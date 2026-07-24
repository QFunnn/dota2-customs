--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


NeutralItemDrop = NeutralItemDrop or {
	neutral_item_list = {},
	craft_costs = {},
	drop_period = {
		ot3_demo = {
			120,
			270,
			420,
			570,
			900,
		},
		ot3_necropolis_ffa = {
			120,
			270,
			420,
			570,
			900,
		},
		ot3_gardens_duo = {
			120,
			270,
			420,
			570,
			900,
		},
		ot3_jungle_quintet = {
			120,
			270,
			420,
			570,
			900,
		},
		ot3_desert_octet = {
			120, -- 1200 - 18
			270, -- 1200 - 15:30
			420, -- 1200 - 13
			570, -- 1200 - 10:30
			900, -- 1200 - 5
		},
	},
}


ListenToGameEvent("game_rules_state_change",
	function()
		local new_state = GameRules:State_Get()
		if new_state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
			NeutralItemDrop:Activate()
		end
	end,
nil)


function NeutralItemDrop:Activate()
	self.neutral_items_kv = LoadKeyValues("scripts/npc/neutral_items.txt")

	for tier, tier_content in pairs(self.neutral_items_kv.neutral_tiers) do
		for item_name, _ in pairs(tier_content.items or {}) do
			self.neutral_item_list[item_name] = tier
		end

		self.craft_costs[tonumber(tier)] = tonumber(tier_content.craft_cost)
	end

	for i = 1, 5 do
		Timers:CreateTimer(self.drop_period[GetMapName()][i] + 1, function() return self:Drop(i) end)
	end
end

function NeutralItemDrop:Drop(tier)
	local madstone_count = self.craft_costs[tier]

	for team = DOTA_TEAM_FIRST,DOTA_TEAM_CUSTOM_MAX do
		for _, hero in pairs(GameLoop.heroes_by_team[team] or {}) do

			hero:QueueMadstones(madstone_count)
		end
	end
end