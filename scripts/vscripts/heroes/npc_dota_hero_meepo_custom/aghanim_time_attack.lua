--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_aghanim_time_attack_debuff", "heroes/npc_dota_hero_meepo_custom/aghanim_time_attack", LUA_MODIFIER_MOTION_NONE )

aghanim_time_attack = class({})

function aghanim_time_attack:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local strike_radius = 150
    local strike_cast_range = self:GetSpecialValueFor("range")
    local vStartPosition = self:GetCaster():GetAbsOrigin()
    local point = self:GetCursorPosition()
    local dir = point - self:GetCaster():GetAbsOrigin()
    dir.z = 0
    dir = dir:Normalized()

    local vTargetPosition = self:GetCaster():GetAbsOrigin() + dir * strike_cast_range
    
    local vDirection = vTargetPosition - vStartPosition
    vDirection.z = 0
    vStartPosition = GetGroundPosition(vStartPosition+vDirection:Normalized()*(strike_radius/2), caster)
    vTargetPosition = GetGroundPosition(vStartPosition+vDirection:Normalized()*(strike_cast_range-strike_radius/2), caster)
    
    EmitSoundOnLocationWithCaster(vStartPosition, "Hero_MonkeyKing.Strike.Impact", caster)
    EmitSoundOnLocationWithCaster(vTargetPosition, "Hero_MonkeyKing.Strike.Impact.EndPos", caster)
    
    local particleID = ParticleManager:CreateParticle("particles/aghs_attack_effect.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particleID, 0, vStartPosition)
    ParticleManager:SetParticleControlForward(particleID, 0, vDirection:Normalized())
    ParticleManager:SetParticleControl(particleID, 1, vTargetPosition)
    ParticleManager:ReleaseParticleIndex(particleID)

    local enemies = FindUnitsInLine(self:GetCaster():GetTeamNumber(), vStartPosition , vTargetPosition, nil, strike_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE)
    
    for _,enemy in pairs(enemies) do
        for i=1, self:GetSpecialValueFor("attacks") do
            self:GetCaster():PerformAttack(enemy, true, true, true, false, false, false, true)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(particle, 0, enemy:GetAbsOrigin() )
			ParticleManager:SetParticleControl(particle, 1, enemy:GetAbsOrigin() )
			ParticleManager:SetParticleControlEnt(particle, 2, self:GetCaster(), PATTACH_CUSTOMORIGIN, "attach_hitloc", enemy:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle)
        end
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_aghanim_time_attack_debuff", {duration = self:GetSpecialValueFor("slow_duration")})
    end
end

modifier_aghanim_time_attack_debuff = class({})

function modifier_aghanim_time_attack_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end
function modifier_aghanim_time_attack_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("slow_movespeed")
end
function modifier_aghanim_time_attack_debuff:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("slow_attackspeed")
end