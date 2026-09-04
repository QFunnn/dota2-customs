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
____exports.item_0550 = __TS__Class()
local item_0550 = ____exports.item_0550
item_0550.name = "item_0550"
__TS__ClassExtends(item_0550, BaseItem_CS)
function item_0550.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0550.name
end
item_0550 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0550)
____exports.item_0550 = item_0550
____exports.modifier_item_0550 = __TS__Class()
local modifier_item_0550 = ____exports.modifier_item_0550
modifier_item_0550.name = "modifier_item_0550"
__TS__ClassExtends(modifier_item_0550, BaseModifier_CS)
function modifier_item_0550.GetLocalizationCN(self)
	return {
		name = "背水之怒",
		description = "每损失1%生命值，造成的最终伤害提高1%，增幅具有上限。",
	}
end
function modifier_item_0550.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0550.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.2)
end
function modifier_item_0550.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0550.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0550.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_burn_trigger_chance_pct = ability:GetSpecialValueFor("ability_value_burn_trigger_chance_pct")
	if ability_burn_trigger_chance_pct <= 0 or not RollPercentage(ability_burn_trigger_chance_pct) then
		return
	end
	local ability_burn_duration = ability:GetSpecialValueFor("ability_burn_duration")
	AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.BURN, { duration = ability_burn_duration })
	local ability_level = math.max(0, ability:GetLevel() - 1)
	ability:StartCooldown(ability:GetCooldown(ability_level))
end
function modifier_item_0550.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return {}
	end
	local maxHealth = math.max(1, parent:GetMaxHealth())
	local currentHealth = math.max(0, parent:GetHealth())
	local ability_lost_health_pct = math.max(0, 100 - currentHealth / maxHealth * 100)
	local ability_value_damage_bonus_max_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_damage_bonus_max_pct"))
	local ability_damage_bonus_pct = math.min(math.floor(ability_lost_health_pct), ability_value_damage_bonus_max_pct)
	if ability_damage_bonus_pct <= 0 then
		return {}
	end
	return { outgoing_damage_pct_2 = ability_damage_bonus_pct }
end
function modifier_item_0550.prototype.IsHidden(self)
	return false
end
function modifier_item_0550.prototype.IsDebuff(self)
	return false
end
function modifier_item_0550.prototype.IsPurgable(self)
	return false
end
modifier_item_0550 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0550)
____exports.modifier_item_0550 = modifier_item_0550
return ____exports