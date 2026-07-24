--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


batrider_flaming_lasso_custom = class({})

function batrider_flaming_lasso_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function batrider_flaming_lasso_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor( "duration" )
	local cursor_target = self:GetCursorTarget()
	if cursor_target:TriggerSpellAbsorb(self) then return end
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
	for _, target in pairs(enemies) do
		target:AddNewModifier( self:GetCaster(), self,  "modifier_batrider_flaming_lasso",  {duration = duration * (1-target:GetStatusResistance())} )
		target:AddNewModifier( self:GetCaster(), self,  "modifier_batrider_flaming_lasso_damage",  {duration = duration * (1-target:GetStatusResistance())} )
		self:GetCaster():AddNewModifier(target, self, "modifier_batrider_flaming_lasso_self", {duration = duration * (1-target:GetStatusResistance())})
	end
end