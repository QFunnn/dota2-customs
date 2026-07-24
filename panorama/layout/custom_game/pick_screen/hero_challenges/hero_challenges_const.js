--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CHALLENGE_TYPE = {
	DEAL_DAMAGE: 1,
	TAKE_DAMAGE: 2,
	HEAL: 3,
	STUN: 4,
	CAPTURE_TIME: 5,
	BREAK_WARD: 6,
	KILL: 7,
	ASSIST: 8,
	DEAL_DAMAGE_WITH_SUMMONS: 9,
};
function GetChallengeTypeName(number_type) {
	return Object.keys(CHALLENGE_TYPE).find((key) => CHALLENGE_TYPE[key] == number_type) || "none";
}

const test_challenges = {
	1: {
		hero_name: "npc_dota_hero_spirit_breaker",
		//4 9
		challenge_type: 9,
		id: 17,
		target: 80000,
		difficulty: 4,
		completed: false,
		progress: 0,
		rewards: {
			currency: 80,
			items: { bp_reroll: 12 },
		},
	},
	2: {
		hero_name: "npc_dota_hero_life_stealer",
		challenge_type: 5,
		id: 18,
		target: 100,
		difficulty: 1,
		completed: false,
		progress: 11.51111133555555555,
		rewards: {
			currency: 20,
			items: { bp_reroll: 3 },
		},
	},
	3: {
		hero_name: "npc_dota_hero_batrider",
		challenge_type: 7,
		id: 19,
		target: 60,
		difficulty: 2,
		completed: true,
		progress: 0,
		rewards: {
			currency: 80,
			items: { bp_reroll: 12 },
		},
	},
	// 4: {
	// 	hero_name: "npc_dota_hero_juggernaut",
	// 	challenge_type: 5,
	// 	id: 20,
	// 	target: 100,
	// 	difficulty: 2,
	// 	completed: false,
	// 	progress: 0,
	// },
};