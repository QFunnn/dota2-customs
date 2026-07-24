--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phoenix_16=class({})

function modifier_phoenix_16:GetTexture() return "phoenix_15" end

function modifier_phoenix_16:IsPurgable() return false end
function modifier_phoenix_16:IsPurgeException() return false end
function modifier_phoenix_16:RemoveOnDeath() return false end

function modifier_phoenix_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local phoenix_freezing_spirits = self:GetCaster():FindAbilityByName("phoenix_freezing_spirits")
    if phoenix_freezing_spirits then
        phoenix_freezing_spirits:SetLevel(self:GetStackCount())
        local modifier_phoenix_freezing_spirits = self:GetCaster():FindModifierByName("modifier_phoenix_freezing_spirits")
        if modifier_phoenix_freezing_spirits then
            modifier_phoenix_freezing_spirits.rotation = 180
        end
        self:GetCaster():AddNewModifier(self:GetCaster(), phoenix_freezing_spirits, "modifier_phoenix_freezing_spirits", {})
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

function modifier_phoenix_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local phoenix_freezing_spirits = self:GetCaster():FindAbilityByName("phoenix_freezing_spirits")
    if phoenix_freezing_spirits then
        phoenix_freezing_spirits:SetLevel(self:GetStackCount())
        local modifier_phoenix_freezing_spirits = self:GetCaster():FindModifierByName("modifier_phoenix_freezing_spirits")
        if modifier_phoenix_freezing_spirits then
            modifier_phoenix_freezing_spirits.rotation = 180
        end
        self:GetCaster():AddNewModifier(self:GetCaster(), phoenix_freezing_spirits, "modifier_phoenix_freezing_spirits", {})
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