--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_treant_natures_grasp_lua_creation_thinker",
	"heroes/hero_treant/hero_treant",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_treant_natures_grasp_lua_damage", "heroes/hero_treant/hero_treant", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_treant_natures_grasp_lua_damage_bonus",
	"heroes/hero_treant/hero_treant",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_treant_natures_grasp_lua_latch_thinker",
	"heroes/hero_treant/hero_treant",
	LUA_MODIFIER_MOTION_NONE
)

LinkLuaModifier("modifier_treant_leech_seed_lua", "heroes/hero_treant/hero_treant", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_treant_leech_seed_lua_slow", "heroes/hero_treant/hero_treant", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_treant_living_armor_lua", "heroes/hero_treant/hero_treant", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_treant_overgrowth_lua", "heroes/hero_treant/hero_treant", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_treant_overgrowth_lua_giant_ent", "heroes/hero_treant/hero_treant", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_treant_living_armor_lua_passive", "heroes/hero_treant/hero_treant", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_treant_living_armor_lua_passive_effect",
	"heroes/hero_treant/hero_treant",
	LUA_MODIFIER_MOTION_NONE
)

treant_natures_grasp_lua = treant_natures_grasp_lua or class({})
modifier_treant_natures_grasp_lua_creation_thinker = modifier_treant_natures_grasp_lua_creation_thinker or class({})
modifier_treant_natures_grasp_lua_damage = modifier_treant_natures_grasp_lua_damage or class({})
modifier_treant_natures_grasp_lua_damage_bonus = modifier_treant_natures_grasp_lua_damage_bonus or class({})
modifier_treant_natures_grasp_lua_latch_thinker = modifier_treant_natures_grasp_lua_latch_thinker or class({})

treant_leech_seed_lua = treant_leech_seed_lua or class({})
modifier_treant_leech_seed_lua = modifier_treant_leech_seed_lua or class({})
modifier_treant_leech_seed_lua_slow = modifier_treant_leech_seed_lua_slow or class({})

treant_living_armor_lua = treant_living_armor_lua or class({})
modifier_treant_living_armor_lua = modifier_treant_living_armor_lua or class({})

treant_overgrowth_lua = treant_overgrowth_lua or class({})
modifier_treant_overgrowth_lua = modifier_treant_overgrowth_lua or class({})
modifier_treant_overgrowth_lua_giant_ent = modifier_treant_overgrowth_lua_giant_ent or class({})

----------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------ treant_natures_grasp_lua --------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------

function treant_natures_grasp_lua:OnSpellStart()
	local cast_position = self:GetCaster():GetAbsOrigin()
	local cursor_position = self:GetCursorPosition()
	local unique_string = DoUniqueString(self:GetName())
	local thicket_thinker = nil

	if cursor_position == cast_position then
		cursor_position = cursor_position + self:GetCaster():GetForwardVector()
	end

	if not self.thinker_tracker then
		self.thinker_tracker = {}
	end

	self:GetCaster():EmitSound("Hero_Treant.NaturesGrasp.Cast")

	for thicket = 1, math.floor(
		(self:GetCastRange(cursor_position, self:GetCaster()) - 100) / self:GetSpecialValueFor("vine_spawn_interval")
	) do
		self:GetCaster():SetContextThink(DoUniqueString("grasp_thinker"), function()
			thicket_thinker = CreateModifierThinker(
				self:GetCaster(),
				self,
				"modifier_treant_natures_grasp_lua_creation_thinker",
				{
					duration = self:GetSpecialValueFor("vines_duration"),
					unique_string = unique_string,
				},
				GetGroundPosition(
					cast_position
						+ (cursor_position - cast_position):Normalized()
							* (100 + (self:GetSpecialValueFor("vine_spawn_interval") * (thicket - 1))),
					nil
				),
				self:GetCaster():GetTeamNumber(),
				false
			)

			thicket_thinker:EmitSound("Hero_Treant.NaturesGrasp.Spawn")

			if
				thicket
				== math.floor(
					(self:GetCastRange(cursor_position, self:GetCaster()) - 100)
						/ self:GetSpecialValueFor("vine_spawn_interval")
				)
			then
				self.thinker_tracker[unique_string] = nil
			end

			return nil
		end, self:GetSpecialValueFor("creation_interval") * (thicket - 1))
	end
