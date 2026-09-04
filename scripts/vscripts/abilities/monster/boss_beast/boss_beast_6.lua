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
local warningEffectRing = ____monster_base.warningEffectRing
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 兽-重踏行进 (boss_beast_6)
local HEAVY_STEPS_ACTIVITY = "heavy_steps"
local HEAVY_STEPS_DURATION = 6
local HEAVY_STEPS_CAST_POINT = 0.74
local HEAVY_STEPS_ROAR_FRAME = 9
local HEAVY_STEPS_INTERVAL = 0.45
local HEAVY_STEPS_MOVE_SPEED = 260
local HEAVY_STEPS_TURN_SPEED = 1.5
local HEAVY_STEPS_DAMAGE_RADIUS = 500
local HEAVY_STEPS_DAMAGE_RATE = 18
local HEAVY_STEPS_ROCK_COUNT = 3
local HEAVY_STEPS_ROCK_RANDOM_RADIUS = 180
local HEAVY_STEPS_ROCK_RADIUS = 200
local HEAVY_STEPS_ROCK_DAMAGE_DELAY = 0.5
local HEAVY_STEPS_ROCK_PFX_LIFETIME = 1.5
local HEAVY_STEPS_ROCK_DAMAGE_RATE = 18
local HEAVY_STEPS_ROCK_PARTICLE = "particles/cb/rock_drop.vpcf"
local HEAVY_STEPS_TRAMPLE_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf"
local HEAVY_STEPS_ROAR_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_debut_roar.vpcf"
____exports.boss_beast_6 = __TS__Class()
local boss_beast_6 = ____exports.boss_beast_6
boss_beast_6.name = "boss_beast_6"
__TS__ClassExtends(boss_beast_6, MonsterAbility_CS)
function boss_beast_6.prototype.Precache(self, context)
	PrecacheResource("particle", HEAVY_STEPS_ROCK_PARTICLE, context)
	PrecacheResource("particle", HEAVY_STEPS_TRAMPLE_PARTICLE, context)
	PrecacheResource("particle", HEAVY_STEPS_ROAR_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tiny.vsndevts", context)
end
function boss_beast_6.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = HEAVY_STEPS_CAST_POINT,
		castDuration = HEAVY_STEPS_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:AddNewModifier(caster, self, "mo_mian_modfier", { duration = HEAVY_STEPS_DURATION + 0.5 })
			self:Timer(FrameTime() * HEAVY_STEPS_ROAR_FRAME, function()
				if not IsValidAlive(nil, caster) or not IsValid(nil, self) or self:IsNull() then
					return
				end
				local roarPfx = ParticleManager:CreateParticle(HEAVY_STEPS_ROAR_PARTICLE, PATTACH_POINT_FOLLOW, caster)
				ParticleManager:SetParticleControlEnt(
					roarPfx,
					0,
					caster,
					PATTACH_POINT_FOLLOW,
					"attach_loadout_roar",
					caster:GetAbsOrigin(),
					true
				)
				Timers:CreateTimer(2, function()
					ParticleManager:DestroyParticle(roarPfx, false)
					ParticleManager:ReleaseParticleIndex(roarPfx)
					return nil
				end)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:AddActivityModifier(HEAVY_STEPS_ACTIVITY)
			caster:StartGestureWithPlaybackRate(ACT_DOTA_RUN, 1)
			caster:AddNewModifier(
				caster,
				self,
				"modifier_boss_beast_6_heavy_steps",
				{ duration = HEAVY_STEPS_DURATION }
			)
		end,
	}
end
boss_beast_6 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_beast_6)
____exports.boss_beast_6 = boss_beast_6
--- 持续行进、拍地伤害和落石调度。
local modifier_boss_beast_6_heavy_steps = __TS__Class()
modifier_boss_beast_6_heavy_steps.name = "modifier_boss_beast_6_heavy_steps"
__TS__ClassExtends(modifier_boss_beast_6_heavy_steps, BaseModifier_CS)
function modifier_boss_beast_6_heavy_steps.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.beatElapsed = 0
	self.initialOrigin = Vector(0, 0, 0)
end
function modifier_boss_beast_6_heavy_steps.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.beatElapsed = 0
	self.initialOrigin = self:GetParent():GetAbsOrigin()
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_beast_6_heavy_steps.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not IsValid(nil, ability) or ability:IsNull() then
		self:Destroy()
		return
	end
	local target = caster:GetMinDistanceUnit(2500)
	if target then
		caster:LockTargetForSpeed(target, FrameTime(), HEAVY_STEPS_TURN_SPEED)
	end
	self:MoveForward(caster)
	self.beatElapsed = self.beatElapsed + FrameTime()
	if self.beatElapsed < HEAVY_STEPS_INTERVAL then
		return
	end
	self.beatElapsed = self.beatElapsed - HEAVY_STEPS_INTERVAL
	self:PlayGroundBeat(caster, ability)
