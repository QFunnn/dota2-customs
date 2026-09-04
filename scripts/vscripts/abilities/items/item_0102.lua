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
--- item_0102 - 碎裂背心
-- 每次受到攻击时，按自身当前护甲反弹物理伤害给攻击者。
____exports.item_0102 = __TS__Class()
local item_0102 = ____exports.item_0102
item_0102.name = "item_0102"
__TS__ClassExtends(item_0102, BaseItem_CS)
function item_0102.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0102"
end
item_0102 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0102)
____exports.item_0102 = item_0102
____exports.modifier_item_0102 = __TS__Class()
local modifier_item_0102 = ____exports.modifier_item_0102
modifier_item_0102.name = "modifier_item_0102"
__TS__ClassExtends(modifier_item_0102, BaseModifier_CS)
function modifier_item_0102.prototype.IsHidden(self)
	return true
end
function modifier_item_0102.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_item_0102.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	local attacker = event.attacker
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, attacker) or attacker:IsBuilding() then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_damage = math.max(0, ability:GetSpecialValueFor("ability_value_item_0102_damage"))
	local totalArmor = math.max(0, MyGameAttribute:GetAttribute(parent, "total_armor") or 0)
	local damage = totalArmor * (ability_damage / 100)
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
modifier_item_0102 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0102)
____exports.modifier_item_0102 = modifier_item_0102
return ____exports