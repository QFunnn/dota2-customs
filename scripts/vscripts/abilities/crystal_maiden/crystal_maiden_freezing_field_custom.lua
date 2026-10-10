--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_crystal_maiden_freezing_field_custom",
	"abilities/crystal_maiden/crystal_maiden_freezing_field_custom",
	LUA_MODIFIER_MOTION_NONE,
	true
)
LinkLuaModifier(
	"modifier_crystal_maiden_freezing_field_custom_debuff",
	"abilities/crystal_maiden/crystal_maiden_freezing_field_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_crystal_maiden_freezing_field_custom_legendary",
	"abilities/crystal_maiden/crystal_maiden_freezing_field_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_crystal_maiden_freezing_field_custom_legendary_mini",
	"abilities/crystal_maiden/crystal_maiden_freezing_field_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_crystal_maiden_freezing_field_custom_tracker",
	"abilities/crystal_maiden/crystal_maiden_freezing_field_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_crystal_maiden_freezing_field_custom_knock_cd",
	"abilities/crystal_maiden/crystal_maiden_freezing_field_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_maiden_freezing_4"
)
LinkLuaModifier(
	"modifier_crystal_maiden_freezing_field_custom_cd_items",
	"abilities/crystal_maiden/crystal_maiden_freezing_field_custom",
	LUA_MODIFIER_MOTION_NONE
)

crystal_maiden_freezing_field_custom = class({})
crystal_maiden_freezing_field_custom.talents = {}

function crystal_maiden_freezing_field_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_slowed_cold.vpcf", context)
	PrecacheResource("particle", "particles/crystal_maiden/maiden_frostbite_slow.vpcf", context)
	PrecacheResource("particle", "particles/crystal_maiden/maiden_freezing_area.vpcf", context)
	PrecacheResource("particle", "particles/crystal_maiden/maiden_field_legendary.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_frosty_dire.vpcf",
		context
	)
	PrecacheResource("particle", "particles/crystal_maiden/freezing_shields.vpcf", context)
	PrecacheResource("particle", "particles/econ/events/winter_major_2016/blink_dagger_wm_end.vpcf", context)
end

function crystal_maiden_freezing_field_custom:UpdateTalents()
	local caster = self:GetCaster()

	if not self.init then
		self.init = true
		self.talents = {
			r1_damage = 0,
			r1_base = 0,

			has_r2 = 0,
			r2_cd = 0,
			r2_linger = 0,

			has_r3 = 0,
			r3_auto = 0,
			r3_cdr = 0,
			r3_count = caster:GetTalentValue("modifier_maiden_freezing_3", "count", true),
			r3_radius = caster:GetTalentValue("modifier_maiden_freezing_3", "radius", true),
			r3_slow = caster:GetTalentValue("modifier_maiden_freezing_3", "slow", true),

			has_r4 = 0,
			r4_delay = caster:GetTalentValue("modifier_maiden_freezing_4", "delay", true),
			r4_cd = caster:GetTalentValue("modifier_maiden_freezing_4", "cd", true),
			r4_silence = caster:GetTalentValue("modifier_maiden_freezing_4", "silence", true),
			r4_distance_min = caster:GetTalentValue("modifier_maiden_freezing_4", "distance_min", true),
			r4_distance_max = caster:GetTalentValue("modifier_maiden_freezing_4", "distance_max", true),
			r4_duration = caster:GetTalentValue("modifier_maiden_freezing_4", "duration", true),

			has_h4 = 0,
			h4_range = caster:GetTalentValue("modifier_maiden_hero_4", "range", true),
			h4_invun = caster:GetTalentValue("modifier_maiden_hero_4", "invun", true),
			h4_damage_reduce = caster:GetTalentValue("modifier_maiden_hero_4", "damage_reduce", true),

			has_r7 = 0,
			r7_slow = caster:GetTalentValue("modifier_maiden_freezing_7", "slow", true),
			r7_mana_regen = caster:GetTalentValue("modifier_maiden_freezing_7", "mana_regen", true) / 100,
			r7_cd_inc = caster:GetTalentValue("modifier_maiden_freezing_7", "cd_inc", true) / 100,

			has_w4 = 0,
			w4_cd_field = caster:GetTalentValue("modifier_maiden_frostbite_4", "cd_field", true) / 100,
		}
	end

	if caster:HasTalent("modifier_maiden_freezing_1") then
		self.talents.r1_damage = caster:GetTalentValue("modifier_maiden_freezing_1", "damage") / 100
		self.talents.r1_base = caster:GetTalentValue("modifier_maiden_freezing_1", "base")
	end

	if caster:HasTalent("modifier_maiden_freezing_2") then
		self.talents.has_r2 = 1
		self.talents.r2_cd = caster:GetTalentValue("modifier_maiden_freezing_2", "cd")
		self.talents.r2_linger = caster:GetTalentValue("modifier_maiden_freezing_2", "linger")
	end

	if caster:HasTalent("modifier_maiden_freezing_3") then
		self.talents.has_r3 = 1
		self.talents.r3_auto = caster:GetTalentValue("modifier_maiden_freezing_3", "auto") / 100
		self.talents.r3_cdr = caster:GetTalentValue("modifier_maiden_freezing_3", "cdr")
		caster:AddSpellEvent(self.tracker, true)
	end

	if caster:HasTalent("modifier_maiden_freezing_4") then
		self.talents.has_r4 = 1
	end

	if caster:HasTalent("modifier_maiden_hero_4") then
		self.talents.has_h4 = 1
	end

	if caster:HasTalent("modifier_maiden_freezing_7") then
		self.talents.has_r7 = 1
		caster:AddSpellEvent(self.tracker, true)
	end

	if caster:HasTalent("modifier_maiden_frostbite_4") then
		self.talents.has_w4 = 1
	end
