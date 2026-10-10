--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bane_fiends_grip_custom", "abilities/bane/bane_fiends_grip_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_tracker",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_sound",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_sound_caster",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_legendary_stack",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_bane_grip_7"
)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_legendary_cast",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_legendary_illusion",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_absorb",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_bane_hero_6"
)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_absorb_cd",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE,
	{ true, "modifier_bane_hero_6" }
)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_spell_damage",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_bane_grip_3"
)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_move_stack",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE,
	"modifier_bane_grip_4"
)
LinkLuaModifier(
	"modifier_bane_fiends_grip_custom_move",
	"abilities/bane/bane_fiends_grip_custom",
	LUA_MODIFIER_MOTION_NONE,
	{ true, "modifier_bane_grip_4" }
)

bane_fiends_grip_custom = class({})
bane_fiends_grip_custom.active_mod = nil
bane_fiends_grip_custom.legendary_illusion = nil
bane_fiends_grip_custom.talents = {}

function bane_fiends_grip_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/units/heroes/hero_bane/bane_fiends_grip.vpcf", context)
	PrecacheResource("particle", "particles/bane/grip_legendary_status.vpcf", context)
	PrecacheResource("particle", "particles/bane/grip_legendary.vpcf", context)
	PrecacheResource("particle", "particles/bane/grip_legendary_stack.vpcf", context)
	PrecacheResource("particle", "particles/bane/sap_legendaryc.vpcf", context)
	PrecacheResource("particle", "particles/bane/grip_absorb.vpcf", context)
	PrecacheResource("particle", "particles/bane/grip_legendary_spells.vpcf", context)
	PrecacheResource("particle", "particles/bane/grip_move.vpcf", context)
	PrecacheResource("particle", "particles/bane/grip_move_trail.vpcf", context)
	PrecacheResource("particle", "particles/bane/enfeeble_damage.vpcf", context)
end

function bane_fiends_grip_custom:UpdateTalents()
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			r1_cd = 0,
			r1_duration = 0,

			has_r2 = 0,
			r2_damage = 0,
			r2_base = 0,
			r2_damage_type = caster:GetTalentValue("modifier_bane_grip_2", "damage_type", true),

			has_r3 = 0,
			r3_cdr = 0,
			r3_damage = 0,
			r3_duration = caster:GetTalentValue("modifier_bane_grip_3", "duration", true),
			r3_max = caster:GetTalentValue("modifier_bane_grip_3", "max", true),

			has_r4 = 0,
			r4_max = caster:GetTalentValue("modifier_bane_grip_4", "max", true),
			r4_duration = caster:GetTalentValue("modifier_bane_grip_4", "duration", true),
			r4_move = caster:GetTalentValue("modifier_bane_grip_4", "move", true),
			r4_cd_items = caster:GetTalentValue("modifier_bane_grip_4", "cd_items", true),
			r4_slow_resist = caster:GetTalentValue("modifier_bane_grip_4", "slow_resist", true),
			r4_effect_duration = caster:GetTalentValue("modifier_bane_grip_4", "effect_duration", true),

			has_h6 = 0,
			h6_cd = caster:GetTalentValue("modifier_bane_hero_6", "cd", true),
			h6_damage_reduce = caster:GetTalentValue("modifier_bane_hero_6", "damage_reduce", true),
			h6_duration = caster:GetTalentValue("modifier_bane_hero_6", "duration", true),
			h6_thresh = caster:GetTalentValue("modifier_bane_hero_6", "thresh", true),

			has_r7 = 0,
			r7_effect_duration = caster:GetTalentValue("modifier_bane_grip_7", "effect_duration", true),
			r7_max = caster:GetTalentValue("modifier_bane_grip_7", "max", true),
			r7_radius = caster:GetTalentValue("modifier_bane_grip_7", "radius", true),
			r7_incoming = caster:GetTalentValue("modifier_bane_grip_7", "incoming", true),
			r7_outgoing = caster:GetTalentValue("modifier_bane_grip_7", "outgoing", true),
			r7_duration = caster:GetTalentValue("modifier_bane_grip_7", "duration", true),
			r7_delay = caster:GetTalentValue("modifier_bane_grip_7", "delay", true),
			r7_cast_range = caster:GetTalentValue("modifier_bane_grip_7", "cast_range", true),
			r7_stun = caster:GetTalentValue("modifier_bane_grip_7", "stun", true),
			r7_damage = caster:GetTalentValue("modifier_bane_grip_7", "damage", true) / 100,
			r7_creeps = caster:GetTalentValue("modifier_bane_grip_7", "creeps", true),
			r7_heal = caster:GetTalentValue("modifier_bane_grip_7", "heal", true) / 100,
			r7_talent_cd = caster:GetTalentValue("modifier_bane_grip_7", "talent_cd", true),
		}
	end

	if caster:HasTalent("modifier_bane_grip_1") then
		self.talents.r1_cd = caster:GetTalentValue("modifier_bane_grip_1", "cd")
		self.talents.r1_duration = caster:GetTalentValue("modifier_bane_grip_1", "duration")
	end

	if caster:HasTalent("modifier_bane_grip_2") then
		self.talents.has_r2 = 1
		self.talents.r2_damage = caster:GetTalentValue("modifier_bane_grip_2", "damage") / 100
		self.talents.r2_base = caster:GetTalentValue("modifier_bane_grip_2", "base")
	end

	if caster:HasTalent("modifier_bane_grip_3") then
		self.talents.has_r3 = 1
		self.talents.r3_cdr = caster:GetTalentValue("modifier_bane_grip_3", "cdr")
		self.talents.r3_damage = caster:GetTalentValue("modifier_bane_grip_3", "damage")
	end

	if caster:HasTalent("modifier_bane_grip_4") then
		self.talents.has_r4 = 1
	end

	if caster:HasTalent("modifier_bane_grip_7") then
		self.talents.has_r7 = 1
		self.tracker:StartIntervalThink(self.tracker.interval)
		self.tracker:UpdateUI()
	end

	if caster:HasTalent("modifier_bane_hero_6") then
		self.talents.has_h6 = 1
		caster:AddDamageEvent_inc(self.tracker, true)
		self.tracker:StartIntervalThink(self.tracker.interval)
	end
