--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_muerta_the_calling_custom", "heroes/npc_dota_hero_muerta_custom/muerta_the_calling_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_muerta_the_calling_custom_thinker", "heroes/npc_dota_hero_muerta_custom/muerta_the_calling_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_muerta_the_calling_custom_debuff", "heroes/npc_dota_hero_muerta_custom/muerta_the_calling_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_muerta_the_calling_custom_damage", "heroes/npc_dota_hero_muerta_custom/muerta_the_calling_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_muerta_the_calling_custom_thinker_buff", "heroes/npc_dota_hero_muerta_custom/muerta_the_calling_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_muerta_the_calling_custom_thinker_heal", "heroes/npc_dota_hero_muerta_custom/muerta_the_calling_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_muerta_the_calling_caster", "heroes/npc_dota_hero_muerta_custom/muerta_the_calling_custom", LUA_MODIFIER_MOTION_NONE )

muerta_the_calling_custom = class({})

function muerta_the_calling_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_calling_aoe.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_calling.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_calling_impact.vpcf", context )
    PrecacheResource( "particle", "particles/muerta_buff.vpcf", context )
end

muerta_the_calling_custom.modifier_muerta_1 = {50,100}
muerta_the_calling_custom.modifier_muerta_2_slow = {-5,-10}
muerta_the_calling_custom.modifier_muerta_2_cd = {-5,-10}
muerta_the_calling_custom.modifier_muerta_3 = {10,20}
muerta_the_calling_custom.modifier_muerta_5 = {2}
muerta_the_calling_custom.modifier_muerta_6 = {-30,-60,-90}
muerta_the_calling_custom.modifier_muerta_11 = 80

function muerta_the_calling_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_muerta_7") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function muerta_the_calling_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_muerta_7") then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_CAN_SELF_CAST
end