end
function modifier_boss_beast_6_heavy_steps.prototype.MoveForward(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local nextPos = GetGroundPosition(
		caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(HEAVY_STEPS_MOVE_SPEED * FrameTime())),
		caster
	)
	if GridNav:IsTraversable(nextPos) and not GridNav:IsBlocked(nextPos) then
		GridNav:DestroyTreesAroundPoint(nextPos, 120, false)
		caster:SetAbsOrigin(nextPos)
	end
end
function modifier_boss_beast_6_heavy_steps.prototype.PlayGroundBeat(self, caster, ability)
	if not IsValidAlive(nil, caster) then
		return
	end
	local beatOrigin = caster:GetAbsOrigin()
	local tramplePfx = ParticleManager:CreateParticle(HEAVY_STEPS_TRAMPLE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(tramplePfx, 0, beatOrigin)
	ParticleManager:SetParticleControl(tramplePfx, 1, Vector(300, 300, 300))
	ParticleManager:ReleaseParticleIndex(tramplePfx)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		beatOrigin,
		nil,
		HEAVY_STEPS_DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			caster:MonsterDamage({ victim = enemy, damage_rate = HEAVY_STEPS_DAMAGE_RATE, ability = ability })
		end
	end
	do
		local groupIndex = 0
		while groupIndex < HEAVY_STEPS_ROCK_COUNT do
			local groupDelay = FrameTime() * 2 * groupIndex
			local groupPosition = self:GetRandomPointInRadius(self.initialOrigin, 1500, caster)
			self:Timer(groupDelay, function()
				if not IsValidAlive(nil, caster) or not IsValid(nil, ability) or ability:IsNull() then
					return
				end
				do
					local rockIndex = 0
					while rockIndex < HEAVY_STEPS_ROCK_COUNT do
						local rockDelay = FrameTime() * 2 * rockIndex
						self:Timer(rockDelay, function()
							if not IsValidAlive(nil, caster) or not IsValid(nil, ability) or ability:IsNull() then
								return
							end
							local rockPos = GetGroundPosition(
								groupPosition:__add(RandomVector(HEAVY_STEPS_ROCK_RANDOM_RADIUS)),
								caster
							)
							self:SpawnRock(rockPos, caster, ability)
						end)
						rockIndex = rockIndex + 1
					end
				end
			end)
			groupIndex = groupIndex + 1
		end
	end
end
function modifier_boss_beast_6_heavy_steps.prototype.GetRandomPointInRadius(self, origin, radius, caster)
	local angle = RandomFloat(0, 360)
	local distance = math.sqrt(RandomFloat(0, 1)) * radius
	local offset = RotateVector2D(nil, Vector(1, 0, 0), angle):__mul(distance)
	return GetGroundPosition(origin:__add(offset), caster)
end
function modifier_boss_beast_6_heavy_steps.prototype.SpawnRock(self, pos, caster, ability)
	local rockPfx = ParticleManager:CreateParticle(HEAVY_STEPS_ROCK_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(rockPfx, 0, pos)
	ParticleManager:SetParticleControl(
		rockPfx,
		1,
		Vector(HEAVY_STEPS_ROCK_RADIUS, HEAVY_STEPS_ROCK_RADIUS, HEAVY_STEPS_ROCK_RADIUS * 3)
	)
	Timers:CreateTimer(HEAVY_STEPS_ROCK_PFX_LIFETIME, function()
		ParticleManager:DestroyParticle(rockPfx, false)
		ParticleManager:ReleaseParticleIndex(rockPfx)
		return nil
	end)
	warningEffectRing(nil, caster, pos, HEAVY_STEPS_ROCK_RADIUS, HEAVY_STEPS_ROCK_DAMAGE_DELAY)
	EmitSoundOnLocationWithCaster(pos, "Hero_Tiny_Tree.Throw", caster)
	Timers:CreateTimer(HEAVY_STEPS_ROCK_DAMAGE_DELAY, function()
		if not IsValidAlive(nil, caster) or not IsValid(nil, ability) or ability:IsNull() then
			return nil
		end
		EmitSoundOnLocationWithCaster(pos, "Hero_Tiny_Tree.Impact", caster)
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			pos,
			nil,
			HEAVY_STEPS_ROCK_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			if IsValidAlive(nil, enemy) then
				caster:MonsterDamage({ victim = enemy, damage_rate = HEAVY_STEPS_ROCK_DAMAGE_RATE, ability = ability })
			end
		end
		return nil
	end)
end
function modifier_boss_beast_6_heavy_steps.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		caster:RemoveGesture(ACT_DOTA_RUN)
		caster:ClearActivityModifiers()
	end
end
function modifier_boss_beast_6_heavy_steps.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_COMMAND_RESTRICTED] = true }
end
modifier_boss_beast_6_heavy_steps = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_6_heavy_steps)
return ____exports