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
____exports.item_0534 = __TS__Class()
local item_0534 = ____exports.item_0534
item_0534.name = "item_0534"
__TS__ClassExtends(item_0534, BaseItem_CS)
function item_0534.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0534.name
end
item_0534 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0534)
____exports.item_0534 = item_0534
--- 固有被动「焚天纹章」：自身给敌人添加灼烧时，按配置概率为其叠加 1 层点燃。
____exports.modifier_item_0534 = __TS__Class()
local modifier_item_0534 = ____exports.modifier_item_0534
modifier_item_0534.name = "modifier_item_0534"
__TS__ClassExtends(modifier_item_0534, BaseModifier_CS)
function modifier_item_0534.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEBUFF_STATUS_APPLY_QUERY }
end
function modifier_item_0534.prototype.IsHidden(self)
	return true
end
function modifier_item_0534.prototype.IsPurgable(self)
	return false
end
function modifier_item_0534.prototype.GetMutexKey(self)
	return "fen_tian_mutex"
end
function modifier_item_0534.prototype.GetMutexPriority(self)
	local ____opt_0 = self:GetAbility()
	return (____opt_0 and ____opt_0:GetAbilityName()) == "item_0534" and 200 or 100
end
function modifier_item_0534.prototype.OnDebuffStatusApplyQuery_CS(self, event)
	if not IsServer() then
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
	if event.status ~= DebuffStatusType.BURN then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_ignite_trigger_chance_pct =
		math.max(0, math.min(100, ability:GetSpecialValueFor("ability_value_ignite_trigger_chance_pct")))
	if not RollPercentage(ability_ignite_trigger_chance_pct) then
		return
	end
	local ability_ignite_pct_per_stack = math.max(0, ability:GetSpecialValueFor("ability_value_ignite_pct_per_stack"))
	local ability_ignite_max_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_ignite_max_stacks")))
	local ability_ignite_duration = math.max(0.1, ability:GetSpecialValueFor("ability_ignite_duration"))
	local ability_use_all_stats = 1
	local existingIgnite = target:FindModifierByNameAndCaster(modifier_generic_ignite.name, parent)
	if existingIgnite and existingIgnite.AddExternalStacks then
		existingIgnite:AddExternalStacks({
			stack = 1,
			pct_per_stack = ability_ignite_pct_per_stack,
			max_stacks = ability_ignite_max_stacks,
			use_all_stats = ability_use_all_stats,
		})
		return
	end
	target:AddNewModifier(parent, ability, modifier_generic_ignite.name, {
		duration = ability_ignite_duration,
		stack = 1,
		pct_per_stack = ability_ignite_pct_per_stack,
		max_stacks = ability_ignite_max_stacks,
		use_all_stats = ability_use_all_stats,
	})
end
modifier_item_0534 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0534)
____exports.modifier_item_0534 = modifier_item_0534
return ____exports