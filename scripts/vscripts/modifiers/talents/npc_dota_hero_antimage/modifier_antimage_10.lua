--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_antimage_counterspell_aura_9", "heroes/npc_dota_hero_antimage_custom/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_counterspell_aura_10", "heroes/npc_dota_hero_antimage_custom/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )

modifier_antimage_10=class({})

function modifier_antimage_10:IsHidden() return true end
function modifier_antimage_10:IsPurgable() return false end
function modifier_antimage_10:IsPurgeException() return false end
function modifier_antimage_10:RemoveOnDeath() return false end

function modifier_antimage_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local ability = self:GetParent():FindAbilityByName("antimage_counterspell_custom")
	if ability then
		self:GetParent():AddNewModifier(self:GetParent(), ability, "modifier_antimage_counterspell_aura_10", {})
	end
end

function modifier_antimage_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end