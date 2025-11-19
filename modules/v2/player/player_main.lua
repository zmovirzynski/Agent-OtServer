local _onLogin
local _onLogout
local _onLook
local _onLookPokemon
local _onLookPokeball
local _onLookItem

function init()
  module.connect("onLogin", _onLogin)
  module.connect("onLogout", _onLogout)
	module.connect("onLook", _onLook)
end

function terminate()
  module.disconnect("onLogin")
  module.disconnect("onLogout")
	module.disconnect("onLook")
end

function _onLogin(params)
  local player = params.creature
  local serverName = configManager.getString(configKeys.SERVER_NAME)
	local loginStr = "Welcome to " .. serverName .. "!"

	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Please choose your outfit."
		player:sendOutfitWindow()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format("Your last visit in %s: %s.", serverName, os.date("%d %b %Y %X", player:getLastLoginSaved()))
	end

	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

  local ability = player:isOnAbility()
  if ability then
    local item = player:getSlotItem(CONST_SLOT_FEET)
    if item then
      local pokeball = Pokeball(item)
      if pokeball then
        g_modules.goback.go(player, pokeball, true, true)
        g_modules.order.mount(player, ability)
      end
    end
  end
	return true
end

function _onLogout(params)
	local player = params.creature

  local ability = player:isOnAbility()

  if ability == "fly" or ability == "surf" then
    return
  end

  if player:getPokemon() ~= nil then
    g_modules.goback.back(player, false, true)
  end

	return true
end

function _onLook(params)
  local player = params.creature
  local thing = params.thing
  local distance = params.distance

  local description

  if thing:isPokemon() then
    description = _onLookPokemon(thing)

  elseif thing:isItem() then
    local pokeball = Pokeball(thing)

    if pokeball then
      description = _onLookPokeball(Pokeball(thing))
    else
      description = _onLookItem(thing, distance)
    end

    if player:getGroup():getAccess() then
      description = string.format("%s\nItem ID: %d", description, thing:getId())
    end
  end

  player:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function _onLookPokemon(pokemon)
  local gender = Functions.getPokemonGenderName(pokemon:getGender())
  local level = pokemon:getLevel()

  description = string.format("You see a %s %s (Level %d)", gender, pokemon:getName(), level)

  local master = pokemon:getMaster()
  if master and master:isPlayer() then
    description = string.format("%s\nStats: %s", description, pokemon:getIvsStats())
    description = string.format("%s\nNature: %s", description, Functions.getPokemonNatureName(pokemon:getNature()))

    local ivs = pokemon:getIvs()
    description = string.format("%s\nIVS: Atk: %d | Def: %d | Hp: %d | Sp.Atk: %d | Sp.Def: %d | Speed: %d", description,
      ivs.attack, ivs.defense, ivs.health,
      ivs.specialAttack, ivs.specialDefense, ivs.speed
    )

    local evs = pokemon:getEvs()
    description = string.format("%s\nEVS: Atk: %d | Def: %d | Hp: %d | Sp.Atk: %d | Sp.Def: %d | Speed: %d", description,
    evs.attack, evs.defense, evs.health,
    evs.specialAttack, evs.specialDefense, evs.speed)

    description = string.format("%s\nHealth: [%d/%d]", description, pokemon:getHealth(), pokemon:getMaxHealth())
    if level < MAX_POKEMON_LEVEL then
      local nextLevel = level + 1
      description = string.format("%s\nExperience: [%d/%d]", description, pokemon:getExperience(), Functions.getPokemonExpForLevel(nextLevel))
    end
  end
  return description
end

function _onLookPokeball(pokeball)
  local gender = Functions.getPokemonGenderName(pokeball:getPokemonGender())
  local level = pokeball:getPokemonLevel()

  description = string.format("You see a %s. It contains a %s %s (Level: %d).", pokeball:getName(), gender, pokeball:getPokemonName(), level)
  description = string.format("%s\nStats: %s", description, pokeball:getIvsStats())
  description = string.format("%s\nNature: %s", description, Functions.getPokemonNatureName(pokeball:getPokemonNature()))

  local ivs = pokeball:getPokemonIvs()
  description = string.format("%s\nIVS: Atk: %d | Def: %d | Hp: %d | Sp.Atk: %d | Sp.Def: %d | Speed: %d", description,
    ivs.attack, ivs.defense, ivs.health,
    ivs.specialAttack, ivs.specialDefense, ivs.speed
  )

  local evs = pokeball:getPokemonEvs()
  description = string.format("%s\nEVS: Atk: %d | Def: %d | Hp: %d | Sp.Atk: %d | Sp.Def: %d | Speed: %d", description,
    evs.attack, evs.defense, evs.health,
    evs.specialAttack, evs.specialDefense, evs.speed
  )

  if level < MAX_POKEMON_LEVEL then
    local nextLevel = level + 1
    description = string.format("%s\nExperience: [%d/%d]", description, pokeball:getPokemonExperience(), Functions.getPokemonExpForLevel(nextLevel))
  end
  return description
end

function _onLookItem(item, distance)
  description = string.format("You see %s", item:getDescription(distance))
  return description
end
