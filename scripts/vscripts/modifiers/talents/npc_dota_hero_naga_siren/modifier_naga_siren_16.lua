--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_naga_siren_16_buff", "modifiers/talents/npc_dota_hero_naga_siren/modifier_naga_siren_16", LUA_MODIFIER_MOTION_NONE)

modifier_naga_siren_16=class({})

function modifier_naga_siren_16:IsHidden() return true end
function modifier_naga_siren_16:IsPurgable() return false end
function modifier_naga_siren_16:IsPurgeException() return false end
function modifier_naga_siren_16:RemoveOnDeath() return false end

function modifier_naga_siren_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local naga_siren_mirror_image_custom = self:GetParent():FindAbilityByName("naga_siren_mirror_image_custom")
    Timers:CreateTimer(1, function()
        if naga_siren_mirror_image_custom and naga_siren_mirror_image_custom:GetLevel() <= 0 then return 1 end
        if not self:GetParent():IsAlive() then return 1 end
        if self:GetParent():HasModifier("modifier_wodawisp") then return 1 end
        if self:GetParent():HasModifier("modifier_smoke_of_deceit") then return 1 end
        if self.illusion == nil or self.illusion:IsNull() or not self.illusion:IsAlive() then
            self:CreateIllusion()
        end
        return 1
    end)
end

function modifier_naga_siren_16:CreateIllusion()
    local origin = self:GetCaster():GetAbsOrigin() + RandomVector(400)
    if self.illusion and not self.illusion:IsNull() then
        origin = self.illusion:GetAbsOrigin()
        self.illusion:AddNoDraw()
        self.illusion:AddEffects(EF_NODRAW)
        UTIL_Remove(self.illusion)
    end
    local naga_siren_mirror_image_custom = self:GetParent():FindAbilityByName("naga_siren_mirror_image_custom")
    local outgoing = naga_siren_mirror_image_custom:GetSpecialValueFor( "outgoing_damage" )
    local illusions = CreateIllusions( self:GetParent(), self:GetParent(), { outgoing_damage = outgoing, incoming_damage = 0}, 1, 400, false, false )
	for _, illusion in pairs(illusions) do
        self.illusion = illusion
        illusion:AddNewModifier(self:GetCaster(), nil, "modifier_naga_siren_16_buff", {})
        FindClearSpaceForUnit(illusion, origin, true)
        illusion:SetControllableByPlayer(-1, true)
    end
end

function modifier_naga_siren_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_naga_siren_16:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_naga_siren_16:GetModifierDamageOutgoing_Percentage()
    return -50
end

modifier_naga_siren_16_buff = class({})
function modifier_naga_siren_16_buff:IsHidden() return true end
function modifier_naga_siren_16_buff:IsPurgable() return false end
function modifier_naga_siren_16_buff:IsPurgeException() return false end

function modifier_naga_siren_16_buff:OnCreated()
    if not IsServer() then return end
    self.me = self:GetParent()
    self.hBucket = self:GetCaster()
	self.flNextPatrolTime = GameRules:GetGameTime() + 1
	self.flMaxLeashTime = nil
	self.nState = modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_IDLE
	self.hAttackTarget = nil
    self.update = 0
    self.naga_siren_mirror_image_custom = self:GetCaster():FindAbilityByName("naga_siren_mirror_image_custom")
    self:StartIntervalThink(0.1)
end

function modifier_naga_siren_16_buff:OnIntervalThink()
	if not IsServer() then return end
	local length = (self:GetCaster():GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
	if length >= 750 then
		FindClearSpaceForUnit(self:GetParent(), self:GetCaster():GetAbsOrigin() + RandomVector(200), true)
	end
	if not self:GetCaster():IsAlive() or self:GetCaster():HasModifier("modifier_wodawisp") or self:GetCaster():HasModifier("modifier_smoke_of_deceit") then
		self:GetParent():ForceKill(false)
        return
    end
    if self.naga_siren_mirror_image_custom and self.naga_siren_mirror_image_custom:GetLevel() <= 0 then
        self:GetParent():ForceKill(false)
        return
    end
    self:BotThink()
    self.update = self.update + 0.1
    if self.update >= 10 then
        self.update = 0
        local modifier_naga_siren_16 = self:GetCaster():FindModifierByName("modifier_naga_siren_16")
        if modifier_naga_siren_16 then
            modifier_naga_siren_16:CreateIllusion()
        end
    end
end

function modifier_naga_siren_16_buff:CheckState()
    return
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_DISARMED] = not self:GetCaster():IsAlive() or self:GetCaster():HasModifier("modifier_wodawisp") or self:GetCaster():HasModifier("modifier_smoke_of_deceit"),
		[MODIFIER_STATE_STUNNED] = not self:GetCaster():IsAlive() or self:GetCaster():HasModifier("modifier_wodawisp") or self:GetCaster():HasModifier("modifier_smoke_of_deceit"),
    }
