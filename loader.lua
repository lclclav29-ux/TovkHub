-- ==========================================
-- Instant GitHub API Loader (Zero Cache)
-- ==========================================
local HttpService = game:GetService("HttpService")

local repo = "lclclav29-ux/TovkHub"
local branch = "main"
local filePath = "main.lua"

-- Запрос прямо к API GitHub (без кэширования CDN)
local apiUrl = string.format("https://api.github.com/repos/%s/contents/%s?ref=%s&t=%d", repo, filePath, branch, os.time())

local success, response = pcall(function()
    return game:HttpGet(apiUrl)
end)

if success and response then
    local data = HttpService:JSONDecode(response)
    if data and data.content then
        -- Декодируем base64 контент, который отдал API
        local base64 = data.content:gsub("\n", "")
        local decodedCode = syn and syn.crypt and syn.crypt.base64.decode(base64) 
            or crypt and crypt.base64decode and crypt.base64decode(base64)
            or buffer and buffer.frombase64 and buffer.readstring(buffer.frombase64(base64), 0, #base64)
        
        -- Если экзекутор не поддерживает встроенный декодер base64, качаем напрямую по коммит-хэшу
        if not decodedCode then
            local rawUrl = string.format("https://raw.githubusercontent.com/%s/%s/%s?t=%d", repo, data.sha, filePath, os.time())
            decodedCode = game:HttpGet(rawUrl)
        end

        local compiled, err = loadstring(decodedCode)
        if compiled then
            compiled()
        else
            warn("[TockHub]: Ошибка компиляции: " .. tostring(err))
        end
    end
else
    warn("[TockHub]: Не удалось получить файл с API GitHub")
end
