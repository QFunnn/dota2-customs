--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/modifier_common"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 4,
		["12"] = 12,
		["13"] = 4,
		["14"] = 12,
		["16"] = 12,
		["17"] = 13,
		["18"] = 18,
		["19"] = 4,
		["20"] = 20,
		["21"] = 21,
		["22"] = 20,
		["23"] = 26,
		["24"] = 27,
		["25"] = 27,
		["26"] = 27,
		["27"] = 27,
		["28"] = 27,
		["29"] = 27,
		["30"] = 27,
		["31"] = 27,
		["32"] = 26,
		["33"] = 42,
		["34"] = 43,
		["35"] = 42,
		["36"] = 47,
		["37"] = 48,
		["38"] = 49,
		["39"] = 50,
		["40"] = 51,
		["41"] = 52,
		["42"] = 53,
		["43"] = 54,
		["44"] = 55,
		["45"] = 55,
		["46"] = 55,
		["47"] = 55,
		["48"] = 55,
		["49"] = 55,
		["51"] = 57,
		["52"] = 58,
		["53"] = 59,
		["56"] = 62,
		["58"] = 47,
		["59"] = 65,
		["60"] = 66,
		["61"] = 66,
		["62"] = 66,
		["63"] = 66,
		["64"] = 65,
		["65"] = 68,
		["66"] = 69,
		["67"] = 69,
		["68"] = 69,
		["69"] = 69,
		["70"] = 68,
		["71"] = 71,
		["72"] = 72,
		["73"] = 71,
		["74"] = 74,
		["75"] = 75,
		["76"] = 75,
		["77"] = 75,
		["78"] = 75,
		["79"] = 74,
		["80"] = 77,
		["81"] = 78,
		["82"] = 79,
		["83"] = 80,
		["84"] = 81,
		["86"] = 77,
		["87"] = 84,
		["88"] = 85,
		["89"] = 84,
		["90"] = 87,
		["91"] = 88,
		["92"] = 87,
		["93"] = 12,
		["94"] = 4,
		["95"] = 4,
		["96"] = 4,
		["97"] = 4,
		["98"] = 4,
		["99"] = 4,
		["100"] = 4,
		["101"] = 4,
		["102"] = 12,
		["104"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_common = c()
local k = g.modifier_common
k.name = "modifier_common"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.iBonusHealth = 0
	self.mana_regen_interval = FRAME_TIME
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_HEALTH_BAR] = true }
end
function k.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_AVOID_DAMAGE,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS_PERCENTAGE,
	}
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE }
end
function k.prototype.CalculateHealth(self)
	if IsServer() then
		local l = self:GetParent()
		local m = GetHealth(l)
		l:SetBaseMaxHealth(m)
		l:SetMaxHealth(m)
		if
			GameState:getStateName() ~= "GameState_Battle"
			and GameState:getStateName() ~= "GameState_BattleEnd"
			and GameState:getStateName() ~= "GameState_Neutral"
		then
			l:SetHealth(GetHealth(l))
			l:ModifyHealth(GetHealth(l), nil, true, 0)
		else
			local n = l:GetHealth()
			if n > m then
				l:SetHealth(m)
			end
		end
		l:CalculateGenericBonuses()
	end
end
function k.prototype.GetModifierPreAttack_BonusDamage(self, o)
	return GetAttackDamage(self:GetParent(), o)
end
function k.prototype.GetModifierPercentageCooldown(self, o)
	return GetCooldownReduction(self:GetParent(), o)
end
function k.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return GetAttackspeed(self:GetParent())
end
function k.prototype.GetModifierProjectileSpeedBonusPercentage(self)
	return GetModifierProperty(self:GetParent(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_SPEED_PERCENTAGE)
end
function k.prototype.EOM_GetModifierManaRegenBase(self)
	local p = self:GetParent():GetUnitName()
	local q = KeyValues.UnitsKv[p]
	if q and q.ManaRegen then
		return KeyValues.UnitsKv[p].ManaRegen
	end
end
function k.prototype.IsCrit(self, r)
	return self.crit_record == r
end
function k.prototype.GetModifierAvoidDamage(self, o)
	return 1
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
g.modifier_common = k
return g