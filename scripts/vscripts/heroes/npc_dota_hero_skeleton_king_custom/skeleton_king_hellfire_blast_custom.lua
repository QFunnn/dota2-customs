--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_skeleton_king_hellfire_blast_custom_debuff", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_hellfire_blast_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skeleton_king_hellfire_blast_skelet_buff", "heroes/npc_dota_hero_skeleton_king_custom/skeleton_king_hellfire_blast_custom", LUA_MODIFIER_MOTION_NONE )

skeleton_king_hellfire_blast_custom = class({})

skeleton_king_hellfire_blast_custom.modifier_skeleton_king_1 = 300
skeleton_king_hellfire_blast_custom.modifier_skeleton_king_1_health_regen = {50,100}
skeleton_king_hellfire_blast_custom.modifier_skeleton_king_6 = {0.2,0.4,0.6}
skeleton_king_hellfire_blast_custom.modifier_skeleton_king_3 = {1,2}
skeleton_king_hellfire_blast_custom.modifier_skeleton_king_9 = {3,6,9}
skeleton_king_hellfire_blast_custom.modifier_skeleton_king_9_out = 27
skeleton_king_hellfire_blast_custom.modifier_skeleton_king_9_inc = 220

function skeleton_king_hellfire_blast_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/skeleton_king_weapon_blur_critical.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/skeleton_king_weapon_blur.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/skeleton_king_weapon_blur_reverse.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast_warmup.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast_explosion.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast_warmup.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast_explosion.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_skeleton_king.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_skeleton_king.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_skeleton_king.vpcf", context)
end

function skeleton_king_hellfire_blast_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_skeleton_king_1") then
        return "modifier_skeleton_king_1"
    end
    return "skeleton_king_hellfire_blast"
end

function skeleton_king_hellfire_blast_custom:OnAbilityPhaseStart()
    local part_name = "particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast_warmup.vpcf"
    if self:GetCaster():HasModifier("modifier_skeleton_king_1") then
        part_name = "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast_warmup.vpcf"
    end
    local particle = ParticleManager:CreateParticle(part_name, PATTACH_CUSTOMORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    return true
end

function skeleton_king_hellfire_blast_custom:GetManaCost(level)
	if self:GetCaster():HasModifier("modifier_skeleton_king_7") then
		return 0
	end
    return self.BaseClass.GetManaCost(self, level)
end

function skeleton_king_hellfire_blast_custom:OnSpellStart(new_target)
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    if new_target ~= nil then 
        target = new_target
    end
    local proj_name = "particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast.vpcf"
    if self:GetCaster():HasModifier("modifier_skeleton_king_1") then
        proj_name = "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast.vpcf"
    end
    local info =
    {
        EffectName = proj_name,
        Ability = self,
        iMoveSpeed = self:GetSpecialValueFor("blast_speed"),
        Source = self:GetCaster(),
        Target = target,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
    }
    ProjectileManager:CreateTrackingProjectile( info )
    self:GetCaster():EmitSound("Hero_SkeletonKing.Hellfire_Blast")
    local all_skeletons = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, 2000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 0, FIND_CLOSEST, false )
    for _, skelet in pairs(all_skeletons) do
        if skelet.skelet then
            skelet:AddNewModifier(self:GetCaster(), self, "modifier_skeleton_king_hellfire_blast_skelet_buff", {duration = self:GetSpecialValueFor("blast_stun_duration")})
        end
    end
end

