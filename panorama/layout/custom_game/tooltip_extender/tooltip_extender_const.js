--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	TEMP_CONTAINER: $("#TE_TempContainer"),
	TEMP_LABEL: $("#TE_TempLabel"),
};

const custom_abilities_list = [
	//Abilities
	"shadow_shaman_mass_serpent_ward_lua",
	"shadow_shaman_shackles_lua",
	"medusa_split_shot_chc",
	"spectre_dispersion_lua",
	"tinker_rearm_custom",
	"spectre_haunt_lua",
	"dark_seer_wall_of_replica_lua",
	"terrorblade_reflection_lua",
	"chaos_knight_phantasm_lua",
	"elder_titan_echo_stomp_lua",
	"elder_titan_ancestral_spirit_lua",
	"elder_titan_natural_order_lua",
	"lina_fiery_soul",
	"undying_soul_rip",
	"undying_tombstone",
	//Items
	"item_blade_mail_lua",
	"item_tome_of_knowledge_lua",
	"marci_call_to_arms",
];

const BOSS_DROP_ITEMS_EXCEPTIONS = [
	"item_medical_tractate",
	"item_book_of_all_attributes_1",
	"item_book_of_all_attributes_2",
	"item_book_of_all_attributes_3",
];

const SHIFT_INSTA_CONSUMABLE = [
	"item_medical_tractate",
	"item_book_of_level",
	"item_book_of_strength_1",
	"item_book_of_strength_2",
	"item_book_of_strength_3",
	"item_book_of_agility_1",
	"item_book_of_agility_2",
	"item_book_of_agility_3",
	"item_book_of_intelligence_1",
	"item_book_of_intelligence_2",
	"item_book_of_intelligence_3",
	"item_book_of_all_attributes_1",
	"item_book_of_all_attributes_2",
	"item_book_of_all_attributes_3",
];
const BOSS_ITEMS_COST = {
	item_angels_blood: 10,
	item_angels_sword: 15,
	item_blessed_essence: 8,
	item_possessed_sword: 80,
	item_awful_mask: 15,
	item_angels_armor: 15,
	item_dead_boots: 10,
	item_icarus: 50,
};