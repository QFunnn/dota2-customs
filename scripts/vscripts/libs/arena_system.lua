--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if arena_system == nil then
    _G.arena_system = class({})
    _G.WISP_DURATION = 15
    _G.CURRENT_ARENA = 1
    _G.ARENA_SPAWN_POINTS= { {"firstarena"},  {"secondarena"}, {"thirdarena"}, {"fourtharena"}, {"fiftharena"}, {"sixtharena"} }
    _G.CAMPS_ICONS={}
    _G.DUEL_TIMER=nil
    _G.PVE_END_GAME=nil
    _G.ARENA_POSITION_TIMER=nil
    _G.DUEL_ACTIVE=false
    _G.DUEL_STARTED=false
    _G.FINAL_DUEL_POINTS={}
    _G.STARTGAME_DURATION=35
    _G.ARENA_DURATION=360
    _G.RELAX_DURATION=20
    _G.DUEL_DURATION=60
    _G.LASTDUEL_DURATION=75
    _G.STUNARENA_DURATION=3
    _G.INTERVAL_CREEPSSPAWN=60
    _G.DUEL_PREDICT_PLAYERS={}
    _G.CURRENT_MINIMAP = 1
    arena_system.HUNT_PLAYERS_LIST = {}
    _G.MINIMAP_TABLES = { {7890, -1824}, {7890, -11510}, {-1790, -11510}, {-11540, -11510}, {-11540, -1824}, {-11540, 7900}, {-1790, 7900}, {-1790, -1824}, {7890, 7900} }
    TEST_LAST_DUEL_ONLY = WODAGameMode.EnableOnlyLastDuel and IsInToolsMode()
    BONUS_NETWORTGS_TABLE = 
    {
        [1] = { 0 },
        [2] = { -10, 0 },
        [3] = { -10, 0, 10 },
        [4] = { -25, -10, 0, 10 },
        [5] = { -25, -10, 0, 10, 25 },
        [6] = { -50, -25, -10, 0, 10, 25 },
        [7] = { -50, -25, -10, 0, 10, 25, 50 },
        [8] = { -50, -25, -10, 0, 0, 10, 25, 50 },
    }

    RUNE_SPAWNPOINTS={
        [1]={
            "spawn_rune_arena1_rune1",
            "spawn_rune_arena1_rune2",
            "spawn_rune_arena1_rune3",
            "spawn_rune_arena1_rune4"
        },
        [2]={
            "spawn_rune_arena2_rune1",
            "spawn_rune_arena2_rune2",
            "spawn_rune_arena2_rune3",
            "spawn_rune_arena2_rune4",
            "spawn_rune_arena2_rune5",
            "spawn_rune_arena2_rune6",
            "spawn_rune_arena2_rune7",
            "spawn_rune_arena2_rune8"
        },
        [3]={
            "spawn_rune_arena3_rune1",
            "spawn_rune_arena3_rune2",
            "spawn_rune_arena3_rune3",
            "spawn_rune_arena3_rune4"
        },
        [4]={
            "spawn_rune_arena4_rune1",
            "spawn_rune_arena4_rune2",
            "spawn_rune_arena4_rune3",
            "spawn_rune_arena4_rune4",
        },
        [5]={
            "spawn_rune_arena5_rune1",
            "spawn_rune_arena5_rune2",
            "spawn_rune_arena5_rune3",
            "spawn_rune_arena5_rune4"
        },
        [6]={
            "spawn_rune_arena6_rune1",
            "spawn_rune_arena6_rune2",
            "spawn_rune_arena6_rune3",
            "spawn_rune_arena6_rune4"
        }
    }

    --КЕМПЫ И ТИРЫ КРИПОВ НА НИХ--
    NEUTRAL_CREEPS={
        [1]={
            ["neutral_camp_arena1_camp1"] = "tier2",
            ["neutral_camp_arena1_camp2"] = "tier1",
            ["neutral_camp_arena1_camp3"] = "tier1",
            ["neutral_camp_arena1_camp4"] = "tier2",
            ["neutral_camp_arena1_camp5"] = "tier1",
            ["neutral_camp_arena1_camp6"] = "tier2",
            ["neutral_camp_arena1_camp7"] = "tier1",
            ["neutral_camp_arena1_camp8"] = "tier2",
            ["neutral_camp_arena1_camp9"] = "tier1",
            ["neutral_camp_arena1_camp10"] = "tier1",
            ["neutral_camp_arena1_camp11"] = "tier1",
            ["neutral_camp_arena1_camp12"] = "tier1",
            ["neutral_camp_arena1_camp13"] = "tier1",
            ["neutral_camp_arena1_camp14"] = "tier1",
            ["neutral_camp_arena1_camp15"] = "tier1",
            ["neutral_camp_arena1_camp16"] = "tier1",
            ["neutral_camp_arena1_camp17"] = "tier1",
            ["neutral_camp_arena1_camp18"] = "tier1",
            ["neutral_camp_arena1_camp19"] = "tier1",
            ["neutral_camp_arena1_camp20"] = "tier1",
        },
        [2]={
            ["neutral_camp_arena2_camp1"]= "tier3",
            ["neutral_camp_arena2_camp2"]= "tier2",
            ["neutral_camp_arena2_camp3"]= "tier2",
            ["neutral_camp_arena2_camp4"]= "tier3",
            ["neutral_camp_arena2_camp5"]= "tier2",
            ["neutral_camp_arena2_camp6"]= "tier3",
            ["neutral_camp_arena2_camp7"]= "tier2",
            ["neutral_camp_arena2_camp8"]= "tier3",
            ["neutral_camp_arena2_camp9"]= "tier2",
            ["neutral_camp_arena2_camp10"]= "tier2",
            ["neutral_camp_arena2_camp11"]= "tier2",
            ["neutral_camp_arena2_camp12"]= "tier2",
            ["neutral_camp_arena2_camp13"]= "tier2",
            ["neutral_camp_arena2_camp14"]= "tier2",
            ["neutral_camp_arena2_camp15"]= "tier2",
            ["neutral_camp_arena2_camp16"]= "tier2",
            ["neutral_camp_arena2_camp17"]= "tier2",
            ["neutral_camp_arena2_camp18"]= "tier2",
            ["neutral_camp_arena2_camp19"]= "tier2",
            ["neutral_camp_arena2_camp20"]= "tier2",
        },
        [3]={
            ["neutral_camp_arena3_camp1"]= "tier3",
            ["neutral_camp_arena3_camp2"]= "tier3",
            ["neutral_camp_arena3_camp3"]= "tier4",
            ["neutral_camp_arena3_camp4"]= "tier3",
            ["neutral_camp_arena3_camp5"]= "tier3",
            ["neutral_camp_arena3_camp6"]= "tier4",
            ["neutral_camp_arena3_camp7"]= "tier3",
            ["neutral_camp_arena3_camp8"]= "tier3",
            ["neutral_camp_arena3_camp9"]= "tier3",
            ["neutral_camp_arena3_camp10"]= "tier3",
            ["neutral_camp_arena3_camp11"]= "tier3",
            ["neutral_camp_arena3_camp12"]= "tier3",
            ["neutral_camp_arena3_camp13"]= "tier3",
            ["neutral_camp_arena3_camp14"]= "tier3",
            ["neutral_camp_arena3_camp15"]= "tier4",
            ["neutral_camp_arena3_camp16"]= "tier4",
            ["neutral_camp_arena3_camp17"]= "tier3",
            ["neutral_camp_arena3_camp18"]= "tier3",
            ["neutral_camp_arena3_camp19"]= "tier3",
            ["neutral_camp_arena3_camp20"]= "tier3",
        },
        [4]={
            ["neutral_camp_arena4_camp1"]= "tier4",
            ["neutral_camp_arena4_camp2"]= "tier5",
            ["neutral_camp_arena4_camp3"]= "tier4",
            ["neutral_camp_arena4_camp4"]= "tier4",
            ["neutral_camp_arena4_camp5"]= "tier4",
            ["neutral_camp_arena4_camp6"]= "tier4",
            ["neutral_camp_arena4_camp7"]= "tier5",
            ["neutral_camp_arena4_camp8"]= "tier4",
            ["neutral_camp_arena4_camp9"]= "tier4",
            ["neutral_camp_arena4_camp10"]= "tier4",
            ["neutral_camp_arena4_camp11"]= "tier5",
            ["neutral_camp_arena4_camp12"]= "tier4",
            ["neutral_camp_arena4_camp13"]= "tier4",
            ["neutral_camp_arena4_camp14"]= "tier4",
            ["neutral_camp_arena4_camp15"]= "tier5",
            ["neutral_camp_arena4_camp16"]= "tier4",
            ["neutral_camp_arena4_camp17"]= "tier4",
            ["neutral_camp_arena4_camp18"]= "tier4",
            ["neutral_camp_arena4_camp19"]= "tier4",
            ["neutral_camp_arena4_camp20"]= "tier4",
        },
        [5]={
            ["neutral_camp_arena5_camp1"]= "tier5",
            ["neutral_camp_arena5_camp2"]= "tier6",
            ["neutral_camp_arena5_camp3"]= "tier5",
            ["neutral_camp_arena5_camp4"]= "tier6",
            ["neutral_camp_arena5_camp5"]= "tier5",
            ["neutral_camp_arena5_camp6"]= "tier5",
            ["neutral_camp_arena5_camp7"]= "tier5",
            ["neutral_camp_arena5_camp8"]= "tier5",
            ["neutral_camp_arena5_camp9"]= "tier5",
            ["neutral_camp_arena5_camp10"]= "tier5",
            ["neutral_camp_arena5_camp11"]= "tier5",
            ["neutral_camp_arena5_camp12"]= "tier5",
            ["neutral_camp_arena5_camp13"]= "tier5",
            ["neutral_camp_arena5_camp14"]= "tier5",
            ["neutral_camp_arena5_camp15"]= "tier5",
            ["neutral_camp_arena5_camp16"]= "tier5",
            ["neutral_camp_arena5_camp17"]= "tier6",
            ["neutral_camp_arena5_camp18"]= "tier6",
            ["neutral_camp_arena5_camp19"]= "tier7",
            ["neutral_camp_arena5_camp20"]= "tier7",
        },
        [6]={
            ["neutral_camp_arena6_camp1"]= "tier6",
            ["neutral_camp_arena6_camp2"]= "tier6",
            ["neutral_camp_arena6_camp3"]= "tier6",
            ["neutral_camp_arena6_camp4"]= "tier6",
            ["neutral_camp_arena6_camp5"]= "tier7",
            ["neutral_camp_arena6_camp6"]= "tier7",
            ["neutral_camp_arena6_camp7"]= "tier7",
            ["neutral_camp_arena6_camp8"]= "tier7",
            ["neutral_camp_arena6_camp9"]= "tier6",
            ["neutral_camp_arena6_camp10"]= "tier6",
            ["neutral_camp_arena6_camp11"]= "tier6",
            ["neutral_camp_arena6_camp12"]= "tier6"
        }
    }
    --КАКИЕ КРИПЫ В КАКОМ ТИРЕ--
    NEUTRAL_CREEPS_TYPES={
        ["tier1"] = {
            {"npc_woda_creep4","npc_woda_creep5","npc_woda_creep6","npc_woda_creep6","npc_woda_creep6"},
            {"npc_woda_creep1","npc_woda_creep1","npc_woda_creep3"},
            {"npc_woda_creep29","npc_woda_creep29","npc_woda_creep29"},
            {"npc_woda_creep12","npc_woda_creep12","npc_woda_creep13"},
            {"npc_woda_creep16","npc_woda_creep17","npc_woda_creep17"},
            {"npc_woda_creep11","npc_woda_creep11","npc_woda_creep11"},
            


            {"npc_woda_creep9","npc_woda_creep10"},
            {"npc_woda_creep24","npc_woda_creep24","npc_woda_creep24"},
            {"npc_woda_creep81","npc_woda_creep81","npc_woda_creep81","npc_woda_creep81"},
            {"npc_woda_creep7","npc_woda_creep8"},
            
            
        },
        ["tier2"] = {
            {"npc_woda_creep18","npc_woda_creep19"},
            {"npc_woda_creep14","npc_woda_creep15","npc_woda_creep15"},
            {"npc_woda_creep34","npc_woda_creep34","npc_woda_creep21","npc_woda_creep21"},
            {"npc_woda_creep45","npc_woda_creep46","npc_woda_creep46"},
            {"npc_woda_creep31","npc_woda_creep31"},
            {"npc_woda_creep88","npc_woda_creep87","npc_woda_creep87"},
            

            {"npc_woda_creep83"},
            {"npc_woda_creep22","npc_woda_creep23"},
            {"npc_woda_creep82","npc_woda_creep33","npc_woda_creep33"},
            {"npc_woda_creep43","npc_woda_creep44","npc_woda_creep44"},
            
            
            
        },
        ["tier3"] = {
            {"npc_woda_creep20","npc_woda_creep20"},
            {"npc_woda_creep27","npc_woda_creep28"},
            {"npc_woda_creep35","npc_woda_creep36","npc_woda_creep36"},
            {"npc_woda_creep50","npc_woda_creep2","npc_woda_creep2"},
            {"npc_woda_creep32","npc_woda_creep32"},
            {"npc_woda_creep90","npc_woda_creep89","npc_woda_creep89"},


            {"npc_woda_creep84"},


            {"npc_woda_creep37","npc_woda_creep38","npc_woda_creep38"},
            {"npc_woda_creep30","npc_woda_creep30"},
            {"npc_woda_creep104","npc_woda_creep105","npc_woda_creep106"},
            

        },
        ["tier4"] = {
            {"npc_woda_creep96","npc_woda_creep97","npc_woda_creep97"},
            {"npc_woda_creep51","npc_woda_creep51","npc_woda_creep66","npc_woda_creep66"},
            {"npc_woda_creep56","npc_woda_creep57","npc_woda_creep58","npc_woda_creep98"},
            {"npc_woda_creep49","npc_woda_creep49"},
            {"npc_woda_creep47","npc_woda_creep48","npc_woda_creep48"},
            {"npc_woda_creep99","npc_woda_creep99","npc_woda_creep99"},


            {"npc_woda_creep85"},


            {"npc_woda_creep94","npc_woda_creep94","npc_woda_creep95"},
            {"npc_woda_creep42","npc_woda_creep42","npc_woda_creep42"},
            {"npc_woda_creep110","npc_woda_creep111","npc_woda_creep112"},

        },
        ["tier5"] = {
            {"npc_woda_creep67","npc_woda_creep68","npc_woda_creep68"},
            {"npc_woda_creep39","npc_woda_creep39","npc_woda_creep39"},
            {"npc_woda_creep54","npc_woda_creep55","npc_woda_creep55"},
            {"npc_woda_creep71","npc_woda_creep70","npc_woda_creep70"},
            {"npc_woda_creep78","npc_woda_creep79","npc_woda_creep79"},
            {"npc_woda_creep92","npc_woda_creep91","npc_woda_creep91"},


            {"npc_woda_creep93"},
            {"npc_woda_creep107","npc_woda_creep108","npc_woda_creep109"},
  
        },
        ["tier6"] = {
            {"npc_woda_creep100","npc_woda_creep100"},
            {"npc_woda_creep59","npc_woda_creep25","npc_woda_creep26"},
            {"npc_woda_creep60","npc_woda_creep60","npc_woda_creep60","npc_woda_creep60"},
            {"npc_woda_creep69","npc_woda_creep64","npc_woda_creep64"},
            {"npc_woda_creep76","npc_woda_creep77","npc_woda_creep77"},
            {"npc_woda_creep101","npc_woda_creep102","npc_woda_creep102"},


            {"npc_woda_creep61"},
            {"npc_woda_creep52","npc_woda_creep53","npc_woda_creep53"},
            
        },
        ["tier7"] = {
            {"npc_woda_creep86","npc_woda_creep86"},
            {"npc_woda_creep72","npc_woda_creep73","npc_woda_creep73"},
            {"npc_woda_creep74","npc_woda_creep74"},
            {"npc_woda_creep65","npc_woda_creep62","npc_woda_creep62","npc_woda_creep62"},
            {"npc_woda_creep75","npc_woda_creep103","npc_woda_creep63"},
            {"npc_woda_creep40","npc_woda_creep41","npc_woda_creep41"},

            
            {"npc_woda_creep80"},
            {"npc_woda_creep113","npc_woda_creep114"},

        }
    }
    ARENA_CREEPSTABLE={}
    ARENA_CREEPSSPAWNPOINT={}
    ARENA_CREEPSSPAWNPOINTFORWARD={}
    ARENA_CREEPSTIMER=nil

    --ТИР 1 КРИПЫ КЕМП - 140 ЗОЛОТА И 240 ОПЫТА--  ЗДОРОВЬЕ 1100 - УРОН 60
    --ТИР 2 КРИПЫ КЕМП - 175 ЗОЛОТА И 300 ОПЫТА--  ЗДОРОВЬЕ 1700 - УРОН 100
    --ТИР 3 КРИПЫ КЕМП - 220 ЗОЛОТА И 375 ОПЫТА--  ЗДОРОВЬЕ 2500 - УРОН 160
    --ТИР 4 КРИПЫ КЕМП - 275 ЗОЛОТА И 470 ОПЫТА--  ЗДОРОВЬЕ 3800 - УРОН 250
    --ТИР 5 КРИПЫ КЕМП - 345 ЗОЛОТА И 590 ОПЫТА--  ЗДОРОВЬЕ 5600 - УРОН 400
    --ТИР 6 КРИПЫ КЕМП - 435 ЗОЛОТА И 740 ОПЫТА--  ЗДОРОВЬЕ 8400 - УРОН 630
    --ТИР 7 КРИПЫ КЕМП - 540 ЗОЛОТА И 925 ОПЫТА--  ЗДОРОВЬЕ 13000 - УРОН 1000


    NEUTRAL_CREEPSREWARD=
    {
        ["npc_woda_pig"] = {
            ["gold"] = 350,
            ["exp"] = 0
        },
        ["npc_woda_frog"] = {
            ["gold"] = 0,
            ["exp"] = 560
        },
        ["npc_woda_pig_pve"] = {
            ["gold"] = 350,
            ["exp"] = 0
        },
        ["npc_woda_frog_pve"] = {
            ["gold"] = 0,
            ["exp"] = 560
        },
        ["npc_woda_creep1"] = {
            ["gold"] = 40,
            ["exp"] = 70
        },
        ["npc_woda_creep2"] = {
            ["gold"] = 60,
            ["exp"] = 100
        },
        ["npc_woda_creep3"] = {
            ["gold"] = 60,
            ["exp"] = 100
        },
        ["npc_woda_creep4"] = {
            ["gold"] = 60,
            ["exp"] = 90
        },
        ["npc_woda_creep5"] = {
            ["gold"] = 35,
            ["exp"] = 60
        },
        ["npc_woda_creep6"] = {
            ["gold"] = 15,
            ["exp"] = 30
        },
        ["npc_woda_creep7"] = {
            ["gold"] = 70,
            ["exp"] = 120
        },
        ["npc_woda_creep8"] = {
            ["gold"] = 70,
            ["exp"] = 120
        },
        ["npc_woda_creep9"] = {
            ["gold"] = 70,
            ["exp"] = 120
        },
        ["npc_woda_creep10"] = {
            ["gold"] = 70,
            ["exp"] = 120
        },
        ["npc_woda_creep11"] = {
            ["gold"] = 47,
            ["exp"] = 80
        },
        ["npc_woda_creep12"] = {
            ["gold"] = 40,
            ["exp"] = 70
        },
        ["npc_woda_creep13"] = {
            ["gold"] = 60,
            ["exp"] = 100
        },
        ["npc_woda_creep14"] = {
            ["gold"] = 75,
            ["exp"] = 130
        },
        ["npc_woda_creep15"] = {
            ["gold"] = 50,
            ["exp"] = 85
        },
        ["npc_woda_creep16"] = {
            ["gold"] = 40,
            ["exp"] = 70
        },
        ["npc_woda_creep17"] = {
            ["gold"] = 50,
            ["exp"] = 85
        },
        ["npc_woda_creep18"] = {
            ["gold"] = 100,
            ["exp"] = 180
        },
        ["npc_woda_creep19"] = {
            ["gold"] = 75,
            ["exp"] = 120
        },
        ["npc_woda_creep20"] = {
            ["gold"] = 110,
            ["exp"] = 188
        },
        ["npc_woda_creep21"] = {
            ["gold"] = 50,
            ["exp"] = 90
        },
        ["npc_woda_creep22"] = {
            ["gold"] = 88,
            ["exp"] = 150
        },
        ["npc_woda_creep23"] = {
            ["gold"] = 88,
            ["exp"] = 150
        },
        ["npc_woda_creep24"] = {
            ["gold"] = 47,
            ["exp"] = 80
        },
        ["npc_woda_creep25"] = {
            ["gold"] = 100,
            ["exp"] = 170
        },
        ["npc_woda_creep26"] = {
            ["gold"] = 100,
            ["exp"] = 170
        },
        ["npc_woda_creep27"] = {
            ["gold"] = 130,
            ["exp"] = 225
        },
        ["npc_woda_creep28"] = {
            ["gold"] = 90,
            ["exp"] = 150
        },
        ["npc_woda_creep29"] = {
            ["gold"] = 47,
            ["exp"] = 80
        },
        ["npc_woda_creep30"] = {
            ["gold"] = 110,
            ["exp"] = 188
        },
        ["npc_woda_creep31"] = {
            ["gold"] = 88,
            ["exp"] = 150
        },
        ["npc_woda_creep32"] = {
            ["gold"] = 110,
            ["exp"] = 188
        },
        ["npc_woda_creep33"] = {
            ["gold"] = 50,
            ["exp"] = 90
        },
        ["npc_woda_creep34"] = {
            ["gold"] = 38,
            ["exp"] = 60
        },
        ["npc_woda_creep35"] = {
            ["gold"] = 100,
            ["exp"] = 175
        },
        ["npc_woda_creep36"] = {
            ["gold"] = 60,
            ["exp"] = 100
        },
        ["npc_woda_creep37"] = {
            ["gold"] = 100,
            ["exp"] = 175
        },
        ["npc_woda_creep38"] = {
            ["gold"] = 60,
            ["exp"] = 100
        },
        ["npc_woda_creep39"] = {
            ["gold"] = 115,
            ["exp"] = 197
        },
        ["npc_woda_creep40"] = {
            ["gold"] = 240,
            ["exp"] = 425
        },
        ["npc_woda_creep41"] = {
            ["gold"] = 150,
            ["exp"] = 250
        },
        ["npc_woda_creep42"] = {
            ["gold"] = 92,
            ["exp"] = 157
        },
        ["npc_woda_creep43"] = {
            ["gold"] = 75,
            ["exp"] = 120
        },
        ["npc_woda_creep44"] = {
            ["gold"] = 50,
            ["exp"] = 90
        },
        ["npc_woda_creep45"] = {
            ["gold"] = 55,
            ["exp"] = 90
        },
        ["npc_woda_creep46"] = {
            ["gold"] = 60,
            ["exp"] = 105
        },
        ["npc_woda_creep47"] = {
            ["gold"] = 115,
            ["exp"] = 190
        },
        ["npc_woda_creep48"] = {
            ["gold"] = 80,
            ["exp"] = 140
        },
        ["npc_woda_creep49"] = {
            ["gold"] = 138,
            ["exp"] = 235
        },
        ["npc_woda_creep50"] = {
            ["gold"] = 100,
            ["exp"] = 175
        },
        ["npc_woda_creep51"] = {
            ["gold"] = 69,
            ["exp"] = 118
        },
        ["npc_woda_creep52"] = {
            ["gold"] = 185,
            ["exp"] = 320
        },
        ["npc_woda_creep53"] = {
            ["gold"] = 125,
            ["exp"] = 210
        },
        ["npc_woda_creep54"] = {
            ["gold"] = 145,
            ["exp"] = 230
        },
        ["npc_woda_creep55"] = {
            ["gold"] = 100,
            ["exp"] = 180
        },
        ["npc_woda_creep56"] = {
            ["gold"] = 69,
            ["exp"] = 118
        },
        ["npc_woda_creep57"] = {
            ["gold"] = 69,
            ["exp"] = 118
        },
        ["npc_woda_creep58"] = {
            ["gold"] = 69,
            ["exp"] = 118
        },
        ["npc_woda_creep59"] = {
            ["gold"] = 235,
            ["exp"] = 400
        },
        ["npc_woda_creep60"] = {
            ["gold"] = 109,
            ["exp"] = 185
        },
        ["npc_woda_creep61"] = {
            ["gold"] = 435,
            ["exp"] = 740
        },
        ["npc_woda_creep62"] = {
            ["gold"] = 100,
            ["exp"] = 175
        },
        ["npc_woda_creep63"] = {
            ["gold"] = 150,
            ["exp"] = 250
        },
        ["npc_woda_creep64"] = {
            ["gold"] = 125,
            ["exp"] = 220
        },
        ["npc_woda_creep65"] = {
            ["gold"] = 240,
            ["exp"] = 400
        },
        ["npc_woda_creep66"] = {
            ["gold"] = 69,
            ["exp"] = 118
        },
        ["npc_woda_creep67"] = {
            ["gold"] = 145,
            ["exp"] = 230
        },
        ["npc_woda_creep68"] = {
            ["gold"] = 100,
            ["exp"] = 180
        },
        ["npc_woda_creep69"] = {
            ["gold"] = 185,
            ["exp"] = 300
        },
        ["npc_woda_creep70"] = {
            ["gold"] = 100,
            ["exp"] = 180
        },
        ["npc_woda_creep71"] = {
            ["gold"] = 145,
            ["exp"] = 230
        },
        ["npc_woda_creep72"] = {
            ["gold"] = 240,
            ["exp"] = 425
        },
        ["npc_woda_creep73"] = {
            ["gold"] = 150,
            ["exp"] = 250
        },
        ["npc_woda_creep74"] = {
            ["gold"] = 270,
            ["exp"] = 463
        },
        ["npc_woda_creep75"] = {
            ["gold"] = 240,
            ["exp"] = 425
        },
        ["npc_woda_creep76"] = {
            ["gold"] = 185,
            ["exp"] = 300
        },
        ["npc_woda_creep77"] = {
            ["gold"] = 125,
            ["exp"] = 220
        },
        ["npc_woda_creep78"] = {
            ["gold"] = 145,
            ["exp"] = 230
        },
        ["npc_woda_creep79"] = {
            ["gold"] = 100,
            ["exp"] = 180
        },
        ["npc_woda_creep80"] = {
            ["gold"] = 540,
            ["exp"] = 925
        },
        ["npc_woda_creep81"] = {
            ["gold"] = 35,
            ["exp"] = 60
        },
        ["npc_woda_creep82"] = {
            ["gold"] = 75,
            ["exp"] = 120
        },
        ["npc_woda_creep83"] = {
            ["gold"] = 175,
            ["exp"] = 300
        },
        ["npc_woda_creep84"] = {
            ["gold"] = 220,
            ["exp"] = 375
        },
        ["npc_woda_creep85"] = {
            ["gold"] = 275,
            ["exp"] = 470
        },
        ["npc_woda_creep86"] = {
            ["gold"] = 270,
            ["exp"] = 463
        },
        ["npc_woda_creep87"] = {
            ["gold"] = 50,
            ["exp"] = 85
        },
        ["npc_woda_creep88"] = {
            ["gold"] = 75,
            ["exp"] = 130
        },
        ["npc_woda_creep89"] = {
            ["gold"] = 60,
            ["exp"] = 100
        },
        ["npc_woda_creep90"] = {
            ["gold"] = 100,
            ["exp"] = 175
        },
        ["npc_woda_creep91"] = {
            ["gold"] = 100,
            ["exp"] = 180
        },
        ["npc_woda_creep92"] = {
            ["gold"] = 145,
            ["exp"] = 230
        },
        ["npc_woda_creep93"] = {
            ["gold"] = 345,
            ["exp"] = 590
        },
        ["npc_woda_creep94"] = {
            ["gold"] = 85,
            ["exp"] = 150
        },
        ["npc_woda_creep95"] = {
            ["gold"] = 105,
            ["exp"] = 170
        },
        ["npc_woda_creep96"] = {
            ["gold"] = 115,
            ["exp"] = 190
        },
        ["npc_woda_creep97"] = {
            ["gold"] = 80,
            ["exp"] = 140
        },
        ["npc_woda_creep98"] = {
            ["gold"] = 69,
            ["exp"] = 118
        },
        ["npc_woda_creep99"] = {
            ["gold"] = 92,
            ["exp"] = 157
        },
        ["npc_woda_creep100"] = {
            ["gold"] = 218,
            ["exp"] = 370
        },
        ["npc_woda_creep101"] = {
            ["gold"] = 185,
            ["exp"] = 300
        },
        ["npc_woda_creep102"] = {
            ["gold"] = 125,
            ["exp"] = 220
        },
        ["npc_woda_creep103"] = {
            ["gold"] = 150,
            ["exp"] = 250
        },
        ["npc_woda_creep104"] = {
            ["gold"] = 74,
            ["exp"] = 125
        },
        ["npc_woda_creep105"] = {
            ["gold"] = 74,
            ["exp"] = 125
        },
        ["npc_woda_creep106"] = {
            ["gold"] = 74,
            ["exp"] = 125
        },
        ["npc_woda_creep107"] = {
            ["gold"] = 145,
            ["exp"] = 250
        },
        ["npc_woda_creep108"] = {
            ["gold"] = 100,
            ["exp"] = 170
        },
        ["npc_woda_creep109"] = {
            ["gold"] = 100,
            ["exp"] = 170
        },
        ["npc_woda_creep110"] = {
            ["gold"] = 92,
            ["exp"] = 157
        },
        ["npc_woda_creep111"] = {
            ["gold"] = 92,
            ["exp"] = 157
        },
        ["npc_woda_creep112"] = {
            ["gold"] = 92,
            ["exp"] = 157
        },
        ["npc_woda_creep113"] = {
            ["gold"] = 270,
            ["exp"] = 463
        },
        ["npc_woda_creep114"] = {
            ["gold"] = 270,
            ["exp"] = 463
        },
        ["boss_3"] = {
            ["gold"] = 1490,
            ["exp"] = 2385
        },
        ["boss_5"] = {
            ["gold"] = 2787,
            ["exp"] = 3576
        },
        ["npc_woda_creep1_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep2_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep3_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep4_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep5_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep6_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep7_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep8_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep9_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep10_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep11_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep12_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep13_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep14_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep15_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep16_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep17_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep18_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep19_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep20_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep21_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep22_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep23_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep24_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep25_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep26_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep27_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep28_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep29_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep30_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep31_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep32_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep33_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep34_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep35_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep36_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep37_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep38_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep39_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep40_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep41_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep42_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep43_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep44_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep45_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep46_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep47_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep48_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep49_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep50_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep51_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep52_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep53_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep54_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep55_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep56_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep57_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep58_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep59_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep60_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep61_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep62_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep63_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep64_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep65_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep66_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep67_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep68_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep69_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep70_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep71_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep72_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep73_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep74_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep75_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep76_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep77_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep78_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep79_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep80_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep81_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep82_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep83_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep84_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep85_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep86_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep87_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep88_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep89_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep90_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep91_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep92_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep93_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep_red_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep_orange_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep_yellow_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep_green_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep_blue_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
        ["npc_woda_creep_purple_pve"] = {
            ["gold"] = 24,
            ["exp"] = 40
        },
    }

    CHAMPION_CREEPPERSENTAGE_BLUE=3
    CHAMPION_CREEPPERSENTAGE_RED=1
    CHAMPION_PIG=33
    CHAMPION_FROG=33

    -- Границы арен
    ARENA_POSITIONS_MAX = 
    {
        [1] = 
        {
            ["y_min"] = -7584, ["y_max"] = -15456, ["x_min"] = 3968, ["x_max"] = 11904
        },
        [2] = 
        {
            ["y_min"] = -7584, ["y_max"] = -15456, ["x_min"] = -5760, ["x_max"] = 2176
        },
        [3] = 
        {
            ["y_min"] = -7584, ["y_max"] = -15456, ["x_min"] = -15488, ["x_max"] = -7552
        },
        [4] = 
        {
            ["y_min"] = 2176, ["y_max"] = -5728, ["x_min"] = -15488, ["x_max"] = -7552
        },
        [5] = 
        {
            ["y_min"] = 12064, ["y_max"] = 3872, ["x_min"] = -15488, ["x_max"] = -7552
        },
        [6] = 
        {
            ["y_min"] = 12064, ["y_max"] = 3872, ["x_min"] = -5760, ["x_max"] = 2176
        },
        ["duel"] = 
        {
            ["y_min"] = -64, ["y_max"] = -3520, ["x_min"] = -3584, ["x_max"] = 32
        },
        ["finalduel"] = 
        {
            ["y_min"] = 9792, ["y_max"] = 6080, ["x_min"] = 6080, ["x_max"] = 9792
        },
        ["relax"] = 
        {
            ["y_min"] = 160, ["y_max"] = -3808, ["x_min"] = 5760, ["x_max"] = 10080
        }
    }
end

if GetMapName() == "rating" or GetMapName() == "rating_300" then
    require("libs/gamemodes/rating")
elseif GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
    require("libs/gamemodes/rating")
    require("libs/gamemodes/rating_duo")
elseif GetMapName() == "arena" then
    require("libs/gamemodes/arena")
elseif GetMapName() == "overthrow" then
    require("libs/gamemodes/overthrow")
end

if IsInToolsMode() then
	STARTGAME_DURATION = 235
	ARENA_DURATION = 6000
	PVE_CURRENT_WAVE = 1
    --PVE_WAVES_COMPLETE = 98
	--REMOVE_CREEPS_UGPRADE_TEST = true
	CURRENT_ARENA = 5
	--DEFAULT_KILLS_COUNT = 1
	--FULL_TIME_OVERHROW = 60
	--------------------------------------------
	STARTGAME_DURATION_PVE = 5
    STARTGAME_DURATION_OVERTHROW = 1
    --STARTGAME_DURATION_OVERTHROW = 1
	--DELAY_WAVES_TIME_RELAX = 3
end

function arena_system:ArenaPositionCheck()
	for id, player in pairs(PLAYERS) do
		if CURRENT_ARENA <= 6 then
			local hero = player.hero
			if hero ~= nil and hero:IsAlive() then
				local origin = hero:GetAbsOrigin()
				local change = false
				if origin.z < 1000 then 
					origin = GetGroundPosition(origin, hero)
				end
				if origin.x < ARENA_POSITIONS_MAX[CURRENT_ARENA]["x_min"] then
					origin.x = ARENA_POSITIONS_MAX[CURRENT_ARENA]["x_min"] + 200
					change = true
				end
				if origin.x > ARENA_POSITIONS_MAX[CURRENT_ARENA]["x_max"] then
					origin.x = ARENA_POSITIONS_MAX[CURRENT_ARENA]["x_max"] - 200
					change = true
				end
				if origin.y > ARENA_POSITIONS_MAX[CURRENT_ARENA]["y_min"] then
					origin.y = ARENA_POSITIONS_MAX[CURRENT_ARENA]["y_min"] - 200
					change = true
                end
				if origin.y < ARENA_POSITIONS_MAX[CURRENT_ARENA]["y_max"] then
					origin.y = ARENA_POSITIONS_MAX[CURRENT_ARENA]["y_max"] + 200
					change = true
				end
				if change and hero:IsAlive() and hero.death == nil then 
					hero:SetAbsOrigin(origin)
					FindClearSpaceForUnit(hero, origin, true)
					hero:RemoveModifierByName("modifier_pudge_chain_binding")
				end
			end
			if hero ~= nil and hero.bear and not hero.bear:IsNull() and hero.bear:IsAlive() then
				if CURRENT_ARENA <= 6 then
					local origin = hero.bear:GetAbsOrigin()
					local change = false
					if origin.z < 1000 then 
						origin = GetGroundPosition(origin, hero.bear)
					end
					if origin.x < ARENA_POSITIONS_MAX[CURRENT_ARENA]["x_min"] then
						origin.x = ARENA_POSITIONS_MAX[CURRENT_ARENA]["x_min"] + 200
						change = true
					end
					if origin.x > ARENA_POSITIONS_MAX[CURRENT_ARENA]["x_max"] then
						origin.x = ARENA_POSITIONS_MAX[CURRENT_ARENA]["x_max"] - 200
						change = true
					end
					if origin.y > ARENA_POSITIONS_MAX[CURRENT_ARENA]["y_min"] then
						origin.y = ARENA_POSITIONS_MAX[CURRENT_ARENA]["y_min"] - 200
						change = true
					end
					if origin.y < ARENA_POSITIONS_MAX[CURRENT_ARENA]["y_max"] then
						origin.y = ARENA_POSITIONS_MAX[CURRENT_ARENA]["y_max"] + 200
						change = true
					end
					if change then 
						hero.bear:SetAbsOrigin(origin)
						FindClearSpaceForUnit(hero.bear, origin, true)
					end
				end
			end
		end
	end
end

function arena_system:DuelPositionCheck(hero)
	local origin = hero:GetAbsOrigin()
	local change = false
	if origin.z < 1000 then 
		origin = GetGroundPosition(origin, hero)
	end
	if origin.x < ARENA_POSITIONS_MAX["duel"]["x_min"] then
		origin.x = ARENA_POSITIONS_MAX["duel"]["x_min"] + 200
		change = true
	end
	if origin.x > ARENA_POSITIONS_MAX["duel"]["x_max"] then
		origin.x = ARENA_POSITIONS_MAX["duel"]["x_max"] - 200
		change = true
	end
	if origin.y > ARENA_POSITIONS_MAX["duel"]["y_min"] then
		origin.y = ARENA_POSITIONS_MAX["duel"]["y_min"] - 200
		change = true
	end
	if origin.y < ARENA_POSITIONS_MAX["duel"]["y_max"] then
		origin.y = ARENA_POSITIONS_MAX["duel"]["y_max"] + 200
		change = true
	end
	if change and hero:IsAlive() then 
		hero:SetAbsOrigin(origin)
		FindClearSpaceForUnit(hero, origin, true)
		hero:RemoveModifierByName("modifier_pudge_chain_binding")
	end
	if hero.bear and not hero.bear:IsNull() and hero.bear:IsAlive() then
		local origin = hero.bear:GetAbsOrigin()
		local change = false
		if origin.z < 1000 then 
			origin = GetGroundPosition(origin, hero.bear)
		end
		if origin.x < ARENA_POSITIONS_MAX["duel"]["x_min"] then
			origin.x = ARENA_POSITIONS_MAX["duel"]["x_min"] + 200
			change = true
		end
		if origin.x > ARENA_POSITIONS_MAX["duel"]["x_max"] then
			origin.x = ARENA_POSITIONS_MAX["duel"]["x_max"] - 200
			change = true
		end
		if origin.y > ARENA_POSITIONS_MAX["duel"]["y_min"] then
			origin.y = ARENA_POSITIONS_MAX["duel"]["y_min"] - 200
			change = true
		end
		if origin.y < ARENA_POSITIONS_MAX["duel"]["y_max"] then
			origin.y = ARENA_POSITIONS_MAX["duel"]["y_max"] + 200
			change = true
		end
		if change then 
			hero.bear:SetAbsOrigin(origin)
			FindClearSpaceForUnit(hero.bear, origin, true)
		end
	end
end

function arena_system:EndDuelPositionCheck(hero)
	local origin = hero:GetAbsOrigin()
	local change = false
	if origin.z < 1000 then 
		origin = GetGroundPosition(origin, hero)
	end
	if origin.x < ARENA_POSITIONS_MAX["finalduel"]["x_min"] then
		origin.x = ARENA_POSITIONS_MAX["finalduel"]["x_min"] + 200
		change = true
	end
	if origin.x > ARENA_POSITIONS_MAX["finalduel"]["x_max"] then
		origin.x = ARENA_POSITIONS_MAX["finalduel"]["x_max"] - 200
		change = true
	end
	if origin.y > ARENA_POSITIONS_MAX["finalduel"]["y_min"] then
		origin.y = ARENA_POSITIONS_MAX["finalduel"]["y_min"] - 200
		change = true
	end
	if origin.y < ARENA_POSITIONS_MAX["finalduel"]["y_max"] then
		origin.y = ARENA_POSITIONS_MAX["finalduel"]["y_max"] + 200
		change = true
	end
	if change and hero:IsAlive() then 
		hero:SetAbsOrigin(origin)
		FindClearSpaceForUnit(hero, origin, true)
	end
	if hero.bear and not hero.bear:IsNull() and hero.bear:IsAlive() then
		local origin = hero.bear:GetAbsOrigin()
		local change = false
		if origin.z < 1000 then 
			origin = GetGroundPosition(origin, hero.bear)
		end
		if origin.x < ARENA_POSITIONS_MAX["finalduel"]["x_min"] then
			origin.x = ARENA_POSITIONS_MAX["finalduel"]["x_min"] + 200
			change = true
		end
		if origin.x > ARENA_POSITIONS_MAX["finalduel"]["x_max"] then
			origin.x = ARENA_POSITIONS_MAX["finalduel"]["x_max"] - 200
			change = true
		end
		if origin.y > ARENA_POSITIONS_MAX["finalduel"]["y_min"] then
			origin.y = ARENA_POSITIONS_MAX["finalduel"]["y_min"] - 200
			change = true
		end
		if origin.y < ARENA_POSITIONS_MAX["finalduel"]["y_max"] then
			origin.y = ARENA_POSITIONS_MAX["finalduel"]["y_max"] + 200
			change = true
		end
		if change then 
			hero.bear:SetAbsOrigin(origin)
			FindClearSpaceForUnit(hero.bear, origin, true)
		end
	end
end

function arena_system:RelaxPositionCheck(hero)
	local origin = hero:GetAbsOrigin()
	local change = false
	if origin.z < 1000 then 
		origin = GetGroundPosition(origin, hero)
	end
	if origin.x < ARENA_POSITIONS_MAX["relax"]["x_min"] then
		origin.x = ARENA_POSITIONS_MAX["relax"]["x_min"] + 200
		change = true
	end
	if origin.x > ARENA_POSITIONS_MAX["relax"]["x_max"] then
		origin.x = ARENA_POSITIONS_MAX["relax"]["x_max"] - 200
		change = true
	end
	if origin.y > ARENA_POSITIONS_MAX["relax"]["y_min"] then
		origin.y = ARENA_POSITIONS_MAX["relax"]["y_min"] - 200
		change = true
	end
	if origin.y < ARENA_POSITIONS_MAX["relax"]["y_max"] then
		origin.y = ARENA_POSITIONS_MAX["relax"]["y_max"] + 200
		change = true
	end
	if change then 
		local teleport_point=Entities:FindByName(nil,"relaxarena")
		if teleport_point and hero:IsAlive() then 
			hero:SetAbsOrigin(teleport_point:GetAbsOrigin())
			FindClearSpaceForUnit(hero, teleport_point:GetAbsOrigin(), true)
			hero:RemoveModifierByName("modifier_pudge_chain_binding")
		end
	end
	if hero.bear and not hero.bear:IsNull() and hero.bear:IsAlive() then
		local origin = hero.bear:GetAbsOrigin()
		local change = false
		if origin.z < 1000 then 
			origin = GetGroundPosition(origin, hero.bear)
		end
		if origin.x < ARENA_POSITIONS_MAX["relax"]["x_min"] then
			origin.x = ARENA_POSITIONS_MAX["relax"]["x_min"] + 200
			change = true
		end
		if origin.x > ARENA_POSITIONS_MAX["relax"]["x_max"] then
			origin.x = ARENA_POSITIONS_MAX["relax"]["x_max"] - 200
			change = true
		end
		if origin.y > ARENA_POSITIONS_MAX["relax"]["y_min"] then
			origin.y = ARENA_POSITIONS_MAX["relax"]["y_min"] - 200
			change = true
		end
		if origin.y < ARENA_POSITIONS_MAX["relax"]["y_max"] then
			origin.y = ARENA_POSITIONS_MAX["relax"]["y_max"] + 200
			change = true
		end
		if change then 
			local teleport_point=Entities:FindByName(nil,"relaxarena")
			if teleport_point then 
				hero.bear:SetAbsOrigin(teleport_point:GetAbsOrigin())
				FindClearSpaceForUnit(hero.bear, teleport_point:GetAbsOrigin(), true)
			end
		end
	end
end

-- Фильтр отслеживания любого убийства на карте
function arena_system:OnEntityKilled(params)
	local killedunit = EntIndexToHScript(params.entindex_killed) -- Кого убили
	local killedteam = killedunit:GetTeamNumber() -- Команда убитого
	local killer = nil -- Убийца
	if params.entindex_attacker then
		killer = EntIndexToHScript(params.entindex_attacker) -- Если убийца есть, то установим его
	end

	-- Баланс функция, если ценность убитого больше чем твоя, то ты получаешь 30% разницы вашей ценности
	if killer ~= nil and killedunit ~= nil and killer ~= killedunit and killer:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then
		if killedunit:IsRealHero() and not killedunit:IsReincarnating() then
			local net_killer = PlayerResource:GetNetWorth(killer:GetPlayerOwnerID())
			local net_victim = PlayerResource:GetNetWorth(killedunit:GetPlayerOwnerID())

			if not killer:IsHero() and not killer:IsIllusion() then
				if killer:GetOwner() then
					killer = killer:GetOwner()
				end
			end
			
			-- Рассчет убийцы
			if killer.book then 
				net_killer = net_killer + (killer.book*500)
			end

			if killer.exp_book then 
				net_killer = net_killer + (killer.exp_book*350)
			end

			if killer.attribute_book then 
				net_killer = net_killer + (killer.attribute_book*500)
			end

			if killer:HasModifier("modifier_item_royale_with_cheese") then
	        	net_killer = net_killer + 4500
	        end

            local get_enchantment_killer = killer:GetItemInSlot(17)
            if get_enchantment_killer then
                local tier_counter = neutrals_reward:GetNeutralTier(get_enchantment_killer:GetAbilityName(), get_enchantment_killer:GetLevel())
                net_killer = net_killer + (neutrals_reward.NEUTRALS_COST[tier_counter] or 0)
            end

			if killer.consumble then 
				net_killer = net_killer + killer.consumble
			end

			if killer.bear and not killer.bear:IsNull() then
				local bonus_bear_networths = 0
				for i = 0, 18 do
					local item = killer.bear:GetItemInSlot(i)
					if item then
						bonus_bear_networths = bonus_bear_networths + item:GetCost()
					end
				end
				net_killer = net_killer + bonus_bear_networths
			end

			-- Рассчет убитого
			if killedunit.book then 
				net_victim = net_victim + (killedunit.book*500)
			end

			if killedunit.exp_book then 
				net_victim = net_victim + (killedunit.exp_book*350)
			end

			if killedunit.attribute_book then 
				net_victim = net_victim + (killedunit.attribute_book*500)
			end

			if killedunit.consumble then 
				net_victim = net_victim + killedunit.consumble
			end

			if killedunit:HasModifier("modifier_item_royale_with_cheese") then
	        	net_victim = net_victim + 4500
	        end

            local get_enchantment_killed = killedunit:GetItemInSlot(17)
            if get_enchantment_killed then
                local tier_counter = neutrals_reward:GetNeutralTier(get_enchantment_killed:GetAbilityName(), get_enchantment_killed:GetLevel())
                net_victim = net_victim + (neutrals_reward.NEUTRALS_COST[tier_counter] or 0)
            end

			if killedunit.bear and not killedunit.bear:IsNull() then
				local bonus_bear_networths = 0
				for i = 0, 18 do
					local item = killedunit.bear:GetItemInSlot(i)
					if item then
						bonus_bear_networths = bonus_bear_networths + item:GetCost()
					end
				end
				net_victim = net_victim + bonus_bear_networths
			end

			local bonus_gold = 0
			if net_victim > net_killer then
				bonus_gold = (net_victim - net_killer) * 0.3
			end

			if bonus_gold > 0 then
				if killer ~= nil then
					if killer:GetUnitName() ~= "dota_fountain" and killer:IsRealHero() then
						local out_gold = killer:ModifyGold(bonus_gold, true, DOTA_ModifyGold_HeroKill)
						SendOverheadEventMessage(killer, 0, killer, out_gold, nil)
					end
				end
			end
		end
	end

	-- Функция убийства крипов
	if killedteam == DOTA_TEAM_NEUTRALS then
		if NEUTRAL_CREEPSREWARD[killedunit:GetUnitName()] and killer ~= nil then 
			------ Опыт
			local heroes = FindUnitsInRadius(killer:GetTeamNumber(), killedunit:GetAbsOrigin(), nil, 1800, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE+DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO+DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS+DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD+DOTA_UNIT_TARGET_FLAG_DEAD, 0, false)
            for _,hero in pairs(heroes) do 
                if hero:IsRealHero() and not hero:HasModifier("modifier_dazzle_nothl_projection_soul_clone") and (hero:GetPlayerOwnerID() == killer:GetPlayerOwnerID() or GetMapName() == "arena") and not hero:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then
                    local exp = NEUTRAL_CREEPSREWARD[killedunit:GetUnitName()]["exp"]

                    if killedunit:HasModifier("modifier_woda_pve_creep_upgrade_wave") and killedunit.frog == nil then
                    	local modifier_woda_pve_creep_upgrade_wave = killedunit:FindModifierByName("modifier_woda_pve_creep_upgrade_wave")
                    	if modifier_woda_pve_creep_upgrade_wave then
                    		exp = exp + (exp / 100 * (PVE_REWARD_EXP_PERCENTAGE_PER_WAVE * math.min(modifier_woda_pve_creep_upgrade_wave:GetStackCount(), PVE_REWARD_MAXIMUM_STACK_CAP)))
                    	end
                    end

                    if killedunit.champion_blue ~= nil then
                    	exp = exp * 4
                    end

                    if killedunit.champion_red ~= nil then
                    	exp = exp * 10
                    end

                    if GetMapName() ~= "arena" then
	                    if player_system:GetPlayerPositionLevels(hero:GetPlayerID()) ~= nil and BONUS_NETWORTGS_TABLE[player_system:GetPlayerCountAll()][player_system:GetPlayerPositionLevels(hero:GetPlayerID())] ~= nil then
	                    	exp = exp + ( exp / 100 * BONUS_NETWORTGS_TABLE[player_system:GetPlayerCountAll()][player_system:GetPlayerPositionLevels(hero:GetPlayerID())])
	                    end
	                end

                    if hero:GetPlayerOwnerID() == killer:GetPlayerOwnerID() then
	                    if killedunit.frog ~= nil then
	                    	if GetMapName() == "arena" then
	                    		exp = exp * (math.min(math.floor(PVE_CURRENT_WAVE / 10) + 1,6))
	                    	elseif GetMapName() == "overthrow" then
	                    		local tier = 1
	                    		if math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60) > 12 then
	                    			tier = 6
	                    		elseif math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60) > 10 then
	                    			tier = 5
	                    		elseif math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60) > 7 then
	                    			tier = 4
	                    		elseif math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60) > 4 then
	                    			tier = 3
	                    		elseif math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60) > 1 then
	                    			tier = 2
	                    		end
	                    		exp = exp * tier
	                    	else
	                    		exp = exp * CURRENT_ARENA
	                    	end
	                    	WodaTalents:AddPoint(killer:GetPlayerOwnerID(),1)
	                    end
	                end
                    
                    if killedunit.pig ~= nil and GetMapName() == "arena" then
                    	if hero:GetPlayerOwnerID() == killer:GetPlayerOwnerID() then
                    		hero:AddExperience(exp, DOTA_ModifyGold_CreepKill, false, false)
                    	end
                    else
                        if killedunit.is_lich_creep then
                            exp = exp / 100 * killedunit.is_lich_creep
                        end
						hero:AddExperience(exp, DOTA_ModifyGold_CreepKill, false, false)
					end
                end
            end
            ----- Золото
            heroes = FindUnitsInRadius(killer:GetTeamNumber(), killedunit:GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE+DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO+DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS+DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD+DOTA_UNIT_TARGET_FLAG_DEAD, 0, false)
            for _,hero in pairs(heroes) do 
                if hero:IsRealHero() and not hero:HasModifier("modifier_dazzle_nothl_projection_soul_clone") and (hero:GetPlayerOwnerID() == killer:GetPlayerOwnerID() or GetMapName() == "arena") and not hero:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then
                    local gold = NEUTRAL_CREEPSREWARD[killedunit:GetUnitName()]["gold"]

                    if killedunit:HasModifier("modifier_woda_pve_creep_upgrade_wave") and killedunit.pig == nil then
                    	local modifier_woda_pve_creep_upgrade_wave = killedunit:FindModifierByName("modifier_woda_pve_creep_upgrade_wave")
                    	if modifier_woda_pve_creep_upgrade_wave then
                    		gold = gold + (gold / 100 * (PVE_REWARD_GOLD_PERCENTAGE_PER_WAVE * math.min(modifier_woda_pve_creep_upgrade_wave:GetStackCount(), PVE_REWARD_MAXIMUM_STACK_CAP)))
                    	end
                    end

                    if killedunit.champion_blue ~= nil then
                    	gold = gold * 4
                    end

                    if killedunit.champion_red ~= nil then
                    	gold = gold * 10
                    end

                    if hero:GetPlayerOwnerID() == killer:GetPlayerOwnerID() then
	                    if killedunit.pig ~= nil then 
	                    	if GetMapName() == "arena" then
	                    		gold = gold * (math.min(math.floor(PVE_CURRENT_WAVE / 10) + 1,6))
	                    	elseif GetMapName() == "overthrow" then
	                    		local tier = 1
	                    		if math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60) > 12 then
	                    			tier = 6
	                    		elseif math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60) > 10 then
	                    			tier = 5
	                    		elseif math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60) > 7 then
	                    			tier = 4
	                    		elseif math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60) > 4 then
	                    			tier = 3
	                    		elseif math.floor(math.floor(GameRules:GetDOTATime(false, false)) / 60) > 1 then
	                    			tier = 2
	                    		end
	                    		gold = gold * tier
	                    	else
	                    		gold = gold * CURRENT_ARENA
	                    	end
	                    end
	                end

	                if GetMapName() ~= "arena" then
	                    if player_system:GetPlayerPositionNetworths(hero:GetPlayerID()) ~= nil and BONUS_NETWORTGS_TABLE[player_system:GetPlayerCountAll()][player_system:GetPlayerPositionNetworths(hero:GetPlayerID())] ~= nil then
	                    	gold = gold + (gold / 100 * BONUS_NETWORTGS_TABLE[player_system:GetPlayerCountAll()][player_system:GetPlayerPositionNetworths(hero:GetPlayerID())])
	                    end
	                end

                    if killedunit.pig ~= nil and GetMapName() == "arena" then
                    	if hero:GetPlayerOwnerID() == killer:GetPlayerOwnerID() and not IsArenaAfk(hero:GetPlayerOwnerID()) then
                    		local out_gold = hero:ModifyGold(gold, false, DOTA_ModifyGold_CreepKill)
                    		CreateEffectGold(hero,out_gold,killedunit)
                    	end
                    else
                        if not IsArenaAfk(hero:GetPlayerOwnerID()) then
						    local out_gold = hero:ModifyGold(gold, false, DOTA_ModifyGold_CreepKill)
						    CreateEffectGold(hero,out_gold,killedunit)
                        end
					end
                end
            end
            -- Если цель чемпион, то дает один поинт
            if killedunit:HasModifier("modifier_wodacreepchampion") then 
				WodaTalents:AddPoint(killer:GetPlayerOwnerID(),1)
			end
			-- Если цель красный чемпион, то дает 3 поинта
			if killedunit:HasModifier("modifier_wodacreepchampionred") then 
				WodaTalents:AddPoint(killer:GetPlayerOwnerID(),3)
			end
			-- Если цель босс, то дает отдельный бонус
			if killedunit.boss ~= nil and killedunit.end_arena == nil then 
				local gold = NEUTRAL_CREEPSREWARD[killedunit:GetUnitName()]["gold"] / 4
				local exp = NEUTRAL_CREEPSREWARD[killedunit:GetUnitName()]["exp"] / 4
				WodaTalents:AddPoint(killer:GetPlayerOwnerID(),5) 
				local heroes = FindUnitsInRadius(killer:GetTeamNumber(), killedunit:GetAbsOrigin(), nil, 1800, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE+DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO+DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES+DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS+DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD+DOTA_UNIT_TARGET_FLAG_DEAD, 0, false)
				for _,hero in pairs(heroes) do
                    if not hero:HasModifier("modifier_dazzle_nothl_projection_soul_clone") and not hero:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then
                        WodaTalents:AddPoint(hero:GetPlayerOwnerID(),5)
                        local out_gold = hero:ModifyGold(gold, false, DOTA_ModifyGold_CreepKill)
                        hero:AddExperience(exp, DOTA_ModifyGold_CreepKill, false, false)
                        CreateEffectGold(hero,out_gold,killedunit)
                    end
				end
                CustomGameEventManager:Send_ServerToAllClients("notification_team_has_been_killed_boss", {id = killer:GetPlayerOwnerID(), heroname = PLAYERS[killer:GetPlayerOwnerID()].hero:GetUnitName()})
                player_system:CheckBossKilled(killer:GetPlayerOwnerID())
            end
		end
	end

	-- Если убитый юнит был героем, то будем за него давать поинты и устанавливать специальное время спавна
	if killedunit:IsRealHero() then
		-- Поинт
		if killer ~= nil then 
			if not killer:IsNeutralUnitType() and not killedunit:IsReincarnating() then
				WodaTalents:AddPoint(killer:GetPlayerOwnerID(),2)
			end
		end
		-- Время спавна
		if killedunit:IsReincarnating() then
			return
		else
			arena_system:SetRespawnTime(killedunit)
		end
	end

    -- Функция постоянного обновления ценности на всякий случай
	player_system:NetWorthUpdate()
