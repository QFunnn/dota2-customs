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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local RUNE_SHIELD_AMOUNT = 200
____exports.modifier_ak_rune_shield = __TS__Class()
local modifier_ak_rune_shield = ____exports.modifier_ak_rune_shield
modifier_ak_rune_shield.name = "modifier_ak_rune_shield"
__TS__ClassExtends(modifier_ak_rune_shield, BaseModifier_CS)
function modifier_ak_rune_shield.GetLocalizationCN(self)
	return { name = "护盾神符", description = "获得高额护盾上限。" }
end
function modifier_ak_rune_shield.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GrantShieldNow()
end
function modifier_ak_rune_shield.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:GrantShieldNow()
end
function modifier_ak_rune_shield.prototype.GetAttributeBonus(self)
	local Level = self:GetParent():GetLevel()
	local shieldAmount = RUNE_SHIELD_AMOUNT + (Level - 1) * 50
	return { bonus_energy_shield = shieldAmount }
end
function modifier_ak_rune_shield.prototype.GetTexture(self)
	return "rune_shield"
end
function modifier_ak_rune_shield.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_shield_rune.vpcf"
end
function modifier_ak_rune_shield.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_ak_rune_shield.prototype.IsHidden(self)
	return false
end
function modifier_ak_rune_shield.prototype.IsDebuff(self)
	return false
end
function modifier_ak_rune_shield.prototype.IsPurgable(self)
	return true
end
function modifier_ak_rune_shield.prototype.GrantShieldNow(self)
	local parent = self:GetParent()
	local Level = parent:GetLevel()
	local shieldAmount = RUNE_SHIELD_AMOUNT + (Level - 1) * 50
	parent:AddCurrentEnergyShield(shieldAmount, "next_frame_delta")
end
modifier_ak_rune_shield =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_ak_rune_shield") }, modifier_ak_rune_shield)
____exports.modifier_ak_rune_shield = modifier_ak_rune_shield
return ____exports