--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dark_seer_wall_of_replica_lua_thinker = modifier_dark_seer_wall_of_replica_lua_thinker or class({})

function modifier_dark_seer_wall_of_replica_lua_thinker:IsPurgable() return false end


function modifier_dark_seer_wall_of_replica_lua_thinker:OnCreated(kv)
	if not IsServer() then return end

	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.origin = self.parent:GetAbsOrigin()

	self.hit_heroes = {}

	self.bounty = 5

	local direction = Vector(kv.dir_x, kv.dir_y, 0)

	local width = self.ability:GetSpecialValueFor("width")
	self.replica_damage_outgoing = self.ability:GetSpecialValueFor("replica_damage_outgoing")
	self.replica_damage_incoming = self.ability:GetSpecialValueFor("replica_damage_incoming")
	self.slow_duration = self.ability:GetSpecialValueFor("slow_duration")

	self.wall_start = self.origin + direction * width / 2
	self.wall_end = self.origin - direction * width / 2
	self.wall_damage = self.ability:GetSpecialValueFor("wall_damage")

	self.damage_table = {
		attacker 		= self.caster,
		ability 		= self.ability,
		damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
		damage 			= self.wall_damage,
		damage_type 	= DAMAGE_TYPE_MAGICAL,
	}

	local interval = 0.1

	local particle_name = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica.vpcf", self.caster)
	local wall_particle = ParticleManager:CreateParticle(particle_name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(wall_particle, 0, self.wall_start)
	ParticleManager:SetParticleControl(wall_particle, 1, self.wall_end)
	self:AddParticle(wall_particle, false, false, -1, false, false)

	self.parent:EmitSound("Hero_Dark_Seer.Wall_of_Replica_Start")
	self.parent:EmitSound("Hero_Dark_Seer.Wall_of_Replica_lp")

	self:StartIntervalThink(interval)
	self:OnIntervalThink()
end


function modifier_dark_seer_wall_of_replica_lua_thinker:OnDestroy()
	if not IsServer() then return end

	if IsValidEntity(self.parent) then
		self.parent:StopSound("Hero_Dark_Seer.Wall_of_Replica_lp")

		UTIL_Remove(self.parent)
	end
end


function modifier_dark_seer_wall_of_replica_lua_thinker:OnIntervalThink()
	if not IsValidEntity(self.caster) or not IsValidEntity(self.ability) then
		self:Destroy()
		return
	end

	local enemies = FindUnitsInLine(
		self.caster:GetTeam(),
		self.wall_start,
		self.wall_end,
		nil,
		50,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS
	)

	for _, enemy in pairs(enemies or {}) do
		enemy:AddNewModifier(self.caster, self.ability, "modifier_dark_seer_wall_slow", {
			duration = self.slow_duration
		})

		self:TryCreateIllusion(enemy)
	end
end


function modifier_dark_seer_wall_of_replica_lua_thinker:TryCreateIllusion(source)
	if not self.ability.illusions then self.ability.illusions = {} end

	local source_entity_index = source:GetEntityIndex()
	local hit_result = self.hit_heroes[source_entity_index]

	local current_illusion = self.ability.illusions[source_entity_index]

	if IsValidEntity(current_illusion) and current_illusion:IsAlive() then
		-- empower valid illusion if haven't hit already
		if not hit_result or hit_result ~= current_illusion then
			local modifier = current_illusion:FindModifierByNameAndCaster("modifier_dark_seer_wall_of_replica_lua_empower", self.caster)
			if modifier and not modifier:IsNull() then
				modifier:IncrementStackCount()
			end

			self:UpdateIllusion(source_entity_index, source, current_illusion)
		end
	else
		-- spawn a new one
		current_illusion = CreateIllusions(
			self.caster,
			source,
			{
				outgoing_damage = self.replica_damage_outgoing,
				incoming_damage = self.replica_damage_incoming,
				bounty_base = self.bounty,
				bounty_growth = 0,
				duration = self:GetRemainingTime(),
			},
			1,
			64,
			false,
			true
		)[1]

		current_illusion:SetMinimumGoldBounty(self.bounty)
		current_illusion:SetMaximumGoldBounty(self.bounty)

		current_illusion:AddNewModifier(self.caster, self.ability, "modifier_dark_seer_wall_of_replica_lua_empower", {})
		current_illusion:AddNewModifier(self.caster, self.ability, "modifier_darkseer_wallofreplica_illusion", {
			duration = self:GetRemainingTime()
		})

		self.ability.illusions[source_entity_index] = current_illusion

		self:UpdateIllusion(source_entity_index, source, current_illusion)
	end
end


function modifier_dark_seer_wall_of_replica_lua_thinker:UpdateIllusion(source_entity_index, source, illusion)
	FindClearRandomPositionAroundUnit(illusion, source, 150)

	self.hit_heroes[source_entity_index] = illusion

	ExecuteOrderFromTable({
		UnitIndex = illusion:GetEntityIndex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		TargetIndex = source_entity_index,
	})

	self.damage_table.victim = source
	ApplyDamage(self.damage_table)
end