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
____exports.item_0219 = __TS__Class()
local item_0219 = ____exports.item_0219
item_0219.name = "item_0219"
__TS__ClassExtends(item_0219, BaseItem_CS)
function item_0219.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/item/item_mana.vpcf", context)
	PrecacheResource("particle", "particles/item/item_mana_magic.vpcf", context)
end
function item_0219.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0219_soul_scatter.name
end
item_0219 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0219)
____exports.item_0219 = item_0219
____exports.modifier_item_0219_soul_scatter = __TS__Class()
local modifier_item_0219_soul_scatter = ____exports.modifier_item_0219_soul_scatter
modifier_item_0219_soul_scatter.name = "modifier_item_0219_soul_scatter"
__TS__ClassExtends(modifier_item_0219_soul_scatter, BaseModifier_CS)
function modifier_item_0219_soul_scatter.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0219_soul_scatter.prototype.IsHidden(self)
	return true
end
function modifier_item_0219_soul_scatter.prototype.IsPurgable(self)
	return false
end
function modifier_item_0219_soul_scatter.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local currentMana = math.max(0, parent:GetMana())
	local maxMana = math.max(0, parent:GetMaxMana())
	if maxMana <= 0 then
		return
	end
	local manaPct = currentMana / maxMana * 100
	self:TrySpendManaForDamage(parent, target, ability, currentMana, manaPct)
	self:TryRestoreMana(parent, ability, manaPct)
end
function modifier_item_0219_soul_scatter.prototype.TrySpendManaForDamage(
	self,
	parent,
	target,
	ability,
	currentMana,
	manaPct
)
	local ability_mana_cost_threshold_pct = math.max(0, ability:GetSpecialValueFor("ability_mana_cost_threshold_pct"))
	if manaPct <= ability_mana_cost_threshold_pct then
		return
	end
	local ability_mana_cost_current_pct = math.max(0, ability:GetSpecialValueFor("ability_mana_cost_current_pct"))
	local manaCost = currentMana * (ability_mana_cost_current_pct / 100)
	if manaCost <= 0 then
		return
	end
	parent:SetMana(math.max(0, currentMana - manaCost))
	local ability_value_bonus_damage_multiplier =
		math.max(0, ability:GetSpecialValueFor("ability_value_bonus_damage_multiplier"))
	local damage = manaCost * ability_value_bonus_damage_multiplier
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = parent,
		damage = damage,
		damage_type = 2,
		ability = ability,
		extra_data = {
			damage_tags = DamageTag.NO_PROC,
			custom_tag = "item_0219_soul_scatter",
			source_name = ability:GetAbilityName(),
		},
	})
end
function modifier_item_0219_soul_scatter.prototype.TryRestoreMana(self, parent, ability, manaPct)
	local ability_mana_restore_threshold_pct =
		math.max(0, ability:GetSpecialValueFor("ability_mana_restore_threshold_pct"))
	if manaPct >= ability_mana_restore_threshold_pct then
		return
	end
	local ability_mana_restore = math.max(0, ability:GetSpecialValueFor("ability_value_mana_restore"))
	if ability_mana_restore <= 0 then
		return
	end
	parent:GiveMana(ability_mana_restore)
end
modifier_item_0219_soul_scatter = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0219_soul_scatter)
____exports.modifier_item_0219_soul_scatter = modifier_item_0219_soul_scatter
return ____exports