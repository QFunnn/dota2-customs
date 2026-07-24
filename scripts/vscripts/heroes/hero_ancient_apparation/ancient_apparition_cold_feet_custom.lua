--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ancient_apparition_cold_feet_custom", "heroes/hero_ancient_apparation/ancient_apparition_cold_feet_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_apparition_cold_feet_custom_stunned", "heroes/hero_ancient_apparation/ancient_apparition_cold_feet_custom", LUA_MODIFIER_MOTION_NONE )

ancient_apparition_cold_feet_custom = class({})

function ancient_apparition_cold_feet_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function ancient_apparition_cold_feet_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	
	if target then
		if not target:TriggerSpellAbsorb(self) then
			target:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_cold_feet_custom", {})
			local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
			for _, enemy in pairs(enemies) do
				if enemy ~= target then
					enemy:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_cold_feet_custom", {})
				end
			end
		end
	end
end

modifier_ancient_apparition_cold_feet_custom = class({})

function modifier_ancient_apparition_cold_feet_custom:OnCreated()
	if not IsServer() then return end
	
	self.duration		= self:GetAbility():GetSpecialValueFor("duration")
	self.damage			= self:GetAbility():GetSpecialValueFor("damage")
	self.break_distance	= self:GetAbility():GetSpecialValueFor("break_distance")
	self.stun_duration	= self:GetAbility():GetSpecialValueFor("stun_duration")

	if self:GetCaster():HasTalent("special_bonus_unique_ancient_apparition_6") then
		self.damage = self.damage * 2
	end

	self.damageTable 	= {
		victim 			= self:GetParent(),
		damage 			= self.damage,
		damage_type		= self:GetAbility():GetAbilityDamageType(),
		damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
		attacker 		= self:GetCaster(),
		ability 		= self:GetAbility()
	}

	self.original_position	= self:GetParent():GetAbsOrigin()
	self.counter			= 1
	self.ticks				= 0
	self.interval			= 0.1
	
	self:GetParent():EmitSound("Hero_Ancient_Apparition.ColdFeetCast")

	local cold_feet_marker_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_marker.vpcf", PATTACH_ABSORIGIN, self:GetParent())
	self:AddParticle(cold_feet_marker_particle, false, false, -1, false, false)

	local cold_feet_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	self:AddParticle(cold_feet_particle, false, false, -1, false, false)
	
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_ancient_apparition_cold_feet_custom:OnIntervalThink()
	if (self:GetParent():GetAbsOrigin() - self.original_position):Length2D() < self.break_distance then
		self.counter	= self.counter + self.interval
		if self.counter >= 1 then
			if self.ticks < self.duration then
				EmitSoundOnClient("Hero_Ancient_Apparition.ColdFeetTick", self:GetParent():GetPlayerOwner())
			
				SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), self.damage, nil)
			
				ApplyDamage(self.damageTable)
				self.ticks = self.ticks + 1
				self.counter = 0
			else
				self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ancient_apparition_cold_feet_custom_stunned", {duration = self.stun_duration * (1 - self:GetParent():GetStatusResistance())})
				
				self:Destroy()
			end
		end
	else
		self:Destroy()
	end
end

modifier_ancient_apparition_cold_feet_custom_stunned = class({})

function modifier_ancient_apparition_cold_feet_custom_stunned:GetEffectName()
	return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_frozen.vpcf"
end

function modifier_ancient_apparition_cold_feet_custom_stunned:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_ancient_apparition_cold_feet_custom_stunned:OnCreated()
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Ancient_Apparition.ColdFeetFreeze")
end

function modifier_ancient_apparition_cold_feet_custom_stunned:CheckState()
	local state = 
	{
		[MODIFIER_STATE_STUNNED]	= true,
		[MODIFIER_STATE_FROZEN]		= true
	}
	return state
end