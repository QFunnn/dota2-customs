--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

keeper_of_the_light_light_illusion_point = class({})

function keeper_of_the_light_light_illusion_point:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context )
    PrecacheResource("particle", "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_marci/marci_rebound_bounce.vpcf", context)
    PrecacheResource("particle", "particles/status_fx/status_effect_phantom_lancer_illstrong.vpcf", context)
    PrecacheResource("model", "models/heroes/vengeful/vengeful.vmdl", context)
end

function keeper_of_the_light_light_illusion_point:OnSpellStart()
    if not IsServer() then return end
    local keeper_of_the_light_light_illusion = self:GetCaster():FindAbilityByName("keeper_of_the_light_light_illusion")
    if keeper_of_the_light_light_illusion then
        local range = self:GetSpecialValueFor("range")
        local target = keeper_of_the_light_light_illusion.spirit
        local point = self:GetCursorPosition()
        local direction = (point - target:GetAbsOrigin())
        direction.z = 0
        local distance = direction:Length2D()
        direction = direction:Normalized()
        target:SetForwardVector( direction )
        local arc = target:AddNewModifier(self:GetCaster(), self, "modifier_generic_arc_lua",
        { 
            dir_x = direction.x,
            dir_y = direction.y,
            duration = 0.4,
            distance = distance,
            height = 120,
            fix_end = false,
            isStun = true,
            isForward = true,
            activity = ACT_DOTA_FLAIL,
        })
        target:AddNewModifier(target, nil, "modifier_invulnerable", {})
        local modifier_illusion = target:FindModifierByName("modifier_illusion")
        if modifier_illusion then
            modifier_illusion:SetDuration(10, true)
        end
        if arc then
            local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_rebound_bounce.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
            ParticleManager:SetParticleControlEnt( effect_cast, 1, target, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
            ParticleManager:SetParticleControlEnt( effect_cast, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
            arc:AddParticle( effect_cast, false, false, -1, false, false )
        end
        target:EmitSound("Hero_Marci.Rebound.Leap")
        arc:SetEndCallback( function( interrupted )
            self:DamageAround(target)
        end)
        self:SetActivated(false)
    end
end

function keeper_of_the_light_light_illusion_point:DamageAround(target)
    self:SetActivated(true)
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetCaster():GetAgility() / 100 * self:GetSpecialValueFor("damage")
    local damage_type = DAMAGE_TYPE_MAGICAL
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _,enemy in pairs(enemies) do
        ApplyDamage({victim = enemy, damage = damage, damage_type = damage_type, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self})
    end
    local center = target:GetAbsOrigin()
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, center )
    ParticleManager:SetParticleControl( effect_cast, 1, center )
    ParticleManager:SetParticleControl( effect_cast, 9, Vector(radius, radius, radius) )
    ParticleManager:SetParticleControl( effect_cast, 10, center )
    ParticleManager:DestroyParticle(effect_cast, false)
    ParticleManager:ReleaseParticleIndex( effect_cast )
    EmitSoundOnLocationWithCaster( center, "Hero_Marci.Rebound.Impact", target )
    target:ForceKill(false)
    self:GetCaster():RemoveModifierByName("modifier_keeper_of_the_light_light_illusion")
end