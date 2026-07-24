--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--调用方法 方法, 实例, 参数表
--debug.traceback 在Source引擎中需要参数的，所以会吞一个参数
--ErrorTracking.Try(HeroBuilder.Test,HeroBuilder,param)
--ErrorTracking.Try(function() end)


ErrorTracking = ErrorTracking or {}
ErrorTracking.collected_errors = ErrorTracking.collected_errors or ""
ErrorTracking.errors = ErrorTracking.errors or {}

function ErrorTracking.Collect(stack)
	stack = stack:gsub(": at 0x%x+", ": at 0x")

    stack = stack:sub(1, stack:find("stack traceback:")-1)
    stack = string.gsub(stack, "\\", "__")
    stack = string.gsub(stack, "'", "")

    if ErrorTracking.IsCorrectFileForSend(tostring(stack)) then
        xpcall(function()
            SendError(tostring(stack))
        end, function(err)
            print("ERROR WHILE SENDING ERROR TO SERVER", err)
            return
        end)
    end

	ErrorTracking.collected_errors = ErrorTracking.collected_errors.."\n"..stack
	ErrorTracking.collected_errors = ""

    table.insert(ErrorTracking.errors, tostring(stack))

    xpcall(function()
        if HeroDemo then
            for _, TeamID in ipairs(HeroDemo:GetAllAdminTeams()) do
                GameRules:SendCustomMessageToTeam(tostring(stack), 0, 0, TeamID)
            end
        end
    end, function(err)
        print("ERROR WHILE COLLECTING ERROR", err)
        return
    end)
end

function ErrorTracking.IsCorrectFileForSend(Text)
    local Files = {
        "modules",
        "utils",
        "web",
        "libs",
        "hero_demo",
        "addon_game_mode.lua",
        "addon_init.lua",
        "creature_ai.lua"
    }

    for _, FileName in ipairs(Files) do
        if string.match(Text, FileName) ~= nil then
            return true
        end
    end

    return false
end

function ErrorTracking.Try(callback, ...)
	return xpcall(callback, function(err)
        print("ERROR: ", err)
    end, ...)
end

-- Disc-fix v5 (13.05.2026): debug.traceback override УДАЛЁН. Он ломал VScript runtime
-- при загрузке error_tracking.lua ("error in error handling" -> весь скрипт не грузится).
-- Не нашёл root cause -- возможно Source 2 Lua VM не любит override стандартных функций
-- из debug-namespace в раннем init. Targeted xpcall в filters.lua (OrderFilter,
-- ModifyGoldFilter) остаётся -- этого должно хватить чтобы поймать sell-краш.