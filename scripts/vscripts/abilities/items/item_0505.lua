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
____exports.item_0505 = __TS__Class()
local item_0505 = ____exports.item_0505
item_0505.name = "item_0505"
__TS__ClassExtends(item_0505, BaseItem_CS)
function item_0505.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0505_shadow_wisdom_tracker.name
end
item_0505 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0505)
____exports.item_0505 = item_0505
--- 隐藏的侦测 modifier：在“本持有者造成法术暴击”时给自己叠一层「贤识」。
____exports.modifier_item_0505_shadow_wisdom_tracker = __TS__Class()
local modifier_item_0505_shadow_wisdom_tracker = ____exports.modifier_item_0505_shadow_wisdom_tracker
modifier_item_0505_shadow_wisdom_tracker.name = "modifier_item_0505_shadow_wisdom_tracker"
__TS__ClassExtends(modifier_item_0505_shadow_wisdom_tracker, BaseModifier_CS)
function modifier_item_0505_shadow_wisdom_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0505_shadow_wisdom_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0505_shadow_wisdom_tracker.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_base_attack then
		return
	end
	if event.damage_type ~= 2 then
		return
	end
	if event.is_crit ~= true then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0505_shadow_wisdom.name, {})
end
modifier_item_0505_shadow_wisdom_tracker =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0505_shadow_wisdom_tracker)
____exports.modifier_item_0505_shadow_wisdom_tracker = modifier_item_0505_shadow_wisdom_tracker
--- 「贤识」叠层 buff：每层提供技能伤害加成（spell_amplify_pct），并随时间逐层流逝。
____exports.modifier_item_0505_shadow_wisdom = __TS__Class()
local modifier_item_0505_shadow_wisdom = ____exports.modifier_item_0505_shadow_wisdom
modifier_item_0505_shadow_wisdom.name = "modifier_item_0505_shadow_wisdom"
__TS__ClassExtends(modifier_item_0505_shadow_wisdom, BaseModifier_CS)
function modifier_item_0505_shadow_wisdom.GetLocalizationCN(self)
	return {
		name = "贤识",
		description = "魔法暴击时获得，每层 +1% 技能伤害，最多 30 层，每秒流逝 1 层。",
	}
end
function modifier_item_0505_shadow_wisdom.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
	self:StartDecay()
end
function modifier_item_0505_shadow_wisdom.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local rolledMaxStacks = ability:GetSpecialValueFor("ability_value_max_stacks")
	local ____math_max_2 = math.max
	local ____math_floor_1 = math.floor
	local ____temp_0
	if rolledMaxStacks > 0 then
		____temp_0 = rolledMaxStacks
	else
		____temp_0 = ability:GetSpecialValueFor("ability_max_stacks")
	end
	local ability_max_stacks = ____math_max_2(1, ____math_floor_1(____temp_0))
	self:SetStackCount(math.min(self:GetStackCount() + 1, ability_max_stacks))
	self:RefreshAttributes()
end
function modifier_item_0505_shadow_wisdom.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local nextStacks = self:GetStackCount() - 1
	if nextStacks <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
function modifier_item_0505_shadow_wisdom.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0505_shadow_wisdom.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local ability_value_spell_amplify_pct_per_stack =
		math.max(0, ability:GetSpecialValueFor("ability_value_spell_amplify_pct_per_stack"))
	return { spell_amplify_pct = self:GetStackCount() * ability_value_spell_amplify_pct_per_stack }
end
function modifier_item_0505_shadow_wisdom.prototype.IsHidden(self)
	return false
end
function modifier_item_0505_shadow_wisdom.prototype.IsDebuff(self)
	return false
end
function modifier_item_0505_shadow_wisdom.prototype.IsPurgable(self)
	return false
end
function modifier_item_0505_shadow_wisdom.prototype.GetTexture(self)
	return "item_icon_m18__17"
end
function modifier_item_0505_shadow_wisdom.prototype.StartDecay(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local ability_stack_decay_interval = math.max(0.1, ability:GetSpecialValueFor("ability_stack_decay_interval"))
	self:StartIntervalThink(ability_stack_decay_interval)
end
modifier_item_0505_shadow_wisdom = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0505_shadow_wisdom)
____exports.modifier_item_0505_shadow_wisdom = modifier_item_0505_shadow_wisdom
return ____exports