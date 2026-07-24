--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_ability_teleport", "abilities/ui/teleport", LUA_MODIFIER_MOTION_NONE)

custom_ability_teleport = class({})

function custom_ability_teleport:GetChannelTime() return 5 end

function custom_ability_teleport:Spawn()
	if not IsServer() then return end
	if self and not self:IsTrained() then
		self:SetLevel(1)
	end
end

function custom_ability_teleport:IsHiddenAbilityCastable()
    return true
end

function custom_ability_teleport:OnSpellStart()
	if not IsServer() then return end
	local hero = self:GetCaster()
	self.point = towers[hero:GetTeamNumber()]:GetAbsOrigin() + RandomVector(220)
	self.point = GetGroundPosition(self.point, nil)
	self.point_start = self:GetCaster():GetAbsOrigin()
	hero:StartGesture(ACT_DOTA_TELEPORT)

    local player_id = hero:GetPlayerOwnerID()
    local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_teleportation")
    local default_effect_start = "particles/items2_fx/teleport_start.vpcf"
    local default_effect_end = "particles/items2_fx/teleport_end.vpcf"
    if custom_effect_data then
        default_effect_start = custom_effect_data[1]
        default_effect_end = custom_effect_data[2]
    end
    
	hero:AddNewModifier(self:GetCaster(), self, "modifier_custom_ability_teleport", {duration = self:GetChannelTime()})
 	self.teleportFromEffect = ParticleManager:CreateParticle(default_effect_start, PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(self.teleportFromEffect, 2, Vector(255, 255, 255))
    self.teleport_center = CreateUnitByName("npc_dota_companion", self.point, false, nil, nil, 0)

    self:GetCaster():EmitSound("Portal.Loop_Appear")
    EmitSoundOn("Portal.Loop_Appear", self.teleport_center)

    self.teleport_center:AddNewModifier(self.teleport_center, nil, "modifier_phased", {})
    self.teleport_center:AddNewModifier(self.teleport_center, nil, "modifier_invulnerable", {})
    self.teleport_center:SetAbsOrigin(self.point)

    self.teleportToEffect = ParticleManager:CreateParticle(default_effect_end, PATTACH_ABSORIGIN_FOLLOW, self.teleport_center)
    ParticleManager:SetParticleControlEnt(self.teleportToEffect, 1, self.teleport_center, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.teleport_center:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(self.teleportToEffect, 3, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.teleport_center:GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(self.teleportToEffect, 4, Vector(0.9, 0, 0))
    ParticleManager:SetParticleControlEnt(self.teleportToEffect, 5, self.teleport_center, PATTACH_POINT_FOLLOW, "attach_hitloc", self.teleport_center:GetAbsOrigin(), true)
end

function custom_ability_teleport:OnChannelThink(fInterval)
    if self:GetCaster():IsRooted() or self:GetCaster():HasModifier("modifier_custom_puck_dream_coil") then
        self:GetCaster():Stop()
        self:GetCaster():Interrupt()
    end
end



function custom_ability_teleport:OnChannelFinish(bInterrupted)
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_custom_ability_teleport")
	
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
end

modifier_custom_ability_teleport = class({})

function modifier_custom_ability_teleport:IsHidden() return false end
function modifier_custom_ability_teleport:IsPurgable() return false end

function modifier_custom_ability_teleport:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }

    return decFuncs
end

function modifier_custom_ability_teleport:GetOverrideAnimation()
	return ACT_DOTA_TELEPORT
end