function muerta_the_calling_custom:GetCooldown(level)
	if self:GetCaster():HasModifier("modifier_muerta_7") then
		return 0
	end
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_muerta_2") then
        bonus = self.modifier_muerta_2_cd[self:GetCaster():GetTalentLevel("modifier_muerta_2")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function muerta_the_calling_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")
	CreateModifierThinker( self:GetCaster(), self, "modifier_muerta_the_calling_custom", { duration = duration }, point, self:GetCaster():GetTeamNumber(), false )
	EmitSoundOnLocationWithCaster(point, "Hero_Muerta.Revenants.Cast", self:GetCaster())
	if self:GetCaster():HasModifier("modifier_muerta_3") then
		CreateModifierThinker( self:GetCaster(), self, "modifier_muerta_the_calling_custom_thinker_buff", { duration = duration }, point, self:GetCaster():GetTeamNumber(), false )
	end
end

modifier_muerta_the_calling_custom_thinker_buff = class({})

function modifier_muerta_the_calling_custom_thinker_buff:IsHidden() return true end
function modifier_muerta_the_calling_custom_thinker_buff:IsPurgable() return false end

function modifier_muerta_the_calling_custom_thinker_buff:OnCreated()
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("dead_zone_distance") + (self:GetAbility():GetSpecialValueFor("hit_radius") * 2)
end

function modifier_muerta_the_calling_custom_thinker_buff:IsAura()
    return true
end

function modifier_muerta_the_calling_custom_thinker_buff:GetModifierAura()
    return "modifier_muerta_the_calling_custom_thinker_heal"
end

function modifier_muerta_the_calling_custom_thinker_buff:GetAuraRadius()
    return self.radius
end

function modifier_muerta_the_calling_custom_thinker_buff:GetAuraDuration()
    return 0
end

function modifier_muerta_the_calling_custom_thinker_buff:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_muerta_the_calling_custom_thinker_buff:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end


modifier_muerta_the_calling_custom_thinker_heal = class({})

function modifier_muerta_the_calling_custom_thinker_heal:IsPurgable() return false end
function modifier_muerta_the_calling_custom_thinker_heal:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end

function modifier_muerta_the_calling_custom_thinker_heal:GetModifierConstantHealthRegen()
	return self:GetAbility().modifier_muerta_3[self:GetCaster():GetTalentLevel("modifier_muerta_3")]
end

modifier_muerta_the_calling_custom = class({})

function modifier_muerta_the_calling_custom:IsHidden() return true end
function modifier_muerta_the_calling_custom:IsPurgable() return false end

function modifier_muerta_the_calling_custom:OnCreated()
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("dead_zone_distance") + (self:GetAbility():GetSpecialValueFor("hit_radius") * 2)
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_calling_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, self.radius, self.radius))
	ParticleManager:SetParticleControl(particle, 2, Vector(self:GetDuration(), self:GetDuration(), self:GetDuration()))
	self:AddParticle(particle, false, false, -1, false, false)
	local r = self.radius

    local c = math.sqrt( 2 ) * 0.5 * r 

    local x_offset = { -r+120, -c, 0.0, c, r-120, c, 0.0, -c }
    local y_offset = { 0.0, c, r-120, c, 0.0, -c, -r+120, -c }


    if self:GetCaster():HasModifier("modifier_muerta_5") then
		self.wisp_1 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[1], y_offset[1], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_2 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[2], y_offset[2], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_3 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[3], y_offset[3], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_4 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[5], y_offset[5], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_5 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[6], y_offset[6], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_6 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[7], y_offset[7], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
	else
		self.wisp_1 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[1], y_offset[1], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_2 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[3], y_offset[3], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_3 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[5], y_offset[5], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_4 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[7], y_offset[7], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
	end

	self.wisp_1:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})
	self.wisp_2:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})
	self.wisp_3:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})
	self.wisp_4:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})

	if self.wisp_5 then
		self.wisp_5:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})
	end

	if self.wisp_6 then
		self.wisp_6:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})
	end

	self.parent = self:GetParent()
	self.zero = Vector(0,0,0)
	self.revolution = 6
	self.rotate_radius = self.radius-120
	self.interval = 0.03
	self.base_facing = Vector(0,1,0)
	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
	self.rotate_delta = 360/self.revolution * self.interval
	self.position1 = self.parent:GetOrigin() + self.relative_pos
	self.position2 = self.parent:GetOrigin() + self.relative_pos
	self.position3 = self.parent:GetOrigin() + self.relative_pos
	self.position4 = self.parent:GetOrigin() + self.relative_pos
	self.position5 = self.parent:GetOrigin() + self.relative_pos
	self.position6 = self.parent:GetOrigin() + self.relative_pos

	self.rotation1 = 0
	self.rotation2 = 90
	self.rotation3 = 180
	self.rotation4 = 270
	self.rotation5 = 300
	self.rotation6 = 360

 	if self:GetCaster():HasModifier("modifier_muerta_5") then
		self.rotation1 = 60
		self.rotation2 = 120
		self.rotation3 = 180
		self.rotation4 = 240
		self.rotation5 = 300
		self.rotation6 = 360
	end

	self.facing = self.base_facing

	self.wisp_1:SetForwardVector( self.facing )
	self.wisp_1:SetDayTimeVisionRange(0)
	self.wisp_1:SetNightTimeVisionRange(0)

	self.wisp_2:SetForwardVector( self.facing )
	self.wisp_2:SetDayTimeVisionRange(0)
	self.wisp_2:SetNightTimeVisionRange(0)

	self.wisp_3:SetForwardVector( self.facing )
	self.wisp_3:SetDayTimeVisionRange(0)
	self.wisp_3:SetNightTimeVisionRange(0)

	self.wisp_4:SetForwardVector( self.facing )
	self.wisp_4:SetDayTimeVisionRange(0)
	self.wisp_4:SetNightTimeVisionRange(0)

	if self.wisp_5 then
		self.wisp_5:SetForwardVector( self.facing )
		self.wisp_5:SetDayTimeVisionRange(0)
		self.wisp_5:SetNightTimeVisionRange(0)
	end

	if self.wisp_6 then
		self.wisp_6:SetForwardVector( self.facing )
		self.wisp_6:SetDayTimeVisionRange(0)
		self.wisp_6:SetNightTimeVisionRange(0)
	end

	self:StartIntervalThink( self.interval )
