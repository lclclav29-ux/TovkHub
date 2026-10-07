-- Загрузчик TockHub
local repo = "твой_логин_на_гитхабе" -- замени на свой ник
local branch = "main"

local success, result = pcall(function()
    return game:HttpGet(("https://raw.githubusercontent.com/%s/tockhub/%s/main.lua"):format(repo, branch))
end)

if success then
    loadstring(result)()
else
    warn("Не удалось загрузить TockHub: " .. tostring(result))
end