end

function bane_fiends_grip_custom:GetAbilityTextureName()
	return wearables_system:GetAbilityIconReplacement(self.caster, "bane_fiends_grip", self)
end

function bane_fiends_grip_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_bane_fiends_grip_custom_tracker"
end

function bane_fiends_grip_custom:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_CHANNELLED
end

function bane_fiends_grip_custom:GetCooldown(level)
	return self.BaseClass.GetCooldown(self, level) + (self.talents.r1_cd or 0)
end

function bane_fiends_grip_custom:GetManaCost(level)
	return self.BaseClass.GetManaCost(self, level)
end

function bane_fiends_grip_custom:GetCastRange(vLocation, hTarget)
	return self.BaseClass.GetCastRange(self, vLocation, hTarget)
		+ (self.caster:HasScepter() and (self.scepter_range or 0) or 0)
end

function bane_fiends_grip_custom:GetCastPoint(iLevel)
	return self.BaseClass.GetCastPoint(self)
end

function bane_fiends_grip_custom:GetChannelTime()
	if self.caster:HasScepter() then
		return self.scepter_duration or 0
	end
	if not self.caster:HasModifier("modifier_bane_fiends_grip_custom_tracker") then
		return self:GetFullDuration()
	end
	return (self.caster:GetUpgradeStack("modifier_bane_fiends_grip_custom_tracker") * self:GetFullDuration() / 100)
end

function bane_fiends_grip_custom:GetFullDuration()
	return (self.channel_time or 0) + (self.talents.r1_duration or 0)
end

function bane_fiends_grip_custom:OnSpellStart()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	local duration = self:GetChannelTime()
	if self.caster:HasScepter() then
		local full = self:GetFullDuration()
		duration = math.max(full, full * (1 - target:GetStatusResistance()))
	end
	self.current_target = target
	target:RemoveModifierByName("modifier_bane_nightmare_custom")
	self.active_mod =
		target:AddNewModifier(self.caster, self, "modifier_bane_fiends_grip_custom", { duration = duration })
end

