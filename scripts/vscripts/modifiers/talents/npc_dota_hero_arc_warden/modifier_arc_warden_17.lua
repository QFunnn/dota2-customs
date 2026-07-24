--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_arc_warden_17_debuff", "modifiers/talents/npc_dota_hero_arc_warden/modifier_arc_warden_17", LUA_MODIFIER_MOTION_NONE)

modifier_arc_warden_17=class({})

function modifier_arc_warden_17:IsHidden() return true end
function modifier_arc_warden_17:IsPurgable() return false end
function modifier_arc_warden_17:IsPurgeException() return false end
function modifier_arc_warden_17:RemoveOnDeath() return false end

function modifier_arc_warden_17:OnCreated()
    self.bonus = {10,20}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_arc_warden_17:OnRefresh()
    self.bonus = {10,20}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_arc_warden_17:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
end

function modifier_arc_warden_17:GetModifierSpellAmplify_Percentage()
    if self:GetCaster():HasModifier("modifier_arc_warden_17_debuff") then return end
    return self.bonus[self:GetStackCount()]
end

function modifier_arc_warden_17:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.damage <= 0 then return end
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_arc_warden_17_debuff", {duration = 3})
end

modifier_arc_warden_17_debuff = class({})
function modifier_arc_warden_17_debuff:IsHidden() return true end
function modifier_arc_warden_17_debuff:IsPurgable() return false end
function modifier_arc_warden_17_debuff:IsPurgeException() return false end