--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_pangolier_gyroshell_custom",
	"abilities/pangolier/pangolier_gyroshell_custom",
	LUA_MODIFIER_MOTION_HORIZONTAL
)
LinkLuaModifier(
	"modifier_pangolier_gyroshell_custom_tracker",
	"abilities/pangolier/pangolier_gyroshell_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_pangolier_gyroshell_custom_heal_reduce",
	"abilities/pangolier/pangolier_gyroshell_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_pangolier_gyroshell_custom_delay",
	"abilities/pangolier/pangolier_gyroshell_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_pangolier_gyroshell_custom_stunned",
	"abilities/pangolier/pangolier_gyroshell_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_pangolier_rollup_custom",
	"abilities/pangolier/pangolier_gyroshell_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_pangolier_gyroshell_custom_turn_boost",
	"abilities/pangolier/pangolier_gyroshell_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_pangolier_gyroshell_custom_legendary_cast",
	"abilities/pangolier/pangolier_gyroshell_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_pangolier_gyroshell_custom_legendary",
	"abilities/pangolier/pangolier_gyroshell_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_pangolier_gyroshell_custom_legendary_health",
	"abilities/pangolier/pangolier_gyroshell_custom",
	LUA_MODIFIER_MOTION_NONE
)

pangolier_gyroshell_custom = class({})
pangolier_gyroshell_custom.talents = {}

function pangolier_gyroshell_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/pangolier/pangolier_gyroshell_cast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf", context)
	PrecacheResource("particle", "particles/items2_fx/vindicators_axe_armor.vpcf", context)
	PrecacheResource("particle", "particles/pangolier/buckle_refresh.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context)
	PrecacheResource("particle", "particles/pangolier/rolling_stack.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_blast_off_trail.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_stunned.vpcf", context)
	PrecacheResource("particle", "particles/pangolier/pangolier_gyroshell_cast.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_pangolier/pangolier_shard_rollup_cast_dust_poof.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", context)
	PrecacheResource("particle", "particles/beast_charge.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_pangolier/pangolier_shard_rollup_cast_dust_poof.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf",
		context
	)
	PrecacheResource("particle", "particles/lc_odd_charge.vpcf", context)
	PrecacheResource("particle", "particles/pangolier/pangolier_gyroshell_cast_fast.vpcf", context)
	PrecacheResource("particle", "particles/lc_odd_charge_mark.vpcf", context)
	PrecacheResource("particle", "particles/ogre_magi/multicast_radius.vpcf", context)
	PrecacheResource("model", "models/heroes/pangolier/pangolier_gyroshell2.vmdl", context)
end

function pangolier_gyroshell_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			has_r1 = 0,
			r1_spell = 0,
			r1_damage = 0,

			has_r2 = 0,
			r2_duration = 0,
			r2_cd = 0,

			has_r3 = 0,
			r3_damage = 0,
			r3_heal_reduce = 0,
			r3_max = caster:GetTalentValue("modifier_pangolier_rolling_3", "max", true) / 100,
			r3_damage_type = caster:GetTalentValue("modifier_pangolier_rolling_3", "damage_type", true),
			r3_duration = caster:GetTalentValue("modifier_pangolier_rolling_3", "duration", true),

			has_r4 = 0,
			r4_stun = caster:GetTalentValue("modifier_pangolier_rolling_4", "stun", true),
			r4_cd_items = caster:GetTalentValue("modifier_pangolier_rolling_4", "cd_items", true),
			r4_cd_items_legendary = caster:GetTalentValue("modifier_pangolier_rolling_4", "cd_items_legendary", true),
			r4_speed = caster:GetTalentValue("modifier_pangolier_rolling_4", "speed", true) / 100,

			has_r7 = 0,
			r7_health_reduce = caster:GetTalentValue("modifier_pangolier_rolling_7", "health_reduce", true),
			r7_damage = caster:GetTalentValue("modifier_pangolier_rolling_7", "damage", true) / 100,
			r7_speed = caster:GetTalentValue("modifier_pangolier_rolling_7", "speed", true),
			r7_max = caster:GetTalentValue("modifier_pangolier_rolling_7", "max", true),
			r7_effect_duration = caster:GetTalentValue("modifier_pangolier_rolling_7", "effect_duration", true),

			has_h2 = 0,
			h2_move = 0,

			has_h3 = 0,
			h3_cdr = 0,
			h3_mana = 0,

			has_h6 = 0,
			h6_bkb = caster:GetTalentValue("modifier_pangolier_hero_6", "bkb", true),
			h6_cast = caster:GetTalentValue("modifier_pangolier_hero_6", "cast", true),
			h6_status = caster:GetTalentValue("modifier_pangolier_hero_6", "status", true),

			has_w4 = 0,
			w4_duration = caster:GetTalentValue("modifier_pangolier_shield_4", "duration", true),

			has_w7 = 0,
			w7_stun_reduce = caster:GetTalentValue("modifier_pangolier_shield_7", "stun_reduce", true) / 100,

			has_w2 = 0,
			w2_radius = 0,
		}
	end

	if caster:HasTalent("modifier_pangolier_rolling_1") then
		self.talents.has_r1 = 1
		self.talents.r1_spell = caster:GetTalentValue("modifier_pangolier_rolling_1", "spell")
		self.talents.r1_damage = caster:GetTalentValue("modifier_pangolier_rolling_1", "damage") / 100
	end

	if caster:HasTalent("modifier_pangolier_rolling_2") then
		self.talents.has_r2 = 1
		self.talents.r2_duration = caster:GetTalentValue("modifier_pangolier_rolling_2", "duration")
		self.talents.r2_cd = caster:GetTalentValue("modifier_pangolier_rolling_2", "cd")
	end

	if caster:HasTalent("modifier_pangolier_rolling_3") then
		self.talents.has_r3 = 1
		self.talents.r3_damage = caster:GetTalentValue("modifier_pangolier_rolling_3", "damage") / 100
		self.talents.r3_heal_reduce = caster:GetTalentValue("modifier_pangolier_rolling_3", "heal_reduce")
	end

	if caster:HasTalent("modifier_pangolier_rolling_4") then
		self.talents.has_r4 = 1
	end

	if caster:HasTalent("modifier_pangolier_rolling_7") then
		self.talents.has_r7 = 1
	end

	if caster:HasTalent("modifier_pangolier_hero_2") then
		self.talents.has_h2 = 1
		self.talents.h2_move = caster:GetTalentValue("modifier_pangolier_hero_2", "move")
	end

	if caster:HasTalent("modifier_pangolier_hero_3") then
		self.talents.has_h3 = 1
		self.talents.h3_cdr = caster:GetTalentValue("modifier_pangolier_hero_3", "cdr")
		self.talents.h3_mana = caster:GetTalentValue("modifier_pangolier_hero_3", "mana")
	end

	if caster:HasTalent("modifier_pangolier_hero_6") then
		self.talents.has_h6 = 1
	end

	if caster:HasTalent("modifier_pangolier_shield_4") then
		self.talents.has_w4 = 1
	end

	if caster:HasTalent("modifier_pangolier_shield_7") then
		self.talents.has_w7 = 1
	end

	if caster:HasTalent("modifier_pangolier_shield_2") then
		self.talents.has_w2 = 1
		self.talents.w2_radius = caster:GetTalentValue("modifier_pangolier_shield_2", "radius") / 100
	end
