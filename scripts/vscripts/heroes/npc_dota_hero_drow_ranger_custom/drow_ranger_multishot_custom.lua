--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_drow_ranger_multishot_custom", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_multishot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_multishot_custom_arbalet_14", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_multishot_custom", LUA_MODIFIER_MOTION_NONE )

drow_ranger_multishot_custom = class({})

drow_ranger_multishot_custom.modifier_drow_ranger_9 = {20,40,60}

drow_ranger_multishot_custom.modifier_drow_ranger_10_damage = {15,30}
drow_ranger_multishot_custom.modifier_drow_ranger_11_wave_bonus = {1,2,3}

function drow_ranger_multishot_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_multishot_proj_linear_proj.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_base_attack_linear_proj.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/drow/drow_arcana/drow_arcana_shard_hypothermia_death.vpcf", context )
end

function drow_ranger_multishot_custom:GetCooldown(level)
	if self:GetAbilityName() == "drow_ranger_multishot_2_custom" then return 0 end
    return self.BaseClass.GetCooldown( self, level )
end

function drow_ranger_multishot_custom:GetCastRange(location, target)
	if self:GetCaster():HasModifier("modifier_drow_ranger_14") then
		return 800
	end
    return self.BaseClass.GetCastRange(self, location, target)
end

function drow_ranger_multishot_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_drow_ranger_14") then
		return "drow_ranger_14"
	end
	return "drow_ranger_multishot"
end

function drow_ranger_multishot_custom:GetChannelTime()
    if true then
        return 1.75
    end
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_drow_ranger_11") then
		bonus = 0.7 * self:GetCaster():GetTalentLevel("modifier_drow_ranger_11")
	end
    local channel = self.BaseClass.GetChannelTime(self) + bonus
    if self:GetCaster():HasModifier("modifier_drow_ranger_9") then
        local percent = self.modifier_drow_ranger_9[self:GetCaster():GetTalentLevel("modifier_drow_ranger_9")]
        channel = channel - (channel / 100 * percent)
    end
	return channel + 0.1
end

function drow_ranger_multishot_custom:GetBehavior()
	if self:GetAbilityName() == "drow_ranger_multishot_custom" then
		if self:GetCaster():HasModifier("modifier_drow_ranger_14") then
			return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING
		end
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DIRECTIONAL
	else
		if self:GetCaster():HasModifier("modifier_drow_ranger_14") then
			return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING + DOTA_ABILITY_BEHAVIOR_HIDDEN
		end
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DIRECTIONAL + DOTA_ABILITY_BEHAVIOR_HIDDEN
	end
end

drow_ranger_multishot_custom.targets = {}

function drow_ranger_multishot_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetChannelTime()
	if self:GetCaster():HasModifier("modifier_drow_ranger_14") then
		return
	end
    local direction = (point - caster:GetAbsOrigin())
    direction.z = 0
    local dir = direction:Normalized()
    local multishot_movespeed = self:GetSpecialValueFor("multishot_movespeed")
    if multishot_movespeed > 0 then
        caster:FaceTowards(point)
        caster:SetForwardVector(dir)
    end
	self.targets = {}
	self.modifier = caster:AddNewModifier( caster, self, "modifier_drow_ranger_multishot_custom",  { duration = duration, x = point.x, y = point.y, z = point.z, } )
end

function drow_ranger_multishot_custom:OnVectorCastStart(vStartLocation, vDirection)
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_drow_ranger_14") then
		self.arbalet = CreateUnitByName("npc_dota_companion", vStartLocation, false, nil, nil, self:GetCaster():GetTeamNumber())
		if self.arbalet then
			self.arbalet:SetModel("models/items/drow/drow_arcana/drow_arcana_weapon.vmdl")
			self.arbalet:SetOriginalModel("models/items/drow/drow_arcana/drow_arcana_weapon.vmdl")
			self.arbalet:SetModelScale(1.2)
			local origin = self:GetCursorPosition()
			origin.z = origin.z + 64
			self.arbalet:SetAbsOrigin(origin)
			self.arbalet:SetForwardVector(vDirection)
			local duration = self:GetChannelTime()
			self.arbalet:AddNewModifier(self:GetCaster(), self, "modifier_drow_ranger_multishot_custom_arbalet_14", {duration = duration})
		end
	end
end

