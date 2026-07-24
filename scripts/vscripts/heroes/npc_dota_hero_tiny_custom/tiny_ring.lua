--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tiny_ring", "heroes/npc_dota_hero_tiny_custom/tiny_ring", LUA_MODIFIER_MOTION_NONE)

tiny_ring = class({})

tiny_ring.modifier_tiny_10 = {50,100}
tiny_ring.modifier_tiny_10_vision  = {400,800}


function tiny_ring:GetIntrinsicModifierName()
    return "modifier_tiny_ring"
end

modifier_tiny_ring = class({})
function modifier_tiny_ring:IsHidden() return true end
function modifier_tiny_ring:IsPurgable() return false end
function modifier_tiny_ring:IsPurgeException() return false end
function modifier_tiny_ring:RemoveOnDeath() return false end

function modifier_tiny_ring:OnCreated()
    if not IsServer() then return end
    self.damage_think = 0
    self:StartIntervalThink(FrameTime())
end

function modifier_tiny_ring:OnIntervalThink()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_tiny_10") then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), self:GetAbility().modifier_tiny_10_vision[self:GetCaster():GetTalentLevel("modifier_tiny_10")], FrameTime(), false)
    end
    self.damage_think = self.damage_think + FrameTime()
    if self.damage_think >= 0.5 then
        self.damage_think = 0
        local damage_agility = self:GetCaster():GetAgility() / 100 * self:GetAbility():GetSpecialValueFor("damage_agility")
        local radius = self:GetAbility():GetSpecialValueFor("radius")
        if self:GetCaster():HasModifier("modifier_tiny_10") then
            radius = radius + self:GetAbility().modifier_tiny_10[self:GetCaster():GetTalentLevel("modifier_tiny_10")]
        end
        if self:GetParent():IsAlive() then 
            local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
            for _,enemy in pairs(enemies) do
                local damageTable = { victim = enemy, attacker = self:GetParent(), damage = damage_agility * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_NONE }
                ApplyDamage(damageTable)
            end
            local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_sandking/sandking_epicenter_tiny.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
            ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetAbsOrigin())
            ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius,1,1))
            ParticleManager:ReleaseParticleIndex( effect_cast )
        end
    end
end

function modifier_tiny_ring:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MODEL_SCALE
    }
end

function modifier_tiny_ring:CheckState()
    return
    {
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_tiny_ring:GetModifierModelScale() 
    return self:GetAbility():GetSpecialValueFor("model_scale") 
end