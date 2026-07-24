--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	GAMES: $("#PE_GamesList_Container"),
	TASKS: $("#PE_TasksList"),
};

const games_order = [
	"angel_arena_classic",
	"12v12",
	"overthrow_3",
	"custom_hero_clash",
	"ar_custom_game_template",
	"",
].reverse();

const games_workshop_pages = {
	angel_arena_classic: 3295624094,
	"12v12": 1576297063,
	overthrow_3: 2760533777,
	custom_hero_clash: 2141071809,
};