end

function pangolier_gyroshell_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_pangolier_gyroshell_custom_tracker"
end

function pangolier_gyroshell_custom:GetAbilityTextureName()
	if self.caster:HasModifier("modifier_pangolier_gyroshell_custom") then
		return "pangolier_gyroshell_stop"
	end
	return wearables_system:GetAbilityIconReplacement(self.caster, "pangolier_gyroshell", self)
end

function pangolier_gyroshell_custom:GetManaCost(level)
	if self.caster:HasModifier("modifier_pangolier_gyroshell_custom") then
		return 0
	end
	return self.BaseClass.GetManaCost(self, level)
end

function pangolier_gyroshell_custom:GetBehavior()
	if self.caster:HasModifier("modifier_pangolier_gyroshell_custom") then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
		+ DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
		+ DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function pangolier_gyroshell_custom:GetCooldown(iLevel)
	return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.r2_cd or 0)
end

function pangolier_gyroshell_custom:GetCastPoint(iLevel)
	return self.BaseClass.GetCastPoint(self) + (self.talents.has_h6 == 1 and self.talents.h6_cast or 0)
end

function pangolier_gyroshell_custom:GetStun()
	local result = self.stun_duration + (self.talents.has_r4 == 1 and self.talents.r4_stun or 0)
	if self.talents.has_w7 == 1 then
		result = result * (1 + self.talents.w7_stun_reduce)
	end
	return result
end

function pangolier_gyroshell_custom:OnAbilityPhaseStart()
	self.caster:EmitSound("Hero_Pangolier.Gyroshell.Cast")
	local particle = "particles/pangolier/pangolier_gyroshell_cast.vpcf"
	local k = 1
	if self.talents.has_h6 == 1 then
		particle = "particles/pangolier/pangolier_gyroshell_cast_fast.vpcf"
		k = 1.5
	end

	self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, k)

	self.cast_effect = ParticleManager:CreateParticle(particle, PATTACH_CUSTOMORIGIN, self.caster)
	ParticleManager:SetParticleControlEnt(
		self.cast_effect,
		0,
		self.caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.cast_effect,
		3,
		self.caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(self.cast_effect, 0, self.caster:GetForwardVector())
	ParticleManager:SetParticleControlForward(self.cast_effect, 3, self.caster:GetForwardVector())

	return true
end

function pangolier_gyroshell_custom:OnAbilityPhaseInterrupted()
	if self.cast_effect then
		ParticleManager:DestroyParticle(self.cast_effect, true)
		ParticleManager:ReleaseParticleIndex(self.cast_effect)
		self.cast_effect = nil
	end

	self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
	self.caster:StopSound("Hero_Pangolier.Gyroshell.Cast")
end

function pangolier_gyroshell_custom:OnSpellStart()
	local mod = self.caster:FindModifierByName("modifier_pangolier_gyroshell_custom")
	if mod then
		mod:Destroy()
		return
	end

	self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)

	if self.cast_effect then
		ParticleManager:DestroyParticle(self.cast_effect, true)
		ParticleManager:ReleaseParticleIndex(self.cast_effect)
		self.cast_effect = nil
	end

	self.caster:Purge(false, true, false, false, false)
	self.caster:AddNewModifier(self.caster, self, "modifier_pangolier_gyroshell_custom", {})
end