function drow_ranger_multishot_custom:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end

	if self.targets[ target ] == data.wave then return false end

	self.targets[ target ] = data.wave

	local pct = self:GetSpecialValueFor( "arrow_damage_pct" )

	if self:GetCaster():HasModifier("modifier_drow_ranger_10") then
		pct = pct + self.modifier_drow_ranger_10_damage[self:GetCaster():GetTalentLevel("modifier_drow_ranger_10")]
	end

	local damage = self:GetCaster():GetAttackDamage() / 100 * pct

	local slow = self:GetSpecialValueFor( "arrow_slow_duration" )

	if data.frost==1 then
		local ability = self:GetCaster():FindAbilityByName( "drow_ranger_frost_arrows_custom" )
		if ability and ability:GetLevel() > 0 then
			target:AddNewModifier( self:GetCaster(), ability, "modifier_drow_ranger_frost_arrows_custom", { duration = slow } )
			damage = damage + ability:GetSpecialValueFor("damage")
			if self:GetCaster():HasModifier("modifier_drow_ranger_4") then
				target:AddNewModifier( self:GetCaster(), ability, "modifier_drow_ranger_frost_arrows_custom_3", { duration = ability.modifier_drow_ranger_3_duration } )
			end
		end
	end

	if not target:IsAttackImmune() then
		if self:GetCaster():HasModifier("modifier_drow_ranger_13") then
			self:GetCaster():PerformAttack(target, true, true, true, false, false, true, true)
			ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self })
		else
			ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self })
		end
	end

	target:EmitSound("Hero_DrowRanger.ProjectileImpact")
	return true
end

modifier_drow_ranger_multishot_custom = class({})

function modifier_drow_ranger_multishot_custom:IsHidden()
	return false
end

function modifier_drow_ranger_multishot_custom:IsDebuff()
	return false
end

function modifier_drow_ranger_multishot_custom:IsStunDebuff()
	return false
end

function modifier_drow_ranger_multishot_custom:IsPurgable()
	return false
end

function modifier_drow_ranger_multishot_custom:OnCreated( kv )
	local count = self:GetAbility():GetSpecialValueFor( "arrow_count_per_wave" )
    local wave_count = self:GetAbility():GetSpecialValueFor("wave_count")
	if self:GetCaster():HasModifier("modifier_drow_ranger_11") then
		wave_count = wave_count + self:GetAbility().modifier_drow_ranger_11_wave_bonus[self:GetCaster():GetTalentLevel("modifier_drow_ranger_11")]
	end
    if self:GetCaster():HasModifier("modifier_drow_ranger_glacier_hilltop") then
		count = count + 1
	end
    self.multishot_movespeed = self:GetAbility():GetSpecialValueFor("multishot_movespeed")
	local range = self:GetAbility():GetSpecialValueFor( "arrow_range_multiplier" )
	local width = self:GetAbility():GetSpecialValueFor( "arrow_width" )
	self.speed = self:GetAbility():GetSpecialValueFor( "arrow_speed" )
	self.angle = 33.33

	if not IsServer() then return end
	local vision = 100
	local delay = 0.1
	local wave = 3
	local wave_interval = (self:GetDuration()-0.1) / wave_count
    self.max_waves = wave_count
	self.arrow_delay = 0.033
	self.arrows = count
	self.wave_delay = wave_interval - self.arrow_delay*(self.arrows-1)

    if self:GetCaster():HasModifier("modifier_drow_ranger_9") then
        local percent = self:GetAbility().modifier_drow_ranger_9[self:GetCaster():GetTalentLevel("modifier_drow_ranger_9")]
        self.wave_delay = self.wave_delay - (self.wave_delay / 100 * percent)
    end

	local point = Vector(kv.x, kv.y, kv.z)
    self.point_start = point
	self.direction = point-self:GetCaster():GetOrigin()
	self.direction.z = 0
	self.direction = self.direction:Normalized()

	self.state = STATE_SALVO
	self.current_arrows = 0
	self.current_wave = 0
	self.frost = false

	local ability = self:GetCaster():FindAbilityByName( "drow_ranger_frost_arrows_custom" )
	if ability and ability:GetLevel()>0 then
		self.frost = true
	end
	local caster = self:GetCaster()
	local projectile_name
	if self.frost then
		projectile_name = "particles/units/heroes/hero_drow/drow_multishot_proj_linear_proj.vpcf"
	else
		projectile_name = "particles/units/heroes/hero_drow/drow_base_attack_linear_proj.vpcf"
	end

	self.info = {
		Source = caster,
		Ability = self:GetAbility(),
		vSpawnOrigin = caster:GetAttachmentOrigin( caster:ScriptLookupAttachment( "attach_attack1" ) ),
	    bDeleteOnHit = true,
	    iUnitTargetTeam = self:GetAbility():GetAbilityTargetTeam(),
	    iUnitTargetType = self:GetAbility():GetAbilityTargetType(),
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
	    EffectName = projectile_name,
	    fDistance = caster:Script_GetAttackRange() * range,
	    fStartRadius = width,
	    fEndRadius = width,
		bProvidesVision = true,
		iVisionRadius = vision,
		iVisionTeamNumber = caster:GetTeamNumber()
	}

	self:StartIntervalThink( delay )
	self:GetCaster():EmitSound("Hero_DrowRanger.Multishot.Channel")
