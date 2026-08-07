--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_courier_attack"
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
		["23"] = 22,
		["24"] = 23,
		["26"] = 25,
		["27"] = 26,
		["29"] = 28,
		["30"] = 29,
		["33"] = 14,
		["34"] = 33,
		["35"] = 34,
		["36"] = 35,
		["37"] = 36,
		["38"] = 37,
		["39"] = 38,
		["41"] = 40,
		["42"] = 41,
		["44"] = 43,
		["45"] = 44,
		["48"] = 33,
		["49"] = 48,
		["50"] = 49,
		["51"] = 50,
		["53"] = 48,
		["54"] = 11,
		["55"] = 3,
		["56"] = 3,
		["57"] = 3,
		["58"] = 3,
		["59"] = 3,
		["60"] = 3,
		["61"] = 3,
		["62"] = 3,
		["63"] = 11,
		["65"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_courier_attack = c()
local k = g.modifier_courier_attack
k.name = "modifier_courier_attack"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		self.oid = l.oid
		local n = KeyValues.CosmeticsKV[l.oid]
		if n.resource then
			Wearable:registerParticleModifier(m, COSMETIC_DEFAULT_PROJECTILE, n.resource)
		end
		if n.launch_sound then
			Wearable:registerSoundModifier(m, COSMETIC_DEFAULT_PROJECTILE_LAUNCH_SOUND, n.launch_sound)
		end
		if n.landed_sound then
			Wearable:registerSoundModifier(m, COSMETIC_DEFAULT_PROJECTILE_LANDED_SOUND, n.landed_sound)
		end
		if n.offset then
			self.offset = n.offset
		end
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		local m = self:GetParent()
		local n = KeyValues.CosmeticsKV[self.oid]
		if n.resource then
			Wearable:unregisterParticleModifier(m, n.resource)
		end
		if n.launch_sound then
			Wearable:unregisterSoundModifier(m, n.launch_sound)
		end
		if n.landed_sound then
			Wearable:unregisterSoundModifier(m, n.landed_sound)
		end
	end
end
function k.prototype.GetPartileOriginOffset(self)
	if self.offset ~= nil then
		return StringToVector(self.offset)
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
g.modifier_courier_attack = k
return g