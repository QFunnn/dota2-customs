--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lone_druid_17=class({})

function modifier_lone_druid_17:IsHidden() return true end
function modifier_lone_druid_17:IsPurgable() return false end
function modifier_lone_druid_17:IsPurgeException() return false end
function modifier_lone_druid_17:RemoveOnDeath() return false end

function modifier_lone_druid_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local ability = self:GetParent():FindAbilityByName("lone_druid_moonlight")
	if ability then
		if not self:GetParent():HasModifier("modifier_lone_druid_1") then
			self:GetParent():SwapAbilities("lone_druid_spirit_bear_custom", "lone_druid_moonlight", false, true)
            ability:SetLevel(1)
		end
	end
    for _, unit in pairs(FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + MODIFIER_STATE_OUT_OF_GAME, FIND_ANY_ORDER, false)) do 
        if unit:GetOwner() == self:GetParent() and unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" then
            unit:ForceKill(false) 
        end
    end
end

function modifier_lone_druid_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local ability = self:GetParent():FindAbilityByName("lone_druid_moonlight")
	if ability then
		if not self:GetParent():HasModifier("modifier_lone_druid_1") then
			ability:SetHidden(false)
            ability:SetLevel(1)
		end
	end
end