function pangolier_gyroshell_custom:DealDamage(enemy, scepter_k)
	if not IsServer() then
		return
	end

	if self.talents.has_r3 == 1 then
		enemy:AddNewModifier(
			self.caster,
			self,
			"modifier_pangolier_gyroshell_custom_heal_reduce",
			{ duration = self.talents.r3_duration }
		)
		local mod = self.caster:FindModifierByName("modifier_pangolier_gyroshell_custom")
		if mod and not mod.targets[enemy] then
			mod.targets[enemy] = true
			enemy:AddNewModifier(self.caster, self, "modifier_pangolier_gyroshell_custom_delay", {})
		end
	end

	if IsValid(self.caster.lucky_ability) then
		self.caster.lucky_ability:ProcPassive(enemy)
	end

	local damage = self.damage + self.caster:GetIntellect(false) * self.talents.r1_damage
	local damage_ability = nil

	local legendary = self.parent:FindModifierByName("modifier_pangolier_gyroshell_custom_legendary")
	if legendary then
		damage = damage * self.ability.talents.r7_damage
		damage_ability = "modifier_pangolier_rolling_7"

		if enemy:IsRealHero() then
			enemy:EmitSound("Pango.Ulti_legendary_hit")
			enemy:AddNewModifier(
				self.caster,
				self.caster:BkbAbility(self.ability, true),
				"modifier_pangolier_gyroshell_custom_legendary_health",
				{ duration = self.ability.talents.r7_effect_duration }
			)
			legendary:SetDuration(0.2, true)
		end
	elseif not scepter_k then
		self.caster.pangolier_r = true
		self.caster:PerformAttack(enemy, true, true, true, true, false, false, true, { damage = "pangolier_r" })
		self.caster.pangolier_r = false

		if IsValid(self.caster.lucky_ability) then
			self.caster.lucky_ability:ProcPassive(enemy)
		end

		if enemy:IsRealHero() then
			self:ProcCd()
			if self.caster:GetQuest() == "Pangolier.Quest_8" then
				self.caster:UpdateQuest(1)
			end
		end

		if IsValid(self.caster.shield_ability) then
			self.caster.shield_ability:ApplyMagic(enemy)

			if self.caster.shield_ability.talents.has_w1 == 1 then
				enemy:AddNewModifier(
					self.caster,
					self.caster.shield_ability,
					"modifier_pangolier_shield_crash_custom_burn",
					{}
				)
			end
		end
	else
		damage = damage * scepter_k
	end

	local real_damage = DoDamage(
		{ victim = enemy, attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self },
		damage_ability
	)
	enemy:SendNumber(4, real_damage)

	enemy:EmitSound(enemy:IsHero() and "Hero_Pangolier.Gyroshell.Stun" or "Hero_Pangolier.Gyroshell.Stun.Creep")

	enemy:RemoveModifierByName("modifier_pangolier_gyroshell_custom_stunned")
	enemy:AddNewModifier(
		self.caster,
		self,
		"modifier_pangolier_gyroshell_custom_stunned",
		{
			duration = self.bounce_duration + self:GetStun() * (1 - enemy:GetStatusResistance()),
			is_scepter = scepter_k and 1 or 0,
		}
	)
end

function pangolier_gyroshell_custom:RollUpDamage(new_radius)
	if not IsServer() then
		return
	end

	local hit_radius = new_radius or (self.hit_radius * (1 + self.talents.w2_radius))
	local cd = 1.4
	local cd_name = self.caster:HasModifier("modifier_pangolier_gyroshell_custom_legendary") and "pangolier_r_legendary"
		or "pangolier_r"

	for _, enemy in pairs(self.caster:FindTargets(hit_radius)) do
		if enemy:CheckCd(cd_name, cd) then
			enemy:StartCd("pangolier_r", cd)
			self:DealDamage(enemy)
		end
	end
end

function pangolier_gyroshell_custom:ProcCd(is_reduced)
	if not IsServer() then
		return
	end
	if not self:IsTrained() then
		return
	end
	if self.ability.talents.has_r4 == 0 then
		return
	end

	local cd_items = is_reduced and self.talents.r4_cd_items_legendary or self.talents.r4_cd_items
	self.caster:CdItems(cd_items)
end

modifier_pangolier_gyroshell_custom = class(mod_visible)
function modifier_pangolier_gyroshell_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.base_max = self.ability.forward_move_speed + self.ability.talents.h2_move
	self.max_speed = self.base_max
	self.duration = self.ability.duration + self.ability.talents.r2_duration

	if not IsServer() then
		return
	end
	self.timer = self.duration

	self.RemoveForDuel = true
	self.ability:EndCd(0.5)
	self.parent:Stop()

	self.legendary_count = self.ability.talents.r7_max

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_pangolier_gyroshell_custom_turn_boost",
		{ duration = self.ability.jump_recover_time }
	)
	self.parent:RemoveModifierByName("modifier_pangolier_rollup_custom")
	self.parent:RemoveModifierByName("modifier_pangolier_shield_crash_custom_health")

	self.bkb_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {})

	self.parent:EmitSound("Hero_Pangolier.Gyroshell.Layer")

	self.targets = {}
	self.acceleration = 350
	self.deceleration = 500
	self.turn_rate = self.ability.turn_rate

	self.flCurrentSpeed = self.max_speed
	self.flDespawnTime = 0.5
	self.nTreeDestroyRadius = 75

	if self.parent.flDesiredYaw == nil then
		self.parent.flDesiredYaw = self.parent:GetAnglesAsVector().y
	end

	if self.ability.talents.has_r7 == 1 and IsValid(self.parent.rolling_ability_legendary) then
		self.parent.rolling_ability_legendary:SetActivated(true)
	end

	self.interval = 0.01
	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_pangolier_gyroshell_custom:OnIntervalThink()
	if not IsServer() then
		return
	end

	if
		self.parent:HasModifier("modifier_pangolier_rollup_custom")
		or self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary_cast")
	then
		if self.cast_effect then
			self.parent:RemoveGesture(ACT_DOTA_RUN)
			self.parent:StopSound("Hero_Pangolier.Gyroshell.Loop")

			ParticleManager:DestroyParticle(self.cast_effect, false)
			ParticleManager:ReleaseParticleIndex(self.cast_effect)
			self.cast_effect = false
		end
		return
	elseif not self.cast_effect then
		self.cast_effect = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			self.cast_effect,
			0,
			self.parent,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			self.parent:GetAbsOrigin(),
			true
		)
		self:AddParticle(self.cast_effect, false, false, -1, false, false)

		self.is_anim = true
		self.parent:StartGesture(ACT_DOTA_RUN)
		self.parent:EmitSound("Hero_Pangolier.Gyroshell.Loop")
	end

	if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary") then
		self.max_speed = self.ability.talents.r7_speed
	else
		self.max_speed = self.base_max
	end

	self.flCurrentSpeed = self.max_speed

	if
		self.parent:HasModifier("modifier_pangolier_gyroshell_custom_turn_boost")
		or self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary")
	then
		self.turn_rate = self.ability.turn_rate_boosted
	else
		self.turn_rate = self.ability.turn_rate
	end
	self.turn_rate = self.turn_rate * (1 + (self.ability.talents.has_r4 == 1 and self.ability.talents.r4_speed or 0))

	self.parent:SetForceAttackTarget(nil)

	if not IsValid(self.parent.shield_jump) then
		self.ability:RollUpDamage()
	end

	self:UpdateHorizontalMotionCustom()

	if self.ability.talents.has_r7 == 1 and self.parent:CheckCd("pangolier_visual", 0.1) and self.timer > 0 then
		self.parent:UpdateUIshort({
			max_time = self.duration,
			time = self.timer,
			stack = self.legendary_count,
			priority = 2,
			style = "PangolierRolling",
		})
	end

	if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary") then
		return
	end

	self.timer = self.timer - self.interval
	if self.visual_timer ~= math.floor(self.timer + 1) then
		self.visual_timer = math.floor(self.timer + 1)

		if IsValid(self.parent.shield_ability) and self.ability.talents.has_w4 == 1 and self:GetStackCount() ~= 0 then
			self.parent:AddNewModifier(
				self.parent,
				self.parent.shield_ability,
				"modifier_pangolier_shield_crash_custom_health",
				{ duration = self.ability.talents.w4_duration }
			)
		end
		self:SetStackCount(self.visual_timer)

		if self.timer <= 0 then
			self:Destroy()
			return
		end
	end
