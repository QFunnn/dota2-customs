--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_triss_shotgun", "heroes/hero_triss/hero_triss", LUA_MODIFIER_MOTION_NONE)

triss_shotgun = class({})

function triss_shotgun:OnAbilityPhaseStart()
	EmitSoundOn("Hero_Snapfire.Shotgun.Load", self:GetCaster())
	return true
end

function triss_shotgun:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	local projectile_name = "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun.vpcf"
	local projectile_distance = self:GetCastRange(point, nil)
	local projectile_start_radius = self:GetSpecialValueFor("blast_width_initial") / 2
	local projectile_end_radius = self:GetSpecialValueFor("blast_width_end") / 2
	local projectile_speed = self:GetSpecialValueFor("blast_speed")
	local projectile_direction = point - origin
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),

		bDeleteOnHit = false,

		iUnitTargetTeam = self:GetAbilityTargetTeam(),
		iUnitTargetFlags = self:GetAbilityTargetFlags(),
		iUnitTargetType = self:GetAbilityTargetType(),

		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,

		bProvidesVision = false,
		ExtraData = {
			pos_x = origin.x,
			pos_y = origin.y,
		},
	}
	ProjectileManager:CreateLinearProjectile(info)

	EmitSoundOn("Hero_Snapfire.Shotgun.Fire", caster)
end

function triss_shotgun:OnProjectileHit_ExtraData(target, location, extraData)
	if not target then
		return
	end

	local caster = self:GetCaster()
	local location = target:GetOrigin()
	local point_blank_range = self:GetSpecialValueFor("point_blank_range")
	local damage = self:GetSpecialValueFor("damage")

	local origin = Vector(extraData.pos_x, extraData.pos_y, 0)
	local length = (location - origin):Length2D()

	local point_blank = (length <= point_blank_range)
	if point_blank then
		damage = damage
	end

	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	target:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_triss_shotgun",
		{ duration = self:GetSpecialValueFor("duration") }
	)

	self:PlayEffects(target, point_blank)
end

function triss_shotgun:PlayEffects(target, point_blank)
	local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_impact.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_snapfire/hero_snapfire_shells_impact.vpcf"
	local particle_cast3 = "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_pointblank_impact_sparks.vpcf"
	local sound_target = "Hero_Snapfire.Shotgun.Target"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	if point_blank then
		local effect_cast = ParticleManager:CreateParticle(particle_cast2, PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			3,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0, 0, 0), -- unknown
			true -- unknown, true
		)
		ParticleManager:ReleaseParticleIndex(effect_cast)

		local effect_cast = ParticleManager:CreateParticle(particle_cast3, PATTACH_POINT_FOLLOW, target)
		ParticleManager:SetParticleControlEnt(
			effect_cast,
			4,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			Vector(0, 0, 0), -- unknown
			true -- unknown, true
		)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end
	EmitSoundOn(sound_target, target)
end

----------------------------------------------------------------------------------

modifier_triss_shotgun = class({})

function modifier_triss_shotgun:IsHidden()
	return false
end
function modifier_triss_shotgun:IsDebuff()
	return true
end
function modifier_triss_shotgun:IsPurgable()
	return true
end

function modifier_triss_shotgun:OnCreated()
	self.armor_reduction = -1 * self:GetAbility():GetSpecialValueFor("debuff")
end

function modifier_triss_shotgun:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_triss_shotgun:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

LinkLuaModifier("modifier_triss_turret", "heroes/hero_triss/hero_triss", LUA_MODIFIER_MOTION_NONE)

triss_turret = class({})

function triss_turret:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("damage")
	local hp = self:GetSpecialValueFor("hp")
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	EmitSoundOn("Hero_Techies.StasisTrap.Plant", caster)

	turret = CreateUnitByName("npc_turret", point, true, caster, nil, caster:GetTeam())
	turret:SetControllableByPlayer(caster:GetPlayerID(), true)
	turret:SetOwner(caster)

	local set_hp = caster:GetMaxHealth() / 100 * hp

	turret:SetBaseMaxHealth(set_hp)
	turret:SetMaxHealth(set_hp)
	turret:SetHealth(set_hp)

	local turret_dmg = damage / 100 * caster:GetBaseDamageMin()

	turret:SetBaseDamageMin(turret_dmg)
	turret:SetBaseDamageMax(turret_dmg)

	turret:AddNewModifier(turret, self, "modifier_triss_turret", {})
	turret:AddNewModifier(turret, self, "modifier_tutorial_disable_healing", {})
	turret:AddNewModifier(turret, self, "modifier_kill", { duration = duration })

	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_triss_7")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		turret:AddAbility("triss_splash"):SetLevel(1)
	end
end

---------------------------------------------------------------

modifier_triss_turret = class({})

function modifier_triss_turret:IsHidden()
	return true
end
function modifier_triss_turret:IsPurgable()
	return false
