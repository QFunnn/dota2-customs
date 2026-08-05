--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_hero_destroyer_totem_thinker",
	"heroes/hero_destroyer/hero_destroyer",
	LUA_MODIFIER_MOTION_NONE
)

hero_destroyer_totem = class({})

function hero_destroyer_totem:Precache(context)
	PrecacheResource("particle", "particles/destr.vpcf", context)
end

function hero_destroyer_totem:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function hero_destroyer_totem:OnSpellStart()
	self.position = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")
	local center = CreateModifierThinker(
		self:GetCaster(),
		self,
		"modifier_hero_destroyer_totem_thinker",
		{ duration = duration + 0.2 },
		self.position,
		self:GetCaster():GetTeamNumber(),
		false
	)
	self:PlayEffects(self.position, duration)
end

function hero_destroyer_totem:PlayEffects(point, duration)
	local sound_cast = "Hero_EarthShaker.Attack"
	-- EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

---------------------------------------------------------------------------------

modifier_hero_destroyer_totem_thinker = class({})

function modifier_hero_destroyer_totem_thinker:IsHidden()
	return false
end

function modifier_hero_destroyer_totem_thinker:IsPurgable()
	return false
end

function modifier_hero_destroyer_totem_thinker:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.position = self:GetParent():GetAbsOrigin()
	local effect_cast = ParticleManager:CreateParticle("particles/destr.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, self.position)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(450, 0, 0))
	self:StartIntervalThink(0.1)
end

function modifier_hero_destroyer_totem_thinker:OnIntervalThink()
	if not IsServer() then
		return
	end

	local ability = self:GetAbility()
	local regen = ability:GetSpecialValueFor("regen")
	local damage_str = ability:GetSpecialValueFor("damage_str")
	local damage_base = ability:GetSpecialValueFor("damage")
	local try_damage = self:GetCaster():GetStrength() * damage_str / 100 + damage_base
	local radius = ability:GetSpecialValueFor("radius")

	local all_units = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self.position,
		self:GetParent(),
		radius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
	for _, unit in pairs(all_units) do
		if unit:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
			unit:Heal(unit:GetMaxHealth() / 100 * regen, ability)
			SendOverheadEventMessage(
				unit:GetPlayerOwner(),
				OVERHEAD_ALERT_HEAL,
				unit,
				unit:GetMaxHealth() / 100 * regen,
				nil
			)
		else
			local damageTable = {
				victim = unit,
				attacker = self:GetCaster(),
				damage = try_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
				ability,
			}
			ApplyDamage(damageTable)

			unit:AddNewModifier(self:GetCaster(), ability, "modifier_knockback", {
				center_x = self.position[1] + 1,
				center_y = self.position[2] + 1,
				center_z = self.position[3],
				duration = 0.4 * (1 - unit:GetStatusResistance()),
				knockback_duration = 0.4 * (1 - unit:GetStatusResistance()),
				knockback_distance = 50,
				knockback_height = 0,
				should_stun = 0,
			})
		end
	end

	ShieldParticle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sandking/sandking_epicenter.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(ShieldParticle, 1, Vector(radius + 150, 0, radius + 150))
	ParticleManager:SetParticleControlEnt(
		ShieldParticle,
		0,
		nil,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.position,
		true
	)
	-- EmitSoundOnLocationWithCaster(self.position, "Hero_EarthShaker.Arcana.run_alt1", self:GetCaster() )

	local sound_cast = "Hero_EarthShaker.Attack"
	-- EmitSoundOnLocationWithCaster(self.position, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())

	self:StartIntervalThink(-1)
	self:StartIntervalThink(1)
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_hero_destroyer_second_skill_armor",
	"heroes/hero_destroyer/hero_destroyer",
	LUA_MODIFIER_MOTION_NONE
)

hero_destroyer_second_skill_armor = class({})

function hero_destroyer_second_skill_armor:GetIntrinsicModifierName()
	return "modifier_hero_destroyer_second_skill_armor"
end

function hero_destroyer_second_skill_armor:OnSpellStart()
	self.level = self:GetLevel()
	self:GetCaster():AddAbility("hero_destroyer_second_skill_resist"):SetLevel(self.level)
	self:GetCaster()
		:SwapAbilities("hero_destroyer_second_skill_armor", "hero_destroyer_second_skill_resist", true, true)
	self:GetCaster():RemoveAbility("hero_destroyer_second_skill_armor")
