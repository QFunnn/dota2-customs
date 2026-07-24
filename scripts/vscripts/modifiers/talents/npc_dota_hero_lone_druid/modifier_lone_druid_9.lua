--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lone_druid_9=class({})

function modifier_lone_druid_9:IsHidden() return true end
function modifier_lone_druid_9:IsPurgable() return false end
function modifier_lone_druid_9:IsPurgeException() return false end
function modifier_lone_druid_9:RemoveOnDeath() return false end

function modifier_lone_druid_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local lone_druid_spirit_bear_custom = self:GetParent():FindAbilityByName("lone_druid_spirit_bear_custom")
    if lone_druid_spirit_bear_custom then
        lone_druid_spirit_bear_custom:SetHidden(true)
    end
    for _, unit in pairs(FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + MODIFIER_STATE_OUT_OF_GAME, FIND_ANY_ORDER, false)) do 
        if unit:GetOwner() == self:GetParent() and unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" then
            unit:ForceKill(false) 
        end
    end
    self:StartIntervalThink(0.1)
end

function modifier_lone_druid_9:OnIntervalThink()
    if not IsServer() then return end
    local lone_druid_entangle = self:GetParent():FindAbilityByName("lone_druid_entangle")
    local modifier_lone_druid_spirit_bear_entangle = self:GetParent():FindModifierByName("modifier_lone_druid_spirit_bear_entangle")
    if modifier_lone_druid_spirit_bear_entangle and modifier_lone_druid_spirit_bear_entangle:GetRemainingTime() > 1 then
        modifier_lone_druid_spirit_bear_entangle:Destroy()
    end
    if not self:GetParent():HasModifier("modifier_lone_druid_spirit_bear_entangle") then
        self:GetParent():AddNewModifier(self:GetParent(), lone_druid_entangle, "modifier_lone_druid_spirit_bear_entangle", {})
    end
    local modifier_lone_druid_spirit_bear_entangle_vfx = self:GetParent():FindModifierByName("modifier_lone_druid_spirit_bear_entangle_vfx")
    if modifier_lone_druid_spirit_bear_entangle_vfx and modifier_lone_druid_spirit_bear_entangle_vfx:GetRemainingTime() > 1 then
        modifier_lone_druid_spirit_bear_entangle_vfx:Destroy()
    end
    if not self:GetParent():HasModifier("modifier_lone_druid_spirit_bear_entangle_vfx") then
        self:GetParent():AddNewModifier(self:GetParent(), lone_druid_entangle, "modifier_lone_druid_spirit_bear_entangle_vfx", {})
    end
end

function modifier_lone_druid_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end