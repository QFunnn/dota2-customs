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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____bless_10169_cat_ability_base = require("abilities.units._bless_10169_cat_ability_base")
local _bless_10169_cat_ability_base = _____bless_10169_cat_ability_base._bless_10169_cat_ability_base
--- 撤退：所有己方英雄向基地移动时，移动速度+60，使所有敌方英雄向我方基地移动时，移动速度-60，持续3秒
____exports.bless_10169_cat_ability_1 = __TS__Class()
local bless_10169_cat_ability_1 = ____exports.bless_10169_cat_ability_1
bless_10169_cat_ability_1.name = "bless_10169_cat_ability_1"
__TS__ClassExtends(bless_10169_cat_ability_1, _bless_10169_cat_ability_base)
function bless_10169_cat_ability_1.prototype.____constructor(self, ...)
	_bless_10169_cat_ability_base.prototype.____constructor(self, ...)
	self._command_particle = BLESS_PARTICLES.bless_10169_ret_head
end
function bless_10169_cat_ability_1.prototype.OnSpellStart(self)
	local caster = self:GetCaster()
	local player_id = caster:GetPlayerOwnerID()
	EmitAnnouncerSoundForTeam("cat_ability_1", caster:GetTeam())
	Custom_SendChatMessage({
		message = "#bless_10169_cat_ability_1_msg",
		send_player = player_id,
		team_only = true,
		args = {
			GetPlayerColorHex(player_id),
			"#" .. caster:GetUnitName(),
		},
	})
	local pid = self:CreateParticle(BLESS_PARTICLES.bless_10169_speed_buff, PATTACH_ABSORIGIN_FOLLOW, caster)
	self:DestroyParticle(pid, false)
	local speed_dur = self:GetSpecialValueFor("speed_dur")
	for ____, hero in ipairs(HeroList:GetAllHeroes()) do
		do
			if not IsValidAlive(hero) then
				goto __continue3
			end
			hero:AddSLModifier(
				____exports.sl_modifier_bless_10169_cat_ability_1,
				{ ability = self, caster = caster, duration = speed_dur, no_error = true }
			)
		end
		::__continue3::
	end
	_bless_10169_cat_ability_base.prototype.OnSpellStart(self)
end
bless_10169_cat_ability_1 = __TS__Decorate({ registerAbility(nil) }, bless_10169_cat_ability_1)
____exports.bless_10169_cat_ability_1 = bless_10169_cat_ability_1
____exports.sl_modifier_bless_10169_cat_ability_1 = __TS__Class()
local sl_modifier_bless_10169_cat_ability_1 = ____exports.sl_modifier_bless_10169_cat_ability_1
sl_modifier_bless_10169_cat_ability_1.name = "sl_modifier_bless_10169_cat_ability_1"
__TS__ClassExtends(sl_modifier_bless_10169_cat_ability_1, SLModifierBase)
function sl_modifier_bless_10169_cat_ability_1.prototype.IsDebuff(self)
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ____caster_GetTeamNumber_result_0 = caster
	if ____caster_GetTeamNumber_result_0 ~= nil then
		____caster_GetTeamNumber_result_0 = ____caster_GetTeamNumber_result_0:GetTeamNumber()
	end
	local ____parent_GetTeamNumber_result_2 = parent
	if ____parent_GetTeamNumber_result_2 ~= nil then
		____parent_GetTeamNumber_result_2 = ____parent_GetTeamNumber_result_2:GetTeamNumber()
	end
	if ____caster_GetTeamNumber_result_0 == ____parent_GetTeamNumber_result_2 then
		return false
	end
	return true
end
function sl_modifier_bless_10169_cat_ability_1.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10169_cat_ability_1.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function sl_modifier_bless_10169_cat_ability_1.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10169_cat_ability_1.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ____caster_GetTeam_result_4 = caster
	if ____caster_GetTeam_result_4 ~= nil then
		____caster_GetTeam_result_4 = ____caster_GetTeam_result_4:GetTeam()
	end
	local caster_team = ____caster_GetTeam_result_4
	if not IsDotaTwoTeam(caster_team) then
		SLError(nil, self:GetName())
		return
	end
	local ____GameMap_GetTeamFountain_result_GetAbsOrigin_result_6 = GameMap:GetTeamFountain(caster_team)
	if ____GameMap_GetTeamFountain_result_GetAbsOrigin_result_6 ~= nil then
		____GameMap_GetTeamFountain_result_GetAbsOrigin_result_6 =
			____GameMap_GetTeamFountain_result_GetAbsOrigin_result_6:GetAbsOrigin()
	end
	self._fountain_pos = ____GameMap_GetTeamFountain_result_GetAbsOrigin_result_6
	local particle_path
	if caster_team == parent:GetTeam() then
		self._speed_bonus = self:GetAbilitySpecialValueFor("speed_ally")
		particle_path = BLESS_PARTICLES.bless_10169_speed_buff
	else
		self._speed_bonus = self:GetAbilitySpecialValueFor("speed_enemy")
		particle_path = BLESS_PARTICLES.bless_10169_slow_buff
	end
	local pid = self:CreateParticle(particle_path, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:AddParticle(pid, false, false, 5, false, false)
	self:SetHasCustomTransmitterData(true)
	self:StartIntervalThink(0.1)
end
function sl_modifier_bless_10169_cat_ability_1.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not self._fountain_pos then
		return
	end
	local parent = self:GetParent()
	local ____parent_GetTeam_result_8 = parent
	if ____parent_GetTeam_result_8 ~= nil then
		____parent_GetTeam_result_8 = ____parent_GetTeam_result_8:GetTeam()
	end
	local team = ____parent_GetTeam_result_8
	if not IsDotaTwoTeam(team) then
		return
	end
	local dir = self._fountain_pos:__sub(parent:GetAbsOrigin())
	local forward = parent:GetForwardVector()
	local check_angle = self:GetAbilitySpecialValueFor("check_angle") / 2
	local current_is_active = self._is_active
	if SLVector:GetAngleDiffVecter(forward, dir) <= check_angle then
		self._is_active = true
	else
		self._is_active = false
	end
	if self._is_active ~= current_is_active then
		self:SendBuffRefreshToClients()
	end
end
function sl_modifier_bless_10169_cat_ability_1.prototype.HandleCustomTransmitterData(self, data)
	local ____temp_10
	if data.is_active == 1 then
		____temp_10 = true
	else
		____temp_10 = false
	end
	self._is_active = ____temp_10
	self._speed_bonus = data.speed_bonus
end
function sl_modifier_bless_10169_cat_ability_1.prototype.AddCustomTransmitterData(self)
	return { is_active = self._is_active, speed_bonus = self._speed_bonus }
end
function sl_modifier_bless_10169_cat_ability_1.prototype.GetModifierMoveSpeedBonus_Constant(self)
	local ____table__is_active_11
	if self._is_active then
		____table__is_active_11 = self._speed_bonus
	else
		____table__is_active_11 = nil
	end
	return ____table__is_active_11
end
sl_modifier_bless_10169_cat_ability_1 = __TS__Decorate(
	{ registerModifier(nil, "abilities/units/bless_10169_cat_ability_1") },
	sl_modifier_bless_10169_cat_ability_1
)
____exports.sl_modifier_bless_10169_cat_ability_1 = sl_modifier_bless_10169_cat_ability_1
return ____exports