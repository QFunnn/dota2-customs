--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")

LinkLuaModifier("modifier_generic_common_stat_boost_upgrade_handler", "game/upgrades/generic_upgrades/modifier_generic_common_stat_boost_upgrade", LUA_MODIFIER_MOTION_NONE)

modifier_generic_common_stat_boost_upgrade = modifier_generic_common_stat_boost_upgrade or class(modifier_base_generic_upgrade)

function modifier_generic_common_stat_boost_upgrade:OnCreated()
	-- GetUpgradeValueFor takes value from Specials array in generics.txt
	-- defined at both client and server
	if not IsServer() then return end
	self.bonus_stat_boost_per_upgrade = self:GetUpgradeValueFor("common_generic_stat_boost")
	self:OnRefresh()
end

function modifier_generic_common_stat_boost_upgrade:OnRefresh()
	if not IsServer() then return end
	self.bonus_stat_boost = self:GetStackCount() * self.bonus_stat_boost_per_upgrade

	local handler = self:GetParent():FindModifierByName("modifier_generic_common_stat_boost_upgrade_handler")

	if handler then
		handler:SetStackCount(self.bonus_stat_boost)
	else
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_generic_common_stat_boost_upgrade_handler", {}):SetStackCount(self.bonus_stat_boost)
	end
end

modifier_generic_common_stat_boost_upgrade_handler = modifier_generic_common_stat_boost_upgrade_handler or class({})

function modifier_generic_common_stat_boost_upgrade_handler:IsHidden() return true end
function modifier_generic_common_stat_boost_upgrade_handler:IsPurgable() return false end
function modifier_generic_common_stat_boost_upgrade_handler:RemoveOnDeath() return false end
function modifier_generic_common_stat_boost_upgrade_handler:OnTooltip() return self:GetStackCount() end

function modifier_generic_common_stat_boost_upgrade_handler:OnCreated()
	self:OnStackCountChanged()
end

function modifier_generic_common_stat_boost_upgrade_handler:OnStackCountChanged()
	if not IsClient() then return end

	local modifiers_by_rarity = self:GetParent().modifiers_by_rarity

	if modifiers_by_rarity and modifiers_by_rarity["common"] then
		for k, v in pairs(self:GetParent().modifiers_by_rarity["common"]) do
			if not v:IsNull() and v.RecalculateBonusPerUpgrade then
				v:RecalculateBonusPerUpgrade()
			end
		end
	end
end

function modifier_generic_common_stat_boost_upgrade_handler:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end