function bane_fiends_grip_custom:OnChannelThink(flInterval)
	local target = self.current_target

	if IsValid(target) and target:HasModifier("modifier_bane_fiends_grip_custom") then
		return
	end
	self.caster:Interrupt()
end

function bane_fiends_grip_custom:OnChannelFinish(bInterrupted)
	local target = self.current_target

	self.current_target = nil
	self.active_mod = nil

	if not IsValid(target) then
		return
	end

	local mod = target:FindModifierByName("modifier_bane_fiends_grip_custom")
	if not mod then
		return
	end
	if self.caster:HasScepter() and mod:GetElapsedTime() >= (self.scepter_duration or 0) - 0.03 then
		return
	end

	mod:Destroy()
end

modifier_bane_fiends_grip_custom = class(mod_visible)
function modifier_bane_fiends_grip_custom:IsStunDebuff()
	return true
end
function modifier_bane_fiends_grip_custom:IsPurgeException()
	return true
end
function modifier_bane_fiends_grip_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_bane_fiends_grip_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_fiendsgrip.vpcf"
end
function modifier_bane_fiends_grip_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end
function modifier_bane_fiends_grip_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	if not IsServer() then
		return
	end
	self.ticks = self.ability.fiend_grip_ticks

	if
		self.parent:IsRealHero()
		and IsValid(self.caster.bane_innate_ability)
		and IsValid(self.caster.bane_innate_ability.tracker)
	then
		self.caster.bane_innate_ability.tracker:UpdateMod(self)
	end

	self.max_time = self:GetRemainingTime()
	self.damage_ability = nil

	self.auto = 0
	if table.illusion then
		self.auto = 1
		self.damage_ability = "modifier_bane_grip_7"
		self.illusion = EntIndexToHScript(table.illusion)
		self.caster_sound = self.illusion:AddNewModifier(
			self.illusion,
			self.ability,
			"modifier_bane_fiends_grip_custom_sound_caster",
			{ duration = self:GetRemainingTime() }
		)
		self.ticks = 3
		self.interval = self.max_time / self.ticks

		local damage = self.parent:GetMaxHealth() * self.ability.talents.r7_damage
		if self.parent:IsCreep() then
			damage = self.ability.talents.r7_creeps
		end
		self.damage = damage / self.ticks
	else
		self.interval = self.max_time / (self.ticks - 1)
		self.damage = ((self.ability.fiend_grip_damage + self.ability.talents.r2_base) * self:GetRemainingTime())
			/ self.ticks
		self.caster_sound = self.caster:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_bane_fiends_grip_custom_sound_caster",
			{ duration = self:GetRemainingTime() }
		)
	end

	self.mana = self.ability.fiend_grip_mana_drain * self:GetRemainingTime() / self.ticks

	self.damageTable = {
		attacker = self.caster,
		victim = self.parent,
		ability = self.ability,
		damage_type = DAMAGE_TYPE_PURE,
		damage = self.damage,
	}

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_bane_fiends_grip_custom_sound",
		{ duration = self:GetRemainingTime() }
	)

	local effect_name = wearables_system:GetParticleReplacementAbility(
		self.caster,
		"particles/units/heroes/hero_bane/bane_fiends_grip.vpcf",
		self
	)

	self.parent:GenericParticle(effect_name, self)
	self.sound = false
	self.count = 0

	self:OnIntervalThink()
	self:StartIntervalThink(self.interval - 0.03)
end

function modifier_bane_fiends_grip_custom:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self.count >= self.ticks then
		return
	end

	local real_damage = DoDamage(self.damageTable, self.damage_ability)

	if self.auto == 0 then
		local mana = self.parent:GetMaxMana() * self.mana
		self.parent:Script_ReduceMana(mana, self.ability)
		self.caster:GiveMana(mana)
	elseif self.caster:IsAlive() then
		self.caster:GenericHeal(
			real_damage * self.ability.talents.r7_heal,
			self.ability,
			true,
			"particles/items3_fx/octarine_core_lifesteal.vpcf",
			"modifier_bane_grip_7"
		)
	end

	self.count = self.count + 1
end

