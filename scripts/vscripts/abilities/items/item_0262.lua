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
____exports.item_0262 = __TS__Class()
local item_0262 = ____exports.item_0262
item_0262.name = "item_0262"
__TS__ClassExtends(item_0262, BaseItem_CS)
function item_0262.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0262_tracker.name
end
function item_0262.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_dash_distance = self:GetSpecialValueFor("ability_dash_distance")
	caster:KnockBack(caster, self, {
		duration = 0.15,
		block = true,
		direction = caster:GetForwardVector(),
		distance = ability_dash_distance,
		height = 175,
		stun = false,
	})
	caster:EmitSound("Hero_Zuus.Taunt.Jump")
end
item_0262 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0262)
____exports.item_0262 = item_0262
____exports.modifier_item_0262_tracker = __TS__Class()
local modifier_item_0262_tracker = ____exports.modifier_item_0262_tracker
modifier_item_0262_tracker.name = "modifier_item_0262_tracker"
__TS__ClassExtends(modifier_item_0262_tracker, BaseModifier_CS)
function modifier_item_0262_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEAL_DAMAGE }
end
function modifier_item_0262_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0262_tracker.prototype.OnDealDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if event.victim ~= parent then
		return
	end
	if (event.final_damage or 0) <= 0 and (event.shield_absorbed_value or 0) <= 0 then
		return
	end
	local attacker = event.attacker
	if not IsValid(nil, attacker) then
		return
	end
	local ____opt_0 = attacker.GetUnitType
	local unitType = ____opt_0 and ____opt_0(attacker)
	if
		unitType ~= UnitType.MONSTER_NORMAL
		and unitType ~= UnitType.MONSTER_ELITE
		and unitType ~= UnitType.MONSTER_MINIBOSS
		and unitType ~= UnitType.MONSTER_BOSS
		and unitType ~= UnitType.MONSTER_TRAP
	then
		return
	end
	local ability_damage_disable_window = ability:GetSpecialValueFor("ability_damage_disable_window")
	if ability_damage_disable_window <= 0 then
		return
	end
	local remaining = ability:GetCooldownTimeRemaining()
	if remaining >= ability_damage_disable_window then
		return
	end
	ability:StartCooldown(ability_damage_disable_window)
end
modifier_item_0262_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0262_tracker)
____exports.modifier_item_0262_tracker = modifier_item_0262_tracker
return ____exports