end

---------------------------------------------------------

function modifier_treant_natures_grasp_lua_creation_thinker:IsHidden()
	return true
end
function modifier_treant_natures_grasp_lua_creation_thinker:IsPurgable()
	return false
end

function modifier_treant_natures_grasp_lua_creation_thinker:OnCreated(keys)
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	if not IsServer() then
		return
	end

	-- счётчик активной лозы на кастере (для пассивки living armor)
	local caster = self:GetCaster()
	if caster then
		caster.treant_vine_count = (caster.treant_vine_count or 0) + 1
	end

	self.latch_range = self:GetAbility():GetSpecialValueFor("latch_range")
	self.latch_vision = self:GetAbility():GetSpecialValueFor("latch_vision")
	self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
	self.movement_slow = self:GetAbility():GetSpecialValueFor("movement_slow")

	self.unique_string = keys.unique_string

	self.bramble_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_treant/treant_bramble_root.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.bramble_particle, 0, Vector(0, 0, 0))
	self:AddParticle(self.bramble_particle, false, false, -1, false, false)

	if
		not self:GetAbility().thinker_tracker[self.unique_string]
		and GridNav:IsNearbyTree(self:GetParent():GetAbsOrigin(), self.latch_range, false)
	then
		self:GetAbility().thinker_tracker[self.unique_string] = true

		self.bTouchingTree = true

		for _, ent in pairs(Entities:FindAllByName("npc_dota_thinker")) do
			if
				ent:HasModifier(self:GetName())
				and ent:FindModifierByName(self:GetName()).unique_string == self.unique_string
				and ent:FindModifierByName(self:GetName()).bramble_particle
			then
				ParticleManager:SetParticleControl(
					ent:FindModifierByName(self:GetName()).bramble_particle,
					1,
					Vector(1, 0, 0)
				)
				ent:FindModifierByName(self:GetName()).bTouchingTree = true
			end
		end

		ParticleManager:SetParticleControl(self.bramble_particle, 1, Vector(1, 0, 0))
	elseif self:GetAbility().thinker_tracker[self.unique_string] then
		ParticleManager:SetParticleControl(self.bramble_particle, 1, Vector(1, 0, 0))
		self.bTouchingTree = true
	end
end

function modifier_treant_natures_grasp_lua_creation_thinker:OnDestroy()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	if caster and caster.treant_vine_count then
		caster.treant_vine_count = math.max(0, caster.treant_vine_count - 1)
	end

	self:GetParent():EmitSound("Hero_Treant.NaturesGrasp.Destroy")
end

function modifier_treant_natures_grasp_lua_creation_thinker:IsAura()
	return true
end
function modifier_treant_natures_grasp_lua_creation_thinker:IsAuraActiveOnDeath()
	return false
end

function modifier_treant_natures_grasp_lua_creation_thinker:GetAuraRadius()
	return self.latch_range
end

function modifier_treant_natures_grasp_lua_creation_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_treant_natures_grasp_lua_creation_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_treant_natures_grasp_lua_creation_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP
end

function modifier_treant_natures_grasp_lua_creation_thinker:GetModifierAura()
	if self.bTouchingTree then
		return "modifier_treant_natures_grasp_lua_damage_bonus"
	else
		return "modifier_treant_natures_grasp_lua_damage"
	end
end

----------------------------------------------- SIMPLE DAMAGE -----------------------------------

