--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_doom_bringer_devour_datadriven", "heroes/hero_doom_bringer/modifier_doom_bringer_devour_datadriven", LUA_MODIFIER_MOTION_NONE )
doom_bringer_devour_datadriven = class({})


function doom_bringer_devour_datadriven:OnSpellStart()

	local caster = self:GetCaster()
	local ability = self
    local target = self:GetCursorTarget()
    local devour_time = self:GetSpecialValueFor("devour_time")

    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_origin", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(pfx, 1, caster, PATTACH_POINT_FOLLOW, "attach_origin", caster:GetAbsOrigin(), true)
   
    caster:AddNewModifier(caster, ability, "modifier_doom_bringer_devour_datadriven", {duration = devour_time})
    target:ForceKill(true)

    caster:EmitSound("Hero_DoomBringer.DevourCast")
end