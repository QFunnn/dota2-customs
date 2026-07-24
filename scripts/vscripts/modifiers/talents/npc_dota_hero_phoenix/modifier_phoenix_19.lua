--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phoenix_19=class({})

function modifier_phoenix_19:GetTexture() return "phoenix_19" end
function modifier_phoenix_19:IsPurgable() return false end
function modifier_phoenix_19:IsPurgeException() return false end
function modifier_phoenix_19:RemoveOnDeath() return false end

function modifier_phoenix_19:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local phoenix_live_spirits = self:GetCaster():FindAbilityByName("phoenix_live_spirits")
    if phoenix_live_spirits then
        phoenix_live_spirits:SetLevel(self:GetStackCount())
        local modifier_phoenix_live_spirits = self:GetCaster():FindModifierByName("modifier_phoenix_live_spirits")
        if modifier_phoenix_live_spirits then
            modifier_phoenix_live_spirits.rotation = 180
        end
        self:GetCaster():AddNewModifier(self:GetCaster(), phoenix_live_spirits, "modifier_phoenix_live_spirits", {})
    end
    local frozen_angle = 0
    local heal_angle = 90
    for _, mod in pairs(self:GetCaster():FindAllModifiersByName("modifier_phoenix_freezing_spirits")) do
        mod.rotation = frozen_angle
        frozen_angle = frozen_angle + 180
    end
    for _, mod in pairs(self:GetCaster():FindAllModifiersByName("modifier_phoenix_live_spirits")) do
        mod.rotation = heal_angle
        heal_angle = heal_angle + 180
    end
end

function modifier_phoenix_19:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local phoenix_live_spirits = self:GetCaster():FindAbilityByName("phoenix_live_spirits")
    if phoenix_live_spirits then
        phoenix_live_spirits:SetLevel(self:GetStackCount())
        local modifier_phoenix_live_spirits = self:GetCaster():FindModifierByName("modifier_phoenix_live_spirits")
        if modifier_phoenix_live_spirits then
            modifier_phoenix_live_spirits.rotation = 180
        end
        self:GetCaster():AddNewModifier(self:GetCaster(), phoenix_live_spirits, "modifier_phoenix_live_spirits", {})
    end
    local frozen_angle = 0
    local heal_angle = 90
    for _, mod in pairs(self:GetCaster():FindAllModifiersByName("modifier_phoenix_freezing_spirits")) do
        mod.rotation = frozen_angle
        frozen_angle = frozen_angle + 180
    end
    for _, mod in pairs(self:GetCaster():FindAllModifiersByName("modifier_phoenix_live_spirits")) do
        mod.rotation = heal_angle
        heal_angle = heal_angle + 180
    end
end