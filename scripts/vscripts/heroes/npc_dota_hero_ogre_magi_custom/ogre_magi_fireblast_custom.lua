--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ogre_magi_fireblast_custom", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_fireblast_custom", LUA_MODIFIER_MOTION_NONE)

ogre_magi_fireblast_custom = class({})

ogre_magi_fireblast_custom.modifier_ogre_magi_14 = 10
ogre_magi_fireblast_custom.modifier_ogre_magi_15_radius = 175
ogre_magi_fireblast_custom.modifier_ogre_magi_16 = {20,40}

function ogre_magi_fireblast_custom:GetIntrinsicModifierName()
    return "modifier_ogre_magi_fireblast_custom"
end

function ogre_magi_fireblast_custom:GetAOERadius()
    if self:GetCaster():HasModifier("modifier_ogre_magi_15") then
        return self.modifier_ogre_magi_15_radius
    end
end

function ogre_magi_fireblast_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context )
end

function ogre_magi_fireblast_custom:OnSpellStart(new_target)
    self:Cast(new_target)
end

function ogre_magi_fireblast_custom:Cast(new_target, ignore_multicast)
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
    if not ignore_multicast then
	    if target:TriggerSpellAbsorb( self ) then return end
    end
	self:Impact(target, self)
    if not new_target then
        local modifier_ogre_magi_multicast_custom = caster:FindModifierByName("modifier_ogre_magi_multicast_custom")
        if modifier_ogre_magi_multicast_custom then
            modifier_ogre_magi_multicast_custom:OnAbilityFullyCast({ability = self, unit = caster, target = target, is_fast_multicast = true})
        end
    end
end

function ogre_magi_fireblast_custom:Impact(target, ability)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local duration = ability:GetSpecialValueFor( "stun_duration" )
    local damage = ability:GetSpecialValueFor("fireblast_damage")
    if caster:HasModifier("modifier_ogre_magi_16") then
        damage = damage + (caster:GetIntellect(false) * self.modifier_ogre_magi_16[caster:GetTalentLevel("modifier_ogre_magi_16")] / 100)
    end
    target:AddNewModifier(caster, ability, "modifier_stunned", {duration = duration * (1 - target:GetStatusResistance())})
    local out_damage = ApplyDamage( { victim = target, attacker = caster, damage = damage, damage_type = ability:GetAbilityDamageType(), ability = ability } )
    if caster:HasModifier("modifier_ogre_magi_15") then
        local enemies = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, self.modifier_ogre_magi_15_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        for _, enemy in pairs(enemies) do
            if enemy ~= target then
                ApplyDamage( { victim = enemy, attacker = caster, damage = damage, damage_type = ability:GetAbilityDamageType(), ability = ability } )
            end
        end
    end
    local pfx_name = "particles/units/heroes/hero_ogre_magi/ogre_magi_fireblast.vpcf"
    local particle = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControl( particle, 1, target:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( particle )
    target:EmitSound("Hero_OgreMagi.Fireblast.Target")
end

modifier_ogre_magi_fireblast_custom = class({})
function modifier_ogre_magi_fireblast_custom:IsHidden() return true end
function modifier_ogre_magi_fireblast_custom:IsPurgable() return false end
function modifier_ogre_magi_fireblast_custom:IsPurgeException() return false end
function modifier_ogre_magi_fireblast_custom:RemoveOnDeath() return false end
function modifier_ogre_magi_fireblast_custom:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    if params.target == self:GetParent() then return end
    if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if params.target:IsBuilding() then return end
    if self:GetParent():IsIllusion() then return end
    if not self:GetParent():HasModifier("modifier_ogre_magi_14") then return end
    if self:GetParent():HasModifier("modifier_ogre_magi_3") then return end
    local fireblast_proc = self:GetAbility().modifier_ogre_magi_14
    if RollPercentage(fireblast_proc) then
        self:GetAbility():Cast(params.target, true)
    end
end