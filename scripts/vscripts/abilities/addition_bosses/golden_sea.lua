--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


require("rules")
rules:SafeCall(function()
	LinkLuaModifier(
		"modifier_boss_damage_boost",
		"abilities/bosses/modifier_boss_damage_boost",
		LUA_MODIFIER_MOTION_NONE
	)
	LinkLuaModifier(
		"modifier_golden_sea_anti_fervor_passive",
		"abilities/addition_bosses/golden_sea",
		LUA_MODIFIER_MOTION_NONE
	)
	LinkLuaModifier(
		"modifier_golden_sea_anti_fervor_debuff",
		"abilities/addition_bosses/golden_sea",
		LUA_MODIFIER_MOTION_NONE
	)
	LinkLuaModifier(
		"modifier_golden_sea_anti_fervor_buff",
		"abilities/addition_bosses/golden_sea",
		LUA_MODIFIER_MOTION_NONE
	)
	LinkLuaModifier(
		"modifier_golden_sea_anti_fervor_base",
		"abilities/addition_bosses/golden_sea",
		LUA_MODIFIER_MOTION_NONE
	)

	golden_sea_anti_fervor = class({})

	function golden_sea_anti_fervor:GetIntrinsicModifierName()
		return "modifier_golden_sea_anti_fervor_passive"
	end

	--------------------------------------------------------------------------------

	modifier_golden_sea_anti_fervor_passive = class({})

	function modifier_golden_sea_anti_fervor_passive:IsHidden()
		return true
	end
	function modifier_golden_sea_anti_fervor_passive:IsPurgable()
		return false
	end
	function modifier_golden_sea_anti_fervor_passive:RemoveOnDeath()
		return false
	end

	function modifier_golden_sea_anti_fervor_passive:DeclareFunctions()
		return {
			MODIFIER_EVENT_ON_ATTACK_LANDED,
		}
	end

	function modifier_golden_sea_anti_fervor_passive:OnAttackLanded(keys)
		if not IsServer() then
			return
		end

		local parent = self:GetParent()
		local target = keys.target

		if keys.attacker == parent and not parent:PassivesDisabled() then
			if target:IsBuilding() or target:IsOther() then
				return
			end

			local ability = self:GetAbility()
			local duration = ability:GetSpecialValueFor("duration")

			local enemy_modifier = target:AddNewModifier(
				parent,
				ability,
				"modifier_golden_sea_anti_fervor_debuff",
				{ duration = duration }
			)
			if enemy_modifier then
				enemy_modifier:AddStack(duration)
			end

			local self_modifier =
				parent:AddNewModifier(parent, ability, "modifier_golden_sea_anti_fervor_buff", { duration = duration })
			if self_modifier then
				self_modifier:AddStack(duration)
			end
		end
	end

	--------------------------------------------------------------------------------

	modifier_golden_sea_anti_fervor_base = class({})

	function modifier_golden_sea_anti_fervor_base:IsHidden()
		return false
	end
	function modifier_golden_sea_anti_fervor_base:IsPurgable()
		return false
	end

	function modifier_golden_sea_anti_fervor_base:OnCreated()
		if not IsServer() then
			return
		end
		self:SetStackCount(0)
	end

	function modifier_golden_sea_anti_fervor_base:AddStack(duration)
		if not IsServer() then
			return
		end

		self:IncrementStackCount()
		self:SetDuration(duration, true)

		self:GetAbility():SetContextThink(DoUniqueString("stack_timer"), function()
			if not self:IsNull() then
				self:DecrementStackCount()
			end
		end, duration)
	end

	--------------------------------------------------------------------------------

	modifier_golden_sea_anti_fervor_debuff = class(modifier_golden_sea_anti_fervor_base)

	function modifier_golden_sea_anti_fervor_debuff:DeclareFunctions()
		return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
	end

	function modifier_golden_sea_anti_fervor_debuff:GetModifierAttackSpeedBonus_Constant()
		if self:GetAbility() then
			return self:GetStackCount() * -self:GetAbility():GetSpecialValueFor("attack_speed")
		end
		return 0
	end

	function modifier_golden_sea_anti_fervor_debuff:GetTexture()
		return "troll_warlord_fervor"
	end

	--------------------------------------------------------------------------------

	modifier_golden_sea_anti_fervor_buff = class(modifier_golden_sea_anti_fervor_base)

	function modifier_golden_sea_anti_fervor_buff:DeclareFunctions()
		return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
	end

	function modifier_golden_sea_anti_fervor_buff:GetModifierAttackSpeedBonus_Constant()
		if self:GetAbility() then
			return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("attack_speed")
		end
		return 0
	end

	function modifier_golden_sea_anti_fervor_buff:GetTexture()
		return "troll_warlord_fervor"
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	LinkLuaModifier("modifier_golden_sea_turbulence", "abilities/addition_bosses/golden_sea", LUA_MODIFIER_MOTION_NONE)

	golden_sea_turbulence = class({})

	function golden_sea_turbulence:GetIntrinsicModifierName()
		return "modifier_boss_damage_boost"
	end

	function golden_sea_turbulence:Precache(context)
		PrecacheResource("particle", "particles/units/heroes/hero_brewmaster/brewmaster_cyclone.vpcf", context)
		PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_windrunner.vsndevts", context)
	end

	function golden_sea_turbulence:OnSpellStart()
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local duration = self:GetSpecialValueFor("duration")

		target:AddNewModifier(caster, self, "modifier_golden_sea_turbulence", { duration = duration })

		caster:EmitSound("Hero_Razor.StormEnd")
	end

	--------------------------------------------------------------------------------

	modifier_golden_sea_turbulence = class({})

	function modifier_golden_sea_turbulence:IsDebuff()
		return true
	end
	function modifier_golden_sea_turbulence:IsPurgable()
		return true
	end

	function modifier_golden_sea_turbulence:OnCreated()
		if not IsServer() then
			return
		end

		self.interval = self:GetAbility():GetSpecialValueFor("interval")
		self.push_dist = self:GetAbility():GetSpecialValueFor("push_distance")
		self.damage = self:GetAbility():GetSpecialValueFor("damage")
			+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

		self.pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_brewmaster/brewmaster_cyclone.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(self.pfx, 0, self:GetParent():GetAbsOrigin())

		self:StartIntervalThink(self.interval)
	end

	function modifier_golden_sea_turbulence:OnIntervalThink()
		local parent = self:GetParent()

		local random_direction = RandomVector(1):Normalized()
		local target_pos = parent:GetAbsOrigin() + random_direction * self.push_dist

		target_pos = GetGroundPosition(target_pos, parent)

		parent:EmitSound("Hero_Windrunner.Powershot.Cast")

		local knockback = {
			should_stun = false,
			knockback_duration = 0.3,
			duration = 0.3,
			knockback_distance = self.push_dist,
			knockback_height = 20,
			center_x = parent:GetAbsOrigin().x - random_direction.x,
			center_y = parent:GetAbsOrigin().y - random_direction.y,
			center_z = parent:GetAbsOrigin().z,
		}

		parent:Script_ReduceMana(self.damage, nil)

		ApplyDamage({
			victim = parent,
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(),
		})

		parent:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_knockback", knockback)
		parent:Stop()
	end

	function modifier_golden_sea_turbulence:OnDestroy()
		if not IsServer() then
			return
		end
		if self.pfx then
			ParticleManager:DestroyParticle(self.pfx, false)
			ParticleManager:ReleaseParticleIndex(self.pfx)
		end
	end

	function modifier_golden_sea_turbulence:DeclareFunctions()
		return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
	end

	function modifier_golden_sea_turbulence:GetOverrideAnimation()
		return ACT_DOTA_FLAIL
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	LinkLuaModifier("modifier_golden_sea_hydro", "abilities/addition_bosses/golden_sea", LUA_MODIFIER_MOTION_NONE)
	LinkLuaModifier("modifier_golden_sea_hydro_stack", "abilities/addition_bosses/golden_sea", LUA_MODIFIER_MOTION_NONE)

	golden_sea_hydro = class({})

	function golden_sea_hydro:GetIntrinsicModifierName()
		return "modifier_golden_sea_hydro"
	end

	--------------------------------------------------------------------------------

	modifier_golden_sea_hydro = class({})

	function modifier_golden_sea_hydro:IsHidden()
		return true
	end
	function modifier_golden_sea_hydro:IsPurgable()
		return true
	end

	function modifier_golden_sea_hydro:OnCreated()
		if not IsServer() then
			return
		end
		local caster = self:GetCaster()
		if not caster:HasModifier("modifier_boss_damage_boost") then
			caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
		end
	end

	function modifier_golden_sea_hydro:DeclareFunctions()
		return {
			MODIFIER_EVENT_ON_ATTACK_LANDED,
		}
	end

	function modifier_golden_sea_hydro:OnAttackLanded(params)
		if not IsServer() then
			return
		end
		if params.attacker ~= self:GetParent() then
			return
		end
		if params.target:IsBuilding() or params.target:IsOther() then
			return
		end

		local caster = self:GetParent()
		local target = params.target
		local ability = self:GetAbility()

		local damage_per_stack = ability:GetSpecialValueFor("damage") + ability:GetSpecialValueFor("diff_boost_damage")
		local duration = ability:GetSpecialValueFor("debuff_duration")

		local modifier = target:FindModifierByNameAndCaster("modifier_golden_sea_hydro_stack", caster)
		if not modifier then
			modifier =
				target:AddNewModifier(caster, ability, "modifier_golden_sea_hydro_stack", { duration = duration })
		end

		if modifier then
			modifier:IncrementStackCount()
			modifier:ForceRefresh()

			local stacks = modifier:GetStackCount()
			local total_damage = damage_per_stack * stacks

			local target_mana = target:GetMana()
			local burn_amount = math.min(target_mana, total_damage)

			if burn_amount > 0 then
				target:Script_ReduceMana(burn_amount, ability)
			end

			ApplyDamage({
				victim = target,
				attacker = caster,
				damage = total_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
				ability = ability,
			})
		end
	end

	--------------------------------------------------------------------------------

	modifier_golden_sea_hydro_stack = class({
		IsHidden = function()
			return false
		end,
		IsDebuff = function()
			return true
		end,
		IsPurgable = function()
			return false
		end,
	})

	function modifier_golden_sea_hydro_stack:GetTexture()
		return "shadow_shaman_voodoo"
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	LinkLuaModifier(
		"modifier_golden_sea_mirror_surface",
		"abilities/addition_bosses/golden_sea",
		LUA_MODIFIER_MOTION_NONE
	)

	golden_sea_mirror_surface = class({})

	function golden_sea_mirror_surface:Precache(context)
		PrecacheResource(
			"particle",
			"particles/units/heroes/hero_morphling/morphling_adaptive_strike_agi_proj.vpcf",
			context
		)
		PrecacheResource("particle", "particles/units/heroes/hero_morphling/morphling_adaptive_strike.vpcf", context)
		PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_morphling.vsndevts", context)
		PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_medusa.vsndevts", context)
		PrecacheResource("particle", "particles/units/heroes/hero_medusa/medusa_mana_shield_impact.vpcf", context)
	end

	function golden_sea_mirror_surface:OnSpellStart()
		local caster = self:GetCaster()
		local duration = self:GetSpecialValueFor("duration")

		caster:AddNewModifier(caster, self, "modifier_golden_sea_mirror_surface", { duration = duration })
		caster:EmitSound("Hero_Morphling.Replicate")
	end

	function golden_sea_mirror_surface:OnProjectileHit_ExtraData(target, vLocation, data)
		if not IsServer() then
			return
		end
		if target == nil then
			return
		end

		target:EmitSound("Hero_Morphling.AdaptiveStrikeAgi.Target")

		ApplyDamage({
			victim = target,
			attacker = self:GetCaster(),
			damage = data.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})

		if data.damage >= self:GetSpecialValueFor("stun_threshold") then
			target:AddNewModifier(
				self:GetCaster(),
				self,
				"modifier_stunned",
				{ duration = self:GetSpecialValueFor("stun_duration") }
			)
		end

		local nFXIndex = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_morphling/morphling_adaptive_strike.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			target
		)
		ParticleManager:SetParticleControlEnt(
			nFXIndex,
			0,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			target:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			nFXIndex,
			1,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			target:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(nFXIndex)
	end

	----------------------------------------------------------------

	modifier_golden_sea_mirror_surface = class({})

	function modifier_golden_sea_mirror_surface:IsHidden()
		return false
	end

	function modifier_golden_sea_mirror_surface:OnCreated()
		if not IsServer() then
			return
		end

		local particle = ParticleManager:CreateParticle(
			"particles/econ/taunts/snapfire/snapfire_taunt_bubble.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			particle,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetOrigin(),
			true
		)
		self:AddParticle(particle, false, false, -1, false, false)

		self.reflect_pct = self:GetAbility():GetSpecialValueFor("reflect_pct")
		self.damage_storage = {}
	end

	function modifier_golden_sea_mirror_surface:DeclareFunctions()
		return {
			MODIFIER_PROPERTY_AVOID_DAMAGE,
			MODIFIER_EVENT_ON_TAKEDAMAGE,
		}
	end

	function modifier_golden_sea_mirror_surface:GetModifierAvoidDamage()
		return 1
	end

	function modifier_golden_sea_mirror_surface:OnTakeDamage(keys)
		if not IsServer() then
			return
		end
		if keys.unit ~= self:GetParent() then
			return
		end
		if keys.attacker == keys.unit then
			return
		end

		local attacker_entindex = keys.attacker:GetEntityIndex()

		if not self.damage_storage[attacker_entindex] then
			self.damage_storage[attacker_entindex] = 0
		end

		self.damage_storage[attacker_entindex] = self.damage_storage[attacker_entindex] + (keys.original_damage or 0)
	end

	function modifier_golden_sea_mirror_surface:OnDestroy()
		if not IsServer() then
			return
		end
		local caster = self:GetCaster()
		local ability = self:GetAbility()

		if not ability or ability:IsNull() then
			return
		end

		for entindex, damage in pairs(self.damage_storage) do
			local hTarget = EntIndexToHScript(entindex)
			if hTarget and not hTarget:IsNull() and hTarget:IsAlive() then
				local WaterProj = {
					Target = hTarget,
					Source = caster,
					Ability = ability,
					EffectName = "particles/units/heroes/hero_morphling/morphling_adaptive_strike_agi_proj.vpcf",
					iMoveSpeed = ability:GetSpecialValueFor("projectile_speed"),
					bDodgeable = true,
					bVisibleToEnemies = true,
					bReplaceExisting = false,
					bProvidesVision = false,
					iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
					ExtraData = { damage = damage },
				}
				ProjectileManager:CreateTrackingProjectile(WaterProj)
			end
		end

		self.damage_storage = nil

		if self.pfx then
			ParticleManager:DestroyParticle(self.pfx, false)
			ParticleManager:ReleaseParticleIndex(self.pfx)
		end

		caster:EmitSound("Hero_Morphling.AdaptiveStrike.Target")
	end

	----------------------------------------------------------------
	----------------------------------------------------------------

	LinkLuaModifier("modifier_golden_sea_illusion", "abilities/addition_bosses/golden_sea", LUA_MODIFIER_MOTION_NONE)

	golden_sea_illusion = class({})

	function golden_sea_illusion:OnSpellStart()
		local caster = self:GetCaster()
		local radius = self:GetSpecialValueFor("radius")
		local duration = self:GetSpecialValueFor("duration")
		local incoming = 100
		local outgoing = 100

		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(enemies) do
			local illusions = CreateIllusions(caster, enemy, {
				outgoing_damage = outgoing,
				incoming_damage = incoming,
				duration = duration,
			}, 1, 64, true, true)

			for _, illusion in pairs(illusions) do
				illusion:AddNewModifier(caster, self, "modifier_golden_sea_illusion", {
					target_index = enemy:GetEntityIndex(),
				})

				local pfx = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					illusion
				)
				ParticleManager:ReleaseParticleIndex(pfx)
			end
		end

		caster:EmitSound("Hero_DarkSeer.Wall_Of_Replica_Start")
	end

	----------------------------------------------------------------

	modifier_golden_sea_illusion = class({})

	function modifier_golden_sea_illusion:IsHidden()
		return true
	end

	function modifier_golden_sea_illusion:OnCreated(params)
		if not IsServer() then
			return
		end
		self.target = EntIndexToHScript(params.target_index)
		self:StartIntervalThink(0.2)
	end

	function modifier_golden_sea_illusion:OnIntervalThink()
		local parent = self:GetParent()

		if not self.target or not self.target:IsAlive() or self.target:IsInvulnerable() then
			parent:ForceKill(false)
			return
		end

		if parent:GetAggroTarget() ~= self.target then
			parent:MoveToTargetToAttack(self.target)
		end
	end

	function modifier_golden_sea_illusion:CheckState()
		return {
			[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
			[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		}
	end

	function modifier_golden_sea_illusion:DeclareFunctions()
		return { MODIFIER_PROPERTY_STATUS_EFFECT_NAME }
	end

	function modifier_golden_sea_illusion:GetStatusEffectName()
		return "particles/status_fx/status_effect_dark_seer_illusion.vpcf"
	end
end)