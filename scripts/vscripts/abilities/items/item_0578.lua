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
local ____modifier_generic_ignite = require("modifiers.debuff.modifier_generic_ignite")
local modifier_generic_ignite = ____modifier_generic_ignite.modifier_generic_ignite
local ____sixiang_set = require("shared.sixiang_set")
local CountSixiangItems = ____sixiang_set.CountSixiangItems
local POISON_EFFECT = "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf"
____exports.item_0578 = __TS__Class()
local item_0578 = ____exports.item_0578
item_0578.name = "item_0578"
__TS__ClassExtends(item_0578, BaseItem_CS)
function item_0578.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0578.name
end
item_0578 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0578)
____exports.item_0578 = item_0578
--- 固有监听：施加三系 DOT 时按套装件数概率，随机补一种目标缺失的 DOT。
____exports.modifier_item_0578 = __TS__Class()
local modifier_item_0578 = ____exports.modifier_item_0578
modifier_item_0578.name = "modifier_item_0578"
__TS__ClassExtends(modifier_item_0578, BaseModifier_CS)
function modifier_item_0578.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.applying = false
end
function modifier_item_0578.GetLocalizationCN(self)
	return {
		name = "万象之引",
		description = "施加持续伤害状态时，有概率随机为目标追加一种其尚未身负的持续伤害状态。",
	}
end
function modifier_item_0578.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEBUFF_STATUS_APPLY_QUERY }
end
function modifier_item_0578.prototype.IsHidden(self)
	return true
end
function modifier_item_0578.prototype.IsPurgable(self)
	return false
end
function modifier_item_0578.prototype.OnDebuffStatusApplyQuery_CS(self, event)
	if not IsServer() then
		return
	end
	if self.applying then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent then
		return
	end
	if
		event.status ~= DebuffStatusType.BLEED
		and event.status ~= DebuffStatusType.POISON
		and event.status ~= DebuffStatusType.BURN
	then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local isFullSet = CountSixiangItems(nil, parent) >= 2
	local chancePct = math.min(
		100,
		math.max(
			0,
			ability:GetSpecialValueFor(
				isFullSet and "ability_extra_dot_chance_pct_full" or "ability_extra_dot_chance_pct"
			)
		)
	)
	if chancePct <= 0 or not RollPercentage(chancePct) then
		return
	end
	local candidates = {}
	if event.status ~= DebuffStatusType.BLEED and not target:HasModifier("modifier_generic_bleed") then
		candidates[#candidates + 1] = "bleed"
	end
	if event.status ~= DebuffStatusType.POISON and not target:HasModifier("modifier_generic_poison") then
		candidates[#candidates + 1] = "poison"
	end
	if event.status ~= DebuffStatusType.BURN and not target:HasModifier("modifier_generic_burning") then
		candidates[#candidates + 1] = "burn"
	end
	if not target:HasModifier(modifier_generic_ignite.name) then
		candidates[#candidates + 1] = "ignite"
	end
	if #candidates == 0 then
		return
	end
	local picked = candidates[RandomInt(0, #candidates - 1) + 1]
	self.applying = true
	if picked == "bleed" then
		local attackDamage = math.max(0, MyGameAttribute:GetAttribute(parent, "total_attack_damage") or 0)
		AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.BLEED, { source_final_damage = attackDamage })
	elseif picked == "poison" then
		AddDeBuffStatus(
			nil,
			target,
			parent,
			ability,
			DebuffStatusType.POISON,
			{ stack = 1, effect_name = POISON_EFFECT }
		)
	elseif picked == "burn" then
		local burnDuration = math.max(0.5, ability:GetSpecialValueFor("ability_extra_burn_duration"))
		AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.BURN, { duration = burnDuration })
	else
		target:AddNewModifier(parent, ability, modifier_generic_ignite.name, { stack = 1 })
	end
	self.applying = false
end
modifier_item_0578 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0578)
____exports.modifier_item_0578 = modifier_item_0578
return ____exports