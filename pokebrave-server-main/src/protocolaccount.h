// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "protocol.h"

class NetworkMessage;
class OutputMessage;
class ProtocolAccount;
using ProtocolAccount_ptr = std::shared_ptr<ProtocolAccount>;

class ProtocolAccount : public Protocol
{
	public:
		// static protocol information
		enum { server_sends_first = false };
		enum { protocol_identifier = 0x2 };
		enum { use_checksum = true };
		static const char* protocol_name() {
			return "create account protocol";
		}

		explicit ProtocolAccount(Connection_ptr connection) : Protocol(connection) {}

		void onRecvFirstMessage(NetworkMessage& msg) override;


	private:
		ProtocolAccount_ptr getThis() {
			return std::static_pointer_cast<ProtocolAccount>(shared_from_this());
		}
		void disconnectClient(const std::string& message, uint16_t version);
		void doCreateAccount(const std::string& accountName, const std::string& email, const std::string& password, const std::string& passwordConfirmation, uint16_t version);

};
