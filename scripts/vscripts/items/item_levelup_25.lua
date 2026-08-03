--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


item_levelup_25 = class({})

function item_levelup_25:OnSpellStart()
	local caster = self:GetCaster()
	local random_card = card_system:GetRandomCardForConsume(caster:GetPlayerOwnerID())
	if random_card then
		card_system:ConsumePlayerCardWitFX(caster:GetPlayerOwnerID(), random_card)
		ConsumeLevelUpItemCharge(caster, self)
	end
end