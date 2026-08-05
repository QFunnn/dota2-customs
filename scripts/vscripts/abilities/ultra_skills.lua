--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


thundergod_ultra_lua = class({})

LinkLuaModifier("modifier_ultra_caster_self_vision_lua", "abilities/ultra_skills", LUA_MODIFIER_MOTION_NONE)

function thundergod_ultra_lua:Precache(context)
	PrecacheResource("soundfile", "particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf", context)
end

function thundergod_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local damage_table = {
		attacker = caster,
		ability = self,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
	}

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() then
			local point = enemy:GetAbsOrigin()
			local thundergod_strike_particle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				enemy
			)
			ParticleManager:SetParticleControl(
				thundergod_strike_particle,
				0,
				Vector(point.x, point.y, point.z + enemy:GetBoundingMaxs().z)
			)
			ParticleManager:SetParticleControl(thundergod_strike_particle, 1, Vector(point.x, point.y, 2000))
			ParticleManager:SetParticleControl(
				thundergod_strike_particle,
				2,
				Vector(point.x, point.y, point.z + enemy:GetBoundingMaxs().z)
			)
			ParticleManager:ReleaseParticleIndex(thundergod_strike_particle)

			damage_table.damage = enemy:GetMaxHealth() * 0.75
			damage_table.victim = enemy
			ApplyDamage(damage_table)
			enemy:EmitSound("Hero_Zuus.GodsWrath.Target")
		end
	end
end

function thundergod_ultra_lua:GetIntrinsicModifierName()
	return "modifier_ultra_caster_self_vision_lua"
end

----------------------------------------------------------------------
----------------------------------------------------------------------

modifier_ultra_caster_self_vision_lua = class({})

function modifier_ultra_caster_self_vision_lua:IsHidden()
	return true
end

function modifier_ultra_caster_self_vision_lua:IsPurgable()
	return false
end

function modifier_ultra_caster_self_vision_lua:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
	}
end

function modifier_ultra_caster_self_vision_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}
end

function modifier_ultra_caster_self_vision_lua:GetModifierProvidesFOWVision()
	return 1
end

----------------------------------------------------------------------
----------------------------------------------------------------------

sunstrike_ultra_lua = class({})

function sunstrike_ultra_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf", context)
end

function sunstrike_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local delay = 1.5
	local damage_radius = 200

	local damage_table = {
		attacker = caster,
		ability = self,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
	}

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() then
			local point = enemy:GetAbsOrigin()
			local startFX = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf",
				PATTACH_ABSORIGIN,
				enemy
			)
			ParticleManager:SetParticleControl(startFX, 0, point)
			ParticleManager:SetParticleControl(startFX, 1, Vector(damage_radius, 0, 0))
			EmitSoundOn("Hero_Invoker.SunStrike.Charge", enemy)

			Timers:CreateTimer(delay, function()
				ParticleManager:DestroyParticle(startFX, false)
				ParticleManager:ReleaseParticleIndex(startFX)
				local endFX = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf",
					PATTACH_ABSORIGIN,
					enemy
				)
				ParticleManager:SetParticleControl(endFX, 0, point)
				ParticleManager:SetParticleControl(endFX, 1, Vector(damage_radius, 0, 0))
				ParticleManager:ReleaseParticleIndex(endFX)
				EmitSoundOn("Hero_Invoker.SunStrike.Ignite", enemy)
				local units = FindUnitsInRadius(
					caster:GetTeamNumber(),
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
					damage_table.damage = unit:GetMaxHealth() * 2
					damage_table.victim = unit
					ApplyDamage(damage_table)
				end
			end)
		end
	end
end

----------------------------------------------------------------------
----------------------------------------------------------------------

LinkLuaModifier("modifier_silence_ultra_lua", "abilities/ultra_skills", LUA_MODIFIER_MOTION_NONE)

silence_ultra_lua = class({})

function silence_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() then
			enemy:AddNewModifier(caster, self, "modifier_silence_ultra_lua", { duration = 20 })
		end
	end
	EmitSoundOn("Hero_Silencer.GlobalSilence.Cast", caster)
end

----------------------------------------------------------------------

modifier_silence_ultra_lua = class({})

function modifier_silence_ultra_lua:IsDebuff()
	return true
end

function modifier_silence_ultra_lua:IsStunDebuff()
	return true
end

function modifier_silence_ultra_lua:IsPurgable()
	return false
end

function modifier_silence_ultra_lua:CheckState()
	return {
		[MODIFIER_STATE_SILENCED] = true,
	}
end

function modifier_silence_ultra_lua:GetTexture()
	return "silencer_global_silence"
end

function modifier_silence_ultra_lua:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end

