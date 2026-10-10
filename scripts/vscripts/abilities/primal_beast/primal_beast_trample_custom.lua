--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_primal_beast_trample_tracker",
	"abilities/primal_beast/primal_beast_trample_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_primal_beast_trample_custom",
	"abilities/primal_beast/primal_beast_trample_custom",
	LUA_MODIFIER_MOTION_NONE,
	true
)
LinkLuaModifier(
	"modifier_primal_beast_trample_charge",
	"abilities/primal_beast/primal_beast_trample_custom",
	LUA_MODIFIER_MOTION_HORIZONTAL
)
LinkLuaModifier(
	"modifier_primal_beast_trample_arrow",
	"abilities/primal_beast/primal_beast_trample_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_primal_beast_trample_quest",
	"abilities/primal_beast/primal_beast_trample_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_primal_beast_trample_strength",
	"abilities/primal_beast/primal_beast_trample_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_primal_beast_trample_3"
)
LinkLuaModifier(
	"modifier_primal_beast_trample_silence",
	"abilities/primal_beast/primal_beast_trample_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_primal_beast_trample_4"
)

primal_beast_trample_custom = class({})
primal_beast_trample_custom.talents = {}

function primal_beast_trample_custom:GetAbilityTextureName()
	return wearables_system:GetAbilityIconReplacement(self:GetCaster(), "primal_beast_trample", self)
end

function primal_beast_trample_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_disarm.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf", context)
	PrecacheResource("particle", "particles/primal_beast/beast_quake_stack.vpcf", context)
	PrecacheResource("particle", "particles/primal_beast/beast_charge.vpcf", context)
	PrecacheResource("particle", "particles/primal_beast/trample_crit_stomp.vpcf", context)
	PrecacheResource("particle", "particles/primal_beast/trample_silence.vpcf", context)
end

function primal_beast_trample_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			w1_str = 0,
			w1_duration = 0,

			has_w3 = 0,
			w3_damage = 0,
			w3_str = 0,
			w3_chance = caster:GetTalentValue("modifier_primal_beast_trample_3", "chance", true),
			w3_max = caster:GetTalentValue("modifier_primal_beast_trample_3", "max", true),
			w3_duration = caster:GetTalentValue("modifier_primal_beast_trample_3", "duration", true),

			has_w4 = 0,
			w4_cd = caster:GetTalentValue("modifier_primal_beast_trample_4", "cd", true),
			w4_hits = caster:GetTalentValue("modifier_primal_beast_trample_4", "hits", true),
			w4_silence = caster:GetTalentValue("modifier_primal_beast_trample_4", "silence", true),
			w4_duration = caster:GetTalentValue("modifier_primal_beast_trample_4", "duration", true),
			w4_talent_cd = caster:GetTalentValue("modifier_primal_beast_trample_4", "talent_cd", true),

			has_w7 = 0,
			w7_damage = caster:GetTalentValue("modifier_primal_beast_trample_7", "damage", true) / 100,
			w7_distance = caster:GetTalentValue("modifier_primal_beast_trample_7", "distance", true),
			w7_duration = caster:GetTalentValue("modifier_primal_beast_trample_7", "duration", true),
			w7_max = caster:GetTalentValue("modifier_primal_beast_trample_7", "max", true) / 100,
			w7_cast = caster:GetTalentValue("modifier_primal_beast_trample_7", "cast", true),
			w7_speed = caster:GetTalentValue("modifier_primal_beast_trample_7", "speed", true),
			w7_radius = caster:GetTalentValue("modifier_primal_beast_trample_7", "radius", true),
			w7_knockback = caster:GetTalentValue("modifier_primal_beast_trample_7", "knockback", true),
			w7_knockback_duration = caster:GetTalentValue(
				"modifier_primal_beast_trample_7",
				"knockback_duration",
				true
			),
			w7_talent_cd = caster:GetTalentValue("modifier_primal_beast_trample_7", "talent_cd", true),

			r2_radius = 0,
			r7_trample = caster:GetTalentValue("modifier_primal_beast_pulverize_7", "trample", true),
		}
	end

	if caster:HasTalent("modifier_primal_beast_trample_1") then
		self.talents.w1_str = caster:GetTalentValue("modifier_primal_beast_trample_1", "str") / 100
		self.talents.w1_duration = caster:GetTalentValue("modifier_primal_beast_trample_1", "duration")
	end

	if caster:HasTalent("modifier_primal_beast_trample_3") then
		self.talents.has_w3 = 1
		self.talents.w3_damage = caster:GetTalentValue("modifier_primal_beast_trample_3", "damage") / 100
		self.talents.w3_str = caster:GetTalentValue("modifier_primal_beast_trample_3", "str") / 100
	end

	if caster:HasTalent("modifier_primal_beast_trample_4") then
		self.talents.has_w4 = 1
	end

	if caster:HasTalent("modifier_primal_beast_trample_7") then
		self.talents.has_w7 = 1
	end

	if caster:HasTalent("modifier_primal_beast_pulverize_2") then
		self.talents.r2_radius = caster:GetTalentValue("modifier_primal_beast_pulverize_2", "radius")
	end
