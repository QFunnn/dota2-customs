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
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local WOUND_MODIFIER_NAME = "modifier_item_0532_mortal_wound"
____exports.item_0532 = __TS__Class()
local item_0532 = ____exports.item_0532
item_0532.name = "item_0532"
__TS__ClassExtends(item_0532, BaseItem_CS)
function item_0532.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0532.name
end
item_0532 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0532)
____exports.item_0532 = item_0532
--- 持有者侧：造成伤害时给敌人挂「重伤」debuff（刷新持续时间）。
____exports.modifier_item_0532 = __TS__Class()
local modifier_item_0532 = ____exports.modifier_item_0532
modifier_item_0532.name = "modifier_item_0532"
__TS__ClassExtends(modifier_item_0532, BaseModifier_CS)
function modifier_item_0532.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0532.prototype.IsHidden(self)
	return true
end
function modifier_item_0532.prototype.IsPurgable(self)
	return false
end
function modifier_item_0532.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	local victim = event.victim
	if not IsValidAlive(nil, parent) or not IsValidEnemyUnit(nil, parent, victim) then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	local duration = math.max(0, ability:GetSpecialValueFor("ability_duration"))
	if duration <= 0 then
		return
	end
	victim:AddNewModifier(parent, ability, WOUND_MODIFIER_NAME, { duration = duration })
end
modifier_item_0532 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0532)
____exports.modifier_item_0532 = modifier_item_0532
--- 敌人侧：「重伤」debuff——受到的恢复效果降低（regen_amp_pct 负值，HealManager 读取）。
____exports.modifier_item_0532_mortal_wound = __TS__Class()
local modifier_item_0532_mortal_wound = ____exports.modifier_item_0532_mortal_wound
modifier_item_0532_mortal_wound.name = "modifier_item_0532_mortal_wound"
__TS__ClassExtends(modifier_item_0532_mortal_wound, BaseModifier_CS)
function modifier_item_0532_mortal_wound.GetLocalizationCN(self)
	return { name = "重伤", description = "受到的治疗与恢复效果降低。" }
end
function modifier_item_0532_mortal_wound.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = math.min(100, math.max(0, ability:GetSpecialValueFor("ability_value_heal_reduction_pct")))
	else
		____ability_0 = 0
	end
	local pct = ____ability_0
	return { regen_amp_pct = -pct }
end
function modifier_item_0532_mortal_wound.prototype.IsHidden(self)
	return false
end
function modifier_item_0532_mortal_wound.prototype.IsDebuff(self)
	return true
end
function modifier_item_0532_mortal_wound.prototype.IsPurgable(self)
	return true
end
function modifier_item_0532_mortal_wound.prototype.GetTexture(self)
	return "item_desolator_2"
end
modifier_item_0532_mortal_wound = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0532_mortal_wound)
____exports.modifier_item_0532_mortal_wound = modifier_item_0532_mortal_wound
return ____exports