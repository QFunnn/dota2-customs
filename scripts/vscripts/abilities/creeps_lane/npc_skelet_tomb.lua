--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skelet_tomb", "abilities/creeps_lane/npc_skelet_tomb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tomb_thinker", "abilities/creeps_lane/npc_skelet_tomb", LUA_MODIFIER_MOTION_NONE)

npc_skelet_tomb = class({})

function npc_skelet_tomb:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.hits = self:GetLevelSpecialValueFor("hits", 1)
	self.regen = self:GetLevelSpecialValueFor("regen", 1)
end

function npc_skelet_tomb:OnSpellStart()
	self.caster:EmitSound("Hero_Undying.Tombstone")

	local tomb = CreateUnitByName(
		"npc_skelet_tomb",
		self.caster:GetAbsOrigin() + RandomVector(RandomInt(-1, 1) + self.radius),
		true,
		nil,
		nil,
		DOTA_TEAM_CUSTOM_5
	)
	tomb:AddNewModifier(self.caster, self, "modifier_tomb_thinker", {})
	tomb:SetBaseMaxHealth(self.hits)
	tomb.host_team = self.caster.host_team
	tomb.any_team_damage = true
	dota1x6:SetLaneCreepsStats(tomb)
end

modifier_tomb_thinker = class(mod_hidden)
function modifier_tomb_thinker:IsAura()
	return true
end
function modifier_tomb_thinker:GetAuraDuration()
	return 0.1
end
function modifier_tomb_thinker:GetAuraRadius()
	return 1200
end
function modifier_tomb_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_tomb_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_tomb_thinker:GetAuraEntityReject(target)
	return target:GetUnitName() == "npc_skelet_tomb" or target.player_unit
end
function modifier_tomb_thinker:GetModifierAura()
	return "modifier_skelet_tomb"
end

modifier_skelet_tomb = class(mod_visible)
function modifier_skelet_tomb:GetTexture()
	return "undying_tombstone"
end
function modifier_skelet_tomb:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.regen = self.ability.regen
end

function modifier_skelet_tomb:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_skelet_tomb:GetMinHealth()
	if self.parent:HasModifier("modifier_death") then
		return
	end
	return 1
end

function modifier_skelet_tomb:GetModifierHealthRegenPercentage()
	return self.regen
end