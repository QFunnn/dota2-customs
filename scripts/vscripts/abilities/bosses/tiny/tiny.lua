--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_tiny_shifting_quake_lua", "abilities/bosses/tiny/tiny", LUA_MODIFIER_MOTION_NONE)

boss_tiny_shifting_quake_lua = class({})

function boss_tiny_shifting_quake_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_tiny_shifting_quake_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp.vpcf", context)
end

function boss_tiny_shifting_quake_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target_pos = self:GetCursorPosition()
	local caster_pos = caster:GetAbsOrigin()

	local distance = self:GetSpecialValueFor("distance")
	local points = self:GetSpecialValueFor("points")
	local radius = self:GetSpecialValueFor("radius")
	local delay = self:GetSpecialValueFor("delay")

	local direction = (target_pos - caster_pos):Normalized()
	local spacing = distance / points
	local current_points = 0

	EmitSoundOn("Hero_EarthShaker.Totem", caster)

	Timers:CreateTimer(0, function()
		current_points = current_points + 1
		local point_loc = caster_pos + direction * (spacing * current_points)

		local particle = "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp.vpcf"
		local effect = ParticleManager:CreateParticle(particle, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(effect, 0, point_loc)
		ParticleManager:ReleaseParticleIndex(effect)

		local thinker = CreateModifierThinker(caster, self, "", {}, point_loc, caster:GetTeamNumber(), false)
		EmitSoundOn("Hero_ElderTitan.EchoStomp", thinker)

		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			point_loc,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			0,
			false
		)

		for _, unit in pairs(units) do
			unit:AddNewModifier(caster, self, "modifier_boss_tiny_shifting_quake_lua", {
				duration = self:GetSpecialValueFor("duration"),
			})
		end

		if current_points < points then
			return delay
		end
	end)
end

--------------------------------------------------------------------------------

modifier_boss_tiny_shifting_quake_lua = class({})

function modifier_boss_tiny_shifting_quake_lua:IsDebuff()
	return true
end
function modifier_boss_tiny_shifting_quake_lua:IsHidden()
	return false
end
function modifier_boss_tiny_shifting_quake_lua:IsPurgable()
	return true
end

function modifier_boss_tiny_shifting_quake_lua:OnCreated()
	if not IsServer() then
		return
	end
	local interval = self:GetAbility():GetSpecialValueFor("interval")
	self:StartIntervalThink(interval)
end

function modifier_boss_tiny_shifting_quake_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()

	if not caster or not parent or not ability then
		return
	end

	local damage = ability:GetSpecialValueFor("damage") + ability:GetSpecialValueFor("diff_boost_damage")

	ApplyDamage({
		victim = parent,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = ability,
	})
end

function modifier_boss_tiny_shifting_quake_lua:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_boss_tiny_shifting_quake_lua:GetEffectName()
	return "particles/newplayer_fx/npx_sleeping.vpcf"
end

function modifier_boss_tiny_shifting_quake_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_boss_tiny_shifting_quake_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_boss_tiny_shifting_quake_lua:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_tiny_gavnina_lua", "abilities/bosses/tiny/tiny", LUA_MODIFIER_MOTION_VERTICAL)
LinkLuaModifier("modifier_boss_tiny_gavnina_lua_thinker", "abilities/bosses/tiny/tiny", LUA_MODIFIER_MOTION_VERTICAL)
LinkLuaModifier("modifier_boss_tiny_gavnina_lua_burn", "abilities/bosses/tiny/tiny", LUA_MODIFIER_MOTION_VERTICAL)

boss_tiny_gavnina_lua = class({})

function boss_tiny_gavnina_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_tiny_gavnina_lua:Precache(context)
	PrecacheResource("particle", "particles/gavnina/gavnina_fly_2.vpcf", context)
	PrecacheResource("particle", "particles/ui_mouseactions/range_display.vpcf", context)
end

