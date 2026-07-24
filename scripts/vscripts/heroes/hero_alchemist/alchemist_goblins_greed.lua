--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


alchemist_goblins_greed_custom = class({})

function alchemist_goblins_greed_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():StartGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	self:EndCooldown()
	self:GetCaster():EmitSound("SeasonalConsumable.TI9.Shovel.Dig")
	self.point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()*120
	self.particle = ParticleManager:CreateParticle("particles/econ/events/ti9/shovel_dig.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(self.particle, 0, self.point)
end

function alchemist_goblins_greed_custom:OnChannelFinish(bInterrupted)
	if not IsServer() then return end

	self:GetCaster():FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)

	self:UseResources(false, false, false, true)

	if self.particle then
		ParticleManager:DestroyParticle(self.particle, false)
	end

	if bInterrupted then return end

	CreateRune(self.point, DOTA_RUNE_BOUNTY)
end