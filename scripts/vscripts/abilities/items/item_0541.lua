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
local RECALC_INTERVAL = 0.5
____exports.item_0541 = __TS__Class()
local item_0541 = ____exports.item_0541
item_0541.name = "item_0541"
__TS__ClassExtends(item_0541, BaseItem_CS)
function item_0541.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0541.name
end
item_0541 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0541)
____exports.item_0541 = item_0541
____exports.modifier_item_0541 = __TS__Class()
local modifier_item_0541 = ____exports.modifier_item_0541
modifier_item_0541.name = "modifier_item_0541"
__TS__ClassExtends(modifier_item_0541, BaseModifier_CS)
function modifier_item_0541.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedConvert = 0
end
function modifier_item_0541.GetLocalizationCN(self)
	return { name = "嬗变棱镜", description = "将物理伤害加成转化为魔法伤害加成。" }
end
function modifier_item_0541.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:Recalc(true)
	self:StartIntervalThink(RECALC_INTERVAL)
end
function modifier_item_0541.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0541.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:Recalc(false)
end
function modifier_item_0541.prototype.IsHidden(self)
	return true
end
function modifier_item_0541.prototype.IsPurgable(self)
	return false
end
function modifier_item_0541.prototype.GetAttributeBonus(self)
	local ____temp_0
	if self.cachedConvert > 0 then
		____temp_0 = self.cachedConvert
	else
		____temp_0 = 0
	end
	local c = ____temp_0
	if c <= 0 then
		return {}
	end
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_convert_pct = ability:GetSpecialValueFor("ability_value_convert_pct")
	return { physical_damage_add_pct = -c, magical_damage_add_pct = c * ability_convert_pct / 100 }
end
function modifier_item_0541.prototype.Recalc(self, force)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local total = MyGameAttribute:GetAttribute(parent, "physical_damage_add_pct") or 0
	local real = total + self.cachedConvert
	local newConvert = math.max(0, real)
	if not force and math.abs(newConvert - self.cachedConvert) < 0.01 then
		return
	end
	self.cachedConvert = newConvert
	local ____ = not force and self:RefreshAttributes()
end
modifier_item_0541 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0541)
____exports.modifier_item_0541 = modifier_item_0541
return ____exports