function modifier_silence_ultra_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

----------------------------------------------------------------------
----------------------------------------------------------------------

LinkLuaModifier("modifier_overgrowth_ultra_lua", "abilities/ultra_skills", LUA_MODIFIER_MOTION_NONE)

overgrowth_ultra_lua = class({})

function overgrowth_ultra_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/lone_druid/lone_druid_cauldron/lone_druid_bear_entangle_cauldron.vpcf",
		context
	)
end

function overgrowth_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() then
			enemy:AddNewModifier(caster, self, "modifier_overgrowth_ultra_lua", { duration = 5 })
		end
	end
end

----------------------------------------------------------------------

modifier_overgrowth_ultra_lua = class({})

function modifier_overgrowth_ultra_lua:IsHidden()
	return false
end
function modifier_overgrowth_ultra_lua:IsDebuff()
	return true
end
function modifier_overgrowth_ultra_lua:IsPurgable()
	return false
end
function modifier_overgrowth_ultra_lua:RemoveOnDeath()
	return true
end

function modifier_overgrowth_ultra_lua:OnCreated()
	if not IsServer() then
		return
	end
	self:DealDamage()
	self:GetParent():EmitSound("Hero_Treant.Overgrowth.Cast")
	self:StartIntervalThink(1)
end

function modifier_overgrowth_ultra_lua:OnIntervalThink()
	self:DealDamage()
end

function modifier_overgrowth_ultra_lua:DealDamage()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local caster = self:GetCaster()

	ApplyDamage({
		victim = parent,
		damage = parent:GetMaxHealth() * 0.20,
		damage_type = DAMAGE_TYPE_PURE,
		attacker = caster,
		ability = self:GetAbility(),
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
	})
end

function modifier_overgrowth_ultra_lua:GetTexture()
	return "treant_overgrowth"
end

function modifier_overgrowth_ultra_lua:GetEffectName()
	return "particles/econ/items/lone_druid/lone_druid_cauldron/lone_druid_bear_entangle_cauldron.vpcf"
end

function modifier_overgrowth_ultra_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_overgrowth_ultra_lua:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end

----------------------------------------------------------------------
----------------------------------------------------------------------

LinkLuaModifier("modifier_mine_ultra_lua_thinker", "abilities/ultra_skills", LUA_MODIFIER_MOTION_NONE)

mine_ultra_lua = class({})

function mine_ultra_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_land_mine.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf", context)
	PrecacheResource("particle", "particles/ui_mouseactions/range_display.vpcf", context)
end

function mine_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() then
			local point = enemy:GetAbsOrigin()
			local mine = CreateUnitByName(
				"npc_zone_8_creep_land_mines",
				point + RandomVector(RandomInt(0, 150)),
				true,
				nil,
				nil,
				caster:GetTeamNumber()
			)
			mine:AddNewModifier(caster, self, "modifier_mine_ultra_lua_thinker", {})
		end
	end
end

----------------------------------------------------------------------

modifier_mine_ultra_lua_thinker = class({})

function modifier_mine_ultra_lua_thinker:IsHidden()
	return true
end

function modifier_mine_ultra_lua_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.radius = 300
	self.threshold = 1.3
	self.activation_delay = 0.5
	self.tick_interval = 0.1

	self.active = false
	self.triggered = false
	self.timer = 0

	local position = self.parent:GetAbsOrigin()
	self.pfx = ParticleManager:CreateParticle("particles/ui_mouseactions/range_display.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.pfx, 0, position)
	ParticleManager:SetParticleControl(self.pfx, 1, Vector(self.radius, 0, 0))
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(3, 0, 0))
	ParticleManager:SetParticleControl(self.pfx, 3, Vector(255, 0, 0))

	-- self:StartIntervalThink(self.activation_delay)
	self:OnIntervalThink()
end

function modifier_mine_ultra_lua_thinker:OnIntervalThink()
	if not self.active then
		self.active = true
		self:StartIntervalThink(self.tick_interval)
		return
	end

	local enemies = _G.OldFindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	local has_target = false
	for _, enemy in pairs(enemies) do
		has_target = true
		break
	end

	if has_target then
		if not self.triggered then
			self.triggered = true
			local sound_cast = "Hero_Techies.RemoteMine.Priming"
			-- EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), sound_cast, self.parent)
			EmitSoundOn(sound_cast, self.parent)
		end
		self.timer = self.timer + self.tick_interval
		if self.timer >= self.threshold then
			self:Explode()
		end
	else
		self.triggered = false
		self.timer = 0
	end
end

