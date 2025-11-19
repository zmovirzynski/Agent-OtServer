local talk = TalkAction("m1", "m2", "m3", "m4", "m5", "m6", "m7", "m8", "m9", "m10", "m11", "m12")

function talk.onSay(player, words, param)
	local pokemon = player:getPokemon()
  if not pokemon then
    return false
  end

  local moveId = tonumber(words:split("m")[1])
  local move = pokemon:getMove(moveId)

  if move then
    pokemon:castSpell(move.name)
  end
end

talk:separator(" ")
talk:register()