end

function modifier_triss_turret:CheckState()
	local state = {
		[MODIFIER_STATE_CANNOT_MISS] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
	return state
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

LinkLuaModifier("modifier_triss_splash", "heroes/hero_triss/hero_triss", LUA_MODIFIER_MOTION_NONE)

triss_splash = class({})

function triss_splash:GetIntrinsicModifierName()
	return "modifier_triss_splash"
end

--------------------------------------------------------------------------

modifier_triss_splash = class({})

function modifier_triss_splash:IsHidden()
	return true
end

function modifier_triss_splash:IsPurgable()
	return false
end

function modifier_triss_splash:OnCreated(kv)
	if not IsServer() then
		return
	end
end

function modifier_triss_splash:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_triss_splash:OnAttackLanded(keys)
	if not IsServer() then
		return
	end
	if
		keys.attacker == self:GetParent()
		and not self:GetParent():IsIllusion()
		and not self:GetParent():PassivesDisabled()
	then
		local radius = self:GetAbility():GetSpecialValueFor("radius")
		local damage = self:GetAbility():GetSpecialValueFor("damage")
		local caster_damage = keys.attacker:GetBaseDamageMin()

		local boom_damage = math.ceil(caster_damage * damage / 100)

		damage_table = {
			attacker = keys.attacker,
			damage = boom_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
				+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
		}

		local enemies = FindUnitsInRadius(
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			keys.target:GetAbsOrigin(),
			keys.target,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_ALL,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		for _, enemy in pairs(enemies) do
			if enemy ~= keys.target then
				damage_table.victim = enemy
				ApplyDamage(damage_table)
			end
		end

		EmitSoundOn("Hero_Jakiro.LiquidFire", keys.attacker)
	end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

LinkLuaModifier("modifier_triss_disguise", "heroes/hero_triss/hero_triss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_modifier_triss_disguise_immune", "heroes/hero_triss/hero_triss", LUA_MODIFIER_MOTION_NONE)

triss_disguise = class({})

function triss_disguise:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_suicide_explosion.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context)
end

function triss_disguise:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local damage = self:GetSpecialValueFor("damage")
	local radius = self:GetSpecialValueFor("radius")

	caster:AddNewModifier(caster, self, "modifier_triss_disguise", { duration = duration })

	-- Звук + взрыв на кастере
	EmitSoundOn("Hero_TemplarAssassin.Meld", caster)
	EmitSoundOn("Hero_Techies.SuicideExplode", caster)

	local exp_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_suicide_explosion.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(exp_pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(exp_pfx, 1, Vector(radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(exp_pfx)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			attacker = caster,
			victim = enemy,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})

		-- Звук и эффект на каждой цели
		EmitSoundOn("Hero_Jakiro.LiquidFire", enemy)
		local hit_pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			enemy
		)
		ParticleManager:ReleaseParticleIndex(hit_pfx)
	end
end

------------------------------------------------------------------

modifier_triss_disguise = class({})

function modifier_triss_disguise:IsHidden()
	return false
end

function modifier_triss_disguise:IsPurgable()
	return false
end

function modifier_triss_disguise:OnCreated(kv)
	if not IsServer() then
		return
	end
end

function modifier_triss_disguise:OnDestroy(kv)
	if not IsServer() then
		return
	end
	EmitSoundOn("Hero_TemplarAssassin.Meld.Move", self:GetCaster())

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_triss_5")
	if talent and talent:GetLevel() > 0 then
		self:GetCaster()
			:AddNewModifier(self:GetCaster(), nil, "modifier_modifier_triss_disguise_immune", { duration = 3 })
	end
end

function modifier_triss_disguise:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_SPENT_MANA,
		MODIFIER_EVENT_ON_UNIT_MOVED,
	}
	return funcs
end

function modifier_triss_disguise:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
	return state
end

function modifier_triss_disguise:GetModifierModelChange()
	return "models/items/antimage/ti7_antimage_immortal/antimage_immortal_remnant_fx.vmdl"
end

function modifier_triss_disguise:GetModifierModelScale()
	return 40
end

function modifier_triss_disguise:OnAttack(params)
	if params.attacker ~= self:GetParent() then
		return
	end
	if params.no_attack_cooldown then
		return
	end
	self:Destroy()
end

function modifier_triss_disguise:OnSpentMana(params)
	if params.unit == self:GetParent() and params.ability:GetManaCost() > 10 then
		self:Destroy()
	end
end

function modifier_triss_disguise:OnUnitMoved(params)
	if params.unit == self:GetParent() then
		self:Destroy()
	end
end

------------------------------------------------------------------

modifier_modifier_triss_disguise_immune = class({})

function modifier_modifier_triss_disguise_immune:IsHidden()
	return true
end
function modifier_modifier_triss_disguise_immune:IsPurgable()
	return false
end

