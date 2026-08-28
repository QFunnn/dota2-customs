--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

boos_doom_solar_flare_lua = class({})

function boos_doom_solar_flare_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf", context)
end

function boos_doom_solar_flare_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local particle_start = "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf"
	local particle_end = "particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf"
	local damage = self:GetSpecialValueFor("damage")
	local delay = self:GetSpecialValueFor("delay")
	local damage_radius = self:GetSpecialValueFor("damage_radius")
	local range = self:GetSpecialValueFor("range")
	local damage_table = {
		attacker = self:GetCaster(),
		damage_type = self:GetAbilityDamageType(),
		damage = damage,
	}

	local hEnemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		self:GetCaster(),
		range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	if #hEnemies > 0 then
		for _, target in ipairs(hEnemies) do
			local point = target:GetAbsOrigin()
			local startFX = ParticleManager:CreateParticle(particle_start, PATTACH_ABSORIGIN, target)
			ParticleManager:SetParticleControl(startFX, 0, point)
			ParticleManager:SetParticleControl(startFX, 1, Vector(damage_radius, 0, 0))
			EmitSoundOn("Hero_Invoker.SunStrike.Charge", target)
			Timers:CreateTimer(delay, function()
				ParticleManager:DestroyParticle(startFX, false)
				local endFX = ParticleManager:CreateParticle(particle_end, PATTACH_ABSORIGIN, target)
				ParticleManager:SetParticleControl(endFX, 0, point)
				ParticleManager:SetParticleControl(endFX, 1, Vector(damage_radius, 0, 0))
				EmitSoundOn("Hero_Invoker.SunStrike.Ignite", target)
				local units = FindUnitsInRadius(
					DOTA_TEAM_BADGUYS,
					point,
					nil,
					damage_radius,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO,
					0,
					0,
					false
				)
				for _, unit in ipairs(units) do
					damage_table.victim = unit
					ApplyDamage(damage_table)
				end
			end)
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boos_doom_pit_lua", "abilities/bosses/lord/lord", LUA_MODIFIER_MOTION_VERTICAL)
LinkLuaModifier("modifier_boos_doom_pit_lua_thinker", "abilities/bosses/lord/lord", LUA_MODIFIER_MOTION_VERTICAL)
LinkLuaModifier("modifier_boos_doom_pit_lua_cooldown", "abilities/bosses/lord/lord", LUA_MODIFIER_MOTION_VERTICAL)

boos_doom_pit_lua = class({})

function boos_doom_pit_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boos_doom_pit_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/heroes_underlord/underlord_pitofmalice_pre.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/heroes_underlord/underlord_pitofmalice.vpcf", context)
end

function boos_doom_pit_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local hEnemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		nil,
		3000,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	if #hEnemies > 0 then
		for _, target in ipairs(hEnemies) do
			local point = target:GetAbsOrigin()
			local duration = self:GetSpecialValueFor("pit_duration")
			CreateModifierThinker(
				caster,
				self,
				"modifier_boos_doom_pit_lua_thinker",
				{ duration = duration },
				point,
				caster:GetTeamNumber(),
				false
			)
			self:PlayEffects(point)
		end
	end
end

