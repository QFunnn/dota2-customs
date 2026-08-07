--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_bunny_girl"
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
		["21"] = 23,
		["22"] = 24,
		["23"] = 25,
		["24"] = 25,
		["25"] = 25,
		["26"] = 25,
		["27"] = 25,
		["28"] = 25,
		["29"] = 25,
		["30"] = 25,
		["33"] = 14,
		["34"] = 35,
		["35"] = 36,
		["36"] = 35,
		["37"] = 40,
		["38"] = 41,
		["39"] = 40,
		["40"] = 47,
		["41"] = 48,
		["42"] = 47,
		["43"] = 11,
		["44"] = 3,
		["45"] = 3,
		["46"] = 3,
		["47"] = 3,
		["48"] = 3,
		["49"] = 3,
		["50"] = 3,
		["51"] = 3,
		["52"] = 11,
		["54"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_bunny_girl = c()
local k = g.modifier_bunny_girl
k.name = "modifier_bunny_girl"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		self.oid = l.oid
		local n = KeyValues.CosmeticsKV[l.oid]
		self.Model = n.resource
		if n.ambient ~= nil then
			local o = ParticleManager:CreateParticle(n.ambient, PATTACH_ABSORIGIN, m)
			self:AddParticle(o, false, false, -1, false, false)
		end
	end
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_UNSELECTABLE] = true }
end
function k.prototype.GetModifierModelChange(self)
	return self.Model
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
g.modifier_bunny_girl = k
return g