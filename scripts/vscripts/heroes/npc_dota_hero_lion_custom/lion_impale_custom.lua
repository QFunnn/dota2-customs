--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

lion_impale_custom = class({})

function lion_impale_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_lion/lion_spell_impale.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/lion/lion_ti9/lion_spell_impale_ti9.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_lion/lion_spell_impale_hit_spikes.vpcf", context )
end

lion_impale_custom.modifier_lion_15 = 450
lion_impale_custom.modifier_lion_19 = {300,600}
lion_impale_custom.modifier_lion_20 = {50,75,100}
lion_impale_custom.modifier_lion_21_delay = 5

function lion_impale_custom:GetCastRange( vLocation, hTarget )
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_lion_19") then
		bonus = self.modifier_lion_19[self:GetCaster():GetTalentLevel("modifier_lion_19")]
	end
	return self.BaseClass.GetCastRange( self, vLocation, hTarget ) + bonus
end

function lion_impale_custom:GetAbilityTextureName()
	if self:GetCaster() and self:GetCaster():HasModifier("modifier_lion_21") then
		return "lion_21"
	end
	return "lion_impale"
end

function lion_impale_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
	local start_point = self:GetCaster():GetAbsOrigin()
	local length_buffer = self:GetSpecialValueFor("length_buffer") + self:GetCaster():GetCastRangeBonus()
	if target then
		point = target:GetOrigin()
	end
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
    local projectile_distance = self:GetCastRange( point, target ) + length_buffer
	self:StartCast(start_point, point, projectile_distance, true)
    if self:GetCaster():HasModifier("modifier_lion_21") then
        Timers:CreateTimer(self.modifier_lion_21_delay, function()
            self:StartCast(start_point, point, projectile_distance)
        end)
    end
end

function lion_impale_custom:StartCast(start_point, point, projectile_distance, IsMain)
    local index = DoUniqueString("index")
    self[index] = {}
    if self:GetCaster():HasModifier("modifier_lion_15") then
        for i=1,3 do
            self:StartProjectile(start_point, point, projectile_distance, i, IsMain, index)
        end
    else
        self:StartProjectile(start_point, point, projectile_distance, nil, IsMain, index)
    end
end

function lion_impale_custom:StartProjectile(start_point, point, projectile_distance, counter, IsMain, index)
	local projectile_name = "particles/units/heroes/hero_lion/lion_spell_impale.vpcf"
	if self:GetCaster():HasModifier("modifier_lion_21") then
		projectile_name = "particles/econ/items/lion/lion_ti9/lion_spell_impale_ti9.vpcf"
	end
	local projectile_radius = self:GetSpecialValueFor( "width" )
	local projectile_speed = self:GetSpecialValueFor( "speed" )
	local projectile_direction = point-start_point
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()
	local info = 
    {
		Source = self:GetCaster(),
		Ability = self,
		vSpawnOrigin = start_point,
	    bDeleteOnHit = false,
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    EffectName = projectile_name,
	    fDistance = projectile_distance,
	    fStartRadius = projectile_radius,
	    fEndRadius = projectile_radius,
		vVelocity = projectile_direction * projectile_speed,
        ExtraData =
        {
            IsMain = IsMain,
            index = index,
        }
	}
    local angles = {-15, 0, 15}
    if counter then
        local angle = angles[counter]
        info.vVelocity = RotateVector2DUnique( projectile_direction, ToRadians( angle ) ) * projectile_speed
    end
	ProjectileManager:CreateLinearProjectile(info)
	self:GetCaster():EmitSound("Hero_Lion.Impale")
end

function RotateVector2DUnique(vector, theta)
    local xp = vector.x*math.cos(theta)-vector.y*math.sin(theta)
    local yp = vector.x*math.sin(theta)+vector.y*math.cos(theta)
    return Vector(xp,yp,vector.z):Normalized()
end

function ToRadians(degrees)
    return degrees * math.pi / 180
end

function lion_impale_custom:OnProjectileHit_ExtraData(target, vLocation, data)
	if not target then return end
	if target:IsMagicImmune() then return end
    if self[data.index][target:entindex()] then return end
    self[data.index][target:entindex()] = true

	local duration = self:GetSpecialValueFor( "duration" )
    if not data.IsMain then
        duration = duration * 0.5
    end

	local damage = self:GetSpecialValueFor("damage")

	if self:GetCaster():HasModifier("modifier_lion_20") then
		damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_lion_20[self:GetCaster():GetTalentLevel("modifier_lion_20")])
	end

	local damageTable = 
	{
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	}

	target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = duration * (1-target:GetStatusResistance()) })
    if not target:IsDebuffImmune() then
        local knockback = target:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = 0.5 * (1-target:GetStatusResistance()), height = 350, IsStun = true } )
        local callback = function()
            target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = duration * (1-target:GetStatusResistance()) })
            ApplyDamage(damageTable)
            target:EmitSound("Hero_Lion.ImpaleTargetLand")
        end
        knockback:SetEndCallback( callback )
    end

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lion/lion_spell_impale_hit_spikes.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Hero_Lion.ImpaleHitTarget")
end

function lion_impale_custom:StunTarget(target)
	if target:IsMagicImmune() then return end
	local duration = self:GetSpecialValueFor( "duration" )
	local damage = self:GetSpecialValueFor("damage")

	if self:GetCaster():HasModifier("modifier_lion_20") then
		damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_lion_20[self:GetCaster():GetTalentLevel("modifier_lion_20")])
	end

	local damageTable = 
	{
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	}

	target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = duration * (1-target:GetStatusResistance()) })
	local knockback = target:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = 0.5, height = 350, IsStun = true } )

	local callback = function()
		ApplyDamage(damageTable)
		target:EmitSound("Hero_Lion.ImpaleTargetLand")
	end

	knockback:SetEndCallback( callback )

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lion/lion_spell_impale_hit_spikes.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Hero_Lion.ImpaleHitTarget")
end