end

function modifier_drow_ranger_multishot_custom:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():StopSound("Hero_DrowRanger.Multishot.Channel")
end

function modifier_drow_ranger_multishot_custom:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_drow_ranger_multishot_custom:GetModifierDisableTurning()
    return (self.multishot_movespeed > 0 or self.is_upgrade > 0) and 1
end

function modifier_drow_ranger_multishot_custom:GetModifierIgnoreCastAngle()
    return (self.multishot_movespeed > 0 or self.is_upgrade > 0) and 1
end

function modifier_drow_ranger_multishot_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.multishot_movespeed > 0 and -self.multishot_movespeed
end

function modifier_drow_ranger_multishot_custom:OnOrder( params )
    if params.unit == self:GetParent() then
        if self.multishot_movespeed > 0 or self.is_upgrade > 0 then
            if params.ability and not params.ability:IsItem() then
                if params.ability:GetAbilityName() ~= "drow_ranger_glacier" then
                    self:Destroy()
                end
            end
            if params.order_type == DOTA_UNIT_ORDER_STOP or params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
                self:Destroy()
            end
        end
    end 
end

function modifier_drow_ranger_multishot_custom:OnIntervalThink()
    if self:GetParent():IsStunned() then
        self:Destroy()
        self:GetParent():Interrupt()
        return
    end
	if self.current_arrows<self.arrows then
		self:StartIntervalThink( self.arrow_delay )
        self.info.vSpawnOrigin = self:GetCaster():GetAttachmentOrigin( self:GetCaster():ScriptLookupAttachment( "attach_attack1" ) )
        self.direction = self.point_start-self:GetCaster():GetOrigin()
	    self.direction.z = 0
	    self.direction = self.direction:Normalized()
        self:GetParent():SetForwardVector(self.direction)
	else
		self.current_arrows = 0
		self.current_wave = self.current_wave+1
        if self.current_wave >= self.max_waves then
            self:Destroy()
            self:GetParent():Interrupt()
        end
		self:StartIntervalThink( self.wave_delay )
        self.info.vSpawnOrigin = self:GetCaster():GetAttachmentOrigin( self:GetCaster():ScriptLookupAttachment( "attach_attack1" ) )
        self.direction = self.point_start-self:GetCaster():GetOrigin()
	    self.direction.z = 0
	    self.direction = self.direction:Normalized()
        self:GetParent():SetForwardVector(self.direction)
		return
	end
    
	local step = self.angle/(self.arrows-1)
	local angle = -self.angle/2 + self.current_arrows*step
	local projectile_direction = RotatePosition( Vector(0,0,0), QAngle( 0, angle, 0 ), self.direction )
	self.info.vVelocity = projectile_direction * self.speed
	self.info.ExtraData = 
    {
		arrow = self.current_arrows,
		wave = self.current_wave,
		frost = self.frost,
	}
	ProjectileManager:CreateLinearProjectile(self.info)
	self:PlayEffects()
	self.current_arrows = self.current_arrows+1
    self:GetParent():SetForwardVector(self.direction)
end

function modifier_drow_ranger_multishot_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_EVENT_ON_ORDER,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION 
    }
end

function modifier_drow_ranger_multishot_custom:GetOverrideAnimation()
    return ACT_DOTA_CHANNEL_ABILITY_3
end
    
function modifier_drow_ranger_multishot_custom:GetActivityTranslationModifiers()
    return "sidestep"
end

function modifier_drow_ranger_multishot_custom:PlayEffects()

	local sound_cast

	if self.frost then
		sound_cast = "Hero_DrowRanger.Multishot.FrostArrows"
	else
		sound_cast = "Hero_DrowRanger.Multishot.Attack"
	end

	self:GetCaster():EmitSound(sound_cast)
end

drow_ranger_multishot_2_custom = drow_ranger_multishot_custom

function drow_ranger_multishot_2_custom:GetAbilityChargeRestoreTime(level)
    return self.BaseClass.GetAbilityChargeRestoreTime( self, level )
end

modifier_drow_ranger_multishot_custom_arbalet_14 = class({})

function modifier_drow_ranger_multishot_custom_arbalet_14:IsHidden() return true end

function modifier_drow_ranger_multishot_custom_arbalet_14:IsPurgable() return false end

function modifier_drow_ranger_multishot_custom_arbalet_14:CheckState()
	return {
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_FROZEN] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end