function modifier_bane_fiends_grip_custom:OnDestroy()
	if not IsServer() then
		return
	end
	if not IsValid(self.parent) then
		return
	end

	if
		self.parent:IsRealHero()
		and IsValid(self.caster.bane_innate_ability)
		and IsValid(self.caster.bane_innate_ability.tracker)
	then
		self.caster.bane_innate_ability.tracker:UpdateMod(self, true)
	end

	if self.ability.talents.has_r2 == 1 and self.parent:IsAlive() and not self.illusion then
		local damage = (self.parent:GetMaxHealth() - self.parent:GetHealth()) * self.ability.talents.r2_damage
		local real_damage = DoDamage(
			{
				damage = damage,
				ability = self.ability,
				attacker = self.caster,
				victim = self.parent,
				damage_type = self.ability.talents.r2_damage_type,
			},
			"modifier_bane_grip_2"
		)
		self.parent:SendNumber(6, real_damage)

		self.parent:EmitSound("Bane.Grip_end")

		local effect_cast =
			ParticleManager:CreateParticle("particles/bane/enfeeble_damage.vpcf", PATTACH_WORLDORIGIN, self.parent)
		ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(effect_cast, 1, Vector(250, 0, 0))
		ParticleManager:Delete(effect_cast, 0)
	end

	if not self.parent:HasModifier(self:GetName()) then
		self.parent:RemoveModifierByName("modifier_bane_fiends_grip_custom_sound")
	end

	if self.caster_sound and not self.caster_sound:IsNull() then
		self.caster_sound:Destroy()
	end
end

function modifier_bane_fiends_grip_custom:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

modifier_bane_fiends_grip_custom_tracker = class(mod_hidden)
function modifier_bane_fiends_grip_custom_tracker:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.interval = 0.2

	self.ability.fiend_grip_ticks = self.ability:GetSpecialValueFor("fiend_grip_ticks")
	self.ability.fiend_grip_damage = self.ability:GetSpecialValueFor("fiend_grip_damage")
	self.ability.fiend_grip_mana_drain = self.ability:GetSpecialValueFor("fiend_grip_mana_drain") / 100
	self.ability.channel_time = self.ability:GetSpecialValueFor("AbilityChannelTime")
	self.ability.scepter_range = self.ability:GetSpecialValueFor("scepter_range")
	self.ability.scepter_duration = self.ability:GetSpecialValueFor("scepter_duration")

	self.ability:UpdateTalents()

	self.parent:AddSpellEvent(self)

	self:SetStackCount(100)
end

function modifier_bane_fiends_grip_custom_tracker:OnRefresh(table)
	self.ability.fiend_grip_damage = self.ability:GetSpecialValueFor("fiend_grip_damage")
	self.ability.fiend_grip_mana_drain = self.ability:GetSpecialValueFor("fiend_grip_mana_drain") / 100
end

function modifier_bane_fiends_grip_custom_tracker:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self.ability.talents.has_h6 == 0 then
		return
	end
	if not self.parent:IsAlive() then
		return
	end
	if self.parent:HasModifier("modifier_bane_fiends_grip_custom_absorb") then
		return
	end
	if self.parent:HasModifier("modifier_bane_fiends_grip_custom_absorb_cd") then
		return
	end

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_bane_fiends_grip_custom_absorb", {})
end

function modifier_bane_fiends_grip_custom_tracker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
end

function modifier_bane_fiends_grip_custom_tracker:GetModifierPercentageCooldown()
	return self.ability.talents.r3_cdr
end

function modifier_bane_fiends_grip_custom_tracker:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.ability.talents.has_h6 == 0 then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if self.parent:GetTeamNumber() == params.attacker:GetTeamNumber() then
		return
	end
	if IsValid(self.ability.active_mod) then
		return
	end
	local attacker = params.attacker

	if attacker:IsCreep() and not players[attacker:GetId()] then
		return
	end
	if params.inflictor and params.original_damage < self.ability.talents.h6_thresh then
		return
	end

	local mod = self.parent:FindModifierByName("modifier_bane_fiends_grip_custom_absorb")

	if mod then
		mod:SetEnd()
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_bane_fiends_grip_custom_absorb_cd",
		{ duration = self.ability.talents.h6_cd }
	)
