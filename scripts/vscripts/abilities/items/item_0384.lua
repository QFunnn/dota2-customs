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
local HEAL_INTERVAL = 1
____exports.item_0384 = __TS__Class()
local item_0384 = ____exports.item_0384
item_0384.name = "item_0384"
__TS__ClassExtends(item_0384, BaseItem_CS)
function item_0384.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0384_sage_cache.name
end
item_0384 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0384)
____exports.item_0384 = item_0384
____exports.modifier_item_0384_sage_cache = __TS__Class()
local modifier_item_0384_sage_cache = ____exports.modifier_item_0384_sage_cache
modifier_item_0384_sage_cache.name = "modifier_item_0384_sage_cache"
__TS__ClassExtends(modifier_item_0384_sage_cache, BaseModifier_CS)
function modifier_item_0384_sage_cache.GetLocalizationCN(self)
	return { name = "贤者秘藏", description = "拥有护盾值时，每秒按当前护盾值恢复生命。" }
end
function modifier_item_0384_sage_cache.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(HEAL_INTERVAL)
end
function modifier_item_0384_sage_cache.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0384_sage_cache.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() or not IsValidAlive(nil, parent) then
		return
	end
	if not parent.GetCurrentEnergyShield then
		return
	end
	local ability_current_shield = math.max(0, parent:GetCurrentEnergyShield())
	if ability_current_shield <= 0 then
		return
	end
	local ability_value_heal_pct_per_sec = math.max(0, ability:GetSpecialValueFor("ability_value_heal_pct_per_sec"))
	if ability_value_heal_pct_per_sec <= 0 then
		return
	end
	local ability_missing_health = math.max(0, parent:GetMaxHealth() - parent:GetHealth())
	if ability_missing_health <= 0 then
		return
	end
	local ability_heal =
		math.min(ability_current_shield * (ability_value_heal_pct_per_sec / 100), ability_missing_health)
	if ability_heal <= 0 then
		return
	end
	parent:CustomHeal(ability_heal, { ability = ability, source = "item" })
end
function modifier_item_0384_sage_cache.prototype.IsHidden(self)
	return true
end
function modifier_item_0384_sage_cache.prototype.IsDebuff(self)
	return false
end
function modifier_item_0384_sage_cache.prototype.IsPurgable(self)
	return false
end
function modifier_item_0384_sage_cache.prototype.GetTexture(self)
	return "item_icon_m6_12"
end
modifier_item_0384_sage_cache = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0384_sage_cache)
____exports.modifier_item_0384_sage_cache = modifier_item_0384_sage_cache
return ____exports