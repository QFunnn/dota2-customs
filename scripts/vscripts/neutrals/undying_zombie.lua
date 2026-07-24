--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local BUCKET_SOLDIER_STATE_IDLE				= 0
local BUCKET_SOLDIER_STATE_ATTACKING		= 1
local BUCKET_SOLDIER_STATE_LEASHED			= 2
local BUCKET_SOLDIER_STATE_SCREAM_ATTACK	= 3

_G.WINTER2022_BUCKET_SOLDIERS_MAX = 1
_G.WINTER2022_BUCKET_SOLDIERS_MAX_HOME = 0
_G.WINTER2022_BUCKET_SOLDIERS_INTERVAL = 10.0
_G.WINTER2022_BUCKET_SOLDIER_AGGRO_RANGE = 400
_G.WINTER2022_BUCKET_SOLDIER_LEASH_RANGE = 300
_G.WINTER2022_BUCKET_SOLDIER_LEASHING_REACTIVATE_RANGE = 600	-- if we're leashing back to the well, start searching for aggro targets once we're this close to the well
_G.WINTER2022_BUCKET_SOLDIER_MAX_LEASH_TIME = 1
_G.WINTER2022_BUCKET_SOLDIER_MAINTAIN_RANGE = 150

if CBucketSoldier == nil then
	CBucketSoldier = class({})
end

function Spawn( entityKeyValues )
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

	thisEntity:SetContextThink( "BucketSoldierThink", BucketSoldierThink, 0.1 )
	thisEntity.AI = CBucketSoldier( thisEntity )
	print("CREATED")
end

function BucketSoldierThink()
	if IsServer() == false then
		return -1
	end

	local fThinkTime = thisEntity.AI:BotThink()
	if fThinkTime then
		return fThinkTime
	end

	return 0.1
end

function CBucketSoldier:constructor( me )
	self.me = me
	self.flNextPatrolTime = GameRules:GetGameTime() + 1
	self.flMaxLeashTime = nil
	self.nState = BUCKET_SOLDIER_STATE_IDLE
	self.hAttackTarget = nil
end

function CBucketSoldier:ChangeBotState( nNewState )
	if self.nState ~= nNewState then
		if nNewState == BUCKET_SOLDIER_STATE_IDLE then
			self.flNextPatrolTime = GameRules:GetGameTime() + 1
		elseif nNewState == BUCKET_SOLDIER_STATE_LEASHED then
			self:LeashToBucket()
		end
	end
	self.nState = nNewState
end

