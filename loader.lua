-- ==========================================
-- TockHub Clean Loader
-- ==========================================
local repo = "lclclav29-ux/TovkHub"
local branch = "main"
local file = "main.lua"

-- Очистка старых GUI
local CoreGui = game:GetService("CoreGui")
for _, name in ipairs({"TockHubFloating", "TockHubModern", "TockHubPineapple"}) do
    local old = CoreGui:FindFirstChild(name)
    if old then old:Destroy() end
end

-- Ссылка на GitHub с обходом кэша
local rawUrl = string.format("https://raw.githubusercontent.com/%s/%s/%s?t=%d", repo, branch, file, os.time())

-- Прямой запрос кода
local code = game:HttpGet(rawUrl, true)

if code and #code > 0 then
    local func, err = loadstring(code)
    if func then
        func()
    else
        warn("[TockHub Error]: Ошибка компиляции: " .. tostring(err))
    end
else
    warn("[TockHub Error]: Не удалось загрузить main.lua с GitHub")
end
