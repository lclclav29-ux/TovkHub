-- ==========================================
-- TockHub Clean Loader
-- ==========================================
local repo = "lclclav29-ux/TovkHub"
local branch = "main"
local file = "main.lua"

-- Безопасная очистка старых окон перед запуском
local CoreGui = game:GetService("CoreGui")
local function CleanOldUI()
    for _, name in ipairs({"TockHubFloating", "TockHubModern", "TockHubPineapple"}) do
        local old = CoreGui:FindFirstChild(name)
        if old then old:Destroy() end
    end
end
CleanOldUI()

-- Формируем URL с обходом кэша через метку времени
local rawUrl = string.format("https://raw.githubusercontent.com/%s/%s/%s?t=%d", repo, branch, file, os.time())

local success, code = pcall(function()
    return game:HttpGet(rawUrl)
end)

if success and code and #code > 0 then
    local func, err = loadstring(code)
    if func then
        func()
    else
        warn("[TockHub]: Ошибка выполнения main.lua: " .. tostring(err))
    end
else
    warn("[TockHub]: Не удалось получить main.lua с GitHub.")
end
