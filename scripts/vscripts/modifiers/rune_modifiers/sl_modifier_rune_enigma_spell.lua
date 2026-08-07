--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点智力提升{amp_per_int}%技能增强；每有1%技能增强，技能范围+{jnfw}
____exports.sl_modifier_rune_enigma_spell = __TS__Class()
local sl_modifier_rune_enigma_spell = ____exports.sl_modifier_rune_enigma_spell
sl_modifier_rune_enigma_spell.name = "sl_modifier_rune_enigma_spell"
__TS__ClassExtends(sl_modifier_rune_enigma_spell, sl_modifier_rune_base)
function sl_modifier_rune_enigma_spell.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._record_aoe = -1
	self._aoe_bonus = 0
end
function sl_modifier_rune_enigma_spell.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_rune_enigma_spell.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_enigma_spell.prototype.OnTooltip(self)
	return self._aoe_bonus
end
function sl_modifier_rune_enigma_spell.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local jnfw = self:_GetRuneSpecialValue("jnfw")
	Timers:CreateTimer(function()
		if not IsValid(self) or not IsValid(parent) then
			return nil
		end
		local aoe = parent:GetSpellAmplification(false) * 100 * jnfw
		if aoe == self._record_aoe then
			return 1
		end
		self._record_aoe = aoe
		self._aoe_bonus = aoe
		GlobalAttrManager:Get(parent:GetPlayerOwnerID()):SetAttr(tostring(self), "jnfw", aoe)
		self:SendBuffRefreshToClients()
		return 1
	end)
end
function sl_modifier_rune_enigma_spell.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	GlobalAttrManager:Get(parent:GetPlayerOwnerID()):RemoveAttr(tostring(self), "jnfw")
end
function sl_modifier_rune_enigma_spell.prototype.HandleCustomTransmitterData(self, data)
	sl_modifier_rune_base.prototype.HandleCustomTransmitterData(self, data)
	local ____data_aoe_bonus_0 = data
	if ____data_aoe_bonus_0 ~= nil then
		____data_aoe_bonus_0 = ____data_aoe_bonus_0.aoe_bonus
	end
	local ____data_aoe_bonus_0_2 = ____data_aoe_bonus_0
	if ____data_aoe_bonus_0_2 == nil then
		____data_aoe_bonus_0_2 = 0
	end
	self._aoe_bonus = ____data_aoe_bonus_0_2
end
function sl_modifier_rune_enigma_spell.prototype.AddCustomTransmitterData(self)
	return __TS__ObjectAssign(
		{},
		sl_modifier_rune_base.prototype.AddCustomTransmitterData(self),
		{ aoe_bonus = self._aoe_bonus }
	)
end
sl_modifier_rune_enigma_spell = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_enigma_spell") },
	sl_modifier_rune_enigma_spell
)
____exports.sl_modifier_rune_enigma_spell = sl_modifier_rune_enigma_spell
return ____exports