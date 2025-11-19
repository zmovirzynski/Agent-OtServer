local _onExtendedOpcode

function init()
  module.connect("onExtendedOpcode", _onExtendedOpcode)
end

function terminate()
  module.disconnect("onExtendedOpcode")
end

function _onExtendedOpcode(params)
  local player = params.creature
  local opcode = params.opcode
  local buffer = params.buffer

  if opcode == const.minimapOpcode then
    Minimap.onReceiveExtendedOpcode(player, buffer)
  elseif opcode == const.tmWindowOpcode then
    TMWindow.onReceiveExtendedOpcode(player, buffer)
  end
end
