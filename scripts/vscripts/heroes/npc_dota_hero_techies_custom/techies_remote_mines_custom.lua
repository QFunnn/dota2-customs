--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


techies_remote_mines_custom = class({})
techies_remote_mines_custom.modifier_techies_10 = {-5,-10}
techies_remote_mines_custom.modifier_techies_11 = {200,350,500}

function techies_remote_mines_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_remote_mine.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_remote_mine_plant.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context)
    PrecacheResource("model", "models/heroes/techies/fx_techies_remotebomb.vmdl", context)
end

function techies_remote_mines_custom:GetCastRange(location, target)
    return self.BaseClass.GetCastRange(self, location, target)
end

function techies_remote_mines_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function techies_remote_mines_custom:OnAbilityPhaseStart()
    local point = self:GetCursorPosition()
    self:GetCaster():EmitSound("Hero_Techies.RemoteMine.Toss")
    self.particle_plant_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_remote_mine_plant.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(self.particle_plant_fx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_remote", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(self.particle_plant_fx, 1, point)
    ParticleManager:SetParticleControl(self.particle_plant_fx, 4, point)
    return true
end

function techies_remote_mines_custom:OnAbilityPhaseInterrupted()
    if self.particle_plant_fx then
        ParticleManager:DestroyParticle(self.particle_plant_fx, true)
        ParticleManager:ReleaseParticleIndex(self.particle_plant_fx)
    end
end

function techies_remote_mines_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    self:CreateMine(point)
end

function techies_remote_mines_custom:CreateMine(point)
    if not IsServer() then return end
    self:GetCaster():EmitSound("Hero_Techies.StickyBomb.Plant")
    local mine = CreateUnitByName("npc_dota_techies_remote_mine", point, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
    mine:SetOriginalModel("models/heroes/techies/fx_techies_remotebomb.vmdl")
    mine:SetModel("models/heroes/techies/fx_techies_remotebomb.vmdl")
    local max_health = self:GetSpecialValueFor("max_health")
    mine:SetBaseMaxHealth(max_health * 2)
    mine:SetMaxHealth(max_health * 2)
    mine:SetHealth(max_health * 2)
    local duration = self:GetSpecialValueFor("duration")
    mine:AddNewModifier(self:GetCaster(), self, "modifier_techies_remote_mines_custom", {duration = duration+1})
    mine:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
    local techies_remote_mines_self_detonate_custom = mine:FindAbilityByName("techies_remote_mines_self_detonate_custom")
    if techies_remote_mines_self_detonate_custom then
        techies_remote_mines_self_detonate_custom:SetLevel(1)
    end
    return mine
end