--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_legion_commander_7_debuff", "modifiers/talents/npc_dota_hero_legion_commander/modifier_legion_commander_7", LUA_MODIFIER_MOTION_NONE)

modifier_legion_commander_7=class({})

function modifier_legion_commander_7:IsHidden() return true end
function modifier_legion_commander_7:IsPurgable() return false end
function modifier_legion_commander_7:IsPurgeException() return false end
function modifier_legion_commander_7:RemoveOnDeath() return false end

function modifier_legion_commander_7:OnCreated()
    self.bonus = {75,150}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_legion_commander_7:OnRefresh()
    self.bonus = {75,150}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_legion_commander_7:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
end

function modifier_legion_commander_7:GetModifierAttackRangeBonus()
	return self.bonus[self:GetStackCount()]
end