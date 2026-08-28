--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_ice_custom"
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
		["18"] = 16,
		["19"] = 17,
		["21"] = 19,
		["22"] = 19,
		["23"] = 19,
		["24"] = 19,
		["25"] = 19,
		["26"] = 20,
		["27"] = 20,
		["28"] = 20,
		["29"] = 20,
		["30"] = 20,
		["31"] = 20,
		["32"] = 20,
		["33"] = 20,
		["35"] = 12,
		["36"] = 23,
		["37"] = 24,
		["38"] = 25,
		["40"] = 23,
		["41"] = 28,
		["42"] = 29,
		["43"] = 30,
		["44"] = 30,
		["45"] = 29,
		["46"] = 28,
		["47"] = 33,
		["48"] = 34,
		["49"] = 35,
		["51"] = 33,
		["52"] = 38,
		["53"] = 39,
		["54"] = 40,
		["55"] = 41,
		["57"] = 44,
		["58"] = 45,
		["59"] = 45,
		["60"] = 45,
		["61"] = 45,
		["62"] = 46,
		["63"] = 47,
		["64"] = 48,
		["65"] = 49,
		["66"] = 50,
		["69"] = 38,
		["70"] = 55,
		["71"] = 56,
		["72"] = 55,
		["73"] = 64,
		["74"] = 65,
		["75"] = 66,
		["76"] = 64,
		["77"] = 68,
		["78"] = 69,
		["79"] = 68,
		["80"] = 74,
		["81"] = 75,
		["82"] = 74,
		["83"] = 78,
		["84"] = 79,
		["85"] = 79,
		["86"] = 79,
		["87"] = 79,
		["88"] = 79,
		["89"] = 79,
		["90"] = 79,
		["91"] = 80,
		["92"] = 80,
		["93"] = 80,
		["94"] = 80,
		["95"] = 80,
		["97"] = 82,
		["98"] = 78,
		["99"] = 85,
		["100"] = 86,
		["101"] = 86,
		["102"] = 86,
		["103"] = 86,
		["104"] = 87,
		["105"] = 87,
		["106"] = 87,
		["107"] = 87,
		["109"] = 89,
		["110"] = 85,
		["111"] = 11,
		["112"] = 3,
		["113"] = 3,
		["114"] = 3,
		["115"] = 3,
		["116"] = 3,
		["117"] = 3,
		["118"] = 3,
		["119"] = 3,
		["120"] = 11,
		["122"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_ice_custom = c()
local k = g.modifier_ice_custom
k.name = "modifier_ice_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		self:SetStackCount(l.iStackCount)
		self:StartIntervalThink(ICE_ATTENUATION.Interval)
	else
		local n = ParticleManager:CreateParticle(
			"particles/generic_gameplay/generic_slowed_cold.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(n, false, false, -1, false, false)
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:IncrementStackCount(l.iStackCount)
	end
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function k.prototype.OnBattleEnd(self, l)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function k.prototype.OnIntervalThink(self)
	local o = self:GetParent()
	local p = self:GetCaster()
	if IsValid(p) then
	end
	local q = math.ceil(self:GetStackCount() * ICE_ATTENUATION.Percentage) + ICE_ATTENUATION.Const
	q = math.max(
		0,
		math.ceil(
			q * (
					1
					+ GetModifierProperty(o, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_ATTENUATION_PERCENTAGE)
						* 0.01
				)
		)
	)
	if q > 0 then
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS, { iCount = q }, p, o)
		self:DecrementStackCount(q)
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end
function k.prototype.EDeclareFunctions(self)
	return {}
end
function k.prototype.EOM_GetModifierIncomingDamagePercentage(self, l)
	local r = self:GetStackCount()
	return 100 * r / (r + ICE_DAMAGE_INCREASE)
end
function k.prototype.EOM_GetModifierManaRegenBonus(self)
	return -self:GetManaRegen()
end
function k.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return -self:GetAttackspeed()
end
function k.prototype.GetManaRegen(self)
	if
		not HasState(self:GetParent(), EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_EFFECT)
		and not HasState(self:GetParent(), EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_MANA_REGEN_EFFECT)
	then
		return ICE_FURY_MANA_REGEN(
			nil,
			KeyValues.UnitsKv[self:GetParent():GetUnitName()].ManaRegen,
			self:GetStackCount()
		)
	end
	return 0
end
function k.prototype.GetAttackspeed(self)
	if not HasState(self:GetParent(), EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_EFFECT) then
		return ICE_FURY_ATTACKSPEED(nil, self:GetStackCount())
	end
	return 0
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
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
g.modifier_ice_custom = k
return g