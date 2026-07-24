--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


invoker_cold_snap_lua = class({})

LinkLuaModifier( "modifier_invoker_cold_snap_lua", "heroes/hero_invoker/modifier_invoker_cold_snap_lua", LUA_MODIFIER_MOTION_NONE )

function invoker_cold_snap_lua:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function invoker_cold_snap_lua:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")
	if target:TriggerSpellAbsorb(self) then return end
    local units = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, unit in pairs(units) do
	    unit:AddNewModifier( caster, self, "modifier_invoker_cold_snap_lua", { duration = duration } )
	    self:PlayEffects( unit )
    end
end

function invoker_cold_snap_lua:GetCooldown(level)
    return self.BaseClass.GetCooldown(self, level)
end

function invoker_cold_snap_lua:PlayEffects( target )
	local particle_cast = "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf"
	local sound_cast = "Hero_Invoker.ColdSnap.Cast"
	local sound_target = "Hero_Invoker.ColdSnap"
	local direction = target:GetOrigin()-self:GetCaster():GetOrigin()
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, target )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster():GetOrigin() + direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound(sound_cast)
	target:EmitSound(sound_target)
end