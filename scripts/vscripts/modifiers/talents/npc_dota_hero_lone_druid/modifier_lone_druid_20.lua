--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lone_druid_20=class({})

function modifier_lone_druid_20:IsHidden() return true end
function modifier_lone_druid_20:IsPurgable() return false end
function modifier_lone_druid_20:IsPurgeException() return false end
function modifier_lone_druid_20:RemoveOnDeath() return false end

function modifier_lone_druid_20:OnCreated()
    self.bonus = {0.4,0.8,1.2}
	if not IsServer() then return end

	self:SetStackCount(1)

	local lone_druid_spirit_link_custom = self:GetParent():FindAbilityByName("lone_druid_spirit_link_custom")
	if lone_druid_spirit_link_custom then
		lone_druid_spirit_link_custom:SetLevel(0)
		lone_druid_spirit_link_custom:SetActivated(false)
		lone_druid_spirit_link_custom:SetHidden(true)
		self:GetParent():RemoveModifierByName("modifier_lone_druid_spirit_link_custom")
		self:GetParent():RemoveModifierByName("modifier_lone_druid_spirit_link_custom_buff")
	end
	
	--local ability = self:GetParent():FindAbilityByName("lone_druid_entanglig_root")
	--if ability then
	--	ability:SetLevel(self:GetStackCount())
	--end
	--self:GetParent():SwapAbilities("lone_druid_spirit_link_custom", "lone_druid_entanglig_root", false, true)
end

function modifier_lone_druid_20:OnRefresh()
	if not IsServer() then return end

	self:SetStackCount(self:GetStackCount() + 1)

	--local ability = self:GetParent():FindAbilityByName("lone_druid_entanglig_root")
	--if ability then
	--	ability:SetLevel(self:GetStackCount())
	--	ability:SetHidden(false)
	--end
end

function modifier_lone_druid_20:DeclareFunctions()
	local funcs = 
	{
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
	}
	return funcs
end

function modifier_lone_druid_20:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "lone_druid_entangle" and data.ability_special_value == "root_heroes_on_cast" then
        return 1
    end
    if data.ability:GetAbilityName() == "lone_druid_entangle" and data.ability_special_value == "active_radius" then
        return 1
    end
    if data.ability:GetAbilityName() == "lone_druid_entangle" and data.ability_special_value == "nostack_protection" then
        return 1
    end
    if data.ability:GetAbilityName() == "lone_druid_entangle" and data.ability_special_value == "entangle_duration" then
        return 1
    end
end

function modifier_lone_druid_20:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "lone_druid_entangle" and data.ability_special_value == "root_heroes_on_cast" then
        return 1
    end
    if data.ability:GetAbilityName() == "lone_druid_entangle" and data.ability_special_value == "active_radius" then
        return data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level ) + 100
    end
    if data.ability:GetAbilityName() == "lone_druid_entangle" and data.ability_special_value == "nostack_protection" then
        return 1
    end
    if data.ability:GetAbilityName() == "lone_druid_entangle" and data.ability_special_value == "entangle_duration" then
        return data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level ) + self.bonus[self:GetStackCount()]
    end
end