end

function modifier_bane_fiends_grip_custom_tracker:SpellEvent(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end

	local target = params.target

	if self.ability == params.ability and target then
		self:SetStackCount((1 - target:GetStatusResistance()) * 100)
	end

	if
		self.ability.talents.has_r3 == 1
		and target
		and target:IsUnit()
		and target:GetTeamNumber() ~= self.parent:GetTeamNumber()
	then
		target:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_bane_fiends_grip_custom_spell_damage",
			{ duration = self.ability.talents.r3_duration }
		)
	end

	if self.ability.talents.has_r4 == 1 and not self.parent:HasModifier("modifier_bane_fiends_grip_custom_move") then
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_bane_fiends_grip_custom_move_stack",
			{ duration = self.ability.talents.r4_effect_duration }
		)
	end

	if self.ability.talents.has_r7 == 0 then
		return
	end
	if IsValid(self.ability.legendary_illusion) then
		return
	end
	if self.parent:HasCd("bane_r7", self.ability.talents.r7_talent_cd) then
		return
	end

	local index = nil
	if target and target:GetTeamNumber() ~= self.parent:GetTeamNumber() then
		index = target:entindex()
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_bane_fiends_grip_custom_legendary_stack",
		{ target = index, duration = self.ability.talents.r7_effect_duration }
	)
end

function modifier_bane_fiends_grip_custom_tracker:UpdateUI()
	if not IsServer() then
		return
	end

	local stack = 0
	local zero = nil
	local active = 0
	local max = self.ability.talents.r7_max

	local mod = self.parent:FindModifierByName("modifier_bane_fiends_grip_custom_legendary_stack")

	if mod then
		stack = mod:GetStackCount()
		if self.particle then
			ParticleManager:DestroyParticle(self.particle, true)
			ParticleManager:ReleaseParticleIndex(self.particle)
			self.particle = nil
		end
	else
		if not self.particle then
			self.particle = self.parent:GenericParticle("particles/bane/grip_legendary_spells.vpcf", self, true)
			for i = 1, max do
				ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))
			end
		end
	end

	if IsValid(self.ability.legendary_illusion) and self.ability.legendary_illusion:IsAlive() then
		local mod =
			self.ability.legendary_illusion:FindModifierByName("modifier_bane_fiends_grip_custom_legendary_illusion")
		if mod then
			active = 1
			zero = 1
			stack = mod:GetRemainingTime()
			max = self.ability.talents.r7_duration
		end
	end

	self.parent:UpdateUIlong({
		stack = stack,
		max = max,
		use_zero = zero,
		active = active,
		priority = 1,
		style = "BaneGrip",
	})
end

modifier_bane_fiends_grip_custom_sound = class(mod_hidden)
function modifier_bane_fiends_grip_custom_sound:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self:StartIntervalThink(0.05)
end

function modifier_bane_fiends_grip_custom_sound:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:StartGesture(ACT_DOTA_FLAIL)
	self.parent:EmitSound("Hero_Bane.FiendsGrip")
	self:StartIntervalThink(-1)
end

function modifier_bane_fiends_grip_custom_sound:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:FadeGesture(ACT_DOTA_FLAIL)
	self.parent:StopSound("Hero_Bane.FiendsGrip")
end

modifier_bane_fiends_grip_custom_sound_caster = class(mod_hidden)
function modifier_bane_fiends_grip_custom_sound_caster:OnCreated(table)
	self.parent = self:GetParent()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.05)
end

function modifier_bane_fiends_grip_custom_sound_caster:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:EmitSound("Hero_Bane.FiendsGrip.Cast")
	self:StartIntervalThink(-1)
end

function modifier_bane_fiends_grip_custom_sound_caster:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:StopSound("Hero_Bane.FiendsGrip.Cast")
end

modifier_bane_fiends_grip_custom_legendary_stack = class(mod_hidden)
function modifier_bane_fiends_grip_custom_legendary_stack:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.max = self.ability.talents.r7_max
	self.radius = self.ability.talents.r7_radius
	self.duration = self.ability.talents.r7_effect_duration

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self.mod = self.ability.tracker

	self.visual_max = self.max
	self.particle = self.parent:GenericParticle("particles/bane/grip_legendary_spells.vpcf", self, true)

	self:OnRefresh(table)
	self:StartIntervalThink(0.2)
