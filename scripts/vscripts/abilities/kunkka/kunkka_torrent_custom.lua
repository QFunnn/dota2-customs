--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_kunkka_torrent_custom_tracker",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_delay",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_aoe",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_trail",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_water",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_wet",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_slow",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_stun",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_deep",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)

kunkka_torrent_custom = class({})
kunkka_torrent_custom.talents = {}
kunkka_torrent_custom.cast_max = 4

function kunkka_torrent_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource("particle", "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush_slow.vpcf", context)
	PrecacheResource("particle", "particles/morphling/wave_trail.vpcf", context)
	PrecacheResource("particle", "particles/kunkka/ship_stack.vpcf", context)
	PrecacheResource("particle", "particles/morphling/wave_trail_effect.vpcf", context)
	PrecacheResource("particle", "particles/kunkka/torrent_legendary_splash.vpcf", context)
	PrecacheResource("particle", "particles/kunkka/torrent_legendary.vpcf", context)
	PrecacheResource("particle", "particles/kunkka/torrent_refresh.vpcf", context)
end

function kunkka_torrent_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			r2_stun = 0,

			has_q1 = 0,
			q1_cd = 0,
			q1_damage = 0,
			q1_int = 0,

			q2_spell = 0,
			q2_range = 0,

			has_h4 = 0,
			h4_radius = caster:GetTalentValue("modifier_kunkka_hero_4", "radius", true),
			h4_silence = caster:GetTalentValue("modifier_kunkka_hero_4", "silence", true),
			h4_torrent_cd = caster:GetTalentValue("modifier_kunkka_hero_4", "torrent_cd", true),

			has_q3 = 0,
			q3_cd_inc = 0,
			q3_damage = 0,
			q3_duration = caster:GetTalentValue("modifier_kunkka_torrent_3", "duration", true),

			has_q4 = 0,
			q4_delay = caster:GetTalentValue("modifier_kunkka_torrent_4", "delay", true),
			q4_slow = caster:GetTalentValue("modifier_kunkka_torrent_4", "slow", true),
			q4_slow_legendary = caster:GetTalentValue("modifier_kunkka_torrent_4", "slow_legendary", true),
			q4_cd_items = caster:GetTalentValue("modifier_kunkka_torrent_4", "cd_items", true),

			has_q7 = 0,
			q7_step = caster:GetTalentValue("modifier_kunkka_torrent_7", "step", true),
			q7_delay_step = caster:GetTalentValue("modifier_kunkka_torrent_7", "delay_step", true) / 100,
			q7_radius = caster:GetTalentValue("modifier_kunkka_torrent_7", "radius", true),
			q7_duration = caster:GetTalentValue("modifier_kunkka_torrent_7", "duration", true),
			q7_max = caster:GetTalentValue("modifier_kunkka_torrent_7", "max", true),
			q7_decay = caster:GetTalentValue("modifier_kunkka_torrent_7", "decay", true),
			q7_crash = caster:GetTalentValue("modifier_kunkka_torrent_7", "crash", true) / 100,
			q7_damage = caster:GetTalentValue("modifier_kunkka_torrent_7", "damage", true) / 100,
			q7_damage_duration = caster:GetTalentValue("modifier_kunkka_torrent_7", "damage_duration", true),
			q7_damage_ticks = caster:GetTalentValue("modifier_kunkka_torrent_7", "damage_ticks", true),
			q7_slow = caster:GetTalentValue("modifier_kunkka_torrent_7", "slow", true),
			q7_turn = caster:GetTalentValue("modifier_kunkka_torrent_7", "turn", true),
			q7_deep = caster:GetTalentValue("modifier_kunkka_torrent_7", "deep", true),
			q7_talent_cd = caster:GetTalentValue("modifier_kunkka_torrent_7", "talent_cd", true),
			q7_cd = caster:GetTalentValue("modifier_kunkka_torrent_7", "cd", true),
		}

		self.cast = 0
		self.hit = {}
		self.proc = {}
		self.strong_mods = {}
	end

	if caster:HasTalent("modifier_kunkka_ship_2") then
		self.talents.r2_stun = caster:GetTalentValue("modifier_kunkka_ship_2", "stun")
	end

	if caster:HasTalent("modifier_kunkka_hero_4") then
		self.talents.has_h4 = 1
	end

	if caster:HasTalent("modifier_kunkka_torrent_1") then
		self.talents.has_q1 = 1
		self.talents.q1_cd = caster:GetTalentValue("modifier_kunkka_torrent_1", "cd")
		self.talents.q1_damage = caster:GetTalentValue("modifier_kunkka_torrent_1", "damage")
		self.talents.q1_int = caster:GetTalentValue("modifier_kunkka_torrent_1", "int") / 100
	end

	if caster:HasTalent("modifier_kunkka_torrent_2") then
		self.talents.q2_spell = caster:GetTalentValue("modifier_kunkka_torrent_2", "spell")
		self.talents.q2_range = caster:GetTalentValue("modifier_kunkka_torrent_2", "range")
	end

	if caster:HasTalent("modifier_kunkka_torrent_3") then
		self.talents.has_q3 = 1
		self.talents.q3_cd_inc = caster:GetTalentValue("modifier_kunkka_torrent_3", "cd_inc") / 100
		self.talents.q3_damage = caster:GetTalentValue("modifier_kunkka_torrent_3", "damage") / 100
		caster:AddSpellEvent(self.tracker, true)
	end

	if caster:HasTalent("modifier_kunkka_torrent_4") then
		self.talents.has_q4 = 1
	end

	if caster:HasTalent("modifier_kunkka_torrent_7") then
		self.talents.has_q7 = 1
	end
