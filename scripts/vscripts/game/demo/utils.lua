--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--[[ Utility Functions ]]

function OT3Demo:NextPlayerID()
	for i = 0, 24 do
		if not PlayerResource:IsValidPlayerID(i) then
			return i
		end
	end
	return -1
end

function OT3Demo:NextBotWithoutHero()
	for i = 0, 24 do
		if PlayerResource:IsValidPlayer(i) and PlayerResource:IsFakeClient(i) and not PlayerResource:GetSelectedHeroEntity(i) then
			return i
		end
	end
	return -1
end

function OT3Demo:AddBot(hero_name, team)
	local assumed_player_id = self:NextBotWithoutHero()
	local hero

	if assumed_player_id == -1 then
		assumed_player_id = OT3Demo:NextPlayerID()

		if assumed_player_id ~= -1 then
			hero = GameRules:AddBotPlayerWithEntityScript(hero_name, "", team, "", false)
		end
	else
		local player = PlayerResource:GetPlayer(assumed_player_id)

		if player then
			player:SetTeam(team)
			hero = CreateHeroForPlayer(hero_name, player)
			player:SetAssignedHeroEntity(hero)
		end
	end

	return hero
end