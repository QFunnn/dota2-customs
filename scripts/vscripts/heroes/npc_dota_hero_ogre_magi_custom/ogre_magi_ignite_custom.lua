--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ogre_magi_ignite_custom", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_ignite_custom", LUA_MODIFIER_MOTION_NONE )

ogre_magi_ignite_custom = class({})

ogre_magi_ignite_custom.modifier_ogre_magi_1 = {1,2}
ogre_magi_ignite_custom.modifier_ogre_magi_1_cd = {-2,-4}
ogre_magi_ignite_custom.modifier_ogre_magi_7_damage_per_second = 7
ogre_magi_ignite_custom.modifier_ogre_magi_7_max_seconds = 150

function ogre_magi_ignite_custom:GetCooldown(iLevel)
    local cooldown = self.BaseClass.GetCooldown(self, iLevel)
    if self:GetCaster():HasModifier("modifier_ogre_magi_1") then
        cooldown = cooldown + self.modifier_ogre_magi_1_cd[self:GetCaster():GetTalentLevel("modifier_ogre_magi_1")]
    end
    return cooldown
end

function ogre_magi_ignite_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_ogre_magi_4") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function ogre_magi_ignite_custom:OnSpellStart(new_target)
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    if new_target ~= nil then
        target = new_target
    end
    local particle_name = "particles/units/heroes/hero_ogre_magi/ogre_magi_ignite.vpcf"
    local info = 
    {
        Target = target,
        Source = caster,
        Ability = self,	
        EffectName = particle_name,
        iMoveSpeed = self:GetSpecialValueFor( "projectile_speed" ),
        bDodgeable = true,
        ExtraData = {}
    }
    ProjectileManager:CreateTrackingProjectile(info)
    local extra_targets = 1
    if caster:HasModifier("modifier_ogre_magi_1") then
        extra_targets = extra_targets + self.modifier_ogre_magi_1[caster:GetTalentLevel("modifier_ogre_magi_1")]
    end
    local units = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, self:GetSpecialValueFor("ignite_multicast_aoe"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false)
    local extra_count = 0
    for _,enemy in pairs(units) do
        if enemy ~= target then
            info.Target = enemy
            ProjectileManager:CreateTrackingProjectile(info)
            extra_count = extra_count + 1
            if extra_count >= extra_targets then break end
        end
    end
    caster:EmitSound("Hero_OgreMagi.Ignite.Cast")
end

function ogre_magi_ignite_custom:OnProjectileHit_ExtraData( target, location, data)
    if not target then return end
    if target:TriggerSpellAbsorb( self ) then return end
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance())
	local modifier_ogre_magi_ignite_custom = target:FindModifierByName("modifier_ogre_magi_ignite_custom")
	if modifier_ogre_magi_ignite_custom then 
		modifier_ogre_magi_ignite_custom:SetDuration(modifier_ogre_magi_ignite_custom:GetRemainingTime() + duration, true)
	else 
		target:AddNewModifier(caster, self, "modifier_ogre_magi_ignite_custom", {duration = duration})
    end
    target:EmitSound("Hero_OgreMagi.Ignite.Target")
end

modifier_ogre_magi_ignite_custom = class({})

function modifier_ogre_magi_ignite_custom:OnCreated( kv )
    self.caster = self:GetCaster()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.slow = self.ability:GetSpecialValueFor( "slow_movement_speed_pct" )
    self.damage = self.ability:GetSpecialValueFor( "burn_damage" )
    self.interval = 1
    if not IsServer() then return end
    self.elapsed = 0
    local effect_name = "particles/units/heroes/hero_ogre_magi/ogre_magi_ignite_debuff.vpcf"
    local particle = ParticleManager:CreateParticle(effect_name, PATTACH_ABSORIGIN_FOLLOW, self.parent)
    self:AddParticle(particle, false, false, -1, false, false)
    self.damageTable = {victim = self.parent, attacker = self.caster, damage_type = self.ability:GetAbilityDamageType(), ability = self.ability}
    self:StartIntervalThink(self.interval - FrameTime())
end

function modifier_ogre_magi_ignite_custom:OnRefresh()
    self.caster = self:GetCaster()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.slow = self.ability:GetSpecialValueFor( "slow_movement_speed_pct" )
    self.damage = self.ability:GetSpecialValueFor( "burn_damage" )
    self.interval = 1
    if not IsServer() then return end
    self.damageTable = {victim = self.parent, attacker = self.caster, damage_type = self.ability:GetAbilityDamageType(), ability = self.ability}
end

function modifier_ogre_magi_ignite_custom:OnIntervalThink()
    if not IsServer() then return end
    self.elapsed = (self.elapsed or 0) + self.interval
    local damage = self.damage
    if self.caster:HasModifier("modifier_ogre_magi_7") then
        damage = damage + self.ability.modifier_ogre_magi_7_damage_per_second * math.min(self:GetRemainingTime(), self.ability.modifier_ogre_magi_7_max_seconds)
    end
    self.damageTable.damage = damage
    local out_damage = ApplyDamage( self.damageTable )
    self.parent:EmitSound("Hero_OgreMagi.Ignite.Damage")
end

function modifier_ogre_magi_ignite_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_ogre_magi_ignite_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.slow
end