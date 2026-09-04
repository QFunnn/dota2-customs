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
____exports.item_0271 = __TS__Class()
local item_0271 = ____exports.item_0271
item_0271.name = "item_0271"
__TS__ClassExtends(item_0271, BaseItem_CS)
function item_0271.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0271_tracker.name
end
item_0271 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0271)
____exports.item_0271 = item_0271
____exports.modifier_item_0271_tracker = __TS__Class()
local modifier_item_0271_tracker = ____exports.modifier_item_0271_tracker
modifier_item_0271_tracker.name = "modifier_item_0271_tracker"
__TS__ClassExtends(modifier_item_0271_tracker, BaseModifier_CS)
function modifier_item_0271_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0271_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0271_tracker.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if event.is_base_attack then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_stack_duration = ability:GetSpecialValue("item_0271", "ability_stack_duration")
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0271_psionic_surge.name,
		{ duration = ability_stack_duration }
	)
end
modifier_item_0271_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0271_tracker)
____exports.modifier_item_0271_tracker = modifier_item_0271_tracker
____exports.modifier_item_0271_psionic_surge = __TS__Class()
local modifier_item_0271_psionic_surge = ____exports.modifier_item_0271_psionic_surge
modifier_item_0271_psionic_surge.name = "modifier_item_0271_psionic_surge"
__TS__ClassExtends(modifier_item_0271_psionic_surge, BaseModifier_CS)
function modifier_item_0271_psionic_surge.GetLocalizationCN(self)
	return { name = "灵能回涌", description = "冷却缩减提升。" }
end
function modifier_item_0271_psionic_surge.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
end
function modifier_item_0271_psionic_surge.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_max_stacks = ability:GetSpecialValue("item_0271", "ability_max_stacks")
	local nextStacks = math.min(self:GetStackCount() + 1, ability_max_stacks)
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
function modifier_item_0271_psionic_surge.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_cdr_pct_per_stack = ability:GetSpecialValue("item_0271", "ability_cdr_pct_per_stack")
	return { cooldown_reduction_pct = self:GetStackCount() * ability_cdr_pct_per_stack }
end
function modifier_item_0271_psionic_surge.prototype.IsHidden(self)
	return false
end
function modifier_item_0271_psionic_surge.prototype.IsDebuff(self)
	return false
end
function modifier_item_0271_psionic_surge.prototype.IsPurgable(self)
	return false
end
function modifier_item_0271_psionic_surge.prototype.GetTexture(self)
	return "item_psychic_headband"
end
modifier_item_0271_psionic_surge = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0271_psionic_surge)
____exports.modifier_item_0271_psionic_surge = modifier_item_0271_psionic_surge
return ____exports