end

function modifier_muerta_the_calling_custom:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self.wisp_1 )
	UTIL_Remove( self.wisp_2 )
	UTIL_Remove( self.wisp_3 )
	UTIL_Remove( self.wisp_4 )
	if self.wisp_5 then
		UTIL_Remove( self.wisp_5 )
	end
	if self.wisp_6 then
		UTIL_Remove( self.wisp_6 )
	end
end

function modifier_muerta_the_calling_custom:OnIntervalThink()
	self.rotation1 = self.rotation1 - self.rotate_delta
	self.rotation2 = self.rotation2 - self.rotate_delta
	self.rotation3 = self.rotation3 - self.rotate_delta
	self.rotation4 = self.rotation4 - self.rotate_delta
	self.rotation5 = self.rotation5 - self.rotate_delta
	self.rotation6 = self.rotation6 - self.rotate_delta

	local origin = self.parent:GetOrigin()

	self.position1 = RotatePosition( origin, QAngle( 0, -self.rotation1, 0 ), origin + self.relative_pos )
	self.position2 = RotatePosition( origin, QAngle( 0, -self.rotation2, 0 ), origin + self.relative_pos )
	self.position3 = RotatePosition( origin, QAngle( 0, -self.rotation3, 0 ), origin + self.relative_pos )
	self.position4 = RotatePosition( origin, QAngle( 0, -self.rotation4, 0 ), origin + self.relative_pos )
	self.position5 = RotatePosition( origin, QAngle( 0, -self.rotation5, 0 ), origin + self.relative_pos )
	self.position6 = RotatePosition( origin, QAngle( 0, -self.rotation6, 0 ), origin + self.relative_pos )

	self.facing1 = RotatePosition( self.zero, QAngle( 0, -self.rotation1, 0 ), self.base_facing )
	self.facing2 = RotatePosition( self.zero, QAngle( 0, -self.rotation2, 0 ), self.base_facing )
	self.facing3 = RotatePosition( self.zero, QAngle( 0, -self.rotation3, 0 ), self.base_facing )
	self.facing4 = RotatePosition( self.zero, QAngle( 0, -self.rotation4, 0 ), self.base_facing )
	self.facing5 = RotatePosition( self.zero, QAngle( 0, -self.rotation5, 0 ), self.base_facing )
	self.facing6 = RotatePosition( self.zero, QAngle( 0, -self.rotation6, 0 ), self.base_facing )

	self.wisp_1:SetOrigin( self.position1 )
	self.wisp_1:SetForwardVector( self.facing1 )

	self.wisp_2:SetOrigin( self.position2 )
	self.wisp_2:SetForwardVector( self.facing2 )

	self.wisp_3:SetOrigin( self.position3 )
	self.wisp_3:SetForwardVector( self.facing3 )

	self.wisp_4:SetOrigin( self.position4 )
	self.wisp_4:SetForwardVector( self.facing4 )

	if self.wisp_5 then
		self.wisp_5:SetOrigin( self.position5 )
		self.wisp_5:SetForwardVector( self.facing5 )
	end

	if self.wisp_6 then
		self.wisp_6:SetOrigin( self.position6 )
		self.wisp_6:SetForwardVector( self.facing6 )
	end
end

function modifier_muerta_the_calling_custom:IsAura()
    return true
end

function modifier_muerta_the_calling_custom:GetModifierAura()
    return "modifier_muerta_the_calling_custom_debuff"
end

function modifier_muerta_the_calling_custom:GetAuraRadius()
    return self.radius
end

function modifier_muerta_the_calling_custom:GetAuraDuration()
    return 0
end

function modifier_muerta_the_calling_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_muerta_the_calling_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_muerta_the_calling_custom_thinker = class({})

