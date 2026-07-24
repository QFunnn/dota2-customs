--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Главная страница сервера
SERVER_URL = 'https://zxcarena.pro/api/'
-- SERVER_URL = 'http://localhost:5000/api/'

-- Ключ кастомки
SERVER_KEY = GetDedicatedServerKeyV3('zxc_arena')

-- Сколько милисекунд ждать ответ от сервера за каждую попытку соединения
SERVER_ONE_TRY_WAIT_TIME = 10000

-- Сколько всего может быть попыток подключения
SERVER_MAX_ATTEMPTS = 5

--Интервал попыток подключения в секундах
SERVER_ATTEMPT_INTERVAL = 1

--Работают ли реквесты с читами (для удобных тестов)
SERVER_ENABLE_WITH_CHEATS = false

--Зачисляется ли рейтинг с читами
SERVER_RATING_ENABLE_WITH_CHEATS = false









--Фнкция для реквестов
function SendRequest(url, data, callback, debugEnabled, attempt)

    if not SERVER_ENABLE_WITH_CHEATS then
        if IsInToolsMode() or GameRules:IsCheatMode() then 
            ifprint('[SendRequest func] Server is not enabled with cheats or in tools', debugEnabled)
            return 
        end
    end

    local current_attempt = attempt and attempt or 1

    ifprint('Trying to create request to URL='..url..' attempt='..current_attempt, debugEnabled)
    local DataToSend = data or {}
    DataToSend['GameKey'] = SERVER_KEY

    local GameModeEntity = GameRules:GetGameModeEntity()

    local EncodedData = json.encode(DataToSend)
    local Request = CreateHTTPRequestScriptVM('POST', url)
    Request:SetHTTPRequestAbsoluteTimeoutMS(SERVER_ONE_TRY_WAIT_TIME)
    Request:SetHTTPRequestGetOrPostParameter('data', EncodedData)
    Request:Send(function(Result)
        if Result.StatusCode ~= 200 then
            ifprint("Request error! Status code " .. tostring(Result.StatusCode) .. ". Trying next attempt", debugEnabled)
            local ResultData = {json.decode(Result.Body)}
            if ResultData and ResultData[1] and ResultData[1].dontTry == 1 then
                return
            end
            current_attempt = current_attempt + 1
            if current_attempt <= SERVER_MAX_ATTEMPTS then
                GameModeEntity:SetContextThink(DoUniqueString("Attempt"), function()
                    SendRequest(
                        url,
                        data,
                        callback,
                        debugEnabled,
                        current_attempt
                    )
                    return -1
                end, SERVER_ATTEMPT_INTERVAL)
            end
            return
        end
        local ResultData = {json.decode(Result.Body)}
        if not ResultData or not ResultData[1] then
            ifprint("Request error! Result data is nil! Trying next attempt", debugEnabled)
            current_attempt = current_attempt + 1
            if current_attempt <= SERVER_MAX_ATTEMPTS then
                GameModeEntity:SetContextThink(DoUniqueString("Attempt"), function()
                    SendRequest(
                        url,
                        data,
                        callback,
                        debugEnabled,
                        current_attempt
                    )
                    return -1
                end, SERVER_ATTEMPT_INTERVAL)
            end
            return
        end
        ifprint("Request was returned completely!", debugEnabled)
        if callback then
            ifprint("Trying to call callback", debugEnabled)
            callback(ResultData[1])
        end
    end)
end

function SendError(ErrorString)
    local RoundNum = 0
    if Rounds ~= nil then
        local ok, result = xpcall(
            function()
                return Rounds:GetCurrentRound()
            end,
            function(err)
                print("ERROR WHILE SENDING ERROR TO SERVER:", err)
                return nil
            end
        )

        if ok then
            RoundNum = result
        end
    end
    local Data = {
        ErrorString = ErrorString,
        Round = RoundNum
    }

    xpcall(
        function()
            SendRequest(SERVER_URL.."on_error", Data, nil, true)
        end,
        function(err)
            print("ERROR WHILE SENDING ERROR TO SERVER:", err)
            return nil
        end
    )
end

function ifprint(sText, bEnabled)
    if bEnabled then
        print("[Roshdef Server] "..sText)
    end
end