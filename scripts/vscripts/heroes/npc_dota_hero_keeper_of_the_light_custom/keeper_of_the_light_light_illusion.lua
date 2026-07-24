--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_keeper_of_the_light_light_illusion", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_light_illusion", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_light_illusion_spirit", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_light_illusion", LUA_MODIFIER_MOTION_NONE)

keeper_of_the_light_light_illusion = class({})

function keeper_of_the_light_light_illusion:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    if self.spirit and not self.spirit:IsNull() and self.spirit:IsAlive() then
        self.spirit:ForceKill(false)
    end
    self:GetCaster():RemoveModifierByName("modifier_keeper_of_the_light_light_illusion")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_light_illusion", {duration = duration})
end

modifier_keeper_of_the_light_light_illusion = class({})
function modifier_keeper_of_the_light_light_illusion:IsPurgable() return false end
function modifier_keeper_of_the_light_light_illusion:IsPurgeException() return false end
function modifier_keeper_of_the_light_light_illusion:RemoveOnDeath() return false end
function modifier_keeper_of_the_light_light_illusion:OnCreated()
    if not IsServer() then return end
    self.modifier_keeper_of_the_light_9 = self:GetParent():HasModifier("modifier_keeper_of_the_light_9")
    self:CreateIllusion()
    if self.modifier_keeper_of_the_light_9 then
        self:GetCaster():SwapAbilities("keeper_of_the_light_light_illusion", "keeper_of_the_light_light_illusion_point", false, true)
    end
    self.attack_range = self:GetParent():Script_GetAttackRange() * -1
    --self:GetAbility():SetActivated(false)
    self:StartIntervalThink(0.1)
end

function modifier_keeper_of_the_light_light_illusion:CreateIllusion()
    local duration = self:GetAbility():GetSpecialValueFor("duration")
    local origin = self:GetCaster():GetAbsOrigin() + RandomVector(400)
    local illusions = CreateIllusions( self:GetParent(), self:GetParent(), { outgoing_damage = -100, incoming_damage = 0, duration = duration}, 1, 400, false, false )
	for _, illusion in pairs(illusions) do
        self.illusion = illusion
        self:GetAbility().spirit = illusion
        if self:GetCaster():HasModifier("modifier_keeper_of_the_light_dark_form") then
            local keeper_of_the_light_dark_form = self:GetCaster():FindAbilityByName("keeper_of_the_light_dark_form")
            if keeper_of_the_light_dark_form then
                illusion:AddNewModifier(self:GetCaster(), keeper_of_the_light_dark_form, "modifier_keeper_of_the_light_dark_form", {})
            end
        end
        illusion:AddNewModifier(self:GetCaster(), nil, "modifier_keeper_of_the_light_light_illusion_spirit", {})
        FindClearSpaceForUnit(illusion, origin, true)
        illusion:SetControllableByPlayer(-1, true)
    end
end

function modifier_keeper_of_the_light_light_illusion:OnIntervalThink()
	if not IsServer() then return end
    self.attack_range = 0
    self.attack_range = self:GetParent():Script_GetAttackRange() * -1
end

function modifier_keeper_of_the_light_light_illusion:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_FIXED_ATTACK_RATE
    }
end

function modifier_keeper_of_the_light_light_illusion:GetModifierFixedAttackRate()
	return 100
end

function modifier_keeper_of_the_light_light_illusion:GetModifierAttackRangeBonus()
    return self.attack_range
end

function modifier_keeper_of_the_light_light_illusion:OnDestroy()
    if not IsServer() then return end
    if self.modifier_keeper_of_the_light_9 then
        self:GetCaster():SwapAbilities("keeper_of_the_light_light_illusion_point", "keeper_of_the_light_light_illusion", false, true)
    end
    --self:GetAbility():SetActivated(true)
end

