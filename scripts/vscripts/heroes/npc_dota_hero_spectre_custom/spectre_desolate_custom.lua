--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spectre_desolate_custom", "heroes/npc_dota_hero_spectre_custom/spectre_desolate_custom", LUA_MODIFIER_MOTION_NONE )

spectre_desolate_custom = class({})

spectre_desolate_custom.modifier_spectre_8 = 400
spectre_desolate_custom.modifier_spectre_12 = {5,10,15}

function spectre_desolate_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spectre.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spectre/spectre_desolate.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_spectre.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_spectre.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_spectre.vpcf", context)
end

function spectre_desolate_custom:GetIntrinsicModifierName()
	return "modifier_spectre_desolate_custom"
end

modifier_spectre_desolate_custom = class({})

function modifier_spectre_desolate_custom:IsHidden()
	return true
end

function modifier_spectre_desolate_custom:IsPurgable()
	return false
end

function modifier_spectre_desolate_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
end

function modifier_spectre_desolate_custom:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_spectre_desolate_custom:DeclareFunctions()
	local funcs = 
	{
		 
	}
	return funcs
end

function modifier_spectre_desolate_custom:OnAttackLanded( params )
	if params.attacker~=self.parent then return end
	if self.parent:IsIllusion() and self:GetCaster():HasModifier("modifier_spectre_6") then
        return
    end
    if self.parent:PassivesDisabled() then return end
	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), params.target:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	if not self:GetParent():HasModifier("modifier_spectre_8") then
		if #enemies>1 then return end
	end
	local bonus = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	if self:GetParent():HasModifier("modifier_spectre_12") then
		bonus = bonus + self:GetAbility().modifier_spectre_12[self:GetCaster():GetTalentLevel("modifier_spectre_12")]
	end
    if self:GetCaster():HasModifier("modifier_spectre_6") then
        bonus = bonus * 2
    end
    local attacker1 = self:GetParent()
    if attacker1:IsIllusion() then
    	attacker1 = self:GetCaster()
	end
	local damageTable = 
	{
		victim = params.target,
		attacker = attacker1,
		damage = bonus,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(),
	}

	local proc = false

	if self:GetParent():HasModifier("modifier_spectre_13") and RollPercentage(self:GetParent():GetEvasion() * 100) then
		proc = true
		damageTable.damage = damageTable.damage * 2
	end

	if self:GetCaster():HasModifier("modifier_spectre_8") then
		local enemies_new = FindUnitsInRadius( self:GetParent():GetTeamNumber(), params.target:GetOrigin(), nil, self:GetAbility().modifier_spectre_8, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		damageTable.damage = damageTable.damage / #enemies_new
		for _, enemy in pairs(enemies_new) do
			damageTable.victim = enemy
			ApplyDamage(damageTable)
		end
	else
		ApplyDamage(damageTable)
	end
	self:PlayEffects( params.target, proc )
end

function modifier_spectre_desolate_custom:DamageTarget( target )
    if self.parent:IsIllusion() and self:GetCaster():HasModifier("modifier_spectre_6") then
        return
    end
	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), target:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	if not self:GetParent():HasModifier("modifier_spectre_8") then
		if #enemies>1 then return end
	end
	local bonus = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	if self:GetParent():HasModifier("modifier_spectre_12") then
		bonus = bonus + self:GetAbility().modifier_spectre_12[self:GetCaster():GetTalentLevel("modifier_spectre_12")]
	end
    if self:GetCaster():HasModifier("modifier_spectre_6") then
        bonus = bonus * 2
    end
    local attacker1 = self:GetParent()
    if attacker1:IsIllusion() then
    	attacker1 = self:GetCaster()
	end
	local damageTable = 
	{
		victim = target,
		attacker = attacker1,
		damage = bonus,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(),
	}

	local proc = false

	if self:GetParent():HasModifier("modifier_spectre_13") and RollPercentage(self:GetParent():GetEvasion() * 100) then
		proc = true
		damageTable.damage = damageTable.damage * 2
	end

	if self:GetCaster():HasModifier("modifier_spectre_8") then
		local enemies_new = FindUnitsInRadius( self:GetParent():GetTeamNumber(), target:GetOrigin(), nil, self:GetAbility().modifier_spectre_8, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		damageTable.damage = damageTable.damage / #enemies_new
		for _, enemy in pairs(enemies_new) do
			damageTable.victim = enemy
			ApplyDamage(damageTable)
		end
	else
		ApplyDamage(damageTable)
	end
	self:PlayEffects( target, proc )
end

function modifier_spectre_desolate_custom:PlayEffects( target, proc )
	local particle_target = target
	local p_name = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
	if proc then
		particle_target = self:GetParent()
		p_name = "particles/econ/items/spectre/spectre_arcana/spectre_arcana_desolate.vpcf"
	end
	local effect_cast = ParticleManager:CreateParticle( p_name, PATTACH_POINT_FOLLOW, particle_target )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 4, target:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound( "Hero_Spectre.Desolate")
end