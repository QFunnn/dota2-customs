--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/hero/special_bonus_unique_tidehunter_attack_trigger_smash.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/hero/special_bonus_unique_tidehunter_attack_trigger_smash.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:79",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "10:5",
		["22"] = "11:14",
		["25"] = "12:49",
		["26"] = "12:17",
		["27"] = "12:27",
		["28"] = "12:35",
		["29"] = "13:15",
		["30"] = "14:13",
		["33"] = "15:13",
		["36"] = "18:15",
		["37"] = "19:14",
		["40"] = "20:15",
		["41"] = "21:13",
		["42"] = "22:13",
		["44"] = "10:5",
		["45"] = "5:14",
		["46"] = "4:2",
		["47"] = "4:2",
		["48"] = "4:19",
		["49"] = "4:2",
		["51"] = "4:2",
		["52"] = "5:14",
		["54"] = "5:14",
	}
)
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash = __TS__Class()
local sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash =
	____exports.sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash
sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash.name =
	"sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash"
__TS__ClassExtends(sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash, SLModifierBase)
function sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end
function sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash.prototype.OnAttackLanded(self, event)
	if not IsServer() then
		return
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	local inflictor = ____event_0.inflictor
	local parent = self:GetParent()
	if parent ~= attacker then
		return
	end
	if IsValid(inflictor) and inflictor:GetAbilityName() == "tidehunter_anchor_smash" then
		return
	end
	local ability = parent:FindAbilityByName("tidehunter_anchor_smash")
	if not IsValid(ability) or ability:GetLevel() < 1 then
		return
	end
	local chance = self:GetAbilitySpecialValueFor("chance")
	if RollPseudoRandomPercentage(chance, DOTA_PSEUDO_RANDOM_CUSTOM_GAME_1, parent) then
		ability:OnSpellStart()
	end
end
sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash = __TS__Decorate(
	{ registerModifier(nil, "modifiers/hero/special_bonus_unique_tidehunter_attack_trigger_smash", nil, getfenv()) },
	sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash
)
____exports.sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash =
	sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash
return ____exports