end

function kunkka_torrent_custom:GetAbilityTextureName()
	local icon = wearables_system:GetAbilityIconReplacement(self.caster, "kunkka_torrent", self)
	if self.talents.has_q7 == 1 then
		if icon == "kunkka_torrent" or icon == "kunkka/ti8_immortal_weapon_retro/kunkka_torrent_immortal_retro" then
			return "kunkka_torrent_storm"
		end
	end
	return icon
end

function kunkka_torrent_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_kunkka_torrent_custom_tracker"
end

function kunkka_torrent_custom:GetCooldown(iLevel)
	return self.BaseClass.GetCooldown(self, iLevel)
		+ (self.talents.q1_cd or 0)
		+ (self.talents.has_q7 == 1 and self.talents.q7_cd or 0)
end

function kunkka_torrent_custom:GetDamage(target)
	local damage = (self.torrent_damage or 0)
		+ (
			self.talents.has_q1 == 1
				and (self.talents.q1_damage + self.caster:GetIntellect(false) * self.talents.q1_int)
			or 0
		)
	return damage * ((target and target:IsCreep()) and (1 + (self.creeps_damage or 0)) or 1)
end

function kunkka_torrent_custom:GetRadius()
	return (self.radius or 0) + (self.talents.has_h4 == 1 and self.talents.h4_radius or 0)
end

function kunkka_torrent_custom:GetAOERadius()
	return self:GetRadius()
end

function kunkka_torrent_custom:OnSpellStart()
	local point = self:GetCursorPosition()
	local delay = self.delay + (self.talents.has_q4 == 1 and self.talents.q4_delay or 0)

	self.cast = self.cast % self.cast_max + 1
	self.hit[self.cast] = {}
	self.proc[self.cast] = nil
	self.used_cd = nil

	if IsValid(self.caster.xmark_ability) then
		delay = delay * (1 - (self.caster.xmark_ability:SpellDelay() or 0))
	end

	local dir = point - self.caster:GetAbsOrigin()
	dir.z = 0

	local count = 0
	if self.talents.has_q7 == 1 then
		count = math.floor(dir:Length2D() / self.talents.q7_step)
	end

	if count > 0 then
		dir = dir:Normalized()
	end

	for i = 0, count do
		local line_point = GetGroundPosition(point - dir * self.talents.q7_step * i, nil)
		local line_delay = delay * (1 - self.talents.q7_delay_step) ^ i

		CreateModifierThinker(
			self.caster,
			self,
			"modifier_kunkka_torrent_custom_delay",
			{ duration = line_delay, cast = self.cast },
			line_point,
			self.caster:GetTeamNumber(),
			false
		)
	end
end

