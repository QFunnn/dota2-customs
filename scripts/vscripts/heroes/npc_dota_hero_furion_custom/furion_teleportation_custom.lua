--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_furion_teleportation_custom",  "heroes/npc_dota_hero_furion_custom/furion_teleportation_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_furion_teleportation_custom_shield",  "heroes/npc_dota_hero_furion_custom/furion_teleportation_custom", LUA_MODIFIER_MOTION_NONE )

furion_teleportation_custom = class({})

furion_teleportation_custom.modifier_furion_12 = {100,200}
furion_teleportation_custom.modifier_furion_12_duration = 6
furion_teleportation_custom.modifier_furion_13 = {0.5,1.5,2.5}
furion_teleportation_custom.modifier_furion_13_max_range = 1800
furion_teleportation_custom.modifier_furion_13_cooldown = {-2,-4,-6}
furion_teleportation_custom.modifier_furion_8 = {60,100}

function furion_teleportation_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_teleport_end.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_teleport_end_team.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_teleport.vpcf", context )
end

function furion_teleportation_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_furion_13") then
        bonus = self.modifier_furion_13_cooldown[self:GetCaster():GetTalentLevel("modifier_furion_13")]
    end
    return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function furion_teleportation_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        if self:GetCaster():HasModifier("modifier_furion_13") then
            return self.modifier_furion_13_max_range
        end
    end
end

function furion_teleportation_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_furion_13") then
        return self.BaseClass.GetCastPoint( self ) - self.modifier_furion_13[self:GetCaster():GetTalentLevel("modifier_furion_13")]
    end
    return self.BaseClass.GetCastPoint( self )
end

function furion_teleportation_custom:OnAbilityPhaseStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
    if self:GetCaster():HasModifier("modifier_furion_13") then
		local direction = point - self:GetCaster():GetAbsOrigin()
        local distance = direction:Length2D()
        direction.z = 0
        direction = direction:Normalized()
        if distance >= self.modifier_furion_13_max_range then
        	point = GetGroundPosition(self:GetCaster():GetAbsOrigin() + direction * self.modifier_furion_13_max_range, self:GetCaster())
        end
	end

	self.point = point

	local particle_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_furion/furion_teleport_end.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControl(particle_fx, 1, point)
    ParticleManager:SetParticleControl( particle_fx, 2, Vector ( 1, 0, 0 ) )
    self.particle_fx = particle_fx

    self.nFXIndexEndTeam = ParticleManager:CreateParticleForTeam( "particles/units/heroes/hero_furion/furion_teleport_end_team.vpcf", PATTACH_CUSTOMORIGIN, nil, self:GetCaster():GetTeamNumber() )
	ParticleManager:SetParticleControl( self.nFXIndexEndTeam, 1, point )
	ParticleManager:SetParticleControl( self.nFXIndexEndTeam, 2, Vector ( 1, 0, 0 ) )

	self.nFXIndexStart = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_teleport.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( self.nFXIndexStart, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( self.nFXIndexStart, 2, Vector( 1, 0, 0 ) )

    self:GetCaster():EmitSound("Hero_Furion.Teleport_Grow")
    EmitSoundOnLocationWithCaster(self.point, "Hero_Furion.Teleport_Grow", self:GetCaster())
	return true
end

function furion_teleportation_custom:OnAbilityPhaseInterrupted()
	if not IsServer() then return end
	if self.particle_fx then
		ParticleManager:DestroyParticle( self.particle_fx, true )
	end
	if self.nFXIndexEndTeam then
		ParticleManager:DestroyParticle( self.nFXIndexEndTeam, true )
	end
	if self.nFXIndexStart then
		ParticleManager:DestroyParticle( self.nFXIndexStart, true )
	end
	self:GetCaster():StopSound("Hero_Furion.Teleport_Grow")
	StopSoundEvent("Hero_Furion.Teleport_Grow", self:GetCaster())
	StopGlobalSound("Hero_Furion.Teleport_Grow")
end

function furion_teleportation_custom:OnSpellStart()
	if not IsServer() then return end

	ProjectileManager:ProjectileDodge( self:GetCaster() )
	FindClearSpaceForUnit( self:GetCaster(), self.point, true )
	self:GetCaster():StartGesture( ACT_DOTA_TELEPORT_END )

	if self.particle_fx then
		ParticleManager:DestroyParticle( self.particle_fx, false )
	end

	if self.nFXIndexStart then
		ParticleManager:DestroyParticle( self.nFXIndexStart, false )
	end

	if self.nFXIndexEndTeam then
		ParticleManager:DestroyParticle( self.nFXIndexEndTeam, false )
	end

	if self:GetCaster():HasModifier("modifier_furion_12") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_furion_teleportation_custom", {duration = self.modifier_furion_12_duration})
	end

	local buff = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_furion_teleportation_custom_shield", {duration = self:GetSpecialValueFor("buff_duration")})

	self:GetCaster():StopSound("Hero_Furion.Teleport_Grow")
	StopSoundEvent("Hero_Furion.Teleport_Grow", self:GetCaster())
	self:GetCaster():EmitSound("Hero_Furion.Teleport_Appear")
end

modifier_furion_teleportation_custom = class({})

function modifier_furion_teleportation_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_furion_teleportation_custom:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility().modifier_furion_12[self:GetCaster():GetTalentLevel("modifier_furion_12")]
end

function modifier_furion_teleportation_custom:GetEffectName()
	return "particles/items3_fx/blink_swift_buff.vpcf"
end

function modifier_furion_teleportation_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_furion_teleportation_custom_shield = class({})

function modifier_furion_teleportation_custom_shield:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	if not IsServer() then return end
    self.barrier = self:GetAbility():GetSpecialValueFor( "barrier" )
    if self:GetCaster():HasModifier("modifier_furion_8") then
        self.barrier = self.barrier + (self:GetCaster():GetDisplayAttackSpeed() / 100 * self:GetAbility().modifier_furion_8[self:GetCaster():GetTalentLevel("modifier_furion_8")])
    end
	self.max_shield = self.barrier
	self.current_shield = self.barrier
	self:SetHasCustomTransmitterData( true )
end

function modifier_furion_teleportation_custom_shield:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_furion_teleportation_custom_shield:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_furion_teleportation_custom_shield:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_furion_teleportation_custom_shield:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
		self:Destroy()
		return -self.current_shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end