end

function modifier_bane_fiends_grip_custom_legendary_stack:OnIntervalThink()
	if not IsServer() then
		return
	end
	local targets = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
		FIND_CLOSEST,
		false
	)

	if #targets > 0 then
		self:SetDuration(self.duration, true)
	end
end

function modifier_bane_fiends_grip_custom_legendary_stack:OnRefresh(params)
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end
	self:IncrementStackCount()

	if self.mod then
		self.mod:UpdateUI()
	end

	if self.particle then
		for i = 1, self.visual_max do
			if i <= math.floor(self:GetStackCount() / (self.max / self.visual_max)) then
				ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0))
			else
				ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))
			end
		end
	end

	if self:GetStackCount() < self.max then
		return
	end

	local point = self.parent:GetAbsOrigin()
	local target = params.target and EntIndexToHScript(params.target)
	if IsValid(target) then
		point = target:GetAbsOrigin()
	end

	point = point + RandomVector(300)

	local duration = self.ability.talents.r7_duration
	local incoming = self.ability.talents.r7_incoming - 100
	local damage = self.ability.talents.r7_outgoing - 100

	local illusions = CreateIllusions(
		self.parent,
		self.parent,
		{ duration = duration, outgoing_damage = damage, incoming_damage = incoming },
		1,
		1,
		false,
		true
	)
	for _, illusion in pairs(illusions) do
		illusion:Stop()
		illusion.owner = self.parent

		for _, mod in pairs(self.parent:FindAllModifiers()) do
			if mod.StackOnIllusion == true then
				illusion:UpgradeIllusion(mod:GetName(), mod:GetStackCount(), mod)
			end
		end

		illusion:EmitSound("Bane.Grip_legendary")
		illusion:EmitSound("Bane.Grip_legendary2")
		illusion:AddNewModifier(self.parent, nil, "modifier_chaos_knight_phantasm_illusion", {})
		illusion:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_bane_fiends_grip_custom_legendary_illusion",
			{ duration = duration, target = params.target }
		)

		illusion:SetAbsOrigin(point)
		FindClearSpaceForUnit(illusion, point, true)
		illusion:SetHealth(illusion:GetMaxHealth())
	end

	self:Destroy()
end

function modifier_bane_fiends_grip_custom_legendary_stack:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.mod then
		return
	end
	self.mod:UpdateUI()
end

modifier_bane_fiends_grip_custom_legendary_illusion = class(mod_hidden)
function modifier_bane_fiends_grip_custom_legendary_illusion:GetStatusEffectName()
	return "particles/bane/grip_legendary_status.vpcf"
end
function modifier_bane_fiends_grip_custom_legendary_illusion:StatusEffectPriority()
	return MODIFIER_PRIORITY_ILLUSION
end
function modifier_bane_fiends_grip_custom_legendary_illusion:OnCreated(table)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.cast_range = self.ability.talents.r7_cast_range
	self.cast_duration = self.ability.talents.r7_stun
	self.first_delay = self.ability.talents.r7_delay

	if not IsServer() then
		return
	end
	self.mod = self.ability.tracker
	self.ability.legendary_illusion = self.parent

	self.parent:GenericParticle("particles/bane/grip_legendary.vpcf", self)
	self.target = nil

	self.caster_vector = RandomVector(300)

	if table.target then
		self.target = EntIndexToHScript(table.target)
	end

	self.interval = 0.1

	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_bane_fiends_grip_custom_legendary_illusion:OnDestroy()
	if not IsServer() then
		return
	end
	self.ability.legendary_illusion = nil

	self.caster:StartCd("bane_r7", self.ability.talents.r7_talent_cd)

	if not self.mod then
		return
	end
	self.mod:UpdateUI()
end

function modifier_bane_fiends_grip_custom_legendary_illusion:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function modifier_bane_fiends_grip_custom_legendary_illusion:GetActivityTranslationModifiers()
	return "haste"
end

