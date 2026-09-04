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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local BOSS_KEZ_5_TOTAL_DURATION = 5
local BOSS_KEZ_5_DRAW_ANIMATION = "loadout_spawn_draw_spin"
local BOSS_KEZ_5_PRESSURE_START_TIME = 0.7
local BOSS_KEZ_5_FIRST_SLASH_TIME = 3.27
local BOSS_KEZ_5_FIRST_SLASH_END_TIME = 3.57
local BOSS_KEZ_5_DASH_TIME = 3.8
local BOSS_KEZ_5_DASH_END_TIME = 4
local BOSS_KEZ_5_DASH_SEARCH_RANGE = 2500
local BOSS_KEZ_5_DASH_STOP_DISTANCE = 200
local BOSS_KEZ_5_DASH_FORWARD_DISTANCE = 800
local BOSS_KEZ_5_DOWN_SLASH_TIME = 4.17
local BOSS_KEZ_5_DOWN_SLASH_END_TIME = 4.4
local BOSS_KEZ_5_SLASH_RADIUS = 600
local BOSS_KEZ_5_DOWN_SLASH_DISTANCE = 1000
local BOSS_KEZ_5_HORIZONTAL_PARTICLE = "particles/units/kez_hungering_blades.vpcf"
local BOSS_KEZ_5_VERTICAL_PARTICLE = "particles/cc/simayi_strike_line_hit.vpcf"
local BOSS_KEZ_5_PULL_RADIUS = 1500
local BOSS_KEZ_5_PULL_TARGET_RADIUS = 800
local BOSS_KEZ_5_PULL_MIN_SPEED = 80
local BOSS_KEZ_5_PULL_MAX_SPEED = 650
local BOSS_KEZ_5_CHANNEL_PARTICLE = "particles/units/heroes/hero_kez/kez_hungering_blades_channel.vpcf"
local BOSS_KEZ_5_PULL_PARTICLE = "particles/units/kez_003.vpcf"
____exports.boss_kez_5 = __TS__Class()
local boss_kez_5 = ____exports.boss_kez_5
boss_kez_5.name = "boss_kez_5"
__TS__ClassExtends(boss_kez_5, MonsterAbility_CS)
function boss_kez_5.prototype.Precache(self, context)
	PrecacheResource("particle", BOSS_KEZ_5_HORIZONTAL_PARTICLE, context)
	PrecacheResource("particle", BOSS_KEZ_5_VERTICAL_PARTICLE, context)
	PrecacheResource("particle", BOSS_KEZ_5_CHANNEL_PARTICLE, context)
	PrecacheResource("particle", BOSS_KEZ_5_PULL_PARTICLE, context)
end
function boss_kez_5.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0,
		castDuration = BOSS_KEZ_5_TOTAL_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = "",
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:SetAnimation(BOSS_KEZ_5_DRAW_ANIMATION)
			EmitSoundOn("Hero_Kez.Katana.Draw", caster)
			self:Timer(BOSS_KEZ_5_PRESSURE_START_TIME, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				____exports.modifier_boss_kez_5_pressure:applys(
					caster,
					caster,
					self,
					{ duration = BOSS_KEZ_5_FIRST_SLASH_TIME - BOSS_KEZ_5_PRESSURE_START_TIME }
				)
			end)
			self:Timer(BOSS_KEZ_5_FIRST_SLASH_TIME, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:PlayHorizontalSlash()
			end)
			self:Timer(BOSS_KEZ_5_DASH_TIME, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:DashToSlashPoint()
			end)
			self:Timer(BOSS_KEZ_5_DOWN_SLASH_TIME, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:PlayVerticalSlash()
			end)
		end,
	}
