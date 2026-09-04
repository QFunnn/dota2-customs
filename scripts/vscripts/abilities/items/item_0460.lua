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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0460 = __TS__Class()
local item_0460 = ____exports.item_0460
item_0460.name = "item_0460"
__TS__ClassExtends(item_0460, BaseItem_CS)
function item_0460.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/neutral_fx/miniboss_dire_shield_hit.vpcf", context)
end
function item_0460.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0460_lionheart_hammer.name
end
item_0460 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0460)
____exports.item_0460 = item_0460
____exports.modifier_item_0460_lionheart_hammer = __TS__Class()
local modifier_item_0460_lionheart_hammer = ____exports.modifier_item_0460_lionheart_hammer
modifier_item_0460_lionheart_hammer.name = "modifier_item_0460_lionheart_hammer"
__TS__ClassExtends(modifier_item_0460_lionheart_hammer, BaseModifier_CS)
function modifier_item_0460_lionheart_hammer.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0460_lionheart_hammer.prototype.IsHidden(self)
	return true
end
function modifier_item_0460_lionheart_hammer.prototype.IsPurgable(self)
	return false
end
function modifier_item_0460_lionheart_hammer.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_current_shield_damage_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_current_shield_damage_pct"))
	local ability_armor_damage_pct_per_point =
		math.max(0, ability:GetSpecialValueFor("ability_armor_damage_pct_per_point"))
	local ability_armor_damage_pct_per_point_max =
		math.max(0, ability:GetSpecialValueFor("ability_value_armor_damage_pct_per_point_max"))
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	if ability_current_shield_damage_pct <= 0 or ability_radius <= 0 then
		return
	end
	local ____math_max_2 = math.max
	local ____opt_0 = parent.GetTotalEnergyShield
	local ability_max_shield = ____math_max_2(
		0,
		____opt_0 and ____opt_0(parent) or MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0
	)
	local ability_total_armor = math.max(0, MyGameAttribute:GetAttribute(parent, "total_armor") or 0)
	local ability_armor_damage_bonus_pct =
		math.min(ability_total_armor * ability_armor_damage_pct_per_point, ability_armor_damage_pct_per_point_max)
	local ability_armor_damage_multiplier = 1 + ability_armor_damage_bonus_pct / 100
	local ability_damage = ability_max_shield
		* (ability_current_shield_damage_pct / 100)
		* ability_armor_damage_multiplier
	if ability_damage <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	if #enemies <= 0 then
		return
	end
	self:PlayEffects1(parent, target, ability_radius)
	__TS__ArrayForEach(enemies, function(____, enemy)
		if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
			return
		end
		Damage:ApplyDamage({
			victim = enemy,
			attacker = parent,
			damage = ability_damage,
			damage_type = 1,
			ability = ability,
			extra_data = { custom_tag = "item_0460_lionheart_hammer", source_name = "狮心王锤" },
		})
	end)
	self:StartAbilityCooldown(ability)
end
function modifier_item_0460_lionheart_hammer.prototype.StartAbilityCooldown(self, ability)
	local ability_level = math.max(0, ability:GetLevel() - 1)
	local ability_cooldown = ability:GetCooldown(ability_level)
	local ____ability_4 = ability
	local ____ability_StartCooldown_5 = ability.StartCooldown
	local ____temp_3
	if ability_cooldown > 0 then
		____temp_3 = ability_cooldown
	else
		____temp_3 = 0.01
	end
	____ability_StartCooldown_5(____ability_4, ____temp_3)
end
function modifier_item_0460_lionheart_hammer.prototype.PlayEffects1(self, parent, target, ability_radius)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/neutral_fx/miniboss_dire_shield_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(ability_radius, ability_radius, ability_radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Hero_Magnataur.Empower.Target", target)
end
modifier_item_0460_lionheart_hammer =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0460_lionheart_hammer)
____exports.modifier_item_0460_lionheart_hammer = modifier_item_0460_lionheart_hammer
return ____exports