--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_cloud_custom", "abilities/zuus_cloud_custom", LUA_MODIFIER_MOTION_NONE)

zuus_cloud_custom = class({})

function zuus_cloud_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_zeus/zeus_cloud.vpcf", context)
	PrecacheUnitByNameSync("npc_dota_zeus_cloud", context)
end

function zuus_cloud_custom:GetAOERadius()
	return self:GetSpecialValueFor("cloud_radius")
end

function zuus_cloud_custom:OnSpellStart()
	if not IsServer() then return end
	self.target_point 			= self:GetCursorPosition()
	local caster 				= self:GetCaster()
	local cloud_bolt_interval 	= self:GetSpecialValueFor("cloud_bolt_interval")
	local cloud_duration 		= self:GetSpecialValueFor("cloud_duration")
	local cloud_radius 			= self:GetSpecialValueFor("cloud_radius")
	caster:EmitSound("Hero_Zuus.Cloud.Cast")
	self.zuus_nimbus_unit = CreateUnitByName("npc_dota_zeus_cloud", Vector(self.target_point.x, self.target_point.y, 450), false, caster, nil, caster:GetTeam())
	self.zuus_nimbus_unit:SetControllableByPlayer(caster:GetPlayerID(), true)
	self.zuus_nimbus_unit:SetModelScale(0.7)
	self.zuus_nimbus_unit:AddNewModifier(self.zuus_nimbus_unit, self, "modifier_phased", {})
	self.zuus_nimbus_unit:AddNewModifier(caster, self, "modifier_zuus_cloud_custom", {duration = cloud_duration, cloud_bolt_interval = cloud_bolt_interval, cloud_radius = cloud_radius})
	self.zuus_nimbus_unit:AddNewModifier(caster, nil, "modifier_kill", {duration = cloud_duration})
end

modifier_zuus_cloud_custom = class({})

function modifier_zuus_cloud_custom:IsHidden() return true end

function modifier_zuus_cloud_custom:OnCreated(keys)
	if not IsServer() then return end
	self.ability = self
	self.cloud_radius = keys.cloud_radius
	self.cloud_bolt_interval = keys.cloud_bolt_interval
	self.lightning_bolt = self:GetCaster():FindAbilityByName("zuus_lightning_bolt_custom")
	local target_point 	= GetGroundPosition(self:GetParent():GetAbsOrigin(), self:GetParent())
	self.original_z = target_point.z
    self:GetParent():SetBaseMaxHealth(self:GetAbility():GetSpecialValueFor("creep_hits_to_kill_tooltip"))
    self:GetParent():SetMaxHealth(self:GetAbility():GetSpecialValueFor("creep_hits_to_kill_tooltip"))
    self:GetParent():SetHealth(self:GetAbility():GetSpecialValueFor("creep_hits_to_kill_tooltip"))
	self:SetStackCount(self.original_z)
	self.counter = self.cloud_bolt_interval
	self.zuus_nimbus_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 0, Vector(target_point.x, target_point.y, 450))
	ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 1, Vector(self.cloud_radius, 0, 0))
	ParticleManager:SetParticleControl(self.zuus_nimbus_particle, 2, Vector(target_point.x, target_point.y, target_point.z + 450))	
	self:AddParticle(self.zuus_nimbus_particle, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end

function modifier_zuus_cloud_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_VISUAL_Z_DELTA,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
	return funcs
end

function modifier_zuus_cloud_custom:GetVisualZDelta()
	return 450
end

function modifier_zuus_cloud_custom:OnIntervalThink()
	if not IsServer() then return end
	if self.lightning_bolt and not self.lightning_bolt:IsNull() and self.lightning_bolt:GetLevel() > 0 and self.counter >= self.cloud_bolt_interval then
		local nearby_enemy_units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(),  self:GetParent():GetAbsOrigin(),  nil,  self.cloud_radius,  DOTA_UNIT_TARGET_TEAM_ENEMY,  self.lightning_bolt:GetAbilityTargetType(), DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
        if #nearby_enemy_units > 0 then
            self.lightning_bolt:CastLightningBolt(self:GetCaster(), nearby_enemy_units[1]:GetAbsOrigin(), self:GetParent(), nearby_enemy_units[1])
            self.counter = 0
        end
	end
    if self.counter <= self.cloud_bolt_interval then
	    self.counter = self.counter + FrameTime()
    end
end

function modifier_zuus_cloud_custom:AttackLandedModifier(params)
	if params.target == self:GetParent() then
		local damage = 2
		if not params.attacker:IsHero() then 
			damage = 1
		end 
		if self:GetParent():GetHealth() > damage then 
			self:GetParent():SetHealth(self:GetParent():GetHealth() - damage)
		else 
			self:GetParent():ForceKill(false)
		end
	end
end

function modifier_zuus_cloud_custom:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_zuus_cloud_custom:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_zuus_cloud_custom:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_zuus_cloud_custom:OnRemoved()
	if not IsServer() then return end
	if self.zuus_nimbus_particle then
		ParticleManager:DestroyParticle(self.zuus_nimbus_particle, false)
	end
end