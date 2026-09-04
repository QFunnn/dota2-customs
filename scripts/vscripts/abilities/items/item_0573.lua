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
local ____tianping_set = require("shared.tianping_set")
local CountTianpingItems = ____tianping_set.CountTianpingItems
local TIANPING_ABSORBED_MANA_KEY = ____tianping_set.TIANPING_ABSORBED_MANA_KEY
____exports.item_0573 = __TS__Class()
local item_0573 = ____exports.item_0573
item_0573.name = "item_0573"
__TS__ClassExtends(item_0573, BaseItem_CS)
function item_0573.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0573.name
end
item_0573 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0573)
____exports.item_0573 = item_0573
--- 固有被动：受击回流时按比例改由魔法承担（打折 + 扣魔法），齐套时向均衡之右报账。
____exports.modifier_item_0573 = __TS__Class()
local modifier_item_0573 = ____exports.modifier_item_0573
modifier_item_0573.name = "modifier_item_0573"
__TS__ClassExtends(modifier_item_0573, BaseModifier_CS)
function modifier_item_0573.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0573.prototype.IsHidden(self)
	return true
end
function modifier_item_0573.prototype.IsPurgable(self)
	return false
end
function modifier_item_0573.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.victim ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local isFullSet = CountTianpingItems(nil, parent) >= 2
	local absorbPct = math.min(
		100,
		math.max(0, ability:GetSpecialValueFor(isFullSet and "ability_absorb_pct_full" or "ability_absorb_pct"))
	)
	if absorbPct <= 0 then
		return
	end
	local currentDamage = self:GetCurrentPipeDamage(event.final)
	if currentDamage <= 0 then
		return
	end
	local mana = math.max(0, parent:GetMana())
	local intended = currentDamage * (absorbPct / 100)
	local absorbed = math.min(intended, mana)
	if absorbed <= 0 then
		return
	end
	local ____event_final_0, ____mul_1 = event.final, "mul"
	if ____event_final_0[____mul_1] == nil then
		____event_final_0[____mul_1] = {}
	end
	local ____event_final_mul_2 = event.final.mul
	____event_final_mul_2[#____event_final_mul_2 + 1] =
		{ value = 1 - absorbed / currentDamage, source = "item_0573:均衡之左·魔法承伤" }
	parent:SetMana(mana - absorbed)
	if isFullSet then
		local acc = math.max(0, tonumber(parent:GetCustomValue(TIANPING_ABSORBED_MANA_KEY) or 0) or 0)
		parent:SetCustomValue(TIANPING_ABSORBED_MANA_KEY, acc + absorbed)
	end
end
function modifier_item_0573.prototype.GetCurrentPipeDamage(self, final)
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
modifier_item_0573 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0573)
____exports.modifier_item_0573 = modifier_item_0573
return ____exports