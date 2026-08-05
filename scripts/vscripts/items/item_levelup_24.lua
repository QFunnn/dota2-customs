--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


item_levelup_24 = class({})

function item_levelup_24:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	if card_system:GenerateRandomCardList(caster) then
		ConsumeLevelUpItemCharge(caster, ability)
	end
end