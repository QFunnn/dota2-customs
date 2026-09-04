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
local ITEM_0374_THINK_INTERVAL = 0.5
local ITEM_0374_STILL_TOLERANCE = 8
____exports.item_0374 = __TS__Class()
local item_0374 = ____exports.item_0374
item_0374.name = "item_0374"
__TS__ClassExtends(item_0374, BaseItem_CS)
function item_0374.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0374_focus.name
end
item_0374 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0374)
____exports.item_0374 = item_0374
____exports.modifier_item_0374_focus = __TS__Class()
local modifier_item_0374_focus = ____exports.modifier_item_0374_focus
modifier_item_0374_focus.name = "modifier_item_0374_focus"
__TS__ClassExtends(modifier_item_0374_focus, BaseModifier_CS)
function modifier_item_0374_focus.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.lastX = 0
	self.lastY = 0
	self.stillTime = 0
end
function modifier_item_0374_focus.prototype.IsHidden(self)
	return true
end
function modifier_item_0374_focus.prototype.IsPurgable(self)
	return false
end
function modifier_item_0374_focus.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local pos = self:GetParent():GetAbsOrigin()
	self.lastX = pos.x
	self.lastY = pos.y
	self:StartIntervalThink(ITEM_0374_THINK_INTERVAL)
end
function modifier_item_0374_focus.prototype.OnIntervalThink(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		return
	end
	local pos = parent:GetAbsOrigin()
	local dx = pos.x - self.lastX
	local dy = pos.y - self.lastY
	local moved = dx * dx + dy * dy > ITEM_0374_STILL_TOLERANCE * ITEM_0374_STILL_TOLERANCE
	self.lastX = pos.x
	self.lastY = pos.y
	if moved or not IsValidAlive(nil, parent) then
		self.stillTime = 0
		local buff = parent:FindModifierByNameAndCaster(____exports.modifier_item_0374_focus_buff.name, parent)
		if buff then
			buff:Destroy()
		end
		return
	end
	self.stillTime = self.stillTime + ITEM_0374_THINK_INTERVAL
	local stillSeconds = math.max(0, ability:GetSpecialValueFor("ability_still_seconds"))
	if self.stillTime >= stillSeconds and not parent:HasModifier(____exports.modifier_item_0374_focus_buff.name) then
		____exports.modifier_item_0374_focus_buff:applys(parent, parent, ability, {})
	end
end
modifier_item_0374_focus = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0374_focus)
____exports.modifier_item_0374_focus = modifier_item_0374_focus
____exports.modifier_item_0374_focus_buff = __TS__Class()
local modifier_item_0374_focus_buff = ____exports.modifier_item_0374_focus_buff
modifier_item_0374_focus_buff.name = "modifier_item_0374_focus_buff"
__TS__ClassExtends(modifier_item_0374_focus_buff, BaseModifier_CS)
function modifier_item_0374_focus_buff.GetLocalizationCN(self)
	return { name = "凝神", description = "站立不动，全伤害提升。" }
end
function modifier_item_0374_focus_buff.prototype.IsHidden(self)
	return false
end
function modifier_item_0374_focus_buff.prototype.IsDebuff(self)
	return false
end
function modifier_item_0374_focus_buff.prototype.IsPurgable(self)
	return false
end
function modifier_item_0374_focus_buff.prototype.GetTexture(self)
	return "item_item_0374"
end
function modifier_item_0374_focus_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return {
		outgoing_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_damage_amp_pct")),
	}
end
modifier_item_0374_focus_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0374_focus_buff)
____exports.modifier_item_0374_focus_buff = modifier_item_0374_focus_buff
return ____exports