function modifier_muerta_the_calling_custom_thinker:IsHidden() return true end
function modifier_muerta_the_calling_custom_thinker:IsPurgable() return false end
function modifier_muerta_the_calling_custom_thinker:RemoveOnDeath() return false end

function modifier_muerta_the_calling_custom_thinker:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_calling.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true )
	ParticleManager:SetParticleControl(particle, 1, Vector(120, 120, 120))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_muerta_the_calling_custom_thinker:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_muerta_the_calling_custom_thinker:OnDestroy()
	if not IsServer() then return end
end

function modifier_muerta_the_calling_custom_thinker:IsAura()
    return true
end

function modifier_muerta_the_calling_custom_thinker:GetModifierAura()
    return "modifier_muerta_the_calling_custom_damage"
end

function modifier_muerta_the_calling_custom_thinker:GetAuraRadius()
    return 120
end

function modifier_muerta_the_calling_custom_thinker:GetAuraDuration()
    return 0
end

function modifier_muerta_the_calling_custom_thinker:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_muerta_the_calling_custom_thinker:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_muerta_the_calling_custom_damage = class({})

function modifier_muerta_the_calling_custom_damage:IsHidden() return true end
function modifier_muerta_the_calling_custom_damage:OnCreated()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_wodawisp") then return end
	if self:GetCaster():HasModifier("modifier_wodarelax") then return end
    if self:GetCaster():HasModifier("modifier_muerta_7") then
        if not self:GetCaster():IsAlive() then return end
        if self:GetCaster():PassivesDisabled() then return end
    end
	if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_calling_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(particle)

		local damage = self:GetAbility():GetSpecialValueFor("damage")

		if self:GetCaster():HasModifier("modifier_muerta_1") then
			damage = damage + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_muerta_1[self:GetCaster():GetTalentLevel("modifier_muerta_1")])
		end

		ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_silence", {duration = self:GetAbility():GetSpecialValueFor("silence_duration") * (1-self:GetParent():GetStatusResistance())})
	end

	if self:GetCaster():HasModifier("modifier_muerta_11") then
		if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then
			self:GetParent():Heal(self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_muerta_11, self:GetAbility())
		end
	end
end

modifier_muerta_the_calling_custom_debuff = class({})

function modifier_muerta_the_calling_custom_debuff:IsPurgable() return false end
function modifier_muerta_the_calling_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_muerta_the_calling_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_muerta_2") then
		bonus = self:GetAbility().modifier_muerta_2_slow[self:GetCaster():GetTalentLevel("modifier_muerta_2")]
	end
	return self:GetAbility():GetSpecialValueFor("aura_movespeed_slow") + bonus
end

function modifier_muerta_the_calling_custom_debuff:GetModifierAttackSpeedBonus_Constant()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_muerta_6") then
		bonus = self:GetAbility().modifier_muerta_6[self:GetCaster():GetTalentLevel("modifier_muerta_6")]
	end
	return self:GetAbility():GetSpecialValueFor("aura_attackspeed_slow") + bonus
end

modifier_muerta_the_calling_caster = class({})

function modifier_muerta_the_calling_caster:IsHidden() return true end
function modifier_muerta_the_calling_caster:IsPurgable() return false end
function modifier_muerta_the_calling_caster:RemoveOnDeath() return false end