function boss_tiny_gavnina_lua:OnSpellStart()
	self.mod_caster = self:GetCaster()
		:AddNewModifier(self:GetCaster(), self, "modifier_boss_tiny_gavnina_lua", { duration = 3 })
end

modifier_boss_tiny_gavnina_lua = class({})

function modifier_boss_tiny_gavnina_lua:IsHidden()
	return true
end

function modifier_boss_tiny_gavnina_lua:OnCreated()
	self.interval = self:GetAbility():GetSpecialValueFor("interval")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self:StartIntervalThink(self.interval)
end

function modifier_boss_tiny_gavnina_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster_pos = self:GetCaster():GetAbsOrigin()
	local angle = RandomInt(0, 360)
	local variance = RandomInt(-self.radius, self.radius)
	local dy = math.sin(math.rad(angle)) * variance
	local dx = math.cos(math.rad(angle)) * variance
	local target_point = Vector(caster_pos.x + dx, caster_pos.y + dy, caster_pos.z)

	CreateModifierThinker(
		self:GetCaster(),
		self:GetAbility(),
		"modifier_boss_tiny_gavnina_lua_thinker",
		{},
		target_point,
		self:GetCaster():GetTeamNumber(),
		false
	)

	self:StartIntervalThink(self.interval)
end

modifier_boss_tiny_gavnina_lua_thinker = class({})

function modifier_boss_tiny_gavnina_lua_thinker:IsHidden()
	return true
end

function modifier_boss_tiny_gavnina_lua_thinker:OnCreated(kv)
	if IsServer() then
		self.caster_origin = self:GetCaster():GetOrigin()
		self.parent_origin = self:GetParent():GetOrigin()
		self.delay = self:GetAbility():GetSpecialValueFor("delay")
		self.area_of_effect = self:GetAbility():GetSpecialValueFor("area_of_effect")
		self.fallen = false

		self:StartIntervalThink(self.delay)
		self:PlayEffects1()
	end
end

function modifier_boss_tiny_gavnina_lua_thinker:OnDestroy()
	if IsServer() then
		StopSoundOn("Hero_Invoker.ChaosMeteor.Loop", self:GetParent())
		if self.indicator_pfx then
			ParticleManager:DestroyParticle(self.indicator_pfx, false)
			ParticleManager:ReleaseParticleIndex(self.indicator_pfx)
			self.indicator_pfx = nil
		end
	end
end

function modifier_boss_tiny_gavnina_lua_thinker:OnIntervalThink()
	if not self.fallen then
		self.fallen = true
		self:Burn()
		self:Destroy()
	end
end

