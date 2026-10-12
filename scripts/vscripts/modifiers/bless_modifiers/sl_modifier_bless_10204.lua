--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10204.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10204.lua",
	{
		["10"] = "2:1",
		["11"] = "2:10",
		["12"] = "4:1",
		["13"] = "4:10",
		["14"] = "5:1",
		["15"] = "5:10",
		["18"] = "11:1",
		["19"] = "12:14",
		["20"] = "11:1",
		["21"] = "12:38",
		["22"] = "21:5",
		["23"] = "22:9",
		["24"] = "21:5",
		["25"] = "25:5",
		["26"] = "26:9",
		["27"] = "25:5",
		["28"] = "29:5",
		["29"] = "30:9",
		["30"] = "29:5",
		["31"] = "37:5",
		["32"] = "38:14",
		["33"] = "38:26",
		["35"] = "39:25",
		["36"] = "39:25",
		["37"] = "39:25",
		["39"] = "39:15",
		["40"] = "40:14",
		["41"] = "40:32",
		["43"] = "43:13",
		["44"] = "43:70",
		["46"] = "44:15",
		["47"] = "45:14",
		["48"] = "45:41",
		["50"] = "46:13",
		["51"] = "46:51",
		["53"] = "49:13",
		["54"] = "49:49",
		["56"] = "51:15",
		["57"] = "52:14",
		["58"] = "52:36",
		["60"] = "53:13",
		["61"] = "53:71",
		["63"] = "54:14",
		["64"] = "54:64",
		["66"] = "56:15",
		["67"] = "57:14",
		["68"] = "57:84",
		["70"] = "59:24",
		["71"] = "59:24",
		["72"] = "59:24",
		["74"] = "59:24",
		["76"] = "59:24",
		["78"] = "59:15",
		["79"] = "60:14",
		["80"] = "60:84",
		["82"] = "62:15",
		["83"] = "63:14",
		["84"] = "63:20",
		["86"] = "66:9",
		["87"] = "67:9",
		["88"] = "67:28",
		["89"] = "67:31",
		["90"] = "68:18",
		["93"] = "69:17",
		["94"] = "70:17",
		["96"] = "67:31",
		["97"] = "67:9",
		["98"] = "74:14",
		["99"] = "75:13",
		["100"] = "76:13",
		["102"] = "79:20",
		["103"] = "79:20",
		["104"] = "79:20",
		["106"] = "79:20",
		["108"] = "79:20",
		["110"] = "79:15",
		["111"] = "80:13",
		["112"] = "81:13",
		["114"] = "88:9",
		["115"] = "37:5",
		["116"] = "95:5",
		["117"] = "96:15",
		["118"] = "97:14",
		["119"] = "97:36",
		["121"] = "98:24",
		["122"] = "98:24",
		["123"] = "98:24",
		["125"] = "98:24",
		["127"] = "98:24",
		["129"] = "98:15",
		["130"] = "99:15",
		["131"] = "100:13",
		["132"] = "101:13",
		["133"] = "102:13",
		["134"] = "103:13",
		["135"] = "99:23",
		["136"] = "99:23",
		["137"] = "99:23",
		["138"] = "99:23",
		["139"] = "108:13",
		["140"] = "99:23",
		["141"] = "110:15",
		["142"] = "111:15",
		["143"] = "112:9",
		["145"] = "113:18",
		["146"] = "113:57",
		["148"] = "114:18",
		["149"] = "114:79",
		["151"] = "115:17",
		["152"] = "116:17",
		["153"] = "117:24",
		["154"] = "118:17",
		["159"] = "121:22",
		["160"] = "121:22",
		["161"] = "121:42",
		["163"] = "121:51",
		["165"] = "121:15",
		["166"] = "122:13",
		["167"] = "122:32",
		["169"] = "123:9",
		["170"] = "95:5",
		["171"] = "12:14",
		["172"] = "11:2",
		["173"] = "11:2",
		["174"] = "11:19",
		["175"] = "11:2",
		["177"] = "11:2",
		["178"] = "12:14",
		["180"] = "12:14",
		["182"] = "128:1",
		["183"] = "129:14",
		["184"] = "128:1",
		["185"] = "129:41",
		["186"] = "130:5",
		["187"] = "131:9",
		["188"] = "130:5",
		["189"] = "134:5",
		["190"] = "135:9",
		["191"] = "134:5",
		["192"] = "129:14",
		["193"] = "128:2",
		["194"] = "128:2",
		["195"] = "128:19",
		["196"] = "128:2",
		["198"] = "128:2",
		["199"] = "129:14",
		["201"] = "129:14",
	}
)
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10204", nil, getfenv()) },
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10204", nil, getfenv()) },
	sl_modifier_bless_10204_cd
)
____exports.sl_modifier_bless_10204_cd = sl_modifier_bless_10204_cd
return ____exports