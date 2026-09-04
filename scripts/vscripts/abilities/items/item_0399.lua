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
____exports.item_0399 = __TS__Class()
local item_0399 = ____exports.item_0399
item_0399.name = "item_0399"
__TS__ClassExtends(item_0399, BaseItem_CS)
function item_0399.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0399_blood_blade.name
end
item_0399 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0399)
____exports.item_0399 = item_0399
--- 固有被动「血刃」：按当前物理吸血折算最终伤害加成（现算不缓存）。
____exports.modifier_item_0399_blood_blade = __TS__Class()
local modifier_item_0399_blood_blade = ____exports.modifier_item_0399_blood_blade
modifier_item_0399_blood_blade.name = "modifier_item_0399_blood_blade"
__TS__ClassExtends(modifier_item_0399_blood_blade, BaseModifier_CS)
function modifier_item_0399_blood_blade.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
	self:RefreshAttributes()
end
function modifier_item_0399_blood_blade.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(math.floor(self:CalcBonusDamagePct()))
	self:RefreshAttributes()
end
function modifier_item_0399_blood_blade.prototype.GetAttributeBonus(self)
	return { outgoing_damage_pct = self:CalcBonusDamagePct() }
end
function modifier_item_0399_blood_blade.prototype.CalcBonusDamagePct(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, parent) then
		return 0
	end
	local ability_lifesteal_step_pct = math.max(1, ability:GetSpecialValueFor("ability_lifesteal_step_pct"))
	local ability_value_damage_bonus_per_step_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_damage_bonus_per_step_pct"))
	local ability_value_damage_bonus_max_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_damage_bonus_max_pct"))
	local physical_lifesteal_pct = math.max(0, MyGameAttribute:GetAttribute(parent, "physical_lifesteal_pct") or 0)
	return math.min(
		ability_value_damage_bonus_max_pct,
		math.floor(physical_lifesteal_pct / ability_lifesteal_step_pct) * ability_value_damage_bonus_per_step_pct
	)
end
function modifier_item_0399_blood_blade.prototype.IsHidden(self)
	return true
end
function modifier_item_0399_blood_blade.prototype.IsPurgable(self)
	return false
end
modifier_item_0399_blood_blade = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0399_blood_blade)
____exports.modifier_item_0399_blood_blade = modifier_item_0399_blood_blade
return ____exports