end

function modifier_pangolier_gyroshell_custom:OnOrderCustom(new_pos, target)
	if not IsServer() then
		return
	end
	if
		self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary_cast")
		or self.parent:HasModifier("modifier_pangolier_rollup_custom")
	then
		return
	end

	local vTargetPos = new_pos
	if target ~= nil and target:IsNull() == false then
		vTargetPos = target:GetAbsOrigin()
	end

	local vMountOrigin = self.parent:GetOrigin()
	if self.angle_correction ~= nil and self.angle_correction > 0 then
		local flOrderDist = (vMountOrigin - vTargetPos):Length2D()
		vMountOrigin = vMountOrigin
			+ self.parent:GetForwardVector() * math.min(self.angle_correction, flOrderDist * 0.75)
	end

	local vDir = vTargetPos - vMountOrigin
	vDir.z = 0
	vDir = vDir:Normalized()
	local angles = VectorAngles(vDir)
	self.parent.flDesiredYaw = angles.y
end

function modifier_pangolier_gyroshell_custom:UpdateHorizontalMotionCustom()
	if not IsServer() or not self.parent then
		return
	end
	if
		self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary_cast")
		or self.parent:HasModifier("modifier_pangolier_rollup_custom")
	then
		return
	end

	if
		(
			self.parent:IsCurrentlyHorizontalMotionControlled()
			or self.parent:IsCurrentlyVerticalMotionControlled()
			or self.parent:IsStunned()
			or self.parent:IsRooted()
		) and not self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary")
	then
		return
	end

	local curAngles = self.parent:GetAnglesAsVector()
	local flAngleDiff = AngleDiff(self.parent.flDesiredYaw, curAngles.y) or 0
	local flTurnAmount = self.interval * self:GetSpeedMultiplier() * self.turn_rate

	flTurnAmount = math.min(flTurnAmount, math.abs(flAngleDiff))

	if flAngleDiff < 0.0 then
		flTurnAmount = flTurnAmount * -1
	end

	if flAngleDiff ~= 0.0 then
		curAngles.y = curAngles.y + flTurnAmount
		self.parent:SetAbsAngles(curAngles.x, curAngles.y, curAngles.z)
	end

	local flMaxSpeed = self.max_speed
	local flAcceleration = self.acceleration or -self.deceleration

	self.flCurrentSpeed = math.max(math.min(self.flCurrentSpeed + (self.interval * flAcceleration), flMaxSpeed), 0)

	local vNewPos = self.parent:GetOrigin() + self.parent:GetForwardVector() * self.interval * self.flCurrentSpeed

	local range_vector = self.parent:GetForwardVector()
	local check_pos = vNewPos + range_vector

	if not GridNav:CanFindPath(self.parent:GetOrigin(), check_pos) then
		GridNav:DestroyTreesAroundPoint(check_pos, self.nTreeDestroyRadius, true)
		if
			not self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary")
			and not GridNav:CanFindPath(self.parent:GetOrigin(), check_pos)
			and self.parent:CheckCd("pangolier_crash", 1)
		then
			self:Crash()
			return
		end
	end

	self.parent:SetOrigin(GetGroundPosition(vNewPos, nil))
end

function modifier_pangolier_gyroshell_custom:Crash()
	if not IsServer() then
		return
	end

	local resetDistance = 0
	local vResetPos = self.parent:GetAbsOrigin()
	local vAngles = self.parent:GetAngles()
	local old_vec = self.parent:GetForwardVector()

	self.parent:FaceTowards(self.parent:GetAbsOrigin() - old_vec)
	self.parent:SetForwardVector(old_vec * -1)
	self.parent:SetOrigin(vResetPos)
	self.parent.flDesiredYaw = self.parent:GetAnglesAsVector().y

	self.parent:RemoveModifierByName("modifier_pangolier_gyroshell_custom_legendary")
	self.parent:EmitSound("Hero_Pangolier.Gyroshell.Carom")
	self.parent:EmitSound("Hero_Pangolier.Carom.Layer")

	self.parent.roll_crash_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_arc", {
		dir_x = old_vec.x * -1,
		dir_x = old_vec.y * -1,
		distance = 0,
		height = 50,
		duration = self.ability.jump_recover_time,
		fix_end = true,
		end_offset = 1,
	})

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_pangolier_gyroshell_custom_turn_boost",
		{ duration = 2 * self.ability.jump_recover_time }
	)
end