end

-------------------------------------------------------------------------------------------

modifier_hero_destroyer_second_skill_armor = class({})

function modifier_hero_destroyer_second_skill_armor:IsHidden()
	return false
end

function modifier_hero_destroyer_second_skill_armor:IsPurgable()
	return false
end

function modifier_hero_destroyer_second_skill_armor:OnCreated(kv)
	self.armor = self:GetAbility():GetSpecialValueFor("armor")
	self.crit_damage = self:GetAbility():GetSpecialValueFor("crit_damage")
	self.crit_chance = self:GetAbility():GetSpecialValueFor("crit_chance")
end

function modifier_hero_destroyer_second_skill_armor:OnRefresh(kv)
	self.armor = self:GetAbility():GetSpecialValueFor("armor")
	self.crit_damage = self:GetAbility():GetSpecialValueFor("crit_damage")
	self.crit_chance = self:GetAbility():GetSpecialValueFor("crit_chance")
end

function modifier_hero_destroyer_second_skill_armor:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_hero_destroyer_second_skill_armor:GetModifierPhysicalArmorBonus()
	if not self:GetParent():PassivesDisabled() then
		return self.armor
	end
end

function modifier_hero_destroyer_second_skill_armor:GetModifierPreAttack_CriticalStrike(params)
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then
			return
		end
		if RandomInt(0, 100) < self.crit_chance then
			self.record = params.record
			return self.crit_damage
		end
	end
end

function modifier_hero_destroyer_second_skill_armor:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		if self.record and self.record == params.record then
			self.record = nil
		end
	end
end

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_hero_destroyer_second_skill_hp",
	"heroes/hero_destroyer/hero_destroyer",
	LUA_MODIFIER_MOTION_NONE
)

hero_destroyer_second_skill_hp = class({})

function hero_destroyer_second_skill_hp:GetIntrinsicModifierName()
	return "modifier_hero_destroyer_second_skill_hp"
end

function hero_destroyer_second_skill_hp:OnSpellStart()
	self.level = self:GetLevel()
	self:GetCaster():AddAbility("hero_destroyer_second_skill_armor"):SetLevel(self.level)
	self:GetCaster():SwapAbilities("hero_destroyer_second_skill_hp", "hero_destroyer_second_skill_armor", true, true)
	self:GetCaster():RemoveAbility("hero_destroyer_second_skill_hp")
end

-------------------------------------------------------------------------------------------

modifier_hero_destroyer_second_skill_hp = class({})

function modifier_hero_destroyer_second_skill_hp:IsHidden()
	return false
end

function modifier_hero_destroyer_second_skill_hp:IsPurgable()
	return false
end

function modifier_hero_destroyer_second_skill_hp:OnCreated(kv)
	self.regen = self:GetAbility():GetSpecialValueFor("regen")
	self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal")
end

function modifier_hero_destroyer_second_skill_hp:OnRefresh(kv)
	self.regen = self:GetAbility():GetSpecialValueFor("regen")
	self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal")
end

function modifier_hero_destroyer_second_skill_hp:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
	return funcs
end

function modifier_hero_destroyer_second_skill_hp:GetModifierHealthRegenPercentage()
	if not self:GetParent():PassivesDisabled() then
		return self.regen
	end
end

function modifier_hero_destroyer_second_skill_hp:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		local pass = false
		if params.target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
			if (not params.target:IsBuilding()) and (not params.target:IsOther()) then
				pass = true
			end
		end

		if pass then
			self.attack_record = params.record
		end
	end
end

function modifier_hero_destroyer_second_skill_hp:OnTakeDamage(params)
	if IsServer() then
		local pass = false
		if self.attack_record and params.record == self.attack_record then
			pass = true
			self.attack_record = nil
		end

		if pass then
			local heal = params.damage * self.lifesteal / 100
			self:GetParent():Heal(heal, self:GetAbility())
			self:PlayEffects(self:GetParent())
		end
	end
end

function modifier_hero_destroyer_second_skill_hp:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_hero_destroyer_second_skill_resist",
	"heroes/hero_destroyer/hero_destroyer",
	LUA_MODIFIER_MOTION_NONE
)