end

function crystal_maiden_freezing_field_custom:CreateTalent()
	self:ToggleAutoCast()
end

function crystal_maiden_freezing_field_custom:GetAbilityTextureName()
	if self.caster:HasScepter() and self.caster:HasModifier("modifier_crystal_maiden_freezing_field_custom") then
		return wearables_system:GetAbilityIconReplacement(self.caster, "crystal_maiden_freezing_field_stop", self)
	else
		return wearables_system:GetAbilityIconReplacement(self.caster, "crystal_maiden_freezing_field", self)
	end
end

function crystal_maiden_freezing_field_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_crystal_maiden_freezing_field_custom_tracker"
end

function crystal_maiden_freezing_field_custom:GetCastRange(vLocation, hTarget)
	return self.talents.has_h4 == 1 and self.talents.h4_range or 0
end

function crystal_maiden_freezing_field_custom:GetAOERadius()
	return self.radius or 0
end

function crystal_maiden_freezing_field_custom:GetManaCost(level)
	if
		self.talents.has_r7 == 1
		or (self.caster:HasScepter() and self.caster:HasModifier("modifier_crystal_maiden_freezing_field_custom"))
	then
		return 0
	end
	return self.BaseClass.GetManaCost(self, level)
end

function crystal_maiden_freezing_field_custom:GetCooldown(iLevel)
	return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.r2_cd or 0)
end

function crystal_maiden_freezing_field_custom:GetBehavior()
	local auto = self.talents.has_r4 == 1 and DOTA_ABILITY_BEHAVIOR_AUTOCAST or 0
	local base = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	if self.talents.has_h4 == 1 and not self.caster:HasModifier("modifier_crystal_maiden_freezing_field_custom") then
		base = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end
	if self.caster:HasScepter() then
		return base + auto
	end
	return base + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + auto
end

function crystal_maiden_freezing_field_custom:GetChannelTime()
	if self.caster:HasScepter() then
		return 0
	end
	return self.duration or 0
end

function crystal_maiden_freezing_field_custom:OnSpellStart()
	local mod = self.caster:FindModifierByName("modifier_crystal_maiden_freezing_field_custom")
	if mod then
		mod:EndEffect()
		return
	end

	if self.talents.has_h4 == 1 and self.caster:CanBlink() then
		self.caster:Teleport(
			self:GetCursorPosition(),
			true,
			"particles/econ/events/winter_major_2016/blink_dagger_start_wm.vpcf",
			"particles/econ/events/winter_major_2016/blink_dagger_wm_end.vpcf",
			"DOTA_Item.Arcane_Blink.Activate"
		)
		self.caster:EmitSound("Puck.Rift_Legendary")
		self.caster:AddNewModifier(
			self.caster,
			self,
			"modifier_crystal_maiden_crystal_nova_invun",
			{ duration = self.talents.h4_invun }
		)
	end

	self.caster:AddNewModifier(
		self.caster,
		self,
		"modifier_crystal_maiden_freezing_field_custom",
		{ duration = self.duration + self.talents.r2_linger }
	)

	if self.caster:HasScepter() then
		self:StartCooldown(1)
	else
		self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
	end
