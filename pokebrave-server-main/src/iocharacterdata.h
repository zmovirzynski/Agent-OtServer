// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "database.h"
#include "account.h"
#include <regex>

class IOCharacterData
{
	public:
		static bool isCharacterNameValid(const std::string& characterName);
		static bool doesCharacterNameExist(const std::string& characterName);

		static bool insertCharacter(const Account account, const std::string& characterName);
	private:

};
