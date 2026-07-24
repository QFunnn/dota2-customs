--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_ice_debuff", "heroes/npc_dota_hero_phoenix_custom/phoenix_ice_debuff", 0)

phoenix_ice_debuff = class({})
phoenix_ice_debuff.stun_duration = {1.6, 2, 2.4}

function phoenix_ice_debuff:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_frozen.vpcf", context )
end

function phoenix_ice_debuff:AddStack(target, count)
    if not self:GetCaster():HasModifier("modifier_phoenix_20") then return end
    if not self:IsTrained() then
        self:SetLevel(1)
    end
    local modifier_phoenix_ice_debuff = target:AddNewModifier(self:GetCaster(), self, "modifier_phoenix_ice_debuff", {duration = 5})
    if modifier_phoenix_ice_debuff then
        modifier_phoenix_ice_debuff:AddStackCounter(count)
    end
end

modifier_phoenix_ice_debuff = class({})

function modifier_phoenix_ice_debuff:AddStackCounter(count)
    if not IsServer() then return end
    self:SetStackCount(self:GetStackCount() + count)
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
    end
    if self:GetStackCount() >= 9 then
        local modifier_stunned = self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = self:GetAbility().stun_duration[self:GetCaster():GetTalentLevel("modifier_phoenix_20")] * (1-self:GetParent():GetStatusResistance())})
        if modifier_stunned then
            local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_frozen.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
            modifier_stunned:AddParticle(pfx, false, false, -1, false, false)
        end
        self:Destroy()
    end
end

function modifier_phoenix_ice_debuff:OnCreated()
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    self:AddParticle(self.particle, false, false, -1, false, false)
end