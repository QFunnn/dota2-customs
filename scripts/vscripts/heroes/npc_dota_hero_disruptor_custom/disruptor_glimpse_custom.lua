--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_disruptor_glimpse_custom_thinker", "heroes/npc_dota_hero_disruptor_custom/disruptor_glimpse_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_glimpse_custom", "heroes/npc_dota_hero_disruptor_custom/disruptor_glimpse_custom", LUA_MODIFIER_MOTION_NONE )

disruptor_glimpse_custom = class({})
disruptor_glimpse_custom.modifier_disruptor_17 = 150
disruptor_glimpse_custom.modifier_disruptor_18 = {100,200,300}

function disruptor_glimpse_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_glimpse_targetstart.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_glimpse_travel.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_glimpse_travel.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_glimpse_targetend.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_glimpse_targetstart.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_pulse_knockback_area.vpcf', context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_disruptor.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_disruptor.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_disruptor.vpcf", context)
end

function disruptor_glimpse_custom:CastFilterResultTarget( hTarget )
    if hTarget:IsMagicImmune() then
        return UF_FAIL_MAGIC_IMMUNE_ENEMY
    end
    if hTarget:GetTeamNumber() == self:GetCaster():GetTeamNumber() and not self:GetCaster():HasModifier("modifier_disruptor_17") then
		return UF_FAIL_FRIENDLY
	end
    if not IsServer() then return UF_SUCCESS end
    local nResult = UnitFilter(
        hTarget,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags(),
        self:GetCaster():GetTeamNumber()
    )

    if nResult ~= UF_SUCCESS then
        return nResult
    end

    return UF_SUCCESS
end

