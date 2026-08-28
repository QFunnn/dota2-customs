--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


luna_starfall = class({})

function luna_starfall:OnAbilityPhaseStart()
	if not IsServer() then
		return
	end
	local precast_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_luna/luna_lucent_beam_precast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		precast_particle,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetCaster():GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(precast_particle)
	return true
end

function luna_starfall:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local main_target = self:GetCursorTarget()
	local beam_count = self:GetSpecialValueFor("beam_count")
	local bounce_radius = self:GetSpecialValueFor("bounce_radius")
	local delay = 0.4
	local beams_fired = 0

	local function FireBeam(unit)
		if not unit or unit:IsNull() or not unit:IsAlive() then
			return
		end

		caster:EmitSound("Hero_Luna.LucentBeam.Cast")
		unit:EmitSound("Hero_Luna.LucentBeam.Target")

		local particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_luna/luna_lucent_beam.vpcf",
			PATTACH_POINT_FOLLOW,
			caster
		)
		ParticleManager:SetParticleControl(particle, 1, unit:GetAbsOrigin())
		ParticleManager:SetParticleControlEnt(
			particle,
			5,
			unit,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			unit:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			particle,
			6,
			caster,
			PATTACH_POINT_FOLLOW,
			"attach_attack1",
			caster:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle)

		local damageTable = {
			victim = unit,
			damage = self:GetSpecialValueFor("beam_damage"),
			damage_type = self:GetAbilityDamageType(),
			attacker = caster,
			ability = self,
		}
		ApplyDamage(damageTable)

		unit:AddNewModifier(caster, self, "modifier_stunned", {
			duration = self:GetSpecialValueFor("stun_duration") * (1 - unit:GetStatusResistance()),
		})

		beams_fired = beams_fired + 1
	end

	if main_target:TriggerSpellAbsorb(self) then
		return
	end
	FireBeam(main_target)

	Timers:CreateTimer(delay, function()
		if beams_fired >= beam_count then
			return nil
		end

		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			main_target:GetAbsOrigin(),
			main_target,
			bounce_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			FIND_CLOSEST,
			false
		)

		local next_target = nil

		for _, enemy in pairs(enemies) do
			if enemy ~= main_target then
				next_target = enemy
				break
			end
		end

		if not next_target then
			next_target = main_target
		end

		FireBeam(next_target)

		if beams_fired < beam_count then
			return delay
		end
	end)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_luna_moon_glaive_lua", "heroes/hero_luna/hero_luna", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_luna_moon_glaive_damage_handler", "heroes/hero_luna/hero_luna", LUA_MODIFIER_MOTION_NONE)

luna_moon_glaive_lua = class({})

function luna_moon_glaive_lua:GetIntrinsicModifierName()
	return "modifier_luna_moon_glaive_lua"
end

function luna_moon_glaive_lua:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
	if not IsServer() or not hTarget then
		return
	end

	local caster = self:GetCaster()

	local reduction = self:GetSpecialValueFor("damage_reduction_percent")
	local multiplier = math.pow((100 - reduction) / 100, ExtraData.bounces) * 100

	local damage_mod = caster:AddNewModifier(caster, self, "modifier_luna_moon_glaive_damage_handler", {})
	damage_mod:SetStackCount(multiplier)

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_luna_8")
	if talent and talent:GetLevel() > 0 then
		caster:PerformAttack(
			hTarget,
			true, -- bUseCastAttackOrb
			true, -- bProcessProcs
			true, -- bSkipCooldown
			false, -- bIgnoreInvis
			false, -- bUseProjectile
			false, -- bFakeAttack
			true -- bNeverMiss
		)
	else
		caster:PerformAttack(
			hTarget,
			true, -- bUseCastAttackOrb
			false, -- bProcessProcs
			true, -- bSkipCooldown
			false, -- bIgnoreInvis
			false, -- bUseProjectile
			false, -- bFakeAttack
			true -- bNeverMiss
		)
	end

	caster:RemoveModifierByName("modifier_luna_moon_glaive_damage_handler")

	ExtraData.bounces = ExtraData.bounces + 1
	if ExtraData.bounces >= self:GetSpecialValueFor("bounces") then
		return
	end

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		vLocation,
		hTarget,
		self:GetSpecialValueFor("range"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_CLOSEST,
		false
	)

	for _, enemy in pairs(enemies) do
		if enemy ~= hTarget then
			ProjectileManager:CreateTrackingProjectile({
				Target = enemy,
				Ability = self,
				EffectName = "particles/units/heroes/hero_luna/luna_moon_glaive_bounce.vpcf",
				iMoveSpeed = 900,
				vSourceLoc = vLocation,
				bDodgeable = false,
				ExtraData = {
					bounces = ExtraData.bounces,
				},
			})
			break
		end
	end
