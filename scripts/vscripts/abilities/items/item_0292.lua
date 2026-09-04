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
____exports.item_0292 = __TS__Class()
local item_0292 = ____exports.item_0292
item_0292.name = "item_0292"
__TS__ClassExtends(item_0292, BaseItem_CS)
function item_0292.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0292_burning_blood.name
end
item_0292 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0292)
____exports.item_0292 = item_0292
____exports.modifier_item_0292_burning_blood = __TS__Class()
local modifier_item_0292_burning_blood = ____exports.modifier_item_0292_burning_blood
modifier_item_0292_burning_blood.name = "modifier_item_0292_burning_blood"
__TS__ClassExtends(modifier_item_0292_burning_blood, BaseModifier_CS)
function modifier_item_0292_burning_blood.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function modifier_item_0292_burning_blood.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local ability_hp_burn_pct_per_sec = math.max(0, ability:GetSpecialValueFor("ability_hp_burn_pct_per_sec"))
	local burnDamage = parent:GetMaxHealth() * (ability_hp_burn_pct_per_sec / 100)
	if burnDamage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = parent,
		attacker = parent,
		damage = burnDamage,
		damage_type = 2,
		ability = ability,
		damage_flag = ApplyDamageFlag.HP_LOSS,
	})
end
function modifier_item_0292_burning_blood.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return {
		base_magic_resistance = math.max(0, ability:GetSpecialValueFor("ability_magic_resistance_pct")),
	}
end
function modifier_item_0292_burning_blood.prototype.IsHidden(self)
	return true
end
modifier_item_0292_burning_blood = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0292_burning_blood)
____exports.modifier_item_0292_burning_blood = modifier_item_0292_burning_blood
return ____exports