function skeleton_king_hellfire_blast_custom:UseStun(target)
    if not IsServer() then return end
    local stun_duration = self:GetSpecialValueFor( "blast_stun_duration" )
    if self:GetCaster():HasModifier("modifier_skeleton_king_6") then
        stun_duration = stun_duration + self.modifier_skeleton_king_6[self:GetCaster():GetTalentLevel("modifier_skeleton_king_6")]
    end
    local slow_duration = self:GetSpecialValueFor( "blast_dot_duration" )
    if self:GetCaster():HasModifier("modifier_skeleton_king_3") then
        slow_duration = slow_duration + self.modifier_skeleton_king_3[self:GetCaster():GetTalentLevel("modifier_skeleton_king_3")]
    end
    local stun_damage = self:GetAbilityDamage()
    stun_duration = stun_duration * (1 - target:GetStatusResistance())
    target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = stun_duration})
    target:AddNewModifier( self:GetCaster(), self, "modifier_skeleton_king_hellfire_blast_custom_debuff", { duration = stun_duration + slow_duration, delay = stun_duration} )
    if self:GetCaster():HasModifier("modifier_skeleton_king_1") then
        local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, self.modifier_skeleton_king_1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _, unit in pairs(units) do
            if unit ~= target then
                unit:AddNewModifier( self:GetCaster(), self, "modifier_skeleton_king_hellfire_blast_custom_debuff", { duration = slow_duration, delay = 0} )
            end
        end
    end
    local damage = 
    {
        victim = target,
        attacker = self:GetCaster(),
        damage = stun_damage,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self
    }
    ApplyDamage( damage )
    target:EmitSound("Hero_SkeletonKing.Hellfire_BlastImpact")
    local exp = "particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast_explosion.vpcf"
    if self:GetCaster():HasModifier("modifier_skeleton_king_1") then
        exp = "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast_explosion.vpcf"
    end
    local particle = ParticleManager:CreateParticle(exp, PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    if self:GetCaster():HasModifier("modifier_skeleton_king_9") then
        local illusion = CreateIllusions( self:GetCaster(), self:GetCaster(), {duration=self.modifier_skeleton_king_9[self:GetCaster():GetTalentLevel("modifier_skeleton_king_9")],outgoing_damage=self.modifier_skeleton_king_9_out-100,incoming_damage=self.modifier_skeleton_king_9_inc-100}, 1, 0, false, false )  
        for k, v in pairs(illusion) do
            FindClearSpaceForUnit(v, target:GetAbsOrigin(), true)
            Timers:CreateTimer(0.1, function()
                v:MoveToPositionAggressive(target:GetAbsOrigin())
            end)
        end
    end
end

function skeleton_king_hellfire_blast_custom:OnProjectileHit( target, vLocation )
    if not IsServer() then return end
    if not target then return end
    if target:IsMagicImmune() then return end
    if target:TriggerSpellAbsorb( self ) then return end
    self:UseStun(target)
end

modifier_skeleton_king_hellfire_blast_custom_debuff = class({})
function modifier_skeleton_king_hellfire_blast_custom_debuff:IsPurgeException() return true end
function modifier_skeleton_king_hellfire_blast_custom_debuff:OnCreated( kv )
    self.move_slow = self:GetAbility():GetSpecialValueFor( "blast_slow" )
    if not IsServer() then return end
    self.per_damage = self:GetAbility():GetSpecialValueFor( "blast_dot_damage" )
    if self:GetCaster():HasModifier("modifier_skeleton_king_1") then
        self.per_damage = self.per_damage + (self:GetCaster():GetHealthRegen() / 100 * self:GetAbility().modifier_skeleton_king_1_health_regen[self:GetCaster():GetTalentLevel("modifier_skeleton_king_1")])
    end
    local particle_name_debuff = "particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast_debuff.vpcf"
    if self:GetCaster():HasModifier("modifier_skeleton_king_1") then
        particle_name_debuff = "particles/econ/items/wraith_king/wraith_king_ti6_bracer/wraith_king_ti6_hellfireblast_debuff.vpcf"
    end
    local debuff_particle = ParticleManager:CreateParticle(particle_name_debuff, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(debuff_particle, false, false, -1, false, false)
    self.interval = 1
    self.count = self:GetAbility():GetSpecialValueFor( "blast_dot_duration" )
    if self:GetCaster():HasModifier("modifier_skeleton_king_3") then
        self.count = self.count + self:GetAbility().modifier_skeleton_king_3[self:GetCaster():GetTalentLevel("modifier_skeleton_king_3")]
    end
    self:StartIntervalThink( kv.delay + FrameTime())
end

function modifier_skeleton_king_hellfire_blast_custom_debuff:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
    return funcs
end

function modifier_skeleton_king_hellfire_blast_custom_debuff:GetModifierMoveSpeedBonus_Percentage( params )
    return self.move_slow
end

function modifier_skeleton_king_hellfire_blast_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    if self.count < 1 then return end 
    self.count = self.count - 1
    local damage = self.per_damage
    local damageTable = 
    {
        victim = self:GetParent(),
        attacker = self:GetCaster(),
        damage = damage,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self:GetAbility()
    }
    ApplyDamage( damageTable )
    self:StartIntervalThink(self.interval)
end

modifier_skeleton_king_hellfire_blast_skelet_buff = class({})

function modifier_skeleton_king_hellfire_blast_skelet_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_skeleton_king_hellfire_blast_skelet_buff:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_move_speed")
end

function modifier_skeleton_king_hellfire_blast_skelet_buff:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end