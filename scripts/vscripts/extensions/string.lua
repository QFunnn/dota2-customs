--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function string.starts(s, start)
	return string.sub(s, 1, #start) == start
end

function string.trim(s)
	return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

function string.split(inputstr, separator)
	if separator == nil then
		separator = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..separator.."]+)") do
		table.insert(t, str)
	end
	return t
end