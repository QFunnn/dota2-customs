--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


skywrath_mage_mystic_flare_custom = class({})

LinkLuaModifier( "modifier_skywrath_mage_mystic_flare_custom_thinker", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_mystic_flare_custom_thinker_slow", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE )


skywrath_mage_mystic_flare_custom.modifier_skywrath_mage_19_slow = {-15,-30,-45}
skywrath_mage_mystic_flare_custom.modifier_skywrath_mage_20_duration = {0.5,1,1.5}
skywrath_mage_mystic_flare_custom.modifier_skywrath_mage_22_cooldown = 0
skywrath_mage_mystic_flare_custom.modifier_skywrath_mage_15 = 90

function skywrath_mage_mystic_flare_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf", context )
end

function skywrath_mage_mystic_flare_custom:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function skywrath_mage_mystic_flare_custom:GetCooldown(level)
	local cooldown = self.BaseClass.GetCooldown( self, level )
	if self:GetCaster():HasModifier("modifier_skywrath_mage_22") then
		cooldown = cooldown - self.modifier_skywrath_mage_22_cooldown
	end
    return cooldown
end

function skywrath_mage_mystic_flare_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_skywrath_mage_15") then
        return self.BaseClass.GetManaCost(self, level) * (1 - (self.modifier_skywrath_mage_15 / 100))
    end
    local manacost = self.BaseClass.GetManaCost(self, level)
    return manacost
end

function skywrath_mage_mystic_flare_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_skywrath_mage_21") then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_AUTOCAST
	end
	return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function skywrath_mage_mystic_flare_custom:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor( "duration" )
	local radius = self:GetSpecialValueFor( "radius" )

	if point == self:GetCaster():GetAbsOrigin() then
		point = point + self:GetCaster():GetForwardVector()
	end

	if self:GetCaster():HasModifier("modifier_skywrath_mage_20") then
		duration = duration + self.modifier_skywrath_mage_20_duration[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_20")]
	end

	if self:GetCaster():HasModifier("modifier_skywrath_mage_21") then
		local forward_vector = (point - self:GetCaster():GetAbsOrigin())
		forward_vector.z = 0
		forward_vector = forward_vector:Normalized()

		local end_point = self:GetCaster():GetAbsOrigin() + forward_vector * (self:GetCastRange(self:GetCaster():GetAbsOrigin(), self:GetCaster()) + self:GetCaster():GetCastRangeBonus())

		local start_point = self:GetCaster():GetAbsOrigin()

		local count = (end_point - start_point):Length2D() / (radius * 1.9)

		for i = 0, count do
			local origin = start_point + forward_vector * ( (radius * 1.9) * i )
			CreateModifierThinker( caster, self, "modifier_skywrath_mage_mystic_flare_custom_thinker", { duration = duration, real_duration = self:GetSpecialValueFor( "duration" ) }, origin, caster:GetTeamNumber(), false )
			caster:EmitSound("Hero_SkywrathMage.MysticFlare.Cast")
		end

		if not self:GetAutoCastState() and not self:GetCaster():IsRooted() and not self:GetCaster():IsCustomHasTethered() then
			FindClearSpaceForUnit(self:GetCaster(), point, true)
		end

		return
	end

	CreateModifierThinker( caster, self, "modifier_skywrath_mage_mystic_flare_custom_thinker", { duration = duration, real_duration = self:GetSpecialValueFor( "duration" ) }, point, caster:GetTeamNumber(), false )

	caster:EmitSound("Hero_SkywrathMage.MysticFlare.Cast")

	if caster:HasScepter() then
		local scepter_radius = self:GetSpecialValueFor( "scepter_radius" )
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), point, nil, scepter_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false )

		local target = nil
		local creep = nil

		for _,enemy in pairs(enemies) do
			if (enemy:GetOrigin()-point):Length2D() > radius then
				if enemy:IsHero() then
					target = enemy
					break
				elseif not creep then
					creep = enemy
				end
			end
		end

		if not target then
			target = creep
		end

		if target then
			CreateModifierThinker( caster, self, "modifier_skywrath_mage_mystic_flare_custom_thinker", { duration = duration, real_duration = self:GetSpecialValueFor( "duration" ) }, target:GetOrigin(), caster:GetTeamNumber(), false )
		end
	end
end

modifier_skywrath_mage_mystic_flare_custom_thinker = class({})

function modifier_skywrath_mage_mystic_flare_custom_thinker:OnCreated( kv )
	local interval = self:GetAbility():GetSpecialValueFor( "damage_interval" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if IsServer() then
		self.damage = self.damage * interval / kv.real_duration

		self.damageTable = 
		{
			attacker = self:GetCaster(),
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(),
		}

		self:StartIntervalThink( interval )
		self:OnIntervalThink()
		self:PlayEffects( self.radius, kv.duration, interval )
	end
end

function modifier_skywrath_mage_mystic_flare_custom_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_skywrath_mage_mystic_flare_custom_thinker:OnIntervalThink()
	local heroes = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	
	if #heroes<1 then return end

	for _,hero in pairs(heroes) do
		self.damageTable.victim = hero
		self.damageTable.damage = self.damage/#heroes
		ApplyDamage( self.damageTable )
	end
end

function modifier_skywrath_mage_mystic_flare_custom_thinker:PlayEffects( radius, duration, interval )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0 , self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, duration, interval ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetParent():EmitSound("Hero_SkywrathMage.MysticFlare")
end

function modifier_skywrath_mage_mystic_flare_custom_thinker:IsAura() return self:GetCaster():HasModifier("modifier_skywrath_mage_19") end
function modifier_skywrath_mage_mystic_flare_custom_thinker:IsAuraActiveOnDeath() return false end
function modifier_skywrath_mage_mystic_flare_custom_thinker:GetAuraDuration() return 0.1 end
function modifier_skywrath_mage_mystic_flare_custom_thinker:GetAuraRadius() return self.radius end
function modifier_skywrath_mage_mystic_flare_custom_thinker:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_skywrath_mage_mystic_flare_custom_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_skywrath_mage_mystic_flare_custom_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_ALL end
function modifier_skywrath_mage_mystic_flare_custom_thinker:GetModifierAura() return "modifier_skywrath_mage_mystic_flare_custom_thinker_slow" end

modifier_skywrath_mage_mystic_flare_custom_thinker_slow = class({})

function modifier_skywrath_mage_mystic_flare_custom_thinker_slow:GetTexture() return "skywrath_mage_19" end

function modifier_skywrath_mage_mystic_flare_custom_thinker_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_skywrath_mage_mystic_flare_custom_thinker_slow:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility().modifier_skywrath_mage_19_slow[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_19")]
end