--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_drow_ranger_marksmanship_lua_effect = class({})

--------------------------------------------------------------------------------
function modifier_drow_ranger_marksmanship_lua_effect:IsHidden()
	return false
end
function modifier_drow_ranger_marksmanship_lua_effect:IsDebuff()
	return false
end
function modifier_drow_ranger_marksmanship_lua_effect:IsPurgable()
	return false
end
function modifier_drow_ranger_marksmanship_lua_effect:GetPriority()
	return MODIFIER_PRIORITY_LOW
end

function modifier_drow_ranger_marksmanship_lua_effect:OnCreated(kv)
	self.chance = self:GetAbility():GetSpecialValueFor("chance")
	self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.disable = self:GetAbility():GetSpecialValueFor("disable_range")
	self.radius = self:GetAbility():GetSpecialValueFor("aura_radius")
	self.agilityBonusMult = self:GetAbility():GetSpecialValueFor("agility_bonus_pct") / 100
	self.split_range = self:GetAbility():GetSpecialValueFor("scepter_range")
	self.split_count = self:GetAbility():GetSpecialValueFor("split_count_scepter")
	self.split_damage = self:GetAbility():GetSpecialValueFor("damage_reduction_scepter")

	self.active = true

	if not IsServer() then
		return
	end

	self.records = {}
	self.procs = false

	-- precache splinter
	self.info = {
		-- Target = target,
		-- Source = self:GetParent(),
		Ability = self:GetAbility(),

		EffectName = self:GetParent():GetRangedProjectileName(),
		iMoveSpeed = self:GetParent():GetProjectileSpeed(),
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,

		bDodgeable = true, -- Optional
		bIsAttack = true, -- Optional

		ExtraData = {},
	}

	self:StartIntervalThink(0.1)

	-- play effects
	self:PlayEffects1()
end

function modifier_drow_ranger_marksmanship_lua_effect:OnRefresh(kv)
	-- references
	self.chance = self:GetAbility():GetSpecialValueFor("chance")
	self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.disable = self:GetAbility():GetSpecialValueFor("disable_range")
	self.radius = self:GetAbility():GetSpecialValueFor("aura_radius")
	self.agilityBonusMult = self:GetAbility():GetSpecialValueFor("agility_bonus_pct") / 100
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_drow_ranger_marksmanship_lua_effect:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,

		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,

		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

modifier_drow_ranger_marksmanship_lua_effect.OnTooltip = Debounce(0.1, function(self)
	local agility = self:GetCaster():GetAgility()

	return math.floor(agility * (1 / (1 + self.agilityBonusMult)) * self.agilityBonusMult)
end)

modifier_drow_ranger_marksmanship_lua_effect.GetModifierBonusStats_Agility = Debounce(0.1, function(self)
	if self.agiLock then
		return
	end

	local caster, parent = self:GetCaster(), self:GetParent()

	if caster ~= parent then
		return
	end

	self.agiLock = true
	local bonus = math.floor(caster:GetAgility() * self.agilityBonusMult)
	self.agiLock = false

	return bonus
end)

function modifier_drow_ranger_marksmanship_lua_effect:GetModifierProcAttack_BonusDamage_Physical(params)
	if IsServer() then
		-- fail if target is invalid
		if params.target:IsBuilding() or params.target:IsOther() then
			return 0
		end

		-- fail if status is invalid
		if self:GetParent():IsIllusion() or self:GetParent():PassivesDisabled() then
			return 0
		end

		if self:RollChance(self.chance) then
			self.record = params.record

			return self.damage
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations

--------------------------------------------------------------------------------
-- Helper
function modifier_drow_ranger_marksmanship_lua_effect:RollChance(chance)
	local rand = math.random()
	if rand < chance / 100 then
		return true
	end
	return false
end

function modifier_drow_ranger_marksmanship_lua_effect:GetModifierProjectileName(params)
	if not IsServer() then
		return
	end
	if params.record ~= self.record then
		return
	end

	return "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
end

function modifier_drow_ranger_marksmanship_lua_effect:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end

	local abil = self:GetCaster():FindAbilityByName("special_bonus_unique_drow_ranger_3")
	if abil == nil or abil:GetLevel() == 0 then
		return
	end

	-- check if this is split shot
	if self:GetAbility().split then
		return
	end

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(), -- int, your team number
		params.target:GetOrigin(), -- point, center point
		params.target, -- handle, cacheUnit. (not known)
		self.split_range, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, -- int, flag filter
		FIND_CLOSEST, -- int, order filter
		false -- bool, can grow cache
	)

	local count = 0
	for _, enemy in pairs(enemies) do
		if enemy ~= params.target and count < self.split_count then
			-- roll pierce armor chance
			local procs = false
			local rand = RandomInt(0, 100)
			if self.active and rand <= self.chance then
				procs = true
			end

			-- launch projectile
			self.info.Target = enemy
			self.info.Source = params.target
			if procs then
				self.info.EffectName = "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
				self.info.ExtraData = {
					procs = true,
				}
			else
				self.info.EffectName = self:GetParent():GetRangedProjectileName()
				self.info.ExtraData = {
					procs = false,
				}
			end
			ProjectileManager:CreateTrackingProjectile(self.info)

			count = count + 1
		end
	end
end

function modifier_drow_ranger_marksmanship_lua_effect:GetModifierDamageOutgoing_Percentage()
	if not IsServer() then
		return
	end

	-- check if split shot
	if not self:GetAbility().split then
		return
	end

	return -self.split_damage
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_drow_ranger_marksmanship_lua_effect:OnIntervalThink()
	-- check for enemy
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(), -- int, your team number
		self:GetParent():GetOrigin(), -- point, center point
		self:GetParent(), -- handle, cacheUnit. (not known)
		self.disable, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS
			+ DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO
			+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE
			+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	local no_enemies = #enemies == 0

	-- check if change state
	if self.active ~= no_enemies then
		self:PlayEffects2(no_enemies)
		self.active = no_enemies
	end
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_drow_ranger_marksmanship_lua_effect:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_drow/drow_marksmanship.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())

	-- set glowing
	ParticleManager:SetParticleControl(self.effect_cast, 2, Vector(2, 0, 0))

	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	self:PlayEffects2(true)
end

function modifier_drow_ranger_marksmanship_lua_effect:PlayEffects2(start)
	-- turn on/off cold effect
	local state = 1
	if start then
		state = 2
	end
	ParticleManager:SetParticleControl(self.effect_cast, 2, Vector(state, 0, 0))

	-- play start effect
	if not start then
		return
	end

	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_drow/drow_marksmanship_start.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end