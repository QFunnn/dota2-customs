--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dawnbreaker_3_buff", "modifiers/talents/npc_dota_hero_dawnbreaker/modifier_dawnbreaker_3", LUA_MODIFIER_MOTION_NONE)

modifier_dawnbreaker_3=class({})

function modifier_dawnbreaker_3:IsHidden() return true end
function modifier_dawnbreaker_3:IsPurgable() return false end
function modifier_dawnbreaker_3:IsPurgeException() return false end
function modifier_dawnbreaker_3:RemoveOnDeath() return false end

function modifier_dawnbreaker_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_dawnbreaker_3_buff", {})
end

function modifier_dawnbreaker_3:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

modifier_dawnbreaker_3_buff = class({})
function modifier_dawnbreaker_3_buff:IsHidden() return self:GetStackCount() == 0 end
function modifier_dawnbreaker_3_buff:IsPurgable() return false end
function modifier_dawnbreaker_3_buff:IsPurgeException() return false end
function modifier_dawnbreaker_3_buff:RemoveOnDeath() return false end
function modifier_dawnbreaker_3_buff:GetTexture() return "dawnbreaker_3" end
function modifier_dawnbreaker_3_buff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.25)
    self:OnIntervalThink()
end
function modifier_dawnbreaker_3_buff:OnIntervalThink()
    if not IsServer() then return end
    self:SetStackCount(self:GetCaster():GetKills() + (self:GetParent().arena_bonus or 0))
end