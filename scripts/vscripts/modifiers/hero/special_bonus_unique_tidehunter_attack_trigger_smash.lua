--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
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
	{ registerModifier(nil, "modifiers/hero/special_bonus_unique_tidehunter_attack_trigger_smash") },
	sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash
)
____exports.sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash =
	sl_modifier_special_bonus_unique_tidehunter_attack_trigger_smash
return ____exports