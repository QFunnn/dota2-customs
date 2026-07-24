--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


muerta_the_calling_lua = class({})
LinkLuaModifier("modifier_muerta_the_calling_lua", "abilities/heroes/muerta/the_calling", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_the_calling_lua_thinker", "abilities/heroes/muerta/the_calling", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_the_calling_lua_revenant", "abilities/heroes/muerta/the_calling", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_muerta_the_calling_lua_regen_aura", "abilities/heroes/muerta/the_calling", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_the_calling_lua_regen_aura_effect", "abilities/heroes/muerta/the_calling", LUA_MODIFIER_MOTION_NONE)

function muerta_the_calling_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_muerta.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_muerta/muerta_calling_aoe.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_muerta/muerta_calling_debuff_slow.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_muerta/muerta_calling_impact.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_muerta/muerta_calling_reticule.vpcf", context)
end

function muerta_the_calling_lua:GetIntrinsicModifierName()
	return "modifier_muerta_the_calling_lua"
end

function muerta_the_calling_lua:CastFilterResultLocation(location)
	if IsServer() then return end

	local caster = self:GetCaster()
	local num_revenants = self:GetSpecialValueFor("num_revenants")
	local hit_radius = self:GetSpecialValueFor("hit_radius")
	local dead_zone_distance = self:GetSpecialValueFor("dead_zone_distance")
	local revenant_radius = dead_zone_distance + hit_radius
	local radius = revenant_radius + hit_radius
	if not self.fx then
		self.fx = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_calling_reticule.vpcf", PATTACH_CUSTOMORIGIN, caster)
	end

	self.modifier:StartIntervalThink(0.01)
	ParticleManager:SetParticleControl(self.fx, 0, location)
	ParticleManager:SetParticleControl(self.fx, 1, Vector(radius, radius, radius))

	local cp_pos_start = 2
	local cp_alpha_start = 10
	for i = 1, num_revenants do
		local pos = location + RotateVector2D(Vector(revenant_radius, 0, 0), math.pi / 2 + 2 * math.pi * i / num_revenants, true)
		ParticleManager:SetParticleControl(self.fx, cp_pos_start + (i-1), pos)
		ParticleManager:SetParticleControl(self.fx, cp_alpha_start + (i-1), Vector(1,0,0))
	end
end

function muerta_the_calling_lua:OnSpellStart()
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	local thinker = CreateModifierThinker(
		caster,
		self,
		"modifier_muerta_the_calling_lua_thinker",
		{duration = duration},
		point,
		caster:GetTeamNumber(),
		false
	)
	thinker:AddNewModifier(caster, self, "modifier_muerta_the_calling_lua_regen_aura", {duration = -1})

	EmitSoundOnLocationWithCaster(point, "Hero_Muerta.Revenants.Cast", caster)
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_muerta_the_calling_lua = class({})

function modifier_muerta_the_calling_lua:IsHidden() return true end
function modifier_muerta_the_calling_lua:IsPurgable() return false end
function modifier_muerta_the_calling_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_muerta_the_calling_lua:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end
	self.ability.modifier = self
end

function modifier_muerta_the_calling_lua:OnIntervalThink()
	local player = Entities:GetLocalPlayer()
	local click_behavior = player:GetClickBehaviors()
	if click_behavior == DOTA_CLICK_BEHAVIOR_CAST then return end

	ParticleManager:DestroyParticle(self.ability.fx, true)
	ParticleManager:ReleaseParticleIndex(self.ability.fx)
	self.ability.fx = nil
	self:StartIntervalThink(-1)
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_muerta_the_calling_lua_thinker = class({})
function modifier_muerta_the_calling_lua_thinker:IsPurgable() return false end
function modifier_muerta_the_calling_lua_thinker:IsAura() return true end
function modifier_muerta_the_calling_lua_thinker:GetModifierAura() return "modifier_muerta_the_calling_aura_slow" end
function modifier_muerta_the_calling_lua_thinker:GetAuraRadius() return self.radius end
function modifier_muerta_the_calling_lua_thinker:GetAuraDuration() return 0.5 end
function modifier_muerta_the_calling_lua_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_muerta_the_calling_lua_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end

