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
____exports.item_0261 = __TS__Class()
local item_0261 = ____exports.item_0261
item_0261.name = "item_0261"
__TS__ClassExtends(item_0261, BaseItem_CS)
function item_0261.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0261.name
end
item_0261 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0261)
____exports.item_0261 = item_0261
____exports.modifier_item_0261 = __TS__Class()
local modifier_item_0261 = ____exports.modifier_item_0261
modifier_item_0261.name = "modifier_item_0261"
__TS__ClassExtends(modifier_item_0261, BaseModifier_CS)
function modifier_item_0261.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0261.prototype.IsHidden(self)
	return true
end
function modifier_item_0261.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if event.ctx.spec.victim ~= parent then
		return
	end
	local attacker = event.ctx.spec.attacker
	if IsValid(nil, attacker) then
		local ____opt_0 = attacker.GetUnitType
		local unitType = ____opt_0 and ____opt_0(attacker)
		if unitType == UnitType.MONSTER_BOSS then
			return
		end
	end
	local ability_block_chance_pct = ability:GetSpecialValueFor("ability_block_chance_pct")
	local ability_block_damage = ability:GetSpecialValueFor("ability_block_damage")
	if not RollPercentage(ability_block_chance_pct) then
		return
	end
	local ____event_final_2, ____add_3 = event.final, "add"
	if ____event_final_2[____add_3] == nil then
		____event_final_2[____add_3] = {}
	end
	local ____event_final_add_4 = event.final.add
	____event_final_add_4[#____event_final_add_4 + 1] =
		{ value = -ability_block_damage, source = "item_0261:伤害格挡" }
	self:PlayEffects1(parent, ability_block_damage)
end
function modifier_item_0261.prototype.PlayEffects1(self, parent, blocked)
	Popups:damageBlock(parent, blocked)
end
modifier_item_0261 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0261)
____exports.modifier_item_0261 = modifier_item_0261
return ____exports