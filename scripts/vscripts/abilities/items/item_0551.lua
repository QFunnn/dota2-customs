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
____exports.item_0551 = __TS__Class()
local item_0551 = ____exports.item_0551
item_0551.name = "item_0551"
__TS__ClassExtends(item_0551, BaseItem_CS)
function item_0551.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0551_arcane_spring.name
end
item_0551 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0551)
____exports.item_0551 = item_0551
____exports.modifier_item_0551_arcane_spring = __TS__Class()
local modifier_item_0551_arcane_spring = ____exports.modifier_item_0551_arcane_spring
modifier_item_0551_arcane_spring.name = "modifier_item_0551_arcane_spring"
__TS__ClassExtends(modifier_item_0551_arcane_spring, BaseModifier_CS)
function modifier_item_0551_arcane_spring.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function modifier_item_0551_arcane_spring.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0551_arcane_spring.prototype.GetMutexKey(self)
	return "yong_ling_mutex"
end
function modifier_item_0551_arcane_spring.prototype.GetMutexPriority(self)
	return 200
end
function modifier_item_0551_arcane_spring.prototype.GetModifierAura(self)
	return ____exports.modifier_item_0551_clear_spring_debuff.name
end
function modifier_item_0551_arcane_spring.prototype.GetAuraRadius(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = math.max(0, ability:GetSpecialValueFor("ability_aura_radius"))
	else
		____ability_0 = 0
	end
	return ____ability_0
end
function modifier_item_0551_arcane_spring.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_item_0551_arcane_spring.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_item_0551_arcane_spring.prototype.IsAura(self)
	return true
end
function modifier_item_0551_arcane_spring.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local ability_aura_radius = math.max(0, ability:GetSpecialValueFor("ability_aura_radius"))
	self:DamageEnemies(parent, ability, ability_aura_radius)
	local ability_mana_restore_max_mana_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_mana_restore_max_mana_pct"))
	if ability_mana_restore_max_mana_pct <= 0 then
		return
	end
	self:RestoreMana(parent, ability_mana_restore_max_mana_pct)
	local allies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ability_aura_radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, ally in ipairs(allies) do
		do
			if ally == parent or not IsValidAlive(nil, ally) then
				goto __continue18
			end
			self:RestoreMana(ally, ability_mana_restore_max_mana_pct)
		end
		::__continue18::
	end
end
function modifier_item_0551_arcane_spring.prototype.DamageEnemies(self, parent, ability, ability_aura_radius)
	local ability_max_mana = math.max(0, MyGameAttribute:GetAttribute(parent, "total_mana") or parent:GetMaxMana())
	local ability_damage = ability_max_mana
	if ability_aura_radius <= 0 or ability_damage <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ability_aura_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue23
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = ability_damage,
				damage_type = 4,
				ability = ability,
				extra_data = {
					damage_tags = DamageTag.DOT,
					source_name = self:GetName(),
				},
			})
		end
		::__continue23::
	end
end
function modifier_item_0551_arcane_spring.prototype.RestoreMana(self, target, ability_mana_restore_max_mana_pct)
	local ability_max_mana = math.max(0, target:GetMaxMana())
	local ability_missing_mana = math.max(0, ability_max_mana - target:GetMana())
	local ability_restore_mana =
		math.min(ability_missing_mana, ability_max_mana * (ability_mana_restore_max_mana_pct / 100))
	if ability_restore_mana > 0 then
		target:GiveMana(ability_restore_mana)
	end
end
function modifier_item_0551_arcane_spring.prototype.IsHidden(self)
	return true
end
function modifier_item_0551_arcane_spring.prototype.IsPurgable(self)
	return false
end
modifier_item_0551_arcane_spring = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0551_arcane_spring)
____exports.modifier_item_0551_arcane_spring = modifier_item_0551_arcane_spring
____exports.modifier_item_0551_clear_spring_debuff = __TS__Class()
local modifier_item_0551_clear_spring_debuff = ____exports.modifier_item_0551_clear_spring_debuff
modifier_item_0551_clear_spring_debuff.name = "modifier_item_0551_clear_spring_debuff"
__TS__ClassExtends(modifier_item_0551_clear_spring_debuff, BaseModifier_CS)
function modifier_item_0551_clear_spring_debuff.GetLocalizationCN(self)
	return { name = "清涌之灵", description = "攻击速度和移动速度降低。" }
end
function modifier_item_0551_clear_spring_debuff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_1
	if ability then
		____ability_1 = math.max(0, ability:GetSpecialValueFor("ability_value_slow_pct"))
	else
		____ability_1 = 0
	end
	local ability_slow_pct = ____ability_1
	return { attack_speed_pct = -ability_slow_pct, bonus_movespeed_pct = -ability_slow_pct }
end
function modifier_item_0551_clear_spring_debuff.prototype.IsDebuff(self)
	return true
end
function modifier_item_0551_clear_spring_debuff.prototype.IsPurgable(self)
	return false
end
function modifier_item_0551_clear_spring_debuff.prototype.GetTextureName(self)
	return "item_icon_zb97_03"
end
modifier_item_0551_clear_spring_debuff =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0551_clear_spring_debuff)
____exports.modifier_item_0551_clear_spring_debuff = modifier_item_0551_clear_spring_debuff
return ____exports