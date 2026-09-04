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
____exports.item_0225 = __TS__Class()
local item_0225 = ____exports.item_0225
item_0225.name = "item_0225"
__TS__ClassExtends(item_0225, BaseItem_CS)
function item_0225.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0225.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	caster:AddNewModifier(caster, self, ____exports.modifier_item_0225_guard.name, { duration = ability_duration })
	self:PlayEffects1(caster)
end
function item_0225.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.DoE.Activate")
end
item_0225 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0225)
____exports.item_0225 = item_0225
____exports.modifier_item_0225_guard = __TS__Class()
local modifier_item_0225_guard = ____exports.modifier_item_0225_guard
modifier_item_0225_guard.name = "modifier_item_0225_guard"
__TS__ClassExtends(modifier_item_0225_guard, BaseModifier_CS)
function modifier_item_0225_guard.GetLocalizationCN(self)
	return { name = "守护", description = "获得临时护盾上限，移动速度降低。" }
end
function modifier_item_0225_guard.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:ApplyShield()
end
function modifier_item_0225_guard.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:ApplyShield()
end
function modifier_item_0225_guard.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_shield_amount = ability:GetSpecialValueFor("ability_value_shield_amount")
	local ability_max_health_pct = ability:GetSpecialValueFor("ability_value_max_health_pct")
	local ability_self_movespeed_pct = ability:GetSpecialValueFor("ability_self_movespeed_pct")
	local parent = self:GetParent()
	local bonusShield = ability_shield_amount + parent:GetMaxHealth() * (ability_max_health_pct / 100)
	return {
		base_energy_shield = bonusShield,
		bonus_movespeed_pct = -math.abs(ability_self_movespeed_pct),
	}
end
function modifier_item_0225_guard.prototype.IsDebuff(self)
	return false
end
function modifier_item_0225_guard.prototype.IsPurgable(self)
	return true
end
function modifier_item_0225_guard.prototype.GetTexture(self)
	return "item_vanguard"
end
function modifier_item_0225_guard.prototype.ApplyShield(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local ability_shield_amount = ability:GetSpecialValueFor("ability_value_shield_amount")
	local ability_max_health_pct = ability:GetSpecialValueFor("ability_value_max_health_pct")
	local bonusShield = ability_shield_amount + parent:GetMaxHealth() * (ability_max_health_pct / 100)
	if bonusShield <= 0 then
		return
	end
	parent:AddCurrentEnergyShield(bonusShield, "next_frame_delta")
	self:RefreshAttributes()
end
modifier_item_0225_guard = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0225_guard)
____exports.modifier_item_0225_guard = modifier_item_0225_guard
return ____exports