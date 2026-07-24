--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_heavy_blade_custom", "items/item_heavy_blade_custom", LUA_MODIFIER_MOTION_NONE)

item_heavy_blade_custom = class({})

function item_heavy_blade_custom:GetIntrinsicModifierName()
	return "modifier_item_heavy_blade_custom"
end

function item_heavy_blade_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():Purge(false, true, false, true, false)
	self:GetCaster():EmitSound("Brewmaster_Storm.DispelMagic")
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
end

modifier_item_heavy_blade_custom = class({})

function modifier_item_heavy_blade_custom:IsHidden() return true end

function modifier_item_heavy_blade_custom:IsPurgable() return false end
function modifier_item_heavy_blade_custom:IsPurgeException() return false end

function modifier_item_heavy_blade_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_item_heavy_blade_custom:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("attack_speed")
end