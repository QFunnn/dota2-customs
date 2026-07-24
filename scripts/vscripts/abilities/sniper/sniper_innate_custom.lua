--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sniper_innate_custom", "abilities/sniper/sniper_innate_custom", LUA_MODIFIER_MOTION_NONE )


sniper_innate_custom = class({})

function sniper_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_sniper.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_sniper", context)
end


function sniper_innate_custom:GetIntrinsicModifierName()
return "modifier_sniper_innate_custom"
end


modifier_sniper_innate_custom = class({})
function modifier_sniper_innate_custom:IsHidden() return true end
function modifier_sniper_innate_custom:IsPurgable() return false end
function modifier_sniper_innate_custom:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.range = self.ability:GetSpecialValueFor("range")
end

function modifier_sniper_innate_custom:OnRefresh(table)
self.range = self.ability:GetSpecialValueFor("range")
end

function modifier_sniper_innate_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end

function modifier_sniper_innate_custom:GetModifierAttackRangeBonus()
if self.parent:PassivesDisabled() then return end
return self.range
end
