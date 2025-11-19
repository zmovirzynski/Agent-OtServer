---@class Signal
Signal = {
  events = { }
}

---@param signal string
---@param params table
function Signal.emit(signal, params, identifier)
  params = params or { }

  local ret = true
  local stopEmit = nil

  for module, event in pairs(Signal.events) do
    if event[signal] then
      local callback = event[signal].defaultCallback

      if identifier then
        callback = event[signal][identifier]
      end

      if callback and type(callback) == "function" then
        ret, stopEmit = callback(params)
        ret = true
        if stopEmit then
          if type(ret) == "table" then
            return unpack(ret)
          end
          return ret
        end
      end
    end
  end

  if type(ret) == "table" then
    return unpack(ret)
  end

  return ret
end

---@param module Module
---@param signal string
---@param callback function
function Signal.connect(module, signal, callback, identifier)
  if type(callback) ~= "function" then
    Module.Error(module, "The callback param is not a function.")
    return
  end

  if not Signal.events[module][signal] then
    Signal.events[module][signal] = { }
  end

  local moduleEvent = Signal.events[module][signal]
  
  if identifier then
    if moduleEvent[identifier] then
      Module.Error(module, "The", signal, string.format("is already connected with %s identifier.", identifier))
      return
    end

    moduleEvent[identifier] = callback
  else
    if moduleEvent.defaultCallback then
      Module.Error(module, "The", signal, "is already connected.")
      return
    end

    moduleEvent.defaultCallback = callback
  end
end

---@param module Module
---@param signal string
function Signal.disconnect(module, signal, identifier)
  if not Signal.events[module][signal] then
    return
  end

  local moduleEvent = Signal.events[module][signal]
  if identifier then
    moduleEvent[identifier] = nil
  else
    moduleEvent.defaultCallback = nil
  end

  if table.size(moduleEvent) == 0 then
    Signal.events[module][signal] = nil
  end
end