function kunkka_torrent_custom:CreateTrail(point, crash)
	if not IsServer() then
		return
	end
	if not self:IsTrained() then
		return
	end
	if self.talents.has_q3 == 0 and self.talents.has_q7 == 0 then
		return
	end

	local radius = self.talents.q7_radius * (crash and self.talents.q7_crash or 1)
	local duration = self.talents.has_q7 == 1 and self.talents.q7_duration or self.talents.q3_duration

	CreateModifierThinker(
		self.caster,
		self,
		"modifier_kunkka_torrent_custom_trail",
		{ duration = duration, radius = radius },
		point,
		self.caster:GetTeamNumber(),
		false
	)
end

function kunkka_torrent_custom:StrongTorrent(target)
	if not IsServer() then
		return
	end

	local point = GetGroundPosition(target:GetAbsOrigin(), nil)

	for mod, _ in pairs(self.strong_mods) do
		if not IsValid(mod) then
			self.strong_mods[mod] = nil
		elseif (mod.center - point):Length2D() <= self:GetRadius() then
			return
		end
	end

	CreateModifierThinker(
		self.caster,
		self,
		"modifier_kunkka_torrent_custom_aoe",
		{ strong = 1 },
		point,
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_kunkka_torrent_custom_delay = class(mod_hidden)
function modifier_kunkka_torrent_custom_delay:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.cast = table.cast
	self.radius = self.ability:GetRadius()
	self.center = self.parent:GetAbsOrigin()

	local pfx = wearables_system:GetParticleReplacementAbility(
		self.caster,
		"particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf",
		self.ability
	)
	self.particle = ParticleManager:CreateParticleForTeam(pfx, PATTACH_WORLDORIGIN, nil, self.caster:GetTeamNumber())
	ParticleManager:SetParticleControl(self.particle, 0, self.center)
	self:AddParticle(self.particle, false, false, -1, false, false)

	AddFOWViewer(self.caster:GetTeamNumber(), self.center, self.radius, 3, false)

	EmitSoundOnLocationForAllies(self.center, "Ability.pre.Torrent", self.caster)
end

function modifier_kunkka_torrent_custom_delay:OnDestroy()
	if not IsServer() then
		return
	end

	CreateModifierThinker(
		self.caster,
		self.ability,
		"modifier_kunkka_torrent_custom_aoe",
		{ cast = self.cast },
		self.center,
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_kunkka_torrent_custom_aoe = class(mod_hidden)
function modifier_kunkka_torrent_custom_aoe:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.center = self.parent:GetAbsOrigin()
	EmitSoundOnLocationWithCaster(self.center, "Ability.Torrent", self.caster)
	local effect = "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf"

	self.count = 0
	self.max = self.ability.damage_ticks
	self.cast = table.cast
	self.strong = table.strong == 1
	self.stun = self.ability.stun_duration + self.ability.talents.r2_stun
	self.duration = self.stun
	self.radius = self.ability:GetRadius()
	self.slow_duration = self.ability.slow_duration

	self.damage_k = 1
	self.hit = self.ability.hit[table.cast] or {}

	if self.strong then
		effect = "particles/kunkka/torrent_legendary_splash.vpcf"
		self.duration = self.ability.talents.q7_damage_duration
		self.max = self.ability.talents.q7_damage_ticks
		self.damage_k = self.ability.talents.q7_damage
		self.source = "modifier_kunkka_torrent_7"
		self.ability.strong_mods[self] = true

		EmitSoundOnLocationWithCaster(self.center, "Kunkka.Torrent_legendary", self.caster)
		self.parent:GenericParticle("particles/kunkka/torrent_legendary.vpcf", self)
	end

	self.damage_k = self.damage_k / self.max
	self.interval = self.duration / self.max

	if not self.strong then
		local replacement = wearables_system:GetParticleReplacementAbility(self.caster, effect, self.ability)
		local is_whale_blade = string.find(replacement, "particles/econ/items/kunkka/kunkka_weapon_whaleblade", 1, true)
			~= nil
		if self.ability.talents.has_q7 ~= 1 or not is_whale_blade then
			effect = replacement
		end
	end
	self.particle = ParticleManager:CreateParticle(effect, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.particle, 0, self.center)
	ParticleManager:ReleaseParticleIndex(self.particle)

	self.damageTable = { attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL }

	if not self.strong then
		self.ability:CreateTrail(self.center)
	end

	self:OnIntervalThink(true)
	self:StartIntervalThink(self.interval)
end

function modifier_kunkka_torrent_custom_aoe:OnIntervalThink(first)
	if not IsServer() then
		return
	end

	for _, target in pairs(self.caster:FindTargets(self.radius, self.center)) do
		if self.hit[target] == nil then
			self.hit[target] = self

			if self.strong then
				local wet = target:FindModifierByName("modifier_kunkka_torrent_custom_wet")
				if wet then
					wet:Destroy()
				end

				target:StartCd("kunkka_torrent_7", self.ability.talents.q7_talent_cd)
			end
		end

		if self.hit[target] == self then
			self.damageTable.damage = self.ability:GetDamage(target) * self.damage_k
			self.damageTable.victim = target

			local real_damage = DoDamage(self.damageTable, self.source)
			if self.strong then
				target:SendNumber(111, real_damage)
			end
		end

		if first then
			if IsValid(self.caster.kunkka_innate) then
				self.caster.kunkka_innate:ApplyHealReduce(target)
			end
			if IsValid(self.caster.xmark_ability) then
				self.caster.xmark_ability:SpellAttack(target)
			end

			if self.strong then
				target:AddNewModifier(
					self.caster,
					self.ability,
					"modifier_kunkka_torrent_custom_deep",
					{ duration = self.duration }
				)
			elseif not target:HasModifier("modifier_kunkka_torrent_custom_stun") then
				target:AddNewModifier(
					self.caster,
					self.ability,
					"modifier_kunkka_torrent_custom_stun",
					{ duration = self.stun }
				)

				if target:IsRealHero() and self.caster:GetQuest() == "Kunkka.Quest_5" then
					self.caster:UpdateQuest(1)
				end

				if self.ability.talents.has_q4 == 1 and not self.ability.proc[self.cast] then
					self.ability.proc[self.cast] = true

					self.caster:CdItems(self.ability.talents.q4_cd_items)
				end
			end
		end

		if not self.strong then
			target:AddNewModifier(
				self.caster,
				self.ability,
				"modifier_kunkka_torrent_custom_slow",
				{ duration = self.slow_duration }
			)
		end
	end

	self.count = self.count + 1
	if self.count >= self.max then
		self:Destroy()
		return
	end
end

function modifier_kunkka_torrent_custom_aoe:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.strong then
		return
	end

	self.ability.strong_mods[self] = nil
end

modifier_kunkka_torrent_custom_trail = class(mod_hidden)
function modifier_kunkka_torrent_custom_trail:IsAura()
	return true
end
function modifier_kunkka_torrent_custom_trail:GetAuraDuration()
	return 0
end
function modifier_kunkka_torrent_custom_trail:GetAuraRadius()
	return self.radius
end
function modifier_kunkka_torrent_custom_trail:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_kunkka_torrent_custom_trail:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_kunkka_torrent_custom_trail:GetModifierAura()
	return "modifier_kunkka_torrent_custom_water"
end
function modifier_kunkka_torrent_custom_trail:OnCreated(table)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.center = self.parent:GetAbsOrigin()

	if not IsServer() then
		return
	end
	self.radius = table.radius

	self.particle = ParticleManager:CreateParticle("particles/morphling/wave_trail.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.particle, 0, self.center)
	ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, 0, 0))
	self:AddParticle(self.particle, false, false, -1, false, false)
end

modifier_kunkka_torrent_custom_water = class(mod_hidden)
function modifier_kunkka_torrent_custom_water:GetStatusEffectName()
	return "particles/status_fx/status_effect_naga_riptide.vpcf"
end
function modifier_kunkka_torrent_custom_water:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end
function modifier_kunkka_torrent_custom_water:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.interval = 0.5
	self:OnRefresh()

	if not IsServer() then
		return
	end
	self.time = 0
	self.damageTable =
		{ attacker = self.caster, ability = self.ability, victim = self.parent, damage_type = DAMAGE_TYPE_MAGICAL }

	self.parent:GenericParticle("particles/morphling/wave_trail_effect.vpcf", self)
	self:StartIntervalThink(self.interval)
end

function modifier_kunkka_torrent_custom_water:OnRefresh()
	self.slow = 0
	self.turn = 0

	if self.ability.talents.has_q7 == 0 then
		return
	end

	self.slow = self.ability.talents.q7_slow
		+ (self.ability.talents.has_q4 == 1 and self.ability.talents.q4_slow_legendary or 0)
	self.turn = self.ability.talents.q7_turn
end

function modifier_kunkka_torrent_custom_water:OnIntervalThink()
	if not IsServer() then
		return
	end

	if self.ability.talents.has_q3 == 1 then
		self.damageTable.damage = self.ability:GetDamage(self.parent) * self.ability.talents.q3_damage * self.interval
		DoDamage(self.damageTable, "modifier_kunkka_torrent_3")
	end

	if self.ability.talents.has_q7 == 0 then
		return
	end

	self.time = self.time + self.interval
	if self.time < 1 then
		return
	end
	self.time = 0

	if self.parent:HasCd("kunkka_torrent_7", self.ability.talents.q7_talent_cd) then
		return
	end

	self.parent:AddNewModifier(self.caster, self.ability, "modifier_kunkka_torrent_custom_wet", {})
end

function modifier_kunkka_torrent_custom_water:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
	}
