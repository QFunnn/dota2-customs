--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


chen_summon_convert_lua = class({})

LinkLuaModifier("modifier_chen_summon_convert_lua", "abilities/heroes/chen/chen_summon_convert", LUA_MODIFIER_MOTION_NONE)

function chen_summon_convert_lua:IsStealable() return false end
function chen_summon_convert_lua:ProcsMagicStick() return false end
chen_summon_convert_lua.current_summon = nil

function chen_summon_convert_lua:GetIntrinsicModifierName() return "modifier_chen_summon_convert_lua" end

function chen_summon_convert_lua:Spawn()
	if not IsServer() then return end
	self.current_summon = nil
	self.martyrdom_cooldown_end = 0
end

function chen_summon_convert_lua:OnOwnerDied()
	if not IsValidEntity(self.current_summon) then return end
	self.current_summon:ForceKill(false)
	self.current_summon = nil
end

function chen_summon_convert_lua:OnOwnerSpawned()
	self:EndCooldown()
end

chen_summon_convert_lua.summon_types = {
	{
		little = "npc_dota_neutral_centaur_outrunner",
		big = "npc_dota_neutral_centaur_khan",
	},
	{
		little = "npc_dota_neutral_giant_wolf",
		big = "npc_dota_neutral_alpha_wolf",
	},
	{
		little = "npc_dota_neutral_polar_furbolg_champion",
		big = "npc_dota_neutral_polar_furbolg_ursa_warrior",
	},
	{
		little = "npc_dota_neutral_forest_troll_berserker",
		big = "npc_dota_neutral_dark_troll_warlord",
	},
	{
		little = "npc_dota_neutral_satyr_trickster",
		big = "npc_dota_neutral_satyr_hellcaller",
	},
	{
		little = "npc_dota_neutral_froglet",
		big = "npc_dota_neutral_grown_frog",
	}
}

chen_summon_convert_lua.summon_icons = {
	"chen_summon_convert_centaur",
	"chen_summon_convert_wolf",
	"chen_summon_convert_hellbear",
	"chen_summon_convert_troll",
	"chen_summon_convert_satyr",
	"chen_summon_convert_frog",
}


function chen_summon_convert_lua:GetSummonType()
	local caster = self:GetCaster()
	return caster:GetModifierStackCount("modifier_chen_summon_convert_lua", caster) + 1 -- lua is 1-indexed
end


function chen_summon_convert_lua:CycleSummonType()
	local m = self:GetCaster():FindModifierByName("modifier_chen_summon_convert_lua")

	local next_stacks = m:GetStackCount() + 1
	if next_stacks > (#chen_summon_convert_lua.summon_types - 1) then next_stacks = 0 end
	m:SetStackCount(next_stacks)
end


function chen_summon_convert_lua:OnSpellStart()
	local caster = self:GetCaster()
	if not IsValidEntity(caster) then return end

	if not IsValidEntity(self.current_summon) or not self.current_summon:IsAlive() then
		self.current_summon = nil
	end

	if self.current_summon then
		self:EndCooldown()
		self:RefundManaCost()
		return
	end

	local summon_size = self:GetLevel() <= 4 and "little" or "big"

	local config = self.summon_types[self:GetSummonType()]
	self:CreateCreep(config[summon_size])

	self:CycleSummonType()
end

function chen_summon_convert_lua:GetAbilityTextureName()
	local icon = chen_summon_convert_lua.summon_icons[self:GetSummonType()]
	if icon then return icon end

	return "chen_soul_persuasion_1"
end

function chen_summon_convert_lua:CreateCreep(creep_name)
	local caster = self:GetCaster()
	if not IsValidEntity(caster) then return end

	local spawn_point = GetRandomPathablePositionWithin(caster:GetAbsOrigin(), 210, 140)
	spawn_point.z = 0

	local unit = CreateUnitByName(creep_name, spawn_point, false, caster, caster, caster:GetTeamNumber())
	unit:SetControllableByPlayer(caster:GetPlayerOwnerID(), true)
	FindClearSpaceForUnit(unit, spawn_point, true)
	self.current_summon = unit

	local health_min = self:GetSpecialValueFor("health_min")
	local bonus_health_per_level = self:GetSpecialValueFor("bonus_health_per_level")
	local health = health_min + caster:GetLevel() * bonus_health_per_level

	unit:SetBaseMaxHealth(health)
	unit:SetMaxHealth(health)
	unit:SetHealth(health)

	unit:AddNewModifier(unit, self, "modifier_chen_holy_persuasion_lua", nil)

	-- if caster:HasScepter() then
	-- 	self:AddMartyrdom(unit)
	-- end

	local abilities_level = GetCreepAbilityLevel()
	if caster:HasShard() then
		abilities_level = abilities_level + 1
	end

	for i = 0, 10 do
		local ability = unit:GetAbilityByIndex(i)
		if IsValidEntity(ability) then
			ability:SetLevel(abilities_level)
		end
	end

	local spawn_particle = ParticleManager:CreateParticle("particles/econ/items/pets/pet_frondillo/pet_spawn_frondillo.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(spawn_particle, 0, spawn_point)
	ParticleManager:ReleaseParticleIndex(spawn_particle)
end

-- function chen_summon_convert_lua:OnItemEquipped(item)
-- 	local caster = self:GetCaster()

-- 	if not caster:HasScepter() then return end

-- 	if not IsValidEntity(self.current_summon) or not self.current_summon:IsAlive() then
-- 		self.current_summon = nil
-- 		return
-- 	end

-- 	self:AddMartyrdom(self.current_summon)
-- end

function chen_summon_convert_lua:AddMartyrdom(unit)
	local martyrdom = unit:AddAbility("chen_martyrdom")
	unit:RemoveAbilityFromIndexByName("chen_martyrdom")
	unit:SetAbilityByIndex(martyrdom, 5)
	martyrdom:SetLevel(1)

	local cooldown = self.martyrdom_cooldown_end - GameRules:GetGameTime()

	if cooldown > 0 then
		martyrdom:StartCooldown(cooldown)
	end
end


modifier_chen_summon_convert_lua = modifier_chen_summon_convert_lua or class({})

function modifier_chen_summon_convert_lua:IsPurgable() return false end
function modifier_chen_summon_convert_lua:IsHidden() return true end