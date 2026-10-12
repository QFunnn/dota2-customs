--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/tower/mid_mode_fort_amplify.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/tower/mid_mode_fort_amplify.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "2:27",
		["15"] = "2:40",
		["16"] = "4:1",
		["17"] = "5:14",
		["18"] = "4:1",
		["19"] = "5:36",
		["20"] = "6:5",
		["21"] = "7:15",
		["22"] = "8:13",
		["23"] = "9:13",
		["25"] = "6:5",
		["26"] = "5:14",
		["27"] = "4:2",
		["28"] = "4:2",
		["29"] = "4:2",
		["31"] = "4:2",
		["32"] = "5:14",
		["34"] = "5:14",
		["35"] = "13:1",
		["36"] = "14:14",
		["37"] = "13:1",
		["38"] = "14:45",
		["39"] = "15:5",
		["40"] = "16:9",
		["41"] = "15:5",
		["42"] = "19:5",
		["43"] = "20:9",
		["44"] = "19:5",
		["45"] = "31:5",
		["46"] = "32:9",
		["47"] = "33:9",
		["48"] = "34:14",
		["51"] = "35:15",
		["52"] = "36:14",
		["55"] = "37:9",
		["56"] = "37:33",
		["57"] = "37:62",
		["59"] = "37:62",
		["61"] = "37:9",
		["62"] = "31:5",
		["63"] = "40:5",
		["64"] = "41:14",
		["65"] = "41:50",
		["67"] = "42:15",
		["68"] = "43:13",
		["69"] = "43:43",
		["71"] = "44:15",
		["72"] = "45:9",
		["73"] = "40:5",
		["74"] = "48:5",
		["75"] = "49:9",
		["76"] = "48:5",
		["77"] = "52:5",
		["78"] = "53:16",
		["80"] = "53:16",
		["82"] = "53:9",
		["83"] = "52:5",
		["84"] = "56:5",
		["85"] = "57:16",
		["87"] = "57:16",
		["89"] = "57:9",
		["90"] = "56:5",
		["91"] = "60:5",
		["92"] = "61:16",
		["94"] = "61:16",
		["96"] = "61:9",
		["97"] = "60:5",
		["98"] = "14:14",
		["99"] = "13:2",
		["100"] = "13:2",
		["101"] = "13:19",
		["102"] = "13:2",
		["104"] = "13:2",
		["105"] = "14:14",
		["107"] = "14:14",
	}
)
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.mid_mode_fort_amplify = __TS__Class()
local mid_mode_fort_amplify = ____exports.mid_mode_fort_amplify
mid_mode_fort_amplify.name = "mid_mode_fort_amplify"
__TS__ClassExtends(mid_mode_fort_amplify, BaseAbility)
function mid_mode_fort_amplify.prototype.GetIntrinsicModifierName(self)
	local level = self:GetLevel()
	if level >= 1 then
		return ____exports.modifier_mid_mode_fort_amplify.name
	end
end
mid_mode_fort_amplify = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, mid_mode_fort_amplify)
____exports.mid_mode_fort_amplify = mid_mode_fort_amplify
____exports.modifier_mid_mode_fort_amplify = __TS__Class()
local modifier_mid_mode_fort_amplify = ____exports.modifier_mid_mode_fort_amplify
modifier_mid_mode_fort_amplify.name = "modifier_mid_mode_fort_amplify"
__TS__ClassExtends(modifier_mid_mode_fort_amplify, SLModifierBase)
function modifier_mid_mode_fort_amplify.prototype.AllowIllusionDuplicate(self)
	return false
end
function modifier_mid_mode_fort_amplify.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function modifier_mid_mode_fort_amplify.prototype.OnCreated(self, params)
	self._weak_time = self:GetAbilitySpecialValueFor("weak_time") * 60
	self._weak_pct = self:GetAbilitySpecialValueFor("weak_pct")
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local ____parent_SetBaseMaxHealth_2 = parent.SetBaseMaxHealth
	local ____temp_1 = parent:GetBaseMaxHealth()
	local ____temp_0 = self:GetAbilitySpecialValueFor("health_bonus")
	if ____temp_0 == nil then
		____temp_0 = 0
	end
	____parent_SetBaseMaxHealth_2(parent, ____temp_1 + ____temp_0)
end
function modifier_mid_mode_fort_amplify.prototype._GetWeakPct(self)
	if not self._weak_time or not self._weak_pct then
		return 0
	end
	local game_time = GameRules:GetDOTATime(false, false)
	if game_time <= self._weak_time then
		return 0
	end
	local minutes = math.floor((game_time - self._weak_time) / 60)
	return minutes * self._weak_pct
end
function modifier_mid_mode_fort_amplify.prototype.GetModifierIncomingDamage_Percentage(self, event)
	return self:GetAbilitySpecialValueFor("dmg_res_pct") * -1 + self:_GetWeakPct()
end
function modifier_mid_mode_fort_amplify.prototype.GetModifierConstantHealthRegen(self)
	local ____temp_3 = self:GetAbilitySpecialValueFor("health_regen_bonus")
	if ____temp_3 == nil then
		____temp_3 = 0
	end
	return ____temp_3
end
function modifier_mid_mode_fort_amplify.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____temp_4 = self:GetAbilitySpecialValueFor("armor_bonus")
	if ____temp_4 == nil then
		____temp_4 = 0
	end
	return ____temp_4
end
function modifier_mid_mode_fort_amplify.prototype.GetModifierMagicalResistanceBonus(self, event)
	local ____temp_5 = self:GetAbilitySpecialValueFor("magic_resist")
	if ____temp_5 == nil then
		____temp_5 = 0
	end
	return ____temp_5
end
modifier_mid_mode_fort_amplify = __TS__Decorate(
	{ registerModifier(nil, "abilities/tower/mid_mode_fort_amplify", nil, getfenv()) },
	modifier_mid_mode_fort_amplify
)
____exports.modifier_mid_mode_fort_amplify = modifier_mid_mode_fort_amplify
return ____exports