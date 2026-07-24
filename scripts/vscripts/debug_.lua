--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


_G.Debug = {
	errorHistrory = {}
}

function Debug:F( f )
	return function( ... )
		return self:Execute( f, ... )
	end
end

function Debug:Print( ... )
	local str = ""

	for k, v in pairs( { ... } ) do
		str = str .. tostring( v ) .. "\t"
	end

	print( str )

	Debug:Log( str )
end

_G.PendingLogs = {}
function Debug:Log( str )
    if not Http:WillSendData() then
        Debug.errorHistrory = {}
        table.insert(Debug.errorHistrory, str)
        CustomNetTables:SetTableValue("debug", "errors", Debug.errorHistrory)
        CustomGameEventManager:Send_ServerToAllClients('NetTableDebugErrors', {})
    else
        table.insert(_G.PendingLogs, str)
    end
end

function Debug:Execute( f, ... )
	local args = { ... }
	local _, result = xpcall( function()
		return f( unpack( args ) )
	end, self.Error )

	return result
end

function Debug.Error( msg )
	--local err = "Error: " .. msg .. "\n" .. debug.traceback() .. "\n"

	--print( err )

--	Debug:Log( err )
end