function modifier_boss_tiny_gavnina_lua_thinker:Burn()
	local damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self.parent_origin,
		nil,
		self.area_of_effect,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
			ability = self:GetAbility(),
		})
	end
	local sound_cast = "Hero_Invoker.ChaosMeteor.Impact"
	-- EmitSoundOnLocationWithCaster( self.parent_origin, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

function modifier_boss_tiny_gavnina_lua_thinker:PlayEffects1()
	local height = 1000
	local effect_cast = ParticleManager:CreateParticle("particles/gavnina/gavnina_fly_2.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, self.caster_origin + Vector(0, 0, height))
	ParticleManager:SetParticleControl(effect_cast, 1, self.parent_origin)
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(self.delay, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local sound_cast = "Hero_Invoker.ChaosMeteor.Cast"
	-- EmitSoundOnLocationWithCaster( self.caster_origin, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())

	self.indicator_pfx =
		ParticleManager:CreateParticle("particles/ui_mouseactions/range_display.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.indicator_pfx, 0, self.parent_origin)
	ParticleManager:SetParticleControl(self.indicator_pfx, 1, Vector(self.area_of_effect, 0, 0))
	ParticleManager:SetParticleControl(self.indicator_pfx, 2, Vector(self.delay, 0, 0))
	ParticleManager:SetParticleControl(self.indicator_pfx, 3, Vector(255, 0, 0))
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_geocron_boulder_blocker", "abilities/bosses/tiny/tiny", LUA_MODIFIER_MOTION_NONE)

boss_tiny_stone_wall_lua = class({})

function boss_tiny_gavnina_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_tiny_stone_wall_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_earthshaker.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf", context)
end

function boss_tiny_stone_wall_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local caster_pos = caster:GetAbsOrigin()
	local duration = self:GetSpecialValueFor("duration")
	local count = self:GetSpecialValueFor("count")
	local max_radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	for i = 1, count do
		local spawn_pos = caster_pos + RandomVector(1) * RandomFloat(150, max_radius)
		spawn_pos.z = GetGroundHeight(spawn_pos, nil)

		CreateModifierThinker(
			caster,
			self,
			"modifier_geocron_boulder_blocker",
			{ duration = duration },
			spawn_pos,
			caster:GetTeamNumber(),
			false
		)

		self:PlayEffects(spawn_pos, duration)

		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			spawn_pos,
			nil,
			120,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
		for _, unit in pairs(units) do
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = self:GetAbilityDamageType(),
				ability = self,
			}

			ApplyDamage(damage_table)

			unit:AddNewModifier(caster, self, "modifier_stunned", { duration = stun_duration })

			FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
		end
	end
	local sound_cast = "Hero_EarthShaker.Fissure"
	-- EmitSoundOnLocationWithCaster(caster_pos, sound_cast, self:GetCaster())
	EmitSoundOn(sound_cast, self:GetCaster())
end

function boss_tiny_stone_wall_lua:PlayEffects(spawn_pos, duration)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast, 0, spawn_pos)
	ParticleManager:SetParticleControl(effect_cast, 1, spawn_pos)
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(duration, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end
--------------------------------------------------------------------------------

modifier_geocron_boulder_blocker = class({
	IsHidden = function()
		return true
	end,
})

function modifier_geocron_boulder_blocker:OnCreated()
	if not IsServer() then
		return
	end

	local pos = self:GetParent():GetAbsOrigin()

	self.blocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", {
		origin = pos,
	})

	self:GetParent():SetHullRadius(100)
end

function modifier_geocron_boulder_blocker:OnDestroy()
	if not IsServer() then
		return
	end

	if self.blocker then
		self.blocker:RemoveSelf()
	end

	local pos = self:GetParent():GetAbsOrigin()
	local units = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		pos,
		nil,
		120,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, unit in pairs(units) do
		FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

boss_tiny_stone_spire_lua = class({})

function boss_tiny_stone_spire_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local spawn_distance = self:GetSpecialValueFor("spawn_distance")
	local count = self:GetSpecialValueFor("count")
	local min_distance = 300

	caster:EmitSound("Hero_EarthSpirit.StoneRemnant.Impact")

	for i = 1, count do
		local direction = RandomVector(1):Normalized()
		local distance = RandomFloat(min_distance, spawn_distance)

		local spawn_point = caster:GetAbsOrigin() + direction * distance

		local unit =
			CreateUnitByName("npc_dota_boss_minion_tiny", spawn_point, true, caster, caster, caster:GetTeamNumber())

		if unit then
			unit:AddNewModifier(caster, self, "modifier_kill", { duration = duration })
			FindClearSpaceForUnit(unit, spawn_point, true)
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_trembling_waves_passive", "abilities/bosses/tiny/tiny", LUA_MODIFIER_MOTION_NONE)

boss_tiny_shifting_quake_minion_lua = class({})

function boss_tiny_shifting_quake_minion_lua:GetIntrinsicModifierName()
	return "modifier_trembling_waves_passive"
end

--------------------------------------------------------------------------------

modifier_trembling_waves_passive = class({})

function modifier_trembling_waves_passive:IsHidden()
	return true
end

function modifier_trembling_waves_passive:OnCreated()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end

	local interval = self:GetAbility():GetSpecialValueFor("interval")
	self:StartIntervalThink(interval)
end

function modifier_trembling_waves_passive:OnIntervalThink()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local ability = self:GetAbility()

	if not caster:IsAlive() or caster:IsIllusion() then
		return
	end

	local radius = ability:GetSpecialValueFor("radius")
	local damage = ability:GetSpecialValueFor("damage") + ability:GetSpecialValueFor("diff_boost_damage")
	local distance = ability:GetSpecialValueFor("distance")
	local duration = ability:GetSpecialValueFor("duration")

	caster:EmitSound("Hero_EarthShaker.EchoSlamSmall")

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sandking/sandking_epicenter.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(pfx)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = ability,
		})

		local knockback_properties = {
			center_x = caster:GetAbsOrigin().x,
			center_y = caster:GetAbsOrigin().y,
			center_z = caster:GetAbsOrigin().z,
			duration = duration,
			knockback_duration = duration,
			knockback_distance = distance,
			knockback_height = 50,
			should_stun = 0,
		}

		enemy:AddNewModifier(caster, ability, "modifier_knockback", knockback_properties)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_tiny_stone_sweep_lua_armor", "abilities/bosses/tiny/tiny", LUA_MODIFIER_MOTION_NONE)

