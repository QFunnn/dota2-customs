--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tinker_laser_lua", "heroes/hero_tinker/hero_tinker", LUA_MODIFIER_MOTION_NONE)

tinker_laser_lua = class({})

function tinker_laser_lua:OnAbilityPhaseStart()
	EmitSoundOn("Hero_Tinker.LaserAnim", self:GetCaster())
	return true
end

function tinker_laser_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	local duration = self:GetSpecialValueFor("duration")
	if not IsServer() then
		return
	end
	local damage = self:GetSpecialValueFor("laser_damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")

	local targets = {}
	table.insert(targets, target)

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_tinker_7")
	if talent and talent:GetLevel() > 0 then
		self:Refract(targets, 1)
	end

	local damage = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self,
	}
	for _, enemy in pairs(targets) do
		damage.victim = enemy
		ApplyDamage(damage)

		enemy:AddNewModifier(caster, self, "modifier_tinker_laser_lua", { duration = duration })
	end
	self:PlayEffects(targets)
end

function tinker_laser_lua:Refract(targets, jumps)
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		targets[jumps]:GetOrigin(),
		targets[jumps],
		300,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)
	local next_target = nil
	for _, enemy in pairs(enemies) do
		local candidate = true
		for _, target in pairs(targets) do
			if enemy == target then
				candidate = false
				break
			end
		end
		if candidate then
			next_target = enemy
			break
		end
	end

	if next_target then
		table.insert(targets, next_target)
		self:Refract(targets, jumps + 1)
	end
end

function tinker_laser_lua:PlayEffects(targets)
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_laser.vpcf"
	local sound_cast = "Hero_Tinker.Laser"
	local sound_target = "Hero_Tinker.LaserImpact"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())

	local attach = "attach_attack1"
	if self:GetCaster():ScriptLookupAttachment("attach_attack2") ~= 0 then
		attach = "attach_attack2"
	end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		9,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		targets[1],
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetCaster())
	EmitSoundOn(sound_target, targets[1])

	if #targets > 1 then
		for i = 2, #targets do
			-- Create Particle
			local effect_cast =
				ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
			ParticleManager:SetParticleControlEnt(
				effect_cast,
				9,
				targets[i - 1],
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				Vector(0, 0, 0), -- unknown
				true -- unknown, true
			)
			ParticleManager:SetParticleControlEnt(
				effect_cast,
				1,
				targets[i],
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				Vector(0, 0, 0), -- unknown
				true -- unknown, true
			)
			ParticleManager:ReleaseParticleIndex(effect_cast)

			EmitSoundOn(sound_target, targets[i])
		end
	end
end

--------------------------------------------------------------------------------------------

modifier_tinker_laser_lua = class({})

function modifier_tinker_laser_lua:IsHidden()
	return false
end

function modifier_tinker_laser_lua:IsDebuff()
	return true
end

function modifier_tinker_laser_lua:IsStunDebuff()
	return false
end

function modifier_tinker_laser_lua:IsPurgable()
	return true
end

function modifier_tinker_laser_lua:OnCreated(kv)
	self.miss_rate = self:GetAbility():GetSpecialValueFor("miss_rate")
end

function modifier_tinker_laser_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
	}
	return funcs
end

function modifier_tinker_laser_lua:GetModifierMiss_Percentage()
	return self.miss_rate
end

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

tinker_heat_seeking_missile_lua = class({})

function tinker_heat_seeking_missile_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local targets = self:GetSpecialValueFor("targets")

	if not caster:IsHero() then
		targets = 1
	end

	local projectile_name = "particles/units/heroes/hero_tinker/tinker_missile.vpcf"
	local projectile_speed = radius

	if not IsServer() then
		return
	end

	local damage = self:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(), -- int, your team number
		caster:GetOrigin(), -- point, center point
		caster, -- handle, cacheUnit. (not known)
		radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_ALL, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, -- int, flag filter
		FIND_CLOSEST, -- int, order filter
		false -- bool, can grow cache
	)

	local info = {
		Source = caster,
		Ability = self,
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		ExtraData = {
			damage = damage,
		},
	}
	for i = 1, math.min(targets, #enemies) do
		info.Target = enemies[i]
		ProjectileManager:CreateTrackingProjectile(info)
	end

	if #enemies < 1 then
		self:PlayEffects2()
	else
		EmitSoundOn("Hero_Tinker.Heat-Seeking_Missile", caster)
	end
end

function tinker_heat_seeking_missile_lua:OnProjectileHit_ExtraData(target, location, extraData)
	local damage = {
		victim = target,
		attacker = self:GetCaster(),
		damage = extraData.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}
	ApplyDamage(damage)

	self:PlayEffects1(target)
end

function tinker_heat_seeking_missile_lua:PlayEffects1(target)
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_missle_explosion.vpcf"
	local sound_cast = "Hero_Tinker.Heat-Seeking_Missile.Impact"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, target)
