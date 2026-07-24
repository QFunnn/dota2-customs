--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_disruptor_kinetic_field_custom", "heroes/npc_dota_hero_disruptor_custom/disruptor_kinetic_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_kinetic_field_custom_big", "heroes/npc_dota_hero_disruptor_custom/disruptor_kinetic_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_kinetic_field_custom_enemies", "heroes/npc_dota_hero_disruptor_custom/disruptor_kinetic_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_kinetic_field_custom_friendly", "heroes/npc_dota_hero_disruptor_custom/disruptor_kinetic_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_kinetic_field_custom_enemies_debuff", "heroes/npc_dota_hero_disruptor_custom/disruptor_kinetic_field_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_kinetic_field_custom_friendly_buff", "heroes/npc_dota_hero_disruptor_custom/disruptor_kinetic_field_custom", LUA_MODIFIER_MOTION_NONE )

disruptor_kinetic_field_custom = class({})

function disruptor_kinetic_field_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_kineticfield_formation.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_kineticfield.vpcf', context )
end

disruptor_kinetic_field_custom.modifier_disruptor_9 = {20,25,30}
disruptor_kinetic_field_custom.modifier_disruptor_10 = {20,25,30}
disruptor_kinetic_field_custom.modifier_disruptor_11 = -1
disruptor_kinetic_field_custom.modifier_disruptor_12 = {0.8,1.6}
disruptor_kinetic_field_custom.modifier_disruptor_13 = {-4,-8} 

function disruptor_kinetic_field_custom:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function disruptor_kinetic_field_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_disruptor_13") then
	    bonus = self.modifier_disruptor_13[self:GetCaster():GetTalentLevel("modifier_disruptor_13")]
	end
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function disruptor_kinetic_field_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor( "radius" )
	CreateModifierThinker( self:GetCaster(), self, "modifier_disruptor_kinetic_field_custom", {radius = radius}, point, self:GetCaster():GetTeamNumber(), false )
	CreateModifierThinker( self:GetCaster(), self, "modifier_disruptor_kinetic_field_custom_enemies", {radius = radius}, point, self:GetCaster():GetTeamNumber(), false )
	CreateModifierThinker( self:GetCaster(), self, "modifier_disruptor_kinetic_field_custom_friendly", {radius = radius}, point, self:GetCaster():GetTeamNumber(), false )
	if self:GetCaster():HasModifier("modifier_disruptor_14") then
		CreateModifierThinker( self:GetCaster(), self, "modifier_disruptor_kinetic_field_custom_big", {radius = radius * 2}, point, self:GetCaster():GetTeamNumber(), false )
		CreateModifierThinker( self:GetCaster(), self, "modifier_disruptor_kinetic_field_custom_enemies", {radius = radius * 2}, point, self:GetCaster():GetTeamNumber(), false )
		CreateModifierThinker( self:GetCaster(), self, "modifier_disruptor_kinetic_field_custom_friendly", {radius = radius * 2}, point, self:GetCaster():GetTeamNumber(), false )
	end
end

modifier_disruptor_kinetic_field_custom = class({})
function modifier_disruptor_kinetic_field_custom:IsPurgable() return false end
function modifier_disruptor_kinetic_field_custom:IsPurgeException() return false end
function modifier_disruptor_kinetic_field_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_disruptor_kinetic_field_custom:OnCreated( kv )
	if not IsServer() then return end
	self.owner = kv.isProvidedByAura~=1

	if self.owner then
		self:GetParent().radius = kv.radius
		self.radius = kv.radius
		self.parent = self:GetParent()
		self.delay = self:GetAbility():GetSpecialValueFor( "formation_time" )
		if self:GetCaster():HasModifier("modifier_disruptor_11") then
			self.delay = self.delay + self:GetAbility().modifier_disruptor_11
		end
		self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
		if self:GetCaster():HasModifier("modifier_disruptor_12") then
			self.duration = self.duration + self:GetAbility().modifier_disruptor_12[self:GetCaster():GetTalentLevel("modifier_disruptor_12")]
		end
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.radius, self.delay + self.duration, false)
		self:SetDuration( self.delay + self.duration, false )
		self.formed = false
		self:StartIntervalThink( self.delay )
		self:PlayEffects1()
		self:GetParent():EmitSound("Hero_Disruptor.KineticField")
	else
		self.radius = self:GetAuraOwner().radius
		self.aura_origin = Vector( kv.aura_origin_x, kv.aura_origin_y, 0 )
		self.parent = self:GetParent()
		self.width = 100
		self.max_speed = 550
		self.min_speed = 0.1
		self.max_min = self.max_speed-self.min_speed
		self.inside = (self.parent:GetOrigin()-self.aura_origin):Length2D() < self.radius
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_disruptor_kinetic_field_custom:OnDestroy()
	if not IsServer() then return end
	if self.owner then
		self:GetParent():StopSound("Hero_Disruptor.KineticField")
		self:GetParent():EmitSound("Hero_Disruptor.KineticField.End")
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_disruptor_kinetic_field_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}
	return funcs
