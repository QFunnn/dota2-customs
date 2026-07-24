--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const MAPS = ["ot3_necropolis_ffa", "ot3_gardens_duo", "ot3_jungle_quintet", "ot3_desert_octet"];

const LEADERBOARD_STATES = {
	NONE: 0,
	FETCHED: 1,
	LOADED: 2,
};

const REWARDS_BY_MMR = {
	ot3_necropolis_ffa: [
		[1550, 1650, 300, { bp_reroll: 20 }],
		[1650, 1800, 500, { bp_reroll: 40, treasure_1: 1 }],
		[1800, 2100, 800, { bp_reroll: 60, treasure_2: 1 }],
		[2100, 2500, 1000, { bp_reroll: 80, treasure_3: 1 }],
		[2500, 3000, 1500, { bp_reroll: 100, treasure_3: 1 }],
		[3000, 999999, 2000, { bp_reroll: 120, treasure_3: 1 }],
	],
	ot3_gardens_duo: [
		[1600, 1800, 300, { bp_reroll: 20 }],
		[1800, 2000, 500, { bp_reroll: 40, treasure_1: 1 }],
		[2000, 2500, 800, { bp_reroll: 60, treasure_2: 1 }],
		[2500, 3000, 1000, { bp_reroll: 80, treasure_3: 1 }],
		[3000, 4000, 1500, { bp_reroll: 100, treasure_3: 1 }],
		[4000, 999999, 2000, { bp_reroll: 120, treasure_3: 1 }],
	],
	ot3_jungle_quintet: [
		[1550, 1600, 300, { bp_reroll: 20 }],
		[1600, 1700, 500, { bp_reroll: 40, treasure_1: 1 }],
		[1700, 1900, 800, { bp_reroll: 60, treasure_2: 1 }],
		[1900, 2200, 1000, { bp_reroll: 80, treasure_3: 1 }],
		[2200, 2500, 1500, { bp_reroll: 100, treasure_3: 1 }],
		[2500, 999999, 2000, { bp_reroll: 120, treasure_3: 1 }],
	],
	ot3_desert_octet: [
		[1550, 1625, 300, { bp_reroll: 20 }],
		[1625, 1750, 500, { bp_reroll: 40, treasure_1: 1 }],
		[1750, 2000, 800, { bp_reroll: 60, treasure_2: 1 }],
		[2000, 2300, 1000, { bp_reroll: 80, treasure_3: 1 }],
		[2300, 2800, 1500, { bp_reroll: 100, treasure_3: 1 }],
		[2800, 999999, 2000, { bp_reroll: 120, treasure_3: 1 }],
	],
};

const REWARDS_BY_TOP_PLACES = [
	[1, 10, { season_reset_13_golden: 1, season_reset_13_silver: 1 }],
	[11, 100, { season_reset_13_silver: 1 }],
];

function GetRewardsByRating(map_name, rating) {
	const rewards = REWARDS_BY_MMR[map_name];
	if (!rewards) return;

	let result = {
		end: rewards[0][0],
		start: 1,
		rank: -1,
	};

	for (let i = 0; i < rewards.length; i++) {
		const [start, end, currency, items] = rewards[i];
		if (rating >= start && rating < end)
			result = { rewards: { currency: currency, items: items }, start: start, end: end, rank: i };
	}

	return result;
}
function GetRewardsByTopPlace(rank) {
	let result = {};

	for (const [start, end, items] of REWARDS_BY_TOP_PLACES) if (rank >= start) result = items;

	return result;
}