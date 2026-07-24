--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_omniknight_purification_custom_repeat", "heroes/npc_dota_hero_omniknight_custom/omniknight_purification_custom", LUA_MODIFIER_MOTION_NONE)

omniknight_purification_custom = class({})

function omniknight_purification_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_purification_hit.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_omniknight.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_omniknight.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_omniknight.vpcf", context)
end

omniknight_purification_custom.modifier_omniknight_2_bonus_radius = {50,100}
omniknight_purification_custom.modifier_omniknight_3_cooldown = {-1,-2}
omniknight_purification_custom.modifier_omniknight_4_heal_increase_strength = {30,50,70}
omniknight_purification_custom.modifier_omniknight_1 = {15,30}

function omniknight_purification_custom:GetAOERadius()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_omniknight_2") then
		bonus = bonus + self.modifier_omniknight_2_bonus_radius[self:GetCaster():GetTalentLevel("modifier_omniknight_2")]
	end
	return self:GetSpecialValueFor( "radius" ) + bonus
end

function omniknight_purification_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_omniknight_3") then
		bonus = self.modifier_omniknight_3_cooldown[self:GetCaster():GetTalentLevel("modifier_omniknight_3")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function omniknight_purification_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_omniknight_2") then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

function omniknight_purification_custom:OnSpellStart(new_target, multiplier, new_heal_counter)
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
    if new_target then
        target = new_target
    end
	local heal = self:GetSpecialValueFor("heal")
	local radius = self:GetSpecialValueFor("radius")
	if self:GetCaster():HasModifier("modifier_omniknight_2") then
		radius = radius + self.modifier_omniknight_2_bonus_radius[self:GetCaster():GetTalentLevel("modifier_omniknight_2")]
	end
	if self:GetCaster():HasModifier("modifier_omniknight_4") then
		heal = heal + ( self:GetCaster():GetStrength() / 100 * self.modifier_omniknight_4_heal_increase_strength[self:GetCaster():GetTalentLevel("modifier_omniknight_4")])
	end
    if multiplier then
        heal = heal * multiplier
    end
    if new_heal_counter then
        heal = new_heal_counter
    end
	if self:GetCaster():HasModifier("modifier_omniknight_2") and not new_target then
		local point = self:GetCursorPosition()
		self:PlayEffects3( point, radius )
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		for _,enemy in pairs(enemies) do
			if enemy:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
				enemy:Heal( heal, self )
                enemy:AddNewModifier(self:GetCaster(), self, "modifier_omniknight_purification_custom_repeat", {duration = 3})
			else
				ApplyDamage({ attacker = caster, victim = enemy, damage = heal, damage_type = DAMAGE_TYPE_PURE, ability = self })
				self:PlayEffects2( enemy, enemy )
			end
		end
		return
	end
	target:Heal( heal, self )
	self:PlayEffects1( target, radius )
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs(enemies) do
		ApplyDamage({ attacker = caster, victim = enemy, damage = heal, damage_type = DAMAGE_TYPE_PURE, ability = self })
		self:PlayEffects2( target, enemy )
	end

    if self:GetCaster():HasModifier("modifier_omniknight_1") and not new_target then
        target:AddNewModifier(self:GetCaster(), self, "modifier_omniknight_purification_custom_repeat", {duration = 3})
    end
end

function omniknight_purification_custom:PlayEffects1( target, radius )
	local effect_target = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_target, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_target )
	
	target:EmitSound("Hero_Omniknight.Purification")

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function omniknight_purification_custom:PlayEffects3( point, radius )
	local effect_target = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_target, 0, point )
	ParticleManager:SetParticleControl( effect_target, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_target )
	
	EmitSoundOnLocationWithCaster(point, "Hero_Omniknight.Purification", self:GetCaster())

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function omniknight_purification_custom:PlayEffects2( origin, target )
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_purification_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt( particle, 0, origin, PATTACH_POINT_FOLLOW, "attach_hitloc", origin:GetOrigin(), true )
	ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( particle )
end

modifier_omniknight_purification_custom_repeat = class({})
function modifier_omniknight_purification_custom_repeat:IsPurgable() return false end
function modifier_omniknight_purification_custom_repeat:IsPurgeException() return false end
function modifier_omniknight_purification_custom_repeat:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_omniknight_purification_custom_repeat:OnCreated(params)
    if not IsServer() then return end
    self.new_heal = params.new_heal
end
function modifier_omniknight_purification_custom_repeat:GetEffectName()
    return "particles/units/heroes/hero_omniknight/omniknight_purification_recast_marker.vpcf"
end
function modifier_omniknight_purification_custom_repeat:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end
function modifier_omniknight_purification_custom_repeat:OnDestroy()
    if not IsServer() then return end
    if self:GetParent():IsAlive() then
        self:GetAbility():OnSpellStart(self:GetParent(), self:GetAbility().modifier_omniknight_1[self:GetCaster():GetTalentLevel("modifier_omniknight_1")] / 100, self.new_heal)
    end
end