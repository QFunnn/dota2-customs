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
____exports.item_0609 = __TS__Class()
local item_0609 = ____exports.item_0609
item_0609.name = "item_0609"
__TS__ClassExtends(item_0609, BaseItem_CS)
function item_0609.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0609.name
end
item_0609 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0609)
____exports.item_0609 = item_0609
--- 固有：裸生命上限的 90% 平添削减，按削减量 180% 发放护盾上限。
____exports.modifier_item_0609 = __TS__Class()
local modifier_item_0609 = ____exports.modifier_item_0609
modifier_item_0609.name = "modifier_item_0609"
__TS__ClassExtends(modifier_item_0609, BaseModifier_CS)
function modifier_item_0609.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedHealthGrant = 0
	self.cachedShieldGrant = 0
end
function modifier_item_0609.GetLocalizationCN(self)
	return {
		name = "混沌之契",
		description = "生命值上限的大部分被契约夺走，化作等价放大的护盾值上限。",
	}
end
function modifier_item_0609.prototype.IsDebuff(self)
	return true
end
function modifier_item_0609.prototype.IsPurgable(self)
	return false
end
function modifier_item_0609.prototype.GetMutexKey(self)
	return "item_0609_mutex"
end
function modifier_item_0609.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0609" and 200 or 100
end
function modifier_item_0609.prototype.GetTexture(self)
	return "item_hood_of_defiance"
end
function modifier_item_0609.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
	self:OnIntervalThink()
end
function modifier_item_0609.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local rolledCut = ability:GetSpecialValueFor("ability_value_health_cut_pct")
	local ____math_max_2 = math.max
	local ____math_min_1 = math.min
	local ____temp_0
	if rolledCut > 0 then
		____temp_0 = rolledCut
	else
		____temp_0 = ability:GetSpecialValueFor("ability_health_cut_pct")
	end
	local cutPct = ____math_max_2(0, ____math_min_1(99, ____temp_0))
	local rolledConvert = ability:GetSpecialValueFor("ability_value_shield_convert_pct")
	local ____math_max_4 = math.max
	local ____temp_3
	if rolledConvert > 0 then
		____temp_3 = rolledConvert
	else
		____temp_3 = ability:GetSpecialValueFor("ability_shield_convert_pct")
	end
	local convertPct = ____math_max_4(0, ____temp_3)
	local rawMax = math.max(1, parent:GetMaxHealth() - self.cachedHealthGrant)
	local cut = math.floor(rawMax * cutPct / 100)
	local shield = math.floor(cut * convertPct / 100)
	if math.abs(-cut - self.cachedHealthGrant) >= 1 or math.abs(shield - self.cachedShieldGrant) >= 1 then
		self.cachedHealthGrant = -cut
		self.cachedShieldGrant = shield
	end
	self:RefreshAttributes()
end
function modifier_item_0609.prototype.GetAttributeBonus(self)
	if self.cachedHealthGrant == 0 and self.cachedShieldGrant == 0 then
		return {}
	end
	return { bonus_health = self.cachedHealthGrant, base_energy_shield = self.cachedShieldGrant }
end
modifier_item_0609 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0609)
____exports.modifier_item_0609 = modifier_item_0609
return ____exports