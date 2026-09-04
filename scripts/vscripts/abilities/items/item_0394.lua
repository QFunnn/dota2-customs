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
____exports.item_0394 = __TS__Class()
local item_0394 = ____exports.item_0394
item_0394.name = "item_0394"
__TS__ClassExtends(item_0394, BaseItem_CS)
function item_0394.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0394_consecration.name
end
item_0394 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0394)
____exports.item_0394 = item_0394
____exports.modifier_item_0394_consecration = __TS__Class()
local modifier_item_0394_consecration = ____exports.modifier_item_0394_consecration
modifier_item_0394_consecration.name = "modifier_item_0394_consecration"
__TS__ClassExtends(modifier_item_0394_consecration, BaseModifier_CS)
function modifier_item_0394_consecration.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0394_consecration.prototype.IsHidden(self)
	return true
end
function modifier_item_0394_consecration.prototype.IsPurgable(self)
	return false
end
function modifier_item_0394_consecration.prototype.GetMutexKey(self)
	return "item_0569_mutex"
end
function modifier_item_0394_consecration.prototype.GetMutexPriority(self)
	return 200
end
function modifier_item_0394_consecration.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local attacker = event.ctx.spec.attacker
	if not ability or event.ctx.spec.victim ~= parent or not IsValidAlive(nil, attacker) then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ability_defer_pct = math.min(100, math.max(0, ability:GetSpecialValueFor("ability_value_defer_pct")))
	local ability_defer_duration = ability:GetSpecialValueFor("ability_value_defer_duration")
	if ability_defer_pct <= 0 or ability_defer_duration <= 0 then
		return
	end
	local ability_current_damage = self:GetCurrentPipeDamage(event.final)
	if ability_current_damage <= 0 then
		return
	end
	local ability_deferred_damage = ability_current_damage * (ability_defer_pct / 100)
	local ____event_final_0, ____mul_1 = event.final, "mul"
	if ____event_final_0[____mul_1] == nil then
		____event_final_0[____mul_1] = {}
	end
	local ____event_final_mul_2 = event.final.mul
	____event_final_mul_2[#____event_final_mul_2 + 1] =
		{ value = 1 - ability_defer_pct / 100, source = "item_0394:神圣化延迟" }
	MyGameDebuffStatus:AddDeBuffStatus(
		parent,
		attacker,
		ability,
		DebuffStatusType.BLEED,
		{ duration = ability_defer_duration, pool_damage = ability_deferred_damage, merge_by_ability = true }
	)
end
function modifier_item_0394_consecration.prototype.GetCurrentPipeDamage(self, final)
	local damage = final.base
	if final.add then
		for ____, value in ipairs(final.add) do
			damage = damage + value.value
		end
	end
	if final.mul then
		for ____, value in ipairs(final.mul) do
			damage = damage * value.value
		end
	end
	return math.max(0, damage)
end
modifier_item_0394_consecration = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0394_consecration)
____exports.modifier_item_0394_consecration = modifier_item_0394_consecration
return ____exports