boss_tiny_stone_sweep_lua = class({})

function boss_tiny_stone_sweep_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", context)
end

function boss_tiny_stone_sweep_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local damage_multiplier = self:GetSpecialValueFor("damage_multiplier") / 100
	local duration = self:GetSpecialValueFor("duration")
	local caster_pos = caster:GetAbsOrigin()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster_pos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = caster:GetAverageTrueAttackDamage(caster) * damage_multiplier,
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		})

		local enemy_pos = enemy:GetAbsOrigin()
		local direction = (enemy_pos - caster_pos):Normalized()
		local distance = 350
		local final_pos = enemy_pos + direction * distance

		if not GridNav:IsTraversable(final_pos) or GridNav:IsNearbyTree(final_pos, 30, false) then
			for i = 1, 10 do
				local temp_dist = distance - (i * 35)
				local temp_pos = enemy_pos + direction * temp_dist
				if GridNav:IsTraversable(temp_pos) then
					final_pos = temp_pos
					break
				end
			end
		end

		local start_height = GetGroundHeight(enemy_pos, nil)
		local end_height = GetGroundHeight(final_pos, nil)

		if end_height > start_height + 10 then
			final_pos = enemy_pos
		end

		enemy:AddNewModifier(caster, self, "modifier_knockback", {
			center_x = caster_pos.x - direction.x * 100,
			center_y = caster_pos.y - direction.y * 100,
			center_z = caster_pos.z,
			duration = 0.4,
			knockback_duration = 0.4,
			knockback_distance = (final_pos - enemy_pos):Length2D(),
			knockback_height = 50,
			should_stun = 1,
		})
	end
	caster:AddNewModifier(caster, self, "modifier_boss_tiny_stone_sweep_lua_armor", { duration = duration })
	self:PlayEffects(radius)
end

function boss_tiny_stone_sweep_lua:PlayEffects(radius)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_centaur/centaur_warstomp.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hoof_L",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hoof_R",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast = "Hero_Centaur.HoofStomp"
	-- EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_boss_tiny_stone_sweep_lua_armor = class({
	IsHidden = function()
		return false
	end,
	IsDebuff = function()
		return false
	end,
	IsPurgable = function()
		return true
	end,
})

function modifier_boss_tiny_stone_sweep_lua_armor:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_boss_tiny_stone_sweep_lua_armor:GetModifierPhysicalArmorBonus()
	return self:GetCaster():GetPhysicalArmorBaseValue() * self:GetAbility():GetSpecialValueFor("bonus_armor") / 100
end

function modifier_boss_tiny_stone_sweep_lua_armor:GetTexture()
	return "tiny_craggy_exterior"
end