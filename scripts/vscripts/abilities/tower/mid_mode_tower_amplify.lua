--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.mid_mode_tower_amplify = __TS__Class()
local mid_mode_tower_amplify = ____exports.mid_mode_tower_amplify
mid_mode_tower_amplify.name = "mid_mode_tower_amplify"
__TS__ClassExtends(mid_mode_tower_amplify, BaseAbility)
function mid_mode_tower_amplify.prototype.GetIntrinsicModifierName(self)
	local level = self:GetLevel()
	if level >= 1 then
		return ____exports.modifier_mid_mode_tower_amplify.name
	end
end
mid_mode_tower_amplify = __TS__Decorate({ registerAbility(nil) }, mid_mode_tower_amplify)
____exports.mid_mode_tower_amplify = mid_mode_tower_amplify
____exports.modifier_mid_mode_tower_amplify = __TS__Class()
local modifier_mid_mode_tower_amplify = ____exports.modifier_mid_mode_tower_amplify
modifier_mid_mode_tower_amplify.name = "modifier_mid_mode_tower_amplify"
__TS__ClassExtends(modifier_mid_mode_tower_amplify, SLModifierBase)
function modifier_mid_mode_tower_amplify.prototype.AllowIllusionDuplicate(self)
	return false
end
function modifier_mid_mode_tower_amplify.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function modifier_mid_mode_tower_amplify.prototype.CheckState(self)
	return { [MODIFIER_STATE_CANNOT_MISS] = true }
end
function modifier_mid_mode_tower_amplify.prototype.OnCreated(self, params)
	self._weak_time = self:GetAbilitySpecialValueFor("weak_time") * 60
	self._weak_pct = self:GetAbilitySpecialValueFor("weak_pct")
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local ____parent_SetBaseMaxHealth_2 = parent.SetBaseMaxHealth
	local ____temp_1 = parent:GetBaseMaxHealth()
	local ____temp_0 = self:GetAbilitySpecialValueFor("health_bonus")
	if ____temp_0 == nil then
		____temp_0 = 0
	end
	____parent_SetBaseMaxHealth_2(parent, ____temp_1 + ____temp_0)
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierProcAttack_BonusDamage_Pure(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local attacker = event.attacker
	local victim = event.target
	if IsValid(parent) and IsValid(attacker) and IsValid(victim) and victim:IsHero() then
		if parent == attacker and parent ~= victim then
			local bonus_pure_damage_pct = self:GetAbilitySpecialValueFor("bonus_pure_damage_pct")
			if not bonus_pure_damage_pct then
				return
			end
			local damage = victim:GetHealth() * (bonus_pure_damage_pct / 100)
			return damage
		end
	end
end
function modifier_mid_mode_tower_amplify.prototype.OnDeath(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local unit = event.unit
	if IsValid(parent) and IsValid(unit) and parent == unit then
		local delay = 4
		local name = parent:GetUnitName()
		local soundName
		repeat
			local ____switch18 = name
			local ____cond18 = ____switch18 == "npc_dota_goodguys_tower3_mid"
			if ____cond18 then
				soundName = "mid_super_bad"
				break
			end
			____cond18 = ____cond18 or ____switch18 == "npc_dota_badguys_tower3_mid"
			if ____cond18 then
				soundName = "mid_super_good"
				break
			end
			do
				break
			end
		until true
		if soundName then
			Timers:CreateTimer(delay, function()
				EmitGlobalSound(soundName)
			end)
		end
	end
end
function modifier_mid_mode_tower_amplify.prototype._GetWeakPct(self)
	if not self._weak_time or not self._weak_pct then
		return 0
	end
	local game_time = GameRules:GetDOTATime(false, false)
	if game_time <= self._weak_time then
		return 0
	end
	local minutes = math.floor((game_time - self._weak_time) / 60)
	return minutes * self._weak_pct
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierIncomingDamage_Percentage(self, event)
	return self:GetAbilitySpecialValueFor("dmg_res_pct") * -1 + self:_GetWeakPct()
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierAttackSpeedBonus_Constant(self)
	local ____temp_3 = self:GetAbilitySpecialValueFor("attack_speed_bonus")
	if ____temp_3 == nil then
		____temp_3 = 0
	end
	return ____temp_3
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierProjectileSpeedBonus(self)
	local ____temp_4 = self:GetAbilitySpecialValueFor("projectile_speed_bonus")
	if ____temp_4 == nil then
		____temp_4 = 0
	end
	return ____temp_4
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____temp_5 = self:GetAbilitySpecialValueFor("armor_bonus")
	if ____temp_5 == nil then
		____temp_5 = 0
	end
	return ____temp_5
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierMagicalResistanceBonus(self, event)
	local ____temp_6 = self:GetAbilitySpecialValueFor("magic_resist")
	if ____temp_6 == nil then
		____temp_6 = 0
	end
	return ____temp_6
end
modifier_mid_mode_tower_amplify =
	__TS__Decorate({ registerModifier(nil, "abilities/tower/mid_mode_tower_amplify") }, modifier_mid_mode_tower_amplify)
____exports.modifier_mid_mode_tower_amplify = modifier_mid_mode_tower_amplify
return ____exports