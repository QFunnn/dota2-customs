--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_templar_assassin_innate_custom", "abilities/templar_assasssin/templar_assassin_innate_custom", LUA_MODIFIER_MOTION_NONE )


templar_assassin_innate_custom = class({})

function templar_assassin_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

end

function templar_assassin_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_templar_assassin_innate_custom"
end

function templar_assassin_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_templar_assassin.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_templar_assassin", context)
end



modifier_templar_assassin_innate_custom = class({})
function modifier_templar_assassin_innate_custom:IsHidden() return true end
function modifier_templar_assassin_innate_custom:IsPurgable() return false end
function modifier_templar_assassin_innate_custom:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bonus = 1 + self.ability:GetSpecialValueFor("bonus")/100
self.smoke = self.ability:GetSpecialValueFor("duration")

if not IsServer() then return end

self.team = self.parent:GetTeamNumber()
self.radius = self.ability:GetSpecialValueFor("radius")
self.duration = 30

self:OnIntervalThink()
self:StartIntervalThink(self.duration)
end


function modifier_templar_assassin_innate_custom:OnIntervalThink()
if not IsServer() then return end

for i = 1,#bounty_abs do 
	AddFOWViewer(self.parent:GetTeamNumber(), bounty_abs[i], self.radius, self.duration + 1, true)
end

end



function modifier_templar_assassin_innate_custom:UseSmoke()
if not IsServer() then return end

local smoke = self.parent:FindAbilityByName("custom_ability_smoke")

if smoke then 

    self.parent:EmitSound("DOTA_Item.SmokeOfDeceit.Activate")
    local particle = ParticleManager:CreateParticle("particles/items2_fx/smoke_of_deceit.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(500, 1, 500))
    ParticleManager:ReleaseParticleIndex(particle)
    self.parent:AddNewModifier(self.parent, smoke, "modifier_smoke_of_deceit", 
    {
        duration = self.smoke,
        application_radius = smoke:GetSpecialValueFor("application_radius"),
        visibility_radius = smoke:GetSpecialValueFor("visibility_radius"),
        bonus_movement_speed = smoke:GetSpecialValueFor("bonus_movement_speed"),
        secondary_application_radius = smoke:GetSpecialValueFor("secondary_application_radius"),
        second_cast_cooldown = smoke:GetSpecialValueFor("second_cast_cooldown"),
    })

end

end