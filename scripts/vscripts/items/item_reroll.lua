--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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