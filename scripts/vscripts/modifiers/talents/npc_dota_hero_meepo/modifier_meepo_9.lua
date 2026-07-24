--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_meepo_9=class({})

function modifier_meepo_9:IsHidden() return true end
function modifier_meepo_9:IsPurgable() return false end
function modifier_meepo_9:IsPurgeException() return false end
function modifier_meepo_9:RemoveOnDeath() return false end

function modifier_meepo_9:OnCreated()
	if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_aghanim_ray")    
    self:GetParent():RemoveModifierByName("modifier_aghanim_ray_caster")
	self:SetStackCount(1)
    self:Swap("aghanim_ray", "aghanim_time_attack")
end

function modifier_meepo_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local aghanim_time_attack = self:GetCaster():FindAbilityByName("aghanim_time_attack")
    if aghanim_time_attack then
        aghanim_time_attack:SetLevel(self:GetStackCount())
    end
end

function modifier_meepo_9:Swap(name1, name2)
	if not IsServer() then return end
	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)
	ability1:SetHidden(true)
	ability2:SetHidden(false)
    ability2:SetLevel(1)
	self:GetParent():SwapAbilities(name1, name2, false, true)
end