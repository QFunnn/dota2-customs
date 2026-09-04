--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local BURN_DURATION = 3
local BURN_TICK_INTERVAL = 0.5
local BURN_CURRENT_HP_PCT = 15
local BURN_ELITE_FACTOR = 0.5
local BURN_BOSS_FACTOR = 0.1
local BURN_HEAL_REDUCTION_PCT = 25
local BURN_SELF_SOURCE_DAMAGE_REDUCTION_PCT = 65
local BURN_DEFAULT_EFFECT = "particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf"
____exports.modifier_generic_burning = __TS__Class()
local modifier_generic_burning = ____exports.modifier_generic_burning
modifier_generic_burning.name = "modifier_generic_burning"
__TS__ClassExtends(modifier_generic_burning, BaseModifier_CS)
function modifier_generic_burning.GetLocalizationCN(self)
	return {
		name = "灼烧",
		description = "周期性受到纯粹伤害。普通目标每秒受到当前生命值15%，精英7.5%，头目和首领1.5%；治疗与恢复效果降低25%。",
	}
end
function modifier_generic_burning.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.effectName = params.effect_name
	self.statusEffectName = params.status_effect_name
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
	self:StartIntervalThink(BURN_TICK_INTERVAL)
end
function modifier_generic_burning.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.effectName = params.effect_name or self.effectName
	self.statusEffectName = params.status_effect_name or self.statusEffectName
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_generic_burning.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local victim = self:GetParent()
	local attacker = self:GetCaster()
	if not IsValidAlive(nil, victim) or not IsValidAlive(nil, attacker) then
		self:Destroy()
		return
	end
	local factor = 1
	if victim:IsBoss() then
		factor = BURN_BOSS_FACTOR
	elseif victim:IsMiniboss() then
		factor = BURN_BOSS_FACTOR
	elseif victim:IsElite() then
		factor = BURN_ELITE_FACTOR
	end
	local ____temp_0
	if attacker == victim then
		____temp_0 = 1 - BURN_SELF_SOURCE_DAMAGE_REDUCTION_PCT / 100
	else
		____temp_0 = 1
	end
	local selfSourceFactor = ____temp_0
	local damage = victim:GetHealth() * (BURN_CURRENT_HP_PCT / 100) * BURN_TICK_INTERVAL * factor * selfSourceFactor
	if damage <= 0 then
		self:Destroy()
		return
	end
	Damage:ApplyDamage({
		attacker = attacker,
		victim = victim,
		damage = damage,
		damage_type = 4,
		damage_flag = ApplyDamageFlag.HP_LOSS,
		ability = self:GetAbility(),
		extra_data = {
			damage_tags = DamageTag.DOT,
			debuff_status = DebuffStatusType.BURN,
			source_name = self:GetName(),
		},
	})
end
function modifier_generic_burning.prototype.AddCustomTransmitterData(self)
	return { effectName = self.effectName, statusEffectName = self.statusEffectName }
end
function modifier_generic_burning.prototype.HandleCustomTransmitterData(self, data)
	self.effectName = data.effectName
	self.statusEffectName = data.statusEffectName
end
function modifier_generic_burning.prototype.GetAttributeBonus(self)
	return { regen_amp_pct = -BURN_HEAL_REDUCTION_PCT }
end
function modifier_generic_burning.prototype.IsHidden(self)
	return false
end
function modifier_generic_burning.prototype.IsDebuff(self)
	return true
end
function modifier_generic_burning.prototype.IsPurgable(self)
	return true
end
function modifier_generic_burning.prototype.GetEffectName(self)
	return self.effectName or BURN_DEFAULT_EFFECT
end
function modifier_generic_burning.prototype.GetStatusEffectName(self)
	return self.statusEffectName or ""
end
function modifier_generic_burning.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_generic_burning.prototype.GetTexture(self)
	return "huskar_burning_spear"
end
modifier_generic_burning = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_burning)
____exports.modifier_generic_burning = modifier_generic_burning
return ____exports