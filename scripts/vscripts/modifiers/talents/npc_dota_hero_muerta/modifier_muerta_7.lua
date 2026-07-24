--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_muerta_the_calling_custom_thinker_buff", "heroes/npc_dota_hero_muerta_custom/muerta_the_calling_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_muerta_the_calling_caster", "heroes/npc_dota_hero_muerta_custom/muerta_the_calling_custom", LUA_MODIFIER_MOTION_NONE )

modifier_muerta_7=class({})

function modifier_muerta_7:IsHidden() return true end
function modifier_muerta_7:IsPurgable() return false end
function modifier_muerta_7:IsPurgeException() return false end
function modifier_muerta_7:RemoveOnDeath() return false end

function modifier_muerta_7:OnCreated()
	self.bonus={0}
	if not IsServer() then return end

	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)

	local muerta_the_calling_custom = self:GetCaster():FindAbilityByName("muerta_the_calling_custom")

	if muerta_the_calling_custom then
		if muerta_the_calling_custom:GetLevel() <= 0 then
			muerta_the_calling_custom:SetLevel(1)
		end
		self:GetCaster():AddNewModifier(self:GetCaster(), muerta_the_calling_custom, "modifier_muerta_the_calling_caster", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), muerta_the_calling_custom, "modifier_muerta_the_calling_custom_thinker_buff", {})
	end
end

function modifier_muerta_7:OnRefresh()
	self.bonus={0}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_muerta_7:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_muerta_7:GetModifierBonusStats_Strength()
	return self.bonus[self:GetStackCount()]
end