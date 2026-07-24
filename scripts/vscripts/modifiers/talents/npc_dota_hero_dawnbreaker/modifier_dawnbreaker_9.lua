--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dawnbreaker_9_buff", "modifiers/talents/npc_dota_hero_dawnbreaker/modifier_dawnbreaker_9", LUA_MODIFIER_MOTION_NONE)

modifier_dawnbreaker_9=class({})

function modifier_dawnbreaker_9:IsHidden() return true end
function modifier_dawnbreaker_9:IsPurgable() return false end
function modifier_dawnbreaker_9:IsPurgeException() return false end
function modifier_dawnbreaker_9:RemoveOnDeath() return false end

function modifier_dawnbreaker_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_dawnbreaker_9_buff", {})
end

function modifier_dawnbreaker_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

modifier_dawnbreaker_9_buff = class({})
function modifier_dawnbreaker_9_buff:IsPurgable() return false end
function modifier_dawnbreaker_9_buff:IsHidden() return self:GetStackCount() == 0 end
function modifier_dawnbreaker_9_buff:IsPurgeException() return false end
function modifier_dawnbreaker_9_buff:RemoveOnDeath() return false end
function modifier_dawnbreaker_9_buff:GetTexture() return "dawnbreaker_9" end