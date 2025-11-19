local window
local opcode = 190

function init()
    connect(g_game, {
        onGameStart = hide,
        onGameEnd = hide,
    })

    window = g_ui.loadUI("technicalmachine", modules.game_interface.getRootPanel())

    ProtocolGame.registerExtendedOpcode(opcode, onReceiveTM)
    window:hide()
end

function terminate()
    disconnect(g_game, {
        onGameStart = hide,
        onGameEnd = hide,
    })

    ProtocolGame.unregisterExtendedOpcode(opcode)
    window:hide()
end

function show()
    window:show()
end

function hide()
    window:hide()
end

function onReceiveTM(protocol, opcode, data)
    local receive = json.decode(data)

    if receive.protocol == "open" then
        show()
        local tmName = receive.tmName

        local selectMove = 1
        window.flatPanelTM:destroyChildren()
        for _, moveInfo in ipairs(receive.moves) do
            local moveName = moveInfo.name
            local widgetName = g_ui.createWidget("TMText", window.flatPanelTM)
            widgetName:setText(moveName)
            widgetName.onClick = function()
                selectMove = moveInfo.id
            end

            window.select.onClick = function()
                local data = {
                    selectMove = selectMove,
                    technicalmachines = receive.technicalmachines,
					pid = receive.pid,
                }
                g_game.getProtocolGame():sendExtendedOpcode(opcode, json.encode(data))
                hide()
            end
        end
    end
end
