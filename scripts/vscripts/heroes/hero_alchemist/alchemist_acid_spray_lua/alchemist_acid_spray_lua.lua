--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_alchemist_acid_spray_lua",
	"heroes/hero_alchemist/alchemist_acid_spray_lua/alchemist_acid_spray_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_acid_spray_lua_slow",
	"heroes/hero_alchemist/alchemist_acid_spray_lua/alchemist_acid_spray_lua",
	LUA_MODIFIER_MOTION_NONE
)

alchemist_acid_spray_lua = class({})

function alchemist_acid_spray_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function alchemist_acid_spray_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_alchemist_acid_spray_lua", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
end

-------------------------------------------------------------------------------

modifier_alchemist_acid_spray_lua = class({})

function modifier_alchemist_acid_spray_lua:IsHidden()
	return false
end

function modifier_alchemist_acid_spray_lua:IsDebuff()
	return true
end

function modifier_alchemist_acid_spray_lua:IsStunDebuff()
	return false
end

function modifier_alchemist_acid_spray_lua:IsPurgable()
	return false
end

function modifier_alchemist_acid_spray_lua:OnCreated(kv)
	local interval = self:GetAbility():GetSpecialValueFor("tick_rate")
	local damage = self:GetAbility():GetSpecialValueFor("damage")
	self.armor = -self:GetAbility():GetSpecialValueFor("armor_reduction")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_alchemist_agi2")
	if talent and talent:GetLevel() > 0 then
		self.armor = -self:GetAbility():GetSpecialValueFor("armor_reduction") - 2
	end

	self.thinker = kv.isProvidedByAura ~= 1

	if not IsServer() then
		return
	end
	if not self.thinker then
		return
	end

	self.damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	self:StartIntervalThink(interval)
	self.sound_cast = "Hero_Alchemist.AcidSpray.Damage"
	self:PlayEffects()
end

function modifier_alchemist_acid_spray_lua:OnRefresh(kv) end

function modifier_alchemist_acid_spray_lua:OnRemoved() end

function modifier_alchemist_acid_spray_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.thinker then
		return
	end

	UTIL_Remove(self:GetParent())
end

function modifier_alchemist_acid_spray_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_alchemist_acid_spray_lua:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_alchemist_acid_spray_lua:OnIntervalThink()
	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(), -- int, your team number
		self:GetParent():GetOrigin(), -- point, center point
		self:GetParent(), -- handle, cacheUnit. (not known)
		self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		0, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	for _, enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)

		local talent = self:GetCaster():FindAbilityByName("special_bonus_alchemist_agi5")
		if talent and talent:GetLevel() > 0 then
			enemy:AddNewModifier(
				self:GetCaster(), -- player source
				self:GetAbility(), -- ability source
				"modifier_alchemist_acid_spray_lua_slow", -- modifier name
				{ duration = 1 } -- kv
			)
		end

		EmitSoundOn(self.sound_cast, enemy)
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_alchemist_acid_spray_lua:IsAura()
	return self.thinker
end

function modifier_alchemist_acid_spray_lua:GetModifierAura()
	return "modifier_alchemist_acid_spray_lua"
end

function modifier_alchemist_acid_spray_lua:GetAuraRadius()
	return self.radius
end

function modifier_alchemist_acid_spray_lua:GetAuraDuration()
	return 0.5
end

function modifier_alchemist_acid_spray_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_alchemist_acid_spray_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_alchemist_acid_spray_lua:GetAuraSearchFlags()
	return 0
end

function modifier_alchemist_acid_spray_lua:GetEffectName()
	return "particles/units/heroes/hero_alchemist/alchemist_acid_spray_debuff.vpcf"
end

function modifier_alchemist_acid_spray_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_alchemist_acid_spray_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf"
	local sound_cast = "Hero_Alchemist.AcidSpray"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn(sound_cast, self:GetParent())
end

-----------------------------------------------------------------

modifier_alchemist_acid_spray_lua_slow = class({})

function modifier_alchemist_acid_spray_lua_slow:IsHidden()
	return false
end

function modifier_alchemist_acid_spray_lua_slow:IsDebuff()
	return false
end

function modifier_alchemist_acid_spray_lua_slow:IsPurgable()
	return true
end

function modifier_alchemist_acid_spray_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_alchemist_acid_spray_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -25
end