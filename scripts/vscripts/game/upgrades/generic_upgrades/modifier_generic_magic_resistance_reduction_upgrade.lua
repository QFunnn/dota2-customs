--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_magic_resistance_reduction_upgrade = class(modifier_base_generic_upgrade)
LinkLuaModifier("modifier_generic_magic_resistance_reduction_target", "game/upgrades/generic_upgrades/modifier_generic_magic_resistance_reduction_upgrade", LUA_MODIFIER_MOTION_NONE)

function modifier_generic_magic_resistance_reduction_upgrade:RecalculateBonusPerUpgrade()
	self.parent = self:GetParent()

	self.magic_resistance_reduction = self:CalculateBonusPerUpgrade("magic_resistance_reduction")
	self.duration = self:CalculateBonusPerUpgrade("fixed_duration")
end

function modifier_generic_magic_resistance_reduction_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_magic_resistance_reduction_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


if IsServer() then
	function modifier_generic_magic_resistance_reduction_upgrade:DeclareFunctions()
		return {
			-- MODIFIER_EVENT_ON_ABILITY_FULLY_CAST, -- OnAbilityFullyCast,
			MODIFIER_EVENT_ON_SPELL_TARGET_READY, -- OnSpellTargetReady
		}
	end

	function modifier_generic_magic_resistance_reduction_upgrade:OnSpellTargetReady(event)
		if not IsValidEntity(self.parent) then return end
		if event.unit ~= self.parent then return end

		local target = event.target
		if not IsValidEntity(target) then return end

		if target:GetTeam() == self.parent:GetTeam() then return end

		local modifier_owner = self.parent

		if self.parent:IsIllusion() or self.parent:IsMonkeyKingSoldier() or self.parent:IsClone() then
			modifier_owner = GameLoop.hero_by_player_id[self.parent:GetPlayerOwnerID()]
			if not IsValidEntity(modifier_owner) then return end
		end

		local existing_modifier = target:FindModifierByNameAndCaster("modifier_generic_magic_resistance_reduction_target", modifier_owner)

		if not existing_modifier or existing_modifier:IsNull() then
			existing_modifier = target:AddNewModifier(modifier_owner, nil, "modifier_generic_magic_resistance_reduction_target", {duration = self.duration})
		end

		if not existing_modifier or existing_modifier:IsNull() then return end

		existing_modifier:SetStackCount(self.magic_resistance_reduction)
		existing_modifier:ForceRefresh()
		existing_modifier:SendBuffRefreshToClients()
	end
end



modifier_generic_magic_resistance_reduction_target = modifier_generic_magic_resistance_reduction_target or class({})

function modifier_generic_magic_resistance_reduction_target:GetTexture() return "../items/veil_of_discord" end
function modifier_generic_magic_resistance_reduction_target:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_generic_magic_resistance_reduction_target:IsDebuff() return true end

function modifier_generic_magic_resistance_reduction_target:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS, -- GetModifierMagicalResistanceBonus
	}
end


function modifier_generic_magic_resistance_reduction_target:GetModifierMagicalResistanceBonus()
	return -(self:GetStackCount() or 0)
end