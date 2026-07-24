--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boar_debuf", "abilities/npc_boar_spit", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boar_cd", "abilities/npc_boar_spit", LUA_MODIFIER_MOTION_NONE)

npc_boar_spit = class({})

function npc_boar_spit:OnAbilityPhaseStart()
    self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 0.6)
       return true
end 


function npc_boar_spit:OnSpellStart()
if not IsServer() then return end
    ParticleManager:DestroyParticle(self.sign, true)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_boar_cd", {duration = self:GetCooldownTimeRemaining()})
    local speed = self:GetSpecialValueFor("speed")
    local radius = self:GetSpecialValueFor("radius")
    local distance = self:GetSpecialValueFor("distance")
    local point = self:GetCursorPosition()
    local direction = point - self:GetCaster():GetAbsOrigin()
    self:GetCaster():EmitSound("Hero_Bristleback.ViscousGoo.Cast")
    direction.z = 0.0
    direction = direction:Normalized()
    local info = {
            EffectName = "particles/creatures/quill_beast/test_model_cluster_linear_projectile.vpcf",
            Ability = self,
            vSpawnOrigin = self:GetCaster():GetOrigin(), 
            fStartRadius = radius,
            fEndRadius = radius,
            vVelocity = direction * speed,
            fDistance = distance,
            Source = self:GetCaster(),
            bDeleteOnHit = true,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
        }


    ProjectileManager:CreateLinearProjectile(info)

end

function npc_boar_spit:OnAbilityPhaseInterrupted()
    ParticleManager:DestroyParticle(self.sign, true)
    self:GetCaster():RemoveGesture(ACT_DOTA_ATTACK)
end

function npc_boar_spit:OnProjectileHit(hTarget, vLocation)
    if not IsServer() then return end
    if hTarget and not hTarget:IsMagicImmune() then
    self:GetCaster():EmitSound("Hero_Bristleback.ViscousGoo.Target")
        local duration = self:GetSpecialValueFor("duration")
        local damage = self:GetSpecialValueFor("damage")
        hTarget:AddNewModifier(self:GetCaster(), self,"modifier_stunned", {duration = duration*(1 - hTarget:GetStatusResistance())})
         DoDamage({ victim = hTarget, attacker = self:GetCaster(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
    end
    return true
end



modifier_boar_cd = class({})

function modifier_boar_cd:IsHidden() return false end
function modifier_boar_cd:IsPurgable() return false end