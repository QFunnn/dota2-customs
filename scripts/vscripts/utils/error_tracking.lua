--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ErrorTracking = ErrorTracking or {}
ErrorTracking.collected_errors = ErrorTracking.collected_errors or ""

--重写debug.traceback
debug.oldTraceback = debug.oldTraceback or debug.traceback
debug.traceback = function(...)
	local stack = debug.oldTraceback(...)
	ErrorTracking.Collect(stack)
	return stack
end

function ErrorTracking.Collect(stack)
	stack = stack:gsub(": at 0x%x+", ": at 0x")
    stack = stack:sub(1, stack:find("stack traceback:")-1)
    stack = string.gsub(stack, "\\", "__")
    stack = string.gsub(stack, "'", "")
    local post_data = 
    {
        ["error"] = tostring(stack),
    }
    if string.find(tostring(stack), "heroes") or string.find(tostring(stack), "player_system") or string.find(tostring(stack), "arena_system") then
        --SendData('https://data.world-of-dota.com/data/post_error_data.php', post_data, nil)
    end
	ErrorTracking.collected_errors = ErrorTracking.collected_errors.."\n"..stack
	ErrorTracking.collected_errors = ""
end

function ErrorTracking.SendMyMessage(msg)
    local post_data = 
    {
        ["error"] = msg,
    }
    SendData('https://data.world-of-dota.com/data/post_error_data.php', post_data, nil)
end

function ErrorTracking.Try(callback, ...)
	return xpcall(callback, debug.traceback, ...)
end