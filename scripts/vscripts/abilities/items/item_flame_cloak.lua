--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local sl_modifier_item_flame_cloak, sl_modifier_item_flame_burn_debuff
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifier_ItemIntrinsic = ____sl_modifier_base.SLModifier_ItemIntrinsic
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
--- 火焰斗篷
-- <h1>被动：生命之火</h1>每秒对敌军造成%damage%+%damage_hp_pct%%%装备者最大生命值的魔法伤害，并且使他们的物理攻击有%blind_pct%%%的几率不会命中。对幻象造成%illusion_hurted_pct%%%伤害。<br><br>如果装备者是幻象，则每秒造成%illusion_damage%+%illusion_damage_hp_pct%%%最大生命值的魔法伤害。<br><br>作用范围：%radius%
____exports.item_flame_cloak = __TS__Class()
local item_flame_cloak = ____exports.item_flame_cloak
item_flame_cloak.name = "item_flame_cloak"
__TS__ClassExtends(item_flame_cloak, SLItemBase)
function item_flame_cloak.prototype.____constructor(self, ...)
	SLItemBase.prototype.____constructor(self, ...)
	self._manual_toggle_state = false
end
function item_flame_cloak.prototype.GetIntrinsicModifierName(self)
	return sl_modifier_item_flame_cloak.name
end
function item_flame_cloak.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function item_flame_cloak.prototype.OnSpellStart(self)
	self._manual_toggle_state = not self._manual_toggle_state
	self:SetSecondaryCharges(self._manual_toggle_state and 1 or 0)
end
function item_flame_cloak.prototype.GetAbilityTextureName(self)
	if self:GetSecondaryCharges() == 1 then
		return "item_flame_cloak_magic"
	end
	return "item_flame_cloak"
end
item_flame_cloak = __TS__Decorate({ registerAbility(nil) }, item_flame_cloak)
____exports.item_flame_cloak = item_flame_cloak
sl_modifier_item_flame_cloak = __TS__Class()
sl_modifier_item_flame_cloak.name = "sl_modifier_item_flame_cloak"
__TS__ClassExtends(sl_modifier_item_flame_cloak, SLModifier_ItemIntrinsic)
function sl_modifier_item_flame_cloak.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end
function sl_modifier_item_flame_cloak.prototype.GetModifierBonusStats_Strength(self)
	return self:GetAbilitySpecialValueFor("bonus_strength")
end
function sl_modifier_item_flame_cloak.prototype.GetModifierPhysicalArmorBonus(self, event)
	return self:GetAbilitySpecialValueFor("bonus_armor")
end
function sl_modifier_item_flame_cloak.prototype.GetModifierConstantHealthRegen(self)
	return self:GetAbilitySpecialValueFor("bonus_regen")
end
function sl_modifier_item_flame_cloak.prototype.IsAura(self)
	return true
end
function sl_modifier_item_flame_cloak.prototype.GetAuraEntityReject(self, entity)
	if not self:IsLatestSource() then
		return true
	end
	return false
end
function sl_modifier_item_flame_cloak.prototype.GetAuraRadius(self)
	return self:GetAbilitySpecialValueFor("radius")
end
function sl_modifier_item_flame_cloak.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function sl_modifier_item_flame_cloak.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function sl_modifier_item_flame_cloak.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function sl_modifier_item_flame_cloak.prototype.GetModifierAura(self)
	return sl_modifier_item_flame_burn_debuff.name
end
function sl_modifier_item_flame_cloak.prototype.GetAuraDuration(self)
	return 0.5
end
sl_modifier_item_flame_cloak =
	__TS__Decorate({ registerModifier(nil, "abilities/items/item_flame_cloak") }, sl_modifier_item_flame_cloak)
sl_modifier_item_flame_burn_debuff = __TS__Class()
sl_modifier_item_flame_burn_debuff.name = "sl_modifier_item_flame_burn_debuff"
__TS__ClassExtends(sl_modifier_item_flame_burn_debuff, SLModifierBase_Debuff)
function sl_modifier_item_flame_burn_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_item_flame_burn_debuff.prototype.GetEffectName(self)
	local ____table_GetSecondaryCharges_result_0 = self:GetAbility()
	if ____table_GetSecondaryCharges_result_0 ~= nil then
		____table_GetSecondaryCharges_result_0 = ____table_GetSecondaryCharges_result_0:GetSecondaryCharges()
	end
	return ____table_GetSecondaryCharges_result_0 == 1 and ITEM_PARTICLES.item_flame_cloak_burn_magic_debuff
		or ITEM_PARTICLES.item_flame_cloak_burn_debuff
end
function sl_modifier_item_flame_burn_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_item_flame_burn_debuff.prototype.OnCreated(self, params)
	if not IsValid(self:GetAbility()) then
		return
	end
	self:_CalculateDamage()
	self:StartIntervalThink(1)
end
function sl_modifier_item_flame_burn_debuff.prototype.OnTooltip(self)
	return self._dmg
end
function sl_modifier_item_flame_burn_debuff.prototype._CalculateDamage(self)
	local caster = self:GetCaster()
	local dmg
	local dmg_hp_pct
	if caster:IsIllusion() then
		dmg = self:GetAbilitySpecialValueFor("illusion_damage")
		dmg_hp_pct = self:GetAbilitySpecialValueFor("illusion_damage_hp_pct")
	else
		dmg = self:GetAbilitySpecialValueFor("damage")
		dmg_hp_pct = self:GetAbilitySpecialValueFor("damage_hp_pct")
	end
	local caster_hp_max = caster:GetMaxHealth()
	local total_dmg = dmg + caster_hp_max * dmg_hp_pct * 0.01
	local parent = self:GetParent()
	if parent:IsIllusion() then
		local illusion_hurted_pct = self:GetAbilitySpecialValueFor("illusion_hurted_pct")
		total_dmg = total_dmg * (1 + illusion_hurted_pct * 0.01)
	end
	self._dmg = total_dmg
	local ____temp_2
	if self:GetAbility():GetSecondaryCharges() == 1 then
		____temp_2 = DAMAGE_TYPE_MAGICAL
	else
		____temp_2 = DAMAGE_TYPE_PHYSICAL
	end
	self._dmg_type = ____temp_2
end
function sl_modifier_item_flame_burn_debuff.prototype.OnIntervalThink(self)
	if not IsValid(self:GetAbility()) then
		return
	end
	self:_CalculateDamage()
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if IsServer() then
		ApplyDamage({
			attacker = caster,
			victim = parent,
			damage = self._dmg,
			damage_type = self._dmg_type,
			ability = self:GetAbility(),
		})
	end
end
sl_modifier_item_flame_burn_debuff =
	__TS__Decorate({ registerModifier(nil, "abilities/items/item_flame_cloak") }, sl_modifier_item_flame_burn_debuff)
return ____exports