function modifier_muerta_the_calling_caster:OnCreated()
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("dead_zone_distance") + (self:GetAbility():GetSpecialValueFor("hit_radius") * 2)
	local particle = ParticleManager:CreateParticle("particles/muerta_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, self.radius, self.radius))
	self:AddParticle(particle, false, false, -1, false, false)
	local r = self.radius

    local c = math.sqrt( 2 ) * 0.5 * r 

    local x_offset = { -r+120, -c, 0.0, c, r-120, c, 0.0, -c }
    local y_offset = { 0.0, c, r-120, c, 0.0, -c, -r+120, -c }


    if self:GetCaster():HasModifier("modifier_muerta_5") then
		self.wisp_1 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[1], y_offset[1], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_2 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[2], y_offset[2], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_3 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[3], y_offset[3], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_4 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[5], y_offset[5], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_5 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[6], y_offset[6], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_6 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[7], y_offset[7], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
	else
		self.wisp_1 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[1], y_offset[1], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_2 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[3], y_offset[3], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_3 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[5], y_offset[5], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
		self.wisp_4 = CreateUnitByName( "npc_dota_companion", self:GetParent():GetAbsOrigin() + Vector( x_offset[7], y_offset[7], 0.0 ), true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber())
	end

	self.wisp_1:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})
	self.wisp_2:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})
	self.wisp_3:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})
	self.wisp_4:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})

	if self.wisp_5 then
		self.wisp_5:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})
	end

	if self.wisp_6 then
		self.wisp_6:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_muerta_the_calling_custom_thinker", {})
	end

	self.parent = self:GetParent()
	self.zero = Vector(0,0,0)
	self.revolution = 6
	self.rotate_radius = self.radius-120
	self.interval = 0.03
	self.base_facing = Vector(0,1,0)
	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
	self.rotate_delta = 360/self.revolution * self.interval
	self.position1 = self.parent:GetOrigin() + self.relative_pos
	self.position2 = self.parent:GetOrigin() + self.relative_pos
	self.position3 = self.parent:GetOrigin() + self.relative_pos
	self.position4 = self.parent:GetOrigin() + self.relative_pos
	self.position5 = self.parent:GetOrigin() + self.relative_pos
	self.position6 = self.parent:GetOrigin() + self.relative_pos

	self.rotation1 = 0
	self.rotation2 = 90
	self.rotation3 = 180
	self.rotation4 = 270
	self.rotation5 = 300
	self.rotation6 = 360

 	if self:GetCaster():HasModifier("modifier_muerta_5") then
		self.rotation1 = 60
		self.rotation2 = 120
		self.rotation3 = 180
		self.rotation4 = 240
		self.rotation5 = 300
		self.rotation6 = 360
	end

	self.facing = self.base_facing

	self.wisp_1:SetForwardVector( self.facing )
	self.wisp_1:SetDayTimeVisionRange(0)
	self.wisp_1:SetNightTimeVisionRange(0)

	self.wisp_2:SetForwardVector( self.facing )
	self.wisp_2:SetDayTimeVisionRange(0)
	self.wisp_2:SetNightTimeVisionRange(0)

	self.wisp_3:SetForwardVector( self.facing )
	self.wisp_3:SetDayTimeVisionRange(0)
	self.wisp_3:SetNightTimeVisionRange(0)

	self.wisp_4:SetForwardVector( self.facing )
	self.wisp_4:SetDayTimeVisionRange(0)
	self.wisp_4:SetNightTimeVisionRange(0)

	if self.wisp_5 then
		self.wisp_5:SetForwardVector( self.facing )
		self.wisp_5:SetDayTimeVisionRange(0)
		self.wisp_5:SetNightTimeVisionRange(0)
	end

	if self.wisp_6 then
		self.wisp_6:SetForwardVector( self.facing )
		self.wisp_6:SetDayTimeVisionRange(0)
		self.wisp_6:SetNightTimeVisionRange(0)
	end

	self:StartIntervalThink( self.interval )
end

function modifier_muerta_the_calling_caster:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self.wisp_1 )
	UTIL_Remove( self.wisp_2 )
	UTIL_Remove( self.wisp_3 )
	UTIL_Remove( self.wisp_4 )
	if self.wisp_5 then
		UTIL_Remove( self.wisp_5 )
	end
	if self.wisp_6 then
		UTIL_Remove( self.wisp_6 )
	end
end