function modifier_mine_ultra_lua_thinker:Explode()
	local origin = self.parent:GetAbsOrigin()
	self.parent:EmitSound("Hero_Techies.RemoteMine.Detonate")

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 2, Vector(self.radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(pfx)

	local enemies = _G.OldFindUnitsInRadius(
		self.parent:GetTeamNumber(),
		origin,
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		if not enemy:HasFlyMovementCapability() then
			ApplyDamage({
				victim = enemy,
				damage = enemy:GetMaxHealth() * 0.75,
				damage_type = DAMAGE_TYPE_PURE,
				attacker = self.parent,
				ability = self:GetAbility(),
				damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
			})
		end
	end
	if not IsServer() then
		return
	end
	self.parent:ForceKill(false)
	self:Destroy()
end

function modifier_mine_ultra_lua_thinker:OnDestroy()
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, true)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
end

function modifier_mine_ultra_lua_thinker:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = (self.active and not self.triggered),
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = (self.active and not self.triggered),
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
end

----------------------------------------------------------------------
----------------------------------------------------------------------

roshan_ultra_lua = class({})

function roshan_ultra_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_greevils.vsndevts", context)
end

function roshan_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() and not enemy:HasModifier("modifier_guild_event") then
			local point = enemy:GetAbsOrigin()
			local dummy = CreateUnitByName(
				"npc_treasure_chest",
				point + RandomVector(RandomFloat(150, 150)),
				false,
				caster,
				caster,
				caster:GetTeamNumber()
			)
			dummy:AddNewModifier(caster, self, "modifier_kill", { duration = 10 })
			dummy:EmitSound("SeasonalConsumable.TI9.Shovel.RevealedSquirrel")
		end
	end
end

----------------------------------------------------------------------
----------------------------------------------------------------------

stun_ultra_lua = class({})

function stun_ultra_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf", context)
end

function stun_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() then
			local point = enemy:GetAbsOrigin()
			local random_start_point = point + RandomVector(RandomFloat(250, 250))

			local info = {
				EffectName = "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf",
				Ability = self,
				iMoveSpeed = 3800,
				Source = self:GetCaster(),
				Target = enemy,
			}
			ProjectileManager:CreateTrackingProjectile(info)
		end
	end
end

function stun_ultra_lua:OnProjectileHit(hTarget, vLocation)
	if hTarget ~= nil then
		EmitSoundOn("Hero_Sven.StormBoltImpact", hTarget)

		ApplyDamage({
			victim = hTarget,
			damage = hTarget:GetMaxHealth() * 0.5,
			damage_type = DAMAGE_TYPE_PURE,
			attacker = self:GetCaster(),
			ability = self,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		})

		hTarget:AddNewModifier(self:GetCaster(), nil, "modifier_stunned", { duration = 5 })
	end
	return true
end

----------------------------------------------------------------------
----------------------------------------------------------------------

LinkLuaModifier("modifier_venomancer_poison_nova_lua", "abilities/ultra_skills", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_ring_lua", "heroes/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE)

poison_ultra_lua = class({})

function poison_ultra_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_poison_venomancer.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_venomancer/venomancer_poison_debuff_nova.vpcf", context)
end

function poison_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local duration = 10
	local speed = 400
	local start_radius = 150
	local end_radius = 450

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() then
			if enemy:GetTeamNumber() ~= caster:GetTeamNumber() then
				enemy:AddNewModifier(caster, self, "modifier_venomancer_poison_nova_lua", { duration = duration })
			end
			local effect_cast = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				enemy
			)
			ParticleManager:SetParticleControl(effect_cast, 1, Vector(speed, 1, speed))
			ParticleManager:ReleaseParticleIndex(effect_cast)
			EmitSoundOn("Hero_Venomancer.PoisonNova", enemy)

			local ring = enemy:AddNewModifier(caster, self, "modifier_generic_ring_lua", {
				start_radius = start_radius,
				end_radius = end_radius,
				speed = speed,
				target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				target_flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
				IsCircle = 0,
			})

			ring:SetCallback(function(victim)
				if victim:GetTeamNumber() ~= caster:GetTeamNumber() then
					victim:AddNewModifier(caster, self, "modifier_venomancer_poison_nova_lua", { duration = duration })
					EmitSoundOn("Hero_Venomancer.PoisonNovaImpact", victim)
				end
			end)
		end
	end
end

----------------------------------------------------------------------

modifier_venomancer_poison_nova_lua = class({})

function modifier_venomancer_poison_nova_lua:IsHidden()
	return false
end
function modifier_venomancer_poison_nova_lua:IsDebuff()
	return true
end
function modifier_venomancer_poison_nova_lua:IsPurgable()
	return false
end

function modifier_venomancer_poison_nova_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end

