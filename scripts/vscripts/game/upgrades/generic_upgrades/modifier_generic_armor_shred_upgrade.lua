--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_armor_shred_upgrade = class(modifier_base_generic_upgrade)


LinkLuaModifier("modifier_generic_armor_shred_target", "game/upgrades/generic_upgrades/modifier_generic_armor_shred_upgrade", LUA_MODIFIER_MOTION_NONE)


function modifier_generic_armor_shred_upgrade:RecalculateBonusPerUpgrade()
	self.armor_shred = self:CalculateBonusPerUpgrade("armor_shred")
	self.duration = self:GetUpgradeValueFor("fixed_duration")
end


function modifier_generic_armor_shred_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_armor_shred_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_armor_shred_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK, -- GetModifierProcAttack_Feedback
	}
end


function modifier_generic_armor_shred_upgrade:GetModifierProcAttack_Feedback(params)
	local target = params.target
	if not IsValidEntity(target) then return end

	local parent = self:GetParent()
	if not IsValidEntity(parent) then return end

	local modifier_owner = parent

	if parent:IsIllusion() or parent:IsMonkeyKingSoldier() or parent:IsClone() then
		modifier_owner = GameLoop.hero_by_player_id[parent:GetPlayerOwnerID()]
	end

	if not IsValidEntity(modifier_owner) then return end

	-- this allows to have multiple armor shreds from different heroes, one instance per hero
	local existing_modifier = target:FindModifierByNameAndCaster("modifier_generic_armor_shred_target", modifier_owner)

	if not existing_modifier or existing_modifier:IsNull() then
		existing_modifier = target:AddNewModifier(modifier_owner, nil, "modifier_generic_armor_shred_target", {duration = self.duration})
	end

	-- double checking because modifier application may fail - due to target being invulnerable, dead or w/e
	if not existing_modifier or existing_modifier:IsNull() then return end

	existing_modifier:SetStackCount(self.armor_shred)
	existing_modifier:ForceRefresh()
	existing_modifier:SendBuffRefreshToClients()
end


-- purgable and visible
modifier_generic_armor_shred_target = modifier_generic_armor_shred_target or class({})

function modifier_generic_armor_shred_target:GetTexture() return "../items/desolator" end
function modifier_generic_armor_shred_target:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end


function modifier_generic_armor_shred_target:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, -- GetModifierPhysicalArmorBonus
	}
end


function modifier_generic_armor_shred_target:GetModifierPhysicalArmorBonus()
	return -self:GetStackCount()
end


-- play sound when disarmor is applied (doesn't play again if instance is refreshed, but does play for any other instance from other heroes)
function modifier_generic_armor_shred_target:OnCreated()
	local parent = self:GetParent()

	if not IsValidEntity(parent) then return end

	EmitSoundOn("Item_Desolator.Target", parent)
end