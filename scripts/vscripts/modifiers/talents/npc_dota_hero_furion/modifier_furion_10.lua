--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_furion_10_cooldown", "modifiers/talents/npc_dota_hero_furion/modifier_furion_10", LUA_MODIFIER_MOTION_NONE)

modifier_furion_10=class({})

modifier_furion_10.duration = {3,6}

function modifier_furion_10:IsHidden() return true end
function modifier_furion_10:IsPurgable() return false end
function modifier_furion_10:IsPurgeException() return false end
function modifier_furion_10:RemoveOnDeath() return false end

function modifier_furion_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_furion_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_furion_10:DeclareFunctions()
    return
    {
         
    }
end

function modifier_furion_10:OnAttackLanded(params)
    if self:GetParent() ~= params.attacker then return end
    if params.target:HasModifier("modifier_furion_10_cooldown") then return end
    params.target:AddNewModifier(self:GetParent(), nil, "modifier_furion_10_cooldown", {duration = 18})
    params.target:AddNewModifier(self:GetParent(), nil, "modifier_furion_wrath_of_nature_custom_root", {duration = self.duration[self:GetStackCount()] * (1-params.target:GetStatusResistance())})
end

modifier_furion_10_cooldown = class({})
function modifier_furion_10_cooldown:IsHidden() return true end
function modifier_furion_10_cooldown:IsPurgable() return false end
function modifier_furion_10_cooldown:IsPurgeException() return false end