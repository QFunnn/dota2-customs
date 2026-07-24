--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_fusion_rune_custom = class({})

function item_fusion_rune_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():StartGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	self:GetCaster():EmitSound("SeasonalConsumable.TI9.Shovel.Dig")
	self.point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()*120
	self.particle = ParticleManager:CreateParticle("particles/econ/events/ti9/shovel_dig.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(self.particle, 0, self.point)
end

function item_fusion_rune_custom:OnChannelFinish(bInterrupted)
	if not IsServer() then return end

	self:GetCaster():FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	self:GetCaster():RemoveModifierByName("modifier_alchemist_goblins_greed_custom_anim")

	if self.particle then
		ParticleManager:DestroyParticle(self.particle, false)
	end

	if bInterrupted then return end

	local particle = 4

	local runetype = self:GetRune()

	CreateRune(self.point, runetype)
end

function item_fusion_rune_custom:GetRune()
    local rune_name = nil
    local runelist = {DOTA_RUNE_ARCANE, DOTA_RUNE_REGENERATION, DOTA_RUNE_DOUBLEDAMAGE, DOTA_RUNE_HASTE, DOTA_RUNE_SHIELD, DOTA_RUNE_ILLUSION }

    if RollPercentage(9) then
        rune_name = DOTA_RUNE_WATER
    else
        rune_name = runelist[RandomInt(1, #runelist)]
    end
    
    return rune_name
end