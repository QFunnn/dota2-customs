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
local modifier_elite_066_crit_aura
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local SEARCH_RANGE = 1200
local CAST_POINT = 1
local CAST_DURATION = 0.5
local PULL_DISTANCE = 180
local PULL_WARNING_RADIUS = 300
local WARNING_DURATION = CAST_POINT
local WARNING_FOLLOW_DURATION = 0.65
local PULL_DURATION = 0.45
local PULL_STUN_DURATION = 1.8
local BUFF_RADIUS = 400
local BUFF_DURATION = 6
local BONUS_CRIT_CHANCE_PCT = 35
local RIFT_SEGMENT_DISTANCE = 400
local SAFE_PULL_ANGLES = {
	0,
	30,
	-30,
	60,
	-60,
	90,
	-90,
	120,
	-120,
	180,
}
local SAFE_PULL_DISTANCES = { PULL_DISTANCE, PULL_DISTANCE - 60, PULL_DISTANCE + 60, 90 }
local REALITY_RIFT_PARTICLE =
	"particles/econ/items/chaos_knight/chaos_knight_ti7_shield/chaos_knight_ti7_reality_rift.vpcf"
local REALITY_RIFT_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_chaos_knight.vsndevts"
local REALITY_RIFT_SOUND = "Hero_ChaosKnight.RealityRift"
local CHAOS_STRIKE_SOUND = "Hero_ChaosKnight.ChaosStrike"
--- 精英技能66 - 现实裂隙：随机拉近一名敌人，并强化周围友军暴击率
____exports.elite_066 = __TS__Class()
local elite_066 = ____exports.elite_066
elite_066.name = "elite_066"
__TS__ClassExtends(elite_066, MonsterAbility_CS)
function elite_066.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castToken = 0
end
function elite_066.prototype.Precache(self, context)
	PrecacheResource("particle", REALITY_RIFT_PARTICLE, context)
	PrecacheResource("soundfile", REALITY_RIFT_SOUND_EVENTS, context)
end
function elite_066.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = SEARCH_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_2,
		canCast = function()
			local ____table_FindRandomEnemy_result_0
			if self:FindRandomEnemy() then
				____table_FindRandomEnemy_result_0 = UF_SUCCESS
			else
				____table_FindRandomEnemy_result_0 = UF_FAIL_CUSTOM
			end
			return ____table_FindRandomEnemy_result_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.castToken = self.castToken + 1
			local target = self:FindRandomEnemy()
			if IsValidAlive(nil, target) then
				local token = self.castToken
				local warningStartTime = GameRules:GetGameTime()
				self.warningTarget = target
				self.warningCenter = self:GetGroundPoint(target:GetAbsOrigin())
				caster:LockTargetForSpeed(target, CAST_POINT)
				self:WarningRingEffect(self.warningCenter, PULL_WARNING_RADIUS, WARNING_DURATION, {
					getCenter = function()
						if self.castToken ~= token then
							return self.warningCenter
						end
						if GameRules:GetGameTime() - warningStartTime >= WARNING_FOLLOW_DURATION then
							return self.warningCenter
						end
						local currentTarget = self.warningTarget
						if currentTarget and IsValidAlive(nil, currentTarget) then
							self.warningCenter = self:GetGroundPoint(currentTarget:GetAbsOrigin())
						end
						return self.warningCenter
					end,
				})
			end
		end,
		OnInterrupt = function()
			self:ClearPullPlan()
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
			local warningCenter = self.warningCenter
			self:ClearPullPlan()
			if warningCenter then
				self:PullEnemiesInWarningCircle(caster, warningCenter)
			end
			modifier_elite_066_crit_aura:applys(caster, caster, self, { duration = BUFF_DURATION })
			EmitSoundOn(CHAOS_STRIKE_SOUND, caster)
		end,
	}