function modifier_treant_natures_grasp_lua_damage:OnCreated()
	if not IsServer() then
		return
	end

	if self:GetAbility() then
		self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
		self.movement_slow = self:GetAbility():GetSpecialValueFor("movement_slow")
	elseif
		self:GetAuraOwner() and self:GetAuraOwner():HasModifier("modifier_treant_natures_grasp_lua_creation_thinker")
	then
		self.damage_per_second = self:GetAuraOwner()
			:FindModifierByName("modifier_treant_natures_grasp_lua_creation_thinker").damage_per_second
		self.movement_slow = self:GetAuraOwner()
			:FindModifierByName("modifier_treant_natures_grasp_lua_creation_thinker").movement_slow
		self.damage_type = self:GetAuraOwner()
			:FindModifierByName("modifier_treant_natures_grasp_lua_creation_thinker").damage_type
	else
		self:Destroy()
	end

	self.interval = 0.25
	self.damage_per_tick = self.damage_per_second * self.interval

	self:SetStackCount(self.movement_slow * -1)

	self:GetParent():EmitSound("Hero_Treant.NaturesGrasp.Damage")
	self:StartIntervalThink(self.interval)
end

function modifier_treant_natures_grasp_lua_damage:OnIntervalThink()
	ApplyDamage({
		victim = self:GetParent(),
		damage = self.damage_per_tick,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self:GetAbility(),
	})
end

function modifier_treant_natures_grasp_lua_damage:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_treant_natures_grasp_lua_damage:GetModifierMoveSpeedBonus_Percentage()
	if not self:GetParent():IsMagicImmune() then
		return self:GetStackCount()
	end
end

-------------------

function modifier_treant_natures_grasp_lua_damage_bonus:OnCreated()
	if not IsServer() then
		return
	end

	if self:GetAbility() then
		self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
		self.movement_slow = self:GetAbility():GetSpecialValueFor("movement_slow")
	elseif
		self:GetAuraOwner() and self:GetAuraOwner():HasModifier("modifier_treant_natures_grasp_lua_creation_thinker")
	then
		self.damage_per_second = self:GetAuraOwner()
			:FindModifierByName("modifier_treant_natures_grasp_lua_creation_thinker").damage_per_second
		self.movement_slow = self:GetAuraOwner()
			:FindModifierByName("modifier_treant_natures_grasp_lua_creation_thinker").movement_slow
		self.damage_type = self:GetAuraOwner()
			:FindModifierByName("modifier_treant_natures_grasp_lua_creation_thinker").damage_type
	else
		self:Destroy()
	end

	-- касание дерева всегда удваивает урон
	self.damage_per_second = self.damage_per_second * 2

	self.interval = 0.25
	self.damage_per_tick = self.damage_per_second * self.interval

	self:SetStackCount(self.movement_slow * -1)

	self:GetParent():EmitSound("Hero_Treant.NaturesGrasp.Damage")

	self:StartIntervalThink(self.interval)
end

function modifier_treant_natures_grasp_lua_damage_bonus:OnIntervalThink()
	ApplyDamage({
		victim = self:GetParent(),
		damage = self.damage_per_tick,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self:GetAbility(),
	})
end

function modifier_treant_natures_grasp_lua_damage_bonus:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_treant_natures_grasp_lua_damage_bonus:GetModifierMoveSpeedBonus_Percentage()
	if not self:GetParent():IsMagicImmune() then
		return self:GetStackCount()
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- treant_leech_seed_lua --------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------

treant_leech_seed_lua = class({})

function treant_leech_seed_lua:OnSpellStart()
	self.hTarget = self:GetCursorTarget()
	self.hTarget:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_treant_leech_seed_lua",
		{ duration = self:GetSpecialValueFor("duration") - FrameTime() }
	)
end

---------------------------------------------------

modifier_treant_leech_seed_lua = class({})

function modifier_treant_leech_seed_lua:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.damage_interval = self:GetAbility():GetSpecialValueFor("damage_interval")
	self.leech_damage = self:GetAbility():GetSpecialValueFor("leech_damage")
	self.remnants_radius = self:GetAbility():GetSpecialValueFor("radius")
	self.projectile_speed = self:GetAbility():GetSpecialValueFor("projectile_speed")

	if not IsServer() then
		return
	end

	self:OnIntervalThink()
	self:StartIntervalThink(self.damage_interval)
end

