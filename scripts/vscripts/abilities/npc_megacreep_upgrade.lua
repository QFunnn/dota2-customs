--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_megacreep_passive", "abilities/npc_megacreep_upgrade.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_megacreep_buf", "abilities/npc_megacreep_upgrade.lua", LUA_MODIFIER_MOTION_NONE)

npc_megacreep_upgrade = class({})


function npc_megacreep_upgrade:GetIntrinsicModifierName() return "modifier_megacreep_passive" end
 
modifier_megacreep_passive = class ({})

function modifier_megacreep_passive:IsHidden() return true end
function modifier_megacreep_passive:IsPurgable() return false end



function modifier_megacreep_passive:OnCreated()
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
end


function modifier_megacreep_passive:DeathEvent( param )
    if not IsServer() then end 
      
    if param.unit == self:GetParent() then
        
    self:GetParent():EmitSound("Hero_Omniknight.Purification")
        local u = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, 0, 0, false)  
        local i = 0 
        for i = 1,#u do 
            if u[i] ~= nil and u[i]:GetHealth() > 1 then
                u[i]:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_megacreep_buf", {})
   
          end
        end


    end
end


modifier_megacreep_buf = class({})

function modifier_megacreep_buf:IsPurgable() return false end

function modifier_megacreep_buf:GetTexture() return "omniknight_purification" end


function modifier_megacreep_buf:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE,
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_PROPERTY_TOOLTIP2
    }
end

function modifier_megacreep_buf:OnTooltip()
    return  self:GetAbility():GetSpecialValueFor("damage")*self:GetStackCount() end
function modifier_megacreep_buf:OnTooltip2()
    return  self:GetAbility():GetSpecialValueFor("health")*self:GetStackCount() end


function modifier_megacreep_buf:OnCreated(table)
if not self:GetAbility() then return end
    self:SetStackCount(1)

    local effect_target = ParticleManager:CreateParticle( "particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_ti6_immortal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_target, 1, Vector( 100, 100, 100 ) )
    ParticleManager:ReleaseParticleIndex( effect_target )

    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.health = self:GetAbility():GetSpecialValueFor("health")
    if not IsServer() then return  end
    local h = self:GetParent():GetMaxHealth()*(self.health/100 + 1)
    self:GetParent():SetBaseMaxHealth(h)


    h = self:GetParent():GetBaseDamageMax()*(self.damage/100 + 1)
    self:GetParent():SetBaseDamageMin(h)
    self:GetParent():SetBaseDamageMax(h)

end


function modifier_megacreep_buf:GetModifierModelScale() return 20*self:GetStackCount() end

function modifier_megacreep_buf:OnRefresh(table)

      if not IsServer() then return  end
    
    self:SetStackCount(self:GetStackCount()+1)

    local effect_target = ParticleManager:CreateParticle( "particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_ti6_immortal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_target, 1, Vector( 100, 100, 100 ) )
    ParticleManager:ReleaseParticleIndex( effect_target )

    local h = self:GetParent():GetMaxHealth()*(self.health/100 + 1)
    self:GetParent():SetBaseMaxHealth(h)
 
    h = self:GetParent():GetBaseDamageMax()*(self.damage/100 + 1)
    self:GetParent():SetBaseDamageMin(h)
    self:GetParent():SetBaseDamageMax(h)

end