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
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local FindEnemies = ____item_0409_shared.FindEnemies
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local FROST_CRACK_STUN_EFFECT = "particles/maiden_frostbite_buff.vpcf"
local FROST_CRACK_STUN_STATUS = "particles/status_fx/status_effect_frost.vpcf"
____exports.item_0411 = __TS__Class()
local item_0411 = ____exports.item_0411
item_0411.name = "item_0411"
__TS__ClassExtends(item_0411, BaseItem_CS)
function item_0411.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf", context)
	PrecacheResource("particle", FROST_CRACK_STUN_EFFECT, context)
	PrecacheResource("particle", FROST_CRACK_STUN_STATUS, context)
end
function item_0411.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0411_frost_splitter.name
end
item_0411 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0411)
____exports.item_0411 = item_0411
____exports.modifier_item_0411_frost_splitter = __TS__Class()
local modifier_item_0411_frost_splitter = ____exports.modifier_item_0411_frost_splitter
modifier_item_0411_frost_splitter.name = "modifier_item_0411_frost_splitter"
__TS__ClassExtends(modifier_item_0411_frost_splitter, BaseModifier_CS)
function modifier_item_0411_frost_splitter.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_item_0411_frost_splitter.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
end
function modifier_item_0411_frost_splitter.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0411_frost_splitter.prototype.IsPurgable(self)
	return false
end
function modifier_item_0411_frost_splitter.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_bonus_armor_per_stack = ability:GetSpecialValueFor("ability_bonus_armor_per_stack")
	return { bonus_armor = self:GetStackCount() * ability_bonus_armor_per_stack }
end
function modifier_item_0411_frost_splitter.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.target ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local attacker = event.attacker
	if not IsValidEnemyUnit(nil, parent, attacker) then
		return
	end
	local ability_required_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_required_stacks")))
	local nextStacks = math.min(ability_required_stacks, self:GetStackCount() + 1)
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
	if nextStacks < ability_required_stacks then
		return
	end
	self:TriggerFrostCrack(parent, ability)
	self:SetStackCount(0)
	self:RefreshAttributes()
	self:StartAbilityCooldown(ability)
end
function modifier_item_0411_frost_splitter.prototype.GetTexture(self)
	return "item_icon_23"
end
function modifier_item_0411_frost_splitter.prototype.TriggerFrostCrack(self, parent, ability)
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_max_shield_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_max_shield_damage_pct"))
	local ability_freeze_duration = math.max(0, ability:GetSpecialValueFor("ability_freeze_duration"))
	if ability_radius <= 0 or ability_max_shield_damage_pct <= 0 then
		return
	end
	local ____math_max_2 = math.max
	local ____this_1
	____this_1 = parent
	local ____opt_0 = ____this_1.GetTotalEnergyShield
	local ability_max_shield = ____math_max_2(
		0,
		____opt_0 and ____opt_0(____this_1) or MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0
	)
	local ability_damage = ability_max_shield * (ability_max_shield_damage_pct / 100)
	self:PlayEffects1(parent, ability_radius)
	for ____, enemy in ipairs(FindEnemies(nil, parent, parent:GetAbsOrigin(), ability_radius)) do
		do
			if not IsValidEnemyUnit(nil, parent, enemy) then
				goto __continue21
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = ability_damage,
				damage_type = 1,
				ability = ability,
				extra_data = {
					custom_tag = "item_0411_frost_crack",
					source_name = self:GetName(),
				},
			})
			local freezeDuration = self:GetFreezeDuration(ability, enemy, ability_freeze_duration)
			if freezeDuration > 0 then
				AddDeBuffStatus(
					nil,
					enemy,
					parent,
					ability,
					DebuffStatusType.STUN,
					{
						duration = freezeDuration,
						effect_name = FROST_CRACK_STUN_EFFECT,
						status_effect_name = FROST_CRACK_STUN_STATUS,
					}
				)
			end
		end
		::__continue21::
	end
end
function modifier_item_0411_frost_splitter.prototype.GetFreezeDuration(self, ability, enemy, ability_freeze_duration)
	local ____this_4
	____this_4 = enemy
	local ____opt_3 = ____this_4.IsBoss
	if not (____opt_3 and ____opt_3(____this_4)) then
		return ability_freeze_duration
	end
	local ability_boss_freeze_reduce_pct =
		math.max(0, math.min(100, ability:GetSpecialValueFor("ability_boss_freeze_reduce_pct")))
	return ability_freeze_duration * (1 - ability_boss_freeze_reduce_pct / 100)
end
function modifier_item_0411_frost_splitter.prototype.StartAbilityCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	local ability_cooldown = ability:GetCooldown(level)
	local ____ability_6 = ability
	local ____ability_StartCooldown_7 = ability.StartCooldown
	local ____temp_5
	if ability_cooldown > 0 then
		____temp_5 = ability_cooldown
	else
		____temp_5 = ability:GetSpecialValueFor("ability_cooldown")
	end
	____ability_StartCooldown_7(____ability_6, ____temp_5)
end
function modifier_item_0411_frost_splitter.prototype.PlayEffects1(self, parent, ability_radius)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf",
		PATTACH_WORLDORIGIN,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(ability_radius, ability_radius, ability_radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Hero_Crystal.CrystalNova", parent)
end
modifier_item_0411_frost_splitter = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0411_frost_splitter)
____exports.modifier_item_0411_frost_splitter = modifier_item_0411_frost_splitter
return ____exports