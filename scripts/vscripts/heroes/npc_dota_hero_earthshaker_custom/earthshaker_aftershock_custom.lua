--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_earthshaker_aftershock_custom", "heroes/npc_dota_hero_earthshaker_custom/earthshaker_aftershock_custom", LUA_MODIFIER_MOTION_NONE )

earthshaker_aftershock_custom = class({})

earthshaker_aftershock_custom.modifier_earthshaker_10 = {50,75}
earthshaker_aftershock_custom.modifier_earthshaker_11_duration = 0.01
earthshaker_aftershock_custom.modifier_earthshaker_11_range = {650,600,550}
earthshaker_aftershock_custom.modifier_earthshaker_13 = {45,90}
earthshaker_aftershock_custom.modifier_earthshaker_17 = {60,120}

function earthshaker_aftershock_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_earthshaker.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_earthshaker.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_earthshaker.vpcf", context)
end

function earthshaker_aftershock_custom:GetIntrinsicModifierName()
	return "modifier_earthshaker_aftershock_custom"
end

modifier_earthshaker_aftershock_custom = class({})

function modifier_earthshaker_aftershock_custom:IsHidden()
	return true
end

function modifier_earthshaker_aftershock_custom:IsPurgable()
	return false
end

function modifier_earthshaker_aftershock_custom:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "aftershock_range" )
	if IsServer() then
		local damage = self:GetAbility():GetSpecialValueFor("aftershock_damage")
		self.duration = self:GetAbility():GetSpecialValueFor("duration")
		self.damageTable = { attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() }
		self.distance_to_skill = 0
		self.currentpos = self:GetParent():GetAbsOrigin()
		self:StartIntervalThink(0.1)
	end
end

function modifier_earthshaker_aftershock_custom:OnRefresh( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "aftershock_range" )
	if IsServer() then
		local damage = self:GetAbility():GetSpecialValueFor("aftershock_damage")
		self.duration = self:GetAbility():GetSpecialValueFor("duration")
		self.damageTable.damage = damage
	end
end

function modifier_earthshaker_aftershock_custom:AfterShockApply(location)
	if not IsServer() then return end

	if self:GetParent():PassivesDisabled() then return end

	local damage = self:GetAbility():GetSpecialValueFor("aftershock_damage")
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	local radius = self:GetAbility():GetSpecialValueFor( "aftershock_range" )

	if self:GetCaster():HasModifier("modifier_earthshaker_17") then
		damage = damage + self:GetAbility().modifier_earthshaker_17[self:GetCaster():GetTalentLevel("modifier_earthshaker_17")]
	end

	if self:GetCaster():HasModifier("modifier_earthshaker_10") then
		damage = damage + ( self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_earthshaker_10[self:GetCaster():GetTalentLevel("modifier_earthshaker_10")] )
	end

	if self:GetCaster():HasModifier("modifier_earthshaker_13") then
		radius = radius + self:GetAbility().modifier_earthshaker_13[self:GetCaster():GetTalentLevel("modifier_earthshaker_13")]
	end

	if self:GetCaster():HasModifier("modifier_earthshaker_11") then
		duration = self:GetAbility().modifier_earthshaker_11_duration
	end

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), location, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_stunned", { duration = duration * (1-enemy:GetStatusResistance()) } )
		ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
	end

  	if self:GetCaster():HasModifier("modifier_earthshaker_14") then 
  		local heroes_check = {}
    	for k, v in pairs(Entities:FindAllByName("npc_dota_thinker")) do
            local modifier_earthshaker_fissure_custom_thinker = v:FindModifierByName("modifier_earthshaker_fissure_custom_thinker")
        	if modifier_earthshaker_fissure_custom_thinker and modifier_earthshaker_fissure_custom_thinker:GetCaster() == self:GetCaster() then
            	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), v:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
            	for _,enemy in pairs(enemies) do
            		if heroes_check[enemy:entindex()] == nil then
            			heroes_check[enemy:entindex()] = enemy
              			enemy:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_stunned", { duration = duration * (1-enemy:GetStatusResistance()) } )
						ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
					end
          		end
              	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf", PATTACH_ABSORIGIN_FOLLOW, v )
              	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
              	ParticleManager:ReleaseParticleIndex( effect_cast )
        	end
    	end
  	end

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_earthshaker_aftershock_custom:OnIntervalThink()
	if not IsServer() then return end
    if not self:GetParent():IsAlive() then return end
	local pos = self:GetParent():GetOrigin()
	local dist = (pos - self.currentpos):Length2D()
	self.currentpos = pos
	if dist > 1000 then return end

	if self:GetCaster():HasModifier("modifier_earthshaker_11") then
		self.distance_to_skill = self.distance_to_skill + dist
		if self.distance_to_skill > self:GetAbility().modifier_earthshaker_11_range[self:GetCaster():GetTalentLevel("modifier_earthshaker_11")] then
			self:AfterShockApply(self:GetParent():GetAbsOrigin())
			self.distance_to_skill = 0
		end
	end
end