--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 流离：常驻隐藏。拦截敌方指向技能（GetRedirectSpell return 1）。
-- 转向施法由 bless_10204 + AbilityForceCast 完成；触发后挂可见冷却 Buff。
____exports.sl_modifier_bless_10204 = __TS__Class()
local sl_modifier_bless_10204 = ____exports.sl_modifier_bless_10204
sl_modifier_bless_10204.name = "sl_modifier_bless_10204"
__TS__ClassExtends(sl_modifier_bless_10204, sl_modifier_transmitter_data)
function sl_modifier_bless_10204.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10204.prototype.SetBless(self, bless)
	self._bless = bless
end
function sl_modifier_bless_10204.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_REDIRECT_SPELL }
end
function sl_modifier_bless_10204.prototype.GetRedirectSpell(self, event)
	if not IsServer() then
		return 0
	end
	local ____event_ability_0 = event
	if ____event_ability_0 ~= nil then
		____event_ability_0 = ____event_ability_0.ability
	end
	local ability = ____event_ability_0
	if not IsValid(ability) then
		return 0
	end
	if ability[AbilitySymbols.Bless10204RedirectCast] == true then
		return 0
	end
	local bless = self._bless
	if not bless or not bless:IsValid() then
		return 0
	end
	if ability:IsForceCastInCastFlow(bless) then
		return 0
	end
	if self._absorbingAbility == ability then
		return 1
	end
	local parent = self:GetParent()
	if not IsValidAlive(parent) then
		return 0
	end
	if parent:HasSLModifier(____exports.sl_modifier_bless_10204_cd, parent) then
		return 0
	end
	if not ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
		return 0
	end
	local caster = ability:GetCaster()
	if not IsValid(caster) or caster:GetTeamNumber() == parent:GetTeamNumber() then
		return 0
	end
	local ____table__params_chance_2 = self._params
	if ____table__params_chance_2 ~= nil then
		____table__params_chance_2 = ____table__params_chance_2.chance
	end
	local ____table__params_chance_2_4 = ____table__params_chance_2
	if ____table__params_chance_2_4 == nil then
		____table__params_chance_2_4 = 0
	end
	local chance = ____table__params_chance_2_4
	if not RollPseudoRandomPercentage(chance, 1011, parent) then
		return 0
	end
	local pick = self:_PickRedirectTarget(ability)
	if not pick then
		return 0
	end
	self._absorbingAbility = ability
	Timers:CreateTimer(0, function()
		if not IsValid(self) then
			return
		end
		if self._absorbingAbility == ability then
			self._absorbingAbility = nil
		end
	end)
	if not bless:RedirectSpell(ability, parent, pick) then
		self._absorbingAbility = nil
		return 0
	end
	local ____table__params_cd_5 = self._params
	if ____table__params_cd_5 ~= nil then
		____table__params_cd_5 = ____table__params_cd_5.cd
	end
	local ____table__params_cd_5_7 = ____table__params_cd_5
	if ____table__params_cd_5_7 == nil then
		____table__params_cd_5_7 = 0
	end
	local cd = ____table__params_cd_5_7
	if cd > 0 then
		parent:AddSLModifier(
			____exports.sl_modifier_bless_10204_cd,
			{ caster = parent, duration = cd, no_error = true }
		)
	end
	return 1
end
function sl_modifier_bless_10204.prototype._PickRedirectTarget(self, ability)
	local parent = self:GetParent()
	if not IsValidAlive(parent) then
		return nil
	end
	local ____table__params_radius_8 = self._params
	if ____table__params_radius_8 ~= nil then
		____table__params_radius_8 = ____table__params_radius_8.radius
	end
	local ____table__params_radius_8_10 = ____table__params_radius_8
	if ____table__params_radius_8_10 == nil then
		____table__params_radius_8_10 = 0
	end
	local radius = ____table__params_radius_8_10
	local units = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_ANY_ORDER,
		false
	)
	local creeps = {}
	local heroes = {}
	for ____, unit in ipairs(units) do
		do
			if not IsValidAlive(unit) or unit == parent then
				goto __continue25
			end
			if not AbilityForceCast:CheckAbilityCanCastOnTarget(ability, unit) then
				goto __continue25
			end
			if unit:IsRealHero() then
				heroes[#heroes + 1] = unit
			elseif unit:IsCreep() then
				creeps[#creeps + 1] = unit
			end
		end
		::__continue25::
	end
	local ____temp_11
	if #creeps > 0 then
		____temp_11 = creeps
	else
		____temp_11 = heroes
	end
	local pool = ____temp_11
	if #pool == 0 then
		return nil
	end
	return GetRandomArrayElement(pool)
end
sl_modifier_bless_10204 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10204") },
	sl_modifier_bless_10204
)
____exports.sl_modifier_bless_10204 = sl_modifier_bless_10204
--- 流离冷却展示：剩余时间由 duration 时钟显示
____exports.sl_modifier_bless_10204_cd = __TS__Class()
local sl_modifier_bless_10204_cd = ____exports.sl_modifier_bless_10204_cd
sl_modifier_bless_10204_cd.name = "sl_modifier_bless_10204_cd"
__TS__ClassExtends(sl_modifier_bless_10204_cd, SLModifierBase)
function sl_modifier_bless_10204_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10204_cd.prototype.GetTexture(self)
	return "buff/bless/10204"
end
sl_modifier_bless_10204_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10204") },
	sl_modifier_bless_10204_cd
)
____exports.sl_modifier_bless_10204_cd = sl_modifier_bless_10204_cd
return ____exports