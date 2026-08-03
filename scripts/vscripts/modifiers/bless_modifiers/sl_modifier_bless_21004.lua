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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21004") },
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21004") },
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21004") },
	sl_modifier_bless_21004_shield
)
____exports.sl_modifier_bless_21004_shield = sl_modifier_bless_21004_shield
return ____exports