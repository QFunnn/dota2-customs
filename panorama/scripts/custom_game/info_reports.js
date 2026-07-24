--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
if ($.GetContextPanel() && parentHUDElements)
{
    $.GetContextPanel().SetParent(parentHUDElements);
}

var max_games = 5
var QUEST_BLUR = true
var courier_selected = null;
var player_table_shop = CustomNetTables.GetTableValue("sub_data", String(Players.GetLocalPlayer()));

var active_sale = 0;
var active_sale_global = 0;
var active_sale_heroes = {}
var selected_category = "tips"

CustomNetTables.SubscribeNetTableListener( "sub_data", UpdatePlayerShopTable );

var new_items =
{
	"npc_dota_hero_drow_ranger": true,
}



var styles_id = 
{
	"2059": ["2068"],
	"4239": ["4560", "4561"],
	"4507": ["4508"],
	"4510": ["4511"],
	"4513": ["4514"],
	"5133": ["7999"],
	"4501": ["4502"],
	"4504": ["4505"],
	"2012": ["4481"],
	"2064": ["4482"],
	"2078": ["4483"],
	"2111": ["4484"],
	"2118": ["4485"],
    "23096": ["2309699"],
    "23098": ["2309899"],
    "23099": ["2309999"],
    "23095": ["2309599"],
    "23097": ["2309799"],
    "7930": ["7931"],
    "9021": ["22845"],
    "9020": ["22844"],
    "9019": ["22843"],
}

var no_styles =
{
    "2012": true,
    "2064": true,
    "2078": true,
    "2111": true,
    "2118": true,
}

var razor_arcana_items_blocked =
{
    23096 : true,
    23098 : true,
    23099 : true,
    23097 : true,
    13768 : true,
    13769 : true,
    13770 : true,
    13760 : true,
    13743 : true,
    13571 : true,
    13473 : true,
    13569 : true,
    24100 : true,
    19091 : true,
    19092 : true,
    19093 : true,
    19094 : true,
    19088 : true,
    19089 : true,
}

var pudge_persona_unique =
{
    999252 : true,
    999253 : true,
}

var crystal_maiden_persona_unique =
{
    265591 : true,
    265592 : true,
}


var SETS_TEXTURE_FULL_ICON = 
{
    // juggernaut
    beast_slayer : "econ/sets/v2/jagged_honor",
    katz : "econ/sets/v2/provocation_of_ruin",
    dc : "econ/sets/v2/balance_bladekeeper",
    favorite : "econ/sets/v2/pilgrimage_of_the_bladeform_aesthete",
    susano : "econ/sets/v2/lineage_of_the_stormlords",
    miyamoto : "econ/sets/v2/isle_of_dragons",

    // phantom
    athena : "econ/sets/v2/bane_of_the_deathstalkers",
    lodas : "econ/sets/v2/dread_gleaming_seal",
    song_shadow_dragon : "custom_game/shop/heroes/phantom_assassin/shadow_dragon",
    gothic : "econ/sets/v2/gothic_whisper",

    // huskar
    maniac : "econ/sets/v2/flashpoint_proselyte",
    pharaohs : "econ/sets/v2/sacred_chamber_guardian",
    baptism : "econ/sets/v2/pursuit_of_the_ember_demons",
    ironbound : "econ/sets/v2/hides_of_hostility",

    // legion commander
    birdofpray : "econ/sets/v2/bird_of_prey",
    triumphimperatrix : "econ/sets/v2/triumph_of_the_imperatrix",
    radiantconqueror : "econ/sets/v2/radiant_conqueror",
    honorservant : "econ/sets/v2/honored_servant_of_the_empire",
    daemonfell : "econ/sets/v2/legion_commander_daemonfell_flame",
    desolate_conquest : "econ/sets/v2/desolate_conquest",

    // Shadow Fiend
    twilight_effigy : "econ/sets/v2/twilight_effigy",
    eternalharverst: "econ/sets/v2/eternal_harvest",
    soulcorplence: "econ/sets/v2/soul_corpulence",
    soulstyrant: "econ/sets/v2/souls_tyrant",

    // razor
    basilisklord : "econ/sets/v2/test_of_the_basilisk_lord",
    cruelassemblage : "econ/sets/v2/cruel_assemblage",
    forlornmaze : "econ/sets/v2/menace_of_the_forlorn_maze",
    razor_arcana : "econ/sets/v2/voidstorm_asylum",

    // monkey king
    fire_lotus_champ : "econ/sets/v2/champion_of_the_fire_lotus",
    mask_mischief : "econ/sets/v2/masks_of_mischief",
    demon_trickster : "econ/sets/v2/cult_of_the_demon_trickster",

    // queen of pain
    queenofpain_arcana : "econ/sets/v2/queenofpain_the_eminence_of_ristul",
    parsols_sting : "econ/sets/v2/regalia_of_the_parasols_sting",
    delightfull_qop : "econ/sets/v2/esl_demonic_affliction",
    maze_of_anguish : "econ/sets/v2/queen_of_agony",

    // wraith king
    dark_reservoir : "econ/sets/v2/dark_reservoir",
    grim_destiny : "econ/sets/v2/grim_destiny",
    vile_reliquary : "econ/sets/v2/vile_reliquary",
    veil_tyrant : "econ/sets/v2/tyrant_of_the_veil",
    king_kringle : "custom_game/shop/heroes/wraith_king/kringle",
    arcana_true_king : "econ/sets/v2/the_one_true_king_bundle",

    // pudge
    pudge_dapper_disguise : "econ/sets/v2/dapper_disguise",
    ftp_dendi : "econ/sets/v2/murder_of_crows",
    pudge_forbidden : "econ/sets/v2/cursed_cryptbreaker",
    doomsday_ripper : "econ/sets/v2/pudge_doomsday_ripper",
    mindless_slaughter : "econ/sets/v2/mindless_slaughter",
    pudge_persona : "econ/sets/v2/pudge_doll_of_the_dead",

    // lina
    scarlet_flare : "econ/sets/v2/lina_the_scarlet_flare",
    blazing_cosmos : "econ/sets/v2/glory_of_the_elderflame",
    lina_calavera : "econ/sets/v2/lina_dead_heat",

    // zuus
    return_of_the_king : "econ/sets/v2/bearing_of_the_king_restored",
    wastorn_heavens : "econ/sets/v2/wartorn_heavens",

    // drow ranger
    drow_stranger : "econ/sets/v2/stranger_in_the_wandering_isles",
    drow_crownfall : "custom_game/shop/heroes/drow_ranger/ravencloack",
    drow_kharen : "econ/sets/v2/sight_of_the_kharen_faithful",
    drow_eldwurm : "econ/sets/v2/eldwurms_touch",
    drow_oaths : "econ/sets/v2/oaths_of_the_dragonborn",
    drow_arcana : "econ/sets/v2/dread_retribution_bundle",

    ogre_shoreline : "econ/sets/v2/shoreline_sapper",
    ogre_pyrexae : "econ/sets/v2/pyrexae_polymorph_perfected",
    ogre_freebot : "econ/sets/v2/freeboot_fortunes",

    terror_foulfell : "econ/sets/v2/foulfell_corruptor",
    terror_chasm : "econ/sets/v2/chasm_of_the_broken_code",
    terror_forgotten : "econ/sets/v2/forgotten_station",

    crystal_winterwarden : "econ/sets/v2/winters_warden",
    crystal_prelate : "econ/sets/v2/crystal_maiden_prelate_of_the_wyvern_legion",
    crystal_white_wind : "econ/sets/v2/whitewind_battlemage",
    crystal_persona : "econ/sets/v2/npc_dota_hero_crystal_maiden_1",
}

var OTHER_BACKGROUND_HEROES =
{
    npc_dota_hero_legion_commander : "queenofpain",
    npc_dota_hero_nevermore : "silencer",
    npc_dota_hero_monkey_king : "slark",
    npc_dota_hero_zuus : "zues",
    npc_dota_hero_drow_ranger : "vengeful_spirit",
    npc_dota_hero_terrorblade : "templar_assassin",
    npc_dota_hero_crystal_maiden : "lycan",
}
 
var SETS_PRIORITY = 
{
    "npc_dota_hero_huskar" : 
    [
        "rare",
        "ironbound",
        "maniac",
        "baptism",
        "pharaohs",
    ],
    "npc_dota_hero_phantom_assassin" : 
    [
        "rare",
        "lodas",
        "athena",
        "song_shadow_dragon",
        "gothic",
    ],
    "npc_dota_hero_juggernaut" : 
    [
        "rare",
        "miyamoto", 
        "beast_slayer",
        "katz",
        "susano",
        "favorite",
        "dc",
    ],
    "npc_dota_hero_nevermore":
    [
        "rare",
        "twilight_effigy",
        "eternalharverst",
        "soulcorplence",
        "soulstyrant",
    ],
    "npc_dota_hero_razor":
    [
        "rare",
        "razor_arcana",
        "forlornmaze",
        "basilisklord",
        "cruelassemblage",
    ],
    "npc_dota_hero_legion_commander":
    [
        "rare",
        "desolate_conquest",
        "triumphimperatrix",
        "radiantconqueror",
        "honorservant",
        "birdofpray",
        "daemonfell",
    ],
    "npc_dota_hero_monkey_king":
    [
        "rare",
        "mask_mischief",
        "demon_trickster",
        "fire_lotus_champ",
    ],
    "npc_dota_hero_queenofpain":
    [
        "rare",
        "queenofpain_arcana",
        "parsols_sting",
        "delightfull_qop",
        "maze_of_anguish",
    ],
    "npc_dota_hero_skeleton_king":
    [
        "rare",
        "arcana_true_king",
        "dark_reservoir",
        "vile_reliquary",
        "king_kringle",
        "veil_tyrant",
        "grim_destiny",
    ],
    "npc_dota_hero_lina":
    [
        "rare",
        "lina_calavera",
        "blazing_cosmos",
        "scarlet_flare",
    ],
    "npc_dota_hero_pudge":
    [
        "rare",
        "pudge_persona",
        "doomsday_ripper",
        "pudge_dapper_disguise",
        "mindless_slaughter",
        "ftp_dendi",
        "pudge_forbidden"
    ],
    "npc_dota_hero_zuus":
    [
        "rare",
        "wastorn_heavens",
        "return_of_the_king",
    ],
    "npc_dota_hero_drow_ranger":
    [
        "rare",
        "drow_arcana",
        "drow_eldwurm",
        "drow_crownfall",
        "drow_stranger",
        "drow_kharen",
        "drow_oaths"
    ],
}


var PLAYER_VIEW_ITEMS_FOR_BUY = true

var ITEM_CHANGED_INFORMATION = 
{
    // НАШ АЙДИ ПРЕДМЕТА
    2059 : 
    {
        // Если не надо отображать модель, то удалить из массива
        // ID ГЕРОЯ / ID DOTA ПРЕДМЕТА / ID слота
        // Найти ID героя и взять HeroID ( https://github.com/dotabuff/d2vpkr/blob/master/dota/scripts/npc/npc_heroes.txt )
        // Ну айди шмотки это айди из доты как камеры
        // последнее номер слота хз рандом ебаный нет инфы, там цифра от 0-10 мб

        "model" : [8, 9059, 0],
        "changed_icons" : 
        [
            // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
            ["custom_juggernaut_blade_fury", "juggernaut_blade_fury_arcana"],
            ["custom_juggernaut_healing_ward", "juggernaut_healing_ward_arcana"],
            ["custom_juggernaut_blade_dance", "juggernaut_blade_dance_arcana"],
            ["custom_juggernaut_omnislash", "juggernaut_omni_slash_arcana"],
        ],
        "changed_effects" : 
        [
            // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
            ["custom_juggernaut_blade_fury", "juggernaut_blade_fury"],
            ["custom_juggernaut_blade_dance", "juggernaut_blade_dance"],
            ["custom_juggernaut_omnislash", "juggernaut_omni_slash"],
        ],
        "styles" : [9059, 0],
    },
    2068 : 
    {
        "styles" : [9059, 1],
    },
    4481 :
    {
        "styles" : [14959, 1],
    },
    4482 :
    {
        "styles" : [14957, 1],
    },
    4484 :
    {
        "styles" : [14956, 1],
    },
    4483 :
    {
        "styles" : [14955, 1],
    },
    4485 :
    {
        "styles" : [14958, 1],
    },
    4478 : 
    {
        "model" : [0, 7593, 0, "juggernaut_healing_ward_shop_preview_1"],
        "changed_icons" : 
        [
            ["custom_juggernaut_healing_ward", "juggernaut/fortunes_tout/juggernaut_healing_ward"],
        ],
        "changed_effects" : 
        [
            ["custom_juggernaut_healing_ward", "juggernaut_healing_ward"],
        ],
    },
    4499 : 
    {
        "model" : [0, 7909, 0, "juggernaut_healing_ward_shop_preview_2"],
        "changed_icons" : 
        [
            ["custom_juggernaut_healing_ward", "juggernaut/fortunes_tout_gold/juggernaut_healing_ward"],
        ],
        "changed_effects" : 
        [
            ["custom_juggernaut_healing_ward", "juggernaut_healing_ward"],
        ],
    },
    2025 :
    {
        "model" : [8, 5339, 0],
        "changed_effects" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut_blade_fury"],
        ],
    },
    2014 :
    {
        "model" : [8, 4101, 0],
        "changed_effects" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut_blade_fury"],
        ],
    },
    2004 :
    {
        "model" : [8, 7481, 4],
        "changed_effects" : 
        [
            ["custom_juggernaut_omnislash", "juggernaut_omni_slash"],
        ],
    },
    2013 :
    {
        "model" : [8, 4100, 4],
        "changed_effects" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut_blade_fury"],
        ],
    },
    2022 :
    {
        "model" : [8, 9984, 4],
        "changed_icons" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut/ti8_immortal_weapon/juggernaut_blade_fury_immortal"],
        ],
        "changed_effects" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut_blade_fury"],
        ],
    },
    2003 :
    {
        "model" : [8, 12296, 4],
        "changed_icons" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut/ti8_immortal_weapon/juggernaut_blade_fury_immortal_gold"],
        ],
        "changed_effects" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut_blade_fury"],
        ],
    },
    2034 :
    {
        "model" : [8, 12417, 4],
        "changed_icons" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut/ti8_immortal_weapon/juggernaut_blade_fury_immortal_crimson"],
        ],
        "changed_effects" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut_blade_fury"],
        ],
    },
    5132 :
    {
        "model" : [0, 18369, 0, "juggernaut_healing_ward_shop_preview_3"],
        "changed_icons" : 
        [
            ["custom_juggernaut_healing_ward", "juggernaut_fall20_healingward"],
        ],
        "changed_effects" : 
        [
            ["custom_juggernaut_healing_ward", "juggernaut_healing_ward"],
        ],
    },
    2029 : 
    {

        "model" : [8, 7076, 4],
        "changed_icons" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut/bladekeeper/juggernaut_blade_fury"],
            ["custom_juggernaut_healing_ward", "juggernaut/bladekeeper/juggernaut_healing_ward"],
            ["custom_juggernaut_blade_dance", "juggernaut/bladekeeper/juggernaut_blade_dance"],
            ["custom_juggernaut_omnislash", "juggernaut/bladekeeper/juggernaut_omni_slash"],
        ],
        "changed_effects" : 
        [
            ["custom_juggernaut_blade_fury", "juggernaut_blade_fury"],
            ["custom_juggernaut_omnislash", "juggernaut_omni_slash"],
        ],
    },
    2006 :
    {
        "model" : [8, 13494, 4], //меч
    },
    2067 :
    {
        "model" : [8, 13492, 4], //голова
    },
    2097 :
    {
        "model" : [8, 13495, 18], //тело
    },
    2080 :
    {
        "model" : [8, 13491, 6], //руки
    },
    2120 :
    {
        "model" : [8, 13496, 11], //ноги
    },
    2012 :
    {
        "model" : [8, 14959, 4], //меч
        "styles" : [14959, 0],
    },
    2064 :
    {
        "model" : [8, 14957, 4], //голова
        "styles" : [14957, 0],
    },
    2111 :
    {
        "model" : [8, 14956, 18], //тело
        "styles" : [14956, 0],
    },
    2078 :
    {
        "model" : [8, 14955, 6], //руки
        "styles" : [14955, 0],
    },
    2118 :
    {
        "model" : [8, 14958, 11], //ноги
        "styles" : [14958, 0],
    },
    2052 :
    {
        "model" : [8, 7079, 4], //голова
    },
    2098 :
    {
        "model" : [8, 7077, 18], //тело
    },
    2070 :
    {
        "model" : [8, 7075, 6], //руки
    },
    2132 :
    {
        "model" : [8, 7164, 11], //ноги
    },
    2031 :
    {
        "model" : [8, 8986, 4], //меч
    },
    2049 :
    {
        "model" : [8, 8984, 4], //голова
    },
    2105 :
    {
        "model" : [8, 8983, 18], //тело
    },
    2083 :
    {
        "model" : [8, 8982, 6], //руки
    },
    2121 :
    {
        "model" : [8, 8985, 11], //ноги
    },
    4479 :
    {
        "model" : [8, 13185, 4], //меч
    },
    2040 :
    {
        "model" : [8, 13177, 4], //голова
    },
    2096 :
    {
        "model" : [8, 13178, 18], //тело
    },
    2079 :
    {
        "model" : [8, 13179, 6], //руки
    },
    2133 :
    {
        "model" : [8, 13176, 11], //ноги
    },
    4513 :
    {
        "model" : [8, 23680, 4], //меч
        "styles" : [23680, 1]
    },
    4507 :
    {
        "model" : [8, 23677, 4], //голова
        "styles" : [23677, 1]
    },
    4504 :
    {
        "model" : [8, 23676, 18], //тело
        "styles" : [23676, 1]
    },
    4501 :
    {
        "model" : [8, 23675, 6], //руки
        "styles" : [23675, 1]
    },
    4510 :
    {
        "model" : [8, 23678, 11], //ноги
        "styles" : [23678, 1]
    },
    4514 :
    {
        "model" : [8, 23680, 4], //меч
        "styles" : [23680, 2]
    },
    4508 :
    {
        "model" : [8, 23677, 4], //голова
        "styles" : [23677, 2]
    },
    4505 :
    {
        "model" : [8, 23676, 18], //тело
        "styles" : [23676, 2]
    },
    4502 :
    {
        "model" : [8, 23675, 6], //руки
        "styles" : [23675, 2]
    },
    4511 :
    {
        "model" : [8, 23678, 11], //ноги
        "styles" : [23678, 2]
    },
    4734 :
    {
        "model" : [0, 4734],
    },
    6226 :
    {
        "model" : [0, 6226],
    },
    5133 :
    {
        "model" : [0, 23679, 0, "juggernaut_healing_ward_shop_preview_4"],
        "changed_effects" : 
        [
            ["custom_juggernaut_healing_ward", "juggernaut_healing_ward"],
        ],
        "styles" : [23679, 1]
    },
    7999 :
    {
        "model" : [0, 23679, 0, "juggernaut_healing_ward_shop_preview_4"],
        "changed_effects" : 
        [
            ["custom_juggernaut_healing_ward", "juggernaut_healing_ward"],
        ],
        "styles" : [23679, 2]
    },
    3357 :
    {
        "model" : [44, 9757, 4],
        "changed_icons" : 
        [
            ["custom_phantom_assassin_stifling_dagger", "phantom_assassin/ti8_immortal_helmet/phantom_assassin_stifling_dagger_immortal"],
        ],
        "changed_effects" : 
        [
            ["custom_phantom_assassin_stifling_dagger", "phantom_assassin_stifling_dagger"],
        ],
    },
    3379 :
    {
        "model" : [44, 14948, 5],
        "changed_icons" : 
        [
            ["custom_phantom_assassin_blur", "phantom_assassin/pa_fall20_immortal_ability_icon/pa_fall20_immortal_blur"],
        ],
        "changed_effects" : 
        [
            ["custom_phantom_assassin_blur", "phantom_assassin_blur"],
        ],
    },
    3384 :
    {
        "model" : [44, 22268, 5],
        "changed_icons" : 
        [
            ["custom_phantom_assassin_blur", "phantom_assassin/pa_fall20_immortal_ability_icon/pa_fall20_immortal_blur_crimson"],
        ],
        "changed_effects" : 
        [
            ["custom_phantom_assassin_blur", "phantom_assassin_blur"],
        ],
    },
    4239 :
    {
        "model" : [44, 7247, 8],
        "changed_icons" : 
        [
            ["custom_phantom_assassin_stifling_dagger", "phantom_assassin_arcana_stifling_dagger"],
            ["custom_phantom_assassin_phantom_strike", "phantom_assassin_arcana_phantom_strike"],
            ["custom_phantom_assassin_blur", "phantom_assassin_arcana_blur"],
            ["custom_phantom_assassin_coup_de_grace", "phantom_assassin_arcana_coup_de_grace"],
        ],
        "changed_effects" : 
        [
            ["custom_phantom_assassin_stifling_dagger", "phantom_assassin_stifling_dagger"],
            ["custom_phantom_assassin_phantom_strike", "phantom_assassin_phantom_strike"],
            ["custom_phantom_assassin_blur", "phantom_assassin_blur"],
            ["custom_phantom_assassin_coup_de_grace", "phantom_assassin_coup_de_grace"],
        ],
        "styles" : [7247, 0]
    },
    4560 :
    {
        "styles" : [7247, 1]
    },
    4561 :
    {
        "styles" : [7247, 2]
    },
    4480 :
    {
        "model" : [44, 22723, 66],
        "changed_icons" : 
        [
            ["custom_phantom_assassin_stifling_dagger", "phantom_assassin/persona/phantom_assassin_stifling_dagger_persona1"],
            ["custom_phantom_assassin_phantom_strike", "phantom_assassin/persona/phantom_assassin_phantom_strike_persona1"],
            ["custom_phantom_assassin_blur", "phantom_assassin/persona/phantom_assassin_blur_persona1"],
            ["custom_phantom_assassin_coup_de_grace", "phantom_assassin/persona/phantom_assassin_coup_de_grace_persona2"],
        ],
        "changed_effects" : 
        [
            ["custom_phantom_assassin_stifling_dagger", "phantom_assassin_stifling_dagger"],
            ["custom_phantom_assassin_phantom_strike", "phantom_assassin_phantom_strike"],
            ["custom_phantom_assassin_blur", "phantom_assassin_blur"],
            ["custom_phantom_assassin_coup_de_grace", "phantom_assassin_coup_de_grace"],
        ],
    },
    3367 :
    {
        "model" : [44, 19176, 4],
    },
    3347 :
    {
        "model" : [44, 19177, 8],
    },
    3369 :
    {
        "model" : [44, 19179, 5],
    },
    4243 :
    {
        "model" : [44, 19180, 8],
    },
    4456 :
    {
        "model" : [44, 19178, 8],
    },
    4486 :
    {
        "model" : [44, 5654, 8],
    },
    7575 :
    {
        "model" : [44, 5655, 8],
    },
    4487 :
    {
        "model" : [44, 5656, 5],
    },
    4488 :
    {
        "model" : [44, 5657, 8],
    },
    4248 :
    {
        "model" : [44, 5658, 8],
    },
    4489 :
    {
        "model" : [44, 13480, 8],
    },
    4490 :
    {
        "model" : [44, 13479, 8],
    },
    4491 :
    {
        "model" : [44, 13478, 5],
    },
    4492 :
    {
        "model" : [44, 13477, 8],
    },
    4258 :
    {
        "model" : [44, 13476, 8],
    },
    2404 :
    {
        "model" : [59, 22716, 4],
        "changed_icons" : 
        [
            ["custom_huskar_life_break", "huskar/husk_2022_immortal/husk_2022_immortal_life_break"],
        ],
        "changed_effects" : 
        [
            ["custom_huskar_life_break", "huskar_life_break"],
        ],
    },

    22404 :
    {
        "model" : [59, 24877, 4],
        "changed_icons" : 
        [
            ["custom_huskar_life_break", "huskar/husk_2022_immortal/husk_2022_immortal_life_break_gold"],
        ],
        "changed_effects" : 
        [
            ["custom_huskar_life_break", "huskar_life_break"],
        ],
    },
    4013 :
    {
        "model" : [59, 18616, 4],
        "changed_icons" : 
        [
            ["custom_huskar_burning_spear", "huskar/husk_2021_immortal_weapon_ability_icon/husk_2021_immortal_burning_spear"],
        ],
        "changed_effects" : 
        [
            ["custom_huskar_burning_spear", "huskar_burning_spear"],
        ],
    },
    4019 :
    {
        "model" : [59, 18564, 4],
        "changed_icons" : 
        [
            ["custom_huskar_burning_spear", "huskar/husk_2021_immortal_weapon_ability_icon/husk_2021_immortal_burning_spear_gold"],
        ],
        "changed_effects" : 
        [
            ["custom_huskar_burning_spear", "huskar_burning_spear"],
        ],
    },
    2414 :
    {
        "model" : [59, 8188, 4],
        "changed_icons" : 
        [
            ["custom_huskar_life_break", "huskar_life_break_alt"],
        ],
        "changed_effects" : 
        [
            ["custom_huskar_life_break", "huskar_life_break"],
        ],
    },
    2428 :
    {
        "model" : [59, 9793, 5],
        "changed_icons" : 
        [
            ["custom_huskar_berserkers_blood", "huskar/ti8_immortal_shoulder/huskar_inner_vitality_immortal"],
        ],
        "changed_effects" : 
        [
            ["custom_huskar_berserkers_blood", "huskar_berserkers_blood"],
        ],
    },
    2376 :
    {
        "model" : [59, 14478, 5], // руки
    },
    2389 :
    {
        "model" : [59, 14476, 6], // 2 оружие
    },
    2402 :
    {
        "model" : [59, 14477, 5], // голова
    },
    2429 :
    {
        "model" : [59, 14475, 5], // тело
    },
    4498 :
    {
        "model" : [59, 14474, 4], // оружие
    },
    2385 :
    {
        "model" : [59, 26829, 5], // руки
    },
    2398 :
    {
        "model" : [59, 26831, 6], // 2 оружие
    },
    5872 :
    {
        "model" : [59, 26830, 5], // голова
    },
    2426 :
    {
        "model" : [59, 26832, 5], // тело
    },
    4005 :
    {
        "model" : [59, 26833, 4], // оружие
    },
    2388 :
    {
        "model" : [59, 13322, 5], // руки
    },
    2401 :
    {
        "model" : [59, 13318, 6], // 2 оружие
    },
    2417 :
    {
        "model" : [59, 13321, 5], // голова
    },
    2431 :
    {
        "model" : [59, 13319, 5], // тело
    },
    4018 :
    {
        "model" : [59, 13320, 4], // оружие
    },
    4497 :
    {
        "model" : [59, 23282, 5], // руки
    },
    4496 :
    {
        "model" : [59, 23281, 6], // 2 оружие
    },
    4494 :
    {
        "model" : [59, 22709, 5], // голова
    },
    4495 :
    {
        "model" : [59, 22710, 5], // тело
    },
    4493 :
    {
        "model" : [59, 22708, 4], // оружие
    },
    8001 :
    {
        "model" : [0, 8001],
        "styles" : [8001, 0],
        "changed_effects" : 
        [
            ["skeleton_king_hellfire_blast_custom", "skeleton_king_hellfire_blast"],
        ],
        "changed_icons" : 
        [
            ["skeleton_king_hellfire_blast_custom", "skeleton_king/blistering_shade/skeleton_king_hellfire_blast"],
        ],
    },
    6918 :
    {
        "model" : [0, 6918],
        "styles" : [6918, 0],
        "changed_effects" : 
        [
            ["skeleton_king_hellfire_blast_custom", "skeleton_king_hellfire_blast"],
        ],
        "changed_icons" : 
        [
            ["skeleton_king_hellfire_blast_custom", "skeleton_king/blistering_shade/skeleton_king_hellfire_blast"],
        ],
    },


    905001 :
    {
        "model" : [0, 9050],
        "styles" : [9050, 0],
        "changed_icons" : 
        [
            ["monkey_king_primal_spring_custom", "monkey_king/great_sages_reckoning/monkey_king_spring"],
        ],
        "changed_effects" : 
        [
            ["monkey_king_primal_spring_custom", "monkey_king_primal_spring"],
        ],
    },
    905002 :
    {
        "model" : [0, 9050],
        "styles" : [9050, 1]
    },
    905003 :
    {
        "model" : [0, 9050],
        "styles" : [9050, 2]
    },
    905004 :
    {
        "model" : [0, 9050],
        "styles" : [9050, 3]
    },
    13544 :
    {
        "model" : [0, 13544],
    },
    13545 :
    {
        "model" : [0, 13545],
    },
    4445 :
    {
        "model" : [0, 4445],
        "changed_effects" : 
        [
            ["skeleton_king_mortal_strike_custom", "skeleton_king_mortal_strike"],
        ],
    },
    13546 :
    {
        "model" : [0, 13546],
    },
    13008 :
    {
        "model" : [0, 13008],
        "styles" : [13008, 0],
        "changed_icons" : 
        [
            ["monkey_king_wukongs_command_custom", "monkey_king_wukongs_command_ti9"],
        ],
        "changed_effects" : 
        [
            ["monkey_king_wukongs_command_custom", "monkey_king_wukongs_command"],
        ],
    },
    1300801 :
    {
        "model" : [0, 13008],
        "styles" : [13008, 1],
        "changed_icons" : 
        [
            ["monkey_king_wukongs_command_custom", "monkey_king_wukongs_command_ti9"],
        ],
        "changed_effects" : 
        [
            ["monkey_king_wukongs_command_custom", "monkey_king_wukongs_command"],
        ],
    },
    1300802 :
    {
        "model" : [0, 13008],
        "styles" : [13008, 2],
        "changed_icons" : 
        [
            ["monkey_king_wukongs_command_custom", "monkey_king_wukongs_command_ti9"],
        ],
        "changed_effects" : 
        [
            ["monkey_king_wukongs_command_custom", "monkey_king_wukongs_command"],
        ],
    },
    1300803 :
    {
        "model" : [0, 13008],
        "styles" : [13008, 3],
        "changed_icons" : 
        [
            ["monkey_king_wukongs_command_custom", "monkey_king_wukongs_command_ti9"],
        ],
        "changed_effects" : 
        [
            ["monkey_king_wukongs_command_custom", "monkey_king_wukongs_command"],
        ],
    },
    12693 :
    {
        "model" : [0, 12693],
    },
    12695 :
    {
        "model" : [0, 12695],
    },
    12696 :
    {
        "model" : [0, 12696],
    },
    12694 :
    {
        "model" : [0, 12694],
    },
    25352 :
    {
        "model" : [0, 25352],
    },
    25353 :
    {
        "model" : [0, 25353],
    },
    25371 :
    {
        "model" : [0, 25371],
    },
    25354 :
    {
        "model" : [0, 25354],
    },
    9212 :
    {
        "model" : [0, 9212],
        "changed_icons" : 
        [
            ["monkey_king_boundless_strike_custom", "monkey_king_strike_immortal"],
        ],
        "changed_effects" : 
        [
            ["monkey_king_boundless_strike_custom", "monkey_king_boundless_strike"],
        ],
    },
    9453 :
    {
        "model" : [0, 9453],
        "changed_icons" : 
        [
            ["monkey_king_boundless_strike_custom", "monkey_king_strike_immortal_gold"],
        ],
        "changed_effects" : 
        [
            ["monkey_king_boundless_strike_custom", "monkey_king_boundless_strike"],
        ],
    },
    29347 :
    {
        "model" : [0, 29347],
        "changed_icons" : 
        [
            ["monkey_king_boundless_strike_custom", "monkey_king_strike_anniversary"],
        ],
        "changed_effects" : 
        [
            ["monkey_king_boundless_strike_custom", "monkey_king_boundless_strike"],
        ],
    },
    
    7212 :
    {
        "model" : [0, 7212]
    },
    12322 :
    {
        "model" : [0, 12322],
        "changed_icons" : 
        [
            ["custom_queenofpain_shadow_strike", "queen_of_pain/ti8_immortal_weapon/queenofpain_shadow_strike_immortal"],
        ],
        "changed_effects" : 
        [
            ["custom_queenofpain_shadow_strike", "queenofpain_shadow_strike"],
        ],
    },
    12337 :
    {
        "model" : [0, 12337],
        "changed_icons" : 
        [
            ["custom_queenofpain_shadow_strike", "queen_of_pain/ti8_immortal_weapon/queenofpain_shadow_strike_gold_immortal"],
        ],
        "changed_effects" : 
        [
            ["custom_queenofpain_shadow_strike", "queenofpain_shadow_strike"],
        ],
    },
    23697 :
    {
        "model" : [0, 23697],
        "styles" : [23697, 0],
        "changed_icons" : 
        [
            ["custom_queenofpain_scream_of_pain", "queen_of_pain/qop_2022_immortal/qop_2022_immortal_scream_of_pain_red"],
        ],
        "changed_effects" : 
        [
            ["custom_queenofpain_scream_of_pain", "queenofpain_scream_of_pain"],
        ],
    },
    2369701 :
    {
        "model" : [0, 23697],
        "styles" : [23697, 1],
        "changed_icons" : 
        [
            ["custom_queenofpain_scream_of_pain", "queen_of_pain/qop_2022_immortal/qop_2022_immortal_scream_of_pain_blue"],
        ],
        "changed_effects" : 
        [
            ["custom_queenofpain_scream_of_pain", "queenofpain_scream_of_pain"],
        ],
    },
    5157 :
    {
        "model" : [0, 5157]
    },
    5159 :
    {
        "model" : [0, 5159]
    },
    6839 :
    {
        "model" : [0, 6839]
    },
    5162 :
    {
        "model" : [0, 5162]
    },
    9858 :
    {
        "model" : [0, 9858]
    },
    9859 :
    {
        "model" : [0, 9859]
    },
    9860 :
    {
        "model" : [0, 9860]
    },
    23743 :
    {
        "model" : [0, 23743]
    },
    9863 :
    {
        "model" : [0, 9863]
    },
    7750 :
    {
        "model" : [0, 7750]
    },
    7753 :
    {
        "model" : [0, 7753]
    },
    7754 :
    {
        "model" : [0, 7754]
    },
    7755 :
    {
        "model" : [0, 7755]
    },
    12930 :
    {
        "model" : [0, 12930],
        "styles" : [12930, 0],
        "changed_icons" : 
        [
            ["custom_queenofpain_shadow_strike", "queen_of_pain/arcana/queenofpain_shadow_strike_alt1"],
            ["custom_queenofpain_blink", "queen_of_pain/arcana/queenofpain_blink_alt1"],
            ["custom_queenofpain_scream_of_pain", "queen_of_pain/arcana/queenofpain_scream_of_pain_alt1"],
            ["custom_queenofpain_sonic_wave", "queen_of_pain/arcana/queenofpain_sonic_wave_alt1"],
        ],
        "changed_effects" : 
        [
            ["custom_queenofpain_shadow_strike", "queenofpain_shadow_strike"],
            ["custom_queenofpain_blink", "queenofpain_blink"],
            ["custom_queenofpain_scream_of_pain", "queenofpain_scream_of_pain"],
            ["custom_queenofpain_sonic_wave", "queenofpain_sonic_wave"],
        ],
    },
    1293001 :
    {
        "model" : [0, 12930],
        "styles" : [12930, 1]
    },
    24300 :
    {
        "model" : [0, 24300],
        "changed_icons" : 
        [
            ["skeleton_king_bone_guard_custom", "skeleton_king_bone_guard_frostivus"],
        ],
        "changed_effects" : 
        [
            ["skeleton_king_bone_guard_custom", "skeleton_king_bone_guard"],
        ],
    },
    24229 :
    {
        "model" : [0, 24229],
    },
    24231 :
    {
        "model" : [0, 24231],
    },
    24230 :
    {
        "model" : [0, 24230],
    },
    24282 :
    {
        "model" : [0, 24282],
    },
    24202 :
    {
        "model" : [0, 24202],
    },
    28604 :
    {
        "model" : [0, 28604],
    },
    28631 :
    {
        "model" : [0, 28631],
    },
    28628 :
    {
        "model" : [0, 28628],
    },
    28626 :
    {
        "model" : [0, 28626],
    },
    28629 :
    {
        "model" : [0, 28629],
    },
    28630 :
    {
        "model" : [0, 28630],
    },
    13036 :
    {
        "model" : [0, 13036],
    },
    13037 :
    {
        "model" : [0, 13037],
    },
    13038 :
    {
        "model" : [0, 13038],
    },
    13039 :
    {
        "model" : [0, 13039],
    },
    13040 :
    {
        "model" : [0, 13040],
    },
    13041 :
    {
        "model" : [0, 13041],
    },
    13501 :
    {
        "model" : [0, 13501],
    },
    13497 :
    {
        "model" : [0, 13497],
    },
    13498 :
    {
        "model" : [0, 13498],
    },
    13499 :
    {
        "model" : [0, 13499],
    },
    13500 :
    {
        "model" : [0, 13500],
    },
    13502 :
    {
        "model" : [0, 13502],
    },
    9601 :
    {
        "model" : [0, 9601],
    },
    9602 :
    {
        "model" : [0, 9602],
    },
    9604 :
    {
        "model" : [0, 9604],
    },
    9605 :
    {
        "model" : [0, 9605],
    },
    9606 :
    {
        "model" : [0, 9606],
    },
    9603 :
    {
        "model" : [0, 9603],
    },
    12424 :
    {
        "model" : [0, 12424],
        "changed_icons" : 
        [
            ["skeleton_king_mortal_strike_custom", "skeleton_king/ti8_immortal_weapon/skeleton_king_mortal_strike_immortal_crimson"],
        ],
        "changed_effects" : 
        [
            ["skeleton_king_bone_guard_custom", "skeleton_king_bone_guard"],
            ["skeleton_king_mortal_strike_custom", "skeleton_king_mortal_strike"],
        ],
    },
    9747 :
    {
        "model" : [0, 9747],
        "changed_icons" : 
        [
            ["skeleton_king_mortal_strike_custom", "skeleton_king/ti8_immortal_weapon/skeleton_king_mortal_strike_immortal"],
        ],
        "changed_effects" : 
        [
            ["skeleton_king_bone_guard_custom", "skeleton_king_bone_guard"],
            ["skeleton_king_mortal_strike_custom", "skeleton_king_mortal_strike"],
        ],
    },
    7211 :
    {
        "model" : [0, 7211],
        "changed_effects" : 
        [
            ["skeleton_king_mortal_strike_custom", "skeleton_king_mortal_strike"],
        ],
    },
    13456 :
    {
        "model" : [0, 21402],
        "styles" : [21402, 0],
        "changed_icons" : 
        [
            ["skeleton_king_hellfire_blast_custom", "skeleton_king/arcana/skeleton_king_hellfire_blast_arcana"],
            ["skeleton_king_bone_guard_custom", "skeleton_king/arcana/skeleton_king_bone_guard_arcana"],
            ["skeleton_king_mortal_strike_custom", "skeleton_king/arcana/skeleton_king_mortal_strike_arcana"],
            ["skeleton_king_reincarnation_custom", "skeleton_king/arcana/skeleton_king_reincarnation_arcana"],
        ],
        "changed_effects" : 
        [
            ["skeleton_king_hellfire_blast_custom", "skeleton_king_hellfire_blast"],
            ["skeleton_king_bone_guard_custom", "skeleton_king_bone_guard"],
            ["skeleton_king_mortal_strike_custom", "skeleton_king_mortal_strike"],
            ["skeleton_king_reincarnation_custom", "skeleton_king_reincarnation"],
        ],
    },
    1345601 :
    {
        "model" : [0, 21402],
        "styles" : [21402, 1],
        "changed_icons" : 
        [
            ["skeleton_king_hellfire_blast_custom", "skeleton_king/arcana/skeleton_king_hellfire_blast_arcana"],
            ["skeleton_king_bone_guard_custom", "skeleton_king/arcana/skeleton_king_bone_guard_arcana"],
            ["skeleton_king_mortal_strike_custom", "skeleton_king/arcana/skeleton_king_mortal_strike_arcana"],
            ["skeleton_king_reincarnation_custom", "skeleton_king/arcana/skeleton_king_reincarnation_arcana"],
        ],
        "changed_effects" : 
        [
            ["skeleton_king_hellfire_blast_custom", "skeleton_king_hellfire_blast"],
            ["skeleton_king_bone_guard_custom", "skeleton_king_bone_guard"],
            ["skeleton_king_mortal_strike_custom", "skeleton_king_mortal_strike"],
            ["skeleton_king_reincarnation_custom", "skeleton_king_reincarnation"],
        ],
    },


5810 :
{
    "changed_icons" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["custom_legion_commander_duel", "legion_commander_duel_alt1"],
    ],
    "changed_effects" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["custom_legion_commander_duel", "legion_commander_duel"],
    ],
	"model" : [0, 5810],
},
7930 :
{
    "changed_icons" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["custom_legion_commander_press_the_attack", "legion_commander/legacy_of_the_fallen_legion/legion_commander_press_the_attack"],
    ],
    "changed_effects" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["custom_legion_commander_press_the_attack", "legion_commander_press_the_attack"],
    ],
	"model" : [0, 7930],
    "styles" : [7930, 0]
},
7931 :
{
	"model" : [0, 7930],
    "styles" : [7930, 1]
},
9236 :
{
    "changed_icons" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["custom_legion_commander_overwhelming_odds", "legion_commander/immortal/legion_commander_overwhelming_odds"],
    ],
    "changed_effects" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["custom_legion_commander_overwhelming_odds", "legion_commander_overwhelming_odds"],
    ],
	"model" : [0, 9236],
},
25758 :
{
	"model" : [0, 25758],
},
25759 :
{
	"model" : [0, 25759],
},
25761 :
{
	"model" : [0, 25761],
},
25762 :
{
	"model" : [0, 25762],
},
25763 :
{
	"model" : [0, 25763],
},
29256 :
{
	"model" : [0, 29256],
},
29257 :
{
	"model" : [0, 29257],
},
29255 :
{
	"model" : [0, 29255],
},
29254 :
{
	"model" : [0, 29254],
},
29253 :
{
	"model" : [0, 29253],
},
29252 :
{
	"model" : [0, 29252],
},
13985 :
{
	"model" : [0, 13985],
},
13984 :
{
	"model" : [0, 13984],
},
13986 :
{
	"model" : [0, 13986],
},
13987 :
{
	"model" : [0, 13987],
},
13988 :
{
	"model" : [0, 13988],
},
13989 :
{
	"model" : [0, 13989],
},
13048 :
{
	"model" : [0, 13048],
},
13051 :
{
	"model" : [0, 13051],
},
13053 :
{
	"model" : [0, 13053],
},
13054 :
{
	"model" : [0, 13054],
},
13052 :
{
	"model" : [0, 13052],
},
13050 :
{
	"model" : [0, 13050],
},
8821 :
{
	"model" : [0, 8821],
},
8822 :
{
	"model" : [0, 8822],
},
8823 :
{
	"model" : [0, 8823],
},
8824 :
{
	"model" : [0, 8824],
},
8820 :
{
	"model" : [0, 8820],
},
6996 :
{
    "changed_icons" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["custom_nevermore_shadowraze_close", "nevermore_shadowraze1_demon"],
        ["custom_nevermore_necromastery", "nevermore_necromastery_demon"],
        ["custom_nevermore_dark_lord", "nevermore_dark_lord_demon"],
        ["custom_nevermore_requiem", "nevermore_requiem_demon"],
    ],
    "changed_effects" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["custom_nevermore_shadowraze_close", "nevermore_shadowraze1"],
        ["custom_nevermore_necromastery", "nevermore_necromastery"],
        ["custom_nevermore_requiem", "nevermore_requiem"],
    ],
	"model" : [0, 6996],
},
8259 :
{
	"model" : [0, 8259],
},
9021 :
{
	"model" : [0, 9021],
    "styles" : [9021, 0]
},
9019 :
{
	"model" : [0, 9019],
    "styles" : [9019, 0]
},
9020 :
{
	"model" : [0, 9020],
    "styles" : [9020, 0]
},
13505 :
{
	"model" : [0, 13505],
},
13506 :
{
	"model" : [0, 13506],
},
13507 :
{
	"model" : [0, 13507],
},
12677 :
{
	"model" : [0, 12677],
},
12678 :
{
	"model" : [0, 12678],
},
12679 :
{
	"model" : [0, 12679],
},
22845 :
{
	"model" : [0, 22845],
	"styles" : [22845, 1]
},
22844 :
{
	"model" : [0, 22844],
	"styles" : [22844, 1]
},
22843 :
{
	"model" : [0, 22843],
	"styles" : [22843, 1]
},
23096 :
{
    "model" : [0, 23096]
},
23098 :
{
    "model" : [0, 23098]
},
23099 :
{
    "model" : [0, 23099]
},
23095 :
{
    "changed_icons" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["razor_plasma_field_custom", "razor/arcana/razor_plasma_field_alt1"],
        ["razor_static_link_custom", "razor/arcana/razor_static_link_alt1"],
        ["razor_unstable_current_custom", "razor/arcana/razor_unstable_current_alt1"],
        ["razor_eye_of_the_storm_custom", "razor/arcana/razor_eye_of_the_storm_alt1"],
    ],
    "changed_effects" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["razor_plasma_field_custom", "razor_plasma_field"],
        ["razor_static_link_custom", "razor_static_link"],
        ["razor_unstable_current_custom", "razor_unstable_current"],
        ["razor_eye_of_the_storm_custom", "razor_eye_of_the_storm"],
    ],
    "model" : [0, 23100],
    "styles" : [23100, 0]
},
2309599 :
{
    "changed_icons" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["razor_plasma_field_custom", "razor/arcana/razor_plasma_field_alt1"],
        ["razor_static_link_custom", "razor/arcana/razor_static_link_alt1"],
        ["razor_unstable_current_custom", "razor/arcana/razor_unstable_current_alt1"],
        ["razor_eye_of_the_storm_custom", "razor/arcana/razor_eye_of_the_storm_alt1"],
    ],
    "changed_effects" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["razor_plasma_field_custom", "razor_plasma_field"],
        ["razor_static_link_custom", "razor_static_link"],
        ["razor_unstable_current_custom", "razor_unstable_current"],
        ["razor_eye_of_the_storm_custom", "razor_eye_of_the_storm"],
    ],
    "model" : [0, 23100],
    "styles" : [23100, 1]
},
23097 :
{
    "model" : [0, 23097]
},
6646 :
{
    "changed_icons" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["razor_static_link", "razor_static_link_alt"],
    ],
    "changed_effects" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["razor_static_link_custom", "razor_static_link"],
    ],
    "model" : [0, 6646]
},
6916 :
{
    "changed_icons" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["razor_static_link", "razor_static_link_alt_gold"],
    ],
    "changed_effects" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["razor_static_link_custom", "razor_static_link"],
    ],
    "model" : [0, 6916]
},
8000 :
{
    "changed_icons" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["razor_plasma_field", "razor/severing_lash/razor_plasma_field"],
    ],
    "changed_effects" : 
    [
        // НАЗВАНИЕ АБИЛКИ В ИГРЕ -- путь(если есть) + НАЗВАНИЕ ИКОНКИ В ФАЙЛАХ ДОТЫ   ( file://{images}/spellicons/huskar_life_break.png  вот так строится путь )
        ["razor_plasma_field_custom", "razor_plasma_field"],
    ],
    "model" : [0, 8000]
},
14812 :
{
    "model" : [0, 14812]
},
14813 :
{
    "model" : [0, 14813]
},
14814 :
{
    "model" : [0, 14814]
},
14759 :
{
    "model" : [0, 14759]
},
14815 :
{
    "model" : [0, 14815]
},
19500 :
{
    "model" : [0, 19500]
},
19501 :
{
    "model" : [0, 19501]
},
19502 :
{
    "model" : [0, 19502]
},
19503 :
{
    "model" : [0, 19503]
},
19505 :
{
    "model" : [0, 19505]
},
18130 :
{
    "model" : [0, 18130]
},
18131 :
{
    "model" : [0, 18131]
},
18132 :
{
    "model" : [0, 18132]
},
18133 :
{
    "model" : [0, 18133]
},
18227 :
{
    "model" : [0, 18227]
},




18034 :
{
    "model" : [0, 18034]
},
18035 :
{
    "model" : [0, 18035]
},
18036 :
{
    "model" : [0, 18036]
},



9780 :
{
    "model" : [0, 9780],
    "styles" : [9780, 0]
},
9781 :
{
    "model" : [0, 9781],
    "styles" : [9781, 0]
},
9782 :
{
    "model" : [0, 9782],
    "styles" : [9782, 0]
},
9783 :
{
    "model" : [0, 9783],
    "styles" : [9783, 0]
},
9784 :
{
    "model" : [0, 9784],
    "styles" : [9784, 0]
},
9785 :
{
    "model" : [0, 9785],
    "styles" : [9785, 0]
},

978099 :
{
    "model" : [0, 9780],
    "styles" : [9780, 1]
},
978199 :
{
    "model" : [0, 9781],
    "styles" : [9781, 1]
},
978299 :
{
    "model" : [0, 9782],
    "styles" : [9782, 1]
},
978399 :
{
    "model" : [0, 9783],
    "styles" : [9783, 1]
},
978499 :
{
    "model" : [0, 9784],
    "styles" : [9784, 1]
},
978599 :
{
    "model" : [0, 9785],
    "styles" : [9785, 1]
},
9780999 :
{
    "model" : [0, 18589],
    "styles" : [18589, 0]
},
9781999 :
{
    "model" : [0, 18590],
    "styles" : [18590, 0]
},
9782999 :
{
    "model" : [0, 18591],
    "styles" : [18591, 0]
},
9783999 :
{
    "model" : [0, 18592],
    "styles" : [18592, 0]
},
9784999 :
{
    "model" : [0, 18593],
    "styles" : [18593, 0]
},
9785999 :
{
    "model" : [0, 18594],
    "styles" : [18594, 0]
},

// Zeus
9052 :
{
    "model" : [0, 9052],
    "styles" : [9052, 1],
},
90521 :
{
    "model" : [0, 9052],
    "styles" : [9052, 0],
},
9037 :
{
    "model" : [0, 9037],
    "styles" : [9037, 1],
},
90371 :
{
    "model" : [0, 9037],
    "styles" : [9037, 0],
},
9038 :
{
    "model" : [0, 9038],
    "styles" : [9038, 1],
},
90381 :
{
    "model" : [0, 9038],
    "styles" : [9038, 0],
},
9039 :
{
    "model" : [0, 9039],
    "styles" : [9039, 1],
},
90391 :
{
    "model" : [0, 9039],
    "styles" : [9039, 0],
},
7954 :
{
    "model" : [0, 7954],
    "styles" : [7954, 0],
},
7953 :
{
    "model" : [0, 7953],
    "styles" : [7953, 0],
},
7952 :
{
    "model" : [0, 7952],
    "styles" : [7952, 0],
},
7951 :
{
    "model" : [0, 7951],
    "styles" : [7951, 0],
},
5412 :
{
    "model" : [0, 5412],
    "styles" : [5412, 0],
    "changed_icons" : 
    [
        ["zuus_lightning_bolt", "zuus_lightning_bolt_immortal"],
    ],
    "changed_effects" : 
    [
        ["zuus_lightning_bolt_custom", "zuus_lightning_bolt"],
    ],
},
12323 :
{
    "model" : [0, 12323],
    "styles" : [12323, 0],
    "changed_icons" : 
    [
        ["zuus_arc_lightning", "zeus/ti8_immortal_arms/zeus_arc_lightning_immortal"],
    ],
    "changed_effects" : 
    [
        ["zuus_arc_lightning_custom", "zuus_arc_lightning"],
    ],
},
24680 :
{
    "model" : [0, 24680],
    "styles" : [24680, 0],
    //"changed_icons" : 
    //[
    //    ["zuus_static_field", "zeus/zeus_2021_immortal_back_ability_icon/zeus_2021_immortal_static_field_crimson"],
    //],
    "changed_effects" : 
    [
        ["zuus_heavenly_jump_custom", "zuus_heavenly_jump"],
    ],
},
19112 :
{
    "model" : [0, 19112],
    "styles" : [19112, 0],
    //"changed_icons" : 
    //[
    //    ["zuus_static_field", "zeus/zeus_2021_immortal_back_ability_icon/zeus_2021_immortal_static_field"],
    //],
    "changed_effects" : 
    [
        ["zuus_heavenly_jump_custom", "zuus_heavenly_jump"],
    ],
},
18563 :
{
    "model" : [0, 18563],
    "styles" : [18563, 0],
    //"changed_icons" : 
    //[
    //    ["zuus_static_field", "zeus/zeus_2021_immortal_back_ability_icon/zeus_2021_immortal_static_field_gold"],
    //],
    "changed_effects" : 
    [
        ["zuus_heavenly_jump_custom", "zuus_heavenly_jump"],
    ],
},
6914 :
{
    "model" : [0, 6914],
    "styles" : [6914, 0],
    "changed_icons" : 
    [
        ["zuus_thundergods_wrath", "zuus_thundergods_wrath_alt1"],
        //["zuus_static_field", "zuus_static_field_alt1"],
    ],
    "changed_effects" : 
    [
        ["zuus_thundergods_wrath_custom", "zuus_thundergods_wrath"],
    ],
},
// Lina
12217 :
{
	"model" : [0, 12217],
    "styles" : [12217, 0],
},
122171 :
{
	"model" : [0, 12217],
    "styles" : [12217, 1],
},
12228 :
{
	"model" : [0, 12228],
    "styles" : [12228, 0],
},
122281 :
{
	"model" : [0, 12228],
    "styles" : [12228, 1],
},
12229 :
{
	"model" : [0, 12229],
    "styles" : [12229, 0],
},
122291 :
{
	"model" : [0, 12229],
    "styles" : [12229, 1],
},
12227 :
{
	"model" : [0, 12227],
    "styles" : [12227, 0],
},
122271 :
{
	"model" : [0, 12227],
    "styles" : [12227, 1],
},
14247 :
{
	"model" : [0, 14247],
    "styles" : [14247, 0],
},
14248 :
{
	"model" : [0, 14248],
    "styles" : [14248, 0],
},
14250 :
{
	"model" : [0, 14250],
    "styles" : [14250, 0],
},
14251 :
{
	"model" : [0, 14251],
    "styles" : [14251, 0],
},
27551 :
{
	"model" : [0, 27551],
    "styles" : [27551, 0],
},
27550 :
{
	"model" : [0, 27550],
    "styles" : [27550, 0],
},
27548 :
{
	"model" : [0, 27548],
    "styles" : [27548, 0],
},
27564 :
{
	"model" : [0, 27564],
    "styles" : [27564, 0],
},
8003 :
{
	"model" : [0, 8003],
    "styles" : [8003, 0],
    "changed_icons" : 
    [
        ["lina_laguna_blade", "lina/lina_ti6_immortal/lina_laguna_blade"],
    ],
    "changed_effects" : 
    [
        ["lina_laguna_blade_custom", "lina_laguna_blade"],
    ],
},
7741 :
{
	"model" : [0, 7741],
    "styles" : [7741, 0],
    "changed_icons" : 
    [
        ["lina_light_strike_array", "lina/lina_ti7_immortal/lina_lightstrike_array_gold"],
    ],
    "changed_effects" : 
    [
        ["lina_light_strike_array_custom", "lina_light_strike_array"],
    ],
},
9243 :
{
	"model" : [0, 9243],
    "styles" : [9243, 0],
    "changed_icons" : 
    [
        ["lina_light_strike_array", "lina/lina_ti7_immortal/lina_light_strike_array"],
    ],
    "changed_effects" : 
    [
        ["lina_light_strike_array_custom", "lina_light_strike_array"],
    ],
},
4794 :
{
	"model" : [0, 4794],
    "styles" : [4794, 0],
    "changed_icons" : 
    [
        ["lina_dragon_slave", "lina_dragon_slave_alt1"],
        ["lina_fiery_soul", "lina_fiery_soul_alt1"],
    ],
    "changed_effects" : 
    [
        ["lina_dragon_slave_custom", "lina_dragon_slave"],
    ],
},
// Pudge

13510 :
{
    "model" : [0, 13510],
    "styles" : [13510, 0],
},
13511 :
{
    "model" : [0, 13511],
    "styles" : [13511, 0],
},
13513 :
{
    "model" : [0, 13513],
    "styles" : [13513, 0],
},
13515 :
{
    "model" : [0, 13515],
    "styles" : [13515, 0],
},
13514 :
{
    "model" : [0, 13514],
    "styles" : [13514, 0],
},
6007 :
{
    "model" : [0, 6007],
    "styles" : [6007, 0],
},
6204 :
{
    "model" : [0, 6204],
    "styles" : [6204, 0],
},
6202 :
{
    "model" : [0, 6202],
    "styles" : [6202, 0],
},
6203 :
{
    "model" : [0, 6203],
    "styles" : [6203, 0],
},
6212 :
{
    "model" : [0, 6212],
    "styles" : [6212, 0],
},
6116 :
{
    "model" : [0, 6116],
    "styles" : [6116, 0],
},
6115 :
{
    "model" : [0, 6115],
    "styles" : [6115, 0],
},
26083 :
{
    "model" : [0, 26083],
    "styles" : [26083, 0],
},
26087 :
{
    "model" : [0, 26087],
    "styles" : [26087, 0],
},
26086 :
{
    "model" : [0, 26086],
    "styles" : [26086, 0],
},
26085 :
{
    "model" : [0, 26085],
    "styles" : [26085, 0],
},
26084 :
{
    "model" : [0, 26084],
    "styles" : [26084, 0],
},
26082 :
{
    "model" : [0, 26082],
    "styles" : [26082, 0],
},
7311 :
{
    "model" : [0, 7311],
    "styles" : [7311, 0],
},
7945 :
{
    "model" : [0, 7945],
    "styles" : [7945, 0],
},
7371 :
{
    "model" : [0, 7371],
    "styles" : [7371, 0],
},
7376 :
{
    "model" : [0, 7376],
    "styles" : [7376, 0],
},
7320 :
{
    "model" : [0, 7320],
    "styles" : [7320, 0],
},
7362 :
{
    "model" : [0, 7362],
    "styles" : [7362, 0],
},
7363 :
{
    "model" : [0, 7363],
    "styles" : [7363, 0],
},
14033 :
{
    "model" : [0, 14033],
    "styles" : [14033, 0],
},
14034 :
{
    "model" : [0, 14034],
    "styles" : [14034, 0],
},
14035 :
{
    "model" : [0, 14035],
    "styles" : [14035, 0],
},
14036 :
{
    "model" : [0, 14036],
    "styles" : [14036, 0],
},
14038 :
{
    "model" : [0, 14038],
    "styles" : [14038, 0],
},
14039 :
{
    "model" : [0, 14039],
    "styles" : [14039, 0],
},
14037 :
{
    "model" : [0, 14037],
    "styles" : [14037, 0],
},
5347 :
{
    "model" : [0, 5347],
    "styles" : [5347, 0],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
4007 :
{
    "model" : [0, 4007],
    "styles" : [4007, 0],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
8004 :
{
    "model" : [0, 8004],
    "styles" : [8004, 0],
    "changed_icons" : 
    [
        ["pudge_meat_hook", "pudge/immortal/pudge_meat_hook"],
    ],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
8038 :
{
    "model" : [0, 8038],
    "styles" : [8038, 0],
    "changed_icons" : 
    [
        ["pudge_meat_hook", "pudge/immortal_gold/pudge_meat_hook"],
    ],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
8010 :
{
    "model" : [0, 8010],
    "styles" : [8010, 0],
    "changed_icons" : 
    [
        ["pudge_meat_hook", "pudge/immortal_gold/pudge_meat_hook"],
    ],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
13788 :
{
    "model" : [0, 13788],
    "styles" : [13788, 0],
    "changed_icons" : 
    [
        ["pudge_meat_hook", "pudge/ti_10_pudge_immortal_hook/pudge_meat_hook_immortal"],
    ],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
137881 :
{
    "model" : [0, 13788],
    "styles" : [13788, 1],
    "changed_icons" : 
    [
        ["pudge_meat_hook", "pudge/ti_10_pudge_immortal_hook/pudge_meat_hook_immortal_alt"],
    ],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
6458 :
{
    "model" : [0, 6458],
    "styles" : [6458, 0],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
9231 :
{
    "model" : [0, 9231],
    "styles" : [9231, 0],
    "changed_icons" : 
    [
        ["pudge_rot", "pudge/ti7_pudge_immortal/pudge_rot_alt"],
    ],
    "changed_effects" : 
    [
        ["pudge_rot_custom", "pudge_rot"],
    ],
},
999251 :
{
    "model" : [0, 13786],
    "styles" : [13786, 0],
    "changed_icons" : 
    [
        ["pudge_meat_hook", "pudge/persona_toy_butcher/pudge_meat_hook_persona1"],
        ["pudge_rot", "pudge/persona_toy_butcher/pudge_rot_persona1"],
        ["pudge_flesh_heap", "pudge/persona_toy_butcher/pudge_flesh_heap_persona1"],
        ["pudge_dismember", "pudge/persona_toy_butcher/pudge_dismember_persona1"],
    ],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
999252 :
{
    "model" : [0, 27558],
    "styles" : [27558, 0],
    "changed_icons" : 
    [
        ["pudge_meat_hook", "pudge/persona_toy_butcher_calavera/pudge_meat_hook_persona_calavera1"],
        ["pudge_rot", "pudge/persona_toy_butcher/pudge_rot_persona1"],
        ["pudge_flesh_heap", "pudge/persona_toy_butcher/pudge_flesh_heap_persona1"],
        ["pudge_dismember", "pudge/persona_toy_butcher/pudge_dismember_persona1"],
    ],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
999253 :
{
    "model" : [0, 30361],
    "styles" : [30361, 0],
    "changed_icons" : 
    [
        ["pudge_meat_hook", "pudge/persona_frostivus/pudge_meat_hook_persona_frostivus1"],
        ["pudge_rot", "pudge/persona_toy_butcher/pudge_rot_persona1"],
        ["pudge_flesh_heap", "pudge/persona_toy_butcher/pudge_flesh_heap_persona1"],
        ["pudge_dismember", "pudge/persona_toy_butcher/pudge_dismember_persona1"],
    ],
    "changed_effects" : 
    [
        ["pudge_meat_hook_custom", "pudge_meat_hook"],
    ],
},
7742 :
{
    "model" : [0, 7742],
    "styles" : [7742, 0],
    "changed_icons" : 
    [
        ["pudge_rot", "pudge/ti7_pudge_immortal/pudge_rot_alt2"],
    ],
    "changed_effects" : 
    [
        ["pudge_rot_custom", "pudge_rot"],
    ],
},  
7756 :
{
    "model" : [0, 7756],
    "styles" : [7756, 0],
    "changed_icons" : 
    [
        ["pudge_meat_hook", "pudge/arcana/pudge_meat_hook_arcana"],
        ["pudge_rot", "pudge/arcana/pudge_rot_arcana"],
        ["pudge_flesh_heap", "pudge/arcana/pudge_flesh_heap_arcana"],
        ["pudge_dismember", "pudge/arcana/pudge_dismember_arcana"],
    ],
    "changed_effects" : 
    [
        ["pudge_dismember_custom", "pudge_dismember"],
    ],
},
77561 :
{
    "model" : [0, 7756],
    "styles" : [7756, 1],
    "changed_icons" : 
    [
        ["pudge_meat_hook", "pudge/arcana/pudge_meat_hook_arcana_style1"],
        ["pudge_rot", "pudge/arcana/pudge_rot_arcana_style1"],
        ["pudge_flesh_heap", "pudge/arcana/pudge_flesh_heap_arcana_style1"],
        ["pudge_dismember", "pudge/arcana/pudge_dismember_arcana_style1"],
    ],
    "changed_effects" : 
    [
        ["pudge_dismember_custom", "pudge_dismember"],
    ],
},
13508 :
{
    "model" : [0, 13508],
    "styles" : [13508, 0],
},
13509 :
{
    "model" : [0, 13509],
    "styles" : [13509, 0],
},

28170 : 
{ 
    "model" : [0, 28170], 
    "styles" : [28170, 0] 
},

28171 : 
{ 
    "model" : [0, 28171], 
    "styles" : [28171, 0] 
},

28172 : 
{ 
    "model" : [0, 28172], 
    "styles" : [28172, 0] 
},

28238 : 
{ 
    "model" : [0, 28238], 
    "styles" : [28238, 0] 
},

28239 : 
{ 
    "model" : [0, 28239], 
    "styles" : [28239, 0] 
},

281701 :
{
    "model" : [0, 28170],
    "styles" : [28170, 1]
},

281711 :
{
    "model" : [0, 28171],
    "styles" : [28171, 1]
},

281721 :
{
    "model" : [0, 28172],
    "styles" : [28172, 1]
},

282381 :
{
    "model" : [0, 28238],
    "styles" : [28238, 1]
},

282391 :
{
    "model" : [0, 28239],
    "styles" : [28239, 1]
},

19309 :
{
    "model" : [0, 19309],
    "styles" : [19309, 0],
},
19310 :
{
    "model" : [0, 19310],
    "styles" : [19310, 0],
},
19311 :
{
    "model" : [0, 19311],
    "styles" : [19311, 0],
},
17868 :
{
    "model" : [0, 17868],
    "styles" : [17868, 0],
},
17869 :
{
    "model" : [0, 17869],
    "styles" : [17869, 0],
},
17870 :
{
    "model" : [0, 17870],
    "styles" : [17870, 0],
},
17871 :
{
    "model" : [0, 17871],
    "styles" : [17871, 0],
},
27133 :
{
    "model" : [0, 27133],
    "styles" : [27133, 0],
},
30363 :
{
    "model" : [0, 30363],
    "styles" : [30363, 0],
},
30280 :
{
    "model" : [0, 30280],
    "styles" : [30280, 0],
},
27131 :
{
    "model" : [0, 27131],
    "styles" : [27131, 0],
},
29302 :
{
    "model" : [0, 29302],
    "styles" : [29302, 0],
},
29303 :
{
    "model" : [0, 29303],
    "styles" : [29303, 0],
},
29304 :
{
    "model" : [0, 29304],
    "styles" : [29304, 0],
},
271331 :
{
    "model" : [0, 27133],
    "styles" : [27133, 1],
},
303631 :
{
    "model" : [0, 30363],
    "styles" : [30363, 1],
},
302801 :
{
    "model" : [0, 30280],
    "styles" : [30280, 1],
},
271311 :
{
    "model" : [0, 27131],
    "styles" : [27131, 1],
},
293021 :
{
    "model" : [0, 29302],
    "styles" : [29302, 1],
},
293031 :
{
    "model" : [0, 29303],
    "styles" : [29303, 1],
},
293041 :
{
    "model" : [0, 29304],
    "styles" : [29304, 1],
},
13338 :
{
    "model" : [0, 13338],
    "styles" : [13338, 0],
},
13339 :
{
    "model" : [0, 13339],
    "styles" : [13339, 0],
},
13377 :
{
    "model" : [0, 13377],
    "styles" : [13377, 0],
},
13378 :
{
    "model" : [0, 13378],
    "styles" : [13378, 0],
},
13379 :
{
    "model" : [0, 13379],
    "styles" : [13379, 0],
},
13380 :
{
    "model" : [0, 13380],
    "styles" : [13380, 0],
},
13337 :
{
    "model" : [0, 13337],
    "styles" : [13337, 0],
},
7053 :
{
    "model" : [0, 7053],
    "styles" : [7053, 0],
},
7055 :
{
    "model" : [0, 7055],
    "styles" : [7055, 0],
},
7057 :
{
    "model" : [0, 7057],
    "styles" : [7057, 0],
},
7058 :
{
    "model" : [0, 7058],
    "styles" : [7058, 0],
},
7052 :
{
    "model" : [0, 7052],
    "styles" : [7052, 0],
},
7056 :
{
    "model" : [0, 7056],
    "styles" : [7056, 0],
},
7054 :
{
    "model" : [0, 7054],
    "styles" : [7054, 0],
    "changed_icons" : 
    [
        ["drow_ranger_frost_arrows_custom", "drow_ranger/dragons_touch_ability_icons/drow_ranger_frost_arrows"],
        ["drow_ranger_wave_of_silence_custom", "drow_ranger/dragons_touch_ability_icons/drow_ranger_wave_of_silence"],
        ["drow_ranger_multishot_custom", "drow_ranger/dragons_touch_ability_icons/drow_ranger_trueshot"],
        ["drow_ranger_marksmanship_custom", "drow_ranger/dragons_touch_ability_icons/drow_ranger_marksmanship"],
    ],
},
13010 :
{
    "model" : [0, 13010],
    "styles" : [13010, 0],
},
13011 :
{
    "model" : [0, 13011],
    "styles" : [13011, 0],
},
13001 :
{
    "model" : [0, 13001],
    "styles" : [13001, 0],
},
13002 :
{
    "model" : [0, 13002],
    "styles" : [13002, 0],
},
13004 :
{
    "model" : [0, 13004],
    "styles" : [13004, 0],
},
13005 :
{
    "model" : [0, 13005],
    "styles" : [13005, 0],
},
13006 :
{
    "model" : [0, 13006],
    "styles" : [13006, 0],
},
12946 :
{
    "model" : [0, 12946],
    "styles" : [12946, 0],
    "changed_icons" : 
    [
        ["drow_ranger_marksmanship_custom", "drow_ranger_marksmanship_ti9"],
    ],
    "changed_effects" : 
    [
        ["drow_ranger_frost_arrows_custom", "drow_ranger_frost_arrows"],
        ["drow_ranger_marksmanship_custom", "drow_ranger_marksmanship"],
    ],
},
5386 :
{
    "model" : [0, 5386],
    "styles" : [5386, 0],
    "changed_effects" : 
    [
        ["drow_ranger_frost_arrows_custom", "drow_ranger_frost_arrows"],
    ],
},
8006 :
{
    "model" : [0, 8006],
    "styles" : [8006, 0],
    "changed_icons" : 
    [
        ["drow_ranger_wave_of_silence_custom", "drow_ranger/immortal/drow_ranger_wave_of_silence"],
    ],
    "changed_effects" : 
    [
        ["drow_ranger_wave_of_silence_custom", "drow_ranger_wave_of_silence"],
    ],
},
8035 :
{
    "model" : [0, 8035],
    "styles" : [8035, 0],
    "changed_icons" : 
    [
        ["drow_ranger_wave_of_silence_custom", "drow_ranger/immortal/drow_ranger_wave_of_silence"],
    ],
    "changed_effects" : 
    [
        ["drow_ranger_wave_of_silence_custom", "drow_ranger_wave_of_silence"],
    ],
},
8037 :
{
    "model" : [0, 8037],
    "styles" : [8037, 0],
    "changed_icons" : 
    [
        ["drow_ranger_wave_of_silence_custom", "drow_ranger/immortal_gold/drow_ranger_wave_of_silence"],
    ],
    "changed_effects" : 
    [
        ["drow_ranger_wave_of_silence_custom", "drow_ranger_wave_of_silence"],
    ],
},
6785 :
{
    "model" : [0, 6785],
    "styles" : [6785, 0],
},
19091 :
{
    "model" : [0, 19091],
    "styles" : [19091, 0],
},
19092 :
{
    "model" : [0, 19092],
    "styles" : [19092, 0],
},
19093 :
{
    "model" : [0, 19093],
    "styles" : [19093, 0],
},
19094 :
{
    "model" : [0, 19094],
    "styles" : [19094, 0],
},
19088 :
{
    "model" : [0, 19088],
    "styles" : [19088, 0],
},
19089 :
{
    "model" : [0, 19089],
    "styles" : [19089, 0],
},
190911 :
{
    "model" : [0, 19091],
    "styles" : [19091, 1],
},
190921 :
{
    "model" : [0, 19092],
    "styles" : [19092, 1],
},
190931 :
{
    "model" : [0, 19093],
    "styles" : [19093, 1],
},
190941 :
{
    "model" : [0, 19094],
    "styles" : [19094, 1],
},
190881 :
{
    "model" : [0, 19088],
    "styles" : [19088, 1],
},
190891 :
{
    "model" : [0, 19089],
    "styles" : [19089, 1],
},
19090 :
{
    "model" : [0, 21837],
    "styles" : [21837, 0],
    "changed_icons" : 
    [
        ["drow_ranger_frost_arrows_custom", "drow_ranger_frost_arrow_arcana"],
        ["drow_ranger_wave_of_silence_custom", "drow_ranger_silence_arcana"],
        ["drow_ranger_multishot_custom", "drow_ranger_multishot_arcana"],
        ["drow_ranger_marksmanship_custom", "drow_ranger_marksmanship_arcana"],
    ],
    "changed_effects" : 
    [
        ["drow_ranger_frost_arrows_custom", "drow_ranger_frost_arrows"],
        ["drow_ranger_wave_of_silence_custom", "drow_ranger_wave_of_silence"],
        ["drow_ranger_multishot_custom", "drow_ranger_multishot"],
        ["drow_ranger_marksmanship_custom", "drow_ranger_marksmanship"],
    ],
},
190901 :
{
    "model" : [0, 21837],
    "styles" : [21837, 1],
    "changed_icons" : 
    [
        ["drow_ranger_frost_arrows_custom", "drow_ranger_frost_arrow_arcana_alt1"],
        ["drow_ranger_wave_of_silence_custom", "drow_ranger_silence_arcana_alt1"],
        ["drow_ranger_multishot_custom", "drow_ranger_multishot_arcana_alt1"],
        ["drow_ranger_marksmanship_custom", "drow_ranger_marksmanship_arcana_alt1"],
    ],
    "changed_effects" : 
    [
        ["drow_ranger_frost_arrows_custom", "drow_ranger_frost_arrows"],
        ["drow_ranger_wave_of_silence_custom", "drow_ranger_wave_of_silence"],
        ["drow_ranger_multishot_custom", "drow_ranger_multishot"],
        ["drow_ranger_marksmanship_custom", "drow_ranger_marksmanship"],
    ],
},


13670 :
{
    "model" : [0, 13670],
    "styles" : [13670, 0],
    "changed_icons" : 
    [
        ["ogre_magi_fireblast", "ogre_magi/arcana/ogre_magi_fireblast_arcana"],
        ["ogre_magi_ignite", "ogre_magi/arcana/ogre_magi_ignite_arcana"],
        ["ogre_magi_bloodlust", "ogre_magi/arcana/ogre_magi_bloodlust_arcana"],
        ["ogre_magi_multicast", "ogre_magi/arcana/ogre_magi_multicast_arcana"],
    ],
    "changed_effects" : 
    [
        ["ogre_magi_fireblast_custom", "ogre_magi_fireblast"],
        ["ogre_magi_ignite_custom", "ogre_magi_ignite"],
    ],
},
136701 :
{
    "model" : [0, 13670],
    "styles" : [13670, 1],
    "changed_icons" : 
    [
        ["ogre_magi_fireblast", "ogre_magi/arcana/ogre_magi_fireblast_arcana_alt1"],
        ["ogre_magi_ignite", "ogre_magi/arcana/ogre_magi_ignite_arcana_alt1"],
        ["ogre_magi_bloodlust", "ogre_magi/arcana/ogre_magi_bloodlust_arcana_alt2"],
        ["ogre_magi_multicast", "ogre_magi/arcana/ogre_magi_multicast_arcana_alt1"],
    ],
    "changed_effects" : 
    [
        ["ogre_magi_fireblast_custom", "ogre_magi_fireblast"],
        ["ogre_magi_ignite_custom", "ogre_magi_ignite"],
    ],
},
12318 :
{
    "model" : [0, 12318],
    "styles" : [12318, 0],
    "changed_icons" : 
    [
        ["ogre_magi_bloodlust", "ogre_magi_bloodlust_ti8"],
    ],
    "changed_effects" : 
    [
        ["ogre_magi_bloodlust_custom", "ogre_magi_bloodlust"],
    ],
},
7910 :
{
    "model" : [0, 7910],
    "styles" : [7910, 0],
    "changed_icons" : 
    [
        ["ogre_magi_multicast", "ogre_magi/auspice_of_the_whyrlegyge/ogre_magi_multicast"],
    ],
    "changed_effects" : 
    [
        ["ogre_magi_multicast_custom", "ogre_magi_multicast"],
    ],
},
79101 :
{
    "model" : [0, 7910],
    "styles" : [7910, 1],
    "changed_icons" : 
    [
        ["ogre_magi_multicast", "ogre_magi/auspice_of_the_whyrlegyge/ogre_magi_multicast"],
    ],
    "changed_effects" : 
    [
        ["ogre_magi_multicast_custom", "ogre_magi_multicast"],
    ],
},
9226 :
{
    "model" : [0, 9226],
    "styles" : [9226, 0],
},
92261 :
{
    "model" : [0, 9226],
    "styles" : [9226, 1],
},
9229 :
{
    "model" : [0, 9229],
    "styles" : [9229, 0],
},
92291 :
{
    "model" : [0, 9229],
    "styles" : [9229, 1],
},
9227 :
{
    "model" : [0, 9227],
    "styles" : [9227, 0],
},
92271 :
{
    "model" : [0, 9227],
    "styles" : [9227, 1],
},
9224 :
{
    "model" : [0, 9224],
    "styles" : [9224, 0],
},
92241 :
{
    "model" : [0, 9224],
    "styles" : [9224, 1],
},
9225 :
{
    "model" : [0, 9225],
    "styles" : [9225, 0],
},
92251 :
{
    "model" : [0, 9225],
    "styles" : [9225, 1],
},
18098 :
{
    "model" : [0, 18098],
    "styles" : [18098, 0],
},
18099 :
{
    "model" : [0, 18099],
    "styles" : [18099, 0],
},
18100 :
{
    "model" : [0, 18100],
    "styles" : [18100, 0],
},
18101 :
{
    "model" : [0, 18101],
    "styles" : [18101, 0],
},
18097 :
{
    "model" : [0, 18097],
    "styles" : [18097, 0],
},
19370 :
{
    "model" : [0, 19370],
    "styles" : [19370, 0],
},
19372 :
{
    "model" : [0, 19372],
    "styles" : [19372, 0],
},
19373 :
{
    "model" : [0, 19373],
    "styles" : [19373, 0],
},
19374 :
{
    "model" : [0, 19374],
    "styles" : [19374, 0],
},
19371 :
{
    "model" : [0, 19371],
    "styles" : [19371, 0],
},
5957 :
{
    "model" : [0, 5957],
    "styles" : [5957, 0],
    "changed_icons" : 
    [
        ["custom_terrorblade_reflection", "terrorblade_reflection_alt1"],
        ["custom_terrorblade_conjure_image", "terrorblade_conjure_image_alt1"],
        ["custom_terrorblade_metamorphosis", "terrorblade_metamorphosis_alt1"],
        ["custom_terrorblade_sunder", "terrorblade_sunder_alt1"],
    ],
    "changed_effects" : 
    [
        ["custom_terrorblade_reflection", "terrorblade_reflection"],
        ["custom_terrorblade_conjure_image", "terrorblade_conjure_image"],
        ["custom_terrorblade_metamorphosis", "terrorblade_metamorphosis"],
        ["custom_terrorblade_sunder", "terrorblade_sunder"],
    ],
},
12917 :
{
    "model" : [0, 12917],
    "styles" : [12917, 0],
},
9750 :
{
    "model" : [0, 9750],
    "styles" : [9750, 0],
    "changed_icons" : 
    [
        ["custom_terrorblade_sunder", "terrorblade/ti8_immortal_back/terrorblade_sunder_immortal"],
    ],
    "changed_effects" : 
    [
        ["custom_terrorblade_sunder", "terrorblade_sunder"],
    ],
},
9497 : 
{
    "model" : [0, 9497],
    "styles" : [9497, 0],
},
9498 : 
{
    "model" : [0, 9498],
    "styles" : [9498, 0],
},
9499 : 
{
    "model" : [0, 9499],
    "styles" : [9499, 0],
},
9500 : 
{
    "model" : [0, 9500],
    "styles" : [9500, 0],
},
14338 : 
{
    "model" : [0, 14338],
    "styles" : [14338, 0],
},
14340 : 
{
    "model" : [0, 14340],
    "styles" : [14340, 0],
},
14341 : 
{
    "model" : [0, 14341],
    "styles" : [14341, 0],
},
14342 : 
{
    "model" : [0, 14342],
    "styles" : [14342, 0],
},
26447 : 
{
    "model" : [0, 26447],
    "styles" : [26447, 0],
},
26448 : 
{
    "model" : [0, 26448],
    "styles" : [26448, 0],
},
26449 : 
{
    "model" : [0, 26449],
    "styles" : [26449, 0],
},
26445 : 
{
    "model" : [0, 26445],
    "styles" : [26445, 0],
},
7404 :
{
    "model" : [0, 7404],
    "styles" : [7404, 0],
    "changed_effects" : 
    [
        ["custom_terrorblade_metamorphosis", "terrorblade_metamorphosis"],
    ],
},
9501 :
{
    "model" : [0, 9501],
    "styles" : [9501, 0],
    "changed_effects" : 
    [
        ["custom_terrorblade_metamorphosis", "terrorblade_metamorphosis"],
    ],
},
14339 :
{
    "model" : [0, 14339],
    "styles" : [14339, 0],
    "changed_effects" : 
    [
        ["custom_terrorblade_metamorphosis", "terrorblade_metamorphosis"],
    ],
},
7033 :
{
    "model" : [0, 7033],
    "styles" : [7033, 0],
    "changed_effects" : 
    [
        ["custom_terrorblade_metamorphosis", "terrorblade_metamorphosis"],
    ],
},
8276 :
{
    "model" : [0, 8276],
    "styles" : [8276, 0],
    "changed_effects" : 
    [
        ["custom_terrorblade_metamorphosis", "terrorblade_metamorphosis"],
    ],
},
26446 :
{
    "model" : [0, 26446],
    "styles" : [26446, 0],
    "changed_effects" : 
    [
        ["custom_terrorblade_metamorphosis", "terrorblade_metamorphosis"],
    ],
},
7385 :
{
    "model" : [0, 7385],
    "styles" : [7385, 0],
    "changed_icons" : 
    [
        ["crystal_maiden_freezing_field_custom", "crystal_maiden_freezing_field_alt1"],
    ],
    "changed_effects" : 
    [
        ["crystal_maiden_freezing_field_custom", "crystal_maiden_freezing_field"],
    ],
},
9205 :
{
    "model" : [0, 9205],
    "styles" : [9205, 0],
    "changed_icons" : 
    [
        ["crystal_maiden_frostbite_custom", "crystal_maiden_frostbite_immortal"],
    ],
    "changed_effects" : 
    [
        ["crystal_maiden_frostbite_custom", "crystal_maiden_frostbite"],
    ],
},
6686 :
{
    "model" : [0, 6686],
    "styles" : [6686, 0],
    "changed_icons" : 
    [
        ["crystal_maiden_crystal_nova_custom", "crystal_maiden_crystal_nova_icecowl"],
    ],
    "changed_effects" : 
    [
        ["crystal_maiden_crystal_nova_custom", "crystal_maiden_crystal_nova"],
    ],
},
13532 :
{
    "model" : [0, 13532],
    "styles" : [13532, 0],
    "changed_icons" : 
    [
        ["crystal_maiden_arcane_aura_custom", "crystal_maiden_brilliance_aura_ti9"],
    ],
    "changed_effects" : 
    [
        ["crystal_maiden_arcane_aura_custom", "crystal_maiden_brilliance_aura"],
    ],
},
13669 :
{
    "model" : [0, 13669],
    "styles" : [13669, 0],
    "changed_icons" : 
    [
        ["crystal_maiden_arcane_aura_custom", "crystal_maiden_brilliance_aura_ti9_gold"],
    ],
    "changed_effects" : 
    [
        ["crystal_maiden_arcane_aura_custom", "crystal_maiden_brilliance_aura"],
    ],
},
6784 :
{
    "model" : [0, 6784],
    "styles" : [6784, 0],
},
9626 :
{
    "model" : [0, 9626],
    "styles" : [9626, 0],
},
9625 :
{
    "model" : [0, 9625],
    "styles" : [9625, 0],
},
9624 :
{
    "model" : [0, 9624],
    "styles" : [9624, 0],
},
9628 :
{
    "model" : [0, 9628],
    "styles" : [9628, 0],
},
9627 :
{
    "model" : [0, 9627],
    "styles" : [9627, 0],
},
13486 :
{
    "model" : [0, 13486],
    "styles" : [13486, 0],
},
13487 :
{
    "model" : [0, 13487],
    "styles" : [13487, 0],
},
13488 :
{
    "model" : [0, 13488],
    "styles" : [13488, 0],
},
13489 :
{
    "model" : [0, 13489],
    "styles" : [13489, 0],
},
13490 :
{
    "model" : [0, 13490],
    "styles" : [13490, 0],
},
14558 :
{
    "model" : [0, 14558],
    "styles" : [14558, 0],
},
145581 :
{
    "model" : [0, 14558],
    "styles" : [14558, 1],
},
145582 :
{
    "model" : [0, 14558],
    "styles" : [14558, 2],
},
14559 :
{
    "model" : [0, 14559],
    "styles" : [14559, 0],
},
145591 :
{
    "model" : [0, 14559],
    "styles" : [14559, 1],
},
145592 :
{
    "model" : [0, 14559],
    "styles" : [14559, 2],
},
14560 :
{
    "model" : [0, 14560],
    "styles" : [14560, 0],
},
145601 :
{
    "model" : [0, 14560],
    "styles" : [14560, 1],
},
145602 :
{
    "model" : [0, 14560],
    "styles" : [14560, 2],
},
14561 :
{
    "model" : [0, 14561],
    "styles" : [14561, 0],
},
145611 :
{
    "model" : [0, 14561],
    "styles" : [14561, 1],
},
145612 :
{
    "model" : [0, 14561],
    "styles" : [14561, 2],
},
14562 :
{
    "model" : [0, 14562],
    "styles" : [14562, 0],
},
145621 :
{
    "model" : [0, 14562],
    "styles" : [14562, 1],
},
145622 :
{
    "model" : [0, 14562],
    "styles" : [14562, 2],
},
26559 :
{
    "model" : [0, 26559],
    "styles" : [26559, 0],
    "changed_icons" : 
    [
        ["crystal_maiden_crystal_nova_custom", "crystal_maiden_crystal_nova_persona"],
        ["crystal_maiden_frostbite_custom", "crystal_maiden_frostbite_persona"],
        ["crystal_maiden_arcane_aura_custom", "crystal_maiden_brilliance_aura_persona"],
        ["crystal_maiden_freezing_field_custom", "crystal_maiden_freezing_field_persona"],
    ],
    "changed_effects" : 
    [
        ["crystal_maiden_crystal_nova_custom", "crystal_maiden_crystal_nova"],
        ["crystal_maiden_freezing_field_custom", "crystal_maiden_freezing_field"],
    ],
},
265591 :
{
    "model" : [0, 24884],
    "styles" : [24884, 0],
    "changed_icons" : 
    [
        ["crystal_maiden_crystal_nova_custom", "crystal_maiden_crystal_nova_persona"],
        ["crystal_maiden_frostbite_custom", "crystal_maiden_frostbite_persona"],
        ["crystal_maiden_arcane_aura_custom", "crystal_maiden_brilliance_aura_persona"],
        ["crystal_maiden_freezing_field_custom", "crystal_maiden_freezing_field_persona"],
    ],
    "changed_effects" : 
    [
        ["crystal_maiden_crystal_nova_custom", "crystal_maiden_crystal_nova"],
        ["crystal_maiden_freezing_field_custom", "crystal_maiden_freezing_field"],
    ],
},
265592 :
{
    "model" : [0, 28140],
    "styles" : [28140, 0],
    "changed_icons" : 
    [
        ["crystal_maiden_crystal_nova_custom", "crystal_maiden_crystal_nova_persona"],
        ["crystal_maiden_frostbite_custom", "crystal_maiden_frostbite_persona"],
        ["crystal_maiden_arcane_aura_custom", "crystal_maiden_brilliance_aura_persona"],
        ["crystal_maiden_freezing_field_custom", "crystal_maiden_freezing_field_persona"],
    ],
    "changed_effects" : 
    [
        ["crystal_maiden_crystal_nova_custom", "crystal_maiden_crystal_nova"],
        ["crystal_maiden_freezing_field_custom", "crystal_maiden_freezing_field"],
    ],
},


}


function UpdatePlayerShopTable(table, key, data ) 
{
	if (table == "sub_data") 
	{
		if (key == Players.GetLocalPlayer()) 
        {
            player_table_shop = CustomNetTables.GetTableValue("sub_data", String(Players.GetLocalPlayer()));
		}
	}
}

function init()
{
    var info_button = $.GetContextPanel().FindChildTraverse("info_button")
    var report_button = $.GetContextPanel().FindChildTraverse("report_button")
    var shop_button = $.GetContextPanel().FindChildTraverse("shop_button")

    var info_window = $.GetContextPanel().FindChildTraverse("window_info")
    var window_reports = $.GetContextPanel().FindChildTraverse("window_reports")
    var window_shop = $.GetContextPanel().FindChildTraverse("window_shop")

    GameEvents.Subscribe_custom('give_bonus_shards', give_bonus_shards)

    GameEvents.Subscribe_custom('show_active_vote', show_active_vote)
    GameEvents.Subscribe_custom('show_new_shop_heroes', show_new_shop_heroes)

    GameEvents.Subscribe_custom('shop_new_promo', shop_new_promo)

    GameEvents.Subscribe_custom('get_payment_url', get_payment_url)

    GameEvents.Subscribe_custom('answer_promo_code', answer_promo_code)

    GameEvents.Subscribe_custom('shop_global_sale', shop_global_sale)


    let data = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()));

    let lang = $.Localize("#lang")

    if ((data && data.total_games && data.total_games >= max_games) || lang == "rus")
    {
       shop_button.style.opacity = "1";
    }else 
    {
       shop_button.style.opacity = "0";
    }


    GameEvents.Subscribe_custom('change_show_level_lua', change_show_level_lua)

    info_button.SetPanelEvent("onactivate", function() 
    {	
        Info_window_show()
    });

    report_button.SetPanelEvent("onactivate", function() 
    {	
        Reports_window_show()
    });

    shop_button.SetPanelEvent("onactivate", function() 
    {	
        GameUI.CustomUIConfig().OpenShop()
    });



    var text = $.Localize("#info_button")

    info_button.SetPanelEvent('onmouseover', function() 
    {
            $.DispatchEvent('DOTAShowTextTooltip', info_button, text) 
    });
        
    info_button.SetPanelEvent('onmouseout', function() 
    {
       $.DispatchEvent('DOTAHideTextTooltip', info_button);
    });

    var text2 = $.Localize("#report_button")

    report_button.SetPanelEvent('onmouseover', function() 
    {
            $.DispatchEvent('DOTAShowTextTooltip', report_button, text2) 
    });
        
    report_button.SetPanelEvent('onmouseout', function() 
    {
       $.DispatchEvent('DOTAHideTextTooltip', report_button);
    });


    var currency_info = $.GetContextPanel().FindChildTraverse("CurrencyInfo")
    if (currency_info) 
    {

        let text = $.Localize("#shop_shards_info")
        currency_info.SetPanelEvent('onmouseover', function() 
        {
                $.DispatchEvent('DOTAShowTextTooltip', currency_info, text) 
        });
                
        currency_info.SetPanelEvent('onmouseout', function() 
        {
               $.DispatchEvent('DOTAHideTextTooltip', currency_info);
        });
    }


    var show_level_button = $.GetContextPanel().FindChildTraverse("heroes_show_button")
    



    if (show_level_button)
    {


        let text = $.Localize("#shop_show_level_info")

        show_level_button.SetPanelEvent('onmouseover', function() 
        {
                $.DispatchEvent('DOTAShowTextTooltip', show_level_button, text) 
        });
                
        show_level_button.SetPanelEvent('onmouseout', function() 
        {
               $.DispatchEvent('DOTAHideTextTooltip', show_level_button);
        });


        show_level_button.SetPanelEvent('onactivate', function() 
        {
                Game.EmitSound("UI.Click")

                GameEvents.SendCustomGameEventToServer_custom( "change_show_tier", {});
        });
                
    }	

    // Check Items
    var heroes_buy_button = $.GetContextPanel().FindChildTraverse("heroes_buy_button")
    if (heroes_buy_button)
    {
        let text = $.Localize("#info_bought")
        heroes_buy_button.SetPanelEvent('onmouseover', function() 
        {
                $.DispatchEvent('DOTAShowTextTooltip', heroes_buy_button, text) 
        });    
        heroes_buy_button.SetPanelEvent('onmouseout', function() 
        {
               $.DispatchEvent('DOTAHideTextTooltip', heroes_buy_button);
        });

        heroes_buy_button.SetPanelEvent('onactivate', function() 
        {
                Game.EmitSound("UI.Click")
                if (PLAYER_VIEW_ITEMS_FOR_BUY)
            {
                PLAYER_VIEW_ITEMS_FOR_BUY = false
                heroes_buy_button.RemoveClass("buy_items_show_button_off")
                heroes_buy_button.AddClass("buy_items_show_button_on")
            }
            else
            {
                PLAYER_VIEW_ITEMS_FOR_BUY = true
                heroes_buy_button.RemoveClass("buy_items_show_button_on")
                heroes_buy_button.AddClass("buy_items_show_button_off")
            }
            let ItemsList = $.GetContextPanel().FindChildTraverse("ItemsList")
            if (ItemsList)
            {
                ItemsList.style.visibility = "visible"
            }
            InitShopItemsForHero(ItemsList)
            UpdateOnlyCouriers()
            InitItems()
        });  
    }

    CheckShards()
}


function NotActive(panel)
{

	if (panel)
	{

		let text = $.Localize("#NotActive")

		panel.SetPanelEvent('onmouseover', function() 
		{
		   	 $.DispatchEvent('DOTAShowTextTooltip', panel, text) 
		});
		    
		panel.SetPanelEvent('onmouseout', function() 
		{
		   $.DispatchEvent('DOTAHideTextTooltip', panel);
		});
	}

}




function get_payment_url(kv)
{

	$.DispatchEvent("ExternalBrowserGoToURL", kv.url);
}




function change_show_level_lua(kv)
{

	var sub_data = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer());
	let active_sub = $.GetContextPanel().FindChildTraverse("InfoHeaderLabel_active_sub")
	let button_text = $.GetContextPanel().FindChildTraverse("ButtonBuySubscribeLabel")

	if (sub_data)
	{


		if (sub_data.subscribed == 1)
		{

			let time = sub_data.sub_time

			let days = Math.floor((time/3600)/24)
			let display = String(days) + $.Localize("#pass_active_sub_days")

			if (days < 1)
			{
				display = String(Math.max(0, Math.floor(((time/3600)/24 - days)*24))) + $.Localize("#pass_active_sub_hours")
			}


			active_sub.text = $.Localize("#pass_active_sub") + ' ' + display

			button_text.text = $.Localize("#pass_header_top_button_active")
		}
		else 
		{
			active_sub.text = ''
			button_text.text = $.Localize("#pass_header_top_button")
		}


		let hide_tier = sub_data.hide_tier


		var show_level_button = $.GetContextPanel().FindChildTraverse("heroes_show_button")

		if (hide_tier == 1)
		{
			show_level_button.AddClass("heroes_show_button_1")
			show_level_button.RemoveClass("heroes_show_button_0")

		}else 
		{
			show_level_button.AddClass("heroes_show_button_0")
			show_level_button.RemoveClass("heroes_show_button_1")
		}

	}else
	{
		active_sub.text = ''
		button_text.text = $.Localize("#pass_header_top_button")
	}


}


function shop_new_promo(kv)
{

    let data = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()));

    let lang = $.Localize("#lang")

    if (lang != "rus")
    {
        return
    }

    if (data && data.total_games && data.total_games >= max_games)
    {
    }else 
    {
       return
    }

    let main = $.GetContextPanel().FindChildTraverse("new_promo_alert")

    let icon = $.GetContextPanel().FindChildTraverse("new_promo_alert_icon")
    let body = $.GetContextPanel().FindChildTraverse("new_promo_alert_body")
    let arrow = $.GetContextPanel().FindChildTraverse("new_promo_alert_arrow")

    let text_top = $.GetContextPanel().FindChildTraverse("new_promo_alert_top_text")
    let text_bot = $.GetContextPanel().FindChildTraverse("new_promo_alert_bot_text")

    if (icon)
    {
        icon.style.opacity = 1
    }

    body.AddClass("new_promo_alert_body_blue")
    arrow.AddClass("new_promo_alert_arrow_blue")

    text_top.text = $.Localize("#new_promo_alert")
    text_bot.text = $.Localize("#new_promo_alert_reward")

    main.RemoveClass("new_promo_alert_hidden")
    main.AddClass("new_promo_alert")

    $.Schedule(12, function ()
    {
        main.AddClass("new_promo_alert_hidden")
        main.RemoveClass("new_promo_alert")

    })
}



function shop_global_sale(kv)
{

    let data = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()));

    let lang = $.Localize("#lang")

    if ((data && data.total_games && data.total_games >= max_games) || lang == "rus")
    {
    }else 
    {
       return
    }

    let main = $.GetContextPanel().FindChildTraverse("new_promo_alert")
    let icon = $.GetContextPanel().FindChildTraverse("new_promo_alert_icon")
    let body = $.GetContextPanel().FindChildTraverse("new_promo_alert_body")
    let arrow = $.GetContextPanel().FindChildTraverse("new_promo_alert_arrow")

    let text_top = $.GetContextPanel().FindChildTraverse("new_promo_alert_top_text")
    let text_bot = $.GetContextPanel().FindChildTraverse("new_promo_alert_bot_text")

    active_sale_global = 1

    if (icon)
    {
        icon.style.opacity = 0
    }

    body.AddClass("new_promo_alert_body_orange")
    arrow.AddClass("new_promo_alert_arrow_orange")

    text_top.text = $.Localize("#global_sale_top")
    text_bot.text = $.Localize("#global_sale_bot")

    main.RemoveClass("new_promo_alert_hidden")
    main.AddClass("new_promo_alert")

    $.Schedule(12, function ()
    {
        main.AddClass("new_promo_alert_hidden")
        main.RemoveClass("new_promo_alert")

    })
}





function show_new_shop_heroes(kv)
{


    let data = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()));

    let lang = $.Localize("#lang")

    if ((data && data.total_games && data.total_games >= max_games) || lang == "rus")
    {
    }else 
    {
       return
    }

    let main = $.GetContextPanel().FindChildTraverse("active_vote_show")

    main.RemoveClass("active_vote_show_hidden")
    main.AddClass("active_vote_show")

    let text = $.GetContextPanel().FindChildTraverse("active_vote_top_text")
    text.text = $.Localize("#active_new_shop_heroes")

    let sale = $.GetContextPanel().FindChildTraverse("active_vote_sale") 


    if (kv.sale == 1)
    {
        sale.AddClass("active_vote_sale_visible")
        active_sale = 1
        active_sale_heroes = kv.heroes
    }


    for (var i = 1; i <= Object.keys(kv.heroes).length; i++) 
    {
        var icon = $.GetContextPanel().FindChildTraverse("active_vote_icon_" + String(i))
        icon.style.backgroundImage = "url('file://{images}/heroes/icons/" + String(kv.heroes[i]) + ".png')"
        icon.style.backgroundSize = "contain"
        icon.style.backgroundRepeat = 'no-repeat'

    }


    $.Schedule(12, function ()
    {
        main.AddClass("active_vote_show_hidden")
        main.RemoveClass("active_vote_show")

    })

}






function show_active_vote()
{

    let data = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()));

    $.Msg('vote!')

    let lang = $.Localize("#lang")

    if ((data && data.total_games && data.total_games >= max_games) || lang == "rus")
    {
    }else 
    {
       return
    }

	let main = $.GetContextPanel().FindChildTraverse("active_vote_show")

	main.RemoveClass("active_vote_show_hidden")
	main.AddClass("active_vote_show")

	var heroes_to_vote = CustomNetTables.GetTableValue("sub_data", "heroes_vote").vote_table;

	for (var i = 1; i <= Object.keys(heroes_to_vote).length; i++) 
	{
		var icon = $.GetContextPanel().FindChildTraverse("active_vote_icon_" + String(i))
		icon.style.backgroundImage = "url('file://{images}/heroes/icons/" + String(heroes_to_vote[i][1]) + ".png')"
		icon.style.backgroundSize = "contain"
		icon.style.backgroundRepeat = 'no-repeat'
	}

	$.Schedule(12, function ()
	{
		main.AddClass("active_vote_show_hidden")
		main.RemoveClass("active_vote_show")


		$.Schedule(0.5, function ()
		{

		})
	})

}








GameUI.CustomUIConfig().OpenShop = function Shop_window_show()
{
	if (cd == false)
	{
		

		Game.EmitSound("UI.Shop_Open")

		cd = true
		
		UpdateShards()


		var button_shard = $.GetContextPanel().FindChildTraverse("BuyCurrencyButton")
		var button_shard_bot = $.GetContextPanel().FindChildTraverse("ButtonBuySubscribe_bot")
		var button_sub = $.GetContextPanel().FindChildTraverse("ButtonBuySubscribe")



        let data = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()));

        let lang = $.Localize("#lang")

        if ((data && data.total_games && data.total_games >= max_games) || lang == "rus")
		{
			button_shard.RemoveClass("BuyCurrencyButton_not")
			button_shard.AddClass("BuyCurrencyButton")

			button_sub.RemoveClass("ButtonBuySubscribe_not")
			button_sub.AddClass("ButtonBuySubscribe")

			button_shard_bot.RemoveClass("ButtonBuySubscribe_bot_not")
			button_shard_bot.AddClass("ButtonBuySubscribe_bot")
		}else
		{

			button_shard.AddClass("BuyCurrencyButton_not")
			button_shard.RemoveClass("BuyCurrencyButton")

			button_sub.AddClass("ButtonBuySubscribe_not")
			button_sub.RemoveClass("ButtonBuySubscribe")

			button_shard_bot.AddClass("ButtonBuySubscribe_bot_not")
			button_shard_bot.RemoveClass("ButtonBuySubscribe_bot")

			//NotActive(button_sub)
			//NotActive(button_shard_bot)

		//	NotActive(button_shard)
		}


		var active_vote = CustomNetTables.GetTableValue("sub_data", "heroes_vote").active_vote;




		var info_button = $.GetContextPanel().FindChildTraverse("info_button")
		var report_button = $.GetContextPanel().FindChildTraverse("report_button")
		var shop_button = $.GetContextPanel().FindChildTraverse("shop_button")

		var info_window = $.GetContextPanel().FindChildTraverse("window_info")
		var window_reports = $.GetContextPanel().FindChildTraverse("window_reports")
		var window_shop = $.GetContextPanel().FindChildTraverse("window_shop")

		info_button.style.backgroundImage = "url('file://{images}/custom_game/profile.png')"
		report_button.style.backgroundImage = "url('file://{images}/custom_game/report.png')"

		var close_button = $.GetContextPanel().FindChildTraverse("close_button_report")
		var close_text = $.GetContextPanel().FindChildTraverse("close_text_report")
		close_text.text = $.Localize("#close_text")


		if (info_window.BHasClass("info_window_show"))
		{
			info_window.RemoveClass("info_window_show")
			info_window.AddClass("info_window_hidden")

			info_button.SetPanelEvent("onactivate", function() 
			{	
				Info_window_show()
			});
		}

		if (window_reports.BHasClass("reports_window_show"))
		{
			window_reports.RemoveClass("reports_window_show")
			window_reports.AddClass("reports_window_hidden")

			report_button.SetPanelEvent("onactivate", function() 
			{	
				Reports_window_show()
			});
		}

		window_shop.RemoveClass("shop_window_hidden")
		window_shop.AddClass("shop_window_show")

		shop_button.SetPanelEvent("onactivate", function() 
		{	
			Shop_window_hide()
		});


		init_shop()

		$.Schedule(0.5, function ()
		{
			cd = false

		})


	}
}

function Shop_window_hide()
{
	if (cd == false)
	{
		cd = true
		Game.EmitSound("UI.Shop_Close")


		var info_button = $.GetContextPanel().FindChildTraverse("info_button")
		var report_button = $.GetContextPanel().FindChildTraverse("report_button")
		var shop_button = $.GetContextPanel().FindChildTraverse("shop_button")

		var info_window = $.GetContextPanel().FindChildTraverse("window_info")
		var window_reports = $.GetContextPanel().FindChildTraverse("window_reports")
		var shop_window = $.GetContextPanel().FindChildTraverse("window_shop")


		shop_window.RemoveClass("shop_window_show")
		shop_window.AddClass("shop_window_hidden")

		CloseActiveChatBlock()

		shop_button.SetPanelEvent("onactivate", function() 
		{	
			GameUI.CustomUIConfig().OpenShop()
		});

		$.Schedule(0.5, function ()
		{
			cd = false
		})
	}
}






function init_shop()
{
	var shop_buttons = []

	shop_buttons[1] = $.GetContextPanel().FindChildTraverse("inshop_button_sub")
	var sub_text = $.GetContextPanel().FindChildTraverse("inshop_button_text_sub")
	sub_text.html = true
 

	shop_buttons[2] = $.GetContextPanel().FindChildTraverse("inshop_button_heroes")
	var heroes_text = $.GetContextPanel().FindChildTraverse("inshop_button_text_heroes")
	heroes_text.html = true

	shop_buttons[3] = $.GetContextPanel().FindChildTraverse("inshop_button_items")
	let shop_buttons_top = $.GetContextPanel().FindChildTraverse("shop_header_button_shop")
	//let inventory_buttons_top = $.GetContextPanel().FindChildTraverse("inventory_header_button_shop")
 
	var items_text = $.GetContextPanel().FindChildTraverse("inshop_button_text_items")
	items_text.html = true

	shop_buttons[4] = $.GetContextPanel().FindChildTraverse("inshop_button_chat")
	var chat_text = $.GetContextPanel().FindChildTraverse("inshop_button_text_chat")
	chat_text.html = true

	//shop_buttons[5] = $.GetContextPanel().FindChildTraverse("shop_header_button_inventory")
	let invenory_buttons_top = $.GetContextPanel().FindChildTraverse("shop_header_button_invenory")

	//var chat_text = $.GetContextPanel().FindChildTraverse("inshop_button_text_inventory")
	//chat_text.html = true

	shop_buttons[6] = $.GetContextPanel().FindChildTraverse("inshop_button_vote")
	var chat_text = $.GetContextPanel().FindChildTraverse("inshop_button_text_vote")

	shop_buttons[6].SetPanelEvent("onactivate", function() 
	{	
		Game.EmitSound("UI.Click")
		GameUI.CustomUIConfig().OpenShopPlus("shop_window_" + 6, shop_buttons[6].id)
		CloseActiveChatBlock()
		InitVote()
	});

	shop_buttons[1].SetPanelEvent("onactivate", function() 
	{	
		Game.EmitSound("UI.Shop_Main_Button")
		GameUI.CustomUIConfig().OpenShopPlus("shop_window_" + 1, shop_buttons[1].id)
		CloseActiveChatBlock()
	});
	shop_buttons[2].SetPanelEvent("onactivate", function() 
	{	
		Game.EmitSound("UI.Shop_Main_Button")
		InitHeroes()
		GameUI.CustomUIConfig().OpenShopPlus("shop_window_" + 2, shop_buttons[2].id)
		CloseActiveChatBlock()
	});

	shop_buttons[3].SetPanelEvent("onactivate", function() 
	{	
		Game.EmitSound("UI.Shop_Main_Button")
		InitItems()

        InitSale()

		GameUI.CustomUIConfig().OpenShopPlus("shop_window_" + 3, shop_buttons[3].id)
		CloseActiveChatBlock()
	});


	//shop_buttons_top.SetPanelEvent("onactivate", function() 
	//{	
	//	Game.EmitSound("UI.Shop_Main_Button")
	//	InitItems()
	//	GameUI.CustomUIConfig().OpenShopPlus("shop_window_" + 3, shop_buttons[3].id)
	//	CloseActiveChatBlock()
	//});

	//$.GetContextPanel().FindChildTraverse("inventory_header_button_shop").SetPanelEvent("onactivate", function() 
	//{	
	//	Game.EmitSound("UI.Shop_Main_Button")
	//	InitItems()
	//	GameUI.CustomUIConfig().OpenShopPlus("shop_window_" + 3, shop_buttons[3].id)
	//	CloseActiveChatBlock()
	//});




	shop_buttons[4].SetPanelEvent("onactivate", function() 
	{	
		Game.EmitSound("UI.Shop_Main_Button")
		InitSounds()
		GameUI.CustomUIConfig().OpenShopPlus("shop_window_" + 4, shop_buttons[4].id)
		CloseActiveChatBlock()
	});	



	//shop_buttons[5].SetPanelEvent("onactivate", function() 
	//{	
	//	Game.EmitSound("UI.Shop_Main_Button")
	//	InitInventory()
	//	GameUI.CustomUIConfig().OpenShopPlus("shop_window_" + 5, shop_buttons[3].id)
	//	CloseActiveChatBlock()
	//});

	//.GetContextPanel().FindChildTraverse("inventory_header_button_inventory").SetPanelEvent("onactivate", function() 
	//	
	//	Game.EmitSound("UI.Shop_Main_Button")
	//	InitItems()
	//	GameUI.CustomUIConfig().OpenShopPlus("shop_window_" + 5, shop_buttons[3].id)
	//	CloseActiveChatBlock()
	//);





	InitHeroes()
	InitItems()
	InitSounds()
	//InitInventory()

	UpdateShards()
}


function InitSale()
{


    let last_panel = $.GetContextPanel().FindChildTraverse("active_sale_panel")
    if (last_panel)
    {
        last_panel.DeleteAsync(0)
    }

    if (active_sale == 0 && active_sale_global == 0)
    {
       return
    }
    let main = $.GetContextPanel().FindChildTraverse('shop_window_header_shop')


    if (active_sale_global == 1)
    {
        let panel = $.CreatePanel("Panel", main, "active_sale_panel");
        panel.AddClass("active_sale_global_panel")

        let top = $.CreatePanel("Panel", panel, "");
        top.AddClass("active_sale_top")

        let bot = $.CreatePanel("Panel", panel, "");
        bot.AddClass("active_sale_bot")


        let text = $.CreatePanel("Label", top, "");
        text.AddClass("active_sale_text")
        text.html = true
        text.text = $.Localize("#global_sale_shop")


        let text_bot = $.CreatePanel("Label", bot, "");
        text_bot.AddClass("active_sale_text_bot")
        text_bot.html = true
        text_bot.text = $.Localize("#global_sale_shop_bot")
        return
    }

    let panel = $.CreatePanel("Panel", main, "active_sale_panel");
    panel.AddClass("active_sale_panel")

    let top = $.CreatePanel("Panel", panel, "");
    top.AddClass("active_sale_top")

    let bot = $.CreatePanel("Panel", panel, "");
    bot.AddClass("active_sale_bot")

    let bot_icons = $.CreatePanel("Panel", bot, "");
    bot_icons.AddClass("active_sale_bot_icons")

    let text = $.CreatePanel("Label", top, "");
    text.AddClass("active_sale_text")
    text.html = true
    text.text = $.Localize("#active_sale_panel")

    for (var i = 1; i <= Object.keys(active_sale_heroes).length; i++) 
    {
        let icon = $.CreatePanel("Panel", bot_icons, "");
        icon.AddClass("active_sale_icon")

        icon.style.backgroundImage = "url('file://{images}/heroes/icons/" + String(active_sale_heroes[i]) + ".png')"
        icon.style.backgroundSize = "contain"
        icon.style.backgroundRepeat = 'no-repeat'

    }

}

function InitHeroes()
{
	let table_heroes = CustomNetTables.GetTableValue("custom_pick", "hero_list")
	let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroList")


	const hero_names_sorted = [...Object.keys(table_heroes)].sort()

	let heroes_strength = []
	let heroes_agility = []
	let heroes_intellect = []
	let heroes_all = []

	for (const hero_name of hero_names_sorted)
	{
		if (table_heroes[hero_name] == 0)
		{
			heroes_strength.push(hero_name)
		} else if (table_heroes[hero_name] == 1) {
			heroes_agility.push(hero_name)
		} else if (table_heroes[hero_name] == 2) {
			heroes_intellect.push(hero_name)
		} else if (table_heroes[hero_name] == 3) {
			heroes_all.push(hero_name)
		}
	}


	if (heroes_panel)
	{
		heroes_panel.RemoveAndDeleteChildren()

		let attribute_info = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info.AddClass("attribute_info")
	
		let hero_icon_str = $.CreatePanel("Panel", attribute_info, "");
		hero_icon_str.AddClass("hero_icon_str")
	
		let hero_label_str = $.CreatePanel("Label", attribute_info, "");
		hero_label_str.AddClass("hero_label_str")
		hero_label_str.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_str")

		const str_row = $.CreatePanel("Panel", heroes_panel, "StrengthHeroes");


		let attribute_info_2 = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info_2.AddClass("attribute_info")
	
		let hero_icon_agi = $.CreatePanel("Panel", attribute_info_2, "");
		hero_icon_agi.AddClass("hero_icon_agi")
	
		let hero_label_agi = $.CreatePanel("Label", attribute_info_2, "");
		hero_label_agi.AddClass("hero_label_agi")
		hero_label_agi.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_agi")



		const agi_row = $.CreatePanel("Panel", heroes_panel, "AgilityHeroes");


		let attribute_info_3 = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info_3.AddClass("attribute_info")
	
		let hero_icon_int = $.CreatePanel("Panel", attribute_info_3, "");
		hero_icon_int.AddClass("hero_icon_int")
	
		let hero_label_int = $.CreatePanel("Label", attribute_info_3, "");
		hero_label_int.AddClass("hero_label_int")
		hero_label_int.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_int")

		const int_row = $.CreatePanel("Panel", heroes_panel, "IntellectHeroes");


		let attribute_info_4 = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info_4.AddClass("attribute_info")
	
		let hero_icon_all = $.CreatePanel("Panel", attribute_info_4, "");
		hero_icon_all.AddClass("hero_icon_all")
	
		let hero_label_all = $.CreatePanel("Label", attribute_info_4, "");
		hero_label_all.AddClass("hero_label_all")
		hero_label_all.text = $.Localize("#stats_all")

		const all_row = $.CreatePanel("Panel", heroes_panel, "AllHeroes");

		for (var i = 0; i < Object.keys(heroes_strength).length; i++) 
		{
			CreateHeroPanel(str_row, heroes_strength[i], 1)
		}

		for (var i = 0; i < Object.keys(heroes_agility).length; i++) 
		{
			CreateHeroPanel(agi_row, heroes_agility[i], 2)
		}

		for (var i = 0; i < Object.keys(heroes_intellect).length; i++) 
		{
			CreateHeroPanel(int_row, heroes_intellect[i], 3)
		}

		for (var i = 0; i < Object.keys(heroes_all).length; i++) 
		{
			CreateHeroPanel(all_row, heroes_all[i], 4)
		}
	}
}

function CreateHeroPanel(panel, hero_name, stat) {


	var player_data_local = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer());
 
 	var BlockHero = $.CreatePanel("Panel", panel, "");
	BlockHero.AddClass("BlockHero");



	var HeroImage = $.CreatePanel(`DOTAHeroImage`, BlockHero, "", {scaling: "stretch-to-cover-preserve-aspect", heroname : String(hero_name), tabindex : "auto", class: "HeroImage", heroimagestyle : "portrait"});

	var LevelPanel = $.CreatePanel("Panel", BlockHero, "");
	LevelPanel.AddClass("LevelPanel");


	var DotaPlusIcon = $.CreatePanel("Panel", LevelPanel, "");
	DotaPlusIcon.AddClass("DotaPlusIcon");
	DotaPlusIcon.style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + player_data_local["heroes_data"][hero_name]["tier"] + '_tiny_png.vtex")'

	var HeroLevelLabel = $.CreatePanel("Label", LevelPanel, "");
	HeroLevelLabel.AddClass("HeroLevelLabel");


	if (player_data_local["heroes_data"][hero_name]['has_level'] == 1)
	{
        let level = Number(player_data_local["heroes_data"][hero_name]["level"])
        let tier = Number(player_data_local["heroes_data"][hero_name]["tier"])
		HeroLevelLabel.text = level

        if (level < 10)
        {
            HeroLevelLabel.AddClass("HeroLevelLabel_1")
        }

		BlockHero.AddClass("BlockHero_" + String(tier))
        LevelPanel.AddClass("LevelPanel_" + String(tier))
        HeroImage.AddClass("HeroImage_" + String(tier))

	}else 
	{
        LevelPanel.style.opacity = 0
		HeroLevelLabel.text = 0
	}



	BlockHero.SetPanelEvent("onactivate", function() 
	{	
		OpenGeneralInformation(hero_name)
	});	
}

function OpenGeneralInformation(hero_name)
{
	Game.EmitSound("UI.Click")
	let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroList")
	if (heroes_panel)
	{
		heroes_panel.style.visibility = "collapse"
	}
	let GeneralHeroInformation = $.GetContextPanel().FindChildTraverse("GeneralHeroInformation")
	if (GeneralHeroInformation)
	{
		GeneralHeroInformation.style.visibility = "visible"
	}
	InitHeroGeneralInformation(GeneralHeroInformation, hero_name)
}

var thresh = [50,60,70,80, 100,120,140,160,180,200, 230,260,290,320,350,380, 420,460,500,540,580,620,680, 800,900,1000,1100,1200, 1500 ]

function InitHeroGeneralInformation(panel, hero_name)
{
	let general_hero_panel = $.GetContextPanel().FindChildTraverse("GeneralHeroInformation")
	if (general_hero_panel)
	{
		general_hero_panel.RemoveAndDeleteChildren()
	}

	var player_data_local = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer());
	var quest_data = CustomNetTables.GetTableValue("hero_quests", Players.GetLocalPlayer());

	var QuestsGeneralPanel = $.CreatePanel("Panel", panel, "");
	QuestsGeneralPanel.AddClass("QuestsGeneralPanel");


	var QuestsTopPanel = $.CreatePanel("Panel", QuestsGeneralPanel, "");
	QuestsTopPanel.AddClass("QuestsTopPanel");


	var QuestsGeneralPanelLabel = $.CreatePanel("Label", QuestsTopPanel, "");
	QuestsGeneralPanelLabel.AddClass("QuestsGeneralPanelLabel");
	QuestsGeneralPanelLabel.text = $.Localize("#quests_top")


	if (player_data_local.subscribed == 1)
	{

		let time = player_data_local.quests_cd

		let days = Math.floor((time/3600)/24)
		let display = String(days) + $.Localize("#pass_active_sub_days")

		if (days < 1)
		{
			display = String(Math.max(0, Math.floor(((time/3600)/24 - days)*24))) + $.Localize("#pass_active_sub_hours")
		}


		var QuestsGeneralPanelLabel_refresh = $.CreatePanel("Label", QuestsTopPanel, "");
		QuestsGeneralPanelLabel_refresh.AddClass("QuestsGeneralPanelLabel_refresh");
		QuestsGeneralPanelLabel_refresh.text = $.Localize("#QuestCd") + display
	}

	//var QuestPanelHeaderPanelLabel1 = $.CreatePanel("Label", QuestPanelHeaderPanel, "");
	//QuestPanelHeaderPanelLabel1.AddClass("QuestPanelHeaderPanelLabel1");
	//QuestPanelHeaderPanelLabel1.text = $.Localize("#quests_date")

	if (player_data_local["subscribed"] == 0)
	{
	//	var QuestPanelHeaderPanelLabel2 = $.CreatePanel("Label", QuestPanelHeaderPanel, "");
	//	QuestPanelHeaderPanelLabel2.AddClass("QuestPanelHeaderPanelLabel2");
	//	QuestPanelHeaderPanelLabel2.text = $.Localize("#quests_sub")
	}

	if (quest_data && quest_data[String(hero_name)])
	{
		if (Object.keys(quest_data[String(hero_name)]).length == 0)
		{

			var questpanel_main = $.CreatePanel("Panel", QuestsGeneralPanel, "");
			questpanel_main.AddClass("questpanel_main");

			var QuestPanel = $.CreatePanel("Panel", questpanel_main, "");
			QuestPanel.AddClass("QuestPanel");

			var QuestPanelName = $.CreatePanel("Label", QuestPanel, "");
			QuestPanelName.html = true;

			let text = $.Localize('#QuestsNoSub')

			if (player_data_local.subscribed == 1)
			{
				text = $.Localize('#NoQuests')
				QuestPanelName.AddClass("QuestPanelName");
			}else 
			{

				QuestPanelName.AddClass("QuestPanelName_nosub");
			}


			QuestPanelName.text = text

		}else
		{
			for (var i = 1; i <= Object.keys(quest_data[String(hero_name)]).length; i++)
			{

				CreateQuest(QuestsGeneralPanel, quest_data[String(hero_name)][i])
			}
		}
	}

	var HeroLevelProgress = $.CreatePanel("Panel", panel, "");
	HeroLevelProgress.AddClass("HeroLevelProgress");


	var HeroLevelProgressTop = $.CreatePanel("Panel", HeroLevelProgress, "");
	HeroLevelProgressTop.AddClass("HeroLevelProgressTop");


	var HeroLevelProgressTop_text = $.CreatePanel("Label", HeroLevelProgressTop, "");
	HeroLevelProgressTop_text.AddClass("HeroLevelProgressText");



	var HeroLevelProgressLine = $.CreatePanel("Panel", HeroLevelProgress, "");
	HeroLevelProgressLine.AddClass("HeroLevelProgressLine");

	var HeroLevelProgressLabel = $.CreatePanel("Label", HeroLevelProgressLine, "");
	HeroLevelProgressLabel.AddClass("HeroLevelProgressLabel");
	HeroLevelProgressLabel.text = ""

	let level_thresh = [6,12,18,25,30]
	let next_level = player_data_local["heroes_data"][hero_name]["level"] + 1

	let next_tier = 0

	for (var i = 0; i <= Object.keys(level_thresh).length; i++)
	{
		let thresh = level_thresh[i]
		if (next_level >= thresh)
		{
			next_tier = i+1
		}else 
		{
			break
		}
	}
	next_tier = Math.min(next_tier, 5)


	var HeroLevelProgressLineIcon1 = $.CreatePanel("Panel", HeroLevelProgressTop, "");
	HeroLevelProgressLineIcon1.AddClass("HeroLevelProgressLineIcon1");
	HeroLevelProgressLineIcon1.style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + player_data_local["heroes_data"][hero_name]["tier"] + '_png.vtex")'
	HeroLevelProgressLineIcon1.style.backgroundSize = "100%"

	//var HeroLevelProgressLineIcon2 = $.CreatePanel("Panel", HeroLevelProgress, "");
//	HeroLevelProgressLineIcon2.AddClass("HeroLevelProgressLineIcon2");
//	HeroLevelProgressLineIcon2.style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + next_tier + '_png.vtex")'
//	HeroLevelProgressLineIcon2.style.backgroundSize = "100%"
	
	if (next_tier == player_data_local["heroes_data"][hero_name]["tier"])
	{
		//HeroLevelProgressLineIcon2.style.opacity = "0";
	}

	var HeroLevelProgressFront = $.CreatePanel("Panel", HeroLevelProgressLine, "");
	HeroLevelProgressFront.AddClass("HeroLevelProgressFront");


	HeroLevelProgressFront.AddClass("HeroLevel_filler_" + String(player_data_local["heroes_data"][hero_name]["tier"]))
	HeroLevelProgressLine.AddClass("HeroLevel_bar_" + String(player_data_local["heroes_data"][hero_name]["tier"]))


//	var HeroLevelProgressEnd = $.CreatePanel("Panel", HeroLevelProgressLine, "");
//	HeroLevelProgressEnd.AddClass("HeroLevelProgressEnd");

	var HeroSoundPanel = $.CreatePanel("Panel", panel, "");
	HeroSoundPanel.AddClass("HeroSoundPanel");

	var HeroSoundPanelLabel = $.CreatePanel("Label", HeroSoundPanel, "");
	HeroSoundPanelLabel.AddClass("HeroSoundPanelLabel");
	HeroSoundPanelLabel.text = $.Localize("#shop_hero_sounds")

	var HeroSoundPanelSounds = $.CreatePanel("Panel", HeroSoundPanel, "");
	HeroSoundPanelSounds.AddClass("HeroSoundPanelSounds");

	if (player_data_local)
	{
		if (player_data_local["heroes_data"][hero_name])
		{
			let init_exp = player_data_local["heroes_data"][hero_name]["exp"]
			let max_exp =  thresh[player_data_local["heroes_data"][hero_name]["level"] - 1]
			if (max_exp)
			{
				if ((max_exp + 1) == level_thresh[player_data_local["heroes_data"][hero_name]["tier"]])
				{
				} 

				let width = ( (init_exp)/max_exp) * 100

				HeroLevelProgressTop_text.text =  $.Localize('#hero_level_full') + String(player_data_local["heroes_data"][hero_name]["level"])

				HeroLevelProgressLabel.text =  String(init_exp) + ' / ' + String(max_exp)
				HeroLevelProgressFront.style.width = String(width)+'%'
			} else {
				//HeroLevelProgressLabel.text = $.Localize('#hero_level') + String(player_data_local["heroes_data"][hero_name]["level"])
				HeroLevelProgressTop_text.text =  $.Localize('#hero_level_full') + String(player_data_local["heroes_data"][hero_name]["level"])
				HeroLevelProgressFront.style.width = "99%"
			}
		}
	}

	let sounds_table = CustomNetTables.GetTableValue("custom_sounds", "sounds")

	for (var sound = 1; sound <= Object.keys(sounds_table[hero_name]).length; sound++)
	{
		CreateSoundInGeneralInformation(HeroSoundPanelSounds, sounds_table[hero_name][sound][1], sounds_table[hero_name][sound], hero_name)
	}
}

function CreateQuest(panel, data, player_data)
{

	var questpanel_main = $.CreatePanel("Panel", panel, "");
	questpanel_main.AddClass("questpanel_main");

	var QuestPanel = $.CreatePanel("Panel", questpanel_main, "");
	QuestPanel.AddClass("QuestPanel");

	var QuestPanelIcon = $.CreatePanel("Panel", QuestPanel, "");
	QuestPanelIcon.AddClass("QuestPanelIcon");

	QuestPanelIcon.style.backgroundImage = 'url("file://{images}/custom_game/icons/skills/' + data.icon + '.png")'
	QuestPanelIcon.style.backgroundSize = "100%"


	var QuestPanelText = $.CreatePanel("Panel", QuestPanel, "");
	QuestPanelText.AddClass("QuestPanelText");


	var QuestPanelReward = $.CreatePanel("Panel", QuestPanel, "");
	QuestPanelReward.AddClass("QuestPanelReward");


	var QuestPanelReward_shards = $.CreatePanel("Panel", QuestPanelReward , "");
	QuestPanelReward_shards.AddClass("QuestPanelReward_shards");

	var QuestPanelReward_exp = $.CreatePanel("Panel", QuestPanelReward , "");
	QuestPanelReward_exp.AddClass("QuestPanelReward_exp");


	var QuestPanelReward_shards_icon = $.CreatePanel("Panel", QuestPanelReward_shards , "");
	QuestPanelReward_shards_icon.AddClass("QuestPanelReward_shards_icon");

	var QuestPanelReward_exp_icon = $.CreatePanel("Panel", QuestPanelReward_exp , "");
	QuestPanelReward_exp_icon.AddClass("QuestPanelReward_exp_icon");

	var QuestPanelRewardLabel_shards = $.CreatePanel("Label",  QuestPanelReward_shards, "");
	QuestPanelRewardLabel_shards.AddClass("QuestPanelReward_text");
	QuestPanelRewardLabel_shards.text ="+" + data.shards


	var QuestPanelRewardLabel_exp = $.CreatePanel("Label",  QuestPanelReward_exp, "");
	QuestPanelRewardLabel_exp.AddClass("QuestPanelReward_text");
	QuestPanelRewardLabel_exp.text = "+" + data.exp


	var QuestPanelName = $.CreatePanel("Label", QuestPanelText, "");
	QuestPanelName.AddClass("QuestPanelName");
	QuestPanelName.html = true;
	QuestPanelName.text = $.Localize("#"+data.name)  + $.Localize("#QuestGoal") + "<b><font color='#53ea48'>" + String(data.goal) + "</font></b>"






	if  (!QUEST_BLUR)
	{
		QuestPanel.style.blur = "gaussian( 50 )"
		var QuestComingSoon = $.CreatePanel("Label", questpanel_main, "");
		QuestComingSoon.AddClass("QuestComingSoon");
		QuestComingSoon.text = $.Localize("#soon_ingame")
	}
}





function CreateSoundInGeneralInformation(panel, level, sound, hero_name)
{
	var SoundSelect = $.CreatePanel("Panel", panel, "");
	SoundSelect.AddClass("SoundSelect");

	var SoundLocked = $.CreatePanel("Panel", SoundSelect, "");
	SoundLocked.AddClass("SoundLocked");
	SoundLocked.style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + (level) + '_png.vtex")'
	SoundLocked.style.backgroundSize = "100%"
	SoundLocked.style.width = "25px"
	SoundLocked.style.height = "25px"

	var SoundIcon = $.CreatePanel("Panel", SoundSelect, "");
	SoundIcon.AddClass("SoundIcon");

	SoundIcon.SetPanelEvent("onactivate", function() 
	{	
		Game.EmitSound(sound[2])
	});

	var SoundHeroIcon = $.CreatePanel("Panel", SoundSelect, "");
	SoundHeroIcon.AddClass("SoundHeroIcon");
	SoundHeroIcon.style.backgroundImage = "url('file://{images}/heroes/icons/" + String(hero_name) + ".png')"
	SoundHeroIcon.style.backgroundSize = "100%"

	var SoundName = $.CreatePanel("Label", SoundSelect, "");
	SoundName.AddClass("SoundName");
	SoundName.text = $.Localize("#"+sound[2])
}





function InitSounds()
{
	$("#ButtonLabelDefault").text = $.Localize("#chat_wheel_general") + GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL)
	$("#ButtonLabelHero").text = $.Localize("#chat_wheel_hero") + GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_CHAT_WHEEL)
    $("#SoundWheelSettingsButton").SetPanelEvent('onmouseover', function() 
    {
        $.DispatchEvent('DOTAShowTextTooltip', $("#SoundWheelSettingsButton"), "#chatwheel_settings_info") 
    });
    $("#SoundWheelSettingsButton").SetPanelEvent('onmouseout', function() 
    {
        $.DispatchEvent('DOTAHideTextTooltip', $("#SoundWheelSettingsButton"));
    });

	let sounds_panel_rus = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList1")
	let sounds_panel_eng = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList2")
	let sounds_panel_other = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList3")
	let sounds_table = CustomNetTables.GetTableValue("custom_sounds", "sounds")

	let sounds_rus = []
	let sounds_eng = []
	let sounds_other = []
	
	if (sounds_table["general_ru"])
	{
		for (var sound = 1; sound <= Object.keys(sounds_table["general_ru"]).length; sound++)
		{
			sounds_rus[sound-1] = []
			sounds_rus[sound-1].push(sounds_table["general_ru"][sound][1], sounds_table["general_ru"][sound][2], sounds_table["general_ru"][sound][3], sounds_table["general_ru"][sound][4] || 0, sounds_table["general_ru"][sound][5] || 0)
		}
	}

	if (sounds_table["general_eng"])
	{
		for (var sound = 1; sound <= Object.keys(sounds_table["general_eng"]).length; sound++)
		{
			sounds_eng[sound-1] = []
			sounds_eng[sound-1].push(sounds_table["general_eng"][sound][1], sounds_table["general_eng"][sound][2], sounds_table["general_eng"][sound][3], sounds_table["general_eng"][sound][4] || 0, sounds_table["general_eng"][sound][5] || 0)
		}
	}

	if (sounds_table["general_other"])
	{
		for (var sound = 1; sound <= Object.keys(sounds_table["general_other"]).length; sound++)
		{
			sounds_other[sound-1] = []
			sounds_other[sound-1].push(sounds_table["general_other"][sound][1], sounds_table["general_other"][sound][2],sounds_table["general_other"][sound][3],sounds_table["general_other"][sound][4] || 0,sounds_table["general_other"][sound][5] || 0)
		}
	}
 
	sounds_rus.sort(function (a, b) 
    {
	  return Number(a[2])-Number(b[2])
	});

	sounds_eng.sort(function (a, b) 
    {
	  return Number(a[2])-Number(b[2])
	});

	sounds_other.sort(function (a, b) 
    {
	  return Number(a[2])-Number(b[2])
	});

	if (sounds_panel_rus)
	{
		sounds_panel_rus.RemoveAndDeleteChildren()
        for (var sound = 0; sound < sounds_rus.length; sound++)
		{
			if (!HasItemInventory(sounds_rus[sound][0]) && sounds_rus[sound][3] != 0)
			{
				CreateSoundInWheel(sounds_panel_rus, sounds_rus[sound], true)
			}
		}
		for (var sound = 0; sound < sounds_rus.length; sound++)
		{
			if (HasItemInventory(sounds_rus[sound][0]))
			{
				CreateSoundInWheel(sounds_panel_rus, sounds_rus[sound])
			}
		}
		for (var sound = 0; sound < sounds_rus.length; sound++)
		{
			if (!HasItemInventory(sounds_rus[sound][0]) && sounds_rus[sound][3] != 1)
			{
				CreateSoundInWheel(sounds_panel_rus, sounds_rus[sound])
			}
		}
	}

	if (sounds_panel_rus)
	{
		sounds_panel_eng.RemoveAndDeleteChildren()
        for (var sound = 0; sound < sounds_eng.length; sound++)
		{
			if (!HasItemInventory(sounds_eng[sound][0]) && sounds_eng[sound][3] != 0)
			{
				CreateSoundInWheel(sounds_panel_eng, sounds_eng[sound], true)
			}
		}
		for (var sound = 0; sound < sounds_eng.length; sound++)
		{
			if (HasItemInventory(sounds_eng[sound][0]))
			{
				CreateSoundInWheel(sounds_panel_eng, sounds_eng[sound])
			}
		}
		for (var sound = 0; sound < sounds_eng.length; sound++)
		{
			if (!HasItemInventory(sounds_eng[sound][0]) && sounds_eng[sound][3] != 1)
			{
				CreateSoundInWheel(sounds_panel_eng, sounds_eng[sound])
			}
		}
	}

	if (sounds_panel_rus)
	{
		sounds_panel_other.RemoveAndDeleteChildren()
        for (var sound = 0; sound < sounds_other.length; sound++)
		{
			if (!HasItemInventory(sounds_rus[sound][0]) && sounds_other[sound][3] != 0)
			{
				CreateSoundInWheel(sounds_panel_other, sounds_other[sound], true)
			}
		}
		for (var sound = 0; sound < sounds_other.length; sound++)
		{
			if (HasItemInventory(sounds_other[sound][0]))
			{
				CreateSoundInWheel(sounds_panel_other, sounds_other[sound])
			}
		}
		for (var sound = 0; sound < sounds_other.length; sound++)
		{
			if (!HasItemInventory(sounds_other[sound][0]) && sounds_other[sound][3] != 1)
			{
				CreateSoundInWheel(sounds_panel_other, sounds_other[sound])
			}
		}
	}

	InitChatWheelData()
}

var chat_select_active = false

function CreateSoundInWheel(panel, sound)
{
	var SoundSelect = $.CreatePanel("Panel", panel, "");
	SoundSelect.AddClass("SoundSelect");
	SoundSelect.sound_name = sound[0]

	var SoundLocked = $.CreatePanel("Panel", SoundSelect, "");
	SoundLocked.AddClass("SoundLocked");
	SoundLocked.style.opacity = "0"

	var SoundIcon = $.CreatePanel("Panel", SoundSelect, "");
	SoundIcon.AddClass("SoundIcon");

	SoundIcon.SetPanelEvent("onactivate", function() 
	{
		Game.EmitSound(sound[1])
	});

	var SoundName = $.CreatePanel("Label", SoundSelect, "");
	SoundName.AddClass("SoundName");
    SoundName.html = true

    if (!HasItemInventory(sound[0]) && sound[3] != 0)
	{
        SoundName.text = "<b><font color='#ff0000'>New</font></b> " + $.Localize("#"+sound[1])
    } else
    {
        SoundName.text = $.Localize("#"+sound[1])
    }
 
	var player_data_local = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer());

	// Здесь проверять на купленность, чтоб не добавлять стоимость если предмет уже есть
	if (!HasItemInventory(sound[0]))
	{
        SoundLocked.style.opacity = "1"

        if (sound[4] != 0)
        {
            SoundSelect.style.visibility = "collapse"
            return
        }

		SoundSelect.SetHasClass("buy_chat_wheel", true)

		var shardcostpanel = $.CreatePanel("Panel", SoundSelect, "");
		shardcostpanel.AddClass("shardcostpanel");

		var shardcost_icon = $.CreatePanel("Panel", SoundSelect, "");
		shardcost_icon.AddClass("shardcost_icon");

		var shard_cost_label = $.CreatePanel("Label", SoundSelect, "");
		shard_cost_label.AddClass("shard_cost_label");
		shard_cost_label.text = sound[2]

		let point = 150

		if (player_data_local && player_data_local["points"] >= sound[2])
		{
			SoundSelect.SetPanelEvent("onactivate", function() 
			{ 
				CreateBuyWindow(sound[0], sound[2], sound[1], 1)
			})
		} 
        else 
        {
			shard_cost_label.style.color = "red"
			SoundSelect.SetHasClass("buy_chat_wheel", false)
		}
	}
}

function HasItemInventory(item_id)
{
	let player_table = player_table_shop
	if (player_table && player_table.items_ids)
	{
		for (var d = 1; d <= Object.keys(player_table.items_ids).length; d++) 
		{
			if (player_table.items_ids[d])
			{
				if (String(player_table.items_ids[d]) == String(item_id))
				{
					return true
				}
			}
		}
	}
	return false
}

function SetActiveChatBlock(id)
{
	let findblock = Number(id) - 1

	if ($("#ChatWheelButton"+findblock).BHasClass("chat_whell_block_selected"))
	{
		CloseActiveChatBlock()
		return
	}
	let sounds_panel_rus = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList1")
	let sounds_panel_eng = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList2")
	let sounds_panel_other = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList3")


	$("#ChatWheelButton6").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton5").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton4").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton3").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton7").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton0").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton1").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton2").SetHasClass("chat_whell_block_selected", false)

	

	$("#ChatWheelButton"+findblock).SetHasClass("chat_whell_block_selected", true)

	if (chat_select_active == false )
	{ 
		for (var i = 0; i < sounds_panel_rus.GetChildCount(); i++) {
			SetEventChatWheel(sounds_panel_rus.GetChild(i), sounds_panel_rus.GetChild(i).sound_name, id, true)
		}
		for (var i = 0; i < sounds_panel_eng.GetChildCount(); i++) {
			SetEventChatWheel(sounds_panel_eng.GetChild(i), sounds_panel_eng.GetChild(i).sound_name, id, true)
		}
		for (var i = 0; i < sounds_panel_other.GetChildCount(); i++) {
			SetEventChatWheel(sounds_panel_other.GetChild(i), sounds_panel_other.GetChild(i).sound_name, id, true)
		}
		chat_select_active = true
	} else {
		for (var i = 0; i < sounds_panel_rus.GetChildCount(); i++) {
			SetEventChatWheel(sounds_panel_rus.GetChild(i), sounds_panel_rus.GetChild(i).sound_name, 0, false)
		}
		for (var i = 0; i < sounds_panel_eng.GetChildCount(); i++) {
			SetEventChatWheel(sounds_panel_eng.GetChild(i), sounds_panel_eng.GetChild(i).sound_name, id, true)
		}
		for (var i = 0; i < sounds_panel_other.GetChildCount(); i++) {
			SetEventChatWheel(sounds_panel_other.GetChild(i), sounds_panel_other.GetChild(i).sound_name, id, true)
		}
		chat_select_active = false
	}
}
















function CloseActiveChatBlock()
{
	let sounds_panel_rus = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList1")
	let sounds_panel_eng = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList2")
	let sounds_panel_other = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList3")

	$("#ChatWheelButton6").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton5").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton4").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton3").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton7").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton0").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton1").SetHasClass("chat_whell_block_selected", false)
	$("#ChatWheelButton2").SetHasClass("chat_whell_block_selected", false)

	for (var i = 0; i < sounds_panel_rus.GetChildCount(); i++) {
		SetEventChatWheel(sounds_panel_rus.GetChild(i), sounds_panel_rus.GetChild(i).sound_name, 0, false)
	}
	for (var i = 0; i < sounds_panel_eng.GetChildCount(); i++) {
		SetEventChatWheel(sounds_panel_eng.GetChild(i), sounds_panel_eng.GetChild(i).sound_name, 0, false)
	}
	for (var i = 0; i < sounds_panel_other.GetChildCount(); i++) {
		SetEventChatWheel(sounds_panel_other.GetChild(i), sounds_panel_other.GetChild(i).sound_name, 0, false)
	}
	chat_select_active = false
}

function SetEventChatWheel(panel, sound_name, id, active)
{
	let sounds_panel_rus = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList1")
	let sounds_panel_eng = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList2")
	let sounds_panel_other = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList3")
	if (active == false)
	{
		if (HasItemInventory(sound_name)) {
			panel.SetPanelEvent("onactivate", function() {})
			panel.SetHasClass("active_chat_wheel", false)
			sounds_panel_rus.SetHasClass("active_chat_wheel_all_block", false)
			sounds_panel_eng.SetHasClass("active_chat_wheel_all_block", false)
			sounds_panel_other.SetHasClass("active_chat_wheel_all_block", false)
		}
		return
	}

	if (!HasItemInventory(sound_name)) {
		return
	}

	panel.SetHasClass("active_chat_wheel", true)
	sounds_panel_rus.SetHasClass("active_chat_wheel_all_block", true)
	sounds_panel_eng.SetHasClass("active_chat_wheel_all_block", true)
	sounds_panel_other.SetHasClass("active_chat_wheel_all_block", true)

	panel.SetPanelEvent("onactivate", function() { 
		GameEvents.SendCustomGameEventToServer_custom( "select_chatwheel_player", {id : id, sound_name : sound_name } );
		$.Schedule( 0.25, function()
		{
			InitChatWheelData()
			CloseActiveChatBlock()
		})
	})
}

function InitChatWheelData()
{
	var player_table = CustomNetTables.GetTableValue("players_chat_wheel", String(Players.GetLocalPlayer()))
	let sounds_table = CustomNetTables.GetTableValue("custom_sounds", "sounds")
	
	if (player_table)
	{
		if (player_table)
		{
			for (var p = 1; p <= 8; p++) {
				
				let name = "null"

				if (sounds_table["general_ru"])
				{
					for (var sound = 1; sound <= Object.keys(sounds_table["general_ru"]).length; sound++)
					{
						if (String(sounds_table["general_ru"][sound][1]) == String(player_table[p]) )
						{
							name = String(sounds_table["general_ru"][sound][2])
						}
					}
				}

				if (sounds_table["general_eng"])
				{
					for (var sound = 1; sound <= Object.keys(sounds_table["general_eng"]).length; sound++)
					{
						if (String(sounds_table["general_eng"][sound][1]) == String(player_table[p]) )
						{
							name = String(sounds_table["general_eng"][sound][2])
						}
					}
				}

				if (sounds_table["general_other"])
				{
					for (var sound = 1; sound <= Object.keys(sounds_table["general_other"]).length; sound++)
					{
						if (String(sounds_table["general_other"][sound][1]) == String(player_table[p]) )
						{
							name = String(sounds_table["general_other"][sound][2])
						}
					}
				}

				$( "#chat_wheel_dota_"+p ).text = $.Localize("#"+name)
			}
		}
	}
}

GameUI.CustomUIConfig().OpenShopPlus = function select_shop_button(panel, button)
{



	if (panel == "shop_window_1")
	{
		$.GetContextPanel().FindChildTraverse("shop_window_1").ScrollToTop()
	}

	if (panel == "shop_window_2")
	{
		let GeneralHeroInformation = $.GetContextPanel().FindChildTraverse("GeneralHeroInformation")
		if (GeneralHeroInformation)
		{
			GeneralHeroInformation.style.visibility = "collapse"
		}
		let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroList")
		if (heroes_panel)
		{
			heroes_panel.style.visibility = "visible"
		}
	}

	if (panel == "shop_window_3")
	{
		$("#ChooseCategory").style.visibility = "visible"
		$("#CategoryPets").style.visibility = "collapse"
		$("#CategoryItems").style.visibility = "collapse"
        $("#CategoryCosmetics").style.visibility = "collapse"
	}

	//if (panel == "shop_window_5")
	//{
	//	$("#ChooseCategoryInventory").style.visibility = "visible"
	//	$("#CategoryPetsInventory").style.visibility = "collapse"
	//	$("#CategoryItemsInventory").style.visibility = "collapse"
	//}

	$.GetContextPanel().FindChildTraverse("inshop_button_sub").SetHasClass("activate", false)
	$.GetContextPanel().FindChildTraverse("inshop_button_heroes").SetHasClass("activate", false)
	$.GetContextPanel().FindChildTraverse("inshop_button_items").SetHasClass("activate", false)
	$.GetContextPanel().FindChildTraverse("inshop_button_chat").SetHasClass("activate", false)
//	$.GetContextPanel().FindChildTraverse("inshop_button_inventory").SetHasClass("activate", false)
	$.GetContextPanel().FindChildTraverse("inshop_button_vote").SetHasClass("activate", false)


	$.GetContextPanel().FindChildTraverse("shop_window_1").style.visibility = "collapse"
	$.GetContextPanel().FindChildTraverse("shop_window_2").style.visibility = "collapse"
	$.GetContextPanel().FindChildTraverse("shop_window_3").style.visibility = "collapse"
	$.GetContextPanel().FindChildTraverse("shop_window_4").style.visibility = "collapse"
	//$.GetContextPanel().FindChildTraverse("shop_window_5").style.visibility = "collapse"
	$.GetContextPanel().FindChildTraverse("shop_window_6").style.visibility = "collapse"
	$.GetContextPanel().FindChildTraverse(button).SetHasClass("activate", true)
	$.GetContextPanel().FindChildTraverse(panel).style.visibility = "visible"
}

function SwapCategorySounds(button, panel)
{

	Game.EmitSound("UI.Click")

	$("#sound_category_ru").style.visibility = "collapse"
	$("#sound_category_eng").style.visibility = "collapse"
	$("#sound_category_other").style.visibility = "collapse"

	$.GetContextPanel().FindChildTraverse("ButtonCategoryRU").SetHasClass("selected", false)
	$.GetContextPanel().FindChildTraverse("ButtonCategoryENG").SetHasClass("selected", false)
	$.GetContextPanel().FindChildTraverse("ButtonCategoryOTHER").SetHasClass("selected", false)

	$.GetContextPanel().FindChildTraverse(button).SetHasClass("selected", true)
	$.GetContextPanel().FindChildTraverse(panel).style.visibility = "visible"
}








function window_init()
{


	var player_stats = $.GetContextPanel().FindChildTraverse("info_button_player_stats")
	var hero_stats = $.GetContextPanel().FindChildTraverse("info_button_hero_stats")
	var gamelist = $.GetContextPanel().FindChildTraverse("info_button_gamelist")		
	var leaderboard = $.GetContextPanel().FindChildTraverse("info_button_leaderboard")	
	var info_window = $.GetContextPanel().FindChildTraverse("window_info")


	


	player_stats.SetPanelEvent("onactivate", function() 
	{	
		init_player_stats(false)
	});


	hero_stats.SetPanelEvent("onactivate", function() 
	{	
		init_hero_stats()
	});


	gamelist.SetPanelEvent("onactivate", function() 
	{	
		init_gamelist()
	});

	leaderboard.SetPanelEvent("onactivate", function() 
	{	
		init_leaderboard();
	});

	init_player_stats(true)

	var player_icon = $.CreatePanel("Panel",player_stats,"info_button_icon1")
	player_icon.AddClass("window_info_button_icon")
    player_icon.style.backgroundImage = 'url("file://{images}/custom_game/Stat_Player.png")';
    player_icon.style.backgroundSize = "100%";
			
    var player_text = $.CreatePanel("Label",player_stats,"info_button_text1")
	player_text.AddClass("window_info_button_text")
	player_text.text = $.Localize('#Player_Stat')


	var heroes = CustomNetTables.GetTableValue("players_heroes",  Players.GetLocalPlayer());
	var hero = heroes.hero


	var hero_icon = $.CreatePanel("Panel",hero_stats,"info_button_icon2")
	hero_icon.AddClass("window_info_button_icon")
    hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + hero + '.png" );'
    hero_icon.style.backgroundSize = "100%";
	
    var hero_text = $.CreatePanel("Label",hero_stats,"info_button_text2")
	hero_text.AddClass("window_info_button_text")
	hero_text.text = $.Localize('#' + hero)



	var gamelist_icon = $.CreatePanel("Panel",gamelist,"info_button_icon4")
	gamelist_icon.AddClass("window_info_button_icon")
    gamelist_icon.style.backgroundImage = 'url("file://{images}/custom_game/match_history.png")';
    gamelist_icon.style.backgroundSize = "100%";

    var gamelist_text = $.CreatePanel("Label",gamelist,"info_button_text4")
	gamelist_text.AddClass("window_info_button_text")
	gamelist_text.text = $.Localize('#Gamelist')


	var leaderboard_icon = $.CreatePanel("Panel",leaderboard,"info_button_icon4")
	leaderboard_icon.AddClass("window_info_button_icon")
    leaderboard_icon.style.backgroundImage = 'url("file://{images}/custom_game/leaderboard.png")';
    leaderboard_icon.style.backgroundSize = "100%";

    var leaderboard_text = $.CreatePanel("Label",leaderboard,"info_button_text4")
	leaderboard_text.AddClass("window_info_button_text")
	leaderboard_text.text = $.Localize('#Leaderboard_Stat')

}


var cd = false 

function Reports_window_show()
{
	if (cd == false)
	{
		
		Game.EmitSound("UI.Info_Open")

		cd = true

		var info_button = $.GetContextPanel().FindChildTraverse("info_button")
		var report_button = $.GetContextPanel().FindChildTraverse("report_button")
		var shop_button = $.GetContextPanel().FindChildTraverse("shop_button")

		var info_window = $.GetContextPanel().FindChildTraverse("window_info")
		var window_reports = $.GetContextPanel().FindChildTraverse("window_reports")
		var shop_window = $.GetContextPanel().FindChildTraverse("window_shop")

		info_button.style.backgroundImage = "url('file://{images}/custom_game/profile.png')"
		report_button.style.backgroundImage = "url('file://{images}/custom_game/report_chose.png')"

		var close_button = $.GetContextPanel().FindChildTraverse("close_button_report")
		var close_text = $.GetContextPanel().FindChildTraverse("close_text_report")
		close_text.text = $.Localize("#close_text")


		if (info_window.BHasClass("info_window_show"))
		{
			info_window.RemoveClass("info_window_show")
			info_window.AddClass("info_window_hidden")

			info_button.SetPanelEvent("onactivate", function() 
			{	
				Info_window_show()
			});
		}




		if (shop_window.BHasClass("shop_window_show"))
		{
			shop_window.RemoveClass("shop_window_show")

			shop_window.AddClass("shop_window_hidden")
			shop_button.SetPanelEvent("onactivate", function() 
			{	
				GameUI.CustomUIConfig().OpenShop()
			});
		}

		window_reports.RemoveClass("reports_window_hidden")
		window_reports.AddClass("reports_window_show")

		report_button.SetPanelEvent("onactivate", function() 
		{	
			Reports_window_hide()
		});



		init_team_report()

		close_button.SetPanelEvent("onactivate", function() 
		{	
			Reports_window_hide()
		});
	

		$.Schedule(0.5, function ()
		{
			cd = false

		})


	}
}

function Reports_window_hide()
{
	if (cd == false)
	{
		cd = true
		Game.EmitSound("UI.Info_Close")


		
		var info_button = $.GetContextPanel().FindChildTraverse("info_button")
		var report_button = $.GetContextPanel().FindChildTraverse("report_button")
		var info_window = $.GetContextPanel().FindChildTraverse("window_info")
		var window_reports = $.GetContextPanel().FindChildTraverse("window_reports")

		report_button.style.backgroundImage = "url('file://{images}/custom_game/report.png')"

		window_reports.RemoveClass("reports_window_show")
		window_reports.AddClass("reports_window_hidden")

		report_button.SetPanelEvent("onactivate", function() 
		{	
			Reports_window_show()
		});

		$.Schedule(0.5, function ()
		{
			cd = false
		})
	}
}






var first_time = false
var chosen_label = 0

function Info_window_show()
{
	if (cd == false)
	{
		
		Game.EmitSound("UI.Info_Open")

		cd = true


	
		var info_button = $.GetContextPanel().FindChildTraverse("info_button")
		var report_button = $.GetContextPanel().FindChildTraverse("report_button")
		var shop_button = $.GetContextPanel().FindChildTraverse("shop_button")

		var info_window = $.GetContextPanel().FindChildTraverse("window_info")
		var window_reports = $.GetContextPanel().FindChildTraverse("window_reports")
		var shop_window = $.GetContextPanel().FindChildTraverse("window_shop")

		info_button.style.backgroundImage = "url('file://{images}/custom_game/profile_chose.png')"
		report_button.style.backgroundImage = "url('file://{images}/custom_game/report.png')"

		var close_button = $.GetContextPanel().FindChildTraverse("close_button")
		var close_text = $.GetContextPanel().FindChildTraverse("close_text")
		close_text.text = $.Localize("#close_text")


		if (window_reports.BHasClass("reports_window_show"))
		{
			window_reports.RemoveClass("reports_window_show")
			window_reports.AddClass("reports_window_hidden")

			report_button.SetPanelEvent("onactivate", function() 
			{	
				Reports_window_show()
			});
		}

		if (shop_window.BHasClass("shop_window_show"))
		{
			shop_window.RemoveClass("shop_window_show")
			shop_window.AddClass("shop_window_hidden")

			shop_button.SetPanelEvent("onactivate", function() 
			{	
				GameUI.CustomUIConfig().OpenShop()
			});
		}

		info_window.RemoveClass("info_window_hidden")
		info_window.AddClass("info_window_show")

		info_button.SetPanelEvent("onactivate", function() 
		{	
			Info_window_hide()
		});

		close_button.SetPanelEvent("onactivate", function() 
		{	
			Info_window_hide()
		});
	

		init_player_stats(true)

		$.Schedule(0.5, function ()
		{
			cd = false

		})

		if (first_time == false)
		{
			window_init()
			first_time = true
		}

	}
}

function Info_window_hide()
{
	if (cd == false)
	{
		cd = true
		Game.EmitSound("UI.Info_Close")

		var info_button = $.GetContextPanel().FindChildTraverse("info_button")
		var report_button = $.GetContextPanel().FindChildTraverse("report_button")
		var info_window = $.GetContextPanel().FindChildTraverse("window_info")
		var window_reports = $.GetContextPanel().FindChildTraverse("window_reports")


		info_button.style.backgroundImage = "url('file://{images}/custom_game/profile.png')"

		info_window.RemoveClass("info_window_show")
		info_window.AddClass("info_window_hidden")

		info_button.SetPanelEvent("onactivate", function() 
		{	
			Info_window_show()
		});

		$.Schedule(0.5, function ()
		{
			cd = false
		})
	}
}

function clear_window(button)
{
	var content = $.GetContextPanel().FindChildTraverse("info_window_content")
	var content_clearing = $.GetContextPanel().FindChildTraverse("content_clearing")

	if (content_clearing)
	{
		content_clearing.DeleteAsync(0)
	}

	var player_stats = $.GetContextPanel().FindChildTraverse("info_button_player_stats")
	var hero_stats = $.GetContextPanel().FindChildTraverse("info_button_hero_stats")	
	var gamelist = $.GetContextPanel().FindChildTraverse("info_button_gamelist")	
	var leaderboard = $.GetContextPanel().FindChildTraverse("info_button_leaderboard")	

	player_stats.RemoveClass("window_info_button_chosen")
	hero_stats.RemoveClass("window_info_button_chosen")
	gamelist.RemoveClass("window_info_button_chosen")
	leaderboard.RemoveClass("window_info_button_chosen")

	button.AddClass("window_info_button_chosen")


}



function init_player_stats(auto)
{
	if (chosen_label == 1) {return}
	chosen_label = 1
	
	if (auto === false)
	{
		Game.EmitSound("UI.Click_Hero")
	}


	var places = []
	var places_game = []
	var places_text_block = []
	var places_text = []
	var places_game_text = []

	var number = 0
	var text = ''


	var server_data = CustomNetTables.GetTableValue("server_data",  Game.GetLocalPlayerID().toString());


	var medal_number = server_data.ranked_tier // Math.floor(server_data.rank_tier / 10)
	var calibration_games = server_data.competitive_calibration_games_remaining



	var rating = 1000
	var stat_total_games = 0
	var stats_player_places = [0,0,0,0,0,0]
	var hero = null


	if (server_data !== undefined )
	{
		rating = String(server_data.rating)
		stat_total_games = String(server_data.total_games)
		stats_player_places = server_data.places
		hero = server_data.favorite_hero
	}
	var leaderboard = CustomNetTables.GetTableValue("leaderboard", "leaderboard");

	var rating_50 = 999999
	var rating_10 = 999999
	var rating_1 = 999999


	if (leaderboard != undefined)
	{
		if (leaderboard[50] != undefined)
		{
			rating_50 = leaderboard[50].rating
		}
		if (leaderboard[10] != undefined)
		{
			rating_10 = leaderboard[10].rating
		}
		if (leaderboard[1] != undefined)
		{
			rating_1 = leaderboard[1].rating
		}
	}


	if (rating >= rating_1)
	{
		medal_number = 10
	}else 
		{
		if (rating >= rating_10)
		{
			medal_number = 9
		}else 
			{
			if (rating >= rating_50)
			{
				medal_number = 8
			}
		}
	}

	var total_games = 0


	var max = 0
	var score = 0
	var avg_place = 0


	for (var i = 0; i < 6; i++) 
	{

		if (stats_player_places[i] >= max)
		{
			max = stats_player_places[i]
		}
		total_games = total_games + stats_player_places[i]
		score = stats_player_places[i]*(i+1) + score
	}


	if (total_games > 0 )
	{
		avg_place = score/total_games
	}



	var player_stats = $.GetContextPanel().FindChildTraverse("info_button_player_stats")

	clear_window(player_stats)
	var content = $.GetContextPanel().FindChildTraverse("info_window_content")
	var content_clearing =  $.CreatePanel("Panel",content,"content_clearing")
	content_clearing.AddClass("content_clearing")


	var player_label = $.CreatePanel("Panel",content_clearing,"player_label")
	player_label.AddClass("player_label")


	var player_icon = $.CreatePanel("DOTAAvatarImage",player_label,"player_icon")
	player_icon.style.width = "10.5%"
    player_icon.style.height = "90%"
    player_icon.steamid = Game.GetPlayerInfo( Players.GetLocalPlayer() ).player_steamid


	var player_name = $.CreatePanel("Label",player_label,"player_name")
	player_name.AddClass("player_name")

	player_name.text = Players.GetPlayerName(Game.GetLocalPlayerID())


	var text_label_1 = $.CreatePanel("Panel",content_clearing,"text_label_1")
	text_label_1.AddClass("text_label")

	var text_label_2 = $.CreatePanel("Panel",content_clearing,"text_label_2")
	text_label_2.AddClass("text_label")

	var text_label_3 = $.CreatePanel("Panel",content_clearing,"text_label_3")
	text_label_3.AddClass("text_label")

	var text_label_4 = $.CreatePanel("Panel",content_clearing,"text_label_4")
	text_label_4.AddClass("text_label")


	var text_1 = $.CreatePanel("Label",text_label_1,"text_1")
	text_1.AddClass("simple_text")
    text_1.text = $.Localize("#total_games") + '  ' + stat_total_games

	var text_2 = $.CreatePanel("Label",text_label_2,"text_2")
	text_2.AddClass("simple_text")

	var medal = $.CreatePanel("Label",text_label_2,"text_2")
	medal.AddClass("rank_medal")


	if (calibration_games <= 0)
	{
    	text_2.text = $.Localize("#rating") + '  ' + rating
	}
	else 
	{
    	text_2.text = $.Localize("#rating") + ' ' + $.Localize("#calibration") + ' (' + String(calibration_games)  + ')'
    	medal_number = 0
	}

	medal.AddClass("rank_medal_" + String(medal_number))




	var text_3 = $.CreatePanel("Label",text_label_3,"text_3")
	text_3.AddClass("simple_text")
    text_3.text = $.Localize("#favor_hero")

	var text_4 = $.CreatePanel("Label",text_label_4,"text_4")
	text_4.AddClass("simple_text")
    text_4.text = $.Localize("#Avg_place") + '  ' + String(avg_place.toFixed(1))
	text_4.AddClass("stats_text_color_" + String(Math.trunc(avg_place)))


	var favor_hero = $.CreatePanel("Panel",text_label_3,"favor_hero")
	favor_hero.AddClass("favor_hero")


	if ((hero != null)&&(hero != ''))
	{
		favor_hero.style.backgroundImage = "url('file://{images}/heroes/icons/" + hero + ".png')"
	}

    favor_hero.style.backgroundSize = "100%";




	var places_label = $.CreatePanel("Panel",content_clearing,"places_label")
	places_label.AddClass("places_label")



	for (var i = 1; i <= 6; i++) 
	{
		places[i] = $.CreatePanel("Panel",places_label,"place"+i)
		places[i].AddClass("place")

		places_text_block[i] = $.CreatePanel("Panel",places[i],"place_text_block"+i)
		places_text_block[i].AddClass("stats_left_text_block")
		


		places_text[i] = $.CreatePanel("Label",places_text_block[i],"place_text"+i)
		places_text[i].AddClass("stats_left_place_text")
		places_text[i].text = String(i)


		places_game[i] = $.CreatePanel("Panel",places[i],"place_game"+i)
		places_game[i].AddClass("stats_left_place_all")
		places_game[i].AddClass("stats_left_place_"+i)

		if (total_games > 0)
		{
			number = (stats_player_places[i-1]/max)*80
		}	
		number = number + 0.01
		text = String(number) + '%'
		places_game[i].style.height = text


		places_game_text[i] = $.CreatePanel("Label",places_game[i],"place_game_text"+i)
		places_game_text[i].AddClass("stats_left_game_text")
		places_game_text[i].text = String(stats_player_places[i-1])

		
	}


}








function roundPlus(x, n) { //x - число, n - количество знаков

  if(isNaN(x) || isNaN(n)) return false;

  var m = Math.pow(10,n);

  return Math.round(x*m)/m;

}





function init_hero_stats()
{
	if (chosen_label == 2) {return}
	chosen_label = 2

	
		Game.EmitSound("UI.Click_Hero")		
		
	var heroes = CustomNetTables.GetTableValue("players_heroes",  Players.GetLocalPlayer());
	var hero = heroes.hero

	var table = Game.GetLocalPlayerID().toString() + '_' + hero

	var hero_data = CustomNetTables.GetTableValue("server_hero_stats", table);


	var stats_player_places = [0,0,0,0,0,0]
	var total_games = 0
	var rating = 0
	var	kills = 0
	var	death = 0

	if (hero_data !== undefined )
	{
		stats_player_places = hero_data.places
		rating = hero_data.rating
		kills = hero_data.kills
		death = hero_data.deaths
	}


	var max = 0
	var score = 0
	var avg_place = 0



	var places = []
	var places_game = []
	var places_text_block = []
	var places_text = []
	var places_game_text = []


	for (var i = 0; i < 6; i++) 
	{

		if (stats_player_places[i] >= max)
		{
			max = stats_player_places[i]
		}
		total_games = total_games + stats_player_places[i]
		score = stats_player_places[i]*(i+1) + score
	}


	if (total_games > 0 )
	{
		avg_place = score/total_games

		if (kills > 0)
		{
			kills = (kills/total_games)
			if (kills%1 !== 0)
			{
				kills = kills
			}
		}


		if (death > 0)
		{
			death = (death/total_games)
			if (death%1 !== 0)
			{
				death = death
			}
		}	

	}

	var kd = 0
	if (death !== 0)
	{
		kd = kills/death
	}
	else 
	{
		kd = kills
	}

	kd = roundPlus(kd,1)
	kills = roundPlus(kills,1)
	death = roundPlus(death,1)
	avg_place = roundPlus(avg_place,1)



	var number = 0
	var text = ''


	var hero_stats = $.GetContextPanel().FindChildTraverse("info_button_hero_stats")
	
	clear_window(hero_stats)

	var content = $.GetContextPanel().FindChildTraverse("info_window_content")
	var content_clearing =  $.CreatePanel("Panel",content,"content_clearing")

	content_clearing.AddClass("content_clearing")


	var hero_label = $.CreatePanel("Panel",content_clearing,"hero_label")
	hero_label.AddClass("player_label")


	var hero_icon = $.CreatePanel("Panel",hero_label,"player_icon")
	hero_icon.AddClass("hero_icon")



	hero_icon.style.backgroundImage = "url('file://{images}/heroes/" + hero + ".png')"


	var player_name = $.CreatePanel("Label",hero_label,"player_name")
	player_name.AddClass("player_name")

	player_name.text = $.Localize('#' + hero)


	var text_label_1 = $.CreatePanel("Panel",content_clearing,"text_label_1")
	text_label_1.AddClass("text_label")

	var text_label_2 = $.CreatePanel("Panel",content_clearing,"text_label_2")
	text_label_2.AddClass("text_label")

	var text_label_3 = $.CreatePanel("Panel",content_clearing,"text_label_3")
	text_label_3.AddClass("text_label")

	var text_label_4 = $.CreatePanel("Panel",content_clearing,"text_label_4")
	text_label_4.AddClass("text_label")


	var text_1 = $.CreatePanel("Label",text_label_1,"text_1")
	text_1.AddClass("simple_text")
    text_1.text = $.Localize("#total_games") + '  ' + String(total_games)

	var text_2 = $.CreatePanel("Label",text_label_2,"text_2")
	text_2.AddClass("simple_text")
	text_2.text = $.Localize("#k_d") + ' ' + String(kills) + '/' + String(death) + ' (' +  String(kd) + ')'

	var text_3 = $.CreatePanel("Label",text_label_3,"text_3")
	text_3.AddClass("simple_text")
    text_3.text = $.Localize("#rating")

    if (rating >= 0)
	{
		text_3.AddClass("stats_text_color_rating_0")
		text_3.text = $.Localize("#rating") + ' +' + String(Math.abs(rating))
	}
	else
	{
		text_3.AddClass("stats_text_color_rating_1")
		text_3.text = $.Localize("#rating") + ' -' + String(Math.abs(rating))
	}



	var text_4 = $.CreatePanel("Label",text_label_4,"text_4")
	text_4.AddClass("simple_text")
    text_4.text = $.Localize("#Avg_place") + '  ' + String(avg_place)
	text_4.AddClass("stats_text_color_" + String(Math.trunc(avg_place)))




	var places_label = $.CreatePanel("Panel",content_clearing,"places_label")
	places_label.AddClass("places_label")

	

	for (var i = 1; i <= 6; i++) 
	{
		places[i] = $.CreatePanel("Panel",places_label,"place"+i)
		places[i].AddClass("place")

		places_text_block[i] = $.CreatePanel("Panel",places[i],"place_text_block"+i)
		places_text_block[i].AddClass("stats_left_text_block")
		


		places_text[i] = $.CreatePanel("Label",places_text_block[i],"place_text"+i)
		places_text[i].AddClass("stats_left_place_text")
		places_text[i].text = String(i)


		places_game[i] = $.CreatePanel("Panel",places[i],"place_game"+i)
		places_game[i].AddClass("stats_left_place_all")
		places_game[i].AddClass("stats_left_place_"+i)

		if (total_games > 0)
		{
			number = (stats_player_places[i-1]/max)*80
		}	
		number = number + 0.01
		text = String(number) + '%'
		places_game[i].style.height = text


		places_game_text[i] = $.CreatePanel("Label",places_game[i],"place_game_text"+i)
		places_game_text[i].AddClass("stats_left_game_text")
		places_game_text[i].text = String(stats_player_places[i-1])

		
	}


}


function padNumber(num) {
    const str = num.toString()
    if (str.length === 1)
        return "0" + str
    return str
}
function init_gamelist()
{
	if (chosen_label == 3) {return}
	chosen_label = 3

		Game.EmitSound("UI.Click_Hero")

	var server_data = CustomNetTables.GetTableValue("server_data",  Game.GetLocalPlayerID().toString());

	var total_games = 0

	if (server_data !== undefined )
	{
		total_games = String(server_data.total_games)
	}

	var button_gamelist = $.GetContextPanel().FindChildTraverse("info_button_gamelist")
	
	clear_window(button_gamelist)

	var content = $.GetContextPanel().FindChildTraverse("info_window_content")
	var content_clearing =  $.CreatePanel("Panel",content,"content_clearing")
	content_clearing.AddClass("content_clearing")



	var text_label_1 = $.CreatePanel("Panel",content_clearing,"text_label_1")
	text_label_1.AddClass("text_label")

	var text_2 = $.CreatePanel("Label",text_label_1,"text_2")
	text_2.AddClass("simple_text")
	if (server_data)
	{
    	text_2.text = $.Localize("#50_games") + Object.keys(server_data.player_matches).length + $.Localize("#games")
    }

	var text_1 = $.CreatePanel("Label",text_label_1,"text_1")
	text_1.AddClass("simple_text_right")
    text_1.text = $.Localize("#total_games") + '  ' + total_games


	var gamelist_stat_info = $.CreatePanel("Panel",content_clearing,"gamelist_stat_info")
	gamelist_stat_info.AddClass("gamelist_stat_info")

	var gamelist_label = $.CreatePanel("Panel",content_clearing,"gamelist_label")
	gamelist_label.AddClass("gamelist_label")



	var gamelist_info_hero = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_info_hero")
	gamelist_info_hero.AddClass("gamelist_stat_info_hero")


	var gamelist_stat_info_hero_text = $.CreatePanel("Label",gamelist_info_hero,"gamelist_stat_info_hero_text")
	gamelist_stat_info_hero_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_hero_text.text = $.Localize("#gamelist_hero")



    var gamelist_stat_info_kills = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_stat_info_kills")
	gamelist_stat_info_kills.AddClass("gamelist_stat_info_kills")

	var gamelist_stat_info_kills_text = $.CreatePanel("Label",gamelist_stat_info_kills,"gamelist_stat_info_kills_text")
	gamelist_stat_info_kills_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_kills_text.text = $.Localize("#gamelist_kills")

    var gamelist_stat_info_death = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_stat_info_death")
	gamelist_stat_info_death.AddClass("gamelist_stat_info_kills")


	var gamelist_stat_info_death_text = $.CreatePanel("Label",gamelist_stat_info_death,"gamelist_stat_info_death_text")
	gamelist_stat_info_death_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_death_text.text = $.Localize("#gamelist_death")



	var gamelist_info_place = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_info_place")
	gamelist_info_place.AddClass("gamelist_stat_info_place")



	var gamelist_stat_info_place_text = $.CreatePanel("Label",gamelist_info_place,"gamelist_stat_info_place_text")
	gamelist_stat_info_place_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_place_text.text = $.Localize("#gamelist_place")




	var gamelist_info_rating = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_info_rating")
	gamelist_info_rating.AddClass("gamelist_stat_info_rating")


	var gamelist_stat_info_rating_text = $.CreatePanel("Label",gamelist_info_rating,"gamelist_stat_info_rating_text")
	gamelist_stat_info_rating_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_rating_text.text = $.Localize("#gamelist_rating")




	var gamelist_info_time = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_info_time")
	gamelist_info_time.AddClass("gamelist_stat_info_time")


	var gamelist_stat_info_time_text = $.CreatePanel("Label",gamelist_info_time,"gamelist_stat_info_time_text")
	gamelist_stat_info_time_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_time_text.text = $.Localize("#gamelist_time")


	var gamelist_info_date = $.CreatePanel("Panel",gamelist_stat_info,"gamelist_info_date")
	gamelist_info_date.AddClass("gamelist_stat_info_date")


	var gamelist_stat_info_date_text = $.CreatePanel("Label",gamelist_info_date,"gamelist_stat_info_date_text")
	gamelist_stat_info_date_text.AddClass("gamelist_stat_info_text")
    gamelist_stat_info_date_text.text = $.Localize("#gamelist_date")






	if (server_data == undefined )
	{
		return
	}


	var gamelist_player_label
	var gamelist_player_hero_icon
	var gamelist_player_hero
	var gamelist_player_skill_icon
	var gamelist_player_skill

	var gamelist_player_kills
	var gamelist_player_death
	var gamelist_player_kills_text
	var gamelist_player_death_text
	var gamelist_player_place
	var gamelist_player_place_text
	var gamelist_player_rating
	var gamelist_player_rating_text
	var gamelist_player_duration
	var gamelist_player_duration_text
	var gamelist_player_items
	var gamelist_player_items_row_1
	var gamelist_player_items_row_2
	var gamelist_player_items_array = [] 
	var gamelist_player_date_text
	var gamelist_player_year_text
	var gamelist_player_date



	for (var i = 1; i <= Object.keys(server_data.player_matches).length; i++) 
	{
		gamelist_player_label = $.CreatePanel("Panel",gamelist_label,"gamelist_player_label"+i)
		gamelist_player_label.AddClass("gamelist_player_label")

		
		gamelist_player_hero = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_hero"+i)
		gamelist_player_hero.AddClass("gamelist_player_hero_skill")

		gamelist_player_skill = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_skill"+i)
		gamelist_player_skill.AddClass("gamelist_player_hero_skill")


		gamelist_player_hero_icon = $.CreatePanel("Panel",gamelist_player_hero,"gamelist_player_hero_icon"+i)
		gamelist_player_hero_icon.AddClass("gamelist_player_hero")

		gamelist_player_skill_icon = $.CreatePanel("Panel",gamelist_player_skill,"gamelist_player_skill_icon"+i)
		gamelist_player_skill_icon.AddClass("gamelist_player_skill")

		var hero = server_data.player_matches[i].hero


		if (server_data.player_matches[i].orange_talent ) {
		    //const data = Game.FindUpgradeByName(hero, server_data.player_matches[i].orange_talent)
		        gamelist_player_skill_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/'  + hero +'/' + server_data.player_matches[i].orange_talent + '.png")'
		}


		gamelist_player_skill_icon.style.backgroundSize = "contain";


		gamelist_player_hero_icon.style.backgroundImage = "url('file://{images}/heroes/icons/" + hero + ".png')"
		gamelist_player_hero_icon.style.backgroundSize = "contain";



		gamelist_player_items = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_items"+i)
		gamelist_player_items.AddClass("gamelist_items")



		gamelist_player_items_row_1 = $.CreatePanel("Panel",gamelist_player_items,"gamelist_player_items_row_1"+i)
		gamelist_player_items_row_1.AddClass("gamelist_items_row")

		gamelist_player_items_row_2 = $.CreatePanel("Panel",gamelist_player_items,"gamelist_player_items_row_2"+i)
		gamelist_player_items_row_2.AddClass("gamelist_items_row")



		const items = server_data.player_matches[i].items
		if (items)
		    for (var j = 0; j <= 6; j++) {
		        var row = j <= 2 ? gamelist_player_items_row_1 : gamelist_player_items_row_2
		        $.CreatePanel("DOTAItemImage",row,"gamelist_item_"+i+"_"+(j-1)).itemname = items[j]
		    }








		gamelist_player_kills = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_kills"+i)
		gamelist_player_kills.AddClass("gamelist_player_stat")


		gamelist_player_kills_text = $.CreatePanel("Label",gamelist_player_kills,"gamelist_player_kills_text"+i)
		gamelist_player_kills_text.AddClass("gamelist_number")
		gamelist_player_kills_text.text = server_data.player_matches[i].kills +'  /  ' + server_data.player_matches[i].deaths

		if ((server_data.player_matches[i].kills >= 10)&&(server_data.player_matches[i].deaths >= 10))
		{
			gamelist_player_kills_text.style.fontSize = "20px"
		}


		gamelist_player_place = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_place"+i)
		gamelist_player_place.AddClass("gamelist_player_stat_place")

		gamelist_player_place_text = $.CreatePanel("Label",gamelist_player_place,"gamelist_player_place_text"+i)

		gamelist_player_place_text.AddClass("gamelist_number_place")

		gamelist_player_place_text.AddClass("stats_text_color_" + server_data.player_matches[i].place)
		gamelist_player_place_text.text = server_data.player_matches[i].place

		gamelist_player_rating = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_rating"+i)
		gamelist_player_rating.AddClass("gamelist_player_stat_rating")
		
		gamelist_player_rating_text = $.CreatePanel("Label",gamelist_player_rating,"gamelist_player_rating_text"+i)
		gamelist_player_rating_text.AddClass("gamelist_number_rating")

		let rating = server_data.player_matches[i].rating || 0

		gamelist_player_rating_text.text = String(rating)

		if (rating >= 0)
		{
			gamelist_player_rating_text.AddClass("gamelist_number_rating_0")
			gamelist_player_rating_text.text = '+' + String(Math.abs(rating))
		}
		else
		{
			gamelist_player_rating_text.AddClass("gamelist_number_rating_1")
			gamelist_player_rating_text.text = '-' + String(Math.abs(rating))
		}


		let duration = server_data.player_matches[i].endTime
		
		var min = Math.trunc((duration)/60) 
		var sec_n =  (duration) - 60*Math.trunc((duration)/60) 

		var hour = String( Math.trunc((min)/60) )

		var min = String(min - 60*( Math.trunc(min/60) ))

		var sec = String(sec_n)
		if (sec_n < 10) 
		{
			sec = '0' + sec

		}
		if (min < 10) 
		{
			min = '0' + min

		}




		gamelist_player_duration = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_duration"+i)
		gamelist_player_duration.AddClass("gamelist_player_duration")

		gamelist_player_duration_text = $.CreatePanel("Label",gamelist_player_duration,"gamelist_player_duration_text"+i)
		gamelist_player_duration_text.AddClass("gamelist_number")
		if (hour > 0)
		{
			gamelist_player_duration_text.text =	hour + ':' + min + ':' + sec
		}
		else 
		{

			gamelist_player_duration_text.text =  min + ':' + sec
		}

		gamelist_player_date = $.CreatePanel("Panel",gamelist_player_label,"gamelist_player_date"+i)
		gamelist_player_date.AddClass("gamelist_player_date")

		gamelist_player_date_text = $.CreatePanel("Label",gamelist_player_date,"gamelist_player_date_text"+i)
		gamelist_player_date_text.AddClass("gamelist_date")

		gamelist_player_year_text = $.CreatePanel("Label",gamelist_player_date,"gamelist_player_year_text"+i)
		gamelist_player_year_text.AddClass("gamelist_date")



		var date = new Date(Number(server_data.player_matches[i].date))

		gamelist_player_date_text.text = padNumber(date.getUTCHours()) + ':' + padNumber(date.getUTCMinutes())
		gamelist_player_year_text.text = padNumber(date.getUTCDate()) + "/"  + padNumber(date.getUTCMonth()) + "/" + date.getUTCFullYear()
	}

}




function Sort_Games(player_matches,cb)
{
	var gamelist_label = $("#gamelist_label")


	for (var i = 1; i <= Object.keys(player_matches).length; i++) 
	{
		const panel = $("#gamelist_player_label"+i)
		const value = player_matches[i]

		for (var j = 1; j <= Object.keys(player_matches).length; j++) 
		{
			if (i === j)
			{
				continue
			}


			const panel_2 = $("#gamelist_player_label"+j)
			
			const v = player_matches[j]


			if (cb(value,v))
			{
				gamelist_label.MoveChildAfter(panel,panel_2)
			}
		}
	}	
}













function init_leaderboard()
{
	if (chosen_label == 4) {return}
	chosen_label = 4

		Game.EmitSound("UI.Click_Hero")
	
	var server_data_info = CustomNetTables.GetTableValue("server_data", "")
	var server_data = CustomNetTables.GetTableValue("server_data",  Game.GetLocalPlayerID().toString());

	var rating = 1000

	var medal_number = server_data.ranked_tier
	var calibration_games = server_data.competitive_calibration_games_remaining

	
	if (server_data !== undefined )
	{
		rating = String(server_data.rating)
	}

	var leaderboard = CustomNetTables.GetTableValue("leaderboard", "leaderboard");

	var rating_50 = 999999
	var rating_10 = 999999
	var rating_1 = 999999


	if (leaderboard != undefined)
	{
		if (leaderboard[50] != undefined)
		{
			rating_50 = leaderboard[50].rating
		}
		if (leaderboard[10] != undefined)
		{
			rating_10 = leaderboard[10].rating
		}
		if (leaderboard[1] != undefined)
		{
			rating_1 = leaderboard[1].rating
		}
	}
	
	if (rating >= rating_1)
	{
		medal_number = 10
	}else 
		{
		if (rating >= rating_10)
		{
			medal_number = 9
		}else 
			{
			if (rating >= rating_50)
			{
				medal_number = 8
			}
		}
	}

	var button_leaderboard = $.GetContextPanel().FindChildTraverse("info_button_leaderboard")
	
	clear_window(button_leaderboard)

	var content = $.GetContextPanel().FindChildTraverse("info_window_content")
	var content_clearing =  $.CreatePanel("Panel",content,"content_clearing")
	content_clearing.AddClass("content_clearing")



	var text_label = $.CreatePanel("Panel",content_clearing,"text_label")
	text_label.AddClass("text_label")

	var text_2 = $.CreatePanel("Label",text_label,"text_2")
	text_2.AddClass("text_leaderboard")

	var medal = $.CreatePanel("Label",text_label,"text_2")
	medal.AddClass("rank_medal")


	if (calibration_games <= 0)
	{
    	text_2.text = $.Localize("#rating") + '  ' + rating
	}
	else 
	{
    	text_2.text = $.Localize("#rating") + ' ' + $.Localize("#calibration") + ' (' + String(calibration_games)  + ')'
    	medal_number = 0
	}


	medal.AddClass("rank_medal_" + String(medal_number))





	var text_1 = $.CreatePanel("Label",text_label,"text_1")
	text_1.AddClass("text_leaderboard_right")
    text_1.text = $.Localize("#Season_start") + '  ' + $.Localize(server_data_info ? server_data_info.season_name : "#Beta_Test")


    var leaderboard_stat_info = $.CreatePanel("Panel",content_clearing,"leaderboard_stat_info")
    leaderboard_stat_info.AddClass("leaderboard_stat_info")


	var leaderboard_info_place = $.CreatePanel("Panel",leaderboard_stat_info,"leaderboard_info_place")
	leaderboard_info_place.AddClass("leaderboard_stat_info_place")


	var leaderboard_info_place_text = $.CreatePanel("Label",leaderboard_info_place,"leaderboard_info_place_text")
	leaderboard_info_place_text.AddClass("leaderboard_stat_info_text")
    leaderboard_info_place_text.text = "#"


	var leaderboard_info_rating = $.CreatePanel("Panel",leaderboard_stat_info,"leaderboard_info_rating")
	leaderboard_info_rating.AddClass("leaderboard_stat_info_rating")


	var leaderboard_info_rating_text = $.CreatePanel("Label",leaderboard_info_rating,"leaderboard_info_rating_text")
	leaderboard_info_rating_text.AddClass("leaderboard_stat_info_text")
    leaderboard_info_rating_text.text = $.Localize("#gamelist_rating")



	var leaderboard_info_games = $.CreatePanel("Panel",leaderboard_stat_info,"leaderboard_info_games")
	leaderboard_info_games.AddClass("leaderboard_stat_info_games")


	var leaderboard_info_games_text = $.CreatePanel("Label",leaderboard_info_games,"leaderboard_info_games_text")
	leaderboard_info_games_text.AddClass("leaderboard_stat_info_text")
    leaderboard_info_games_text.text = $.Localize("#gamelist_games")


	var leaderboard_info_player = $.CreatePanel("Panel",leaderboard_stat_info,"leaderboard_info_player")
	leaderboard_info_player.AddClass("leaderboard_stat_info_player")


	var leaderboard_info_player_text = $.CreatePanel("Label",leaderboard_info_player,"leaderboard_info_player_text")
	leaderboard_info_player_text.AddClass("leaderboard_stat_info_text")
    leaderboard_info_player_text.text = $.Localize("#gamelist_player")


	var leaderboard_info_hero = $.CreatePanel("Panel",leaderboard_stat_info,"leaderboard_info_hero")
	leaderboard_info_hero.AddClass("leaderboard_stat_info_hero")


	var leaderboard_info_hero_text = $.CreatePanel("Label",leaderboard_info_hero,"leaderboard_info_hero_text")
	leaderboard_info_hero_text.AddClass("leaderboard_stat_info_text")
    leaderboard_info_hero_text.text = $.Localize("#gamelist_hero")	


	var leaderboard_label = $.CreatePanel("Panel",content_clearing,"leaderboard_label")
	leaderboard_label.AddClass("leaderboard_label")

	var leaderboard_player_label
	var leaderboard_player_place
	var leaderboard_player_place_text
	var leaderboard_player_name
	var leaderboard_player_icon
	var leaderboard_player_games
	var leaderboard_player_games_text
	var leaderboard_player_rating
	var leaderboard_player_rating_text
	var leaderboard_player_name_text
	var leaderboard_player_hero
	var leaderboard_player_hero_label


	var leaderboard_data = CustomNetTables.GetTableValue("leaderboard",  "leaderboard");

	if (leaderboard_data == undefined) {return}


	for (var i = 1; i <= Object.keys(leaderboard_data).length; i++) 
	{
		var hero = leaderboard_data[i].favorite_hero
		var count = 0
		leaderboard_data[i].count_hero = 0

		for (var j = 1; j <= Object.keys(leaderboard_data).length; j++)
		{
			if (leaderboard_data[j].favorite_hero === hero)
			{
				count += 1
			}
		}
		leaderboard_data[i].count_hero = count
	}


	for (var i = 1; i <= Object.keys(leaderboard_data).length; i++) 
	{
		leaderboard_player_label = $.CreatePanel("Panel",leaderboard_label,"leaderboard_player_label"+i)
		leaderboard_player_label.AddClass("leaderboard_player_label")

		leaderboard_player_place = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_place"+i)
		leaderboard_player_place.AddClass("leaderboard_player_place")

		leaderboard_player_place_text = $.CreatePanel("Label",leaderboard_player_place,"leaderboard_player_place_text"+i)
		leaderboard_player_place_text.AddClass("leaderboard_number")
		leaderboard_player_place_text.text = String(i)
		


		leaderboard_player_rating = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_rating"+i)
		leaderboard_player_rating.AddClass("leaderboard_player_rating")

		leaderboard_player_rating_text = $.CreatePanel("Label",leaderboard_player_rating,"leaderboard_player_rating_text"+i)
		leaderboard_player_rating_text.AddClass("leaderboard_text")
		leaderboard_player_rating_text.text = leaderboard_data[i].rating





		leaderboard_player_games = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_games"+i)
		leaderboard_player_games.AddClass("leaderboard_player_games")

		leaderboard_player_games_text = $.CreatePanel("Label",leaderboard_player_games,"leaderboard_player_games_text"+i)
		leaderboard_player_games_text.AddClass("leaderboard_text")
		leaderboard_player_games_text.text = leaderboard_data[i].total_matches


		var leaderboard_player_icon = $.CreatePanel("DOTAAvatarImage",leaderboard_player_label,"leaderboard_player_icon"+i)
		leaderboard_player_icon.style.width = "7.3%"
    	leaderboard_player_icon.style.height = "90%"
    	leaderboard_player_icon.style.marginLeft = "1%"
    	leaderboard_player_icon.accountid = leaderboard_data[i].playerId


		leaderboard_player_name = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_name"+i)
		leaderboard_player_name.AddClass("leaderboard_player_name")
		leaderboard_player_name_text = $.CreatePanel("DOTAUserName",leaderboard_player_name,"leaderboard_player_name_text"+i)
		leaderboard_player_name_text.AddClass("leaderboard_name_text")
		leaderboard_player_name_text.accountid = leaderboard_data[i].playerId

		leaderboard_player_hero_label = $.CreatePanel("Panel",leaderboard_player_label,"leaderboard_player_hero_label"+i)
		leaderboard_player_hero_label.AddClass("leaderboard_player_hero_label")
		


		leaderboard_player_hero = $.CreatePanel("Panel",leaderboard_player_hero_label,"leaderboard_player_hero"+i)
		leaderboard_player_hero.AddClass("leaderboard_player_hero")
		

		var hero = leaderboard_data[i].favorite_hero

		if ((hero != null)&&(hero != ''))
		{
			leaderboard_player_hero.style.backgroundImage = "url('file://{images}/heroes/icons/" + hero + ".png')"
		}
		leaderboard_player_hero.style.backgroundSize = "contain";



	}


	//Sort(leaderboard_data , ((a,b)=> a.rating <= b.rating))
	//reset_leaderboard_buttons(leaderboard_data)
	
	
}


function reset_leaderboard_buttons(leaderboard_data)
{
	var leaderboard_info_games = $("#leaderboard_info_games")
	var leaderboard_info_rating = $("#leaderboard_info_rating")
	var leaderboard_info_hero = $("#leaderboard_info_hero")
	leaderboard_info_games.SetPanelEvent("onactivate", function() 
	{	
		reset_leaderboard_buttons(leaderboard_data)
		Sort(leaderboard_data , ((a,b)=> a.TotalGames <= b.TotalGames))
	});	


	leaderboard_info_rating.SetPanelEvent("onactivate", function() 
	{	
		reset_leaderboard_buttons(leaderboard_data)
		Sort(leaderboard_data , ((a,b)=> a.rating <= b.rating))
	});	

	leaderboard_info_hero.SetPanelEvent("onactivate", function() 
	{	
		reset_leaderboard_buttons(leaderboard_data)
		Sort(leaderboard_data , ((a,b)=> a.count_hero <= b.count_hero))
	});	

}


function Sort(leaderboard_data,cb)
{
	var leaderboard_label = $("#leaderboard_label")

	for (var i = 1; i <= Object.keys(leaderboard_data).length; i++) 
	{
		const panel = $("#leaderboard_player_label"+i)
		const value = leaderboard_data[i]

		for (var j = 1; j <= Object.keys(leaderboard_data).length; j++) 
		{
			if (i === j)
			{
				continue
			}


			const panel_2 = $("#leaderboard_player_label"+j)
			
			const v = leaderboard_data[j]


			if (cb(value,v))
			{
				leaderboard_label.MoveChildAfter(panel,panel_2)
			}
		}
	}	
}


var Hero_1 = null
var Hero_2 = null


function init_team_report() {
	var content_main = $.GetContextPanel().FindChildTraverse("reports_window_content")
	var content = $.GetContextPanel().FindChildTraverse("content_clearing_report")

	var report = CustomNetTables.GetTableValue("reports", Players.GetLocalPlayer());

	var player_count = 0
	for (var i = 0; i <= 24; i++) {
		var player_info = Game.GetPlayerInfo(i)
		if (player_info !== undefined && player_info.player_steamid !== "0")
			player_count++
	}

	var no_players = false //player_count < 1
	var not_valid = no_players || report.report < 1

	var reports_left = report.report

	Hero_1 = null
	Hero_2 = null

	if (content)
		content.DeleteAsync(0)


	content = $.CreatePanel("Panel", content_main, "content_clearing_report")
	content.AddClass("content_clearing")

	var top_label = $.CreatePanel("Panel", content, "top_label")
	top_label.AddClass("reports_top_label")

	var top_text = $.CreatePanel("Label", top_label, "top_text")
	top_text.AddClass("report_team_top")
	top_text.html = true
	top_text.text = $.Localize("#report_team_top")


	var hero_label_1 = $.CreatePanel("Panel", content, "hero_label_1")
	hero_label_1.AddClass("reports_hero_label")

	var mid_label = $.CreatePanel("Panel", content, "mid_label")
	mid_label.AddClass("reports_mid_label")

	var mid_text = $.CreatePanel("Label", mid_label, "mid_text")
	mid_text.AddClass("report_mid_text")
	mid_text.html = true

	if (reports_left < 1)
		top_text.text = $.Localize("#no_reports")

	if (no_players)
		top_text.text = $.Localize("#no_players_reports")



	if (!not_valid)
		mid_text.text = '+'

	var hero_label_2 = $.CreatePanel("Panel", content, "hero_label_2")
	hero_label_2.AddClass("reports_hero_label")
	hero_label_2.AddClass("report_border_white")

	var heroes = []
	var heroes2 = []

	var bottom_label = $.CreatePanel("Panel", content, "bottom_label")
	bottom_label.AddClass("reports_bottom_label")

	var bottom_label_left = $.CreatePanel("Panel", bottom_label, "bottom_label_left")
	bottom_label_left.AddClass("reports_bottom_left")

	var bottom_button = $.CreatePanel("Panel", bottom_label, "bottom_button")
	bottom_button.AddClass("reports_bottom_button")

	bottom_button.style.saturation = "0"
	bottom_button.style.washColor = "#666666";


	var bottom_button_text = $.CreatePanel("Label", bottom_button, "bottom_button_text")
	bottom_button_text.AddClass("reports_bottom_button_text")
	bottom_button_text.text = $.Localize("#Send_report")


	var bottom_left_text = $.CreatePanel("Label", bottom_label_left, "bottom_left_text")
	bottom_left_text.AddClass("reports_bottom_left_text")
	bottom_left_text.text = $.Localize("#Reports_left") + String(reports_left)


	bottom_button.SetPanelEvent("onactivate", function() {
		if ((Hero_1 === null) || (Hero_2 === null)) {
			return
		}

		Reports_window_hide()


		GameEvents.SendCustomGameEventToServer_custom("send_report", {
			Hero_1,
			Hero_2
		})
	});



	if (not_valid)
		return
	for (var i = 0; i <= 24; i++) {
		
		  if (i === Players.GetLocalPlayer())
            continue
        var player_info = Game.GetPlayerInfo(i)
        if (player_info === undefined || player_info.player_steamid === "0")
            continue

		heroes[i] = $.CreatePanel("Panel", hero_label_1, "hero" + i)
		heroes2[i] = $.CreatePanel("Panel", hero_label_2, "hero2" + i)
		heroes[i].AddClass("reports_hero_portrait")
		heroes2[i].AddClass("reports_hero_portrait")

		heroes[i].style.backgroundImage = "url('file://{images}/heroes/" + Players.GetPlayerSelectedHero(i) + ".png')"
		if (Players.GetPlayerSelectedHero(i) === 'invalid index')
			heroes[i].style.backgroundImage = "url('file://{images}/heroes/npc_dota_hero_juggernaut.png')"

		heroes2[i].style.backgroundImage = "url('file://{images}/heroes/" + Players.GetPlayerSelectedHero(i) + ".png')"
		if (Players.GetPlayerSelectedHero(i) === 'invalid index')
			heroes2[i].style.backgroundImage = "url('file://{images}/heroes/npc_dota_hero_juggernaut.png')"


		heroes[i].style.backgroundSize = "contain";
		heroes2[i].style.backgroundSize = "contain";
		heroes2[i].style.saturation = "0"
		heroes2[i].style.washColor = "#666666";

		set_report_player_1(heroes, heroes2, i)
		set_report_player_2(heroes2, bottom_button, i)
	}
}


function set_report_player_1(heroes, heroes2, i)
{
	heroes[i].SetPanelEvent("onactivate", function() 
	{	

		if (Hero_2 === i)
		{
			return
		}
		Game.EmitSound("UI.Click")
	

		Hero_1 = i
		for (var j = 0; j <= 24; j++) 
		{
			if (heroes[j])
			{
				heroes[j].style.saturation = "1"
				heroes[j].style.washColor = "none";

				if ((heroes[j]) && (j !== i))
				{	
					heroes[j].style.saturation = "0"
					heroes[j].style.washColor = "#666666";	
				}
			}
		}

		if (Hero_2 === null)
		{
			for (var j = 0; j <= 24; j++) 
			{
				if (heroes[j])
				{
					heroes2[j].style.saturation = "0"
					heroes2[j].style.washColor = "#666666";
					if (j !== Hero_1)
					{
						heroes2[j].style.saturation = "1"
						heroes2[j].style.washColor = "none";
					}
				}
			}
		}
	});	
}

function GetGameKeybind(command) {
    return Game.GetKeybindForCommand(command);
}

function set_report_player_2(heroes2, button, i)
{


	heroes2[i].SetPanelEvent("onactivate", function() 
	{	
		if ((Hero_1 === null)||(Hero_1 === i))
		{
			return
		} 
		Hero_2 = i
		Game.EmitSound("UI.Click")
		for (var j = 0; j <= 24; j++) 
		{		
			if (heroes2[j])
			{
				heroes2[j].style.saturation = "1"
				heroes2[j].style.washColor = "none";
				if ((heroes2[j]) && (j !== i))
				{	
					heroes2[j].style.saturation = "0"	
					heroes2[j].style.washColor = "#666666";
				}
			}
		}
		if ((Hero_1 !== null)&&(Hero_2 !== null))
		{
			button.style.saturation = "1"
			button.style.washColor = "none";
		}


	});	
}
init();



// new
function OpenItemsContent(panel)
{
    $("#ChooseCategory").style.visibility = "collapse"
    $("#CategoryPets").style.visibility = "collapse"
    $("#CategoryItems").style.visibility = "collapse"
    $("#CategoryCosmetics").style.visibility = "collapse"
    $("#ItemsList").style.visibility = "collapse"
    $("#HeroListItems").style.visibility = "visible"
    $.GetContextPanel().FindChildTraverse(panel).style.visibility = "visible"

    Game.EmitSound("UI.Shop_Category_Open")
}

function OpenInventoryContent(panel)
{
    $("#ChooseCategoryInventory").style.visibility = "collapse"
    $("#CategoryPetsInventory").style.visibility = "collapse"
    $("#CategoryItemsInventory").style.visibility = "collapse"
    $("#ItemsListInventory").style.visibility = "collapse"
    $("#HeroListItemsInventory").style.visibility = "visible"
    $.GetContextPanel().FindChildTraverse(panel).style.visibility = "visible"

    Game.EmitSound("UI.Shop_Category_Open")
}

function InitItems()
{
	let items_panel = $.GetContextPanel().FindChildTraverse("HeroListItems")
    if (items_panel)
    {
        items_panel.RemoveAndDeleteChildren()
        InitHeroesItems()
    }

    let cosmetics_panel = $.GetContextPanel().FindChildTraverse("CategoryCosmeticsContent")
    if (cosmetics_panel)
    {
        cosmetics_panel.RemoveAndDeleteChildren()
        InitCosmeticsItems(cosmetics_panel)
    }

	let CategoryPets = $.GetContextPanel().FindChildTraverse("CategoryPets")

	if (CategoryPets)
	{

		CategoryPets.RemoveAndDeleteChildren()

        let text_panel = $.CreatePanel("Panel", CategoryPets, "");
        text_panel.AddClass("pets_info_panel");

        let text_panel_text = $.CreatePanel("Label", text_panel, "");
        text_panel_text.AddClass("pets_info_text");
        text_panel_text.html = true

        text_panel_text.text = $.Localize("#pets_info_text")

		let pets_info_table = CustomNetTables.GetTableValue("shop_items", "pets")

		let new_table = []

		if (pets_info_table)
		{
		    for (var item = 1; item <= Object.keys(pets_info_table).length; item++)
		    {
		        new_table[item-1] = []
		        new_table[item-1].push(pets_info_table[item][1], pets_info_table[item][2], pets_info_table[item][3], pets_info_table[item][4], pets_info_table[item][5])
		    }

			new_table.sort(function (a, b) {
			  return Number(a[3])-Number(b[3])
			});

			for (var i = 0; i < new_table.length; i++)
			{
				if (HasItemInventory(new_table[i][0]))
				{
					CreateItemInShop(CategoryPets, new_table[i])
				}
			}

			for (var i = 0; i < new_table.length; i++)
			{
				if (!HasItemInventory(new_table[i][0]))
				{
					CreateItemInShop(CategoryPets, new_table[i])
				}
			}
		}    

	}
}

function InitCosmeticsItems(main_panel)
{

    if (selected_category == "tips")
    {
        InitTipsShop(main_panel)
    }
    else if (selected_category == "high_five")
    {
        InitHighFiveShop(main_panel)
    }
}

function InitHighFiveShop(main_panel)
{
    let high_five_info_table = CustomNetTables.GetTableValue("shop_items", "high_five")
    let high_five_js_table = []
    let high_five_container = CreateCosmeticSlotLine(main_panel, "high_five")
    var player_data_local = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer());

    for (var item = 1; item <= Object.keys(high_five_info_table).length; item++)
    {
        if (high_five_info_table[item][2] != 0)
        {
            high_five_js_table[item-1] = []
            high_five_js_table[item-1].push(high_five_info_table[item][1], high_five_info_table[item][2], high_five_info_table[item][3], high_five_info_table[item][4], high_five_info_table[item][5], high_five_info_table[item][6])   
        }
    }

    high_five_js_table.sort(function (a, b) 
    {
        return Number(a[3])-Number(b[3])
    });

    for (var i = 0; i < high_five_js_table.length; i++)
    {
        if (high_five_js_table[i])
        {
            if (HasItemInventory(high_five_js_table[i][0]))
            {
                CreateItemInShopCosmeticsHighFive(high_five_container, high_five_js_table[i], player_data_local)
            }
        }
    }

    for (var i = 0; i < high_five_js_table.length; i++)
    {
        if (high_five_js_table[i])
        {
            if (!HasItemInventory(high_five_js_table[i][0]))
            {
                CreateItemInShopCosmeticsHighFive(high_five_container, high_five_js_table[i], player_data_local)
            }
        }
    }
}

function InitTipsShop(main_panel)
{
    let tips_info_table = CustomNetTables.GetTableValue("shop_items", "tips")
    let tips_js_table = []
    let tips_container = CreateCosmeticSlotLine(main_panel, "tips")
    let player_tips_data = GetPlayerTips()
    for (var item = 1; item <= Object.keys(tips_info_table).length; item++)
    {
        if (tips_info_table[item][2] != 0)
        {
            tips_js_table[item-1] = []
            tips_js_table[item-1].push(tips_info_table[item][1], tips_info_table[item][2], tips_info_table[item][3], tips_info_table[item][4], tips_info_table[item][5], tips_info_table[item][6])   
        }
    }
    tips_js_table.sort(function (a, b) 
    {
        return Number(a[3])-Number(b[3])
    });
    for (var i = 0; i < tips_js_table.length; i++)
    {
        if (tips_js_table[i])
        {
            if (HasItemInventory(tips_js_table[i][0]))
            {
                CreateItemInShopCosmeticsTips(tips_container, tips_js_table[i], player_tips_data)
            }
        }
    }
    for (var i = 0; i < tips_js_table.length; i++)
    {
        if (tips_js_table[i])
        {
            if (!HasItemInventory(tips_js_table[i][0]))
            {
                CreateItemInShopCosmeticsTips(tips_container, tips_js_table[i], player_tips_data)
            }
        }
    }
}
function CreateItemInShopCosmeticsHighFive(panel, info, player_data_sub) 
{
 	var BlockItem = $.CreatePanel("Panel", panel, "item_id_" + info[0]);
	BlockItem.AddClass("BlockItemChat");
	var BlockItemImage = $.CreatePanel("Panel", BlockItem, "BlockItemImage");
	BlockItemImage.AddClass("BlockItemImageChat_high_five");
	var BlockItemLabel = $.CreatePanel("Label", BlockItem, "");
	BlockItemLabel.AddClass("BlockItemLabelChat");
	var BlockItemBuyButton = $.CreatePanel("Panel", BlockItem, "button");
	BlockItemBuyButton.AddClass("BlockItemBuyButtonChat");
	var BlockItemBuyButtonCenter = $.CreatePanel("Panel", BlockItemBuyButton, "");
	BlockItemBuyButtonCenter.AddClass("BlockItemBuyButtonCenter");
	var BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButtonCenter, "");
	BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabelChat");
	BlockItemBuyButtonLabel.text = $.Localize("#shop_buy")
	BlockItemBuyButtonLabel.style.marginRight = "8px"
	var shardcost_icon = $.CreatePanel("Panel", BlockItemBuyButtonCenter, "");
	shardcost_icon.AddClass("shardcost_icon");
	var BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButtonCenter, "");
	BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel");
	BlockItemBuyButtonLabel.text = info[3]
	var player_data_local = player_table_shop

	if (info)
	{

        BlockItem.SetPanelEvent('onmouseover', function() 
        {
            var BlockHoverPanel = $.CreatePanel("Panel", $.GetContextPanel().FindChildTraverse("CategoryCosmeticsVideo"), "BlockHoverPanel");
            BlockHoverPanel.AddClass("BlockHoverPanel");
            BlockHoverPanel.hittest = false;
            var width = 300
            var height = 185;
            BlockHoverPanel.style.width = String(width) + 'px';
            BlockHoverPanel.style.height = String(height) + 'px';
            var x = BlockItem.actualxoffset + BlockItem.actuallayoutwidth + 20
            var y = BlockItem.actualyoffset + BlockItem.actuallayoutheight/2 + 30

            if ((x + width) > BlockItem.GetParent().actuallayoutwidth)
            {
                x = BlockItem.actualxoffset - width*BlockItem.actualuiscale_x - 20
                BlockHoverPanel.AddClass("BlockHoverPanelLeft")
            }else 
            {
                BlockHoverPanel.AddClass("BlockHoverPanelRight")
            }

            BlockHoverPanel.SetPositionInPixels(x/BlockItem.actualuiscale_x , y/BlockItem.actualuiscale_y, 0)

            if ((info[1] == 10 || info[1] == '10') && !HasItemInventory(info[0]))
            {
                Game.EmitSound("HighFive.Midas_cast")
            }

            var video = $.CreatePanel("MoviePanel", BlockHoverPanel, 'video', 
            {
                style: "",
                src: "file://{resources}/"+ info[5],
                repeat: "true",
                hittest: "false",
                autoplay: "onload"
            });
            video.AddClass("BlockHoverPanelVideo")
        });

        BlockItem.SetPanelEvent('onmouseout', function() 
        {
            let BlockHoverPanel = $.GetContextPanel().FindChildTraverse("BlockHoverPanel")

            if (BlockHoverPanel)
                BlockHoverPanel.DeleteAsync(0)
        });

		if (HasItemInventory(info[0]))
		{
			BlockItemBuyButton.style.visibility = "collapse"
			BlockItem.AddClass("BlockItem_purchased")
			var BlockItemActivateButton = $.CreatePanel("Panel", BlockItem, "button_activate");
			BlockItemActivateButton.AddClass("BlockItemBuyButtonChat");
			var BlockItemActivateButtonLabel = $.CreatePanel("Label", BlockItemActivateButton, "BlockItemActivateButtonLabel");
			BlockItemActivateButtonLabel.AddClass("BlockItemBuyButtonLabel");
            let check_active = false
            if (GetCurrentHighFive(info[1], player_data_sub))
            {
                check_active = true
            }
            if (check_active)
            {
                BlockItemActivateButtonLabel.text = $.Localize("#shop_unequip")
                SetHighFiveUpdate(BlockItem, info[1], true)
                BlockItemActivateButton.AddClass("BlockItemBuyButton_unequip")
                BlockItemActivateButton.RemoveClass("BlockItemBuyButton_equip")
            }
            else
            {
                BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
                SetHighFiveUpdate(BlockItem, info[1])
                BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
                BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
            }
		} 
		else 
		{
			if (player_data_local && player_data_local["points"] >= info[3])
			{
				BlockItemBuyButton.RemoveClass("BlockItemBuyButton_nomoney")
				BlockItemBuyButton.AddClass("BlockItemBuyButton_money")
				BlockItemBuyButtonLabel.RemoveClass("BlockItemBuyButtonLabel_nomoney")
				BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel")
				BlockItem.AddClass("BlockItem_money")
				BlockItem.RemoveClass("BlockItem_nomoney")
				BlockItem.SetPanelEvent("onactivate", function() 
				{ 
					CreateBuyWindow(info[0], info[3], info[2], 0, null, null, null, info[1])
				})
			} 
			else 
			{
				BlockItem.RemoveClass("BlockItem_money")
				BlockItem.AddClass("BlockItem_nomoney")
				BlockItemBuyButton.AddClass("BlockItemBuyButton_nomoney")
				BlockItemBuyButton.RemoveClass("BlockItemBuyButton_money")
				BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel_nomoney")
				BlockItemBuyButtonLabel.RemoveClass("BlockItemBuyButtonLabel")
			}
            if (!PLAYER_VIEW_ITEMS_FOR_BUY)
            {
                BlockItem.style.visibility = "collapse"
            }
		}
		BlockItemLabel.text = $.Localize("#" + info[2])
		BlockItemImage.style.backgroundImage = 'url("' + info[4] + '")';
		BlockItemImage.style.backgroundSize = "100%"
	}
}

function GetCurrentHighFive(id, sub_data)
{
    if (sub_data && sub_data.selected_high_five == id)
    {
        return true
    }
    return false
}

function CreateItemInShopCosmeticsTips(panel, info, player_tips_data) 
{
 	var BlockItem = $.CreatePanel("Panel", panel, "item_id_" + info[0]);
	BlockItem.AddClass("BlockItemChat");
	var BlockItemImage = $.CreatePanel("Panel", BlockItem, "BlockItemImage");
	BlockItemImage.AddClass("BlockItemImageChat");
	var BlockItemLabel = $.CreatePanel("Label", BlockItem, "");
	BlockItemLabel.AddClass("BlockItemLabelChat");
	var BlockItemBuyButton = $.CreatePanel("Panel", BlockItem, "button");
	BlockItemBuyButton.AddClass("BlockItemBuyButtonChat");
	var BlockItemBuyButtonCenter = $.CreatePanel("Panel", BlockItemBuyButton, "");
	BlockItemBuyButtonCenter.AddClass("BlockItemBuyButtonCenter");
	var BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButtonCenter, "");
	BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabelChat");
	BlockItemBuyButtonLabel.text = $.Localize("#shop_buy")
	BlockItemBuyButtonLabel.style.marginRight = "8px"
	var shardcost_icon = $.CreatePanel("Panel", BlockItemBuyButtonCenter, "");
	shardcost_icon.AddClass("shardcost_icon");
	var BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButtonCenter, "");
	BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel");
	BlockItemBuyButtonLabel.text = info[3]
	var player_data_local = player_table_shop

	if (info)
	{
        BlockItem.SetPanelEvent('onmouseover', function() 
        {


            var BlockHoverPanel = $.CreatePanel("Panel", $.GetContextPanel().FindChildTraverse("CategoryCosmeticsVideo"), "BlockHoverPanel");
            BlockHoverPanel.AddClass("BlockHoverPanel");
            BlockHoverPanel.hittest = false;

            var width = 300
            var height = 185;
            BlockHoverPanel.style.width = String(width) + 'px';
            BlockHoverPanel.style.height = String(height) + 'px';

            var x = BlockItem.actualxoffset + BlockItem.actuallayoutwidth + 20
            var y = BlockItem.actualyoffset + BlockItem.actuallayoutheight/2 + 30

            if ((x + width) > BlockItem.GetParent().actuallayoutwidth)
            {
                x = BlockItem.actualxoffset - width*BlockItem.actualuiscale_x - 20
                BlockHoverPanel.AddClass("BlockHoverPanelLeft")
            }else 
            {
                BlockHoverPanel.AddClass("BlockHoverPanelRight")
            }

            BlockHoverPanel.SetPositionInPixels(x/BlockItem.actualuiscale_x , y/BlockItem.actualuiscale_y, 0)

            var video = $.CreatePanel("MoviePanel", BlockHoverPanel, 'video', 
            {
                style: "",
                src: "file://{resources}/"+ info[5],
                repeat: "true",
                hittest: "false",
                autoplay: "onload"
            });
            video.AddClass("BlockHoverPanelVideo")
        });

        BlockItem.SetPanelEvent('onmouseout', function() 
        {
            let BlockHoverPanel = $.GetContextPanel().FindChildTraverse("BlockHoverPanel")

            if (BlockHoverPanel)
                BlockHoverPanel.DeleteAsync(0)
        });

		if (HasItemInventory(info[0]))
		{
			BlockItemBuyButton.style.visibility = "collapse"
			BlockItem.AddClass("BlockItem_purchased")
			var BlockItemActivateButton = $.CreatePanel("Panel", BlockItem, "button_activate");
			BlockItemActivateButton.AddClass("BlockItemBuyButtonChat");
			var BlockItemActivateButtonLabel = $.CreatePanel("Label", BlockItemActivateButton, "BlockItemActivateButtonLabel");
			BlockItemActivateButtonLabel.AddClass("BlockItemBuyButtonLabel");
            let check_active = false
            if (player_tips_data != null)
            {
                if (GetPlayerTips(info[1]))
                {
                    check_active = true
                }
            }
            if (check_active)
            {
                BlockItemActivateButtonLabel.text = $.Localize("#shop_unequip")
                SetTipUpdate(BlockItem, info[1], true)
                BlockItemActivateButton.AddClass("BlockItemBuyButton_unequip")
                BlockItemActivateButton.RemoveClass("BlockItemBuyButton_equip")
            }
            else
            {
                BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
                SetTipUpdate(BlockItem, info[1])
                BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
                BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
            }
		} 
		else 
		{
			if (player_data_local && player_data_local["points"] >= info[3])
			{
				BlockItemBuyButton.RemoveClass("BlockItemBuyButton_nomoney")
				BlockItemBuyButton.AddClass("BlockItemBuyButton_money")
				BlockItemBuyButtonLabel.RemoveClass("BlockItemBuyButtonLabel_nomoney")
				BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel")
				BlockItem.AddClass("BlockItem_money")
				BlockItem.RemoveClass("BlockItem_nomoney")
				BlockItem.SetPanelEvent("onactivate", function() 
				{ 
					CreateBuyWindow(info[0], info[3], info[2], 0, null, null, null, info[1])
				})
			} 
			else 
			{
				BlockItem.RemoveClass("BlockItem_money")
				BlockItem.AddClass("BlockItem_nomoney")
				BlockItemBuyButton.AddClass("BlockItemBuyButton_nomoney")
				BlockItemBuyButton.RemoveClass("BlockItemBuyButton_money")
				BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel_nomoney")
				BlockItemBuyButtonLabel.RemoveClass("BlockItemBuyButtonLabel")
			}
            if (!PLAYER_VIEW_ITEMS_FOR_BUY)
            {
                BlockItem.style.visibility = "collapse"
            }
		}
		BlockItemLabel.text = $.Localize("#" + info[2])
		BlockItemImage.style.backgroundImage = 'url("' + info[4] + '")';
		BlockItemImage.style.backgroundSize = "100%"
	}
}

function GetPlayerTips(item_id)
{
    let player_table = player_table_shop
	if (player_table && player_table.player_tips)
	{
		for (var d = 1; d <= Object.keys(player_table.player_tips).length; d++) 
		{
			if (player_table.player_tips[d])
			{
				if (String(player_table.player_tips[d]) == String(item_id))
				{
					return true
				}
			}
		}
	}
	return false
}

function SetTipUpdate(panel, tip_id, fdelete)
{
    panel.SetPanelEvent("onactivate", function() 
    { 
        if (fdelete == null)
        {
            Game.EmitSound("UI.Shop_Buy_equip")
            GameEvents.SendCustomGameEventToServer_custom( "update_tip_list", {tip_id: tip_id, delete : false} );
        }
        else
        {
            Game.EmitSound("UI.Shop_Buy_unequip")
            GameEvents.SendCustomGameEventToServer_custom( "update_tip_list", {tip_id: tip_id, delete : true} );
        }
        $.Schedule( 0.35, function()
        {
            InitItems()
        })
    }); 
}

function SetHighFiveUpdate(panel, high_five, fdelete)
{
    panel.SetPanelEvent("onactivate", function() 
    { 
        if (fdelete == null)
        {
            Game.EmitSound("UI.Shop_Buy_equip")
            GameEvents.SendCustomGameEventToServer_custom( "select_current_high_five", {high_five_id: high_five} );
        }
        else
        {
            Game.EmitSound("UI.Shop_Buy_unequip")
            GameEvents.SendCustomGameEventToServer_custom( "select_current_high_five", {high_five_id: 0} );
        }
        $.Schedule( 0.35, function()
        {
            InitItems()
        })
    }); 
}

function CreateCosmeticSlotLine(panel, name)
{
    let panels_category_swap = $.CreatePanel("Panel", panel, "");
    panels_category_swap.AddClass("panels_category_swap");

    let panels_category_swap_buttons = $.CreatePanel("Panel", panels_category_swap, "");
    panels_category_swap_buttons.AddClass("panels_category_swap_buttons");

    if (name == "tips")
    {   
        let keybind_panel = $.CreatePanel("Panel", panel, "");
        keybind_panel.AddClass("keybind_panel");

        let keybind_tip_name = $.CreatePanel("Label", keybind_panel, "");
        keybind_tip_name.AddClass("keybind_name");
        keybind_tip_name.html = true
        keybind_tip_name.text = $.Localize("#button_second_wheel") + " <b><font color='#f1b257'>" + GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL2) + "</font></b>"

        let keybind_tip_name_info = $.CreatePanel("Label", keybind_panel, "");
        keybind_tip_name_info.AddClass("keybind_name_info");
        keybind_tip_name_info.html = true
        keybind_tip_name_info.text = $.Localize("#button_second_wheel_info") 
    }


    if (name == "high_five")
    {   
        let keybind_panel = $.CreatePanel("Panel", panel, "");
        keybind_panel.AddClass("keybind_panel");

        let keybind_tip_name = $.CreatePanel("Label", keybind_panel, "");
        keybind_tip_name.AddClass("keybind_name");
        keybind_tip_name.html = true
        keybind_tip_name.text = $.Localize("#button_high_five") + " <b><font color='#f1b257'>" + GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP4) + "</font></b>"

        let keybind_tip_name_info = $.CreatePanel("Label", keybind_panel, "");
        keybind_tip_name_info.AddClass("keybind_name_info");
        keybind_tip_name_info.html = true
        keybind_tip_name_info.text = $.Localize("#button_high_five_info") 
    }


    let slot_panel = $.CreatePanel("Panel", panel, "");
    slot_panel.AddClass("slot_panel");

    let active_buttons_category_tips = $.CreatePanel("Panel", panels_category_swap_buttons, "");
    active_buttons_category_tips.AddClass("active_buttons_category");
    active_buttons_category_tips.AddClass("active_buttons_category_first");

    let active_buttons_category_tips_icon = $.CreatePanel("Panel", active_buttons_category_tips, "");
    active_buttons_category_tips_icon.AddClass("active_buttons_category_icon");
    active_buttons_category_tips_icon.AddClass("active_buttons_category_tip_icon");

    let active_buttons_category_tips_label = $.CreatePanel("Label", active_buttons_category_tips, "");
    active_buttons_category_tips_label.AddClass("active_buttons_category_label")
    active_buttons_category_tips_label.html = true
    active_buttons_category_tips_label.text = $.Localize("#tips")

    let active_buttons_category_five = $.CreatePanel("Panel", panels_category_swap_buttons, "");
    active_buttons_category_five.AddClass("active_buttons_category");
    active_buttons_category_five.AddClass("active_buttons_category_not_first");

    let active_buttons_category_five_icon = $.CreatePanel("Panel", active_buttons_category_five, "");
    active_buttons_category_five_icon.AddClass("active_buttons_category_icon");
    active_buttons_category_five_icon.AddClass("active_buttons_category_high_five_icon");

    let active_buttons_category_five_label = $.CreatePanel("Label", active_buttons_category_five, "");
    active_buttons_category_five_label.AddClass("active_buttons_category_label")
    active_buttons_category_five_label.html = true
    active_buttons_category_five_label.text = $.Localize("#high_five")

    active_buttons_category_tips.SetPanelEvent("onactivate", function() 
    { 
        Game.EmitSound("UI.Click")
        let cosmetics_panel = $.GetContextPanel().FindChildTraverse("CategoryCosmeticsContent")
        if (cosmetics_panel)
        {
            selected_category = "tips"
            cosmetics_panel.RemoveAndDeleteChildren()
            InitTipsShop(cosmetics_panel)
        }
    })
    active_buttons_category_five.SetPanelEvent("onactivate", function() 
    { 
        Game.EmitSound("UI.Click")
        let cosmetics_panel = $.GetContextPanel().FindChildTraverse("CategoryCosmeticsContent")
        if (cosmetics_panel)
        {
            selected_category = "high_five"
            cosmetics_panel.RemoveAndDeleteChildren()
            InitHighFiveShop(cosmetics_panel)
        }
    })
    if (name == "tips")
    {
        active_buttons_category_tips.AddClass("active_buttons_category_current");
        active_buttons_category_tips_label.AddClass("active_buttons_category_label_current");
        active_buttons_category_tips_icon.AddClass("active_buttons_category_icon_current_tip");
    }
    else if (name == "high_five")
    {
        active_buttons_category_five.AddClass("active_buttons_category_current");
        active_buttons_category_five_label.AddClass("active_buttons_category_label_current");
        active_buttons_category_five_icon.AddClass("active_buttons_category_icon_current_high_five");
    }
    let main_parent = $.CreatePanel("Panel", slot_panel, "panel_"+name);
    main_parent.AddClass("SlotType");
    return main_parent
}

function InitInventory()
{

	let items_panel = $.GetContextPanel().FindChildTraverse("HeroListItemsInventory")
    if (items_panel)
    {
        items_panel.RemoveAndDeleteChildren()
        InitHeroesItemsInventory()
    }


	let CategoryPetsInventory = $.GetContextPanel().FindChildTraverse("CategoryPetsInventory")

	if (CategoryPetsInventory)
	{
		CategoryPetsInventory.RemoveAndDeleteChildren()

		let pets_info_table = CustomNetTables.GetTableValue("shop_items", "pets")

		if (pets_info_table)
		{
			for (var i = 1; i <= Object.keys(pets_info_table).length; i++)
			{
				if (HasItemInventory(pets_info_table[i][1]))
				{
					CreateItemInventory(CategoryPetsInventory, pets_info_table[i])
				}
			}
		}
	}
}

function CreateItemInventory(panel, info) 
{
 	var BlockItem = $.CreatePanel("Panel", panel, "item_id_" + info[1]);
	BlockItem.AddClass("BlockItem");
	BlockItem.AddClass("BlockItem_purchased");

	var BlockItemImage = $.CreatePanel("Panel", BlockItem, "BlockItemImage");
	BlockItemImage.AddClass("BlockItemImage");

	var BlockItemLabel = $.CreatePanel("Label", BlockItem, "");
	BlockItemLabel.AddClass("BlockItemLabel");

	var player_data_local = player_table_shop

	var BlockItemActivateButton = $.CreatePanel("Panel", BlockItem, "button");
	BlockItemActivateButton.AddClass("BlockItemActivateButton");


	var BlockItemActivateButtonLabel = $.CreatePanel("Label", BlockItemActivateButton, "BlockItemActivateButtonLabel");
	BlockItemActivateButtonLabel.AddClass("BlockItemBuyButtonLabel");


	if (player_data_local && player_data_local.pet_id)
	{
		if (player_data_local.pet_id == info[2])
		{
			courier_selected = player_data_local.pet_id;
			BlockItemActivateButtonLabel.text = $.Localize("#shop_unequip")
			SetPetInventory(BlockItem, info[2], info[1])

			BlockItemActivateButton.AddClass("BlockItemBuyButton_unequip")
			BlockItemActivateButton.RemoveClass("BlockItemBuyButton_equip")
		}
		else
		{
			courier_selected = player_data_local.pet_id;
			BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
			SetPetInventory(BlockItem, info[2], info[1])

			BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
			BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
		}
	}
	else
	{
		courier_selected = 0;
		BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
		SetPetInventory(BlockItem, info[2], info[1])

		BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
		BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
	}

	BlockItemLabel.text = $.Localize("#" + info[3])
	BlockItemImage.style.backgroundImage = 'url("' + info[5] + '")';
	BlockItemImage.style.backgroundSize = "100%"
}
function CreateItemInShop(panel, info) 
{

 	var BlockItem = $.CreatePanel("Panel", panel, "item_id_" + info[0]);
	BlockItem.AddClass("BlockItem");

	var BlockItemImage = $.CreatePanel("Panel", BlockItem, "BlockItemImage");
	BlockItemImage.AddClass("BlockItemImage");


	var BlockItemLabel = $.CreatePanel("Label", BlockItem, "");
	BlockItemLabel.AddClass("BlockItemLabel");

	var BlockItemBuyButton = $.CreatePanel("Panel", BlockItem, "button");
	BlockItemBuyButton.AddClass("BlockItemBuyButton");

	var BlockItemBuyButtonCenter = $.CreatePanel("Panel", BlockItemBuyButton, "");
	BlockItemBuyButtonCenter.AddClass("BlockItemBuyButtonCenter");


	var BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButtonCenter, "");
	BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel");
	BlockItemBuyButtonLabel.text = $.Localize("#shop_buy")
	BlockItemBuyButtonLabel.style.marginRight = "8px"

	var shardcost_icon = $.CreatePanel("Panel", BlockItemBuyButtonCenter, "");
	shardcost_icon.AddClass("shardcost_icon");

	var BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButtonCenter, "");
	BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel");
	BlockItemBuyButtonLabel.text = info[3]

	var player_data_local = player_table_shop

	if (info)
	{
		if (HasItemInventory(info[0]))
		{
			BlockItemBuyButton.style.visibility = "collapse"
			BlockItem.AddClass("BlockItem_purchased")
			
			var BlockItemActivateButton = $.CreatePanel("Panel", BlockItem, "button_activate");
			BlockItemActivateButton.AddClass("BlockItemBuyButton");

			var BlockItemActivateButtonLabel = $.CreatePanel("Label", BlockItemActivateButton, "BlockItemActivateButtonLabel");
			BlockItemActivateButtonLabel.AddClass("BlockItemBuyButtonLabel");

			if (player_data_local && player_data_local.pet_id)
			{
				if (player_data_local.pet_id == info[1])
				{
					courier_selected = player_data_local.pet_id;
					BlockItemActivateButtonLabel.text = $.Localize("#shop_unequip")
					SetPetInventory(BlockItem, info[1], info[0])
					BlockItemActivateButton.AddClass("BlockItemBuyButton_unequip")
					BlockItemActivateButton.RemoveClass("BlockItemBuyButton_equip")
				}
				else
				{
					courier_selected = player_data_local.pet_id;
					BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
					SetPetInventory(BlockItem, info[1], info[0])
					BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
					BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
				}
			}
			else
			{
				courier_selected = 0;
				BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
				SetPetInventory(BlockItem, info[1], info[0])
				BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
				BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
			}
		} 
		else 
		{
			if (player_data_local)
			{
                if (player_data_local["points"] >= info[3])
                {
    				BlockItemBuyButton.RemoveClass("BlockItemBuyButton_nomoney")
    				BlockItemBuyButton.AddClass("BlockItemBuyButton_money")
    				
    				BlockItemBuyButtonLabel.RemoveClass("BlockItemBuyButtonLabel_nomoney")
    				BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel")

				    BlockItem.AddClass("BlockItem_money")
				    BlockItem.RemoveClass("BlockItem_nomoney")
                }else
                {
                    BlockItem.RemoveClass("BlockItem_money")
                    BlockItem.AddClass("BlockItem_nomoney")

                    BlockItemBuyButton.AddClass("BlockItemBuyButton_nomoney")
                    BlockItemBuyButton.RemoveClass("BlockItemBuyButton_money")

                    BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel_nomoney")
                    BlockItemBuyButtonLabel.RemoveClass("BlockItemBuyButtonLabel") 
                }
				BlockItem.SetPanelEvent("onactivate", function() 
				{ 
					CreateBuyWindow(info[0], info[3], info[2], 0, null, (player_data_local["points"] < info[3]), null, null, 1)
				})
			} 
			else 
			{

			}
            if (!PLAYER_VIEW_ITEMS_FOR_BUY)
            {
                BlockItem.style.visibility = "collapse"
            }
		}

		BlockItemLabel.text = $.Localize("#" + info[2])
		BlockItemImage.style.backgroundImage = 'url("' + info[4] + '")';
		BlockItemImage.style.backgroundSize = "100%"
	}
}
function SelectCourier(num, id)
{
    if (courier_selected != num)
    {
    	Game.EmitSound("UI.Shop_Buy_equip")
        GameEvents.SendCustomGameEventToServer_custom( "change_premium_pet", {pet_id: num, delete_pet:false} );
        courier_selected = num;
        UpdateEquiupPet(id)
    }
    else
    {
    	Game.EmitSound("UI.Shop_Buy_unequip")
        GameEvents.SendCustomGameEventToServer_custom( "change_premium_pet", {pet_id: 0, delete_pet: true} );
        courier_selected = 0;
        UpdateEquiupPet(0)
    }
}

function SetPetInventory(panel, courier_id, item_id) 
{
    panel.SetPanelEvent("onactivate", function() 
    { 
        SelectCourier(courier_id, item_id)
    });
}

function UpdateEquiupPet(id)
{
	var CategoryPets = $.GetContextPanel().FindChildTraverse("CategoryPets")
	if (CategoryPets)
	{
		for (var i = 0; i < CategoryPets.GetChildCount(); i++) {


			let lable = CategoryPets.GetChild(i).FindChildTraverse("BlockItemActivateButtonLabel")
			let button = CategoryPets.GetChild(i).FindChildTraverse('button_activate')
			if (lable)
			{
				lable.text = $.Localize("#shop_equip")
				CategoryPets.GetChild(i).RemoveClass("BlockItem_money")
				CategoryPets.GetChild(i).RemoveClass("BlockItem_nomoney")
				CategoryPets.GetChild(i).AddClass("BlockItem_purchased")
			}
			if (button)
			{
				button.RemoveClass("BlockItemBuyButton_unequip")
				button.AddClass("BlockItemBuyButton_equip")
			}

		}
		let current_courier = CategoryPets.FindChildTraverse("item_id_"+id)
		if (current_courier)
		{
			let lable = current_courier.FindChildTraverse("BlockItemActivateButtonLabel")
			if (lable)
			{
				lable.text = $.Localize("#shop_unequip")
				current_courier.RemoveClass("BlockItem_money")
				current_courier.RemoveClass("BlockItem_nomoney")
				current_courier.AddClass("BlockItem_purchased")
			}


			let button = current_courier.FindChildTraverse('button_activate')
			if (button)
			{
				button.AddClass("BlockItemBuyButton_unequip")
				button.RemoveClass("BlockItemBuyButton_equip")	
			} 
		}
	}

	var CategoryPetsInventory = $.GetContextPanel().FindChildTraverse("CategoryPetsInventory")
	if (CategoryPetsInventory)
	{
		for (var i = 0; i < CategoryPetsInventory.GetChildCount(); i++) {
		

			let button = CategoryPetsInventory.GetChild(i).FindChildTraverse('button')

			let lable = CategoryPetsInventory.GetChild(i).FindChildTraverse("BlockItemActivateButtonLabel")
			if (lable)
			{
				lable.text = $.Localize("#shop_equip")
				CategoryPetsInventory.GetChild(i).RemoveClass("BlockItem_money")
				CategoryPetsInventory.GetChild(i).RemoveClass("BlockItem_nomoney")
				CategoryPetsInventory.GetChild(i).AddClass("BlockItem_purchased")
			}

			if (button)
			{
				button.RemoveClass("BlockItemBuyButton_unequip")
				button.AddClass("BlockItemBuyButton_equip")
			}
		}
		let current_courier = CategoryPetsInventory.FindChildTraverse("item_id_"+id)
		if (current_courier)
		{
			let button = current_courier.FindChildTraverse('button')
			let lable = current_courier.FindChildTraverse("BlockItemActivateButtonLabel")
			if (lable)
			{
				lable.text = $.Localize("#shop_unequip")
				current_courier.RemoveClass("BlockItem_money")
				current_courier.RemoveClass("BlockItem_nomoney")
				current_courier.AddClass("BlockItem_purchased")
			}
			if (button)
			{
				button.AddClass("BlockItemBuyButton_unequip")
				button.RemoveClass("BlockItemBuyButton_equip")
			}
		}
	}
}


function CreateBuyWindow(id, cost, name, sound, hero, no_money, styles, fast_active_tip, pet_video)
{

    let main = $.GetContextPanel().FindChildTraverse("window_shop")

    Game.EmitSound("UI.Shop_Buy_start")

    let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
    blur_panel.RemoveClass("shop_window_blur_hidden")
    blur_panel.AddClass("shop_window_blur")
    
    let buy_panel = $.CreatePanel("Panel", main, "buy_panel_item")
    buy_panel.AddClass("buy_panel")

    buy_panel.hittest = true;
    buy_panel.SetPanelEvent("onactivate", function() {})

    let buy_panel_name_space = $.CreatePanel("Panel", buy_panel, "")
    buy_panel_name_space.AddClass("buy_panel_name_space")


    let buy_panel_content_space_left = $.CreatePanel("Panel", buy_panel, "")
    buy_panel_content_space_left.AddClass("buy_panel_content_space_left")

    let buy_panel_changes_effects = $.CreatePanel("Panel", buy_panel, "")
    buy_panel_changes_effects.AddClass("buy_panel_changes_effects")

    let buy_panel_changes_icons = $.CreatePanel("Panel", buy_panel, "")
    buy_panel_changes_icons.AddClass("buy_panel_changes_icons")

    let buy_panel_cost_and_button = $.CreatePanel("Panel", buy_panel, "")
    buy_panel_cost_and_button.AddClass("buy_panel_cost_and_button")

    let buy_panel_name = $.CreatePanel("Label", buy_panel_name_space, "")
    

    let buy_panel_costpanel = $.CreatePanel("Panel", buy_panel_cost_and_button, "")
    buy_panel_costpanel.AddClass("buy_panel_costpanel")

    let shard_icon_cost = $.CreatePanel("Panel", buy_panel_costpanel, "")
    shard_icon_cost.AddClass("shard_icon_cost")

    let shard_label_cost = $.CreatePanel("Label", buy_panel_costpanel, "")
    shard_label_cost.AddClass("shard_label_cost")
    shard_label_cost.text = cost

    let buy_buttons = $.CreatePanel("Panel", buy_panel_cost_and_button, "")
    buy_buttons.AddClass("shop_buy_buttons")

    let button_buy_buy = $.CreatePanel("Panel", buy_buttons, "")
    button_buy_buy.AddClass("shop_button_buy")

    //let button_buy_close = $.CreatePanel("Panel", buy_buttons, "")
    //button_buy_close.AddClass("button_buy_close")

    let label_button_1 = $.CreatePanel("Label", button_buy_buy, "")
    label_button_1.AddClass("label_button_buy")
    label_button_1.text = $.Localize("#buy")

//  let label_button_2 = $.CreatePanel("Label", button_buy_close, "")
//  label_button_2.AddClass("label_button_buy")
//  label_button_2.text = $.Localize("#close")

    if (pet_video != null)
    {
        buy_panel.AddClass("buy_panel_pet_video")

        var video = $.CreatePanel("MoviePanel", buy_panel, 'video', 
        {
            style: "",
            src: "file://{resources}/videos/custom_game/shop/pets/" + name + ".webm",
            repeat: "true",
            hittest: "false",
            autoplay: "onload"
        });
        video.AddClass("PanelVideoPet")
    }



    if (id != -1 && ITEM_CHANGED_INFORMATION[id] != null)
    {

        buy_panel.AddClass("buy_panel_with_info")
        let abilities_changes_panel = null
        let scene_panel_visual = null

        if (ITEM_CHANGED_INFORMATION[id]["model"] != null)
        {
            let model_info = ITEM_CHANGED_INFORMATION[id]["model"]
            let style = 0
            if (ITEM_CHANGED_INFORMATION[id]["styles"])
            {
                style = ITEM_CHANGED_INFORMATION[id]["styles"][1]
            }
            let item_scene_panel_preview = $.CreatePanel("Panel", buy_panel_content_space_left, "")
            item_scene_panel_preview.AddClass("item_scene_panel_preview")
            scene_panel_visual = item_scene_panel_preview
            $.CreatePanel("DOTAUIEconSetPreview", item_scene_panel_preview, "full_scene_panel_preview_model", { itemdef:model_info[1], itemstyle:style, class:"full_scene_panel_preview_model", style: "width:100%;height:100%;", particleonly:"false", renderdeferred:"false", antialias:"false", renderwaterreflections:"false", allowrotation:"true" });
        }



        if ((styles != null) && (no_styles[id] !== true))
        {
            var ButtonStylesBuyPanel = $.CreatePanel("Panel", buy_panel_content_space_left, "ButtonStylesBuyPanel");
            ButtonStylesBuyPanel.AddClass("ButtonStylesBuyPanel");

            for (var i = 1; i <= Object.keys(styles).length; i++) 
            {
                var ButtonItemStyleBuyPanel = $.CreatePanel("Panel", ButtonStylesBuyPanel, "item_style_" + styles[i][1]);
                ButtonItemStyleBuyPanel.AddClass("ButtonItemStyleBuyPanel");
                ButtonItemStyleBuyPanel.style.backgroundColor = styles[i][2]
                var ButtonItemStyleBuyPanelActiveIcon = $.CreatePanel("Panel", ButtonItemStyleBuyPanel, "");
              //  ButtonItemStyleBuyPanelActiveIcon.AddClass("ButtonItemStyleBuyPanelActiveIcon");

                if (i == 1)
                {
                    ButtonItemStyleBuyPanel.SetHasClass("ButtonItemStyle_active", true)
                    ButtonItemStyleBuyPanel.SetHasClass("ButtonItemStyleBuyPanel_active", true)
                }
                ChangeScenePreviewItem(buy_panel, ButtonItemStyleBuyPanel, ITEM_CHANGED_INFORMATION[styles[i][1]], scene_panel_visual)
            }
        }

        if (ITEM_CHANGED_INFORMATION[id]["changed_icons"] != null)
        {
            abilities_changes_panel = $.CreatePanel("Panel", buy_panel_changes_icons, "abilities_changes_panel")
            abilities_changes_panel.AddClass("abilities_changes_panel")

            let changes_icons_panel = $.CreatePanel("Panel", abilities_changes_panel, "changes_icons_panel")
            changes_icons_panel.AddClass("changes_icons_panel")
            let changes_icons_panel_label = $.CreatePanel("Label", changes_icons_panel, "changes_icons_panel_label")
            changes_icons_panel_label.AddClass("changes_icons_panel_label")
            changes_icons_panel_label.text = $.Localize("#changes_icons_abilities")
            let changes_ability_list = $.CreatePanel("Panel", changes_icons_panel, "")
            changes_ability_list.AddClass("changes_ability_list")

            for (var i = 0; i < ITEM_CHANGED_INFORMATION[id]["changed_icons"].length; i++) 
            {
                let ability_info = ITEM_CHANGED_INFORMATION[id]["changed_icons"][i]
                if (ability_info)
                {
                    let ability_info_panel = $.CreatePanel("Panel", changes_ability_list, "changes_icons_panel")
                    ability_info_panel.AddClass("ability_info_panel")
                    ability_info_panel.style.backgroundImage = 'url("file://{images}/spellicons/' + ability_info[1] + '.png")';
                    ability_info_panel.style.backgroundSize = "100%";
                    SetShowAbDesc(ability_info_panel, ability_info[0])
                }
            }
        }

        if (ITEM_CHANGED_INFORMATION[id]["changed_effects"] != null)
        {

            let changes_effects_panel = $.CreatePanel("Panel", buy_panel_changes_effects, "changes_effects_panel")
            changes_effects_panel.AddClass("changes_effects_panel")
            let changes_effects_panel_label = $.CreatePanel("Label", changes_effects_panel, "changes_effects_panel_label")
            changes_effects_panel_label.AddClass("changes_effects_panel_label")
            changes_effects_panel_label.text = $.Localize("#changes_effects_abilities")
            let changes_ability_list = $.CreatePanel("Panel", changes_effects_panel, "")
            changes_ability_list.AddClass("changes_ability_list")
            for (var i = 0; i < ITEM_CHANGED_INFORMATION[id]["changed_effects"].length; i++) 
            {
                let ability_info = ITEM_CHANGED_INFORMATION[id]["changed_effects"][i]
                if (ability_info)
                {
                    let ability_info_panel = $.CreatePanel("Panel", changes_ability_list, "changes_icons_panel")
                    ability_info_panel.AddClass("ability_info_panel")
                    ability_info_panel.style.backgroundImage = 'url("file://{images}/spellicons/' + ability_info[1] + '.png")';
                    ability_info_panel.style.backgroundSize = "100%";
                    SetShowAbDesc(ability_info_panel, ability_info[0])
                }
            }
        }
    } 

    if (sound == 1)
    {
        buy_panel_name.AddClass("buy_panel_name_sound")
    }
    else 
    {
        buy_panel_name.AddClass("buy_panel_name")
    }

    if (id == -1)
    {

        buy_panel_name.text = $.Localize("#vote_buy_window") + name
    }
    else
    {
        if (("#"+name) == $.Localize("#"+name))
        {
            buy_panel_name.text = name
        }else 
        {
            buy_panel_name.text = $.Localize("#"+name)
        }
    }


    if (no_money == null || no_money == false)
    {
        button_buy_buy.SetPanelEvent("onactivate", function() 
        { 
            button_buy_buy.SetPanelEvent("onactivate", function() {})

            blur_panel.AddClass("shop_window_blur_hidden")
            blur_panel.RemoveClass("shop_window_blur")

            Game.EmitSound("UI.Shop_Buy")

            var votes = 0

            if (id == -1)
            {
                votes = Number(name)
            }

            if (hero)
            {
                GameEvents.SendCustomGameEventToServer_custom( "shop_buy_item_player", { item_id : id, votes : votes, hero : hero} );
            }
            else
            {
                GameEvents.SendCustomGameEventToServer_custom( "shop_buy_item_player", { item_id : id, votes : votes} );
            }

            if (fast_active_tip != null)
            {
                GameEvents.SendCustomGameEventToServer_custom( "update_tip_list", {tip_id: fast_active_tip, delete : false} );
            }
            
            buy_panel.RemoveClass("buy_panel")

            buy_panel.AddClass("buy_panel_hide")

            $.Schedule( 0.35, function()
            {
                buy_panel.DeleteAsync(0)

                UpdateShards()
                InitItems()
                //InitInventory()
                InitSounds()
                InitVote()
                CloseActiveChatBlock()

                let ItemsList = $.GetContextPanel().FindChildTraverse("ItemsList")
                if (ItemsList)
                {
                    InitShopItemsForHero(ItemsList)
                }
                let ItemsListInventory = $.GetContextPanel().FindChildTraverse("ItemsListInventory")
                if (ItemsListInventory)
                {
                    InitShopItemsForHeroInventory(ItemsListInventory)
                }
            })
        })
    }
    else
    {
        
        button_buy_buy.AddClass("button_no_money")
        shard_label_cost.AddClass("cost_no_money")
    }
    //button_buy_close.SetPanelEvent("onactivate", function() 
    //{ 
    //  buy_panel.RemoveClass("buy_panel")
    //  buy_panel.AddClass("buy_panel_hide")
//
    //  $.Schedule( 0.35, function()
    //  {
    //      buy_panel.DeleteAsync(0)
    //  })
//
//
    //  Game.EmitSound("UI.Shop_Category_Open")
//
//
    //  blur_panel.AddClass("shop_window_blur_hidden")
    //  blur_panel.RemoveClass("shop_window_blur")
    //})

    blur_panel.SetPanelEvent("onactivate", function() 
    {   
        buy_panel.RemoveClass("buy_panel")
        buy_panel.AddClass("buy_panel_hide")

        $.Schedule( 0.35, function()
        {
            buy_panel.DeleteAsync(0)
        })

        Game.EmitSound("UI.Shop_Category_Open")

        blur_panel.SetPanelEvent("onactivate", function() {})

        blur_panel.AddClass("shop_window_blur_hidden")
        blur_panel.RemoveClass("shop_window_blur")
    })
}

function SetShowAbDesc(panel, ability)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowAbilityTooltip', panel, ability); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
    });       
}

function CreatePlusWindow()
{


	let data = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()));


    let lang = $.Localize("#lang")

    if ((data && data.total_games && data.total_games >= max_games) || lang == "rus")
    {

    }else 
    {
        return
    }


	let main = $.GetContextPanel().FindChildTraverse("window_shop")

	Game.EmitSound("UI.Shop_Buy_start")

	let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
	blur_panel.RemoveClass("shop_window_blur_hidden")
	blur_panel.AddClass("shop_window_blur")
	
	let buy_panel = $.CreatePanel("Panel", main, "buy_panel_item")
	buy_panel.AddClass("buy_pass_panel")

	buy_panel.hittest = true;
	buy_panel.SetPanelEvent("onactivate", function() {})


	let sale = 0


	let buy_pass_top = $.CreatePanel("Panel", buy_panel, "buy_panel_item")
	buy_pass_top.AddClass("buy_pass_top")


	let buy_pass_bot = $.CreatePanel("Panel", buy_panel, "buy_panel_item")
	buy_pass_bot.AddClass("buy_pass_bot")



	let buy_pass_close_button= $.CreatePanel("Panel", buy_pass_top, "buy_panel_item")
	buy_pass_close_button.AddClass("buy_pass_close_button")

	let buy_pass_top_text = $.CreatePanel("Label", buy_pass_top, "buy_panel_item")
	buy_pass_top_text.AddClass("buy_pass_top_text")
	buy_pass_top_text.text = $.Localize("#pass_buy_top")






	let buy_pass_bot_left =  $.CreatePanel("Panel", buy_pass_bot, "buy_panel_item")
	buy_pass_bot_left.AddClass("buy_pass_bot_panel")

	let buy_pass_bot_mid =  $.CreatePanel("Panel", buy_pass_bot, "buy_panel_item")
	buy_pass_bot_mid.AddClass("buy_pass_bot_panel")


	let buy_pass_bot_right =  $.CreatePanel("Panel", buy_pass_bot, "buy_panel_item")
	buy_pass_bot_right.AddClass("buy_pass_bot_panel")



	let buy_pass_bot_button_left = $.CreatePanel("Panel", buy_pass_bot_left, "")
	buy_pass_bot_button_left.AddClass("buy_pass_button")


	let buy_pass_bot_button_left_text = $.CreatePanel("Label", buy_pass_bot_button_left, "")
	buy_pass_bot_button_left_text.AddClass("buy_pass_button_text")
	buy_pass_bot_button_left_text.text = $.Localize("#pass_buy_button1")



	let buy_pass_bot_button_mid = $.CreatePanel("Panel", buy_pass_bot_mid, "")
	buy_pass_bot_button_mid.AddClass("buy_pass_button")

	let buy_pass_bot_button_mid_text = $.CreatePanel("Label", buy_pass_bot_button_mid, "")
	buy_pass_bot_button_mid_text.AddClass("buy_pass_button_text")
	buy_pass_bot_button_mid_text.text = $.Localize("#pass_buy_button2")




	let buy_pass_bot_button_right = $.CreatePanel("Panel", buy_pass_bot_right, "")
	buy_pass_bot_button_right.AddClass("buy_pass_button")

	let buy_pass_bot_button_right_text = $.CreatePanel("Label", buy_pass_bot_button_right, "")
	buy_pass_bot_button_right_text.AddClass("buy_pass_button_text")
	buy_pass_bot_button_right_text.text = $.Localize("#pass_buy_button3")



	if (sale == 1)
	{

		let buy_pass_mid_text = $.CreatePanel("Label", buy_pass_top, "buy_panel_item")
		buy_pass_mid_text.html = true

		buy_pass_mid_text.AddClass("buy_pass_mid_text")
		buy_pass_mid_text.text = $.Localize("#pass_buy_mid")



		let buy_pass_bot_cost_left_sale_text = $.CreatePanel("Label", buy_pass_bot_left, "")
		buy_pass_bot_cost_left_sale_text.AddClass("buy_pass_cost_sale_text_left")
		buy_pass_bot_cost_left_sale_text.html = true
		buy_pass_bot_cost_left_sale_text.text = $.Localize("#pass_buy_cost1_sale_left")

		let buy_pass_bot_cost_left_sale_text_cost = $.CreatePanel("Label", buy_pass_bot_left, "")
		buy_pass_bot_cost_left_sale_text_cost.AddClass("buy_pass_cost_sale_text_right")
		buy_pass_bot_cost_left_sale_text_cost.html = true
		buy_pass_bot_cost_left_sale_text_cost.text = $.Localize("#pass_buy_cost1_sale_right")


		let buy_pass_bot_cost_mid_sale_text = $.CreatePanel("Label", buy_pass_bot_mid, "")
		buy_pass_bot_cost_mid_sale_text.AddClass("buy_pass_cost_sale_text_left")
		buy_pass_bot_cost_mid_sale_text.html = true
		buy_pass_bot_cost_mid_sale_text.text = $.Localize("#pass_buy_cost2_sale_left")

		let buy_pass_bot_cost_mid_sale_text_cost = $.CreatePanel("Label", buy_pass_bot_mid, "")
		buy_pass_bot_cost_mid_sale_text_cost.AddClass("buy_pass_cost_sale_text_right")
		buy_pass_bot_cost_mid_sale_text_cost.html = true
		buy_pass_bot_cost_mid_sale_text_cost.text = $.Localize("#pass_buy_cost2_sale_right")


		let buy_pass_bot_cost_right_sale_text = $.CreatePanel("Label", buy_pass_bot_right, "")
		buy_pass_bot_cost_right_sale_text.AddClass("buy_pass_cost_sale_text_left")
		buy_pass_bot_cost_right_sale_text.html = true
		buy_pass_bot_cost_right_sale_text.text = $.Localize("#pass_buy_cost3_sale_left")

		let buy_pass_bot_cost_right_sale_text_cost = $.CreatePanel("Label", buy_pass_bot_right, "")
		buy_pass_bot_cost_right_sale_text_cost.AddClass("buy_pass_cost_sale_text_right")
		buy_pass_bot_cost_right_sale_text_cost.html = true
		buy_pass_bot_cost_right_sale_text_cost.text = $.Localize("#pass_buy_cost3_sale_right")
	}
	else
	{

		let buy_pass_mid_icon = $.CreatePanel("Panel", buy_pass_top, "buy_panel_item")
		buy_pass_mid_icon.AddClass("buy_pass_mid_icon")


		let buy_pass_bot_cost_left_text = $.CreatePanel("Label", buy_pass_bot_left, "")
		buy_pass_bot_cost_left_text.AddClass("buy_pass_cost_text")
		buy_pass_bot_cost_left_text.html = true
		buy_pass_bot_cost_left_text.text = $.Localize("#pass_buy_cost1")

		let buy_pass_bot_cost_mid_text = $.CreatePanel("Label", buy_pass_bot_mid, "")
		buy_pass_bot_cost_mid_text.AddClass("buy_pass_cost_text")
		buy_pass_bot_cost_mid_text.html = true
		buy_pass_bot_cost_mid_text.text = $.Localize("#pass_buy_cost2")
		
		let buy_pass_bot_cost_right_text = $.CreatePanel("Label", buy_pass_bot_right, "")
		buy_pass_bot_cost_right_text.AddClass("buy_pass_cost_text")
		buy_pass_bot_cost_right_text.html = true
		buy_pass_bot_cost_right_text.text = $.Localize("#pass_buy_cost3")
	} 






	buy_pass_bot_button_left.SetPanelEvent("onactivate", function() 
	{ 
		buy_pass_bot_button_left.SetPanelEvent("onactivate", function() {})

		
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "dota_plus_1"});

		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		Game.EmitSound("UI.Shop_Buy")
		
		buy_panel.RemoveClass("buy_pass_panel")
		buy_panel.AddClass("buy_pass_panel_hide")

		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
			
		})


	})

	buy_pass_bot_button_mid.SetPanelEvent("onactivate", function() 
	{ 
		buy_pass_bot_button_mid.SetPanelEvent("onactivate", function() {})

		
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name : "dota_plus_3"});

		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		Game.EmitSound("UI.Shop_Buy")
		
		buy_panel.RemoveClass("buy_pass_panel")
		buy_panel.AddClass("buy_pass_panel_hide")

		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
			
		})


	})


	buy_pass_bot_button_right.SetPanelEvent("onactivate", function() 
	{ 
		buy_pass_bot_button_right.SetPanelEvent("onactivate", function() {})

		
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name:  "dota_plus_6"});

		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		Game.EmitSound("UI.Shop_Buy")
		
		buy_panel.RemoveClass("buy_pass_panel")
		buy_panel.AddClass("buy_pass_panel_hide")

		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
			
		})


	})

	buy_pass_close_button.SetPanelEvent("onactivate", function() 
	{ 
		buy_panel.RemoveClass("buy_pass_panel")
		buy_panel.AddClass("buy_pass_panel_hide")

		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
		})


		Game.EmitSound("UI.Shop_Category_Open")


		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
	})

	blur_panel.SetPanelEvent("onactivate", function() 
	{ 	
		buy_panel.RemoveClass("buy_pass_panel")
		buy_panel.AddClass("buy_pass_panel_hide")

		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
		})

		Game.EmitSound("UI.Shop_Category_Open")

		blur_panel.SetPanelEvent("onactivate", function() {})

		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")
	})
}








function OpenBuyCurrency()
{


    let data = CustomNetTables.GetTableValue("server_data", String(Players.GetLocalPlayer()));

    let lang = $.Localize("#lang")

    if ((data && data.total_games && data.total_games >= max_games) || lang == "rus")
	{

	}else 
    {
        return
    }

	let main = $.GetContextPanel().FindChildTraverse("window_shop")

	Game.EmitSound("UI.Shop_Buy_start")

	let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
	blur_panel.RemoveClass("shop_window_blur_hidden")
	blur_panel.AddClass("shop_window_blur")


	let currency_panel_buying = $.CreatePanel("Panel", main, "currency_panel_buying")
	currency_panel_buying.AddClass("currency_panel_buying")

	currency_panel_buying.hittest = true

	currency_panel_buying.SetPanelEvent("onactivate", function() {})

	let closebuy = $.CreatePanel("Panel", currency_panel_buying, "")
	closebuy.AddClass("closebuy")

	blur_panel.SetPanelEvent("onactivate", function() 
	{	
		if (currency_panel_buying)
		{
			
			currency_panel_buying.RemoveClass("currency_panel_buying")
			currency_panel_buying.AddClass("currency_panel_buying_hide")

			$.Schedule( 0.35, function()
			{
				currency_panel_buying.DeleteAsync(0)
			})

			Game.EmitSound("UI.Shop_Category_Open")


			blur_panel.AddClass("shop_window_blur_hidden")
			blur_panel.RemoveClass("shop_window_blur")
		}
	});

	closebuy.SetPanelEvent("onactivate", function() 
	{	
		if (currency_panel_buying)
		{
			
			currency_panel_buying.RemoveClass("currency_panel_buying")
			currency_panel_buying.AddClass("currency_panel_buying_hide")

			$.Schedule( 0.35, function()
			{
				currency_panel_buying.DeleteAsync(0)
			})

			Game.EmitSound("UI.Shop_Category_Open")


			blur_panel.AddClass("shop_window_blur_hidden")
			blur_panel.RemoveClass("shop_window_blur")
		}
	});


	let label_header = $.CreatePanel("Label", currency_panel_buying, "")
	label_header.AddClass("label_header")
	label_header.text = $.Localize("#shop_buy_shards")



	let label_mid = $.CreatePanel("Label", currency_panel_buying, "")
	label_mid.AddClass("label_mid")
	label_mid.html = true;
	label_mid.text = $.Localize("#shop_buy_shards_text")



	let block_with_choose = $.CreatePanel("Panel", currency_panel_buying, "")
	block_with_choose.AddClass("block_with_choose")


	var button_donate_link_1 = "https://google.com/"
	var button_donate_link_2 = "https://google.com/"
	var button_donate_link_3 = "https://google.com/"

	let choose_1 = $.CreatePanel("Panel", block_with_choose, "")
	choose_1.AddClass("choose_block")

	let ShardIconCurrencyBuy = $.CreatePanel("Panel", choose_1, "")
	ShardIconCurrencyBuy.AddClass("ShardIconCurrencyBuy")
	ShardIconCurrencyBuy.style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_5.png")';
	ShardIconCurrencyBuy.style.backgroundSize = "contain";




	let ShardNameCurrencyBuy = $.CreatePanel("Label", choose_1, "")
	ShardNameCurrencyBuy.AddClass("ShardNameCurrencyBuy")
	ShardNameCurrencyBuy.text = $.Localize("#shop_buy_shards_1")


	let BuyButtonSiteURL = $.CreatePanel("Panel", choose_1, "");
	BuyButtonSiteURL.AddClass("BuyButtonSiteURL")

	choose_1.SetPanelEvent("onactivate", function() {
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "shards_2"});	


		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		Game.EmitSound("UI.Shop_Buy")
		
		currency_panel_buying.RemoveClass("currency_panel_buying")
		currency_panel_buying.AddClass("currency_panel_buying_hide")

		$.Schedule( 0.35, function()
		{
			currency_panel_buying.DeleteAsync(0)
		})

	})


	let BuyButtonSiteURLLabel = $.CreatePanel("Label", BuyButtonSiteURL, "")
	BuyButtonSiteURLLabel.AddClass("BuyButtonSiteURLLabel")
	BuyButtonSiteURLLabel.text = $.Localize("#shop_buy_shards_1_button")

	let choose_2 = $.CreatePanel("Panel", block_with_choose, "")
	choose_2.AddClass("choose_block")

	let ShardIconCurrencyBuy_2 = $.CreatePanel("Panel", choose_2, "")
	ShardIconCurrencyBuy_2.AddClass("ShardIconCurrencyBuy")
	ShardIconCurrencyBuy_2.style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_11.png")';
	ShardIconCurrencyBuy_2.style.backgroundSize = "contain";


	let ShardIconCurrencyBuy_2_sale = $.CreatePanel("Panel", ShardIconCurrencyBuy_2, "")
	ShardIconCurrencyBuy_2_sale.AddClass("ShardIconCurrencyBuy_sale")

	let ShardIconCurrencyBuy_2_sale_text = $.CreatePanel("Label", ShardIconCurrencyBuy_2_sale, "")
	ShardIconCurrencyBuy_2_sale_text.AddClass("ShardIconCurrencyBuy_sale_text")
	ShardIconCurrencyBuy_2_sale_text.text = $.Localize("#shop_buy_shards_2_sale")


	let ShardNameCurrencyBuy_2 = $.CreatePanel("Label", choose_2, "")
	ShardNameCurrencyBuy_2.AddClass("ShardNameCurrencyBuy")
	ShardNameCurrencyBuy_2.text = $.Localize("#shop_buy_shards_2")

	let BuyButtonSiteURL_2 = $.CreatePanel("Panel", choose_2, "");
	BuyButtonSiteURL_2.AddClass("BuyButtonSiteURL")

	choose_2.SetPanelEvent("onactivate", function() {
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "shards_10"});	

		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		Game.EmitSound("UI.Shop_Buy")
		
		currency_panel_buying.RemoveClass("currency_panel_buying")
		currency_panel_buying.AddClass("currency_panel_buying_hide")

		$.Schedule( 0.35, function()
		{
			currency_panel_buying.DeleteAsync(0)
		})
	})


	let BuyButtonSiteURLLabel_2 = $.CreatePanel("Label", BuyButtonSiteURL_2, "")
	BuyButtonSiteURLLabel_2.AddClass("BuyButtonSiteURLLabel")
	BuyButtonSiteURLLabel_2.text = $.Localize("#shop_buy_shards_2_button")

	let choose_3 = $.CreatePanel("Panel", block_with_choose, "")
	choose_3.AddClass("choose_block")

	let ShardIconCurrencyBuy_3 = $.CreatePanel("Panel", choose_3, "")
	ShardIconCurrencyBuy_3.AddClass("ShardIconCurrencyBuy")
	ShardIconCurrencyBuy_3.style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_24.png")';
	ShardIconCurrencyBuy_3.style.backgroundSize = "contain";


	let ShardIconCurrencyBuy_3_sale = $.CreatePanel("Panel", ShardIconCurrencyBuy_3, "")
	ShardIconCurrencyBuy_3_sale.AddClass("ShardIconCurrencyBuy_sale")

	let ShardIconCurrencyBuy_3_sale_text = $.CreatePanel("Label", ShardIconCurrencyBuy_3_sale, "")
	ShardIconCurrencyBuy_3_sale_text.AddClass("ShardIconCurrencyBuy_sale_text")
	ShardIconCurrencyBuy_3_sale_text.text = $.Localize("#shop_buy_shards_3_sale")

	let ShardNameCurrencyBuy_3 = $.CreatePanel("Label", choose_3, "")
	ShardNameCurrencyBuy_3.AddClass("ShardNameCurrencyBuy")
	ShardNameCurrencyBuy_3.text = $.Localize("#shop_buy_shards_3")


	let BuyButtonSiteURL_3 = $.CreatePanel("Panel", choose_3, "");
	BuyButtonSiteURL_3.AddClass("BuyButtonSiteURL")

	choose_3.SetPanelEvent("onactivate", function() {
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "shards_35"});	


		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		Game.EmitSound("UI.Shop_Buy")
		
		currency_panel_buying.RemoveClass("currency_panel_buying")
		currency_panel_buying.AddClass("currency_panel_buying_hide")

		$.Schedule( 0.35, function()
		{
			currency_panel_buying.DeleteAsync(0)
		})
	})

	let BuyButtonSiteURLLabel_3 = $.CreatePanel("Label", BuyButtonSiteURL_3, "")
	BuyButtonSiteURLLabel_3.AddClass("BuyButtonSiteURLLabel")
	BuyButtonSiteURLLabel_3.text = $.Localize("#shop_buy_shards_3_button")

	let choose_4 = $.CreatePanel("Panel", block_with_choose, "")
	choose_4.AddClass("choose_block")

	let ShardIconCurrencyBuy_4 = $.CreatePanel("Panel", choose_4, "")
	ShardIconCurrencyBuy_4.AddClass("ShardIconCurrencyBuy")
	ShardIconCurrencyBuy_4.style.backgroundImage = 'url("file://{images}/econ/tools/bp_2022_treasure_crimson.png")';
	ShardIconCurrencyBuy_4.style.backgroundSize = "contain";


	let ShardIconCurrencyBuy_4_sale = $.CreatePanel("Panel", ShardIconCurrencyBuy_4, "")
	ShardIconCurrencyBuy_4_sale.AddClass("ShardIconCurrencyBuy_sale")

	let ShardIconCurrencyBuy_4_sale_text = $.CreatePanel("Label", ShardIconCurrencyBuy_4_sale, "")
	ShardIconCurrencyBuy_4_sale_text.AddClass("ShardIconCurrencyBuy_sale_text")
	ShardIconCurrencyBuy_4_sale_text.text = $.Localize("#shop_buy_shards_4_sale")

	let ShardNameCurrencyBuy_4 = $.CreatePanel("Label", choose_4, "")
	ShardNameCurrencyBuy_4.AddClass("ShardNameCurrencyBuy")
	ShardNameCurrencyBuy_4.text = $.Localize("#shop_buy_shards_4")

	let BuyButtonSiteURL_4 = $.CreatePanel("Panel", choose_4, "");
	BuyButtonSiteURL_4.AddClass("BuyButtonSiteURL")

	choose_4.SetPanelEvent("onactivate", function() {
		GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "shards_100"});	


		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		Game.EmitSound("UI.Shop_Buy")
		
		currency_panel_buying.RemoveClass("currency_panel_buying")
		currency_panel_buying.AddClass("currency_panel_buying_hide")

		$.Schedule( 0.35, function()
		{
			currency_panel_buying.DeleteAsync(0)
		})
	})

	let BuyButtonSiteURLLabel_4 = $.CreatePanel("Label", BuyButtonSiteURL_4, "")
	BuyButtonSiteURLLabel_4.AddClass("BuyButtonSiteURLLabel")
	BuyButtonSiteURLLabel_4.text = $.Localize("#shop_buy_shards_4_button")

}



function answer_promo_code(data)
{
    let result = data.status
    let ru_text = data.ru
    let eng_text = data.eng
    let lang = $.Localize("#lang")
    let name = data.name
    let amount = data.amount

    if ((name != "") && (amount != 0))
    {
        ru_text = $.Localize("#promo_active_" + name) + String(amount)

        if (name == "dota_plus")
        {
            ru_text = ru_text + $.Localize("#promo_active_dota_plus_2")
        }

        eng_text = ru_text
    }


    let entry = $.GetContextPanel().FindChildTraverse("PromoEntry")
    let status = $.GetContextPanel().FindChildTraverse("promo_text_status")

    if (status)
    {

        if (lang == "rus")
        {
            status.text = ru_text
        }else 
        {
            status.text = eng_text
        }

        if (result == 0)
        {
            status.AddClass("promo_text_status_yes")
            Game.EmitSound("UI.Promo_active")

            if (entry)
            {
                entry.text = ""
            }
        }else 
        {
            status.AddClass("promo_text_status_no")
            Game.EmitSound("UI.Promo_fail")
        }
    }
}



function OpenPromoWindow()
{
    let main = $.GetContextPanel().FindChildTraverse("window_shop")

    Game.EmitSound("UI.Shop_Buy_start")

    let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
    blur_panel.RemoveClass("shop_window_blur_hidden")
    blur_panel.AddClass("shop_window_blur")

    let currency_panel_buying = $.CreatePanel("Panel", main, "currency_panel_buying")
    currency_panel_buying.AddClass("promo_panel")
    currency_panel_buying.hittest = true
    currency_panel_buying.SetPanelEvent("onactivate", function() {})

    let promo_content = $.CreatePanel("Panel", currency_panel_buying, "")
    promo_content.AddClass("promo_panel_content")

    let telegram_content = $.CreatePanel("Panel", currency_panel_buying, "")
    telegram_content.AddClass("telegram_content")


    let telegram_icon = $.CreatePanel("Panel", telegram_content, "")
    telegram_icon.AddClass("telegram_icon")

    let telegram_text = $.CreatePanel("Label", telegram_content, "")
    telegram_text.AddClass("promo_telegram_text")
    telegram_text.text = $.Localize("#promo_telegram_text")

    let closebuy = $.CreatePanel("Panel", currency_panel_buying, "")
    closebuy.AddClass("closebuy")
  
    telegram_content.SetPanelEvent("onactivate", function() 
    {  
        $.DispatchEvent("ExternalBrowserGoToURL", 'https://t.me/Dota1x6');
    })


    telegram_text.SetPanelEvent("onactivate", function() 
    {  
        $.DispatchEvent("ExternalBrowserGoToURL", 'https://t.me/Dota1x6');
    })

    blur_panel.SetPanelEvent("onactivate", function() 
    {   
        if (currency_panel_buying)
        {
            
            currency_panel_buying.RemoveClass("promo_panel")
            currency_panel_buying.AddClass("promo_panel_hide")

            $.Schedule( 0.35, function()
            {
                currency_panel_buying.DeleteAsync(0)
            })

            Game.EmitSound("UI.Shop_Category_Open")


            blur_panel.AddClass("shop_window_blur_hidden")
            blur_panel.RemoveClass("shop_window_blur")
        }
    });

    closebuy.SetPanelEvent("onactivate", function() 
    {   
        if (currency_panel_buying)
        {
            
            currency_panel_buying.RemoveClass("promo_panel")
            currency_panel_buying.AddClass("promo_panel_hide")

            $.Schedule( 0.35, function()
            {
                currency_panel_buying.DeleteAsync(0)
            })

            Game.EmitSound("UI.Shop_Category_Open")


            blur_panel.AddClass("shop_window_blur_hidden")
            blur_panel.RemoveClass("shop_window_blur")
        }
    });


    let label_header = $.CreatePanel("Label", promo_content, "")
    label_header.AddClass("promo_panel_header")
    label_header.text = $.Localize("#promo_button_header")

    let promo_entry_and_button = $.CreatePanel("Panel", promo_content, "");
    promo_entry_and_button.AddClass("promo_entry_and_button")

    let text_entry = $.CreatePanel(`TextEntry`, promo_entry_and_button, "PromoEntry", {});
    text_entry.AddClass("promo_text_entry")


    let promo_button = $.CreatePanel("Panel", promo_entry_and_button, "");
    promo_button.AddClass("promo_button")

    let promo_button_text = $.CreatePanel("Label", promo_button, "")
    promo_button_text.AddClass("promo_button_text")
    promo_button_text.text = $.Localize("#promo_button_active")


    let promo_text_status = $.CreatePanel("Label", promo_content, "promo_text_status")
    promo_text_status.AddClass("promo_text_status")

    promo_button.SetPanelEvent("onactivate", function() 
    {   
        Game.EmitSound("UI.Click")
        let entry = $.GetContextPanel().FindChildTraverse("PromoEntry")
        let status = $.GetContextPanel().FindChildTraverse("promo_text_status")

        if (promo_text_status)
        {
            status.RemoveClass("promo_text_status_yes")
            status.RemoveClass("promo_text_status_no")
            status.text = ""
        }


        if (entry)
        {   
            let text = (entry.text).toUpperCase();
            GameEvents.SendCustomGameEventToServer_custom( "send_promo_code", {text : text});
        }


    });

}





function InitVote()
{
	$("#shop_window_6").RemoveAndDeleteChildren()


	var heroes_to_vote = CustomNetTables.GetTableValue("sub_data", "heroes_vote").vote_table;
	var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());

	var vote_cost = CustomNetTables.GetTableValue("shop_items",  "votes_cost").cost;

	var vote_data = CustomNetTables.GetTableValue("sub_data", "heroes_vote")

	var active_vote = vote_data.active_vote;
	var hero_won = vote_data.hero_won;
	var end_date = vote_data.end_date;


	var top_panel =  $.CreatePanel("Panel", $("#shop_window_6"), "");
	top_panel.AddClass("heroes_vote_list_top")

	if (active_vote == 0)
	{

		var top_panel_text =  $.CreatePanel("Label", top_panel, "");
		top_panel_text.AddClass("heroes_vote_list_top_text")
		top_panel_text.text = $.Localize('#vote_top_end')


		var mid_panel_text =  $.CreatePanel("Label",  $("#shop_window_6"), "");
		mid_panel_text.AddClass("mid_panel_text")
		mid_panel_text.text = $.Localize('#vote_hero_won')


		var mid_panel_icon =  $.CreatePanel("Panel",  $("#shop_window_6"), "");
		mid_panel_icon.AddClass("mid_panel_icon")
		mid_panel_icon.style.backgroundImage = "url('file://{images}/heroes/" + String(hero_won) + ".png')"
		mid_panel_icon.style.backgroundSize = "contain";

		mid_panel_icon.AddClass("HeroImageVote_" + String(vote_data.hero_stat))


		var bot_panel_text =  $.CreatePanel("Label",  $("#shop_window_6"), "");
		bot_panel_text.AddClass("bot_panel_text")
		bot_panel_text.html = true
		bot_panel_text.text = $.Localize('#vote_hero_won_date')

		return
	}




	var top_panel_text =  $.CreatePanel("Label", top_panel, "");
	top_panel_text.AddClass("heroes_vote_list_top_text")
	top_panel_text.text = $.Localize('#vote_top')


	var player_vote_count = 0

	if (sub_data)
	{
		player_vote_count = sub_data.votes_count
	}

	let full_vote = 1	

	let heroes_vote_list = $.CreatePanel("Panel", $("#shop_window_6"), "heroes_vote_list");
	heroes_vote_list.AddClass("heroes_vote_list")






	for (var i = 1; i <= Object.keys(heroes_to_vote).length; i++) 
	{
        if (Number(heroes_to_vote[i][2]) >= full_vote)
        {
            full_vote = Number(heroes_to_vote[i][2])
        }
	}


	for (var i = 1; i <= Object.keys(heroes_to_vote).length; i++) 
	{
		let percent = Math.round((heroes_to_vote[i][2] / full_vote) * 95)

		if (full_vote == 0)
		{
			percent = 0
		}

		let hero_info = $.CreatePanel("Panel", heroes_vote_list, "");
		hero_info.AddClass("hero_info_vote")

		if (i == 1)
		{
			hero_info.AddClass("hero_info_vote_first")
		}

		var HeroImage = $.CreatePanel(`DOTAHeroImage`, hero_info, "", {scaling: "stretch-to-cover-preserve-aspect", heroname : String(heroes_to_vote[i][1]), tabindex : "auto", class: "HeroImageVote"});
		//HeroImage.AddClass("HeroImageVote_" + String(heroes_to_vote[i][4]))

		let vote_line_default = $.CreatePanel("Panel", hero_info, "");
		vote_line_default.AddClass("vote_line_default")

		let vote_line_background = $.CreatePanel("Panel", vote_line_default, "");
		vote_line_background.AddClass("vote_line_background")
		vote_line_background.AddClass("vote_line_background_" + String(heroes_to_vote[i][4]))

		let vote_line_reach = $.CreatePanel("Panel", vote_line_default, "");
		vote_line_reach.AddClass("vote_line_reach")
		//vote_line_reach.AddClass("vote_line_reach_" + String(heroes_to_vote[i][4]))
		vote_line_reach.style.width = percent + "%"

		var anim = $.CreatePanel("DOTAScenePanel", vote_line_reach, 'HealthBurner', {map:'scenes/hud/healthbarburner', hittest:'false', camera:'camera_1'});


		let vote_line_label = $.CreatePanel("Label", vote_line_default, "");
		vote_line_label.AddClass("vote_line_label")
		vote_line_label.text = heroes_to_vote[i][2]

		let button_vote_hero = $.CreatePanel("Panel", hero_info, "");
		button_vote_hero.AddClass("button_vote_hero")

		if (sub_data.votes_count > 0)
		{
			button_vote_hero.AddClass("button_vote_hero_money")
		}else 
		{
			button_vote_hero.AddClass("button_vote_hero_nomoney")
		}

		SetOpenVoteHero(button_vote_hero, String(heroes_to_vote[i][1]), String(heroes_to_vote[i][4]))


		let button_vote_hero_label = $.CreatePanel("Label", button_vote_hero, "");
		button_vote_hero_label.AddClass("button_vote_hero_label")
		button_vote_hero_label.text = $.Localize("#vote_for_hero")
	}

	let votes_count_panel = $.CreatePanel("Panel", $("#shop_window_6"), "");
	votes_count_panel.AddClass("votes_count_panel")

	let votes_panel_top = $.CreatePanel("Panel", votes_count_panel, "");
	votes_panel_top.AddClass("votes_count_panel_top")


	let votes_panel_mid = $.CreatePanel("Panel", votes_count_panel, "");
	votes_panel_mid.AddClass("votes_count_panel_mid")


	let votes_panel_mid_left = $.CreatePanel("Panel", votes_panel_mid, "");
	votes_panel_mid_left.AddClass("votes_count_panel_mid_left")



	let votes_panel_mid_right = $.CreatePanel("Panel", votes_panel_mid, "");
	votes_panel_mid_right.AddClass("votes_count_panel_mid_right")


	let button_buy_votes_button_free = $.CreatePanel("Panel", votes_panel_mid_right, "button_buy_votes_button_free");
	button_buy_votes_button_free.AddClass("button_buy_votes_button_free")

	let votes_panel_mid_right_bot = $.CreatePanel("Label", votes_panel_mid_right, "button_buy_votes_button_free_label");
	votes_panel_mid_right_bot.AddClass("votes_panel_mid_right_bot")

	var active = 1

	if (sub_data.subscribed == 1)
	{

		if (sub_data.free_vote_cd !== 0)
		{
			active = 0
			let cd = Math.max(1, Math.floor(sub_data.free_vote_cd/3600))
			let s = "#vote_free_cd_hour"

			if (cd == 1)
			{
				s = "#vote_free_cd_hour_2"
			}


			votes_panel_mid_right_bot.text = $.Localize("#vote_free_cd") + String(cd) + $.Localize(s)
		}
	}
	else 
	{
		votes_panel_mid_right_bot.text = $.Localize("#vote_free_plus")
		active = 0
	}


	if (active == 1)
	{	
		button_buy_votes_button_free.SetPanelEvent("onactivate", function() 
		{	
			
			button_buy_votes_button_free.SetPanelEvent("onactivate", function() {})

			Game.EmitSound("UI.Shop_Buy")
			GameEvents.SendCustomGameEventToServer_custom( "heroes_vote_free", {});
			$.Schedule( 0.15, function()
			{
				InitVote()
			})

		});
		button_buy_votes_button_free.AddClass("button_buy_votes_button_free_money")
	}else 
	{
		button_buy_votes_button_free.AddClass("button_buy_votes_button_free_nomoney")
	}

	let button_buy_votes_button_free_label = $.CreatePanel("Label", button_buy_votes_button_free, "button_buy_votes_button_free_label");
	button_buy_votes_button_free_label.AddClass("button_buy_votes_button_free_label")
	button_buy_votes_button_free_label.text = $.Localize("#vote_free")





	let votes_count_player = $.CreatePanel("Label", votes_panel_top, "votes_count_player");
	votes_count_player.AddClass("votes_count_player")
	votes_count_player.text = $.Localize("#vote_count")  + player_vote_count

	if (sub_data.votes_count < 1)
	{
		votes_count_player.AddClass("votes_count_player_no_votes")
	}




	let button_buy_votes_button = $.CreatePanel("Panel", votes_panel_mid_left, "button_buy_votes_button");
	button_buy_votes_button.AddClass("button_buy_votes_button")



	let button_buy_votes_label = $.CreatePanel("Label", button_buy_votes_button, "button_buy_votes_label");
	button_buy_votes_label.AddClass("button_vote_hero_buy")
	button_buy_votes_label.text = $.Localize("#vote_buy") 



	let button_buy_votes_label_icon = $.CreatePanel("Panel", button_buy_votes_button, "button_vote_hero_icon");
	button_buy_votes_label_icon.AddClass("button_vote_hero_icon")


	let button_buy_votes_label_cost = $.CreatePanel("Label", button_buy_votes_button, "button_buy_votes_label_cost");
	button_buy_votes_label_cost.AddClass("button_vote_hero_cost")
	button_buy_votes_label_cost.text = $.Localize("#shop_buy") 



	SetBuyVoteCount(button_buy_votes_button)




	let button_buy_votes_entry = $.CreatePanel("Label", votes_panel_mid_left, "");
	button_buy_votes_entry.AddClass("button_buy_votes_entry")


	let count_max = Math.max(1, Math.floor(sub_data.points/vote_cost))


	let number_entry = $.CreatePanel(`NumberEntry`, button_buy_votes_entry, "NumberEntryBuyVotes", {value : 1, min : 1, max : count_max});

	UpdateButVotes(1)

	if (number_entry)
	{
		let text_entry = number_entry.FindChildTraverse("TextEntry")
		if (text_entry)
		{
			SetChangeBuyVoteCount(text_entry)
		}
	}


	let end_date_label = $.CreatePanel("Label", $("#shop_window_6"), "");
	end_date_label.AddClass("end_date_label")
	end_date_label.text = $.Localize('#vote_end_date') + end_date

}

function SetChangeBuyVoteCount(textEntry)
{

    textEntry.SetPanelEvent("ontextentrychange", function () 
    {
      UpdateButVotes(Number(textEntry.text))
	  Game.EmitSound("UI.Click")
  	})
}

function UpdateButVotes(count)
{
	var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());
	let votes_cost = CustomNetTables.GetTableValue("shop_items", "votes_cost").cost

	let button_buy_votes_label_cost = $.GetContextPanel().FindChildTraverse("button_buy_votes_label_cost")
    let button_buy_votes_button = $.GetContextPanel().FindChildTraverse("button_buy_votes_button")

    if (button_buy_votes_label_cost)
    {
       	button_buy_votes_label_cost.text = count * votes_cost
    }

    if (button_buy_votes_button)
    {
       	if (sub_data.points >= count * votes_cost)
       	{
       		button_buy_votes_button.AddClass("button_buy_votes_money")
       		button_buy_votes_button.RemoveClass("button_buy_votes_nomoney")
       		button_buy_votes_label_cost.RemoveClass("button_vote_hero_cost_nomoney")


       	}else
       	{
       		button_buy_votes_button.RemoveClass("button_buy_votes_money")
       		button_buy_votes_button.AddClass("button_buy_votes_nomoney")
       		button_buy_votes_label_cost.AddClass("button_vote_hero_cost_nomoney")
       	}
    }
}



function SetBuyVoteCount(panel)
{
	panel.SetPanelEvent("onactivate", function() 
	{	
		BuyVoteLua()

	});
}

function BuyVoteLua()
{
	let NumberEntryBuyVotes = $.GetContextPanel().FindChildTraverse("NumberEntryBuyVotes")

	var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());
	let votes_cost = CustomNetTables.GetTableValue("shop_items", "votes_cost").cost


   	if (NumberEntryBuyVotes)
   	{
   		let text_entry = NumberEntryBuyVotes.FindChildTraverse("TextEntry")
   		if (text_entry)
   		{
	   		if (text_entry.text == "")
	   		{
	   			$.Msg("Пустое значение голосов")
	   		}
	   		else
	   		{
	   			let count_votes_buy = Number(text_entry.text)
	   			let cost_votes_buy = Number(text_entry.text) * votes_cost

	   			if (sub_data.points >= cost_votes_buy)
	   			{
					Game.EmitSound("UI.Click")
					CreateBuyWindow(-1, cost_votes_buy, String(count_votes_buy), 0)
				}
	   		}
	   	}
   	}
}

function SetOpenVoteHero(panel, hero_name, stat)
{
	panel.SetPanelEvent("onactivate", function() 
	{	

		var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());
		var player_vote_count = 0

		if (sub_data)
		{
			player_vote_count = sub_data.votes_count
		}

		if (player_vote_count > 0)
		{
			Game.EmitSound("UI.Click")
			OpenVoteHero(hero_name, stat)
		}
	});
}

function OpenVoteHero(hero_name, stat)
{
	var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());

	let main = $.GetContextPanel().FindChildTraverse("window_shop")

	Game.EmitSound("UI.Shop_Buy_start")

	let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
	blur_panel.RemoveClass("shop_window_blur_hidden")
	blur_panel.AddClass("shop_window_blur")
	

	var player_vote_count = 0

	if (sub_data)
	{
		player_vote_count = sub_data.votes_count
	}

	let vote_hero_end = $.CreatePanel("Panel", main, "vote_hero_end")
	vote_hero_end.AddClass("vote_hero_end")
	vote_hero_end.hittest = true



	vote_hero_end.SetPanelEvent("onactivate", function() {})

	let vote_information_end = $.CreatePanel("Panel", vote_hero_end, "vote_information_end")
	vote_information_end.AddClass("vote_information_end")

	var HeroImage = $.CreatePanel(`DOTAHeroImage`, vote_information_end, "", {scaling: "stretch-to-cover-preserve-aspect", heroname : String(hero_name), tabindex : "auto", class: "HeroImageVoteEnd"});

	HeroImage.AddClass("HeroImageVote_" + String(stat))

	let number_entry_end_panel = $.CreatePanel("Panel", vote_information_end, "number_entry_end_panel")
	number_entry_end_panel.AddClass("number_entry_end_panel")

	let number_entry_end = $.CreatePanel(`NumberEntry`, number_entry_end_panel, "number_entry_end", {value : player_vote_count, min : 0, max : player_vote_count});

	let buy_buttons = $.CreatePanel("Panel", vote_hero_end, "")
	buy_buttons.AddClass("buy_buttons")

	let button_buy_buy = $.CreatePanel("Panel", buy_buttons, "")
	button_buy_buy.AddClass("button_buy_buy")
	SetVoteHeroButton(button_buy_buy, hero_name, vote_hero_end)

	button_buy_buy.SetPanelEvent("onactivate", function() 
	{ 
		VoteHeroLua(hero_name)
	
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		vote_hero_end.RemoveClass("vote_hero_end")
		vote_hero_end.AddClass("vote_hero_end_hide")

		$.Schedule( 0.35, function()
		{
			vote_hero_end.DeleteAsync(0)
		})


		Game.EmitSound(hero_name + '_thx')

	  	Game.EmitSound("UI.Click")
		button_buy_close.SetPanelEvent("onactivate", function() {})


		$.Schedule( 0.25, function()
		{
			InitVote()
		})
	})

	let button_buy_close = $.CreatePanel("Panel", buy_buttons, "")
	button_buy_close.AddClass("button_buy_close")


	button_buy_close.SetPanelEvent("onactivate", function() 
	{ 
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		vote_hero_end.RemoveClass("vote_hero_end")
		vote_hero_end.AddClass("vote_hero_end_hide")

		$.Schedule( 0.35, function()
		{
			vote_hero_end.DeleteAsync(0)
		})

		Game.EmitSound("UI.Shop_Category_Open")

		button_buy_close.SetPanelEvent("onactivate", function() {})
	})

	blur_panel.SetPanelEvent("onactivate", function() 
	{ 

		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		vote_hero_end.RemoveClass("vote_hero_end")
		vote_hero_end.AddClass("vote_hero_end_hide")

		$.Schedule( 0.35, function()
		{
			vote_hero_end.DeleteAsync(0)
		})

		Game.EmitSound("UI.Shop_Category_Open")

		blur_panel.SetPanelEvent("onactivate", function() {})
	})




	let label_button_1 = $.CreatePanel("Label", button_buy_buy, "")
	label_button_1.AddClass("label_button_buy_vote")
	label_button_1.text = $.Localize("#vote")

	let label_button_2 = $.CreatePanel("Label", button_buy_close, "")
	label_button_2.AddClass("label_button_buy")
	label_button_2.text = $.Localize("#close")
}

function SetCloseVoteButton(panela, panelb)
{

}
function SetVoteHeroButton(panel, hero_name, panelb)
{
	
}

function VoteHeroLua(hero_name)
{
	let number_entry_end = $.GetContextPanel().FindChildTraverse("number_entry_end")
   	if (number_entry_end)
   	{
   		let text_entry = number_entry_end.FindChildTraverse("TextEntry")
   		if (text_entry)
   		{
	   		if (text_entry.text == "")
	   		{
	   			$.Msg("Пустое значение голосов")
	   		}
	   		else
	   		{
	   			let count_votes = Number(text_entry.text)
				GameEvents.SendCustomGameEventToServer_custom( "heroes_vote_change", {count : count_votes , name : hero_name});
	   		}
	   	}
   	}
}


function CheckShards()
{
	let main = $.GetContextPanel().FindChildTraverse("window_shop")

	if ((main) && (main.BHasClass("shop_window_show")))
	{
		UpdateShards()
	}

	$.Schedule( 1, function()
	{
		CheckShards()
	});
}






function UpdateShards()
{
	var player_data_local = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer());
	let points_label = $.GetContextPanel().FindChildTraverse("CurrencyNumber")
	if (points_label)
	{
		points_label.text = player_data_local["points"]
	}

	if (player_data_local.subscribed == 0 && player_data_local.points >= 500)
	{
		points_label.AddClass("CurrencyNumber_limit")
		points_label.text =  player_data_local["points"] + '/500'
	}else
	{
		points_label.RemoveClass("CurrencyNumber_limit")
	}

	UpdateBonusShards()	


}



var sound = null

function UpdateBonusShards()
{
	let main = $.GetContextPanel().FindChildTraverse("BonusCurrencyButton")
	var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());

	if (main)
	{
		let text = ''
		let active = 0



		if (sub_data.bonus_shards_cd > 0)
		{

			active = 0
			let cd = Math.max(1, Math.floor(sub_data.bonus_shards_cd/3600))
			let s = "#vote_free_cd_hour"

			if (cd == 1)
			{
				s = "#vote_free_cd_hour_2"
			}

			text = $.Localize("#bonus_shards_notactive") + String(cd) + $.Localize(s)
		}else
		{
			active = 1
			text = $.Localize("#bonus_shards_active")
		}


		main.SetPanelEvent('onmouseover', function() 
		{
		   	 $.DispatchEvent('DOTAShowTextTooltip', main, text) 
		});
		    
		main.SetPanelEvent('onmouseout', function() 
		{
		   $.DispatchEvent('DOTAHideTextTooltip', main);
		});


		if (active == 0)
		{

			main.AddClass("BonusCurrencyButton_notactive")
			main.RemoveClass("BonusCurrencyButton_active")

			main.SetPanelEvent("onactivate", function() {});
		}else
		{
			main.AddClass("BonusCurrencyButton_active")
			main.RemoveClass("BonusCurrencyButton_notactive")

			main.SetPanelEvent("onactivate", function() {OpenBonusShards()});
		}
	}
}



function OpenBonusShards()
{
	var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());

	let main = $.GetContextPanel().FindChildTraverse("window_shop")

	Game.EmitSound("UI.Shop_Buy_start")

	let buy_panel = $.CreatePanel("Panel", main, "bonus_shards_panel")
	buy_panel.AddClass("bonus_shards_panel")

	let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
	blur_panel.RemoveClass("shop_window_blur_hidden")
	blur_panel.AddClass("shop_window_blur")
	

	let bonus_panel_top = $.CreatePanel("Panel", buy_panel, "")
	bonus_panel_top.AddClass("bonus_panel_top")

	let bonus_panel_top_text = $.CreatePanel("Label", bonus_panel_top, "")
	bonus_panel_top_text.AddClass("bonus_panel_top_text")

	bonus_panel_top_text.text = $.Localize("#bonus_panel_top")



	let closebuy = $.CreatePanel("Panel", bonus_panel_top, "")
	closebuy.AddClass("bonus_panel_close")

	let bonus_panel_mid = $.CreatePanel("Panel", buy_panel, "bonus_shards_panel_mid")
	bonus_panel_mid.AddClass("bonus_panel_mid")


	let bonus_panel_amount = $.CreatePanel("Label", bonus_panel_mid, "bonus_panel_amount")
	bonus_panel_amount.AddClass("bonus_panel_amount")
	bonus_panel_amount.text = '+0'



	let bonus_panel_max = $.CreatePanel("Label", bonus_panel_mid, "bonus_panel_max")
	bonus_panel_max.AddClass("bonus_panel_max")

	bonus_panel_max.html = true
	bonus_panel_max.text = $.Localize("#bonus_shards_random")

	let bonus_panel_icon = $.CreatePanel("Panel", bonus_panel_mid, "")
	bonus_panel_icon.AddClass("bonus_panel_icon")



	GameEvents.SendCustomGameEventToServer_custom( "get_bonus_shards", {});


	$.Schedule( 0.25, function()
	{
		UpdateBonusShards()
	});

	blur_panel.SetPanelEvent("onactivate", function() 
	{ 

		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		buy_panel.AddClass("bonus_shards_panel_hide")
		buy_panel.RemoveClass("bonus_shards_panel")

		UpdateShards()

		$.Schedule( 0.35, function()
		{
			buy_panel.DeleteAsync(0)
		})


		if (sound != null)
		{
			Game.StopSound(sound)
		}

		if (sound != -1)
		{
		
			Game.EmitSound("Sub.Points_end")
		}
		Game.EmitSound("UI.Shop_Category_Open")

		blur_panel.SetPanelEvent("onactivate", function() {})
	})



}


function give_bonus_shards(kv)
{

	AddBonusShards(0, kv.count, kv.limit)


	if (kv.count > 0)
	{	
		sound = Game.EmitSound("Sub.Points_inc")
	}
}

function AddBonusShards(current, max, limit)
{
	var panel = $.GetContextPanel().FindChildTraverse("bonus_panel_amount")

	if (panel)
	{

		var text = current + 1

		if (max == 0)
		{
			text = 0
		}

		panel.text = '+' + String(text)

		if (text < max)
		{

			$.Schedule(0.04, function ()
			{
				AddBonusShards(text, max, limit)
			})

		}else
		{
			if (limit == 1)
			{

				let bonus_panel_max = $.GetContextPanel().FindChildTraverse("bonus_panel_max")
				bonus_panel_max.text = $.Localize("#bonus_shards_max")
			}

			if (sound != null)
			{
				Game.StopSound(sound)

				Game.EmitSound("Sub.Points_end")

				sound = -1
			}
		}
	}

}














var items_cooldown = {}
var current_shop_hero_choose

GameEvents.Subscribe_custom('shop_dota1x6_item_cooldown', shop_dota1x6_item_cooldown)

function shop_dota1x6_item_cooldown(data)
{
    items_cooldown[data.slot_type] = data.time
}

function InitHeroesItems()
{
	let table_heroes = CustomNetTables.GetTableValue("custom_pick", "hero_list")
	let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroListItems")
	const hero_names_sorted = [...Object.keys(table_heroes)].sort()

	let heroes_strength = []
	let heroes_agility = []
	let heroes_intellect = []
	let heroes_all = []

    for (const hero_name of hero_names_sorted)
    {
        if (table_heroes[hero_name] == 0)
        {
            heroes_strength.push(hero_name)
        } else if (table_heroes[hero_name] == 1) {
            heroes_agility.push(hero_name)
        } else if (table_heroes[hero_name] == 2) {
            heroes_intellect.push(hero_name)
        } else if (table_heroes[hero_name] == 3) {
            heroes_all.push(hero_name)
        }
    }

	if (heroes_panel)
	{
		heroes_panel.RemoveAndDeleteChildren()

		let attribute_info = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info.AddClass("attribute_info")
	
		let hero_icon_str = $.CreatePanel("Panel", attribute_info, "");
		hero_icon_str.AddClass("hero_icon_str")
	
		let hero_label_str = $.CreatePanel("Label", attribute_info, "");
		hero_label_str.AddClass("hero_label_str")
		hero_label_str.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_str")

		const str_row = $.CreatePanel("Panel", heroes_panel, "StrengthHeroes");

		let attribute_info_2 = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info_2.AddClass("attribute_info")
	
		let hero_icon_agi = $.CreatePanel("Panel", attribute_info_2, "");
		hero_icon_agi.AddClass("hero_icon_agi")
	
		let hero_label_agi = $.CreatePanel("Label", attribute_info_2, "");
		hero_label_agi.AddClass("hero_label_agi")
		hero_label_agi.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_agi")

		const agi_row = $.CreatePanel("Panel", heroes_panel, "AgilityHeroes");

		let attribute_info_3 = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info_3.AddClass("attribute_info")
	
		let hero_icon_int = $.CreatePanel("Panel", attribute_info_3, "");
		hero_icon_int.AddClass("hero_icon_int")
	
		let hero_label_int = $.CreatePanel("Label", attribute_info_3, "");
		hero_label_int.AddClass("hero_label_int")
		hero_label_int.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_int")

		const int_row = $.CreatePanel("Panel", heroes_panel, "IntellectHeroes");

        let attribute_info_4 = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info_4.AddClass("attribute_info")
	
		let hero_icon_all = $.CreatePanel("Panel", attribute_info_4, "");
		hero_icon_all.AddClass("hero_icon_all")
	
		let hero_label_all = $.CreatePanel("Label", attribute_info_4, "");
		hero_label_all.AddClass("hero_label_all")
		hero_label_all.text = $.Localize("#stats_all")

		const all_row = $.CreatePanel("Panel", heroes_panel, "AllHeroes");

		for (var i = 0; i < Object.keys(heroes_strength).length; i++) 
		{
			CreateHeroPanelItems(str_row, heroes_strength[i])
		}

		for (var i = 0; i < Object.keys(heroes_agility).length; i++) 
		{
			CreateHeroPanelItems(agi_row, heroes_agility[i])
		}

		for (var i = 0; i < Object.keys(heroes_intellect).length; i++) 
		{
			CreateHeroPanelItems(int_row, heroes_intellect[i])
		}

        for (var i = 0; i < Object.keys(heroes_all).length; i++) 
		{
			CreateHeroPanelItems(all_row, heroes_all[i])
		}
	}
}


function CreateHeroPanelItems(panel, hero_name, stat) 
{
    var player_data_local = player_table_shop
    var BlockHero = $.CreatePanel("Panel", panel, "");
    BlockHero.AddClass("BlockHeroItems");
    var HeroImage = $.CreatePanel(`DOTAHeroImage`, BlockHero, "", {scaling: "stretch-to-cover-preserve-aspect", heroname : String(hero_name), tabindex : "auto", class: "HeroImage", heroimagestyle : "portrait"});
    let items = CustomNetTables.GetTableValue("heroes_items_info", String(hero_name))

    if (new_items[hero_name])
    {
    	let new_alert = $.CreatePanel("Panel", BlockHero, "")
    	new_alert.AddClass("new_alert")
        BlockHero.AddClass("BlockHeroItems_new")
    }

    if (items)
    {
        if (Object.keys(items).length <= 0)
        {
            BlockHero.AddClass("hero_no_items")
        }
        else
        {
            BlockHero.SetPanelEvent("onactivate", function() 
            {	
                current_shop_hero_choose = hero_name
                OpenItemsForHero()
            });
        }
    }
    else
    {
        BlockHero.AddClass("hero_no_items")
    }
}

function OpenItemsForHero()
{
	Game.EmitSound("UI.Click")
	let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroListItems")
	if (heroes_panel)
	{
		heroes_panel.style.visibility = "collapse"
	}
	let ItemsList = $.GetContextPanel().FindChildTraverse("ItemsList")
	if (ItemsList)
	{
		ItemsList.style.visibility = "visible"
	}
	InitShopItemsForHero(ItemsList)
}

function InitShopItemsForHero(panel)
{
    if (current_shop_hero_choose)
    {
        panel.RemoveAndDeleteChildren()
        let items = CustomNetTables.GetTableValue("heroes_items_info", String(current_shop_hero_choose))


        if (items)
        {
            if (SETS_PRIORITY[current_shop_hero_choose])
            {
                for (var i = 0; i < SETS_PRIORITY[current_shop_hero_choose].length; i++) 
                {
                    CreateSlotTypeInfo(panel, SETS_PRIORITY[current_shop_hero_choose][i])
                }
            }
            // Sort
            let new_table = []
            for (var item = 0; item <= Object.keys(items).length; item++)
            {
                let check_in = item
                if (items[Object.keys(items)[check_in]])
                {
                    new_table[item] = []
                    new_table[item].push(items[Object.keys(items)[check_in]]["item_id"], items[Object.keys(items)[check_in]]["price"])
                }
            }
            new_table.sort(function (a, b) 
            {
                return Number(a[1])-Number(b[1])
            });
            
            for (var i = 0; i <= new_table.length; i++) 
            {
                if (new_table[i])
                {
                    CreateItemShopItemHero(panel, items[new_table[i][0]])
                } 
            }
            if (Object.keys(items).length <= 0)
            {
                var ComingSoonText = $.CreatePanel("Label", panel, "");
                ComingSoonText.AddClass("QuestComingSoon");
                ComingSoonText.text = $.Localize("#soon_ingame")
            }
        } 
        else 
        {
            var ComingSoonText = $.CreatePanel("Label", panel, "");
            ComingSoonText.AddClass("QuestComingSoon");
            ComingSoonText.text = $.Localize("#soon_ingame")
        }
    }
}


function CreateSlotTypeInfo(panel, name)
{
    if (name == "rare")
    {
        let slot_name_panel = $.CreatePanel("Label", panel, "");
        slot_name_panel.AddClass("slot_name_panel");
        let slot_panel = $.CreatePanel("Panel", panel, "");
        slot_panel.AddClass("slot_panel");
        let slot_name = $.CreatePanel("Label", slot_name_panel, "");
        slot_name.AddClass("slot_name");
        slot_name.text = $.Localize("#"+name)
        let main_parent = $.CreatePanel("Panel", slot_panel, "panel_"+name);
        main_parent.AddClass("SlotType");
        return main_parent
    }
    else
    {
        let set_this_info = GetAllItemsInSet(name, current_shop_hero_choose)

        let slot_name_panel = $.CreatePanel("Label", panel, "");
        slot_name_panel.AddClass("slot_name_panel");

        let slot_panel = $.CreatePanel("Panel", panel, "");
        slot_panel.AddClass("slot_panel");

        let slot_name = $.CreatePanel("Label", slot_name_panel, "");
        slot_name.AddClass("slot_name");
        slot_name.text = $.Localize("#"+name)

        let slot_panel_sets = $.CreatePanel("Panel", slot_panel, "");
        slot_panel_sets.AddClass("slot_panel_sets");

        let sets_texture = $.CreatePanel("Panel", slot_panel_sets, "");
        sets_texture.AddClass("sets_texture");

        let sets_texture_background = $.CreatePanel("Panel", sets_texture, "");
        sets_texture_background.AddClass("sets_texture_bg");

        let texture_bg = current_shop_hero_choose.replace("npc_dota_hero_", "")
        if (OTHER_BACKGROUND_HEROES[current_shop_hero_choose] != null)
        {
            texture_bg = OTHER_BACKGROUND_HEROES[current_shop_hero_choose]
        }
        sets_texture_background.style.backgroundImage = 'url("s2r://materials/portraits_card/portrait_backgrounds/' + texture_bg + '.psd")';
        sets_texture_background.style.backgroundSize = "cover"

        let hero_image_sets = $.CreatePanel("Panel", sets_texture, "");
        hero_image_sets.AddClass("hero_image_sets");
        hero_image_sets.style.backgroundImage = 'url("s2r://panorama/images/' + SETS_TEXTURE_FULL_ICON[name] + '.png")';
        hero_image_sets.style.backgroundSize = "100%"

        $.Msg(set_this_info)

        if (name != "pudge_persona")
        {
            let buy_full_set_button = $.CreatePanel("Panel", sets_texture, "");
            buy_full_set_button.AddClass("buy_full_set_button");

            let set_center_button = $.CreatePanel("Panel", buy_full_set_button, "");
            set_center_button.AddClass("set_center_button");
            let shardcost_icon_sets = $.CreatePanel("Panel", set_center_button, "");
            shardcost_icon_sets.AddClass("buy_full_set_icon");
            let price_info_sets = $.CreatePanel("Label", set_center_button, "");
            price_info_sets.AddClass("buy_full_set_label");

            if (set_this_info[3] != null && set_this_info[3] != 0 && set_this_info[4] != null && set_this_info[4] != 0)
            {
                var buy_full_set_old_panel = $.CreatePanel("Panel", buy_full_set_button, "");
                buy_full_set_old_panel.AddClass("buy_full_set_old_panel");

                let buy_full_set_old_text = $.CreatePanel("Label", buy_full_set_old_panel, "");
                buy_full_set_old_text.AddClass("buy_full_set_old_text");
                buy_full_set_old_text.text = set_this_info[2]

                price_info_sets.text = set_this_info[4]

                var buy_full_set_line = $.CreatePanel("Panel", buy_full_set_old_panel, "");
                buy_full_set_line.AddClass("buy_full_set_line");

                buy_full_set_button.AddClass("buy_full_set_button_sale");
            }else 
            {
                price_info_sets.text = set_this_info[2]
            }
        }

        if (set_this_info[3] > 0)
        {
            var BlockItemSale = $.CreatePanel("Panel", sets_texture, "BlockItemSale");
            BlockItemSale.AddClass("sets_texture_sale");

            var BlockItemSaleText = $.CreatePanel("Label", BlockItemSale, "BlockItemSaleText");
            BlockItemSaleText.AddClass("sets_texture_sale_text");
            BlockItemSaleText.text = '-' + String(set_this_info[3]) + '%'
        }

        let main_parent = $.CreatePanel("Panel", slot_panel_sets, "panel_"+name);
        main_parent.AddClass("SlotType");
        return main_parent
    }
}

function CreateItemShopItemHero(panel, info) 
{
    if (info["hide"] == 1)
    {
        return
    }

    let main_parent = panel

    if (info["sets"] != null)
    {
        main_parent = panel.FindChildTraverse("panel_"+info["sets"])
        if (main_parent == null)
        {
            main_parent = CreateSlotTypeInfo(panel, info["sets"])
        }
    }

    let sets = info["sets"]

    let original_item_id = info["item_id"]

    var BlockItem = $.CreatePanel("Panel", main_parent, "item_id_" + info["item_id"]);
    BlockItem.AddClass("BlockItem");
    BlockItem.slot_type = info["SlotType"]

    var BlockItemImage = $.CreatePanel("Panel", BlockItem, "BlockItemImage");
    BlockItemImage.AddClass("BlockItemImage");

    var BlockItemLabel = $.CreatePanel("Label", BlockItem, "");
    BlockItemLabel.AddClass("BlockItemLabel");

    var BlockItemBuyButton = $.CreatePanel("Panel", BlockItem, "button");
    BlockItemBuyButton.AddClass("BlockItemBuyButton");

    var BlockItemBuyButtonCenter = $.CreatePanel("Panel", BlockItemBuyButton, "");
    BlockItemBuyButtonCenter.AddClass("BlockItemBuyButtonCenter");

    var BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButtonCenter, "");
    BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel");
    BlockItemBuyButtonLabel.text = $.Localize("#shop_buy")
    BlockItemBuyButtonLabel.style.marginRight = "8px"

    var shardcost_icon = $.CreatePanel("Panel", BlockItemBuyButtonCenter, "");
    shardcost_icon.AddClass("shardcost_icon");

    var BlockItemBuyButtonLabel_price = $.CreatePanel("Label", BlockItemBuyButtonCenter, "");
    BlockItemBuyButtonLabel_price.AddClass("BlockItemBuyButtonLabel");
    BlockItemBuyButtonLabel_price.text = info["price"]


    if (info['sale'] && info['sale'] > 0)
    {
        var BlockItemSale = $.CreatePanel("Panel", BlockItemImage, "BlockItemSale");
        BlockItemSale.AddClass("BlockItemImage_sale");

        var BlockItemSaleText = $.CreatePanel("Label", BlockItemSale, "BlockItemSaleText");
        BlockItemSaleText.AddClass("BlockItemImage_sale_text");
        BlockItemSaleText.text = '-' + String(info['sale']) + '%'

        if (info['sale_price'] && info['sale_price'] > 0 )
        {
            BlockItemBuyButtonLabel_price.text =  info['sale_price']
            BlockItemBuyButtonLabel.text =  info['price']

            BlockItemBuyButtonLabel_price.RemoveClass("BlockItemBuyButtonLabel")
            BlockItemBuyButtonLabel_price.AddClass("BlockItemBuyButtonLabel_new_price")

            BlockItemBuyButtonLabel.RemoveClass("BlockItemBuyButtonLabel")
            BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel_old_price")

            var BlockItemBuyButton_line = $.CreatePanel("Panel", BlockItemBuyButton, "button_line");
            BlockItemBuyButton_line.AddClass("BlockItemBuyButton_line");

            BlockItemBuyButton.AddClass("BlockItemBuyButtonCenter_sale");
        }
    }

    var player_data_local = player_table_shop


    if (styles_id[info["item_id"]])
    {
        for (var i = 0; i <= Object.keys(styles_id[info["item_id"]]).length - 1; i++) 
        {
            if (HasItemUneqieup(current_shop_hero_choose, styles_id[info["item_id"]][i]))
            {
                original_item_id = styles_id[info["item_id"]][i]
                break
            }
        }

    }


    if (info)
    {
        if (HasItemInventory(info["item_id"]))
        {
            BlockItemBuyButton.style.visibility = "collapse"
            BlockItem.AddClass("BlockItem_purchased")
            var BlockItemActivateButton = $.CreatePanel("Panel", BlockItem, "button_activate");
            BlockItemActivateButton.AddClass("BlockItemBuyButton");
            var BlockItemActivateButtonLabel = $.CreatePanel("Label", BlockItemActivateButton, "BlockItemActivateButtonLabel");
            BlockItemActivateButtonLabel.AddClass("BlockItemBuyButtonLabel");

            if (Players.GetPlayerSelectedHero( Players.GetLocalPlayer() ) != current_shop_hero_choose)
            {
                BlockItemActivateButton.style.opacity = "0"
                if (info["OtherItemsBundle"])
                {
                    var ButtonsItemStyles = $.CreatePanel("Panel", BlockItemImage, "ButtonsItemStyles");
                    ButtonsItemStyles.AddClass("ButtonsItemStyles");
                    for (var i = 1; i <= Object.keys(info["OtherItemsBundle"]).length; i++) 
                    {
                        var ButtonItemStyle = $.CreatePanel("Panel", ButtonsItemStyles, "item_style_" + info["OtherItemsBundle"][i][1]);
                        ButtonItemStyle.AddClass("ButtonItemStyle");
                        ButtonItemStyle.style.backgroundColor = info["OtherItemsBundle"][i][2]
                        var ButtonItemStyleActiveIcon = $.CreatePanel("Panel", ButtonItemStyle, "");
                        ButtonItemStyleActiveIcon.AddClass("ButtonItemStyleActiveIcon");
                    }
                }
            }
            else
            {
                if (HasItemUneqieup(current_shop_hero_choose, original_item_id))
                {
                    BlockItemActivateButtonLabel.text = $.Localize("#shop_unequip")
                    BlockItemActivateButton.AddClass("BlockItemBuyButton_unequip")
                    BlockItemActivateButton.RemoveClass("BlockItemBuyButton_equip")
                    BlockItemActivateButton.SetPanelEvent("onactivate", function() 
                    { 
                        UneuipItemHero(info["item_id"], info["SlotType"], original_item_id, BlockItem, sets)
                    });
                    BlockItem.SetPanelEvent("onactivate", function() 
                    { 
                        UneuipItemHero(info["item_id"], info["SlotType"], original_item_id, BlockItem, sets)
                    });
                }
                else
                {
                    BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
                    BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
                    BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
                    BlockItemActivateButton.SetPanelEvent("onactivate", function() 
                    { 
                        UneuipItemHero(info["item_id"], info["SlotType"], original_item_id, BlockItem, sets)
                    });
                    BlockItem.SetPanelEvent("onactivate", function() 
                    { 
                        UneuipItemHero(info["item_id"], info["SlotType"], original_item_id, BlockItem, sets)
                    });
                }
    
                if (info["OtherItemsBundle"])
                {
                    var ButtonsItemStyles = $.CreatePanel("Panel", BlockItemImage, "ButtonsItemStyles");
                    ButtonsItemStyles.AddClass("ButtonsItemStyles");
                    for (var i = 1; i <= Object.keys(info["OtherItemsBundle"]).length; i++) 
                    {
                        var ButtonItemStyle = $.CreatePanel("Panel", ButtonsItemStyles, "item_style_" + info["OtherItemsBundle"][i][1]);
                        ButtonItemStyle.AddClass("ButtonItemStyle");
                        ButtonItemStyle.style.backgroundColor = info["OtherItemsBundle"][i][2]
                        var ButtonItemStyleActiveIcon = $.CreatePanel("Panel", ButtonItemStyle, "");
                        ButtonItemStyleActiveIcon.AddClass("ButtonItemStyleActiveIcon");
    
                        SetButtonStyle(ButtonItemStyle, info["OtherItemsBundle"][i][1], info["SlotType"], BlockItem, info["item_id"], sets)
                        if (HasItemUneqieup(current_shop_hero_choose, info["OtherItemsBundle"][i][1]))
                        {
                            ButtonItemStyle.SetHasClass("ButtonItemStyle_active", true)
                        } 
                    }
                }
            } 
        } 
        else 
        {
            if (razor_arcana_items_blocked[info["item_id"]])
            {
                // ДОБАВИТЬ СЮДА ТУПА СТИЛЬКА ЕСЛИ  НАДО
                BlockItemBuyButton.style.opacity = "0"
            }
            else if (pudge_persona_unique[info["item_id"]] && !HasItemInventory(999251))
            {
                BlockItemBuyButton.style.opacity = "0"
            }
            else if (crystal_maiden_persona_unique[info["item_id"]] && !HasItemInventory(26559))
            {
                BlockItemBuyButton.style.opacity = "0"
            }
            else
            {

                if ( info["sale_price"] &&  info["sale_price"] > 0)
                {
                    BlockItemBuyButton.RemoveClass("BlockItemBuyButton_nomoney")
                    BlockItemBuyButtonLabel.RemoveClass("BlockItemBuyButtonLabel_nomoney")
                    BlockItemBuyButton.AddClass("BlockItemBuyButton_sale")
                    BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel")
                    BlockItem.AddClass("BlockItem_sale")

                    let buy = true

                    if (player_data_local && player_data_local["points"] >= info["sale_price"])
                    {
                        buy = null
                    }

                    BlockItem.SetPanelEvent("onactivate", function() 
                    { 
                        CreateBuyWindow(info["item_id"], info["sale_price"], info["name"], 0, current_shop_hero_choose, buy, info["OtherItemsBundle"])
                    })
                }
                else
                {
                    if (player_data_local && player_data_local["points"] >= info["price"])
                    {
                        BlockItemBuyButton.RemoveClass("BlockItemBuyButton_nomoney")
                        BlockItemBuyButton.AddClass("BlockItemBuyButton_money")
                        BlockItemBuyButtonLabel.RemoveClass("BlockItemBuyButtonLabel_nomoney")
                        BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel")
                        BlockItem.AddClass("BlockItem_money")
                        BlockItem.RemoveClass("BlockItem_nomoney")
                        BlockItem.SetPanelEvent("onactivate", function() 
                        { 
                            CreateBuyWindow(info["item_id"], info["price"], info["name"], 0, current_shop_hero_choose, null, info["OtherItemsBundle"])
                        })
                    } 
                    else 
                    {
                        BlockItem.RemoveClass("BlockItem_money")
                        BlockItem.AddClass("BlockItem_nomoney")
                        BlockItemBuyButton.AddClass("BlockItemBuyButton_nomoney")
                        BlockItemBuyButton.RemoveClass("BlockItemBuyButton_money")
                        BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel_nomoney")
                        BlockItemBuyButtonLabel.RemoveClass("BlockItemBuyButtonLabel")
                        BlockItem.SetPanelEvent("onactivate", function() 
                        { 
                            CreateBuyWindow(info["item_id"], info["price"], info["name"], 0, current_shop_hero_choose, true, info["OtherItemsBundle"])
                        })
                    }
                }
            }

            if (info["OtherItemsBundle"])
            {
                var ButtonsItemStyles = $.CreatePanel("Panel", BlockItemImage, "ButtonsItemStyles");
                ButtonsItemStyles.AddClass("ButtonsItemStyles");
                for (var i = 1; i <= Object.keys(info["OtherItemsBundle"]).length; i++) 
                {
                    var ButtonItemStyle = $.CreatePanel("Panel", ButtonsItemStyles, "item_style_" + info["OtherItemsBundle"][i][1]);
                    ButtonItemStyle.AddClass("ButtonItemStyle");
                    ButtonItemStyle.style.backgroundColor = info["OtherItemsBundle"][i][2]
                    var ButtonItemStyleActiveIcon = $.CreatePanel("Panel", ButtonItemStyle, "");
                    ButtonItemStyleActiveIcon.AddClass("ButtonItemStyleActiveIcon");
                    SetButtonStyleNoBuy(ButtonItemStyle, info["OtherItemsBundle"][i][1], info["SlotType"], BlockItem, info["item_id"], sets, i)
                    if (i == 1)
                    {
                        ButtonItemStyle.SetHasClass("ButtonItemStyle_active", true)
                    }
                }
            }
            if (!PLAYER_VIEW_ITEMS_FOR_BUY)
            {
                BlockItem.style.visibility = "collapse"
            }
        }

        BlockItemLabel.text = $.Localize(info["name"])

        if (info["local_icon"] && info["local_icon"] == 1)
        {
            BlockItemImage.style.backgroundImage = 'url("file://{images}/custom_game/shop/heroes/' + info["icon"] + '.png")'
        }else 
        {
            BlockItemImage.style.backgroundImage = 'url("s2r://panorama/images/' + info["icon"] + '.png")';
        }

        BlockItemImage.style.backgroundSize = "100%"
    }
}
function SetButtonStyle(panel, item, slot, item_block, block_id, sets)
{
    panel.SetPanelEvent("onactivate", function() 
    {
        SwapUneuipItemHero(item, slot, item_block, block_id, sets)
    });
}

function SetButtonStyleNoBuy(panel, item, slot, item_block, block_id, sets, style)
{
    panel.SetPanelEvent("onactivate", function() 
    {
        UpdateShopBlockImageNoBuy(item_block, item, block_id, sets, style)
    });
}

function HasItemUneqieup(hero, id)
{
	var player_data_local = player_table_shop
	if (player_data_local)
	{
		if (player_data_local["player_items_onequip"])
		{
			let hero_items = player_data_local["player_items_onequip"][String(hero)]
			for (var i = 1; i <= Object.keys(hero_items).length; i++) 
			{
				if (String(hero_items[i]) == String(id))
				{
					return true
				}
			}
		}
	}
	return false
}


function SwapUneuipItemHero(id, slot_type, item_block, block_id, sets)
{
    if (items_cooldown[slot_type] != null && items_cooldown[slot_type] > 0)
    {
        GameEvents.SendEventClientSide("dota_hud_error_message", 
        {
            "splitscreenplayer": 0,
            "reason": 80,
            "message": $.Localize("#dota_item_change_error") + items_cooldown[slot_type]
        })
        return
    }

    if (!HasItemUneqieup(current_shop_hero_choose, id))
    {
        if (HeroIsAlive() && IsLockedTime())
        {
            Game.EmitSound("UI.Shop_Buy_equip")
            GameEvents.SendCustomGameEventToServer_custom( "dota1x6_item_change", {item_id: id, current_hero:current_shop_hero_choose, remove : 0} );
            UpdateShopBlock(item_block, id, block_id, sets)
            UpdateQuipHeroItem(block_id, true, slot_type, sets)
        }
    }
}
function UpdateShopBlockImageNoBuy(BlockItem, item_id, block_id, sets, style)
{
    let info = null
	let items = CustomNetTables.GetTableValue("heroes_items_info", String(current_shop_hero_choose))
	if (items)
	{
		for (var i = 0; i < Object.keys(items).length; i++) 
		{
			if (items[Object.keys(items)[i]]["item_id"] == item_id)
			{
				info = items[Object.keys(items)[i]]
			}
		}
	}
    let BlockItemActivateButtonLabel = BlockItem.FindChildTraverse("BlockItemActivateButtonLabel")
    let BlockItemActivateButton = BlockItem.FindChildTraverse("button_activate")
    let ButtonsItemStyles = BlockItem.FindChildTraverse("ButtonsItemStyles")
    let BlockItemImage = BlockItem.FindChildTraverse("BlockItemImage")
    if (BlockItemImage)
    {
        BlockItemImage.style.backgroundImage = 'url("s2r://panorama/images/' + info["icon"] + '.png")';
        BlockItemImage.style.backgroundSize = "100%"
    }
    if (info["OtherItemsBundle"])
    {
        ButtonsItemStyles.RemoveAndDeleteChildren()
        for (var i = 1; i <= Object.keys(info["OtherItemsBundle"]).length; i++) 
        {
            var ButtonItemStyle = $.CreatePanel("Panel", ButtonsItemStyles, "item_style_" + info["OtherItemsBundle"][i][1]);
            ButtonItemStyle.AddClass("ButtonItemStyle");
            ButtonItemStyle.style.backgroundColor = info["OtherItemsBundle"][i][2]
            var ButtonItemStyleActiveIcon = $.CreatePanel("Panel", ButtonItemStyle, "");
			ButtonItemStyleActiveIcon.AddClass("ButtonItemStyleActiveIcon");
            SetButtonStyleNoBuy(ButtonItemStyle, info["OtherItemsBundle"][i][1], info["SlotType"], BlockItem, block_id, sets, i)
            if (style == i)
            {
                ButtonItemStyle.SetHasClass("ButtonItemStyle_active", true)
            }
        }
    }
}

function UpdateShopBlock(BlockItem, item_id, block_id, sets) 
{
    let info = null
	let items = CustomNetTables.GetTableValue("heroes_items_info", String(current_shop_hero_choose))
	if (items)
	{
		for (var i = 0; i < Object.keys(items).length; i++) 
		{
			if (items[Object.keys(items)[i]]["item_id"] == item_id)
			{
				info = items[Object.keys(items)[i]]
			}
		}
	}

    let BlockItemActivateButtonLabel = BlockItem.FindChildTraverse("BlockItemActivateButtonLabel")
    let BlockItemActivateButton = BlockItem.FindChildTraverse("button_activate")
    let ButtonsItemStyles = BlockItem.FindChildTraverse("ButtonsItemStyles")
    let BlockItemImage = BlockItem.FindChildTraverse("BlockItemImage")

    if (BlockItemActivateButtonLabel)
    {
        BlockItemActivateButtonLabel.text = $.Localize("#shop_unequip")   
    }

    if (BlockItemActivateButton)
    {
        BlockItemActivateButton.AddClass("BlockItemBuyButton_unequip")
        BlockItemActivateButton.RemoveClass("BlockItemBuyButton_equip")
        BlockItemActivateButton.SetPanelEvent("onactivate", function() 
        { 
            UneuipItemHero(block_id, info["SlotType"], info["item_id"], BlockItem, sets)
        });
        BlockItem.SetPanelEvent("onactivate", function() 
        { 
            UneuipItemHero(block_id, info["SlotType"], info["item_id"], BlockItem, sets)
        });
    }

    if (BlockItemImage)
    {
        BlockItemImage.style.backgroundImage = 'url("s2r://panorama/images/' + info["icon"] + '.png")';
        BlockItemImage.style.backgroundSize = "100%"
    }

    if (info["OtherItemsBundle"])
    {
        ButtonsItemStyles.RemoveAndDeleteChildren()
        for (var i = 1; i <= Object.keys(info["OtherItemsBundle"]).length; i++) 
        {
            var ButtonItemStyle = $.CreatePanel("Panel", ButtonsItemStyles, "item_style_" + info["OtherItemsBundle"][i][1]);
            ButtonItemStyle.AddClass("ButtonItemStyle");
            ButtonItemStyle.style.backgroundColor = info["OtherItemsBundle"][i][2]
            var ButtonItemStyleActiveIcon = $.CreatePanel("Panel", ButtonItemStyle, "");
			ButtonItemStyleActiveIcon.AddClass("ButtonItemStyleActiveIcon");
            SetButtonStyle(ButtonItemStyle, info["OtherItemsBundle"][i][1], info["SlotType"], BlockItem, block_id, sets)
            if (info["OtherItemsBundle"][i][1] == info["item_id"])
            {
                ButtonItemStyle.SetHasClass("ButtonItemStyle_active", true)
            }
        }
    }
}


function UneuipItemHero(id, slot_type, original_item_id, BlockItem, sets)
{
    id = Number(id)
    original_item_id = Number(original_item_id)
    
    if (items_cooldown[slot_type] != null && items_cooldown[slot_type] > 0)
    {
        GameEvents.SendEventClientSide("dota_hud_error_message", 
        {
            "splitscreenplayer": 0,
            "reason": 80,
            "message": $.Localize("#dota_item_change_error") + items_cooldown[slot_type]
        })
        return
    }

    if (HeroIsAlive() && IsLockedTime())
    {
        if (HasItemUneqieup(current_shop_hero_choose, original_item_id))
        {
            Game.EmitSound("UI.Shop_Buy_unequip")
            GameEvents.SendCustomGameEventToServer_custom( "dota1x6_item_change", {item_id: original_item_id, current_hero:current_shop_hero_choose, remove : 1} );
            UpdateQuipHeroItem(id, false, slot_type, sets)
            if (BlockItem)
            {
                let ButtonsItemStyles = BlockItem.FindChildTraverse("ButtonsItemStyles")
                if (ButtonsItemStyles)
                {
                    for (var i = 0; i < ButtonsItemStyles.GetChildCount(); i++) 
                    {
                        ButtonsItemStyles.GetChild(i).SetHasClass("ButtonItemStyle_active", false)
                    }
                }
            }
        }
        else
        {
            Game.EmitSound("UI.Shop_Buy_equip")
            GameEvents.SendCustomGameEventToServer_custom( "dota1x6_item_change", {item_id: original_item_id, current_hero:current_shop_hero_choose, remove : 0} );
            UpdateQuipHeroItem(id, true, slot_type, sets)
            if (BlockItem)
            {
                let ButtonsItemStyles = BlockItem.FindChildTraverse("ButtonsItemStyles")
                if (ButtonsItemStyles)
                {
                    for (var i = 0; i < ButtonsItemStyles.GetChildCount(); i++) 
                    {
                        if (ButtonsItemStyles.GetChild(i).id == "item_style_"+original_item_id)
                        {
                            ButtonsItemStyles.GetChild(i).SetHasClass("ButtonItemStyle_active", true)
                        }
                        else
                        {
                            ButtonsItemStyles.GetChild(i).SetHasClass("ButtonItemStyle_active", false)
                        }
                    }
                }
            }
        }
    }
}

function UpdateQuipHeroItem(id, activate, slot_type, sets)
{
	var ItemsList = $.GetContextPanel().FindChildTraverse("ItemsList")
	if (ItemsList)
	{
        for (var d = 0; d < ItemsList.GetChildCount(); d++) 
        {
            let slot_panel = ItemsList.GetChild(d+1)
            if (slot_panel)
            {
                let next_panel = slot_panel.GetChild(0)
                if (next_panel.id == "")
                {
                    next_panel = next_panel.GetChild(1)
                }
                if (next_panel)
                {
                    for (var i = 0; i < next_panel.GetChildCount(); i++) 
                    {
                        let BlockItemActivateButton = next_panel.GetChild(i).FindChildTraverse("button_activate")
                        let BlockItemActivateButtonLabel = next_panel.GetChild(i).FindChildTraverse("BlockItemActivateButtonLabel")
                        if (next_panel.GetChild(i).id == "item_id_"+id)
                        {
                            if (activate)
                            {
                                BlockItemActivateButtonLabel.text = $.Localize("#shop_unequip")
                                BlockItemActivateButton.AddClass("BlockItemBuyButton_unequip")
                                BlockItemActivateButton.RemoveClass("BlockItemBuyButton_equip")
                
                            }
                            else
                            {
                                BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
                                BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
                                BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
                            }
                        } 
                        else 
                        {
                            if (BlockItemActivateButton && BlockItemActivateButtonLabel && next_panel.GetChild(i).slot_type == slot_type)
                            {
                                BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
                                BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
                                BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
                            }
                        }
                    }
                }
            }
        }
	}
}
//////////////////////////////////////////////////////////////////

function InitHeroesItemsInventory()
{
	let table_heroes = CustomNetTables.GetTableValue("custom_pick", "hero_list")
	let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroListItemsInventory")
	const hero_names_sorted = [...Object.keys(table_heroes)].sort()

	let heroes_strength = []
	let heroes_agility = []
	let heroes_intellect = []
	let heroes_all = []

    for (const hero_name of hero_names_sorted)
    {
        if (table_heroes[hero_name] == 0)
        {
            heroes_strength.push(hero_name)
        } else if (table_heroes[hero_name] == 1) {
            heroes_agility.push(hero_name)
        } else if (table_heroes[hero_name] == 2) {
            heroes_intellect.push(hero_name)
        } else if (table_heroes[hero_name] == 3) {
            heroes_all.push(hero_name)
        }
    }

	if (heroes_panel)
	{
		heroes_panel.RemoveAndDeleteChildren()

        if (Object.keys(heroes_strength).length > 0)
        {
            let attribute_info = $.CreatePanel("Panel", heroes_panel, "");
            attribute_info.AddClass("attribute_info")
            let hero_icon_str = $.CreatePanel("Panel", attribute_info, "");
            hero_icon_str.AddClass("hero_icon_str")
            let hero_label_str = $.CreatePanel("Label", attribute_info, "");
            hero_label_str.AddClass("hero_label_str")
            hero_label_str.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_str")
            const str_row = $.CreatePanel("Panel", heroes_panel, "StrengthHeroes");
            for (var i = 0; i < Object.keys(heroes_strength).length; i++) 
            {
                CreateHeroPanelItemsInventory(str_row, heroes_strength[i], 1)
            }
            if (str_row.GetChildCount() <= 0)
            {
                attribute_info.visible = false
            }
        }

        if (Object.keys(heroes_agility).length > 0)
        {
            let attribute_info_2 = $.CreatePanel("Panel", heroes_panel, "");
            attribute_info_2.AddClass("attribute_info")
            let hero_icon_agi = $.CreatePanel("Panel", attribute_info_2, "");
            hero_icon_agi.AddClass("hero_icon_agi")
            let hero_label_agi = $.CreatePanel("Label", attribute_info_2, "");
            hero_label_agi.AddClass("hero_label_agi")
            hero_label_agi.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_agi")
            const agi_row = $.CreatePanel("Panel", heroes_panel, "AgilityHeroes");
            for (var i = 0; i < Object.keys(heroes_agility).length; i++) 
            {
                CreateHeroPanelItemsInventory(agi_row, heroes_agility[i], 2)
            }
            if (agi_row.GetChildCount() <= 0)
            {
                attribute_info_2.visible = false
            }
        }

        if (Object.keys(heroes_intellect).length > 0)
        {
            let attribute_info_3 = $.CreatePanel("Panel", heroes_panel, "");
            attribute_info_3.AddClass("attribute_info")
            let hero_icon_int = $.CreatePanel("Panel", attribute_info_3, "");
            hero_icon_int.AddClass("hero_icon_int")
            let hero_label_int = $.CreatePanel("Label", attribute_info_3, "");
            hero_label_int.AddClass("hero_label_int")
            hero_label_int.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_int")
            const int_row = $.CreatePanel("Panel", heroes_panel, "IntellectHeroes");
            for (var i = 0; i < Object.keys(heroes_intellect).length; i++) 
            {
                CreateHeroPanelItemsInventory(int_row, heroes_intellect[i], 3)
            }
            if (int_row.GetChildCount() <= 0)
            {
                attribute_info_3.visible = false
            }
        }

        if (Object.keys(heroes_all).length > 0)
        {
            let attribute_info_4 = $.CreatePanel("Panel", heroes_panel, "");
            attribute_info_4.AddClass("attribute_info")
            let hero_icon_all = $.CreatePanel("Panel", attribute_info_4, "");
            hero_icon_all.AddClass("hero_icon_all")
            let hero_label_all = $.CreatePanel("Label", attribute_info_4, "");
            hero_label_all.AddClass("hero_label_all")
            hero_label_all.text = $.Localize("#stats_all")
            const all_row = $.CreatePanel("Panel", heroes_panel, "AllHeroes");
            for (var i = 0; i < Object.keys(heroes_all).length; i++) 
            {
                CreateHeroPanelItemsInventory(all_row, heroes_all[i])
            }
            if (all_row.GetChildCount() <= 0)
            {
                attribute_info_4.visible = false
            }
        }
	}
}

function CreateHeroPanelItemsInventory(panel, hero_name, stat) 
{
	var player_data_local = player_table_shop
    let items = CustomNetTables.GetTableValue("heroes_items_info", String(hero_name))
    if (items)
    {
        for (var i = 0; i < Object.keys(items).length; i++) 
        {
            if (HasItemForThisHero(items[Object.keys(items)[i]]))
            {
                var BlockHero = $.CreatePanel("Panel", panel, "");
                BlockHero.AddClass("BlockHeroItems");
                var HeroImage = $.CreatePanel(`DOTAHeroImage`, BlockHero, "", {scaling: "stretch-to-cover-preserve-aspect", heroname : String(hero_name), tabindex : "auto", class: "HeroImage", heroimagestyle : "portrait"});
                BlockHero.SetPanelEvent("onactivate", function() 
                {	
                    current_shop_hero_choose = hero_name
                    OpenItemsForHeroInventory()
                });	
                break
            }
        }
    }
}

function OpenItemsForHeroInventory()
{
	Game.EmitSound("UI.Click")
	let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroListItemsInventory")
	if (heroes_panel)
	{
		heroes_panel.style.visibility = "collapse"
	}
	let ItemsList = $.GetContextPanel().FindChildTraverse("ItemsListInventory")
	if (ItemsList)
	{
		ItemsList.style.visibility = "visible"
	}
	InitShopItemsForHeroInventory(ItemsList)
}

function InitShopItemsForHeroInventory(panel)
{
	if (current_shop_hero_choose)
	{
		panel.RemoveAndDeleteChildren()
		let items = CustomNetTables.GetTableValue("heroes_items_info", String(current_shop_hero_choose))
		if (items)
		{
			for (var i = 0; i < Object.keys(items).length; i++) 
			{
				CreateItemShopItemHeroInventory(panel, items[Object.keys(items)[i]]) 
			}
		}
	}
}
	

function CreateItemShopItemHeroInventory(panel, info) 
{
	if (info["hide"] == 1)
	{
		return
	}

	let main_parent = panel

	if (!HasItemInventory(info["item_id"]))
	{
		return
	}

    if (panel.FindChildTraverse("panel_rare") == null)
    {
        let slot_panel = $.CreatePanel("Panel", panel, "");
        slot_panel.AddClass("slot_panel");
        let slot_name = $.CreatePanel("Label", slot_panel, "");
        slot_name.AddClass("slot_name");
        slot_name.text = $.Localize("#rare")
        rare_fast = $.CreatePanel("Panel", slot_panel, "panel_rare");
        rare_fast.AddClass("SlotType");
    }

	if (info["sets"] != null)
	{
		main_parent = panel.FindChildTraverse("panel_"+info["sets"])
		if (main_parent == null)
		{
            if (info["sets"] == "rare")
            {
                let slot_panel = $.CreatePanel("Panel", panel, "");
                slot_panel.AddClass("slot_panel");
                let slot_name = $.CreatePanel("Label", slot_panel, "");
                slot_name.AddClass("slot_name");
                slot_name.text = $.Localize("#"+info["sets"])
                main_parent = $.CreatePanel("Panel", slot_panel, "panel_"+info["sets"]);
                main_parent.AddClass("SlotType");
            }
            else
            {
                let set_this_info = GetAllItemsInSet(info["sets"], current_shop_hero_choose)

                let slot_panel = $.CreatePanel("Panel", panel, "");
                slot_panel.AddClass("slot_panel");

                let slot_name = $.CreatePanel("Label", slot_panel, "");
                slot_name.AddClass("slot_name");
                slot_name.text = $.Localize("#"+info["sets"])

                let slot_panel_sets = $.CreatePanel("Panel", slot_panel, "");
                slot_panel_sets.AddClass("slot_panel_sets");

                let sets_texture = $.CreatePanel("Panel", slot_panel_sets, "");
                sets_texture.AddClass("sets_texture");

                let sets_texture_background = $.CreatePanel("Panel", sets_texture, "");
                sets_texture_background.AddClass("sets_texture_bg");
                sets_texture_background.style.backgroundImage = 'url("s2r://materials/portraits_card/portrait_backgrounds/' + current_shop_hero_choose.replace("npc_dota_hero_", "") + '.psd")';
                sets_texture_background.style.backgroundSize = "cover"

                let hero_image_sets = $.CreatePanel("Panel", sets_texture, "");
                hero_image_sets.AddClass("hero_image_sets");
                hero_image_sets.style.backgroundImage = 'url("s2r://panorama/images/' + SETS_TEXTURE_FULL_ICON[info["sets"]] + '.png")';
                hero_image_sets.style.backgroundSize = "100%"

                main_parent = $.CreatePanel("Panel", slot_panel_sets, "panel_"+info["sets"]);
                main_parent.AddClass("SlotType");
            }
		}
	}

    let sets = info["sets"]

	let original_item_id = info["item_id"]

	var BlockItem = $.CreatePanel("Panel", main_parent, "item_id_" + info["item_id"]);
	BlockItem.AddClass("BlockItem");
    BlockItem.slot_type = info["SlotType"]

	var BlockItemImage = $.CreatePanel("Panel", BlockItem, "BlockItemImage");
	BlockItemImage.AddClass("BlockItemImage");

	var BlockItemLabel = $.CreatePanel("Label", BlockItem, "");
	BlockItemLabel.AddClass("BlockItemLabel");

	var BlockItemBuyButton = $.CreatePanel("Panel", BlockItem, "button");
	BlockItemBuyButton.AddClass("BlockItemBuyButton");

	var BlockItemBuyButtonCenter = $.CreatePanel("Panel", BlockItemBuyButton, "");
	BlockItemBuyButtonCenter.AddClass("BlockItemBuyButtonCenter");

	var BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButtonCenter, "");
	BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel");
	BlockItemBuyButtonLabel.text = $.Localize("#shop_buy")
	BlockItemBuyButtonLabel.style.marginRight = "8px"

	var shardcost_icon = $.CreatePanel("Panel", BlockItemBuyButtonCenter, "");
	shardcost_icon.AddClass("shardcost_icon");

	var BlockItemBuyButtonLabel = $.CreatePanel("Label", BlockItemBuyButtonCenter, "");
	BlockItemBuyButtonLabel.AddClass("BlockItemBuyButtonLabel");
	BlockItemBuyButtonLabel.text = info["price"]

	var player_data_local = player_table_shop

	if (info["item_id"] == "2059" && HasItemUneqieup(current_shop_hero_choose, "2068"))
	{
		original_item_id = "2068"
	}
	else if (info["item_id"] == "4239" && HasItemUneqieup(current_shop_hero_choose, "4560"))
	{
		original_item_id = "4560"
	}
	else if (info["item_id"] == "4239" && HasItemUneqieup(current_shop_hero_choose, "4561"))
	{
		original_item_id = "4561"
	}

	if (info)
	{
		if (HasItemInventory(info["item_id"]))
		{
			BlockItemBuyButton.style.visibility = "collapse"
			BlockItem.AddClass("BlockItem_purchased")
			
			var BlockItemActivateButton = $.CreatePanel("Panel", BlockItem, "button_activate");
			BlockItemActivateButton.AddClass("BlockItemBuyButton");

			var BlockItemActivateButtonLabel = $.CreatePanel("Label", BlockItemActivateButton, "BlockItemActivateButtonLabel");
			BlockItemActivateButtonLabel.AddClass("BlockItemBuyButtonLabel");

			if (HasItemUneqieup(current_shop_hero_choose, original_item_id))
			{
				BlockItemActivateButtonLabel.text = $.Localize("#shop_unequip")
				BlockItemActivateButton.AddClass("BlockItemBuyButton_unequip")
				BlockItemActivateButton.RemoveClass("BlockItemBuyButton_equip")
				BlockItemActivateButton.SetPanelEvent("onactivate", function() 
				{ 
					UneuipItemHero(info["item_id"], info["SlotType"], original_item_id, BlockItem, sets)
				});
				BlockItem.SetPanelEvent("onactivate", function() 
				{ 
					UneuipItemHero(info["item_id"], info["SlotType"], original_item_id, BlockItem, sets)
				});
			}
			else
			{
				BlockItemActivateButtonLabel.text = $.Localize("#shop_equip")
				BlockItemActivateButton.RemoveClass("BlockItemBuyButton_unequip")
				BlockItemActivateButton.AddClass("BlockItemBuyButton_equip")
				BlockItemActivateButton.SetPanelEvent("onactivate", function() 
				{ 
					UneuipItemHero(info["item_id"], info["SlotType"], original_item_id, BlockItem, sets)
				});
				BlockItem.SetPanelEvent("onactivate", function() 
				{ 
					UneuipItemHero(info["item_id"], info["SlotType"], original_item_id, BlockItem, sets)
				});
			}
			if (info["OtherItemsBundle"])
			{
				var ButtonsItemStyles = $.CreatePanel("Panel", BlockItemImage, "ButtonsItemStyles");
				ButtonsItemStyles.AddClass("ButtonsItemStyles");
				for (var i = 1; i <= Object.keys(info["OtherItemsBundle"]).length; i++) 
				{
					var ButtonItemStyle = $.CreatePanel("Panel", ButtonsItemStyles, "item_style_" + info["OtherItemsBundle"][i][1]);
					ButtonItemStyle.AddClass("ButtonItemStyle");
					ButtonItemStyle.style.backgroundColor = info["OtherItemsBundle"][i][2]
					var ButtonItemStyleActiveIcon = $.CreatePanel("Panel", ButtonItemStyle, "");
					ButtonItemStyleActiveIcon.AddClass("ButtonItemStyleActiveIcon");
					SetButtonStyle(ButtonItemStyle, info["OtherItemsBundle"][i][1], info["SlotType"], BlockItem, info["item_id"], sets)
					if (HasItemUneqieup(current_shop_hero_choose, info["OtherItemsBundle"][i][1]))
					{
						ButtonItemStyle.SetHasClass("ButtonItemStyle_active", true)
					}
				}
			}
			BlockItemLabel.text = $.Localize(info["name"])
			BlockItemImage.style.backgroundImage = 'url("s2r://panorama/images/' + info["icon"] + '.png")';
			BlockItemImage.style.backgroundSize = "100%"
		}
	}
}
function HasItemForThisHero(info) 
{
	if (info["hide"] == 1)
	{
		return false
	}

	var player_data_local = player_table_shop

	if (info)
	{
		if (HasItemInventory(info["item_id"]))
		{
            return true
		}
	}
}
function GetAllItemsInSet(set_name, hero_name)
{
    let set_info = 
    [
        [],
        0,
        0,
        0,
        0,
    ]
    let items = CustomNetTables.GetTableValue("heroes_items_info", String(hero_name))
    if (items)
    {
        for (var i = 0; i < Object.keys(items).length; i++) 
        {
            if (items[Object.keys(items)[i]] && items[Object.keys(items)[i]]["sets"] == set_name && items[Object.keys(items)[i]]["hide"] == 0)
            {
                let item_id = items[Object.keys(items)[i]]["item_id"]
                set_info[0].push(item_id)

                if (items[Object.keys(items)[i]]["sale_price"] && items[Object.keys(items)[i]]["sale_price"] > 0)
                {
                    set_info[4] = set_info[4] + items[Object.keys(items)[i]]["sale_price"]

                    if (items[Object.keys(items)[i]]["sale"] && items[Object.keys(items)[i]]["sale"] > 0)
                    {
                        set_info[3] = set_info[3] + items[Object.keys(items)[i]]["sale"]
                    }

                }
                
                set_info[2] = set_info[2] + items[Object.keys(items)[i]]["price"]
                
            }
        }
    }

    return set_info
}


 
function UpdateOnlyCouriers()
{



    let CategoryPets = $.GetContextPanel().FindChildTraverse("CategoryPets")
    if (CategoryPets)
    {
        CategoryPets.RemoveAndDeleteChildren()

        let pets_info_table = CustomNetTables.GetTableValue("shop_items", "pets")
        let new_table = []
        if (pets_info_table)
        {
            for (var item = 1; item <= Object.keys(pets_info_table).length; item++)
            {
                new_table[item-1] = []
                new_table[item-1].push(pets_info_table[item][1], pets_info_table[item][2], pets_info_table[item][3], pets_info_table[item][4], pets_info_table[item][5])
            }

            new_table.sort(function (a, b) {
                return Number(a[3])-Number(b[3])
            });

            for (var i = 0; i < new_table.length; i++)
            {

                if (HasItemInventory(new_table[i][0]))
                {
                    CreateItemInShop(CategoryPets, new_table[i])
                }

            }

            for (var i = 0; i < new_table.length; i++)
            {

                if (!HasItemInventory(new_table[i][0]))
                {
                    CreateItemInShop(CategoryPets, new_table[i])
                }

            }
        }    
    }  
}

function ChangeScenePreviewItem(buy_panel, ButtonItemStyleBuyPanel, style, item_scene_panel_preview)
{
    ButtonItemStyleBuyPanel.SetPanelEvent("onactivate", function() 
    {

        Game.EmitSound("UI.Click")

        let find_info = style["styles"]
        let full_scene_panel_preview_model = buy_panel.FindChildTraverse("full_scene_panel_preview_model")
        if (full_scene_panel_preview_model)
        {
            full_scene_panel_preview_model.DeleteAsync(0)
        }
        $.CreatePanel("DOTAUIEconSetPreview", item_scene_panel_preview, "full_scene_panel_preview_model", { itemdef:find_info[0], itemstyle:find_info[1], class:"full_scene_panel_preview_model", style: "width:100%;height:100%;", particleonly:"false", renderdeferred:"false", antialias:"false", renderwaterreflections:"false", allowrotation:"true" });
        let ButtonStylesBuyPanel = buy_panel.FindChildTraverse("ButtonStylesBuyPanel")
        if (ButtonStylesBuyPanel)
        {
            for (var i = 0; i < ButtonStylesBuyPanel.GetChildCount(); i++) 
            {  
                ButtonStylesBuyPanel.GetChild(i).SetHasClass("ButtonItemStyle_active", false)
                ButtonStylesBuyPanel.GetChild(i).SetHasClass("ButtonItemStyleBuyPanel_active", false)
            }
        }
        ButtonItemStyleBuyPanel.SetHasClass("ButtonItemStyle_active", true)
        ButtonItemStyleBuyPanel.SetHasClass("ButtonItemStyleBuyPanel_active", true)
    })
}

function HeroIsAlive()
{
    let player_table = CustomNetTables.GetTableValue("networth_players", String(Players.GetLocalPlayer()));

    if (player_table)
    {
        if (player_table.place !== -1)
        {
            return true
        }
    }

    if (Entities.IsAlive( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) ))
    {
        return true
    }

    GameEvents.SendEventClientSide("dota_hud_error_message", 
    {
        "splitscreenplayer": 0,
        "reason": 80,
        "message": $.Localize("#shop_error_death")
    })
    return false
}

function IsLockedTime()
{
    let player_table = CustomNetTables.GetTableValue("networth_players", String(Players.GetLocalPlayer()));

    if (player_table)
    {
        if ((player_table.validGame == 0) || (player_table.place !== -1))
        {
            return true
        }
    }

    if (Game.GetDOTATime( false, false) >= 120 && !Game.IsInToolsMode())
    {
        GameEvents.SendEventClientSide("dota_hud_error_message", 
        {
            "splitscreenplayer": 0,
            "reason": 80,
            "message": $.Localize("#shop_error_time")
        })

        return false
    }
    return true
}