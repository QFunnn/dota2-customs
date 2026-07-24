--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_marci_special_delivery_custom", "heroes/npc_dota_hero_marci_custom/marci_special_delivery_custom", LUA_MODIFIER_MOTION_NONE)

marci_special_delivery_custom = class({})

function marci_special_delivery_custom:OnAbilityPhaseStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("Hero_Marci.SpecialDelivery.Cast")
end

function marci_special_delivery_custom:OnAbilityPhaseInterrupted()
    if not IsServer() then return end
    self:GetCaster():StopSound("Hero_Marci.SpecialDelivery.Cast")
end

function marci_special_delivery_custom:OnSpellStart()
    if not IsServer() then return end
    CreateModifierThinker(self:GetCaster(), self, "modifier_marci_special_delivery_custom", {duration = 15}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
end

modifier_marci_special_delivery_custom = class({})

function modifier_marci_special_delivery_custom:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/experience_border_shrine.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
    if GetMapName() ~= "arena" then
        local trigger = SpawnDOTAShopTriggerRadiusApproximate( self:GetParent():GetOrigin(), self:GetAbility():GetSpecialValueFor("radius"))
        if trigger then
            trigger:SetShopType( DOTA_SHOP_HOME )
            self.trigger = trigger
        end
    end
    self:GetParent():EmitSound("Hero_Marci.SpecialDelivery.Courier")
    self.model = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/props_gameplay/donkey_wings.vmdl", IdleAnim = "ACT_DOTA_IDLE", IdleAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING"})
    self.model:SetAbsOrigin(self:GetParent():GetAbsOrigin() + Vector(0,0,350))
end

function modifier_marci_special_delivery_custom:OnDestroy()
    if not IsServer() then return end
    if self.trigger then
        self.trigger:Destroy()
    end
    if self.model then
        self.model:Destroy()
    end
end