end

function primal_beast_trample_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_primal_beast_trample_tracker"
end

function primal_beast_trample_custom:IsRecast()
	return self.talents.has_w7 == 1 and self.caster:HasModifier("modifier_primal_beast_trample_custom")
end

function primal_beast_trample_custom:GetBehavior()
	if self:IsRecast() then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET
			+ DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
			+ DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
end

function primal_beast_trample_custom:GetCastPoint(iLevel)
	if self:IsRecast() then
		return self.talents.w7_cast
	end
	return self.BaseClass.GetCastPoint(self)
end

function primal_beast_trample_custom:GetManaCost(level)
	if self:IsRecast() then
		return 0
	end
	return self.BaseClass.GetManaCost(self, level)
end

function primal_beast_trample_custom:GetCooldown(iLevel)
	return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.has_w4 == 1 and self.talents.w4_cd or 0)
end

function primal_beast_trample_custom:GetDamage(target, legendary_damage)
	local damage = (self.base_damage + self.caster:GetStrength() * self.talents.w1_str) * (1 + legendary_damage)
	local uproar = self.caster.uproar_ability
	if IsValid(uproar) and IsValid(uproar.buff_mod) then
		damage = damage * (1 + uproar.buff_mod:GetTrampleBonus() / 100)
	end
	return damage * (target:IsCreep() and 1 + self.creeps_damage or 1)
end

function primal_beast_trample_custom:OnAbilityPhaseStart()
	if not IsServer() then
		return true
	end
	if not self:IsRecast() then
		return true
	end

	self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.4 / self:GetCastPointModifier())
	self.caster:AddNewModifier(self.caster, self, "modifier_primal_beast_trample_arrow", {})
	return true
end

function primal_beast_trample_custom:OnAbilityPhaseInterrupted()
	if not IsServer() then
		return
	end
	self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
	self.caster:RemoveModifierByName("modifier_primal_beast_trample_arrow")
end

function primal_beast_trample_custom:OnSpellStart()
	if self:IsRecast() then
		self.caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_2)
		self.caster:RemoveModifierByName("modifier_primal_beast_trample_arrow")
		self.caster:AddNewModifier(
			self.caster,
			self,
			"modifier_primal_beast_trample_charge",
			{ duration = self.talents.w7_distance / self.talents.w7_speed }
		)
		self.caster:EmitSound("PBeast.Trample_dash")
		return
	end

	self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	self.trample_mod = self.caster:AddNewModifier(
		self.caster,
		self,
		"modifier_primal_beast_trample_custom",
		{ duration = self.duration + self.talents.w1_duration }
	)
end

