--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dragon_knight_4=class({})

function modifier_dragon_knight_4:IsHidden() return true end
function modifier_dragon_knight_4:IsPurgable() return false end
function modifier_dragon_knight_4:IsPurgeException() return false end
function modifier_dragon_knight_4:RemoveOnDeath() return false end

function modifier_dragon_knight_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local dragon_knight_fireball = self:GetParent():FindAbilityByName("dragon_knight_fireball")
    if dragon_knight_fireball then
        dragon_knight_fireball:SetLevel(self:GetStackCount())
    end
    self:GetCaster():SwapAbilities("dragon_knight_wyrms_wrath", "dragon_knight_fireball", false, true)
    local dragon_knight_wyrms_wrath = self:GetParent():FindAbilityByName("dragon_knight_wyrms_wrath")
    if dragon_knight_wyrms_wrath then
        dragon_knight_wyrms_wrath:SetHidden(false)
    end
end

function modifier_dragon_knight_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local dragon_knight_fireball = self:GetParent():FindAbilityByName("dragon_knight_fireball")
    if dragon_knight_fireball then
        dragon_knight_fireball:SetLevel(self:GetStackCount())
    end
end