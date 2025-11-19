// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "iocharacterdata.h"

bool IOCharacterData::isCharacterNameValid(const std::string& characterName) {
	return std::regex_match(characterName, std::regex("^[a-zA-Z ]{3,}$"));
}

bool IOCharacterData::doesCharacterNameExist(const std::string& characterName) {
	Database& db = Database::getInstance();

	std::ostringstream query;
	query << "SELECT `id` FROM `players` WHERE `name` = " << db.escapeString(characterName);
	DBResult_ptr result = db.storeQuery(query.str());

	if (result) {
		return true;
	}

	return false;
}

bool IOCharacterData::insertCharacter(const Account account, const std::string& characterName) {
	Database& db = Database::getInstance();
	std::ostringstream query;
	query << "INSERT INTO `players` (`name`, `account_id`, `conditions`) VALUES ('" << characterName << "', '" << account.id << "', '""')";
	if (db.executeQuery(query.str())) {
		return true;
	}

	return false;
}
