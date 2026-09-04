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
____exports.item_0599 = __TS__Class()
local item_0599 = ____exports.item_0599
item_0599.name = "item_0599"
__TS__ClassExtends(item_0599, BaseItem_CS)
function item_0599.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0599.name
end
item_0599 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0599)
____exports.item_0599 = item_0599
--- 固有：闪避率溢出阈值的部分转化为全域增伤（层数=当前加成%）。
____exports.modifier_item_0599 = __TS__Class()
local modifier_item_0599 = ____exports.modifier_item_0599
modifier_item_0599.name = "modifier_item_0599"
__TS__ClassExtends(modifier_item_0599, BaseModifier_CS)
function modifier_item_0599.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.bonus = 0
end
function modifier_item_0599.GetLocalizationCN(self)
	return {
		name = "影舞",
		description = "闪避率超过阈值的部分转化为造成的伤害提高，当前加成见层数。",
	}
end
function modifier_item_0599.prototype.IsHidden(self)
	return false
end
function modifier_item_0599.prototype.IsDebuff(self)
	return false
end
function modifier_item_0599.prototype.IsPurgable(self)
	return false
end
function modifier_item_0599.prototype.GetMutexKey(self)
	return "ying_wu_mutex"
end
function modifier_item_0599.prototype.GetMutexPriority(self)
	local ____opt_0 = self:GetAbility()
	return (____opt_0 and ____opt_0:GetAbilityName()) == "item_0599" and 200 or 100
end
function modifier_item_0599.prototype.GetTexture(self)
	return "item_eternal_shroud"
end
function modifier_item_0599.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
	self:OnIntervalThink()
end
function modifier_item_0599.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local thRaw = ability:GetSpecialValueFor("ability_value_c_evasion_threshold_pct")
	local ____math_max_3 = math.max
	local ____temp_2
	if thRaw > 0 then
		____temp_2 = thRaw
	else
		____temp_2 = ability:GetSpecialValueFor("ability_c_evasion_threshold_pct")
	end
	local threshold = ____math_max_3(0, ____temp_2)
	local perRaw = ability:GetSpecialValueFor("ability_value_dmg_per_evasion_pct")
	local ____math_max_5 = math.max
	local ____temp_4
	if perRaw > 0 then
		____temp_4 = perRaw
	else
		____temp_4 = ability:GetSpecialValueFor("ability_dmg_per_evasion_pct")
	end
	local per = ____math_max_5(0, ____temp_4)
	local evasion = math.max(0, MyGameAttribute:GetAttribute(parent, "evasion_pct") or 0)
	local overflow = math.max(0, evasion - threshold)
	self.bonus = overflow * per
	self:SetStackCount(math.floor(self.bonus))
	self:RefreshAttributes()
end
function modifier_item_0599.prototype.GetAttributeBonus(self)
	if self.bonus <= 0 then
		return {}
	end
	return { outgoing_damage_pct = self.bonus }
end
modifier_item_0599 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0599)
____exports.modifier_item_0599 = modifier_item_0599
return ____exports