end

function crystal_maiden_freezing_field_custom:OnChannelFinish(bInterrupted)
	local mod = self.caster:FindModifierByName("modifier_crystal_maiden_freezing_field_custom")
	if not mod then
		return
	end

	mod:EndEffect()
	if not self.caster:HasScepter() then
		self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
	end
end

function crystal_maiden_freezing_field_custom:DealDamage(radius, point, damage_ability)
	if not IsServer() then
		return
	end

	local damage = self.damage + self.talents.r1_base + self.caster:GetMaxMana() * self.talents.r1_damage
	local slow_duration = self.slow_duration

	if damage_ability == "modifier_maiden_freezing_3" then
		damage = damage * self.talents.r3_auto
		slow_duration = self.talents.r3_slow
	end

	if damage_ability == "modifier_maiden_freezing_7" then
		slow_duration = self.talents.r7_slow
	end

	local damageTable = { attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }
	for _, enemy in pairs(self.caster:FindTargets(radius, point)) do
		damageTable.victim = enemy
		DoDamage(damageTable, damage_ability)
		enemy:AddNewModifier(
			self.caster,
			self,
			"modifier_crystal_maiden_freezing_field_custom_debuff",
			{ duration = slow_duration }
		)
	end

	if IsValid(self.caster.arcane_aura_ability) and self.caster.arcane_aura_ability:IsTrained() then
		self.caster.arcane_aura_ability:SearchClones(radius, point)
	end
end

function crystal_maiden_freezing_field_custom:SummonShard(point, damage_ability)
	if not IsServer() then
		return
	end
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOnLocationWithCaster(point, "hero_Crystal.freezingField.explosion", self.caster)
	CreateModifierThinker(
		self.caster,
		self,
		"modifier_crystal_maiden_freezing_field_custom_legendary_mini",
		{ duration = 0.25, damage_ability = damage_ability },
		point,
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_crystal_maiden_freezing_field_custom = class(mod_visible)
function modifier_crystal_maiden_freezing_field_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.slow_radius = self.ability.radius
	self.slow_duration = self.ability.slow_duration
	self.explosion_radius = self.ability.explosion_radius
	self.explosion_interval = self.ability.explosion_interval
	self.scepter_slow = self.ability.scepter_slow

	self.explosion_min_dist = self.explosion_radius / 2
	self.explosion_max_dist = self.slow_radius - self.explosion_radius / 2

	self.quartal = -1

	if not IsServer() then
		return
	end
	self.ability:EndCd()
	if self.parent:HasScepter() then
		self.ability:SetActivated(true)
		self.ability:StartCooldown(1)
	end

	if self.ability.talents.has_h4 == 1 then
		self.parent:GenericParticle("particles/crystal_maiden/freezing_shields.vpcf", self)
	end

	if self.ability.talents.has_w4 == 1 then
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_crystal_maiden_freezing_field_custom_cd_items",
			{}
		)
	end

	self.RemoveForDuel = true
	self:SetStackCount(0)

	local effect_name = wearables_system:GetParticleReplacementAbility(
		self.parent,
		"particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf",
		self
	)
	self.shard_effect = wearables_system:GetParticleReplacementAbility(
		self.parent,
		"particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf",
		self
	)

	self.effect_cast = ParticleManager:CreateParticle(effect_name, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.slow_radius, self.slow_radius, 1))
	self:AddParticle(self.effect_cast, false, false, -1, false, false)

	self.sound = wearables_system:GetSoundReplacement(self.parent, "hero_Crystal.freezingField.wind", self)

	self.parent:EmitSound(self.sound)
	self:OnIntervalThink()
	self:StartIntervalThink(self.explosion_interval)
end

