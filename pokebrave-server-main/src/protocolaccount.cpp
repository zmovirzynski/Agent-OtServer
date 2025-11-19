// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "protocolaccount.h"

#include "outputmessage.h"
#include "tasks.h"

#include "configmanager.h"
#include "ioaccountdata.h"
#include "ban.h"
#include "game.h"

#include <fmt/format.h>

extern ConfigManager g_config;
extern Game g_game;

void ProtocolAccount::disconnectClient(const std::string& message, uint16_t version)
{
	auto output = OutputMessagePool::getOutputMessage();

	output->addByte(version >= 1076 ? 0x0B : 0x0A);
	output->addString(message);
	send(output);

	disconnect();
}

void ProtocolAccount::doCreateAccount(const std::string& accountName, const std::string& email, const std::string& password, const std::string& passwordConfirmation, uint16_t version)
{
	if (!IOAccountData::isAccountNameValid(accountName)) {
		disconnectClient("Account name is invalid.", version);
		return;
	}

	if (IOAccountData::doesAccountNameExist(accountName)) {
		disconnectClient("Account name already exists.", version);
		return;
	}

	if (!IOAccountData::isEmailValid(email)) {
		disconnectClient("Email is invalid.", version);
		return;
	}

	if (IOAccountData::doesEmailExist(email)) {
		disconnectClient("Email already exists.", version);
		return;
	}

	if (!IOAccountData::isPasswordValid(password)) {
		disconnectClient("Password is invalid.", version);
		return;
	}

	if (!IOAccountData::isPasswordConfirmationValid(password, passwordConfirmation)) {
		disconnectClient("Password confirmation is invalid.", version);
		return;
	}

	if (!IOAccountData::insertAccount(accountName, email, password)) {
		disconnectClient("Something went wrong, please contact the support!", version);
		return;
	}

	auto output = OutputMessagePool::getOutputMessage();

	output->addByte(0xFF);
	output->addString("Account successfully created");

	send(output);

	disconnect();
}

void ProtocolAccount::onRecvFirstMessage(NetworkMessage& msg)
{
	if (g_game.getGameState() == GAME_STATE_SHUTDOWN) {
		disconnect();
		return;
	}

	msg.skipBytes(2); // client OS

	uint16_t version = msg.get<uint16_t>();
	if (version >= 971) {
		msg.skipBytes(17);
	}
	else {
		msg.skipBytes(12);
	}
	/*
	 * Skipped bytes:
	 * 4 bytes: protocolVersion
	 * 12 bytes: dat, spr, pic signatures (4 bytes each)
	 * 1 byte: 0
	 */

	if (version <= 760) {
		disconnectClient(fmt::format("Only clients with protocol {:s} allowed!", CLIENT_VERSION_STR), version);
		return;
	}

	if (!Protocol::RSA_decrypt(msg)) {
		disconnect();
		return;
	}

	xtea::key key;
	key[0] = msg.get<uint32_t>();
	key[1] = msg.get<uint32_t>();
	key[2] = msg.get<uint32_t>();
	key[3] = msg.get<uint32_t>();
	enableXTEAEncryption();
	setXTEAKey(std::move(key));

	if (version < CLIENT_VERSION_MIN || version > CLIENT_VERSION_MAX) {
		disconnectClient(fmt::format("Only clients with protocol {:s} allowed!", CLIENT_VERSION_STR), version);
		return;
	}

	if (g_game.getGameState() == GAME_STATE_STARTUP) {
		disconnectClient("Gameworld is starting up. Please wait.", version);
		return;
	}

	if (g_game.getGameState() == GAME_STATE_MAINTAIN) {
		disconnectClient("Gameworld is under maintenance.\nPlease re-connect in a while.", version);
		return;
	}

	BanInfo banInfo;
	auto connection = getConnection();
	if (!connection) {
		return;
	}

	if (IOBan::isIpBanned(connection->getIP(), banInfo)) {
		if (banInfo.reason.empty()) {
			banInfo.reason = "(none)";
		}

		disconnectClient(fmt::format("Your IP has been banned until {:s} by {:s}.\n\nReason specified:\n{:s}", formatDateShort(banInfo.expiresAt), banInfo.bannedBy, banInfo.reason), version);
		return;
	}

	std::string accountName = msg.getString();
	if (accountName.empty()) {
		disconnectClient("Invalid account name.", version);
		return;
	}

	std::string email = msg.getString();
	if (email.empty()) {
		disconnectClient("Invalid email", version);
		return;
	}

	std::string password = msg.getString();
	if (password.empty()) {
		disconnectClient("Invalid password.", version);
		return;
	}

	std::string passwordConfirmation = msg.getString();
	if (passwordConfirmation.empty()) {
		disconnectClient("Invalid password confirmation.", version);
		return;
	}

	g_dispatcher.addTask(createTask(std::bind(&ProtocolAccount::doCreateAccount, getThis(), accountName, email, password, passwordConfirmation, version)));
}
