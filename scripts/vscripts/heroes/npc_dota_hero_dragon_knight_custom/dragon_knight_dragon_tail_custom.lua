--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dragon_knight_dragon_tail_custom_aggro", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_dragon_tail_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_knight_dragon_tail_custom_armor", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_dragon_tail_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_knight_dragon_tail_custom_armor_debuff", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_dragon_tail_custom", LUA_MODIFIER_MOTION_NONE)

dragon_knight_dragon_tail_custom = class({})

dragon_knight_dragon_tail_custom.modifier_dragon_knight_7_radius = 325
dragon_knight_dragon_tail_custom.modifier_dragon_knight_3_movespeed = 550
dragon_knight_dragon_tail_custom.modifier_dragon_knight_5_bonus_armor = {15,30,45}
dragon_knight_dragon_tail_custom.modifier_dragon_knight_5_duration = 4
dragon_knight_dragon_tail_custom.modifier_dragon_knight_7_bonus_duration = 1

dragon_knight_dragon_tail_custom.modifier_dragon_knight_6_duration = 4
dragon_knight_dragon_tail_custom.modifier_dragon_knight_6 = -9

function dragon_knight_dragon_tail_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_dragon_knight/dragon_knight_dragon_tail_dragonform_proj.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_dragon_knight/dragon_knight_dragon_tail.vpcf', context )
    PrecacheResource( "particle", 'particles/status_fx/status_effect_beserkers_call.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_dazzle/dazzle_armor_friend.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_dazzle/dazzle_armor_enemy.vpcf', context )
end

function dragon_knight_dragon_tail_custom:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_1" ) 
    or self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_2" ) 
    or self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_3" ) 
    or self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_4" ) then
		return self:GetSpecialValueFor("dragon_cast_range")
	else
		return self.BaseClass.GetCastRange( self, vLocation, hTarget )
	end
end

function dragon_knight_dragon_tail_custom:GetAOERadius()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_dragon_knight_7") then
        bonus = self.modifier_dragon_knight_7_radius
    end
    return self:GetSpecialValueFor("aoe") + bonus
end

function dragon_knight_dragon_tail_custom:CastFilterResultTarget( hTarget )
    if hTarget:IsMagicImmune() then
        return UF_FAIL_MAGIC_IMMUNE_ENEMY
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

function dragon_knight_dragon_tail_custom:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

function dragon_knight_dragon_tail_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
    local aoe = self:GetSpecialValueFor("aoe")
	if self:GetCaster():HasModifier("modifier_dragon_knight_5") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_dragon_knight_dragon_tail_custom_armor", {duration = self.modifier_dragon_knight_5_duration})
	end
    if self:GetCaster():HasModifier("modifier_dragon_knight_7") then
        aoe = aoe + self:GetCaster():GetAoeBonus(self.modifier_dragon_knight_7_radius)
    end
	self:GetCaster():EmitSound("Hero_DragonKnight.DragonTail.Cast")

	local flag = 0
	if self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_1" ) 
    or self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_2" ) 
    or self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_3" ) 
    or self:GetCaster():HasModifier( "modifier_dragon_knight_elder_dragon_form_custom_4" ) then
        local info = {
            Target = target,
            Source = caster,
            Ability = self,
            iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
            EffectName = "particles/units/heroes/hero_dragon_knight/dragon_knight_dragon_tail_dragonform_proj.vpcf",
            iMoveSpeed = self:GetSpecialValueFor( "projectile_speed" ),
            bDodgeable = true,
            ExtraData = 
            {
                aoe = 1,
            }
        }
        local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, nil, aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, flag, 0, false )
        for _, enemy in pairs(targets) do
            info.Target = enemy
            ProjectileManager:CreateTrackingProjectile(info)
        end
	else
        local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, flag, 0, false )
        for _, enemy in pairs(targets) do
            self:Hit( enemy, false, true )
        end
	end
end