function primal_beast_trample_custom:Trample(mod)
	local enemies = self.caster:FindTargets(mod.radius)
	local damageTable = { attacker = self.caster, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }
	local critTable = { attacker = self.caster, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }
	local crit = self.talents.has_w3 == 1 and RollPseudoRandomPercentage(self.talents.w3_chance, 4162, self.caster)

	local origin = self.caster:GetAbsOrigin()
	local hero_hit = false

	for _, enemy in pairs(enemies) do
		local damage = self:GetDamage(enemy, mod.legendary_damage)
		damageTable.victim = enemy
		damageTable.damage = damage
		DoDamage(damageTable)

		if crit then
			critTable.victim = enemy
			critTable.damage = damage * self.talents.w3_damage
			DoDamage(critTable, "modifier_primal_beast_trample_3")
			enemy:SendNumber(114, damage + critTable.damage)

			if IsValid(self.caster.onslaught_ability) then
				self.caster.onslaught_ability:HitEffect(enemy, origin, false)
			end
		else
			enemy:SendNumber(4, damage)
		end

		if enemy:IsValidKill(self.caster) then
			hero_hit = true
		end

		if self.talents.has_w4 == 1 and not enemy:HasCd("primal_beast_trample_4", self.talents.w4_talent_cd) then
			enemy:AddNewModifier(
				self.caster,
				self,
				"modifier_primal_beast_trample_silence",
				{ duration = self.talents.w4_duration }
			)
		end

		if self.caster:GetQuest() == "Beast.Quest_6" and enemy:IsRealHero() and not self.caster:QuestCompleted() then
			enemy:AddNewModifier(self.caster, self, "modifier_primal_beast_trample_quest", { duration = 1 })
		end
	end

	if hero_hit then
		mod.ult_count = mod.ult_count + 1
		if mod.ult_count >= self.talents.r7_trample then
			mod.ult_count = 0
			if IsValid(self.caster.pulverize_ability) then
				self.caster.pulverize_ability:AddLegendaryStack("trample")
			end
		end
	end

	local effect_cast = ParticleManager:CreateParticle(
		wearables_system:GetParticleReplacementAbility(
			self.caster,
			"particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf",
			self
		),
		PATTACH_ABSORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(mod.radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	self.caster:EmitSound("Hero_PrimalBeast.Trample")

	if not crit then
		return
	end
	self.caster:LogProc("modifier_primal_beast_trample_3", hero_hit and 1 or 0)
	self:ProcCrit(origin, mod.radius, hero_hit)
end

function primal_beast_trample_custom:ProcCrit(point, radius, hero_hit)
	if not IsServer() then
		return
	end

	local effect_cast =
		ParticleManager:CreateParticle("particles/primal_beast/trample_crit_stomp.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:SetParticleControl(effect_cast, 2, point)
	ParticleManager:SetParticleControl(effect_cast, 3, point)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOnLocationWithCaster(point, "DOTA_Item.Daedelus.Crit", self.caster)

	if not hero_hit then
		return
	end
	self.caster:AddNewModifier(
		self.caster,
		self,
		"modifier_primal_beast_trample_strength",
		{ duration = self.talents.w3_duration }
	)
end

modifier_primal_beast_trample_tracker = class(mod_hidden)
function modifier_primal_beast_trample_tracker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.parent.trample_ability = self.ability

	self.ability.effect_radius = self.ability:GetSpecialValueFor("effect_radius")
	self.ability.step_distance = self.ability:GetSpecialValueFor("step_distance")
	self.ability.base_damage = self.ability:GetSpecialValueFor("base_damage")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.creeps_damage = self.ability:GetSpecialValueFor("creeps_damage") / 100
end

function modifier_primal_beast_trample_tracker:OnRefresh()
	self.ability.base_damage = self.ability:GetSpecialValueFor("base_damage")
end

modifier_primal_beast_trample_custom = class(mod_visible)
function modifier_primal_beast_trample_custom:GetEffectName()
	return "particles/units/heroes/hero_primal_beast/primal_beast_disarm.vpcf"
end
function modifier_primal_beast_trample_custom:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_primal_beast_trample_custom:OnCreated(params)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self.ability:EndCd(self.ability.talents.has_w7 == 1 and 0.2 or nil)

	self.step_distance = self.ability.step_distance
	self.radius = self.ability.effect_radius + self.ability.talents.r2_radius

	self.ult_count = 0
	self.distance = 0
	self.treshold = 500
	self.interval = 0.1
	self.ticks = 0
	self.legendary_damage = 0
	self.base_duration = self:GetDuration()
	self.max_time = self.base_duration
	self.extend = 0
	self.currentpos = self.parent:GetOrigin()
	self:StartIntervalThink(self.interval)
	self.ability:Trample(self)
end

function modifier_primal_beast_trample_custom:OnDestroy()
	if not IsServer() then
		return
	end
	self.ability:StartCd()

	if self.ability.talents.has_w4 == 1 then
		FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)
	end

	if self.ability.talents.has_w7 == 0 then
		return
	end
	self.parent:UpdateUIshort({ hide = 1, style = "BeastTrample", priority = -1 })

	if not self.ability:IsInAbilityPhase() then
		return
	end
	self.parent:Interrupt()
end

function modifier_primal_beast_trample_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function modifier_primal_beast_trample_custom:GetActivityTranslationModifiers()
	return "heavy_steps"
end

function modifier_primal_beast_trample_custom:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = self.ability.talents.has_w4 == 1,
	}
end

function modifier_primal_beast_trample_custom:OnIntervalThink()
	if not IsServer() then
		return
	end

	if self.parent:HasModifier("modifier_primal_beast_pulverize_custom") then
		self:SetDuration(self:GetRemainingTime() + self.interval, true)
	else
		self.ticks = self.ticks + 1
	end

	if self.ability.talents.has_w7 == 1 then
		if self.ticks * self.interval >= 1 then
			self.ticks = 0
			self:IncrementStackCount()
			self.legendary_damage = self:GetStackCount() * self.ability.talents.w7_damage

			if not self.particle then
				self.particle = self.parent:GenericParticle("particles/primal_beast/beast_quake_stack.vpcf", self, true)
			end

			local number = self:GetStackCount()
			local double = math.floor(number / 10)
			ParticleManager:SetParticleControl(self.particle, 1, Vector(double, number, number - double * 10))
		end

		self.max_time = math.max(self.max_time, self:GetRemainingTime())
		self.parent:UpdateUIshort({
			max_time = self.max_time,
			time = self:GetRemainingTime(),
			stack = self:GetRemainingTime(),
			use_zero = 1,
			style = "BeastTrample",
			priority = -1,
		})
	end

	local pos = self.parent:GetOrigin()
	local dist = (pos - self.currentpos):Length2D()
	self.currentpos = pos
	GridNav:DestroyTreesAroundPoint(pos, self.radius, false)
	if dist > self.treshold then
		return
	end

	self.distance = self.distance + dist
	if self.distance <= self.step_distance then
		return
	end

	self.ability:Trample(self)
	self.distance = 0
end

modifier_primal_beast_trample_quest = class(mod_hidden)
function modifier_primal_beast_trample_quest:OnCreated()
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self:OnRefresh()
end

function modifier_primal_beast_trample_quest:OnRefresh()
	if not IsServer() then
		return
	end
	if not self.caster:GetQuest() then
		return
	end
	if self.caster:QuestCompleted() then
		return
	end

	self:IncrementStackCount()
	if self:GetStackCount() < self.caster.quest.number then
		return
	end

	self.caster:UpdateQuest(1)
	self:Destroy()
end

modifier_primal_beast_trample_charge = class(mod_hidden)
function modifier_primal_beast_trample_charge:GetEffectName()
	return "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf"
end
function modifier_primal_beast_trample_charge:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_primal_beast_trample_charge:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.ability:EndCd(self.ability.talents.w7_talent_cd)
	self.speed = self.ability.talents.w7_speed
	self.radius = self.ability.talents.w7_radius
	self.knockback = self.ability.talents.w7_knockback
	self.knockback_duration = self.ability.talents.w7_knockback_duration
	self.dir = self.parent:GetForwardVector()
	self.dir.z = 0
	self.dir = self.dir:Normalized()
	self.hit = false
	self.hit_units = {}

	if self:ApplyHorizontalMotionController() then
		return
	end
	self:Destroy()
end

function modifier_primal_beast_trample_charge:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:RemoveHorizontalMotionController(self)
	self.parent:FacePoint()
	FindClearSpaceForUnit(self.parent, self.parent:GetOrigin(), false)
end

function modifier_primal_beast_trample_charge:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_primal_beast_trample_charge:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function modifier_primal_beast_trample_charge:GetModifierDisableTurning()
	return 1
end

function modifier_primal_beast_trample_charge:GetOverrideAnimation()
	return ACT_DOTA_RUN
end

function modifier_primal_beast_trample_charge:GetActivityTranslationModifiers()
	return "onslaught_movement"
end

function modifier_primal_beast_trample_charge:UpdateHorizontalMotion(me, dt)
	if self.parent:IsStunned() or self.parent:IsHexed() or self.parent:IsChanneling() then
		self:Destroy()
		return
	end

	if self.parent:IsRooted() or self.parent:IsLeashed() then
		return
	end

	for _, unit in pairs(self.parent:FindTargets(self.radius)) do
		if not self.hit_units[unit] then
			self.hit_units[unit] = true
			self.parent:LogProc("modifier_primal_beast_trample_7", nil, unit)

			if not self.hit and IsValid(self.ability.trample_mod) then
				self.hit = true
				local mod = self.ability.trample_mod
				local duration = math.min(
					self.ability.talents.w7_duration,
					mod.base_duration * self.ability.talents.w7_max - mod.extend
				)
				mod.extend = mod.extend + duration
				mod:SetDuration(mod:GetRemainingTime() + duration, true)
				self.parent:LogProc("modifier_primal_beast_trample_7_extend", duration)
			end

			if not unit:IsCurrentlyHorizontalMotionControlled() and not unit:IsCurrentlyVerticalMotionControlled() then
				local vec = unit:GetAbsOrigin() - self.parent:GetAbsOrigin()
				vec.z = 0
				vec = vec:Normalized()

				unit:AddNewModifier(self.parent, self.ability, "modifier_generic_knockback", {
					duration = self.knockback_duration,
					distance = self.knockback,
					height = 50,
					direction_x = vec.x,
					direction_y = vec.y,
				})
			end

			local effect_cast = ParticleManager:CreateParticle(
				wearables_system:GetParticleReplacementAbility(
					self.parent,
					"particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf",
					self.ability
				),
				PATTACH_ABSORIGIN_FOLLOW,
				unit
			)
			ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, self.radius, self.radius))
			ParticleManager:ReleaseParticleIndex(effect_cast)
			unit:EmitSound("Hero_PrimalBeast.Onslaught.Hit")
		end
	end

	me:SetOrigin(me:GetOrigin() + self.dir * self.speed * dt)