end

-- Функция установки время возрождения
function arena_system:SetRespawnTime(hero)
	local respawn_table = 
	{
		[1] = 27,
		[2] = 25,
		[3] = 23,
		[4] = 21,
		[5] = 19,
		[6] = 17,
		[7] = 15,
		[8] = 13
	}
	local respawn_table_overthrow = 
	{
		[1] = 17,
		[2] = 15,
		[3] = 13,
		[4] = 11,
		[5] = 9,
		[6] = 7,
		[7] = 5,
		[8] = 3
	}

	-- Смертьв дуэли ( Все равно респавн будет )
	if player_system:IsDuel(hero:GetPlayerOwnerID()) then
		hero:SetTimeUntilRespawn(99999999)
		return
	end

	-- Смерть в окончательной дуэли ( Все равно респавн будет )
	if player_system:IsDuelEnd(hero:GetPlayerOwnerID()) then
		hero:SetTimeUntilRespawn(99999999)
		return
	end

	-- Проигравший тоже не должен возрождаться никогда!!
	if player_system:IsLose(hero:GetPlayerOwnerID()) then
		hero:SetTimeUntilRespawn(99999999)
		return
	end

	if GetMapName() == "arena" then
		if arena_system:GetAegisCount(hero) <= 0 then
	    	hero:SetTimeUntilRespawn(99999999)
	    	hero:SetRespawnsDisabled(true)
	    	if arena_system:CheckPveSkipBoss() then
	    		arena_system:CloseAndEndGamePVE()
	    	end
	    	return
	    end
	end

	-- Позиция ценности
	local position = player_system:GetPlayerPositionNetworths(hero:GetPlayerOwnerID())

	-- Устанавливаем время возрождения
	if GetMapName() == "arena" then
		self:EnrageClear()
		hero:SetTimeUntilRespawn(PVE_RESPAWN_TIME_AEGIS)
	elseif string.find(GetMapName(), "rating") then
		hero:SetTimeUntilRespawn(respawn_table[position])
	elseif GetMapName() == "overthrow" then
		position = player_system:GetPlayerPositionKills(hero:GetPlayerOwnerID())
		hero:SetTimeUntilRespawn(respawn_table_overthrow[position])
	end

	if GetMapName() == "overthrow" then return end
	-- Висп должен выходить из невидимости за 3 секунд перед возрождением, поэтому устанавливаем длительность -3 секунды
	local wispmodifier = hero:FindModifierByName("modifier_wodawispdeath")
	if wispmodifier then 
		if wispmodifier.wisp and not wispmodifier.wisp:IsNull() and wispmodifier.wisp:IsAlive() then
			local invismodifier = wispmodifier.wisp:FindModifierByName("modifier_wodawispdeath_invisible")
			if invismodifier then
				invismodifier:SetDuration(respawn_table[position] - 3, true)
			end
		end
	end
