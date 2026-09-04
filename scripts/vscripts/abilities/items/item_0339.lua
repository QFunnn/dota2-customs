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
local ITEM_0339_STACK_DECAY_INTERVAL = 2
____exports.item_0339 = __TS__Class()
local item_0339 = ____exports.item_0339
item_0339.name = "item_0339"
__TS__ClassExtends(item_0339, BaseItem_CS)
function item_0339.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0339_tracker.name
end
item_0339 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0339)
____exports.item_0339 = item_0339
____exports.modifier_item_0339_tracker = __TS__Class()
local modifier_item_0339_tracker = ____exports.modifier_item_0339_tracker
modifier_item_0339_tracker.name = "modifier_item_0339_tracker"
__TS__ClassExtends(modifier_item_0339_tracker, BaseModifier_CS)
function modifier_item_0339_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0339_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0339_tracker.prototype.IsPurgable(self)
	return false
end
function modifier_item_0339_tracker.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	local ____opt_0 = castAbility.IsItem
	if ____opt_0 and ____opt_0(castAbility) then
		return
	end
	local ____opt_2 = castAbility.IsToggle
	if ____opt_2 and ____opt_2(castAbility) then
		return
	end
	if castAbility:GetAbilityName() == ability:GetAbilityName() then
		return
	end
	____exports.modifier_item_0339_secret:applys(parent, parent, ability)
end
modifier_item_0339_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0339_tracker)
____exports.modifier_item_0339_tracker = modifier_item_0339_tracker
____exports.modifier_item_0339_secret = __TS__Class()
local modifier_item_0339_secret = ____exports.modifier_item_0339_secret
modifier_item_0339_secret.name = "modifier_item_0339_secret"
__TS__ClassExtends(modifier_item_0339_secret, BaseModifier_CS)
function modifier_item_0339_secret.GetLocalizationCN(self)
	return { name = "隐秘", description = "释放技能时获得生命值和魔法值，层数会随时间流逝。" }
end
function modifier_item_0339_secret.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
	self:StartDecay()
end
function modifier_item_0339_secret.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local maxStacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_max_stacks")))
	local nextStacks = math.min(self:GetStackCount() + 1, maxStacks)
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
function modifier_item_0339_secret.prototype.OnIntervalThink(self)
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
function modifier_item_0339_secret.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0339_secret.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local bonusHealth = math.max(0, ability:GetSpecialValueFor("ability_value_bonus_health"))
	local stacks = math.max(0, self:GetStackCount())
	if bonusHealth <= 0 or stacks <= 0 then
		return {}
	end
	return {
		bonus_health = bonusHealth * stacks,
		bonus_mana = ability:GetSpecialValueFor("ability_value_bonus_mana") * stacks,
	}
end
function modifier_item_0339_secret.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0339_secret.prototype.IsDebuff(self)
	return false
end
function modifier_item_0339_secret.prototype.IsPurgable(self)
	return false
end
function modifier_item_0339_secret.prototype.GetTexture(self)
	return "item_icon_18"
end
function modifier_item_0339_secret.prototype.StartDecay(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	self:StartIntervalThink(ITEM_0339_STACK_DECAY_INTERVAL)
end
modifier_item_0339_secret = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0339_secret)
____exports.modifier_item_0339_secret = modifier_item_0339_secret
return ____exports