hero_destroyer_second_skill_resist = class({})

function hero_destroyer_second_skill_resist:GetIntrinsicModifierName()
	return "modifier_hero_destroyer_second_skill_resist"
end

function hero_destroyer_second_skill_resist:OnSpellStart()
	self.level = self:GetLevel()
	self:GetCaster():AddAbility("hero_destroyer_second_skill_hp"):SetLevel(self.level)
	self:GetCaster():SwapAbilities("hero_destroyer_second_skill_resist", "hero_destroyer_second_skill_hp", true, true)
	self:GetCaster():RemoveAbility("hero_destroyer_second_skill_resist")
end

-------------------------------------------------------------------------------------------

modifier_hero_destroyer_second_skill_resist = class({})

function modifier_hero_destroyer_second_skill_resist:IsHidden()
	return false
end

function modifier_hero_destroyer_second_skill_resist:IsPurgable()
	return false
end

function modifier_hero_destroyer_second_skill_resist:OnCreated(kv)
	self.resist = self:GetAbility():GetSpecialValueFor("resist")
	self.spell_amp = self:GetAbility():GetSpecialValueFor("spell_amp")
end

function modifier_hero_destroyer_second_skill_resist:OnRefresh(kv)
	self.resist = self:GetAbility():GetSpecialValueFor("resist")
	self.spell_amp = self:GetAbility():GetSpecialValueFor("spell_amp")
end

function modifier_hero_destroyer_second_skill_resist:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
	return funcs
end

function modifier_hero_destroyer_second_skill_resist:GetModifierMagicalResistanceBonus()
	if not self:GetParent():PassivesDisabled() then
		return self.resist
	end
end

function modifier_hero_destroyer_second_skill_resist:GetModifierSpellAmplify_Percentage()
	if not self:GetParent():PassivesDisabled() then
		return self.spell_amp
	end
end

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_hero_destroyer_third_skill", "heroes/hero_destroyer/hero_destroyer", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_hero_destroyer_third_skill_debuff",
	"heroes/hero_destroyer/hero_destroyer",
	LUA_MODIFIER_MOTION_NONE
)

hero_destroyer_third_skill = class({})

function hero_destroyer_third_skill:GetIntrinsicModifierName()
	return "modifier_hero_destroyer_third_skill"
end

-----------------------------------------------------------------------

modifier_hero_destroyer_third_skill = class({})

function modifier_hero_destroyer_third_skill:IsHidden()
	return true
end

function modifier_hero_destroyer_third_skill:IsPurgable()
	return false
end

function modifier_hero_destroyer_third_skill:DestroyOnExpire()
	return false
end

function modifier_hero_destroyer_third_skill:RemoveOnDeath()
	return false
end

function modifier_hero_destroyer_third_skill:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_hero_destroyer_third_skill:GetModifierIncomingDamage_Percentage(params)
	return self.incom
end

function modifier_hero_destroyer_third_skill:OnAttackLanded(keys)
	if not IsServer() then
		return
	end

	local ability = self:GetAbility()
	local block = ability:GetSpecialValueFor("incom_damage")

	if keys.target == self:GetParent() and keys.attacker:HasModifier("modifier_hero_destroyer_third_skill_debuff") then
		self.incom = -1 * block
	else
		self.incom = 0
	end

	if
		self:GetParent() == keys.attacker
		and keys.attacker:GetTeamNumber() ~= keys.target:GetTeamNumber()
		and not self:GetParent():PassivesDisabled()
	then
		local damage = keys.original_damage
		local particle_cast = "particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf"

		local direction = keys.target:GetOrigin() - self:GetParent():GetOrigin()
		direction.z = 0
		direction = direction:Normalized()
		local range = self:GetParent():GetOrigin() + direction * 400 / 2

		local enemies = FindUnitsInCone(
			self:GetParent():GetTeamNumber(),
			keys.target:GetOrigin(),
			self:GetParent():GetOrigin(),
			range,
			150,
			360,
			nil,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_CLOSEST,
			false
		)
		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(
				self:GetParent(),
				ability,
				"modifier_hero_destroyer_third_skill_debuff",
				{ duration = ability:GetSpecialValueFor("duration") }
			)
			if keys.target ~= enemy then
				ApplyDamage({
					victim = enemy,
					attacker = self:GetParent(),
					damage = damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
					damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
						+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
					ability = ability,
				})
			end
		end
		self:PlayEffects1(direction)
	end
