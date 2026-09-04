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
local modifier_elite_042_attack_speed_buff
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_042_TOTAL_ACTION_TIME = 2.6
local ELITE_042_CAST_POINT = 1.3
local ELITE_042_CAST_DURATION = ELITE_042_TOTAL_ACTION_TIME - ELITE_042_CAST_POINT
local ELITE_042_LAND_RADIUS = 850
local ELITE_042_LAND_STUN_DURATION = 1.5
local ELITE_042_GROUND_DURATION = 15
local ELITE_042_ATTACK_SPEED_BUFF_DURATION = ELITE_042_GROUND_DURATION
local ELITE_042_ATTACK_SPEED_BUFF_PCT = 100
local ELITE_042_LAND_PARTICLE = "particles/unit/elite_042.vpcf"
local ELITE_042_LAND_SOUND = "Hero_Mars.ArenaOfBlood.Start"
--- 精英技能42 - 原地施法创建禁逃阻碍区域
____exports.elite_042 = __TS__Class()
local elite_042 = ____exports.elite_042
elite_042.name = "elite_042"
__TS__ClassExtends(elite_042, MonsterAbility_CS)
function elite_042.prototype.Precache(self, context)
	PrecacheResource("particle", ELITE_042_LAND_PARTICLE, context)
end
function elite_042.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = ELITE_042_CAST_POINT,
		castDuration = ELITE_042_CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		isNotMove = true,
		canCast = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return UF_FAIL_CUSTOM
			end
			if modifier_elite_042_attack_speed_buff:find_on(caster) then
				return UF_FAIL_CUSTOM
			end
			return UF_SUCCESS
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local center = caster:GetAbsOrigin()
			center.z = GetGroundHeight(center, caster) or center.z
			self:PlayLandingImpact(caster, center)
		end,
	}
end
function elite_042.prototype.PlayLandingImpact(self, caster, center)
	if not IsValidAlive(nil, caster) then
		return
	end
	modifier_elite_042_attack_speed_buff:applys(
		caster,
		caster,
		self,
		{ duration = ELITE_042_ATTACK_SPEED_BUFF_DURATION }
	)
	local pfx = ParticleManager:CreateParticle(ELITE_042_LAND_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, center)
	ParticleManager:SetParticleControl(
		pfx,
		1,
		Vector(ELITE_042_LAND_RADIUS - 50, ELITE_042_LAND_RADIUS, ELITE_042_LAND_RADIUS)
	)
	ParticleManager:SetParticleControl(pfx, 2, center)
	Timers:CreateTimer(ELITE_042_GROUND_DURATION, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
	EmitSoundOnLocationWithCaster(center, ELITE_042_LAND_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		ELITE_042_LAND_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue12
			end
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.STUN,
				{ duration = ELITE_042_LAND_STUN_DURATION }
			)
		end
		::__continue12::
	end
	CreateModifierThinker(caster, self, "modifier_elite_042_ground_thinker", {
		duration = ELITE_042_GROUND_DURATION,
		radius = ELITE_042_LAND_RADIUS,
		center_x = center.x,
		center_y = center.y,
		center_z = center.z,
	}, center, caster:GetTeamNumber(), false)
end
elite_042 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_042)
____exports.elite_042 = elite_042
modifier_elite_042_attack_speed_buff = __TS__Class()
modifier_elite_042_attack_speed_buff.name = "modifier_elite_042_attack_speed_buff"
__TS__ClassExtends(modifier_elite_042_attack_speed_buff, MonsterModifier_CS)
function modifier_elite_042_attack_speed_buff.prototype.GetAttributeBonus(self)
	return { attack_speed_pct = ELITE_042_ATTACK_SPEED_BUFF_PCT }
end
function modifier_elite_042_attack_speed_buff.prototype.IsPurgable(self)
	return false
end
modifier_elite_042_attack_speed_buff = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_042_attack_speed_buff") },
	modifier_elite_042_attack_speed_buff
)
local modifier_elite_042_ground_thinker = __TS__Class()
modifier_elite_042_ground_thinker.name = "modifier_elite_042_ground_thinker"
__TS__ClassExtends(modifier_elite_042_ground_thinker, MonsterModifier_CS)
function modifier_elite_042_ground_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._radius = ELITE_042_LAND_RADIUS
end
function modifier_elite_042_ground_thinker.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local centerX = params.center_x or self:GetParent():GetAbsOrigin().x
	local centerY = params.center_y or self:GetParent():GetAbsOrigin().y
	local centerZ = params.center_z or self:GetParent():GetAbsOrigin().z
	self._center = Vector(centerX, centerY, centerZ)
	self._radius = params.radius or ELITE_042_LAND_RADIUS