function boos_doom_pit_lua:PlayEffects(point)
	local particle_cast = "particles/units/heroes/heroes_underlord/underlord_pitofmalice_pre.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.PitOfMalice.Start"
	local radius = self:GetSpecialValueFor("radius")
	self.effect_cast = ParticleManager:CreateParticleForTeam(
		particle_cast,
		PATTACH_WORLDORIGIN,
		self:GetCaster(),
		self:GetCaster():GetTeamNumber()
	)
	ParticleManager:SetParticleControl(self.effect_cast, 0, point)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(radius, 1, 1))
	-- EmitSoundOnLocationForAllies( point, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_boos_doom_pit_lua_thinker = class({})

function modifier_boos_doom_pit_lua_thinker:IsHidden()
	return false
end

function modifier_boos_doom_pit_lua_thinker:IsDebuff()
	return false
end

function modifier_boos_doom_pit_lua_thinker:IsPurgable()
	return false
end

function modifier_boos_doom_pit_lua_thinker:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.duration = self:GetAbility():GetSpecialValueFor("ensnare_duration")

	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	self:StartIntervalThink(0.033)
	self:OnIntervalThink()

	self:PlayEffects()
end

function modifier_boos_doom_pit_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	UTIL_Remove(self:GetParent())
end

function modifier_boos_doom_pit_lua_thinker:OnIntervalThink()
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.parent:GetOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		local modifier = enemy:FindModifierByNameAndCaster("modifier_boos_doom_pit_lua_cooldown", self:GetCaster())
		if not modifier then
			enemy:AddNewModifier(
				self.caster,
				self:GetAbility(),
				"modifier_boos_doom_pit_lua",
				{ duration = self.duration }
			)
		end
	end
end

function modifier_boos_doom_pit_lua_thinker:PlayEffects()
	local particle_cast = "particles/units/heroes/heroes_underlord/underlord_pitofmalice.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.PitOfMalice"

	local parent = self:GetParent()

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(effect_cast, 0, parent:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(self:GetDuration(), 0, 0))

	self:AddParticle(effect_cast, false, false, -1, false, false)
	EmitSoundOn(sound_cast, parent)
end

--------------------------------------------------------------------------------

modifier_boos_doom_pit_lua = class({})

function modifier_boos_doom_pit_lua:IsHidden()
	return false
end

function modifier_boos_doom_pit_lua:IsDebuff()
	return true
end

function modifier_boos_doom_pit_lua:IsStunDebuff()
	return false
end

function modifier_boos_doom_pit_lua:IsPurgable()
	return true
end

function modifier_boos_doom_pit_lua:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_boos_doom_pit_lua:OnCreated(kv)
	local interval = self:GetAbility():GetSpecialValueFor("pit_interval")
	local damage = self:GetAbility():GetSpecialValueFor("pit_damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

	if not IsServer() then
		return
	end

	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_boos_doom_pit_lua_cooldown", -- modifier name
		{
			duration = interval,
		} -- kv
	)

	local damage_table = {
		attacker = self:GetCaster(),
		damage_type = self:GetAbility():GetAbilityDamageType(),
		damage = damage,
		victim = self:GetParent(),
	}
	ApplyDamage(damage_table)

	local hero = self:GetParent():IsHero()
	local sound_cast = "Hero_AbyssalUnderlord.Pit.TargetHero"
	if not hero then
		sound_cast = "Hero_AbyssalUnderlord.Pit.Target"
	end
	EmitSoundOn(sound_cast, self:GetParent())
end

function modifier_boos_doom_pit_lua:OnRefresh(kv) end

function modifier_boos_doom_pit_lua:OnRemoved() end

function modifier_boos_doom_pit_lua:OnDestroy() end

function modifier_boos_doom_pit_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
		[MODIFIER_STATE_ROOTED] = true,
	}

	return state
end

function modifier_boos_doom_pit_lua:GetEffectName()
	return "particles/units/heroes/heroes_underlord/abyssal_underlord_pitofmalice_stun.vpcf"
end

function modifier_boos_doom_pit_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------

modifier_boos_doom_pit_lua_cooldown = class({})

function modifier_boos_doom_pit_lua_cooldown:IsHidden()
	return true
end

function modifier_boos_doom_pit_lua_cooldown:IsDebuff()
	return true
end

function modifier_boos_doom_pit_lua_cooldown:IsPurgable()
	return false
end

function modifier_boos_doom_pit_lua_cooldown:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_boos_doom_pit_lua_cooldown:OnCreated(kv) end

function modifier_boos_doom_pit_lua_cooldown:OnRefresh(kv) end

function modifier_boos_doom_pit_lua_cooldown:OnRemoved() end

function modifier_boos_doom_pit_lua_cooldown:OnDestroy() end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_generic_ring_lua", "heroes/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE)

boos_doom_fire_ring_lua = class({})

