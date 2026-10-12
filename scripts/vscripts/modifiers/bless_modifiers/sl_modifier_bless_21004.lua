--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_21004.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_21004.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "4:10",
		["16"] = "7:1",
		["17"] = "8:14",
		["18"] = "7:1",
		["19"] = "8:38",
		["20"] = "9:5",
		["21"] = "10:9",
		["22"] = "9:5",
		["23"] = "13:5",
		["24"] = "14:9",
		["25"] = "13:5",
		["26"] = "17:5",
		["27"] = "18:9",
		["28"] = "19:13",
		["29"] = "20:13",
		["30"] = "21:13",
		["31"] = "22:13",
		["32"] = "23:13",
		["33"] = "24:13",
		["34"] = "25:13",
		["35"] = "26:13",
		["36"] = "27:13",
		["37"] = "28:13",
		["38"] = "18:16",
		["39"] = "17:5",
		["40"] = "33:5",
		["41"] = "34:14",
		["44"] = "35:9",
		["45"] = "36:9",
		["46"] = "33:5",
		["47"] = "39:5",
		["48"] = "40:14",
		["51"] = "41:15",
		["52"] = "42:9",
		["53"] = "43:13",
		["54"] = "44:13",
		["56"] = "50:13",
		["57"] = "51:19",
		["58"] = "52:17",
		["59"] = "53:23",
		["60"] = "54:21",
		["61"] = "55:27",
		["62"] = "56:27",
		["63"] = "57:21",
		["64"] = "57:43",
		["65"] = "57:51",
		["66"] = "57:85",
		["67"] = "57:21",
		["70"] = "61:17",
		["71"] = "62:17",
		["72"] = "63:17",
		["75"] = "67:13",
		["76"] = "68:13",
		["78"] = "39:5",
		["79"] = "73:5",
		["80"] = "74:9",
		["81"] = "73:5",
		["82"] = "79:5",
		["83"] = "80:9",
		["84"] = "81:9",
		["85"] = "82:9",
		["86"] = "79:5",
		["87"] = "85:5",
		["88"] = "86:14",
		["91"] = "87:15",
		["92"] = "88:13",
		["93"] = "89:13",
		["95"] = "91:13",
		["97"] = "85:5",
		["98"] = "8:14",
		["99"] = "7:2",
		["100"] = "7:2",
		["101"] = "7:19",
		["102"] = "7:2",
		["104"] = "7:2",
		["105"] = "8:14",
		["107"] = "8:14",
		["108"] = "96:1",
		["109"] = "97:14",
		["110"] = "96:1",
		["111"] = "97:41",
		["112"] = "98:5",
		["113"] = "99:9",
		["114"] = "98:5",
		["115"] = "102:5",
		["116"] = "103:9",
		["117"] = "102:5",
		["118"] = "97:14",
		["119"] = "96:2",
		["120"] = "96:2",
		["121"] = "96:19",
		["122"] = "96:2",
		["124"] = "96:2",
		["125"] = "97:14",
		["127"] = "97:14",
		["128"] = "107:1",
		["129"] = "108:14",
		["130"] = "107:1",
		["131"] = "108:45",
		["132"] = "109:5",
		["133"] = "110:9",
		["134"] = "109:5",
		["135"] = "113:5",
		["136"] = "114:9",
		["137"] = "113:5",
		["138"] = "120:5",
		["139"] = "121:9",
		["140"] = "120:5",
		["141"] = "124:5",
		["142"] = "125:14",
		["145"] = "126:13",
		["146"] = "127:13",
		["147"] = "128:13",
		["149"] = "124:5",
		["150"] = "132:5",
		["151"] = "133:9",
		["152"] = "132:5",
		["153"] = "136:5",
		["154"] = "137:9",
		["155"] = "136:5",
		["156"] = "140:5",
		["157"] = "141:9",
		["158"] = "140:5",
		["159"] = "108:14",
		["160"] = "107:2",
		["161"] = "107:2",
		["162"] = "107:19",
		["163"] = "107:2",
		["165"] = "107:2",
		["166"] = "108:14",
		["168"] = "108:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
