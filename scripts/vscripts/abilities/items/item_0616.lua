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
local ____item_0614 = require("abilities.items.item_0614")
local AddDebt = ____item_0614.AddDebt
local GetDebt = ____item_0614.GetDebt
____exports.item_0616 = __TS__Class()
local item_0616 = ____exports.item_0616
item_0616.name = "item_0616"
__TS__ClassExtends(item_0616, BaseItem_CS)
function item_0616.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0616.name
end
item_0616 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0616)
____exports.item_0616 = item_0616
--- 固有被动「赤字」：每秒自动欠 1 层债；按全家债层发放全域增伤。
____exports.modifier_item_0616 = __TS__Class()
local modifier_item_0616 = ____exports.modifier_item_0616
modifier_item_0616.name = "modifier_item_0616"
__TS__ClassExtends(modifier_item_0616, BaseModifier_CS)
function modifier_item_0616.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.grantOutgoing = 0
end
function modifier_item_0616.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function modifier_item_0616.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0616.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	AddDebt(nil, parent, ability, 1)
	local perDebt = math.max(0, ability:GetSpecialValueFor("ability_dmg_per_debt"))
	self.grantOutgoing = GetDebt(nil, parent) * perDebt
	self:RefreshAttributes()
end
function modifier_item_0616.prototype.GetAttributeBonus(self)
	return { outgoing_damage_pct = self.grantOutgoing }
end
function modifier_item_0616.prototype.IsHidden(self)
	return true
end
function modifier_item_0616.prototype.IsPurgable(self)
	return false
end
modifier_item_0616 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0616)
____exports.modifier_item_0616 = modifier_item_0616
return ____exports