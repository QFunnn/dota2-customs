--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_muerta_pierce_the_veil_custom", "heroes/npc_dota_hero_muerta_custom/muerta_pierce_the_veil_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_pierce_the_veil_custom_range", "heroes/npc_dota_hero_muerta_custom/muerta_pierce_the_veil_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_muerta_pierce_the_veil_custom_ghost_attack", "heroes/npc_dota_hero_muerta_custom/muerta_pierce_the_veil_custom", LUA_MODIFIER_MOTION_NONE)

muerta_pierce_the_veil_custom = class({})
muerta_pierce_the_veil_custom.modifier_muerta_12 = {100,200}
muerta_pierce_the_veil_custom.modifier_muerta_14 = 2

function muerta_pierce_the_veil_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/items3_fx/octarine_core_lifesteal.vpcf", context )
end

function muerta_pierce_the_veil_custom:GetIntrinsicModifierName()
	return "modifier_muerta_pierce_the_veil"
end

function muerta_pierce_the_veil_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():Purge(false, true, false, true, true)
    if self:GetCaster():HasModifier("modifier_muerta_14") then
        duration = duration + self.modifier_muerta_14
    end
	self:GetCaster():EmitSound("Hero_Muerta.PierceTheVeil.Cast")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_muerta_pierce_the_veil_custom", {duration = duration})
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_muerta_pierce_the_veil_buff", {duration = duration})
end

modifier_muerta_pierce_the_veil_custom = class({})
function modifier_muerta_pierce_the_veil_custom:IsPurgable() return false end
function modifier_muerta_pierce_the_veil_custom:IsHidden() return true end
function modifier_muerta_pierce_the_veil_custom:IsPurgeException() return false end
function modifier_muerta_pierce_the_veil_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_PROPERTY_MAGICAL_LIFESTEAL,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
end

function modifier_muerta_pierce_the_veil_custom:GetModifierAttackRangeBonus()
    if not self:GetCaster():HasModifier("modifier_muerta_12") then return end
    return self:GetAbility().modifier_muerta_12[self:GetCaster():GetTalentLevel("modifier_muerta_12")]
end

function modifier_muerta_pierce_the_veil_custom:GetMinHealth()
    if not self:GetCaster():HasModifier("modifier_muerta_21") then return end
	return 1
end

function modifier_muerta_pierce_the_veil_custom:GetModifierProperty_MagicalLifesteal(params)
    if not self:GetCaster():HasModifier("modifier_muerta_21") then return end
    return 20
end



