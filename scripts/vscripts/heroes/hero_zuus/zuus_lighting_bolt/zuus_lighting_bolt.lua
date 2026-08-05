--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_zuus_lightning_bolt_lua_true_sight",
	"heroes/hero_zuus/zuus_lighting_bolt/zuus_lighting_bolt",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_zuus_lightning_bolt_lua_dummy",
	"heroes/hero_zuus/zuus_lighting_bolt/zuus_lighting_bolt",
	LUA_MODIFIER_MOTION_NONE
)

zuus_lightning_bolt_lua = class({})

function zuus_lightning_bolt_lua:OnAbilityPhaseStart()
	self:GetCaster():EmitSound("Hero_Zuus.LightningBolt.Cast")
	return true
end

function zuus_lightning_bolt_lua:CastFilterResultTarget(target)
	if IsServer() then
		local nResult = UnitFilter(
			target,
			self:GetAbilityTargetTeam(),
			self:GetAbilityTargetType(),
			self:GetAbilityTargetFlags(),
			self:GetCaster():GetTeamNumber()
		)
		return nResult
	end
end

function zuus_lightning_bolt_lua:OnSpellStart()
	if IsServer() then
		local caster = self:GetCaster()
		local target = self:GetCursorTarget()
		local target_point = self:GetCursorPosition()

		zuus_lightning_bolt_lua:CastLightningBolt(caster, self, target, target_point)
	end
end

function zuus_lightning_bolt_lua:CastLightningBolt(caster, ability, target, target_point, nimbus)
	if IsServer() then
		local spread_aoe = ability:GetSpecialValueFor("spread_aoe")
		local bolt_damage = ability:GetSpecialValueFor("damage")
			+ caster:ExtraIntelligenceDamage() * ability:GetSpecialValueFor("ExtraIntelligenceDamage")
		local true_sight_radius = ability:GetSpecialValueFor("true_sight_radius")
		local sight_duration = ability:GetSpecialValueFor("sight_duration")
		local stun_duration = ability:GetSpecialValueFor("stun_duration")
		local z_pos = 2000

		caster:EmitSound("Hero_Zuus.LightningBolt")

		AddFOWViewer(caster:GetTeam(), target_point, true_sight_radius, sight_duration, false)

		if target ~= nil then
			target_point = target:GetAbsOrigin()
			if target == caster then
				z_pos = 950
			end
		end

		if target == nil then
			local target_flags = DOTA_UNIT_TARGET_FLAG_NONE

			local nearby_enemy_units = FindUnitsInRadius(
				caster:GetTeamNumber(),
				target_point,
				nil,
				spread_aoe,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_ALL,
				target_flags,
				FIND_CLOSEST,
				false
			)
			for i, unit in ipairs(nearby_enemy_units) do
				if not unit:IsMagicImmune() or pierce_spellimmunity then
					target = unit
					break
				end
			end
		end

		if target then
			if target:GetTeam() ~= caster:GetTeam() then
				if target:TriggerSpellAbsorb(ability) then
					return nil
				end
			end
		end

		local particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf",
			PATTACH_WORLDORIGIN,
			target
		)
		if target == nil then
			ParticleManager:SetParticleControl(particle, 0, Vector(target_point.x, target_point.y, target_point.z))
			ParticleManager:SetParticleControl(particle, 1, Vector(target_point.x, target_point.y, z_pos))
			ParticleManager:SetParticleControl(particle, 2, Vector(target_point.x, target_point.y, target_point.z))
		elseif target:IsMagicImmune() == false or pierce_spellimmunity then
			target_point = target:GetAbsOrigin()
			ParticleManager:SetParticleControl(particle, 0, Vector(target_point.x, target_point.y, target_point.z))
			ParticleManager:SetParticleControl(particle, 1, Vector(target_point.x, target_point.y, z_pos))
			ParticleManager:SetParticleControl(particle, 2, Vector(target_point.x, target_point.y, target_point.z))
		end

		local dummy_unit = CreateUnitByName(
			"npc_dummy_unit",
			Vector(target_point.x, target_point.y, 0),
			false,
			nil,
			nil,
			caster:GetTeam()
		)
		local true_sight = dummy_unit:AddNewModifier(
			caster,
			ability,
			"modifier_zuus_lightning_bolt_lua_true_sight",
			{ duration = sight_duration }
		)
		true_sight:SetStackCount(true_sight_radius)
		dummy_unit:SetDayTimeVisionRange(true_sight_radius)
		dummy_unit:SetNightTimeVisionRange(true_sight_radius)

		dummy_unit:AddNewModifier(caster, ability, "modifier_zuus_lightning_bolt_lua_dummy", {})
		dummy_unit:AddNewModifier(caster, nil, "modifier_kill", { duration = sight_duration + 1 })

		if target ~= nil and target:GetTeam() ~= caster:GetTeam() then
			target:AddNewModifier(
				caster,
				ability,
				"modifier_stunned",
				{ duration = stun_duration * (1 - target:GetStatusResistance()) }
			)

			local talent = caster:FindAbilityByName("special_bonus_zuus_4")
			if talent and talent:GetLevel() > 0 then
				bolt_damage = bolt_damage + 175
			end

			local damage_table = {}
			damage_table.attacker = caster
			damage_table.ability = ability
			damage_table.damage_type = ability:GetAbilityDamageType()
			damage_table.damage = bolt_damage
			damage_table.victim = target

			ApplyDamage(damage_table)
		end
	end
end

modifier_zuus_lightning_bolt_lua_dummy = class({})
function modifier_zuus_lightning_bolt_lua_dummy:IsHidden()
	return true
end
function modifier_zuus_lightning_bolt_lua_dummy:IsPurgable()
	return false
end
function modifier_zuus_lightning_bolt_lua_dummy:CheckState()
	local state = {
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_FLYING] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

modifier_zuus_lightning_bolt_lua_true_sight = class({})

function modifier_zuus_lightning_bolt_lua_true_sight:IsAura()
	return true
end

function modifier_zuus_lightning_bolt_lua_true_sight:IsHidden()
	return true
end

function modifier_zuus_lightning_bolt_lua_true_sight:IsPurgable()
	return false
end

function modifier_zuus_lightning_bolt_lua_true_sight:GetAuraRadius()
	return self:GetStackCount()
end

function modifier_zuus_lightning_bolt_lua_true_sight:GetModifierAura()
	return "modifier_truesight"
end

function modifier_zuus_lightning_bolt_lua_true_sight:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_zuus_lightning_bolt_lua_true_sight:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_zuus_lightning_bolt_lua_true_sight:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_OTHER
end

function modifier_zuus_lightning_bolt_lua_true_sight:GetAuraDuration()
	return 0.5
end