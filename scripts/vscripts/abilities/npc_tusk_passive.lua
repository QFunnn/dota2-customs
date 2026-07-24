--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tusk_passive", "abilities/npc_tusk_passive.lua", LUA_MODIFIER_MOTION_NONE)

npc_tusk_passive = class({})


function npc_tusk_passive:GetIntrinsicModifierName() return "modifier_tusk_passive" end
 
modifier_tusk_passive = class ({})

function modifier_tusk_passive:IsHidden() return true end



function modifier_tusk_passive:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_phased", {})
end

function modifier_tusk_passive:DeathEvent( param )
    if not IsServer() then end 
      
    if param.unit == self:GetParent() then

         local new_ghost = CreateUnitByName("npc_tusk_ghost", self:GetParent():GetAbsOrigin(), true, nil, nil, DOTA_TEAM_CUSTOM_5)
         new_ghost:AddNewModifier(self:GetParent(), self, "modifier_invulnerable", {})
    end
end

