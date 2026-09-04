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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local STAB_PARTICLE = "particles/riki_immortal_ti6_blinkstrike_stab_2_ice.vpcf"
local STAB_NARROW_PARTICLE = "particles/riki_immortal_ti6_blinkstrike_stab_2_ice.vpcf"
local STAB_CAST_SOUND = "Hero_Pangolier.Swashbuckle.Cast"
local STAB_HIT_SOUND = "Hero_Pangolier.Swashbuckle.Damage"
local DEFAULT_LOCK_RANGE = 1000
local CAST_POINT = 1
local STAB_RANGE = 520
local STAB_WIDTH = 160
local STAB_COUNT = 3
local STAB_INTERVAL = 1
local DAMAGE_RATE = 18
local KNOCKBACK_DISTANCE = 80
local FINAL_KNOCKBACK_DISTANCE = 160
local KNOCKBACK_DURATION = 0.2
local STAB_START_OFFSET = 80
local STAB_ANIMATION_PLAYBACK_RATE = 1
local STAB_DASH_DISTANCE = 120
local STAB_DASH_DURATION = 0.16
--- 精英技能141 - 瞄准蓄力后朝正前方连续三段戳击。
____exports.elite_141 = __TS__Class()
local elite_141 = ____exports.elite_141
elite_141.name = "elite_141"
__TS__ClassExtends(elite_141, MonsterAbility_CS)
function elite_141.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castToken = 0
end
function elite_141.prototype.Precache(self, context)
	PrecacheResource("particle", STAB_PARTICLE, context)
	PrecacheResource("particle", STAB_NARROW_PARTICLE, context)
end
function elite_141.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = STAB_RANGE,
		castPoint = CAST_POINT,
		castDuration = self:GetCastDurationAfterPoint(),
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		animationPlaybackRate = 0.8,
		OnPhaseStart = function()
			return self:OnAimStart()
		end,
		OnStart = function()
			return self:StartStabChain()
		end,
		OnInterrupt = function()
			return self:StopStabChain()
		end,
		OnFinish = function()
			return self:StopStabChain()
		end,
	}
end
function elite_141.prototype.OnAimStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local lockRange = math.max(DEFAULT_LOCK_RANGE, STAB_RANGE)
	local target = caster:GetMinDistanceUnit(lockRange)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 4)
	end
	local origin = caster:GetAbsOrigin()
	local endPos = origin:__add(self:GetFlatForward(caster):__mul(STAB_RANGE))
	self:WarningEffect(origin, endPos, CAST_POINT, {
		startWidth = STAB_WIDTH,
		endWidth = STAB_WIDTH,
		getDirection = function()
			return self:GetFlatForward(caster)
		end,
	})
end
function elite_141.prototype.StartStabChain(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.castToken = self.castToken + 1
	local token = self.castToken
	EmitSoundOn(STAB_CAST_SOUND, caster)
	local stabCount = math.max(1, math.floor(STAB_COUNT))
	local interval = STAB_INTERVAL
	do
		local index = 0
		while index < stabCount do
			local currentIndex = index
			local currentDelay = currentIndex * interval
			local isLast = currentIndex == stabCount - 1
			self:Timer(currentDelay, function()
				if not self:IsTokenValid(token) then
					return
				end
				self:ExecuteStab(caster, currentIndex, isLast)
			end)
			index = index + 1
		end
	end
end
function elite_141.prototype.StopStabChain(self)
	self.castToken = self.castToken + 1
end
function elite_141.prototype.ExecuteStab(self, caster, index, isLast)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_1)
	caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 0.05, 0.2, STAB_ANIMATION_PLAYBACK_RATE)
	local origin = caster:GetAbsOrigin()
	local direction = self:GetFlatForward(caster)
	local range = 300
	local width = STAB_WIDTH
	local startPos = origin:__add(direction:__mul(STAB_START_OFFSET))
	local endPos = startPos:__add(direction:__mul(range))
	local particleName = index == 0 and STAB_NARROW_PARTICLE or STAB_PARTICLE
	self:DashForward(caster, origin, direction)
	self:Timer(0.2, function()
		self:PlayStabEffect(caster, startPos, range, width, particleName, direction)
		self:DamageStabLine(caster, startPos, endPos, width, direction, isLast)
	end)
end
function elite_141.prototype.DashForward(self, caster, origin, direction)
	local targetPos = GetGroundPosition(origin:__add(direction:__mul(300)), caster)
	caster:Mover(targetPos, STAB_DASH_DURATION, nil, true, true)
end
function elite_141.prototype.PlayStabEffect(self, caster, startPos, range, width, particleName, direction)
	local groundStart = GetGroundPosition(startPos, caster)
	local pfx = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, groundStart)
	ParticleManager:SetParticleControl(pfx, 1, Vector(range, width, 0))
	ParticleManager:SetParticleControlForward(pfx, 0, direction)
	ParticleManager:SetParticleControlTransformForward(pfx, 0, groundStart, direction)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_141.prototype.DamageStabLine(self, caster, startPos, endPos, width, direction, isLast)
	local center = startPos:__add(endPos):__mul(0.5)
	local range = startPos:__sub(endPos):Length2D()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		range * 0.5 + width,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local hitRecord = {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue24
			end
			if not self:IsEnemyInStabLine(enemy, startPos, direction, range, width) then
				goto __continue24
			end
			local enemyIndex = enemy:entindex()
			if hitRecord[enemyIndex] then
				goto __continue24
			end
			hitRecord[enemyIndex] = true
			EmitSoundOn(STAB_HIT_SOUND, enemy)
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self, damage_type = 1 })
			enemy:KnockBack(caster, self, {
				direction = direction,
				distance = isLast and FINAL_KNOCKBACK_DISTANCE or KNOCKBACK_DISTANCE,
				duration = KNOCKBACK_DURATION,
				height = 0,
				destroyTreesType = "onDestroy",
				block = true,
				blockUntraversable = true,
			})
		end
		::__continue24::
	end
end
function elite_141.prototype.IsEnemyInStabLine(self, enemy, startPos, direction, range, width)
	if not IsValidAlive(nil, enemy) then
		return false
	end
	local delta = enemy:GetAbsOrigin():__sub(startPos)
	local forwardDistance = delta.x * direction.x + delta.y * direction.y
	if forwardDistance < 0 or forwardDistance > range then
		return false
	end
	local sideX = delta.x - direction.x * forwardDistance
	local sideY = delta.y - direction.y * forwardDistance
	return math.sqrt(sideX * sideX + sideY * sideY) <= width * 0.5
end
function elite_141.prototype.GetFlatForward(self, caster)
	local forward = caster:GetForwardVector()
	local flat = Vector(forward.x, forward.y, 0)
	if flat:Length2D() <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:Normalized()
end
function elite_141.prototype.GetCastDurationAfterPoint(self)
	local stabCount = math.max(1, math.floor(STAB_COUNT))
	local interval = STAB_INTERVAL
	local knockbackDuration = KNOCKBACK_DURATION
	return interval * (stabCount - 1) + knockbackDuration + 0.2
end
function elite_141.prototype.IsTokenValid(self, token)
	return token == self.castToken and not self:IsNull()
end
elite_141 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_141)
____exports.elite_141 = elite_141
return ____exports