function modifier_muerta_the_calling_lua_thinker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.caster = self.ability:GetCaster()

	if not self.parent or self.parent:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.dead_zone_distance = self.ability:GetSpecialValueFor("dead_zone_distance")
	self.hit_radius = self.ability:GetSpecialValueFor("hit_radius")
	self.revenant_radius = self.dead_zone_distance + self.hit_radius
	self.radius = self.revenant_radius + self.hit_radius
	self.max_num_revenants = self.ability:GetSpecialValueFor("max_num_revenants")
	if not self.num_revenants then
		self.num_revenants = self.ability:GetSpecialValueFor("num_revenants")
	end

	if not IsServer() then return end

	self.revenants = {}

	local center = self.parent:GetOrigin()

	self.hit_tracker = {}

	for i = 1, self.num_revenants do
		local starting_angle = math.pi / 2 + 2 * math.pi / self.num_revenants * i

		local starting_position = center + RotateVector2D(Vector(self.revenant_radius, 0, 0), starting_angle, true)

		local revenant = CreateUnitByName("npc_custom_ot3_dummy_unit", starting_position, false, self.parent, self.parent, self.parent:GetTeam())
		local revenant_controller = revenant:AddNewModifier(self.parent, self.ability, "modifier_muerta_the_calling_lua_revenant", {duration = -1})

		if revenant_controller and not revenant_controller:IsNull() then
			revenant_controller:Init(self.ability, revenant, center, self.revenant_radius, starting_angle, self)
			table.insert(self.revenants, revenant_controller)
		else
			revenant:ForceKill(false)
		end
	end

	self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_calling_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.effect_cast, 0, center)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, self.radius, self.radius))
	ParticleManager:SetParticleControl(self.effect_cast, 2, Vector(self:GetDuration(), 0, 0))

	EmitSoundOn("Hero_Muerta.Revenants", self.parent)
	EmitSoundOn("Hero_Muerta.Revenants.Layer", self.parent)

	self:StartIntervalThink(0)
end

function modifier_muerta_the_calling_lua_thinker:OnRefresh()
	if not self.ability or self.ability:IsNull() then return end
	self.num_revenants = math.min(self.num_revenants, self.max_num_revenants)
	local duration = self.ability:GetSpecialValueFor("duration") - (self.num_revenants - self.ability:GetSpecialValueFor("num_revenants"))
	self:SetDuration(duration, true)

	if self.revenants then
		for _, revenant in pairs(self.revenants) do
			revenant:Destroy()
		end
	end

	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, true)
	end

	self:OnCreated()
end

function modifier_muerta_the_calling_lua_thinker:OnDestroy()
	if not IsServer() then return end
	for _, revenant in pairs(self.revenants) do
		if revenant and not revenant:IsNull() then
			revenant:Destroy()
		end
	end

	ParticleManager:ReleaseParticleIndex(self.effect_cast)
	UTIL_Remove(self.parent)
end

function modifier_muerta_the_calling_lua_thinker:OnIntervalThink()
	for _, revenant in pairs(self.revenants) do
		revenant:Update(FrameTime())
	end
end

function modifier_muerta_the_calling_lua_thinker:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_muerta_the_calling_lua_thinker:OnDeath(keys)
	if not self or self:IsNull() then return end
	if not IsServer() then return end

	if not keys.unit:HasModifier("modifier_muerta_the_calling_aura_slow") then return end
	if keys.unit:GetTeamNumber() == self.parent:GetTeamNumber() then return end
	if not keys.unit:IsHero() then return end
	if keys.unit:IsIllusion() then return end
	if (keys.unit:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius then return end
	-- only with specific facet
	if self.caster:GetHeroFacetID() ~= 1 then return end

	self:OnRefresh()
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_muerta_the_calling_lua_revenant = modifier_muerta_the_calling_lua_revenant or class({})

function modifier_muerta_the_calling_lua_revenant:Init(ability, unit, center, distance, angle, controller)
	self.ability = ability
	self.caster = ability:GetCaster()

	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.unit = unit
	self.center = center
	self.distance = distance
	self.current_angle = angle -- in rad

	self.acceleration = ability:GetSpecialValueFor("acceleration")
	self.speed_initial = ability:GetSpecialValueFor("speed_initial")
	self.speed_max = ability:GetSpecialValueFor("speed_max")

	self.damage = ability:GetSpecialValueFor("damage")
	self.hit_radius = ability:GetSpecialValueFor("hit_radius")
	self.silence_duration = ability:GetSpecialValueFor("silence_duration")

	self.current_speed = self.speed_initial

	self.controller = controller

	self.damage_table = {
		-- victim = target,
		attacker = self.caster,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	}

	local assumed_position = self:GetPosition()

	unit:SetOrigin(assumed_position)

	self.effect = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_calling.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt(self.effect, 0, unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0, 0, 0), false)
	ParticleManager:SetParticleControl(self.effect, 1, Vector(self.hit_radius, self.hit_radius, self.hit_radius))
end


