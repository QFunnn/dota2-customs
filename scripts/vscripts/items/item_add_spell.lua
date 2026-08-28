--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_add_spell = class({})

function item_add_spell:OnSpellStart()
	if IsServer() then
		local pid = self:GetCaster():GetPlayerID()
		local hHero = PlayerResource:GetSelectedHeroEntity(pid)

		hHero.count = 1
		HeroBuilder:ShowAbilityForSelect(hHero, pid)
		UTIL_Remove(self)
	end
end