function modifier_pangolier_gyroshell_custom:OnDestroy()
	if not IsServer() then
		return
	end

	self.parent:UpdateUIshort({ hide = 1, hide_full = 1, priority = 2, style = "PangolierRolling" })

	if IsValid(self.bkb_mod) then
		self.bkb_mod:Destroy()
	end

	for target, _ in pairs(self.targets) do
		if IsValid(target) then
			target:RemoveModifierByName("modifier_pangolier_gyroshell_custom_delay")
		end
	end

	if not IsValid(self.parent.shield_jump) then
		FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)
	end

	if IsValid(self.parent.shield_ability) and self.ability.talents.has_w4 == 1 then
		self.parent.shield_ability:AddShield()
	end

	if self.ability.talents.has_r7 == 1 and IsValid(self.parent.rolling_ability_legendary) then
		self.parent.rolling_ability_legendary:SetActivated(false)
	end

	if not self.parent:HasModifier("modifier_pangolier_rollup_custom") then
		self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
		self.parent:EmitSound("Hero_Pangolier.Gyroshell.Stop")
	end

	self.parent:RemoveGesture(ACT_DOTA_RUN)
	self.parent:RemoveGesture(ACT_DOTA_IDLE)
	self.parent:RemoveModifierByName("modifier_pangolier_gyroshell_custom_legendary")
	self.parent:RemoveModifierByName("modifier_pangolier_gyroshell_custom_legendary_cast")
	self.parent:StopSound("Hero_Pangolier.Gyroshell.Loop")
	self.parent:StopSound("Hero_Pangolier.Gyroshell.Layer")

	if self.ability.talents.has_h6 == 1 then
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_generic_debuff_immune",
			{ duration = self.ability.talents.h6_bkb, effect = 2 }
		)
	end

	self.ability:StartCd()
end

function modifier_pangolier_gyroshell_custom:GetSpeedMultiplier()
	return 0.5 + 0.5 * (self.flCurrentSpeed / self.max_speed)
end

function modifier_pangolier_gyroshell_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
	}
end

function modifier_pangolier_gyroshell_custom:GetModifierModelChange()
	return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
end

function modifier_pangolier_gyroshell_custom:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
	}
end

function modifier_pangolier_gyroshell_custom:GetModifierDisableTurning(params)
	return 1
end

function modifier_pangolier_gyroshell_custom:GetModifierTotalPercentageManaRegen()
	if
		self.parent:HasModifier("modifier_pangolier_gyroshell_custom_legendary_cast")
		or self.parent:HasModifier("modifier_pangolier_rollup_custom")
	then
		return
	end
	return self.ability.talents.h3_mana
end

function modifier_pangolier_gyroshell_custom:GetModifierMoveSpeed_Absolute()
	if IsServer() then
		return 0.1
	end
	return self.max_speed
end

modifier_pangolier_gyroshell_custom_tracker = class(mod_hidden)
function modifier_pangolier_gyroshell_custom_tracker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.parent.rolling_ability = self.ability
	self.parent.rolling_ability_legendary = self.parent:FindAbilityByName("pangolier_gyroshell_custom_legendary")
	if self.parent.rolling_ability_legendary then
		self.parent.rolling_ability_legendary:UpdateTalents()
	end

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
	self.ability.attack_damage = self.ability:GetSpecialValueFor("attack_damage")
	self.ability.forward_move_speed = self.ability:GetSpecialValueFor("forward_move_speed")
	self.ability.turn_rate_boosted = self.ability:GetSpecialValueFor("turn_rate_boosted")
	self.ability.turn_rate = self.ability:GetSpecialValueFor("turn_rate")
	self.ability.hit_radius = self.ability:GetSpecialValueFor("hit_radius")
	self.ability.bounce_duration = self.ability:GetSpecialValueFor("bounce_duration")
	self.ability.knockback_radius = self.ability:GetSpecialValueFor("knockback_radius")
	self.ability.jump_recover_time = self.ability:GetSpecialValueFor("jump_recover_time")
end

function modifier_pangolier_gyroshell_custom_tracker:OnRefresh()
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
end

function modifier_pangolier_gyroshell_custom_tracker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_pangolier_gyroshell_custom_tracker:GetModifierSpellAmplify_Percentage()
	return self.ability.talents.r1_spell
end

function modifier_pangolier_gyroshell_custom_tracker:GetModifierPercentageCooldown()
	return self.ability.talents.h3_cdr
end

function modifier_pangolier_gyroshell_custom_tracker:GetModifierStatusResistanceStacking()
	if self.ability.talents.has_h6 == 0 then
		return
	end
	return self.ability.talents.h6_status
end

function modifier_pangolier_gyroshell_custom_tracker:GetModifierTotalDamageOutgoing_Percentage(params)
	if not self.parent.pangolier_r or params.inflictor then
		return
	end
	return self.ability.attack_damage - 100
end

modifier_pangolier_gyroshell_custom_heal_reduce = class(mod_hidden)
function modifier_pangolier_gyroshell_custom_heal_reduce:OnCreated(table)
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.heal_reduce = self.ability.talents.r3_heal_reduce
end

function modifier_pangolier_gyroshell_custom_heal_reduce:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_pangolier_gyroshell_custom_heal_reduce:GetModifierHealChange()
	return self.heal_reduce
end

function modifier_pangolier_gyroshell_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage()
	return self.heal_reduce
end

modifier_pangolier_gyroshell_custom_stunned = class(mod_hidden)
function modifier_pangolier_gyroshell_custom_stunned:IsStunDebuff()
	return true
end
function modifier_pangolier_gyroshell_custom_stunned:IsPurgeException()
	return true
end
function modifier_pangolier_gyroshell_custom_stunned:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	local target_point = self.parent:GetAbsOrigin()
	local direction = (self.parent:GetAbsOrigin() - self.caster:GetAbsOrigin()):Normalized()
	local knock_duration = self.ability.bounce_duration
	local distance = self.ability.knockback_radius

	if table.is_scepter == 1 and IsValid(self.caster.shield_ability) then
		local max_dist = self.caster.shield_ability.scepter_pull_distance
		local point = self.caster:GetAbsOrigin() + direction * max_dist
		knock_duration = 0.3

		if (target_point - self.caster:GetAbsOrigin()):Length2D() > max_dist then
			local pull_point = point + (target_point - point):Normalized() * max_dist
			direction = pull_point - target_point
			distance = direction:Length2D()
			direction = direction:Normalized()
		else
			distance = 0
		end
	end

	local mod = self.parent:AddNewModifier(self.caster, self.ability, "modifier_generic_arc", {
		dir_x = direction.x,
		dir_y = direction.y,
		duration = knock_duration,
		distance = distance,
		fix_end = false,
		isStun = true,
		IsFlail = true,
		height = 100,
		activity = ACT_DOTA_FLAIL,
	})

	self.parent:GenericParticle("particles/generic_gameplay/generic_stunned.vpcf", self, true)

	local particle_stomp_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_centaur/centaur_warstomp.vpcf",
		PATTACH_ABSORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControl(particle_stomp_fx, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_stomp_fx, 1, Vector(300, 1, 1))
	ParticleManager:SetParticleControl(particle_stomp_fx, 2, self.parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_stomp_fx)

	local cast_effect = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_blast_off_trail.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		cast_effect,
		0,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		cast_effect,
		1,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	mod:AddParticle(cast_effect, false, false, -1, false, false)

	self:StartIntervalThink(knock_duration)
