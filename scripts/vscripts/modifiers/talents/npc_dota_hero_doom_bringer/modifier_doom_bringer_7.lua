--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_doom_bringer_doom_custom_aura", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_doom_custom", LUA_MODIFIER_MOTION_NONE)

modifier_doom_bringer_7=class({})

function modifier_doom_bringer_7:IsHidden() return true end
function modifier_doom_bringer_7:IsPurgable() return false end
function modifier_doom_bringer_7:IsPurgeException() return false end
function modifier_doom_bringer_7:RemoveOnDeath() return false end

function modifier_doom_bringer_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local doom_bringer_doom_custom = self:GetCaster():FindAbilityByName("doom_bringer_doom_custom")
	if doom_bringer_doom_custom and doom_bringer_doom_custom:GetLevel() > 0 then
		doom_bringer_doom_custom:EndCooldown()
		self:GetParent():AddNewModifier(self:GetParent(), doom_bringer_doom_custom, "modifier_doom_bringer_doom_custom_aura", {})
	end
end

function modifier_doom_bringer_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_doom_bringer_7:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_doom_bringer_7:GetModifierMoveSpeedBonus_Constant()
	return -175
end