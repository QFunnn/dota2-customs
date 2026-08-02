--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_fury_permanent"
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
		["28"] = 23,
		["29"] = 24,
		["30"] = 25,
		["31"] = 25,
		["32"] = 25,
		["33"] = 25,
		["34"] = 25,
		["35"] = 26,
		["36"] = 26,
		["37"] = 26,
		["38"] = 26,
		["39"] = 26,
		["40"] = 26,
		["41"] = 26,
		["42"] = 26,
		["45"] = 29,
		["46"] = 30,
		["47"] = 31,
		["50"] = 21,
		["51"] = 35,
		["52"] = 36,
		["53"] = 35,
		["54"] = 41,
		["55"] = 42,
		["56"] = 41,
		["57"] = 44,
		["58"] = 45,
		["59"] = 44,
		["60"] = 48,
		["61"] = 49,
		["62"] = 49,
		["63"] = 49,
		["64"] = 49,
		["65"] = 49,
		["66"] = 49,
		["67"] = 49,
		["68"] = 49,
		["69"] = 48,
		["70"] = 52,
		["71"] = 53,
		["72"] = 53,
		["73"] = 53,
		["74"] = 53,
		["75"] = 53,
		["76"] = 53,
		["77"] = 53,
		["78"] = 52,
		["79"] = 11,
		["80"] = 3,
		["81"] = 3,
		["82"] = 3,
		["83"] = 3,
		["84"] = 3,
		["85"] = 3,
		["86"] = 3,
		["87"] = 3,
		["88"] = 11,
		["90"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_fury_permanent = c()
local k = g.modifier_fury_permanent
k.name = "modifier_fury_permanent"
d(k, i)
function k.prototype.GetTexture(self)
	return "fury_permanent"
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartIntervalThink(0.2)
	end
end
function k.prototype.OnIntervalThink(self)
	self:SetStackCount(GetModifierProperty(self:GetParent(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT))
	if self:GetStackCount() > 0 then
		if self.particleID == nil then
			self.particleID = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf",
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
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function k.prototype.EOM_GetModifierManaRegenBonus(self)
	return self:GetManaRegen()
end
function k.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self:GetAttackspeed()
end
function k.prototype.GetManaRegen(self)
	return ICE_FURY_MANA_REGEN(
		nil,
		KeyValues.UnitsKv[self:GetParent():GetUnitName()].ManaRegen,
		self:GetStackCount() + self:GetParent():GetModifierStackCount("modifier_fury_custom", self:GetParent())
	)
end
function k.prototype.GetAttackspeed(self)
	return ICE_FURY_ATTACKSPEED(
		nil,
		self:GetStackCount() + self:GetParent():GetModifierStackCount("modifier_fury_custom", self:GetParent())
	)
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
g.modifier_fury_permanent = k
return g