function disruptor_glimpse_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()	

	if target:TriggerSpellAbsorb(self) then return end	

	if target:IsIllusion() then
		target:Kill(self, self:GetCaster())
		return nil
	end

	if not target:IsHero() then
		local damage = self:GetSpecialValueFor("max_damage")
		ApplyDamage({attacker = self:GetCaster(), victim = target, ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
		local nFXIndex3 = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_glimpse_targetstart.vpcf", PATTACH_CUSTOMORIGIN, nil )
		ParticleManager:SetParticleControlEnt( nFXIndex3, 0, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetOrigin(), true )
		ParticleManager:SetParticleControl( nFXIndex3, 2, Vector( 1, 1, 1 ) )
		ParticleManager:ReleaseParticleIndex(nFXIndex3)
		target:EmitSound("Hero_Disruptor.Glimpse.Target")
		return
	end

	local thinker = CreateModifierThinker(self:GetCaster(), self, "modifier_disruptor_glimpse_custom_thinker", {}, target:GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)	
	local thinkerBuff = thinker:FindModifierByName("modifier_disruptor_glimpse_custom_thinker")
	local buff = target:FindModifierByName("modifier_disruptor_glimpse_custom")
	if buff then		
		target:EmitSound("Hero_Disruptor.Glimpse.Target")
		thinkerBuff:BeginGlimpse(target, buff:GetOldestPosition())
	end		
end

function disruptor_glimpse_custom:CustomStart(target, point)
	if not IsServer() then return end
	local thinker = CreateModifierThinker(self:GetCaster(), self, "modifier_disruptor_glimpse_custom_thinker", {}, target:GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)	
	local thinkerBuff = thinker:FindModifierByName("modifier_disruptor_glimpse_custom_thinker")
	local buff = target:FindModifierByName("modifier_disruptor_glimpse_custom")
	if buff then		
		target:EmitSound("Hero_Disruptor.Glimpse.Target")
		thinkerBuff:BeginGlimpse(target, point)
	end		
end

modifier_disruptor_glimpse_custom_thinker = class({})

function modifier_disruptor_glimpse_custom_thinker:IsHidden()
	return true
end

function modifier_disruptor_glimpse_custom_thinker:IsPurgable()
	return true
end

function modifier_disruptor_glimpse_custom_thinker:OnCreated( kv )
	if IsServer() then		
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
		self.parent = self:GetParent()
		self.move_delay = 1.8	
		self.projectile_speed = 600
		self.vision_radius = 400
		self.vision_duration = 3.34	
		self.storm_duration = self.ability:GetSpecialValueFor("storm_duration")
	end
end

function modifier_disruptor_glimpse_custom_thinker:BeginGlimpse(target, old_position)
	if IsServer() then				
		local hUnit = target
		local vOldLocation = old_position
		if hUnit and vOldLocation then
			local vVelocity = ( vOldLocation - hUnit:GetOrigin())
			vVelocity.z = 0.0

			local flDist = vVelocity:Length2D()
			vVelocity = vVelocity:Normalized()

			local flDuration = math.max(0.05, math.min(self.move_delay, flDist / self.projectile_speed))
			
			local projectile =
			{
				Ability = self:GetAbility(),
				EffectName = "particles/units/heroes/hero_disruptor/disruptor_glimpse_travel.vpcf",
				vSpawnOrigin = hUnit:GetOrigin(), 
				fDistance = flDist,
				Source = self:GetCaster(),                				
				vVelocity = vVelocity * ( flDist / flDuration ),
				fStartRadius = 0,
				fEndRadius = 0,				
				bProvidesVision = true,
				iVisionRadius = self.vision_radius,
				iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
			}			  

			ProjectileManager:CreateLinearProjectile(projectile)                      

			local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_glimpse_travel.vpcf", PATTACH_CUSTOMORIGIN, nil )
			ParticleManager:SetParticleControlEnt( nFXIndex, 0, hUnit, PATTACH_ABSORIGIN_FOLLOW, nil, hUnit:GetOrigin(), true )
			ParticleManager:SetParticleControl( nFXIndex, 1, vOldLocation )
			ParticleManager:SetParticleControl( nFXIndex, 2, Vector( flDuration, flDuration, flDuration ) )
			self:AddParticle( nFXIndex, false, false, -1, false, false )

			local nFXIndex2 = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_glimpse_targetend.vpcf", PATTACH_CUSTOMORIGIN, nil )
			ParticleManager:SetParticleControlEnt( nFXIndex2, 0, hUnit, PATTACH_ABSORIGIN_FOLLOW, nil, hUnit:GetOrigin(), true )
			ParticleManager:SetParticleControl( nFXIndex2, 1, vOldLocation )
			ParticleManager:SetParticleControl( nFXIndex2, 2, Vector( flDuration, flDuration, flDuration ) )
			self:AddParticle( nFXIndex2, false, false, -1, false, false )

			local nFXIndex3 = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_glimpse_targetstart.vpcf", PATTACH_CUSTOMORIGIN, nil )
			ParticleManager:SetParticleControlEnt( nFXIndex3, 0, hUnit, PATTACH_ABSORIGIN_FOLLOW, nil, hUnit:GetOrigin(), true )
			ParticleManager:SetParticleControl( nFXIndex3, 2, Vector( flDuration, flDuration, flDuration ) )
			self:AddParticle( nFXIndex3, false, false, -1, false, false )
			
			EmitSoundOnLocationForAllies( vOldLocation, "Hero_Disruptor.GlimpseNB2017.Destination", self:GetCaster() )

			local buff = hUnit:FindModifierByName( "modifier_disruptor_glimpse_custom" )
			if buff then
				buff.hThinker = self						
				buff:SetGlimpsePosition(old_position)
				buff:SetExpireTime( GameRules:GetGameTime() + flDuration )						                    
			end			
		end		
	end
end

function modifier_disruptor_glimpse_custom_thinker:EndGlimpse(caster, ability, hUnit, old_position)
    if hUnit then
        hUnit:InterruptMotionControllers(true)
        if hUnit:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
            if hUnit:IsMagicImmune() or hUnit:IsDebuffImmune() or hUnit:IsInvulnerable() then
                return
            end
        end
		local distance = (hUnit:GetAbsOrigin() - old_position):Length2D()
		local min_damage = self:GetAbility():GetSpecialValueFor("min_damage")
		local max_damage = self:GetAbility():GetSpecialValueFor("max_damage")
		if self:GetCaster():HasModifier("modifier_disruptor_18") then
			max_damage = max_damage + self:GetAbility().modifier_disruptor_18[self:GetCaster():GetTalentLevel("modifier_disruptor_18")]
		end
		local max_distance = self:GetAbility():GetSpecialValueFor("max_distance") 	
		local pct = self:GetAbility():GetSpecialValueFor("damage_to_distance_pct")
        local damage = distance * pct / 100
        damage = math.max(min_damage, damage)
        damage = math.min(max_damage, damage)
		if self:GetCaster():HasModifier("modifier_disruptor_16") then
			damage = max_damage
		end
		AddFOWViewer(caster:GetTeamNumber(), old_position, self.vision_radius, self.vision_duration, false)
		FindClearSpaceForUnit( hUnit, old_position, true)
		if hUnit:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
			hUnit:Heal(damage / 100 * self:GetAbility().modifier_disruptor_17, self:GetAbility())
		else
			ApplyDamage({attacker = self:GetCaster(), victim = hUnit, ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
		end
		hUnit:Interrupt()
		self:Destroy()
	end
end

modifier_disruptor_glimpse_custom_movement_check_aura = class({})
function modifier_disruptor_glimpse_custom_movement_check_aura:IsHidden() return true end
function modifier_disruptor_glimpse_custom_movement_check_aura:IsPassive() return true end
function modifier_disruptor_glimpse_custom_movement_check_aura:IsAura() return true end
function modifier_disruptor_glimpse_custom_movement_check_aura:IsAuraActiveOnDeath() return true end
function modifier_disruptor_glimpse_custom_movement_check_aura:GetAuraRadius() return FIND_UNITS_EVERYWHERE end
function modifier_disruptor_glimpse_custom_movement_check_aura:GetAuraSearchFlags()	return DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end
function modifier_disruptor_glimpse_custom_movement_check_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_BOTH end
function modifier_disruptor_glimpse_custom_movement_check_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_disruptor_glimpse_custom_movement_check_aura:GetModifierAura() return "modifier_disruptor_glimpse_custom" end
function modifier_disruptor_glimpse_custom_movement_check_aura:GetAuraDuration() return 1 end
function modifier_disruptor_glimpse_custom_movement_check_aura:RemoveOnDeath() return false end

modifier_disruptor_glimpse_custom = class({})
function modifier_disruptor_glimpse_custom:IsHidden() return true end
function modifier_disruptor_glimpse_custom:IsPurgable() return true end

function modifier_disruptor_glimpse_custom:OnCreated( kv )
	if IsServer() then	
		self.backtrack_time = 4
		self.interval = 0.1
		self.possible_positions = self.backtrack_time / 0.1
        if self.vPositions == nil then
            self.vPositions = {}
            for i = 1, self.possible_positions do
                table.insert(self.vPositions, self:GetParent():GetOrigin())
            end
            self.flExpireTime = -1
        end
		self:StartIntervalThink(self.interval)
	end
end

function modifier_disruptor_glimpse_custom:OnIntervalThink()
	if IsServer() then
		if self.flExpireTime ~= -1 and GameRules:GetGameTime() > self.flExpireTime then
			if self.hThinker then
				self.hThinker:EndGlimpse(self:GetCaster(), self:GetAbility(), self:GetParent(), self.glimpse_position)
			end
			self.flExpireTime = -1
			self.hThinker = nil
		end
		for i = 1, #self.vPositions-1 do
			self.vPositions[i] = self.vPositions[i+1]
		end
		self.vPositions[ #self.vPositions ] = self:GetParent():GetOrigin()
	end
end

function modifier_disruptor_glimpse_custom:GetOldestPosition()
	return self.vPositions[1]
end

function modifier_disruptor_glimpse_custom:SetExpireTime( flTime )
	if IsServer() then
		self.flExpireTime = flTime
	end
end

function modifier_disruptor_glimpse_custom:SetGlimpsePosition(old_position)
	self.glimpse_position = old_position
end