function CBucketSoldier:BotThink()
	if self.me == nil or self.me:IsNull() or ( not self.me:IsAlive() ) then
		return -1
	end

	if GameRules:IsGamePaused() == true then
		return 0.1
	end

	if not IsServer() then
		return
	end

	if self.hBucket ~= nil then
		self.vInitialSpawnPos = self.hBucket:GetAbsOrigin()
	else
		self.vInitialSpawnPos = self.me:GetAbsOrigin()
	end


	-- Афк стойка

	if self.nState == BUCKET_SOLDIER_STATE_IDLE then
		-- Побежать до челикса
		if self:ShouldLeash() then
			self:ChangeBotState( BUCKET_SOLDIER_STATE_LEASHED )
			return 0.1
		end
		-- Пойти хуярить челикса
		local hTarget = self:FindBestTarget()
		if hTarget ~= nil then
			self.hAttackTarget = hTarget
			self:ChangeBotState( BUCKET_SOLDIER_STATE_ATTACKING )
			return 0.1
		end
		-- Некст тайм ждемс
		if GameRules:GetGameTime() > self.flNextPatrolTime then
			local flWaitTime = self:PatrolBucket()
			self.flNextPatrolTime = GameRules:GetGameTime() + flWaitTime
		end
	elseif self.nState == BUCKET_SOLDIER_STATE_ATTACKING then
		if self:ShouldLeash() then
			self:ChangeBotState( BUCKET_SOLDIER_STATE_LEASHED )
			return 0.1
		end

		if self.hAttackTarget ~= nil and self.hAttackTarget:IsNull() == false and self.hAttackTarget:IsRealHero() == false then
			self.hAttackTarget = self:FindBestTarget()
		end

		if self.hAttackTarget == nil or self.hAttackTarget:IsNull() == true or self.hAttackTarget:IsAlive() == false then
			self:ChangeBotState( BUCKET_SOLDIER_STATE_IDLE )
			return 0.1
		end

		if self.hBucket:GetAggroTarget() ~= nil and not self.hBucket:GetAggroTarget():IsNull() and self.hBucket:GetAggroTarget():IsAlive() and not self.hBucket:GetAggroTarget():IsInvulnerable() then
			self.hAttackTarget = self.hBucket:GetAggroTarget()
		end

		self:AttackTarget( self.hAttackTarget )
	elseif self.nState == BUCKET_SOLDIER_STATE_LEASHED then
		local flDist = ( self.vLeashDestination - self.me:GetAbsOrigin() ):Length2D()

		if self:ShouldLeash() then
			self.me:MoveToPosition(self.vInitialSpawnPos)
			return 0.1
		end

		local hTarget = self:FindBestTarget()
		if hTarget ~= nil then
			self.hAttackTarget = hTarget
			self:ChangeBotState( BUCKET_SOLDIER_STATE_ATTACKING )
			return 0.1
		end
	end

	return 0.1
end

function CBucketSoldier:LeashToBucket()
	self.vLeashDestination = self.vInitialSpawnPos + RandomVector( RandomInt( 50, WINTER2022_BUCKET_SOLDIER_MAINTAIN_RANGE ) )
	self.flMaxLeashTime = GameRules:GetGameTime() + WINTER2022_BUCKET_SOLDIER_MAX_LEASH_TIME
end

function CBucketSoldier:AttackTarget( hTarget )
	self.me:MoveToTargetToAttack(hTarget)
end

function CBucketSoldier:PatrolBucket()
	local vTargetPos = self.vInitialSpawnPos + RandomVector( RandomInt( 50, WINTER2022_BUCKET_SOLDIER_MAINTAIN_RANGE ) )
	local flDist = ( vTargetPos - self.me:GetAbsOrigin() ):Length2D()
	self.me:MoveToPositionAggressive(vTargetPos)
	local fSleepTime = ( flDist / self.me:GetIdealSpeed() )
	print(fSleepTime)
	return fSleepTime
end

function CBucketSoldier:FindBestTarget()
	local fSearchRadius = WINTER2022_BUCKET_SOLDIER_AGGRO_RANGE + (self.me:Script_GetAttackRange() / 2)

	local vSearchOrigin = self.hBucket:GetAbsOrigin()

	local Units = FindUnitsInRadius( self.me:GetTeamNumber(), vSearchOrigin, self.me, fSearchRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false )
	
	local hBestNonHero = nil

	if self.hBucket:GetAggroTarget() ~= nil and not self.hBucket:GetAggroTarget():IsNull() and self.hBucket:GetAggroTarget():IsAlive() and not self.hBucket:GetAggroTarget():IsInvulnerable() then
		return self.hBucket:GetAggroTarget()
	end

	if #Units > 0 then
		for _,hUnit in pairs( Units ) do
			if hUnit ~= nil and not hUnit:IsNull() and hUnit:IsAlive() and not hUnit:IsInvulnerable() then
				if hUnit:IsRealHero() then
					return hUnit
				else
					if hBestNonHero == nil then
						hBestNonHero = hUnit
					end
				end
			end
		end
	end

	return hBestNonHero
end

function CBucketSoldier:ShouldLeash()
	local flDist = ( self.vInitialSpawnPos - self.me:GetAbsOrigin() ):Length2D()
	if flDist >= WINTER2022_BUCKET_SOLDIER_LEASH_RANGE then
		return true
	end
	return false
end