end

function modifier_pangolier_gyroshell_custom_stunned:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:RemoveGesture(ACT_DOTA_FLAIL)
	self.parent:StartGesture(ACT_DOTA_DISABLED)

	self:StartIntervalThink(-1)
end

function modifier_pangolier_gyroshell_custom_stunned:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_pangolier_gyroshell_custom_stunned:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:FadeGesture(ACT_DOTA_DISABLED)
end

pangolier_rollup_custom = class({})

function pangolier_rollup_custom:Spawn()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.turn_rate_boosted = self:GetLevelSpecialValueFor("turn_rate_boosted", 1)
	self.hit_radius = self:GetLevelSpecialValueFor("hit_radius", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.damage_cd = self:GetLevelSpecialValueFor("damage_cd", 1)
end

function pangolier_rollup_custom:GetAbilityTextureName()
	if self.caster:HasModifier("modifier_pangolier_rollup_custom") then
		return "pangolier_gyroshell_stop"
	end
	return "pangolier_rollup"
end

function pangolier_rollup_custom:GetManaCost(level)
	if self.caster:HasModifier("modifier_pangolier_rollup_custom") then
		return 0
	end
	return self.BaseClass.GetManaCost(self, level)
end

function pangolier_rollup_custom:GetBehavior()
	if
		self.caster:HasModifier("modifier_pangolier_gyroshell_custom")
		or self.caster:HasModifier("modifier_pangolier_rollup_custom")
	then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function pangolier_rollup_custom:OnAbilityPhaseStart()
	self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 3)

	self.cast_effect = ParticleManager:CreateParticle(
		"particles/pangolier/pangolier_gyroshell_cast.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControlEnt(
		self.cast_effect,
		0,
		self.caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.cast_effect,
		3,
		self.caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(self.cast_effect, 0, self.caster:GetForwardVector())
	ParticleManager:SetParticleControlForward(self.cast_effect, 3, self.caster:GetForwardVector())

	return true
end

function pangolier_rollup_custom:OnAbilityPhaseInterrupted()
	if self.cast_effect then
		ParticleManager:DestroyParticle(self.cast_effect, true)
		ParticleManager:ReleaseParticleIndex(self.cast_effect)
		self.cast_effect = nil
	end
	self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
end

function pangolier_rollup_custom:OnSpellStart()
	local mod = self.caster:FindModifierByName("modifier_pangolier_rollup_custom")
	if mod then
		mod:Destroy()
		return
	end

	self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)

	if self.cast_effect then
		ParticleManager:DestroyParticle(self.cast_effect, true)
		ParticleManager:ReleaseParticleIndex(self.cast_effect)
		self.cast_effect = nil
	end

	self.caster:AddNewModifier(self.caster, self, "modifier_pangolier_rollup_custom", { duration = self.duration })
end

modifier_pangolier_rollup_custom = class(mod_visible)
function modifier_pangolier_rollup_custom:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.parent:AddAttackEvent_inc(self, true)
	self.parent:AddOrderEvent(self)

	self.parent:Stop()
	self.parent:NoDraw(self)

	self.ability:EndCd(0.5)

	self.parent:GenericParticle("particles/units/heroes/hero_pangolier/pangolier_shard_rollup_cast_dust_poof.vpcf")

	self.turn_rate = self.ability.turn_rate_boosted

	local first_point = self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 100
	self:SetDirection(Vector(first_point.x, first_point.y, 0))
	self.current_dir = self.target_dir
	self.turn_speed = FrameTime() * self.turn_rate
	self.proj_time = 0

	self.bkb_mod = self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_generic_debuff_immune",
		{ effect = 1, duration = self:GetRemainingTime() }
	)

	self.parent:StartGesture(ACT_DOTA_SPAWN)
	self.parent:EmitSound("Hero_Pangolier.Gyroshell.Layer")

	self.interval = FrameTime()

	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_pangolier_rollup_custom:AttackEvent_inc(params)
	if not IsServer() then
		return
	end
	if not IsValid(self.parent.rolling_ability) then
		return
	end
	if params.attacker == self.parent then
		return
	end
	if params.target ~= self.parent then
		return
	end
	if not self.parent:CheckCd("pangolier_shard", self.ability.damage_cd) then
		return
	end

	self.parent:RemoveGesture(ACT_DOTA_SPAWN)
	self.parent:StartGesture(ACT_DOTA_SPAWN)

	local smash = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(smash, 0, self.parent:GetAbsOrigin())
	ParticleManager:DestroyParticle(smash, false)
	ParticleManager:ReleaseParticleIndex(smash)

	self.parent.rolling_ability:RollUpDamage(self.ability.hit_radius)
end

