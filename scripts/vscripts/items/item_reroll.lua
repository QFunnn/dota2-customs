--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_reroll = class({})

function item_reroll:OnSpellStart()
	if IsServer() then
		local pid = self:GetCaster():GetPlayerID()
		local hHero = PlayerResource:GetSelectedHeroEntity(pid)
		CustomGameEventManager:Send_ServerToPlayer(
			PlayerResource:GetPlayer(pid),
			"ShowRerollSkills",
			_G.hero_skills[pid]
		)
		UTIL_Remove(self)
	end
end