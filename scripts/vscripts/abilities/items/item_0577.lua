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
local ____zushi_set = require("shared.zushi_set")
local CountZushiItems = ____zushi_set.CountZushiItems
____exports.item_0577 = __TS__Class()
local item_0577 = ____exports.item_0577
item_0577.name = "item_0577"
__TS__ClassExtends(item_0577, BaseItem_CS)
function item_0577.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0577.name
end
item_0577 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0577)
____exports.item_0577 = item_0577
--- 固有监听：自己的 DOT 每次结算 → 概率给自己叠 1 层蚀魂诅咒。
____exports.modifier_item_0577 = __TS__Class()
local modifier_item_0577 = ____exports.modifier_item_0577
modifier_item_0577.name = "modifier_item_0577"
__TS__ClassExtends(modifier_item_0577, BaseModifier_CS)
function modifier_item_0577.GetLocalizationCN(self)
	return {
		name = "蚀魂之典",
		description = "你的持续伤害结算时，有概率使自己陷入一层蚀魂诅咒。",
	}
end
function modifier_item_0577.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_HP_LOSS, target = { scope = "global" } } }
end
function modifier_item_0577.prototype.IsHidden(self)
	return true
end
function modifier_item_0577.prototype.IsPurgable(self)
	return false
end
function modifier_item_0577.prototype.OnHpLoss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local victim = event.victim
	if not victim or victim == parent or not IsValidAlive(nil, victim) then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local source = event.source
	local isDotDamage = (source and source.debuff_status) == DebuffStatusType.BLEED
		or (source and source.debuff_status) == DebuffStatusType.POISON
		or (source and source.debuff_status) == DebuffStatusType.BURN
		or CheckTag(nil, source and source.damage_tags, DamageTag.DOT)
	if not isDotDamage then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local chancePct = math.min(100, math.max(0, ability:GetSpecialValueFor("ability_curse_chance_pct")))
	if chancePct <= 0 or not RollPercentage(chancePct) then
		return
	end
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0577_curse.name, {})
end
modifier_item_0577 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0577)
____exports.modifier_item_0577 = modifier_item_0577
--- 【蚀魂】小诅咒（挂自己·真 debuff·喂诅咒生态）：每层降移速；诅蚀二件套时每层加技能伤害。
____exports.modifier_item_0577_curse = __TS__Class()
local modifier_item_0577_curse = ____exports.modifier_item_0577_curse
modifier_item_0577_curse.name = "modifier_item_0577_curse"
__TS__ClassExtends(modifier_item_0577_curse, BaseModifier_CS)
function modifier_item_0577_curse.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.movespeedPctPerStack = 1
	self.spellAmpPerStack = 2
	self.maxStacks = 10
end
function modifier_item_0577_curse.GetLocalizationCN(self)
	return {
		name = "蚀魂",
		description = "移动速度降低；若穿戴诅蚀二件套，每层同时提高技能伤害。",
	}
end
function modifier_item_0577_curse.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:SetStackCount(1)
	self:RefreshAttributes()
end
function modifier_item_0577_curse.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:SetStackCount(math.min(self.maxStacks, self:GetStackCount() + 1))
	self:RefreshAttributes()
end
function modifier_item_0577_curse.prototype.RefreshConfig(self)
	local ability = self:GetAbility()
	local ____ability_8
	if ability then
		____ability_8 = math.max(0, ability:GetSpecialValueFor("ability_movespeed_pct_per_stack"))
	else
		____ability_8 = 1
	end
	self.movespeedPctPerStack = ____ability_8
	local ____ability_9
	if ability then
		____ability_9 = math.max(0, ability:GetSpecialValueFor("ability_spell_amp_per_stack"))
	else
		____ability_9 = 2
	end
	self.spellAmpPerStack = ____ability_9
	local ____ability_10
	if ability then
		____ability_10 = math.max(1, math.floor(ability:GetSpecialValueFor("ability_curse_max_stacks")))
	else
		____ability_10 = 10
	end
	self.maxStacks = ____ability_10
	local ____ability_11
	if ability then
		____ability_11 = math.max(1, ability:GetSpecialValueFor("ability_curse_duration"))
	else
		____ability_11 = 8
	end
	local duration = ____ability_11
	self:SetDuration(duration, true)
end
function modifier_item_0577_curse.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local stacks = self:GetStackCount()
	if not IsValid(nil, parent) or stacks <= 0 then
		return {}
	end
	local bonus = { bonus_movespeed_pct = -self.movespeedPctPerStack * stacks }
	if CountZushiItems(nil, parent) >= 2 then
		bonus.spell_amplify_pct = self.spellAmpPerStack * stacks
	end
	return bonus
end
function modifier_item_0577_curse.prototype.IsHidden(self)
	return false
end
function modifier_item_0577_curse.prototype.IsDebuff(self)
	return true
end
function modifier_item_0577_curse.prototype.IsPurgable(self)
	return false
end
function modifier_item_0577_curse.prototype.GetTexture(self)
	return "item_shadow_amulet"
end
modifier_item_0577_curse = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0577_curse)
____exports.modifier_item_0577_curse = modifier_item_0577_curse
return ____exports