function modifier_muerta_the_calling_lua_revenant:Update(dt)
	self.current_speed = math.min(self.current_speed + self.acceleration * dt, self.speed_max)
	self.current_angle = self.current_angle + self.current_speed * dt
	if self.current_angle > 2 * math.pi then
		self.current_angle = self.current_angle - 2 * math.pi
	end

	local position = self:GetPosition()
	local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), position, nil, self.hit_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	for _, enemy in pairs(enemies) do
		if enemy and not enemy:IsNull() then
			local modifier = enemy:FindModifierByNameAndCaster("modifier_muerta_the_calling_silence", self.caster)
			if not modifier or (self.controller.hit_tracker[enemy:GetEntityIndex()] ~= self) then
				self.controller.hit_tracker[enemy:GetEntityIndex()] = self
				modifier = enemy:AddNewModifierSR(self.caster, self.ability, "modifier_muerta_the_calling_silence", {duration = self.silence_duration})

				self.damage_table.victim = enemy
				ApplyDamage(self.damage_table)

				self:PlayEffects(enemy)
			end
		end
	end

	if IsValidEntity(self.unit) then
		self.unit:SetOrigin(position)
	end
end

function modifier_muerta_the_calling_lua_revenant:GetPosition()
	local pos = self.center + RotateVector2D(Vector(self.distance, 0, 0), self.current_angle, true)
	pos.z = GetGroundHeight(pos, self.unit) + 100 -- z ground offset
	return pos
end

function modifier_muerta_the_calling_lua_revenant:OnDestroy()
	if self.effect then
		ParticleManager:DestroyParticle(self.effect, false)
		ParticleManager:ReleaseParticleIndex(self.effect)
		self.effect = nil
	end

	if IsValidEntity(self.unit) then
		self.unit:ForceKill(false)
	end
end

function modifier_muerta_the_calling_lua_revenant:PlayEffects(target)
	local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_calling_impact.vpcf", PATTACH_POINT, target)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT,
		"attach_hitloc",
		Vector(0,0,0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT,
		"attach_hitloc",
		Vector(0,0,0),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local sound_cast = "Hero_Muerta.Revenants.Damage.Creep"
	if target:IsHero() then
		sound_cast = "Hero_Muerta.Revenants.Damage.Hero"
	end
	EmitSoundOn(sound_cast, target)
	EmitSoundOn("Hero_Muerta.Revenants.Silence", target)
end

function modifier_muerta_the_calling_lua_revenant:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end




modifier_muerta_the_calling_lua_regen_aura = modifier_muerta_the_calling_lua_regen_aura or class({})
function modifier_muerta_the_calling_lua_regen_aura:IsPurgable() return false end
function modifier_muerta_the_calling_lua_regen_aura:IsAura() return true end
function modifier_muerta_the_calling_lua_regen_aura:GetModifierAura() return "modifier_muerta_the_calling_lua_regen_aura_effect" end
function modifier_muerta_the_calling_lua_regen_aura:GetAuraRadius() return self.radius or 600 end
function modifier_muerta_the_calling_lua_regen_aura:GetAuraDuration() return 0.5 end
function modifier_muerta_the_calling_lua_regen_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_muerta_the_calling_lua_regen_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end

function modifier_muerta_the_calling_lua_regen_aura:GetAuraEntityReject(entity)
	return entity ~= self:GetCaster()
end

function modifier_muerta_the_calling_lua_regen_aura:OnCreated()
	self.ability = self:GetAbility()
	self.dead_zone_distance = self.ability:GetSpecialValueFor("dead_zone_distance")
	self.hit_radius = self.ability:GetSpecialValueFor("hit_radius")
	self.revenant_radius = self.dead_zone_distance + self.hit_radius
	self.radius = self.revenant_radius + self.hit_radius
end


modifier_muerta_the_calling_lua_regen_aura_effect = modifier_muerta_the_calling_lua_regen_aura_effect or class({})

function modifier_muerta_the_calling_lua_regen_aura_effect:IsPurgable() return false end
function modifier_muerta_the_calling_lua_regen_aura_effect:IsHidden() return (self.hp_regen_pct or 0) < 0.01 end

function modifier_muerta_the_calling_lua_regen_aura_effect:OnCreated()
	self.hp_regen_pct = self:GetAbility():GetSpecialValueFor("hp_regen_pct")
end

function modifier_muerta_the_calling_lua_regen_aura_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE, -- GetModifierHealthRegenPercentage
	}
end


function modifier_muerta_the_calling_lua_regen_aura_effect:GetModifierHealthRegenPercentage()
	return self.hp_regen_pct
end