end

modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_IDLE				= 0
modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_ATTACKING		= 1
modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_LEASHED			= 2
modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_SCREAM_ATTACK	= 3
modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIERS_MAX = 1
modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIERS_MAX_HOME = 0
modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIERS_INTERVAL = 10.0
modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIER_AGGRO_RANGE = 400
modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIER_LEASH_RANGE = 300
modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIER_LEASHING_REACTIVATE_RANGE = 600
modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIER_MAX_LEASH_TIME = 1
modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIER_MAINTAIN_RANGE = 150

function modifier_naga_siren_16_buff:ChangeBotState( nNewState )
	if self.nState ~= nNewState then
		if nNewState == modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_IDLE then
			self.flNextPatrolTime = GameRules:GetGameTime() + 1
		elseif nNewState == modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_LEASHED then
			self:LeashToBucket()
		end
	end
	self.nState = nNewState
end

function modifier_naga_siren_16_buff:BotThink()
   
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

	if self.nState == modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_IDLE then
		-- Побежать до челикса
		if self:ShouldLeash() then
			self:ChangeBotState( modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_LEASHED )
			return 0.1
		end
		-- Пойти хуярить челикса
		local hTarget = self:FindBestTarget()
		if hTarget ~= nil then
			self.hAttackTarget = hTarget
			self:ChangeBotState( modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_ATTACKING )
			return 0.1
		end
		-- Некст тайм ждемс
		if GameRules:GetGameTime() > self.flNextPatrolTime then
			local flWaitTime = self:PatrolBucket()
			self.flNextPatrolTime = GameRules:GetGameTime() + flWaitTime
		end
	elseif self.nState == modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_ATTACKING then
		if self:ShouldLeash() then
			self:ChangeBotState( modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_LEASHED )
			return 0.1
		end

		if self.hAttackTarget ~= nil and self.hAttackTarget:IsNull() == false and self.hAttackTarget:IsRealHero() == false then
			self.hAttackTarget = self:FindBestTarget()
		end

		if self.hAttackTarget == nil or self.hAttackTarget:IsNull() == true or self.hAttackTarget:IsAlive() == false then
			self:ChangeBotState( modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_IDLE )
			return 0.1
		end

		if self.hBucket:GetAggroTarget() ~= nil and not self.hBucket:GetAggroTarget():IsNull() and self.hBucket:GetAggroTarget():IsAlive() and not self.hBucket:GetAggroTarget():IsInvulnerable() then
			self.hAttackTarget = self.hBucket:GetAggroTarget()
		end

		self:AttackTarget( self.hAttackTarget )
	elseif self.nState == modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_LEASHED then
		local flDist = ( self.vLeashDestination - self.me:GetAbsOrigin() ):Length2D()

		if self:ShouldLeash() then
			self.me:MoveToPosition(self.vInitialSpawnPos)
			return 0.1
		end

		local hTarget = self:FindBestTarget()
		if hTarget ~= nil then
			self.hAttackTarget = hTarget
			self:ChangeBotState( modifier_naga_siren_16_buff.BUCKET_SOLDIER_STATE_ATTACKING )
			return 0.1
		end
	end

	return 0.1
end

function modifier_naga_siren_16_buff:LeashToBucket()
	self.vLeashDestination = self.vInitialSpawnPos + RandomVector( RandomInt( 50, modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIER_MAINTAIN_RANGE ) )
	self.flMaxLeashTime = GameRules:GetGameTime() + modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIER_MAX_LEASH_TIME
end

function modifier_naga_siren_16_buff:AttackTarget( hTarget )
	self.me:MoveToTargetToAttack(hTarget)
end

function modifier_naga_siren_16_buff:PatrolBucket()
	local vTargetPos = self.vInitialSpawnPos + RandomVector( RandomInt( 50, modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIER_MAINTAIN_RANGE ) )
	local flDist = ( vTargetPos - self.me:GetAbsOrigin() ):Length2D()
	self.me:MoveToPositionAggressive(vTargetPos)
	local fSleepTime = ( flDist / self.me:GetIdealSpeed() )
	return fSleepTime
end

function modifier_naga_siren_16_buff:FindBestTarget()
	local fSearchRadius = modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIER_AGGRO_RANGE + (self.me:Script_GetAttackRange() / 2)

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

function modifier_naga_siren_16_buff:ShouldLeash()
	local flDist = ( self.vInitialSpawnPos - self.me:GetAbsOrigin() ):Length2D()
	if flDist >= modifier_naga_siren_16_buff.WINTER2022_BUCKET_SOLDIER_LEASH_RANGE then
		return true
	end
	return false
end