modifier_keeper_of_the_light_light_illusion_spirit = class({})
function modifier_keeper_of_the_light_light_illusion_spirit:IsHidden() return true end
function modifier_keeper_of_the_light_light_illusion_spirit:IsPurgable() return false end
function modifier_keeper_of_the_light_light_illusion_spirit:IsPurgeException() return false end
modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_IDLE				= 0
modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_ATTACKING		= 1
modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_LEASHED			= 2
modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_SCREAM_ATTACK	= 3
modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIERS_MAX = 1
modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIERS_MAX_HOME = 0
modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIERS_INTERVAL = 10.0
modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_AGGRO_RANGE = 600
modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_LEASH_RANGE = 300
modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_LEASHING_REACTIVATE_RANGE = 600
modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_MAX_LEASH_TIME = 1
modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_MAINTAIN_RANGE = 300

function modifier_keeper_of_the_light_light_illusion_spirit:OnCreated()
    if not IsServer() then return end
    self.me = self:GetParent()
    self.hBucket = self:GetCaster()
	self.flNextPatrolTime = GameRules:GetGameTime() + 1
	self.flMaxLeashTime = nil
    self.attack_range = self:GetParent():Script_GetAttackRange() * -1
    modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_AGGRO_RANGE = self:GetParent():Script_GetAttackRange()
    modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_LEASH_RANGE = 1200
	self.nState = modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_IDLE
	self.hAttackTarget = nil
    self:StartIntervalThink(0.1)
    self:OnIntervalThink()
end

function modifier_keeper_of_the_light_light_illusion_spirit:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
    }
end

function modifier_keeper_of_the_light_light_illusion_spirit:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    self:GetCaster():PerformAttack(params.target, true, true, true, false, false, false, false)
end

function modifier_keeper_of_the_light_light_illusion_spirit:GetEffectName()
    if self:GetParent():HasModifier("modifier_keeper_of_the_light_dark_form") then return end
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_spirit_form_ambient.vpcf"
end 

function modifier_keeper_of_the_light_light_illusion_spirit:GetStatusEffectName()
    if self:GetParent():HasModifier("modifier_keeper_of_the_light_dark_form") then return end
	return "particles/status_fx/status_effect_keeper_spirit_form.vpcf"
end

function modifier_keeper_of_the_light_light_illusion_spirit:GetModifierMoveSpeed_Absolute()
    return 550
end

function modifier_keeper_of_the_light_light_illusion_spirit:StatusEffectPriority()
    if self:GetParent():HasModifier("modifier_keeper_of_the_light_dark_form") then return end
    return 100000
end

