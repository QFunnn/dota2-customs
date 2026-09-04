--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifierMotionHorizontal_CS = ____modifier_base.BaseModifierMotionHorizontal_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local BLINK_RANGE = 1000
local DASH_DURATION = 0.3
local FACE_SEARCH_RADIUS = 2000
--- 获取最近敌方英雄
local function getNearestEnemyHero(self, unit)
	if not IsValidAlive(nil, unit) then
		return nil
	end
	local list = FindUnitsInRadius(
		unit:GetTeamNumber(),
		unit:GetAbsOrigin(),
		nil,
		FACE_SEARCH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local nearest = nil
	local minDist = FACE_SEARCH_RADIUS + 1
	for ____, u in ipairs(list) do
		do
			if not IsValidAlive(nil, u) then
				goto __continue4
			end
			if not u.IsAlive or not u:IsAlive() then
				goto __continue4
			end
			local d = GetDistance(nil, u:GetAbsOrigin(), unit:GetAbsOrigin())
			if d < minDist then
				minDist = d
				nearest = u
			end
		end
		::__continue4::
	end
	return nearest
end
--- Boss 闪现：POINT，持续位移到目标方向（与英雄冲刺同逻辑与特效），落地后面向最近玩家。
____exports.boss_007 = __TS__Class()
local boss_007 = ____exports.boss_007
boss_007.name = "boss_007"
__TS__ClassExtends(boss_007, MonsterAbility_CS)
function boss_007.prototype.GetBehavior(self)
	return DOTA_ABILITY_BEHAVIOR_POINT
end
function boss_007.prototype.GetCastRange(self, _location, _target)
	return BLINK_RANGE
end
function boss_007.prototype.GetCastPoint(self)
	return 0
end
function boss_007.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local pos = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()
	local dir = GetDirection(nil, pos, origin)
	local dist = math.min(GetDistance(nil, pos, origin), BLINK_RANGE)
	____exports.modifier_boss_007_dash:applys(
		caster,
		caster,
		self,
		{ distance = dist, dir = dir, duration = DASH_DURATION }
	)
end
boss_007 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_007)
____exports.boss_007 = boss_007
--- Boss 闪现位移：与英雄冲刺相同逻辑与特效（水平位移 + 推杖音效 + 粒子），落地后面向最近玩家。
____exports.modifier_boss_007_dash = __TS__Class()
local modifier_boss_007_dash = ____exports.modifier_boss_007_dash
modifier_boss_007_dash.name = "modifier_boss_007_dash"
__TS__ClassExtends(modifier_boss_007_dash, BaseModifierMotionHorizontal_CS)
function modifier_boss_007_dash.prototype.____constructor(self, ...)
	BaseModifierMotionHorizontal_CS.prototype.____constructor(self, ...)
	self.moved = 0
end
function modifier_boss_007_dash.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.distance = kv.distance
	local duration = kv.duration
	self.direction = StringToVector(nil, kv.dir)
	self.speed = self.distance / duration
	self._parent:EmitSound("DOTA_Item.ForceStaff.Activate")
	if self.distance > 0 and not self:ApplyHorizontalMotionController() then
		self._parent:StopSound("DOTA_Item.ForceStaff.Activate")
		self:Destroy()
	end
end
function modifier_boss_007_dash.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveHorizontalMotionController(self)
end
function modifier_boss_007_dash.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_boss_007_dash.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_boss_007_dash.prototype.GetActivityTranslationModifiers(self)
	return "forcestaff_friendly"
end
function modifier_boss_007_dash.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_boss_007_dash.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_007_dash.prototype.UpdateHorizontalMotion(self, me, dt)
	if not IsValid(nil, me) or me:IsNull() then
		self:Destroy()
		return
	end
	local step = self.speed * dt
	local pos = me:GetOrigin() + self.direction * step
	if not GridNav:CanFindPath(me:GetOrigin(), pos) then
		pos = me:GetOrigin()
	end
	if self.moved + step >= self.distance then
		local remain = self.distance - self.moved
		local finalPos = me:GetOrigin() + self.direction * remain
		finalPos.z = GetGroundHeight(finalPos, me) or finalPos.z
		me:SetOrigin(finalPos)
		local hero = getNearestEnemyHero(nil, me)
		if IsValidAlive(nil, hero) then
			local dirToHero = GetDirection(nil, hero:GetAbsOrigin(), me:GetAbsOrigin())
			local angles = VectorToAngles(dirToHero)
			me:SetAbsAngles(angles.x, angles.y, angles.z)
		else
			local angles = VectorToAngles(self.direction)
			me:SetAbsAngles(angles.x, angles.y, angles.z)
		end
		self:Destroy()
		return
	end
	self.moved = self.moved + step
	local angles = VectorToAngles(self.direction)
	me:SetAbsAngles(angles.x, angles.y, angles.z)
	me:SetOrigin(pos)
end
function modifier_boss_007_dash.prototype.OnHorizontalMotionInterrupted(self)
	self._parent:StopSound("DOTA_Item.ForceStaff.Activate")
	self:Destroy()
end
function modifier_boss_007_dash.prototype.IsHidden(self)
	return true
end
function modifier_boss_007_dash.prototype.GetEffectName(self)
	return "particles/econ/items/vengeful/vengeful_arcana/vengeful_arcana_forcestaff_v3.vpcf"
end
modifier_boss_007_dash = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_007_dash)
____exports.modifier_boss_007_dash = modifier_boss_007_dash
return ____exports