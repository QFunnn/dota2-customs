--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_dust_custom = class({})

function item_dust_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function item_dust_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
	local point = self:GetCaster():GetAbsOrigin()

	self:GetCaster():EmitSound("DOTA_Item.DustOfAppearance.Activate")
	EmitSoundOnLocationWithCaster(point, "DOTA_Item.DustOfAppearance.Activate", self:GetCaster())
	
	AddFOWViewer(self:GetCaster():GetTeamNumber(), point, radius, duration, false)

	local particle = ParticleManager:CreateParticle("particles/items_fx/dust_of_appearance.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, point)
    ParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
    Timers:CreateTimer(duration, function()
    	ParticleManager:DestroyParticle(particle, false)
    	ParticleManager:ReleaseParticleIndex(particle)
    end)

	self:SpendCharge(0)
end