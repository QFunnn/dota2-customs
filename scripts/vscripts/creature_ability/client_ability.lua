--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if client_ability == nil then
	client_ability = class({})
end
function client_ability:GetAbilityTextureName()
	if _G.ClientRequestEventResult ~= nil then
		local sResult = _G.ClientRequestEventResult
		_G.ClientRequestEventResult = nil
		return sResult
	end
	return ""
end