end

function modifier_kunkka_torrent_custom_water:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_kunkka_torrent_custom_water:GetModifierTurnRate_Percentage()
	return self.turn
end

modifier_kunkka_torrent_custom_wet = class(mod_visible)
function modifier_kunkka_torrent_custom_wet:GetTexture()
	return "kunkka_torrent"
end
function modifier_kunkka_torrent_custom_wet:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.RemoveForDuel = true
	self.max = self.ability.talents.q7_max
	self.decay = self.ability.talents.q7_decay

	self.particle = self.parent:GenericParticle("particles/kunkka/ship_stack.vpcf", self, true)

	self:OnRefresh()
end

function modifier_kunkka_torrent_custom_wet:OnRefresh()
	if not IsServer() then
		return
	end

	self:StartIntervalThink(self.decay)

	if self:GetStackCount() < self.max then
		self:IncrementStackCount()
	end

	ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))

	if self:GetStackCount() >= self.max then
		self.ability:StrongTorrent(self.parent)
	end
end

function modifier_kunkka_torrent_custom_wet:OnIntervalThink()
	if not IsServer() then
		return
	end

	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:Destroy()
		return
	end

	ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
	self:StartIntervalThink(1)
end

modifier_kunkka_torrent_custom_slow = class(mod_visible)
function modifier_kunkka_torrent_custom_slow:IsPurgable()
	return true
