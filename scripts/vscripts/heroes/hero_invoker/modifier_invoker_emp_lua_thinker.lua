--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_emp_lua_thinker = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_emp_lua_thinker:IsHidden()
	return true
end

function modifier_invoker_emp_lua_thinker:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_emp_lua_thinker:OnCreated(kv)
	self.shard_drag_speed = self:GetAbilitySpecialValueFor("shard_drag_speed")
	self.mana_burned = self:GetAbilitySpecialValueFor("mana_burned")
	self.area_of_effect = self:GetAbilitySpecialValueFor("area_of_effect")
	self.damage_per_mana_pct = self:GetAbilitySpecialValueFor("damage_per_mana_pct")
	self.restore_mana_pct = self:GetAbilitySpecialValueFor("restore_mana_pct")
	if IsServer() then
		if self.shard_drag_speed > 0 then
			self:StartIntervalThink(FrameTime())
		end

		-- play effects
		self:PlayEffects1()
	end
end
function modifier_invoker_emp_lua_thinker:IsAura()
	return self.shard_drag_speed > 0
end
function modifier_invoker_emp_lua_thinker:GetAuraRadius()
	return self.area_of_effect
end
function modifier_invoker_emp_lua_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_invoker_emp_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_invoker_emp_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_invoker_emp_lua_thinker:GetModifierAura()
	return "modifier_naga_siren_rip_tide_lua_effect"
end
function modifier_invoker_emp_lua_thinker:OnIntervalThink()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	if IsValid(hParent) then
		local units = FindUnitsInRadius(hCaster:GetTeamNumber(), hParent:GetAbsOrigin(), nil, self.area_of_effect, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				local vDir = (hParent:GetAbsOrigin() - unit:GetAbsOrigin()):Normalized()
				local fDistance = math.min(self.shard_drag_speed * FrameTime(), (hParent:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D())
				local vPos = unit:GetAbsOrigin() + vDir * fDistance
				FindClearSpaceForUnit(unit, vPos, false)
			end
		end
	end
end
function modifier_invoker_emp_lua_thinker:OnDestroy()
	if IsServer() then
		-- find caught units
		local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(), -- int, your team number
		self:GetParent():GetOrigin(), -- point, center point
		nil, -- handle, cacheUnit. (not known)
		self.area_of_effect, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_MANA_ONLY, -- int, flag filter
		FIND_ANY_ORDER, -- int, order filter
		false	-- bool, can grow cache
		)

		if self:GetAbility() and not self:GetAbility():IsNull() then
			-- precache damage
			local damageTable = {
				-- victim = target,
				attacker = self:GetCaster(),
				-- damage = 500,
				damage_type = self:GetAbility():GetAbilityDamageType(),
				ability = self:GetAbility(), --Optional.
			}

			local burned = 0
			for _, enemy in pairs(enemies) do
				-- burn mana
				local mana_burn = math.min(enemy:GetMana(), self.mana_burned)
				enemy:Script_ReduceMana(mana_burn, self:GetAbility())

				-- damage based on mana burned
				damageTable.victim = enemy
				damageTable.damage = mana_burn * self.damage_per_mana_pct * 0.01
				ApplyDamage(damageTable)

				-- sum mana burned
				burned = burned + mana_burn
			end

			-- give mana to caster
			self:GetCaster():GiveMana(burned * self.restore_mana_pct * 0.01)
		end

		-- play effects
		self:PlayEffects2()

		-- remove thinker
		UTIL_Remove(self:GetParent())
	end
end

function modifier_invoker_emp_lua_thinker:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_invoker/invoker_emp.vpcf"
	local sound_cast = "Hero_Invoker.EMP.Charge"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.area_of_effect, 0, 0))
	-- ParticleManager:ReleaseParticleIndex( effect_cast )
	-- Create Sound
	EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self:GetCaster())
end

function modifier_invoker_emp_lua_thinker:PlayEffects2()
	-- Get Resources
	local sound_cast = "Hero_Invoker.EMP.Discharge"

	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)

	-- Create Sound
	EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self:GetCaster())
end
function modifier_invoker_emp_lua_thinker:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
	}
end