end

function modifier_primal_beast_trample_charge:OnHorizontalMotionInterrupted()
	self:Destroy()
end

modifier_primal_beast_trample_arrow = class(mod_hidden)
function modifier_primal_beast_trample_arrow:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.distance = self.ability.talents.w7_distance
	self.particle = ParticleManager:CreateParticleForPlayer(
		"particles/primal_beast/beast_charge.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent,
		PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID())
	)
	ParticleManager:SetParticleControl(self.particle, 2, Vector(self.ability.talents.w7_radius / 1.4, 0, 0))
	self:AddParticle(self.particle, true, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
	self:OnIntervalThink()
end

function modifier_primal_beast_trample_arrow:OnIntervalThink()
	if not IsServer() then
		return
	end
	ParticleManager:SetParticleControl(
		self.particle,
		1,
		self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * self.distance
	)
end

modifier_primal_beast_trample_strength = class(mod_visible)
function modifier_primal_beast_trample_strength:GetTexture()
	return "buffs/primal_beast/trample_3"
end
function modifier_primal_beast_trample_strength:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self.max = self.ability.talents.w3_max
	self:OnRefresh()
end

function modifier_primal_beast_trample_strength:OnRefresh()
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end
	self:IncrementStackCount()
	self.parent:AddPercentStat({ str = self:GetStackCount() * self.ability.talents.w3_str }, self)
end

function modifier_primal_beast_trample_strength:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_primal_beast_trample_strength:OnTooltip()
	return self:GetStackCount() * self.ability.talents.w3_str * 100
end

modifier_primal_beast_trample_silence = class(mod_hidden)
function modifier_primal_beast_trample_silence:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self.max = self.ability.talents.w4_hits
	self.particle = self.parent:GenericParticle("particles/primal_beast/trample_silence.vpcf", self, true)
	self:OnRefresh()
end

function modifier_primal_beast_trample_silence:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
	ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))

	if self:GetStackCount() < self.max then
		return
	end

	self.parent:StartCd("primal_beast_trample_4")
	self.parent:EmitSound("PBeast.Trample_silence")
	self.parent:AddNewModifier(
		self.caster,
		self.ability,
		"modifier_generic_silence",
		{ duration = (1 - self.parent:GetStatusResistance()) * self.ability.talents.w4_silence }
	)
	self.caster:LogProc("modifier_primal_beast_trample_4", nil, self.parent)
	self:Destroy()
end