function modifier_crystal_maiden_freezing_field_custom:OnDestroy()
	if not IsServer() then
		return
	end
	self.ability:StartCd()

	self.parent:RemoveModifierByName("modifier_crystal_maiden_freezing_field_custom_cd_items")

	if IsValid(self.parent.arcane_aura_ability) and IsValid(self.parent.arcane_aura_ability.tracker) then
		self.parent.arcane_aura_ability.tracker:OnIntervalThink()
	end

	self.parent:StopSound(self.sound)
end

function modifier_crystal_maiden_freezing_field_custom:EndEffect()
	if not IsServer() then
		return
	end
	if self:GetStackCount() == 1 then
		return
	end

	self:SetStackCount(1)
	if self.ability.talents.has_r2 == 1 then
		self.ability:EndCd()
		self:SetDuration(self.ability.talents.r2_linger, true)
	else
		self:Destroy()
	end
end

function modifier_crystal_maiden_freezing_field_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_crystal_maiden_freezing_field_custom:GetModifierIncomingDamage_Percentage()
	if self.ability.talents.has_h4 == 0 then
		return
	end
	return self.ability.talents.h4_damage_reduce
end

function modifier_crystal_maiden_freezing_field_custom:GetModifierMoveSpeedBonus_Percentage()
	if not self.parent:HasScepter() or self:GetStackCount() == 1 then
		return
	end
	return self.scepter_slow
end

