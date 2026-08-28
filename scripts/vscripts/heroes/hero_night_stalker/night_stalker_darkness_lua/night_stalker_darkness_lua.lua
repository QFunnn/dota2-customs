--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


night_stalker_darkness_lua = class({})
LinkLuaModifier(
	"modifier_imba_darkness_night",
	"heroes/hero_night_stalker/night_stalker_darkness_lua/night_stalker_darkness_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_imba_darkness_vision",
	"heroes/hero_night_stalker/night_stalker_darkness_lua/night_stalker_darkness_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_night_fear_thinker",
	"heroes/hero_night_stalker/night_stalker_darkness_lua/night_stalker_darkness_lua",
	LUA_MODIFIER_MOTION_NONE
)

function night_stalker_darkness_lua:IsNetherWardStealable()
	return false
end
function night_stalker_darkness_lua:IsHiddenWhenStolen()
	return false
end

function night_stalker_darkness_lua:OnUpgrade()
	if self:IsStolen() then
		Timers:CreateTimer(FrameTime(), function()
			local caster = self:GetCaster()
			local has_darkness = caster:HasAbility("night_stalker_darkness_lua")
			local is_day = GameRules:IsDaytime()

			if not has_darkness then
				return nil
			end

			return FrameTime()
		end)
	end
end

function night_stalker_darkness_lua:OnSpellStart()
	-- Ability properties
	local caster = self:GetCaster()
	local ability = self
	local sound_cast = "Hero_Nightstalker.Darkness"
	local particle_darkness = "particles/units/heroes/hero_night_stalker/nightstalker_ulti.vpcf"
	local modifier_night = "modifier_imba_darkness_night"
	local duration = ability:GetSpecialValueFor("duration")

	if self:GetCaster():FindAbilityByName("npc_dota_night_stalker_int3") ~= nil then
		if self:GetCaster():FindAbilityByName("npc_dota_night_stalker_int3"):GetLevel() > 0 then
			duration = ability:GetSpecialValueFor("duration") * 2
		end
	end

	EmitSoundOn(sound_cast, caster)

	local particle_darkness_fx = ParticleManager:CreateParticle(particle_darkness, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle_darkness_fx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_darkness_fx, 1, caster:GetAbsOrigin())

	caster:AddNewModifier(caster, ability, modifier_night, { duration = duration })

	if self:GetCaster():FindAbilityByName("npc_dota_night_stalker_int4") ~= nil then
		if self:GetCaster():FindAbilityByName("npc_dota_night_stalker_int4"):GetLevel() > 0 then
			CreateModifierThinker(
				self:GetCaster(),
				self,
				"modifier_night_fear_thinker",
				{ duration = 1600 / 1000 },
				self:GetCaster():GetAbsOrigin(),
				self:GetCaster():GetTeamNumber(),
				false
			)
		end
	end
end

modifier_imba_darkness_night = class({})

function modifier_imba_darkness_night:IsPurgable()
	return false
end

function modifier_imba_darkness_night:OnCreated()
	-- Ability properties
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")

	-- Start a Night Stalker night
	if IsServer() then
		self.game_mode = GameRules:GetGameModeEntity()

		GameRules:BeginNightstalkerNight(self:GetDuration())
		-- self.game_mode:SetDaynightCycleDisabled(true)

		self:StartIntervalThink(FrameTime() * 3)
	end
end

function modifier_imba_darkness_night:OnRefresh()
	self:OnCreated()
end

function modifier_imba_darkness_night:OnIntervalThink()
	AddFOWViewer(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		self.parent:GetCurrentVisionRange(),
		FrameTime() * 3,
		false
	)
end

function modifier_imba_darkness_night:OnDestroy()
	if IsServer() then
		-- self.game_mode:SetDaynightCycleDisabled(false)
		FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)
	end
end

function modifier_imba_darkness_night:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return decFuncs
end

function modifier_imba_darkness_night:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_imba_darkness_night:GetActivityTranslationModifiers()
	return "hunter_night"
end

-- Darkness vision reduction modifier
modifier_imba_darkness_vision = class({})
function modifier_imba_darkness_vision:IsHidden()
	return false
end
function modifier_imba_darkness_vision:IsPurgable()
	return false
end
function modifier_imba_darkness_vision:IsDebuff()
	return true
end

function modifier_imba_darkness_vision:OnCreated()
	if IsServer() then
		-- Ability properties
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
		self.parent = self:GetParent()

		-- Ability specials
		self.vision_reduction_pct = self.ability:GetSpecialValueFor("vision_reduction_pct")

		-- #7 Talent: Darkness maximum vision range reduction
		--self.vision_radius = self.vision_radius - self.caster:FindTalentValue("special_bonus_imba_night_stalker_7")

		-- Keep the original base night vision
		self.original_base_night_vision = self.parent:GetBaseNightTimeVisionRange()

		-- Override the base night vision
		self.parent:SetNightTimeVisionRange(self.original_base_night_vision * (100 - self.vision_reduction_pct) / 100)
	end
end

function modifier_imba_darkness_vision:OnDestroy()
	if IsServer() then
		self.parent:SetNightTimeVisionRange(self.original_base_night_vision)
	end
end

----------------------------------------------------------------------------
----------------------------------------------------------------------------
modifier_night_fear_thinker = class({})

function modifier_night_fear_thinker:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.fear_duration = 2.5
	self.radius = 700
	self.speed = 700
	self.spawn_delay = 0.6

	if not IsServer() then
		return
	end

	self.bLaunched = false
	self.feared_units = {}
	self.fear_modifier = nil

	self:StartIntervalThink(self.spawn_delay)
end

-- Once again, wiki says nothing about a width (might be 1 for all I know, but I'll arbitrarily make it 50)
function modifier_night_fear_thinker:OnIntervalThink()
	if not self.bLaunched then
		self.bLaunched = true

		self:StartIntervalThink(-1)
		self:StartIntervalThink(FrameTime())
	else
		for _, enemy in
			pairs(
				FindUnitsInRadius(
					self:GetCaster():GetTeamNumber(),
					self:GetParent():GetAbsOrigin(),
					self:GetParent(),
					math.min(self.speed * (self:GetElapsedTime() - self.spawn_delay), self.radius),
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
			)
		do
			if
				not self.feared_units[enemy:entindex()]
				and (enemy:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
					>= math.min(self.speed * (self:GetElapsedTime() - self.spawn_delay), self.radius) - 50
			then
				--enemy:EmitSound("Hero_Terrorblade.Metamorphosis.Fear")

				-- Vanilla fear modifier
				self.fear_modifier = enemy:AddNewModifier(
					self:GetCaster(),
					self:GetAbility(),
					"modifier_terrorblade_fear",
					{ duration = self.fear_duration }
				)

				if self.fear_modifier then
					self.fear_modifier:SetDuration(self.fear_duration * (1 - enemy:GetStatusResistance()), true)
				end

				self.feared_units[enemy:entindex()] = true
			end
		end
	end
end