--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_windrunner_powershot_custom_magic_resistance", "heroes/npc_dota_hero_windrunner_custom/windrunner_powershot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_windrunner_powershot_custom_magic_immune", "heroes/npc_dota_hero_windrunner_custom/windrunner_powershot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_windrunner_powershot_custom_slow", "heroes/npc_dota_hero_windrunner_custom/windrunner_powershot_custom", LUA_MODIFIER_MOTION_NONE)

windrunner_powershot_custom = class({})

function windrunner_powershot_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf", context )
    PrecacheResource( "particle", "particles/items_fx/black_king_bar_avatar.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_avatar.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/windrunner/windranger_arcana/windranger_arcana_spell_powershot.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_windrunner.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_windrunner.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_windrunner.vpcf", context)
end

windrunner_powershot_custom.modifier_windrunner_16_duration = 10
windrunner_powershot_custom.modifier_windrunner_16_debuff = {-6,-12,-18}
windrunner_powershot_custom.modifier_windrunner_21_duration = {0.5,1,1.5}
windrunner_powershot_custom.modifier_windrunner_22_bonus = {30,55,80}
windrunner_powershot_custom.modifier_windrunner_23_bonus = 2

function windrunner_powershot_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	self.point = self:GetCursorPosition()
    if self.point == self:GetCaster():GetAbsOrigin() then
        self.point = self.point + self:GetCaster():GetForwardVector()
    end
	EmitSoundOnLocationForAllies( self:GetCaster():GetOrigin(), "Ability.PowershotPull", self:GetCaster() )
	if self:GetCaster():HasModifier("modifier_windrunner_21") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_windrunner_powershot_custom_magic_immune", {duration = self.modifier_windrunner_21_duration[self:GetCaster():GetTalentLevel("modifier_windrunner_21")]})
	end
end

function windrunner_powershot_custom:GetChannelTime()
	local bonus = 1
	if self:GetCaster():HasModifier("modifier_windrunner_23") then
		bonus = self.modifier_windrunner_23_bonus
	end
	return self.BaseClass.GetChannelTime(self) / bonus
end

function windrunner_powershot_custom:OnChannelFinish( bInterrupted )
	if not IsServer() then return end
    local modifier_windrunner_tailwind_custom = self:GetCaster():FindModifierByName("modifier_windrunner_tailwind_custom")
    if modifier_windrunner_tailwind_custom then
        modifier_windrunner_tailwind_custom:ApplyBonus()
    end

	local caster = self:GetCaster()

	local point = self.point

	local channel_pct = (GameRules:GetGameTime() - self:GetChannelStartTime()) / self:GetChannelTime()

	local damage = self:GetSpecialValueFor( "powershot_damage" )
    local slow = self:GetSpecialValueFor( "slow" )

	local reduction = 1 -( self:GetSpecialValueFor( "damage_reduction" )  / 100 )

	local vision_radius = self:GetSpecialValueFor( "vision_radius" )

	local projectile_speed = self:GetSpecialValueFor( "arrow_speed" )

	local projectile_distance = self:GetSpecialValueFor( "arrow_range" )

	local projectile_radius = self:GetSpecialValueFor( "arrow_width" )


	if self:GetCaster():HasModifier("modifier_windrunner_22") then
		damage = damage + ( self:GetCaster():GetIntellect(false) / 100 * self.modifier_windrunner_22_bonus[self:GetCaster():GetTalentLevel("modifier_windrunner_22")])
	end

	if self:GetCaster():HasModifier("modifier_windrunner_21") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_windrunner_powershot_custom_magic_immune", {duration = self.modifier_windrunner_21_duration[self:GetCaster():GetTalentLevel("modifier_windrunner_21")]})
	end

	local projectile_direction = point-caster:GetOrigin()
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf",
	    fDistance = projectile_distance,
	    fStartRadius = projectile_radius,
	    fEndRadius = projectile_radius,
		vVelocity = projectile_direction * projectile_speed,
	
		bProvidesVision = true,
		iVisionRadius = vision_radius,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}
	local projectile = ProjectileManager:CreateLinearProjectile(info)

        
	self.projectiles[projectile] = {}
	self.projectiles[projectile].damage = damage*channel_pct
    self.projectiles[projectile].slow = slow*channel_pct
	self.projectiles[projectile].reduction = reduction
	self:GetCaster():EmitSound("Ability.Powershot")
