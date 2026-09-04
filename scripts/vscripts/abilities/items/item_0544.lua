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
local JUDGMENT_MODIFIER_NAME = "modifier_item_0544_judgment"
____exports.item_0544 = __TS__Class()
local item_0544 = ____exports.item_0544
item_0544.name = "item_0544"
__TS__ClassExtends(item_0544, BaseItem_CS)
function item_0544.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0544.name
end
item_0544 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0544)
____exports.item_0544 = item_0544
--- 持有者侧：攻击命中后按概率给敌人挂「天罚」debuff（刷新持续时间）。
____exports.modifier_item_0544 = __TS__Class()
local modifier_item_0544 = ____exports.modifier_item_0544
modifier_item_0544.name = "modifier_item_0544"
__TS__ClassExtends(modifier_item_0544, BaseModifier_CS)
function modifier_item_0544.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0544.prototype.IsHidden(self)
	return true
end
function modifier_item_0544.prototype.IsPurgable(self)
	return false
end
function modifier_item_0544.prototype.GetMutexKey(self)
	return "tian_fa_mutex"
end
function modifier_item_0544.prototype.GetMutexPriority(self)
	local ____opt_0 = self:GetAbility()
	return (____opt_0 and ____opt_0:GetAbilityName()) == "item_0544" and 200 or 100
end
function modifier_item_0544.prototype.OnTakeDamage_CS(self, event)
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
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
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
	local triggerChance = ability:GetSpecialValueFor("ability_value_trigger_chance_pct")
	if not RollPercentage(triggerChance) then
		return
	end
	local duration = math.max(0, ability:GetSpecialValueFor("ability_duration"))
	if duration <= 0 then
		return
	end
	victim:AddNewModifier(parent, ability, JUDGMENT_MODIFIER_NAME, { duration = duration })
end
modifier_item_0544 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0544)
____exports.modifier_item_0544 = modifier_item_0544
--- 敌人侧：「天罚」debuff——攻击力降低 + 完全禁疗。
____exports.modifier_item_0544_judgment = __TS__Class()
local modifier_item_0544_judgment = ____exports.modifier_item_0544_judgment
modifier_item_0544_judgment.name = "modifier_item_0544_judgment"
__TS__ClassExtends(modifier_item_0544_judgment, BaseModifier_CS)
function modifier_item_0544_judgment.GetLocalizationCN(self)
	return { name = "天罚", description = "攻击力降低，且无法受到任何治疗效果。" }
end
function modifier_item_0544_judgment.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_2
	if ability then
		____ability_2 = math.max(0, ability:GetSpecialValueFor("ability_value_atk_reduction_pct"))
	else
		____ability_2 = 0
	end
	local pct = ____ability_2
	return { all_attack_damage_percent = -pct, disable_heal = 1 }
end
function modifier_item_0544_judgment.prototype.IsHidden(self)
	return false
end
function modifier_item_0544_judgment.prototype.IsDebuff(self)
	return true
end
function modifier_item_0544_judgment.prototype.IsPurgable(self)
	return true
end
function modifier_item_0544_judgment.prototype.GetTexture(self)
	return "ancient_apparition_chilling_touch"
end
modifier_item_0544_judgment = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0544_judgment)
____exports.modifier_item_0544_judgment = modifier_item_0544_judgment
return ____exports