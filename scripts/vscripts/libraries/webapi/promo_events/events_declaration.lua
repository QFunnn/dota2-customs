--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local PROMO_EVENTS = {}

PROMO_EVENTS["12v12_event_first"] = {
	custom_game = "12v12",
	active = true,
	started_at = "06/21/24", -- date for backend to fetch data from - stuff before won't be accounted
	ends_at = "07/21/24", -- month / day / year - most fucked up format that is default in dota

	tasks = {
		play_games = {
			target = 10,
			rewards = {
				currency = 300,
			}
		},
		win_games = {
			target = 10,
			rewards = {
				currency = 500,
				items = { bp_reroll = 25 },
			}
		},
		kill_heroes = {
			target = 200,
			rewards = {
				currency = 1000,
				items = { bp_reroll = 50, bp_gg_token = 5 },
			}
		},
	},
}


PROMO_EVENTS["chc_event_first"] = {
	custom_game = "custom_hero_clash",
	active = true,
	started_at = "06/21/24", -- date for backend to fetch data from - stuff before won't be accounted
	ends_at = "07/21/24", -- month / day / year - most fucked up format that is default in dota

	tasks = {
		reach_round = {
			target = 60,
			rewards = {
				currency = 300,
			}
		},
		play_games = {
			target = 15,
			rewards = {
				currency = 450,
				items = { bp_reroll = 25 },
			}
		},
		win_games = {
			target = 10,
			rewards = {
				currency = 1000,
				items = { bp_reroll = 50, bp_gg_token = 5 },
			}
		},
	},
}

PROMO_EVENTS["aa_frontier_release"] = {
	custom_game = "angel_arena_classic",
	active = true,
	started_at = "11/22/24", -- date for backend to fetch data from - stuff before won't be accounted
	ends_at = "01/20/25", -- month / day / year - most fucked up format that is default in dota

	tasks = {
		play_games = {
			target = 5,
			rewards = {
				currency = 300,
			}
		},
		win_games = {
			target = 5,
			rewards = {
				currency = 400,
				items = { bp_reroll = 25 },
			}
		},
		kill_creeps = {
			target = 1500,
			rewards = {
				currency = 750,
				items = { bp_reroll = 50, bp_legendary_lagresse = 2, bp_breathtaking_benefaction = 4 },
			}
		},
		kill_heroes = {
			target = 70,
			rewards = {
				currency = 750,
				items = { bp_reroll = 50, bp_legendary_lagresse = 2, bp_breathtaking_benefaction = 4 },
			}
		},
	},
}

PROMO_EVENTS["aa_frontier_promo"] = {
	custom_game = "angel_arena_classic",
	active = true,
	started_at = "01/21/25", -- date for backend to fetch data from - stuff before won't be accounted
	ends_at = "02/21/25", -- month / day / year - most fucked up format that is default in dota

	tasks = {
		kills_and_assists = {
			target = 150,
			rewards = {
				currency = 400,
				items = { bp_reroll = 24, aaf_promo_devil = 1 }
			}
		},
		kill_creeps = {
			target = 1000,
			rewards = {
				currency = 250,
				items = { bp_reroll = 12 }
			}
		},
		kill_bosses = {
			target = 80,
			rewards = {
				currency = 400,
				items = { bp_reroll = 24, aaf_promo_angel = 1 }
			}
		},
		play_games = {
			target = 5,
			rewards = {
				currency = 250,
				items = { bp_reroll = 12 }
			}
		},
		win_games = {
			target = 5,
			rewards = {
				currency = 900,
				items = { bp_reroll = 48, aaf_promo_gold = 1 }
			}
		},
	},
}

PROMO_EVENTS["12v12_event_second"] = {
	custom_game = "12v12",
	active = true,
	started_at = "08/15/25", -- date for backend to fetch data from - stuff before won't be accounted
	ends_at = "09/07/25", -- month / day / year - most fucked up format that is default in dota

	tasks = {
		play_games = {
			target = 5,
			rewards = {
				currency = 300,
				items = { bp_reroll = 50 }
			}
		},
		win_games = {
			target = 5,
			rewards = {
				currency = 750,
				items = { ["12v12_crosspromo_space_oddity"] = 1 },
			}
		},
	},
}

PROMO_EVENTS["aaf_promo"] = {
	custom_game = "angel_arena_classic",
	active = true,
	started_at = "10/05/25", -- date for backend to fetch data from - stuff before won't be accounted
	ends_at = "11/05/25", -- month / day / year - most fucked up format that is default in dota

	tasks = {
		play_games = {
			target = 10,
			rewards = {
				currency = 500,
				items = { bp_reroll = 60 }
			}
		},
		win_games = {
			target = 10,
			rewards = {
				currency = 1000,
				items = { bp_reroll = 100, bp_legendary_lagresse = 5 },
			}
		},
		kills_and_assists = {
			target = 200,
			rewards = {
				currency = 500,
				items = { bp_reroll = 50, double_mmr_token = 5 }
			}
		},
		kill_bosses = {
			target = 80,
			rewards = {
				currency = 1000,
				items = { bp_reroll = 100, bp_breathtaking_benefaction = 5 },
			}
		},
	},
}

return PROMO_EVENTS