end

-- Инициализация спавна рун
function arena_system:StartRune()
    local spawn_rune = true
	ARENA_RUNETIMER = Timers:CreateTimer(0, function()
		if math.floor(GameRules:GetDOTATime(false, false)) % 120 == 0 then
            if spawn_rune then 
			    self:SpawnRune()
                spawn_rune = false
            end
			return 0.5
		end
        spawn_rune = true
		return 0.5
	end)
end

-- Создание руны
function arena_system:SpawnRune()
	if GetMapName() == "overthrow" then
		local spawn_point_runes = 
		{
			"spawn_rune_arena1_rune1",
			"spawn_rune_arena1_rune2",
			"spawn_rune_arena1_rune3",
			"spawn_rune_arena1_rune4",
			"spawn_rune_arena1_rune5",
			"spawn_rune_arena1_rune6",
			"spawn_rune_arena1_rune7",
			"spawn_rune_arena1_rune8"
		}
		for _,point in pairs(spawn_point_runes) do 
			local runetype = arena_system:GetRune()
			local point2 = Entities:FindByName(nil, point)
			if point2 then 
				local near_rune_arcane = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_arcane.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_doubledamage01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_doubledamage01.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_haste01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_haste01.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_illusion01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_illusion01.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_regeneration01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_regeneration01.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_goldxp = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_goldxp.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_water = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_water.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_xp = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_xp.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_shield = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_shield01.vmdl", point2:GetAbsOrigin(), 100)

				local near_rune = false
				if near_rune_arcane then
				    near_rune = true
				end
				if near_rune_doubledamage01 then
				    near_rune = true
				end 
				if near_rune_haste01 then
				    near_rune = true
				end
				if near_rune_illusion01 then
				    near_rune = true
				end 
				if near_rune_water then
				    near_rune = true
				end 
				if near_rune_regeneration01 then
				    near_rune = true
				end
				if near_rune_goldxp then
				    near_rune = true
				end
				if near_rune_xp then
				    near_rune = true
				end
				if near_rune_shield then
				    near_rune = true
				end
				if not near_rune then
					CreateRune(point2:GetAbsOrigin(), runetype)
				end
			end
		end
		return
	end
	if GetMapName() == "arena" then
		local spawn_point_runes = 
		{
			"spawn_rune_arena1_rune2",
			"spawn_rune_arena1_rune1"
		}
		for _,point in pairs(spawn_point_runes) do 
			local runetype = arena_system:GetRune()
			local point2 = Entities:FindByName(nil, point)
			if point2 then 
				local near_rune_arcane = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_arcane.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_doubledamage01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_doubledamage01.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_haste01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_haste01.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_illusion01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_illusion01.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_regeneration01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_regeneration01.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_goldxp = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_goldxp.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_water = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_water.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_xp = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_xp.vmdl", point2:GetAbsOrigin(), 100)
				local near_rune_shield = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_shield01.vmdl", point2:GetAbsOrigin(), 100)

				local near_rune = false
				if near_rune_arcane then
				    near_rune = true
				end
				if near_rune_doubledamage01 then
				    near_rune = true
				end 
				if near_rune_haste01 then
				    near_rune = true
				end
				if near_rune_illusion01 then
				    near_rune = true
				end 
				if near_rune_water then
				    near_rune = true
				end 
				if near_rune_regeneration01 then
				    near_rune = true
				end
				if near_rune_goldxp then
				    near_rune = true
				end
				if near_rune_xp then
				    near_rune = true
				end
				if near_rune_shield then
				    near_rune = true
				end
				if not near_rune then
					CreateRune(point2:GetAbsOrigin(), runetype)
				end
			end
		end
		return
	end

	for _,point in pairs(RUNE_SPAWNPOINTS[CURRENT_ARENA]) do 
		local runetype = arena_system:GetRune()
		local point2 = Entities:FindByName(nil, point)
		if point2 then 
			local near_rune_arcane = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_arcane.vmdl", point2:GetAbsOrigin(), 100)
			local near_rune_doubledamage01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_doubledamage01.vmdl", point2:GetAbsOrigin(), 100)
			local near_rune_haste01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_haste01.vmdl", point2:GetAbsOrigin(), 100)
			local near_rune_illusion01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_illusion01.vmdl", point2:GetAbsOrigin(), 100)
			local near_rune_regeneration01 = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_regeneration01.vmdl", point2:GetAbsOrigin(), 100)
			local near_rune_goldxp = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_goldxp.vmdl", point2:GetAbsOrigin(), 100)
			local near_rune_water = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_water.vmdl", point2:GetAbsOrigin(), 100)
			local near_rune_xp = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_xp.vmdl", point2:GetAbsOrigin(), 100)
			local near_rune_shield = Entities:FindByModelWithin(nil, "models/props_gameplay/rune_shield01.vmdl", point2:GetAbsOrigin(), 100)

			local near_rune = false
			if near_rune_arcane then
			    near_rune = true
			end
			if near_rune_doubledamage01 then
			    near_rune = true
			end 
			if near_rune_haste01 then
			    near_rune = true
			end
			if near_rune_illusion01 then
			    near_rune = true
			end 
			if near_rune_water then
			    near_rune = true
			end 
			if near_rune_regeneration01 then
			    near_rune = true
			end
			if near_rune_goldxp then
			    near_rune = true
			end
			if near_rune_xp then
			    near_rune = true
			end
			if near_rune_shield then
			    near_rune = true
			end
			if not near_rune then
				CreateRune(point2:GetAbsOrigin(), runetype)
			end
		end
	end
