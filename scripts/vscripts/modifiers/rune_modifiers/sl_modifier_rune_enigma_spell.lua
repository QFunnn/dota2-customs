--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_enigma_spell.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_enigma_spell.lua",
	{
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "2:1",
		["14"] = "2:10",
		["16"] = "7:1",
		["17"] = "8:14",
		["18"] = "7:1",
		["19"] = "8:44",
		["21"] = "8:52",
		["22"] = "9:5",
		["23"] = "11:5",
		["24"] = "7:1",
		["25"] = "13:5",
		["26"] = "14:9",
		["27"] = "13:5",
		["28"] = "17:5",
		["29"] = "18:9",
		["30"] = "18:16",
		["31"] = "20:13",
		["32"] = "21:13",
		["33"] = "18:16",
		["34"] = "17:5",
		["35"] = "25:5",
		["36"] = "26:9",
		["37"] = "25:5",
		["38"] = "29:5",
		["39"] = "8:52",
		["40"] = "31:14",
		["43"] = "32:15",
		["44"] = "33:15",
		["45"] = "34:9",
		["46"] = "35:18",
		["47"] = "35:53",
		["49"] = "36:19",
		["50"] = "37:17",
		["51"] = "37:43",
		["53"] = "38:13",
		["54"] = "39:13",
		["55"] = "40:13",
		["56"] = "40:70",
		["57"] = "40:86",
		["58"] = "40:109",
		["59"] = "40:13",
		["60"] = "41:13",
		["61"] = "42:13",
		["62"] = "34:28",
		["63"] = "29:5",
		["64"] = "46:5",
		["65"] = "47:14",
		["68"] = "48:15",
		["69"] = "49:14",
		["72"] = "50:9",
		["73"] = "50:69",
		["74"] = "50:85",
		["75"] = "50:9",
		["76"] = "46:5",
		["77"] = "53:5",
		["78"] = "8:52",
		["79"] = "55:27",
		["80"] = "55:27",
		["81"] = "55:27",
		["83"] = "55:27",
		["85"] = "55:27",
		["87"] = "55:9",
		["88"] = "53:5",
		["89"] = "58:5",
		["90"] = "59:9",
		["91"] = "59:16",
		["92"] = "8:52",
		["93"] = "59:16",
		["94"] = "59:16",
		["95"] = "58:5",
		["96"] = "8:14",
		["97"] = "7:2",
		["98"] = "7:2",
		["99"] = "7:19",
		["100"] = "7:2",
		["102"] = "7:2",
		["103"] = "8:14",
		["105"] = "8:14",
	}
)
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
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_enigma_spell", nil, getfenv()) },
	sl_modifier_rune_enigma_spell
)
____exports.sl_modifier_rune_enigma_spell = sl_modifier_rune_enigma_spell
return ____exports