function modifier_keeper_of_the_light_light_illusion_spirit:OnIntervalThink()
	if not IsServer() then return end
	local length = (self:GetCaster():GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
	if length >= 2300 and not self:GetParent():HasModifier("modifier_generic_arc_lua") then
		FindClearSpaceForUnit(self:GetParent(), self:GetCaster():GetAbsOrigin() + RandomVector(200), true)
	end
	if not self:GetCaster():IsAlive() or self:GetCaster():HasModifier("modifier_wodawisp") or self:GetCaster():HasModifier("modifier_smoke_of_deceit") then
		self:GetParent():AddEffects( EF_NODRAW )
	else
		self:GetParent():RemoveEffects( EF_NODRAW )
	end
    self:BotThink()
    if not self:GetCaster():IsAlive() then
        self:GetParent():ForceKill(false)
    end
end

function modifier_keeper_of_the_light_light_illusion_spirit:CheckState()
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

function modifier_keeper_of_the_light_light_illusion_spirit:ChangeBotState( nNewState )
	if self.nState ~= nNewState then
		if nNewState == modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_IDLE then
			self.flNextPatrolTime = GameRules:GetGameTime() + 1
		elseif nNewState == modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_LEASHED then
			self:LeashToBucket()
		end
	end
	self.nState = nNewState
end

function modifier_keeper_of_the_light_light_illusion_spirit:BotThink()
   
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

	if self.nState == modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_IDLE then
		-- Побежать до челикса
		if self:ShouldLeash() then
			self:ChangeBotState( modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_LEASHED )
			return 0.1
		end
		-- Пойти хуярить челикса
		local hTarget = self:FindBestTarget()
		if hTarget ~= nil then
			self.hAttackTarget = hTarget
			self:ChangeBotState( modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_ATTACKING )
			return 0.1
		end
		-- Некст тайм ждемс
		if GameRules:GetGameTime() > self.flNextPatrolTime then
			local flWaitTime = self:PatrolBucket()
			self.flNextPatrolTime = GameRules:GetGameTime() + flWaitTime
		end
	elseif self.nState == modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_ATTACKING then
		if self:ShouldLeash() then
			self:ChangeBotState( modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_LEASHED )
			return 0.1
		end

		if self.hAttackTarget ~= nil and self.hAttackTarget:IsNull() == false and self.hAttackTarget:IsRealHero() == false then
			self.hAttackTarget = self:FindBestTarget()
		end

		if self.hAttackTarget == nil or self.hAttackTarget:IsNull() == true or self.hAttackTarget:IsAlive() == false then
			self:ChangeBotState( modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_IDLE )
			return 0.1
		end

		if self.hBucket:GetAggroTarget() ~= nil and not self.hBucket:GetAggroTarget():IsNull() and self.hBucket:GetAggroTarget():IsAlive() and not self.hBucket:GetAggroTarget():IsInvulnerable() then
			self.hAttackTarget = self.hBucket:GetAggroTarget()
		end

		self:AttackTarget( self.hAttackTarget )
	elseif self.nState == modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_LEASHED then
		local flDist = ( self.vLeashDestination - self.me:GetAbsOrigin() ):Length2D()

		if self:ShouldLeash() then
			self.me:MoveToPosition(self.vInitialSpawnPos)
			return 0.1
		end

		local hTarget = self:FindBestTarget()
		if hTarget ~= nil then
			self.hAttackTarget = hTarget
			self:ChangeBotState( modifier_keeper_of_the_light_light_illusion_spirit.BUCKET_SOLDIER_STATE_ATTACKING )
			return 0.1
		end
	end

	return 0.1
end

function modifier_keeper_of_the_light_light_illusion_spirit:LeashToBucket()
	self.vLeashDestination = self.vInitialSpawnPos + RandomVector( RandomInt( 50, modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_MAINTAIN_RANGE ) )
	self.flMaxLeashTime = GameRules:GetGameTime() + modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_MAX_LEASH_TIME
end

function modifier_keeper_of_the_light_light_illusion_spirit:AttackTarget( hTarget )
	self.me:MoveToTargetToAttack(hTarget)
end

function modifier_keeper_of_the_light_light_illusion_spirit:PatrolBucket()
	local vTargetPos = self.vInitialSpawnPos + RandomVector( RandomInt( 50, modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_MAINTAIN_RANGE ) )
	local flDist = ( vTargetPos - self.me:GetAbsOrigin() ):Length2D()
	self.me:MoveToPositionAggressive(vTargetPos)
	local fSleepTime = ( flDist / self.me:GetIdealSpeed() )
	return fSleepTime
end

function modifier_keeper_of_the_light_light_illusion_spirit:FindBestTarget()
	local fSearchRadius = modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_AGGRO_RANGE + (self.me:Script_GetAttackRange() / 2)

	local vSearchOrigin = self.hBucket:GetAbsOrigin()

	local Units = FindUnitsInRadius( self.me:GetTeamNumber(), vSearchOrigin, self.me, fSearchRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false )
	
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

function modifier_keeper_of_the_light_light_illusion_spirit:ShouldLeash()
	local flDist = ( self.vInitialSpawnPos - self.me:GetAbsOrigin() ):Length2D()
	if flDist >= modifier_keeper_of_the_light_light_illusion_spirit.WINTER2022_BUCKET_SOLDIER_LEASH_RANGE then
		return true
	end
	return false
end