end
function modifier_elite_042_ground_thinker.prototype.IsAura(self)
	return true
end
function modifier_elite_042_ground_thinker.prototype.GetAuraRadius(self)
	return ELITE_042_LAND_RADIUS
end
function modifier_elite_042_ground_thinker.prototype.GetModifierAura(self)
	return "modifier_elite_042_ground_boundary"
end
function modifier_elite_042_ground_thinker.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_elite_042_ground_thinker.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_elite_042_ground_thinker.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_elite_042_ground_thinker.prototype.GetAuraDuration(self)
	return 0.2
end
function modifier_elite_042_ground_thinker.prototype.GetCenter(self)
	return self._center
end
function modifier_elite_042_ground_thinker.prototype.GetRadius(self)
	return self._radius
end
function modifier_elite_042_ground_thinker.prototype.IsHidden(self)
	return true
end
function modifier_elite_042_ground_thinker.prototype.IsPurgable(self)
	return false
end
modifier_elite_042_ground_thinker = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_042_ground_thinker") },
	modifier_elite_042_ground_thinker
)
local modifier_elite_042_ground_boundary = __TS__Class()
modifier_elite_042_ground_boundary.name = "modifier_elite_042_ground_boundary"
__TS__ClassExtends(modifier_elite_042_ground_boundary, MonsterModifier_CS)
function modifier_elite_042_ground_boundary.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._radius = ELITE_042_LAND_RADIUS
end
function modifier_elite_042_ground_boundary.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetCaster()) then
		self:Destroy()
		return
	end
	local thinker = self:GetAuraOwner()
	local ____thinker_0
	if thinker then
		____thinker_0 = modifier_elite_042_ground_thinker:find_on(thinker)
	else
		____thinker_0 = nil
	end
	local aura = ____thinker_0
	self._center = aura and aura:GetCenter()
	self._radius = aura and aura:GetRadius() or ELITE_042_LAND_RADIUS
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not self._center then
		self:Destroy()
		return
	end
	local distance = GetDistance(nil, self._center, parent:GetAbsOrigin())
	local ____opt_5 = parent.GetHullRadius
	local hullRadius = ____opt_5 and ____opt_5(parent) or 0
	local maxCenterDistance = math.max(self._radius - hullRadius, 0)
	if distance >= maxCenterDistance then
		local direction = GetDirection(nil, parent:GetAbsOrigin(), self._center)
		local clampPos = self._center:__add(direction:__mul(maxCenterDistance))
		clampPos.z = GetGroundHeight(clampPos, parent) or clampPos.z
		GridNav:DestroyTreesAroundPoint(clampPos, 50, false)
		FindClearSpaceForUnit(parent, clampPos, true)
		self:Destroy()
		return
	end
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_042_ground_boundary.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetCaster()) then
		self:Destroy()
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not self._center then
		self:Destroy()
		return
	end
	local distance = GetDistance(nil, self._center, parent:GetAbsOrigin())
	local direction = GetDirection(nil, parent:GetAbsOrigin(), self._center)
	local ____opt_7 = parent.GetHullRadius
	local hullRadius = ____opt_7 and ____opt_7(parent) or 0
	local maxCenterDistance = math.max(self._radius - hullRadius, 0)
	if distance > maxCenterDistance then
		local clampPos = self._center:__add(direction:__mul(maxCenterDistance))
		clampPos.z = GetGroundHeight(clampPos, parent) or clampPos.z
		FindClearSpaceForUnit(parent, clampPos, true)
	end
end
function modifier_elite_042_ground_boundary.prototype.IsHidden(self)
	return true
end
function modifier_elite_042_ground_boundary.prototype.IsPurgable(self)
	return false
end
modifier_elite_042_ground_boundary = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_042_ground_boundary") },
	modifier_elite_042_ground_boundary
)
return ____exports