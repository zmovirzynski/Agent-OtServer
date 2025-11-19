#pragma once

#include "items.h"

struct PokeballInfo {
	uint16_t id;
	uint16_t charged;
	uint16_t catchEffect;
	uint16_t failEffect;
	uint16_t callEffect;
	uint16_t shotEffect;
	uint32_t effectDelay;
	double multiplier;
};

class Pokeballs
{
public:
	bool loadFromXml();
	PokeballInfo* getPokeballInfo(uint16_t id);

private:
	std::map<uint16_t, PokeballInfo> pokeballs;
};
