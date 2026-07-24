--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lone_druid_5=class({})

function modifier_lone_druid_5:IsHidden() return true end
function modifier_lone_druid_5:IsPurgable() return false end
function modifier_lone_druid_5:IsPurgeException() return false end
function modifier_lone_druid_5:RemoveOnDeath() return false end

function modifier_lone_druid_5:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local ability = self:GetParent():FindAbilityByName("lone_druid_spirit_bear_custom")
	if ability then
		for _, unit in pairs(FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
	        if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" then
				unit:RemoveModifierByName("modifier_lone_druid_spirit_bear_custom")
				unit:AddNewModifier(self:GetParent(), ability, 'modifier_lone_druid_spirit_bear_custom', {})            
	        end
	    end
	end
end

function modifier_lone_druid_5:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local ability = self:GetParent():FindAbilityByName("lone_druid_spirit_bear_custom")
	if ability then
		for _, unit in pairs(FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
	        if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" then
				unit:RemoveModifierByName("modifier_lone_druid_spirit_bear_custom")
				unit:AddNewModifier(self:GetParent(), ability, 'modifier_lone_druid_spirit_bear_custom', {})            
	        end
	    end
	end
end