function dragon_knight_dragon_tail_custom:Hit( target, dragonform, aoe )
	local caster = self:GetCaster()

	if target:TriggerSpellAbsorb( self ) then return end

	local modifier = "modifier_stunned"

	if self:GetCaster():HasModifier("modifier_dragon_knight_3") then
		modifier = "modifier_dragon_knight_dragon_tail_custom_aggro"
	end

	local damage = self:GetSpecialValueFor( "damage" )
	local duration = self:GetSpecialValueFor( "stun_duration" )

	if self:GetCaster():HasModifier("modifier_dragon_knight_7") then
		duration = duration + self.modifier_dragon_knight_7_bonus_duration
	end

	if self:GetCaster():HasModifier("modifier_dragon_knight_6") then
		target:AddNewModifier(self:GetCaster(), self, "modifier_dragon_knight_dragon_tail_custom_armor_debuff", {duration = self.modifier_dragon_knight_6_duration * ( 1 - target:GetStatusResistance())})
	end
	
	ApplyDamage({ victim = target, attacker = caster, damage = damage, damage_type = self:GetAbilityDamageType(), ability = self })
	target:AddNewModifier( caster, self, modifier, { duration = duration * ( 1 - target:GetStatusResistance()) } )
	self:PlayEffects( target, dragonform )
	target:EmitSound("Hero_DragonKnight.DragonTail.Target")
end

function dragon_knight_dragon_tail_custom:OnProjectileHit_ExtraData( target, location, extra )
	if not target then return end
	if target:IsMagicImmune() then return end
	if extra and extra.aoe and extra.aoe == 1 then
		self:Hit( target, true, true )
		return
	end
	self:Hit( target, true )
end

function dragon_knight_dragon_tail_custom:PlayEffects( target, dragonform )
	local vec = target:GetOrigin()-self:GetCaster():GetOrigin()
	local attach = "attach_attack1"

	if dragonform then
		attach = "attach_attack2"
	end

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dragon_knight/dragon_knight_dragon_tail.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 3, vec )
	ParticleManager:SetParticleControlEnt( effect_cast, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, attach, Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( effect_cast, 4, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_dragon_knight_dragon_tail_custom_aggro = class({})

function modifier_dragon_knight_dragon_tail_custom_aggro:OnCreated( kv )
    if not IsServer() then return end
    self:GetParent():SetForceAttackTarget( self:GetCaster() )
    self:GetParent():MoveToTargetToAttack( self:GetCaster() )
    self:StartIntervalThink(FrameTime())
end

function modifier_dragon_knight_dragon_tail_custom_aggro:OnIntervalThink( kv )
    if not IsServer() then return end
    if not self:GetCaster():IsAlive() then
        if not self:IsNull() then
            self:Destroy()
        end
    end
end

function modifier_dragon_knight_dragon_tail_custom_aggro:OnRemoved()
    if not IsServer() then return end
    self:GetParent():SetForceAttackTarget( nil )
end

function modifier_dragon_knight_dragon_tail_custom_aggro:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE
	}
end

function modifier_dragon_knight_dragon_tail_custom_aggro:GetModifierMoveSpeed_Absolute()
	return self:GetAbility().modifier_dragon_knight_3_movespeed
end

function modifier_dragon_knight_dragon_tail_custom_aggro:CheckState()
    local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_TAUNTED] = true,
    }

    return state
end

function modifier_dragon_knight_dragon_tail_custom_aggro:GetStatusEffectName()
    return "particles/status_fx/status_effect_beserkers_call.vpcf"
end

modifier_dragon_knight_dragon_tail_custom_armor = class({})

function modifier_dragon_knight_dragon_tail_custom_armor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_dragon_knight_dragon_tail_custom_armor:GetModifierPhysicalArmorBonus()
	return self:GetAbility().modifier_dragon_knight_5_bonus_armor[self:GetCaster():GetTalentLevel("modifier_dragon_knight_5")]
end

function modifier_dragon_knight_dragon_tail_custom_armor:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_armor_friend.vpcf"
end

function modifier_dragon_knight_dragon_tail_custom_armor:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

modifier_dragon_knight_dragon_tail_custom_armor_debuff = class({})

function modifier_dragon_knight_dragon_tail_custom_armor_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_dragon_knight_dragon_tail_custom_armor_debuff:GetModifierPhysicalArmorBonus()
	return self:GetAbility().modifier_dragon_knight_6
end

function modifier_dragon_knight_dragon_tail_custom_armor_debuff:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_armor_enemy.vpcf"
end

function modifier_dragon_knight_dragon_tail_custom_armor_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end