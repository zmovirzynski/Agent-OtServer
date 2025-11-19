local LFS = require(Game.getLFSName())

g_modules = { }

---@class Module
Module = {
  name = nil,

  __path = nil,
  __loaded = false,
  __ENV = nil,
}

---@param name string
---@param path string
function Module.new(name, path, enviromentPath)
  local newModule = {
    name = name,

    __path = path,
    __enviromentPath = enviromentPath,
    __ENV = nil,
    __loaded = false,
  }

  local env = {
    module = {
      emit = function(signal, params, identifier) Signal.emit(signal, params, identifier) end,
      connect = function(signal, callback, identifier) return Module.connect(newModule, signal, callback, identifier) end,
      disconnect = function(signal, identifier) Module.disconnect(newModule, signal, identifier) end,
      export = function(name, object) Module.Export(newModule, name, object) end,
      scheduleEvent = function(callback, delay, params) return addModuleEvent(callback, delay, params) end,
      stopEvent = function(eventIndex) stopModuleEvent(eventIndex) end
    },

    print = function(...) Module.Print(newModule, ...) end,
    error = function(...) Module.Error(newModule, ...) end,
  }

  setmetatable(env, { __index = _G })
  setmetatable(newModule, { __index = Module })

  newModule.__ENV = env
  newModule.__loaded = false

  Signal.events[newModule] = { }
  return newModule
end

function Module.connect(module, signal, callback, identifier)
  return Signal.connect(module, signal, callback, identifier)
end

function Module.disconnect(module, signal, identifier)
  Signal.disconnect(module, signal, identifier)
end

function Module.Print(module, ...)
  local args = { ... }
  local str = ""

  for _, arg in ipairs(args) do
    str = str .. " " .. tostring(arg)
  end

  print(string.format("[Module::%s] %s", module.name, str))
end

function Module.Error(module, ...)
  local args = { ... }
  local str = ""

  for _, arg in ipairs(args) do
      str = str .. " " .. tostring(arg)
  end

  str = str .. "\n" .. debug.traceback()
  print(string.format("[Module::%s] %s", module.name, str))
end

function Module.Export(module, name, object)
  local oldEnv = getfenv(0)
  setfenv(0, _G)

  if not _G.g_modules then
    _G.g_modules = { }
  end

  if not _G.g_modules[module.name] then
    _G.g_modules[module.name] = { }
  end

  _G.g_modules[module.name][name] = object
  setfenv(0, oldEnv)
end

function Module:isLoaded()
  return self.__loaded
end

function Module:isReloadable()
  return self.__ENV.configs.reload
end

function Module:canSendReloadBroadcast()
  return self.__ENV.configs.reloadBroadcast
end

function Module:getFiles()
  return self.__ENV.files
end

function Module:getPath()
  return self.__path
end

function Module:getEnviromentPath()
  return self.__enviromentPath
end

function Module:load(isReload)
  if self:isLoaded() then
    return false
  end

  if not Signal.events[self] then
    Signal.events[self] = { }
  end

  local lastTime = os.clock()

  local initFilePath = self.__path .. "/" .. self.name .. ".lua"
  local attr = LFS.attributes(initFilePath)

  if not attr then
    print("[Module] Could not found file: " .. initFilePath)
    return false
  end

  self:runInSafeSandbox(function()
    dofile(initFilePath)

    local constFilePath = self.__path .. "/const.lua"
    if LFS.attributes(constFilePath) then
      dofile(constFilePath)
    end

    if self.__ENV.files then
      for _, fileName in ipairs(self.__ENV.files) do
        local filePath = self.__path .. "/" .. fileName .. ".lua"
        dofile(filePath)
      end

      if type(self.__ENV.init) == "function" then
        self.__ENV.init()
      end
    end
  end)

  self.__loaded = true
  local elapsedTime = os.clock() - lastTime

  if isReload then
    print(string.format("[Module] %s reloaded. (%.2fms)", self.name, elapsedTime))
  else
    print(string.format("[Module] %s loaded. (%.2fms)", self.name, elapsedTime))
  end
  return true
end

function Module:unload(isReload)
  if not self:isLoaded() then
    return
  end

  self:runInSafeSandbox(function()
    if isReload and type(self.__ENV.onReload) == "function" then
      self.__ENV.onReload()
    end

    if type(self.__ENV.terminate) == "function" then
      self.__ENV.terminate()
    end
  end)

  if Signal.events[self] then
    Signal.events[self] = nil
  end

  self.__loaded = false

  local oldEnv = getfenv(0)
  setfenv(0, _G)

  if _G.g_modules[self.name] then
    _G.g_modules[self.name] = nil
  end

  setfenv(0, oldEnv)
  if not isReload then
    print(string.format("[Module] %s unloaded.", self.name))
  end
end

function Module:reload()
  if not self:isReloadable() then
    return
  end

  self:unload(true)
  self:load(true)
end

function Module:runInSafeSandbox(func, ...)
  if type(func) ~= "function" then
    print(string.format("[Module::%s] invalid function in %s", self.name, debug.traceback()))
    return
  end

  local oldEnv = getfenv(0)
  setfenv(0, self.__ENV)

  local success, response = pcall(func, ...)
  if not success then
    Module.Error(self, response)
  end

  setfenv(0, oldEnv)

  return response
end
