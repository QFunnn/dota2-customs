--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_injury_permanent"
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
		["25"] = 22,
		["26"] = 22,
		["27"] = 22,
		["28"] = 22,
		["29"] = 22,
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 25,
		["34"] = 25,
		["35"] = 25,
		["36"] = 25,
		["37"] = 25,
		["38"] = 26,
		["39"] = 26,
		["40"] = 26,
		["41"] = 26,
		["42"] = 26,
		["43"] = 26,
		["44"] = 26,
		["45"] = 26,
		["48"] = 29,
		["49"] = 30,
		["50"] = 31,
		["53"] = 21,
		["54"] = 35,
		["55"] = 36,
		["56"] = 35,
		["57"] = 40,
		["58"] = 41,
		["59"] = 40,
		["60"] = 11,
		["61"] = 3,
		["62"] = 3,
		["63"] = 3,
		["64"] = 3,
		["65"] = 3,
		["66"] = 3,
		["67"] = 3,
		["68"] = 3,
		["69"] = 11,
		["71"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_injury_permanent = c()
local k = g.modifier_injury_permanent
k.name = "modifier_injury_permanent"
d(k, i)
function k.prototype.GetTexture(self)
	return "injury_permanent"
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function k.prototype.OnIntervalThink(self)
	self:SetStackCount(
		GetModifierProperty(self:GetParent(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT)
			+ GetModifierProperty(self:GetCaster(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT_SOURCE)
	)
	if self:GetStackCount() > 0 then
		if self.particleID == nil then
			self.particleID = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_shadow_demon/shadow_demon_shadow_poison_4stack.vpcf",
				PATTACH_ABSORIGIN,
				self:GetParent()
			)
			self:AddParticle(self.particleID, false, false, -1, false, false)
		end
	else
		if self.particleID then
			ParticleManager:DestroyParticle(self.particleID, false)
			self.particleID = nil
		end
	end
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ADJUST_DAMAGE }
end
function k.prototype.EOM_GetModifierAdjustDamage(self)
	return -self:GetStackCount()
end
k = e(
	{
		j(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_injury_permanent = k
return g