function modifier_pangolier_rollup_custom:OrderEvent(params)
	if not IsServer() then
		return
	end
	local order = params.order_type

	if order == DOTA_UNIT_ORDER_MOVE_TO_POSITION or order == DOTA_UNIT_ORDER_MOVE_TO_DIRECTION then
		self:SetDirection(params.pos)
	elseif (order == DOTA_UNIT_ORDER_MOVE_TO_TARGET or order == DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target then
		self:SetDirection(params.target:GetOrigin())
	end
end

function modifier_pangolier_rollup_custom:SetDirection(vec)
	if vec.x == self.parent:GetAbsOrigin().x and vec.y == self.parent:GetAbsOrigin().y then
		vec = self.parent:GetAbsOrigin() + 100 * self.parent:GetForwardVector()
	end
	self.target_dir = ((vec - self.parent:GetOrigin()) * Vector(1, 1, 0)):Normalized()
	self.face_target = false
end

function modifier_pangolier_rollup_custom:OnIntervalThink()
	if not IsServer() then
		return
	end
	self:TurnLogic()
end

function modifier_pangolier_rollup_custom:TurnLogic()
	if self.face_target then
		return
	end

	local current_angle = VectorToAngles(self.current_dir).y
	local target_angle = VectorToAngles(self.target_dir).y
	local angle_diff = AngleDiff(current_angle, target_angle)
	local sign = -1
	if angle_diff < 0 then
		sign = 1
	end
	if math.abs(angle_diff) < 1.1 * self.turn_speed then
		self.current_dir = self.target_dir
		self.face_target = true
	else
		self.current_dir = RotatePosition(Vector(0, 0, 0), QAngle(0, sign * self.turn_speed, 0), self.current_dir)
	end
	local a = self.parent:IsCurrentlyHorizontalMotionControlled()
	local b = self.parent:IsCurrentlyVerticalMotionControlled()
	if not (a or b) then
		self.parent:SetForwardVector(self.current_dir)
	end
end

function modifier_pangolier_rollup_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_pangolier_rollup_custom:GetOverrideAnimation()
	return ACT_DOTA_IDLE
end

function modifier_pangolier_rollup_custom:GetModifierModelChange()
	return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
end

function modifier_pangolier_rollup_custom:GetModifierMoveSpeed_Limit()
	return 0.1
end

function modifier_pangolier_rollup_custom:GetModifierDisableTurning()
	return 1
end

function modifier_pangolier_rollup_custom:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_pangolier_rollup_custom:OnDestroy()
	if not IsServer() then
		return
	end

	self.parent:RemoveGesture(ACT_DOTA_SPAWN)

	if IsValid(self.bkb_mod) then
		self.bkb_mod:Destroy()
	end

	if not self.parent:HasModifier("modifier_pangolier_gyroshell_custom") then
		self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
		self.parent:EmitSound("Hero_Pangolier.Gyroshell.Stop")
		self.parent:StopSound("Hero_Pangolier.Gyroshell.Layer")
	end

	self.ability:StartCd()
end

modifier_pangolier_gyroshell_custom_turn_boost = class(mod_hidden)

pangolier_gyroshell_custom_legendary = class({})
pangolier_gyroshell_custom_legendary.talents = {}

function pangolier_gyroshell_custom_legendary:CreateTalent()
	self.caster:SwapAbilities(self:GetName(), "pangolier_heartpiercer_custom", true, false)
	self:SetLevel(1)
	self:SetActivated(false)
end

function pangolier_gyroshell_custom_legendary:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			has_r7 = 0,
			r7_turn_rate = caster:GetTalentValue("modifier_pangolier_rolling_7", "turn_rate", true),
			r7_max = caster:GetTalentValue("modifier_pangolier_rolling_7", "max", true),
			r7_cast_duration = caster:GetTalentValue("modifier_pangolier_rolling_7", "cast_duration", true),
			r7_duration = caster:GetTalentValue("modifier_pangolier_rolling_7", "duration", true),
			r7_speed = caster:GetTalentValue("modifier_pangolier_rolling_7", "speed", true),
			r7_talent_cd = caster:GetTalentValue("modifier_pangolier_rolling_7", "talent_cd", true),
		}
	end

	if caster:HasTalent("modifier_pangolier_shield_7") then
		self.talents.has_w7 = 1
	end
end

function pangolier_gyroshell_custom_legendary:GetCooldown()
	return self.talents.r7_talent_cd or 0
end

function pangolier_gyroshell_custom_legendary:OnSpellStart()
	self.caster:AddNewModifier(
		self.caster,
		self,
		"modifier_pangolier_gyroshell_custom_legendary_cast",
		{ duration = self.talents.r7_cast_duration }
	)
end

modifier_pangolier_gyroshell_custom_legendary_cast = class(mod_hidden)
function modifier_pangolier_gyroshell_custom_legendary_cast:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.parent:EmitSound("Pango.Ulti_legendary")
	self.parent:RemoveModifierByName("modifier_pangolier_rollup_custom")

	self.hit_radius = self.parent.rolling_ability.hit_radius

	self.parent:AddOrderEvent(self)
	self.parent:StartGesture(ACT_DOTA_SPAWN)

	self.effect_cast =
		ParticleManager:CreateParticle("particles/beast_charge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 2, Vector(self.hit_radius, 0, 0))
	self:AddParticle(self.effect_cast, false, false, -1, false, false)

	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf",
		PATTACH_POINT_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	self:AddParticle(effect_cast, false, false, -1, false, false)

	self.parent:GenericParticle("particles/units/heroes/hero_pangolier/pangolier_shard_rollup_cast_dust_poof.vpcf")

	local radius = self.ability.talents.r7_duration * self.ability.talents.r7_speed

	self.radius_visual = ParticleManager:CreateParticleForPlayer(
		"particles/ogre_magi/multicast_radius.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent,
		self.parent:GetPlayerOwner()
	)
	ParticleManager:SetParticleControl(self.radius_visual, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.radius_visual, 1, Vector(radius, 0, 0))
	self:AddParticle(self.radius_visual, false, false, -1, false, false)

	AddFOWViewer(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), radius, 3, false)

	self.turn_rate = self.ability.talents.r7_turn_rate

	local first_point = self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 100
	self:SetDirection(Vector(first_point.x, first_point.y, 0))
	self.current_dir = self.target_dir

	self.interval = 0.01
	self.turn_speed = self.interval * self.turn_rate

	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_pangolier_gyroshell_custom_legendary_cast:CheckState()
	return {
		[MODIFIER_STATE_SILENCED] = true,
	}
end