____exports.sl_modifier_bless_21004 = __TS__Class()
local sl_modifier_bless_21004 = ____exports.sl_modifier_bless_21004
sl_modifier_bless_21004.name = "sl_modifier_bless_21004"
__TS__ClassExtends(sl_modifier_bless_21004, SLModifierBase)
function sl_modifier_bless_21004.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21004.prototype.GetTexture(self)
	return "buff/bless/21004"
end
function sl_modifier_bless_21004.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end
function sl_modifier_bless_21004.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:GetParent():AddNoDraw()
	self._cd = params.cd
end
function sl_modifier_bless_21004.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:RemoveNoDraw()
	if IsValidAlive(parent) then
		parent:AddSLModifier(____exports.sl_modifier_bless_21004_cd, { caster = parent, duration = self._cd })
	end
	if IsValid(self._follow_target) then
		local team = self._follow_target:GetTeam()
		if IsDotaTwoTeam(team) then
			local font = GameMap:GetTeamFort(team)
			if IsValid(font) then
				local target_pos = self._follow_target:GetAbsOrigin()
				local dir = SLVector:Normalized2D(font:GetAbsOrigin():__sub(target_pos))
				FindClearSpaceForUnit(parent, target_pos:__add(dir:__mul(100)), false)
			end
		end
		if self._shield_buff and IsValid(self._shield_buff) then
			self._shield_buff:Destroy()
			self._shield_buff = nil
		end
	end
	if self._source_bless and self._source_bless:IsValid() then
		self._source_bless:OnAppear(parent)
	end
end
function sl_modifier_bless_21004.prototype.SetShieldBuff(self, buff)
	self._shield_buff = buff
end
function sl_modifier_bless_21004.prototype.SetFollowTargetAndSourceBless(self, target, source_bless)
	self._follow_target = target
	self._source_bless = source_bless
	self:StartIntervalThink(0.1)
end
function sl_modifier_bless_21004.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValidAlive(self._follow_target) then
		parent:SetAbsOrigin(self._follow_target:GetAbsOrigin())
	else
		self:Destroy()
	end
end
sl_modifier_bless_21004 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21004", nil, getfenv()) },
	sl_modifier_bless_21004
)
____exports.sl_modifier_bless_21004 = sl_modifier_bless_21004
____exports.sl_modifier_bless_21004_cd = __TS__Class()
local sl_modifier_bless_21004_cd = ____exports.sl_modifier_bless_21004_cd
sl_modifier_bless_21004_cd.name = "sl_modifier_bless_21004_cd"
__TS__ClassExtends(sl_modifier_bless_21004_cd, SLModifierBase)
function sl_modifier_bless_21004_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21004_cd.prototype.GetTexture(self)
	return "buff/bless/21004"
end
sl_modifier_bless_21004_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21004", nil, getfenv()) },
	sl_modifier_bless_21004_cd
)
____exports.sl_modifier_bless_21004_cd = sl_modifier_bless_21004_cd
____exports.sl_modifier_bless_21004_shield = __TS__Class()
local sl_modifier_bless_21004_shield = ____exports.sl_modifier_bless_21004_shield
sl_modifier_bless_21004_shield.name = "sl_modifier_bless_21004_shield"
__TS__ClassExtends(sl_modifier_bless_21004_shield, sl_modifier_shield_all)
function sl_modifier_bless_21004_shield.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_SUPER_ULTRA
end
function sl_modifier_bless_21004_shield.prototype.CheckState(self)
	return { [MODIFIER_STATE_DEBUFF_IMMUNE] = true }
end
function sl_modifier_bless_21004_shield.prototype.SetBlessHideBuff(self, buff)
	self._bless_hide_buff = buff
end
function sl_modifier_bless_21004_shield.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._bless_hide_buff and IsValid(self._bless_hide_buff) then
		self._bless_hide_buff:Destroy()
		self._bless_hide_buff = nil
	end
end
function sl_modifier_bless_21004_shield.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.debuff_immune
end
function sl_modifier_bless_21004_shield.prototype.GetStatusEffectName(self)
	return GENERIC_PARTICLES.debuff_immune_status_effect
end
function sl_modifier_bless_21004_shield.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_SUPER_ULTRA
end
sl_modifier_bless_21004_shield = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21004", nil, getfenv()) },
	sl_modifier_bless_21004_shield
)
____exports.sl_modifier_bless_21004_shield = sl_modifier_bless_21004_shield
return ____exports