function boos_doom_fire_ring_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boos_doom_fire_ring_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts", context)
	PrecacheResource("particle", "particles/fire_ring/fire_ring.vpcf", context)
end

function boos_doom_fire_ring_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local speed = self:GetSpecialValueFor("speed")
	local effect = self:PlayEffects(radius, speed)

	local pulse = caster:AddNewModifier(caster, self, "modifier_generic_ring_lua", {
		end_radius = radius,
		speed = speed,
		target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	})

	pulse:SetCallback(function(enemy)
		self:OnHit(enemy)
	end)

	pulse:SetEndCallback(function()
		ParticleManager:SetParticleControl(effect, 1, Vector(speed, radius, -1))
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
	end)
end

function boos_doom_fire_ring_lua:OnHit(enemy)
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local damage_min = self:GetSpecialValueFor("damage_min") + self:GetSpecialValueFor("diff_boost_damage")
	local damage_max = self:GetSpecialValueFor("damage_max") + self:GetSpecialValueFor("diff_boost_damage")
	local distance = (enemy:GetOrigin() - caster:GetOrigin()):Length2D()
	local pct = distance / radius
	pct = math.min(pct, 1)
	local damage = damage_min + (damage_max - damage_min) * pct
	local damageTable = {
		victim = enemy,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end

function boos_doom_fire_ring_lua:PlayEffects(radius, speed)
	local particle_cast = "particles/fire_ring/fire_ring.vpcf"
	local sound_cast = "Hero_DragonKnight.BreathFire"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(speed, radius, 1))

	EmitSoundOn(sound_cast, self:GetCaster())
	return effect_cast
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boos_doom_doom_lua", "abilities/bosses/lord/lord", LUA_MODIFIER_MOTION_NONE)

boos_doom_doom_lua = class({})

function boos_doom_doom_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf", context)
end

function boos_doom_doom_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")
	target:AddNewModifier(caster, self, "modifier_boos_doom_doom_lua", { duration = duration })
end

------------------------------------------------------------

modifier_boos_doom_doom_lua = class({})

function modifier_boos_doom_doom_lua:IsHidden()
	return false
end

function modifier_boos_doom_doom_lua:IsDebuff()
	return true
end

function modifier_boos_doom_doom_lua:IsStunDebuff()
	return false
end

function modifier_boos_doom_doom_lua:IsPurgable()
	return false
end

function modifier_boos_doom_doom_lua:GetTexture()
	return "doom"
end

function modifier_boos_doom_doom_lua:OnCreated(kv)
	local damage = self:GetAbility():GetSpecialValueFor("damage")
	self.interval = 1
	self.check_radius = 900
	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self:GetParent():GetMaxHealth() / 100 * damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self:GetAbility(), --Optional.
	}
	ApplyDamage(self.damageTable)

	self:StartIntervalThink(self.interval)
	self:PlayEffects()
end

function modifier_boos_doom_doom_lua:OnRefresh(kv)
	local damage = self:GetParent():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("damage")
	if not IsServer() then
		return
	end
	self.damageTable.damage = damage
	EmitSoundOn("Hero_DoomBringer.Doom", self:GetParent())
end

function modifier_boos_doom_doom_lua:OnRemoved() end

function modifier_boos_doom_doom_lua:OnDestroy()
	if not IsServer() then
		return
	end
	StopSoundOn("Hero_DoomBringer.Doom", self:GetParent())
end

function modifier_boos_doom_doom_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}
	return state
end

function modifier_boos_doom_doom_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
	return funcs
end

function modifier_boos_doom_doom_lua:GetDisableHealing()
	return 1
end

function modifier_boos_doom_doom_lua:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

function modifier_boos_doom_doom_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_doom.vpcf"
end

function modifier_boos_doom_doom_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_boos_doom_doom_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_doom_bringer/doom_bringer_doom.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self:AddParticle(effect_cast, false, false, MODIFIER_PRIORITY_SUPER_ULTRA, false, false)
	EmitSoundOn("Hero_DoomBringer.Doom", self:GetParent())
end