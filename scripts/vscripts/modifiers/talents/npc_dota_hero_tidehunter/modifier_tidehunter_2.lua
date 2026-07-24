--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier("modifier_tidehunter_2_cooldown", "modifiers/talents/npc_dota_hero_tidehunter/modifier_tidehunter_2", LUA_MODIFIER_MOTION_NONE)

modifier_tidehunter_2=class({})

function modifier_tidehunter_2:IsHidden() return true end
function modifier_tidehunter_2:IsPurgable() return false end
function modifier_tidehunter_2:IsPurgeException() return false end
function modifier_tidehunter_2:RemoveOnDeath() return false end

function modifier_tidehunter_2:OnCreated()
    self.bonus = {75,150}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_tidehunter_2:OnRefresh()
    self.bonus = {75,150}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tidehunter_2:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_AOE_BONUS_CONSTANT_STACKING
    }
end

function modifier_tidehunter_2:GetModifierAoEBonusConstantStacking()
    return self.bonus[self:GetStackCount()]
end