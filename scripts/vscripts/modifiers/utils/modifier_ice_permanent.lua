--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_ice_permanent"
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
		["16"] = 11,
		["17"] = 13,
		["18"] = 3,
		["19"] = 14,
		["20"] = 15,
		["21"] = 14,
		["22"] = 17,
		["23"] = 18,
		["24"] = 19,
		["25"] = 20,
		["27"] = 17,
		["28"] = 23,
		["29"] = 24,
		["30"] = 24,
		["31"] = 24,
		["32"] = 24,
		["33"] = 24,
		["34"] = 24,
		["35"] = 24,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 28,
		["44"] = 28,
		["45"] = 28,
		["46"] = 28,
		["47"] = 28,
		["48"] = 28,
		["49"] = 28,
		["50"] = 28,
		["53"] = 31,
		["54"] = 32,
		["55"] = 33,
		["58"] = 23,
		["59"] = 37,
		["60"] = 38,
		["61"] = 37,
		["62"] = 42,
		["63"] = 43,
		["64"] = 42,
		["65"] = 45,
		["66"] = 46,
		["67"] = 45,
		["68"] = 51,
		["69"] = 52,
		["70"] = 51,
		["71"] = 54,
		["72"] = 55,
		["73"] = 54,
		["74"] = 58,
		["75"] = 59,
		["76"] = 60,
		["77"] = 61,
		["78"] = 66,
		["79"] = 66,
		["80"] = 66,
		["81"] = 66,
		["82"] = 66,
		["84"] = 68,
		["85"] = 58,
		["86"] = 71,
		["87"] = 72,
		["88"] = 73,
		["89"] = 74,
		["90"] = 75,
		["91"] = 76,
		["92"] = 77,
		["95"] = 80,
		["96"] = 81,
		["98"] = 83,
		["99"] = 71,
		["100"] = 11,
		["101"] = 3,
		["102"] = 3,
		["103"] = 3,
		["104"] = 3,
		["105"] = 3,
		["106"] = 3,
		["107"] = 3,
		["108"] = 3,
		["109"] = 11,
		["111"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_ice_permanent = c()
local k = g.modifier_ice_permanent
k.name = "modifier_ice_permanent"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.count = 0
end
function k.prototype.GetTexture(self)
	return "ice_permanent"
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartIntervalThink(0)
		self:SetHasCustomTransmitterData(true)
	end
end
function k.prototype.OnIntervalThink(self)
	self:SetStackCount(
		GetModifierProperty(self:GetParent(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_PERMANENT)
			+ GetModifierProperty(self:GetCaster(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_PERMANENT_SOURCE)
	)
	if self:GetStackCount() > 0 then
		if self.particleID == nil then
			self.particleID = ParticleManager:CreateParticle(
				"particles/generic_gameplay/generic_slowed_cold.vpcf",
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
function k.prototype.AddCustomTransmitterData(self)
	return { count = self.count }
end
function k.prototype.HandleCustomTransmitterData(self, m)
	self.count = m.count
end
function k.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function k.prototype.EOM_GetModifierManaRegenBonus(self)
	return -self:GetManaRegen()
end
function k.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return -self:GetAttackspeed()
end
function k.prototype.GetManaRegen(self)
	local n = self:GetParent()
	if
		not HasState(n, EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_EFFECT)
		and not HasState(n, EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_MANA_REGEN_EFFECT)
	then
		local o = self:GetStackCount() + self.count
		return ICE_FURY_MANA_REGEN(nil, KeyValues.UnitsKv[n:GetUnitName()].ManaRegen, o)
	end
	return 0
end
function k.prototype.GetAttackspeed(self)
	local n = self:GetParent()
	if not HasState(n, EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_EFFECT) then
		if IsServer() then
			local p = n:FindModifierByName("modifier_ice_custom")
			if IsValid(p) then
				self.count = p:GetStackCount()
			end
		end
		local o = self:GetStackCount() + self.count
		return ICE_FURY_ATTACKSPEED(nil, o)
	end
	return 0
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
g.modifier_ice_permanent = k
return g