function modifier_treant_leech_seed_lua:OnIntervalThink()
	self:GetParent():EmitSound("Hero_Treant.LeechSeed.Tick")

	self.damage_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(self.damage_particle)
	self.damage_particle = nil

	dealdamage(self:GetParent(), self.leech_damage * self.damage_interval, self:GetCaster(), self:GetAbility())

	local units = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		self:GetParent(),
		self.remnants_radius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, unit in pairs(units) do
		if unit ~= self:GetParent() then
			ProjectileManager:CreateTrackingProjectile({
				EffectName = "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf",
				Ability = self:GetAbility(),
				Source = self:GetParent(),
				vSourceLoc = self:GetParent():GetAbsOrigin(),
				Target = unit,
				iMoveSpeed = self.projectile_speed,
				flExpireTime = nil,
				bDodgeable = false,
				bIsAttack = false,
				bReplaceExisting = false,
				iSourceAttachment = nil,
				bDrawsOnMinimap = nil,
				bVisibleToEnemies = true,
				bProvidesVision = false,
				iVisionRadius = nil,
				iVisionTeamNumber = nil,
				ExtraData = {},
			})
		end
	end
end

function treant_leech_seed_lua:OnProjectileHit_ExtraData(target, location, ExtraData)
	if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		target:Heal(self:GetSpecialValueFor("leech_damage"), self:GetCaster())
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, self:GetSpecialValueFor("leech_damage"), nil)
	else
		target:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_treant_leech_seed_lua_slow",
			{ duration = self:GetSpecialValueFor("slow_duration") }
		)
		dealdamage(
			target,
			self:GetSpecialValueFor("leech_damage") * self:GetSpecialValueFor("damage_interval"),
			self:GetCaster(),
			self
		)
	end
end

function dealdamage(victim, damage, attacker, ability)
	ApplyDamage({
		victim = victim,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = attacker,
		ability = ability,
	})
end

----------------

modifier_treant_leech_seed_lua_slow = class({})

function modifier_treant_leech_seed_lua_slow:IsHidden()
	return false
end

function modifier_treant_leech_seed_lua_slow:IsPurgable()
	return false
end

function modifier_treant_leech_seed_lua_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_treant_leech_seed_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("movement_slow")
end

-----------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------- treant_living_armor_lua --------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

function treant_living_armor_lua:GetIntrinsicModifierName()
	return "modifier_treant_living_armor_lua_passive"
end

-- с талантом special_bonus_unique_treant_8 способность становится нотаргетной (AoE на союзников)
function treant_living_armor_lua:GetBehavior()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_treant_8")
	if talent ~= nil and talent:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT
end

function treant_living_armor_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:EmitSound("Hero_Treant.LivingArmor.Cast")

	local talent = caster:FindAbilityByName("special_bonus_unique_treant_8")
	if talent ~= nil and talent:GetLevel() > 0 then
		-- нотаргет: баф на всех союзников в радиусе 600
		local allies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			600,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, ally in pairs(allies) do
			ally:EmitSound("Hero_Treant.LivingArmor.Target")
			ally:AddNewModifier(caster, self, "modifier_treant_living_armor_lua", { duration = duration })
		end
	else
		-- обычный каст: на цель (а при касте по земле — на себя)
		local target = self:GetCursorTarget()
		if not target or target:IsNull() then
			target = caster
		end
		target:EmitSound("Hero_Treant.LivingArmor.Target")
		target:AddNewModifier(caster, self, "modifier_treant_living_armor_lua", { duration = duration })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------

function modifier_treant_living_armor_lua:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.total_heal = self:GetAbility():GetSpecialValueFor("total_heal")
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")

	self.heal_per_tick = self.total_heal / self.duration

	if not IsServer() then
		return
	end

	self.armor_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_treant/treant_livingarmor.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		self.armor_particle,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_origin",
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:AddParticle(self.armor_particle, false, false, -1, false, false)

	self:StartIntervalThink(1)
end