end

windrunner_powershot_custom.projectiles = {}

function windrunner_powershot_custom:OnProjectileHitHandle( target, location, handle )
	if not target then
		self.projectiles[handle] = nil
		local vision_radius = self:GetSpecialValueFor( "vision_radius" )
		local vision_duration = self:GetSpecialValueFor( "vision_duration" )
		AddFOWViewer( self:GetCaster():GetTeamNumber(), location, vision_radius, vision_duration, false )
		return
	end
	if self:GetCaster():HasModifier("modifier_windrunner_16") then
		target:AddNewModifier(self:GetCaster(), self, "modifier_windrunner_powershot_custom_magic_resistance", {duration = self.modifier_windrunner_16_duration })
	end
	local data = self.projectiles[handle]
	local damage = data.damage
    local slow = data.slow
	ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = self:GetAbilityDamageType(), ability = self })
    print(slow)
    target:AddNewModifier(self:GetCaster(), self, "modifier_windrunner_powershot_custom_slow", {duration = self:GetSpecialValueFor("slow_duration") * (1 - target:GetStatusResistance()), slow = slow})
	data.damage = damage * data.reduction
    data.slow = slow * data.reduction
    
	target:EmitSound("Hero_Windrunner.PowershotDamage")
	return false
end

function windrunner_powershot_custom:OnProjectileThink( location )
	if not IsServer() then return end
	local tree_width = self:GetSpecialValueFor( "tree_width" )
	GridNav:DestroyTreesAroundPoint(location, tree_width, false)	
end


modifier_windrunner_powershot_custom_magic_resistance = class({})

function modifier_windrunner_powershot_custom_magic_resistance:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_windrunner_powershot_custom_magic_resistance:GetModifierMagicalResistanceBonus()
	return self:GetAbility().modifier_windrunner_16_debuff[self:GetCaster():GetTalentLevel("modifier_windrunner_16")]
end

function modifier_windrunner_powershot_custom_magic_resistance:GetTexture()
	return "windrunner_16"
end


modifier_windrunner_powershot_custom_magic_immune = class({})

