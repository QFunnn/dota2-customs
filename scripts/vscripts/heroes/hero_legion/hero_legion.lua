--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_legion_odds_buff", "heroes/hero_legion/hero_legion", LUA_MODIFIER_MOTION_NONE)

legion_odds = class({})

function legion_odds:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_start_pos.vpcf",
		context
	)
end

function legion_odds:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local ability = self
	local radius = ability:GetSpecialValueFor("radius")
	local duration = ability:GetSpecialValueFor("duration")
	local damage = ability:GetSpecialValueFor("damage")

	local sound_cast = "Hero_LegionCommander.Overwhelming.Location"
	-- EmitSoundOnLocationForAllies(caster:GetAbsOrigin(), sound_cast, caster)
	EmitSoundOn(sound_cast, caster)

	local strike_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(strike_pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(strike_pfx, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(strike_pfx)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	if #enemies > 0 then
		local buff = caster:AddNewModifier(caster, ability, "modifier_legion_odds_buff", { duration = duration })
		if buff then
			buff:SetStackCount(#enemies)
		end
	end

	local damage_table = {
		attacker = caster,
		ability = ability,
		damage_type = ability:GetAbilityDamageType(),
		damage = damage,
	}

	for _, enemy in pairs(enemies) do
		enemy:EmitSound("Hero_LegionCommander.Overwhelming.Creep")

		if not enemy:IsMagicImmune() and not enemy:IsInvulnerable() then
			if not enemy:IsInvisible() or caster:CanEntityBeSeenByMyTeam(enemy) then
				damage_table.victim = enemy

				local strike_pfx = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_start_pos.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					enemy
				)
				ParticleManager:SetParticleControl(strike_pfx, 0, enemy:GetAbsOrigin())
				ParticleManager:SetParticleControl(strike_pfx, 1, Vector(radius, radius, radius))
				ParticleManager:ReleaseParticleIndex(strike_pfx)

				ApplyDamage(damage_table)
			end
		end
	end
end

-------------------------------------------------------------------------------

modifier_legion_odds_buff = class({})

function modifier_legion_odds_buff:IsHidden()
	return false
end

function modifier_legion_odds_buff:IsPurgable()
	return false
end

function modifier_legion_odds_buff:OnCreated(kv) end

function modifier_legion_odds_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_legion_odds_buff:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("hp_regen") * self:GetStackCount()
end

function modifier_legion_odds_buff:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("armor") * self:GetStackCount()
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_legion_press_the_attack", "heroes/hero_legion/hero_legion", LUA_MODIFIER_MOTION_NONE)

legion_press_the_attack = class({})

function legion_press_the_attack:Precache(context)
	PrecacheResource("particle", "particles/econ/items/legion/legion_fallen/legion_fallen_press.vpcf", context)
end

function legion_press_the_attack:IsHiddenWhenStolen()
	return false
end

function legion_press_the_attack:GetAOERadius()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_legion_6")
	if talent ~= nil and talent:GetLevel() > 0 then
		return self:GetSpecialValueFor("radius")
	end
	return 0
end

function legion_press_the_attack:GetBehavior()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_legion_6")
	if talent ~= nil and talent:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function legion_press_the_attack:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	caster:EmitSound("Hero_LegionCommander.PressTheAttack")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_legion_6")
	if talent ~= nil and talent:GetLevel() > 0 then
		local target_point = self:GetCursorPosition()
		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target_point,
			caster,
			radius,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO,
			0,
			0,
			false
		)
		for _, unit in pairs(units) do
			unit:Purge(false, true, false, false, false)
			unit:AddNewModifier(caster, self, "modifier_legion_press_the_attack", { duration = duration })
		end
	else
		local target = self:GetCursorTarget()
		target:Purge(false, true, false, false, false)
		target:AddNewModifier(caster, self, "modifier_legion_press_the_attack", { duration = duration })
	end
end

-------------------------------------------------------------------------------

modifier_legion_press_the_attack = class({})

function modifier_legion_press_the_attack:IsHidden()
	return false
end

function modifier_legion_press_the_attack:IsPurgable()
	return true
end

function modifier_legion_press_the_attack:IgnoreTenacity()
	return true
end

function modifier_legion_press_the_attack:OnCreated()
	if not self:GetAbility() then
		return
	end
	self.parent = self:GetParent()
	self.regen = self:GetAbility():GetSpecialValueFor("regen")
	self.attack_speed = self:GetAbility():GetSpecialValueFor("attack_speed")

	if IsServer() then
		self.particle_good_fx = ParticleManager:CreateParticle(
			"particles/econ/items/legion/legion_fallen/legion_fallen_press.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControl(self.particle_good_fx, 0, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(self.particle_good_fx, 1, self.parent:GetAbsOrigin())
		self:AddParticle(self.particle_good_fx, false, false, -1, false, false)
	end
end

function modifier_legion_press_the_attack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_legion_press_the_attack:GetModifierConstantHealthRegen()
	return self.regen
end

function modifier_legion_press_the_attack:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_legion_courage", "heroes/hero_legion/hero_legion", LUA_MODIFIER_MOTION_NONE)

legion_courage = class({})

function legion_courage:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_legion_commander/legion_commander_courage_tgt_flash.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_legion_commander/legion_commander_courage_hit.vpcf",
		context
	)
end

function legion_courage:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_legion_5")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 2
	end
	return self.BaseClass.GetCooldown(self, level)
end

function legion_courage:GetIntrinsicModifierName()
	return "modifier_legion_courage"
end

-------------------------------------------------------------------------------

modifier_legion_courage = class({})

function modifier_legion_courage:IsHidden()
	return true
end

function modifier_legion_courage:IsPurgable()
	return false
end

function modifier_legion_courage:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function modifier_legion_courage:OnAttackLanded(params)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local ability = self:GetAbility()

	if not ability or not ability:IsFullyCastable() or parent:PassivesDisabled() then
		return
	end

	if
		params.target == parent
		and not params.attacker:IsOther()
		and params.attacker:GetTeamNumber() ~= parent:GetTeamNumber()
	then
		self.chance = ability:GetSpecialValueFor("chance")
		self.lifesteal = ability:GetSpecialValueFor("lifesteal")

		if RandomInt(1, 100) <= self.chance then
			if (parent:GetAbsOrigin() - params.attacker:GetAbsOrigin()):Length2D() < 300 then
				ability:UseResources(false, false, false, true)
				self:PlayEffects()
				parent:PerformAttack(params.attacker, true, true, true, false, false, false, true)
				local damage = parent:GetAverageTrueAttackDamage(params.attacker)
				local heal = damage * (self.lifesteal / 100)
				parent:Heal(heal, ability)
				SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, parent, heal, nil)
				self:PlayEffects2(parent)
			end
		end
	end
