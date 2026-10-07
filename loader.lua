-- ==========================================
-- TockHub Advanced Auto Cache-Bypasser
-- ==========================================
local repo = "lclclav29-ux/TovkHub"
local branch = "main"
local file = "main.lua"

-- 1. Удаление старых интерфесов из CoreGui перед запуском
local CoreGui = game:GetService("CoreGui")
local getHui = gethui or function() return CoreGui end
local targetGui = getHui()

for _, guiName in ipairs({"TockHubFloating", "TockHubModern", "TockHubPineapple"}) do
    local oldGui = targetGui:FindFirstChild(guiName) or CoreGui:FindFirstChild(guiName)
    if oldGui then
        oldGui:Destroy()
    end
end

-- 2. Генерация уникального URL (случайный числовой хэш)
math.randomseed(os.time())
local uniqueHash = string.format("%d_%d", os.time(), math.random(100000, 999999))
local rawUrl = string.format("https://raw.githubusercontent.com/%s/%s/%s?nocache=%s", repo, branch, file, uniqueHash)

-- 3. Безопасная загрузка свежего кода напрямую с GitHub
local success, code = pcall(function()
    -- Попытка запроса с занулением кэш-заголовков
    return game:HttpGet(rawUrl, true)
end)

if success and code and #code > 0 then
    local compiledFunction, err = loadstring(code)
    if compiledFunction then
        compiledFunction()
    else
        warn("[TockHub Error]: Ошибка компиляции кода: " .. tostring(err))
    end
else
    warn("[TockHub Error]: Не удалось загрузить свежий скрипт с GitHub.")
end
