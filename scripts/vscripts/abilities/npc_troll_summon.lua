--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier("modifier_troll_cd", "abilities/npc_troll_summon", LUA_MODIFIER_MOTION_NONE)

npc_troll_summon = class({})

function npc_troll_summon:OnAbilityPhaseStart()
    self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.75)
       return true
end 


function npc_troll_summon:OnSpellStart()
if not IsServer() then return end
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_troll_cd", {duration = self:GetCooldownTimeRemaining()})
self:GetCaster():EmitSound("n_creep_TrollWarlord.RaiseDead")
ParticleManager:DestroyParticle(self.sign, true)
local total = self:GetSpecialValueFor("total")
for i = 1,total do
     local new_skelet = CreateUnitByName("npc_troll_skelet", self:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_CUSTOM_5)
     new_skelet:SetOwner(self:GetCaster())
     new_skelet.mkb = self:GetCaster().mkb
     new_skelet.summoned = true
     new_skelet.host_team = self:GetCaster().host_team
     new_skelet:AddNewModifier(new_skelet, nil, "modifier_waveupgrade", {})
     new_skelet:SetPhysicalArmorBaseValue(2)
end
end

function npc_troll_summon:OnAbilityPhaseInterrupted()
    ParticleManager:DestroyParticle(self.sign, true)
    self:GetCaster():RemoveGesture(ACT_DOTA_CAST_ABILITY_2)
end

modifier_troll_cd = class({})
function modifier_troll_cd:IsHidden() return false end
function modifier_troll_cd:IsPurgable() return false end
