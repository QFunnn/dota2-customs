--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const MAPS = ["dota"];

const LEADERBOARD_STATES = {
	NONE: 0,
	FETCHED: 1,
	LOADED: 2,
};

// from - to - glory - new rating - items list
const REWARDS_BY_MMR = {
	dota: [
		[0, 1000, 0, 1000, {}],
		[1000, 2000, 750, 1500, {}],
		[2000, 3000, 2000, 2000, {}],
		[3000, 4000, 3000, 2500, {}],
		[4000, 999999, 5000, 3000, {}],
	],
};

const REWARDS_BY_SEASONS_EMPTY = [
	[1, 3],
	[4, 10],
	[11, 25],
	[26, 100],
];
const REWARDS_BY_SEASONS = {
	6: [
		[1, 3, { dragon_champion: 1, kill_effect_sword_smash: 1 }],
		[4, 10, { season_6_golden_wings: 1, spectral_kill_gold: 1 }],
		[11, 25, { season_6_silver_wings: 1, spectral_kill_blue: 1 }],
		[26, 100, { dragon_aura: 1 }],
	],
	7: [
		[1, 3, { season_7_top_3_aura: 1, season_7_top_3_kill_effect: 1 }],
		[4, 10, { season_7_top_10_aura: 1, season_7_top_10_kill_effect: 1 }],
		[11, 25, { season_7_top_25_aura: 1, season_7_top_25_kill_effect: 1 }],
		[26, 100, { season_7_top_100_aura: 1 }],
	],
	8: [
		[1, 3, { season_8_top_3_aura: 1, season_8_top_3_kill_effect: 1 }],
		[4, 10, { season_8_top_10_aura: 1, season_8_top_10_kill_effect: 1 }],
		[11, 25, { season_8_top_25_aura: 1, season_8_top_25_kill_effect: 1 }],
		[26, 100, { season_8_top_100_aura: 1 }],
	],
	9: [
		[1, 3, { season_9_top_3_aura: 1, season_9_top_3_kill_effect: 1 }],
		[4, 10, { season_9_top_10_aura: 1, season_9_top_10_kill_effect: 1 }],
		[11, 25, { season_9_top_25_aura: 1, season_9_top_25_kill_effect: 1 }],
		[26, 100, { season_9_top_100_aura: 1 }],
	],
};

let REWARDS_BY_TOP_PLACES;
function UpdateRewardsTable(current_season) {
	if (REWARDS_BY_TOP_PLACES) return;

	REWARDS_BY_TOP_PLACES = REWARDS_BY_SEASONS[current_season] || REWARDS_BY_SEASONS_EMPTY;
}

function GetRewardsByRating(map_name, rating) {
	const rewards = REWARDS_BY_MMR[map_name];
	if (!rewards) return;

	let result = {
		end: rewards[0][0],
		start: 1,
		rank: -1,
	};

	for (let i = 0; i < rewards.length; i++) {
		const [start, end, currency, new_rating, items] = rewards[i];
		if (rating >= start && rating < end)
			result = {
				rewards: { currency: currency, items: items },
				start: start,
				end: end,
				rank: i,
				reset_new_rating: new_rating,
			};
	}

	return result;
}
function GetRewardsByTopPlace(rank, current_season) {
	UpdateRewardsTable(current_season);
	let result = {};

	for (const [start, end, items] of REWARDS_BY_TOP_PLACES) if (rank >= start) result = items;

	return result;
}

function GetClassNameByTopPlace(place, current_season) {
	UpdateRewardsTable(current_season);
	for (const [start, end, items] of REWARDS_BY_TOP_PLACES) if (place >= start && place <= end) return `Top${start}`;
}