function modifier_bane_fiends_grip_custom_legendary_illusion:GetModifierModelScale()
	return 20
end

function modifier_bane_fiends_grip_custom_legendary_illusion:GetModifierMoveSpeed_Absolute()
	return 550
end

function modifier_bane_fiends_grip_custom_legendary_illusion:OnIntervalThink()
	if not IsServer() then
		return
	end

	local target = nil

	if self.mod then
		self.mod:UpdateUI()
	end

	if self.parent:HasModifier("modifier_bane_fiends_grip_custom_legendary_cast") then
		return
	end

	if IsValid(self.target) and self.target:IsAlive() and self.target:IsHero() then
		target = self.target
	else
		target = self.parent:RandomTarget(1000)
	end

	if not target then
		local point = self.caster:GetAbsOrigin() + self.caster_vector
		if (point - self.parent:GetAbsOrigin()):Length2D() >= 50 then
			self.parent:MoveToPosition(point)
		end
		return
	end

	AddFOWViewer(self.caster:GetTeamNumber(), target:GetAbsOrigin(), 10, self.interval * 2, false)

	if
		not self.cast_stun
		and (target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.cast_range
		and not target:IsInvulnerable()
		and not target:IsOutOfGame()
		and not target:HasModifier("modifier_bane_fiends_grip_custom")
		and self:GetElapsedTime() >= self.first_delay
		and not self.parent:IsStunned()
		and not self.parent:IsSilenced()
		and self.parent:CanEntityBeSeenByMyTeam(target)
		and not self.parent:IsHexed()
		and not self.parent:IsFeared()
	then
		self.cast_stun = true
		self.parent:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_bane_fiends_grip_custom_legendary_cast",
			{ duration = self.cast_duration, target = target:entindex() }
		)
	end

	self.target = target
	self.parent:SetForceAttackTarget(target)
	self.parent:MoveToTargetToAttack(target)
end

function modifier_bane_fiends_grip_custom_legendary_illusion:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

modifier_bane_fiends_grip_custom_legendary_cast = class(mod_hidden)
function modifier_bane_fiends_grip_custom_legendary_cast:OnCreated(table)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	self.target = EntIndexToHScript(table.target)

	if not IsValid(self.target) then
		return
	end

	self.mod = self.target:AddNewModifier(
		self.caster,
		self.ability,
		"modifier_bane_fiends_grip_custom",
		{ illusion = self.parent:entindex(), duration = self:GetRemainingTime() }
	)

	self.parent:FacePoint(self.target:GetAbsOrigin())

	self:StartIntervalThink(0.1)
end

function modifier_bane_fiends_grip_custom_legendary_cast:OnIntervalThink()
	if not IsServer() then
		return
	end

	if self:GetElapsedTime() >= 0.5 and not self.anim then
		self.anim = true
		self.parent:StartGesture(ACT_DOTA_CHANNEL_ABILITY_4)
	end

	if self.parent:IsStunned() or self.parent:IsSilenced() or self.parent:IsHexed() or self.parent:IsFeared() then
		self:Destroy()
		return
	end
end

function modifier_bane_fiends_grip_custom_legendary_cast:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_bane_fiends_grip_custom_legendary_cast:OnDestroy()
	if not IsServer() then
		return
	end
	if not IsValid(self.parent) then
		return
	end

	if self.mod and not self.mod:IsNull() then
		self.mod:Destroy()
	end

	self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
	self.parent:FadeGesture(ACT_DOTA_CHANNEL_ABILITY_4)
	self.parent:Kill(nil, nil)
end

modifier_bane_fiends_grip_custom_absorb = class(mod_visible)
function modifier_bane_fiends_grip_custom_absorb:GetTexture()
	return "buffs/bane/hero_8"
end
function modifier_bane_fiends_grip_custom_absorb:GetStatusEffectName()
	return "particles/status_fx/status_effect_phase_shift.vpcf"
end
function modifier_bane_fiends_grip_custom_absorb:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end
function modifier_bane_fiends_grip_custom_absorb:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.damage_cd = self.ability.talents.h6_cd
	self.damage_reduce = self.ability.talents.h6_damage_reduce
	self.duration = self.ability.talents.h6_duration

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/bane/grip_absorb.vpcf", self)
	self.parent:EmitSound("Bane.Grip_absorb")
