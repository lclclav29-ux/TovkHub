-- Обновленный загрузчик с обходом кэша
local repo = "lclclav29-ux/TovkHub"
local branch = "main"
local file = "main.lua"

-- Добавляем случайный параметр с временем, чтобы сбросить кэш
local cacheBuster = "?t=" .. tostring(os.time())
local url = ("https://raw.githubusercontent.com/%s/%s/%s" .. cacheBuster):format(repo, branch, file)

local success, result = pcall(function()
    return game:HttpGet(url)
end)

if success then
    loadstring(result)()
else
    warn("Ошибка загрузки TockHub: " .. tostring(result))
end
