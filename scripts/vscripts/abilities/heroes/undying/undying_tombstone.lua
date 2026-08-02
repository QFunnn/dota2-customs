--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


---@class undying_tombstone:CDOTA_Ability_Lua
undying_tombstone_lua = class({})
LinkLuaModifier(
	"modifier_undying_tombstone_intrinsic_lua",
	"abilities/heroes/undying/modifier_undying_tombstone_intrinsic",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_undying_tombstone_lua",
	"abilities/heroes/undying/modifier_undying_tombstone",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_undying_tombstone_zombie",
	"abilities/heroes/undying/modifier_undying_tombstone_zombie",
	LUA_MODIFIER_MOTION_NONE
)

function undying_tombstone_lua:Spawn()
	if IsClient() then
		return
	end

	self.zombies = {}
end

function undying_tombstone_lua:CastFilterResultTarget(target)
	if IsClient() then
		return
	end

	if PlayerResource:IsDisableHelpSetForPlayerID(target:GetPlayerOwnerID(), self:GetCaster():GetPlayerOwnerID()) then
		return UF_FAIL_DISABLE_HELP
	end
end

function undying_tombstone_lua:GetBehavior()
	if self:GetCaster():HasShard() then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	else
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
	end
end

function undying_tombstone_lua:GetCooldown(level)
	return self.BaseClass.GetCooldown(self, level) - self:GetCaster():FindTalentValue("special_bonus_unique_undying_7")
end

function undying_tombstone_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function undying_tombstone_lua:GetIntrinsicModifierName()
	return "modifier_undying_tombstone_intrinsic_lua"
end

function undying_tombstone_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local cast_position = self:GetCursorPosition()

	local target = self:GetCursorTarget()

	GridNav:DestroyTreesAroundPoint(cast_position, 300, false)

	local tombstone = CreateUnitByName(
		"npc_dota_unit_tombstone" .. self:GetLevel(),
		cast_position,
		true,
		caster,
		caster,
		caster:GetTeamNumber()
	)

	tombstone:AddNewModifier(caster, self, "modifier_undying_tombstone_lua", { duration = duration })
	tombstone:AddNewModifier(caster, self, "modifier_kill", { duration = duration })

	local base_health = self:GetSpecialValueFor("hits_to_destroy_tooltip") * 4
	tombstone:SetBaseMaxHealth(base_health)
	tombstone:SetMaxHealth(base_health)
	tombstone:SetHealth(base_health)

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_undying/undying_tombstone.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, self:GetCursorPosition())
	ParticleManager:SetParticleControlEnt(particle, 1, caster, duration, "attach_attack1", caster:GetOrigin(), true)
	ParticleManager:SetParticleControl(particle, 2, Vector(duration, duration, duration))
	ParticleManager:ReleaseParticleIndex(particle)

	tombstone:EmitSound("Hero_Undying.Tombstone")

	ResolveNPCPositions(tombstone:GetAbsOrigin(), 64)

	if caster:HasShard() then
		tombstone:AddNewModifier(tombstone, self, "modifier_undying_tombstone_bunker", nil)

		local bunker_ability = tombstone:FindAbilityByName("undying_tombstone_unit_grab")
		bunker_ability:SetHidden(true)

		if target then
			tombstone:CastAbilityOnTarget(target, bunker_ability, -1)
		end
	end
end

function undying_tombstone_lua:SpawnOrUpgradeZombie(target, source)
	local zombie = self.zombies[target]

	if not IsValidEntity(zombie) or not zombie:IsAlive() then
		zombie = self:SpawnZombie(target)
		self.zombies[target] = zombie
	end

	local modifier = zombie:FindModifierByName("modifier_undying_tombstone_zombie")
	if modifier and not modifier:IsNull() then
		modifier:AddStack(source)
	end
end

function undying_tombstone_lua:SpawnZombie(target)
	local caster = self:GetCaster()

	local unit_name = RandomInt(0, 1) == 1 and "npc_dota_unit_undying_zombie_torso" or "npc_dota_unit_undying_zombie"
	local unit =
		CreateUnitByName(unit_name, target:GetAbsOrigin() + RandomVector(16), true, caster, caster, caster:GetTeam())

	local zombie_damage = self:GetSpecialValueFor("zombie_damage_tooltip")

	unit:SetBaseDamageMin(zombie_damage - 1)
	unit:SetBaseDamageMax(zombie_damage + 1)

	unit:FindAbilityByName("undying_tombstone_zombie_deathstrike"):SetLevel(self:GetLevel())
	unit:FindAbilityByName("neutral_spell_immunity"):SetLevel(1)
	unit:AddNewModifier(caster, self, "modifier_undying_tombstone_zombie", nil).target = target

	unit:SetForceAttackTarget(target)

	return unit
end