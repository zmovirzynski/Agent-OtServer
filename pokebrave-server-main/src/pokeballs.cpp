#include "otpch.h"

#include "pokeballs.h"
#include "game.h"

#include "pugicast.h"
#include "tools.h"

extern Game g_game;

bool Pokeballs::loadFromXml()
{
	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file("data/XML/pokeballs.xml");
	if (!result) {
		printXMLError("Error - Pokeballs::loadFromXml", "data/XML/pokeballs.xml", result);
		return false;
	}

	for (auto pokeballNode : doc.child("pokeballs").children()) {
		pugi::xml_attribute attr = pokeballNode.attribute("id");
		if (!attr) {
			std::cout << "[Warning - Pokeballs:loadFromXml] Missing pokeball id" << std::endl;
			continue;
		}

		uint16_t id = pugi::cast<uint16_t>(attr.value());
		const ItemType& it = Item::items.getItemType(id);
		if (id == 0) {
			std::cout << "[Warning - Pokeballs:loadFromXml] Not found item id: " << id << std::endl;
			continue;
		}

		auto res = pokeballs.emplace(std::make_pair(id, PokeballInfo()));
		PokeballInfo& pokeballInfo = res.first->second;
		pokeballInfo.id = id;

		pokeballNode.remove_attribute("id");
		for (auto childNode : pokeballNode.children()) {
			if (strcasecmp(childNode.name(), "catch") == 0) {
				if ((attr = childNode.attribute("multiplier"))) {
					pokeballInfo.multiplier = pugi::cast<double>(attr.value());
				}else {
					std::cout << "[Warning - Pokeballs:loadFromXml] Missing catch multiplier for pokeball: " << id << std::endl;
				}

				if ((attr = childNode.attribute("effectdelay"))) {
					pokeballInfo.effectDelay = pugi::cast<uint32_t>(attr.value());
				}
				else {
					std::cout << "[Warning - Pokeballs:loadFromXml] Missing catch multiplier for pokeball: " << id << std::endl;
				}
			} else if (strcasecmp(childNode.name(), "item") == 0) {
				if ((attr = childNode.attribute("charged"))) {
					pokeballInfo.charged = pugi::cast<uint16_t>(attr.value());
				}
				else {
					std::cout << "[Warning - Pokeballs:loadFromXml] Missing item charged for pokeball: " << id << std::endl;
				}
			} else if (strcasecmp(childNode.name(), "effects") == 0) {
				if ((attr = childNode.attribute("catch"))) {
					pokeballInfo.catchEffect = pugi::cast<uint16_t>(attr.value());
				}
				else {
					std::cout << "[Warning - Pokeballs:loadFromXml] Missing effects catch for pokeball: " << id << std::endl;
				}

				if ((attr = childNode.attribute("fail"))) {
					pokeballInfo.failEffect = pugi::cast<uint16_t>(attr.value());
				}
				else {
					std::cout << "[Warning - Pokeballs:loadFromXml] Missing effects fail for pokeball: " << id << std::endl;
				}

				if ((attr = childNode.attribute("call"))) {
					pokeballInfo.callEffect = pugi::cast<uint16_t>(attr.value());
				}
				else {
					std::cout << "[Warning - Pokeballs:loadFromXml] Missing effects call for pokeball: " << id << std::endl;
				}

				if ((attr = childNode.attribute("shot"))) {
					pokeballInfo.shotEffect = pugi::cast<uint16_t>(attr.value());
				}
				else {
					std::cout << "[Warning - Pokeballs:loadFromXml] Missing effects shot for pokeball: " << id << std::endl;
				}
			}
		}
	}
    return true;
}

PokeballInfo* Pokeballs::getPokeballInfo(uint16_t id)
{
	auto it = pokeballs.find(id);
	if (it == pokeballs.end()) {
		std::cout << "[Warning - Pokeballs:getPokeballInfo] Pokeball " << id << " not found" << std::endl;
		return nullptr;
	}
	return &it->second;
}
