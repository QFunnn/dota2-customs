--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "modifiers/hunt_boss/modifier_hunt_control_immune"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 2,
		["11"] = 2,
		["12"] = 2,
		["13"] = 4,
		["14"] = 4,
		["15"] = 10,
		["16"] = 11,
		["17"] = 12,
		["18"] = 11,
		["19"] = 15,
		["20"] = 16,
		["21"] = 15,
		["22"] = 19,
		["23"] = 21,
		["24"] = 22,
		["27"] = 23,
		["28"] = 24,
		["29"] = 24,
		["30"] = 24,
		["31"] = 24,
		["32"] = 24,
		["33"] = 24,
		["34"] = 24,
		["37"] = 19,
		["38"] = 10,
		["39"] = 4,
		["40"] = 10,
	}
)
local g = {}
local h = require("framework.control_immunity")
local i = h.ShouldBlockControlModifier
local j = require("modifiers.eom_modifier.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
local m = c()
m.name = "modifier_hunt_control_immune"
d(m, k)
function m.prototype.StaticState(self)
	return { [StateEnum.CONTROL_IMMUNE] = true }
end
function m.prototype.CheckState(self)
	return { [MODIFIER_STATE_UNSLOWABLE] = true }
end
function m.prototype.OnCreated(self)
	self:RegisterStaticStates()
	if not IsServer() then
		return
	end
	for n, o in ipairs(self:GetParent():FindAllModifiers()) do
		if i(self:GetParent(), o:GetName(), o:GetCaster(), o:GetAbility()) then
			o:Destroy()
		end
	end
end
m = e({ l(a, { IsHidden = true, IsDebuff = false, IsPurgable = false, RemoveOnDeath = false }) }, m)
return g