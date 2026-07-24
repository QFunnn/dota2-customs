--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_techies_death_passive", "abilities/npc_techies_death.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_death_debuf", "abilities/npc_techies_death.lua", LUA_MODIFIER_MOTION_NONE)

npc_techies_death = class({})


function npc_techies_death:GetIntrinsicModifierName() return "modifier_techies_death_passive" end
 
modifier_techies_death_passive = class ({})

function modifier_techies_death_passive:IsHidden() return true end



function modifier_techies_death_passive:OnCreated(table)
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
end

function modifier_techies_death_passive:DeathEvent( param )
    if not IsServer() then end 

   
    if param.unit == self:GetParent()  then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.damage = self:GetAbility():GetSpecialValueFor("damage")
        self.parent = self:GetParent()
        self.parent:EmitSound("Hero_Techies.Suicide")
        local particle_explosion = "particles/units/heroes/hero_techies/techies_blast_off.vpcf"
        local particle_explosion_fx = ParticleManager:CreateParticle(particle_explosion, PATTACH_WORLDORIGIN, self.parent)
        ParticleManager:SetParticleControl(particle_explosion_fx, 0, self.parent:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle_explosion_fx)

        local enemy_for_ability = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0 , FIND_CLOSEST, false)
  
         if #enemy_for_ability > 0 then 
         for _,i in pairs(enemy_for_ability) do 
            if i:GetTeam() ~= DOTA_TEAM_NEUTRALS and not i:IsBuilding() and not i:IsMagicImmune() then 
       
               i:AddNewModifier(self:GetAbility():GetCaster(), self:GetAbility(), "modifier_techies_death_debuf", {duration = self.duration*(1 - i:GetStatusResistance())})
               DoDamage({ victim = i, attacker = self:GetAbility():GetCaster(), ability = self:GetAbility(), damage = self.damage, damage_type = DAMAGE_TYPE_PURE})
            end
        end
    end
    end
end


modifier_techies_death_debuf = class({})

function modifier_techies_death_debuf:IsPurgable() return true end

function modifier_techies_death_debuf:IsHidden() return false end

function modifier_techies_death_debuf:CheckState() return {[MODIFIER_STATE_DISARMED] = true} end

function modifier_techies_death_debuf:GetEffectName() return "particles/generic_gameplay/generic_disarm.vpcf" end
 
function modifier_techies_death_debuf:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end