end

function modifier_disruptor_kinetic_field_custom:GetModifierMoveSpeed_Limit( params )
	if not IsServer() then return end
	if self.owner then return 0 end
	if self.parent:HasModifier("modifier_woda_neutral_flying") then return end
	local parent_vector = self.parent:GetOrigin()-self.aura_origin
	parent_vector.z = 0
	local parent_direction = parent_vector:Normalized()
	local actual_distance = parent_vector:Length2D()
	local wall_distance = actual_distance-self.radius
	local over_walls = false
	if self.inside ~= (wall_distance<0) then
		if math.abs( wall_distance )>self.width then
			self.inside = not self.inside
		else
			over_walls = true
		end
	end	
	wall_distance = math.abs(wall_distance)
	if wall_distance>self.width then return 0 end
	local parent_angle = 0
	if self.inside then
		parent_angle = VectorToAngles(parent_direction).y
	else
		parent_angle = VectorToAngles(-parent_direction).y
	end
	local unit_angle = self:GetParent():GetAnglesAsVector().y
	local wall_angle = math.abs( AngleDiff( parent_angle, unit_angle ) )
	local limit = 0
	if wall_angle<=90 then
		if over_walls then
			limit = self.min_speed
            self.parent:RemoveModifierByName("modifier_item_forcestaff_active")
            self.parent:RemoveModifierByName("modifier_force_boots_active")
            self.parent:RemoveModifierByName("modifier_item_hurricane_pike_active")
		else
			limit = (wall_distance/self.width)*self.max_min + self.min_speed
            self.parent:RemoveModifierByName("modifier_item_forcestaff_active")
            self.parent:RemoveModifierByName("modifier_force_boots_active")
            self.parent:RemoveModifierByName("modifier_item_hurricane_pike_active")
		end
	else
        self.parent:RemoveModifierByName("modifier_item_forcestaff_active")
        self.parent:RemoveModifierByName("modifier_force_boots_active")
        self.parent:RemoveModifierByName("modifier_item_hurricane_pike_active")
		limit = 0
	end
	return limit
end

function modifier_disruptor_kinetic_field_custom:OnIntervalThink()
	if not IsServer() then return end
	if not self.owner then
		if self.parent:HasModifier("modifier_woda_neutral_flying") then return end
		local parent_vector = self.parent:GetOrigin()-self.aura_origin
		parent_vector.z = 0
		local actual_distance = parent_vector:Length2D()
	else
		self:StartIntervalThink( -1 )
		self.formed = true
		self:PlayEffects2()
	end
end

function modifier_disruptor_kinetic_field_custom:IsAura()
	return self.owner and self.formed
end

function modifier_disruptor_kinetic_field_custom:GetModifierAura()
	return "modifier_disruptor_kinetic_field_custom"
end

function modifier_disruptor_kinetic_field_custom:GetAuraRadius()
	return self.radius
end

function modifier_disruptor_kinetic_field_custom:GetAuraDuration()
	return 0.3
end

function modifier_disruptor_kinetic_field_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_disruptor_kinetic_field_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_disruptor_kinetic_field_custom:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_disruptor_kinetic_field_custom:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_kineticfield_formation.vpcf", PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.delay, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_disruptor_kinetic_field_custom:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_kineticfield.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 999, 0, 0 ) )
	self:AddParticle( effect_cast, true, false, -1, false, false )
end

modifier_disruptor_kinetic_field_custom_enemies = class({})

function modifier_disruptor_kinetic_field_custom_enemies:IsHidden() return true end

