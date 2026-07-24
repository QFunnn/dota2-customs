--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_patrol_warp_amulet", "abilities/items/item_patrol_warp_amulet", LUA_MODIFIER_MOTION_NONE)


item_patrol_warp_amulet              = class({})

function item_patrol_warp_amulet:GetChannelTime() 
	return self:GetSpecialValueFor("duration") 
end


function item_patrol_warp_amulet:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/econ/events/ti10/teleport/teleport_start_ti10_lvl1_rewardline.vpcf", context )
PrecacheResource( "particle","particles/econ/events/ti5/teleport_end_lvl2_ti5.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/smoke_of_deceit.vpcf", context )
end


function item_patrol_warp_amulet:OnAbilityPhaseStart()

return self:GetCaster():CanTeleport()  
end






function item_patrol_warp_amulet:OnSpellStart()
if not IsServer() then return end
local hero = self:GetCaster()

self.point = self:GetCursorPosition()
self.point = GetGroundPosition(self.point, nil)
self.point_start = self:GetCaster():GetAbsOrigin()


hero:StartGesture(ACT_DOTA_TELEPORT)



self.teleportFromEffect = ParticleManager:CreateParticle("particles/econ/events/ti10/teleport/teleport_start_ti10_lvl1_rewardline.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
ParticleManager:SetParticleControl(self.teleportFromEffect, 2, Vector(255, 255, 255))
self.teleport_center = CreateUnitByName("npc_dota_companion", self.point, false, nil, nil, 0)


hero:AddNewModifier(self:GetCaster(), self, "modifier_patrol_warp_amulet", {duration = self:GetChannelTime(), unit = self.teleport_center:entindex()})

self:GetCaster():EmitSound("Portal.Loop_Appear")
EmitSoundOn("Portal.Loop_Appear", self.teleport_center)

self.teleport_center:AddNewModifier(self.teleport_center, nil, "modifier_phased", {})
self.teleport_center:AddNewModifier(self.teleport_center, nil, "modifier_invulnerable", {})
self.teleport_center:SetAbsOrigin(self.point)

self.teleportToEffect = ParticleManager:CreateParticle("particles/econ/events/ti5/teleport_end_lvl2_ti5.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.teleport_center)
ParticleManager:SetParticleControlEnt(self.teleportToEffect, 1, self.teleport_center, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.teleport_center:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.teleportToEffect, 3, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.teleport_center:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(self.teleportToEffect, 4, Vector(0.9, 0, 0))
ParticleManager:SetParticleControlEnt(self.teleportToEffect, 5, self.teleport_center, PATTACH_POINT_FOLLOW, "attach_hitloc", self.teleport_center:GetAbsOrigin(), true)
end

function item_patrol_warp_amulet:OnChannelThink(fInterval)
    if self:GetCaster():IsRooted() or self:GetCaster():HasModifier("modifier_custom_puck_dream_coil") or
    self:GetCaster():HasModifier("modifier_custom_puck_phase_shift") then
        self:GetCaster():Stop()
        self:GetCaster():Interrupt()
    end
end


function item_patrol_warp_amulet:OnChannelThink(flInterval)

AddFOWViewer(self:GetCaster():GetTeamNumber(), self.point, 700, flInterval, false)

end



function item_patrol_warp_amulet:OnChannelFinish(bInterrupted)
if not IsServer() then return end
self:GetCaster():RemoveModifierByName("modifier_patrol_warp_amulet")
	
local hero = self:GetCaster()


StopSoundOn("Portal.Loop_Appear", self.teleport_center)
self:GetCaster():StopSound("Portal.Loop_Appear")



self.teleport_center:Destroy()
self:GetCaster():RemoveGesture(ACT_DOTA_TELEPORT)

if bInterrupted then 

	ParticleManager:DestroyParticle(self.teleportFromEffect, true)
    ParticleManager:ReleaseParticleIndex(self.teleportFromEffect)
    ParticleManager:DestroyParticle(self.teleportToEffect, true)
   	ParticleManager:ReleaseParticleIndex(self.teleportToEffect)

    return 
end   

ParticleManager:DestroyParticle(self.teleportFromEffect, false)
ParticleManager:ReleaseParticleIndex(self.teleportFromEffect)
ParticleManager:DestroyParticle(self.teleportToEffect, false)
ParticleManager:ReleaseParticleIndex(self.teleportToEffect)

EmitSoundOnLocationWithCaster(self.point_start, "Portal.Hero_Disappear", self:GetCaster())

self:GetCaster():SetAbsOrigin(self.point)
FindClearSpaceForUnit(self:GetCaster(), self.point, true)
self:GetCaster():Stop()
self:GetCaster():Interrupt()
EmitSoundOn("Portal.Hero_Disappear", self:GetCaster())
self:GetCaster():StartGesture(ACT_DOTA_TELEPORT_END)

local smoke = self:GetCaster():FindAbilityByName("custom_ability_smoke")

if smoke then 

    self:GetCaster():EmitSound("DOTA_Item.SmokeOfDeceit.Activate")
    local particle = ParticleManager:CreateParticle("particles/items2_fx/smoke_of_deceit.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(800, 1, 800))
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetCaster():AddNewModifier(self:GetCaster(), smoke, "modifier_smoke_of_deceit", 
    {
        duration = smoke:GetSpecialValueFor("duration"),
        application_radius = smoke:GetSpecialValueFor("application_radius"),
        visibility_radius = smoke:GetSpecialValueFor("visibility_radius"),
        bonus_movement_speed = smoke:GetSpecialValueFor("bonus_movement_speed"),
        secondary_application_radius = smoke:GetSpecialValueFor("secondary_application_radius"),
        second_cast_cooldown = smoke:GetSpecialValueFor("second_cast_cooldown"),
    })

end


self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_can_not_push", {duration = self:GetSpecialValueFor("duration_building")})

self:SpendCharge(0)
end







modifier_patrol_warp_amulet = class({})

function modifier_patrol_warp_amulet:IsHidden() return false end
function modifier_patrol_warp_amulet:IsPurgable() return false end
function modifier_patrol_warp_amulet:GetTexture() return "buffs/warp_amulet" end

function modifier_patrol_warp_amulet:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }

    return decFuncs
end

function modifier_patrol_warp_amulet:GetOverrideAnimation()
	return ACT_DOTA_TELEPORT
end


function modifier_patrol_warp_amulet:DamageEvent_inc(params)
if not IsServer() then return end
if self:GetParent() ~= params.unit then return end
if self:GetParent() == params.attacker then return end

self:GetParent():Stop()

end




function modifier_patrol_warp_amulet:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
if self.parent:IsRealHero() then 
    self.parent:AddDamageEvent_inc(self, true)
end 

self.unit = EntIndexToHScript(table.unit)

if self.unit then 
	self.point = self.unit:GetAbsOrigin()
end

self:StartIntervalThink(0.1)
end


function modifier_patrol_warp_amulet:OnIntervalThink()
if not IsServer() then return end

if self.point then 
	AddFOWViewer(self:GetParent():GetTeamNumber(), self.point, 150, 0.1, false)
end

end