function modifier_drow_ranger_multishot_custom_arbalet_14:OnCreated( kv )
	local count = self:GetAbility():GetSpecialValueFor( "arrow_count_per_wave" )
    if self:GetCaster():HasModifier("modifier_drow_ranger_glacier_hilltop") then
		count = count + 1
	end
    local wave_count = self:GetAbility():GetSpecialValueFor("wave_count")
	if self:GetCaster():HasModifier("modifier_drow_ranger_11") then
		wave_count = wave_count + self:GetAbility().modifier_drow_ranger_11_wave_bonus[self:GetCaster():GetTalentLevel("modifier_drow_ranger_11")]
	end
	local range = self:GetAbility():GetSpecialValueFor( "arrow_range_multiplier" )
	local width = self:GetAbility():GetSpecialValueFor( "arrow_width" )
	self.speed = self:GetAbility():GetSpecialValueFor( "arrow_speed" )
	self.angle = 33.33

	if not IsServer() then return end
	local vision = 100
	local delay = 0.1
	local wave = 3
	local wave_interval = (self:GetDuration()-0.1) / wave_count
    self.max_waves = wave_count
	self.arrow_delay = 0.033
	self.arrows = count
	self.wave_delay = wave_interval - self.arrow_delay*(self.arrows-1)
    if self:GetCaster():HasModifier("modifier_drow_ranger_9") then
        local percent = self:GetAbility().modifier_drow_ranger_9[self:GetCaster():GetTalentLevel("modifier_drow_ranger_9")]
        self.wave_delay = self.wave_delay - (self.wave_delay / 100 * percent)
    end
    print(self.wave_delay)

	local point = Vector(kv.x, kv.y, kv.z)
	self.direction = self:GetParent():GetForwardVector()
	self.direction.z = 0

	self.state = STATE_SALVO
	self.current_arrows = 0
	self.current_wave = 0
	self.frost = false

	local ability = self:GetCaster():FindAbilityByName( "drow_ranger_frost_arrows_custom" )

	if ability and ability:GetLevel()>0 then
		self.frost = true
	end

	local caster = self:GetCaster()

	local projectile_name

	if self.frost then
		projectile_name = "particles/units/heroes/hero_drow/drow_multishot_proj_linear_proj.vpcf"
	else
		projectile_name = "particles/units/heroes/hero_drow/drow_base_attack_linear_proj.vpcf"
	end

	self.info = {
		Source = self:GetParent(),
		Ability = self:GetAbility(),
		vSpawnOrigin = self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector() * 100,
	    bDeleteOnHit = true,
	    iUnitTargetTeam = self:GetAbility():GetAbilityTargetTeam(),
	    iUnitTargetType = self:GetAbility():GetAbilityTargetType(),
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
	    EffectName = projectile_name,
	    fDistance = caster:Script_GetAttackRange() * range,
	    fStartRadius = width,
	    fEndRadius = width,
		bProvidesVision = true,
		iVisionRadius = vision,
		iVisionTeamNumber = caster:GetTeamNumber()
	}

	self:StartIntervalThink( delay )
	self:GetCaster():EmitSound("Hero_DrowRanger.Multishot.Channel")
end

function modifier_drow_ranger_multishot_custom_arbalet_14:OnDestroy()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/econ/items/drow/drow_arcana/drow_arcana_shard_hypothermia_death.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    local parent = self:GetParent()
    parent:AddNoDraw()
    Timers:CreateTimer(3, function()
        parent:Destroy()
    end)
	self:GetCaster():StopSound("Hero_DrowRanger.Multishot.Channel")
end

function modifier_drow_ranger_multishot_custom_arbalet_14:OnIntervalThink()

	if self.current_arrows<self.arrows then
		self:StartIntervalThink( self.arrow_delay )
	else
		self.current_arrows = 0
		self.current_wave = self.current_wave+1
        if self.current_wave >= self.max_waves then
            self:Destroy()
            self:GetParent():Interrupt()
        end
		self:StartIntervalThink( self.wave_delay )
		return
	end

	local step = self.angle/(self.arrows-1)
	local angle = -self.angle/2 + self.current_arrows*step

	local projectile_direction = RotatePosition( Vector(0,0,0), QAngle( 0, angle, 0 ), self.direction )

	self.info.vVelocity = projectile_direction * self.speed
	self.info.ExtraData = {
		arrow = self.current_arrows,
		wave = self.current_wave,
		frost = self.frost,
	}

	ProjectileManager:CreateLinearProjectile(self.info)
	self:PlayEffects()
	self.current_arrows = self.current_arrows+1
end

function modifier_drow_ranger_multishot_custom_arbalet_14:PlayEffects()

	local sound_cast

	if self.frost then
		sound_cast = "Hero_DrowRanger.Multishot.FrostArrows"
	else
		sound_cast = "Hero_DrowRanger.Multishot.Attack"
	end

	self:GetCaster():EmitSound(sound_cast)
end