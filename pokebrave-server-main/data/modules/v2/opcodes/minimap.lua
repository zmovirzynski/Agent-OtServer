Minimap = { }

function Minimap.onReceiveExtendedOpcode(player, buffer)
  buffer = json.decode(buffer)

  if buffer["gotopos"] then
    local gotoPos = buffer["gotopos"]
    local position = Position(gotoPos.x, gotoPos.y, gotoPos.z)
    player:teleportTo(position)
  end
end