function modifier_muerta_the_calling_caster:OnIntervalThink()
    if not IsServer() then return end
    local new_radius_checker = self:GetAbility():GetSpecialValueFor("dead_zone_distance") + (self:GetAbility():GetSpecialValueFor("hit_radius") * 2)
    if new_radius_checker ~= self.radius then
        self.radius = new_radius_checker
        self.rotate_radius = self.radius-120
        self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
        self.position1 = self.parent:GetOrigin() + self.relative_pos
        self.position2 = self.parent:GetOrigin() + self.relative_pos
        self.position3 = self.parent:GetOrigin() + self.relative_pos
        self.position4 = self.parent:GetOrigin() + self.relative_pos
        self.position5 = self.parent:GetOrigin() + self.relative_pos
        self.position6 = self.parent:GetOrigin() + self.relative_pos
    end

	self.rotation1 = self.rotation1 - self.rotate_delta
	self.rotation2 = self.rotation2 - self.rotate_delta
	self.rotation3 = self.rotation3 - self.rotate_delta
	self.rotation4 = self.rotation4 - self.rotate_delta
	self.rotation5 = self.rotation5 - self.rotate_delta
	self.rotation6 = self.rotation6 - self.rotate_delta

	local origin = self.parent:GetOrigin()

	if not self:GetCaster():IsAlive() or self:GetCaster():HasModifier("modifier_wodawisp") or self:GetCaster():HasModifier("modifier_smoke_of_deceit") or self:GetCaster():PassivesDisabled() then
		if self.wisp_1 then
			self.wisp_1:AddEffects( EF_NODRAW )
		end
		if self.wisp_2 then
			self.wisp_2:AddEffects( EF_NODRAW )
		end
		if self.wisp_3 then
			self.wisp_3:AddEffects( EF_NODRAW )
		end
		if self.wisp_4 then
			self.wisp_4:AddEffects( EF_NODRAW )
		end
		if self.wisp_5 then
			self.wisp_5:AddEffects( EF_NODRAW )
		end
		if self.wisp_6 then
			self.wisp_6:AddEffects( EF_NODRAW )
		end
	else
		if self.wisp_1 then
			self.wisp_1:RemoveEffects( EF_NODRAW )
		end
		if self.wisp_2 then
			self.wisp_2:RemoveEffects( EF_NODRAW )
		end
		if self.wisp_3 then
			self.wisp_3:RemoveEffects( EF_NODRAW )
		end
		if self.wisp_4 then
			self.wisp_4:RemoveEffects( EF_NODRAW )
		end
		if self.wisp_5 then
			self.wisp_5:RemoveEffects( EF_NODRAW )
		end
		if self.wisp_6 then
			self.wisp_6:RemoveEffects( EF_NODRAW )
		end
	end

	self.position1 = RotatePosition( origin, QAngle( 0, -self.rotation1, 0 ), origin + self.relative_pos )
	self.position2 = RotatePosition( origin, QAngle( 0, -self.rotation2, 0 ), origin + self.relative_pos )
	self.position3 = RotatePosition( origin, QAngle( 0, -self.rotation3, 0 ), origin + self.relative_pos )
	self.position4 = RotatePosition( origin, QAngle( 0, -self.rotation4, 0 ), origin + self.relative_pos )
	self.position5 = RotatePosition( origin, QAngle( 0, -self.rotation5, 0 ), origin + self.relative_pos )
	self.position6 = RotatePosition( origin, QAngle( 0, -self.rotation6, 0 ), origin + self.relative_pos )

	self.wisp_1:SetOrigin( self.position1 )
	self.wisp_2:SetOrigin( self.position2 )
	self.wisp_3:SetOrigin( self.position3 )
	self.wisp_4:SetOrigin( self.position4 )

	if self.wisp_5 then
		self.wisp_5:SetOrigin( self.position5 )
	end

	if self.wisp_6 then
		self.wisp_6:SetOrigin( self.position6 )
	end
end

function modifier_muerta_the_calling_caster:IsAura()
    return not self:GetCaster():PassivesDisabled()
end

function modifier_muerta_the_calling_caster:GetModifierAura()
    return "modifier_muerta_the_calling_custom_debuff"
end

function modifier_muerta_the_calling_caster:GetAuraRadius()
    return self.radius
end

function modifier_muerta_the_calling_caster:GetAuraDuration()
    return 0
end

function modifier_muerta_the_calling_caster:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_muerta_the_calling_caster:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end