end
function modifier_kunkka_torrent_custom_slow:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.slow = self.ability.movespeed_bonus
		+ (self.ability.talents.has_q4 == 1 and self.ability.talents.has_q7 == 0 and self.ability.talents.q4_slow or 0)
	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/units/heroes/hero_tidehunter/tidehunter_gush_slow.vpcf", self)
end

function modifier_kunkka_torrent_custom_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_kunkka_torrent_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

modifier_kunkka_torrent_custom_deep = class(mod_hidden)
function modifier_kunkka_torrent_custom_deep:IsPurgable()
	return true
end
function modifier_kunkka_torrent_custom_deep:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.slow = self.ability.talents.q7_deep

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/units/heroes/hero_tidehunter/tidehunter_gush_slow.vpcf", self)
end

function modifier_kunkka_torrent_custom_deep:CheckState()
	return {
		[MODIFIER_STATE_TETHERED] = true,
	}
end

function modifier_kunkka_torrent_custom_deep:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_kunkka_torrent_custom_deep:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

modifier_kunkka_torrent_custom_tracker = class(mod_hidden)
function modifier_kunkka_torrent_custom_tracker:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.parent.torrent_ability = self.ability

	self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
	self.ability.torrent_damage = self.ability:GetSpecialValueFor("torrent_damage")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.movespeed_bonus = self.ability:GetSpecialValueFor("movespeed_bonus")
	self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
	self.ability.delay = self.ability:GetSpecialValueFor("delay")
	self.ability.damage_ticks = self.ability:GetSpecialValueFor("damage_ticks")
	self.ability.creeps_damage = self.ability:GetSpecialValueFor("creeps_damage") / 100

	self.ignore_angle = false
	self.parent:AddOrderEvent(self)
