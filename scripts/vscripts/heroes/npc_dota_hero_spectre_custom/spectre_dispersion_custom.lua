--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spectre_dispersion_custom", "heroes/npc_dota_hero_spectre_custom/spectre_dispersion_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_dispersion_custom_aggresive", "heroes/npc_dota_hero_spectre_custom/spectre_dispersion_custom", LUA_MODIFIER_MOTION_NONE)

spectre_dispersion_custom = class({})

spectre_dispersion_custom.modifier_spectre_3_aura = {250,500}
spectre_dispersion_custom.modifier_spectre_3_duration = 1.75
spectre_dispersion_custom.modifier_spectre_3_cooldown = 18
spectre_dispersion_custom.modifier_spectre_4_percent = 1
spectre_dispersion_custom.modifier_spectre_4_health_percent = 1
spectre_dispersion_custom.modifier_spectre_7 = 5

function spectre_dispersion_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_spectre_3") then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function spectre_dispersion_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_spectre_3") then
		return "spectre_3"
	end
	return "spectre_dispersion"
end

function spectre_dispersion_custom:GetCooldown(iLevel)
	if self:GetCaster():HasModifier("modifier_spectre_3") then
		return self.modifier_spectre_3_cooldown
	end
	return 0
end

function spectre_dispersion_custom:OnSpellStart()
	if not IsServer() then return end
	local radius = self.modifier_spectre_3_aura[self:GetCaster():GetTalentLevel("modifier_spectre_3")]
	local duration = self.modifier_spectre_3_duration
	if self:GetCaster():HasModifier("modifier_spectre_4") then
		local percent = (100 - self:GetCaster():GetHealthPercent()) / self.modifier_spectre_4_health_percent
		duration = duration + (duration / 100 * percent)
	end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier( self:GetCaster(), self, "modifier_spectre_dispersion_custom_aggresive", { duration = duration } )
	end
	local particle = ParticleManager:CreateParticle( "particles/spectre_call.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControlEnt( particle, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl(particle, 2, Vector(radius,radius,radius))
    ParticleManager:ReleaseParticleIndex( particle )	
	self:GetCaster():EmitSound("Hero_Spectre.HauntCast")
end

function spectre_dispersion_custom:GetIntrinsicModifierName()
	return "modifier_spectre_dispersion_custom"
end

modifier_spectre_dispersion_custom = class({})

function modifier_spectre_dispersion_custom:IsHidden()
	return true
end

function modifier_spectre_dispersion_custom:IsDebuff()
	return false
end

function modifier_spectre_dispersion_custom:IsStunDebuff()
	return false
end

function modifier_spectre_dispersion_custom:IsPurgable()
	return false
end

function modifier_spectre_dispersion_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.reflect = self:GetAbility():GetSpecialValueFor( "damage_reflection_pct" )
	self.min_radius = self:GetAbility():GetSpecialValueFor( "min_radius" )
	self.max_radius = self:GetAbility():GetSpecialValueFor( "max_radius" )
	self.delta = self.max_radius-self.min_radius
end

function modifier_spectre_dispersion_custom:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_spectre_dispersion_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return funcs
end

function modifier_spectre_dispersion_custom:GetModifierIncomingDamage_Percentage( params )
	if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
	if self.parent:PassivesDisabled() then return 0 end
    if self.parent:IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_spectre_13") then return end
	local reflect = self:GetAbility():GetSpecialValueFor( "damage_reflection_pct" )
	if self:GetCaster():HasModifier("modifier_spectre_7") then
		reflect = reflect + self:GetAbility().modifier_spectre_7
	end
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.max_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs(enemies) do
		local distance = (enemy:GetOrigin()-self.parent:GetOrigin()):Length2D()
		local pct = (self.max_radius-distance)/self.delta
		pct = math.min( pct, 1 )
		local damageTable = 
		{
			attacker = self.parent,
			ability = self:GetAbility(),
			damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_REFLECTION,
			victim = enemy,
			damage = params.original_damage * pct * reflect/100,
			damage_type = params.damage_type,
		}
		if enemy:IsHero() then
			local part = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_dispersion.vpcf", PATTACH_CUSTOMORIGIN, enemy)
			ParticleManager:SetParticleControl(part, 0, enemy:GetAbsOrigin() + Vector(0,0,50))
			ParticleManager:SetParticleControl(part, 1, self.parent:GetAbsOrigin() + Vector(0,0,50))
			ParticleManager:SetParticleControl(part, 2, self.parent:GetAbsOrigin() + Vector(0,0,50))
			ParticleManager:ReleaseParticleIndex(part)
		end
		ApplyDamage(damageTable)
	end
	return -reflect
end

modifier_spectre_dispersion_custom_aggresive = class({})

function modifier_spectre_dispersion_custom_aggresive:IsHidden()
    return false
end

function modifier_spectre_dispersion_custom_aggresive:IsPurgable()
    return false
end

function modifier_spectre_dispersion_custom_aggresive:OnCreated( kv )
    if not IsServer() then return end
    self:GetParent():SetForceAttackTarget( self:GetCaster() )
    self:GetParent():MoveToTargetToAttack( self:GetCaster() )
    self:StartIntervalThink(FrameTime())
end

function modifier_spectre_dispersion_custom_aggresive:OnIntervalThink( kv )
    if not IsServer() then return end
	if not self:GetCaster():IsAlive() then self:Destroy() return end
    self:GetParent():SetForceAttackTarget( self:GetCaster() )
    self:GetParent():MoveToTargetToAttack( self:GetCaster() )
end

function modifier_spectre_dispersion_custom_aggresive:OnRemoved()
    if not IsServer() then return end
    self:GetParent():SetForceAttackTarget( nil )
end

function modifier_spectre_dispersion_custom_aggresive:CheckState()
    local state = 
    {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_TAUNTED] = true,
    }

    return state
end