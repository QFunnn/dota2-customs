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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10206 = __TS__Class()
local sl_modifier_bless_10206 = ____exports.sl_modifier_bless_10206
sl_modifier_bless_10206.name = "sl_modifier_bless_10206"
__TS__ClassExtends(sl_modifier_bless_10206, sl_modifier_transmitter_data)
function sl_modifier_bless_10206.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10206.prototype.GetTexture(self)
	return "buff/bless/10206"
end
function sl_modifier_bless_10206.prototype.SetBless(self, bless)
	self._bless = bless
end
function sl_modifier_bless_10206.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_ABSORB_SPELL, MODIFIER_EVENT_ON_ATTACK_FAIL, MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10206.prototype.GetAbsorbSpell(self, event)
	if not IsServer() then
		return 0
	end
	local ____table__params_spell_dodge_chance_0 = self._params
	if ____table__params_spell_dodge_chance_0 ~= nil then
		____table__params_spell_dodge_chance_0 = ____table__params_spell_dodge_chance_0.spell_dodge_chance
	end
	local ____table__params_spell_dodge_chance_0_2 = ____table__params_spell_dodge_chance_0
	if ____table__params_spell_dodge_chance_0_2 == nil then
		____table__params_spell_dodge_chance_0_2 = 0
	end
	local chance = ____table__params_spell_dodge_chance_0_2
	if not RollPercentage(chance) then
		return 0
	end
	local ability = event.ability
	local ____event_unit_5 = event.unit
	if ____event_unit_5 == nil then
		local ____ability_GetCaster_result_3 = ability
		if ____ability_GetCaster_result_3 ~= nil then
			____ability_GetCaster_result_3 = ____ability_GetCaster_result_3:GetCaster()
		end
		____event_unit_5 = ____ability_GetCaster_result_3
	end
	local attacker = ____event_unit_5
	if IsValid(attacker) and attacker:IsHero() and attacker:IsRealHero() then
		self:_TryCounter(attacker)
	end
	return 1
end
function sl_modifier_bless_10206.prototype.OnAttackFail(self, event)
	if not IsServer() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	local attacker = event.attacker
	if not IsValid(attacker) or not attacker:IsHero() or not attacker:IsRealHero() then
		return
	end
	self:_TryCounter(attacker)
end
function sl_modifier_bless_10206.prototype.OnTooltip(self)
	local ____table__params_spell_dodge_chance_6 = self._params
	if ____table__params_spell_dodge_chance_6 ~= nil then
		____table__params_spell_dodge_chance_6 = ____table__params_spell_dodge_chance_6.spell_dodge_chance
	end
	local ____table__params_spell_dodge_chance_6_8 = ____table__params_spell_dodge_chance_6
	if ____table__params_spell_dodge_chance_6_8 == nil then
		____table__params_spell_dodge_chance_6_8 = 0
	end
	return ____table__params_spell_dodge_chance_6_8
end
function sl_modifier_bless_10206.prototype._TryCounter(self, source)
	local bless = self._bless
	if not bless or not bless:IsValid() then
		return
	end
	local ____table__params_trigger_chance_9 = self._params
	if ____table__params_trigger_chance_9 ~= nil then
		____table__params_trigger_chance_9 = ____table__params_trigger_chance_9.trigger_chance
	end
	local ____table__params_trigger_chance_9_11 = ____table__params_trigger_chance_9
	if ____table__params_trigger_chance_9_11 == nil then
		____table__params_trigger_chance_9_11 = 0
	end
	local trigger_chance = ____table__params_trigger_chance_9_11
	if not RollPercentage(trigger_chance) then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(parent) or not IsValidAlive(source) then
		return
	end
	local ____table__params_damage_12 = self._params
	if ____table__params_damage_12 ~= nil then
		____table__params_damage_12 = ____table__params_damage_12.damage
	end
	local ____table__params_damage_12_14 = ____table__params_damage_12
	if ____table__params_damage_12_14 == nil then
		____table__params_damage_12_14 = 0
	end
	local dmg_per_level = ____table__params_damage_12_14
	local damage = dmg_per_level * parent:GetLevel()
	if damage <= 0 then
		return
	end
	bless:ApplyDamage({ attacker = parent, victim = source, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
end
sl_modifier_bless_10206 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10206") },
	sl_modifier_bless_10206
)
____exports.sl_modifier_bless_10206 = sl_modifier_bless_10206
return ____exports