end

function modifier_kunkka_torrent_custom_tracker:OnRefresh(table)
	self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
	self.ability.torrent_damage = self.ability:GetSpecialValueFor("torrent_damage")
end

function modifier_kunkka_torrent_custom_tracker:SpellEvent(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if self.ability.talents.has_q3 == 0 then
		return
	end
	if self.ability.used_cd then
		return
	end
	if self.ability == params.ability then
		return
	end
	if self.ability:GetCooldownTimeRemaining() <= 0 then
		return
	end

	local particle =
		ParticleManager:CreateParticle("particles/kunkka/torrent_refresh.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	self.ability.used_cd = true
	self.parent:CdAbility(self.ability, nil, self.ability.talents.q3_cd_inc)
end

function modifier_kunkka_torrent_custom_tracker:OrderEvent(params)
	if not IsServer() then
		return
	end
	if self.parent:GetCurrentActiveAbility() == self.ability then
		return
	end

	self.ignore_angle = false

	if params.order_type ~= DOTA_UNIT_ORDER_CAST_POSITION then
		return
	end
	if not params.ability or params.ability ~= self.ability then
		return
	end
	if not params.pos then
		return
	end
	if (params.pos - self.parent:GetAbsOrigin()):Length2D() > self.ability:GetEffectiveCastRange(params.pos, nil) then
		return
	end

	self.ignore_angle = true
end

function modifier_kunkka_torrent_custom_tracker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_kunkka_torrent_custom_tracker:GetModifierCastRangeBonusStacking()
	return self.ability.talents.q2_range
end

function modifier_kunkka_torrent_custom_tracker:GetModifierSpellAmplify_Percentage()
	return self.ability.talents.q2_spell
end

function modifier_kunkka_torrent_custom_tracker:GetModifierDisableTurning()
	if not self.ignore_angle then
		return
	end
	return 1
end

function modifier_kunkka_torrent_custom_tracker:GetModifierIgnoreCastAngle()
	if not self.ignore_angle then
		return
	end
	return 1
end

modifier_kunkka_torrent_custom_stun = class(mod_hidden)
function modifier_kunkka_torrent_custom_stun:IsPurgeException()
	return true
end
function modifier_kunkka_torrent_custom_stun:IsStunDebuff()
	return true
end
function modifier_kunkka_torrent_custom_stun:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.parent:IsDebuffImmune() then
		self.parent:InterruptMotionControllers(false)
	end

	local height = 300
	local anim_time = self:GetRemainingTime() - 0.3

	self.mod = self.parent:AddNewModifier(self.caster, self.ability, "modifier_knockback", {
		center_x = self.parent:GetAbsOrigin().x,
		center_y = self.parent:GetAbsOrigin().y,
		center_z = self.parent:GetAbsOrigin().z,
		knockback_distance = 0,
		knockback_height = height,
		duration = anim_time,
		knockback_duration = anim_time,
		should_stun = true,
	})

	self.parent:StartGesture(ACT_DOTA_FLAIL)
	self:StartIntervalThink(anim_time)
end

function modifier_kunkka_torrent_custom_stun:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:RemoveGesture(ACT_DOTA_FLAIL)
	self.parent:StartGesture(ACT_DOTA_DISABLED)
	self:StartIntervalThink(-1)
end

function modifier_kunkka_torrent_custom_stun:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_kunkka_torrent_custom_stun:OnDestroy()
	if not IsServer() then
		return
	end

	if IsValid(self.mod) then
		self.mod:Destroy()
	end

	if
		self.ability.talents.has_h4 == 1 and self.parent:CheckCd("kunkka_hero_4", self.ability.talents.h4_torrent_cd)
	then
		self.parent:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_generic_silence",
			{ duration = (1 - self.parent:GetStatusResistance()) * self.ability.talents.h4_silence, use_sound = 1 }
		)
	end

	self.parent:FadeGesture(ACT_DOTA_DISABLED)
end