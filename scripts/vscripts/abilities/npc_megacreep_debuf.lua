--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_megacreep_bad_passive", "abilities/npc_megacreep_debuf.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_megacreep_bad_debuf", "abilities/npc_megacreep_debuf.lua", LUA_MODIFIER_MOTION_NONE)

npc_megacreep_debuf = class({})


function npc_megacreep_debuf:GetIntrinsicModifierName() return "modifier_megacreep_bad_passive" end
 
modifier_megacreep_bad_passive = class ({})

function modifier_megacreep_bad_passive:IsHidden() return true end


function modifier_megacreep_bad_passive:OnCreated()
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
end

function modifier_megacreep_bad_passive:DeathEvent( param )
    if not IsServer() then end 
      
    if param.unit == self:GetParent() and not param.attacker:IsBuilding() and param.attacker:IsAlive() then
        local duration = self:GetAbility():GetSpecialValueFor("duration")
        param.attacker:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_megacreep_bad_debuf", {duration = duration})

    end
end


modifier_megacreep_bad_debuf = class({})

function modifier_megacreep_bad_debuf:IsPurgable() return false end


function modifier_megacreep_bad_debuf:GetTexture() return "doom_bringer_doom" end

function modifier_megacreep_bad_debuf:OnCreated(table)
        if not IsServer() then return end
    self:SetStackCount(1)


    local effect_target = ParticleManager:CreateParticle( "particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_target, 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_target )
    self:GetParent():EmitSound("Hero_DoomBringer.InfernalBlade.PreAttack")
    local interval = self:GetAbility():GetSpecialValueFor("interval")
    self:StartIntervalThink(interval)
end

function modifier_megacreep_bad_debuf:OnIntervalThink()

    if not IsServer() then return end


    local effect_target = ParticleManager:CreateParticle( "particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_target, 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_target )
    self:GetParent():EmitSound("Hero_DoomBringer.InfernalBlade.Target")
    local tik = 0
    local total = self:GetAbility():GetSpecialValueFor("damage")
    local duration = self:GetAbility():GetSpecialValueFor("duration")
    local interval = self:GetAbility():GetSpecialValueFor("interval")
    tik = self:GetParent():GetMaxHealth()*((total / (duration / interval) ) /100) * self:GetStackCount()
    DoDamage({ victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = tik, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION})
    SendOverheadEventMessage(self:GetParent(), 9, self:GetParent(), tik, nil)

end



function modifier_megacreep_bad_debuf:OnRefresh(table)
      if not IsServer() then return  end
    self:GetParent():EmitSound("Hero_DoomBringer.InfernalBlade.PreAttack")
    self:SetStackCount(self:GetStackCount()+1)
end

function modifier_megacreep_bad_debuf:DeclareFunctions()
    return
{
    MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_megacreep_bad_debuf:OnTooltip()
    return self:GetStackCount()*self:GetAbility():GetSpecialValueFor("damage") / self:GetAbility():GetSpecialValueFor("duration") / self:GetAbility():GetSpecialValueFor("interval")


end