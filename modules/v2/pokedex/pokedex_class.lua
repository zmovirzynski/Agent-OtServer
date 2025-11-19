PokedexSystem = {}

function PokedexSystem.register(player, pokemonType)
  local nationalNumber = pokemonType:nationalNumber()
  local storage = PlayerStorageKeys.pokedex + nationalNumber

  if player:getStorageValue(storage) == -1 then
    local experience = pokemonType:experience() * configManager.getNumber(configKeys.RATE_POKEDEX)
    local name = pokemonType:getName()

    player:setStorageValue(storage, 1)
    player:addExperience(experience, true)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format(const.messages.registerSuccessful, name))
    return true
  end

  data = PokedexSystem.getInfo(pokemonType)
  player:showTextDialog(pokemonType:portrait(), data)

	return true
end

function PokedexSystem.getInfo(pokemonType)
  local nationalNumber = pokemonType:nationalNumber()
  local name = pokemonType:getName()
  local description = pokemonType:description()
  local first_type = Functions.getPokemonTypeName(pokemonType:getFirstType())
  local second_type = Functions.getPokemonTypeName(pokemonType:getSecondType())
  local level = pokemonType:requiredLevel()
  local experience = pokemonType:experience()
  local evolutions = pokemonType:getEvolutions()
  local moves = pokemonType:getMoves()
  local genderMaleRate = pokemonType:genderMalePercent()
  local genderFemaleRate = pokemonType:genderFemalePercent()
  local height = string.format("%.1f", pokemonType:height())
  local weight = string.format("%.1f", pokemonType:weight())
  local catchRate = pokemonType:catchRate()

  local output = ""

  output = "National number: #" .. nationalNumber .. "\n\n"
  output = output .. "Name: " .. name .. "\n\n"
  output = output .. "Description: " .. description .. "\n\n"
  output = output .. "Height: " .. height .. " m" .. "\n"
  output = output .. "Weight: " .. weight .. " kg" .. "\n\n"
  output = output .. "Required level: " .. level .. "\n\n"
  output = output .. "Base experience: " .. experience .. "\n\n"

  output = output .. "Types: \n"
  output = output .. "First type: " .. first_type .. "\n"
  output = output .. "Second type: " .. second_type .. "\n\n"

  output = output .. "Evolutions: \n"

  for _, value in ipairs(evolutions) do
    local stone = ItemType(value.stoneId):getName()
    output = output .. "Name: " .. value.name:gsub("^%l", string.upper) .. ", " .. "Level: " .. value.level .. ", " .. "Stone: " .. stone:gsub("^%l", string.upper) .. "\n"
  end

  output = output .. "\n"

  output = output .. "Moves: \n"

  for index, value in ipairs(moves) do
    output = output .. "#" .. index .. " - " .. value.name:gsub("^%l", string.upper) .. ", " .. "Level: " .. value.level .. "\n"
  end

  output = output .. "\n"

  output = output .. "Male spawn rate: " .. genderMaleRate .. "\n"
  output = output .. "Female spawn rate: " .. genderFemaleRate .. "\n\n"

  output = output .. "Catch rate: " .. catchRate .. "\n\n"

	return output
end