end

-- Функция случайной руны
function arena_system:GetRune()
    local rune_name = nil
    local runelist = {DOTA_RUNE_ARCANE, DOTA_RUNE_REGENERATION, DOTA_RUNE_DOUBLEDAMAGE, DOTA_RUNE_HASTE, DOTA_RUNE_SHIELD, DOTA_RUNE_ILLUSION }

    repeat
        if RollPercentage(9) then
            rune_name = DOTA_RUNE_WATER
        elseif RollPercentage(45) then
            rune_name = runelist[RandomInt(1, #runelist)]
        elseif RollPercentage(45) then
            rune_name = DOTA_RUNE_BOUNTY
        end
    until rune_name ~= nil
    
    return rune_name
end


-- Обновление иконок кэмпов
function arena_system:UpdateIcons(pos)
	local camp = CreateUnitByName("minimap_small_camp_custom", pos, false, nil, nil, DOTA_TEAM_NEUTRALS)
	camp:AddNewModifier(camp, nil, "modifier_wodacamp", {})
	table.insert(CAMPS_ICONS, camp)
end

-- Спавн крипа
function arena_system:Spawn(trigger, pos, tier, forward)
	for _,creep in pairs(NEUTRAL_CREEPS_TYPES[tier][RandomInt(1, #NEUTRAL_CREEPS_TYPES[tier])]) do
		local creepname = creep
		if RollPercentage(1) then 
			if RollPercentage(CHAMPION_PIG) then 
				creepname = "npc_woda_pig"
			end
		elseif RollPercentage(1) then 
			if RollPercentage(CHAMPION_FROG) then 
				creepname = "npc_woda_frog"
			end
		end
		local unit = CreateUnitByName(creepname, pos, true, nil, nil, 4)
        if unit then
            unit:SetLocalOrigin(unit:GetAbsOrigin())
            unit:SetForwardVector(forward)
            unit:SetMinimumGoldBounty(0)
            unit:SetMaximumGoldBounty(0)
            unit:SetDeathXP(0)
            if creepname == "npc_woda_pig" then 
                unit:AddNewModifier(unit, nil, "modifier_wodapig", {})
                unit.pig = true
            end
            if creepname == "npc_woda_frog" then 
                unit:AddNewModifier(unit, nil, "modifier_wodafrog", {})
                unit.frog = true
            end
            if RollPercentage(CHAMPION_CREEPPERSENTAGE_RED) and creepname ~= "npc_woda_pig" and creepname ~= "npc_woda_frog" then 
                unit:AddNewModifier(unit, nil, "modifier_wodacreepchampionred", {})
                unit.champion_red = true
            elseif RollPercentage(CHAMPION_CREEPPERSENTAGE_BLUE) and creepname ~= "npc_woda_pig" and creepname ~= "npc_woda_frog" then
                unit:AddNewModifier(unit, nil, "modifier_wodacreepchampion", {})
                unit.champion_blue = true
            end
            table.insert(ARENA_CREEPSTABLE, unit)
        end
	end
end

function arena_system:GetArena()
	return CURRENT_ARENA - 1
end

function arena_system:GetCurrentArena()
	return CURRENT_ARENA
end

function arena_system:DuelActive()
	return DUEL_ACTIVE 
end

function arena_system:woda_select_duel_player(data)
	local predict_id = data.player_id
	local self_id = data.PlayerID
    print("дуэль активирована уже", arena_system:DuelActive())
    if DUEL_STARTED then return end
    if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
        DUEL_PREDICT_PLAYERS[self_id] = data.team
    else
	    DUEL_PREDICT_PLAYERS[self_id] = predict_id
    end
end

function arena_system:SetMinimapAll()
	local map = MINIMAP_TABLES[CURRENT_MINIMAP]
	CustomNetTables:SetTableValue("map_info",  "map_coord", {x=map[1], y=map[2]})
	CustomGameEventManager:Send_ServerToAllClients( 'set_map_change_woda', {x=map[1], y=map[2]})
end

function arena_system:SetMinimapPlayer(id, state)
	local map = {}
	if state == 1 then
		map = MINIMAP_TABLES[1]
	elseif state == 2 then
		map = MINIMAP_TABLES[8]
	elseif state == 3 then
		map = MINIMAP_TABLES[9]
	else
		map = MINIMAP_TABLES[CURRENT_MINIMAP]
	end
	if PlayerResource:GetPlayer(id) then 
		CustomGameEventManager:Send_ServerToPlayer( PlayerResource:GetPlayer(id), "set_map_change_woda", {x=map[1], y=map[2]})
	end
end

function arena_system:SetMinimapForAllChoose(state)
	local map = {}
	if state == 1 then
		map = MINIMAP_TABLES[1]
	elseif state == 2 then
		map = MINIMAP_TABLES[8]
	elseif state == 3 then
		map = MINIMAP_TABLES[9]
	else
		map = MINIMAP_TABLES[CURRENT_MINIMAP]
	end
	CustomNetTables:SetTableValue("map_info", "map_coord", {x=map[1], y=map[2]})
	CustomGameEventManager:Send_ServerToAllClients( 'set_map_change_woda', {x=map[1], y=map[2]})
end

function arena_system:OnTeamKillCredit( event )
	if GetMapName() == "overthrow" then
		arena_system:AddScoreToTeam( event.teamnumber, 1 )
	end
end

function arena_system:GetMaxPlayersMode()
    if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
        return 8
    end
    return 7
end