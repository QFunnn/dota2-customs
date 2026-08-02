--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_1772001"
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
		["11"] = 4,
		["12"] = 4,
		["13"] = 12,
		["14"] = 13,
		["15"] = 14,
		["16"] = 15,
		["17"] = 16,
		["20"] = 17,
		["21"] = 18,
		["22"] = 19,
		["25"] = 13,
		["26"] = 23,
		["27"] = 24,
		["28"] = 23,
		["29"] = 12,
		["30"] = 4,
		["31"] = 4,
		["32"] = 4,
		["33"] = 4,
		["34"] = 4,
		["35"] = 4,
		["36"] = 4,
		["37"] = 4,
		["38"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = c()
k.name = "modifier_1772001"
d(k, i)
function k.prototype.OnCreated(self, l)
	local m = self:GetParent()
	local n = Cosmetic:GetKv("1772001")
	if n == nil then
		return
	end
	if n.particle ~= nil then
		for o, p in pairs(n.particle) do
			Cosmetic:RegisterParticleModifier(m, o, p)
		end
	end
end
function k.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS] = "1772001" }
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
return g