function modifier_modifier_triss_disguise_immune:CheckState()
	local state = {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
	return state
end

function modifier_modifier_triss_disguise_immune:GetEffectName()
	return "particles/items_fx/black_king_bar_avatar.vpcf"
end

------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------

LinkLuaModifier("modifier_triss_granade", "heroes/hero_triss/hero_triss", LUA_MODIFIER_MOTION_NONE)

triss_granade = class({})

function triss_granade:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function triss_granade:OnSpellStart()
	local flamebreak_dummy = CreateModifierThinker(
		self:GetCaster(),
		self,
		nil,
		{},
		self:GetCaster():GetAbsOrigin(),
		self:GetCaster():GetTeamNumber(),
		false
	)
	flamebreak_dummy:EmitSound("Hero_Batrider.Flamebreak")

	local flamebreak_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_batrider/batrider_flamebreak.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(flamebreak_particle, 0, self:GetCaster():GetAbsOrigin() + Vector(0, 0, 128)) -- Arbitrary verticality increase
	ParticleManager:SetParticleControl(flamebreak_particle, 1, Vector(600))
	ParticleManager:SetParticleControl(flamebreak_particle, 5, self:GetCursorPosition())

	if not self.projectile_table then
		self.projectile_table = {
			Ability = self,
			EffectName = nil,
			vSpawnOrigin = nil,
			fDistance = nil,
			fStartRadius = 0,
			fEndRadius = 0,
			Source = self:GetCaster(),
			bHasFrontalCone = false,
			bReplaceExisting = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType = DOTA_UNIT_TARGET_NONE,
			fExpireTime = nil,
			bDeleteOnHit = false,
			vVelocity = nil,
			bProvidesVision = true,
			-- "The projectile has 175 radius flying vision. This vision does not last."
			iVisionRadius = 175,
			iVisionTeamNumber = self:GetCaster():GetTeamNumber(),

			ExtraData = nil,
		}
	end

	self.projectile_table.vSpawnOrigin = self:GetCaster():GetAbsOrigin()
	self.projectile_table.fDistance = (self:GetCursorPosition() - self:GetCaster():GetAbsOrigin()):Length2D()
	self.projectile_table.fExpireTime = GameRules:GetGameTime() + 10.0
	self.projectile_table.vVelocity = (self:GetCursorPosition() - self:GetCaster():GetAbsOrigin()):Normalized()
		* 600
		* Vector(1, 1, 0)
	self.projectile_table.ExtraData = {
		flamebreak_dummy_entindex = flamebreak_dummy:entindex(),
		flamebreak_particle = flamebreak_particle,
	}

	ProjectileManager:CreateLinearProjectile(self.projectile_table)
end

function triss_granade:OnProjectileThink_ExtraData(location, data)
	if data.flamebreak_dummy_entindex then
		EntIndexToHScript(data.flamebreak_dummy_entindex):SetAbsOrigin(location)
	end
end

function triss_granade:OnProjectileHit_ExtraData(target, location, data)
	local sound_cast = "Hero_Batrider.Flamebreak.Impact"
	-- EmitSoundOnLocationWithCaster(location, sound_cast, self:GetCaster())
	EmitSoundOn(sound_cast, self:GetCaster())

	if data.flamebreak_dummy_entindex then
		EntIndexToHScript(data.flamebreak_dummy_entindex):StopSound("Hero_Batrider.Flamebreak")
		EntIndexToHScript(data.flamebreak_dummy_entindex):RemoveSelf()
	end

	if data.flamebreak_particle then
		ParticleManager:DestroyParticle(data.flamebreak_particle, false)
		ParticleManager:ReleaseParticleIndex(data.flamebreak_particle)
	end

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		location,
		nil,
		self:GetSpecialValueFor("radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	if not self.initial_damage_table then
		self.initial_damage_table = {
			victim = nil,
			damage = self:GetSpecialValueFor("damage"),
			damage_type = self:GetAbilityDamageType(),
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			attacker = self:GetCaster(),
			ability = self,
		}
	end

	for _, enemy in pairs(enemies) do
		self.initial_damage_table.victim = enemy
		ApplyDamage(self.initial_damage_table)

		enemy:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_triss_granade",
			{ duration = self:GetSpecialValueFor("duration") }
		)
	end
end

---------------------------------

modifier_triss_granade = modifier_triss_granade or class({})

function modifier_triss_granade:CheckState()
	local state = { [MODIFIER_STATE_ROOTED] = true }
	local state = { [MODIFIER_STATE_STUNNED] = true }
	return state
end

function modifier_triss_granade:IsHidden()
	return false
end
function modifier_triss_granade:IsPurgable()
	return true
end
function modifier_triss_granade:IsDebuff()
	return true
end

function modifier_triss_granade:GetStatusEffectName()
	return "particles/status_fx/status_effect_techies_stasis.vpcf"
end