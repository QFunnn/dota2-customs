--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


slardar_amplify_damage_custom = class({})

function slardar_amplify_damage_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius_skill")
end

function slardar_amplify_damage_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	local cursor_target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, self:GetCaster(), self:GetSpecialValueFor("radius_skill"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

	if cursor_target:TriggerSpellAbsorb(self) then return end

	for _, target in pairs(enemies) do
		target:AddNewModifier( self:GetCaster(), self, "modifier_slardar_amplify_damage", { duration = duration * (1 - target:GetStatusResistance()) } )
		target:EmitSound("Hero_Slardar.Amplify_Damage")
	end
end

