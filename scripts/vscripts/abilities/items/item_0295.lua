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
local ITEM_0295_INVULNERABLE_DURATION = 3
local ITEM_0295_INVULNERABLE_EFFECT = "particles/units/heroes/hero_skeletonking/wraith_king_ghosts_ambient.vpcf"
local ITEM_0295_INVULNERABLE_STATUS = "particles/status_fx/status_effect_wraithking_ghosts.vpcf"
____exports.item_0295 = __TS__Class()
local item_0295 = ____exports.item_0295
item_0295.name = "item_0295"
__TS__ClassExtends(item_0295, BaseItem_CS)
function item_0295.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_0295_INVULNERABLE_EFFECT, context)
	PrecacheResource("particle", ITEM_0295_INVULNERABLE_STATUS, context)
end
function item_0295.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0295_scapegoat_tracker.name
end
item_0295 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0295)
____exports.item_0295 = item_0295
____exports.modifier_item_0295_scapegoat_tracker = __TS__Class()
local modifier_item_0295_scapegoat_tracker = ____exports.modifier_item_0295_scapegoat_tracker
modifier_item_0295_scapegoat_tracker.name = "modifier_item_0295_scapegoat_tracker"
__TS__ClassExtends(modifier_item_0295_scapegoat_tracker, BaseModifier_CS)
function modifier_item_0295_scapegoat_tracker.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.triggered = false
end
function modifier_item_0295_scapegoat_tracker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.triggered = false
end
function modifier_item_0295_scapegoat_tracker.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH_INTERCEPT, priority = DeathRevivePriority.EQUIPMENT } }
end
function modifier_item_0295_scapegoat_tracker.prototype.OnUnitDeathIntercept_CS(self, event)
	if not IsServer() then
		return
	end
	if event.prevented then
		return
	end
	if self.triggered then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.victim ~= parent then
		return
	end
	self.triggered = true
	event.prevented = true
	event.handled_by = self:GetName()
	event.intercept_type = "death_prevent"
	event.set_health = 1
	local ability_bonus_attack_damage_pct = ability:GetSpecialValueFor("ability_bonus_attack_damage_pct")
	local ability_bonus_crit_chance_pct = ability:GetSpecialValueFor("ability_bonus_crit_chance_pct")
	local ability_duration = ability:GetSpecialValueFor("ability_duration")
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0295_scapegoat_power.name,
		{
			duration = ability_duration,
			bonus_attack_damage_pct = ability_bonus_attack_damage_pct,
			bonus_crit_chance_pct = ability_bonus_crit_chance_pct,
		}
	)
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0295_scapegoat_invulnerable.name,
		{ duration = ITEM_0295_INVULNERABLE_DURATION }
	)
	parent:EmitSound("Hero_SkeletonKing.Reincarnate.Ghost")
	ability:RemoveSelf()
end
function modifier_item_0295_scapegoat_tracker.prototype.IsHidden(self)
	return true
end
modifier_item_0295_scapegoat_tracker =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0295_scapegoat_tracker)
____exports.modifier_item_0295_scapegoat_tracker = modifier_item_0295_scapegoat_tracker
____exports.modifier_item_0295_scapegoat_power = __TS__Class()
local modifier_item_0295_scapegoat_power = ____exports.modifier_item_0295_scapegoat_power
modifier_item_0295_scapegoat_power.name = "modifier_item_0295_scapegoat_power"
__TS__ClassExtends(modifier_item_0295_scapegoat_power, BaseModifier_CS)
function modifier_item_0295_scapegoat_power.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.bonusAttackDamagePct = 0
	self.bonusCritChancePct = 0
end
function modifier_item_0295_scapegoat_power.prototype.OnCreated(self, params)
	self.bonusAttackDamagePct = params.bonus_attack_damage_pct or 0
	self.bonusCritChancePct = params.bonus_crit_chance_pct or 0
	self:RefreshAttributes()
end
function modifier_item_0295_scapegoat_power.prototype.GetAttributeBonus(self)
	return { all_attack_damage_percent = self.bonusAttackDamagePct, crit_chance_pct = self.bonusCritChancePct }
end
function modifier_item_0295_scapegoat_power.prototype.IsHidden(self)
	return false
end
function modifier_item_0295_scapegoat_power.prototype.IsPurgable(self)
	return false
end
modifier_item_0295_scapegoat_power = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0295_scapegoat_power)
____exports.modifier_item_0295_scapegoat_power = modifier_item_0295_scapegoat_power
____exports.modifier_item_0295_scapegoat_invulnerable = __TS__Class()
local modifier_item_0295_scapegoat_invulnerable = ____exports.modifier_item_0295_scapegoat_invulnerable
modifier_item_0295_scapegoat_invulnerable.name = "modifier_item_0295_scapegoat_invulnerable"
__TS__ClassExtends(modifier_item_0295_scapegoat_invulnerable, BaseModifier_CS)
function modifier_item_0295_scapegoat_invulnerable.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
function modifier_item_0295_scapegoat_invulnerable.prototype.IsHidden(self)
	return false
end
function modifier_item_0295_scapegoat_invulnerable.prototype.IsPurgable(self)
	return false
end
function modifier_item_0295_scapegoat_invulnerable.prototype.GetEffectName(self)
	return ITEM_0295_INVULNERABLE_EFFECT
end
function modifier_item_0295_scapegoat_invulnerable.prototype.GetStatusEffectName(self)
	return ITEM_0295_INVULNERABLE_STATUS
end
function modifier_item_0295_scapegoat_invulnerable.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
modifier_item_0295_scapegoat_invulnerable =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0295_scapegoat_invulnerable)
____exports.modifier_item_0295_scapegoat_invulnerable = modifier_item_0295_scapegoat_invulnerable
return ____exports