end
function elite_066.prototype.FindRandomEnemy(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		SEARCH_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	if #enemies <= 0 then
		return nil
	end
	return enemies[RandomInt(0, #enemies - 1) + 1]
end
function elite_066.prototype.PullEnemiesInWarningCircle(self, caster, center)
	self:PlayRealityRiftAtPoint(caster, center)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		PULL_WARNING_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue20
			end
			self:PullTargetToCasterFront(enemy)
		end
		::__continue20::
	end
end
function elite_066.prototype.PlayRealityRiftAtPoint(self, caster, point)
	local groundPoint = self:GetGroundPoint(point)
	local direction = GetDirection(nil, caster:GetAbsOrigin(), groundPoint)
	local pfx = ParticleManager:CreateParticle(REALITY_RIFT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, groundPoint)
	ParticleManager:SetParticleControl(pfx, 1, groundPoint)
	ParticleManager:SetParticleControlTransformForward(pfx, 2, groundPoint, direction)
	ParticleManager:SetParticleControlForward(pfx, 2, direction)
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_066.prototype.PullTargetToCasterFront(self, target)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	caster:EmitSound(REALITY_RIFT_SOUND)
	local startPos = target:GetAbsOrigin()
	local pullTargetPos = self:FindSafePullTargetPosition(caster, target)
	if not pullTargetPos then
		return
	end
	self:PlayRealityRiftPath(target, startPos, pullTargetPos)
	AddDeBuffStatus(nil, target, caster, self, DebuffStatusType.STUN, { duration = PULL_STUN_DURATION })
	target:Mover(pullTargetPos, PULL_DURATION, nil, false, true, false)
	self:Timer(PULL_DURATION + 0.03, function()
		if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
			return
		end
		FindClearSpaceForUnit(target, target:GetAbsOrigin(), true)
	end)
	target:SetForwardVector(GetDirection(nil, caster:GetAbsOrigin(), target:GetAbsOrigin()))
end
function elite_066.prototype.FindSafePullTargetPosition(self, caster, target)
	local casterOrigin = self:GetGroundPoint(caster:GetAbsOrigin())
	local targetOrigin = self:GetGroundPoint(target:GetAbsOrigin())
	local forward = caster:GetForwardVector():Normalized()
	for ____, distance in ipairs(SAFE_PULL_DISTANCES) do
		local currentDistance = distance
		for ____, angle in ipairs(SAFE_PULL_ANGLES) do
			local currentAngle = angle
			local direction = RotateVector2D(nil, forward, currentAngle):Normalized()
			local rawPos = casterOrigin:__add(direction:__mul(currentDistance))
			local point = self:GetGroundPoint(rawPos)
			if self:IsValidPullTargetPosition(targetOrigin, casterOrigin, point) then
				return point
			end
		end
	end
	return nil
end
function elite_066.prototype.IsValidPullTargetPosition(self, targetOrigin, casterOrigin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(targetOrigin, point) then
		return false
	end
	if GridNav:FindPathLength(targetOrigin, point) == -1 then
		return false
	end
	if IsGridNavDisplacementWalkable(nil, casterOrigin) then
		if not GridNav:CanFindPath(casterOrigin, point) then
			return false
		end
		if GridNav:FindPathLength(casterOrigin, point) == -1 then
			return false
		end
	end
	return true
end
function elite_066.prototype.ClearPullPlan(self)
	self.castToken = self.castToken + 1
	self.warningTarget = nil
	self.warningCenter = nil
end
function elite_066.prototype.PlayRealityRiftPath(self, target, startPos, endPos)
	local direction = GetDirection(nil, endPos, startPos)
	local distance = GetDistance(nil, startPos, endPos)
	if distance <= 0 then
		self:PlayRealityRiftSegment(target, startPos, endPos, direction)
		return
	end
	do
		local traveled = 0
		while traveled < distance do
			local nextTraveled = math.min(traveled + RIFT_SEGMENT_DISTANCE, distance)
			local segmentStart = startPos:__add(direction:__mul(traveled))
			local segmentEnd = startPos:__add(direction:__mul(nextTraveled))
			self:PlayRealityRiftSegment(
				target,
				self:GetGroundPoint(segmentStart),
				self:GetGroundPoint(segmentEnd),
				direction
			)
			traveled = traveled + RIFT_SEGMENT_DISTANCE
		end
	end
end
function elite_066.prototype.PlayRealityRiftSegment(self, target, startPoint, endPoint, direction)
	local pfx = ParticleManager:CreateParticle(REALITY_RIFT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(pfx, 0, endPoint)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		2,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlTransformForward(pfx, 2, startPoint, direction)
	ParticleManager:SetParticleControlForward(pfx, 2, direction)
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_066.prototype.GetGroundPoint(self, pos)
	local caster = self:GetCaster()
	local groundZ = GetGroundHeight(pos, caster) or pos.z
	return Vector(pos.x, pos.y, groundZ)
end
elite_066 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_066)
____exports.elite_066 = elite_066
modifier_elite_066_crit_aura = __TS__Class()
modifier_elite_066_crit_aura.name = "modifier_elite_066_crit_aura"
__TS__ClassExtends(modifier_elite_066_crit_aura, MonsterModifier_CS)
function modifier_elite_066_crit_aura.prototype.GetModifierAura(self)
	return "modifier_elite_066_crit_buff"
end
function modifier_elite_066_crit_aura.prototype.GetAuraRadius(self)
	return BUFF_RADIUS
end
function modifier_elite_066_crit_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_elite_066_crit_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_elite_066_crit_aura.prototype.IsAura(self)
	return true
end
function modifier_elite_066_crit_aura.prototype.IsHidden(self)
	return false
end
function modifier_elite_066_crit_aura.prototype.IsPurgable(self)
	return false
end
function modifier_elite_066_crit_aura.prototype.GetTexture(self)
	return "chaos_knight_chaos_strike"
end
function modifier_elite_066_crit_aura.GetLocalizationCN(self)
	return { name = "混沌裂隙", description = "自身周围友军获得暴击提升。" }
end
modifier_elite_066_crit_aura =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_066_crit_aura") }, modifier_elite_066_crit_aura)
local modifier_elite_066_crit_buff = __TS__Class()
modifier_elite_066_crit_buff.name = "modifier_elite_066_crit_buff"
__TS__ClassExtends(modifier_elite_066_crit_buff, MonsterModifier_CS)
function modifier_elite_066_crit_buff.prototype.GetAttributeBonus(self)
	return { crit_chance_pct = BONUS_CRIT_CHANCE_PCT }
end
function modifier_elite_066_crit_buff.prototype.IsHidden(self)
	return false
end
function modifier_elite_066_crit_buff.prototype.IsPurgable(self)
	return true
end
function modifier_elite_066_crit_buff.prototype.IsDebuff(self)
	return false
end
function modifier_elite_066_crit_buff.prototype.GetTexture(self)
	return "chaos_knight_chaos_strike"
end
function modifier_elite_066_crit_buff.GetLocalizationCN(self)
	return { name = "混沌暴击", description = "暴击提升。" }
end
modifier_elite_066_crit_buff =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_066_crit_buff") }, modifier_elite_066_crit_buff)
return ____exports