function modifier_treant_living_armor_lua:OnIntervalThink()
	self:GetParent():Heal(self.heal_per_tick, self:GetCaster())
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), self.heal_per_tick, nil)
end

function modifier_treant_living_armor_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_treant_living_armor_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

-----------------------------

modifier_treant_living_armor_lua_passive = class({})

function modifier_treant_living_armor_lua_passive:IsHidden()
	return true
end

function modifier_treant_living_armor_lua_passive:IsPurgable()
	return false
end

function modifier_treant_living_armor_lua_passive:OnCreated(kv)
	self:StartIntervalThink(0.1)
end

function modifier_treant_living_armor_lua_passive:OnIntervalThink()
	if not IsServer() then
		return
	end

	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_treant_6")
	if talent_ability == nil or talent_ability:GetLevel() <= 0 then
		return
	end

	-- стак за каждое дерево рядом (деревья — не юниты, ищем через GridNav)
	local trees = GridNav:GetAllTreesAroundPoint(self:GetCaster():GetAbsOrigin(), 600, false)
	local stacks = #trees

	-- + пока на земле есть лоза Nature's Grasp (использован 1-й скил) → +10 стаков
	if (self:GetCaster().treant_vine_count or 0) > 0 then
		stacks = stacks + 10
	end

	if stacks > 0 then
		self:GetParent()
			:AddNewModifier(self:GetParent(), nil, "modifier_treant_living_armor_lua_passive_effect", {})
			:SetStackCount(stacks)
	elseif self:GetParent():HasModifier("modifier_treant_living_armor_lua_passive_effect") then
		self:GetParent():RemoveModifierByName("modifier_treant_living_armor_lua_passive_effect")
	end
end

---------------------

modifier_treant_living_armor_lua_passive_effect = class({})

function modifier_treant_living_armor_lua_passive_effect:IsHidden()
	return false
end

function modifier_treant_living_armor_lua_passive_effect:IsPurgable()
	return false
end

function modifier_treant_living_armor_lua_passive_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_treant_living_armor_lua_passive_effect:GetModifierConstantHealthRegen()
	return 5 * self:GetStackCount()
end

function modifier_treant_living_armor_lua_passive_effect:GetModifierPreAttack_BonusDamage()
	return 10 * self:GetStackCount()
end

--------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------- treant_overgrowth_lua -----------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

function treant_overgrowth_lua:GetCastRange(location, target)
	return self:GetSpecialValueFor("radius") - self:GetCaster():GetCastRangeBonus()
end

function treant_overgrowth_lua:OnAbilityPhaseStart()
	self:GetCaster():EmitSound("Hero_Treant.Overgrowth.CastAnim")
	return true
end

function treant_overgrowth_lua:OnSpellStart()
	self:GetCaster():EmitSound("Hero_Treant.Overgrowth.Cast")

	local cast_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_treant/treant_overgrowth_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:ReleaseParticleIndex(cast_particle)

	local overgrowth_primary_enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetAbsOrigin(),
		self:GetCaster(),
		self:GetSpecialValueFor("radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(overgrowth_primary_enemies) do
		enemy:Stop()
		enemy:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_treant_overgrowth_lua",
			{ duration = self:GetSpecialValueFor("duration") * (1 - enemy:GetStatusResistance()) }
		)
	end
end

-------------------------------------
function modifier_treant_overgrowth_lua:GetEffectName()
	return "particles/units/heroes/hero_treant/treant_overgrowth_vines.vpcf"
end

function modifier_treant_overgrowth_lua:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.damage = self:GetAbility():GetSpecialValueFor("damage")

	if not IsServer() then
		return
	end

	self.damage_type = self:GetAbility():GetAbilityDamageType()

	self:StartIntervalThink(1 - self:GetParent():GetStatusResistance())
end

function modifier_treant_overgrowth_lua:OnIntervalThink()
	ApplyDamage({
		victim = self:GetParent(),
		damage = self.damage,
		damage_type = self.damage_type,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self:GetAbility(),
	})
end

function modifier_treant_overgrowth_lua:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_INVISIBLE] = false,
	}
end