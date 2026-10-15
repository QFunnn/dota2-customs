--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/units/bless_10169_cat_ability_1.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/units/bless_10169_cat_ability_1.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "2:27",
		["15"] = "3:1",
		["16"] = "3:10",
		["18"] = "8:1",
		["19"] = "9:14",
		["20"] = "8:1",
		["21"] = "9:40",
		["23"] = "9:48",
		["24"] = "10:5",
		["25"] = "8:1",
		["26"] = "11:5",
		["27"] = "12:15",
		["28"] = "13:15",
		["29"] = "15:9",
		["30"] = "15:35",
		["31"] = "15:52",
		["32"] = "15:9",
		["33"] = "17:9",
		["34"] = "18:13",
		["35"] = "19:13",
		["36"] = "20:13",
		["37"] = "21:13",
		["38"] = "21:20",
		["39"] = "21:50",
		["40"] = "21:19",
		["41"] = "17:32",
		["42"] = "23:15",
		["43"] = "24:9",
		["44"] = "26:15",
		["45"] = "27:9",
		["47"] = "28:18",
		["48"] = "28:38",
		["50"] = "29:13",
		["54"] = "9:48",
		["55"] = "11:5",
		["56"] = "9:14",
		["57"] = "8:2",
		["58"] = "8:2",
		["59"] = "8:2",
		["61"] = "8:2",
		["62"] = "9:14",
		["64"] = "9:14",
		["65"] = "40:1",
		["66"] = "41:14",
		["67"] = "40:1",
		["68"] = "41:52",
		["69"] = "42:5",
		["70"] = "43:15",
		["71"] = "44:15",
		["72"] = "45:13",
		["73"] = "45:13",
		["74"] = "45:13",
		["76"] = "45:40",
		["77"] = "45:40",
		["78"] = "45:40",
		["80"] = "45:13",
		["81"] = "46:13",
		["83"] = "48:9",
		["84"] = "42:5",
		["85"] = "51:5",
		["86"] = "52:9",
		["87"] = "51:5",
		["88"] = "55:5",
		["89"] = "56:9",
		["90"] = "55:5",
		["91"] = "59:5",
		["92"] = "60:9",
		["93"] = "59:5",
		["94"] = "68:5",
		["95"] = "69:14",
		["98"] = "70:15",
		["99"] = "71:15",
		["100"] = "72:15",
		["101"] = "73:14",
		["102"] = "74:13",
		["105"] = "77:29",
		["106"] = "77:29",
		["107"] = "77:29",
		["109"] = "77:15",
		["110"] = "78:14",
		["111"] = "79:13",
		["112"] = "79:21",
		["113"] = "79:13",
		["115"] = "79:13",
		["118"] = "82:30",
		["119"] = "82:30",
		["120"] = "82:30",
		["122"] = "82:9",
		["123"] = "84:9",
		["124"] = "85:13",
		["125"] = "86:13",
		["126"] = "87:13",
		["127"] = "88:13",
		["129"] = "90:13",
		["130"] = "91:13",
		["132"] = "93:15",
		["133"] = "94:9",
		["134"] = "94:26",
		["135"] = "94:31",
		["136"] = "94:38",
		["137"] = "94:45",
		["138"] = "94:48",
		["139"] = "94:55",
		["140"] = "94:9",
		["141"] = "95:9",
		["142"] = "96:9",
		["143"] = "68:5",
		["144"] = "99:5",
		["145"] = "100:14",
		["148"] = "101:14",
		["151"] = "102:15",
		["152"] = "103:22",
		["153"] = "103:22",
		["154"] = "103:22",
		["156"] = "103:15",
		["157"] = "104:14",
		["160"] = "105:15",
		["161"] = "106:15",
		["162"] = "107:15",
		["163"] = "108:13",
		["164"] = "109:13",
		["166"] = "111:13",
		["168"] = "113:13",
		["169"] = "114:13",
		["171"] = "99:5",
		["172"] = "118:5",
		["173"] = "119:27",
		["174"] = "119:27",
		["175"] = "119:49",
		["177"] = "119:56",
		["179"] = "119:9",
		["180"] = "120:9",
		["181"] = "118:5",
		["182"] = "123:5",
		["183"] = "124:9",
		["184"] = "123:5",
		["185"] = "130:5",
		["186"] = "131:16",
		["187"] = "131:16",
		["188"] = "131:34",
		["190"] = "131:54",
		["192"] = "131:9",
		["193"] = "130:5",
		["194"] = "41:14",
		["195"] = "40:2",
		["196"] = "40:2",
		["197"] = "40:19",
		["198"] = "40:2",
		["200"] = "40:2",
		["201"] = "41:14",
		["203"] = "41:14",
	}
)
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
bless_10169_cat_ability_1 = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, bless_10169_cat_ability_1)
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
	local ability = self:GetAbility()
	if not IsValid(caster) or not IsValid(parent) or not IsValid(ability) then
		self:Destroy()
		return
	end
	local ____caster_GetTeam_result_4 = caster
	if ____caster_GetTeam_result_4 ~= nil then
		____caster_GetTeam_result_4 = ____caster_GetTeam_result_4:GetTeam()
	end
	local caster_team = ____caster_GetTeam_result_4
	if not IsDotaTwoTeam(caster_team) then
		SLError(self:GetName(), nil, "abilities/units/bless_10169_cat_ability_1.ts:79:13")
		return
	end
	local ____GameMap_GetTeamFountain_result_GetAbsOrigin_result_6 = GameMap:GetTeamFountain(caster_team)
	if ____GameMap_GetTeamFountain_result_GetAbsOrigin_result_6 ~= nil then
		____GameMap_GetTeamFountain_result_GetAbsOrigin_result_6 =
			____GameMap_GetTeamFountain_result_GetAbsOrigin_result_6:GetAbsOrigin()
	end
	self._fountain_pos = ____GameMap_GetTeamFountain_result_GetAbsOrigin_result_6
	self._check_angle = ability:GetSpecialValueFor("check_angle") / 2
	local particle_path
	if caster_team == parent:GetTeam() then
		self._speed_bonus = ability:GetSpecialValueFor("speed_ally")
		particle_path = BLESS_PARTICLES.bless_10169_speed_buff
	else
		self._speed_bonus = ability:GetSpecialValueFor("speed_enemy")
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
	local current_is_active = self._is_active
	if SLVector:GetAngleDiffVecter(forward, dir) <= self._check_angle then
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
	{ registerModifier(nil, "abilities/units/bless_10169_cat_ability_1", nil, getfenv()) },
	sl_modifier_bless_10169_cat_ability_1
)
____exports.sl_modifier_bless_10169_cat_ability_1 = sl_modifier_bless_10169_cat_ability_1
return ____exports