function modifier_disruptor_kinetic_field_custom_enemies:OnCreated(params)
	if not IsServer() then return end
	self.radius = params.radius
	self.delay = self:GetAbility():GetSpecialValueFor( "formation_time" )
	if self:GetCaster():HasModifier("modifier_disruptor_11") then
		self.delay = self.delay + self:GetAbility().modifier_disruptor_11
	end
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	if self:GetCaster():HasModifier("modifier_disruptor_12") then
		self.duration = self.duration + self:GetAbility().modifier_disruptor_12[self:GetCaster():GetTalentLevel("modifier_disruptor_12")]
	end
	self:SetDuration( self.delay + self.duration, false )
end

function modifier_disruptor_kinetic_field_custom_enemies:IsAura()
	return self:GetCaster():HasModifier("modifier_disruptor_9")
end

function modifier_disruptor_kinetic_field_custom_enemies:GetModifierAura()
	return "modifier_disruptor_kinetic_field_custom_enemies_debuff"
end

function modifier_disruptor_kinetic_field_custom_enemies:GetAuraRadius()
	return self.radius
end

function modifier_disruptor_kinetic_field_custom_enemies:GetAuraDuration()
	return 0.1
end

function modifier_disruptor_kinetic_field_custom_enemies:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_disruptor_kinetic_field_custom_enemies:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_disruptor_kinetic_field_custom_enemies:GetAuraSearchFlags()
	return 0
end

modifier_disruptor_kinetic_field_custom_friendly = class({})

function modifier_disruptor_kinetic_field_custom_friendly:OnCreated(params)
	if not IsServer() then return end
	self.radius = params.radius
	self.delay = self:GetAbility():GetSpecialValueFor( "formation_time" )
	if self:GetCaster():HasModifier("modifier_disruptor_11") then
		self.delay = self.delay + self:GetAbility().modifier_disruptor_11
	end
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	if self:GetCaster():HasModifier("modifier_disruptor_12") then
		self.duration = self.duration + self:GetAbility().modifier_disruptor_12[self:GetCaster():GetTalentLevel("modifier_disruptor_12")]
	end
	self:SetDuration( self.delay + self.duration, false )
end

function modifier_disruptor_kinetic_field_custom_friendly:IsHidden() return true end

function modifier_disruptor_kinetic_field_custom_friendly:IsAura()
	return self:GetCaster():HasModifier("modifier_disruptor_10")
end

function modifier_disruptor_kinetic_field_custom_friendly:GetModifierAura()
	return "modifier_disruptor_kinetic_field_custom_friendly_buff"
end

function modifier_disruptor_kinetic_field_custom_friendly:GetAuraRadius()
	return self.radius
end

function modifier_disruptor_kinetic_field_custom_friendly:GetAuraDuration()
	return 0.1
end

function modifier_disruptor_kinetic_field_custom_friendly:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_disruptor_kinetic_field_custom_friendly:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_disruptor_kinetic_field_custom_friendly:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_disruptor_kinetic_field_custom_enemies_debuff = class({})

function modifier_disruptor_kinetic_field_custom_enemies_debuff:GetTexture() return "disruptor_9" end

function modifier_disruptor_kinetic_field_custom_enemies_debuff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modifier_disruptor_kinetic_field_custom_enemies_debuff:OnIntervalThink()
	if not IsServer() then return end
	local damage = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_disruptor_9[self:GetCaster():GetTalentLevel("modifier_disruptor_9")]
	ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK })
end

modifier_disruptor_kinetic_field_custom_friendly_buff = class({})

function modifier_disruptor_kinetic_field_custom_friendly_buff:GetTexture() return "disruptor_10" end

function modifier_disruptor_kinetic_field_custom_friendly_buff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modifier_disruptor_kinetic_field_custom_friendly_buff:OnIntervalThink()
	if not IsServer() then return end
	local heal = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_disruptor_10[self:GetCaster():GetTalentLevel("modifier_disruptor_10")]
	self:GetParent():Heal(heal, self:GetAbility())
end

function modifier_disruptor_kinetic_field_custom_friendly_buff:CheckState()
	return
	{
		[MODIFIER_STATE_UNSLOWABLE] = self:GetCaster():HasModifier("modifier_disruptor_14")
	}
end

