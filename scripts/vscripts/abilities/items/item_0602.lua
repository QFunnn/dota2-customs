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
local IsRealNonItemAbility = ____item_0409_shared.IsRealNonItemAbility
____exports.item_0602 = __TS__Class()
local item_0602 = ____exports.item_0602
item_0602.name = "item_0602"
__TS__ClassExtends(item_0602, BaseItem_CS)
function item_0602.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0602.name
end
item_0602 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0602)
____exports.item_0602 = item_0602
--- 固有被动：真实施法时按魔法值状态给自己叠对应态的层（不带 duration·衰减交给 buff tick）。
____exports.modifier_item_0602 = __TS__Class()
local modifier_item_0602 = ____exports.modifier_item_0602
modifier_item_0602.name = "modifier_item_0602"
__TS__ClassExtends(modifier_item_0602, BaseModifier_CS)
function modifier_item_0602.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0602.prototype.IsHidden(self)
	return true
end
function modifier_item_0602.prototype.IsPurgable(self)
	return false
end
function modifier_item_0602.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or event.caster ~= parent:GetEntityIndex() then
		return
	end
	if event.is_trigger == true then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not IsRealNonItemAbility(nil, castAbility) then
		return
	end
	local threshold = ability:GetSpecialValueFor("ability_mana_threshold_pct")
	local manaPct = parent:GetMana() / math.max(1, parent:GetMaxMana()) * 100
	local ____temp_0
	if manaPct > threshold then
		____temp_0 = ____exports.modifier_item_0602_surge.name
	else
		____temp_0 = ____exports.modifier_item_0602_distill.name
	end
	local buffName = ____temp_0
	parent:AddNewModifier(parent, ability, buffName, {})
end
modifier_item_0602 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0602)
____exports.modifier_item_0602 = modifier_item_0602
--- 【倾泻】盈态：每层增加法力消耗与技能伤害；每 decay_interval 秒流逝 1 层。
____exports.modifier_item_0602_surge = __TS__Class()
local modifier_item_0602_surge = ____exports.modifier_item_0602_surge
modifier_item_0602_surge.name = "modifier_item_0602_surge"
__TS__ClassExtends(modifier_item_0602_surge, BaseModifier_CS)
function modifier_item_0602_surge.GetLocalizationCN(self)
	return {
		name = "倾泻",
		description = "每层增加法力消耗与技能伤害；每隔一段时间流逝一层。",
	}
end
function modifier_item_0602_surge.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
	local ability = self:GetAbility()
	local ____temp_1
	if ability and IsValid(nil, ability) then
		____temp_1 = math.max(0.1, ability:GetSpecialValueFor("ability_decay_interval"))
	else
		____temp_1 = 2
	end
	local interval = ____temp_1
	self:StartIntervalThink(interval)
end
function modifier_item_0602_surge.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:AddOneStack()
end
function modifier_item_0602_surge.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local next = self:GetStackCount() - 1
	if next <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(next)
	self:RefreshAttributes()
	self:RefreshTagRules()
end
function modifier_item_0602_surge.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	return {
		spell_amplify_pct = self:GetStackCount() * math.max(0, ability:GetSpecialValueFor("ability_surge_spell_amp")),
	}
end
function modifier_item_0602_surge.prototype.GetTagModifierRules(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local perStackPct = math.max(0, ability:GetSpecialValueFor("ability_surge_manacost_pct"))
	local totalPct = self:GetStackCount() * perStackPct
	if totalPct <= 0 then
		return {}
	end
	return { { id = "item_0602_surge_mana_cost_up", statKey = 6, op = 1, value = totalPct } }
end
function modifier_item_0602_surge.prototype.IsHidden(self)
	return false
end
function modifier_item_0602_surge.prototype.IsDebuff(self)
	return false
end
function modifier_item_0602_surge.prototype.IsPurgable(self)
	return false
end
function modifier_item_0602_surge.prototype.GetTexture(self)
	return "item_arcane_ring"
end
function modifier_item_0602_surge.prototype.AddOneStack(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local maxStacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_max_stacks")))
	self:SetStackCount(math.min(self:GetStackCount() + 1, maxStacks))
	self:RefreshAttributes()
end
modifier_item_0602_surge = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0602_surge)
____exports.modifier_item_0602_surge = modifier_item_0602_surge
--- 【蒸馏】枯态：每层增加魔法恢复、减少技能伤害；每 decay_interval 秒流逝 1 层。
____exports.modifier_item_0602_distill = __TS__Class()
local modifier_item_0602_distill = ____exports.modifier_item_0602_distill
modifier_item_0602_distill.name = "modifier_item_0602_distill"
__TS__ClassExtends(modifier_item_0602_distill, BaseModifier_CS)
function modifier_item_0602_distill.GetLocalizationCN(self)
	return {
		name = "蒸馏",
		description = "每层增加魔法恢复，但减少技能伤害；每隔一段时间流逝一层。",
	}
end
function modifier_item_0602_distill.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
	local ability = self:GetAbility()
	local ____temp_2
	if ability and IsValid(nil, ability) then
		____temp_2 = math.max(0.1, ability:GetSpecialValueFor("ability_decay_interval"))
	else
		____temp_2 = 2
	end
	local interval = ____temp_2
	self:StartIntervalThink(interval)
end
function modifier_item_0602_distill.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:AddOneStack()
end
function modifier_item_0602_distill.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local next = self:GetStackCount() - 1
	if next <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(next)
	self:RefreshAttributes()
end
function modifier_item_0602_distill.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local stacks = self:GetStackCount()
	return {
		mana_regen_pct = stacks * math.max(0, ability:GetSpecialValueFor("ability_distill_regen_pct")),
		spell_amplify_pct = -(stacks * math.max(0, ability:GetSpecialValueFor("ability_distill_spell_reduce"))),
	}
end
function modifier_item_0602_distill.prototype.IsHidden(self)
	return false
end
function modifier_item_0602_distill.prototype.IsDebuff(self)
	return false
end
function modifier_item_0602_distill.prototype.IsPurgable(self)
	return false
end
function modifier_item_0602_distill.prototype.GetTexture(self)
	return "item_clarity"
end
function modifier_item_0602_distill.prototype.AddOneStack(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local maxStacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_max_stacks")))
	self:SetStackCount(math.min(self:GetStackCount() + 1, maxStacks))
	self:RefreshAttributes()
end
modifier_item_0602_distill = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0602_distill)
____exports.modifier_item_0602_distill = modifier_item_0602_distill
return ____exports