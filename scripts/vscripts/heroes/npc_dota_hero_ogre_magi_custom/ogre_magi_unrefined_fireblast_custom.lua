--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ogre_magi_unrefined_fireblast_custom = class({})

function ogre_magi_unrefined_fireblast_custom:GetManaCost( level )
    return math.floor( self:GetCaster():GetMana() * self:GetSpecialValueFor( "scepter_mana" ) / 100 )
end

function ogre_magi_unrefined_fireblast_custom:OnSpellStart(new_target)
    self:Cast(new_target)
end

function ogre_magi_unrefined_fireblast_custom:Cast(new_target)
    local caster = self:GetCaster()
    caster:EmitSound("Hero_OgreMagi.Fireblast.Cast")
    local target = nil 
    if not new_target then 
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_fireblast_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(particle)
    end
    target = self:GetCursorTarget()
    if new_target ~= nil then 
        target = new_target
    end
	if target:TriggerSpellAbsorb( self ) then return end
	self:Impact(target, self)
    if not new_target then
        local modifier_ogre_magi_multicast_custom = caster:FindModifierByName("modifier_ogre_magi_multicast_custom")
        if modifier_ogre_magi_multicast_custom then
            modifier_ogre_magi_multicast_custom:OnAbilityFullyCast({ability = self, unit = caster, target = target, is_fast_multicast = true})
        end
    end
end

function ogre_magi_unrefined_fireblast_custom:Impact(target, ability)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local duration = ability:GetSpecialValueFor( "stun_duration" )
    local intellect_damage = ability:GetSpecialValueFor("intellect_damage")
    local damage = ability:GetSpecialValueFor("base_damage") + (self:GetCaster():GetIntellect(false) / 100 * intellect_damage)
    target:AddNewModifier(caster, ability, "modifier_stunned", {duration = duration * (1 - target:GetStatusResistance())})
    ApplyDamage( { victim = target, attacker = caster, damage = damage, damage_type = ability:GetAbilityDamageType(), ability = ability } )
    local pfx_name = "particles/units/heroes/hero_ogre_magi/ogre_magi_unr_fireblast.vpcf"
    local particle = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControl( particle, 1, target:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( particle )
    target:EmitSound("Hero_OgreMagi.Fireblast.Target")
end