--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_skywrath_mage_arcane_bolt_lua",
	"heroes/hero_skywrath_mage/hero_skywrath_mage",
	LUA_MODIFIER_MOTION_NONE
)

skywrath_mage_arcane_bolt_lua = class({})

function skywrath_mage_arcane_bolt_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local projectile_speed = self:GetSpecialValueFor("bolt_speed")
	local projectile_vision = self:GetSpecialValueFor("bolt_vision")
	local multiplier = self:GetSpecialValueFor("int_multiplier")

	if not IsServer() then
		return
	end
	local damage = self:GetSpecialValueFor("bolt_damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")

	if caster:IsHero() then
		damage = damage + multiplier * caster:GetIntellect(true)
	end

	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = false,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = projectile_vision,
		iVisionTeamNumber = caster:GetTeamNumber(),
		ExtraData = {
			damage = damage,
		},
	}
	ProjectileManager:CreateTrackingProjectile(info)

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_skywrath_mage_7")
	if talent and talent:GetLevel() > 0 then
		local radius = self:GetSpecialValueFor("radius")
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target:GetOrigin(),
			target,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			0,
			false
		)

		local target_2 = nil
		for _, enemy in pairs(enemies) do
			if enemy ~= target and enemy:IsHero() then
				target_2 = enemy
				break
			end
		end

		if not target_2 then
			target_2 = enemies[1]
			if target_2 == target then
				target_2 = enemies[2]
			end
		end

		if target_2 then
			info.Target = target_2
			ProjectileManager:CreateTrackingProjectile(info)
		end
	end
	EmitSoundOn("Hero_SkywrathMage.ArcaneBolt.Cast", caster)
end

function skywrath_mage_arcane_bolt_lua:OnProjectileHit_ExtraData(target, location, extraData)
	if not target then
		return
	end
	if target:TriggerSpellAbsorb(self) then
		return
	end

	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = extraData.damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	}
	ApplyDamage(damageTable)

	local vision = self:GetSpecialValueFor("bolt_vision")
	local duration = self:GetSpecialValueFor("vision_duration")
	AddFOWViewer(self:GetCaster():GetTeamNumber(), target:GetOrigin(), vision, duration, false)

	EmitSoundOn("Hero_SkywrathMage.ArcaneBolt.Impact", target)
	StopSoundOn("Hero_SkywrathMage.ArcaneBolt.Cast", self:GetCaster())
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_skywrath_mage_concussive_shot_lua",
	"heroes/hero_skywrath_mage/hero_skywrath_mage",
	LUA_MODIFIER_MOTION_NONE
)

skywrath_mage_concussive_shot_lua = class({})

function skywrath_mage_concussive_shot_lua:OnSpellStart()
	local caster = self:GetCaster()
	local launch_radius = self:GetSpecialValueFor("launch_radius")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		launch_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	local target = nil
	for _, enemy in pairs(enemies) do
		if enemy:IsHero() then
			target = enemy
			break
		end
	end
	target = target or enemies[1]

	if not target then
		self:PlayEffects2()
		return
	end

	self:LaunchShot(target)

	local talent = caster:FindAbilityByName("special_bonus_unique_skywrath_mage_7")
	if talent and talent:GetLevel() > 0 then
		local radius = self:GetSpecialValueFor("radius")
		local extra_enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target:GetOrigin(),
			target,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			FIND_CLOSEST,
			false
		)

		local target_2 = nil
		for _, enemy in pairs(extra_enemies) do
			if enemy ~= target then
				if enemy:IsHero() then
					target_2 = enemy
					break
				elseif not target_2 then
					target_2 = enemy
				end
			end
		end

		if target_2 and not target_2:IsMagicImmune() then
			self:LaunchShot(target_2)
		end
	end
end

function skywrath_mage_concussive_shot_lua:LaunchShot(target)
	local info = {
		Target = target,
		Source = self:GetCaster(),
		Ability = self,
		EffectName = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("speed"),
		bDodgeable = true,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = 400,
		iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
	}
	ProjectileManager:CreateTrackingProjectile(info)
	self:PlayEffects1(target)
end

function skywrath_mage_concussive_shot_lua:OnProjectileHit(target, location)
	if not target or not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("slow_radius")
	local duration = self:GetSpecialValueFor("slow_duration")
	local damage = self:GetSpecialValueFor("damage")
		+ (caster:ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage"))

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target:GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		})

		enemy:AddNewModifier(caster, self, "modifier_skywrath_mage_concussive_shot_lua", { duration = duration })
	end

	AddFOWViewer(
		caster:GetTeamNumber(),
		target:GetOrigin(),
		self:GetSpecialValueFor("shot_vision"),
		self:GetSpecialValueFor("vision_duration"),
		false
	)
	EmitSoundOn("Hero_SkywrathMage.ConcussiveShot.Target", target)
end

function skywrath_mage_concussive_shot_lua:PlayEffects1(target)
	local caster = self:GetCaster()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(self:GetSpecialValueFor("speed"), 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_SkywrathMage.ConcussiveShot.Cast", caster)
end

function skywrath_mage_concussive_shot_lua:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_failure.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

--------------------------------------------------------------------------------

modifier_skywrath_mage_concussive_shot_lua = class({})

function modifier_skywrath_mage_concussive_shot_lua:IsHidden()
	return false
end

function modifier_skywrath_mage_concussive_shot_lua:IsDebuff()
	return true
end

function modifier_skywrath_mage_concussive_shot_lua:IsStunDebuff()
	return false
end

function modifier_skywrath_mage_concussive_shot_lua:IsPurgable()
	return true
end

function modifier_skywrath_mage_concussive_shot_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_skywrath_mage_concussive_shot_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("movement_speed_pct")
end

function modifier_skywrath_mage_concussive_shot_lua:GetEffectName()
	return "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_slow_debuff.vpcf"
end

function modifier_skywrath_mage_concussive_shot_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_skywrath_mage_ancient_seal_lua",
	"heroes/hero_skywrath_mage/hero_skywrath_mage",
	LUA_MODIFIER_MOTION_NONE
)

