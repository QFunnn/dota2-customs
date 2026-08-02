--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_courier_emblem"
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
		["15"] = 14,
		["16"] = 15,
		["17"] = 16,
		["18"] = 17,
		["19"] = 18,
		["20"] = 19,
		["21"] = 20,
		["22"] = 21,
		["23"] = 22,
		["24"] = 22,
		["25"] = 22,
		["26"] = 22,
		["27"] = 22,
		["28"] = 22,
		["29"] = 22,
		["30"] = 22,
		["33"] = 14,
		["34"] = 11,
		["35"] = 3,
		["36"] = 3,
		["37"] = 3,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 11,
		["45"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_courier_emblem = c()
local k = g.modifier_courier_emblem
k.name = "modifier_courier_emblem"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		self.emblemID = l.emblemID
		local n = KeyValues.CosmeticsKV[l.emblemID]
		self.particle = n.resource
		if self.particle then
			local o = ParticleManager:CreateParticle(self.particle, PATTACH_ABSORIGIN_FOLLOW, m)
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
g.modifier_courier_emblem = k
return g