function modifier_pangolier_gyroshell_custom_legendary_cast:OrderEvent(params)
	if not IsServer() then
		return
	end
	local order = params.order_type

	if order == DOTA_UNIT_ORDER_MOVE_TO_POSITION or order == DOTA_UNIT_ORDER_MOVE_TO_DIRECTION then
		self:SetDirection(params.pos)
	elseif (order == DOTA_UNIT_ORDER_MOVE_TO_TARGET or order == DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target then
		self:SetDirection(params.target:GetOrigin())
	end
end

function modifier_pangolier_gyroshell_custom_legendary_cast:SetDirection(vec)
	if not IsServer() then
		return
	end
	if vec.x == self.parent:GetAbsOrigin().x and vec.y == self.parent:GetAbsOrigin().y then
		vec = self.parent:GetAbsOrigin() + 100 * self.parent:GetForwardVector()
	end
	self.target_dir = ((vec - self.parent:GetOrigin()) * Vector(1, 1, 0)):Normalized()
	self.face_target = false
end

function modifier_pangolier_gyroshell_custom_legendary_cast:OnIntervalThink()
	if not IsServer() then
		return
	end
	self:TurnLogic()
end

function modifier_pangolier_gyroshell_custom_legendary_cast:TurnLogic()
	if self.face_target then
		return
	end
	local current_angle = VectorToAngles(self.current_dir).y
	local target_angle = VectorToAngles(self.target_dir).y
	local angle_diff = AngleDiff(current_angle, target_angle)
	local sign = -1
	if angle_diff < 0 then
		sign = 1
	end
	if math.abs(angle_diff) < 1.1 * self.turn_speed then
		self.current_dir = self.target_dir
		self.face_target = true
	else
		self.current_dir = RotatePosition(Vector(0, 0, 0), QAngle(0, sign * self.turn_speed, 0), self.current_dir)
	end
	local a = self.parent:IsCurrentlyHorizontalMotionControlled()
	local b = self.parent:IsCurrentlyVerticalMotionControlled()
	if not (a or b) then
		self.parent:SetForwardVector(self.current_dir)
	end

	if self.effect_cast then
		local target_pos = self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 500
		ParticleManager:SetParticleControl(self.effect_cast, 1, target_pos)
	end
end

function modifier_pangolier_gyroshell_custom_legendary_cast:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:EmitSound("Pango.Ulti_legendary_cast")
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_pangolier_gyroshell_custom_legendary",
		{ duration = self.ability.talents.r7_duration }
	)
end

modifier_pangolier_gyroshell_custom_legendary = class(mod_hidden)
function modifier_pangolier_gyroshell_custom_legendary:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.parent:GenericParticle("particles/lc_odd_charge.vpcf", self)
	self.parent:GenericParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf",
		self
	)

	local mod = self.parent:FindModifierByName("modifier_pangolier_gyroshell_custom")
	if mod then
		mod.legendary_count = mod.legendary_count - 1
		if mod.legendary_count <= 0 then
			self.ability:SetActivated(false)
		end
	end
end

function modifier_pangolier_gyroshell_custom_legendary:CheckState()
	return {
		[MODIFIER_STATE_SILENCED] = true,
	}
end

function modifier_pangolier_gyroshell_custom_legendary:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:StopSound("Pango.Ulti_legendary")
end

modifier_pangolier_gyroshell_custom_delay = class(mod_visible)
function modifier_pangolier_gyroshell_custom_delay:GetTexture()
	return "buffs/pangolier/rolling_3"
end
function modifier_pangolier_gyroshell_custom_delay:OnCreated(table)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.max = self.ability.talents.r3_max

	if not IsServer() then
		return
	end
	self.stack = 0
	self.parent:AddDamageEvent_inc(self, true)
	self.damageTable = {
		victim = self.parent,
		attacker = self.caster,
		ability = self.ability,
		damage_type = self.ability.talents.r3_damage_type,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
	}
	self.parent:GenericParticle("particles/lc_odd_charge_mark.vpcf", self, true)
end

function modifier_pangolier_gyroshell_custom_delay:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if params.attacker ~= self.caster then
		return
	end

	self.stack = math.min(
		self.parent:GetMaxHealth() * self.max,
		self.stack + params.original_damage * self.ability.talents.r3_damage
	)
	self:SetStackCount(self.stack)
end

function modifier_pangolier_gyroshell_custom_delay:OnDestroy()
	if not IsServer() then
		return
	end
	if self.stack <= 0 then
		return
	end
	if not self.parent:IsAlive() then
		return
	end

	self.damageTable.damage = math.min(self.parent:GetMaxHealth() * self.max, self.stack)

	self.parent:EmitSound("Pango.Rolling_delay_damage")
	self.parent:EmitSound("Pango.Rolling_delay_damage2")
	self.parent:GenericParticle("particles/jugg_legendary_proc_.vpcf")

	local trail_pfx =
		ParticleManager:CreateParticle("particles/items3_fx/iron_talon_active.vpcf", PATTACH_ABSORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt(
		trail_pfx,
		0,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		trail_pfx,
		1,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(trail_pfx)

	local real_damage = DoDamage(self.damageTable, "modifier_pangolier_rolling_3")
	self.parent:SendNumber(106, real_damage)
end

modifier_pangolier_gyroshell_custom_legendary_health = class(mod_visible)
function modifier_pangolier_gyroshell_custom_legendary_health:GetTexture()
	return "pangolier_heartpiercer"
end
function modifier_pangolier_gyroshell_custom_legendary_health:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self.caster.rolling_ability
	if not self.ability then
		self:Destroy()
		return
	end

	self.health = self.ability.talents.r7_health_reduce
	self.max = self.ability.talents.r7_max

	if not IsServer() then
		return
	end
	self.effect_cast = self.parent:GenericParticle("particles/pangolier/rolling_stack.vpcf", self, true)
	self:OnRefresh()
end

function modifier_pangolier_gyroshell_custom_legendary_health:OnRefresh()
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end
	self:IncrementStackCount()

	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(0, self:GetStackCount(), 0))
	self.parent:CalculateStatBonus(true)
end

function modifier_pangolier_gyroshell_custom_legendary_health:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:CalculateStatBonus(true)
end

function modifier_pangolier_gyroshell_custom_legendary_health:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
	}
end

function modifier_pangolier_gyroshell_custom_legendary_health:GetModifierExtraHealthPercentage()
	return self.health * self:GetStackCount()
end