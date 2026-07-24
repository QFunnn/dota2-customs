--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ot3_mist_coil_mist_ally", "abilities/heroes/abaddon/abaddon_death_coil.lua", LUA_MODIFIER_MOTION_NONE)

ot3_abaddon_death_coil = ot3_abaddon_death_coil or class({})

function ot3_abaddon_death_coil:CastFilterResultTarget(target)
	if target == self:GetCaster() then return UF_FAIL_CUSTOM end
end

function ot3_abaddon_death_coil:GetCustomCastErrorTarget(target)
	return "#dota_hud_error_cant_cast_on_self"
end

function ot3_abaddon_death_coil:OnSpellStart(unit, special_cast)
	if not IsServer() then return end

	local caster = self:GetCaster()
	local target = unit or self:GetCursorTarget()
	self.damage = self:GetSpecialValueFor("target_damage")
	local effect_radius = self:GetSpecialValueFor("effect_radius")

	caster:EmitSound("Hero_Abaddon.DeathCoil.Cast")

	if not special_cast then
		local health_cost = self.damage * self:GetSpecialValueFor("self_damage") / 100

		ApplyDamage({ victim = caster, attacker = caster, ability = self, damage = health_cost, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL})
	end

	-- Create the projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf",
		bDodgeable = false,
		bProvidesVision = true,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		iMoveSpeed = self:GetSpecialValueFor("missile_speed"),
		iVisionRadius = 0,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}

	-- launch at all targets in AOE if not triggered by Borrowed Time scepter and radius is valid
	if not special_cast and effect_radius > 0 then
		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target:GetAbsOrigin(),
			nil,
			effect_radius,
			DOTA_UNIT_TARGET_TEAM_BOTH,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
			DOTA_UNIT_TARGET_FLAG_NONE,
			0, false
		)

		for _, unit in pairs(units or {}) do
			if IsValidEntity(unit) and unit ~= caster then
				info.Target = unit
				ProjectileManager:CreateTrackingProjectile(info)
			end
		end
	else
		ProjectileManager:CreateTrackingProjectile(info)
	end
end

function ot3_abaddon_death_coil:OnProjectileHit(hTarget, vLocation)
	if not IsServer() then return end

	local caster = self:GetCaster()
	local target = hTarget
	local mist_duration = self:GetSpecialValueFor("mist_duration")

	target:EmitSound("Hero_Abaddon.DeathCoil.Target")

	local damage_table = {
		attacker = caster,
		damage = self.damage,
		damage_type = self:GetAbilityDamageType()
	}

	if target:GetTeam() ~= caster:GetTeam() then
		-- If target has Linken Sphere, block effect entirely
		if target:TriggerSpellAbsorb(self) then return nil end

		damage_table.victim = target
		ApplyDamage(damage_table)

		if caster:HasShard() then
			caster:PerformAttack(
				target, true, true, true, true, false, false, true
			)
		end
	else
		--Apply spellpower to heal
		-- local heal_amp = 1 + (caster:GetSpellAmplification(false) / 100)

		local heal = self.damage

		-- heal allies or self and apply mist
		target:HealWithParams(heal, self, false, true, caster, false)
		target:AddNewModifier(caster, self, "modifier_ot3_mist_coil_mist_ally", {duration = mist_duration})
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, heal, nil)
	end
end

modifier_ot3_mist_coil_mist_ally = modifier_ot3_mist_coil_mist_ally or class({})

function modifier_ot3_mist_coil_mist_ally:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_ot3_mist_coil_mist_ally:OnCreated(keys)
	if not self:GetAbility() then self:Destroy() return end

	self.damage_heal_pct = self:GetAbility():GetSpecialValueFor("damage_heal_pct") / 100
end

function modifier_ot3_mist_coil_mist_ally:OnRefresh()
	self:OnCreated()
end

function modifier_ot3_mist_coil_mist_ally:OnDestroy(keys)
	if not self:GetAbility() then return end
	if not IsServer() then return end

	if self:GetParent():IsAlive() then
		self:GetParent():Heal(self:GetStackCount(), self:GetAbility())
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), self:GetStackCount(), nil)
	end
end

function modifier_ot3_mist_coil_mist_ally:OnTakeDamage(keys)
	if keys.unit == self:GetParent() then
		self:SetStackCount(self:GetStackCount() + math.floor(keys.damage * self.damage_heal_pct))
	end
end