--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_witch_doctor_maledict_lua", "heroes/hero_witch_doctor/witch_doctor_maledict_lua.lua",
	LUA_MODIFIER_MOTION_NONE)

if witch_doctor_maledict_lua == nil then
	witch_doctor_maledict_lua = class({}) ---@class witch_doctor_maledict_lua : CDOTA_Ability_Lua
end
function witch_doctor_maledict_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local vPosition = self:GetCursorPosition()
	local flRadius = self:GetSpecialValueFor("radius")
	local flDuration = self:GetDuration()
	local tTargets = FindUnitsInRadius(hCaster:GetTeam(), vPosition, nil, flRadius, self:GetAbilityTargetTeam(),
		self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), 0, false)
	for _, hTarget in ipairs(tTargets) do
		hTarget:AddNewModifier(hCaster, self, "modifier_maledict", {
			duration = flDuration
		})
		hTarget:AddNewModifier(hCaster, self, "modifier_maledict_dot", {
			duration = flDuration
		})
	end

	local iParticleID = ParticleManager:CreateParticle(
	"particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(iParticleID, 0, vPosition)
	ParticleManager:SetParticleControl(iParticleID, 1, Vector(flRadius, 0, 0))
	ParticleManager:ReleaseParticleIndex(iParticleID)
	EmitSoundOn("Hero_WitchDoctor.Maledict_Cast", hCaster)
end

function witch_doctor_maledict_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function witch_doctor_maledict_lua:IsHiddenWhenStolen()
	return false
end