function modifier_venomancer_poison_nova_lua:OnIntervalThink()
	local parent = self:GetParent()
	local caster = self:GetCaster()

	if not parent:IsAlive() then
		return
	end

	local damage = parent:GetMaxHealth() * 0.15

	ApplyDamage({
		victim = parent,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self:GetAbility(),
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
	})
end

function modifier_venomancer_poison_nova_lua:GetTexture()
	return "venomancer_poison_nova"
end

function modifier_venomancer_poison_nova_lua:GetEffectName()
	return "particles/units/heroes/hero_venomancer/venomancer_poison_debuff_nova.vpcf"
end

function modifier_venomancer_poison_nova_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_venomancer.vpcf"
end

function modifier_venomancer_poison_nova_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

----------------------------------------------------------------------
----------------------------------------------------------------------

LinkLuaModifier("modifier_blind_ultra_lua", "abilities/ultra_skills", LUA_MODIFIER_MOTION_NONE)

blind_ultra_lua = class({})

function blind_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local duration = 10

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() then
			enemy:AddNewModifier(caster, self, "modifier_blind_ultra_lua", { duration = duration })
		end
	end

	EmitSoundOn("Hero_Nightstalker.Darkness", caster)
end

--------------------------------------------------------------------------------

modifier_blind_ultra_lua = class({})

function modifier_blind_ultra_lua:IsHidden()
	return false
end
function modifier_blind_ultra_lua:IsDebuff()
	return true
end
function modifier_blind_ultra_lua:IsPurgable()
	return false
end

function modifier_blind_ultra_lua:GetPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_blind_ultra_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_FIXED_DAY_VISION,
		MODIFIER_PROPERTY_FIXED_NIGHT_VISION,
		MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE,
	}
end

function modifier_blind_ultra_lua:GetFixedDayVision()
	return 0
end

function modifier_blind_ultra_lua:GetFixedNightVision()
	return 0
end

function modifier_blind_ultra_lua:GetBonusVisionPercentage()
	return -100
end

function modifier_blind_ultra_lua:GetTexture()
	return "night_stalker_darkness"
end

function modifier_blind_ultra_lua:GetEffectName()
	return "particles/generic_gameplay/generic_break_dark.vpcf"
end

function modifier_blind_ultra_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

----------------------------------------------------------------------
----------------------------------------------------------------------

LinkLuaModifier("modifier_resist_ultra_lua", "abilities/ultra_skills", LUA_MODIFIER_MOTION_NONE)

resist_ultra_lua = class({})

function resist_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local duration = 15

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() then
			enemy:AddNewModifier(caster, self, "modifier_resist_ultra_lua", { duration = duration })
		end
	end

	EmitSoundOn("Hero_Nightstalker.Darkness", caster)
end

--------------------------------------------------------------------------------

modifier_resist_ultra_lua = class({})

function modifier_resist_ultra_lua:IsHidden()
	return false
end
function modifier_resist_ultra_lua:IsDebuff()
	return true
end
function modifier_resist_ultra_lua:IsPurgable()
	return false
end

function modifier_resist_ultra_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_resist_ultra_lua:GetModifierPhysicalArmorBonus()
	return -100
end

function modifier_resist_ultra_lua:GetModifierMagicalResistanceBonus()
	return -100
end

function modifier_resist_ultra_lua:GetTexture()
	return "elder_titan_natural_order"
end

function modifier_resist_ultra_lua:GetEffectName()
	return "particles/generic_gameplay/generic_break.vpcf"
end

function modifier_resist_ultra_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

----------------------------------------------------------------------
----------------------------------------------------------------------

LinkLuaModifier("modifier_ice_ultra_lua", "abilities/ultra_skills", LUA_MODIFIER_MOTION_NONE)

ice_ultra_lua = class({})

function ice_ultra_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local duration = 15

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		Vector(0, 0, 0),
		caster,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy:IsAlive() then
			enemy:AddNewModifier(caster, self, "modifier_ice_ultra_lua", { duration = duration })
		end
	end

	EmitSoundOn("Hero_Nightstalker.Darkness", caster)
end

----------------------------------------------------------------------

modifier_ice_ultra_lua = class({})

function modifier_ice_ultra_lua:IsHidden()
	return false
end
function modifier_ice_ultra_lua:IsDebuff()
	return true
end
function modifier_ice_ultra_lua:IsPurgable()
	return false
end

function modifier_ice_ultra_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
	return funcs
end

function modifier_ice_ultra_lua:GetDisableHealing()
	return 1
end

function modifier_ice_ultra_lua:GetTexture()
	return "ancient_apparition_ice_blast"
end

function modifier_ice_ultra_lua:GetEffectName()
	return "ancient_apparition_ice_blast"
end

function modifier_ice_ultra_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end