end

function modifier_legion_courage:PlayEffects2(target)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_legion_courage:PlayEffects()
	self:GetParent():FadeGesture(ACT_DOTA_ATTACK)
	self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_CAST3_STATUE, 2.0)

	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_legion_commander/legion_commander_courage_tgt_flash.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local effect_cast2 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_legion_commander/legion_commander_courage_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast2)
	EmitSoundOn("Hero_LegionCommander.Courage", self:GetParent())
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_legion_ult", "heroes/hero_legion/hero_legion", LUA_MODIFIER_MOTION_NONE)

legion_ult = class({})

function legion_ult:GetIntrinsicModifierName()
	return "modifier_legion_ult"
end

function legion_ult:GetCooldown(level)
	return self.BaseClass.GetCooldown(self, level)
end

function legion_ult:IsRefreshable()
	return false
end

-------------------------------------------------------------------------------

modifier_legion_ult = class({})

function modifier_legion_ult:IsHidden()
	return true
end

function modifier_legion_ult:IsPurgable()
	return false
end

function modifier_legion_ult:RemoveOnDeath()
	return false
end

function modifier_legion_ult:GetTexture()
	return "legion_commander_duel"
end

function modifier_legion_ult:OnCreated(kv)
	self:StartIntervalThink(0.1)
end

function modifier_legion_ult:OnIntervalThink()
	if IsServer() and self:GetAbility() and self:GetCaster():IsRealHero() and self:GetCaster():IsAlive() then
		if self:GetAbility():IsCooldownReady() then
			self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
			self:GetAbility():UseResources(false, false, false, true)
			self:GetCaster()
				:SetModifierStackCount(
					"modifier_legion_ult",
					self:GetCaster(),
					self:GetStackCount() + self.bonus_damage
				)
		end
	end
end

function modifier_legion_ult:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_legion_ult:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end