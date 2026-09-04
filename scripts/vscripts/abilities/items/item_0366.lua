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
____exports.item_0366 = __TS__Class()
local item_0366 = ____exports.item_0366
item_0366.name = "item_0366"
__TS__ClassExtends(item_0366, BaseItem_CS)
function item_0366.prototype.Precache(self, context) end
function item_0366.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0366_spiked_armor.name
end
item_0366 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0366)
____exports.item_0366 = item_0366
____exports.modifier_item_0366_spiked_armor = __TS__Class()
local modifier_item_0366_spiked_armor = ____exports.modifier_item_0366_spiked_armor
modifier_item_0366_spiked_armor.name = "modifier_item_0366_spiked_armor"
__TS__ClassExtends(modifier_item_0366_spiked_armor, BaseModifier_CS)
function modifier_item_0366_spiked_armor.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_item_0366_spiked_armor.prototype.IsHidden(self)
	return true
end
function modifier_item_0366_spiked_armor.prototype.IsPurgable(self)
	return false
end
function modifier_item_0366_spiked_armor.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.target ~= parent then
		return
	end
	local attacker = event.attacker
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, attacker) or attacker:IsBuilding() then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_value_reflect_attack_damage_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_reflect_attack_damage_pct"))
	local ability_value_reflect_damage_pct_per_armor =
		math.max(0, ability:GetSpecialValueFor("ability_value_reflect_damage_pct_per_armor"))
	local ability_attack_damage = math.max(0, self:GetAllAttackDamage(parent))
	local totalArmor = math.max(0, MyGameAttribute:GetAttribute(parent, "total_armor") or 0)
	local reflectDamagePct = ability_value_reflect_attack_damage_pct
		+ totalArmor * ability_value_reflect_damage_pct_per_armor
	local reflectDamage = ability_attack_damage * (reflectDamagePct / 100)
	if reflectDamage <= 0 then
		return
	end
	self:PlayEffects1(parent, attacker)
	Damage:ApplyDamage({
		victim = attacker,
		attacker = parent,
		damage = reflectDamage,
		damage_type = 1,
		ability = ability,
		extra_data = { custom_tag = "item_0366_spiked_armor", source_name = "item_0366" },
	})
end
function modifier_item_0366_spiked_armor.prototype.PlayEffects1(self, parent, attacker)
	EmitSoundOn("DOTA_Item.BladeMail.Damage", attacker)
end
modifier_item_0366_spiked_armor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0366_spiked_armor)
____exports.modifier_item_0366_spiked_armor = modifier_item_0366_spiked_armor
return ____exports