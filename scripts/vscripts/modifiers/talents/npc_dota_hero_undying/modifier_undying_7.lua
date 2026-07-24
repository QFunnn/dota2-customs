--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_undying_flesh_golem_custom", "heroes/npc_dota_hero_undying_custom/undying_flesh_golem_custom", LUA_MODIFIER_MOTION_NONE)

modifier_undying_7=class({})

function modifier_undying_7:IsHidden() return true end
function modifier_undying_7:IsPurgable() return false end
function modifier_undying_7:IsPurgeException() return false end
function modifier_undying_7:RemoveOnDeath() return false end

function modifier_undying_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local undying_flesh_golem_custom = self:GetParent():FindAbilityByName("undying_flesh_golem_custom")
	if undying_flesh_golem_custom and undying_flesh_golem_custom:GetLevel() > 0 then
		self:GetParent():RemoveModifierByName("modifier_undying_flesh_golem_custom")
		self:GetParent():AddNewModifier(self:GetParent(), undying_flesh_golem_custom, "modifier_undying_flesh_golem_custom", {})
		self:GetParent():StartGesture(ACT_DOTA_SPAWN)
	end
end

function modifier_undying_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end