end

-------------------------------------------------------------------------------

modifier_luna_moon_glaive_lua = class({})

function modifier_luna_moon_glaive_lua:IsHidden()
	return true
end

function modifier_luna_moon_glaive_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_PROCATTACK_FEEDBACK }
end

function modifier_luna_moon_glaive_lua:GetModifierProcAttack_Feedback(keys)
	if not IsServer() then
		return
	end

	if keys.no_attack_cooldown then
		return
	end

	local parent = self:GetParent()

	if parent:PassivesDisabled() then
		return
	end

	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		keys.target:GetAbsOrigin(),
		keys.target,
		self:GetAbility():GetSpecialValueFor("range"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_CLOSEST,
		false
	)

	for _, enemy in pairs(enemies) do
		if enemy ~= keys.target then
			ProjectileManager:CreateTrackingProjectile({
				Target = enemy,
				Source = keys.target,
				Ability = self:GetAbility(),
				EffectName = "particles/units/heroes/hero_luna/luna_moon_glaive_bounce.vpcf",
				iMoveSpeed = 900,
				bDodgeable = false,
				ExtraData = {
					bounces = 1,
				},
			})
			break
		end
	end
end

-------------------------------------------------------------------------------

modifier_luna_moon_glaive_damage_handler = class({})

function modifier_luna_moon_glaive_damage_handler:IsHidden()
	return true
end
function modifier_luna_moon_glaive_damage_handler:IsPurgable()
	return false
end

function modifier_luna_moon_glaive_damage_handler:DeclareFunctions()
	return { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE }
end

function modifier_luna_moon_glaive_damage_handler:GetModifierDamageOutgoing_Percentage()
	return self:GetStackCount() - 100
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_luna_lunar_blessing_lua_aura", "heroes/hero_luna/hero_luna", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_luna_lunar_blessing_lua_buff", "heroes/hero_luna/hero_luna", LUA_MODIFIER_MOTION_NONE)

luna_lunar_blessing_lua = class({})

function luna_lunar_blessing_lua:GetCastRange()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_luna_7")
	if talent and talent:GetLevel() > 0 then
		return 500
	end
	return 0
end

function luna_lunar_blessing_lua:GetIntrinsicModifierName()
	return "modifier_luna_lunar_blessing_lua_aura"
end

-------------------------------------------------------------------------------

modifier_luna_lunar_blessing_lua_aura = class({})

function modifier_luna_lunar_blessing_lua_aura:IsHidden()
	return true
end
function modifier_luna_lunar_blessing_lua_aura:IsPurgable()
	return false
end

function modifier_luna_lunar_blessing_lua_aura:IsAura()
	return true
end

function modifier_luna_lunar_blessing_lua_aura:GetAuraRadius()
	return 500
end

function modifier_luna_lunar_blessing_lua_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_luna_lunar_blessing_lua_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_luna_lunar_blessing_lua_aura:GetModifierAura()
	return "modifier_luna_lunar_blessing_lua_buff"
end

function modifier_luna_lunar_blessing_lua_aura:GetAuraEntityReject(hEntity)
	local caster = self:GetCaster()
	local talent = caster:FindAbilityByName("special_bonus_unique_luna_7")

	if talent and talent:GetLevel() > 0 then
		return false
	end

	return hEntity ~= caster
