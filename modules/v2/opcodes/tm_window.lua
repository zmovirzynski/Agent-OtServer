TMWindow = { }

function TMWindow.onReceiveExtendedOpcode(player, buffer)
  buffer = json.decode(buffer)

  local pokemon = player:getPokemon()
  if not pokemon then
    return true
  end

  if pokemon:getId() ~= buffer.pid then
    return true
  end

  if pokemon:learnMove(buffer.selectMove, buffer.technicalmachines.level, buffer.technicalmachines.move) then
    pokemon:getPosition():sendMagicEffect(const.learnEffect)
  end
end
