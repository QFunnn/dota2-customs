--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if _G.debug == nil then
    _G.debug = {}
    _G.debug.getinfo = function(level)
        return {
            what = "",
            nups = 0,
            isvararg = true,
            func = function()
            end,
            source = "",
            nparams = 0,
            currentline = 0,
            short_src = "",
            linedefined = 0,
            lastlinedefined = 0,
            namewhat = ""
        }
    end
    debug.traceback = function(thread, message, level) 
        if type(thread) ~= "string" then
            return thread
        end
        thread = thread .. '\n' .. "stack traceback:\n"
        do
            local i = 0
            while i < 20 do
                local stack = select(
                    2,
                    pcall(error, "", i)
                )
                if stack ~= "" then
                    stack = string.gsub(stack,'/','\\')
                    thread = thread .. ((("\t[" .. tostring(i)) .. "] ") .. stack) .. "\n"
                end
                i = i + 1
            end
        end
        if _G.__TS__sourcemap and not _G.__TS__sourcemap_post_process then
            _G.__TS__sourcemap_post_process = true
            for k, v in pairs(_G.__TS__sourcemap) do
                if string.sub(k, 1, 1) ~= '[' then
                    _G.__TS__sourcemap[("[string \"" .. k) .. "\"]"] = v
                end
            end
        end
        return thread 
    end
end
getfenv().debug = _G.debug