end
function boss_kez_5.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_boss_kez_5_stance.name
end
function boss_kez_5.prototype.PlayHorizontalSlash(self)
	local caster = self:GetCaster()
	local pfx = ParticleManager:CreateParticle(BOSS_KEZ_5_HORIZONTAL_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControlTransformForward(pfx, 0, caster:GetAbsOrigin(), -caster:GetRightVector())
	ParticleManager:SetParticleControl(pfx, 2, Vector(BOSS_KEZ_5_SLASH_RADIUS, 1, 1))
	ParticleManager:ReleaseParticleIndex(pfx)
	self:Timer(FrameTime() * 5, function()
		local pfx = ParticleManager:CreateParticle(BOSS_KEZ_5_HORIZONTAL_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControlTransformForward(pfx, 0, caster:GetAbsOrigin(), caster:GetRightVector())
		ParticleManager:SetParticleControl(pfx, 2, Vector(BOSS_KEZ_5_SLASH_RADIUS, 0, 1))
		ParticleManager:ReleaseParticleIndex(pfx)
		EmitSoundOn("Hero_Kez.RaptorDance.Katana.Slash", caster)
		EmitSoundOn("Hero_Kez.RaptorDance.Katana.Slash.Layer", caster)
	end)
	self:Timer(FrameTime() * 10, function()
		local pfx = ParticleManager:CreateParticle(BOSS_KEZ_5_HORIZONTAL_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControlTransformForward(pfx, 0, caster:GetAbsOrigin(), caster:GetRightVector())
		ParticleManager:SetParticleControl(pfx, 2, Vector(BOSS_KEZ_5_SLASH_RADIUS, 1, 1))
		ParticleManager:ReleaseParticleIndex(pfx)
		EmitSoundOn("Hero_Kez.RaptorDance.Katana.Slash", caster)
		EmitSoundOn("Hero_Kez.RaptorDance.Katana.Slash.Layer", caster)
	end)
	EmitSoundOn("Hero_Kez.RaptorDance.Katana.Slash", caster)
	EmitSoundOn("Hero_Kez.RaptorDance.Katana.Slash.Layer", caster)
end
function boss_kez_5.prototype.DashToSlashPoint(self)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local target = caster:GetMinDistanceUnit(BOSS_KEZ_5_DASH_SEARCH_RANGE)
	local dashDuration = BOSS_KEZ_5_DASH_END_TIME - BOSS_KEZ_5_DASH_TIME
	local targetPos
	if target and IsValidAlive(nil, target) then
		local targetOrigin = target:GetAbsOrigin()
		local toTarget = targetOrigin:__sub(origin)
		local distance = toTarget:Length2D()
		local ____temp_0
		if distance > 1 then
			____temp_0 = toTarget:Normalized()
		else
			____temp_0 = caster:GetForwardVector()
		end
		local direction = ____temp_0
		local dashDistance = math.max(0, distance - BOSS_KEZ_5_DASH_STOP_DISTANCE)
		targetPos = origin:__add(direction:__mul(dashDistance))
		caster:SetForwardVector(direction)
	else
		targetPos = origin:__add(caster:GetForwardVector():__mul(BOSS_KEZ_5_DASH_FORWARD_DISTANCE))
	end
	targetPos.z = GetGroundHeight(targetPos, caster)
	caster:Mover(targetPos, dashDuration)
end
function boss_kez_5.prototype.PlayVerticalSlash(self)
	local caster = self:GetCaster()
	local startPos = caster:GetAbsOrigin()
	local endPos = startPos:__add(caster:GetForwardVector():__mul(BOSS_KEZ_5_DOWN_SLASH_DISTANCE))
	endPos.z = GetGroundHeight(endPos, caster)
	local pfx = ParticleManager:CreateParticle(BOSS_KEZ_5_VERTICAL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, startPos)
	ParticleManager:SetParticleControl(pfx, 1, endPos)
	ParticleManager:SetParticleControl(pfx, 2, startPos)
	ParticleManager:SetParticleControl(pfx, 3, Vector(BOSS_KEZ_5_DOWN_SLASH_DISTANCE, 1, 1))
	ParticleManager:SetParticleControl(pfx, 6, startPos)
	ParticleManager:SetParticleControl(pfx, 11, Vector(BOSS_KEZ_5_DOWN_SLASH_DISTANCE, 1, 1))
	ParticleManager:SetParticleControl(pfx, 20, startPos)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn("Hero_Kez.EchoSlash.Slash", caster)
end
boss_kez_5 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_kez_5)
____exports.boss_kez_5 = boss_kez_5
____exports.modifier_boss_kez_5_pressure = __TS__Class()
local modifier_boss_kez_5_pressure = ____exports.modifier_boss_kez_5_pressure
modifier_boss_kez_5_pressure.name = "modifier_boss_kez_5_pressure"
__TS__ClassExtends(modifier_boss_kez_5_pressure, BaseModifier_CS)
function modifier_boss_kez_5_pressure.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:CreatePressureEffects()
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_kez_5_pressure.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	self:PullEnemies(caster)
end
function modifier_boss_kez_5_pressure.prototype.CreatePressureEffects(self)
	local caster = self:GetCaster()
	local pullPfx = ParticleManager:CreateParticle(BOSS_KEZ_5_PULL_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pullPfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(
		pullPfx,
		1,
		Vector(BOSS_KEZ_5_PULL_RADIUS, BOSS_KEZ_5_PULL_RADIUS, BOSS_KEZ_5_PULL_RADIUS)
	)
	self:AddParticle(pullPfx, false, false, -1, false, false)
end
function modifier_boss_kez_5_pressure.prototype.PullEnemies(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local casterPos = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		casterPos,
		nil,
		BOSS_KEZ_5_PULL_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue30
			end
			if not self:IsValidEnemy(enemy) then
				goto __continue30
			end
			local enemyPos = enemy:GetAbsOrigin()
			local toCaster = casterPos:__sub(enemyPos)
			local distance = toCaster:Length2D()
			if distance <= BOSS_KEZ_5_PULL_TARGET_RADIUS then
				goto __continue30
			end
			local pullProgress = math.min(
				1,
				math.max(
					0,
					(distance - BOSS_KEZ_5_PULL_TARGET_RADIUS)
						/ (BOSS_KEZ_5_PULL_RADIUS - BOSS_KEZ_5_PULL_TARGET_RADIUS)
				)
			)
			local pullSpeed = BOSS_KEZ_5_PULL_MIN_SPEED
				+ (BOSS_KEZ_5_PULL_MAX_SPEED - BOSS_KEZ_5_PULL_MIN_SPEED) * pullProgress
			local moveDistance = math.min(pullSpeed * FrameTime(), distance - BOSS_KEZ_5_PULL_TARGET_RADIUS)
			local nextPos = enemyPos:__add(toCaster:Normalized():__mul(moveDistance))
			nextPos.z = GetGroundHeight(nextPos, enemy)
			enemy:SetAbsOrigin(nextPos)
		end
		::__continue30::
	end
end
function modifier_boss_kez_5_pressure.prototype.IsValidEnemy(self, unit)
	if not unit or not IsValidAlive(nil, unit) then
		return false
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return false
	end
	if unit:GetTeamNumber() == caster:GetTeamNumber() then
		return false
	end
	local ____this_2
	____this_2 = unit
	local ____opt_1 = ____this_2.GetUnitType
	local unitType = ____opt_1 and ____opt_1(____this_2)
	return unitType ~= UnitType.BUILDING and unitType ~= UnitType.DESTRUCTIBLE
end
function modifier_boss_kez_5_pressure.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
modifier_boss_kez_5_pressure = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_kez_5_pressure)
____exports.modifier_boss_kez_5_pressure = modifier_boss_kez_5_pressure
____exports.modifier_boss_kez_5_stance = __TS__Class()
local modifier_boss_kez_5_stance = ____exports.modifier_boss_kez_5_stance
modifier_boss_kez_5_stance.name = "modifier_boss_kez_5_stance"
__TS__ClassExtends(modifier_boss_kez_5_stance, BaseModifier_CS)
function modifier_boss_kez_5_stance.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.isSaiStance = false
end
function modifier_boss_kez_5_stance.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.isSaiStance = false
end
function modifier_boss_kez_5_stance.prototype.SwitchStance(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if not self.isSaiStance then
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 1)
		EmitSoundOn("Hero_Kez.Sai.Draw", caster)
	else
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 1)
		EmitSoundOn("Hero_Kez.Katana.Draw", caster)
	end
	self.isSaiStance = not self.isSaiStance
	self:ForceRefresh()
end
function modifier_boss_kez_5_stance.prototype.IsSaiStance(self)
	return self.isSaiStance
end
function modifier_boss_kez_5_stance.prototype.IsKatanaStance(self)
	return not self.isSaiStance
end
function modifier_boss_kez_5_stance.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_boss_kez_5_stance.prototype.GetActivityTranslationModifiers(self)
	return self.isSaiStance and "kunai" or ""
end
function modifier_boss_kez_5_stance.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
modifier_boss_kez_5_stance = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_kez_5_stance)
____exports.modifier_boss_kez_5_stance = modifier_boss_kez_5_stance
return ____exports