end

function modifier_hero_destroyer_third_skill:PlayEffects1(direction)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function FindUnitsInCone(
	nTeamNumber,
	vCenterPos,
	vStartPos,
	vEndPos,
	fStartRadius,
	fEndRadius,
	hCacheUnit,
	nTeamFilter,
	nTypeFilter,
	nFlagFilter,
	nOrderFilter,
	bCanGrowCache
)
	local direction = vEndPos - vStartPos
	direction.z = 0

	local distance = direction:Length2D()
	direction = direction:Normalized()

	local big_radius = distance + math.max(fStartRadius, fEndRadius)

	local units = FindUnitsInRadius(
		nTeamNumber, -- int, your team number
		vCenterPos, -- point, center point
		nil, -- handle, cacheUnit. (not known)
		big_radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		nTeamFilter, -- int, team filter
		nTypeFilter, -- int, type filter
		nFlagFilter, -- int, flag filter
		nOrderFilter, -- int, order filter
		bCanGrowCache -- bool, can grow cache
	)

	local targets = {}
	for _, unit in pairs(units) do
		local vUnitPos = unit:GetOrigin() - vStartPos
		local fProjection = vUnitPos.x * direction.x + vUnitPos.y * direction.y + vUnitPos.z * direction.z
		fProjection = math.max(math.min(fProjection, distance), 0)
		local vProjection = direction * fProjection
		local fUnitRadius = (vUnitPos - vProjection):Length2D()
		local fInterpRadius = (fProjection / distance) * (fEndRadius - fStartRadius) + fStartRadius
		if fUnitRadius <= fInterpRadius then
			table.insert(targets, unit)
		end
	end
	return targets
end

-------------------------------------------------------------------------------------------

modifier_hero_destroyer_third_skill_debuff = class({})

function modifier_hero_destroyer_third_skill_debuff:IsHidden()
	return false
end
function modifier_hero_destroyer_third_skill_debuff:IsDebuff()
	return true
end
function modifier_hero_destroyer_third_skill_debuff:IsPurgable()
	return true
end

function modifier_hero_destroyer_third_skill_debuff:OnCreated(kv) end

function modifier_hero_destroyer_third_skill_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_hero_destroyer_third_skill_debuff:GetModifierPhysicalArmorBonus()
	return -self:GetAbility():GetSpecialValueFor("dis_arm")
end

function modifier_hero_destroyer_third_skill_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("slow_as")
end

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_hero_destroyer_overkill", "heroes/hero_destroyer/hero_destroyer", LUA_MODIFIER_MOTION_NONE)

hero_destroyer_overkill = class({})

function hero_destroyer_overkill:GetIntrinsicModifierName()
	return "modifier_hero_destroyer_overkill"
end

--------------------------------------------------------------------------------

modifier_hero_destroyer_overkill = class({})

function modifier_hero_destroyer_overkill:IsHidden()
	return true
end

function modifier_hero_destroyer_overkill:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_hero_destroyer_overkill:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() or params.unit == self:GetParent() then
		return
	end

	local target = params.unit
	local damage_dealt = params.damage
	local current_health = target:GetHealth()

	if current_health <= 0 then
		local overkill_damage = damage_dealt
		local radius = self:GetAbility():GetSpecialValueFor("radius")
		local multiplier = self:GetAbility():GetSpecialValueFor("damage_mult")
		local final_aoe_damage = overkill_damage * multiplier

		local particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_physical.vpcf",
			PATTACH_ABSORIGIN,
			target
		)
		ParticleManager:SetParticleControl(particle, 1, Vector(radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle)

		target:EmitSound("Hero_ElderTitan.Attack")

		local enemies = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),
			target:GetAbsOrigin(),
			target,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(enemies) do
			if enemy ~= target then
				ApplyDamage({
					victim = enemy,
					attacker = self:GetParent(),
					damage = final_aoe_damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
					damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
					ability = self:GetAbility(),
				})
			end
		end
	end
end

-------------------------------------------------------------------
-------------------------------------------------------------------