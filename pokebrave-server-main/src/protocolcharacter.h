// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "protocol.h"

class NetworkMessage;
class OutputMessage;
class ProtocolCharacter;
using ProtocolCharacter_ptr = std::shared_ptr<ProtocolCharacter>;

class ProtocolCharacter : public Protocol
{
	public:
		// static protocol information
		enum { server_sends_first = false };
		enum { protocol_identifier = 0x3 };
		enum { use_checksum = true };
		static const char* protocol_name() {
			return "create character protocol";
		}

		explicit ProtocolCharacter(Connection_ptr connection) : Protocol(connection) {}

		void onRecvFirstMessage(NetworkMessage& msg) override;

	private:
		ProtocolCharacter_ptr getThis() {
			return std::static_pointer_cast<ProtocolCharacter>(shared_from_this());
		}
		void disconnectClient(const std::string& message, uint16_t version);
		void doCreateCharacter(const std::string& accountName, const std::string& password, const std::string& characterName, uint16_t version);
};