end

function tinker_heat_seeking_missile_lua:PlayEffects2()
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_missile_dud.vpcf"
	local sound_cast = "Hero_Tinker.Heat-Seeking_Missile_Dud"

	local attach = "attach_attack1"
	if self:GetCaster():ScriptLookupAttachment("attach_attack3") ~= 0 then
		attach = "attach_attack3"
	end
	local point = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment(attach))

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControlForward(effect_cast, 0, self:GetCaster():GetForwardVector())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetCaster())
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

LinkLuaModifier("modifier_tinker_bot", "heroes/hero_tinker/hero_tinker", LUA_MODIFIER_MOTION_NONE)

tinker_summon = class({})

function tinker_summon:OnSpellStart()
	self:GetCaster():EmitSound("Hero_Tinker.March_of_the_Machines.Cast")
	local count = self:GetSpecialValueFor("count")
	local duration = self:GetSpecialValueFor("duration")

	for i = 1, count do
		local bot = CreateUnitByName(
			"tinkerbot",
			self:GetCaster():GetAbsOrigin() + RandomVector(RandomFloat(150, 150)),
			true,
			nil,
			nil,
			DOTA_TEAM_GOODGUYS
		)
		bot:AddNewModifier(self:GetCaster(), self, "modifier_tinker_bot", {})
		bot:AddNewModifier(self:GetCaster(), self, "modifier_kill", { duration = duration })
		bot:SetOwner(self:GetCaster())
		bot:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
		local owner_ability = self:GetCaster():FindAbilityByName("tinker_heat_seeking_missile_lua")
		if owner_ability ~= nil and owner_ability:GetLevel() > 0 then
			bot:FindAbilityByName("tinker_heat_seeking_missile_lua"):SetLevel(owner_ability:GetLevel())
		else
			bot:RemoveAbility("tinker_heat_seeking_missile_lua")
		end
	end
end

------------------------------------------------

modifier_tinker_bot = class({})

function modifier_tinker_bot:IsHidden()
	return false
end

function modifier_tinker_bot:IsPurgable()
	return false
end

function modifier_tinker_bot:OnCreated(kv)
	if IsServer() then
		if self:GetParent():GetUnitName() == "tinkerbot" then
			self:GetParent():SetRenderColor(255, 233, 0)
		end
	end
end

function modifier_tinker_bot:CheckState()
	local state = {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_tinker_bot:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	}
	return funcs
end

function modifier_tinker_bot:GetAbsoluteNoDamageMagical(params)
	return 1
end

function modifier_tinker_bot:GetAbsoluteNoDamagePure(params)
	return 1
end

function modifier_tinker_bot:GetAbsoluteNoDamagePhysical(params)
	return 1
end

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

tinker_rearm_lua = class({})

function tinker_rearm_lua:GetManaCost(iLevel)
	if not self:GetCaster():IsRealHero() then
		return 0
	end
	return self:GetCaster():GetMaxMana() / 100 * self:GetSpecialValueFor("manacost")
end

function tinker_rearm_lua:OnSpellStart()
	EmitSoundOn("Hero_Tinker.Rearm", self:GetCaster())
end

function tinker_rearm_lua:OnChannelFinish(bInterrupted)
	local caster = self:GetCaster()
	StopSoundOn("Hero_Tinker.Rearm", self:GetCaster())

	if bInterrupted then
		return
	end
	for i = 0, caster:GetAbilityCount() - 1 do
		local ability = caster:GetAbilityByIndex(i)
		if
			ability
			and ability:GetAbilityType() ~= ABILITY_TYPE_ATTRIBUTES
			and ability ~= self
			and not self:IsItemException(ability)
		then
			ability:RefreshCharges()
			ability:EndCooldown()
		end
	end
	for i = 0, 8 do
		local item = caster:GetItemInSlot(i)
		if item then
			local pass = false
			if item:GetPurchaser() == caster and not self:IsItemException(item) then
				pass = true
			end

			if pass then
				item:EndCooldown()
			end
		end
	end
	self:PlayEffects()
end

function tinker_rearm_lua:IsItemException(item)
	return self.ItemException[item:GetName()]
end

tinker_rearm_lua.ItemException = {
	["item_aeon_disk"] = true,
	["item_black_king_bar_lua1"] = true,
	["item_black_king_bar_lua2"] = true,
	["item_black_king_bar_lua3"] = true,
	["item_octarine_core_lua1"] = true,
	["item_octarine_core_lua2"] = true,
	["item_octarine_core_lua3"] = true,
	["item_refresher"] = true,
	["item_sphere"] = true,
	["item_aeon_of_tarrasque"] = true,
	["item_aeon_of_tarrasque2"] = true,
	["item_aeon_of_tarrasque3"] = true,
	["hero_rubick_ability"] = true,
}

function tinker_rearm_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tinker/tinker_rearm.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Tinker.RearmStart", self:GetCaster())
end