end

function modifier_bane_fiends_grip_custom_absorb:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:Purge(false, true, false, true, true)
	self.parent:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_bane_fiends_grip_custom_absorb_cd",
		{ duration = self.damage_cd }
	)
end

function modifier_bane_fiends_grip_custom_absorb:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_bane_fiends_grip_custom_absorb:GetModifierIncomingDamage_Percentage(params)
	return self.damage_reduce
end

function modifier_bane_fiends_grip_custom_absorb:SetEnd()
	if not IsServer() then
		return
	end
	if self.ended then
		return
	end
	self.ended = true
	self:SetDuration(self.duration, true)
	self.parent:EmitSound("Bane.Grip_absorb_active")
	self.parent:GenericParticle("particles/bane/sap_legendaryc.vpcf", self)
end

modifier_bane_fiends_grip_custom_absorb_cd = class(mod_cd)
function modifier_bane_fiends_grip_custom_absorb_cd:GetTexture()
	return "buffs/bane/hero_8"
end

modifier_bane_fiends_grip_custom_spell_damage = class(mod_visible)
function modifier_bane_fiends_grip_custom_spell_damage:GetTexture()
	return "buffs/bane/grip_3"
end
function modifier_bane_fiends_grip_custom_spell_damage:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	self.max = self.ability.talents.r3_max
	self.damage = self.ability.talents.r3_damage

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self:OnRefresh()
end

function modifier_bane_fiends_grip_custom_spell_damage:OnRefresh(table)
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end
	self:IncrementStackCount()

	if not self.particle then
		self.particle = self.parent:GenericParticle("particles/bane/grip_legendary_stack.vpcf", self, true)
	end

	if not self.particle then
		return
	end
	ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
end

function modifier_bane_fiends_grip_custom_spell_damage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_bane_fiends_grip_custom_spell_damage:GetModifierIncomingDamage_Percentage(params)
	if IsServer() and (not params.attacker or params.attacker:FindOwner() ~= self.caster) then
		return
	end
	if params.inflictor == nil then
		return
	end
	if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
		return
	end
	if Not_spell_damage[params.inflictor:GetName()] then
		return
	end

	return self.damage * self:GetStackCount()
end

function modifier_bane_fiends_grip_custom_spell_damage:OnTooltip()
	return self.damage * self:GetStackCount()
end

modifier_bane_fiends_grip_custom_move_stack = class(mod_visible)
function modifier_bane_fiends_grip_custom_move_stack:GetTexture()
	return "buffs/bane/grip_4"
end
function modifier_bane_fiends_grip_custom_move_stack:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.max = self.ability.talents.r4_max
	if not IsServer() then
		return
	end
	self:OnRefresh()
end

function modifier_bane_fiends_grip_custom_move_stack:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()

	if self:GetStackCount() >= self.max then
		self.parent:CdItems(self.ability.talents.r4_cd_items, "modifier_bane_grip_4")
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_bane_fiends_grip_custom_move",
			{ duration = self.ability.talents.r4_duration }
		)
		self:Destroy()
	end
end

modifier_bane_fiends_grip_custom_move = class(mod_visible)
function modifier_bane_fiends_grip_custom_move:GetTexture()
	return "buffs/bane/grip_4"
end
function modifier_bane_fiends_grip_custom_move:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.move = self.ability.talents.r4_move
	self.resist = self.ability.talents.r4_slow_resist

	if not IsServer() then
		return
	end
	self.parent:EmitSound("Bane.Grip_move")
	self.parent:GenericParticle("particles/bane/grip_move_trail.vpcf", self)
	self.parent:GenericParticle("particles/bane/grip_move.vpcf")
end

function modifier_bane_fiends_grip_custom_move:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function modifier_bane_fiends_grip_custom_move:GetActivityTranslationModifiers()
	return "haste"
end

function modifier_bane_fiends_grip_custom_move:GetModifierMoveSpeedBonus_Percentage()
	return self.move
end

function modifier_bane_fiends_grip_custom_move:GetModifierSlowResistance_Stacking()
	return self.resist
end