function modifier_windrunner_powershot_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_windrunner_powershot_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_windrunner_powershot_custom_magic_immune:CheckState()
    return {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_windrunner_powershot_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_windrunner_powershot_custom_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_windrunner_powershot_custom_magic_immune:GetTexture()
	return "windrunner_21"
end

function modifier_windrunner_powershot_custom_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_windrunner_powershot_custom_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_windrunner_powershot_custom_magic_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end

windrunner_ultra_powershot_custom = class({})

windrunner_ultra_powershot_custom.modifier_windrunner_16_duration = 10
windrunner_ultra_powershot_custom.modifier_windrunner_16_debuff = {-5,-10,-15}
windrunner_ultra_powershot_custom.modifier_windrunner_21_duration = {0.5,1,1.5}
windrunner_ultra_powershot_custom.modifier_windrunner_22_bonus = 120
windrunner_ultra_powershot_custom.modifier_windrunner_23_bonus = 2

function windrunner_ultra_powershot_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	if self:GetCaster():HasModifier("modifier_windrunner_21") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_windrunner_powershot_custom_magic_immune", {duration = self.modifier_windrunner_21_duration[self:GetCaster():GetTalentLevel("modifier_windrunner_21")]})
	end
	EmitSoundOnLocationForAllies( self:GetCaster():GetOrigin(), "Ability.PowershotPull", self:GetCaster() )
end

function windrunner_ultra_powershot_custom:GetChannelTime()
	local bonus = 1
	if self:GetCaster():HasModifier("modifier_windrunner_23") then
		bonus = self.modifier_windrunner_23_bonus
	end
	return self.BaseClass.GetChannelTime(self) / bonus
end

function windrunner_ultra_powershot_custom:OnChannelFinish( bInterrupted )
	if not IsServer() then return end
    local modifier_windrunner_tailwind_custom = self:GetCaster():FindModifierByName("modifier_windrunner_tailwind_custom")
    if modifier_windrunner_tailwind_custom then
        modifier_windrunner_tailwind_custom:ApplyBonus()
    end

	local caster = self:GetCaster()

	local point = self:GetCursorPosition()

	local channel_pct = (GameRules:GetGameTime() - self:GetChannelStartTime()) / self:GetChannelTime()

	local damage = self:GetSpecialValueFor( "powershot_damage" )

	local reduction = 1 - (self:GetSpecialValueFor( "damage_reduction" ) / 100 )

	local vision_radius = self:GetSpecialValueFor( "vision_radius" )

	local projectile_speed = self:GetSpecialValueFor( "arrow_speed" )

	local projectile_distance = self:GetSpecialValueFor( "arrow_range" )

	local projectile_radius = self:GetSpecialValueFor( "arrow_width" )


	if self:GetCaster():HasModifier("modifier_windrunner_22") then
		damage = damage + (( self:GetCaster():GetIntellect(false) / 100 * self.modifier_windrunner_22_bonus) * 3)
	end

	local projectile_direction = point-caster:GetOrigin()
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = "particles/econ/items/windrunner/windranger_arcana/windranger_arcana_spell_powershot.vpcf",
	    fDistance = projectile_distance,
	    fStartRadius = projectile_radius,
	    fEndRadius = projectile_radius,
		vVelocity = projectile_direction * projectile_speed,
	
		bProvidesVision = true,
		iVisionRadius = vision_radius,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}
	local projectile = ProjectileManager:CreateLinearProjectile(info)

	self.projectiles[projectile] = {}
	self.projectiles[projectile].damage = damage*channel_pct
	self.projectiles[projectile].reduction = reduction
	self:GetCaster():EmitSound("Ability.Powershot")
end

windrunner_ultra_powershot_custom.projectiles = {}

function windrunner_ultra_powershot_custom:OnProjectileHitHandle( target, location, handle )
	if not target then
		self.projectiles[handle] = nil
		local vision_radius = self:GetSpecialValueFor( "vision_radius" )
		local vision_duration = self:GetSpecialValueFor( "vision_duration" )
		AddFOWViewer( self:GetCaster():GetTeamNumber(), location, vision_radius, vision_duration, false )
		return
	end

	if self:GetCaster():HasModifier("modifier_windrunner_16") then
		target:AddNewModifier(self:GetCaster(), self, "modifier_windrunner_powershot_custom_magic_resistance", {duration = self.modifier_windrunner_16_duration })
	end

	local data = self.projectiles[handle]
	local damage = data.damage

	print("ultra", damage)
	ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = self:GetAbilityDamageType(), ability = self })

	data.damage = damage * data.reduction
	target:EmitSound("Hero_Windrunner.PowershotDamage")
end

function windrunner_ultra_powershot_custom:OnProjectileThink( location )
	if not IsServer() then return end
	local tree_width = self:GetSpecialValueFor( "tree_width" )
	GridNav:DestroyTreesAroundPoint(location, tree_width, false)	
end

modifier_windrunner_powershot_custom_slow = class({})

function modifier_windrunner_powershot_custom_slow:OnCreated(params)
    if not IsServer() then return end
    self.slow = -params.slow
    self:SetHasCustomTransmitterData( true )
end

function modifier_windrunner_powershot_custom_slow:AddCustomTransmitterData()
	local data = 
    {
		slow = self.slow,
	}
	return data
end

function modifier_windrunner_powershot_custom_slow:HandleCustomTransmitterData( data )
	self.slow = data.slow
end

function modifier_windrunner_powershot_custom_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_windrunner_powershot_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return self.slow
end