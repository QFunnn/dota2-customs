--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


treant_generating_tree = class({})

LinkLuaModifier("treant_generating_tree_auto_cast", "abilities/heroes/treant/treant_generating_tree", LUA_MODIFIER_MOTION_NONE)

function treant_generating_tree:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end

function treant_generating_tree:GetIntrinsicModifierName()
	return "treant_generating_tree_auto_cast"
end

function treant_generating_tree:OnSpellStart()
	if not IsServer() then return end

	self:CreateTree(self:GetCursorPosition())
end

function treant_generating_tree:CreateTree(target_loc)
	CreateTempTree(target_loc, self.tree_duration)

	local unitsInRadius = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target_loc, nil, 60, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_COURIER, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
	for _, unit in pairs(unitsInRadius) do
		FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
	end

	local spawnParticle = ParticleManager:CreateParticle("particles/world_destruction_fx/tree_grow_generic.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(spawnParticle, 0, target_loc)
	ParticleManager:ReleaseParticleIndex( spawnParticle )
end

treant_generating_tree_auto_cast = class({})

function treant_generating_tree_auto_cast:IsHidden() return true end
function treant_generating_tree_auto_cast:IsDebuff() return false end
function treant_generating_tree_auto_cast:IsPurgable() return false end

function treant_generating_tree_auto_cast:OnCreated(keys)
	if not IsServer() then return end

	local parent = self:GetParent()

	self.ability = self:GetAbility()
	self.ability.tree_duration = self.ability:GetSpecialValueFor("tree_duration")
	self.auto_cast_tick_rate = self.ability:GetSpecialValueFor("auto_cast_tick_rate")
	self.min_distance = self.ability:GetSpecialValueFor("min_distance")
	self.auto_distance = self.ability:GetSpecialValueFor("autocast_range")

	self:StartIntervalThink(self.auto_cast_tick_rate)
end

function treant_generating_tree_auto_cast:OnRefresh(keys)
    self:OnCreated(keys)
end

function treant_generating_tree_auto_cast:OnIntervalThink()
	local parent = self:GetParent()
	if not parent:IsAlive() then return end

	if not self.ability:GetAutoCastState() then return end
	if self.ability:GetCurrentAbilityCharges() ~= self.ability:GetMaxAbilityCharges(self.ability:GetLevel() - 1) then return end

	local randomPoint = GetRandomPathablePositionWithin(parent:GetAbsOrigin(), self.auto_distance, self.minDistance)
	randomPoint.z = 0

	self.ability:CreateTree(randomPoint)
	self.ability:SetCurrentAbilityCharges(self.ability:GetCurrentAbilityCharges() - 1)
end