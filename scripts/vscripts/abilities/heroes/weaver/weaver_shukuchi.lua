--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


weaver_shukuchi = weaver_shukuchi or class({})
LinkLuaModifier("modifier_weaver_shukuchi_lua", "abilities/heroes/weaver/weaver_shukuchi", LUA_MODIFIER_MOTION_NONE)


function weaver_shukuchi:Precache(context)

end


function weaver_shukuchi:OnSpellStart()
	local caster = self:GetCaster()

	local duration = self:GetSpecialValueFor("duration")

	-- caster:AddNewModifier(caster, self, "fade", {duration = fade_time})
	caster:AddNewModifier(caster, self, "modifier_weaver_shukuchi_lua", {duration = duration})

	local cast_particle_name = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_weaver/weaver_shukuchi_start.vpcf", caster)
	local cast_particle = ParticleManager:CreateParticle(cast_particle_name, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(cast_particle, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), false)
	ParticleManager:ReleaseParticleIndex(cast_particle)

	caster:EmitSound("Hero_Weaver.Shukuchi")
end



modifier_weaver_shukuchi_lua = modifier_weaver_shukuchi_lua or class({})

function modifier_weaver_shukuchi_lua:IsPurgable() return false end


function modifier_weaver_shukuchi_lua:GetEffectName()
	return "particles/units/heroes/hero_weaver/weaver_shukuchi.vpcf"
end


function modifier_weaver_shukuchi_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


function modifier_weaver_shukuchi_lua:OnCreated()
	self:OnRefresh()

	local damage = self.ability:GetSpecialValueFor("damage")

	self.damage_radius = self.ability:GetSpecialValueFor("radius")
	self.damage_table = {
		damage 			= damage,
		damage_type		= DAMAGE_TYPE_MAGICAL,
		damage_flags	= DOTA_DAMAGE_FLAG_NONE,
		attacker		= self.parent,
		ability			= self.ability
	}

	self.damaged_enemies = {}

	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end


function modifier_weaver_shukuchi_lua:OnRefresh()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.fade_time = self.ability:GetSpecialValueFor("fade_time")
	self.min_movespeed_override = self.ability:GetSpecialValueFor("min_movespeed_override")
end


function modifier_weaver_shukuchi_lua:OnIntervalThink()
	-- search for enemies in range and deal damage
	local targets = FindUnitsInRadius(
		self.parent:GetTeam(),
		self.parent:GetAbsOrigin(),
		nil,
		self.damage_radius or 1,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	local mark_duration = self.ability:GetSpecialValueFor("geminate_attack_mark_duration")
	local slow_duration = self.ability:GetSpecialValueFor("slow_duration")

	for _, target in pairs(targets) do
		if IsValidEntity(target) and target:IsAlive() and not self.damaged_enemies[target:GetEntityIndex()] then
			self.damage_table.victim = target
			ApplyDamage(self.damage_table)

			self.damaged_enemies[target:GetEntityIndex()] = true

			if self.parent:HasShard() then
				target:AddNewModifier(self.parent, self.ability, "modifier_shukuchi_geminate_attack_mark", {duration = mark_duration})
			end

			-- modifier_shukuchi_slow
			if slow_duration > 0 then
				target:AddNewModifier(self.parent, self.ability, "modifier_shukuchi_slow", {
					duration = slow_duration
				})
			end

			local hit_particle_name = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_weaver/weaver_loadout.vpcf", self.parent)

			local hit_particle = ParticleManager:CreateParticle(hit_particle_name, PATTACH_ABSORIGIN_FOLLOW, target)
			ParticleManager:SetParticleControlEnt(hit_particle, 0, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false)
			ParticleManager:SetParticleControlEnt(hit_particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), false)
			ParticleManager:ReleaseParticleIndex(hit_particle)
		end
	end
end


function modifier_weaver_shukuchi_lua:OnDestroy()
	if not IsServer() then return end
	if not self.parent:HasShard() then return end

	-- after delay, self will most likely no longer exist, bind needed stuff to local instead
	local ability = self.ability
	local parent = self.parent
	if not IsValidEntity(ability) or not IsValidEntity(parent) then return end
	local geminate_attack = self.parent:FindAbilityByName("weaver_geminate_attack_lua")
	if not IsValidEntity(geminate_attack) then return end

	local shukuchi_attack_mark_radius = ability:GetSpecialValueFor("shukuchi_attack_mark_radius")
	local shukuchi_attack_delay = ability:GetSpecialValueFor("shukuchi_attack_delay")

	Timers:CreateTimer(shukuchi_attack_delay, function()
		if not IsValidEntity(ability) or not IsValidEntity(parent) or not IsValidEntity(geminate_attack) then return end

		local targets = FindUnitsInRadius(
			self.parent:GetTeam(),
			self.parent:GetAbsOrigin(),
			nil,
			shukuchi_attack_mark_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER,
			false
		)

		for _, target in pairs(targets or {}) do
			if IsValidEntity(target) and target:HasModifier("modifier_shukuchi_geminate_attack_mark") then
				geminate_attack:DoSecondaryAttacks(target)
			end
		end
	end)
end


function modifier_weaver_shukuchi_lua:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end


function modifier_weaver_shukuchi_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE, -- GetModifierMoveSpeed_Absolute
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL, -- GetModifierInvisibilityLevel
	}
end


function modifier_weaver_shukuchi_lua:GetModifierMoveSpeed_Absolute()
	return self.min_movespeed_override
end


function modifier_weaver_shukuchi_lua:GetModifierInvisibilityLevel()
	local elapsed = self:GetElapsedTime()
	-- linearly interpolate invis level within fade time
	if elapsed < self.fade_time then
		return 0 * (1 - elapsed) + 1 * elapsed
	else
		return 1
	end
end


function modifier_weaver_shukuchi_lua:OnAttack(event)
	if not self or self:IsNull() then return end
	if not IsServer() then return end
	if not IsValidEntity(self.parent) then return end
	if event.attacker ~= self.parent then return end

	if not self.parent:IsAttackingEntity(event.target) then return end
	if self:GetElapsedTime() < self.fade_time then return end

	self:Destroy()
end


function modifier_weaver_shukuchi_lua:OnAbilityExecuted(keys)
	if not self or self:IsNull() then return end
	if not IsServer() then return end
	if not IsValidEntity(self.parent) then return end
	if self.parent ~= keys.unit then return end
	if not IsValidEntity(keys.ability) then return end
	if keys.ability:GetAbilityName() == "item_madstone_bundle" then return end

	if self:GetElapsedTime() < self.fade_time then return end

	self:Destroy()
end