modifier_disruptor_kinetic_field_custom_big = class({})
function modifier_disruptor_kinetic_field_custom_big:IsPurgable() return false end
function modifier_disruptor_kinetic_field_custom_big:IsPurgeException() return false end
function modifier_disruptor_kinetic_field_custom_big:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_disruptor_kinetic_field_custom_big:OnCreated( kv )
	if not IsServer() then return end
	self.owner = kv.isProvidedByAura~=1

	if self.owner then
		self:GetParent().radius = kv.radius-20
		self.radius = kv.radius-20
		self.parent = self:GetParent()
		self.delay = self:GetAbility():GetSpecialValueFor( "formation_time" )
		if self:GetCaster():HasModifier("modifier_disruptor_11") then
			self.delay = self.delay + self:GetAbility().modifier_disruptor_11
		end
		self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
		if self:GetCaster():HasModifier("modifier_disruptor_12") then
			self.duration = self.duration + self:GetAbility().modifier_disruptor_12[self:GetCaster():GetTalentLevel("modifier_disruptor_12")]
		end
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.radius, self.delay + self.duration, false)
		self:SetDuration( self.delay + self.duration, false )
		self.formed = false
		self:StartIntervalThink( self.delay )
		self:PlayEffects1()
		self:GetParent():EmitSound("Hero_Disruptor.KineticField")
	else
		self.radius = self:GetAuraOwner().radius
		self.aura_origin = Vector( kv.aura_origin_x, kv.aura_origin_y, 0 )
		self.parent = self:GetParent()
		self.width = 100
		self.max_speed = 550
		self.min_speed = 0.1
		self.max_min = self.max_speed-self.min_speed
		self.inside = (self.parent:GetOrigin()-self.aura_origin):Length2D() < self.radius
	end
end

function modifier_disruptor_kinetic_field_custom_big:OnDestroy()
	if not IsServer() then return end
	if self.owner then
		self:GetParent():StopSound("Hero_Disruptor.KineticField")
		self:GetParent():EmitSound("Hero_Disruptor.KineticField.End")
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_disruptor_kinetic_field_custom_big:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}
	return funcs
end

function modifier_disruptor_kinetic_field_custom_big:GetModifierMoveSpeed_Limit( params )
	if not IsServer() then return end
	if self.owner then return 0 end
	if self.parent:HasModifier("modifier_woda_neutral_flying") then return end
	local parent_vector = self.parent:GetOrigin()-self.aura_origin
	parent_vector.z = 0
	local parent_direction = parent_vector:Normalized()
	local actual_distance = parent_vector:Length2D()
	local wall_distance = actual_distance-self.radius
	local over_walls = false
	if self.inside ~= (wall_distance<0) then
		if math.abs( wall_distance )>self.width then
			self.inside = not self.inside
		else
			over_walls = true
		end
	end	
	wall_distance = math.abs(wall_distance)
	if wall_distance>self.width then return 0 end
	local parent_angle = 0
	if self.inside then
		parent_angle = VectorToAngles(parent_direction).y
	else
		parent_angle = VectorToAngles(-parent_direction).y
	end
	local unit_angle = self:GetParent():GetAnglesAsVector().y
	local wall_angle = math.abs( AngleDiff( parent_angle, unit_angle ) )
	local limit = 0
	if wall_angle<=90 then
		if over_walls then
			limit = self.min_speed
		else
			limit = (wall_distance/self.width)*self.max_min + self.min_speed
		end
	else
		limit = 0
	end
	return limit
end

function modifier_disruptor_kinetic_field_custom_big:OnIntervalThink()
	if not IsServer() then return end
	if not self.owner then
		if self.parent:HasModifier("modifier_woda_neutral_flying") then return end
		local parent_vector = self.parent:GetOrigin()-self.aura_origin
		parent_vector.z = 0
		local actual_distance = parent_vector:Length2D()
	else
		self:StartIntervalThink( -1 )
		self.formed = true
		self:PlayEffects2()
	end
end

function modifier_disruptor_kinetic_field_custom_big:IsAura()
	return self.owner and self.formed
end

function modifier_disruptor_kinetic_field_custom_big:GetModifierAura()
	return "modifier_disruptor_kinetic_field_custom_big"
end

function modifier_disruptor_kinetic_field_custom_big:GetAuraRadius()
	return self.radius
end

function modifier_disruptor_kinetic_field_custom_big:GetAuraDuration()
	return 0.3
end

function modifier_disruptor_kinetic_field_custom_big:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_disruptor_kinetic_field_custom_big:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_disruptor_kinetic_field_custom_big:GetAuraSearchFlags()
	return 0
end

function modifier_disruptor_kinetic_field_custom_big:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_kineticfield_formation.vpcf", PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.delay, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_disruptor_kinetic_field_custom_big:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_kineticfield.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 999, 0, 0 ) )
	self:AddParticle( effect_cast, true, false, -1, false, false )
end