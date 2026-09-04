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
____exports.item_0382 = __TS__Class()
local item_0382 = ____exports.item_0382
item_0382.name = "item_0382"
__TS__ClassExtends(item_0382, BaseItem_CS)
function item_0382.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0382_chaos_poison.name
end
item_0382 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0382)
____exports.item_0382 = item_0382
--- 固有被动「乱毒」：施加任意负面状态时按概率为目标追加 1 层中毒。
____exports.modifier_item_0382_chaos_poison = __TS__Class()
local modifier_item_0382_chaos_poison = ____exports.modifier_item_0382_chaos_poison
modifier_item_0382_chaos_poison.name = "modifier_item_0382_chaos_poison"
__TS__ClassExtends(modifier_item_0382_chaos_poison, BaseModifier_CS)
function modifier_item_0382_chaos_poison.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.applyingChaosPoison = false
end
function modifier_item_0382_chaos_poison.GetLocalizationCN(self)
	return { name = "乱毒", description = "给目标添加任意负面状态时，有概率使其受到1层中毒。" }
end
function modifier_item_0382_chaos_poison.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEBUFF_STATUS_APPLY_QUERY }
end
function modifier_item_0382_chaos_poison.prototype.IsHidden(self)
	return true
end
function modifier_item_0382_chaos_poison.prototype.IsPurgable(self)
	return false
end
function modifier_item_0382_chaos_poison.prototype.OnDebuffStatusApplyQuery_CS(self, event)
	if not IsServer() then
		return
	end
	if self.applyingChaosPoison then
		return
	end
	local parent = self:GetParent()
	if event.caster ~= parent then
		return
	end
	if event.cancelled then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target == parent or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local rolledChance = ability:GetSpecialValueFor("ability_value_trigger_chance_pct")
	local ____math_max_2 = math.max
	local ____math_min_1 = math.min
	local ____temp_0
	if rolledChance > 0 then
		____temp_0 = rolledChance
	else
		____temp_0 = ability:GetSpecialValueFor("ability_trigger_chance_pct")
	end
	local chancePct = ____math_max_2(0, ____math_min_1(100, ____temp_0))
	if chancePct <= 0 or not RollPercentage(chancePct) then
		return
	end
	self.applyingChaosPoison = true
	AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.POISON, { stack = 1 })
	self.applyingChaosPoison = false
end
modifier_item_0382_chaos_poison = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0382_chaos_poison)
____exports.modifier_item_0382_chaos_poison = modifier_item_0382_chaos_poison
return ____exports