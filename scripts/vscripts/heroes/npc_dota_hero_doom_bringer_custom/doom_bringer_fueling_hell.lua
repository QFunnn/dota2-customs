--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_doom_bringer_fueling_hell", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_fueling_hell", LUA_MODIFIER_MOTION_NONE)

doom_bringer_fueling_hell = class({})

function doom_bringer_fueling_hell:GetCastRange(vLocation, hTarget)
    return self:GetSpecialValueFor( "radius" )
end

function doom_bringer_fueling_hell:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/doom_fueling_hell.vpcf', context )
end

function doom_bringer_fueling_hell:OnSpellStart()
	if not IsServer() then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/doom_fueling_hell.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 1000, 1000, 1000 ) )
	ParticleManager:SetParticleControl( effect_cast, 15, Vector( 255, 90, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 16, Vector( 1, 1, 1 ) )

	local pulse = self:GetCaster():AddNewModifier(
		self:GetCaster(), 
		self, 
		"modifier_doom_bringer_fueling_hell", 
		{
			--start_radius = self:GetSpecialValueFor("radius"),
			end_radius = self:GetSpecialValueFor("radius"),
			speed = 1000,
			target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		} 
	)

	pulse:SetCallback()
	
	Timers:CreateTimer(self:GetSpecialValueFor("radius")/1000,function()
		ParticleManager:DestroyParticle(effect_cast, false)
		ParticleManager:ReleaseParticleIndex(effect_cast)
    end)
end

modifier_doom_bringer_fueling_hell = class({})

function modifier_doom_bringer_fueling_hell:IsHidden()
	return true
end

function modifier_doom_bringer_fueling_hell:IsDebuff()
	return false
end

function modifier_doom_bringer_fueling_hell:IsStunDebuff()
	return false
end

function modifier_doom_bringer_fueling_hell:IsPurgable()
	return false
end

function modifier_doom_bringer_fueling_hell:RemoveOnDeath()
	return false
end

function modifier_doom_bringer_fueling_hell:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_doom_bringer_fueling_hell:OnCreated( kv )
	if not IsServer() then return end
	self.origin = self:GetParent():GetAbsOrigin()
	self.start_radius = kv.start_radius or 0
	self.end_radius = kv.end_radius or 0
	self.width = kv.width or 100
	self.speed = kv.speed or 0
	self.outward = self.end_radius>=self.start_radius
	if not self.outward then
		self.speed = -self.speed
	end

	self.target_team = kv.target_team or 0
	self.target_type = kv.target_type or 0
	self.target_flags = kv.target_flags or 0

	self.IsCircle = kv.IsCircle or 1

	self.targets = {}
end

function modifier_doom_bringer_fueling_hell:OnDestroy()
	if self.EndCallback then
		self.EndCallback()
	end
	if not IsServer() then return end
	if self:GetParent():GetClassname()=="npc_dota_thinker" then
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_doom_bringer_fueling_hell:SetCallback( callback )
	self.Callback = callback
	self:StartIntervalThink( 0.03 )
	self:OnIntervalThink()
end

function modifier_doom_bringer_fueling_hell:SetEndCallback( callback )
	self.EndCallback = callback
end

function modifier_doom_bringer_fueling_hell:OnIntervalThink()
	local radius = self.start_radius + self.speed * self:GetElapsedTime()
	if not self.outward and radius<self.end_radius then
		self:Destroy()
		return
	elseif self.outward and radius>self.end_radius then
		self:Destroy()
		return
	end

	local targets = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self.origin, nil, radius, self.target_team, self.target_type, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	local fear_duration = 0
	for _,target in pairs(targets) do
		if not self.targets[target] then
			if ((not self.IsCircle) or (target:GetOrigin()-self.origin):Length2D()>(radius-self.width))  then
				self.targets[target] = true
				local doom_bringer_infernal_blade_custom = self:GetCaster():FindAbilityByName("doom_bringer_infernal_blade_custom")
				if doom_bringer_infernal_blade_custom and doom_bringer_infernal_blade_custom:GetLevel() > 0 then
					doom_bringer_infernal_blade_custom:OnOrbImpact( {target = target, is_ability = true} )
				end
			end
		end
	end
end