skywrath_mage_ancient_seal_lua = class({})

function skywrath_mage_ancient_seal_lua:IsHiddenWhenStolen()
	return false
end

function skywrath_mage_ancient_seal_lua:GetAOERadius()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_skywrath_mage_5")
	return (talent and talent:GetLevel() > 0) and self:GetSpecialValueFor("radius") or 0
end

function skywrath_mage_ancient_seal_lua:GetBehavior()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_skywrath_mage_5")
	if talent and talent:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function skywrath_mage_ancient_seal_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local talent = caster:FindAbilityByName("special_bonus_unique_skywrath_mage_5")

	if talent and talent:GetLevel() > 0 then
		local target_point = self:GetCursorPosition()
		local radius = self:GetSpecialValueFor("radius")
		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target_point,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, unit in pairs(units) do
			unit:AddNewModifier(caster, self, "modifier_skywrath_mage_ancient_seal_lua", { duration = duration })
		end
	else
		local target = self:GetCursorTarget()
		if target then
			target:AddNewModifier(caster, self, "modifier_skywrath_mage_ancient_seal_lua", { duration = duration })
		end
	end
end

--------------------------------------------------------------------------------

modifier_skywrath_mage_ancient_seal_lua = class({})

function modifier_skywrath_mage_ancient_seal_lua:IsHidden()
	return false
end
function modifier_skywrath_mage_ancient_seal_lua:IsDebuff()
	return true
end
function modifier_skywrath_mage_ancient_seal_lua:IsPurgable()
	return true
end

function modifier_skywrath_mage_ancient_seal_lua:OnCreated()
	if not IsServer() then
		return
	end
	self:PlayEffects()
end

function modifier_skywrath_mage_ancient_seal_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS }
end

function modifier_skywrath_mage_ancient_seal_lua:GetModifierMagicalResistanceBonus()
	return -self:GetAbility():GetSpecialValueFor("resist_debuff")
end

function modifier_skywrath_mage_ancient_seal_lua:CheckState()
	return { [MODIFIER_STATE_SILENCED] = true }
end

function modifier_skywrath_mage_ancient_seal_lua:PlayEffects()
	local parent = self:GetParent()
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_ancient_seal_debuff.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(effect_cast, 0, parent, PATTACH_OVERHEAD_FOLLOW, "", Vector(0, 0, 0), true)
	ParticleManager:SetParticleControlEnt(effect_cast, 1, parent, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0, 0, 0), true)
	self:AddParticle(effect_cast, false, false, -1, false, false)

	EmitSoundOn("Hero_SkywrathMage.AncientSeal.Target", parent)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_skywrath_mage_mystic_flare_lua_thinker",
	"heroes/hero_skywrath_mage/hero_skywrath_mage",
	LUA_MODIFIER_MOTION_NONE
)

skywrath_mage_mystic_flare_lua = class({})

function skywrath_mage_mystic_flare_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function skywrath_mage_mystic_flare_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	local function CreateFlare(pos)
		CreateModifierThinker(
			caster,
			self,
			"modifier_skywrath_mage_mystic_flare_lua_thinker",
			{ duration = duration },
			pos,
			caster:GetTeamNumber(),
			false
		)
	end

	CreateFlare(point)
	EmitSoundOn("Hero_SkywrathMage.MysticFlare.Cast", caster)

	local talent = caster:FindAbilityByName("special_bonus_unique_skywrath_mage_8")
	if talent and talent:GetLevel() > 0 then
		local radius = self:GetSpecialValueFor("radius")
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			point,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			0,
			false
		)

		for _, enemy in pairs(enemies) do
			CreateFlare(enemy:GetOrigin())
		end
	end
end

--------------------------------------------------------------------------------

modifier_skywrath_mage_mystic_flare_lua_thinker = class({})

function modifier_skywrath_mage_mystic_flare_lua_thinker:OnCreated(kv)
	local interval = self:GetAbility():GetSpecialValueFor("damage_interval")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	if IsServer() then
		self.damage = self:GetAbility():GetSpecialValueFor("damage")
			+ (
				self:GetCaster():ExtraIntelligenceDamage()
				* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")
			)
		self.damage = self.damage * interval / kv.duration
		self.damageTable = {
			attacker = self:GetCaster(),
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(),
		}

		self:StartIntervalThink(interval)
		self:OnIntervalThink()
		self:PlayEffects(self.radius, kv.duration, interval)
	end
end

function modifier_skywrath_mage_mystic_flare_lua_thinker:OnDestroy()
	if IsServer() then
		UTIL_Remove(self:GetParent())
	end
end

function modifier_skywrath_mage_mystic_flare_lua_thinker:OnIntervalThink()
	local heroes = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetOrigin(),
		self:GetParent(),
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_ALL,
		0,
		0,
		false
	)
	if #heroes < 1 then
		return
	end
	for _, hero in pairs(heroes) do
		self.damageTable.victim = hero
		self.damageTable.damage = self.damage
		ApplyDamage(self.damageTable)
	end
end

function modifier_skywrath_mage_mystic_flare_lua_thinker:PlayEffects(radius, duration, interval)
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf"
	local sound_cast = "Hero_SkywrathMage.MysticFlare"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, duration, interval))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetParent())
end