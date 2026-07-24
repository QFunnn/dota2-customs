--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


night_stalker_void_custom = class({})

function night_stalker_void_custom:OnSpellStart()
	if not IsServer() then return end
	local damage = self:GetSpecialValueFor("damage")
	local duration_night = self:GetSpecialValueFor("duration_night")
	local movespeed_slow = self:GetSpecialValueFor("movespeed_slow")
	local attackspeed_slow = self:GetSpecialValueFor("attackspeed_slow")
	local radius_scepter = self:GetSpecialValueFor("radius_scepter")
	local scepter_ministun = self:GetSpecialValueFor("scepter_ministun")
	local scepter_zone_duration = self:GetSpecialValueFor("scepter_zone_duration")

	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("radius_scepter"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
	for _, target in pairs(enemies) do
		target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = scepter_ministun})
		target:AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_void", {duration = duration_night})
		local damageTable = 
		{
			victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		}
		ApplyDamage( damageTable )
	end
end