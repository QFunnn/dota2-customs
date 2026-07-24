--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


undying_soul_rip_custom = undying_soul_rip_custom or class({})
LinkLuaModifier("modifier_undying_soul_rip_active_lua", "abilities/heroes/undying/modifier_undying_soul_rip_active_lua", LUA_MODIFIER_MOTION_NONE)

function undying_soul_rip_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_undying/soul_rip_buff.vpcf", context)
end

function undying_soul_rip_custom:IsTargetTombstone(target)
	return target and target.GetClassname and target:GetClassname() == "npc_dota_unit_undying_tombstone"
end

function undying_soul_rip_custom:IsTargetZombie(target)
	return target and target.GetClassname and target:GetClassname() == "npc_dota_unit_undying_zombie"
end

function undying_soul_rip_custom:CastFilterResultTarget(target)
	if self:IsTargetTombstone(target) and target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		return UF_SUCCESS
	elseif self:IsTargetZombie(target) then
		return UF_FAIL_CUSTOM
	else
		return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, self:GetCaster():GetTeamNumber())
	end
end

function undying_soul_rip_custom:GetCustomCastErrorTarget(target)
	if self:IsTargetZombie(target) then
		return "#hud_error_undying_soul_rip_cannot_be_cast_on_zombies"
	end
end

function undying_soul_rip_custom:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if not IsValidEntity(caster) then return end
	if not IsValidEntity(target) then return end

	if target:TriggerSpellAbsorb(self) then return end -- Cancel if linken

	local units = self:PerformSoulRip(caster, target)

	if not self:IsTargetTombstone(target) then return end
	if not caster:HasShard() then return end
	self:BounceSoulRip(caster, target, units)
end

function undying_soul_rip_custom:PerformSoulRip(caster, target)
	local damage_per_unit = self:GetSpecialValueFor("damage_per_unit")
	local max_units = self:GetSpecialValueFor("max_units")
	local radius = self:GetSpecialValueFor("radius")
	local tombstone_heal = self:GetSpecialValueFor("tombstone_heal")
	local strength_share_duration = self:GetSpecialValueFor("strength_share_duration") or 0

	caster:EmitSound("Hero_Undying.SoulRip.Cast")

	local hp_removal_damage_table = {
		--victim
		damage			= damage_per_unit,
		damage_type		= DAMAGE_TYPE_PURE,
		damage_flags	= DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, -- Putting reflection flag here in case of unwanted interactions
		attacker		= caster,
		ability			= self
	}

	local soul_rip_damage_table = {
		--victim
		--damage
		damage_type		= DAMAGE_TYPE_MAGICAL,
		damage_flags	= DOTA_DAMAGE_FLAG_NONE,
		attacker		= caster,
		ability			= self
	}

	-- "Does not count Undying, the target, wards, buildings, invisible enemies and units in the Fog of War."
	-- "Spell immune allies are counted, including the zombies from Tombstone."
	local units = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
	local unit_counter = 0
	for _, unit in pairs(units) do
		if unit ~= caster and unit ~= target then
			local particle
			if target:GetTeamNumber() ~= caster:GetTeamNumber() then
				particle = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_soul_rip_damage.vpcf", PATTACH_POINT_FOLLOW, target)
			else
				particle = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_soul_rip_heal.vpcf", PATTACH_POINT_FOLLOW, target)
			end

			ParticleManager:SetParticleControlEnt(particle, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle)

			-- "Units which require a certain amount of attacks to be killed do not lose health when counted in by Soul Rip."
			if self:IsTargetZombie(unit) then
				local modifier = unit:FindModifierByName("modifier_undying_tombstone_zombie")
				if modifier then
					local stacks = modifier:GetUpgradeStacks()
					if stacks then
						unit_counter = unit_counter + stacks
					end
				end
			else
				hp_removal_damage_table.victim = unit
				ApplyDamage(hp_removal_damage_table)
			end

			unit_counter = unit_counter + 1

			if unit_counter >= max_units then
				break
			end
		end
	end

	if unit_counter < 1 then return end

	local is_ally = target:GetTeamNumber() == caster:GetTeamNumber()

	if is_ally and strength_share_duration > 0 and target ~= caster and not self:IsTargetTombstone(target) then
		target:AddNewModifier(caster, self, "modifier_undying_soul_rip_active_lua", {duration = strength_share_duration})
	end

	if is_ally then
		local heal = damage_per_unit * unit_counter
		if self:IsTargetTombstone(target) then
			heal = tombstone_heal
		end
		target:HealWithParams(heal, self, false, true, caster, false)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, heal, nil)
		target:EmitSound("Hero_Undying.SoulRip.Ally")
	else
		soul_rip_damage_table.victim = target
		soul_rip_damage_table.damage = damage_per_unit * unit_counter
		ApplyDamage(soul_rip_damage_table)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_DAMAGE, target, damage_per_unit * unit_counter, nil)
		target:EmitSound("Hero_Undying.SoulRip.Enemy")
	end

	return units
end

function undying_soul_rip_custom:BounceSoulRip(caster, tombstone, units)
	if not IsValidEntity(caster) then return end
	if #units == 0 then return end

	local bounce_radius = self:GetSpecialValueFor("bounce_radius")
	local origin = tombstone:GetAbsOrigin()

	-- Filter: keep only units within 750 range
	local filtered = {}
	for _, unit in ipairs(units) do
		if (unit:GetAbsOrigin() - origin):Length2D() <= bounce_radius then
			table.insert(filtered, unit)
		end
	end

	if #filtered == 0 then return end

	local function GetPriority(unit)
		local is_ally = unit:GetTeamNumber() == caster:GetTeamNumber()
		if is_ally and unit:GetHealth() >= unit:GetMaxHealth() * 0.95 then
			return 6 -- almost full health allies last
		end
		if unit == caster then -- self
			return 2
		end
		if is_ally then
			if unit:IsHero() then return 1 end  -- allied heroes
			return 4							-- allied creeps
		else
			if unit:IsHero() then return 3 end  -- enemy heroes
			return 5							-- enemy creeps
		end
	end

	-- Sort by priority
	table.sort(filtered, function(a, b)
		local pa = GetPriority(a)
		local pb = GetPriority(b)

		if pa ~= pb then
			return pa < pb -- lower number -> higher priority
		end

		if a:GetHealthPercent() ~= b:GetHealthPercent() then
			return a:GetHealthPercent() < b:GetHealthPercent() -- lower health -> higher priority
		end

		-- If same priority → closest first
		local distA = (a:GetAbsOrigin() - origin):Length2D()
		local distB = (b:GetAbsOrigin() - origin):Length2D()
		return distA < distB
	end)

	-- Final target
	local target = filtered[1]
	if not IsValidEntity(target) then return end
	self:PerformSoulRip(caster, target)
end