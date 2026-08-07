--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_chaos_permanent"
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
		["10"] = 1,
		["11"] = 3,
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["15"] = 13,
		["16"] = 14,
		["17"] = 13,
		["18"] = 16,
		["19"] = 17,
		["20"] = 18,
		["22"] = 16,
		["23"] = 21,
		["24"] = 22,
		["25"] = 23,
		["26"] = 23,
		["27"] = 23,
		["28"] = 23,
		["29"] = 24,
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 29,
		["36"] = 21,
		["37"] = 11,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 3,
		["46"] = 11,
		["48"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_chaos_permanent = c()
local k = g.modifier_chaos_permanent
k.name = "modifier_chaos_permanent"
d(k, i)
function k.prototype.GetTexture(self)
	return "chaos_permanent"
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function k.prototype.OnIntervalThink(self)
	local m = self:GetStackCount()
	local n = GetModifierProperty(self:GetParent(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_PERMANENT)
	self:SetStackCount(n)
	if n > m then
		local o = self:GetParent():FindModifierByName("modifier_chaos_custom")
		if IsValid(o) then
			o:TriggerChaos()
		end
	end
end
k = e(
	{
		j(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = true,
				IsPurgeException = true,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_chaos_permanent = k
return g