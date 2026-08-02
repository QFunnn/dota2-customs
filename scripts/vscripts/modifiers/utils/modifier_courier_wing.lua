--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_courier_wing"
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
		["15"] = 12,
		["16"] = 13,
		["17"] = 14,
		["18"] = 15,
		["19"] = 16,
		["20"] = 17,
		["21"] = 18,
		["22"] = 18,
		["23"] = 18,
		["24"] = 18,
		["25"] = 18,
		["26"] = 18,
		["27"] = 18,
		["28"] = 18,
		["31"] = 12,
		["32"] = 11,
		["33"] = 3,
		["34"] = 3,
		["35"] = 3,
		["36"] = 3,
		["37"] = 3,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 11,
		["43"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_courier_wing = c()
local k = g.modifier_courier_wing
k.name = "modifier_courier_wing"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		local n = KeyValues.CosmeticsKV[l.oid]
		if n.resource then
			local o = ParticleManager:CreateParticle(n.resource, PATTACH_ABSORIGIN_FOLLOW, m)
			self:AddParticle(o, false, false, -1, false, false)
		end
	end
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
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
g.modifier_courier_wing = k
return g