function modifier_crystal_maiden_freezing_field_custom:OnIntervalThink()
	if not IsServer() then
		return
	end
	local origin = self.parent:GetAbsOrigin()
	local knock = self.ability.talents.has_r4 == 1 and self:GetElapsedTime() >= self.ability.talents.r4_delay

	for _, enemy in pairs(self.parent:FindTargets(self.slow_radius)) do
		enemy:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_crystal_maiden_freezing_field_custom_debuff",
			{ duration = self.slow_duration }
		)

		if
			knock
			and not enemy:HasModifier("modifier_crystal_maiden_freezing_field_custom_knock_cd")
			and enemy:IsUnit()
		then
			if self.ability:GetAutoCastState() then
				local target_point = enemy:GetAbsOrigin()
				if target_point == origin then
					target_point = target_point + enemy:GetForwardVector() * 10
				end
				local direction = Vector(0, 0, 0)
				local distance = 0

				if (target_point - origin):Length2D() > self.ability.talents.r4_distance_min then
					local pull_point = origin
						+ (target_point - origin):Normalized() * self.ability.talents.r4_distance_min
					direction = pull_point - target_point
					distance = math.min(self.ability.talents.r4_distance_max, direction:Length2D())
					direction = direction:Normalized()
				end

				enemy:AddNewModifier(self.parent, self.ability, "modifier_generic_arc", {
					dir_x = direction.x,
					dir_y = direction.y,
					duration = self.ability.talents.r4_duration,
					distance = distance,
					fix_end = false,
					isStun = false,
					activity = ACT_DOTA_FLAIL,
				})
			end
			enemy:EmitSound("Maiden.Freezing_silence")
			enemy:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_generic_silence",
				{ duration = (1 - enemy:GetStatusResistance()) * self.ability.talents.r4_silence }
			)
			enemy:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_crystal_maiden_freezing_field_custom_knock_cd",
				{ duration = self.ability.talents.r4_cd }
			)
		end
	end

	if self.ability.talents.has_r7 == 1 then
		self.parent:GiveMana(self.ability.talents.r7_mana_regen * self.parent:GetMaxMana() * self.explosion_interval)
	end

	if
		self.parent:HasScepter()
		and self:GetRemainingTime() <= self.ability.talents.r2_linger
		and self.ability.talents.has_r2 == 1
	then
		self:EndEffect()
	end

	self.quartal = self.quartal + 1
	if self.quartal > 3 then
		self.quartal = 0
	end

	local a = math.rad(RandomInt(0, 90) + self.quartal * 90)
	local r = RandomInt(self.explosion_min_dist, self.explosion_max_dist)
	local point = Vector(math.cos(a), math.sin(a), 0):Normalized() * r
	point = origin + point

	self.ability:DealDamage(self.explosion_radius, point)

	local effect_cast = ParticleManager:CreateParticle(self.shard_effect, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOnLocationWithCaster(point, "hero_Crystal.freezingField.explosion", self.parent)
end

modifier_crystal_maiden_freezing_field_custom_debuff = class(mod_visible)
function modifier_crystal_maiden_freezing_field_custom_debuff:IsPurgable()
	return true
end
function modifier_crystal_maiden_freezing_field_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end
function modifier_crystal_maiden_freezing_field_custom_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_crystal_maiden_freezing_field_custom_debuff:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.ms_slow = self.ability.movespeed_slow
	self.as_slow = self.ability.attack_slow

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/generic_gameplay/generic_slowed_cold.vpcf", self)
end

function modifier_crystal_maiden_freezing_field_custom_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_crystal_maiden_freezing_field_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_crystal_maiden_freezing_field_custom_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

modifier_crystal_maiden_freezing_field_custom_tracker = class(mod_hidden)
function modifier_crystal_maiden_freezing_field_custom_tracker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.parent.freezing_field_ability = self.ability

	self.legendary_ability = self.parent:FindAbilityByName("crystal_maiden_freezing_field_legendary")
	if IsValid(self.legendary_ability) then
		if IsServer() and not self.legendary_ability:IsTrained() then
			self.legendary_ability:SetLevel(1)
		end
		self.legendary_ability:UpdateTalents()
	end

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.explosion_radius = self.ability:GetSpecialValueFor("explosion_radius")
	self.ability.explosion_interval = self.ability:GetSpecialValueFor("explosion_interval")
	self.ability.movespeed_slow = self.ability:GetSpecialValueFor("movespeed_slow")
	self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.attack_slow = self.ability:GetSpecialValueFor("attack_slow")
	self.ability.scepter_slow = self.ability:GetSpecialValueFor("scepter_slow")

	self.spell_count = 0
end

function modifier_crystal_maiden_freezing_field_custom_tracker:OnRefresh()
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.attack_slow = self.ability:GetSpecialValueFor("attack_slow")
end

function modifier_crystal_maiden_freezing_field_custom_tracker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
end

function modifier_crystal_maiden_freezing_field_custom_tracker:GetModifierPercentageCooldown()
	return self.ability.talents.r3_cdr
end

function modifier_crystal_maiden_freezing_field_custom_tracker:SpellEvent(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self.parent then
		return
	end

	if self.ability.talents.has_r3 == 1 then
		self.spell_count = self.spell_count + 1
		if self.spell_count >= self.ability.talents.r3_count then
			self.spell_count = 0
			local point = nil
			local target = self.parent:RandomTarget(self.ability.talents.r3_radius)

			if target then
				point = target:GetAbsOrigin()
			else
				point = self.parent:GetAbsOrigin() + RandomVector(500)
			end
			self.ability:SummonShard(point, "modifier_maiden_freezing_3")
		end
	end

	if self.ability.talents.has_r7 == 0 then
		return
	end
	if not self.legendary_ability then
		return
	end
	if params.ability == self.legendary_ability then
		return
	end

	self.parent:CdAbility(self.legendary_ability, nil, self.ability.talents.r7_cd_inc, "modifier_maiden_freezing_7")
end

modifier_crystal_maiden_freezing_field_custom_legendary_mini = class(mod_hidden)
function modifier_crystal_maiden_freezing_field_custom_legendary_mini:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.origin = self.parent:GetAbsOrigin()

	self.radius = 250
	self.damage_ability = table.damage_ability
end

function modifier_crystal_maiden_freezing_field_custom_legendary_mini:OnDestroy()
	if not IsServer() then
		return
	end

	local effect_cast2 =
		ParticleManager:CreateParticle("particles/crystal_maiden/maiden_field_legendary.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast2, 0, self.origin)
	ParticleManager:SetParticleControl(effect_cast2, 1, Vector(self.radius, 3, self.radius))
	ParticleManager:ReleaseParticleIndex(effect_cast2)

	self.ability:DealDamage(self.radius, self.origin, self.damage_ability)

	EmitSoundOnLocationWithCaster(self.origin, "Maiden.Freezing_damage", self.caster)
	EmitSoundOnLocationWithCaster(self.origin, "Maiden.Freezing_damage2", self.caster)
end

modifier_crystal_maiden_freezing_field_custom_knock_cd = class(mod_hidden)

modifier_crystal_maiden_freezing_field_custom_cd_items = class(mod_hidden)
function modifier_crystal_maiden_freezing_field_custom_cd_items:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.interval = 0.5

	self:StartIntervalThink(self.interval)
end

function modifier_crystal_maiden_freezing_field_custom_cd_items:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:CdItems(self.interval * self.ability.talents.w4_cd_field, "modifier_maiden_frostbite_4")
end

crystal_maiden_freezing_field_legendary = class({})
crystal_maiden_freezing_field_legendary.talents = {}

function crystal_maiden_freezing_field_legendary:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.damage_interval = self:GetLevelSpecialValueFor("damage_interval", 1)
	self.start_interval = self:GetLevelSpecialValueFor("delay", 1)
end

function crystal_maiden_freezing_field_legendary:UpdateTalents()
	local caster = self:GetCaster()

	if not self.init then
		self.init = true
		self.talents = {
			has_r7 = 0,
			r7_count = caster:GetTalentValue("modifier_maiden_freezing_7", "count", true),
			r7_talent_cd = caster:GetTalentValue("modifier_maiden_freezing_7", "talent_cd", true),
			r7_mana = caster:GetTalentValue("modifier_maiden_freezing_7", "mana", true) / 100,
		}
	end

	if caster:HasTalent("modifier_maiden_freezing_7") then
		self.talents.has_r7 = 1
	end
end

function crystal_maiden_freezing_field_legendary:CreateTalent()
	self:SetHidden(false)
	self:UpdateTalents()
end

function crystal_maiden_freezing_field_legendary:GetAOERadius()
	return self.radius or 0
end

function crystal_maiden_freezing_field_legendary:GetCooldown()
	return self.talents.has_r7 == 1 and self.talents.r7_talent_cd or 0
end

function crystal_maiden_freezing_field_legendary:GetManaCost()
	return self.caster:GetMaxMana() * (self.talents.has_r7 == 1 and self.talents.r7_mana or 0)
end

function crystal_maiden_freezing_field_legendary:OnSpellStart()
	CreateModifierThinker(
		self.caster,
		self,
		"modifier_crystal_maiden_freezing_field_custom_legendary",
		{},
		self:GetCursorPosition(),
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_crystal_maiden_freezing_field_custom_legendary = class(mod_hidden)
function modifier_crystal_maiden_freezing_field_custom_legendary:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.origin = self.parent:GetAbsOrigin()
	self.ultimate = self.caster.freezing_field_ability

	self.start_interval = self.ability.start_interval
	self.damage_interval = self.ability.damage_interval
	self.radius = self.ability.radius
	self.max = self.ability.talents.r7_count

	AddFOWViewer(self.caster:GetTeamNumber(), self.origin, self.radius, self.start_interval, false)

	self.effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self.origin)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, self.radius, 1))
	self:AddParticle(self.effect_cast, false, false, -1, false, false)

	EmitSoundOnLocationWithCaster(self.origin, "Maiden.Frostbite_stun", self.caster)

	self.effect_timer = ParticleManager:CreateParticle(
		"particles/crystal_maiden/maiden_freezing_area.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(self.effect_timer, 1, Vector(0, 0, 100))
	ParticleManager:SetParticleControl(self.effect_timer, 5, Vector(self.radius, self.radius, self.radius))
	self:AddParticle(self.effect_timer, false, false, -1, false, false)

	self:SetStackCount(0)
	self:StartIntervalThink(self.start_interval)
end

function modifier_crystal_maiden_freezing_field_custom_legendary:OnIntervalThink()
	if not IsServer() then
		return
	end

	local point = self.origin + RandomVector(RandomInt(1, self.radius))

	if IsValid(self.ultimate) and self.ultimate:IsTrained() then
		self.ultimate:SummonShard(point, "modifier_maiden_freezing_7")
	end

	self:IncrementStackCount()

	if self:GetStackCount() >= self.max then
		self:Destroy()
	end

	AddFOWViewer(self.caster:GetTeamNumber(), self.origin, self.radius, self.damage_interval, false)
	self:StartIntervalThink(self.damage_interval)
end