end

-------------------------------------------------------------------------------

modifier_luna_lunar_blessing_lua_buff = class({})

function modifier_luna_lunar_blessing_lua_buff:IsHidden()
	return false
end
function modifier_luna_lunar_blessing_lua_buff:IsDebuff()
	return false
end
function modifier_luna_lunar_blessing_lua_buff:IsPurgable()
	return false
end

function modifier_luna_lunar_blessing_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_luna_lunar_blessing_lua_buff:GetModifierBonusStats_Strength()
	local ability = self:GetAbility()
	if not ability then
		return 0
	end
	local pct = ability:GetSpecialValueFor("attributes_pct") / 100
	return self:GetParent():GetBaseStrength() * pct
end

function modifier_luna_lunar_blessing_lua_buff:GetModifierBonusStats_Agility()
	local ability = self:GetAbility()
	if not ability then
		return 0
	end
	local pct = ability:GetSpecialValueFor("attributes_pct") / 100
	return self:GetParent():GetBaseAgility() * pct
end

function modifier_luna_lunar_blessing_lua_buff:GetModifierBonusStats_Intellect()
	local ability = self:GetAbility()
	if not ability then
		return 0
	end
	local pct = ability:GetSpecialValueFor("attributes_pct") / 100
	return self:GetParent():GetBaseIntellect() * pct
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_luna_moon", "heroes/hero_luna/hero_luna", LUA_MODIFIER_MOTION_NONE)

luna_moon = class({})

function luna_moon:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_luna_3")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 20
	end
	return self.BaseClass.GetCooldown(self, level)
end

function luna_moon:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()

	local duration = self:GetSpecialValueFor("duration")
	caster:EmitSound("Hero_Luna.Eclipse.Cast")
	caster:AddNewModifier(caster, self, "modifier_luna_moon", { duration = duration })
end

-------------------------------------------------------------------------------

modifier_luna_moon = class({})

function modifier_luna_moon:OnCreated()
	if not IsServer() then
		return
	end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.beams = self:GetAbility():GetSpecialValueFor("beams")
	self.interval = self:GetAbility():GetSpecialValueFor("beam_interval")
	self.beams_fired = 0
	self.glaive_ability = self:GetCaster():FindAbilityByName("luna_moon_glaive_lua")

	self:StartIntervalThink(self.interval)
end

function modifier_luna_moon:OnIntervalThink()
	if self.beams_fired >= self.beams then
		self:Destroy()
		return
	end

	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
		FIND_ANY_ORDER,
		false
	)

	if #enemies > 0 then
		local target = enemies[RandomInt(1, #enemies)]

		target:EmitSound("Hero_Luna.Eclipse.Target")

		local particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_luna/luna_lucent_beam.vpcf",
			PATTACH_POINT_FOLLOW,
			caster
		)
		ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
		ParticleManager:SetParticleControlEnt(
			particle,
			5,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			target:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			particle,
			6,
			caster,
			PATTACH_POINT_FOLLOW,
			"attach_attack1",
			caster:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle)

		caster:PerformAttack(target, true, true, true, false, false, false, true)

		if self.glaive_ability and self.glaive_ability:GetLevel() > 0 then
			local bounce_range = self.glaive_ability:GetSpecialValueFor("range")

			local bounce_enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				target:GetAbsOrigin(),
				target,
				bounce_range,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
				FIND_CLOSEST,
				false
			)

			for _, b_enemy in pairs(bounce_enemies) do
				if b_enemy ~= target then
					ProjectileManager:CreateTrackingProjectile({
						Target = b_enemy,
						Source = target,
						Ability = self.glaive_ability,
						EffectName = "particles/units/heroes/hero_luna/luna_moon_glaive_bounce.vpcf",
						iMoveSpeed = 900,
						bDodgeable = false,
						ExtraData = { bounces = 1 },
					})
					break
				end
			end
		end

		self.beams_fired = self.beams_fired + 1
	else
		self.beams_fired = self.beams_fired + 1
	end
end