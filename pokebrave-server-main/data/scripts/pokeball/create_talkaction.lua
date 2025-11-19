local talk = TalkAction("/cb")
local createEffect = 11
local pokeballs = {
  [1] = 2456, -- poke ball
  [2] = 2457, -- great ball
  [3] = 2458, -- fast ball
  [4] = 2459, -- ultra ball
  [5] = 2460, -- safari ball
  [6] = 2461, -- master ball
}

function talk.onSay(player, words, param)
  if not player:getGroup():getAccess() then
		return true
	end

  local split = param:split(";")
  local pokemonName = split[1]

  if not pokemonName then
    local message = "Use /cb PokemonName\n > Optional parameters\n   > gender : interger [0 : Undefined, 1 : Male, 2 : Female]\n   > level : integer\n   > pokeballId : integer\n > Example: /cb charmander;1;100;2149"
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, message)
    return
  end

  local pokemonType = PokemonType(pokemonName)

  local pokemonGender = tonumber(split[2]) or pokemonType:getRandomGender()
  local pokemonLevel = tonumber(split[3]) or math.random(pokemonType:minSpawnLevel(), pokemonType:maxSpawnLevel())
  local pokeballId = tonumber(split[4]) or pokeballs[math.random(1, #pokeballs)]
  local pokemonNature = math.random(0, POKEMON_NATURE_LAST)
  local ivs = Game.generateIvs()

  if player:addPokemon(pokeballId, pokemonName, pokemonLevel, pokemonGender, pokemonNature, ivs) then
    local playerPos = player:getPosition()
    playerPos:sendMagicEffect(createEffect)
  end
end

talk:separator(" ")
talk:register()
