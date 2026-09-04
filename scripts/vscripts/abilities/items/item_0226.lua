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
____exports.item_0226 = __TS__Class()
local item_0226 = ____exports.item_0226
item_0226.name = "item_0226"
__TS__ClassExtends(item_0226, BaseItem_CS)
function item_0226.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0226.name
end
item_0226 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0226)
____exports.item_0226 = item_0226
____exports.modifier_item_0226 = __TS__Class()
local modifier_item_0226 = ____exports.modifier_item_0226
modifier_item_0226.name = "modifier_item_0226"
__TS__ClassExtends(modifier_item_0226, BaseModifier_CS)
function modifier_item_0226.prototype.IsHidden(self)
	return true
end
function modifier_item_0226.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_item_0226.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	local parent = self:GetParent()
	local attacker = event.attacker
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not IsValidAlive(nil, attacker) or attacker:IsBuilding() then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local damage = ability:GetSpecialValueFor("ability_damage")
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = attacker,
		attacker = parent,
		damage = damage,
		damage_type = 1,
		ability = ability,
	})
end
modifier_item_0226 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0226)
____exports.modifier_item_0226 = modifier_item_0226
return ____exports