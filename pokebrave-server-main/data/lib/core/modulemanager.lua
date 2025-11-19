local LFS = require(Game.getLFSName())

function GetDirectoriesInFolder(path)
  local dirs = {}
  local path = LFS.currentdir() .. "/data/" .. path

  for file in LFS.dir(path) do
    if file ~= "." and file ~= ".." then
      local fullPath = path .. "/" .. file
      local isDirectory = LFS.attributes(fullPath, "mode") == "directory"

      if isDirectory and not file:match("^#") then
        table.insert(dirs, file)
      end
    end
  end

  table.sort(dirs, function(a, b) return a < b end)

  return dirs
end

---@class ModuleManager
ModuleManager = {
  enviroments = {
    { path = "modules/v1", ignoreReload = true },
    { path = "modules/v2" },
  },

  enviromentsByPath = { },
  modules = { },
  firstLoad = false,
}

for _, enviroment in ipairs(ModuleManager.enviroments) do
  ModuleManager.enviromentsByPath[enviroment.path] = enviroment
end

local moduleFiles = { }

function ModuleManager.setWatchFiles(module)
  for _, fileName in ipairs(module:getFiles()) do
    local filePath = module:getPath() .. "/" .. fileName .. ".lua"
    local attr = LFS.attributes(filePath)

    local info = {
      lastModified = attr.modification,
      module = module
    }

    moduleFiles[filePath] = info
  end
end

function ModuleManager.loadModules()
  if ModuleManager.firstLoad then
    return
  end

  for _, moduleEnviroment in ipairs(ModuleManager.enviroments) do
    for _, moduleName in ipairs(GetDirectoriesInFolder(moduleEnviroment.path)) do
      local modulePath = "data/" .. moduleEnviroment.path .. "/" .. moduleName
      local module = Module.new(moduleName, modulePath, moduleEnviroment.path)

      if module and module:load() then
        table.insert(ModuleManager.modules, module)
        ModuleManager.setWatchFiles(module)
      end
    end
  end

  ModuleManager.firstLoad = true
end

function ModuleManager.reloadEvent()
  for filePath, info in pairs(moduleFiles) do
    local attr = LFS.attributes(filePath)

    if attr and attr.modification > info.lastModified then
      local module = info.module
      local enviromentConfig = ModuleManager.enviromentsByPath[module:getEnviromentPath()]

      if not enviromentConfig.ignoreReload and module:isReloadable() then
        module:reload()
        info.lastModified = attr.modification

        if module:canSendReloadBroadcast() then
          Game.broadcastMessage(string.format("[Module] %s reloaded.", module.name))
        end
      end
    end
  end

  addEvent(ModuleManager.reloadEvent, 1000)
end

function ModuleManager.reloadAll()
  for _, module in ipairs(ModuleManager.modules) do
    module:reload()
  end
end

function ModuleManager.restart()
  for _, module in ipairs(ModuleManager.modules) do
    module:unload(true)
  end

  ModuleManager.modules = { }
  ModuleManager.firstLoad = false
  moduleFiles = { }

  ModuleManager.loadModules()
end
