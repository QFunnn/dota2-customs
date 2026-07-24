--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_talent_frost_mind", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_arcane_aura_custom.lua", LUA_MODIFIER_MOTION_NONE )

modifier_crystal_maiden_20=class({})

function modifier_crystal_maiden_20:IsHidden() return true end
function modifier_crystal_maiden_20:IsPurgable() return false end
function modifier_crystal_maiden_20:IsPurgeException() return false end
function modifier_crystal_maiden_20:RemoveOnDeath() return false end

function modifier_crystal_maiden_20:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_crystal_maiden_20:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_crystal_maiden_20:OnAbilityExecuted( params )
	if IsServer() then
		local hAbility = params.ability
		if hAbility == nil or not ( hAbility:GetCaster() == self:GetParent() ) then
			return 0
		end
		if hAbility:IsToggle() or hAbility:IsItem() then
			return 0
		end
		local ability = self:GetParent():FindAbilityByName("crystal_maiden_arcane_aura_custom")
		if self:GetParent():HasModifier("modifier_crystal_maiden_20") and ability then
			self:GetParent():AddNewModifier(self:GetParent(), ability, "modifier_crystal_maiden_arcane_aura_custom_talent_frost_mind", {duration = ability.modifier_crystal_maiden_20_duration[self:GetStackCount()]})
		end
	end
	return 0
end

function modifier_crystal_maiden_20:DeclareFunctions()
	local funcs = {MODIFIER_EVENT_ON_ABILITY_EXECUTED}
	return funcs
end