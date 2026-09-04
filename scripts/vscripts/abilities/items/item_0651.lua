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
local ____shadow_set = require("shared.shadow_set")
local CountShadowItems = ____shadow_set.CountShadowItems
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local SET_REFRESH_INTERVAL = 0.5
____exports.item_0651 = __TS__Class()
local item_0651 = ____exports.item_0651
item_0651.name = "item_0651"
__TS__ClassExtends(item_0651, BaseItem_CS)
function item_0651.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0651_shadow_resonance.name
end
item_0651 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0651)
____exports.item_0651 = item_0651
--- 被动「疾影共鸣」：按主装槽内【疾影】套件数提供攻速与移速（含本件，最多生效 3 件）。
____exports.modifier_item_0651_shadow_resonance = __TS__Class()
local modifier_item_0651_shadow_resonance = ____exports.modifier_item_0651_shadow_resonance
modifier_item_0651_shadow_resonance.name = "modifier_item_0651_shadow_resonance"
__TS__ClassExtends(modifier_item_0651_shadow_resonance, BaseModifier_CS)
function modifier_item_0651_shadow_resonance.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.attackSpeedPct = 0
	self.moveSpeedPct = 0
end
function modifier_item_0651_shadow_resonance.GetLocalizationCN(self)
	return {
		name = "疾影共鸣",
		description = "每件【疾影】套装备提高攻击速度与移动速度，最多生效3件（层数=当前生效件数）。",
	}
end
function modifier_item_0651_shadow_resonance.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:Recalculate()
	self:StartIntervalThink(SET_REFRESH_INTERVAL)
end
function modifier_item_0651_shadow_resonance.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:Recalculate()
end
function modifier_item_0651_shadow_resonance.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0651_shadow_resonance.prototype.GetAttributeBonus(self)
	return { attack_speed_pct = self.attackSpeedPct, bonus_movespeed_pct = self.moveSpeedPct }
end
function modifier_item_0651_shadow_resonance.prototype.Recalculate(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability or not IsValid(nil, ability) then
		return
	end
	local ability_set_item_count_max = 3
	local ability_shadow_item_count = math.min(CountShadowItems(nil, parent), ability_set_item_count_max)
	local ability_value_set_attack_speed_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_set_attack_speed_pct"))
	local ability_value_set_movespeed_pct = math.max(0, ability:GetSpecialValueFor("ability_value_set_movespeed_pct"))
	self.attackSpeedPct = ability_shadow_item_count * ability_value_set_attack_speed_pct
	self.moveSpeedPct = ability_shadow_item_count * ability_value_set_movespeed_pct
	self:SetStackCount(ability_shadow_item_count)
	self:RefreshAttributes()
end
function modifier_item_0651_shadow_resonance.prototype.IsHidden(self)
	return false
end
function modifier_item_0651_shadow_resonance.prototype.IsDebuff(self)
	return false
end
function modifier_item_0651_shadow_resonance.prototype.IsPurgable(self)
	return false
end
modifier_item_0651_shadow_resonance =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0651_shadow_resonance)
____exports.modifier_item_0651_shadow_resonance = modifier_item_0651_shadow_resonance
return ____exports