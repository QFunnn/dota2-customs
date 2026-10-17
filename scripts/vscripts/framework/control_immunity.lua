--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "framework/control_immunity"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["7"] = 4,
		["8"] = 4,
		["9"] = 4,
		["10"] = 4,
		["11"] = 4,
		["12"] = 4,
		["13"] = 4,
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 4,
		["18"] = 4,
		["19"] = 4,
		["20"] = 4,
		["21"] = 4,
		["22"] = 4,
		["23"] = 4,
		["24"] = 4,
		["25"] = 23,
		["26"] = 24,
		["27"] = 24,
		["29"] = 26,
		["30"] = 27,
		["32"] = 28,
		["33"] = 23,
		["34"] = 36,
	}
)
local d = {}
local e = {
	modifier_stunned = true,
	modifier_bashed = true,
	modifier_knockback = true,
	modifier_rooted = true,
	modifier_silence = true,
	modifier_disarmed = true,
	modifier_hexed = true,
	modifier_feared = true,
	modifier_taunt = true,
	modifier_eul_cyclone = true,
	modifier_wind_waker = true,
	modifier_freeze_debuff = true,
	modifier_knockback_custom = true,
	modifier_meat_hook_debuff = true,
	modifier_stagger = true,
	modifier_sleep = true,
}
function d.ShouldBlockControlModifier(f, g, h, i)
	if not e[g] or not f:HasState(StateEnum.CONTROL_IMMUNE) then
		return false
	end
	if
		g == "modifier_stunned"
		and h == f
		and IsValid(i)
		and i:GetCaster() == f
		and i:GetAbilityName() == "magma_earthshaker_5"
	then
		return false
	end
	return true
end
_G.IsControlModifierBlocked = d.ShouldBlockControlModifier
return d