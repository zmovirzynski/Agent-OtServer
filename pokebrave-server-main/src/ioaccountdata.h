// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "account.h"
#include "player.h"
#include "database.h"
#include <regex>

class IOAccountData
{
	public:
		static bool isAccountNameValid(const std::string& accountName);
		static bool isEmailValid(const std::string& email);
		static bool isPasswordValid(const std::string& password);
		static bool isPasswordConfirmationValid(const std::string& password, const std::string& passwordConfirmation);
		static bool doesAccountNameExist(const std::string& accountName);
		static bool doesEmailExist(const std::string& email);
		static bool insertAccount(const std::string& accountName, const std::string& email, const std::string& password);

	private:
		static bool doesEntryExist(const std::string& fieldName, const std::string& entryValue);

};
