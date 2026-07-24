--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



if talents_values == nil then 
    _G.talents_values = class({})
end

function talents_values:InitGameMode()
CustomGameEventManager:RegisterListener( "RequestTalents", Dynamic_Wrap(self, 'RequestTalents'))
CustomGameEventManager:RegisterListener( "RequestPickRates", Dynamic_Wrap(self, 'RequestPickRates'))

end

function talents_values:RequestTalents(data)
if data.PlayerID == nil then return end

print('RequestTalents')
CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(data.PlayerID) , "SendNewTalentSystem", new_talent_system)
talents_values:SendTalents(data.PlayerID)
end

function talents_values:SendPickRates(data)
pickrate_talents = data
CustomGameEventManager:Send_ServerToAllClients("SendPickRates", pickrate_talents)
end

function talents_values:RequestPickRates(data)
if data.PlayerID == nil then return end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(data.PlayerID) , "SendPickRates", pickrate_talents)
end

talents_icons =
{

}

active_talents =
{

}


talents_heroes =
{

}

perma_mods =
{

}

ingame_talents =
{

}


pickrate_talents = 
{

}


function talents_values:SendTalents(client_id, hero_name, test_skill, more_test_skills)

local global_values = 
{
    general = 
    {
        ["modifier_up_primary"] = 
        {
            skill_icon = "Possessed_Mask",
            rarity = "gray",
            exception = {"only_normal"},

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 4,
        },
        ["modifier_up_health"] = 
        {
            skill_icon = "Vitality_Booster",
            rarity = "gray",

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 100,
        },
        ["modifier_up_damage"] = 
        {
            skill_icon = "Broadsword",
            rarity = "gray",

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 10,
        },
        ["modifier_up_armor"] = 
        {
            skill_icon = "Chainmail",
            rarity = "gray",

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 4,
        },
        ["modifier_up_secondary"] = 
        {
            skill_icon = "Pupil_Gift",
            rarity = "gray",
            exception = {"only_normal"},

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 3,
        },
        ["modifier_up_spelldamage"] = 
        {
            skill_icon = "Kaya",
            rarity = "gray",
            exception = {"mage"},

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 2,
        },
        ["modifier_up_movespeed"] = 
        {
            skill_icon = "Boots_of_Speed",
            rarity = "gray",

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 10,
        },
        ["modifier_up_evasion"] = 
        {
            skill_icon = "Talisman_of_Evasion",
            rarity = "gray",

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 6,
        },
        ["modifier_up_lifesteal"] = 
        {
            skill_icon = "Morbid_Mask",
            rarity = "gray",

            damage_info = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 6,
        },
        ["modifier_up_speed"] = 
        {
            skill_icon = "Gloves_of_Haste",
            rarity = "gray",

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 10,
        },
        ["modifier_up_spellsteal"] = 
        {
            skill_icon = "Voodoo_Mask",
            rarity = "gray",
            exception = {"mage"},

            damage_info = 1,
            creeps = 3,
            update_mod = "modifier_general_stats",
            general_bonus = 5,
        },
        ["modifier_up_statusresist"] = 
        {
            skill_icon = "Titan_Sliver",
            rarity = "gray",

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 5,
        },
        ["modifier_up_cleave"] = 
        {
            skill_icon = "Battle_Fury",
            rarity = "gray",
            exception = {"melle"},

            update_mod = "modifier_general_stats",
            general_bonus = 10,
        },
        ["modifier_up_magicresist"] = 
        {
            skill_icon = "Cloak",
            rarity = "gray",

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 4,
        },
        ["modifier_up_javelin"] = 
        {
            skill_icon = "Javelin",
            rarity = "gray",

            damage = 20,
            update_mod = "modifier_general_stats",
            allow_illusion = 1,
            general_bonus = 15,
        },
        ["modifier_up_creeps"] = 
        {
            skill_icon = "Quelling_Blade",
            rarity = "gray",

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 10,
        },
        ["modifier_up_manaregen"] = 
        {
            skill_icon = "Voidstone",
            rarity = "gray",

            update_mod = "modifier_general_stats",
            general_bonus = 3,
        },
        ["modifier_up_allstats"] = 
        {
            skill_icon = "circlet",
            rarity = "gray",
            exception = {"only_all"},

            allow_illusion = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 2,
        },
        ["modifier_up_ignore_armor"] = 
        {
            skill_icon = "blight",
            rarity = "gray",

            update_mod = "modifier_general_stats",
            general_bonus = 1,
            duration = 4,
        },
        ["modifier_up_aoe_damage"] = 
        {
            skill_icon = "dragon",
            rarity = "gray",

            radius = 500,
            damage_info = 1,
            update_mod = "modifier_general_stats",
            general_bonus = 12,
        },


        ["modifier_up_slow"] = 
        {
            skill_icon = "Penta-Edged_Sword",
            rarity = "blue",

            attack_slow = {-30, -45, -60},
            move_slow = {-20, -30, -40},
            is_purgable_self = 1,
            duration = 4,
            update_mod = "modifier_general_stats",
            chance = 25,
        },
        ["modifier_up_gainprimary"] = 
        {
            skill_icon = "Crown",
            rarity = "blue",
            exception = {"only_normal"},

            stats = {8, 12, 16},
            update_mod = "modifier_general_stats",
            allow_illusion = 1,
        },
        ["modifier_up_gainsecondary"] = 
        {
            skill_icon = "Ocean_Heart",
            rarity = "blue",
            exception = {"only_normal"},

            stats = {8, 12, 16},
            update_mod = "modifier_general_stats",
            allow_illusion = 1,
        },
        ["modifier_up_magicblock"] = 
        {
            skill_icon = "Hood_of_Defiance",
            rarity = "blue",

            cd = 10,
            damage_info = 1,
            update_mod = "modifier_general_stats",
            block = {200, 400, 600},
        },
        ["modifier_up_attackblock"] = 
        {
            skill_icon = "Crimson_Guard",
            rarity = "blue",

            cd = 10,
            damage_info = 1,
            update_mod = "modifier_general_stats",
            block = {200, 400, 600},
        },
        ["modifier_up_cooldown"] = 
        {
            skill_icon = "Octarine_Core",
            rarity = "blue",

            cdr = {6, 9, 12},
            update_mod = "modifier_general_stats",
        },
        ["modifier_up_stun"] = 
        {
            skill_icon = "vest",
            rarity = "blue",

            update_mod = "modifier_general_stats",
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_up_root"] = 
        {
            skill_icon = "earthbind",
            rarity = "blue",
            alt_panel = 1,

            cd = 15,
            update_mod = "modifier_general_stats",
            is_purgable_self = 1,
            duration = {1, 1.5, 2},
        },
        ["modifier_up_bigdamage"] = 
        {
            skill_icon = "Defend_Matrix",
            rarity = "blue",
            alt_panel = 1,

            cd = 40,
            update_mod = "modifier_general_stats",
            duration = 3,
            damage_reduce = {-10, -20, -30},
            health = 30,
            regen = {10, 15, 20},
        },
        ["modifier_up_venom"] = 
        {
            skill_icon = "venom",
            rarity = "blue",

            update_mod = "modifier_general_stats",
            heal_reduce = {-15, -25, -35},
            health = 40,
            duration = 2,
        },
        ["modifier_up_range"] = 
        {
            skill_icon = "dragon_lance",
            rarity = "blue",

            cast_range = {100, 150, 200},
            update_mod = "modifier_general_stats",
            allow_illusion = 1,
            attack_range = {50, 75, 100},
        },
        ["modifier_up_gainall"] = 
        {
            skill_icon = "Crown",
            rarity = "blue",
            exception = {"only_all"},

            stats = {5, 7.5, 10},
            update_mod = "modifier_general_stats",
            allow_illusion = 1,
        },
        ["modifier_up_teamfight"] = 
        {
            skill_icon = "Martyr",
            rarity = "blue",

            update_mod = "modifier_general_stats",
            radius = 800,
            damage_bonus = {10, 15, 20},
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_up_random_gray"] = 
        {
            skill_icon = "Gray",
            rarity = "blue",

            count = 3,
            general_trigger = 1,
        },


        ["modifier_up_primaryupgrade"] = 
        {
            skill_icon = "Apex",
            rarity = "purple",
            exception = {"only_normal"},

            allow_illusion = 1,
            int = 20,
            agi = 10,
            str = 10,
            percent = 1,
        },
        ["modifier_up_secondaryupgrade"] = 
        {
            skill_icon = "Ultimate_Orb",
            rarity = "purple",
            exception = {"only_normal"},

            allow_illusion = 1,
            int = 20,
            agi = 10,
            str = 10,
            percent = 1,
        },
        ["modifier_up_allupgrade"] = 
        {
            skill_icon = "Apex",
            rarity = "purple",
            exception = {"only_all"},

            allow_illusion = 1,
            all = 60,
            int = 20,
            agi = 10,
            str = 10,
            percent = 0.6,
        },
        ["modifier_up_graypoints"] = 
        {
            skill_icon = "Gray",
            rarity = "purple",

            count = 1,
            bonus = 30,
            allow_illusion = 1,
        },
        ["modifier_up_bluepoints"] = 
        {
            skill_icon = "Blue",
            rarity = "purple",

            count = 4,
            general_trigger = 1,
        },
        ["modifier_up_res"] = 
        {
            skill_icon = "Phoenix_Ash",
            rarity = "purple",
            alt_panel = 1,

            damage_info = 1,    
            heal = 20,
            radius = 500,
            cd = 4,
            invun = 0.2,
            stun = 1.5,
            update_mod = "modifier_general_stats"
        },
        ["modifier_up_damagestack"] = 
        {
            skill_icon = "Timeless_Relic",
            rarity = "purple",

            damage = 1,
            radius = 800,
            max = 20,
            duration = 3,
        },

    },


    patrol = 
    {
        ["modifier_patrol_reward_orb"] = 
        {
            rarity = "blue",
            skill_icon = "restrained_orb",
            patrol_1 = 1,
            blue = 100,
            gold = 100,
        },
        ["modifier_patrol_reward_contract"] =
        {
            rarity = "blue",
            skill_icon = "contract",
            patrol_1 = 1,

            duration = 50,
        },
        ["modifier_patrol_reward_ward"] =
        {
            rarity = "blue",
            skill_icon = "Wards",
            patrol_1 = 1,
            
            duration = 120,
            radius = 700,
            max = 3,
            gold = 50,
        },
        ["modifier_patrol_reward_gold"] =
        {
            rarity = "blue",
            skill_icon = "patrol_midas",
            patrol_1 = 1,
            
            duration = 70,
            gold = 25,
        },
        ["modifier_patrol_reward_shield"] =
        {
            rarity = "blue",
            skill_icon = "patrol_shield",
            patrol_1 = 1,
            
            duration = 70,
            shield = 60,
            delay = 6,
            regen = 20,
        },

        ["modifier_patrol_reward_gem"] = 
        {
            rarity = "purple",
            skill_icon = "Third_Eye",
            patrol_2 = 1,
            
            radius = 4000,
            duration = 120
        },
        ["modifier_patrol_reward_buff"] = 
        {
            rarity = "purple",
            skill_icon = "patrol_empower",
            patrol_2 = 1,
            
            duration = 120,
            damage_inc = -15,
            damage_out = 15,
        },
        ["modifier_patrol_reward_necro"] = 
        {
            rarity = "purple",
            skill_icon = "patrol_necro",
            patrol_2 = 1,
            
            count = 2,
            timer = 5,
        },
        ["modifier_patrol_reward_fortifier"] =
        {
            rarity = "purple",
            skill_icon = "patrol_fortifier",
            patrol_2 = 1,
            
            shield = 2,
            duration = 2,
            slow = -30,
        },
        ["modifier_patrol_reward_portal"] =
        {
            rarity = "purple",
            skill_icon = "warp_amulet",
            patrol_2 = 1,
            
            cd = 5,
            cast = 2.5,
            duration = 120,
            push_duration = 5,
        }
    },

    invoker_spells =
    {
        ["modifier_invoker_spells_1"] = 
        {
            mini_icon = "coldsnap",
            skill_icon = "coldsnap",
            rarity = "blue",
            max_level = 1,
            skill_number = 5,

            stun_cd = -0.05,
            max = 80,
        },
        ["modifier_invoker_spells_2"] = 
        {
            mini_icon = "forge",
            skill_icon = "forge",
            rarity = "blue",
            max_level = 1,
            skill_number = 5,

            count = 1,
            bonus = 35,
            armor = -8,
            radius = 900,
            max = 120,
        },
        ["modifier_invoker_spells_3"] = 
        {
            mini_icon = "tornado",
            skill_icon = "tornado",
            rarity = "blue",
            max_level = 1,
            skill_number = 5,

            duration = 2,
            timer = 4,
            max = 15000,
        },
        ["modifier_invoker_spells_4"] = 
        {
            mini_icon = "deafing",
            skill_icon = "deafing",
            rarity = "blue",
            max_level = 1,
            skill_number = 5,

            spell = 10,
            cdr = 8,
            cd = -8,
            max = 100,
        },
    },

    muerta_quest =
    {
        ["modifier_muerta_quest_1"] = 
        {
            item = "item_muerta_shovel_custom",
            max = 3,
            radius = 500,
        },
        ["modifier_muerta_quest_2"] = 
        {
            item = "item_muerta_mercy_custom",
            max = 3,
        },
        ["modifier_muerta_quest_3"] = 
        {
            item = "item_muerta_mercy_and_grace_custom",
            max = 6,
        },
        ["modifier_muerta_quest_4"] = 
        {
            item = "item_muerta_mercy_and_grace_full_custom",
            max = 1,
        },
    },

    broodmother_spiders =
    {
        ["modifier_broodmother_scepter_1"] =
        {
            mini_icon = "brood_scepter_1",
            skill_icon = "spawn",
            rarity = "blue",
            max_level = 3,

            gold = {4, 6, 8},
        },
        ["modifier_broodmother_scepter_2"] =
        {
            mini_icon = "brood_scepter_2",
            skill_icon = "spawn",
            rarity = "blue",
            max_level = 3,

            damage_reduce = {-2, -3, -4},
            max = 10,
        },
        ["modifier_broodmother_scepter_3"] =
        {
            mini_icon = "brood_scepter_3",
            skill_icon = "spawn",
            rarity = "blue",
            max_level = 3,

            move = {40, 60, 80},
            max_move = {590, 610, 630},
        },
        ["modifier_broodmother_scepter_4"] =
        {
            mini_icon = "brood_scepter_4",
            skill_icon = "spawn",
            rarity = "blue",
            max_level = 3,

            damage = {10, 15, 20}
        },
        ["modifier_broodmother_scepter_5"] =
        {
            mini_icon = "brood_scepter_5",
            skill_icon = "spawn",
            rarity = "blue",
            max_level = 3,

            health = {4, 6, 8},
        },
        ["modifier_broodmother_scepter_6"] =
        {
            mini_icon = "brood_scepter_6",
            skill_icon = "spawn",
            rarity = "blue",
            max_level = 3,

            chance = {2, 3, 4},
            max = {2, 3, 4},
        },
        ["modifier_broodmother_scepter_7"] =
        {
            mini_icon = "brood_scepter_7",
            skill_icon = "spawn",
            rarity = "purple",
            max_level = 1,

            damage = 100,
            radius = 900,
            speed = 10,
        },
        ["modifier_broodmother_scepter_8"] =
        {
            mini_icon = "brood_scepter_8",
            skill_icon = "spawn",
            rarity = "purple",
            max_level = 1,
            
            spell = 15,
            damage = 15,
            radius = 300,
            damage_info = 1,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_broodmother_scepter_9"] =
        {
            mini_icon = "brood_scepter_9",
            skill_icon = "spawn",
            rarity = "purple",
            max_level = 1,

            duration = 10,
            invun = 2,
            chance = 50,
        }
    },

    alchemist_items = 
    {
        ["modifier_recipe_gold_skadi"] =
        {
            rarity = "purple",
            skill_icon = "gold_skadi",

            type = 1
        },
        ["modifier_recipe_gold_heart"] =
        {
            rarity = "purple",
            skill_icon = "gold_heart",

            type = 2
        },
        ["modifier_recipe_gold_assault"] =
        {
            rarity = "purple",
            skill_icon = "gold_assault",

            type = 1
        },
        ["modifier_recipe_gold_octarine"] =
        {
            rarity = "purple",
            skill_icon = "gold_octarine",

            type = 2
        },
        ["modifier_recipe_gold_daedalus"] =
        {
            rarity = "purple",
            skill_icon = "gold_crit",

            type = 1
        },
        ["modifier_recipe_gold_khanda"] =
        {
            rarity = "purple",
            skill_icon = "gold_seal",

            type = 2,
        },
        ["modifier_recipe_gold_shiva"] =
        {
            rarity = "purple",
            skill_icon = "gold_shiva",

            type = 2,
        },
        ["modifier_recipe_gold_satanic"] =
        {
            rarity = "purple",
            skill_icon = "gold_satanic",

            type = 1,
        },
    },


    npc_dota_hero_juggernaut = 
    {
        ["modifier_juggernaut_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            health = {4, 6, 8},
            stats = {6, 9, 12},
        },
        ["modifier_juggernaut_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            magic = {6, 9, 12},
            status = {6, 9, 12},
            bonus = 2,
            duration = 2,
        },
        ["modifier_juggernaut_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            move = {30, 45, 60},
            slow = {-20, -30, -40},
            duration = 3,
            is_purgable_self = 1,
            is_through_bkb = 1,
        },
        ["modifier_juggernaut_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            duration = 1,
            damage_reduce = -35,
        },
        ["modifier_juggernaut_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            stun = 1.5,
            invun = 1.5,
            invun_legendary = 1,
            heal = 3,
            alt_talent = "modifier_juggernaut_healingward_7",
        },
        ["modifier_juggernaut_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            talent_cd = 14,
            cd_inc = -0.5,
            shield = 10,
            base = 250,
        },

        ["modifier_juggernaut_bladefury_1"] = 
        {
            skill_number = 1,
            mini_icon = "Blade_fury_1",
            skill_icon = "Blade_Fury",
            rarity = "blue",

            damage = {30, 45, 60},
            heal = {10, 15, 20},
        },
        ["modifier_juggernaut_bladefury_2"] = 
        {
            skill_number = 1,
            mini_icon = "Blade_fury_2",
            skill_icon = "Blade_Fury",
            rarity = "blue",

            cd = {-2, -3, -4},
            radius = {30, 45, 60},
        },
        ["modifier_juggernaut_bladefury_3"] = 
        {
            skill_number = 1,
            mini_icon = "Blade_fury_3",
            skill_icon = "Blade_Fury",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal_reduce = {-25, -40},
            magic = {-25, -40},
            max = 8,
            duration = 8,
        },
        ["modifier_juggernaut_bladefury_4"] = 
        {
            skill_number = 1,
            mini_icon = "Blade_fury_4",
            skill_icon = "Blade_Fury",
            rarity = "purple",
            has_video = 1,

            slow = -50,
            is_purgable_self = 1,
        },
        ["modifier_juggernaut_bladefury_7"] = 
        {
            skill_number = 1,
            mini_icon = "Blade_Fury",
            skill_icon = "Blade_Fury",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            speed = 1500,
            talent_cd = 10,
            timer = 1.5,
            max = 25,
            damage = 4,
            cd_inc = -2,
            duration = 3,
            stack_init = 20,
            skill_name = "custom_juggernaut_blade_fury",
            trigger_ability = "custom_juggernaut_whirling_blade_custom",
        },
        ["modifier_juggernaut_healingward_1"] = 
        {
            skill_number = 2,
            mini_icon = "Healing_ward_1",
            skill_icon = "Healing_Ward",
            rarity = "blue",

            spell = {6, 9, 12},
            damage = {1, 1.5, 2},
        },
        ["modifier_juggernaut_healingward_2"] = 
        {
            skill_number = 2,
            mini_icon = "Healing_ward_2",
            skill_icon = "Healing_Ward",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = {1, 1.5, 2},
            duration_legendary = {0.6, 0.9, 1.2},
            alt_talent = "modifier_juggernaut_healingward_7",
        },
        ["modifier_juggernaut_healingward_3"] = 
        {
            skill_number = 2,
            mini_icon = "Healing_ward_3",
            skill_icon = "Healing_Ward",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            chance = 40,
            chance_fury = 20,
            damage = {60, 100},
            heal = 100,
        },
        ["modifier_juggernaut_healingward_4"] = 
        {
            skill_number = 2,
            mini_icon = "Healing_ward_4",
            skill_icon = "Healing_Ward",
            rarity = "purple",

            cdr = 12,
            mana = 3,
            cd_items = 50,
        },
        ["modifier_juggernaut_healingward_7"] = 
        {
            skill_number = 2,
            mini_icon = "Healing_Ward",
            skill_icon = "Healing_Ward",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            duration = 4,
            cd_inc = -25,
            damage = 35,
            damage_type = DAMAGE_TYPE_MAGICAL,
            skill_name = "custom_juggernaut_healing_ward",
        },
        ["modifier_juggernaut_bladedance_1"] = 
        {
            skill_number = 3,
            mini_icon = "Blade_dance_1",
            skill_icon = "Blade_Dance",
            rarity = "blue",

            speed = {20, 30, 40},
            chance = {6, 9, 12},
        },
        ["modifier_juggernaut_bladedance_2"] = 
        {
            skill_number = 3,
            mini_icon = "Blade_dance_2",
            skill_icon = "Blade_Dance",
            rarity = "blue",

            range = {50, 75, 100},
            cleave = {20, 30, 40},
            allow_illusion = 1,
        },
        ["modifier_juggernaut_bladedance_3"] = 
        {
            skill_number = 3,
            mini_icon = "Blade_dance_3",
            skill_icon = "Blade_Dance",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            agi = {8, 15},
            attacks = 4,
            speed = 0.8,
            damage = {50, 80},
            duration = 7,
            move = 550,
        },
        ["modifier_juggernaut_bladedance_4"] = 
        {
            skill_number = 3,
            mini_icon = "Blade_dance_4",
            skill_icon = "Blade_Dance",
            rarity = "purple",
            has_video = 1,

            heal = 20,
            bonus = 2,
            armor = 15,
            duration = 2,
        },
        ["modifier_juggernaut_bladedance_7"] = 
        {
            skill_number = 3,
            mini_icon = "Blade_Dance",
            skill_icon = "Blade_Dance",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            status = 20,
            damage = 15,
            damage_max = 600,
            blade_fury = 2,
            duration = 4,
            talent_cd = 12,
            skill_name = "custom_juggernaut_blade_dance",
        },
        ["modifier_juggernaut_omnislash_1"] = 
        {
            skill_number = 4,
            mini_icon = "Omnislash_1",
            skill_icon = "Omnislash",
            rarity = "blue",

            damage = {10, 15, 20},
            max = 4,
            duration = 8,
        },
        ["modifier_juggernaut_omnislash_2"] = 
        {
            skill_number = 4,
            mini_icon = "Omnislash_2",
            skill_icon = "Omnislash",
            rarity = "blue",

            range = {80, 120, 160},
            cd = {-2, -3, -4},
        },
        ["modifier_juggernaut_omnislash_3"] = 
        {
            skill_number = 4,
            mini_icon = "Omnislash_3",
            skill_icon = "Omnislash",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            armor = {15, 25},
            chance = 50,
            min = 1,
            max = 4,
            damage = {40, 60},
            interval = 0.4,
        },
        ["modifier_juggernaut_omnislash_4"] = 
        {
            skill_number = 4,
            mini_icon = "Omnislash_4",
            skill_icon = "Omnislash",
            rarity = "purple",
            has_video = 1,

            move = 600,
            duration = 1.5,
            root = 1.5,
            cast = -0.2,
        },
        ["modifier_juggernaut_omnislash_7"] = 
        {
            skill_number = 4,
            mini_icon = "Omnislash",
            skill_icon = "Omnislash",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            cd_inc = 10,
            distance = 320,
            damage = 30,
            duration = 15,
            bva = 0.4,
            damage_type = DAMAGE_TYPE_PURE,
            skill_name = "custom_juggernaut_omnislash",
        },
    },

    npc_dota_hero_phantom_assassin = 
    {
        ["modifier_phantom_assassin_dagger_1"] = 
        {
            skill_number = 1,
            mini_icon = "Stifling_Dagger_1",
            skill_icon = "Stifling_Dagger",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            cast = {-0.1, -0.15, -0.2},
        },
        ["modifier_phantom_assassin_dagger_2"] = 
        {
            skill_number = 1,
            mini_icon = "Stifling_Dagger_2",
            skill_icon = "Stifling_Dagger",
            rarity = "blue",

            move = {4, 6, 8},
            max = 3,
            heal = {8, 12, 16},
            duration = 8,
        },
        ["modifier_phantom_assassin_dagger_3"] = 
        {
            skill_number = 1,
            mini_icon = "Stifling_Dagger_3",
            skill_icon = "Stifling_Dagger",
            rarity = "blue",
            has_video = 1,

            damage = {40, 60, 80},
            is_purgable_self = 1,
            bonus = 3,
            duration = 8,
        },
        ["modifier_phantom_assassin_dagger_4"] = 
        {
            skill_number = 1,
            mini_icon = "Stifling_Dagger_4",
            skill_icon = "Stifling_Dagger",
            rarity = "purple",
            main_epic = 1,

            chance = {30, 50},
            radius = 1000,
            delay = 0.3,
            cdr = {8, 12},
        },
        ["modifier_phantom_assassin_dagger_5"] = 
        {
            skill_number = 1,
            mini_icon = "Stifling_Dagger_5",
            skill_icon = "Stifling_Dagger",
            rarity = "purple",

            range = 150,
            duration = 10,
        },
        ["modifier_phantom_assassin_dagger_6"] = 
        {
            skill_number = 1,
            mini_icon = "Stifling_Dagger_6",
            skill_icon = "Stifling_Dagger",
            rarity = "purple",

            cd = 15,
            duration = 1.8,
            damage_reduce = -50,
            status = 50,
        },
        ["modifier_phantom_assassin_dagger_7"] = 
        {
            skill_number = 1,
            mini_icon = "Stifling_Dagger",
            skill_icon = "Stifling_Dagger",
            rarity = "orange",

            stack_max = 5,
            cd = 15,
            trigger_ability = "custom_phantom_assassin_stifling_dagger",
            cast_inc = -0.4,
            skill_name = "custom_phantom_assassin_stifling_dagger",
            cast = 2.8,
            timer = 10,
            max = 8,
        },
        ["modifier_phantom_assassin_blink_1"] = 
        {
            skill_number = 2,
            mini_icon = "Phantom_Strike_1",
            skill_icon = "Phantom_Strike",
            rarity = "blue",

            duration = 2,
            range = {100, 150, 200},
            slow = {-15, -25, -35},
        },
        ["modifier_phantom_assassin_blink_2"] = 
        {
            skill_number = 2,
            mini_icon = "Phantom_Strike_2",
            skill_icon = "Phantom_Strike",
            rarity = "blue",

            agi = {10, 15, 20},
            allow_illusion = 1,
            duration = {0.5, 1, 1.5},
        },
        ["modifier_phantom_assassin_blink_3"] = 
        {
            skill_number = 2,
            mini_icon = "Phantom_Strike_3",
            skill_icon = "Phantom_Strike",
            rarity = "blue",

            allow_illusion = 1,
            is_purgable = 1,
            health = {1.5, 2, 2.5},
            shield = {100, 175, 250},
        },
        ["modifier_phantom_assassin_blink_4"] = 
        {
            skill_number = 2,
            mini_icon = "Phantom_Strike_4",
            skill_icon = "Phantom_Strike",
            rarity = "purple",
            main_epic = 1,

            damage = {80, 130},
            is_through_bkb = 1,
            heal = 75,
            radius = 300,
            max = 5,
        },
        ["modifier_phantom_assassin_blink_5"] = 
        {
            skill_number = 2,
            mini_icon = "Phantom_Strike_5",
            skill_icon = "Phantom_Strike",
            rarity = "purple",
            has_video = 1,

            cd = -1,
            duration = 2,
            slow = -50,
        },
        ["modifier_phantom_assassin_blink_6"] = 
        {
            skill_number = 2,
            mini_icon = "Phantom_Strike_6",
            skill_icon = "Phantom_Strike",
            rarity = "purple",

            is_root_disabled = 1,
            range = 35,
            move = 25,
            allow_illusion = 1,
            duration = 1,
        },
        ["modifier_phantom_assassin_blink_7"] = 
        {
            skill_number = 2,
            mini_icon = "Phantom_Strike",
            skill_icon = "Phantom_Strike",
            rarity = "orange",

            damage = 10,
            incoming = 600,
            agi_duration_creeps = 5,
            radius = 1000,
            trigger_ability = "custom_phantom_assassin_phantom_strike",
            agi_duration_heroes = 12,
            duration = 4,
            agi = 50,
            skill_name = "custom_phantom_assassin_phantom_strike",
            max = 80,
        },
        ["modifier_phantom_assassin_blur_1"] = 
        {
            skill_number = 3,
            mini_icon = "Blur_1",
            skill_icon = "Blur",
            rarity = "blue",

            evasion = {8, 12, 16},
            delay = {0.4, 0.6, 0.8},
        },
        ["modifier_phantom_assassin_blur_2"] = 
        {
            skill_number = 3,
            mini_icon = "Blur_2",
            skill_icon = "Blur",
            rarity = "blue",

            speed = {10, 15, 20},
            heal = {10, 15, 20},
            duration = 4,
        },
        ["modifier_phantom_assassin_blur_3"] = 
        {
            skill_number = 3,
            mini_icon = "Blur_3",
            skill_icon = "Blur",
            rarity = "blue",

            speed = {20, 30, 40},
            bonus = 2,
            duration = 4,
        },
        ["modifier_phantom_assassin_blur_4"] = 
        {
            skill_number = 3,
            mini_icon = "Blur_4",
            skill_icon = "Blur",
            rarity = "purple",
            main_epic = 1,

            damage = {4, 6},
            effect_duration = 8,
            slow = {-30, -50},
            radius = 360,
            duration = 6,
            max = 5,
        },
        ["modifier_phantom_assassin_blur_5"] = 
        {
            skill_number = 3,
            mini_icon = "Blur_5",
            skill_icon = "Blur",
            rarity = "purple",

            distance = 300,
            range = 80,
            effect_duration = 3,
            stun = 1.2,
            bonus = 2,
            duration = 0.2,
        },
        ["modifier_phantom_assassin_blur_6"] = 
        {
            skill_number = 3,
            mini_icon = "Blur_6",
            skill_icon = "Blur",
            rarity = "purple",

            cd_items = 3,
            cd_inc = -0.4,
            duration = 1,
        },
        ["modifier_phantom_assassin_blur_7"] = 
        {
            skill_number = 3,
            mini_icon = "Blur",
            skill_icon = "Blur",
            rarity = "orange",

            damage = 8,
            max_creeps = 150,
            skill_name = "custom_phantom_assassin_blur",
            radius = 360,
            evasion = 70,
            duration = 6,
        },
        ["modifier_phantom_assassin_crit_1"] = 
        {
            skill_number = 4,
            mini_icon = "Coup_de_Grace_1",
            skill_icon = "Coup_de_Grace",
            rarity = "blue",

            damage = {20, 30, 40},
            allow_illusion = 1,
            chance = {4, 6, 8},
            duration = 4,
        },
        ["modifier_phantom_assassin_crit_2"] = 
        {
            skill_number = 4,
            mini_icon = "Coup_de_Grace_2",
            skill_icon = "Coup_de_Grace",
            rarity = "blue",

            heal = {8, 12, 16},
            allow_illusion = 1,
            bonus = 2,
            creeps = 3,
        },
        ["modifier_phantom_assassin_crit_3"] = 
        {
            skill_number = 4,
            mini_icon = "Coup_de_Grace_3",
            skill_icon = "Coup_de_Grace",
            rarity = "blue",

            is_through_bkb = 1,
            duration = 4,
            heal_reduce = {-15, -20, -25},
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_phantom_assassin_crit_4"] = 
        {
            skill_number = 4,
            mini_icon = "Coup_de_Grace_4",
            skill_icon = "Coup_de_Grace",
            rarity = "purple",
            main_epic = 1,

            armor = -1,
            is_through_bkb = 1,
            max = {10, 18},
            crit_stack = 3,
            duration = 6,
        },
        ["modifier_phantom_assassin_crit_5"] = 
        {
            skill_number = 4,
            mini_icon = "Coup_de_Grace_5",
            skill_icon = "Coup_de_Grace",
            rarity = "purple",
            has_video = 1,

            silence = 2.5,
            is_through_bkb = 1,
            cd = 15,
            slow = -150,
        },
        ["modifier_phantom_assassin_crit_6"] = 
        {
            skill_number = 4,
            mini_icon = "Coup_de_Grace_6",
            skill_icon = "Coup_de_Grace",
            rarity = "purple",

            status = 20,
            duration = 10,
            shield = 7,
            max = 3,
        },
        ["modifier_phantom_assassin_crit_7"] = 
        {
            skill_number = 4,
            mini_icon = "Coup_de_Grace",
            skill_icon = "Coup_de_Grace",
            rarity = "orange",

            damage = 15,
            cd = 40,
            range = 700,
            max = 10,
            skill_name = "custom_phantom_assassin_coup_de_grace",
            delay = 10,
            bva = 1.5,
            duration = 90,
        },
    },

    npc_dota_hero_huskar = 
    {
        ["modifier_huskar_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            heal_inc = {6, 9, 12},
            heal_reduce = {-2, -3, -4},
            max = 6,
        },
        ["modifier_huskar_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            armor = {8, 12, 16},
            magic = {8, 12, 16},
        },
        ["modifier_huskar_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            str = {6, 9, 12},
            heal = {30, 45, 60},
            duration = 5,
        },
        ["modifier_huskar_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            status = 12,
            cast = 0,
            shield = 20,
            base = 100,
            duration = 5,
        },
        ["modifier_huskar_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",

            health = 10,
            mana = 20,
        },
        ["modifier_huskar_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            cast = -0.2,
            health = 40,
            taunt = 2,
            talent_cd = 10,
            is_through_bkb = 1,
        },

        ["modifier_huskar_disarm_1"] = 
        {
            skill_number = 1,
            mini_icon = "Inner_Fire_1",
            skill_icon = "Inner_Fire",
            rarity = "blue",

            damage = {6, 9, 12},
            spell = {8, 12, 16},
        },
        ["modifier_huskar_disarm_2"] = 
        {
            skill_number = 1,
            mini_icon = "Inner_Fire_2",
            skill_icon = "Inner_Fire",
            rarity = "blue",

            cd = {-2, -3, -4},
            damage_reduce = {-12, -18, -24},
        },
        ["modifier_huskar_disarm_3"] = 
        {
            skill_number = 1,
            mini_icon = "Inner_Fire_3",
            skill_icon = "Inner_Fire",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            cdr = {12, 20},
            duration = 8,
            max = 5,
            legendary_stack = 3,
            damage = {6, 10},
            interval = 1,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_huskar_disarm_4"] = 
        {
            skill_number = 1,
            mini_icon = "Inner_Fire_4",
            skill_icon = "Inner_Fire",
            rarity = "purple",
            has_video = 1,

            silence = 1,
            range = 800,
            leash = 2,
            knock_duration = 0.2,
            knock_dist = 200,
            radius = 450,
        },
        ["modifier_huskar_disarm_7"] = 
        {
            skill_number = 1,
            mini_icon = "Inner_Fire",
            skill_icon = "Inner_Fire",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            interval = 1,
            count = 3,
            damage = 20,
            magic = -10,
            duration = 10,
            max = 8,
            health = 8,
            knock_distance = 100,
            knock_duration = 0.2,
            skill_name = "custom_huskar_inner_fire",
        },
        ["modifier_huskar_spears_1"] = 
        {
            skill_number = 2,
            mini_icon = "Burning_Spears_1",
            skill_icon = "Burning_Spears",
            rarity = "blue",

            speed = {6, 9, 12},
            duration = 5,
            max = 10,
        },
        ["modifier_huskar_spears_2"] = 
        {
            skill_number = 2,
            mini_icon = "Burning_Spears_2",
            skill_icon = "Burning_Spears",
            rarity = "blue",

            range = {180, 240, 320},
            move = {30, 45, 60},
        },
        ["modifier_huskar_spears_3"] = 
        {
            skill_number = 2,
            mini_icon = "Burning_Spears_3",
            skill_icon = "Burning_Spears",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            chance = {20, 35},
            damage = 75,
            delay = 0.25,
            slow = -100,
            duration = 1,
            knock_range = 50
        },
        ["modifier_huskar_spears_4"] = 
        {
            skill_number = 2,
            mini_icon = "Burning_Spears_4",
            skill_icon = "Burning_Spears",
            rarity = "purple",
            has_video = 1,

            talent_cd = 10,
            max = 8,
            slow = -5,
            fear = 1.5,
        },
        ["modifier_huskar_spears_7"] = 
        {
            skill_number = 2,
            mini_icon = "Burning_Spears",
            skill_icon = "Burning_Spears",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            duration = 6,
            damage_inc = 30,
            damage = 1,
            slow = -40,
            damage_creeps = 20,
            talent_cd = 7,
            is_through_bkb = 1,
            skill_name = "custom_huskar_burning_spear",
            trigger_ability = "custom_huskar_burning_spear_legendary",
        },
        ["modifier_huskar_passive_1"] = 
        {
            skill_number = 3,
            mini_icon = "Berserkers_Blood_1",
            skill_icon = "Berserkers_Blood",
            rarity = "blue",

            damage = {8, 12, 16},
            health = 25,
            bonus = 2,
            duration = 4,
        },
        ["modifier_huskar_passive_2"] = 
        {
            skill_number = 3,
            mini_icon = "Berserkers_Blood_2",
            skill_icon = "Berserkers_Blood",
            rarity = "blue",

            heal = {10, 15, 20},
            regen = {8, 12, 16}, 
        },
        ["modifier_huskar_passive_3"] = 
        {
            skill_number = 3,
            mini_icon = "Berserkers_Blood_3",
            skill_icon = "Berserkers_Blood",
            rarity = "purple",
            main_epic = 1,

            health = 25,
            bva = {-0.2, -0.35},
            chance = 35,
            crit = {130, 160},
            duration = 4,
        },
        ["modifier_huskar_passive_4"] = 
        {
            skill_number = 3,
            mini_icon = "Berserkers_Blood_4",
            skill_icon = "Berserkers_Blood",
            rarity = "purple",
            has_video = 1,

            health = 25,
            damage_reduce = -15,
            movespeed = 20,
            slow_resist = 50,
            duration = 4,
        },
        ["modifier_huskar_passive_7"] = 
        {
            skill_number = 3,
            mini_icon = "Berserkers_Blood",
            skill_icon = "Berserkers_Blood",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            cost = 50,
            damage = 100,
            heal = 50,
            duration = 4,
            talent_cd = 6,
            skill_name = "custom_huskar_berserkers_blood",
        },
        ["modifier_huskar_leap_1"] = 
        {
            skill_number = 4,
            mini_icon = "Life_Break_1",
            skill_icon = "Life_Break",
            rarity = "blue",

            damage = {2, 3, 4},
            radius = 600,
            damage_min = {10, 15, 20},
            interval = 0.5,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_huskar_leap_2"] = 
        {
            skill_number = 4,
            mini_icon = "Life_Break_2",
            skill_icon = "Life_Break",
            rarity = "blue",

            cd = {-2, -3, -4},
        },
        ["modifier_huskar_leap_3"] = 
        {
            skill_number = 4,
            mini_icon = "Life_Break_3",
            skill_icon = "Life_Break",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            delay = 2,
            health = 25,
            heal = {20, 35},
            damage = {20, 35},
            is_through_bkb = 1,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_huskar_leap_4"] = 
        {
            skill_number = 4,
            mini_icon = "Life_Break_4",
            skill_icon = "Life_Break",
            rarity = "purple",

            cd_items = -3,
            health = 25,
        },
        ["modifier_huskar_leap_7"] = 
        {
            skill_number = 4,
            mini_icon = "Life_Break",
            skill_icon = "Life_Break",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            cd_inc = 2,
            health = 50,
            damage = 25,
            cost = 15,
            skill_name = "custom_huskar_life_break",
        },
    },

    npc_dota_hero_nevermore = 
    {
        ["modifier_nevermore_raze_1"] = 
        {
            skill_number = 1,
            mini_icon = "Shadowraze_1",
            skill_icon = "Shadowraze",
            rarity = "blue",

            damage = {20, 30, 40},
            mana = {-20, -30, -40},
        },
        ["modifier_nevermore_raze_2"] = 
        {
            skill_number = 1,
            mini_icon = "Shadowraze_2",
            skill_icon = "Shadowraze",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            cast = {-0.1, -0.15, -0.2},
        },
        ["modifier_nevermore_raze_3"] = 
        {
            skill_number = 1,
            mini_icon = "Shadowraze_3",
            skill_icon = "Shadowraze",
            rarity = "blue",

            speed = {4, 6, 8},
            heal = {20, 30, 40},
            is_purgable = 1,
            max = 3,
            duration = 6,
        },
        ["modifier_nevermore_raze_4"] = 
        {
            skill_number = 1,
            mini_icon = "Shadowraze_4",
            skill_icon = "Shadowraze",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            aoe = 0.8,
            cd = {8, 5},
            delay = 1,
            stun = 0.5,
            radius = 800,
        },
        ["modifier_nevermore_raze_5"] = 
        {
            skill_number = 1,
            mini_icon = "Shadowraze_5",
            skill_icon = "Shadowraze",
            rarity = "purple",

            duration = 8,
            slow = -10,
            cd = 8,
            fear = 1.5,
            is_purgable_self = 1,
            max = 5,
        },
        ["modifier_nevermore_raze_6"] = 
        {
            skill_number = 1,
            mini_icon = "Shadowraze_6",
            skill_icon = "Shadowraze",
            rarity = "purple",

            is_perma = 1,
            mod_name = "modifier_custom_shadowraze_perma",
            max = 40,
            cd_items = -0.7,
            cdr = 12,
        },
        ["modifier_nevermore_raze_7"] = 
        {
            skill_number = 1,
            mini_icon = "Shadowraze",
            skill_icon = "Shadowraze",
            rarity = "orange",
            has_video = 1,

            damage = -30,
            skill_name = "custom_nevermore_shadowraze_close",
            duration = 12,
            timer = 3,
            max = 3,
        },
        ["modifier_nevermore_souls_1"] = 
        {
            skill_number = 2,
            mini_icon = "Necromastery_1",
            skill_icon = "Frenzy",
            rarity = "blue",

            cd = {-2, -3, -4},
            shield = {10, 15, 20},
        },
        ["modifier_nevermore_souls_2"] = 
        {
            skill_number = 2,
            mini_icon = "Necromastery_2",
            skill_icon = "Frenzy",
            rarity = "blue",

            damage = {0.4, 0.6, 0.8},
            speed = {40, 60, 80},
        },
        ["modifier_nevermore_souls_3"] = 
        {
            skill_number = 2,
            mini_icon = "Necromastery_3",
            skill_icon = "Frenzy",
            rarity = "blue",

            move = {10, 15, 20},
            status = {10, 15, 20},
        },
        ["modifier_nevermore_souls_4"] = 
        {
            skill_number = 2,
            mini_icon = "Necromastery_4",
            skill_icon = "Frenzy",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {4, 6},
            heal = 1,
            attack = 4,
            radius = 250,
            duration = {2, 3},
        },
        ["modifier_nevermore_souls_5"] = 
        {
            skill_number = 2,
            mini_icon = "Necromastery_5",
            skill_icon = "Frenzy",
            rarity = "purple",
            has_video = 1,

            heal = 1,
            cd = 25,
            is_breakable = 1,
            health = 30,
        },
        ["modifier_nevermore_souls_6"] = 
        {
            skill_number = 2,
            mini_icon = "Necromastery_6",
            skill_icon = "Frenzy",
            rarity = "purple",

            silence = 3,
            slow = -40,
            is_purgable_self = 1,
            bonus = 2,
            duration = 2,
        },
        ["modifier_nevermore_souls_7"] = 
        {
            skill_number = 2,
            mini_icon = "Frenzy",
            skill_icon = "Frenzy",
            rarity = "orange",
            has_video = 1,

            speed = 2.5,
            range = 200,
            skill_name = "nevermore_frenzy_custom",
            vision = 1200,
            duration = 10,
        },
        ["modifier_nevermore_darklord_1"] = 
        {
            skill_number = 3,
            mini_icon = "Dark_Lord_1",
            skill_icon = "Dark_Lord",
            rarity = "blue",

            magic = {-10, -15, -20},
            armor = {-2, -3, -4},
            is_through_bkb = 1,
        },
        ["modifier_nevermore_darklord_2"] = 
        {
            skill_number = 3,
            mini_icon = "Dark_Lord_2",
            skill_icon = "Dark_Lord",
            rarity = "blue",

            move = {-10, -15, -20},
            attack = {-20, -30, -40},
            is_through_bkb = 1,
        },
        ["modifier_nevermore_darklord_3"] = 
        {
            skill_number = 3,
            mini_icon = "Dark_Lord_3",
            skill_icon = "Dark_Lord",
            rarity = "blue",

            heal = {8, 12, 16},
            creeps = 3,
            heal_reduce = {-10, -15, -20},
            health = 50,
        },
        ["modifier_nevermore_darklord_4"] = 
        {
            skill_number = 3,
            mini_icon = "Dark_Lord_4",
            skill_icon = "Dark_Lord",
            rarity = "purple",
            main_epic = 1,

            damage = {5, 8},
            interval = 0.5,
            duration = 3,
            burn = {30, 50},
            radius = 600,
            max = 8,
        },
        ["modifier_nevermore_darklord_5"] = 
        {
            skill_number = 3,
            mini_icon = "Dark_Lord_5",
            skill_icon = "Dark_Lord",
            rarity = "purple",

            speed = 600,
            slow = -80,
            duration = 3,
            radius = 250,
            is_purgable_self = 1,
            slow_duration = 2,
        },
        ["modifier_nevermore_darklord_6"] = 
        {
            skill_number = 3,
            mini_icon = "Dark_Lord_6",
            skill_icon = "Dark_Lord",
            rarity = "purple",

            speed = 700,
            range = 800,
            status = 10,
            cd = 12,
            is_through_bkb = 1,
            width = 100,
            fear = 1,
        },
        ["modifier_nevermore_darklord_7"] = 
        {
            skill_number = 3,
            mini_icon = "Dark_Lord",
            skill_icon = "Dark_Lord",
            rarity = "orange",

            damage = 45,
            fear_radius = 1800,
            skill_name = "custom_nevermore_dark_lord",
            radius = 500,
            bonus = 10,
            is_through_bkb = 1,
            cd = 15,
            fear_speed = 900,
            duration = 8,
            fear = 0.2,
        },
        ["modifier_nevermore_requiem_1"] = 
        {
            skill_number = 4,
            mini_icon = "Requiem_1",
            skill_icon = "Requiem",
            rarity = "blue",

            damage = {20, 30, 40},
            max = {3, 4, 5},
        },
        ["modifier_nevermore_requiem_2"] = 
        {
            skill_number = 4,
            mini_icon = "Requiem_2",
            skill_icon = "Requiem",
            rarity = "blue",

            cd = {-10, -15, -20},
            duration = {0.4, 0.6, 0.8},
        },
        ["modifier_nevermore_requiem_3"] = 
        {
            skill_number = 4,
            mini_icon = "Requiem_3",
            skill_icon = "Requiem",
            rarity = "blue",

            health = {15, 20, 25},
            damage_reduce = {-10, -15, -20},
            duration = 6,
        },
        ["modifier_nevermore_requiem_4"] = 
        {
            skill_number = 4,
            mini_icon = "Requiem_4",
            skill_icon = "Requiem",
            rarity = "purple",
            main_epic = 1,

            speed = {80, 120},
            raze = 2,
            trigger_ability = "custom_nevermore_requiem",
            max = 8,
            attack = 1,
            damage = {15, 25},
            duration = 8,
        },
        ["modifier_nevermore_requiem_5"] = 
        {
            skill_number = 4,
            mini_icon = "Requiem_5",
            skill_icon = "Requiem",
            rarity = "purple",

            block = 1,
            is_root_disabled = 1,
            range = 650,
            duration = 6,
        },
        ["modifier_nevermore_requiem_6"] = 
        {
            skill_number = 4,
            mini_icon = "Requiem_6",
            skill_icon = "Requiem",
            rarity = "purple",

            break_duration = 4,
        },
        ["modifier_nevermore_requiem_7"] = 
        {
            skill_number = 4,
            mini_icon = "Requiem",
            skill_icon = "Requiem",
            rarity = "orange",

            is_through_bkb = 1,
            skill_name = "custom_nevermore_requiem",
            radius = 1000,
            trigger_ability = "custom_nevermore_requiem",
            raze = 2,
            duration = 5,
            cd = -60,
            cast = -0.1,
            pull_radius = 800,
            max = 8,
        },
    },

    npc_dota_hero_queenofpain = 
    {
        ["modifier_queen_dagger_1"] = 
        {
            skill_number = 1,
            mini_icon = "Dagger_1",
            skill_icon = "Dagger",
            rarity = "blue",

            damage = {40, 60, 80},
            cast = {-0.1, -0.15, -0.2},
        },
        ["modifier_queen_dagger_2"] = 
        {
            skill_number = 1,
            mini_icon = "Dagger_2",
            skill_icon = "Dagger",
            rarity = "blue",

            heal = {0.4, 0.6, 0.8},
            max = 3,
            move = {4, 6, 8},
            duration = 6,
        },
        ["modifier_queen_dagger_3"] = 
        {
            skill_number = 1,
            mini_icon = "Dagger_3",
            skill_icon = "Dagger",
            rarity = "blue",

            mana = {15, 20, 25},
            range = {80, 120, 160},
        },
        ["modifier_queen_dagger_4"] = 
        {
            skill_number = 1,
            mini_icon = "Dagger_4",
            skill_icon = "Dagger",
            rarity = "purple",
            main_epic = 1,

            heal = {-30, -50},
            magic = {-30, -50},
            duration = 5,
            max = 10,
        },
        ["modifier_queen_dagger_5"] = 
        {
            skill_number = 1,
            mini_icon = "Dagger_5",
            skill_icon = "Dagger",
            rarity = "purple",
            has_video = 1,

            speed = 30,
            cd_duration = 10,
            fear = 1.2,
            slow = -15,
        },
        ["modifier_queen_dagger_6"] = 
        {
            skill_number = 1,
            mini_icon = "Dagger_6",
            skill_icon = "Dagger",
            rarity = "purple",

            cd = -1,
            cd_items = -1,
            vision = 10,
        },
        ["modifier_queen_dagger_7"] = 
        {
            skill_number = 1,
            mini_icon = "Dagger",
            skill_icon = "Dagger",
            rarity = "orange",
            has_video = 1,

            creeps = 3,
            ticks = 10,
            heal = 80,
            slow = -100,
            skill_name = "custom_queenofpain_shadow_strike",
            max = 4,
            cd = 4,
            duration = 2,
        },
        ["modifier_queen_blink_1"] = 
        {
            skill_number = 2,
            mini_icon = "Blink_1",
            skill_icon = "Blink",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            cast = {-30, -40, -50},
        },
        ["modifier_queen_blink_2"] = 
        {
            skill_number = 2,
            mini_icon = "Blink_2",
            skill_icon = "Blink",
            rarity = "blue",

            duration = 5,
            int = {8, 12, 16},
            shield = {80, 120, 160},
        },
        ["modifier_queen_blink_3"] = 
        {
            skill_number = 2,
            mini_icon = "Blink_3",
            skill_icon = "Blink",
            rarity = "blue",

            damage = {2, 3, 4},
            max = 4,
            range = {80, 120, 160},
            duration = 8,
        },
        ["modifier_queen_blink_4"] = 
        {
            skill_number = 2,
            mini_icon = "Blink_4",
            skill_icon = "Blink",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            speed = {100, 200},
            radius = 300,
            slow = -100,
            effect_duration = 5,
            count = 2,
            damage = {80, 140},
            duration = 1,
        },
        ["modifier_queen_blink_5"] = 
        {
            skill_number = 2,
            mini_icon = "Blink_5",
            skill_icon = "Blink",
            rarity = "purple",
            has_video = 1,

            trigger_ability = "custom_queenofpain_blink",
            root = 2,
            knock_radius = 325,
            radius = 300,
            is_purgable_self = 1,
            knock_duration = 0.2,
        },
        ["modifier_queen_blink_6"] = 
        {
            skill_number = 2,
            mini_icon = "Blink_6",
            skill_icon = "Blink",
            rarity = "purple",
            has_video = 1,

            status = 10,
            duration = 1.5,
        },
        ["modifier_queen_blink_7"] = 
        {
            skill_number = 2,
            mini_icon = "Blink",
            skill_icon = "Blink",
            rarity = "orange",
            has_video = 1,

            damage = 80,
            is_through_bkb = 1,
            skill_name = "custom_queenofpain_blink",
            radius = 1000,
            trigger_ability = "custom_queenofpain_blink",
            aoe = 300,
            interval = 0.12,
            max = 8,
            attack = 1,
            spell = 2,
            duration = 3,
        },
        ["modifier_queen_scream_1"] = 
        {
            skill_number = 3,
            mini_icon = "Scream_1",
            skill_icon = "Scream",
            rarity = "blue",

            damage = {2, 3, 4},
            damage_auto = {30, 45, 60},
            cd = 8,
        },
        ["modifier_queen_scream_2"] = 
        {
            skill_number = 3,
            mini_icon = "Scream_2",
            skill_icon = "Scream",
            rarity = "blue",

            cd = {1, 1.5, 2},
            duration = 3,
            is_purgable_self = 1,
            slow = {-20, -30, -40},
        },
        ["modifier_queen_scream_3"] = 
        {
            skill_number = 3,
            mini_icon = "Scream_3",
            skill_icon = "Scream",
            rarity = "blue",

            max = 4,
            str = {2, 3, 4},
            armor = {2, 3, 4},
            duration = 6,
        },
        ["modifier_queen_scream_4"] = 
        {
            skill_number = 3,
            mini_icon = "Scream_4",
            skill_icon = "Scream",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            heal = 6,
            radius = 400,
            chance = {30, 50},
        },
        ["modifier_queen_scream_5"] = 
        {
            skill_number = 3,
            mini_icon = "Scream_5",
            skill_icon = "Scream",
            rarity = "purple",
            has_video = 1,

            speed = 40,
            is_purgable = 1,
            duration = 1.5,
            min = 10,
            damage_reduce = -40,
        },
        ["modifier_queen_scream_6"] = 
        {
            skill_number = 3,
            mini_icon = "Scream_6",
            skill_icon = "Scream",
            rarity = "purple",

            str = 10,
            is_breakable = 1,
            health = 40,
            cd = 50,
            heal = 25,
            trigger_ability = "custom_queenofpain_scream_of_pain",
        },
        ["modifier_queen_scream_7"] = 
        {
            skill_number = 3,
            mini_icon = "Scream",
            skill_icon = "Scream",
            rarity = "orange",
            has_video = 1,

            damage = 4,
            cost = 5,
            cd = 13,
            skill_name = "custom_queenofpain_scream_of_pain",
            trigger_ability = "custom_queenofpain_blood_pact",
            cd_bonus = 100,
            duration = 10,
        },
        ["modifier_queen_sonic_1"] = 
        {
            skill_number = 4,
            mini_icon = "Sonic_1",
            skill_icon = "Sonic",
            rarity = "blue",

            damage = {80, 120, 160},
            heal_reduce = {-15, -20, -25},
            duration = 6,
        },
        ["modifier_queen_sonic_2"] = 
        {
            skill_number = 4,
            mini_icon = "Sonic_2",
            skill_icon = "Sonic",
            rarity = "blue",

            cd = {-8, -12, -16},
            cast = {-0.1, -0.15, -0.2},
        },
        ["modifier_queen_sonic_3"] = 
        {
            skill_number = 4,
            mini_icon = "Sonic_3",
            skill_icon = "Sonic",
            rarity = "blue",

            heal = {8, 12, 16},
            creeps = 3,
            bonus = 2,
            duration = 5,
        },
        ["modifier_queen_sonic_4"] = 
        {
            skill_number = 4,
            mini_icon = "Sonic_4",
            skill_icon = "Sonic",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {6, 10},
            is_through_bkb = 1,
            stun = {1.2, 2},
            radius = 300,
            max = 6,
            duration = 8,
        },
        ["modifier_queen_sonic_5"] = 
        {
            skill_number = 4,
            mini_icon = "Sonic_5",
            skill_icon = "Sonic",
            rarity = "purple",
            has_video = 1,

            duration_knock = 40,
            duration = 3,
        },
        ["modifier_queen_sonic_6"] = 
        {
            skill_number = 4,
            mini_icon = "Sonic_6",
            skill_icon = "Sonic",
            rarity = "purple",

            max = 8,
            is_perma = 1,
            mod_name = "modifier_custom_sonic_cdr_perma",
            bkb = 2.5,
            timer = 5,
            cdr = 10,
        },
        ["modifier_queen_sonic_7"] = 
        {
            skill_number = 4,
            mini_icon = "Sonic",
            skill_icon = "Sonic",
            rarity = "orange",

            damage = 15,
            hero = 10,
            damage_inc = 80,
            radius = 150,
            trigger_ability = "custom_queenofpain_sonic_wave",
            interval = 0.5,
            timer = 5,
            skill_name = "custom_queenofpain_sonic_wave",
            duration = 5,
            cd_inc = -40,
            max = 300,
        },
    },

    npc_dota_hero_legion_commander = 
    {
        ["modifier_legion_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            status = {8, 12, 16},
            armor = {8, 12, 16},
            duration = 5,
        },
        ["modifier_legion_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            move = {30, 45, 60},
            slow_resist = {20, 30, 40},
        },
        ["modifier_legion_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            range = {100, 150, 200},
            cd = {-6, -9, -12},
        },

        ["modifier_legion_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            slow = 1,
            silence = 2,
        },
        ["modifier_legion_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            bkb = 2,
            cd = 10,
            alt_talent = "modifier_legion_press_7",
        },
        ["modifier_legion_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            skill_icon = "Duel",
            rarity = "purple",

            health = 8,
            cdr = 8,
            cast = -0.1,
            bonus = 2,
            max = 8,
            is_perma = 1,
            mod_name = "modifier_legion_commander_duel_custom_damage",
        },

        ["modifier_legion_odds_1"] = 
        {
            skill_number = 1,
            mini_icon = "Odds_1",
            skill_icon = "Odds",
            rarity = "blue",

            damage = {30, 45, 60},
            heal_reduce = {-12, -18, -24},
            duration = 5,
        },
        ["modifier_legion_odds_2"] = 
        {
            skill_number = 1,
            mini_icon = "Odds_2",
            skill_icon = "Odds",
            rarity = "blue",

            radius = {60, 90, 120},
            cd = {-2, -3, -4},
            radius_press = {40, 60, 80},
        },
        ["modifier_legion_odds_3"] = 
        {
            skill_number = 1,
            mini_icon = "Odds_3",
            skill_icon = "Odds",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            spell = {8, 15},
            damage = {20, 35},
            duration = 10,
            damage_max = 70,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_legion_odds_4"] = 
        {
            skill_number = 1,
            mini_icon = "Odds_4",
            skill_icon = "Odds",
            rarity = "purple",

            shield = 5,
            shield_max = 25,
            cd_items = -0.8,
            cd_items_legendary = -0.5,
            duration = 5,
            alt_talent = "modifier_legion_press_7",
        },
        ["modifier_legion_odds_7"] = 
        {
            skill_number = 1,
            mini_icon = "Odds",
            skill_icon = "Odds",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            max = 3,
            damage = 40,
            damage_max = 250,
            speed = 200,
            radius = 1000,
            interval = 2,
            aoe_radius = 450,
            skill_name = "custom_legion_commander_overwhelming_odds",
        },

        ["modifier_legion_press_1"] = 
        {
            skill_number = 2,
            mini_icon = "Press_1",
            skill_icon = "Press",
            rarity = "blue",

            damage = {0.8, 1.2, 1.6},
            magic = {-8, -12, -16},
        },
        ["modifier_legion_press_2"] = 
        {
            skill_number = 2,
            mini_icon = "Press_2",
            skill_icon = "Press",
            rarity = "blue",

            duration = {1, 1.5, 2},
            duration_legendary = {0.6, 0.9, 1.2},
            heal = {0.8, 1.2, 1.6},
            alt_talent = "modifier_legion_press_7",
        },
        ["modifier_legion_press_3"] = 
        {
            skill_number = 2,
            mini_icon = "Press_3",
            skill_icon = "Press",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal = {25, 40},
            chance = 15,
            talent_cd = 2,
            damage = {250, 400},
            duration = 4,
            talent_cd = 1,
        },
        ["modifier_legion_press_4"] = 
        {
            skill_number = 2,
            mini_icon = "Press_4",
            skill_icon = "Press",
            rarity = "purple",
            has_video = 1,

            pull_duration = 0.2,
            pull_distance = 150,
            radius = 550,
            root = 2,
            root_cd = 10,
            cd = -4,
            odds_count = 3,
            is_purgable_self = 1,
            alt_talent = "modifier_legion_odds_7",
            alt_talent2 = "modifier_legion_press_7",
        },
        ["modifier_legion_press_7"] = 
        {
            skill_number = 2,
            mini_icon = "Press",
            skill_icon = "Press",
            rarity = "orange",
            complexity = 1,
            has_video = 1,

            duration = 3,
            damage = 30,
            max = 20,
            linger_duration = 5,
            heal_reduce = -15,
            skill_name = "custom_legion_commander_press_the_attack",
        },

        ["modifier_legion_moment_1"] = 
        {
            skill_number = 3,
            mini_icon = "Moment_1",
            skill_icon = "Moment",
            rarity = "blue",

            range = {40, 60, 80},
            speed = {20, 30, 40},
            max = 3,
            duration = 6,
        },
        ["modifier_legion_moment_2"] = 
        {
            skill_number = 3,
            mini_icon = "Moment_2",
            skill_icon = "Moment",
            rarity = "blue",

            slow = {-20, -30, -40},
            damage_reduce = {-12, -18, -24},
            duration = 3,
            is_purgable_self = 1,
        },
        ["modifier_legion_moment_3"] = 
        {
            skill_number = 3,
            mini_icon = "Moment_3",
            skill_icon = "Moment",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            stun = {0.6, 1},
            crit = {150, 200},
            heal = 100,
            talent_cd = 6,
            cd_reduce = 2,
            is_basher = 1,
            is_through_bkb = 1,
        },
        ["modifier_legion_moment_4"] = 
        {
            skill_number = 3,
            mini_icon = "Moment_4",
            skill_icon = "Moment",
            rarity = "purple",
            has_video = 1,

            attack = -1,
            duration = 5,
        },
        ["modifier_legion_moment_7"] = 
        {
            skill_number = 3,
            mini_icon = "Moment",
            skill_icon = "Moment",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            bva = -0.3,
            talent_cd = 2,
            damage_reduce = -20,
            heal = 4,
            skill_name = "custom_legion_commander_moment_of_courage",
        },

        ["modifier_legion_duel_1"] = 
        {
            skill_number = 4,
            mini_icon = "Duel_1",
            skill_icon = "Duel",
            rarity = "blue",

            armor = {-2, -3, -4},
            max = 4,
            duration = 8,
            armor_legendary = {-1, -1.5, -2},
            max_legendary = 8,
            alt_talent = "modifier_legion_duel_7",
        },
        ["modifier_legion_duel_2"] = 
        {
            skill_number = 4,
            mini_icon = "Duel_2",
            skill_icon = "Duel",
            rarity = "blue",

            heal = {12, 18, 24},
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_legion_duel_3"] = 
        {
            skill_number = 4,
            mini_icon = "Duel_3",
            skill_icon = "Duel",
            rarity = "purple",
            main_epic = 1,

            str = {6, 10},
            damage = {30, 50},
            radius = 700,
            max = 12,
            duration = 6,
        },
        ["modifier_legion_duel_4"] = 
        {
            skill_number = 4,
            mini_icon = "Duel_4",
            skill_icon = "Duel",
            rarity = "purple",
            has_video = 1,

            duration = 0.5,
            duration_legendary = 0.5,
            heal = 35,
            talent_cd = 20,
            is_breakable = 1,
            alt_talent = "modifier_legion_duel_7",
        },
        ["modifier_legion_duel_7"] = 
        {
            skill_number = 4,
            mini_icon = "Duel",
            skill_icon = "Duel",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            duration = 6,
            duration_inc = 1,
            duration_max = 20,
            interval = 1,
            damage = 100,
            radius = 500,
            skill_name = "custom_legion_commander_duel",
        },
    },

    npc_dota_hero_bristleback = 
    {
        ["modifier_bristle_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            move = {30, 45, 60},
            slow_resist = {20, 30, 40},
        },
        ["modifier_bristle_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            str = {6, 9, 12},
            shield = {2, 3, 4},
        },
        ["modifier_bristle_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            armor = {8, 12, 16},
            regen = {40, 60, 80},
        },

        ["modifier_bristle_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            chance = 20,
            talent_cd = 4,
            damage = 50,
            stun = 1,
            is_through_bkb = 1,
            is_basher = 1,
        },
        ["modifier_bristle_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -10,
            talent_cd = 20,
            duration = 3,
        },
        ["modifier_bristle_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",

            cdr = 20,
            move = 1,
            move_max = 600,
            move_tooltip = 50,
        },

        ["modifier_bristle_goo_1"] = 
        {
            skill_number = 1,
            mini_icon = "Goo_1",
            skill_icon = "Goo",
            rarity = "blue",

            damage = {20, 30, 40},
            speed = {20, 30, 40},
            interval = 0.5,
            damage_type = DAMAGE_TYPE_PHYSICAL,
        },
        ["modifier_bristle_goo_2"] = 
        {
            skill_number = 1,
            mini_icon = "Goo_2",
            skill_icon = "Goo",
            rarity = "blue",

            cd = {-0.4, -0.6, -0.8},
            range = {100, 150, 200},
        },
        ["modifier_bristle_goo_3"] = 
        {
            skill_number = 1,
            mini_icon = "Goo_3",
            skill_icon = "Goo",
            rarity = "purple",
            main_epic = 1,

            armor = {-15, -25},
            slow = {-25, -40},
            max = 10,
            duration = 8,
        },
        ["modifier_bristle_goo_4"] = 
        {
            skill_number = 1,
            mini_icon = "Goo_4",
            skill_icon = "Goo",
            rarity = "purple",
            has_video = 1,

            max = 1,
            damage_reduce = -8,
            stack = 4,
            silence = 3,
            talent_cd = 10,
            is_purgable_self = 1,
        },
        ["modifier_bristle_goo_7"] = 
        {
            skill_number = 1,
            mini_icon = "Goo",
            skill_icon = "Goo",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            stack = 4,
            duration = 8,
            bva = 1,
            status = 50,
            chance = 35,
            stun = 0.5,
            stun_cd = 1,
            talent_cd = 12,
            is_basher = 1,
            is_through_bkb = 1,
            skill_name = "bristleback_viscous_nasal_goo_custom",
        },
        ["modifier_bristle_spray_1"] = 
        {
            skill_number = 2,
            mini_icon = "Spray_1",
            skill_icon = "Spray",
            rarity = "blue",

            damage = {50, 75, 100},
            damage_max = 300,
        },
        ["modifier_bristle_spray_2"] = 
        {
            skill_number = 2,
            mini_icon = "Spray_2",
            skill_icon = "Spray",
            rarity = "blue",

            radius = {80, 120, 160},
            cd = {-0.6, -0.9, -1.2},
        },
        ["modifier_bristle_spray_3"] = 
        {
            skill_number = 2,
            mini_icon = "Spray_3",
            skill_icon = "Spray",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal = {12, 20},
            min = 1,
            max = 3,
            damage = {30, 50},
            chance = 30,
            chance_inc = 50,
            interval = 0.2,
        },
        ["modifier_bristle_spray_4"] = 
        {
            skill_number = 2,
            mini_icon = "Spray_4",
            skill_icon = "Spray",
            rarity = "purple",
            
            cd_items = 0.5,
            heal_reduce = -2,
            slow = -2,
            max = 20,
            duration = 8,
        },
        ["modifier_bristle_spray_7"] = 
        {
            skill_number = 2,
            mini_icon = "Spray",
            skill_icon = "Spray",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            mana = 15,
            thresh = 50,
            damage = 200,
            mana_inc = 15,
            creeps = 4,
            skill_name = "bristleback_quill_spray_custom",
        },
        ["modifier_bristle_back_1"] = 
        {
            skill_number = 3,
            mini_icon = "Back_1",
            skill_icon = "Back",
            rarity = "blue",

            chance = 40,
            damage = {2, 3, 4},
            base = {20, 30, 40},
            damage_reduce = -25,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            damage_type_quill = DAMAGE_TYPE_MAGICAL,
            is_through_bkb = 1,
        },
        ["modifier_bristle_back_2"] = 
        {
            skill_number = 3,
            mini_icon = "Back_2",
            skill_icon = "Back",
            rarity = "blue",

            base = {10, 15, 20},
            heal = {1, 1.5, 2},
            heal_reduce = 2,
        },
        ["modifier_bristle_back_3"] = 
        {
            skill_number = 3,
            mini_icon = "Back_3",
            skill_icon = "Back",
            rarity = "purple",
            main_epic = 1,

            spell = {6, 10},
            health = {6, 10},
            bonus = 3,
            duration = 10,
            stack = 3,
            stack_duration = 5,
        },
        ["modifier_bristle_back_4"] = 
        {
            skill_number = 3,
            mini_icon = "Back_4",
            skill_icon = "Back",
            rarity = "purple",
            has_video = 1,

            damage = -20,
            stack = 3,
            stack_duration = 5,
            taunt = 2,
            radius = 700,
            talent_cd = 10,
            is_through_bkb = 1,
        },
        ["modifier_bristle_back_7"] = 
        {
            skill_number = 3,
            mini_icon = "Back",
            skill_icon = "Back",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            cost = 6,
            cd = -20,
            health = 600,   
            interval = 0.1,
            talent_cd = 14,
            skill_name = "bristleback_bristleback_custom",
            trigger_ability = "bristleback_quill_spray_custom_legendary",
        },
        ["modifier_bristle_warpath_1"] = 
        {
            skill_number = 4,
            mini_icon = "Warpath_1",
            skill_icon = "Warpath",
            rarity = "blue",

            range = {40, 60, 80},
            damage = {4, 6, 8},
            radius = {30, 45, 60},
            alt_talent = "modifier_bristle_warpath_7",
        },
        ["modifier_bristle_warpath_2"] = 
        {
            skill_number = 4,
            mini_icon = "Warpath_2",
            skill_icon = "Warpath",
            rarity = "blue",

            status = {12, 18, 24},
            max = {2, 3, 4},
        },
        ["modifier_bristle_warpath_3"] = 
        {
            skill_number = 4,
            mini_icon = "Warpath_3",
            skill_icon = "Warpath",
            rarity = "purple",
            main_epic = 1,

            heal = {25, 40},
            damage = {3, 5},
            duration = 12,
        },
        ["modifier_bristle_warpath_4"] = 
        {
            skill_number = 4,
            mini_icon = "Warpath_4",
            skill_icon = "Warpath",
            rarity = "purple",
            has_video = 1,

            max = 10,
            stack = 4,
            talent_cd = 10,
            bkb = 2.5, 
            is_breakable = 1,
        },
        ["modifier_bristle_warpath_7"] = 
        {
            skill_number = 4,
            mini_icon = "Warpath",
            skill_icon = "Warpath",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            radius = 220,
            range = 700,
            damage = 200,
            damage_inc = 150,
            damage_max = 800,
            talent_cd = 1.5,
            stun = 1,
            cast = 1.4,
            speed = 2000,
            cast_inc = -0.25,
            max = 4,
            duration = 12,
            is_through_bkb = 1,
            skill_name = "bristleback_warpath_custom",
        },
    },

    npc_dota_hero_terrorblade = 
    {
        ["modifier_terror_reflection_1"] = 
        {
            skill_number = 1,
            mini_icon = "Reflection_1",
            skill_icon = "Reflection",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = {1, 1.5, 2},
        },
        ["modifier_terror_reflection_2"] = 
        {
            skill_number = 1,
            mini_icon = "Reflection_2",
            skill_icon = "Reflection",
            rarity = "blue",

            damage = {10, 15, 20},
            armor = {-4, -6, -8},
        },
        ["modifier_terror_reflection_3"] = 
        {
            skill_number = 1,
            mini_icon = "Reflection_3",
            skill_icon = "Reflection",
            rarity = "blue",

            damage_reduce = {-10, -15, -20},
            slow = {-10, -15, -20},
        },
        ["modifier_terror_reflection_4"] = 
        {
            skill_number = 1,
            mini_icon = "Reflection_4",
            skill_icon = "Reflection",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            speed = {40, 70},
            damage = {70, 120},
            duration = 5,
            max = 3,
        },
        ["modifier_terror_reflection_5"] = 
        {
            skill_number = 1,
            mini_icon = "Reflection_5",
            skill_icon = "Reflection",
            rarity = "purple",
            has_video = 1,

            cast = -50,
            delay = 3,
            range = 150,
            stun = 1,
        },
        ["modifier_terror_reflection_6"] = 
        {
            skill_number = 1,
            mini_icon = "Reflection_6",
            skill_icon = "Reflection",
            rarity = "purple",

            heal = 4,
            max = 5,
            cd_items = -0.8,
            cdr = 10,
        },
        ["modifier_terror_reflection_7"] = 
        {
            skill_number = 1,
            mini_icon = "Reflection",
            skill_icon = "Reflection",
            rarity = "orange",
            has_video = 1,

            skill_name = "custom_terrorblade_reflection",
            damage = 35,
        },
        ["modifier_terror_illusion_1"] = 
        {
            skill_number = 2,
            mini_icon = "Illusion_1",
            skill_icon = "Illusion",
            rarity = "blue",

            damage = {16, 24, 32},
            radius_meta = 700,
            slow = {-16, -24, -32},
            allow_illusion = 1,
            radius = 450,
            interval = 0.5,
        },
        ["modifier_terror_illusion_2"] = 
        {
            skill_number = 2,
            mini_icon = "Illusion_2",
            skill_icon = "Illusion",
            rarity = "blue",

            cd = {-2, -3, -4},
            mana = {-35, -60, -85},
        },
        ["modifier_terror_illusion_3"] = 
        {
            skill_number = 2,
            mini_icon = "Illusion_3",
            skill_icon = "Illusion",
            rarity = "blue",

            move = {30, 45, 60},
            magic = {8, 12, 16},
            allow_illusion = 1,
            update_mod = "modifier_terrorblade_innate_custom",
        },
        ["modifier_terror_illusion_4"] = 
        {
            skill_number = 2,
            mini_icon = "Illusion_4",
            skill_icon = "Illusion",
            rarity = "purple",
            main_epic = 1,

            damage = {6, 10},
            allow_illusion = 1,
            update_mod = "modifier_terrorblade_innate_custom",
            agility = {8, 15},
            max = 4,
        },
        ["modifier_terror_illusion_5"] = 
        {
            skill_number = 2,
            mini_icon = "Illusion_5",
            skill_icon = "Illusion",
            rarity = "purple",
            has_video = 1,

            is_root_disabled = 1,
            range = 400,
            invun = 0.3,
        },
        ["modifier_terror_illusion_6"] = 
        {
            skill_number = 2,
            mini_icon = "Illusion_6",
            skill_icon = "Illusion",
            rarity = "purple",

            allow_illusion = 1,
            damage_self = -40,
            duration = 2,
            damage_reduce = -60,
        },
        ["modifier_terror_illusion_7"] = 
        {
            skill_number = 2,
            mini_icon = "Illusion",
            skill_icon = "Illusion",
            rarity = "orange",
            has_video = 1,

            damage = 30,
            max = 2,
            heal = 10,
            chance = 10,
            skill_name = "custom_terrorblade_conjure_image",
            radius = 1200,
            incoming = 500,
            duration = 8,
        },
        ["modifier_terror_meta_1"] = 
        {
            skill_number = 3,
            mini_icon = "Meta_1",
            skill_icon = "Meta",
            rarity = "blue",

            slow = -50,
            allow_illusion = 1,
            crit = 150,
            chance = {20, 30, 40},
            duration = 1,
        },
        ["modifier_terror_meta_2"] = 
        {
            skill_number = 3,
            mini_icon = "Meta_2",
            skill_icon = "Meta",
            rarity = "blue",

            range = {40, 60, 80},
            cleave = {10, 15, 20},
            allow_illusion = 1,
            radius = 300,
            bonus = 2,
            update_mod = "modifier_terrorblade_innate_custom",
        },
        ["modifier_terror_meta_3"] = 
        {
            skill_number = 3,
            mini_icon = "Meta_3",
            skill_icon = "Meta",
            rarity = "blue",

            cd = {-8, -12, -16},
            alt_talent = "modifier_terror_meta_7",
            duration = {2, 3, 4},
            max = {2, 3, 4},
        },
        ["modifier_terror_meta_4"] = 
        {
            skill_number = 3,
            mini_icon = "Meta_4",
            skill_icon = "Meta",
            rarity = "purple",
            main_epic = 1,

            creeps = 3,
            is_perma = 1,
            heal = {40, 70},
            mod_name = "modifier_custom_terrorblade_metamorphosis_perma",
            damage = {0.5, 1},
            max = 100,
        },
        ["modifier_terror_meta_5"] = 
        {
            skill_number = 3,
            mini_icon = "Meta_5",
            skill_icon = "Meta",
            rarity = "purple",
            has_video = 1,

            move = 15,
            allow_illusion = 1,
            alt_talent = "modifier_terror_meta_7",
            duration = 2,
        },
        ["modifier_terror_meta_6"] = 
        {
            skill_number = 3,
            mini_icon = "Meta_6",
            skill_icon = "Meta",
            rarity = "purple",
            has_video = 1,

            range = 800,
            status = 10,
            cd = 12,
            is_breakable = 1,
            allow_illusion = 1,
            fear = 1.5,
        },
        ["modifier_terror_meta_7"] = 
        {
            skill_number = 3,
            mini_icon = "Meta",
            skill_icon = "Meta",
            rarity = "orange",
            has_video = 1,

            cd = 25,
            bva = 1.2,
            duration = 1,
            skill_name = "custom_terrorblade_metamorphosis",
            delay = 3,
            trigger_ability = "custom_terrorblade_metamorphosis",
            max = 10,
        },
        ["modifier_terror_sunder_1"] = 
        {
            skill_number = 4,
            mini_icon = "Sunder_1",
            skill_icon = "Sunder",
            rarity = "blue",

            damage = {10, 15, 20},
            heal_reduce = {-20, -30, -40},
            duration = 5,
        },
        ["modifier_terror_sunder_2"] = 
        {
            skill_number = 4,
            mini_icon = "Sunder_2",
            skill_icon = "Sunder",
            rarity = "blue",

            health = {1, 1.5, 2},
            allow_illusion = 1,
            update_mod = "modifier_terrorblade_innate_custom",
            shield = {8, 12, 16},
            duration = 6,
        },
        ["modifier_terror_sunder_3"] = 
        {
            skill_number = 4,
            mini_icon = "Sunder_3",
            skill_icon = "Sunder",
            rarity = "blue",

            cd = {-6, -10, -14},
            update_mod = "modifier_custom_terrorblade_sunder_tracker",
            range = {100, 150, 200},
        },
        ["modifier_terror_sunder_4"] = 
        {
            skill_number = 4,
            mini_icon = "Sunder_4",
            skill_icon = "Sunder",
            rarity = "purple",
            main_epic = 1,

            init = {6, 10},
            duration = 12,
            max = 8,
        },
        ["modifier_terror_sunder_5"] = 
        {
            skill_number = 4,
            mini_icon = "Sunder_5",
            skill_icon = "Sunder",
            rarity = "purple",
            has_video = 1,

            speed = 40,
            is_breakable = 1,
            cd = 25,
            cast = -0.2,
            duration = 2,
        },
        ["modifier_terror_sunder_6"] = 
        {
            skill_number = 4,
            mini_icon = "Sunder_6",
            skill_icon = "Sunder",
            rarity = "purple",
            has_video = 1,

            health = 30,
            is_through_bkb = 1,
            is_purgable_self = 1,
            root = 2,
        },
        ["modifier_terror_sunder_7"] = 
        {
            skill_number = 4,
            mini_icon = "Sunder",
            skill_icon = "Sunder",
            rarity = "orange",
            has_video = 1,

            skill_name = "custom_terrorblade_sunder",
            radius = 250,
            trigger_ability = "custom_terrorblade_sunder",
            interval = 1,
            cost = 8,
            slow = -100,
            cd = 3,
            heal = 20,
            slow_duration = 1,
            max = 4,
        },
    },

    npc_dota_hero_puck = 
    {
        ["modifier_puck_orb_1"] = 
        {
            skill_number = 1,
            mini_icon = "Orb_1",
            skill_icon = "Orb",
            rarity = "blue",

            range = {80, 120, 160},
            radius = 300,
            resist = {-4, -6, -8},
            duration = 8,
            max = 4,
        },
        ["modifier_puck_orb_2"] = 
        {
            skill_number = 1,
            mini_icon = "Orb_2",
            skill_icon = "Orb",
            rarity = "blue",

            heal = {8, 12, 16},
            is_purgable = 1,
            duration = 3,
            health = {1.5, 2, 2.5},
        },
        ["modifier_puck_orb_3"] = 
        {
            skill_number = 1,
            mini_icon = "Orb_3",
            skill_icon = "Orb",
            rarity = "blue",

            speed = {10, 15, 20},
            range = {10, 15, 20},
            move = {20, 30, 40},
        },
        ["modifier_puck_orb_4"] = 
        {
            skill_number = 1,
            mini_icon = "Orb_4",
            skill_icon = "Orb",
            rarity = "purple",
            main_epic = 1,

            damage = {2.5, 4},
            cd = {-0.4, -0.6},
            duration = 8,
            creeps = {60, 100},
            max = 5,
        },
        ["modifier_puck_orb_5"] = 
        {
            skill_number = 1,
            mini_icon = "Orb_5",
            skill_icon = "Orb",
            rarity = "purple",

            duration = 1.5,
            status = 40,
            damage_reduce = -40,
        },
        ["modifier_puck_orb_6"] = 
        {
            skill_number = 1,
            mini_icon = "Orb_6",
            skill_icon = "Orb",
            rarity = "purple",

            slow = -80,
            stun = 1.6,
            effect_duration = 8,
            duration = 2,
            max = 5,
        },
        ["modifier_puck_orb_7"] = 
        {
            skill_number = 1,
            mini_icon = "Orb",
            skill_icon = "Orb",
            rarity = "orange",
            has_video = 1,

            skill_name = "custom_puck_illusory_orb",
            duration = 10,
            damage = 80,
            trigger_ability = "custom_puck_illusory_orb",
        },
        ["modifier_puck_rift_1"] = 
        {
            skill_number = 2,
            mini_icon = "Rift_1",
            skill_icon = "Rift",
            rarity = "blue",

            damage = {60, 90, 120},
            creeps = 3,
            heal = {20, 30, 40},
        },
        ["modifier_puck_rift_2"] = 
        {
            skill_number = 2,
            mini_icon = "Rift_2",
            skill_icon = "Rift",
            rarity = "blue",

            cd = {-2, -3, -4},
            range = {80, 120, 160},
        },
        ["modifier_puck_rift_3"] = 
        {
            skill_number = 2,
            mini_icon = "Rift_3",
            skill_icon = "Rift",
            rarity = "blue",

            slow = {-20, -30, -40},
            duration = {0.4, 0.6, 0.8},
        },
        ["modifier_puck_rift_4"] = 
        {
            skill_number = 2,
            mini_icon = "Rift_4",
            skill_icon = "Rift",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {20, 35},
            heal_reduce = {-25, -40},
        },
        ["modifier_puck_rift_5"] = 
        {
            skill_number = 2,
            mini_icon = "Rift_5",
            skill_icon = "Rift",
            rarity = "purple",

            knock_range = 300,
            health = 50,
            radius = 100,
            knock_duration = 0.2,
            fear = 1.2,
        },
        ["modifier_puck_rift_6"] = 
        {
            skill_number = 2,
            mini_icon = "Rift_6",
            skill_icon = "Rift",
            rarity = "purple",
            has_video = 1,

            speed = -120,
            duration = 3,
        },
        ["modifier_puck_rift_7"] = 
        {
            skill_number = 2,
            mini_icon = "Rift",
            skill_icon = "Rift",
            rarity = "orange",

            damage = 60,
            is_through_bkb = 1,
            skill_name = "custom_puck_waning_rift",
            range = 500,
            slow = -80,
            duration = 2,
            effect_duration = 8,
            duration_max = 5,
            max = 4,
        },
        ["modifier_puck_shift_1"] = 
        {
            skill_number = 3,
            mini_icon = "Shift_1",
            skill_icon = "Shift",
            rarity = "blue",

            speed = {15, 25, 35},
            int = {6, 9, 12},
        },
        ["modifier_puck_shift_2"] = 
        {
            skill_number = 3,
            mini_icon = "Shift_2",
            skill_icon = "Shift",
            rarity = "blue",

            status = {10, 15, 20},
            shield = {80, 120, 160},
            duration = 4,
        },
        ["modifier_puck_shift_3"] = 
        {
            skill_number = 3,
            mini_icon = "Shift_3",
            skill_icon = "Shift",
            rarity = "blue",

            speed = 30,
            duration = {1, 1.5, 2},
        },
        ["modifier_puck_shift_4"] = 
        {
            skill_number = 3,
            mini_icon = "Shift_4",
            skill_icon = "Shift",
            rarity = "purple",
            main_epic = 1,

            damage = {60, 120},
            slow = -80,
            effect_duration = 5,
            radius = 300,
            chance = 20,
            duration = 1,
        },
        ["modifier_puck_shift_5"] = 
        {
            skill_number = 3,
            mini_icon = "Shift_5",
            skill_icon = "Shift",
            rarity = "purple",

            cd = 10,
            radius = 450,
            cd_inc = -0.5,
            stun = 1,
        },
        ["modifier_puck_shift_6"] = 
        {
            skill_number = 3,
            mini_icon = "Shift_6",
            skill_icon = "Shift",
            rarity = "purple",

            is_root_disabled = 1,
            trigger_ability = "custom_puck_phase_shift",
            range = 350,
            duration = 1.2,
        },
        ["modifier_puck_shift_7"] = 
        {
            skill_number = 3,
            mini_icon = "Shift",
            skill_icon = "Shift",
            rarity = "orange",
            has_video = 1,

            damage = 5,
            status = 80,
            skill_name = "custom_puck_phase_shift",
            attack_damage = -40,
            duration = 3,
            damage_reduce = -80,
        },
        ["modifier_puck_coil_1"] = 
        {
            skill_number = 4,
            mini_icon = "Coil_1",
            skill_icon = "Coil",
            rarity = "blue",

            damage = {2, 3, 4},
            radius = {-60, -90, -120},
            interval = 0.5,
            duration = 4,
        },
        ["modifier_puck_coil_2"] = 
        {
            skill_number = 4,
            mini_icon = "Coil_2",
            skill_icon = "Coil",
            rarity = "blue",

            cd = {-6, -9, -12},
            duration = {1, 1.5, 2},
        },
        ["modifier_puck_coil_3"] = 
        {
            skill_number = 4,
            mini_icon = "Coil_3",
            skill_icon = "Coil",
            rarity = "blue",

            duration = 4,
            damage_reduce = {-10, -15, -20},
            slow = {-20, -30, -40},
        },
        ["modifier_puck_coil_4"] = 
        {
            skill_number = 4,
            mini_icon = "Coil_4",
            skill_icon = "Coil",
            rarity = "purple",
            main_epic = 1,

            cd = {5, 3},
            damage = {2, 3},
            duration = 16,
        },
        ["modifier_puck_coil_5"] = 
        {
            skill_number = 4,
            mini_icon = "Coil_5",
            skill_icon = "Coil",
            rarity = "purple",

            stun = 0.5,
            duration = 3,
        },
        ["modifier_puck_coil_6"] = 
        {
            skill_number = 4,
            mini_icon = "Coil_6",
            skill_icon = "Coil",
            rarity = "purple",

            is_perma = 1,
            mod_name = "modifier_custom_puck_dream_coil_cdr",
            cdr = 1,
            cd_items = -1,
            max = 10,
        },
        ["modifier_puck_coil_7"] = 
        {
            skill_number = 4,
            mini_icon = "Coil",
            skill_icon = "Coil",
            rarity = "orange",

            damage = 100,
            knock_distance = 140,
            skill_name = "custom_puck_dream_coil",
            radius = 450,
            knock_duration = 0.3,
            cd = 0.5,
            trigger_ability = "custom_puck_dream_coil",
            cd_inc = 40,
            mana = 6,
        },
    },

    npc_dota_hero_void_spirit = 
    {
        ["modifier_void_remnant_1"] = 
        {
            skill_number = 1,
            mini_icon = "Remnant_1",
            skill_icon = "Remnant",
            rarity = "blue",

            damage = {40, 60, 80},
            update_mod = "modifier_void_spirit_innate_custom",
            damage_bonus = {6, 9, 12},
        },
        ["modifier_void_remnant_2"] = 
        {
            skill_number = 1,
            mini_icon = "Remnant_2",
            skill_icon = "Remnant",
            rarity = "blue",

            evasion = {10, 15, 20},
            allow_illusion = 1,
            move = {20, 30, 40},
            update_mod = "modifier_void_spirit_innate_custom",
            bonus = 2,
            duration = 3,
        },
        ["modifier_void_remnant_3"] = 
        {
            skill_number = 1,
            mini_icon = "Remnant_3",
            skill_icon = "Remnant",
            rarity = "blue",

            stun = {0.2, 0.3, 0.4},
            duration = 6,
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_void_remnant_4"] = 
        {
            skill_number = 1,
            mini_icon = "Remnant_4",
            skill_icon = "Remnant",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            speed = {100, 150},
            range = {100, 150},
            stack = 2,
            cd = -0.3,
            update_mod = "modifier_custom_void_remnant_tracker",
            max = {2, 3},
            duration = 6,
        },
        ["modifier_void_remnant_5"] = 
        {
            skill_number = 1,
            mini_icon = "Remnant_5",
            skill_icon = "Remnant",
            rarity = "purple",
            has_video = 1,

            move = -80,
            duration = 2,
        },
        ["modifier_void_remnant_6"] = 
        {
            skill_number = 1,
            mini_icon = "Remnant_6",
            skill_icon = "Remnant",
            rarity = "purple",
            has_video = 1,

            heal = 15,
            stun = 1,
            cd = 12,
        },
        ["modifier_void_remnant_legendary"] = 
        {
            skill_number = 1,
            mini_icon = "Remnant",
            skill_icon = "Remnant",
            rarity = "orange",
            has_video = 1,

            is_through_bkb = 1,
            incoming = 300,
            move = 40,
            status = 70,
            skill_name = "void_spirit_aether_remnant_custom",
            update_mod = "modifier_custom_void_remnant_tracker",
            trigger_ability = "void_spirit_aether_remnant_custom_legendary",
            duration = 8,
        },
        ["modifier_void_astral_1"] = 
        {
            skill_number = 2,
            mini_icon = "Astral_1",
            skill_icon = "Astral",
            rarity = "blue",

            damage = {40, 60, 80},
            update_mod = "modifier_custom_void_dissimilate_tracker",
            duration = 8,
            resist = {-4, -6, -8},
            is_purgable_self = 1,
            max = 3,
        },
        ["modifier_void_astral_2"] = 
        {
            skill_number = 2,
            mini_icon = "Astral_2",
            skill_icon = "Astral",
            rarity = "blue",

            mana = {6, 9, 12},
            update_mod = "modifier_custom_void_dissimilate_tracker",
            duration = 4,
        },
        ["modifier_void_astral_3"] = 
        {
            skill_number = 2,
            mini_icon = "Astral_3",
            skill_icon = "Astral",
            rarity = "blue",

            cast = {-50, -75, -100},
            speed = {10, 15, 20},
            duration = 5,
        },
        ["modifier_void_astral_4"] = 
        {
            skill_number = 2,
            mini_icon = "Astral_4",
            skill_icon = "Astral",
            rarity = "purple",
            main_epic = 1,

            damage = {12, 20},
            is_perma = 1,
            stun = {0.8, 1.5},
            update_mod = "modifier_custom_void_dissimilate_spell",
            mod_name = "modifier_custom_void_dissimilate_spell",
            max = 20,
        },
        ["modifier_void_astral_5"] = 
        {
            skill_number = 2,
            mini_icon = "Astral_5",
            skill_icon = "Astral",
            rarity = "purple",
            has_video = 1,

            count = 1,
            slow = -40,
        },
        ["modifier_void_astral_6"] = 
        {
            skill_number = 2,
            mini_icon = "Astral_6",
            skill_icon = "Astral",
            rarity = "purple",

            cd_self = -2,
            cd_items = -0.8,
            cdr = 8,
        },
        ["modifier_void_astral_legendary"] = 
        {
            skill_number = 2,
            mini_icon = "Astral",
            skill_icon = "Astral",
            rarity = "orange",
            has_video = 1,

            damage = 75,
            interval = 1,
            effect_duration = 8,
            skill_name = "void_spirit_dissimilate_custom",
            update_mod = "modifier_custom_void_dissimilate_tracker",
            radius = 250,
            duration = 3,
        },
        ["modifier_void_pulse_1"] = 
        {
            skill_number = 3,
            mini_icon = "Pulse_1",
            skill_icon = "Pulse",
            rarity = "blue",

            heal = {10, 15, 20},
            creeps = 3,
            shield = {10, 15, 20},
        },
        ["modifier_void_pulse_2"] = 
        {
            skill_number = 3,
            mini_icon = "Pulse_2",
            skill_icon = "Pulse",
            rarity = "blue",

            speed = {20, 30, 40},
            slow = {-20, -30, -40},
            allow_illusion = 1,
            radius = 500,
            bonus = 2,
            update_mod = "modifier_void_spirit_innate_custom",
        },
        ["modifier_void_pulse_3"] = 
        {
            skill_number = 3,
            mini_icon = "Pulse_3",
            skill_icon = "Pulse",
            rarity = "blue",

            magic = {10, 15, 20},
            duration = 4,
            status = {10, 15, 20},
        },
        ["modifier_void_pulse_4"] = 
        {
            skill_number = 3,
            mini_icon = "Pulse_4",
            skill_icon = "Pulse",
            rarity = "purple",
            main_epic = 1,

            stats = {2, 3},
            cd = {-1.5, -3},
            update_mod = "modifier_void_spirit_resonant_tracker",
            max = 8,
            duration = 8,
        },
        ["modifier_void_pulse_5"] = 
        {
            skill_number = 3,
            mini_icon = "Pulse_5",
            skill_icon = "Pulse",
            rarity = "purple",
            has_video = 1,

            heal = 25,
            duration = 1,
        },
        ["modifier_void_pulse_6"] = 
        {
            skill_number = 3,
            mini_icon = "Pulse_6",
            skill_icon = "Pulse",
            rarity = "purple",
            has_video = 1,

            silence = 1.5,
            distance = 350,
            slow = -100,
            is_purgable_self = 1,
            duration = 0.2,
        },
        ["modifier_void_pulse_legendary"] = 
        {
            skill_number = 3,
            mini_icon = "Pulse",
            skill_icon = "Pulse",
            rarity = "orange",
            has_video = 1,

            damage = 60,
            update_mod = "modifier_void_spirit_resonant_tracker",
            skill_name = "void_spirit_resonant_pulse_custom",
            count = 1,
            cd = -50,
            max = 8,
        },
        ["modifier_void_step_1"] = 
        {
            skill_number = 4,
            mini_icon = "Step_1",
            skill_icon = "Step",
            rarity = "blue",

            is_through_bkb = 1,
            crit = {140, 170, 200},
            heal_reduce = {-20, -30, -40},
            duration = 3,
        },
        ["modifier_void_step_2"] = 
        {
            skill_number = 4,
            mini_icon = "Step_2",
            skill_icon = "Step",
            rarity = "blue",

            cd = {-2, -3, -4},
            update_mod = "modifier_void_spirit_astral_step_tracker",
            range = {80, 120, 160},
            alt_talent = "modifier_void_step_legendary",
        },
        ["modifier_void_step_3"] = 
        {
            skill_number = 4,
            mini_icon = "Step_3",
            skill_icon = "Step",
            rarity = "blue",

            heal = {10, 15, 20},
            update_mod = "modifier_void_spirit_astral_step_tracker",
            bonus = 3,
            creeps = 3,
        },
        ["modifier_void_step_4"] = 
        {
            skill_number = 4,
            mini_icon = "Step_4",
            skill_icon = "Step",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {3, 5},
            creeps = 300,
            update_mod = "modifier_void_spirit_astral_step_tracker",
            is_through_bkb = 1,
            damage_auto = {60, 100},
            attack = 2,
            max = 3,
            duration = 8,
        },
        ["modifier_void_step_5"] = 
        {
            skill_number = 4,
            mini_icon = "Step_5",
            skill_icon = "Step",
            rarity = "purple",
            has_video = 1,

            mana = -50,
            health = 50,
            stun = 1.5,
            break_duration = 3,
            is_through_bkb = 1,
            cd = 10,
        },
        ["modifier_void_step_6"] = 
        {
            skill_number = 4,
            mini_icon = "Step_6",
            skill_icon = "Step",
            rarity = "purple",
            has_video = 1,

            cast = -0.1,
            duration = 1.5,
            damage_reduce = -50,
            status = 50,
        },
        ["modifier_void_step_legendary"] = 
        {
            skill_number = 4,
            mini_icon = "Step",
            skill_icon = "Step",
            rarity = "orange",
            has_video = 1,

            duration = 4,
            is_through_bkb = 1,
            skill_name = "void_spirit_astral_step_custom",
            update_mod = "modifier_void_spirit_astral_step_tracker",
            cd = 16,
            trigger_ability = "void_spirit_astral_replicant",
        },
    },

    npc_dota_hero_ember_spirit = 
    {
        ["modifier_ember_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            slow = {-20, -30, -40},
            move = {30, 45, 60},
            bonus = 2,
            duration = 2,
            is_purgable_self = 1,
        },
        ["modifier_ember_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            armor = {8, 12, 16},
            magic = {8, 12, 16},
        },
        ["modifier_ember_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            health = {40, 60, 80},
            mana = {20, 30, 40},
            duration = 4,
        },

        ["modifier_ember_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            slow = -100,
            duration = 2,
            silence = 3,
            miss = 100,
            talent_cd = 12,
        },
        ["modifier_ember_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            shield = 10,
            heal = 10,
            duration = 2,
        },
        ["modifier_ember_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            status = 15,
            bkb = 2,
            cd = -3,
        },

        ["modifier_ember_chain_1"] = 
        {
            skill_number = 1,
            mini_icon = "Chain_1",
            skill_icon = "Chain",
            rarity = "blue",

            cleave = {20, 30, 40},
            armor = {-5, -7.5, -10},
            duration = 5,
        },
        ["modifier_ember_chain_2"] = 
        {
            skill_number = 1,
            mini_icon = "Chain_2",
            skill_icon = "Chain",
            rarity = "blue",

            duration = {0.4, 0.6, 0.8},
            cd = {-2, -3, -4},
        },
        ["modifier_ember_chain_3"] = 
        {
            skill_number = 1,
            mini_icon = "Chain_3",
            skill_icon = "Chain",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            chance = 25,
            heal = {60, 100},
            crit = {135, 160},
            bonus = 2,
        },
        ["modifier_ember_chain_4"] = 
        {
            skill_number = 1,
            mini_icon = "Chain_4",
            skill_icon = "Chain",
            rarity = "purple",
            has_video = 1,

            distance = 150,
            radius = 200,
            duration = 0.3,
            damage_reduce = -40,
            is_through_bkb = 1,
            trigger_ability = "ember_spirit_searing_chains_custom",
        },
        ["modifier_ember_chain_7"] = 
        {
            skill_number = 1,
            mini_icon = "Chain",
            skill_icon = "Chain",
            rarity = "orange",
            complexity = 1,
            has_video = 1,

            attacks = 3,
            damage = 50,
            damage_inc = 50,
            max = 4,
            cd_inc = 50,
            interval = 0.5,
            effect_duration = 15,
            mana = -50,
            skill_name = "ember_spirit_searing_chains_custom",
        },
        ["modifier_ember_fist_1"] = 
        {
            skill_number = 2,
            mini_icon = "Fist_1",
            skill_icon = "Fist",
            rarity = "blue",

            damage = {20, 30, 40},
            cd = {-0.8, -1.2, -1.6},
        },
        ["modifier_ember_fist_2"] = 
        {
            skill_number = 2,
            mini_icon = "Fist_2",
            skill_icon = "Fist",
            rarity = "blue",

            heal = {12, 18, 24},
            heal_reduce = {-10, -15, -20},
        },
        ["modifier_ember_fist_3"] = 
        {
            skill_number = 2,
            mini_icon = "Fist_3",
            skill_icon = "Fist",
            rarity = "purple",
            main_epic = 1,

            damage = {120, 200},
            chance = 50,
            magic = {-5, -8},
            max = 4,
            duration = 12,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_ember_fist_4"] = 
        {
            skill_number = 2,
            mini_icon = "Fist_4",
            skill_icon = "Fist",
            rarity = "purple",

            duration = 2,
            cd_items = -0.8,
            range = 150,
        },
        ["modifier_ember_fist_7"] = 
        {
            skill_number = 2,
            mini_icon = "Fist",
            skill_icon = "Fist",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            duration = 8,
            damage_inc = 10,
            damage_max = 25,
            min = 1,
            max = 3,
            damage = 30,
            effect_duration = 12,
            cd_inc = 5,
            distance = 300,
            chance = 60,
            interval = 0.15,
            skill_name = "ember_spirit_sleight_of_fist_custom",
        },
        ["modifier_ember_guard_1"] = 
        {
            skill_number = 3,
            mini_icon = "Guard_1",
            skill_icon = "Guard",
            rarity = "blue",

            damage = {20, 30, 40},
            burn = {12, 18, 24},
        },
        ["modifier_ember_guard_2"] = 
        {
            skill_number = 3,
            mini_icon = "Guard_2",
            skill_icon = "Guard",
            rarity = "blue",

            range = {50, 75, 100},
            shield = {6, 9, 12},
        },
        ["modifier_ember_guard_3"] = 
        {
            skill_number = 3,
            mini_icon = "Guard_3",
            skill_icon = "Guard",
            rarity = "purple",
            main_epic = 1,

            agi = {6, 10},
            str = {6, 10},
            bonus = 3,
            max = 10,
            duration = 6,
        },
        ["modifier_ember_guard_4"] = 
        {
            skill_number = 3,
            mini_icon = "Guard_4",
            skill_icon = "Guard",
            rarity = "purple",
            has_video = 1,

            duration = 4,
            talent_cd = 3,
            stun = 1.2,
            chance = 40,
            duration_legendary = 1,
            is_through_bkb = 1,
            is_basher = 1,
            alt_talent = "modifier_ember_guard_7"
        },
        ["modifier_ember_guard_7"] = 
        {
            skill_number = 3,
            mini_icon = "Guard",
            skill_icon = "Guard",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            speed = 50,
            duration = 3,
            damage_inc = 10,
            max = 20,
            shield_cd = 6,
            skill_name = "ember_spirit_flame_guard_custom",
        },
        ["modifier_ember_remnant_1"] = 
        {
            skill_number = 4,
            mini_icon = "FireRemnant_1",
            skill_icon = "FireRemnant",
            rarity = "blue",
            has_video = 1,

            damage = {40, 60, 80},
            interval = 0.5,
            linger = 1,
            duration = 6,
            radius = 230,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_ember_remnant_2"] = 
        {
            skill_number = 4,
            mini_icon = "FireRemnant_2",
            skill_icon = "FireRemnant",
            rarity = "blue",

            cd = {-4, -6, -8},
            mana = {-40, -60, -80},
        },
        ["modifier_ember_remnant_3"] = 
        {
            skill_number = 4,
            mini_icon = "FireRemnant_3",
            skill_icon = "FireRemnant",
            rarity = "purple",
            main_epic = 1,

            damage = {3, 5},
            spell = {2.5, 4},
            max = 8,
            duration = 5,
            creeps = {120, 200},
        },
        ["modifier_ember_remnant_4"] = 
        {
            skill_number = 4,
            mini_icon = "FireRemnant_4",
            skill_icon = "FireRemnant",
            rarity = "purple",
            has_video = 1,

            cdr = 10,
            range = 500,
            talent_cd = 24,
        },
        ["modifier_ember_remnant_7"] = 
        {
            skill_number = 4,
            mini_icon = "FireRemnant",
            skill_icon = "FireRemnant",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            talent_cd = 40,
            cast = 1.5,
            count = 6,
            radius = 400,
            cd_inc = -6,
            trigger_ability = "ember_spirit_fire_remnant_burst",
            skill_name = "ember_spirit_fire_remnant_custom",
        },
    },

    npc_dota_hero_pudge = 
    {
        ["modifier_pudge_hook_1"] = 
        {
            skill_number = 1,
            mini_icon = "hook_1",
            skill_icon = "hook",
            rarity = "blue",

            damage = {40, 60, 80},
            speed = {40, 60, 80},
            duration = 5,
        },
        ["modifier_pudge_hook_2"] = 
        {
            skill_number = 1,
            mini_icon = "hook_2",
            skill_icon = "hook",
            rarity = "blue",

            cast = {-30, -40, -50},
            range = {15, 20, 25},
            speed = {15, 20, 25},
        },
        ["modifier_pudge_hook_3"] = 
        {
            skill_number = 1,
            mini_icon = "hook_3",
            skill_icon = "hook",
            rarity = "blue",
            has_video = 1,

            mana = {-40, -60, -80},
            heal = {8, 12, 16},
            duration = 5,
        },
        ["modifier_pudge_hook_4"] = 
        {
            skill_number = 1,
            mini_icon = "hook_4",
            skill_icon = "hook",
            rarity = "purple",
            main_epic = 1,

            damage = {12, 20},
            is_perma = 1,
            cd = {-2, -3},
            mod_name = "modifier_custom_pudge_meat_hook_perma",
            max = 25,
        },
        ["modifier_pudge_hook_5"] = 
        {
            skill_number = 1,
            mini_icon = "hook_5",
            skill_icon = "hook",
            rarity = "purple",

            speed = 25,
            range = 80,
            slow = -25,
            vision = 10,
            duration = 3,
        },
        ["modifier_pudge_hook_6"] = 
        {
            skill_number = 1,
            mini_icon = "hook_6",
            skill_icon = "hook",
            rarity = "purple",
            has_video = 1,

            speed = -120,
            min_duration = 1,
            max_duration = 3,
            max_dist = 1200,
            is_purgable_self = 1,
        },
        ["modifier_pudge_hook_legendary"] = 
        {
            skill_number = 1,
            mini_icon = "hook",
            skill_icon = "hook",
            rarity = "orange",
            has_video = 1,

            damage = 10,
            duration = 15,
            angle = 5,
            is_through_bkb = 1,
            skill_name = "custom_pudge_meat_hook",
            count = 2,
            cd = -1,
            max = 5,
        },
        ["modifier_pudge_rot_1"] = 
        {
            skill_number = 2,
            mini_icon = "rot_1",
            skill_icon = "rot",
            rarity = "blue",

            radius = {60, 90, 120},
            slow = {-10, -15, -20},
        },
        ["modifier_pudge_rot_2"] = 
        {
            skill_number = 2,
            mini_icon = "rot_2",
            skill_icon = "rot",
            rarity = "blue",

            damage = {10, 15, 20},
            self_damage = {-10, -15, -20},
        },
        ["modifier_pudge_rot_3"] = 
        {
            skill_number = 2,
            mini_icon = "rot_3",
            skill_icon = "rot",
            rarity = "blue",

            move = {40, 60, 80},
            armor = {8, 12, 16},
            max = 8,
        },
        ["modifier_pudge_rot_4"] = 
        {
            skill_number = 2,
            mini_icon = "rot_4",
            skill_icon = "rot",
            rarity = "purple",
            main_epic = 1,

            creeps = 3,
            magic = {-25, -40},
            heal = {30, 50},
            timer = 4,
            duration = 3,
        },
        ["modifier_pudge_rot_5"] = 
        {
            skill_number = 2,
            mini_icon = "rot_5",
            skill_icon = "rot",
            rarity = "purple",
            has_video = 1,

            silence = 2.5,
            is_purgable_self = 1,
            timer = 4,
            mana = 2.5,
        },
        ["modifier_pudge_rot_6"] = 
        {
            skill_number = 2,
            mini_icon = "rot_6",
            skill_icon = "rot",
            rarity = "purple",

            shield = 15,
            max = 8,
            spell = -10,
            duration = 5,
        },
        ["modifier_pudge_rot_legendary"] = 
        {
            skill_number = 2,
            mini_icon = "rot",
            skill_icon = "rot",
            rarity = "orange",

            knock_duration = 0.2,
            cd = 4,
            status = 40,
            skill_name = "custom_pudge_rot",
            radius = 600,
            damage_inc = 1,
            max = 8,
        },
        ["modifier_pudge_flesh_1"] = 
        {
            skill_number = 3,
            mini_icon = "flesh_1",
            skill_icon = "flesh",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = {1, 1.5, 2},
        },
        ["modifier_pudge_flesh_2"] = 
        {
            skill_number = 3,
            mini_icon = "flesh_2",
            skill_icon = "flesh",
            rarity = "blue",

            heal = {8, 12, 16},
            bonus = 2,
            creeps = 3,
        },
        ["modifier_pudge_flesh_3"] = 
        {
            skill_number = 3,
            mini_icon = "flesh_3",
            skill_icon = "flesh",
            rarity = "blue",

            count = 30,
            spell = {1, 1.5, 2},
            str = {8, 12, 16},
        },
        ["modifier_pudge_flesh_4"] = 
        {
            skill_number = 3,
            mini_icon = "flesh_4",
            skill_icon = "flesh",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = 200,
            is_breakable = 1,
            cd = {6, 3},
            heal = 100,
            stun = 0.5,
        },
        ["modifier_pudge_flesh_5"] = 
        {
            skill_number = 3,
            mini_icon = "flesh_5",
            skill_icon = "flesh",
            rarity = "purple",

            is_breakable = 1,
            health = 40,
            max = 30,
            status = 10,
            bonus = 1,
            damage_reduce = 10,
        },
        ["modifier_pudge_flesh_6"] = 
        {
            skill_number = 3,
            mini_icon = "flesh_6",
            skill_icon = "flesh",
            rarity = "purple",

            speed = 850,
            distance = 80,
            range = 750,
            is_root_disabled = 1,
            stun = 1,
            height = 40,
            width = 150,
            duration = 0.25,
        },
        ["modifier_pudge_flesh_legendary"] = 
        {
            skill_number = 3,
            mini_icon = "flesh",
            skill_icon = "flesh",
            rarity = "orange",
            has_video = 1,

            speed = 200,
            is_through_bkb = 1,
            skill_name = "custom_pudge_flesh_heap",
            model = 25,
            bonus = 100,
            duration = 8,
        },
        ["modifier_pudge_dismember_1"] = 
        {
            skill_number = 4,
            mini_icon = "dismember_3",
            skill_icon = "dismember",
            rarity = "blue",

            heal = {10, 15, 20},
            str = {20, 30, 40},
        },
        ["modifier_pudge_dismember_2"] = 
        {
            skill_number = 4,
            mini_icon = "dismember_2",
            skill_icon = "dismember",
            rarity = "blue",

            damage = {-10, -15, -20},
            is_through_bkb = 1,
            heal = {-20, -30, -40},
            duration = 4,
        },
        ["modifier_pudge_dismember_3"] = 
        {
            skill_number = 4,
            mini_icon = "dismember_1",
            skill_icon = "dismember",
            rarity = "blue",

            cd = {-2, -3, -4},
            range = {80, 120, 160},
        },
        ["modifier_pudge_dismember_4"] = 
        {
            skill_number = 4,
            mini_icon = "dismember_4",
            skill_icon = "dismember",
            rarity = "purple",
            main_epic = 1,

            str = {30, 50},
            effect_duration = 10,
            duration = {0.8, 1.2},
            radius = 1000,
            stack_duration = 3,
            max = 5,
        },
        ["modifier_pudge_dismember_5"] = 
        {
            skill_number = 4,
            mini_icon = "dismember_6",
            skill_icon = "dismember",
            rarity = "purple",

            radius = 100,
            is_through_bkb = 1,
            duration = 2,
        },
        ["modifier_pudge_dismember_6"] = 
        {
            skill_number = 4,
            mini_icon = "dismember_5",
            skill_icon = "dismember",
            rarity = "purple",

            duration = 2,
            cd_items = 70,
            cdr = 10,
        },
        ["modifier_pudge_dismember_legendary"] = 
        {
            skill_number = 4,
            mini_icon = "dismember",
            skill_icon = "dismember",
            rarity = "orange",
            has_video = 1,

            is_blockable = 1,
            shield = 20,
            skill_name = "custom_pudge_dismember",
            is_through_bkb = 1,
            trigger_ability = "custom_pudge_dismember_devour",
            duration = 6,
        },
    },

    npc_dota_hero_hoodwink = 
    {
        ["modifier_hoodwink_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            range = {100, 150, 200},
            mana = {16, 24, 32},
        },
        ["modifier_hoodwink_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            heal = {6, 9, 12},
            str = {8, 12, 16},
            duration = 5,
        },
        ["modifier_hoodwink_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            magic = {12, 18, 24},
            status = {12, 18, 24},
        },

        ["modifier_hoodwink_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            silence = 2.5,
            slow = -50,
            is_purgable_self = 1,
            alt_talent = "modifier_hoodwink_bush_7",
        },
        ["modifier_hoodwink_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            chance = 20,
            duration = 5,
            shield = 20,
            health = 30,
            talent_cd = 15,
            is_breakable = 1,
        },
        ["modifier_hoodwink_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            invun = 1,
            invun_legendary = 1,
            bkb = 2,
            bkb_legendary = 1,
            alt_talent = "modifier_hoodwink_sharp_7"
        },

        ["modifier_hoodwink_acorn_1"] = 
        {
            skill_number = 1,
            mini_icon = "acorn_1",
            skill_icon = "acorn",
            rarity = "blue",

            chance = 20,
            damage = {140, 160, 180},
            bonus = 2,
        },
        ["modifier_hoodwink_acorn_2"] = 
        {
            skill_number = 1,
            mini_icon = "acorn_2",
            skill_icon = "acorn",
            rarity = "blue",

            heal = {12, 18, 24},
            cd = {-1, -1.5, -2},
        },
        ["modifier_hoodwink_acorn_3"] = 
        {
            skill_number = 1,
            mini_icon = "acorn_3",
            skill_icon = "acorn",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {12, 20},
            range = 200,
            count = {1, 2},
            cd = 6,
        },
        ["modifier_hoodwink_acorn_4"] = 
        {
            skill_number = 1,
            mini_icon = "acorn_4",
            skill_icon = "acorn",
            rarity = "purple",
            has_video = 1,

            cast = -0.1,
            max = 2,
            stun = 1,
            chance = 30,
            talent_cd = 3,
            is_basher = 1,
            is_through_bkb = 1,
        },
        ["modifier_hoodwink_acorn_7"] = 
        {
            skill_number = 1,
            mini_icon = "acorn",
            skill_icon = "acorn",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            cd_inc = 40,
            armor = -1.5,
            duration = 10,
            skill_name = "hoodwink_acorn_shot_custom",
            trigger_ability = "hoodwink_acorn_shot_custom",
        },
        ["modifier_hoodwink_bush_1"] = 
        {
            skill_number = 2,
            mini_icon = "bush_1",
            skill_icon = "bush",
            rarity = "blue",

            damage = {80, 120, 160},
            spell = {6, 9, 12},
        },
        ["modifier_hoodwink_bush_2"] = 
        {
            skill_number = 2,
            mini_icon = "bush_2",
            skill_icon = "bush",
            rarity = "blue",

            cd = {-2, -3, -4},
            stun = {0.2, 0.3, 0.4},
        },
        ["modifier_hoodwink_bush_3"] = 
        {
            skill_number = 2,
            mini_icon = "bush_3",
            skill_icon = "bush",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal = 50,
            damage = {3, 5},
            base = {30, 50},
            creeps = {120, 200},
            interval = 0.5,
            sharp = 3,
            max = 6,
            duration = 8,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_hoodwink_bush_4"] = 
        {
            skill_number = 2,
            mini_icon = "bush_4",
            skill_icon = "bush",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -12,
            heal_reduce = -12,
            duration = 25,
            health = 50,
            bonus = 2,
        },
        ["modifier_hoodwink_bush_7"] = 
        {
            skill_number = 2,
            mini_icon = "bush",
            skill_icon = "bush",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            max = 3,
            magic = -50,
            effect_duration = 8,
            talent_cd = 8,
            duration = 3,
            move = 25,
            stun_reduce = -40,
            stack_duration = 15,
            incoming = 200,
            range = 1500,
            trigger_ability = "hoodwink_decoy_custom",
            skill_name = "hoodwink_bushwhack_custom",
        },
        ["modifier_hoodwink_scurry_1"] = 
        {
            skill_number = 3,
            mini_icon = "scurry_1",
            skill_icon = "scurry",
            rarity = "blue",

            agi = {6, 9, 12},
            speed = {40, 60, 80},
            duration = 4,
        },
        ["modifier_hoodwink_scurry_2"] = 
        {
            skill_number = 3,
            mini_icon = "scurry_2",
            skill_icon = "scurry",
            rarity = "blue",

            move = {30, 45, 60},
            duration = {1, 1.5, 2},
        },
        ["modifier_hoodwink_scurry_3"] = 
        {
            skill_number = 3,
            mini_icon = "scurry_3",
            skill_icon = "scurry",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            range = {150, 250},
            duration = 4,
            attacks = {3, 5},
        },
        ["modifier_hoodwink_scurry_4"] = 
        {
            skill_number = 3,
            mini_icon = "scurry_4",
            skill_icon = "scurry",
            rarity = "purple",
            has_video = 1,

            chance = 10,
            range = 250,
            slow_resist = 30,
            talent_cd = 4,
            is_root_disabled = 1,
            trigger_ability = "hoodwink_scurry_custom",
        },
        ["modifier_hoodwink_scurry_7"] = 
        {
            skill_number = 3,
            mini_icon = "scurry",
            skill_icon = "scurry",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            distance = 850,
            bva = 1.5,
            damage = 50,
            heal = 3,
            duration = 4,
            damage_type = DAMAGE_TYPE_MAGICAL,
            skill_name = "hoodwink_scurry_custom",
        },
        ["modifier_hoodwink_sharp_1"] = 
        {
            skill_number = 4,
            mini_icon = "sharp_1",
            skill_icon = "sharp",
            rarity = "blue",

            heal = {10, 15, 20},
            damage = {300, 450, 600},
            max = 12,
            is_perma = 1,
            mod_name = "modifier_hoodwink_sharpshooter_custom_hits",
        },
        ["modifier_hoodwink_sharp_2"] = 
        {
            skill_number = 4,
            mini_icon = "sharp_2",
            skill_icon = "sharp",
            rarity = "blue",

            cd = {-2, -3, -4},
            speed = {20, 30, 40},
        },
        ["modifier_hoodwink_sharp_3"] = 
        {
            skill_number = 4,
            mini_icon = "sharp_3",
            skill_icon = "sharp",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            cast = {-20, -35},
            delay = 50,
            damage = {35, 60},
        },
        ["modifier_hoodwink_sharp_4"] = 
        {
            skill_number = 4,
            mini_icon = "sharp_4",
            skill_icon = "sharp",
            rarity = "purple",
            has_video = 1,

            cdr = 12,
            cd_items = -5,
            cd_items_legendary = -3,
            knock_max = 350,
            duration = 0.3,
            knock_range = 800,
            alt_talent = "modifier_hoodwink_sharp_7",
        },
        ["modifier_hoodwink_sharp_7"] = 
        {
            skill_number = 4,
            mini_icon = "sharp",
            skill_icon = "sharp",
            rarity = "orange",
            complexity = 2,
            has_video = 1,

            cd = -50,
            delay = -1,
            damage = -50,
            damage_inc = 50,
            max = 5,
            duration = 15,
            mana = -50,
            skill_name = "hoodwink_sharpshooter_custom",
        },
    },
    
    npc_dota_hero_skeleton_king = 
    {
        ["modifier_skeleton_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            skill_icon = "vampiric",
            rarity = "blue",

            range = {100, 150, 200},
            stun = {0.3, 0.45, 0.6},
        },
        ["modifier_skeleton_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            heal_amp = {6, 9, 12},
            heal = {8, 12, 16},
        },
        ["modifier_skeleton_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            move = {6, 9, 12},
            status = {6, 9, 12},
            bonus = 2,
        },


        ["modifier_skeleton_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",

            damage_reduce = -20,
            heal_reduce = -20,
        },
        ["modifier_skeleton_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,
            has_video = 1,

            magic = 15,
            heal = 8,
            heal_legendary = 5,
            talent_cd = 10,
            bkb = 2.5,
            alt_talent = "modifier_skeleton_strike_7"
        },
        ["modifier_skeleton_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,
            has_video = 1,

            fear = 1.5,
            delay = -1,
            distance = 600,
            duration = 0.4,
            move = 550,
            move_duration = 1.5,
            is_through_bkb = 1,
        },


        ["modifier_skeleton_blast_1"] = 
        {
            skill_number = 1,
            mini_icon = "blast_1",
            skill_icon = "blast",
            rarity = "blue",

            spell = {6, 9, 12},
            damage = {80, 120, 160},
        },
        ["modifier_skeleton_blast_2"] = 
        {
            skill_number = 1,
            mini_icon = "blast_2",
            skill_icon = "blast",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            cast = {-0.1, -0.15, -0.2},
        },
        ["modifier_skeleton_blast_3"] = 
        {
            skill_number = 1,
            mini_icon = "blast_3",
            skill_icon = "blast",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {40, 70},
            heal = 75,
            burn_duration = 5,
            interval = 1,
            duration = 3,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_skeleton_blast_4"] = 
        {
            skill_number = 1,
            mini_icon = "blast_4",
            skill_icon = "blast",
            rarity = "purple",
            has_video = 1,

            silence = 1.5,
            duration = 0.3,
            max_dist = 450,
            is_purgable_self = 1,
            trigger_ability = "skeleton_king_hellfire_blast_custom",
        },
        ["modifier_skeleton_blast_7"] = 
        {
            skill_number = 1,
            mini_icon = "blast",
            skill_icon = "blast",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            duration = 6,
            damage = 45,
            talent_cd = 6,
            trigger_ability = "skeleton_king_hellfire_blast_custom_legendary",
            skill_name = "skeleton_king_hellfire_blast_custom",
        },
        ["modifier_skeleton_vampiric_1"] = 
        {
            skill_number = 2,
            mini_icon = "vampiric_1",
            skill_icon = "vampiric",
            rarity = "blue",

            cd = {-4, -6, -8},
            shield = {12, 18, 24},
        },
        ["modifier_skeleton_vampiric_2"] = 
        {
            skill_number = 2,
            mini_icon = "vampiric_2",
            skill_icon = "vampiric",
            rarity = "blue",

            attack = {20, 30, 40},
            damage = {50, 75, 100},
            radius = 400,
            damage_type = DAMAGE_TYPE_PHYSICAL,
        },
        ["modifier_skeleton_vampiric_3"] = 
        {
            skill_number = 2,
            mini_icon = "vampiric_3",
            skill_icon = "vampiric",
            rarity = "purple",
            main_epic = 1,

            armor = {-12, -20},
            duration = 8,
            max = 50,
            crit = 5,
        },
        ["modifier_skeleton_vampiric_4"] = 
        {
            skill_number = 2,
            mini_icon = "vampiric_4",
            skill_icon = "vampiric",
            rarity = "purple",
            has_video = 1,

            health = 40,
            radius = 700,
            move = 30,
            slow_resist = 30,
            damage_reduce = -30,
        },
        ["modifier_skeleton_vampiric_7"] = 
        {
            skill_number = 2,
            mini_icon = "vampiric",
            skill_icon = "vampiric",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            count = 4,
            damage = 60,
            max = 200,
            stack_init = 150,
            duration = 12,
            skill_name = "skeleton_king_vampiric_aura_custom",
        },
        ["modifier_skeleton_strike_1"] = 
        {
            skill_number = 3,
            mini_icon = "strike_1",
            skill_icon = "strike",
            rarity = "blue",

            speed = {16, 24, 32},
            max = 3,
            duration = 8,
            radius = 800,
        },
        ["modifier_skeleton_strike_2"] = 
        {
            skill_number = 3,
            mini_icon = "strike_2",
            skill_icon = "strike",
            rarity = "blue",

            slow = {-16, -24, -32},
            duration = 3,
            range = {50, 75, 100},
            range_skelet = {30, 45, 60},
        },
        ["modifier_skeleton_strike_3"] = 
        {
            skill_number = 3,
            mini_icon = "strike_3",
            skill_icon = "strike",
            rarity = "purple",
            main_epic = 1,

            cd = {-1.5, -2.5},
            chance = {12, 20},
            delay = 3,
            damage = {18, 30},
            damage_type = DAMAGE_TYPE_PURE,
            is_through_bkb = 1,
            alt_talent = "modifier_skeleton_strike_7"
        },
        ["modifier_skeleton_strike_4"] = 
        {
            skill_number = 3,
            mini_icon = "strike_4",
            skill_icon = "strike",
            rarity = "purple",
            has_video = 1,

            root = 2,
            talent_cd = 8,
            is_through_bkb = 1,
            is_purgable_self = 1,
        },
        ["modifier_skeleton_strike_7"] = 
        {
            skill_number = 3,
            mini_icon = "strike",
            skill_icon = "strike",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            chance = 40,
            damage = -30,
            mark_duration = 12,
            talent_cd = 12,
            crit = 140,
            duration = 8,
            skill_name = "skeleton_king_mortal_strike_custom",
        },
        ["modifier_skeleton_reincarnation_1"] = 
        {
            skill_number = 4,
            mini_icon = "reincarnation_1",
            skill_icon = "reincarnation",
            rarity = "blue",

            base = {10, 15, 20},
            damage = {1.6, 2.4, 3.2},
            interval = 0.5,
            radius = 600,
            creeps = 2,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_skeleton_reincarnation_2"] = 
        {
            skill_number = 4,
            mini_icon = "reincarnation_2",
            skill_icon = "reincarnation",
            rarity = "blue",

            shield = {6, 9, 12},
            bonus = 100,
            talent_cd = 10,
        },
        ["modifier_skeleton_reincarnation_3"] = 
        {
            skill_number = 4,
            mini_icon = "reincarnation_3",
            skill_icon = "reincarnation",
            rarity = "purple",
            main_epic = 1,

            str = {2.5, 4},
            magic = {-2.5, -4},
            max = 10,
            stun = 2,
            radius = 600,
            duration = 10,
        },
        ["modifier_skeleton_reincarnation_4"] = 
        {
            skill_number = 4,
            mini_icon = "reincarnation_4",
            skill_icon = "reincarnation",
            rarity = "purple",

            cdr = 2,
            cd = -5,
            max = 10,
            is_perma = 1,
            mod_name = "modifier_skeleton_king_reincarnation_custom_perma",
        },
        ["modifier_skeleton_reincarnation_7"] = 
        {
            skill_number = 4,
            mini_icon = "reincarnation",
            skill_icon = "reincarnation",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            heal = 30,
            cd_inc = 50,
            duration = 3,
            slow = -50,
            move = 15,
            base = 200,
            radius = 400,
            damage = 100,
            talent_cd = 20,
            damage_type = DAMAGE_TYPE_MAGICAL,
            skill_name = "skeleton_king_reincarnation_custom",
            trigger_ability = "skeleton_king_reincarnation_custom_legendary",
        },
    },

    npc_dota_hero_lina = 
    {
        ["modifier_lina_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            range = {120, 180, 240},
            mana = {12, 18, 24},
        },
        ["modifier_lina_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            magic = {6, 9, 12},
            move = {30, 45, 60},
        },
        ["modifier_lina_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            health = {6, 9, 12},
            mana = {5, 7.5, 10},
            count = 4,
            duration = 8,
        },

        ["modifier_lina_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            status = 15,
            heal = 50,
            duration = 5,
            health_loss = 40,
            talent_cd = 20,
            is_breakable = 1,
        },
        ["modifier_lina_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            move = 1.5,
            cd = 10,
            range = 450,
            range_legendary = 350,
            speed = 1350,
            is_root_disabled = 1,
            alt_talent = "modifier_lina_soul_7"
        },
        ["modifier_lina_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            skill_icon = "array",
            rarity = "purple",

            cast = -0.3,
            radius = 50,
            cdr = 15,
            max = 25,
            is_perma = 1,
            mod_name = "modifier_lina_light_strike_array_custom_cdr",
        },

        ["modifier_lina_dragon_1"] = 
        {
            skill_number = 1,
            mini_icon = "dragon_1",
            skill_icon = "dragon",
            rarity = "blue",

            spell = {4, 6, 8},
            damage = {60, 90, 120},
        },
        ["modifier_lina_dragon_2"] = 
        {
            skill_number = 1,
            mini_icon = "dragon_2",
            skill_icon = "dragon",
            rarity = "blue",
            has_video = 1,

            cd = {-1, -1.5, -2},
            slow = {-40, -60, -80},
            duration = 1,
            is_purgable_self = 1,
        },
        ["modifier_lina_dragon_3"] = 
        {
            skill_number = 1,
            mini_icon = "dragon_3",
            skill_icon = "dragon",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal = {30, 50},
            damage = {6, 10},
        },
        ["modifier_lina_dragon_4"] = 
        {
            skill_number = 1,
            mini_icon = "dragon_4",
            skill_icon = "dragon",
            rarity = "purple",
            has_video = 1,

            count = 4,
            duration = 8,
            range = 900,
            damage = 75,
            cd_items = -1.2,
        },
        ["modifier_lina_dragon_7"] = 
        {
            skill_number = 1,
            mini_icon = "dragon",
            skill_icon = "dragon",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            count = 5,
            linger = 3,
            radius = 1000,
            cd = -85,
            cast = -50,
            duration = 6,
            status = 50,
            mana = -30,
            skill_name = "lina_dragon_slave_custom",
        },
        ["modifier_lina_array_1"] = 
        {
            skill_number = 2,
            mini_icon = "array_1",
            skill_icon = "array",
            rarity = "blue",

            int = {6, 9, 12},
            chance = 40,
            damage = {30, 45, 60},
            radius = 250,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_lina_array_2"] = 
        {
            skill_number = 2,
            mini_icon = "array_2",
            skill_icon = "array",
            rarity = "blue",

            range = {100, 150, 200},
            heal = {12, 18, 24},
        },
        ["modifier_lina_array_3"] = 
        {
            skill_number = 2,
            mini_icon = "array_3",
            skill_icon = "array",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            cd = {-1, -2},
            max = 3,
            damage = {60, 100},
            duration = 6,
            interval = 0.2,
        },
        ["modifier_lina_array_4"] = 
        {
            skill_number = 2,
            mini_icon = "array_4",
            skill_icon = "array",
            rarity = "purple",
            has_video = 1,

            speed = 300,
            root = 2,
            damage = 100,
            ticks = 3,
            talent_cd = 10,
            is_purgable_self = 1,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_lina_array_7"] = 
        {
            skill_number = 2,
            mini_icon = "array",
            skill_icon = "array",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            max = 12,
            duration = 15,
            cd_inc = -50,
            damage = 75,
            range = 200,
            effect_duration = 8,
            duration_k = 2,
            heal = 75,
            talent_cd = 6,
            skill_name = "lina_light_strike_array_custom",
            trigger_ability = "lina_light_strike_array_custom_legendary",
        },

        ["modifier_lina_soul_1"] = 
        {
            skill_number = 3,
            mini_icon = "soul_1",
            skill_icon = "soul",
            rarity = "blue",

            duration = 3,
            slow = {-20, -30, -40},
            speed = {6, 9, 12},
        },
        ["modifier_lina_soul_2"] = 
        {
            skill_number = 3,
            mini_icon = "soul_2",
            skill_icon = "soul",
            rarity = "blue",

            armor = {1, 1.5, 2},
            armor_reduce = {-4, -6, -8},
            duration = 3,
            max = 12,
        },
        ["modifier_lina_soul_3"] = 
        {
            skill_number = 3,
            mini_icon = "soul_3",
            skill_icon = "soul",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {8, 15},
            duration = 2,
            crit = {125, 140},
        },
        ["modifier_lina_soul_4"] = 
        {
            skill_number = 3,
            mini_icon = "soul_4",
            skill_icon = "soul",
            rarity = "purple",
            has_video = 1,

            heal = 50,
            damage_reduce = -2,
            str = 2,
            duration = 8,
            max = 10,
        },
        ["modifier_lina_soul_7"] = 
        {
            skill_number = 3,
            mini_icon = "soul",
            skill_icon = "soul",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            damage = 35,
            mana = 25,
            range = 550,
            cast = 3,
            knock_max = 350,
            talent_cd = 3.5,
            min_distance = 100,
            attacks = 2,
            duration = 0.3,
            stack = 2,
            stack_duration = 10,
            skill_name = "lina_fiery_soul_custom",
        },

        ["modifier_lina_laguna_1"] = 
        {
            skill_number = 4,
            mini_icon = "laguna_1",
            skill_icon = "laguna",
            rarity = "blue",

            spell = {4, 6, 8},
            damage = {4, 6, 8},
        },
        ["modifier_lina_laguna_2"] = 
        {
            skill_number = 4,
            mini_icon = "laguna_2",
            skill_icon = "laguna",
            rarity = "blue",

            heal = {12, 18, 24},
            heal_reduce = {-12, -18, -24},
            duration = 4,
        },
        ["modifier_lina_laguna_3"] = 
        {
            skill_number = 4,
            mini_icon = "laguna_3",
            skill_icon = "laguna",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            magic = {-20, -35},
            max = 10,
            duration = 6,
            delay = 3,
            damage = {20, 35},
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_lina_laguna_4"] = 
        {
            skill_number = 4,
            mini_icon = "laguna_4",
            skill_icon = "laguna",
            rarity = "purple",
            has_video = 1,

            chance = 50,
            shield = 12,
            shield_duration = 5,
            slow_resist = 30,
            cast = -0.15,
            talent_cd = 3,
        },
        ["modifier_lina_laguna_7"] = 
        {
            skill_number = 4,
            mini_icon = "laguna",
            skill_icon = "laguna",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            duration = 2,
            move = 15,
            move_max = 750,
            damage = 10,
            damage_inc = 15,
            max = 20,
            distance = 320,
            radius = 700,
            aoe = 180,
            turn = 50,
            stack_duration = 10,
            skill_name = "lina_laguna_blade_custom",
        },
    },

    npc_dota_hero_troll_warlord = 
    {
        ["modifier_troll_rage_1"] = 
        {
            skill_number = 1,
            mini_icon = "rage_1",
            skill_icon = "rage",
            rarity = "blue",

            damage = {40, 60, 80},
            aoe = 400,
            range = {60, 90, 120},
            update_mod = "modifier_troll_warlord_berserkers_rage_tracker",
            bonus = 2,
        },
        ["modifier_troll_rage_2"] = 
        {
            skill_number = 1,
            mini_icon = "rage_2",
            skill_icon = "rage",
            rarity = "blue",

            cd = {-0.6, -0.9, -1.2},
            update_mod = "modifier_troll_warlord_berserkers_rage_tracker",
            chance = {6, 9, 12},
        },
        ["modifier_troll_rage_3"] = 
        {
            skill_number = 1,
            mini_icon = "rage_3",
            skill_icon = "rage",
            rarity = "blue",

            damage = {10, 15, 20},
            update_mod = "modifier_troll_warlord_berserkers_rage_tracker",
            heal = 50,
        },
        ["modifier_troll_rage_4"] = 
        {
            skill_number = 1,
            mini_icon = "rage_4",
            skill_icon = "rage",
            rarity = "purple",
            main_epic = 1,

            damage = {60, 100},
            is_perma = 1,
            mod_name = "modifier_troll_warlord_berserkers_rage_custom_agi_perma",
            agi = {25, 40},
            max = 25,
        },
        ["modifier_troll_rage_5"] = 
        {
            skill_number = 1,
            mini_icon = "rage_5",
            skill_icon = "rage",
            rarity = "purple",

            is_breakable = 1,
            health = 40,
            move = 40,
            update_mod = "modifier_troll_warlord_berserkers_rage_tracker",
            damage_reduce = -12,
        },
        ["modifier_troll_rage_6"] = 
        {
            skill_number = 1,
            mini_icon = "rage_6",
            skill_icon = "rage",
            rarity = "purple",

            health = 50,
            cd = 10,
            break_duration = 3,
            slow = -80,
            slow_duration = 2,
        },
        ["modifier_troll_rage_legendary"] = 
        {
            skill_number = 1,
            mini_icon = "rage",
            skill_icon = "rage",
            rarity = "orange",
            has_video = 1,

            speed = 1700,
            skill_name = "troll_warlord_berserkers_rage_custom",
            is_root_disabled = 1,
            trigger_ability = "troll_warlord_berserkers_rage_custom",
            agility = 10,
            max = 3,
            range = 450,
            root = 50,
            allow_illusion = 1,
            cd = 10,
            cd_inc = 0.6,
            duration = 3,
        },
        ["modifier_troll_axes_1"] = 
        {
            skill_number = 2,
            mini_icon = "axes_1",
            skill_icon = "axes",
            rarity = "blue",

            cd = {-2, -3, -4},
            mana = {-20, -30, -40},
        },
        ["modifier_troll_axes_2"] = 
        {
            skill_number = 2,
            mini_icon = "axes_2",
            skill_icon = "axes",
            rarity = "blue",

            magic = {8, 12, 16},
            update_mod = "modifier_troll_warlord_whirling_axes_tracker",
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_troll_axes_3"] = 
        {
            skill_number = 2,
            mini_icon = "axes_3",
            skill_icon = "axes",
            rarity = "blue",

            speed = {30, 45, 60},
            is_purgable = 1,
            damage = {50, 75, 100},
            duration = 3,
        },
        ["modifier_troll_axes_4"] = 
        {
            skill_number = 2,
            mini_icon = "axes_4",
            skill_icon = "axes",
            rarity = "purple",
            main_epic = 1,

            damage = {4, 6},
            duration = 10,
            heal_reduce = {-6, -10},
            max = 4,
        },
        ["modifier_troll_axes_5"] = 
        {
            skill_number = 2,
            mini_icon = "axes_5",
            skill_icon = "axes",
            rarity = "purple",
            has_video = 1,

            silence = 2,
            distance = 350,
            slow = -10,
            cd = 8,
            is_purgable_self = 1,
            duration = 0.2,
        },
        ["modifier_troll_axes_6"] = 
        {
            skill_number = 2,
            mini_icon = "axes_6",
            skill_icon = "axes",
            rarity = "purple",
            has_video = 1,

            move = 25,
            duration = 3,
            shield = 15,
        },
        ["modifier_troll_axes_legendary"] = 
        {
            skill_number = 2,
            mini_icon = "axes",
            skill_icon = "axes",
            rarity = "orange",
            has_video = 1,

            damage = 130,
            skill_name = "troll_warlord_whirling_axes_melee_custom",
            radius = 250,
            trigger_ability = "troll_warlord_whirling_axes_melee_custom",
            stun = 1,
            cd = -50,
            update_mod = "modifier_troll_warlord_whirling_axes_tracker",
            max = 5,
            duration = 6,
        },
        ["modifier_troll_fervor_1"] = 
        {
            skill_number = 3,
            mini_icon = "fervor_1",
            skill_icon = "fervor",
            rarity = "blue",

            move = {6, 9, 12},
            update_mod = "modifier_troll_warlord_fervor_custom",
            bonus = 2,
            status = {6, 9, 12},
        },
        ["modifier_troll_fervor_2"] = 
        {
            skill_number = 3,
            mini_icon = "fervor_2",
            skill_icon = "fervor",
            rarity = "blue",

            speed = {2, 3, 4},
            stack = {2, 3, 4},
            allow_illusion = 1,
        },
        ["modifier_troll_fervor_3"] = 
        {
            skill_number = 3,
            mini_icon = "fervor_3",
            skill_icon = "fervor",
            rarity = "blue",

            armor = 1,
            duration = 8,
            max = {4, 6, 8},
        },
        ["modifier_troll_fervor_4"] = 
        {
            skill_number = 3,
            mini_icon = "fervor_4",
            skill_icon = "fervor",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            creeps = 3,
            is_through_bkb = 1,
            is_basher = 1,
            update_mod = "modifier_troll_warlord_fervor_custom",
            chance = {2, 3},
            stun = 1,
            crit = {160, 220},
            cd = 2.5,
            heal = 50,
        },
        ["modifier_troll_fervor_5"] = 
        {
            skill_number = 3,
            mini_icon = "fervor_5",
            skill_icon = "fervor",
            rarity = "purple",
            has_video = 1,

            str = 12,
            is_breakable = 1,
            cd = 8,
            update_mod = "modifier_troll_warlord_fervor_custom",
            bonus = 2,
            bkb = 2,
        },
        ["modifier_troll_fervor_6"] = 
        {
            skill_number = 3,
            mini_icon = "fervor_6",
            skill_icon = "fervor",
            rarity = "purple",

            bva = -0.2,
            update_mod = "modifier_troll_warlord_fervor_custom",
            cd_items = 100,
            duration = 4,
        },
        ["modifier_troll_fervor_legendary"] = 
        {
            skill_number = 3,
            mini_icon = "fervor",
            skill_icon = "fervor",
            rarity = "orange",
            has_video = 1,

            damage = 16,
            stun = 0.5,
            cd = 12,
            linger = 8,
            skill_name = "troll_warlord_fervor_custom",
            update_mod = "modifier_troll_warlord_fervor_custom",
            timer = 2,
            duration = 8,
        },
        ["modifier_troll_trance_1"] = 
        {
            skill_number = 4,
            mini_icon = "trance_1",
            skill_icon = "trance",
            rarity = "blue",

            cd = {-10, -15, -20},
            update_mod = "modifier_troll_warlord_battle_trance_custom_tracker",
            health = {300, 450, 600},
        },
        ["modifier_troll_trance_2"] = 
        {
            skill_number = 4,
            mini_icon = "trance_2",
            skill_icon = "trance",
            rarity = "blue",

            heal = {20, 30, 40},
            update_mod = "modifier_troll_warlord_battle_trance_custom_tracker",
            creeps = 3,
        },
        ["modifier_troll_trance_3"] = 
        {
            skill_number = 4,
            mini_icon = "trance_3",
            skill_icon = "trance",
            rarity = "blue",

            damage = {40, 60, 80},
            update_mod = "modifier_troll_warlord_battle_trance_custom_tracker",
            slow = {-30, -45, -60},
            chance = 40,
            radius = 300,
            bonus = 2,
            duration = 1,
        },
        ["modifier_troll_trance_4"] = 
        {
            skill_number = 4,
            mini_icon = "trance_4",
            skill_icon = "trance",
            rarity = "purple",
            main_epic = 1,

            damage = {20, 35},
            linger = 5,
            duration = {1, 2},
        },
        ["modifier_troll_trance_5"] = 
        {
            skill_number = 4,
            mini_icon = "trance_5",
            skill_icon = "trance",
            rarity = "purple",
            has_video = 1,

            heal = 15,
            cd = 30,
            is_breakable = 1,
            duration = 2,
        },
        ["modifier_troll_trance_6"] = 
        {
            skill_number = 4,
            mini_icon = "trance_6",
            skill_icon = "trance",
            rarity = "purple",
            has_video = 1,

            move = 50,
            move_real = 600,
            count = 1,
        },
        ["modifier_troll_trance_legendary"] = 
        {
            skill_number = 4,
            mini_icon = "trance",
            skill_icon = "trance",
            rarity = "orange",

            damage = 10,
            interval = 0.5,
            cost = 4,
            skill_name = "troll_warlord_battle_trance_custom",
            radius = 500,
            cd_inc = 6,
        },
    },

    npc_dota_hero_axe = 
    {
        ["modifier_axe_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            heal_reduce = {-12, -18, -24},
            heal_inc = {8, 12, 16},
            duration = 5,
            is_through_bkb = 1,
        },
        ["modifier_axe_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            move = {20, 30, 40},
            status = {10, 15, 20},
            bonus = 2,
        },
        ["modifier_axe_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            armor = {8, 12, 16},
            magic = {12, 18, 24},
            max = 3,
            duration = 8,
        },

        ["modifier_axe_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -30,
            talent_cd = 15,
            duration = 1.2,
            radius = 700,
        },
        ["modifier_axe_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",

            shield = 15,
            duration = 5,
            health = 50,
            talent_cd = 15,
            cd_inc = -1,
            is_breakable = 1,
        },
        ["modifier_axe_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            skill_icon = "culling",

            cdr = 8,
            heal = 0.5,
            max = 10,
            bonus = 2,
            is_perma = 1,
            mod_name = "modifier_axe_coat_of_blood_custom",
        },


        ["modifier_axe_call_1"] = 
        {
            skill_number = 1,
            mini_icon = "call_1",
            skill_icon = "call",
            rarity = "blue",

            speed = {30, 45, 60},
            bonus = 2,
            duration = 2,
        },
        ["modifier_axe_call_2"] = 
        {
            skill_number = 1,
            mini_icon = "call_2",
            skill_icon = "call",
            rarity = "blue",

            range = {50, 75, 100},
            duration = {0.3, 0.45, 0.6},
        },
        ["modifier_axe_call_3"] = 
        {
            skill_number = 1,
            mini_icon = "call_3",
            skill_icon = "call",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            chance = 30,
            crit = {150, 200},
            armor = {-5, -8},
            duration = 12,
            max = 3,
        },
        ["modifier_axe_call_4"] = 
        {
            skill_number = 1,
            mini_icon = "call_4",
            skill_icon = "call",
            rarity = "purple",
            has_video = 1,

            cast = -0.3,
            mana = 0,
            cd_inc = -5,
        },
        ["modifier_axe_call_7"] = 
        {
            skill_number = 1,
            mini_icon = "call",
            skill_icon = "call",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            interval = 1,
            heal = 200,
            cost = 4,
            damage = 110,
            radius = 500,
            move = 20,
            talent_cd = 3,
            trigger_ability = "axe_berserkers_call_custom_legendary",
            skill_name = "axe_berserkers_call_custom",
        },
        ["modifier_axe_hunger_1"] = 
        {
            skill_number = 2,
            mini_icon = "hunger_1",
            skill_icon = "hunger",
            rarity = "blue",

            spell = {8, 12, 16},
            damage = {8, 12, 16},
        },
        ["modifier_axe_hunger_2"] = 
        {
            skill_number = 2,
            mini_icon = "hunger_2",
            skill_icon = "hunger",
            rarity = "blue",

            slow = {-10, -15, -20},
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_axe_hunger_3"] = 
        {
            skill_number = 2,
            mini_icon = "hunger_3",
            skill_icon = "hunger",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            base = {25, 40},
            damage = {2.5, 4},
            chance = 30,
            talent_cd = 2,
            heal = {20, 35},
            damage_type = DAMAGE_TYPE_PURE,
        },
        ["modifier_axe_hunger_4"] = 
        {
            skill_number = 2,
            mini_icon = "hunger_4",
            skill_icon = "hunger",
            rarity = "purple",
            has_video = 1,

            cd = 6,
            silence = 2,
            distance = 350,
            range = 750,
            knock_duration = 0.3,
        },
        ["modifier_axe_hunger_7"] = 
        {
            skill_number = 2,
            mini_icon = "hunger",
            skill_icon = "hunger",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            damage = 3,
            max = 20,
            radius = 500,
            duration = 4,
            skill_name = "axe_battle_hunger_custom",
        },
        ["modifier_axe_helix_1"] = 
        {
            skill_number = 3,
            mini_icon = "helix_1",
            skill_icon = "helix",
            rarity = "blue",

            base = {6, 9, 12},
            health = {0.6, 0.9, 1.2},        
        },
        ["modifier_axe_helix_2"] = 
        {
            skill_number = 3,
            mini_icon = "helix_2",
            skill_icon = "helix",
            rarity = "blue",

            radius = {40, 60, 80},
            base = {6, 9, 12},
            heal = {0.6, 0.9, 1.2},      
        },
        ["modifier_axe_helix_3"] = 
        {
            skill_number = 3,
            mini_icon = "helix_3",
            skill_icon = "helix",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            health = {1.8, 3},
            health_reduce = {-1.8, -3},
            max = 10,
            duration = 8,
            duration_creeps = 3,
        },
        ["modifier_axe_helix_4"] = 
        {
            skill_number = 3,
            mini_icon = "helix_4",
            skill_icon = "helix",
            rarity = "purple",
            has_video = 1,

            move = 25,
            radius = 500,
            slow_resist = 50,
            cd_items = -0.3,
            duration = 3,
        },
        ["modifier_axe_helix_7"] = 
        {
            skill_number = 3,
            mini_icon = "helix",
            skill_icon = "helix",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            duration = 3,
            talent_cd = 10,
            damage = 350,
            interval = 0.25,
            max = 10,
            status = 70,
            skill_name = "axe_counter_helix_custom",
        },
        ["modifier_axe_culling_1"] = 
        {
            skill_number = 4,
            mini_icon = "culling_1",
            skill_icon = "culling",
            rarity = "blue",

            slow = {-20, -30, -40},
            damage = {50, 75, 100},
            duration = 4,
            interval = 1,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            is_through_bkb = 1,
        },
        ["modifier_axe_culling_2"] = 
        {
            skill_number = 4,
            mini_icon = "culling_2",
            skill_icon = "culling",
            rarity = "blue",

            heal = {12, 18, 24},
            health = 50,
            bonus = 2,
        },
        ["modifier_axe_culling_3"] = 
        {
            skill_number = 4,
            mini_icon = "culling_3",
            skill_icon = "culling",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {12, 20},
            damage_stack = {12, 20},
            max = 12,
            duration = 8,
        },
        ["modifier_axe_culling_4"] = 
        {
            skill_number = 4,
            mini_icon = "culling_4",
            skill_icon = "culling",
            rarity = "purple",
            has_video = 1,

            health = 50,
            radius = 1000,
            root = 2,
            bkb = 2,
            cd_inc = 2,
            talent_cd = 12,
            is_through_bkb = 1,
            is_purgable_self = 1,
        },
        ["modifier_axe_culling_7"] = 
        {
            skill_number = 4,
            mini_icon = "culling",
            skill_icon = "culling",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            attacks = 3,
            health = 50,
            cd_low = 2,
            damage = 80,
            trigger_ability = "axe_culling_blade_custom_legendary",
            is_blockable = 1,
            is_through_bkb = 1,
            talent_cd = 10,
            skill_name = "axe_culling_blade_custom",
        },
    },

    npc_dota_hero_alchemist = 
    {
        ["modifier_alchemist_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            slow = {-16, -24, -32},
            heal_reduce = {-15, -20, -25},
            is_through_bkb = 1,
        },
        ["modifier_alchemist_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",
            has_video = 1,

            shield = {12, 18, 24},
        },
        ["modifier_alchemist_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            duration = {4, 6, 8},
            cd = {-4, -6, -8}
        },

        ["modifier_alchemist_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",

            magic = 15,
            heal = 1.5,
            status = 20,
        },
        ["modifier_alchemist_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            resist = 30,
            range = 350,
            move = 15,
            status = 15,
            duration = 0.25,
            is_root_disabled = 1,
            trigger_ability = "alchemist_unstable_concoction_custom"
        },
        ["modifier_alchemist_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            skill_icon = "greed",
            rarity = "purple",

            cd = 80,
            cdr = 20,
            max = 25,
            is_perma = 1,
            mod_name = "modifier_alchemist_goblins_greed_custom_runes"
        },

        ["modifier_alchemist_spray_1"] = 
        {
            skill_number = 1,
            mini_icon = "acid_1",
            skill_icon = "acid",
            rarity = "blue",

            damage = {2, 3, 4},
            creeps_max = 150,
        },
        ["modifier_alchemist_spray_2"] = 
        {
            skill_number = 1,
            mini_icon = "acid_2",
            skill_icon = "acid",
            rarity = "blue",

            cd = {-2, -3, -4},
            mana = {16, 24, 32},
            update_mod = "modifier_alchemist_acid_spray_custom_tracker"
        },
        ["modifier_alchemist_spray_3"] = 
        {
            skill_number = 1,
            mini_icon = "acid_3",
            skill_icon = "acid",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            max = 6,
            duration = 8,
            armor = {10, 18},
            magic = {20, 30},
            is_through_bkb = 1,
            alt_talent = "modifier_alchemist_unstable_legendary"
        },
        ["modifier_alchemist_spray_4"] = 
        {
            skill_number = 1,
            mini_icon = "acid_4",
            skill_icon = "acid",
            rarity = "purple",
            has_video = 1,

            radius = 150,
            root = 1.6,
            cd = 6,
        },
        ["modifier_alchemist_spray_legendary"] = 
        {
            skill_number = 1,
            mini_icon = "acid",
            skill_icon = "acid",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            skill_name = "alchemist_acid_spray_custom",
            trigger_ability = "alchemist_acid_spray_mixing",
            damage_reduce = -20,
            status_reduce = -20,
            delay = 1.5,
            max = 3,
            creeps = -20,
            is_through_bkb = 1,
        },
        ["modifier_alchemist_unstable_1"] = 
        {
            skill_number = 2,
            mini_icon = "unstable_1",
            skill_icon = "unstable",
            rarity = "blue",

            damage = {20, 35, 50},
            interval = 1,
            radius = 500,
            bonus = 2
        },
        ["modifier_alchemist_unstable_2"] = 
        {
            skill_number = 2,
            mini_icon = "unstable_2",
            skill_icon = "unstable",
            rarity = "blue",

            cd = {-2, -3, -4},
            stun = {0.4, 0.6, 0.8},
        },
        ["modifier_alchemist_unstable_3"] = 
        {
            skill_number = 2,
            mini_icon = "unstable_3",
            skill_icon = "unstable",
            rarity = "purple",
            main_epic = 1,

            damage = {8, 15},
            str = {8, 15},
            bonus = 2,
            duration = 8,
            timer = 4,
        },
        ["modifier_alchemist_unstable_4"] = 
        {
            skill_number = 2,
            mini_icon = "unstable_4",
            skill_icon = "unstable",
            rarity = "purple",

            cd_items = -4,
            range = 250,
            update_mod = "modifier_alchemist_unstable_concoction_custom_tracker"
        },
        ["modifier_alchemist_unstable_legendary"] = 
        {
            skill_number = 2,
            mini_icon = "unstable",
            skill_icon = "unstable",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            skill_name = "alchemist_unstable_concoction_custom",
            damage = 75,
            magic_resist = -20,
            creeps = 3,
            duration = 2,
        },
        ["modifier_alchemist_greed_1"] = 
        {
            skill_number = 3,
            mini_icon = "greed_1",
            skill_icon = "greed",
            rarity = "blue",

            speed = {4, 6, 8},
            duration = 5,
        },
        ["modifier_alchemist_greed_2"] = 
        {
            skill_number = 3,
            mini_icon = "greed_2",
            skill_icon = "greed",
            rarity = "blue",

            move_slow = {-10, -15, -20},
            range = {50, 75, 100},
        },
        ["modifier_alchemist_greed_3"] = 
        {
            skill_number = 3,
            mini_icon = "greed_3",
            skill_icon = "greed",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            chance = {30, 50},
            damage = 300,
            duration = 6,
            interval = 1,
            talent_cd = 0.3,
            heal = 100,
            damage_type = DAMAGE_TYPE_MAGICAL,
            update_mod = "modifier_alchemist_corrosive_weaponry_custom",
        },
        ["modifier_alchemist_greed_4"] = 
        {
            skill_number = 3,
            mini_icon = "greed_4",
            skill_icon = "greed",
            rarity = "purple",
            has_video = 1,

            silence = 3,
            cd = 10,
            is_purgable_self = 1,
        },
        ["modifier_alchemist_greed_legendary"] = 
        {
            skill_number = 3,
            mini_icon = "greed",
            skill_icon = "greed",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            talent_cd = 12,
            duration = 8,
            linger = 16,
            str = 2,
            range = 700,
            slow_duration = 1,
            skill_name = "alchemist_corrosive_weaponry_custom",
            is_through_bkb = 1,
        },
        ["modifier_alchemist_rage_1"] = 
        {
            skill_number = 4,
            mini_icon = "chemical_1",
            skill_icon = "chemical",
            rarity = "blue",
            has_video = 1,

            attacks = 5,
            damage = {20, 30, 40},
            gold = {20, 30, 40},
            creeps = 4,
            bonus = 5,
            duration = 6,
        },
        ["modifier_alchemist_rage_2"] = 
        {
            skill_number = 4,
            mini_icon = "chemical_2",
            skill_icon = "chemical",
            rarity = "blue",

            move = {30, 45, 60},
            cleave = {20, 30, 40},
        },
        ["modifier_alchemist_rage_3"] = 
        {
            skill_number = 4,
            mini_icon = "chemical_3",
            skill_icon = "chemical",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,
            alt_talent = "modifier_alchemist_rage_legendary",

            bva = {-0.15, -0.3},
            duration = 10,
            heal = {30, 50},
            trigger_ability = "alchemist_enrage_potion"
        },
        ["modifier_alchemist_rage_4"] = 
        {
            skill_number = 4,
            mini_icon = "chemical_4",
            skill_icon = "chemical",
            rarity = "purple",
            has_video = 1,
            alt_talent = "modifier_alchemist_rage_legendary",

            damage_reduce = -40,
            duration = 2.5,
            health = 30,
            talent_cd = 25,
            is_breakable = 1,
        },
        ["modifier_alchemist_rage_legendary"] = 
        {
            skill_number = 4,
            mini_icon = "chemical",
            skill_icon = "chemical",
            rarity = "orange",
            complexity = 1,

            bonus = 100,
            duration = 10,
            cd = 10,
            points_start = 40,
            points_inc = 15,
            orbs_count = 6,
            update_mod = "modifier_alchemist_goblins_greed_custom",
            skill_name = "alchemist_chemical_rage_custom",
            trigger_ability = "alchemist_enrage_potion"
        },
    },

    npc_dota_hero_ogre_magi = 
    {
        ["modifier_ogremagi_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            stun = {0.2, 0.3, 0.4},
            slow = {-20, -30, -40},
            duration = 5,
            is_purgable_self = 1,
        },
        ["modifier_ogremagi_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            move = {2, 3, 4},
            magic = {4, 6, 8},
        },
        ["modifier_ogremagi_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            mana = {2, 3, 4},
            str = {6, 9, 12},
        },
        ["modifier_ogremagi_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            status = 15,
            health = 30,
            bkb = 2.5,
            duration = 6,
            talent_cd = 20,
            is_breakable = 1,
        },
        ["modifier_ogremagi_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            cast = -0.15,
            silence = 1.5,
            slow = -100,
            is_purgable_self = 1,
            talent_cd = 8,
        },
        ["modifier_ogremagi_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -10,
            bonus = 4,
            duration = 3,
            heal = 6,
        },

        ["modifier_ogremagi_blast_1"] = 
        {
            skill_number = 1,
            mini_icon = "fireblast_1",
            skill_icon = "fireblast",
            rarity = "blue",

            spell = {4, 6, 8},
            damage = {4, 6, 8},
        },
        ["modifier_ogremagi_blast_2"] = 
        {
            skill_number = 1,
            mini_icon = "fireblast_2",
            skill_icon = "fireblast",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            range = {100, 150, 200},
        },
        ["modifier_ogremagi_blast_3"] = 
        {
            skill_number = 1,
            mini_icon = "fireblast_3",
            skill_icon = "fireblast",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            max = 4,
            damage = {120, 200},
            magic = {-12, -20},
            effect_duration = 6,
            duration = 6
        },
        ["modifier_ogremagi_blast_4"] = 
        {
            skill_number = 1,
            mini_icon = "fireblast_4",
            skill_icon = "fireblast",
            rarity = "purple",

            cast = -0.2,
            move = 40,
            duration = 3,
            cd_items = 1,
            cd_items_inc = 0.5,
        },
        ["modifier_ogremagi_blast_7"] = 
        {
            skill_number = 1,
            mini_icon = "fireblast",
            skill_icon = "fireblast",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            speed = 1800,
            distance = 400,
            damage = 6,
            cd = -30,
            range = 700,
            width = 150,
            mana = -40,
            duration = 15,
            max = 20,
            interval = 0.25,
            skill_name = "ogre_magi_fireblast_custom",
        },

        ["modifier_ogremagi_ignite_1"] = 
        {
            skill_number = 2,
            mini_icon = "ignite_1",
            skill_icon = "ignite",
            rarity = "blue",
            
            bonus = {10, 15, 20},
            damage = {20, 30, 40},
        },
        ["modifier_ogremagi_ignite_2"] = 
        {
            skill_number = 2,
            mini_icon = "ignite_2",
            skill_icon = "ignite",
            rarity = "blue",

            cd = {-2, -3, -4},
            heal = {10, 15, 20},
            bonus = 2,
        },
        ["modifier_ogremagi_ignite_3"] = 
        {
            skill_number = 2,
            mini_icon = "ignite_3",
            skill_icon = "ignite",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {150, 250},
            slow = -100,
            slow_duration = 0.5,
            radius = 250,
            chance = 25,
            bva = {-0.2, -0.35},
            duration = 5,
            cd = -3,
        },
        ["modifier_ogremagi_ignite_4"] = 
        {
            skill_number = 2,
            mini_icon = "ignite_4",
            skill_icon = "ignite",
            rarity = "purple",
            has_video = 1,

            max = 1,
            attacks = 5,
            range = 500,
            duration = 5,
            cd = -3,
        },
        ["modifier_ogremagi_ignite_7"] = 
        {
            skill_number = 2,
            mini_icon = "ignite",
            skill_icon = "ignite",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            duration = 5,
            chance = 50,
            damage = 60,
            duration_inc = 2,
            damage_reduce = -30,
            cd = -3,
            skill_name = "ogre_magi_ignite_custom",
        },

        ["modifier_ogremagi_bloodlust_1"] = 
        {
            skill_number = 3,
            mini_icon = "bloodlust_1",
            skill_icon = "bloodlust",
            rarity = "blue",

            range = {50, 75, 100},
            speed = {16, 24, 32},
            speed_legendary = {12, 18, 24},
            alt_talent = "modifier_ogremagi_bloodlust_7", 
        },
        ["modifier_ogremagi_bloodlust_2"] = 
        {
            skill_number = 3,
            mini_icon = "bloodlust_2",
            skill_icon = "bloodlust",
            rarity = "blue",

            armor = {2, 3, 4},
            armor_reduce = {-4, -6, -8},
            duration = 5,
        },
        ["modifier_ogremagi_bloodlust_3"] = 
        {
            skill_number = 3,
            mini_icon = "bloodlust_3",
            skill_icon = "bloodlust",
            rarity = "purple",
            main_epic = 1,

            damage = {4, 6},
            str = {5, 8},
            max = 4,
            duration = 8,
            alt_talent = "modifier_ogremagi_bloodlust_7", 
        },
        ["modifier_ogremagi_bloodlust_4"] = 
        {
            skill_number = 3,
            mini_icon = "bloodlust_4",
            skill_icon = "bloodlust",
            rarity = "purple",
            has_video = 1,

            slow_resist = 30,
            range = 650,
            duration = 0.45,
            stun = 0.3,
            knock_distance = 150,
            talent_cd = 14,
            cd_inc = -1,
            radius = 250,
            is_root_disabled = 1,
        },
        ["modifier_ogremagi_bloodlust_7"] = 
        {
            skill_number = 3,
            mini_icon = "bloodlust",
            skill_icon = "bloodlust",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            duration = 3,
            cost = 8,
            effect_duration = 16,
            crit_chance = 30,
            crit_damage = 230,
            crit_cleave = 50,
            crit_radius = 250,
            bash_chance = 30,
            bash_cd = 2.5,
            bash_duration = 1,
            bash_slow = -40,
            bash_slow_duration = 3,
            heal_max = 100,
            heal_health = 15,
            move_max_tooltip = 100,
            move_max = 650,
            move_bonus = 40,
            move_status = 40,
            move_duration = 3,
            is_basher = 1,
            is_through_bkb = 1,
            skill_name = "ogre_magi_bloodlust_custom",
            trigger_ability = "ogre_magi_bloodlust_custom",
            banned_talent = "modifier_ogremagi_multi_7",
        },
        ["modifier_ogremagi_multi_1"] = 
        {
            skill_number = 4,
            mini_icon = "multicast_1",
            skill_icon = "multicast",
            rarity = "blue",

            spell = {4, 6, 8},
            damage = {20, 30, 40},
            range = 900,
            targets = 3,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_ogremagi_multi_2"] = 
        {
            skill_number = 4,
            mini_icon = "multicast_2",
            skill_icon = "multicast",
            rarity = "blue",

            heal = {10, 15, 20},
            regen = {2, 3, 4},
            max = 20,
            duration = 8,
        },
        ["modifier_ogremagi_multi_3"] = 
        {
            skill_number = 4,
            mini_icon = "multicast_3",
            skill_icon = "multicast",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            max = 20,
            duration = 8,
            damage = {150, 250},
            heal_reduce = {-25, -40},
            interval = 1,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_ogremagi_multi_4"] = 
        {
            skill_number = 4,
            mini_icon = "multicast_4",
            skill_icon = "multicast",
            rarity = "purple",

            chance = 5,
            gold = 3000,
            cdr = 15,
            max = 150,
            mod_name = "modifier_ogre_magi_dumb_luck_custom_cdr",
            is_perma = 1,
            alt_talent = "modifier_ogremagi_multi_7",
        },
        ["modifier_ogremagi_multi_7"] = 
        {
            skill_number = 4,
            mini_icon = "multicast",
            skill_icon = "multicast",
            rarity = "orange",
            complexity = 2,
            has_video = 1,

            cdr = 35,
            interval = 0.5,
            duration = 4,
            radius = 450,
            duration_reduce = 35,
            talent_cd = 10,
            damage = -40,
            aura_radius = 1000,
            skill_name = "ogre_magi_multicast_custom",
            banned_talent = "modifier_ogremagi_bloodlust_7",
        },
    },

    npc_dota_hero_antimage = 
    {

        ["modifier_antimage_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            slow = {10, 15, 20},
            damage_reduce = {-12, -18, -24},
        },
        ["modifier_antimage_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            heal = {8, 12, 16},
            bonus = 2,
            mana = 50,
        },
        ["modifier_antimage_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            stats_init = {6, 9, 12},
            stats_inc = 2,
            max = 8,
            duration = 6,
            allow_illusion = 1,
        },
        ["modifier_antimage_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            skill_icon = "manavoid",
            rarity = "purple",

            duration = 3,
            slow = -80,
            damage = 1,
            max = 15,
            mana = 50,
            is_perma = 1,
            mod_name = "modifier_antimage_mana_void_custom_perma",
        },
        ["modifier_antimage_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            radius = 800,
            silence = 2,
            attack_slow = -150,
            talent_cd = 10,
            is_purgable_self = 1,
        },
        ["modifier_antimage_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            radius = 700,
            move = 30,
            duration = 2,
            mana = 50,
            allow_illusion = 1,
        },


        ["modifier_antimage_break_1"] = 
        {
            skill_number = 1,
            mini_icon = "manabreak_1",
            skill_icon = "manabreak",
            rarity = "blue",

            duration = 3,
            armor = {-6, -9, -12},
        },
        ["modifier_antimage_break_2"] = 
        {
            skill_number = 1,
            mini_icon = "manabreak_2",
            skill_icon = "manabreak",
            rarity = "blue",
            
            cleave = {20, 30, 40},
            range = {40, 60, 80},
            allow_illusion = 1,
        },
        ["modifier_antimage_break_3"] = 
        {
            skill_number = 1,
            mini_icon = "manabreak_3",
            skill_icon = "manabreak",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            mana = {1.2, 2},
            speed = {70, 120},
            duration = 3,
            allow_illusion = 1,
        },
        ["modifier_antimage_break_4"] = 
        {
            skill_number = 1,
            mini_icon = "manabreak_4",
            skill_icon = "manabreak",
            rarity = "purple",
            has_video = 1,

            heal_reduce = -30,
            mana = 50,
            stun = 1.2,
            talent_cd = 10,
            is_through_bkb = 1,
            is_breakable = 1,
        },
        ["modifier_antimage_break_7"] = 
        {
            skill_number = 1,
            mini_icon = "manabreak",
            skill_icon = "manabreak",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            damage = 150,
            talent_cd = 6,
            duration = 6,
            status = 50,
            skill_name = "antimage_mana_break_custom",
        },

        ["modifier_antimage_blink_1"] = 
        {
            skill_number = 2,
            mini_icon = "antimage_blink_1",
            skill_icon = "antimage_blink",
            rarity = "blue",

            damage = {20, 30, 40},
            crit = {140, 160, 180},
            attacks = 2,
            attacks_legendary = 1,
            duration = 4,
            allow_illusion = 1,
            alt_talent = "modifier_antimage_blink_7",
        },
        ["modifier_antimage_blink_2"] = 
        {
            skill_number = 2,
            mini_icon = "antimage_blink_2",
            skill_icon = "antimage_blink",
            rarity = "blue",

            move = {20, 30, 40},
            evasion = {8, 12, 16},
            bonus = 2,
            duration = 3,
        },
        ["modifier_antimage_blink_3"] = 
        {
            skill_number = 2,
            mini_icon = "antimage_blink_3",
            skill_icon = "antimage_blink",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            legendary_count = 2,
            damage = {50, 80},
            heal = {70, 100},
            legendary_count = 2,
            duration = 4,
            alt_talent = "modifier_antimage_blink_7"
        },
        ["modifier_antimage_blink_4"] = 
        {
            skill_number = 2,
            mini_icon = "antimage_blink_4",
            skill_icon = "antimage_blink",
            rarity = "purple",

            cast = -0.2,
            speed = 30,
            cd_inc = -10,
            alt_talent = "modifier_antimage_blink_7"
        },
        ["modifier_antimage_blink_7"] = 
        {
            skill_number = 2,
            mini_icon = "antimage_blink",
            skill_icon = "antimage_blink",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            agi = 80,
            max = 6,
            distance = 550,
            min_distance = 250,
            mana = 30,
            cd = -50,
            speed = 2000,
            duration_hero = 12,
            duration_creeps = 5,
            allow_illusion = 1,
            trigger_ability = "antimage_blink_custom",
            skill_name = "antimage_blink_custom",
        },

        ["modifier_antimage_counter_1"] = 
        {
            skill_number = 3,
            mini_icon = "counterspell_1",
            skill_icon = "counterspell",
            rarity = "blue",

            damage = {20, 30, 40},
            damage_health = {1, 1.5, 2},
            radius = 600,
            interval = 1,
            allow_illusion = 1,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_antimage_counter_2"] = 
        {
            skill_number = 3,
            mini_icon = "counterspell_2",
            skill_icon = "counterspell",
            rarity = "blue",
            has_video = 1,

            health = {4, 6, 8},
            radius = 600,
            mana = {1.2, 1.8, 2.4},
            is_breakable = 1,
            allow_illusion = 1,
        },
        ["modifier_antimage_counter_3"] = 
        {
            skill_number = 3,
            mini_icon = "counterspell_3",
            skill_icon = "counterspell",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            base = {120, 200},
            heal = {8, 15},
            radius = 400,
            shield = 5,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_antimage_counter_4"] = 
        {
            skill_number = 3,
            mini_icon = "counterspell_4",
            skill_icon = "counterspell",
            rarity = "purple",
            has_video = 1,

            status = 15,
            range = 350,
            duration = 0.5,
            trigger_ability = "antimage_counterspell_custom",
        },
        ["modifier_antimage_counter_7"] = 
        {
            skill_number = 3,
            mini_icon = "counterspell",
            skill_icon = "counterspell",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            magic = -60,
            stun = 1.5,
            shield = 5,
            is_through_bkb = 1,
            radius = 400,
            duration = 5,
            skill_name = "antimage_counterspell_custom",
        },

        ["modifier_antimage_void_1"] = 
        {
            skill_number = 4,
            mini_icon = "manavoid_1",
            skill_icon = "manavoid",
            rarity = "blue",

            base = {50, 75, 100},
            damage = {4, 6, 8},
            mana = 25,
            damage_type = DAMAGE_TYPE_MAGICAL,
            alt_talent = "modifier_antimage_void_7",
        },
        ["modifier_antimage_void_2"] = 
        {
            skill_number = 4,
            mini_icon = "manavoid_2",
            skill_icon = "manavoid",
            rarity = "blue",

            cd = {-4, -6, -8},
            heal = {10, 15, 20},
        },
        ["modifier_antimage_void_3"] = 
        {
            skill_number = 4,
            mini_icon = "manavoid_3",
            skill_icon = "manavoid",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            spell = {8, 15},
            duration = 10,
            mana = {5, 8},
            max = 8,
            radius = 600,
            allow_illusion = 1,
        },
        ["modifier_antimage_void_4"] = 
        {
            skill_number = 4,
            mini_icon = "manavoid_4",
            skill_icon = "manavoid",
            rarity = "purple",

            range = 200,
            cd_items = -5,
            cdr = 12,
        },
        ["modifier_antimage_void_7"] = 
        {
            skill_number = 4,
            mini_icon = "manavoid",
            skill_icon = "manavoid",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            delay = 3,
            talent_cd = 8,
            skill_name = "antimage_mana_void_custom",
            trigger_ability = "antimage_mana_overload_custom",
        },
    },

    npc_dota_hero_primal_beast = 
    {
        ["modifier_primal_beast_onslaught_1"] = 
        {
            skill_number = 1,
            mini_icon = "onslaught_1",
            skill_icon = "onslaught",
            rarity = "blue",

            cd = {-2, -3, -4},
            stun = {0.2, 0.3, 0.4},
        },
        ["modifier_primal_beast_onslaught_2"] = 
        {
            skill_number = 1,
            mini_icon = "onslaught_2",
            skill_icon = "onslaught",
            rarity = "blue",

            damage = {50, 75, 100},
            damage_inc = {40, 60, 80},
            duration = 6,
        },
        ["modifier_primal_beast_onslaught_3"] = 
        {
            skill_number = 1,
            mini_icon = "onslaught_3",
            skill_icon = "onslaught",
            rarity = "blue",

            mana = {-60, -90, -120},
            duration = 8,
            shield = {200, 350, 500},
        },
        ["modifier_primal_beast_onslaught_4"] = 
        {
            skill_number = 1,
            mini_icon = "onslaught_4",
            skill_icon = "onslaught",
            rarity = "purple",
            main_epic = 1,

            damage = {12, 20},
            is_perma = 1,
            cast = {-0.4, -0.7},
            mod_name = "modifier_primal_beast_onslaught_custom_stacks",
            max = 15,
        },
        ["modifier_primal_beast_onslaught_5"] = 
        {
            skill_number = 1,
            mini_icon = "onslaught_5",
            skill_icon = "onslaught",
            rarity = "purple",
            has_video = 1,

            trigger_ability = "primal_beast_onslaught_custom",
            slow = -80,
            block = 1,
            radius = 400,
            knock_duration = 0.3,
            duration = 2,
        },
        ["modifier_primal_beast_onslaught_6"] = 
        {
            skill_number = 1,
            mini_icon = "onslaught_6",
            skill_icon = "onslaught",
            rarity = "purple",

            speed = 25,
            move = -50,
            attack = -100,
            is_purgable_self = 1,
            leash = 2.5,
        },
        ["modifier_primal_beast_onslaught_7"] = 
        {
            skill_number = 1,
            mini_icon = "onslaught",
            skill_icon = "onslaught",
            rarity = "orange",

            damage = 100,
            interval = 1,
            heal = 50,
            skill_name = "primal_beast_onslaught_custom",
            radius = 550,
            cd = -40,
            duration = 5,
        },
        ["modifier_primal_beast_trample_1"] = 
        {
            skill_number = 2,
            mini_icon = "trample_1",
            skill_icon = "trample",
            rarity = "blue",

            damage = {8, 12, 16},
            radius = 80,
            cd = {5, 4, 3},
        },
        ["modifier_primal_beast_trample_2"] = 
        {
            skill_number = 2,
            mini_icon = "trample_2",
            skill_icon = "trample",
            rarity = "blue",
            has_video = 1,

            heal = {10, 15, 20},
            bonus = 2,
            creeps = 3,
        },
        ["modifier_primal_beast_trample_3"] = 
        {
            skill_number = 2,
            mini_icon = "trample_3",
            skill_icon = "trample",
            rarity = "blue",

            move = {40, 60, 80},
            duration = {1, 1.5, 2},
        },
        ["modifier_primal_beast_trample_4"] = 
        {
            skill_number = 2,
            mini_icon = "trample_4",
            skill_icon = "trample",
            rarity = "purple",
            main_epic = 1,

            damage = {18, 30},
            slow = {-40, -60},
            max = 8,
            duration = 6,
        },
        ["modifier_primal_beast_trample_5"] = 
        {
            skill_number = 2,
            mini_icon = "trample_5",
            skill_icon = "trample",
            rarity = "purple",
            has_video = 1,

            duration = 3,
            status = 50,
            stack = 10,
            damage_reduce = -30,
        },
        ["modifier_primal_beast_trample_6"] = 
        {
            skill_number = 2,
            mini_icon = "trample_6",
            skill_icon = "trample",
            rarity = "purple",
            has_video = 1,

            silence = 3,
            cd = -3,
            radius = 70,
            is_purgable_self = 1,
            max = 4,
        },
        ["modifier_primal_beast_trample_7"] = 
        {
            skill_number = 2,
            mini_icon = "trample",
            skill_icon = "trample",
            rarity = "orange",
            has_video = 1,

            damage = 5,
            distance = 350,
            skill_name = "primal_beast_trample_custom",
            cd = 1,
            duration = 6,
        },
        ["modifier_primal_beast_uproar_1"] = 
        {
            skill_number = 3,
            mini_icon = "uproar_1",
            skill_icon = "uproar",
            rarity = "blue",

            magic = {3, 4, 5},
            max = 5,
            movespeed = {3, 4, 5},
        },
        ["modifier_primal_beast_uproar_2"] = 
        {
            skill_number = 3,
            mini_icon = "uproar_2",
            skill_icon = "uproar",
            rarity = "blue",

            update_mod = "modifier_primal_beast_uproar_custom",
            duration = {1, 1.5, 2},
            status = {10, 15, 20},
        },
        ["modifier_primal_beast_uproar_3"] = 
        {
            skill_number = 3,
            mini_icon = "uproar_3",
            skill_icon = "uproar",
            rarity = "blue",

            damage = {8, 12, 16},
            cast_damage = {40, 60, 80},
        },
        ["modifier_primal_beast_uproar_4"] = 
        {
            skill_number = 3,
            mini_icon = "uproar_4",
            skill_icon = "uproar",
            rarity = "purple",
            main_epic = 1,

            speed = {120, 200},
            attacks = {2, 3},
            is_through_bkb = 1,
            heal = 70,
            stun = 0.3,
            creeps = 3,
            duration = 10,
        },
        ["modifier_primal_beast_uproar_5"] = 
        {
            skill_number = 3,
            mini_icon = "uproar_5",
            skill_icon = "uproar",
            rarity = "purple",
            has_video = 1,

            is_purgable_self = 1,
            radius = 550,
            pull_duration = 0.3,
            root = 2,
        },
        ["modifier_primal_beast_uproar_6"] = 
        {
            skill_number = 3,
            mini_icon = "uproar_6",
            skill_icon = "uproar",
            rarity = "purple",

            duration = 2,
            shield = 20,
        },
        ["modifier_primal_beast_uproar_7"] = 
        {
            skill_number = 3,
            mini_icon = "uproar",
            skill_icon = "uproar",
            rarity = "orange",

            speed = 200,
            max = 25,
            heal = 2,
            skill_name = "primal_beast_uproar_custom",
            duration = 4,
            cd = 17,
            trigger_ability = "primal_beast_blood_frenzy_custom",
        },
        ["modifier_primal_beast_pulverize_1"] = 
        {
            skill_number = 4,
            mini_icon = "pulverize_1",
            skill_icon = "pulverize",
            rarity = "blue",

            damage = {30, 45, 60},
            str = {30, 25, 20},
            spell = 1,
        },
        ["modifier_primal_beast_pulverize_2"] = 
        {
            skill_number = 4,
            mini_icon = "pulverize_2",
            skill_icon = "pulverize",
            rarity = "blue",

            is_through_bkb = 1,
            duration = 5,
            heal_reduce = {-20, -30, -40},
            damage_reduce = {-15, -20, -25},
        },
        ["modifier_primal_beast_pulverize_3"] = 
        {
            skill_number = 4,
            mini_icon = "pulverize_3",
            skill_icon = "pulverize",
            rarity = "blue",

            cd = {-4, -6, -8},
            range = {100, 150, 200},
        },
        ["modifier_primal_beast_pulverize_4"] = 
        {
            skill_number = 4,
            mini_icon = "pulverize_4",
            skill_icon = "pulverize",
            rarity = "purple",
            main_epic = 1,

            str = {4, 7},
            is_through_bkb = 1,
            duration = 10,
            max = 5,
            uproar = 5,
            trample = 4,
        },
        ["modifier_primal_beast_pulverize_5"] = 
        {
            skill_number = 4,
            mini_icon = "pulverize_5",
            skill_icon = "pulverize",
            rarity = "purple",
            has_video = 1,

            heal = 12,
            cd_items = -1.5,
            cdr = 10,
        },
        ["modifier_primal_beast_pulverize_6"] = 
        {
            skill_number = 4,
            mini_icon = "pulverize_6",
            skill_icon = "pulverize",
            rarity = "purple",

            is_through_bkb = 1,
            duration = 1,
        },
        ["modifier_primal_beast_pulverize_7"] = 
        {
            skill_number = 4,
            mini_icon = "pulverize",
            skill_icon = "pulverize",
            rarity = "orange",
            has_video = 1,

            radius = 1000,
            duration = 5,
            trample = 4,
            skill_name = "primal_beast_pulverize_custom",
            count = 1,
            uproar = 5,
            max = 5,
        },
    },

    npc_dota_hero_marci = 
    {
        ["modifier_marci_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            move = {30, 45, 60},
        },
        ["modifier_marci_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            status = {8, 12, 16},
            shield = {6, 9, 12},
        },
        ["modifier_marci_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            cd = {-4, -6, -8},
            regen = {8, 12, 16},
            max = 4,
            duration = 5,
        },

        ["modifier_marci_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            slow_resist = 30,
            range = 100,
            move = 25,
            move_max = 100,
            move_max_real = 650,
            duration = 2,
        },
        ["modifier_marci_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",

            stun = 0.5,
            speed = 25,
        },
        ["modifier_marci_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            bkb = 2,
            cd = 10,
        },

        ["modifier_marci_dispose_1"] = 
        {
            skill_number = 1,
            mini_icon = "dispose_1",
            skill_icon = "dispose",
            rarity = "blue",

            base = {20, 30, 40},
            damage = {4, 6, 8},
        },
        ["modifier_marci_dispose_2"] = 
        {
            skill_number = 1,
            mini_icon = "dispose_2",
            skill_icon = "dispose",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            range = {100, 150, 200},
        },
        ["modifier_marci_dispose_3"] = 
        {
            skill_number = 1,
            mini_icon = "dispose_3",
            skill_icon = "dispose",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            health_reduce = {3, 6},
            max = 6,
            duration = 12,
        },
        ["modifier_marci_dispose_4"] = 
        {
            skill_number = 1,
            mini_icon = "dispose_4",
            skill_icon = "dispose",
            rarity = "purple",
            has_video = 1,

            duration = 4,
            damage = 75,
            speed = 1600,
            range = 650,
            stun = 1.2,
            cast_range = 200,
        },
        ["modifier_marci_dispose_7"] = 
        {
            skill_number = 1,
            mini_icon = "dispose",
            skill_icon = "dispose",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            damage = 400,
            channel = 2,
            interval = 0.2,
            slow = -100,
            linger = 0.5,
            talent_cd = 3,
            count = 5,
            duration = 6,
            range = 600,
            skill_name = "marci_grapple_custom",
            trigger_ability = "marci_dispose_hits",
            banned_talent = {"modifier_marci_sidekick_7", "modifier_marci_unleash_7"},
        },

        ["modifier_marci_rebound_1"] = 
        {
            skill_number = 2,
            mini_icon = "rebound_1",
            skill_icon = "rebound",
            rarity = "blue",

            spell = {6, 9, 12},
            damage = {60, 90, 120},
        },
        ["modifier_marci_rebound_2"] = 
        {
            skill_number = 2,
            mini_icon = "rebound_2",
            skill_icon = "rebound",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            heal_reduce = {-12, -18, -24},
            duration = 5,
        },
        ["modifier_marci_rebound_3"] = 
        {
            skill_number = 2,
            mini_icon = "rebound_3",
            skill_icon = "rebound",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal = {15, 25},
            min = 1,
            max = 3,
            damage = {15, 25},
            chance = 75,
            chance_inc = 50,
            interval = 0.2,
        },
        ["modifier_marci_rebound_4"] = 
        {
            skill_number = 2,
            mini_icon = "rebound_4",
            skill_icon = "rebound",
            rarity = "purple",

            cdr = 12,
            cd_items = -1.5, 
            mana = 6,
        },
        ["modifier_marci_rebound_7"] = 
        {
            skill_number = 2,
            mini_icon = "rebound",
            skill_icon = "rebound",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            magic = -10,
            max = 8,
            duration = 10,
            cd_inc = -10,
            stun = -50,
            skill_name = "marci_companion_run_custom",
            banned_talent = "modifier_marci_unleash_7",
        },

        ["modifier_marci_sidekick_1"] = 
        {
            skill_number = 3,
            mini_icon = "sidekick_1",
            skill_icon = "sidekick",
            rarity = "blue",

            duration = 3,
            armor = {5, 7.5, 10},
            armor_reduce = {-5, -7.5, -10},
            radius = 900,
        },
        ["modifier_marci_sidekick_2"] = 
        {
            skill_number = 3,
            mini_icon = "sidekick_2",
            skill_icon = "sidekick",
            rarity = "blue",

            heal = {12, 18, 24},
            damage_reduce = {-10, -15, -20},
            damage_reduce_legendary = {-12, -18, -24},
            duration = 3,
            alt_talent = "modifier_marci_sidekick_7"
        },
        ["modifier_marci_sidekick_3"] = 
        {
            skill_number = 3,
            mini_icon = "sidekick_3",
            skill_icon = "sidekick",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            crit = {130, 150},
            attacks = 2,
            damage = {5, 8},
            max = 4,
            effect_duration = 4,
            duration = 12,
        },
        ["modifier_marci_sidekick_4"] = 
        {
            skill_number = 3,
            mini_icon = "sidekick_4",
            skill_icon = "sidekick",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -40,
            duration = 1.5,
            cd_inc = -10,
            cd_inc_legendary = -5,
            alt_talent = {"modifier_marci_dispose_7", "modifier_marci_rebound_7"},
            alt_talent2 = "modifier_marci_sidekick_7",
        },
        ["modifier_marci_sidekick_7"] = 
        {
            skill_number = 3,
            mini_icon = "sidekick",
            skill_icon = "sidekick",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            damage = 70,
            speed = 60,
            duration = 3,
            heal = 40,
            health = 60,
            armor = 10,
            magic = 50,
            bva = 1.7,
            range = 850,
            talent_cd = 14,
            movespeed = 15,
            slow_resist = 40,
            skill_name = "marci_guardian_custom",
            trigger_ability = "marci_guardian_custom",
            banned_talent = "modifier_marci_dispose_7",
        },

        ["modifier_marci_unleash_1"] = 
        {
            skill_number = 4,
            mini_icon = "unleash_1",
            skill_icon = "unleash",
            rarity = "blue",

            stats_inc = {20, 30, 40},
            duration = 10,
            duration_creeps = 4,
            max = 20,
        },
        ["modifier_marci_unleash_2"] = 
        {
            skill_number = 4,
            mini_icon = "unleash_2",
            skill_icon = "unleash",
            rarity = "blue",

            speed = {40, 60, 80},
            speed_legendary = {40, 60, 80},
            slow = {-10, -15, -20},
            alt_talent = "modifier_marci_sidekick_7",
        },
        ["modifier_marci_unleash_3"] = 
        {
            skill_number = 4,
            mini_icon = "unleash_3",
            skill_icon = "unleash",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {120, 200},
            chance = 25,
            radius = 500,
            damage_inc = {25, 40},
            max = 6,
            duration = 12,
        },
        ["modifier_marci_unleash_4"] = 
        {
            skill_number = 4,
            mini_icon = "unleash_4",
            skill_icon = "unleash",
            rarity = "purple",
            has_video = 1,

            range = 150,
            stun = 1.2,
            heal = 6,
            talent_cd = 3,
            is_through_bkb = 1,
            is_basher = 1.2,
        },
        ["modifier_marci_unleash_7"] = 
        {
            skill_number = 4,
            mini_icon = "unleash",
            skill_icon = "unleash",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            cd_inc = -0.1,
            speed = 55,
            stack_init = 4,
            stack_max = 10,
            skill_name = "marci_unleash_custom",
            banned_talent = {"modifier_marci_dispose_7", "modifier_marci_rebound_7"},
        },
    },

    npc_dota_hero_templar_assassin = 
    {
        ["modifier_templar_assassin_refraction_1"] = 
        {
            skill_number = 1,
            mini_icon = "refraction_1",
            skill_icon = "refraction",
            rarity = "blue",

            move = {20, 30, 40},
            bonus = 2,
            status = {6, 9, 12},
        },
        ["modifier_templar_assassin_refraction_2"] = 
        {
            skill_number = 1,
            mini_icon = "refraction_2",
            skill_icon = "refraction",
            rarity = "blue",

            mana = {-35, -60, -85},
            heal = {1, 1.5, 2},
        },
        ["modifier_templar_assassin_refraction_3"] = 
        {
            skill_number = 1,
            mini_icon = "refraction_3",
            skill_icon = "refraction",
            rarity = "blue",

            cd = {-2, -3, -4},
            stack = {2, 3, 4},
        },
        ["modifier_templar_assassin_refraction_4"] = 
        {
            skill_number = 1,
            mini_icon = "refraction_4",
            skill_icon = "refraction",
            rarity = "purple",
            main_epic = 1,

            speed = {60, 100},
            effect_duration = 5,
            is_through_bkb = 1,
            slow = {-25, -40},
            duration = 2,
        },
        ["modifier_templar_assassin_refraction_5"] = 
        {
            skill_number = 1,
            mini_icon = "refraction_5",
            skill_icon = "refraction",
            rarity = "purple",

            silence = 2,
            slow = -80,
            radius = 500,
            is_purgable_self = 1,
            duration = 0.3,
        },
        ["modifier_templar_assassin_refraction_6"] = 
        {
            skill_number = 1,
            mini_icon = "refraction_6",
            skill_icon = "refraction",
            rarity = "purple",
            has_video = 1,

            duration = 1.2,
            shield = 30,
        },
        ["modifier_templar_assassin_refraction_7"] = 
        {
            skill_number = 1,
            mini_icon = "refraction",
            skill_icon = "refraction",
            rarity = "orange",
            has_video = 1,

            damage = 12,
            invun = 1.2,
            skill_name = "templar_assassin_refraction_custom",
            is_through_bkb = 1,
            duration = 5,
        },
        ["modifier_templar_assassin_meld_1"] = 
        {
            skill_number = 2,
            mini_icon = "meld_1",
            skill_icon = "meld",
            rarity = "blue",

            agility = {10, 15, 20},
            armor = {-2, -3, -4},
        },
        ["modifier_templar_assassin_meld_2"] = 
        {
            skill_number = 2,
            mini_icon = "meld_2",
            skill_icon = "meld",
            rarity = "blue",

            heal = {15, 20, 25},
            creeps = 3,
            health = {1.5, 2, 2.5},
            duration = 4,
        },
        ["modifier_templar_assassin_meld_3"] = 
        {
            skill_number = 2,
            mini_icon = "meld_3",
            skill_icon = "meld",
            rarity = "blue",

            is_through_bkb = 1,
            duration = 6,
            heal_reduce = {-15, -20, -25},
            damage_reduce = {-15, -20, -25},
        },
        ["modifier_templar_assassin_meld_4"] = 
        {
            skill_number = 2,
            mini_icon = "meld_4",
            skill_icon = "meld",
            rarity = "purple",
            main_epic = 1,

            damage = {50, 80},
            trigger_ability = "templar_assassin_meld_custom",
            duration = 4,
            timer = 2,
            agility = {6, 10},
            max = 4,
        },
        ["modifier_templar_assassin_meld_5"] = 
        {
            skill_number = 2,
            mini_icon = "meld_5",
            skill_icon = "meld",
            rarity = "purple",
            has_video = 1,

            is_root_disabled = 1,
            distance = 300,
            range = 150,
            duration = 4,
            trigger_ability = "templar_assassin_meld_custom",
        },
        ["modifier_templar_assassin_meld_6"] = 
        {
            skill_number = 2,
            mini_icon = "meld_6",
            skill_icon = "meld",
            rarity = "purple",
            has_video = 1,

            health = 50,
            cd = -0.3,
            break_duration = 3,
            is_through_bkb = 1,
            stun = 1,
        },
        ["modifier_templar_assassin_meld_7"] = 
        {
            skill_number = 2,
            mini_icon = "meld",
            skill_icon = "meld",
            rarity = "orange",
            has_video = 1,

            attacks = 3,
            move = 30,
            skill_name = "templar_assassin_meld_custom",
            duration_min = 0,
            duration_max = 4,
            duration = 3,
        },
        ["modifier_templar_assassin_psiblades_1"] = 
        {
            skill_number = 3,
            mini_icon = "psiblades_1",
            skill_icon = "psiblades",
            rarity = "blue",

            range = {60, 90, 120},
            damage = {8, 12, 16},
        },
        ["modifier_templar_assassin_psiblades_2"] = 
        {
            skill_number = 3,
            mini_icon = "psiblades_2",
            skill_icon = "psiblades",
            rarity = "blue",

            is_purgable = 1,
            move = {20, 30, 40},
            evasion = {20, 30, 40},
            max = 5,
            duration = 4,
        },
        ["modifier_templar_assassin_psiblades_3"] = 
        {
            skill_number = 3,
            mini_icon = "psiblades_3",
            skill_icon = "psiblades",
            rarity = "blue",

            damage = {140, 160, 180},
            chance = 25,
            speed = {-50, -75, -100},
            is_purgable_self = 1,
            duration = 2,
        },
        ["modifier_templar_assassin_psiblades_4"] = 
        {
            skill_number = 3,
            mini_icon = "psiblades_4",
            skill_icon = "psiblades",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {60, 100},
            is_through_bkb = 1,
            stun = {0.3, 0.5},
            radius = 1000,
            cd = 3,
            duration = 6,
        },
        ["modifier_templar_assassin_psiblades_5"] = 
        {
            skill_number = 3,
            mini_icon = "psiblades_5",
            skill_icon = "psiblades",
            rarity = "purple",
            has_video = 1,

            cd = 12,
            is_breakable = 1,
            incoming = 200,
            heal = 4,
            invun = 0.4,
            health = 50,
            duration = 6,
        },
        ["modifier_templar_assassin_psiblades_6"] = 
        {
            skill_number = 3,
            mini_icon = "psiblades_6",
            skill_icon = "psiblades",
            rarity = "purple",

            min_distance = 300,
            cd = 10,
            root = 2,
            distance_max = 450,
            range_knock = 350,
            vision_duration = 8,
            is_purgable_self = 1,
            knock_duration = 0.2,
        },
        ["modifier_templar_assassin_psiblades_7"] = 
        {
            skill_number = 3,
            mini_icon = "psiblades",
            skill_icon = "psiblades",
            rarity = "orange",
            has_video = 1,

            is_through_bkb = 1,
            skill_name = "templar_assassin_psi_blades_custom",
            radius = 250,
            castrange = 400,
            attacks = 3,
            heal = 50,
            stun = 0.2,
            cd = 6,
            duration = 8,
        },
        ["modifier_templar_assassin_psionic_1"] = 
        {
            skill_number = 4,
            mini_icon = "psionic_1",
            skill_icon = "psionic",
            rarity = "blue",

            damage = {60, 90, 120},
            creeps = 3,
            heal = {40, 60, 80},
        },
        ["modifier_templar_assassin_psionic_2"] = 
        {
            skill_number = 4,
            mini_icon = "psionic_2",
            skill_icon = "psionic",
            rarity = "blue",

            cd = {-2, -3, -4},
            charge = {-0.6, -0.9, -1.2},
        },
        ["modifier_templar_assassin_psionic_3"] = 
        {
            skill_number = 4,
            mini_icon = "psionic_3",
            skill_icon = "psionic",
            rarity = "blue",

            speed = {30, 45, 60},
            slow = {8, 12, 16},
            duration = 5,
        },
        ["modifier_templar_assassin_psionic_4"] = 
        {
            skill_number = 4,
            mini_icon = "psionic_4",
            skill_icon = "psionic",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {60, 100},
            range = {120, 200},
            duration = 8,
            delay = 0.25,
            attacks = 2,
            max = 4,
        },
        ["modifier_templar_assassin_psionic_5"] = 
        {
            skill_number = 4,
            mini_icon = "psionic_5",
            skill_icon = "psionic",
            rarity = "purple",

            stun = 1.5,
            range = 150,
            cd = 10,
        },
        ["modifier_templar_assassin_psionic_6"] = 
        {
            skill_number = 4,
            mini_icon = "psionic_6",
            skill_icon = "psionic",
            rarity = "purple",

            mod_name = "modifier_templar_assassin_psionic_trap_custom_trap_cdr",
            is_perma = 1,
            cast = -0.2,
            cdr = 1,
            cd_items = -1.5,
            max = 15,
        },
        ["modifier_templar_assassin_psionic_7"] = 
        {
            skill_number = 4,
            mini_icon = "psionic",
            skill_icon = "psionic",
            rarity = "orange",
            has_video = 1,

            heal_duration = 5,
            chance = 50,
            skill_name = "templar_assassin_psionic_trap_custom",
            duration = 12,
            heal_reduce = -60,
            max = 5,
        },
    },

    npc_dota_hero_bloodseeker = 
    {
        ["modifier_bloodseeker_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            magic = {6, 9, 12},
            status = {6, 9, 12},
            health = 50,
            bonus = 2,
        },
        ["modifier_bloodseeker_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            shield = {30, 45, 60},
            shield_max = {30, 45, 60},
        },
        ["modifier_bloodseeker_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            heal = {8, 12, 16},
            bonus = 2,
            health = 50,
        },
        ["modifier_bloodseeker_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            bkb_duration = 2,
        },
        ["modifier_bloodseeker_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_7",
            skill_icon = "thirst",
            rarity = "purple",

            duration = 40,
            damage = 12,
            health = 12,
            max = 8,
            radius = 700,
            is_perma = 1,
            mod_name = "modifier_bloodseeker_thirst_custom_cdr",
        },
        ["modifier_bloodseeker_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_8",
            rarity = "purple",
            has_video = 1,

            cast = -0.2,
            fear = 1.4,
            is_through_bkb = 1,
        },


        ["modifier_bloodseeker_bloodrage_1"] = 
        {
            skill_number = 1,
            mini_icon = "bloodrage_1",
            skill_icon = "bloodrage",
            rarity = "blue",

            speed = {30, 45, 60},
            range = {50, 75, 100},
        },
        ["modifier_bloodseeker_bloodrage_2"] = 
        {
            skill_number = 1,
            mini_icon = "bloodrage_2",
            skill_icon = "bloodrage",
            rarity = "blue",

            slow = {-20, -30, -40},
            damage_reduce = {-16, -24, -32},
            max = 6,
            duration = 5,
            is_purgable_self = 1,
        },
        ["modifier_bloodseeker_bloodrage_3"] = 
        {
            skill_number = 1,
            mini_icon = "bloodrage_3",
            skill_icon = "bloodrage",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {120, 200},
            interval = 0.5,
            heal = 100,
            duration = 10,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_bloodseeker_bloodrage_4"] = 
        {
            skill_number = 1,
            mini_icon = "bloodrage_4",
            skill_icon = "bloodrage",
            rarity = "purple",

            heal = 3,
            damage_reduce = -20,
            health = 30,
            is_breakable = 1,
        },
        ["modifier_bloodseeker_bloodrage_7"] = 
        {
            skill_number = 1,
            mini_icon = "bloodrage",
            skill_icon = "bloodrage",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            cost = 4,
            bonus = 125,
            health = 30,
            cd = 1,
            skill_name = "bloodseeker_bloodrage_custom",
            trigger_ability = "bloodseeker_bloodrage_custom",
        },
        ["modifier_bloodseeker_bloodrite_1"] = 
        {
            skill_number = 2,
            mini_icon = "bloodrite_1",
            skill_icon = "bloodrite",
            rarity = "blue",

            spell = {6, 9, 12},
            damage = {50, 75, 100},
        },
        ["modifier_bloodseeker_bloodrite_2"] = 
        {
            skill_number = 2,
            mini_icon = "bloodrite_2",
            skill_icon = "bloodrite",
            rarity = "blue",

            cd = {-2, -3, -4},
            delay = {-0.4, -0.6, -0.8},
        },
        ["modifier_bloodseeker_bloodrite_3"] = 
        {
            skill_number = 2,
            mini_icon = "bloodrite_3",
            skill_icon = "bloodrite",
            rarity = "purple",
            main_epic = 1,

            max = 12,
            health = {18, 30},
            duration = 10,
            stack = 4,
        },
        ["modifier_bloodseeker_bloodrite_4"] = 
        {
            skill_number = 2,
            mini_icon = "bloodrite_4",
            skill_icon = "bloodrite",
            rarity = "purple",
            has_video = 1,

            radius = 100,
            root = 1.5,
            range = 400,
            duration = 0.3, 
            is_purgable_self = 1,
        },
        ["modifier_bloodseeker_bloodrite_7"] = 
        {
            skill_number = 2,
            mini_icon = "bloodrite",
            skill_icon = "bloodrite",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            duration = 6,
            cost = 4,
            radius = 450,
            damage_inc = 100,
            interval = 0.5,
            damage = 100,
            damage_type = DAMAGE_TYPE_MAGICAL,
            trigger_ability = "bloodseeker_blood_mist_custom",
            skill_name = "bloodseeker_blood_bath_custom",
        },
        ["modifier_bloodseeker_thirst_1"] = 
        {
            skill_number = 3,
            mini_icon = "thirst_1",
            skill_icon = "thirst",
            rarity = "blue",

            damage = {6, 9, 12},
            max = 1200,
        },
        ["modifier_bloodseeker_thirst_2"] = 
        {
            skill_number = 3,
            mini_icon = "thirst_2",
            skill_icon = "thirst",
            rarity = "blue",

            cleave = {20, 30, 40},
            move = {30, 45, 60},
        },
        ["modifier_bloodseeker_thirst_3"] = 
        {
            skill_number = 3,
            mini_icon = "thirst_3",
            skill_icon = "thirst",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            count = 4,
            count_inc = 2,
            damage = {150, 200},
            heal = {35, 50},
            health = 50,
            duration = 8,
        },
        ["modifier_bloodseeker_thirst_4"] = 
        {
            skill_number = 3,
            mini_icon = "thirst_4",
            skill_icon = "thirst",
            rarity = "purple",

            thresh = 15,
            health = 50,
            stun = 1,
            talent_cd = 3.5,
            is_basher = 1,
            is_through_bkb = 1,
        },
        ["modifier_bloodseeker_thirst_7"] = 
        {
            skill_number = 3,
            mini_icon = "thirst",
            skill_icon = "thirst",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            range = 800,
            min_range = 300,
            attacks = 2,
            attacks_creeps = 1,
            damage = 100,
            speed = 2000,
            talent_cd = 8,
            delay = 0.25,
            is_root_disabled = 1,
            cd_inc = 2,
            health = 50,
            skill_name = "bloodseeker_thirst_custom",
        },
        ["modifier_bloodseeker_rupture_1"] = 
        {
            skill_number = 4,
            mini_icon = "rupture_1",
            skill_icon = "rupture",
            rarity = "blue",

            damage = {50, 75, 100},
            max = 8,
        },
        ["modifier_bloodseeker_rupture_2"] = 
        {
            skill_number = 4,
            mini_icon = "rupture_2",
            skill_icon = "rupture",
            rarity = "blue",

            range = {120, 180, 240},
            cd = {-6, -9, -12},
        },
        ["modifier_bloodseeker_rupture_3"] = 
        {
            skill_number = 4,
            mini_icon = "rupture_3",
            skill_icon = "rupture",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal_reduce = {-20, -35},
            damage = {18, 30},
            radius = 350,
            damage_type = DAMAGE_TYPE_PURE,
            is_through_bkb = 1,
        },
        ["modifier_bloodseeker_rupture_4"] = 
        {
            skill_number = 4,
            mini_icon = "rupture_4",
            skill_icon = "rupture",
            rarity = "purple",

            cdr = 12,
            slow_resist = 50,
            cd_items = -50,
        },
        ["modifier_bloodseeker_rupture_7"] = 
        {
            skill_number = 4,
            mini_icon = "rupture",
            skill_icon = "rupture",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            damage = 15,
            damage_reduce = -80,
            creeps = 800,
            talent_cd = 10,
            cd_inc = -1,
            cd_distance = 180,
            duration = 2,
            is_blockable = 1,
            trigger_ability = "bloodseeker_rupture_custom_legendary",
            skill_name = "bloodseeker_rupture_custom",
        },
    },

    npc_dota_hero_monkey_king = 
    {
        ["modifier_monkey_king_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            range = {100, 150, 200},
            stun = {0.3, 0.45, 0.6},
        },
        ["modifier_monkey_king_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            move = {20, 30, 40},
            evasion = {8, 12, 16},
            bonus = 2,
            duration = 5,
        },
        ["modifier_monkey_king_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            magic = {8, 12, 16},
            mana = {2, 3, 4},
        },

        ["modifier_monkey_king_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            tree_cd = -1.5,
            cd = -5,
            invun = 0.8,
        },
        ["modifier_monkey_king_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            speed = 30,
            silence = 2.5,
            is_purgable_self = 1,
            talent_cd = 8,
        },
        ["modifier_monkey_king_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            cast = -0.3,
            bkb = 2.5,
            heal = 6,
            duration = 2,
        },

        ["modifier_monkey_king_boundless_1"] = 
        {
            skill_number = 1,
            mini_icon = "boundless_1",
            skill_icon = "boundless",
            rarity = "blue",

            damage = {30, 45, 60},
            duration = 6,
            cleave = {20, 30, 40},
        },
        ["modifier_monkey_king_boundless_2"] = 
        {
            skill_number = 1,
            mini_icon = "boundless_2",
            skill_icon = "boundless",
            rarity = "blue",

            slow = {-20, -30, -40},
            duration = 4,
            cd = {-2, -3, -4},
        },
        ["modifier_monkey_king_boundless_3"] = 
        {
            skill_number = 1,
            mini_icon = "boundless_3",
            skill_icon = "boundless",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {35, 60},
            armor = {-20, -35},
            base = {-3, -5},
            duration = 4,
            is_through_bkb = 1,
            alt_talent = "modifier_monkey_king_boundless_7",
        },
        ["modifier_monkey_king_boundless_4"] = 
        {
            skill_number = 1,
            mini_icon = "boundless_4",
            skill_icon = "boundless",
            rarity = "purple",

            duration = 4,
            move = 30,
            slow_resist = 50,
            cd_inc = -50,
            cast = -0.15,
            alt_talent = "modifier_monkey_king_boundless_7",
        },
        ["modifier_monkey_king_boundless_7"] = 
        {
            skill_number = 1,
            mini_icon = "boundless",
            skill_icon = "boundless",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            duration = 5,
            max = 3,
            damage = 2.3,
            range = 1200,
            damage_k = 1.5,
            skill_name = "monkey_king_boundless_strike_custom",
        },

        ["modifier_monkey_king_tree_1"] = 
        {
            skill_number = 2,
            mini_icon = "tree_1",
            skill_icon = "tree",
            rarity = "blue",

            spell = {6, 9, 12},
            damage = {3, 4.5, 6},
            creeps = {100, 150, 200},
        },
        ["modifier_monkey_king_tree_2"] = 
        {
            skill_number = 2,
            mini_icon = "tree_2",
            skill_icon = "tree",
            rarity = "blue",

            cd = {-2, -3, -4},
            heal_reduce = {-12, -18, -24},
            duration = 5,
        },
        ["modifier_monkey_king_tree_3"] = 
        {
            skill_number = 2,
            mini_icon = "tree_3",
            skill_icon = "tree",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            cdr = {8, 15},
            delay = 2,
            damage = {30, 50},
            stun = 0.3,
            radius = 80,
        },
        ["modifier_monkey_king_tree_4"] = 
        {
            skill_number = 2,
            mini_icon = "tree_4",
            skill_icon = "tree",
            rarity = "purple",
            has_video = 1,

            shield = 8,
            base = 160,
            talent_cd = 8,
            cast = -50,
        },
        ["modifier_monkey_king_tree_7"] = 
        {
            skill_number = 2,
            mini_icon = "tree",
            skill_icon = "tree",
            rarity = "orange",
            complexity = 2,

            damage = 2.5,
            duration = 135,
            cd = 45,
            radius = 120,
            tower_radius = 1500,
            bonus_1 = 10,
            bonus_2 = 25,
            max = 40,
            legendary = 20,
            bounty = 75,
            vision = 500,
            charge = 2,
            chance = 10,
            refresh_cd = 4,
            mana = -50,

            skill_change = "jingu_mastery_magic",
            skill_name = "monkey_king_tree_dance_custom",
            trigger_ability = "monkey_king_primal_spring_custom",
        },

        ["modifier_monkey_king_mastery_1"] = 
        {
            skill_number = 3,
            mini_icon = "mastery_1",
            skill_icon = "mastery",
            rarity = "blue",

            speed = {20, 30, 40},
            damage = {12, 18, 24},
        },
        ["modifier_monkey_king_mastery_2"] = 
        {
            skill_number = 3,
            mini_icon = "mastery_2",
            skill_icon = "mastery",
            rarity = "blue",

            health = {1, 1.5, 2},
            heal = {16, 24, 32},
        },
        ["modifier_monkey_king_mastery_3"] = 
        {
            skill_number = 3,
            mini_icon = "mastery_3",
            skill_icon = "mastery",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            agility = {8, 15},
            damage = 40,
            attacks = {2, 3},
            interval = 0.25,
            damage_legendary = 80,
            alt_talent = "modifier_monkey_king_boundless_7",
        },
        ["modifier_monkey_king_mastery_4"] = 
        {
            skill_number = 3,
            mini_icon = "mastery_4",
            skill_icon = "mastery",
            rarity = "purple",
            has_video = 1,

            count = 1,
            attack = -1,
            health = 40,
            damage_reduce = -25,
            status = 25,
            is_breakable = 1,
        },
        ["modifier_monkey_king_mastery_7"] = 
        {
            skill_number = 3,
            mini_icon = "mastery",
            skill_icon = "mastery",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            speed = 2200,
            move_slow = -50,
            back = 250,
            range = 600,
            cd = 8,
            turn_slow = -70,
            cd_inc = -3,
            slow_duration = 1.2,
            agi = 8,
            duration = 30,
            talent_cd = 8,
            is_through_bkb = 1,
            is_root_disabled = 1,
            skill_name = "monkey_king_jingu_mastery_custom",
        },

        ["modifier_monkey_king_command_1"] = 
        {
            skill_number = 4,
            mini_icon = "command_1",
            skill_icon = "command",
            rarity = "blue",

            heal = {12, 18, 24},
            damage = {20, 30, 40},
            radius = 600,
            max = 3,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_monkey_king_command_2"] = 
        {
            skill_number = 4,
            mini_icon = "command_2",
            skill_icon = "command",
            rarity = "blue",

            cd = {-4, -6, -8},
            duration = {2, 3, 4},
        },
        ["modifier_monkey_king_command_3"] = 
        {
            skill_number = 4,
            mini_icon = "command_3",
            skill_icon = "command",
            rarity = "purple",
            main_epic = 1,

            damage = {120, 200},
            chance = 30,
            magic = {-3, -5},
            max = 8,
            duration = 15,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_monkey_king_command_4"] = 
        {
            skill_number = 4,
            mini_icon = "command_4",
            skill_icon = "command",
            rarity = "purple",
            has_video = 1,

            slow = -40,
            duration = 3,
            damage = -60,
            cd_items = 60,
        },
        ["modifier_monkey_king_command_7"] = 
        {
            skill_number = 4,
            mini_icon = "command",
            skill_icon = "command",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            delay = 1,
            heal = 75,
            range = 300,
            spell = -0,
            cdr = 25,
            cd = -4,
            duration = 2,
            delay_spring = 0.5,
            skill_change = "jingu_mastery_magic",
            skill_name = "monkey_king_wukongs_command_custom",
        },
    },

    npc_dota_hero_mars = 
    {
        ["modifier_mars_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            move = {30, 45, 60},
            status = {10, 15, 20},
        },
        ["modifier_mars_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            armor = {2, 3, 4},
            str = {4, 6, 8},
            max = 10,
            cd = 0.5,
            bonus = 4,
            duration = 8,
        },
        ["modifier_mars_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            cdr = {6, 9, 12},
            mana = {0.8, 1.2, 1.6},
        },

        ["modifier_mars_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            stun = 0.5,
            speed = 25,
            silence = 2,
            is_purgable_self = 1,
        },
        ["modifier_mars_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            speed = 1250,
            distance = 800,
            slow_resist = 30,
            radius = -100,
            is_root_disabled = 1,
        },
        ["modifier_mars_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -25,
            heal = 2,
            break_effect = -50,
        },

        ["modifier_mars_spear_1"] = 
        {
            skill_number = 1,
            mini_icon = "spear_1",
            skill_icon = "spear",
            rarity = "blue",

            damage = {4, 6, 8},
            damage_creeps = {80, 120, 160},
            heal_reduce = {-16, -24, -32},
            duration = 5,
        },
        ["modifier_mars_spear_2"] = 
        {
            skill_number = 1,
            mini_icon = "spear_2",
            skill_icon = "spear",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            range = {100, 150, 200},
            radius = {40, 60, 80},
            alt_talent = "modifier_mars_arena_7",
        },
        ["modifier_mars_spear_3"] = 
        {
            skill_number = 1,
            mini_icon = "spear_3",
            skill_icon = "spear",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {25, 40},
            heal = {70, 100},
            timer = 3,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_mars_spear_4"] = 
        {
            skill_number = 1,
            mini_icon = "spear_4",
            skill_icon = "spear",
            rarity = "purple",

            move = 25,
            cd_items = 3,
            duration = 3,
            cd_items_arena = 60,
        },
        ["modifier_mars_spear_7"] = 
        {
            skill_number = 1,
            mini_icon = "spear",
            skill_icon = "spear",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            damage = 150,
            radius = 350,
            range = 500,
            slow = -100,
            cd_inc = -35,
            slow_duration = 1.5,
            turn_speed = 125,
            cast = 1.6,
            skill_name = "mars_spear_custom",
        },

        ["modifier_mars_rebuke_1"] = 
        {
            skill_number = 2,
            mini_icon = "rebuke_1",
            skill_icon = "rebuke",
            rarity = "blue",

            base = {-3, -4.5, -6},
            creeps = {-6, -9, -12},
            armor = {-10, -15, -20},
            duration = 5,
        },
        ["modifier_mars_rebuke_2"] = 
        {
            skill_number = 2,
            mini_icon = "rebuke_2",
            skill_icon = "rebuke",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = {1, 1.5, 2},
        },
        ["modifier_mars_rebuke_3"] = 
        {
            skill_number = 2,
            mini_icon = "rebuke_3",
            skill_icon = "rebuke",
            rarity = "purple",
            main_epic = 1,

            crit = {35, 60},
            damage = {15, 25},
            max = 30,
            is_perma = 1,
            mod_name = "modifier_mars_gods_rebuke_custom_perma"
        },
        ["modifier_mars_rebuke_4"] = 
        {
            skill_number = 2,
            mini_icon = "rebuke_4",
            skill_icon = "rebuke",
            rarity = "purple",
            has_video = 1,

            cast = -0.1,
            knock = 50,
            base = 100,
            shield = 150,
            min_distance = 200,
            shield_reduce = -60,
            duration = 6,
            alt_talent = "modifier_mars_bulwark_7",
        },
        ["modifier_mars_rebuke_7"] = 
        {
            skill_number = 2,
            mini_icon = "rebuke",
            skill_icon = "rebuke",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            cd_inc = -50,
            duration = 5,
            damage_reduce = -40,
            damage_inc = 40,
            talent_cd = 12,
            mana = -50,
            max = 10,
            skill_name = "mars_gods_rebuke_custom",
            trigger_ability = "mars_avatar_custom",
            banned_talent = "modifier_mars_arena_7",
        },

        ["modifier_mars_bulwark_1"] = 
        {
            skill_number = 3,
            mini_icon = "bulwark_1",
            skill_icon = "bulwark",
            rarity = "blue",

            speed = {30, 45, 60},
            damage = {30, 45, 60},
            max = 12,
            stack = 3,
            duration = 10,
            duration_creeps = 3,
        },
        ["modifier_mars_bulwark_2"] = 
        {
            skill_number = 3,
            mini_icon = "bulwark_2",
            skill_icon = "bulwark",
            rarity = "blue",

            heal = {10, 15, 20},
            bonus = 2,
        },
        ["modifier_mars_bulwark_3"] = 
        {
            skill_number = 3,
            mini_icon = "bulwark_3",
            skill_icon = "bulwark",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {25, 40},
            heal = {70, 100},
            duration = 7,
            max = 3,
            chance = 20,
            move = 500,
        },
        ["modifier_mars_bulwark_4"] = 
        {
            skill_number = 3,
            mini_icon = "bulwark_4",
            skill_icon = "bulwark",
            rarity = "purple",
            has_video = 1,

            stun = 1.2,
            range = 100,
            chance = 20,
            talent_cd = 3,
            is_through_bkb = 1,
            is_basher = 1,
        },
        ["modifier_mars_bulwark_7"] = 
        {
            skill_number = 3,
            mini_icon = "bulwark",
            skill_icon = "bulwark",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            max = 4,
            duration = 6,
            speed = 70,
            duration_inc = 1,
            damage_reduce = -60,
            talent_cd = 12,
            duration_max = 10,
            skill_name = "mars_bulwark_custom",
        },

        ["modifier_mars_arena_1"] = 
        {
            skill_number = 4,
            mini_icon = "arena_2",
            skill_icon = "arena",
            rarity = "blue",

            damage = {40, 60, 80},
            spell = {6, 9, 12},
        },
        ["modifier_mars_arena_2"] = 
        {
            skill_number = 4,
            mini_icon = "arena_3",
            skill_icon = "arena",
            rarity = "blue",

            duration = {1, 1.5, 2},
            cd = {-4, -6, -8}
        },
        ["modifier_mars_arena_3"] = 
        {
            skill_number = 4,
            mini_icon = "arena_3",
            skill_icon = "arena",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            duration = 6,
            damage = {40, 70},
            interval = 1,
            magic = {-20, -35},
            max = 8,
            effect_duration = 12,
        },
        ["modifier_mars_arena_4"] = 
        {
            skill_number = 4,
            mini_icon = "arena_4",
            skill_icon = "arena",
            rarity = "purple",
            has_video = 1,

            heal = 25,
            damage_reduce = -25,
            duration = 8,
            shield = 20,
        },
        ["modifier_mars_arena_7"] = 
        {
            skill_number = 4,
            mini_icon = "arena",
            skill_icon = "arena",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            damage = 125,
            damage_inc = 40,
            talent_cd = 3,
            radius = 400,
            cast = 0.5,
            max = 6,
            duration = 15,
            slow = -100,
            slow_duration = 1,
            cd_inc = 2,
            knock_duration = 0.25,
            knock_distance = 550,
            cast = 0.5,
            trigger_ability = "mars_revenge_custom",
            skill_name = "mars_arena_of_blood_custom",
            banned_talent = "modifier_mars_rebuke_7",
        },
    },

    npc_dota_hero_zuus = 
    {
        ["modifier_zuus_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            slow = {0.3, 0.45, 0.6},
            stun = {0.3, 0.45, 0.6},
        },
        ["modifier_zuus_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            armor = {6, 9, 12},
            shield = {16, 24, 32},
            duration = 10,
        },
        ["modifier_zuus_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            range = {120, 180, 240},
            mana = {12, 18, 24},
        },
        ["modifier_zuus_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",

            range = 200,
        },
        ["modifier_zuus_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            status = 15,
            health = 30,
            duration = 2,
            damage_reduce = -80,
            radius = 550,
            knock_duration = 0.3,
            talent_cd = 20,
            is_breakable = 1,
        },
        ["modifier_zuus_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            skill_icon = "wrath",
            rarity = "purple",

            silence = 3,
            cdr = 2,
            max = 8,
            radius = 2000,
            is_perma = 1,
            duration = 10,
            is_purgable_self = 1,
            mod_name = "modifier_zuus_thundergods_wrath_custom_kills",
        },

        ["modifier_zuus_arc_1"] = 
        {
            skill_number = 1,
            mini_icon = "arc_1",
            skill_icon = "arc",
            rarity = "blue",

            attack = {20, 30, 40},
            damage = {20, 30, 40},
            damage_legendary = {12, 18, 24},
            alt_talent = "modifier_zuus_arc_7",
        },
        ["modifier_zuus_arc_2"] = 
        {
            skill_number = 1,
            mini_icon = "arc_2",
            skill_icon = "arc",
            rarity = "blue",

            move = {30, 45, 60},
            slow = {-4, -6, -8},
            max = 5,
            duration = 6,
        },
        ["modifier_zuus_arc_3"] = 
        {
            skill_number = 1,
            mini_icon = "arc_3",
            skill_icon = "arc",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            cd = {-0.4, -0.8},
            chance = {25, 40},
            delay = 0.2,
        },
        ["modifier_zuus_arc_4"] = 
        {
            skill_number = 1,
            mini_icon = "arc_4",
            skill_icon = "arc",
            rarity = "purple",

            heal = 30,
            damage_reduce = -6,
            max = 5,
            duration = 6,
            cast = -0.1,
        },
        ["modifier_zuus_arc_7"] = 
        {
            skill_number = 1,
            mini_icon = "arc",
            skill_icon = "arc",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            damage = 110,
            interval = 0.25,
            charge = 1,
            duration = 8,
            max = 10,
            cd = 3,
            radius = 500,
            mana = -50,
            skill_name = "zuus_arc_lightning_custom",
        },
        ["modifier_zuus_bolt_1"] = 
        {
            skill_number = 2,
            mini_icon = "bolt_1",
            skill_icon = "bolt",
            rarity = "blue",

            cd = {-1.2, -1.8, -2.4},
        },
        ["modifier_zuus_bolt_2"] = 
        {
            skill_number = 2,
            mini_icon = "bolt_2",
            skill_icon = "bolt",
            rarity = "blue",

            damage = {80, 120, 160},
            heal_reduce = {-10, -15, -20},
            duration = 6,
        },
        ["modifier_zuus_bolt_3"] = 
        {
            skill_number = 2,
            mini_icon = "bolt_3",
            skill_icon = "bolt",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            heal = {25, 40},
            count = 4,
            damage = {50, 80},
            radius = 900,
            duration = 10,
            delay = 0.3,
            stun = 0.3,
        },
        ["modifier_zuus_bolt_4"] = 
        {
            skill_number = 2,
            mini_icon = "bolt_4",
            skill_icon = "bolt",
            rarity = "purple",
            has_video = 1,

            cast = -50,
            talent_cd = 12,
            root = 2,
            is_purgable_self = 1,
        },
        ["modifier_zuus_bolt_7"] = 
        {
            skill_number = 2,
            mini_icon = "bolt",
            skill_icon = "bolt",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            max = 5,
            damage = 30,
            stun = 0.1,
            damage_inc = 400,
            talent_cd = 3,
            max_stack = 20,
            radius = 360,
            damage_k = 1.5,
            interval = 0.3,
            duration = 10,
            skill_name = "zuus_lightning_bolt_custom",
            trigger_ability = "zuus_stormkeeper_custom"
        },
        ["modifier_zuus_jump_1"] = 
        {
            skill_number = 3,
            mini_icon = "jump_1",
            skill_icon = "jump",
            rarity = "blue",

            attacks = 3,
            damage = {50, 75, 100},
            interval = 0.13,
            is_through_bkb = 1,
        },
        ["modifier_zuus_jump_2"] = 
        {
            skill_number = 3,
            mini_icon = "jump_2",
            skill_icon = "jump",
            rarity = "blue",

            cd = {-2, -3, -4},
            heal = {6, 9, 12},
        },
        ["modifier_zuus_jump_3"] = 
        {
            skill_number = 3,
            mini_icon = "jump_3",
            skill_icon = "jump",
            rarity = "purple",
            main_epic = 1,

            damage = {15, 25},
            stats = {2.5, 4},
            max = 10,
            duration = 10,
            duration_creeps = 3,
        },
        ["modifier_zuus_jump_4"] = 
        {
            skill_number = 3,
            mini_icon = "jump_4",
            skill_icon = "jump",
            rarity = "purple",
            has_video = 1,

            leash = 2,
            slow = -50,
            delay = 2,
            radius = 350,
            stun = 1.2,
        },
        ["modifier_zuus_jump_7"] = 
        {
            skill_number = 3,
            mini_icon = "jump",
            skill_icon = "jump",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            duration = 10,
            duration_creeps = 4,
            range = 400,
            cd_inc = -10,
            speed = 20,
            max = 15,
            skill_name = "zuus_heavenly_jump_custom",
        },
        ["modifier_zuus_wrath_1"] = 
        {
            skill_number = 4,
            mini_icon = "wrath_1",
            skill_icon = "wrath",
            rarity = "blue",

            damage = {12, 18, 24},
            spell = {6, 9, 12},
        },
        ["modifier_zuus_wrath_2"] = 
        {
            skill_number = 4,
            mini_icon = "wrath_2",
            skill_icon = "wrath",
            rarity = "blue",

            cd = {-10, -15, -20},
            heal = {10, 15, 20},
        },
        ["modifier_zuus_wrath_3"] = 
        {
            skill_number = 4,
            mini_icon = "wrath_3",
            skill_icon = "wrath",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {70, 120},
            magic = {-2.5, -4},
            max = 10,
            chance = 25,
            radius = 350,
            duration = 5,
            range = 2000,
            effect_duration = 10,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_zuus_wrath_4"] = 
        {
            skill_number = 4,
            mini_icon = "wrath_4",
            skill_icon = "wrath",
            rarity = "purple",

            move = 30,
            resist = 30,
            duration = 3,
            cd_items = -1,
            cd_items_wrath = -4,
        },
        ["modifier_zuus_wrath_7"] = 
        {
            skill_number = 4,
            mini_icon = "wrath",
            skill_icon = "wrath",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            delay = 1.6,
            damage = 14,
            stun = 0.5,
            talent_cd = 5,
            cd_wrath = -25,
            cd_bolt = -100,
            radius = 400,
            damage_creeps = 300,
            damage_type = DAMAGE_TYPE_MAGICAL,
            trigger_ability = "zuus_cloud_custom",
            skill_name = "zuus_thundergods_wrath_custom",
        },
    },

    npc_dota_hero_leshrac = 
    {
        ["modifier_leshrac_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            mana_loss = {12, 18, 24},
            mana = {10, 15, 20},
            duration = 4,
            cd_inc = {-2, -3, -4},
            alt_talent = "modifier_leshrac_nova_7",
        },
        ["modifier_leshrac_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            move = {20, 30, 40},
            evasion = {8, 12, 16},
            bonus = 2,
        },
        ["modifier_leshrac_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            range = {30, 45, 60},
            health = {10, 15, 20},
        },

        ["modifier_leshrac_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            cast = -0.3,
            speed = 1400,
            is_root_disabled = 1,
            trigger_ability = "leshrac_split_earth_custom",
        },
        ["modifier_leshrac_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            cdr = 12,
            speed = 600,
            duration = 2,
            cd = 5,
        },
        ["modifier_leshrac_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -30,
            health = 30,
            talent_cd = 15,
            bkb = 2,
            is_breakable = 1,
        },

        ["modifier_leshrac_earth_1"] = 
        {
            skill_number = 1,
            mini_icon = "earth_1",
            skill_icon = "earth",
            rarity = "blue",

            damage = {8, 12, 16},
            max = 5,
            damage_duration = 8,
            armor = {-4, -6, -8},
            armor_duration = 4,
        },
        ["modifier_leshrac_earth_2"] = 
        {
            skill_number = 1,
            mini_icon = "earth_2",
            skill_icon = "earth",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            slow = {-20, -30, -40},
            duration = 3,
            is_purgable_self = 1,
        },
        ["modifier_leshrac_earth_3"] = 
        {
            skill_number = 1,
            mini_icon = "earth_3",
            skill_icon = "earth",
            rarity = "purple",
            main_epic = 1,

            heal = {25, 40},
            damage = {40, 70},
            duration = 4,
            bonus = 2,
        },
        ["modifier_leshrac_earth_4"] = 
        {
            skill_number = 1,
            mini_icon = "earth_4",
            skill_icon = "earth",
            rarity = "purple",
            has_video = 1,

            chance = 25,
            stun = 1,
            delay = 0.6,
            radius = 230,
            stun_inc = 0.5,
            is_basher = 1,
            talent_cd = 3,
            is_through_bkb = 1,
        },
        ["modifier_leshrac_earth_7"] = 
        {
            skill_number = 1,
            mini_icon = "earth",
            skill_icon = "earth",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            chance = 20,
            chance_inc = 20,
            max = 4,
            edict_reduce = 2,
            damage = 100,
            cd = -30,
            stun = -30,
            duration = 15,
            skill_name = "leshrac_split_earth_custom",
        },
        ["modifier_leshrac_edict_1"] = 
        {
            skill_number = 2,
            mini_icon = "edict_1",
            skill_icon = "edict",
            rarity = "blue",

            damage = {8, 12, 16},
            slow = {-1, -1.5, -2},
            duration = 3,
            max = 20,
        },
        ["modifier_leshrac_edict_2"] = 
        {
            skill_number = 2,
            mini_icon = "edict_2",
            skill_icon = "edict",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = {10, 15, 20},
        },
        ["modifier_leshrac_edict_3"] = 
        {
            skill_number = 2,
            mini_icon = "edict_3",
            skill_icon = "edict",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            count = {3, 5},
            talent_cd = 0.5,
            damage = {15, 25},
            max = 600,
            is_perma = 1,
            mod_name = "modifier_leshrac_diabolic_edict_custom_damage_stack"
        },
        ["modifier_leshrac_edict_4"] = 
        {
            skill_number = 2,
            mini_icon = "edict_4",
            skill_icon = "edict",
            rarity = "purple",
            has_video = 1,

            root = 2,
            talent_cd = 10,
            cd_items = -1,
            count = 10,
            is_purgable_self = 1,
        },
        ["modifier_leshrac_edict_7"] = 
        {
            skill_number = 2,
            mini_icon = "edict",
            skill_icon = "edict",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            magic = -2,
            stun = 1.2,
            duration = 3,
            effect_duration = 6,
            is_through_bkb = 1,
            skill_name = "leshrac_diabolic_edict_custom",
        },
        ["modifier_leshrac_storm_1"] = 
        {
            skill_number = 3,
            mini_icon = "storm_1",
            skill_icon = "storm",
            rarity = "blue",

            int = {6, 9, 12},
            damage = {60, 90, 120},
        
            damage_earth = {60, 90, 120},
            alt_talent = "modifier_leshrac_earth_7",
        },
        ["modifier_leshrac_storm_2"] = 
        {
            skill_number = 3,
            mini_icon = "storm_2",
            skill_icon = "storm",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            heal = {16, 24, 32},
        },
        ["modifier_leshrac_storm_3"] = 
        {
            skill_number = 3,
            mini_icon = "storm_3",
            skill_icon = "storm",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            cd = 0.5,
            speed = {6, 10},
            max = 15,
            chance = 25,
            damage = {60, 100},
            count = 2,
            slow = 0.5,
            duration = 5,
        },
        ["modifier_leshrac_storm_4"] = 
        {
            skill_number = 3,
            mini_icon = "storm_4",
            skill_icon = "storm",
            rarity = "purple",
            has_video = 1,

            slow = 0.5,
            cast = -0.2,
            talent_cd = 10,
            distance_min = 50,
            distance_max = 400,
            duration = 0.3,
            silence = 2.5,
        },
        ["modifier_leshrac_storm_7"] = 
        {
            skill_number = 3,
            mini_icon = "storm",
            skill_icon = "storm",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            damage = 400,
            radius = 280,
            interval = 0.25,
            bva = -0.7,
            duration = 3,
            duration_hero = 8,
            effect_duration = 5,
            max = 6,
            root = 1.5,
            is_purgable_self = 1,
            skill_name = "leshrac_lightning_storm_custom",
        },

        ["modifier_leshrac_nova_1"] = 
        {
            skill_number = 4,
            mini_icon = "nova_1",
            skill_icon = "nova",
            rarity = "blue",

            damage = {2, 3, 4},
            base = {20, 30, 40},
        },
        ["modifier_leshrac_nova_2"] = 
        {
            skill_number = 4,
            mini_icon = "nova_2",
            skill_icon = "nova",
            rarity = "blue",

            heal = {12, 18, 24},
            heal_reduce = {-12, -18, -24},
            duration = 3,
        },
        ["modifier_leshrac_nova_3"] = 
        {
            skill_number = 4,
            mini_icon = "nova_3",
            skill_icon = "nova",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            interval = {-0.4, -0.6},
            health_reduce = {-18, -30},
            max = 10,
            duration = 5,
        },
        ["modifier_leshrac_nova_4"] = 
        {
            skill_number = 4,
            mini_icon = "nova_4",
            skill_icon = "nova",
            rarity = "purple",
            has_video = 1,

            shield = 20,
            heal = 30,
            status = 20,
        },
        ["modifier_leshrac_nova_7"] = 
        {
            skill_number = 4,
            mini_icon = "nova",
            skill_icon = "nova",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            cast = 2,
            mana = 100,
            heal = 60,
            damage = 90,
            radius = 500,
            talent_cd = 18,
            skill_name = "leshrac_pulse_nova_custom",
            trigger_ability = "leshrac_pulse_nova_custom_legendary",
        },
    },

    npc_dota_hero_crystal_maiden = 
    {
        ["modifier_maiden_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            move_speed = {30, 45, 60},
            cast_range = {100, 150, 200},
        },
        ["modifier_maiden_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            armor = {8, 12, 16},
            duration = 4,
            health = {1.2, 1.8, 2.4},
        },
        ["modifier_maiden_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            duration = 4,
            mana = {4, 6, 8},
        },

        ["modifier_maiden_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            range = 600,
            damage_reduce = -40,  
            invun = 1, 
            is_root_disabled = 1,   
        },
        ["modifier_maiden_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            talent_cd = 25,
            heal_inc = 15,
            heal = 20,
            duration = 2.5,
            is_breakable = 1,
        },
        ["modifier_maiden_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            status = 35,
            cd = 3,
            mana = 20,
            radius = 900,
        },

        ["modifier_maiden_crystal_1"] = 
        {
            skill_number = 1,
            mini_icon = "crystal_1",
            skill_icon = "crystal",
            rarity = "blue",

            speed = {20, 30, 40},
            damage = {50, 75, 100},
        },
        ["modifier_maiden_crystal_2"] = 
        {
            skill_number = 1,
            mini_icon = "crystal_2",
            skill_icon = "crystal",
            rarity = "blue",

            cd = {-2, -3, -4},
        },
        ["modifier_maiden_crystal_3"] = 
        {
            skill_number = 1,
            mini_icon = "crystal_3",
            skill_icon = "crystal",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal = {25, 40},
            damage = {50, 80},
            chance = 30,
            duration = 2,
            radius = 250,
        },
        ["modifier_maiden_crystal_4"] = 
        {
            skill_number = 1,
            mini_icon = "crystal_4",
            skill_icon = "crystal",
            rarity = "purple",
            has_video = 1,

            cast = -0.2,
            talent_cd = 10,
            stun = 1.2,
        },
        ["modifier_maiden_crystal_7"] = 
        {
            skill_number = 1,
            mini_icon = "crystal",
            skill_icon = "crystal",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            attack_range = 200,
            radius = 800,
            talent_cd = 10,
            duration = 6,
            trigger_ability = "crystal_maiden_crystal_nova_custom_legendary",
            skill_name = "crystal_maiden_crystal_nova_custom",
        },

        ["modifier_maiden_frostbite_1"] = 
        {
            skill_number = 2,
            mini_icon = "frostbite_1",
            skill_icon = "frostbite",
            rarity = "blue",

            damage = {20, 30, 40},
            resist = {-8, -12, -16},
            duration = 5,
        },
        ["modifier_maiden_frostbite_2"] = 
        {
            skill_number = 2,
            mini_icon = "frostbite_2",
            skill_icon = "frostbite",
            rarity = "blue",

            heal = {12, 18, 24},
            bonus = 2,
        },
        ["modifier_maiden_frostbite_3"] = 
        {
            skill_number = 2,
            mini_icon = "frostbite_3",
            skill_icon = "frostbite",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            interval = 1,
            radius = 400,
            spell = {1.8, 3},
            effect_duration = 10,
            max = 8,
            damage = {60, 100},
            duration = 6,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_maiden_frostbite_4"] = 
        {
            skill_number = 2,
            mini_icon = "frostbite_4",
            skill_icon = "frostbite",
            rarity = "purple",
            has_video = 1,

            cd = -1,
            cd_items = -2,
            cd_field = 100,
        },
        ["modifier_maiden_frostbite_7"] = 
        {
            skill_number = 2,
            mini_icon = "frostbite",
            skill_icon = "frostbite",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            damage = 50,
            slow = -50,
            radius = 550,
            max = 8,
            duration = 3,
            skill_name = "crystal_maiden_frostbite_custom",
        },

        ["modifier_maiden_arcane_1"] = 
        {
            skill_number = 3,
            mini_icon = "arcane_1",
            skill_icon = "arcane",
            rarity = "blue",

            stats = {6, 9, 12},
            damage = {10, 15, 20},
        },
        ["modifier_maiden_arcane_2"] = 
        {
            skill_number = 3,
            mini_icon = "arcane_2",
            skill_icon = "arcane",
            rarity = "blue",

            range = {100, 150, 200},
            slow = {-20, -30, -40},
            duration = 3,
        },
        ["modifier_maiden_arcane_3"] = 
        {
            skill_number = 3,
            mini_icon = "arcane_3",
            skill_icon = "arcane",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            spawn_radius = 200,
            radius = 500,
            stun = {0.6, 1},
            duration = 1.5,
            damage = {150, 250},
        },
        ["modifier_maiden_arcane_4"] = 
        {
            skill_number = 3,
            mini_icon = "arcane_4",
            skill_icon = "arcane",
            rarity = "purple",
            has_video = 1,

            count = 1,
            duration_legendary = 0.5,
            move = 40,
            duration = 2.5,
            alt_talent = "modifier_maiden_arcane_7"
        },
        ["modifier_maiden_arcane_7"] = 
        {
            skill_number = 3,
            mini_icon = "arcane",
            skill_icon = "arcane",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            duration = 2,
            cdr = 2.5,
            damage = 5,
            max = 20,
            duration_hero = 10,
            duration_creeps = 3,
            skill_name = "crystal_maiden_arcane_aura_custom",
        },

        ["modifier_maiden_freezing_1"] = 
        {
            skill_number = 4,
            mini_icon = "freezing_1",
            skill_icon = "freezing",
            rarity = "blue",

            heal_reduce = {-10, -15, -20},
            duration = 5,
            base = {10, 15, 20},
            damage = {1, 1.5, 2},
        },
        ["modifier_maiden_freezing_2"] = 
        {
            skill_number = 4,
            mini_icon = "freezing_2",
            skill_icon = "freezing",
            rarity = "blue",

            cd = {-4, -6, -8},
            linger = {1, 1.5, 2},
        },
        ["modifier_maiden_freezing_3"] = 
        {
            skill_number = 4,
            mini_icon = "freezing_3",
            skill_icon = "freezing",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            radius = 1000,
            count = 2,
            auto = {150, 250},
            cdr = {8, 15},
            slow = 2,
        },
        ["modifier_maiden_freezing_4"] = 
        {
            skill_number = 4,
            mini_icon = "freezing_4",
            skill_icon = "freezing",
            rarity = "purple",
            has_video = 1,

            silence = 2,
            distance_min = 120,
            distance_max = 350,
            duration = 0.2,
            cd = 3,
            delay = 1.5,
            is_purgable_self = 1,
            trigger_ability = "crystal_maiden_freezing_field_custom",
        },
        ["modifier_maiden_freezing_7"] = 
        {
            skill_number = 4,
            mini_icon = "freezing",
            skill_icon = "freezing",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            talent_cd = 12,
            count = 4,
            cd_inc = -25,
            slow = 2,
            mana = 30,
            mana_regen = 20,
            trigger_ability = "crystal_maiden_freezing_field_legendary",
            skill_name = "crystal_maiden_freezing_field_custom",
        },
    },

    npc_dota_hero_snapfire = 
    {
        ["modifier_snapfire_scatter_1"] = 
        {
            skill_number = 1,
            mini_icon = "scatter_1",
            skill_icon = "scatter",
            rarity = "blue",

            cast = {-0.1, -0.15, -0.2},
            damage = {80, 120, 160},
        },
        ["modifier_snapfire_scatter_2"] = 
        {
            skill_number = 1,
            mini_icon = "scatter_2",
            skill_icon = "scatter",
            rarity = "blue",

            heal = {8, 12, 16},
            mana = {-40, -60, -80},
            duration = 4,
        },
        ["modifier_snapfire_scatter_3"] = 
        {
            skill_number = 1,
            mini_icon = "scatter_3",
            skill_icon = "scatter",
            rarity = "blue",

            duration = 4,
            slow = {0.5, 0.75, 1},
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_snapfire_scatter_4"] = 
        {
            skill_number = 1,
            mini_icon = "scatter_4",
            skill_icon = "scatter",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {12, 20},
            duration = 8,
            cd = {-3, -5},
            max = 6,
        },
        ["modifier_snapfire_scatter_5"] = 
        {
            skill_number = 1,
            mini_icon = "scatter_5",
            skill_icon = "scatter",
            rarity = "purple",
            has_video = 1,

            range = 50,
            cd = 8,
            stun = 1.2,
            width_start = 50,
            width_end = 180,
            trigger_ability = "snapfire_scatterblast_custom",
        },
        ["modifier_snapfire_scatter_6"] = 
        {
            skill_number = 1,
            mini_icon = "scatter_6",
            skill_icon = "scatter",
            rarity = "purple",

            speed = 25,
            attacks = 6,
            cd_items = -1,
            duration = 3,
        },
        ["modifier_snapfire_scatter_7"] = 
        {
            skill_number = 1,
            mini_icon = "scatter",
            skill_icon = "scatter",
            rarity = "orange",
            has_video = 1,

            skill_name = "snapfire_scatterblast_custom",
            count = 6,
            interval = 1,
            cd = -60,
        },
        ["modifier_snapfire_cookie_1"] = 
        {
            skill_number = 2,
            mini_icon = "cookie_1",
            skill_icon = "cookie",
            rarity = "blue",

            damage = {80, 120, 160},
            resist = {-2, -3, -4},
            duration = 8,
            max = 6,
        },
        ["modifier_snapfire_cookie_2"] = 
        {
            skill_number = 2,
            mini_icon = "cookie_2",
            skill_icon = "cookie",
            rarity = "blue",

            move = {20, 30, 40},
            bonus = 2,
            range = {100, 150, 200},
            duration = 4,
        },
        ["modifier_snapfire_cookie_3"] = 
        {
            skill_number = 2,
            mini_icon = "cookie_3",
            skill_icon = "cookie",
            rarity = "blue",

            stun = {0.3, 0.45, 0.6},
            cast = {-0.1, -0.15, -0.2},
        },
        ["modifier_snapfire_cookie_4"] = 
        {
            skill_number = 2,
            mini_icon = "cookie_4",
            skill_icon = "cookie",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {5, 8},
            distance = 180,
            chance = 30,
            count = 2,
            is_purgable_self = 1,
            damage_creeps = {150, 300},
            slow = -100,
            radius = 320,
            timer = 2,
            duration = {1, 2},
        },
        ["modifier_snapfire_cookie_5"] = 
        {
            skill_number = 2,
            mini_icon = "cookie_5",
            skill_icon = "cookie",
            rarity = "purple",
            has_video = 1,

            cd = 8,
            duration = 6,
            unslow = 3,
            shield = 15,
        },
        ["modifier_snapfire_cookie_6"] = 
        {
            skill_number = 2,
            mini_icon = "cookie_6",
            skill_icon = "cookie",
            rarity = "purple",

            damage = -50,
            charge = 2,
            cd = -4,
            stun = -50,
            trigger_ability = "snapfire_firesnap_cookie_custom_2",
        },
        ["modifier_snapfire_cookie_7"] = 
        {
            skill_number = 2,
            mini_icon = "cookie",
            skill_icon = "cookie",
            rarity = "orange",
            has_video = 1,

            mana = 0,
            distance = 230,
            chance = 18,
            skill_name = "snapfire_firesnap_cookie_custom",
            radius = 150,
            trigger_ability = "snapfire_firesnap_cookie_custom",
            cd = 0.5,
            max_speed = 30,
            timer = 4,
            speed = 10,
        },
        ["modifier_snapfire_shredder_1"] = 
        {
            skill_number = 3,
            mini_icon = "shredder_1",
            skill_icon = "shredder",
            rarity = "blue",

            damage = {20, 30, 40},
            bonus = {10, 15, 20},
        },
        ["modifier_snapfire_shredder_2"] = 
        {
            skill_number = 3,
            mini_icon = "shredder_2",
            skill_icon = "shredder",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = 3,
            is_purgable_self = 1,
            slow = {-20, -30, -40},
        },
        ["modifier_snapfire_shredder_3"] = 
        {
            skill_number = 3,
            mini_icon = "shredder_3",
            skill_icon = "shredder",
            rarity = "blue",

            move = {12, 18, 24},
            armor = {10, 15, 20},
            duration = 8,
            max = 10,
        },
        ["modifier_snapfire_shredder_4"] = 
        {
            skill_number = 3,
            mini_icon = "shredder_4",
            skill_icon = "shredder",
            rarity = "purple",
            main_epic = 1,

            str = {30, 50},
            alt_talent = "modifier_snapfire_shredder_7",
            attack = {2, 3},
            duration = 8,
            max = 12,
        },
        ["modifier_snapfire_shredder_5"] = 
        {
            skill_number = 3,
            mini_icon = "shredder_5",
            skill_icon = "shredder",
            rarity = "purple",

            heal = 2,
            health = 40,
            bonus = 2,
            status = 15,
        },
        ["modifier_snapfire_shredder_6"] = 
        {
            skill_number = 3,
            mini_icon = "shredder_6",
            skill_icon = "shredder",
            rarity = "purple",
            has_video = 1,

            is_purgable_self = 1,
            knock_duration = 0.2,
            silence = 2.5,
            range = 150,
            dist_max = 800,
            cd = 6,
            knock_min = 50,
            timer = 4,
            knock_max = 400,
        },
        ["modifier_snapfire_shredder_7"] = 
        {
            skill_number = 3,
            mini_icon = "shredder",
            skill_icon = "shredder",
            rarity = "orange",
            has_video = 1,

            decay = 42,
            spell_max = 50,
            skill_name = "snapfire_lil_shredder_custom",
            max = 100,
            effect_duration = 6,
            stun = 0.5,
            attack = 20,
            spell = 2.5,
            duration = 8,
        },
        ["modifier_snapfire_kisses_1"] = 
        {
            skill_number = 4,
            mini_icon = "kisses_1",
            skill_icon = "kisses",
            rarity = "blue",

            cd = {-4, -6, -8},
            duration = 2,
            damage_reduce = {-20, -30, -40},
        },
        ["modifier_snapfire_kisses_2"] = 
        {
            skill_number = 4,
            mini_icon = "kisses_2",
            skill_icon = "kisses",
            rarity = "blue",

            duration = 5,
            heal_reduce = {-20, -30, -40},
            max = {2, 3, 4},
        },
        ["modifier_snapfire_kisses_3"] = 
        {
            skill_number = 4,
            mini_icon = "kisses_3",
            skill_icon = "kisses",
            rarity = "blue",

            heal = {8, 12, 16},
            creeps = 3,
            bonus = 3,
            slow = {-10, -15, -20},
        },
        ["modifier_snapfire_kisses_4"] = 
        {
            skill_number = 4,
            mini_icon = "kisses_4",
            skill_icon = "kisses",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {30, 50},
            range = 800,
            radius = 300,
            duration = 8,
            attack = 4,
            fire_duration = {3, 5},
            max = 10,
        },
        ["modifier_snapfire_kisses_5"] = 
        {
            skill_number = 4,
            mini_icon = "kisses_5",
            skill_icon = "kisses",
            rarity = "purple",
            has_video = 1,

            range = 550,
            bkb = 2.5,
        },
        ["modifier_snapfire_kisses_6"] = 
        {
            skill_number = 4,
            mini_icon = "kisses_6",
            skill_icon = "kisses",
            rarity = "purple",
            has_video = 1,

            speed = 30,
            cdr = 12,
            root = 2,
            mod_name = "modifier_snapfire_mortimer_kisses_custom_cdr",
            is_perma = 1,
            is_purgable_self = 1,
            max = 20,
        },
        ["modifier_snapfire_kisses_7"] = 
        {
            skill_number = 4,
            mini_icon = "kisses",
            skill_icon = "kisses",
            rarity = "orange",
            has_video = 1,

            damage = 50,
            health = 50,
            skill_name = "snapfire_mortimer_kisses_custom",
            radius = 2000,
            trigger_ability = "snapfire_mortimer_kisses_custom_legendary",
            duration = 6,
        },
    },

    npc_dota_hero_sven = 
    {
        ["modifier_sven_hammer_1"] = 
        {
            skill_number = 1,
            mini_icon = "hammer_1",
            skill_icon = "hammer",
            rarity = "blue",

            damage = {80, 120, 160},
            str = {6, 9, 12},
            duration = 5,
        },
        ["modifier_sven_hammer_2"] = 
        {
            skill_number = 1,
            mini_icon = "hammer_2",
            skill_icon = "hammer",
            rarity = "blue",

            stun = {0.3, 0.45, 0.6},
            range = {100, 150, 200},
        },
        ["modifier_sven_hammer_3"] = 
        {
            skill_number = 1,
            mini_icon = "hammer_3",
            skill_icon = "hammer",
            rarity = "blue",

            duration = 6,
            heal_reduce = {-15, -20, -25},
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_sven_hammer_4"] = 
        {
            skill_number = 1,
            mini_icon = "hammer_4",
            skill_icon = "hammer",
            rarity = "purple",
            main_epic = 1,

            damage = 100,
            chance_inc = 1.5,
            chance = {30, 50},
            cd = -0.5,
            slow_duration = 0.5,
            slow = -100,
            duration = 5,
        },
        ["modifier_sven_hammer_5"] = 
        {
            skill_number = 1,
            mini_icon = "hammer_5",
            skill_icon = "hammer",
            rarity = "purple",
            has_video = 1,

            mana = 0,
            silence = 1.5,
            is_purgable_self = 1,
            slow = -100,
        },
        ["modifier_sven_hammer_6"] = 
        {
            skill_number = 1,
            mini_icon = "hammer_6",
            skill_icon = "hammer",
            rarity = "purple",

            speed = 25,
            creeps = 3,
            shield = 40,
            cast = -0.1,
            duration = 6,
            shield_max = 30,
            cdr = 12,
        },
        ["modifier_sven_hammer_7"] = 
        {
            skill_number = 1,
            mini_icon = "hammer",
            skill_icon = "hammer",
            rarity = "orange",

            cd = 8,
            duration = 2,
            skill_name = "sven_storm_bolt_custom",
            trigger_ability = "sven_storm_bolt_custom_legendary",
            damage_inc = 20,
            damage_init = 20,
        },
        ["modifier_sven_cleave_1"] = 
        {
            skill_number = 2,
            mini_icon = "cleave_1",
            skill_icon = "cleave",
            rarity = "blue",

            count_duration = 5,
            slow = {-20, -30, -40},
            duration = 4,
            attack = {-40, -60, -80},
            is_purgable_self = 1,
            max = 3,
        },
        ["modifier_sven_cleave_2"] = 
        {
            skill_number = 2,
            mini_icon = "cleave_2",
            skill_icon = "cleave",
            rarity = "blue",

            damage = {4, 6, 8},
            health = {30, 40, 50},
        },
        ["modifier_sven_cleave_3"] = 
        {
            skill_number = 2,
            mini_icon = "cleave_3",
            skill_icon = "cleave",
            rarity = "blue",

            damage = {40, 60, 80},
            str = {6, 9, 12},
            is_perma = 1,
            mod_name = "modifier_sven_great_cleave_custom_damage_perma",
            max = 80,
        },
        ["modifier_sven_cleave_4"] = 
        {
            skill_number = 2,
            mini_icon = "cleave_4",
            skill_icon = "cleave",
            rarity = "purple",
            main_epic = 1,

            speed = {100, 200},
            range = {60, 100},
            cd = 3,
            bonus = 3,
            attacks = 4,
        },
        ["modifier_sven_cleave_5"] = 
        {
            skill_number = 2,
            mini_icon = "cleave_5",
            skill_icon = "cleave",
            rarity = "purple",
            has_video = 1,

            is_breakable = 1,
            damage_reduce = -25,
            cd = 15,
            heal = 8,
            cd_inc = 1,
            duration = 2,
        },
        ["modifier_sven_cleave_6"] = 
        {
            skill_number = 2,
            mini_icon = "cleave_6",
            skill_icon = "cleave",
            rarity = "purple",

            is_through_bkb = 1,
            health = 40,
            move = 100,
            radius = 2000,
            cd = 10,
            duration = 3,
        },
        ["modifier_sven_cleave_7"] = 
        {
            skill_number = 2,
            mini_icon = "cleave",
            skill_icon = "cleave",
            rarity = "orange",
            has_video = 1,

            speed = 1600,
            distance = 1200,
            damage_min = 50,
            damage_max = 120,
            charges = 3,
            trigger_ability = "sven_great_cleave_custom_legendary",
            width = 150,
            is_through_bkb = 1,
            slow = -100,
            cd = 12,
            chance = 45,
            skill_name = "sven_great_cleave_custom",
            duration = 0.5,
        },
        ["modifier_sven_cry_1"] = 
        {
            skill_number = 3,
            mini_icon = "cry_1",
            skill_icon = "cry",
            rarity = "blue",

            regen = {50, 75, 100},
            armor = {4, 6, 8},
        },
        ["modifier_sven_cry_2"] = 
        {
            skill_number = 3,
            mini_icon = "cry_2",
            skill_icon = "cry",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = {1, 1.5, 2},
        },
        ["modifier_sven_cry_3"] = 
        {
            skill_number = 3,
            mini_icon = "cry_3",
            skill_icon = "cry",
            rarity = "blue",

            speed = {30, 45, 60},
            move = {8, 12, 16},
        },
        ["modifier_sven_cry_4"] = 
        {
            skill_number = 3,
            mini_icon = "cry_4",
            skill_icon = "cry",
            rarity = "purple",
            main_epic = 1,

            damage = {200, 350},
            armor = {-2, -3},
            interval = 0.5,
            radius = 600,
            duration = 5,
            max = 6,
        },
        ["modifier_sven_cry_5"] = 
        {
            skill_number = 3,
            mini_icon = "cry_5",
            skill_icon = "cry",
            rarity = "purple",
            has_video = 1,

            speed = 600,
            status = 10,
            bonus = 4,
            duration = 3,
        },
        ["modifier_sven_cry_6"] = 
        {
            skill_number = 3,
            mini_icon = "cry_6",
            skill_icon = "cry",
            rarity = "purple",

            magic = 3,
            slow = -30,
            max = 8,
            radius = 600,
            armor = 2,
            duration = 5,
        },
        ["modifier_sven_cry_7"] = 
        {
            skill_number = 3,
            mini_icon = "cry",
            skill_icon = "cry",
            rarity = "orange",

            damage = 30,
            is_through_bkb = 1,
            shield = 15,
            skill_name = "sven_warcry_custom",
            radius = 400,
            stun = 1.2,
            duration = 4,
        },
        ["modifier_sven_god_1"] = 
        {
            skill_number = 4,
            mini_icon = "god_1",
            skill_icon = "god",
            rarity = "blue",

            speed = {20, 30, 40},
            damage = {30, 45, 60},
            max = 10,
        },
        ["modifier_sven_god_2"] = 
        {
            skill_number = 4,
            mini_icon = "god_2",
            skill_icon = "god",
            rarity = "blue",

            heal = {8, 12, 16},
            bonus = 2,
            creeps = 3,
        },
        ["modifier_sven_god_3"] = 
        {
            skill_number = 4,
            mini_icon = "god_3",
            skill_icon = "god",
            rarity = "blue",

            cd = {-8, -12, -16},
            duration = {2, 3, 4},
        },
        ["modifier_sven_god_4"] = 
        {
            skill_number = 4,
            mini_icon = "god_4",
            skill_icon = "god",
            rarity = "purple",
            main_epic = 1,

            damage = {12, 20},
            str = {15, 25},
            duration = 6,
            bonus = 2,
            max = 10,
        },
        ["modifier_sven_god_5"] = 
        {
            skill_number = 4,
            mini_icon = "god_5",
            skill_icon = "god",
            rarity = "purple",

            root = 2,
            cast = -50,
            radius = 400,
            is_purgable_self = 1,
            cd = 12,
        },
        ["modifier_sven_god_6"] = 
        {
            skill_number = 4,
            mini_icon = "god_6",
            skill_icon = "god",
            rarity = "purple",
            has_video = 1,

            is_breakable = 1,
            health = 30,
            cd = 40,
            bkb = 2,
            duration = 4,
        },
        ["modifier_sven_god_7"] = 
        {
            skill_number = 4,
            mini_icon = "god",
            skill_icon = "god",
            rarity = "orange",
            has_video = 1,

            damage = 350,
            armor = 35,
            health = 200,
            skill_name = "sven_gods_strength_custom",
            trigger_ability = "sven_gods_strength_custom_legendary",
            range = 1000,
            slow = 1,
            is_through_bkb = 1,
            max = 10,
            duration = 3,
        },
    },

    npc_dota_hero_sniper = 
    {
        ["modifier_sniper_shrapnel_1"] = 
        {
            skill_number = 1,
            mini_icon = "shrapnel_1",
            skill_icon = "shrapnel",
            rarity = "blue",

            cd = {-6, -9, -12},
            slow = {-10, -15, -20},
        },
        ["modifier_sniper_shrapnel_2"] = 
        {
            skill_number = 1,
            mini_icon = "shrapnel_2",
            skill_icon = "shrapnel",
            rarity = "blue",

            damage = {8, 12, 16},
            duration = 5,
            speed = {8, 12, 16},
            max = 5,
        },
        ["modifier_sniper_shrapnel_3"] = 
        {
            skill_number = 1,
            mini_icon = "shrapnel_3",
            skill_icon = "shrapnel",
            rarity = "blue",

            heal = {1, 1.5, 2},
            slow = {-50, -75, -100},
        },
        ["modifier_sniper_shrapnel_4"] = 
        {
            skill_number = 1,
            mini_icon = "shrapnel_4",
            skill_icon = "shrapnel",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {6, 10},
            attacks = 1,
            stun = {0.6, 1},
            timer = 2,
            creeps = {150, 300},
        },
        ["modifier_sniper_shrapnel_5"] = 
        {
            skill_number = 1,
            mini_icon = "shrapnel_5",
            skill_icon = "shrapnel",
            rarity = "purple",
            has_video = 1,

            silence = 2,
            slow = 2,
            radius = 70,
            timer = 4,
            is_purgable_self = 1,
        },
        ["modifier_sniper_shrapnel_6"] = 
        {
            skill_number = 1,
            mini_icon = "shrapnel_6",
            skill_icon = "shrapnel",
            rarity = "purple",
            has_video = 1,

            trigger_ability = "sniper_shrapnel_custom",
            move = 20,
            charges = 1,
            delay = -50,
            duration = 1,
        },
        ["modifier_sniper_shrapnel_7"] = 
        {
            skill_number = 1,
            mini_icon = "shrapnel",
            skill_icon = "shrapnel",
            rarity = "orange",
            has_video = 1,

            skill_name = "sniper_shrapnel_custom",
            chance_creeps = 0.5,
            damage = -10,
            chance = 15,
        },
        ["modifier_sniper_headshot_1"] = 
        {
            skill_number = 2,
            mini_icon = "headshot_1",
            skill_icon = "headshot",
            rarity = "blue",

            damage = {30, 45, 60},
            radius = 250,
            cleave = {20, 30, 40},
        },
        ["modifier_sniper_headshot_2"] = 
        {
            skill_number = 2,
            mini_icon = "headshot_2",
            skill_icon = "headshot",
            rarity = "blue",

            distance = {10, 15, 20},
            chance = {8, 12, 16},
        },
        ["modifier_sniper_headshot_3"] = 
        {
            skill_number = 2,
            mini_icon = "headshot_3",
            skill_icon = "headshot",
            rarity = "blue",

            move = {20, 30, 40},
            radius = 400,
            bonus = 2,
            evasion = {10, 15, 20},
        },
        ["modifier_sniper_headshot_4"] = 
        {
            skill_number = 2,
            mini_icon = "headshot_4",
            skill_icon = "headshot",
            rarity = "purple",
            main_epic = 1,

            damage = {20, 35},
            distance = 700,
            range = {80, 150},
        },
        ["modifier_sniper_headshot_5"] = 
        {
            skill_number = 2,
            mini_icon = "headshot_5",
            skill_icon = "headshot",
            rarity = "purple",
            has_video = 1,

            is_breakable = 1,
            health = 2,
            cd = 25,
            shield = 25,
            thresh = 30,
            duration = 4,
        },
        ["modifier_sniper_headshot_6"] = 
        {
            skill_number = 2,
            mini_icon = "headshot_6",
            skill_icon = "headshot",
            rarity = "purple",

            is_through_bkb = 1,
            vision = 6,
            duration = 0.5,
        },
        ["modifier_sniper_headshot_7"] = 
        {
            skill_number = 2,
            mini_icon = "headshot",
            skill_icon = "headshot",
            rarity = "orange",
            has_video = 1,

            speed = 35,
            cd = 15,
            invis = 3,
            agi_duration = 10,
            skill_name = "sniper_headshot_custom",
            radius = 400,
            agi = 4,
            duration = 5,
        },
        ["modifier_sniper_aim_1"] = 
        {
            skill_number = 3,
            mini_icon = "aim_1",
            skill_icon = "aim",
            rarity = "blue",

            cd = {-3, -4, -5},
            duration = {0.6, 0.9, 1.2},
        },
        ["modifier_sniper_aim_2"] = 
        {
            skill_number = 3,
            mini_icon = "aim_2",
            skill_icon = "aim",
            rarity = "blue",

            heal = {20, 30, 40},
            creeps = 3,
            status = {8, 12, 16},
        },
        ["modifier_sniper_aim_3"] = 
        {
            skill_number = 3,
            mini_icon = "aim_3",
            skill_icon = "aim",
            rarity = "blue",

            move = {10, 15, 20},
            duration = 6,
            damage = {30, 45, 60},
            max = 8,
        },
        ["modifier_sniper_aim_4"] = 
        {
            skill_number = 3,
            mini_icon = "aim_4",
            skill_icon = "aim",
            rarity = "purple",
            main_epic = 1,

            armor = {-2, -3},
            slow = {-3, -5},
            is_through_bkb = 1,
            max = 8,
            duration = 8,
        },
        ["modifier_sniper_aim_5"] = 
        {
            skill_number = 3,
            mini_icon = "aim_5",
            skill_icon = "aim",
            rarity = "purple",
            has_video = 1,

            mana = 0,
            damage_reduce = -35,
            duration = 1.5,
        },
        ["modifier_sniper_aim_6"] = 
        {
            skill_number = 3,
            mini_icon = "aim_6",
            skill_icon = "aim",
            rarity = "purple",
            has_video = 1,

            leash = 2.5,
        },
        ["modifier_sniper_aim_7"] = 
        {
            skill_number = 3,
            mini_icon = "aim",
            skill_icon = "aim",
            rarity = "orange",
            has_video = 1,

            damage = 30,
            distance = 1300,
            is_through_bkb = 1,
            skill_name = "sniper_take_aim_custom",
            random_factor = 8,
            turn = 200,
            width = 100,
            interval = 0.1,
            auto = 1,
            speed = 2500,
            duration = 2.5,
        },
        ["modifier_sniper_assassinate_1"] = 
        {
            skill_number = 4,
            mini_icon = "assassinate_1",
            skill_icon = "assassinate",
            rarity = "blue",

            cast = {-0.3, -0.4, -0.5},
            range = {150, 250, 350},
        },
        ["modifier_sniper_assassinate_2"] = 
        {
            skill_number = 4,
            mini_icon = "assassinate_2",
            skill_icon = "assassinate",
            rarity = "blue",

            damage = {80, 120, 160},
            heal_reduce = {-20, -30, -40},
            duration = 5,
        },
        ["modifier_sniper_assassinate_3"] = 
        {
            skill_number = 4,
            mini_icon = "assassinate_3",
            skill_icon = "assassinate",
            rarity = "blue",

            cd = {-2, -3, -4},
            mana = {15, 25, 35},
        },
        ["modifier_sniper_assassinate_4"] = 
        {
            skill_number = 4,
            mini_icon = "assassinate_4",
            skill_icon = "assassinate",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {25, 40},
            heal = 130,
            heal_creeps = 3,
            duration = 3,
        },
        ["modifier_sniper_assassinate_5"] = 
        {
            skill_number = 4,
            mini_icon = "assassinate_5",
            skill_icon = "assassinate",
            rarity = "purple",
            has_video = 1,

            is_through_bkb = 1,
            trigger_ability = "sniper_assassinate_custom",
            duration = 3,
            distance_max = 800,
            range_self = 325,
            damage_reduce = -50,
            range_knock = 400,
            knock_duration = 0.25,
        },
        ["modifier_sniper_assassinate_6"] = 
        {
            skill_number = 4,
            mini_icon = "assassinate_6",
            skill_icon = "assassinate",
            rarity = "purple",
            has_video = 1,

            slow = -50,
            duration = 3,
        },
        ["modifier_sniper_assassinate_7"] = 
        {
            skill_number = 4,
            mini_icon = "assassinate",
            skill_icon = "assassinate",
            rarity = "orange",
            has_video = 1,

            damage = 50,
            max = 5,
            cd = 5,
            skill_name = "sniper_assassinate_custom",
            attack = 1,
            cd_inc = 2,
            trigger_ability = "sniper_assassinate_custom_legendary",
        },
    },

    npc_dota_hero_muerta = 
    {
        ["modifier_muerta_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            fear = {0.3, 0.45, 0.6},
            slow = {-10, -15, -20},
        },
        ["modifier_muerta_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            move = {20, 30, 40},
            magic = {6, 9, 12},
            bonus = 3,
        },
        ["modifier_muerta_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            cdr = {6, 9, 12},
            mana = {12, 18, 24},
        },

        ["modifier_muerta_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -25,
            duration = 3,
            fear = 1,
            talent_cd = 12,
        },
        ["modifier_muerta_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            range = 150,
            base = 200,
            shield = 15,
            duration = 8,
            alt_talent = "modifier_muerta_calling_7",
            is_root_disabled = 1,
        },
        ["modifier_muerta_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            status = 15,
            bonus = 3,
            heal = 25,
        },

        ["modifier_muerta_dead_1"] = 
        {
            skill_number = 1,
            mini_icon = "dead_1",
            skill_icon = "dead",
            rarity = "blue",

            spell = {6, 9, 12},
            damage = {60, 90, 120},
        },
        ["modifier_muerta_dead_2"] = 
        {
            skill_number = 1,
            mini_icon = "dead_2",
            skill_icon = "dead",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            range = {100, 150, 200},
        },
        ["modifier_muerta_dead_3"] = 
        {
            skill_number = 1,
            mini_icon = "dead_3",
            skill_icon = "dead",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {20, 35},
            duration = 6,
            health = 50,
            bonus = 2,
            heal_reduce = {-12, -20},
        },
        ["modifier_muerta_dead_4"] = 
        {
            skill_number = 1,
            mini_icon = "dead_4",
            skill_icon = "dead",
            rarity = "purple",

            width = 40,
            speed = 40,
            move = 25,
            duration = 3,
            cd_items = -3,
            cd_items_legendary = -1.5,
            alt_talent = "modifier_muerta_dead_7",
        },
        ["modifier_muerta_dead_7"] = 
        {
            skill_number = 1,
            mini_icon = "dead",
            skill_icon = "dead",
            rarity = "orange",
            complexity = 2,
            has_video = 1,

            cd = -50,
            damage_reduce = -50,
            fear_reduce = -50,
            max = 2,
            duration = 15,
            damage = 300,
            heal = 50,
            fear = 1.2,
            mana = -50,
            width = 3,
            cd_proc = 1,
            skill_name = "muerta_dead_shot_custom",
        },

        ["modifier_muerta_calling_1"] = 
        {
            skill_number = 2,
            mini_icon = "calling_1",
            skill_icon = "calling",
            rarity = "blue",

            damage = {1.6, 2.4, 3.2},
            heal = {12, 18, 24},
        },
        ["modifier_muerta_calling_2"] = 
        {
            skill_number = 2,
            mini_icon = "calling_2",
            skill_icon = "calling",
            rarity = "blue",

            cd = {-2, -3, -4},
            magic = {-8, -12, -16},
        },
        ["modifier_muerta_calling_3"] = 
        {
            skill_number = 2,
            mini_icon = "calling_3",
            skill_icon = "calling",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            interval = 2,
            damage = 80,
            count = {3, 5},
            health_reduce = {-2, -3.5},
            max = 6,
            duration = 12,
            radius = 250,
            slow = -100,
            range = 400,
            slow_duration = 0.5,
        },
        ["modifier_muerta_calling_4"] = 
        {
            skill_number = 2,
            mini_icon = "calling_4",
            skill_icon = "calling",
            rarity = "purple",
            has_video = 1,

            duration = 2,
            speed = 20,
            root = 1.5,
            cd = 5,
            is_purgable_self = 1,
        },
        ["modifier_muerta_calling_7"] = 
        {
            skill_number = 2,
            mini_icon = "calling",
            skill_icon = "calling",
            rarity = "orange",
            complexity = 1,
            has_video = 1,

            small_radius = 450,
            big_radius = 850,
            count = 5,
            max = 9,
            fear_stack = 8,
            fear = 1.2,
            damage = 120,
            base_damage = -35,
            radius = 250,
            range = 1200,
            cd = 3,
            skill_name = "muerta_the_calling_custom",
        },

        ["modifier_muerta_gun_1"] = 
        {
            skill_number = 3,
            mini_icon = "gun_1",
            skill_icon = "gun",
            rarity = "blue",

            speed = {10, 15, 20},
            max = 4,
            duration = 6,
        },
        ["modifier_muerta_gun_2"] = 
        {
            skill_number = 3,
            mini_icon = "gun_2",
            skill_icon = "gun",
            rarity = "blue",

            heal = {12, 18, 24},
            chance = {6, 9, 12},
        },
        ["modifier_muerta_gun_3"] = 
        {
            skill_number = 3,
            mini_icon = "gun_3",
            skill_icon = "gun",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            stats = {6, 10},
            max = 4,
            duration = 6,
            crit = {125, 140},
        },
        ["modifier_muerta_gun_4"] = 
        {
            skill_number = 3,
            mini_icon = "gun_4",
            skill_icon = "gun",
            rarity = "purple",
            has_video = 1,

            armor = 12,
            effect_duration = 3,
            health = 40,
            damage_reduce = -30,
            heal = 3,
            duration = 8,
            incoming = 250,
            is_breakable = 1,
            talent_cd = 20,
        },
        ["modifier_muerta_gun_7"] = 
        {
            skill_number = 3,
            mini_icon = "gun",
            skill_icon = "gun",
            rarity = "orange",
            complexity = 1,
            has_video = 1,

            damage_reduce = -60,
            damage = 10,
            duration = 25,
            duration_creeps = 10,
            range = 400,
            speed = 1500,
            stack = 2,
            effect_duration = 5,
            cd_inc = -0.5,
            talent_cd = 10,
            is_root_disabled = 1,
            skill_name = "muerta_gunslinger_custom",
            trigger_ability = "muerta_gunslinger_custom",
        },

        ["modifier_muerta_veil_1"] = 
        {
            skill_number = 4,
            mini_icon = "veil_1",
            skill_icon = "veil",
            rarity = "blue",

            damage = {60, 90, 120},
            duration = 4,
            interval = 1,
            talent_cd = 3,
            cd_inc = 3,
            radius = 250,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_muerta_veil_2"] = 
        {
            skill_number = 4,
            mini_icon = "veil_2",
            skill_icon = "veil",
            rarity = "blue",

            range = {80, 120, 160},
            bonus = 2,
            slow = {-10, -15, -20},
            duration = 3,
        },
        ["modifier_muerta_veil_3"] = 
        {
            skill_number = 4,
            mini_icon = "veil_3",
            skill_icon = "veil",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            duration = {0.6, 1},
            duration_legendary = {0.8, 1.5},
            bva = {-0.25, -0.4},
            effect_duration = 2,
            alt_talent = "modifier_muerta_veil_7",
        },
        ["modifier_muerta_veil_4"] = 
        {
            skill_number = 4,
            mini_icon = "veil_4",
            skill_icon = "veil",
            rarity = "purple",
            has_video = 1,

            cd_inc = -1.5,
            cd_inc_legendary = -5,
            alt_talent = "modifier_muerta_veil_7",
        },
        ["modifier_muerta_veil_7"] = 
        {
            skill_number = 4,
            mini_icon = "veil",
            skill_icon = "veil",
            rarity = "orange",
            complexity = 2,
            has_video = 1,

            duration = 0.2,
            duration_reduce = -0.5,
            max = 15,
            max_magic = 8,
            radius = 900,
            magic = -25,
            fear = 1.5,
            pull_duration = 0.3,
            pull_distance = 250,
            stack_duration = 10,
            shot_stack = 3,
            skill_name = "muerta_pierce_the_veil_custom",
        },
    },

    npc_dota_hero_pangolier = 
    {
        ["modifier_pangolier_buckle_1"] = 
        {
            skill_number = 1,
            mini_icon = "buckle_1",
            skill_icon = "buckle",
            rarity = "blue",

            cd = {-2, -3, -4},
            mana = {-30, -60, -90},
        },
        ["modifier_pangolier_buckle_2"] = 
        {
            skill_number = 1,
            mini_icon = "buckle_2",
            skill_icon = "buckle",
            rarity = "blue",

            speed = {20, 30, 40},
            bonus = 2,
            range = {100, 150, 200},
            duration = 4,
        },
        ["modifier_pangolier_buckle_3"] = 
        {
            skill_number = 1,
            mini_icon = "buckle_3",
            skill_icon = "buckle",
            rarity = "blue",

            damage = {20, 30, 40},
            crit = {140, 200, 260},
        },
        ["modifier_pangolier_buckle_4"] = 
        {
            skill_number = 1,
            mini_icon = "buckle_4",
            skill_icon = "buckle",
            rarity = "purple",
            main_epic = 1,

            damage = {30, 50},
            interval = 0.5,
            heal = 70,
            creeps = 3,
            duration = 8,
            max = 10,
        },
        ["modifier_pangolier_buckle_5"] = 
        {
            skill_number = 1,
            mini_icon = "buckle_5",
            skill_icon = "buckle",
            rarity = "purple",

            blink_duration = 0.25,
            distance = 300,
            range = 500,
            slow = -50,
            leash = 2,
            trigger_ability = "pangolier_swashbuckle_custom",
            is_purgable_self = 1,
            duration = 5,
        },
        ["modifier_pangolier_buckle_6"] = 
        {
            skill_number = 1,
            mini_icon = "buckle_6",
            skill_icon = "buckle",
            rarity = "purple",

            duration = 2,
            damage_reduce = -40,
        },
        ["modifier_pangolier_buckle_7"] = 
        {
            skill_number = 1,
            mini_icon = "buckle",
            skill_icon = "buckle",
            rarity = "orange",
            has_video = 1,

            is_through_bkb = 1,
            distance = 270,
            stun = 1,
            hit = 1,
            skill_name = "pangolier_swashbuckle_custom",
            radius = 1000,
            timer = 3,
            max = 5,
        },
        ["modifier_pangolier_shield_1"] = 
        {
            skill_number = 2,
            mini_icon = "shield_1",
            skill_icon = "shield",
            rarity = "blue",

            heal = {10, 15, 20},
            creeps = 3,
            shield = {8, 12, 16},
        },
        ["modifier_pangolier_shield_2"] = 
        {
            skill_number = 2,
            mini_icon = "shield_2",
            skill_icon = "shield",
            rarity = "blue",

            duration = {2, 3, 4},
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_pangolier_shield_3"] = 
        {
            skill_number = 2,
            mini_icon = "shield_3",
            skill_icon = "shield",
            rarity = "blue",

            damage = {100, 150, 200},
            str = {8, 12, 16},
            trigger_ability = "pangolier_shield_crash_custom",
        },
        ["modifier_pangolier_shield_4"] = 
        {
            skill_number = 2,
            mini_icon = "shield_4",
            skill_icon = "shield",
            rarity = "purple",
            main_epic = 1,

            damage = {15, 25},
            timer = 4,
            cd_inc = {-2, -3},
            duration = 6,
        },
        ["modifier_pangolier_shield_5"] = 
        {
            skill_number = 2,
            mini_icon = "shield_5",
            skill_icon = "shield",
            rarity = "purple",

            distance = 300,
        },
        ["modifier_pangolier_shield_6"] = 
        {
            skill_number = 2,
            mini_icon = "shield_6",
            skill_icon = "shield",
            rarity = "purple",

            heal = 2,
            duration = 2,
            damage_reduce = -50,
        },
        ["modifier_pangolier_shield_7"] = 
        {
            skill_number = 2,
            mini_icon = "shield",
            skill_icon = "shield",
            rarity = "orange",

            skill_name = "pangolier_shield_crash_custom",
            radius = 650,
            cd = 1.5,
            damage = 60,
        },
        ["modifier_pangolier_lucky_1"] = 
        {
            skill_number = 3,
            mini_icon = "lucky_1",
            skill_icon = "lucky",
            rarity = "blue",

            speed = {-30, -45, -60},
            chance = {6, 9, 12},
        },
        ["modifier_pangolier_lucky_2"] = 
        {
            skill_number = 3,
            mini_icon = "lucky_2",
            skill_icon = "lucky",
            rarity = "blue",

            damage = {60, 90, 120},
            radius = 300,
            range = {40, 60, 80},
            chance = 25,
        },
        ["modifier_pangolier_lucky_3"] = 
        {
            skill_number = 3,
            mini_icon = "lucky_3",
            skill_icon = "lucky",
            rarity = "blue",

            heal = {15, 20, 25},
            creeps = 3,
            slow = {-30, -45, -60},
        },
        ["modifier_pangolier_lucky_4"] = 
        {
            skill_number = 3,
            mini_icon = "lucky_4",
            skill_icon = "lucky",
            rarity = "purple",
            main_epic = 1,

            speed = {30, 50},
            max = 4,
            status = {25, 40},
            duration = 10,
        },
        ["modifier_pangolier_lucky_5"] = 
        {
            skill_number = 3,
            mini_icon = "lucky_5",
            skill_icon = "lucky",
            rarity = "purple",

            damage = -25,
            silence = 3,
            is_purgable_self = 1,
            cd = 15,
        },
        ["modifier_pangolier_lucky_6"] = 
        {
            skill_number = 3,
            mini_icon = "lucky_6",
            skill_icon = "lucky",
            rarity = "purple",
            has_video = 1,

            range = 200,
            cd = 8,
            dash_speed = 2000,
            stun = 0.5,
            cast = 600,
        },
        ["modifier_pangolier_lucky_7"] = 
        {
            skill_number = 3,
            mini_icon = "lucky",
            skill_icon = "lucky",
            rarity = "orange",
            has_video = 1,

            is_through_bkb = 1,
            effect_duration = 7,
            skill_name = "pangolier_lucky_shot_custom",
            trigger_ability = "pangolier_lucky_shot_custom",
            stun = 2,
            duration = 15,
        },
        ["modifier_pangolier_rolling_1"] = 
        {
            skill_number = 4,
            mini_icon = "rolling_1",
            skill_icon = "rolling",
            rarity = "blue",

            damage = {8, 12, 16},
            attack_damage = {50, 75, 100},
        },
        ["modifier_pangolier_rolling_2"] = 
        {
            skill_number = 4,
            mini_icon = "rolling_2",
            skill_icon = "rolling",
            rarity = "blue",

            heal = {2, 3, 4},
            armor = {10, 15, 20},
            duration = 2,
        },
        ["modifier_pangolier_rolling_3"] = 
        {
            skill_number = 4,
            mini_icon = "rolling_3",
            skill_icon = "rolling",
            rarity = "blue",

            cd = {-4, -6, -8},
            duration = {0.8, 1.2, 1.6},
        },
        ["modifier_pangolier_rolling_4"] = 
        {
            skill_number = 4,
            mini_icon = "rolling_4",
            skill_icon = "rolling",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {30, 50},
            duration = 12,
            heal_reduce = {-30, -50},
            max = 4,
        },
        ["modifier_pangolier_rolling_5"] = 
        {
            skill_number = 4,
            mini_icon = "rolling_5",
            skill_icon = "rolling",
            rarity = "purple",
            has_video = 1,

            cast = -0.5,
            speed = 50,
            duration = 2,
        },
        ["modifier_pangolier_rolling_6"] = 
        {
            skill_number = 4,
            mini_icon = "rolling_6",
            skill_icon = "rolling",
            rarity = "purple",

            mod_name = "modifier_pangolier_gyroshell_custom_perma",
            is_perma = 1,
            cast = -0.4,
            cdr = 0.5,
            cd_items = -1.5,
            max = 30,
        },
        ["modifier_pangolier_rolling_7"] = 
        {
            skill_number = 4,
            mini_icon = "rolling",
            skill_icon = "rolling",
            rarity = "orange",
            has_video = 1,

            skill_name = "pangolier_gyroshell_custom",
            duration_inc = 2,
            damage = 300,
            trigger_ability = "pangolier_gyroshell_custom",
        },
    },

    npc_dota_hero_arc_warden = 
    {
        ["modifier_arc_warden_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            cdr = {6, 9, 12},
            cast_range = {120, 180, 240},
            allow_illusion = 1,
        },

        ["modifier_arc_warden_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            status = {6, 9, 12},
            magic = {6, 9, 12},
            bonus = 2,
            duration = 3,
            allow_illusion = 1,
        },

        ["modifier_arc_warden_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            mana = {16, 24, 32},
            str = {2, 3, 4},
            duration = 8,
            max = 6,
            allow_illusion = 1,
        },

        ["modifier_arc_warden_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            cast = -0.2,
            attack_slow = -150,
            silence = 1.6,
            allow_illusion = 1,
            is_purgable_self = 1,
        },

        ["modifier_arc_warden_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            cast = -0.2,
            range = 200,
            stun = 1,
            talent_cd = 10,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            heal_inc = 20,
            damage_reduce = -15,
            bonus = 2,
            health = 50,
            radius = 900,
            allow_illusion = 1,
        },


        ["modifier_arc_warden_flux_1"] = 
        {
            skill_number = 1,
            mini_icon = "flux_1",
            skill_icon = "flux",
            rarity = "blue",

            spell = {4, 6, 8},
            damage = {1.2, 1.8, 2.4},
            allow_illusion = 1,
        },
        ["modifier_arc_warden_flux_2"] = 
        {
            skill_number = 1,
            mini_icon = "flux_2",
            skill_icon = "flux",
            rarity = "blue",

            cd = {-2, -3, -4},
            slow = {-8, -12, -16},
            allow_illusion = 1,
        },
        ["modifier_arc_warden_flux_3"] = 
        {
            skill_number = 1,
            mini_icon = "flux_3",
            skill_icon = "flux",
            rarity = "purple",
            main_epic = 1,

            resist = {-30, -50},
            heal_reduce = {-30, -50},
            max = 12,
            stack = 2,
            duration = 8,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_flux_4"] = 
        {
            skill_number = 1,
            mini_icon = "flux_4",
            skill_icon = "flux",
            rarity = "purple",
            has_video = 1,

            heal = 3,
            shield = 2,
            shield_max = 20,
            duration = 15,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_flux_7"] = 
        {
            skill_number = 1,
            mini_icon = "flux",
            skill_icon = "flux",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            interval = 2,
            allow_illusion = 1,
            radius = 430,
            skill_name = "arc_warden_flux_custom",
        },
        ["modifier_arc_warden_field_1"] = 
        {
            skill_number = 2,
            mini_icon = "field_1",
            skill_icon = "field",
            rarity = "blue",

            speed = {30, 45, 60},
            cleave = {20, 30, 40},
            radius = 300,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_field_2"] = 
        {
            skill_number = 2,
            mini_icon = "field_2",
            skill_icon = "field",
            rarity = "blue",

            heal = {10, 15, 20},
            bonus = 2,
            duration = 3,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_field_3"] = 
        {
            skill_number = 2,
            mini_icon = "field_3",
            skill_icon = "field",
            rarity = "purple",
            main_epic = 1,

            damage = {12, 20},
            agi = {3, 5},
            max = 20,
            duration = 8,
            duration_creeps = 3, 
            allow_illusion = 1,
        },
        ["modifier_arc_warden_field_4"] = 
        {
            skill_number = 2,
            mini_icon = "field_4",
            skill_icon = "field",
            rarity = "purple",
            has_video = 1,

            cd = -4,
            slow = -35,
            slow_duration = 3,
            range = 350,
            alt_talent = "modifier_arc_warden_field_7",
            allow_illusion = 1,
            is_root_disabled = 1,
        },
        ["modifier_arc_warden_field_7"] = 
        {
            skill_number = 2,
            mini_icon = "field",
            skill_icon = "field",
            rarity = "orange",
            has_video = 1,
            complexity = 3,

            talent_cd = 12,
            damage = 50,
            incoming = 200,
            invun = 0.5,
            radius = 250,
            duration = 8,
            cd_inc = -0.5,
            is_root_disabled = 1,
            allow_illusion = 1,
            skill_name = "arc_warden_magnetic_field_custom",
        },
        ["modifier_arc_warden_spark_1"] = 
        {
            skill_number = 3,
            mini_icon = "spark_1",
            skill_icon = "spark",
            rarity = "blue",

            delay = {-20, -30, -40},
            damage = {50, 75, 100},
            allow_illusion = 1,
        },
        ["modifier_arc_warden_spark_2"] = 
        {
            skill_number = 3,
            mini_icon = "spark_2",
            skill_icon = "spark",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            cast = {-0.1, -0.15, -0.2},
            allow_illusion = 1,
        },
        ["modifier_arc_warden_spark_3"] = 
        {
            skill_number = 3,
            mini_icon = "spark_3",
            skill_icon = "spark",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            heal = {20, 35},
            chance = {25, 40},
            radius = 1200,
            damage = 60,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_spark_4"] = 
        {
            skill_number = 3,
            mini_icon = "spark_4",
            skill_icon = "spark",
            rarity = "purple",
            has_video = 1,

            move = 25,
            duration = 3,
            slow_resist = 50,
            cd_items = -0.8,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_spark_7"] = 
        {
            skill_number = 3,
            mini_icon = "spark",
            skill_icon = "spark",
            rarity = "orange",
            has_video = 1,
            complexity = 3,

            cast = 1.5,
            damage = 125,
            talent_cd = 4,
            max = 10,
            stun = 1.5,
            duration = 5,
            radius = 1200,
            allow_illusion = 1,
            trigger_ability = "arc_warden_spark_wraith_custom_legendary",
            skill_name = "arc_warden_spark_wraith_custom",
        },
        ["modifier_arc_warden_double_1"] = 
        {
            skill_number = 4,
            mini_icon = "double_1",
            skill_icon = "double",
            rarity = "blue",

            crit = {140, 170, 200},
            chance = 40,
            heal = 75,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_double_2"] = 
        {
            skill_number = 4,
            mini_icon = "double_2",
            skill_icon = "double",
            rarity = "blue",

            range = {80, 120, 160},
            move = {30, 45, 60},
            bonus = 2,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_double_3"] = 
        {
            skill_number = 4,
            mini_icon = "double_3",
            skill_icon = "double",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {75, 150},
            range = 50,
            cd = 2,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_double_4"] = 
        {
            skill_number = 4,
            mini_icon = "double_4",
            skill_icon = "double",
            rarity = "purple",
            has_video = 1,

            duration = 3,
            talent_cd = 8,
            damage = 100,
            status = 50,
            is_breakable = 1,
            allow_illusion = 1,
        },
        ["modifier_arc_warden_double_7"] = 
        {
            skill_number = 4,
            mini_icon = "double",
            skill_icon = "double",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            cast = 6,
            duration = 10,
            damage = 160,
            health = 125,
            range = 2000,
            damage_reduce = -40,
            talent_cd = 12,
            trigger_ability = "arc_warden_tempest_double_custom_legendary",
            skill_name = "arc_warden_tempest_double_custom",
        },
    },

    npc_dota_hero_invoker = 
    {
        ["modifier_invoker_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            mana = {10, 15, 20},
            shield = {30, 45, 60},
            max = 10,
            duration = 10,
        },
        ["modifier_invoker_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            armor = {6, 9, 12},
            duration = {0.3, 0.45, 0.6},
        },
        ["modifier_invoker_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            move = {30, 45, 60},
            status = {8, 12, 16},
        },
        ["modifier_invoker_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -25,
            regen = 4,
            duration = 2,
        },
        ["modifier_invoker_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            cd = -4,
            silence = 2.5,
            slow = -50,
            is_purgable_self = 1,
        },
        ["modifier_invoker_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            health = 30,
            count = 11,
            bkb = 2,
            talent_cd = 20,
            is_breakable = 1,
        },

        ["modifier_invoker_quas_1"] = 
        {
            skill_number = 1,
            mini_icon = "quas_1",
            skill_icon = "coldsnap",
            rarity = "blue",

            duration = {1, 1.5, 2},
            damage = {1, 1.5, 2},
            creeps = {40, 60, 80},
        },
        ["modifier_invoker_quas_2"] = 
        {
            skill_number = 1,
            mini_icon = "quas_2",
            skill_icon = "quas",
            rarity = "blue",

            cd = {-2, -3, -4},
        },
        ["modifier_invoker_quas_3"] = 
        {
            skill_number = 1,
            mini_icon = "quas_3",
            skill_icon = "coldsnap",
            rarity = "purple",
            main_epic = 1,

            max = 10,
            magic = {-2.5, -4},
            heal_reduce = {-2.5, -4},
            heal = {25, 40},
            wall = 2,
            duration = 12,
        },
        ["modifier_invoker_quas_4"] = 
        {
            skill_number = 1,
            mini_icon = "quas_4",
            skill_icon = "icewall",
            rarity = "purple",
            has_video = 1,

            range = 600,
            root = 1.6,
            wall = 2,
            is_purgable_self = 1,
        },
        ["modifier_invoker_quas_7"] = 
        {
            skill_number = 1,
            mini_icon = "quas",
            skill_icon = "quas",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            damage = 85,
            stun = 3,
            max = 7,
            duration = 7,
            radius = 1200,
            skill_name = "invoker_quas_custom",
        },
        ["modifier_invoker_wex_1"] = 
        {
            skill_number = 2,
            mini_icon = "wex_1",
            skill_icon = "alacrity",
            rarity = "blue",

            stats = {4, 6, 8},
            bonus = {2, 3, 4},
            max = 8,
            duration = 6,
        },
        ["modifier_invoker_wex_2"] = 
        {
            skill_number = 2,
            mini_icon = "wex_2",
            skill_icon = "wex",
            rarity = "blue",

            slow = {-20, -30, -40},
            range = {100, 150, 200},
            duration = 3,
            is_purgable_self = 1,
        },
        ["modifier_invoker_wex_3"] = 
        {
            skill_number = 2,
            mini_icon = "wex_3",
            skill_icon = "alacrity",
            rarity = "purple",
            main_epic = 1,

            duration = {3, 5},
            bonus = {12, 20},
            effect_duration = 12,
        },
        ["modifier_invoker_wex_4"] = 
        {
            skill_number = 2,
            mini_icon = "wex_4",
            skill_icon = "emp",
            rarity = "purple",
            has_video = 1,

            delay = -1,
            invun = 0.5,
            min_distance = 150,
            max_distance = 500,
            knock_duration = 0.3,
            is_root_disabled = 1,
            speed = 50,
            legendary_stack = 5,
            alt_talent = "modifier_invoker_exort_7",
            trigger_ability = "invoker_emp_custom",
        },
        ["modifier_invoker_wex_7"] = 
        {
            skill_number = 2,
            mini_icon = "wex",
            skill_icon = "wex",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            attacks = 1,
            range = 1600,
            cd = -10,
            duration = 15,
            speed = 750,
            damage = 125,
            max = 4,
            mana = -70,
            skill_name = "invoker_wex_custom",
        },
        ["modifier_invoker_exort_1"] = 
        {
            skill_number = 3,
            mini_icon = "exort_1",
            skill_icon = "exort",
            rarity = "blue",

            speed = {40, 60, 80},
            duration = 4,
            forge = 50,
        },
        ["modifier_invoker_exort_2"] = 
        {
            skill_number = 3,
            mini_icon = "exort_2",
            skill_icon = "forge",
            rarity = "blue",

            health = {30, 45, 60},
            heal = {1, 1.5, 2},
            forge = 2,
        },
        ["modifier_invoker_exort_3"] = 
        {
            skill_number = 3,
            mini_icon = "exort_3",
            skill_icon = "forge",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            count = {3, 2},
            duration = 10,
            chance = {25, 40},
            damage = 50,
        },
        ["modifier_invoker_exort_4"] = 
        {
            skill_number = 3,
            mini_icon = "exort_4",
            skill_icon = "meteor",
            rarity = "purple",
            has_video = 1,

            stun = 1,
            talent_cd = 3,
            chance = 20,
            attacks = 5,
            chance_forge = 8,
            duration = 10,
            is_through_bkb = 1,
            is_basher = 1,
        },
        ["modifier_invoker_exort_7"] = 
        {
            skill_number = 3,
            mini_icon = "exort",
            skill_icon = "exort",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            radius = 340,
            meteor = 3,
            stack = -0.25,
            damage = 5,
            max = 15,
            sun_delay = 0.7,
            reset = 10,
            sun = 6,
            duration = 4,
            root = 2,
            mana = -50,
            talent_cd = 8,
            skill_name = "invoker_exort_custom",
            trigger_ability = "invoker_exort_custom",
        },
        ["modifier_invoker_invoke_1"] = 
        {
            skill_number = 4,
            mini_icon = "invoke_1",
            skill_icon = "invoke",
            rarity = "blue",

            spell = {6, 9, 12},
            damage = {6, 9, 12},
        },
        ["modifier_invoker_invoke_2"] = 
        {
            skill_number = 4,
            mini_icon = "invoke_2",
            skill_icon = "invoke",
            rarity = "blue",

            cdr = {6, 9, 12},
            radius = {12, 18, 24},
        },
        ["modifier_invoker_invoke_3"] = 
        {
            skill_number = 4,
            mini_icon = "invoke_3",
            skill_icon = "invoke",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            base = {30, 50},
            damage = {70, 130},
            interval = 1,
            duration = 7,
            heal = 75,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_invoker_invoke_4"] = 
        {
            skill_number = 4,
            mini_icon = "invoke_4",
            skill_icon = "invoke",
            rarity = "purple",

            cd_items = -0.6,
            level = 1,
        },
        ["modifier_invoker_invoke_7"] = 
        {
            skill_number = 4,
            mini_icon = "invoke",
            skill_icon = "invoke",
            rarity = "orange",
            has_video = 1,
            complexity = 3,

            duration = 10,
            talent_cd = 20,
            vision_radius = 1500,
            skill_name = "invoker_invoke_custom",
            trigger_ability = "invoker_invoke_custom",
        },
    },

    npc_dota_hero_razor = 
    {
        ["modifier_razor_plasma_1"] = 
        {
            skill_number = 1,
            mini_icon = "plasma_1",
            skill_icon = "plasma",
            rarity = "blue",

            damage = {30, 45, 60},
            radius = {80, 120, 160},
        },
        ["modifier_razor_plasma_2"] = 
        {
            skill_number = 1,
            mini_icon = "plasma_2",
            skill_icon = "plasma",
            rarity = "blue",

            speed = {-40, -60, -80},
            duration = {1, 1.5, 2},
        },
        ["modifier_razor_plasma_3"] = 
        {
            skill_number = 1,
            mini_icon = "plasma_3",
            skill_icon = "plasma",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            mana = {-30, -45, -60},
        },
        ["modifier_razor_plasma_4"] = 
        {
            skill_number = 1,
            mini_icon = "plasma_4",
            skill_icon = "plasma",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {10, 15},
            interval = 0.5,
            stop = {2, 3},
            duration = 15,
        },
        ["modifier_razor_plasma_5"] = 
        {
            skill_number = 1,
            mini_icon = "plasma_5",
            skill_icon = "plasma",
            rarity = "purple",
            has_video = 1,

            speed = 30,
            interval = 0.05,
            shield_duration = 6,
            shield = 10,
            duration = 1.2,
        },
        ["modifier_razor_plasma_6"] = 
        {
            skill_number = 1,
            mini_icon = "plasma_6",
            skill_icon = "plasma",
            rarity = "purple",
            has_video = 1,

            silence = 2,
            is_purgable_self = 1,
            slow = 15,
        },
        ["modifier_razor_plasma_7"] = 
        {
            skill_number = 1,
            mini_icon = "plasma",
            skill_icon = "plasma",
            rarity = "orange",
            has_video = 1,

            damage = 150,
            knock_distance = 600,
            incoming = 250,
            skill_name = "razor_plasma_field_custom",
            radius = 500,
            knock_duration = 0.3,
            knock_distance_min = 100,
            delay = 2.5,
            cd = 7,
            trigger_ability = "razor_plasma_field_custom_clone",
        },
        ["modifier_razor_link_1"] = 
        {
            skill_number = 2,
            mini_icon = "link_1",
            skill_icon = "link",
            rarity = "blue",

            duration = 8,
            armor = {6, 9, 12},
        },
        ["modifier_razor_link_2"] = 
        {
            skill_number = 2,
            mini_icon = "link_2",
            skill_icon = "link",
            rarity = "blue",

            range = {100, 150, 200},
            cd = {-2, -3, -4},
        },
        ["modifier_razor_link_3"] = 
        {
            skill_number = 2,
            mini_icon = "link_3",
            skill_icon = "link",
            rarity = "blue",

            is_through_bkb = 1,
            duration = 8,
            spell = {15, 20, 25},
            slow = {20, 30, 40},
        },
        ["modifier_razor_link_4"] = 
        {
            skill_number = 2,
            mini_icon = "link_4",
            skill_icon = "link",
            rarity = "purple",
            main_epic = 1,

            damage = {8, 12},
            mod_name = "modifier_razor_static_link_custom_perma",
            is_perma = 1,
            heal = {30, 50},
            duration = 4,
            creeps = 3,
            max = 10,
        },
        ["modifier_razor_link_5"] = 
        {
            skill_number = 2,
            mini_icon = "link_5",
            skill_icon = "link",
            rarity = "purple",
            has_video = 1,

            count = 1,
            status = 20,
        },
        ["modifier_razor_link_6"] = 
        {
            skill_number = 2,
            mini_icon = "link_6",
            skill_icon = "link",
            rarity = "purple",
            has_video = 1,

            trigger_ability = "razor_static_link_custom",
            knock_distance = 80,
            knock_duration = 0.3,
            is_through_bkb = 1,
            stun = 1.5,
            link_duration = -1,
            knock_distance_max = 800,
            duration = 8,
        },
        ["modifier_razor_link_7"] = 
        {
            skill_number = 2,
            mini_icon = "link",
            skill_icon = "link",
            rarity = "orange",
            has_video = 1,

            lose_duration = 2,
            swap = 6,
            is_through_bkb = 1,
            skill_name = "razor_static_link_custom",
            attack = 10,
            radius = 250,
            duration = 2.5,
        },
        ["modifier_razor_current_1"] = 
        {
            skill_number = 3,
            mini_icon = "current_1",
            skill_icon = "current",
            rarity = "blue",

            damage = {40, 60, 80},
            spell = 1,
            spell_attack = {40, 30, 20},
        },
        ["modifier_razor_current_2"] = 
        {
            skill_number = 3,
            mini_icon = "current_2",
            skill_icon = "current",
            rarity = "blue",

            heal = {4, 6, 8},
            duration = 4,
            chance = {6, 9, 12},
        },
        ["modifier_razor_current_3"] = 
        {
            skill_number = 3,
            mini_icon = "current_3",
            skill_icon = "current",
            rarity = "blue",

            agi = {1, 1.5, 2},
            str = {1, 1.5, 2},
            max = 12,
            spell = 3,
            duration = 8,
        },
        ["modifier_razor_current_4"] = 
        {
            skill_number = 3,
            mini_icon = "current_4",
            skill_icon = "current",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {2, 4},
            distance = 700,
            duration = 8,
            max = 8,
        },
        ["modifier_razor_current_5"] = 
        {
            skill_number = 3,
            mini_icon = "current_5",
            skill_icon = "current",
            rarity = "purple",

            speed_text = 50,
            speed_max = 600,
            speed_bonus = 0.4,
            cd = -0.7,
            distance = 700,
        },
        ["modifier_razor_current_6"] = 
        {
            skill_number = 3,
            mini_icon = "current_6",
            skill_icon = "current",
            rarity = "purple",
            has_video = 1,

            stun = 1,
            cd_inc = -1.2,
            cd = 15,
        },
        ["modifier_razor_current_7"] = 
        {
            skill_number = 3,
            mini_icon = "current",
            skill_icon = "current",
            rarity = "orange",
            has_video = 1,

            skill_name = "razor_unstable_current_custom",
            charge_speed = 3500,
            max_distance = 1400,
            stun_knock = 150,
            max_damage = 250,
            trigger_ability = "razor_unstable_current_custom",
            slow = -70,
            stun = 0.3,
            cd = 12,
            cd_inc = -1,
            duration = 1.6,
        },
        ["modifier_razor_eye_1"] = 
        {
            skill_number = 4,
            mini_icon = "eye_1",
            skill_icon = "eye",
            rarity = "blue",

            damage = {30, 45, 60},
            max = 20,
            attack_damage = {2, 3, 4},
        },
        ["modifier_razor_eye_2"] = 
        {
            skill_number = 4,
            mini_icon = "eye_2",
            skill_icon = "eye",
            rarity = "blue",

            move = {20, 30, 40},
            bonus = 2,
            status = {6, 9, 12},
        },
        ["modifier_razor_eye_3"] = 
        {
            skill_number = 4,
            mini_icon = "eye_3",
            skill_icon = "eye",
            rarity = "blue",

            cd = {-4, -6, -8},
            duration = {2, 3, 4},
        },
        ["modifier_razor_eye_4"] = 
        {
            skill_number = 4,
            mini_icon = "eye_4",
            skill_icon = "eye",
            rarity = "purple",
            main_epic = 1,

            speed = {2, 3},
            damage = {60, 100},
            max = 4,
        },
        ["modifier_razor_eye_5"] = 
        {
            skill_number = 4,
            mini_icon = "eye_5",
            skill_icon = "eye",
            rarity = "purple",
            has_video = 1,

            range = 150,
            root = 1.5,
            cd = 8,
            radius = 150,
            is_purgable_self = 1,
            is_through_bkb = 1,
        },
        ["modifier_razor_eye_6"] = 
        {
            skill_number = 4,
            mini_icon = "eye_6",
            skill_icon = "eye",
            rarity = "purple",
            has_video = 1,

            damage = -15,
            duration = 3,
        },
        ["modifier_razor_eye_7"] = 
        {
            skill_number = 4,
            mini_icon = "eye",
            skill_icon = "eye",
            rarity = "orange",
            has_video = 1,

            skill_name = "razor_eye_of_the_storm_custom",
            bonus = 2,
            trigger_ability = "razor_eye_of_the_storm_custom",
            creeps = 3,
            cd = 4,
            slow = -70,
            heal = 60,
            duration_min = 0,
            duration_max = 4,
            max = 10,
        },
    },

    npc_dota_hero_sand_king = 
    {
        ["modifier_sand_king_burrow_1"] = 
        {
            skill_number = 1,
            mini_icon = "burrow_1",
            skill_icon = "burrow",
            rarity = "blue",

            stun = {0.2, 0.3, 0.4},
            range = {100, 150, 200},
        },
        ["modifier_sand_king_burrow_2"] = 
        {
            skill_number = 1,
            mini_icon = "burrow_2",
            skill_icon = "burrow",
            rarity = "blue",

            damage = {50, 75, 100},
            damage_auto = {8, 12, 16},
        },
        ["modifier_sand_king_burrow_3"] = 
        {
            skill_number = 1,
            mini_icon = "burrow_3",
            skill_icon = "burrow",
            rarity = "blue",

            speed = {20, 30, 40},
            is_purgable = 1,
            duration = 5,
            bonus = 2,
            evasion = {10, 15, 20},
        },
        ["modifier_sand_king_burrow_4"] = 
        {
            skill_number = 1,
            mini_icon = "burrow_4",
            skill_icon = "burrow",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            stun = {0.5, 0.8},
            radius = 300,
            attacks = {2, 3},
            delay = 3,
        },
        ["modifier_sand_king_burrow_5"] = 
        {
            skill_number = 1,
            mini_icon = "burrow_5",
            skill_icon = "burrow",
            rarity = "purple",

            leash = 2,
            duration = 0.5,
            speed = 50,
            slow = -50,
        },
        ["modifier_sand_king_burrow_6"] = 
        {
            skill_number = 1,
            mini_icon = "burrow_6",
            skill_icon = "burrow",
            rarity = "purple",
            has_video = 1,

            is_root_disabled = 1,
            range = 500,
            slow = -100,
            cd = -2,
            duration = 5,
            slow_duration = 1,
        },
        ["modifier_sand_king_burrow_7"] = 
        {
            skill_number = 1,
            mini_icon = "burrow",
            skill_icon = "burrow",
            rarity = "orange",
            has_video = 1,

            speed = 300,
            shield = 25,
            skill_name = "sandking_burrowstrike_custom",
            radius = 400,
            trigger_ability = "sandking_burrowstrike_custom_legendary",
            cd = 13,
            restore_timer = 9,
            attack_cd = 1.5,
            attack_stun = 0.2,
            damage = 75,
        },
        ["modifier_sand_king_sand_1"] = 
        {
            skill_number = 2,
            mini_icon = "sand_1",
            skill_icon = "sand",
            rarity = "blue",

            damage = {1.5, 2, 2.5},
            slow = {-15, -20, -25},
        },
        ["modifier_sand_king_sand_2"] = 
        {
            skill_number = 2,
            mini_icon = "sand_2",
            skill_icon = "sand",
            rarity = "blue",

            cd = {-2, -3, -4},
            speed = {20, 30, 40},
        },
        ["modifier_sand_king_sand_3"] = 
        {
            skill_number = 2,
            mini_icon = "sand_3",
            skill_icon = "sand",
            rarity = "blue",

            heal = {0.6, 0.9, 1.2},
            str = {10, 15, 20},
        },
        ["modifier_sand_king_sand_4"] = 
        {
            skill_number = 2,
            mini_icon = "sand_4",
            skill_icon = "sand",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            silence = 1,
            slow = -50,
            damage = 150,
            is_purgable_self = 1,
            max = {1, 2},
        },
        ["modifier_sand_king_sand_5"] = 
        {
            skill_number = 2,
            mini_icon = "sand_5",
            skill_icon = "sand",
            rarity = "purple",

            speed = 20,
            cd = 6,
            duration = 3,
            status = 20,
        },
        ["modifier_sand_king_sand_6"] = 
        {
            skill_number = 2,
            mini_icon = "sand_6",
            skill_icon = "sand",
            rarity = "purple",
            has_video = 1,

            radius = 80,
            cd = 12,
            more_radius = 100,
            is_purgable_self = 1,
            duration = 1.5,
        },
        ["modifier_sand_king_sand_7"] = 
        {
            skill_number = 2,
            mini_icon = "sand",
            skill_icon = "sand",
            rarity = "orange",

            damage = 5,
            health = 35,
            skill_name = "sandking_sand_storm_custom",
            count = 1,
            life_duration = 8,
            death_damage = 100,
            bva = 1.2,
            radius = 400,
            slow_duration = 6,
        },
        ["modifier_sand_king_finale_1"] = 
        {
            skill_number = 3,
            mini_icon = "finale_1",
            skill_icon = "stinger",
            rarity = "blue",

            damage = {40, 60, 80},
            stinger_damage = {40, 60, 80},
        },
        ["modifier_sand_king_finale_2"] = 
        {
            skill_number = 3,
            mini_icon = "finale_2",
            skill_icon = "stinger",
            rarity = "blue",
            has_video = 1,

            damage_reduce = {-10, -15, -20},
            slow = {-10, -15, -20},
        },
        ["modifier_sand_king_finale_3"] = 
        {
            skill_number = 3,
            mini_icon = "finale_3",
            skill_icon = "stinger",
            rarity = "blue",

            range = {200, 300, 400},
            cd = {-1, -1.5, -2},
        },
        ["modifier_sand_king_finale_4"] = 
        {
            skill_number = 3,
            mini_icon = "finale_4",
            skill_icon = "stinger",
            rarity = "purple",
            main_epic = 1,

            speed = {60, 100},
            is_perma = 1,
            mod_name = "modifier_sandking_scorpion_strike_custom_perma",
            duration = 5,
            spell = {12, 20},
            max = 30,
        },
        ["modifier_sand_king_finale_5"] = 
        {
            skill_number = 3,
            mini_icon = "finale_5",
            skill_icon = "stinger",
            rarity = "purple",
            has_video = 1,

            heal_creeps = 3,
            health = 40,
            heal = 4,
            update_mod = "modifier_sandking_caustic_finale_custom",
            bonus = 2,
            damage_reduce = -15,
        },
        ["modifier_sand_king_finale_6"] = 
        {
            skill_number = 3,
            mini_icon = "finale_6",
            skill_icon = "stinger",
            rarity = "purple",

            cast = -0.2,
            cd = 10,
            stun = 1.2,
            mana = 0,
        },
        ["modifier_sand_king_finale_7"] = 
        {
            skill_number = 3,
            mini_icon = "stinger",
            skill_icon = "stinger",
            rarity = "orange",

            pull_distance = 80,
            chance_inc = 20,
            range = 100,
            chance = 20,
            skill_name = "sandking_scorpion_strike_custom",
            delay = 0.3,
            duration = 15,
            max = 4,
        },
        ["modifier_sand_king_epicenter_1"] = 
        {
            skill_number = 4,
            mini_icon = "epicenter_1",
            skill_icon = "epicenter",
            rarity = "blue",

            damage = 5,
            duration = 8,
            heal_reduce = {-15, -20, -25},
            max = {6, 9, 12},
        },
        ["modifier_sand_king_epicenter_2"] = 
        {
            skill_number = 4,
            mini_icon = "epicenter_2",
            skill_icon = "epicenter",
            rarity = "blue",

            cd = {-8, -12, -16},
            mana = {10, 15, 20},
        },
        ["modifier_sand_king_epicenter_3"] = 
        {
            skill_number = 4,
            mini_icon = "epicenter_3",
            skill_icon = "epicenter",
            rarity = "blue",

            heal = {20, 30, 40},
            duration = 6,
            heal_creeps = 3,
            shield = {8, 12, 16},
        },
        ["modifier_sand_king_epicenter_4"] = 
        {
            skill_number = 4,
            mini_icon = "epicenter_4",
            skill_icon = "epicenter",
            rarity = "purple",
            main_epic = 1,

            duration = 8,
            resist = {-1.5, -2.5},
            stack = 20,
            max = {3, 5},
        },
        ["modifier_sand_king_epicenter_5"] = 
        {
            skill_number = 4,
            mini_icon = "epicenter_5",
            skill_icon = "epicenter",
            rarity = "purple",
            has_video = 1,

            cd = 10,
            count = 1,
            damage = -30,
        },
        ["modifier_sand_king_epicenter_6"] = 
        {
            skill_number = 4,
            mini_icon = "epicenter_6",
            skill_icon = "epicenter",
            rarity = "purple",

            cd = -0.3,
            duration = 8,
            speed = 5,
            max = 6,
        },
        ["modifier_sand_king_epicenter_7"] = 
        {
            skill_number = 4,
            mini_icon = "epicenter",
            skill_icon = "epicenter",
            rarity = "orange",
            has_video = 1,

            distance = 150,
            cd = 14,
            skill_name = "sandking_epicenter_custom",
            trigger_ability = "sandking_epicenter_custom_legendary",
            cd_inc = 4,
            duration = 4,
        },
    },

    npc_dota_hero_furion = 
    {
        ["modifier_furion_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            range = {100, 150, 200},
            bonus = 2,
            armor = {4, 6, 8},
            duration = 4,
        },
        ["modifier_furion_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            shield = {6, 9, 12},
            mana = {20, 30, 40},
        },
        ["modifier_furion_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            move = {30, 45, 60},
            gold = {6, 9, 12},
            chance = 50,
        },
        ["modifier_furion_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            leash = 2.5,
            move = 25,
        },
        ["modifier_furion_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            cast = -25,
            bkb = 2.5,
            health = 30,
            talent_cd = 20,
            is_breakable = 1,
        },
        ["modifier_furion_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            cd = -4,
            speed = 200,
            fear = 1.5,
        },

        ["modifier_furion_sprout_1"] = 
        {
            skill_number = 1,
            mini_icon = "sprout_1",
            skill_icon = "sprout",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            damage = {3, 4.5, 6},
            base = {20, 30, 40},
        },
        ["modifier_furion_sprout_2"] = 
        {
            skill_number = 1,
            mini_icon = "sprout_2",
            skill_icon = "sprout",
            rarity = "blue",

            heal = {10, 15, 20},
            bonus = 2,
            regen = {1, 1.5, 2},
        },
        ["modifier_furion_sprout_3"] = 
        {
            skill_number = 1,
            mini_icon = "sprout_3",
            skill_icon = "sprout",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            radius = 900,
            magic = {-8, -15},
            bonus = 2,
            delay = 1.5,
            aoe_radius = 300,
            damage = {60, 100},
            duration = 5,
        },
        ["modifier_furion_sprout_4"] = 
        {
            skill_number = 1,
            mini_icon = "sprout_4",
            skill_icon = "sprout",
            rarity = "purple",

            radius = 700,
            str = 2.5,
            max = 8,
            duration = 0.5,
            damage_reduce = -30,
        },
        ["modifier_furion_sprout_7"] = 
        {
            skill_number = 1,
            mini_icon = "sprout",
            skill_icon = "sprout",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            damage = 20,
            health = 60,
            base = 100,
            damage_inc = 20,
            is_through_bkb = 1,
            talent_cd = 10,
            duration = 14,
            armor = 8,
            magic = 30,
            knock_duration = 0.2,
            radius = 700,
            trees = 8,
            heal = 70,
            skill_name = "furion_sprout_custom",
            trigger_ability = "furion_sprout_custom_legendary",
        },

        ["modifier_furion_teleport_1"] = 
        {
            skill_number = 2,
            mini_icon = "teleport_1",
            skill_icon = "teleport",
            rarity = "blue",

            speed = {20, 30, 40},
            chance = 25,
            chance_ent = 10,
            base = {30, 45, 60},
            damage = {16, 24, 32},
            radius = 200,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_furion_teleport_2"] = 
        {
            skill_number = 2,
            mini_icon = "teleport_2",
            skill_icon = "teleport",
            rarity = "blue",

            range = {160, 240, 320},
            slow = {-20, -30, -40},
            duration = 3,
        },
        ["modifier_furion_teleport_3"] = 
        {
            skill_number = 2,
            mini_icon = "teleport_3",
            skill_icon = "teleport",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            attacks = {2, 3},
            delay = 0.15,
            stats = {8, 15},
            damage = 50,
            duration = 5,
            chance = 25,
            alt_talent = "modifier_furion_teleport_7",
        },
        ["modifier_furion_teleport_4"] = 
        {
            skill_number = 2,
            mini_icon = "teleport_4",
            skill_icon = "teleport",
            rarity = "purple",
            has_video = 1,

            cd_inc = 3,
            status = 30,
            shield = 75,
        },
        ["modifier_furion_teleport_7"] = 
        {
            skill_number = 2,
            mini_icon = "teleport",
            skill_icon = "teleport",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            bva = -0.3,
            duration = 4,
            duration_min  = 0.5,
            range = 1000,
            damage = 160,
            effect_duration = 3,
            interval = 1,
            radius = 900,
            damage_type = DAMAGE_TYPE_MAGICAL,
            skill_name = "furion_teleportation_custom",
            is_root_disabled = 1,
        },

        ["modifier_furion_call_1"] = 
        {
            skill_number = 3,
            mini_icon = "nature_call_1",
            skill_icon = "nature_call",
            rarity = "blue",

            damage = {16, 24, 32},
            damage_ents = {16, 24, 32},
        },
        ["modifier_furion_call_2"] = 
        {
            skill_number = 3,
            mini_icon = "nature_call_2",
            skill_icon = "nature_call",
            rarity = "blue",

            heal = {12, 18, 24},
            health = {1000, 1500, 2000},
            mod_name = "modifier_furion_force_of_nature_custom_health",
            is_perma = 1,
            max = 500,
        },
        ["modifier_furion_call_3"] = 
        {
            skill_number = 3,
            mini_icon = "nature_call_3",
            skill_icon = "nature_call",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            speed = {8, 15},
            max = 5,
            armor = {-12, -20},
            attacks = 30,
            stack = 2,
            duration = 10,
        },
        ["modifier_furion_call_4"] = 
        {
            skill_number = 3,
            mini_icon = "nature_call_4",
            skill_icon = "nature_call",
            rarity = "purple",
            has_video = 1,

            status = 75,
            slow_resist = 75,
            chance = 25,
            stun = 0.7,
            duration = 12,
            talent_cd = 3,
            is_basher = 1,
            is_through_bkb = 1,
        },
        ["modifier_furion_call_7"] = 
        {
            skill_number = 3,
            mini_icon = "nature_call",
            skill_icon = "nature_call",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            speed = 250,
            damage_reduce = -80,
            damage_reduce_hero = -30,
            duration = 12,
            duration_k = 1.5,
            move = 50,
            max = 12,
            cast = 0.3,
            cd = 2,
            stack_duration = 16,
            skill_name = "furion_force_of_nature_custom",
        },

        ["modifier_furion_nature_1"] = 
        {
            skill_number = 4,
            mini_icon = "nature_wrath_1",
            skill_icon = "nature_wrath",
            rarity = "blue",

            health = {1, 1.5, 2},
            damage = {80, 120, 160},
        },
        ["modifier_furion_nature_2"] = 
        {
            skill_number = 4,
            mini_icon = "nature_wrath_2",
            skill_icon = "nature_wrath",
            rarity = "blue",

            cd = {-2, -3, -4},
            heal_reduce = {-12, -18, -24},
            duration = 5,
        },
        ["modifier_furion_nature_3"] = 
        {
            skill_number = 4,
            mini_icon = "nature_wrath_3",
            skill_icon = "nature_wrath",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            spell = {8, 15},
            chance = 40,
            talent_cd = 2,
            base = {18, 30},
            damage = {18, 30},
            max = 8,
            duration = 5,
            interval = 1,
            radius = 600,
            range = 800,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_furion_nature_4"] = 
        {
            skill_number = 4,
            mini_icon = "nature_wrath_4",
            skill_icon = "nature_wrath",
            rarity = "purple",

            cdr = 12,
            speed = 25,
            cast = -25,
            cd_items = -0.5,
            cd_items_legendary = -0.2,
            alt_talent = "modifier_furion_nature_7"
        },
        ["modifier_furion_nature_7"] = 
        {
            skill_number = 4,
            mini_icon = "nature_wrath",
            skill_icon = "nature_wrath",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            cd_inc = -70,
            duration = 20,
            root = -40,
            tree_min = 1,
            tree_max = 2,
            chance = 50,
            radius = 600,
            mana = -50,
            skill_name = "furion_blooming_flare_custom",
        },
    },

    npc_dota_hero_abaddon = 
    {

        ["modifier_abaddon_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            move = {30, 45, 60},
            slow = {-10, -15, -20},
        },
        ["modifier_abaddon_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            armor = {6, 9, 12},
            magic = {6, 9, 12},
            bonus = 2,
        },
        ["modifier_abaddon_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            cdr = {6, 9, 12},
            heal = {60, 90, 120},
            duration = 6,
        },


        ["modifier_abaddon_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            range = 200,
            leash = 3,
            talent_cd = 10,
            max_dist = 550,
            is_purgable_self = 1,
            trigger_ability = "abaddon_death_coil_custom",
        },
        ["modifier_abaddon_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            range = 600,
            duration = 0.5,
            is_root_disabled = 1,
        },
        ["modifier_abaddon_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            status = 15,
            duration = 1,
        },


        ["modifier_abaddon_mist_1"] = 
        {
            skill_number = 1,
            mini_icon = "mist_1",
            skill_icon = "mist",
            rarity = "blue",

            spell = {6, 9, 12},
            damage = {50, 75, 100},
        },
        ["modifier_abaddon_mist_2"] = 
        {
            skill_number = 1,
            mini_icon = "mist_2",
            skill_icon = "mist",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            heal = {10, 15, 20},
        },
        ["modifier_abaddon_mist_3"] = 
        {
            skill_number = 1,
            mini_icon = "mist_3",
            skill_icon = "mist",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            chance = {25, 40},
            multi = 1.5,
            slow = -80,
            delay = 0.3,
            duration = 1,
        },
        ["modifier_abaddon_mist_4"] = 
        {
            skill_number = 1,
            mini_icon = "mist_4",
            skill_icon = "mist",
            rarity = "purple",

            cd_items = -1.2,
            move = 20,
            duration = 3,
        },
        ["modifier_abaddon_mist_7"] = 
        {
            skill_number = 1,
            mini_icon = "mist",
            skill_icon = "mist",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            damage = 120,
            radius = 150,
            range = 400,
            talent_cd = 15,
            heal = 100,
            timer = 0.3,
            duration = 30,
            skill_name = "abaddon_death_coil_custom",
            trigger_ability = "abaddon_death_coil_custom_legendary",
        },
        ["modifier_abaddon_aphotic_1"] = 
        {
            skill_number = 2,
            mini_icon = "aphotic_1",
            skill_icon = "aphotic",
            rarity = "blue",

            base = {40, 60, 80},
            shield = {5, 7.5, 10},
        },
        ["modifier_abaddon_aphotic_2"] = 
        {
            skill_number = 2,
            mini_icon = "aphotic_2",
            skill_icon = "aphotic",
            rarity = "blue",

            cd = {-2, -3, -4},
            mana = {16, 24, 32},
        },
        ["modifier_abaddon_aphotic_3"] = 
        {
            skill_number = 2,
            mini_icon = "aphotic_3",
            skill_icon = "aphotic",
            rarity = "purple",
            main_epic = 1,

            duration = 5,
            base = {20, 35},
            damage = {2.5, 4},
            interval = 1,
            stack = 3,
            heal = 50,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_abaddon_aphotic_4"] = 
        {
            skill_number = 2,
            mini_icon = "aphotic_4",
            skill_icon = "aphotic",
            rarity = "purple",
            has_video = 1,

            max = 10,
            str = 4,
            stun_stack = 5,
            stun = 1.5,
            duration = 8,
            damage = 120,
        },
        ["modifier_abaddon_aphotic_7"] = 
        {
            skill_number = 2,
            mini_icon = "aphotic",
            skill_icon = "aphotic",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            damage = 5,
            max = 12,
            magic = -4,
            effect_duration = 8,
            radius = 550,
            interval = 0.5,
            duration = 2,
            slow = -100,
            heal = 50,
            skill_name = "abaddon_aphotic_shield_custom",
        },
        ["modifier_abaddon_curse_1"] = 
        {
            skill_number = 3,
            mini_icon = "curse_1",
            skill_icon = "curse",
            rarity = "blue",

            damage = {6, 9, 12},
            speed = {6, 9, 12},
            max = 5,
        },
        ["modifier_abaddon_curse_2"] = 
        {
            skill_number = 3,
            mini_icon = "curse_2",
            skill_icon = "curse",
            rarity = "blue",

            cleave = {20, 30, 40},
            range = {50, 75, 100},
        },
        ["modifier_abaddon_curse_3"] = 
        {
            skill_number = 3,
            mini_icon = "curse_3",
            skill_icon = "curse",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            stats = {12, 20},    
            damage = {50, 80},
            attacks = 4,
            talent_cd = 6,
        },
        ["modifier_abaddon_curse_4"] = 
        {
            skill_number = 3,
            mini_icon = "curse_4",
            skill_icon = "curse",
            rarity = "purple",
            has_video = 1,

            silence = 3,
            attacks = 4,
            talent_cd = 6,
            duration = 5,
            is_purgable_self = 1,
        },
        ["modifier_abaddon_curse_7"] = 
        {
            skill_number = 3,
            mini_icon = "curse",
            skill_icon = "curse",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            bonus = 4,
            duration_creeps = 7,
            stats = 1,
            talent_cd = 15,
            stack_duration = 25,
            duration = 8,
            is_through_bkb = 1,
            skill_name = "abaddon_frostmourne_custom",
        },
        ["modifier_abaddon_borrowed_1"] = 
        {
            skill_number = 4,
            mini_icon = "borrowed_1",
            skill_icon = "borrowed",
            rarity = "blue",

            damage = {20, 30, 40},
            armor = {-6, -9, -12},
            radius = 600,
            max = 8,
            duration = 5,
        },
        ["modifier_abaddon_borrowed_2"] = 
        {
            skill_number = 4,
            mini_icon = "borrowed_2",
            skill_icon = "borrowed",
            rarity = "blue",

            heal = {12, 18, 24},
            heal_inc = {16, 24, 32},
        },
        ["modifier_abaddon_borrowed_3"] = 
        {
            skill_number = 4,
            mini_icon = "borrowed_3",
            skill_icon = "borrowed",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {120, 200},
            max = 5,
            max_inc = 3,
            duration = 6,
            heal = {75, 100},
            cleave = 100,
        },
        ["modifier_abaddon_borrowed_4"] = 
        {
            skill_number = 4,
            mini_icon = "borrowed_4",
            skill_icon = "borrowed",
            rarity = "purple",
            has_video = 1,

            cd_inc = -5,
            taunt = 1.5,
            range = 100,
            is_through_bkb = 1,
        },
        ["modifier_abaddon_borrowed_7"] = 
        {
            skill_number = 4,
            mini_icon = "borrowed",
            skill_icon = "borrowed",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            heal = 200,
            damage = 60,
            duration_inc = 25,
            radius = 400,
            knock_duration = 0.2,
            talent_cd = 6,
            knock_dist = 150,
            duration = 4,
            is_blockable = 1,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            skill_name = "abaddon_borrowed_time_custom",
            trigger_ability = "abaddon_borrowed_time_custom_legendary",
        },
    },

    npc_dota_hero_drow_ranger = 
    {
        ["modifier_drow_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            duration = 3,
            heal_reduce = {-8, -12, -16},
            damage_reduce = {-8, -12, -16},
            health = 50,
            bonus = 2,
        },
        ["modifier_drow_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            evasion = {8, 12, 16},
            move = {20, 30, 40},
            bonus = 3,
            duration = 4,
            allow_illusion = 1,
        },
        ["modifier_drow_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            status = {6, 9, 12},
            magic = {6, 9, 12},
            bonus = 2,
        },

        ["modifier_drow_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            shield = 15,
            talent_cd = 4,
            radius = 400,
            health = 40,
            stun = 1,
            duration = 4,
            is_breakable = 1,
        },
        ["modifier_drow_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            duration = 0.4,
            silence = 1,
        },
        ["modifier_drow_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            duration = 1,
            root = 1.5,
            talent_cd = 8,
            is_purgable_self = 1,
        },

        ["modifier_drow_frost_1"] = 
        {
            skill_number = 1,
            mini_icon = "frost_1",
            skill_icon = "frost",
            rarity = "blue",

            max = 12,
            duration = 8,
            armor_inc = {4, 6, 8},
            armor = {-6, -9, -12},
        },
        ["modifier_drow_frost_2"] = 
        {
            skill_number = 1,
            mini_icon = "frost_2",
            skill_icon = "frost",
            rarity = "blue",

            mana = {-6, -9, -12},
            slow = {-10, -15, -20},
            allow_illusion = 1,
        },
        ["modifier_drow_frost_3"] = 
        {
            skill_number = 1,
            mini_icon = "frost_3",
            skill_icon = "frost",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            heal = {20, 35},
            damage = {25, 40},
            cd = 6,
            radius = 1000,
            targets = 3,
        },
        ["modifier_drow_frost_4"] = 
        {
            skill_number = 1,
            mini_icon = "frost_4",
            skill_icon = "frost",
            rarity = "purple",
            has_video = 1,

            move = 8,
            max = 5,
            duration = 3,
            vision = 10,
            slow_resist = 50,
        },
        ["modifier_drow_frost_7"] = 
        {
            skill_number = 1,
            mini_icon = "frost",
            skill_icon = "frost",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            speed = 2500,
            duration = 8,
            width = 120,
            range = 2000,
            damage = 75,
            talent_cd = 3,
            cast = 0.25,
            stun = 0.25,
            max = 6,
            skill_name = "drow_ranger_frost_arrows_custom",
        },
        ["modifier_drow_gust_1"] = 
        {
            skill_number = 2,
            mini_icon = "gust_1",
            skill_icon = "gust",
            rarity = "blue",

            damage = {100, 150, 200},
            spell = {8, 12, 16},
        },
        ["modifier_drow_gust_2"] = 
        {
            skill_number = 2,
            mini_icon = "gust_2",
            skill_icon = "gust",
            rarity = "blue",

            cd = {-2, -3, -4},
            cast = {-0.1, -0.15, -0.2},
        },
        ["modifier_drow_gust_3"] = 
        {
            skill_number = 2,
            mini_icon = "gust_3",
            skill_icon = "gust",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {8, 14},
            damage_creeps = {80, 150},
            aoe = 250,
            heal = 75,
            max = 3,
            duration = 8,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_drow_gust_4"] = 
        {
            skill_number = 2,
            mini_icon = "gust_4",
            skill_icon = "gust",
            rarity = "purple",
            has_video = 1,

            duration = 0.25,
            range = 350,
            talent_cd = 15,
            cd_inc = 1,
            mana = 35,
            is_root_disabled = 1,
            trigger_ability = "drow_ranger_wave_of_silence_custom_blink",
        },
        ["modifier_drow_gust_7"] = 
        {
            skill_number = 2,
            mini_icon = "gust",
            skill_icon = "gust",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            spell = 30,
            duration = 6,
            cd_inc = -40,
            mana = -50,
            damage_type = DAMAGE_TYPE_MAGICAL,
            skill_name = "drow_ranger_wave_of_silence_custom",
        },

        ["modifier_drow_multishot_1"] = 
        {
            skill_number = 3,
            mini_icon = "multishot_1",
            skill_icon = "multishot",
            rarity = "blue",

            damage = {30, 45, 60},
            heal = {12, 18, 24},
        },
        ["modifier_drow_multishot_2"] = 
        {
            skill_number = 3,
            mini_icon = "multishot_2",
            skill_icon = "multishot",
            rarity = "blue",

            cd = {-2, -3, -4},
            range = {100, 150, 200}
        },
        ["modifier_drow_multishot_3"] = 
        {
            skill_number = 3,
            mini_icon = "multishot_3",
            skill_icon = "multishot",
            rarity = "purple",
            main_epic = 1,

            max = {1, 2},
            damage = {35, 60},
            damage_type = DAMAGE_TYPE_PURE,
        },
        ["modifier_drow_multishot_4"] = 
        {
            skill_number = 3,
            mini_icon = "multishot_4",
            skill_icon = "multishot",
            rarity = "purple",

            cdr = 12,
            damage_reduce = -35,
            cd_items = -0.8,
        },
        ["modifier_drow_multishot_7"] = 
        {
            skill_number = 3,
            mini_icon = "multishot",
            skill_icon = "multishot",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            cd = -30,
            max = 3,
            damage = 80,
            fear = 1.2,
            duration = 12,
            skill_name = "drow_ranger_multishot_custom",
        },

        ["modifier_drow_marksman_1"] = 
        {
            skill_number = 4,
            mini_icon = "marksman_1",
            skill_icon = "marksman",
            rarity = "blue",

            speed = {20, 30, 40},
            damage = {30, 45, 60},
            max = 30,
            is_perma = 1,
            mod_name = "modifier_drow_ranger_marksmanship_custom_perma",
        },
        ["modifier_drow_marksman_2"] = 
        {
            skill_number = 4,
            mini_icon = "marksman_2",
            skill_icon = "marksman",
            rarity = "blue",

            heal = {2, 3, 4},
            range = {100, 150, 200},
        },
        ["modifier_drow_marksman_3"] = 
        {
            skill_number = 4,
            mini_icon = "marksman_3",
            skill_icon = "marksman",
            rarity = "purple",
            main_epic = 1,

            damage = {45, 70},
            damage_alt = {30, 50},
            duration = 12,
            duration_creeps = 3,
            bonus = {60, 100},
            max = 5,
            alt_talent = "modifier_drow_frost_7",
        },
        ["modifier_drow_marksman_4"] = 
        {
            skill_number = 4,
            mini_icon = "marksman_4",
            skill_icon = "marksman",
            rarity = "purple",

            health = 4,
            health_max = 20,
            linger = 2.5,
            allow_illusion = 1,
        },
        ["modifier_drow_marksman_7"] = 
        {
            skill_number = 4,
            mini_icon = "marksman",
            skill_icon = "marksman",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            talent_cd = 5,
            duration = 0.5,
            max = 14,
            stack_duration = 3,
            chance = 100,
            status = 40,
            radius = 1000,
            skill_name = "drow_ranger_marksmanship_custom",
            trigger_ability = "drow_ranger_marksmanship_custom",
        },
    },

    npc_dota_hero_skywrath_mage = 
    {
        ["modifier_sky_arcane_bolt_1"] = 
        {
            skill_number = 1,
            mini_icon = "arcane_bolt_1",
            skill_icon = "arcane_bolt",
            rarity = "blue",

            damage = {30, 45, 60},
            health = {1.5, 2, 2.5},
        },
        ["modifier_sky_arcane_bolt_2"] = 
        {
            skill_number = 1,
            mini_icon = "arcane_bolt_2",
            skill_icon = "arcane_bolt",
            rarity = "blue",

            slow = {-4, -6, -8},
            is_purgable = 1,
            duration = 6,
            is_purgable_self = 1,
            max = 4,
        },
        ["modifier_sky_arcane_bolt_3"] = 
        {
            skill_number = 1,
            mini_icon = "arcane_bolt_3",
            skill_icon = "arcane_bolt",
            rarity = "blue",

            mana = {4, 6, 8},
            chance = 30,
        },
        ["modifier_sky_arcane_bolt_4"] = 
        {
            skill_number = 1,
            mini_icon = "arcane_bolt_4",
            skill_icon = "arcane_bolt",
            rarity = "purple",
            main_epic = 1,

            cd = {-0.6, -1},
            radius = 350,
            cd_items = {-0.6, -1},
        },
        ["modifier_sky_arcane_bolt_5"] = 
        {
            skill_number = 1,
            mini_icon = "arcane_bolt_5",
            skill_icon = "arcane_bolt",
            rarity = "purple",
            has_video = 1,

            cd = 25,
            heal = 400,
            is_breakable = 1,
            duration = 2,
        },
        ["modifier_sky_arcane_bolt_6"] = 
        {
            skill_number = 1,
            mini_icon = "arcane_bolt_6",
            skill_icon = "arcane_bolt",
            rarity = "purple",
            has_video = 1,

            speed = 45,
            range = 100,
            root = 1.5,
            count = 4,
            is_purgable_self = 1,
            duration = 8,
        },
        ["modifier_sky_arcane_bolt_7"] = 
        {
            skill_number = 1,
            mini_icon = "arcane_bolt",
            skill_icon = "arcane_bolt",
            rarity = "orange",
            has_video = 1,

            damage = 20,
            skill_name = "skywrath_mage_arcane_bolt_custom",
            trigger_ability = "skywrath_mage_arcane_bolt_custom_legendary",
            mana = 3,
            status = 40,
            mana_inc = 70,
            mana_duration = 5,
            cd = 12,
            duration = 20,
        },
        ["modifier_sky_concussive_1"] = 
        {
            skill_number = 2,
            mini_icon = "concussive_1",
            skill_icon = "concussive",
            rarity = "blue",

            damage = {40, 60, 80},
            int = {10, 15, 20},
        },
        ["modifier_sky_concussive_2"] = 
        {
            skill_number = 2,
            mini_icon = "concussive_2",
            skill_icon = "concussive",
            rarity = "blue",

            damage_reduce = {-15, -20, -25},
            slow = {-8, -12, -16},
        },
        ["modifier_sky_concussive_3"] = 
        {
            skill_number = 2,
            mini_icon = "concussive_3",
            skill_icon = "concussive",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = {1, 1.5, 2},
        },
        ["modifier_sky_concussive_4"] = 
        {
            skill_number = 2,
            mini_icon = "concussive_4",
            skill_icon = "concussive",
            rarity = "purple",
            main_epic = 1,

            damage = {40, 70},
            interval = 1,
            mana = {40, 60},
            duration = 6,
        },
        ["modifier_sky_concussive_5"] = 
        {
            skill_number = 2,
            mini_icon = "concussive_5",
            skill_icon = "concussive",
            rarity = "purple",
            has_video = 1,

            move = 50,
            duration = 2,
        },
        ["modifier_sky_concussive_6"] = 
        {
            skill_number = 2,
            mini_icon = "concussive_6",
            skill_icon = "concussive",
            rarity = "purple",
            has_video = 1,

            attack_range = -30,
            cast_range = -150,
            range = 400,
            knock_distance_legendary = 150,
            trigger_ability = "skywrath_mage_concussive_shot_custom",
            knock_distance = 300,
            duration = 0.2,
        },
        ["modifier_sky_concussive_7"] = 
        {
            skill_number = 2,
            mini_icon = "concussive",
            skill_icon = "concussive",
            rarity = "orange",
            has_video = 1,

            speed = 400,
            max = 5,
            range = 400,
            effect_duration = 3,
            skill_name = "skywrath_mage_concussive_shot_custom",
            count = 3,
            duration = 6,
            trigger_ability = "skywrath_mage_concussive_shot_custom ",
        },
        ["modifier_sky_seal_1"] = 
        {
            skill_number = 3,
            mini_icon = "seal_1",
            skill_icon = "seal",
            rarity = "blue",

            heal_reduce = {-15, -20, -25},
            magic = {-10, -15, -20},
        },
        ["modifier_sky_seal_2"] = 
        {
            skill_number = 3,
            mini_icon = "seal_2",
            skill_icon = "seal",
            rarity = "blue",

            max = 4,
            str = {2, 3, 4},
            armor = {2, 3, 4},
            duration = 6,
        },
        ["modifier_sky_seal_3"] = 
        {
            skill_number = 3,
            mini_icon = "seal_3",
            skill_icon = "seal",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = {0.3, 0.45, 0.6},
        },
        ["modifier_sky_seal_4"] = 
        {
            skill_number = 3,
            mini_icon = "seal_4",
            skill_icon = "seal",
            rarity = "purple",
            main_epic = 1,

            damage = 1,
            health = 100,
            heal = {15, 25},
            max = {12, 20},
            duration = 8,
        },
        ["modifier_sky_seal_5"] = 
        {
            skill_number = 3,
            mini_icon = "seal_5",
            skill_icon = "seal",
            rarity = "purple",
            has_video = 1,

            cd = 15,
            radius = 900,
            status = 15,
            duration = 1.6,
        },
        ["modifier_sky_seal_6"] = 
        {
            skill_number = 3,
            mini_icon = "seal_6",
            skill_icon = "seal",
            rarity = "purple",
            has_video = 1,

            move = -40,
            attack = -80,
        },
        ["modifier_sky_seal_7"] = 
        {
            skill_number = 3,
            mini_icon = "seal",
            skill_icon = "seal",
            rarity = "orange",
            has_video = 1,

            damage = 4,
            cd = 4,
            delay = 0.15,
            charge = 2,
            skill_name = "skywrath_mage_ancient_seal_custom",
            radius = 265,
            chance = 6,
            trigger_ability = "skywrath_mage_ancient_seal_custom",
        },
        ["modifier_sky_flare_1"] = 
        {
            skill_number = 4,
            mini_icon = "flare_1",
            skill_icon = "flare",
            rarity = "blue",

            damage = {100, 150, 200},
            radius = {40, 60, 80},
        },
        ["modifier_sky_flare_2"] = 
        {
            skill_number = 4,
            mini_icon = "flare_2",
            skill_icon = "flare",
            rarity = "blue",

            heal = {10, 15, 20},
            bonus = 2,
        },
        ["modifier_sky_flare_3"] = 
        {
            skill_number = 4,
            mini_icon = "flare_3",
            skill_icon = "flare",
            rarity = "blue",

            mana = {10, 15, 20},
            range = {100, 150, 200},
        },
        ["modifier_sky_flare_4"] = 
        {
            skill_number = 4,
            mini_icon = "flare_4",
            skill_icon = "flare",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {10, 16},
            duration = 8,
            stun = {1.2, 2},
            max = 5,
        },
        ["modifier_sky_flare_5"] = 
        {
            skill_number = 4,
            mini_icon = "flare_5",
            skill_icon = "flare",
            rarity = "purple",

            mod_name = "modifier_skywrath_mage_mystic_flare_custom_perma",
            is_perma = 1,
            cd = -0.8,
            cdr = 1,
            max = 12,
            duration = 1.6,
        },
        ["modifier_sky_flare_6"] = 
        {
            skill_number = 4,
            mini_icon = "flare_6",
            skill_icon = "flare",
            rarity = "purple",
            has_video = 1,

            is_purgable_self = 1,
            chance = 100,
            bkb = 2.5,
            duration = 2.5,
        },
        ["modifier_sky_flare_7"] = 
        {
            skill_number = 4,
            mini_icon = "flare",
            skill_icon = "flare",
            rarity = "orange",
            has_video = 1,

            damage = 50,
            channel = 8,
            move_duration = 0.3,
            move_cd = 1,
            skill_name = "skywrath_mage_mystic_flare_custom",
            damage_inc = 15,
            damage_reduce = -40,
        },
    },

    npc_dota_hero_slark = 
    {
        ["modifier_slark_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            duration = {0.4, 0.6, 0.8},
            damage_reduce = {-16, -24, -32},
        },
        ["modifier_slark_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            move = {30, 45, 60},
            slow = {-30, -45, -60},
        },
        ["modifier_slark_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            magic = {8, 12, 16},
            heal = {40, 60, 80},
        },
        ["modifier_slark_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            skill_icon = "pounce",
            has_video = 1,

            speed = 40,
            range = 40,
            invun = 0.5,
        },
        ["modifier_slark_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",

            status = 10,
            str = 2,
            max = 15,
            bonus = 2,
        },
        ["modifier_slark_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",

            move = 50,
            max_move = 600,
            radius = -200,
            radius_tooltip = 700,
            linger = 2,
        },


        ["modifier_slark_pact_1"] = 
        {
            skill_number = 1,
            mini_icon = "pact_1",
            skill_icon = "pact",
            rarity = "blue",

            base = {30, 45, 60},
            damage = {4, 6, 8},
        },
        ["modifier_slark_pact_2"] = 
        {
            skill_number = 1,
            mini_icon = "pact_2",
            skill_icon = "pact",
            rarity = "blue",

            heal = {10, 15, 20},
            bonus = 2,
            mana = 70,
        },
        ["modifier_slark_pact_3"] = 
        {
            skill_number = 1,
            mini_icon = "pact_3",
            skill_icon = "pact",
            rarity = "purple",
            main_epic = 1,

            bonus = {6, 10},
            bonus_inc = {3, 5},
            max = 5,
            duration = 12,
            duration_creeps = 5,
        },
        ["modifier_slark_pact_4"] = 
        {
            skill_number = 1,
            mini_icon = "pact_4",
            skill_icon = "pact",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -30,
            duration = 0.5,
            base = 70,
            shield = 5,
            max = 3,
            shield_duration = 10,
        },
        ["modifier_slark_pact_7"] = 
        {
            skill_number = 1,
            mini_icon = "pact",
            skill_icon = "pact",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            damage = 350,
            cost = 12,
            heal = 12,
            max = 3,
            duration = 1.5,
            radius = 100,
            knock_duration = 0.4,
            trigger_ability = "slark_dark_pact_custom",
            skill_name = "slark_dark_pact_custom",
        },
        ["modifier_slark_pounce_1"] = 
        {
            skill_number = 2,
            mini_icon = "pounce_1",
            skill_icon = "pounce",
            rarity = "blue",

            heal_reduce = {-6, -9, -12},
            damage = {20, 30, 40},
            duration = 8,
        },
        ["modifier_slark_pounce_2"] = 
        {
            skill_number = 2,
            mini_icon = "pounce_2",
            skill_icon = "pounce",
            rarity = "blue",

            cd = {-1, -1.5, -2},
        },
        ["modifier_slark_pounce_3"] = 
        {
            skill_number = 2,
            mini_icon = "pounce_3",
            skill_icon = "pounce",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            magic = {-3, -5},
            damage = {50, 80},
            effect_duration = 4,
            interval = 0.5,
            duration = 10,
            min_radius = 300,
            max = 8,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_slark_pounce_4"] = 
        {
            skill_number = 2,
            mini_icon = "pounce_4",
            skill_icon = "pounce",
            rarity = "purple",

            cdr = 10,
            move = 30,
            duration = 3,
            cd_items = -1.5,
            cd_items_legendary = -0.8,
        },
        ["modifier_slark_pounce_7"] = 
        {
            skill_number = 2,
            mini_icon = "pounce",
            skill_icon = "pounce",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            spell = 1.5,
            pact = 1.5,
            leash = 50,
            damage = 50,
            charge = 2,
            charge_return = 1,
            speed = 1200,
            range = 1200,
            radius = 230,
            duration = 20,
            talent_cd = 10,
            tower_duration = 5,

            skill_name = "slark_pounce_custom",
            trigger_ability = "slark_pounce_custom_legendary",
        },
        ["modifier_slark_essence_1"] = 
        {
            skill_number = 3,
            mini_icon = "essence_1",
            skill_icon = "essence",
            rarity = "blue",

            speed = {20, 30, 40},
            agi = {0.4, 0.6, 0.8},
        },
        ["modifier_slark_essence_2"] = 
        {
            skill_number = 3,
            mini_icon = "essence_2",
            skill_icon = "essence",
            rarity = "blue",

            range = {50, 75, 100},
            cleave = {20, 30, 40},
        },
        ["modifier_slark_essence_3"] = 
        {
            skill_number = 3,
            mini_icon = "essence_3",
            skill_icon = "essence",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            attacks = {2, 3},
            slow = -100,
            cd = 4,
            delay = 0.15,
            cd_inc = 2,
            duration = 1,
            damage = 40,
            is_through_bkb = 1,
        },
        ["modifier_slark_essence_4"] = 
        {
            skill_number = 3,
            mini_icon = "essence_4",
            skill_icon = "essence",
            rarity = "purple",
            has_video = 1,

            duration = 5,
            max = 10,
            silence = 3,
            talent_cd = 10,
            is_purgable_self = 1,
        },
        ["modifier_slark_essence_7"] = 
        {
            skill_number = 3,
            mini_icon = "essence",
            skill_icon = "essence",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            range = 500,
            attacks = 5,
            effect_duration = 4,
            talent_cd = 15,
            duration = 10,
            cdr = 40,
            cast = 40,
            skill_name = "slark_saltwater_shiv_custom",
        },
        ["modifier_slark_dance_1"] = 
        {
            skill_number = 4,
            mini_icon = "dance_1",
            skill_icon = "dance",
            rarity = "blue",

            armor = {6, 9, 12},
            max = 15,
            is_through_bkb = 1,
        },
        ["modifier_slark_dance_2"] = 
        {
            skill_number = 4,
            mini_icon = "dance_2",
            skill_icon = "dance",
            rarity = "blue",

            duration = {0.2, 0.3, 0.4},
            cd = {-4, -6, -8},
        },
        ["modifier_slark_dance_3"] = 
        {
            skill_number = 4,
            mini_icon = "dance_3",
            skill_icon = "dance",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {8, 15},
            burn = {25, 40},
            interval = 1,
            bonus = 30,
            duration = 8,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            is_through_bkb = 1,
        },
        ["modifier_slark_dance_4"] = 
        {
            skill_number = 4,
            mini_icon = "dance_4",
            skill_icon = "dance",
            rarity = "purple",
            has_video = 1,

            heal = 15,
            bonus = 3,
            range = 200,
        },
        ["modifier_slark_dance_7"] = 
        {
            skill_number = 4,
            mini_icon = "dance",
            skill_icon = "dance",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            cd = 6,
            bva_base = 2,
            bva_bonus = 1.5,
            duration = 2.5,
            radius = 300,
            skill_name = "slark_shadow_dance_custom",
            trigger_ability = "slark_shadow_dance_custom_legendary",
        },
    },

    npc_dota_hero_centaur = 
    {
        ["modifier_centaur_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            max = 4,
            damage_reduce = {-4, -6, -8},
            heal_reduce = {-4, -6, -8},
            duration = 8,
        },
        ["modifier_centaur_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            slow = {-20, -30, -40},
            move = {30, 45, 60},
            duration = 4,
            is_purgable_self = 1,
        },
        ["modifier_centaur_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            duration = 6,
            armor = {10, 15, 20},
            regen = {20, 30, 40},
            max = 10,
        },

        ["modifier_centaur_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            silence = 2,
            range_inc = 250,
            range = 200,
            talent_cd = 12,
            knock_duration = 0.3,
            is_purgable_self = 1,
            trigger_ability = "centaur_double_edge_custom",
        },
        ["modifier_centaur_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            status = 15,
            status_bonus = 3,
            damage_reduce = -25,
            talent_cd = 12,
            duration = 4,
            is_breakable = 1,
        },
        ["modifier_centaur_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            bkb = 2.5,
        },

        ["modifier_centaur_stomp_1"] = 
        {
            skill_number = 1,
            mini_icon = "stomp_1",
            skill_icon = "stomp",
            rarity = "blue",

            damage = {80, 120, 160},
            spell = {6, 9, 12},
        },
        ["modifier_centaur_stomp_2"] = 
        {
            skill_number = 1,
            mini_icon = "stomp_2",
            skill_icon = "stomp",
            rarity = "blue",

            cd = {-2, -3, -4},
            cast = {-0.1, -0.15, -0.2},
        },
        ["modifier_centaur_stomp_3"] = 
        {
            skill_number = 1,
            mini_icon = "stomp_3",
            skill_icon = "stomp",
            rarity = "purple",
            main_epic = 1,

            magic = {-5, -8},
            duration = 10,
            max = 5,
            distance = 250,
            damage_max = 3,
            damage = {25, 40},
            slow = -100,
            slow_duration = 0.5,
            effect_duration = 5,
        },
        ["modifier_centaur_stomp_4"] = 
        {
            skill_number = 1,
            mini_icon = "stomp_4",
            skill_icon = "stomp",
            rarity = "purple",

            cdr = 15,
            slow_resist = 30,
            cd_items = 1,
        },
        ["modifier_centaur_stomp_7"] = 
        {
            skill_number = 1,
            mini_icon = "stomp",
            skill_icon = "stomp",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            distance = 300,
            max = 6,
            cd_inc = -10,
            effect_duration = 12,
            damage = 35,
            speed = 1400,
            range = 1000,
            hit_radius = 150,
            is_root_disabled = 1,
            skill_name = "centaur_hoof_stomp_custom",
        },

        ["modifier_centaur_edge_1"] = 
        {
            skill_number = 2,
            mini_icon = "edge_1",
            skill_icon = "edge",
            rarity = "blue",

            damage = {10, 15, 20},
            damage_self = {-10, -15, -20},
        },
        ["modifier_centaur_edge_2"] = 
        {
            skill_number = 2,
            mini_icon = "edge_2",
            skill_icon = "edge",
            rarity = "blue",

            cd = {-20, -30, -40},
            cast = {-20, -30, -40},
        },
        ["modifier_centaur_edge_3"] = 
        {
            skill_number = 2,
            mini_icon = "edge_3",
            skill_icon = "edge",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal = {20, 35},
            chance = 30,
            damage = {50, 80},
        },
        ["modifier_centaur_edge_4"] = 
        {
            skill_number = 2,
            mini_icon = "edge_4",
            skill_icon = "edge",
            rarity = "purple",
            has_video = 1,

            health = 30,
            max_shield = 15,
            shield = 25,
            talent_cd = 12,
            resist = 20,
            duration = 10,
            is_breakable = 1,
        },
        ["modifier_centaur_edge_7"] = 
        {
            skill_number = 2,
            mini_icon = "edge",
            skill_icon = "edge",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            creeps = 3,
            talent_cd = 12,
            cd_inc = -40,
            duration = 6,
            damage = 170,
            blood_duration = 6,
            interval = 0.5,
            skill_name = "centaur_double_edge_custom",
            trigger_ability = "centaur_double_edge_custom_legendary",
        },

        ["modifier_centaur_retaliate_1"] = 
        {
            skill_number = 3,
            mini_icon = "retaliate_1",
            skill_icon = "retaliate",
            rarity = "blue",
                
            armor = {-4, -6, -8},
            duration = 6,
            damage = {8, 12, 16},
        },
        ["modifier_centaur_retaliate_2"] = 
        {
            skill_number = 3,
            mini_icon = "retaliate_2",
            skill_icon = "retaliate",
            rarity = "blue",

            heal = {10, 15, 20},
            bonus = 3,
        },
        ["modifier_centaur_retaliate_3"] = 
        {
            skill_number = 3,
            mini_icon = "retaliate_3",
            skill_icon = "retaliate",
            rarity = "purple",
            main_epic = 1,

            damage = {200, 350},
            radius = 300,
            chance = 50,
            str = {3, 5},
            max = 5,
            duration = 10,
        },
        ["modifier_centaur_retaliate_4"] = 
        {
            skill_number = 3,
            mini_icon = "retaliate_4",
            skill_icon = "retaliate",
            rarity = "purple",
            has_video = 1,

            slow = -40,
            slow_duration = 4,
            timer = 3,
            taunt = 2,
            health = 35,
            duration = 10,
            is_through_bkb = 1,
            talent_cd = 12,
            alt_talent = "modifier_centaur_retaliate_7"
        },
        ["modifier_centaur_retaliate_7"] = 
        {
            skill_number = 3,
            mini_icon = "retaliate",
            skill_icon = "retaliate",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            speed = 20,
            effect_duration = 8,
            health = 35,
            heal = 10,
            duration = 10,
            range = 500,
            talent_cd = 12,
            radius = 700,
            max = 12,
            knock_radius = 600,
            is_through_bkb = 1,
            knock_duration = 0.3,
            attack_radius = 250,
            skill_name = "centaur_return_custom",
        },
        ["modifier_centaur_stampede_1"] = 
        {
            skill_number = 4,
            mini_icon = "stampede_1",
            skill_icon = "stampede",
            rarity = "blue",

            speed = {20, 30, 40},
            damage = {4, 6, 8},
            max = 5,
            duration = 10,
        },
        ["modifier_centaur_stampede_2"] = 
        {
            skill_number = 4,
            mini_icon = "stampede_2",
            skill_icon = "stampede",
            rarity = "blue",

            range = {40, 60, 80},
            bonus = 2,
            duration = {1, 1.5, 2},
        },
        ["modifier_centaur_stampede_3"] = 
        {
            skill_number = 4,
            mini_icon = "stampede_3",
            skill_icon = "stampede",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            cd = {4, 2.5},
            crit = 200,
            heal = 100,
            cleave = 50,
            cd_inc = 3,
            legendary_stack = 2,
            alt_talent = "modifier_centaur_stampede_7",
        },
        ["modifier_centaur_stampede_4"] = 
        {
            skill_number = 4,
            mini_icon = "stampede_4",
            skill_icon = "stampede",
            rarity = "purple",

            cd_inc = -5,
            duration = 1,
        },
        ["modifier_centaur_stampede_7"] = 
        {
            skill_number = 4,
            mini_icon = "stampede",
            skill_icon = "stampede",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            damage = 250,
            stack_radius = 1000,
            max = 8,
            stack_duration = 3,
            duration = 0.5,
            silence = 2,
            talent_cd = 5,
            slow = -50,
            is_through_bkb = 1,
            skill_name = "centaur_stampede_custom",
            trigger_ability = "centaur_stampede_custom_legendary",
        },
    },

    npc_dota_hero_enigma = 
    {

        ["modifier_enigma_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            heal = {10, 15, 20},
            range = {100, 150, 200},
        },
        ["modifier_enigma_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            armor = {6, 9, 12},
            move = {30, 45, 60},
        },
        ["modifier_enigma_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            cdr = {6, 9, 12},
            mana = {16, 24, 32},
        },
        ["modifier_enigma_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            duration = 2.5,
            damage_reduce = -70,
            slow = -70,
            cd = 12,
        },
        ["modifier_enigma_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            speed = 600,
            duration = 2,
            slow = -50,
        },
        ["modifier_enigma_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            range = 250,
            status = 15,
            is_root_disabled = 1,
            trigger_ability = "enigma_demonic_conversion_custom",
        },


        ["modifier_enigma_malefice_1"] = 
        {
            skill_number = 1,
            mini_icon = "malefice_1",
            skill_icon = "malefice",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            damage = {50, 75, 100},
        },
        ["modifier_enigma_malefice_2"] = 
        {
            skill_number = 1,
            mini_icon = "malefice_2",
            skill_icon = "malefice",
            rarity = "blue",

            attack_range = {100, 150, 200},
            slow = {-16, -24, -32},
            duration = 3,
        },
        ["modifier_enigma_malefice_3"] = 
        {
            skill_number = 1,
            mini_icon = "malefice_3",
            skill_icon = "malefice",
            rarity = "purple",
            main_epic = 1,

            damage = {12, 20},
            health = {-20, -35},
            eidolon = 3,
            duration = 8,
            max = 15,
        },
        ["modifier_enigma_malefice_4"] = 
        {
            skill_number = 1,
            mini_icon = "malefice_4",
            skill_icon = "malefice",
            rarity = "purple",
            has_video = 1,

            stun = 0.2,
            chance = 10,
            talent_cd = 4,
            is_basher = 1,
        },
        ["modifier_enigma_malefice_7"] = 
        {
            skill_number = 1,
            mini_icon = "malefice",
            skill_icon = "malefice",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            damage_end = 1700,
            damage_k = 1.75,
            stun = 2,
            radius = 400,
            max = 7,
            stun_reduce = -30,
            skill_name = "enigma_malefice_custom",
        },
        ["modifier_enigma_conversion_1"] = 
        {
            skill_number = 2,
            mini_icon = "conversion_1",
            skill_icon = "conversion",
            rarity = "blue",

            damage = {20, 30, 40},
            health = {60, 90, 120},
            max = 200,
            is_perma = 1,
            mod_name = "modifier_enigma_demonic_conversion_custom_perma",
        },
        ["modifier_enigma_conversion_2"] = 
        {
            skill_number = 2,
            mini_icon = "conversion_2",
            skill_icon = "conversion",
            rarity = "blue",

            cd = {-2, -3, -4},
            heal = {4, 6, 8},
        },
        ["modifier_enigma_conversion_3"] = 
        {
            skill_number = 2,
            mini_icon = "conversion_3",
            skill_icon = "conversion",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            speed = {35, 60},
            max = 6,
            bonus = 2,
            chance = 50,
            duration = 8,
            count = {3, 5},
            radius = 800,
        },
        ["modifier_enigma_conversion_4"] = 
        {
            skill_number = 2,
            mini_icon = "conversion_4",
            skill_icon = "conversion",
            rarity = "purple",
            has_video = 1,

            attacks = -1,
            duration = 1.5,
            move = 50,
        },
        ["modifier_enigma_conversion_7"] = 
        {
            skill_number = 2,
            mini_icon = "conversion",
            skill_icon = "conversion",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            health = 15,
            radius = 800,
            aura_radius = 600,
            talent_cd = 20,
            invun_duration = 0.3,
            duration = 10,
            base_health = 200,
            movespeed = 50,
            damage_type = DAMAGE_TYPE_MAGICAL,
            skill_name = "enigma_demonic_conversion_custom",
            trigger_ability = "enigma_demonic_conversion_custom_legendary",
        },
        ["modifier_enigma_midnight_1"] = 
        {
            skill_number = 3,
            mini_icon = "midnight_1",
            skill_icon = "midnight",
            rarity = "blue",

            damage = {1, 1.5, 2},
            magic = {-8, -12, -16},
            creeps = {50, 75, 100},
        },
        ["modifier_enigma_midnight_2"] = 
        {
            skill_number = 3,
            mini_icon = "midnight_2",
            skill_icon = "midnight",
            rarity = "blue",

            cd = {-2, -3, -4},
            radius = {80, 120, 160},
        },
        ["modifier_enigma_midnight_3"] = 
        {
            skill_number = 3,
            mini_icon = "midnight_3",
            skill_icon = "midnight",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {3, 5},
            base = {35, 60},
            heal = 75,
            chance = 15,
            bonus = 2,
            health = 50,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_enigma_midnight_4"] = 
        {
            skill_number = 3,
            mini_icon = "midnight_4",
            skill_icon = "midnight",
            rarity = "purple",

            heal = 4,
            health = 12,
            damage_reduce = -12,
        },
        ["modifier_enigma_midnight_7"] = 
        {
            skill_number = 3,
            mini_icon = "midnight",
            skill_icon = "midnight",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            duration = 3,
            invun = 1.5,
            damage = 50,
            skill_name = "enigma_midnight_pulse_custom",
        },
        ["modifier_enigma_blackhole_1"] = 
        {
            skill_number = 4,
            mini_icon = "blackhole_1",
            skill_icon = "blackhole",
            rarity = "blue",

            damage = {30, 45, 60},
            heal_reduce = {-12, -18, -24},
        },
        ["modifier_enigma_blackhole_2"] = 
        {
            skill_number = 4,
            mini_icon = "blackhole_2",
            skill_icon = "blackhole",
            rarity = "blue",

            cd = {-4, -6, -8},
            cast = {-0.2, -0.3, -0.4},
        },
        ["modifier_enigma_blackhole_3"] = 
        {
            skill_number = 4,
            mini_icon = "blackhole_3",
            skill_icon = "blackhole",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {2, 3.5},
            duration = {0.5, 1},
            max = 10,
            stack_duration = 10,
            radius = 2000,
        },
        ["modifier_enigma_blackhole_4"] = 
        {
            skill_number = 4,
            mini_icon = "blackhole_4",
            skill_icon = "blackhole",
            rarity = "purple",
            has_video = 1,

            range = 300,
            heal = 60,
            cd_items = -5,
            cd_items_legendary = -1.5,
            alt_talent = "modifier_enigma_blackhole_7",
        },
        ["modifier_enigma_blackhole_7"] = 
        {
            skill_number = 4,
            mini_icon = "blackhole",
            skill_icon = "blackhole",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            damage_inc = 135,
            max = 4,
            damage_k = 1.5,
            damage = 100,
            stun = 1,
            range = 1500,
            radius = 250,
            speed = 1200,
            slow_move = -100,
            slow_duration = 0.5,
            stack_duration = 15,
            linger = 5,
            talent_cd = 3.5,
            active_cd = 5,
            is_through_bkb = 1,
            skill_name = "enigma_black_hole_custom",
            trigger_ability = "enigma_black_hole_custom_legendary",
        },
    },

    npc_dota_hero_bane = 
    {
        ["modifier_bane_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            range = {100, 150, 200},
            move = {30, 45, 60},
        },
        ["modifier_bane_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            cd = {-2, -3, -4},
            health = {6, 9, 12},
        },
        ["modifier_bane_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            heal_reduce = {-10, -15, -20},
            regen = {1, 1.5, 2},
            duration = 4,
        },

        ["modifier_bane_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            heal_inc = 15,
            duration = 12,
            health = 30,
            talent_cd = 12,
            shield = 20,
            is_breakable = 1,
        },
        ["modifier_bane_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            magic = 15,
            silence = 2.5,
            slow = -100,
            is_purgable_self = 1,
            alt_talent = "modifier_bane_nightmare_7",
        },
        ["modifier_bane_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            cd = 4,
            damage_reduce = -50,
            duration = 2,
            thresh = 100,
        },


        ["modifier_bane_enfeeble_1"] = 
        {
            skill_number = 1,
            mini_icon = "enfeeble_1",
            skill_icon = "enfeeble",
            rarity = "blue",

            health = {10, 15, 20},
            armor = {-6, -9, -12},
            duration = 4,
        },
        ["modifier_bane_enfeeble_2"] = 
        {
            skill_number = 1,
            mini_icon = "enfeeble_2",
            skill_icon = "enfeeble",
            rarity = "blue",

            speed = {40, 60, 80},
            speed_reduce = {-40, -60, -80},
        },
        ["modifier_bane_enfeeble_3"] = 
        {
            skill_number = 1,
            mini_icon = "enfeeble_3",
            skill_icon = "enfeeble",
            rarity = "purple",
            main_epic = 1,

            damage = {35, 60},
            heal = 100,
            radius = 300,
            chance = 25,
            bonus = 2,
            damage_type = DAMAGE_TYPE_PURE,
        },
        ["modifier_bane_enfeeble_4"] = 
        {
            skill_number = 1,
            mini_icon = "enfeeble_4",
            skill_icon = "enfeeble",
            rarity = "purple",
            has_video = 1,

            is_purgable_self = 1,
            range = -30,
            root = 2,
        },
        ["modifier_bane_enfeeble_7"] = 
        {
            skill_number = 1,
            mini_icon = "enfeeble",
            skill_icon = "enfeeble",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            value = 200,
            radius = 600,
            timer = 1,
            max = 15,
            duration = 10,
            skill_name = "bane_enfeeble_custom",
        },
        ["modifier_bane_brain_1"] = 
        {
            skill_number = 2,
            mini_icon = "brain_1",
            skill_icon = "brain",
            rarity = "blue",

            cd = {-2, -3, -4},
            mana = {10, 15, 20},
        },
        ["modifier_bane_brain_2"] = 
        {
            skill_number = 2,
            mini_icon = "brain_2",
            skill_icon = "brain",
            rarity = "blue",

            base = {20, 30, 40},
            damage = {1.6, 2.4, 3.2},
        },
        ["modifier_bane_brain_3"] = 
        {
            skill_number = 2,
            mini_icon = "brain_3",
            skill_icon = "brain",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            mana = {300, 200},
            cd = 5,
            damage = {30, 50},
            radius = 600,
        },
        ["modifier_bane_brain_4"] = 
        {
            skill_number = 2,
            mini_icon = "brain_4",
            skill_icon = "brain",
            rarity = "purple",
            has_video = 1,

            cast = -0.1,
            talent_cd = 10,
            fear = 1.2,
        },
        ["modifier_bane_brain_7"] = 
        {
            skill_number = 2,
            mini_icon = "brain",
            skill_icon = "brain",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            mana = 30,
            damage_reduce = -80,
            duration = 4,
            talent_cd = 20,
            damage = 80,
            cd = -40,
            skill_name = "bane_brain_sap_custom",
            trigger_ability = "bane_brain_sap_custom_legendary",
        },
        ["modifier_bane_nightmare_1"] = 
        {
            skill_number = 3,
            mini_icon = "nightmare_1",
            skill_icon = "nightmare",
            rarity = "blue",

            slow = {-20, -30, -40},
            duration = 3,
            range = {120, 180, 240},
            is_purgable_self = 1,
        },
        ["modifier_bane_nightmare_2"] = 
        {
            skill_number = 3,
            mini_icon = "nightmare_2",
            skill_icon = "nightmare",
            rarity = "blue",

            bonus = 2,
            damage = {10, 15, 20},
            duration = 5,
        },
        ["modifier_bane_nightmare_3"] = 
        {
            skill_number = 3,
            mini_icon = "nightmare_3",
            skill_icon = "nightmare",
            rarity = "purple",
            has_video = 1,
            main_epic = 1,

            damage = {70, 120},
            stats = {12, 20},
            radius = 900,
            attacks = 4,
            max = 4,
            duration = 3,
        },
        ["modifier_bane_nightmare_4"] = 
        {
            skill_number = 3,
            mini_icon = "nightmare_4",
            skill_icon = "nightmare",
            rarity = "purple",
            has_video = 1,

            status = 15,
            regen = 4,
            heal = 25,
            bonus = 5,
            creeps = 3,
        },
        ["modifier_bane_nightmare_7"] = 
        {
            skill_number = 3,
            mini_icon = "nightmare",
            skill_icon = "nightmare",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            damage = 140,
            effect_duration = 12,
            talent_cd = 16,
            duration = 5,
            skill_name = "bane_nightmare_custom",
            trigger_ability = "bane_nightmare_custom_legendary",
        },
        ["modifier_bane_grip_1"] = 
        {
            skill_number = 4,
            mini_icon = "grip_1",
            skill_icon = "grip",
            rarity = "blue",

            cd = {-4, -6, -8},
            duration = {0.2, 0.3, 0.4},
        },
        ["modifier_bane_grip_2"] = 
        {
            skill_number = 4,
            mini_icon = "grip_2",
            skill_icon = "grip",
            rarity = "blue",

            damage = {10, 15, 20},
            is_through_bkb = 1,
            damage_type = DAMAGE_TYPE_PURE,
        },
        ["modifier_bane_grip_3"] = 
        {
            skill_number = 4,
            mini_icon = "grip_3",
            skill_icon = "grip",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            cdr = {10, 15},
            damage = {2.5, 4},
            max = 6,
            duration = 8,
            is_through_bkb = 1,
        },
        ["modifier_bane_grip_4"] = 
        {
            skill_number = 4,
            mini_icon = "grip_4",
            skill_icon = "grip",
            rarity = "purple",

            max = 4,
            duration = 3,
            cd_items = -3,
            move = 30,
            effect_duration = 6,
        },
        ["modifier_bane_grip_7"] = 
        {
            skill_number = 4,
            mini_icon = "grip",
            skill_icon = "grip",
            rarity = "orange",
            has_video = 1,
            complexity = 2,

            duration = 6,
            stun = 1.5,
            damage = 12,
            heal = 140,
            cast_range = 800,
            incoming = 200,
            outgoing = 50,
            delay = 3,
            max = 4,
            radius = 1000,
            effect_duration = 3,
            creeps = 600,
            is_through_bkb = 1,
            damage_type = DAMAGE_TYPE_PURE,
            skill_name = "bane_fiends_grip_custom",
        },
    },

    npc_dota_hero_morphling =
    {
        ["modifier_morphling_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            slow = {-20, -30, -40},
            heal_reduce = {-10, -15, -20},
            duration = 3,
        },
        ["modifier_morphling_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            mana = {16, 24, 32},
            speed = {20, 30, 40},
        },
        ["modifier_morphling_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "blue",

            magic = {8, 12, 16},
            health = {8, 12, 16},
        },

        ["modifier_morphling_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            speed = 30,
            silence = 2.5,
            miss = 100,
            talent_cd = 10,
            is_purgable_self = 1,
        },
        ["modifier_morphling_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            str = 1.5,
            heal = 50,
            invun = 1,
        },
        ["modifier_morphling_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",

            max_move = 50,
            max_move_real = 600,
            move = 1,
            status = 1,
            agi = 8,
            str = 8,
        },

        ["modifier_morphling_wave_1"] = 
        {
            skill_number = 1,
            mini_icon = "wave_1",
            skill_icon = "wave",
            rarity = "blue",
            has_video = 1,

            damage = {60, 90, 120},
            duration = 8,
            radius = 240,
            distance = 200,
            linger = 2,
            interval = 0.5,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_morphling_wave_2"] = 
        {
            skill_number = 1,
            mini_icon = "wave_2",
            skill_icon = "wave",
            rarity = "blue",

            range = {100, 150, 200},
            move = {30, 45, 60},
        },
        ["modifier_morphling_wave_3"] = 
        {
            skill_number = 1,
            mini_icon = "wave_3",
            skill_icon = "wave",
            rarity = "purple",
            main_epic = 1,

            spell = {8, 15},
            magic = {-25, -40},
            max = 6,
            duration = 12,
        },
        ["modifier_morphling_wave_4"] = 
        {
            skill_number = 1,
            mini_icon = "wave_4",
            skill_icon = "wave",
            rarity = "purple",
            has_video = 1,

            cd_items = -1,
            duration = 4,
            cd = -2,
            slow_resist = 50,
        },
        ["modifier_morphling_wave_7"] = 
        {
            skill_number = 1,
            mini_icon = "wave",
            skill_icon = "wave",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            cd_inc = 10,
            distance = 200,
            duration = 16,
            max = 3,
            effect_duration = 12,
            health_reduce = -50,
            is_through_bkb = 1,
            skill_name = "morphling_waveform_custom",
        },


        ["modifier_morphling_adaptive_1"] = 
        {
            skill_number = 2,
            mini_icon = "adaptive_1",
            skill_icon = "adaptive",
            rarity = "blue",

            damage = {12, 18, 24},
        },
        ["modifier_morphling_adaptive_2"] = 
        {
            skill_number = 2,
            mini_icon = "adaptive_2",
            skill_icon = "adaptive",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            stun = {0.2, 0.3, 0.4},
        },
        ["modifier_morphling_adaptive_3"] = 
        {
            skill_number = 2,
            mini_icon = "adaptive_3",
            skill_icon = "adaptive",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            cdr = {8, 15},
            damage = {35, 60},
            delay = 0.3,
            delay_wave = 0.5,
            chance = 50,
        },
        ["modifier_morphling_adaptive_4"] = 
        {
            skill_number = 2,
            mini_icon = "adaptive_4",
            skill_icon = "adaptive",
            rarity = "purple",
            has_video = 1,

            heal = 25,
            max = 4,
            shield = 180,
            timer = 8,
            duration = 10,
        },
        ["modifier_morphling_adaptive_7"] = 
        {
            skill_number = 2,
            mini_icon = "adaptive",
            skill_icon = "adaptive",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            attack = -20,
            damage = 180,
            stun = 0.6,
            base = 50,
            cd_inc = 50,
            inner_radius = 170,
            radius = 320,
            range = 200,
            speed = 2000,
            skill_name = "morphling_adaptive_strike_custom",
        },

        ["modifier_morphling_attribute_1"] = 
        {
            skill_number = 3,
            mini_icon = "attribute_1",
            skill_icon = "attribute",
            rarity = "blue",

            speed = {20, 30, 40},
            damage = {100, 150, 200},
            duration = 3,
            damage_type = DAMAGE_TYPE_PHYSICAL,
        },
        ["modifier_morphling_attribute_2"] = 
        {
            skill_number = 3,
            mini_icon = "attribute_2",
            skill_icon = "attribute",
            rarity = "blue",

            radius = 250,
            damage = {20, 30, 40},
            range = {100, 150, 200},
            alt_talent = "modifier_morphling_morph_7",
        },
        ["modifier_morphling_attribute_3"] = 
        {
            skill_number = 3,
            mini_icon = "attribute_3",
            skill_icon = "attribute",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            max = 4,
            max_legendary = 3,
            damage = {40, 80},
            stats = {6, 10},
            stats_max = 4,
            duration = 10,
            duration_creeps = 4,
            alt_talent = "modifier_morphling_morph_7",
        },
        ["modifier_morphling_attribute_4"] = 
        {
            skill_number = 3,
            mini_icon = "attribute_4",
            skill_icon = "attribute",
            rarity = "purple",

            range = 400,
            chance = 25,
            max_stun = 1.2,
            stun = 0.1,
            str = 12,
            talent_cd = 3,
            is_basher = 1,
            is_through_bkb = 1,
        },
        ["modifier_morphling_attribute_7"] = 
        {
            skill_number = 3,
            mini_icon = "attribute",
            skill_icon = "attribute",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
     
            duration = 15,
            max = 12,
            radius = 1000,
            linger = 3,
            wave_cd = 15,
            duration_k = 1.75,
            strike_duration = 3,
            talent_cd = 10,
            bva = 1.1,
            skill_name = "morphling_morph_agi_custom",
            trigger_ability = "morphling_attribute_legendary_custom",
        },

        ["modifier_morphling_morph_1"] = 
        {
            skill_number = 4,
            mini_icon = "morph_1",
            skill_icon = "morph",
            rarity = "blue",

            armor_reduce = {-6, -9, -12},
            armor = {6, 9, 12},
            duration = 8,
            max = 10,
            max_legendary = 5,
            is_through_bkb = 1,
            alt_talent = "modifier_morphling_morph_7",
        },
        ["modifier_morphling_morph_2"] = 
        {
            skill_number = 4,
            mini_icon = "morph_2",
            skill_icon = "morph",
            rarity = "blue",

            heal = {10, 15, 20},
            bonus = 2,
        },
        ["modifier_morphling_morph_3"] = 
        {
            skill_number = 4,
            mini_icon = "morph_3",
            skill_icon = "morph",
            rarity = "purple",
            main_epic = 1,

            chance = 30,
            crit = {130, 150},
            damage = {3, 5},
            max = 6,
        },
        ["modifier_morphling_morph_4"] = 
        {
            skill_number = 4,
            mini_icon = "morph_4",
            skill_icon = "morph",
            rarity = "purple",

            duration = 1,
            duration_legendary = 2,
            duration_max = 12,
            bkb = 2.5,
            talent_cd = 10,
            alt_talent = "modifier_morphling_morph_7",
        },
        ["modifier_morphling_morph_7"] = 
        {
            skill_number = 4,
            mini_icon = "morph",
            skill_icon = "morph",
            rarity = "orange",
            has_video = 1,
            complexity = 3,
     
            bva = 0.5,
            damage_base = 75,
            damage = 15,
            max = 15,
            targets = 3,
            cdr = 30,
            radius = 900,
            timer = 4,
            items_timer = 1,
            skill_name = "morphling_replicate_custom",
        },
    },

    npc_dota_hero_life_stealer = 
    {
        ["modifier_lifestealer_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            cd = {-4, -6, -8},
            armor = {8, 12, 16},
            duration = 4,
        },
        ["modifier_lifestealer_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            move = {30, 45, 60},
            status = {8, 12, 16},
        },
        ["modifier_lifestealer_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            slow = {-16, -24, -32},
            heal_reduce = {-16, -24, -32},
            max = 4,
            duration = 5,
            is_purgable_self = 1,
        },


        ["modifier_lifestealer_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            status = 80,
            invun = 0.5,
            health = 30,
            talent_cd = 20,
            is_breakable = 1,
        },
        ["modifier_lifestealer_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            attacks = 4,
            silence = 3,
            pull_duration = 0.25,
            min_distance = 200,
            max_distance = 500,
            range = 200,
            trigger_ability = "life_stealer_open_wounds_custom",
            is_purgable_self = 1,
        },
        ["modifier_lifestealer_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",

            mana = 40,
            duration = 1,
            cd_items = -1,
            duration_creep = 1,
            alt_talent = "modifier_lifestealer_infest_7",
        },

        ["modifier_lifestealer_rage_1"] = 
        {
            skill_number = 1,
            mini_icon = "lifestealer_rage_1",
            skill_icon = "lifestealer_rage",
            rarity = "blue",

            damage = {20, 30, 40},
            damage_burn = {4, 6, 8},
            armor = {-5, -7.5, -10},
            duration = 3,
            is_through_bkb = 1,
            alt_talent = "modifier_lifestealer_ghoul_7",
        },
        ["modifier_lifestealer_rage_2"] = 
        {
            skill_number = 1,
            mini_icon = "lifestealer_rage_2",
            skill_icon = "lifestealer_rage",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = {0.6, 0.9, 1.2}
        },
        ["modifier_lifestealer_rage_3"] = 
        {
            skill_number = 1,
            mini_icon = "lifestealer_rage_3",
            skill_icon = "lifestealer_rage",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            speed = {150, 250},
            str = {12, 20},
        },
        ["modifier_lifestealer_rage_4"] = 
        {
            skill_number = 1,
            mini_icon = "lifestealer_rage_4",
            skill_icon = "lifestealer_rage",
            rarity = "purple",
            has_video = 1,

            range = 400,
            duration = 0.25,
            move = 30,
            slow_resist = 30,
            trigger_ability = "life_stealer_rage_custom",
        },
        ["modifier_lifestealer_rage_7"] = 
        {
            skill_number = 1,
            mini_icon = "lifestealer_rage",
            skill_icon = "lifestealer_rage",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
    
            feast = 2,
            cd = -50,
            health = 40,
            bonus = 3,
            skill_name = "life_stealer_rage_custom",
        },


        ["modifier_lifestealer_wounds_1"] = 
        {
            skill_number = 2,
            mini_icon = "wounds_1",
            skill_icon = "wounds",
            rarity = "blue",

            spell = {8, 12, 16},
            damage = {4, 6, 8},
        },
        ["modifier_lifestealer_wounds_2"] = 
        {
            skill_number = 2,
            mini_icon = "wounds_2",
            skill_icon = "wounds",
            rarity = "blue",

            cd = {-2, -3, -4},
            heal = {10, 15, 20},
        },
        ["modifier_lifestealer_wounds_3"] = 
        {
            skill_number = 2,
            mini_icon = "wounds_3",
            skill_icon = "wounds",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            max = 5,
            damage = {4, 6},
            base = {40, 65},
            duration = 6,
            interval = 0.5,
            heal = 50,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_lifestealer_wounds_4"] = 
        {
            skill_number = 2,
            mini_icon = "wounds_4",
            skill_icon = "wounds",
            rarity = "purple",
            has_video = 1,

            slow = -30,
            duration = 1,
        },
        ["modifier_lifestealer_wounds_7"] = 
        {
            skill_number = 2,
            mini_icon = "wounds",
            skill_icon = "wounds",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            radius = 600,
            duration = 8,
            stun = 1,
            damage = 50,
            talent_cd = 6,
            damage_type = DAMAGE_TYPE_MAGICAL,
            skill_name = "life_stealer_open_wounds_custom",
            trigger_ability = "life_stealer_open_wounds_custom_legendary"
        },

        ["modifier_lifestealer_ghoul_1"] = 
        {
            skill_number = 3,
            mini_icon = "ghoul_1",
            skill_icon = "ghoul",
            rarity = "blue",

            speed = {4, 6, 8},
            max = 10,
            is_breakable = 1,
        },
        ["modifier_lifestealer_ghoul_2"] = 
        {
            skill_number = 3,
            mini_icon = "ghoul_2",
            skill_icon = "ghoul",
            rarity = "blue",

            range = {50, 75, 100},
            cleave = {20, 30, 40},
        },
        ["modifier_lifestealer_ghoul_3"] = 
        {
            skill_number = 3,
            mini_icon = "ghoul_3",
            skill_icon = "ghoul",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            chance = 15,
            bonus = 3,
            max = 5,
            damage = 40,
            attacks = {2, 3},
            delay = 0.2,
            slow = -100,
            slow_duration = 0.5,
        },
        ["modifier_lifestealer_ghoul_4"] = 
        {
            skill_number = 3,
            mini_icon = "ghoul_4",
            skill_icon = "ghoul",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -2,
            max = 15,
            duration = 10,
            shield = 20,
            attacks = 5,
            cd = 5,
        },
        ["modifier_lifestealer_ghoul_7"] = 
        {
            skill_number = 3,
            mini_icon = "ghoul",
            skill_icon = "ghoul",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
     
            attack_damage = -25,
            duration = 3,
            effect_duration = 8,
            damage = 35,
            interval = 1,
            heal = 50,
            talent_cd = 5,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            skill_name = "life_stealer_feast_custom",
        },

        ["modifier_lifestealer_infest_1"] = 
        {
            skill_number = 4,
            mini_icon = "infest_1",
            skill_icon = "infest",
            rarity = "blue",

            damage = {4, 6, 8},
            health_reduce = {-6, -9, -12},
            duration  =10,
            damage_creep = {8, 12, 16},
            cd_creep = {-1, -1.5, -2},
            is_through_bkb = 1,
            alt_talent = "modifier_lifestealer_infest_7",
        },
        ["modifier_lifestealer_infest_2"] = 
        {
            skill_number = 4,
            mini_icon = "infest_2",
            skill_icon = "infest",
            rarity = "blue",

            heal = {1, 1.5, 2},
            health = {8, 12, 16},
            duration = 10,
            heal_creep = {0.6, 0.9, 1.2},
            health_creep = {8, 12, 16},
            alt_talent = "modifier_lifestealer_infest_7",
        },
        ["modifier_lifestealer_infest_3"] = 
        {
            skill_number = 4,
            mini_icon = "infest_3",
            skill_icon = "infest",
            rarity = "purple",
            main_epic = 1,

            cdr = {8, 15},
            magic = {-5, -8},
            duration = 10,
            max = 5,

            damage_creep = {15, 25},
            max_creep = 4,
            is_through_bkb = 1,
            alt_talent = "modifier_lifestealer_infest_7",
        },
        ["modifier_lifestealer_infest_4"] = 
        {
            skill_number = 4,
            mini_icon = "infest_4",
            skill_icon = "infest",
            rarity = "purple",
            has_video = 1,

            heal_amp = 12,
            duration = 2,
            root = 2,
            heal_creep = 10,
            is_through_bkb = 1,
            alt_talent = "modifier_lifestealer_infest_7",
        },
        ["modifier_lifestealer_infest_7"] = 
        {
            skill_number = 4,
            mini_icon = "infest",
            skill_icon = "infest",
            rarity = "orange",
            has_video = 1,
            complexity = 3,
     
            health = 50,
            health_creep = 50,
            skill_name = "life_stealer_infest_custom",
            trigger_ability = "life_stealer_infest_custom_legendary",
        },
    },

    npc_dota_hero_tinker = 
    {
        ["modifier_tinker_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            mana = {16, 24, 32},
            regen = {1, 1.5, 2},
        },
        ["modifier_tinker_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            status = {10, 15, 20},
            shield = {40, 60, 80},
        },
        ["modifier_tinker_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            health = {1, 1.5, 2},
            int = {8, 12, 16},
        },

        ["modifier_tinker_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            duration = 10,
            max = 2,
            stun = 1.2,
            cd_inc = -35,
            cast = -0.2,
            talent_cd = 16,
        },
        ["modifier_tinker_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            talent_cd = 15,
            health = 30,
            is_breakable = 1,
        },
        ["modifier_tinker_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -60,
            talent_cd = 14,
            duration = 0.5,
        },

        ["modifier_tinker_laser_1"] = 
        {
            skill_number = 1,
            mini_icon = "laser_1",
            skill_icon = "laser",
            rarity = "blue",

            damage = {2, 3, 4},
            base = {40, 60, 80},
        },
        ["modifier_tinker_laser_2"] = 
        {
            skill_number = 1,
            mini_icon = "laser_2",
            skill_icon = "laser",
            rarity = "blue",

            range_laser = {80, 120, 160},
            range = {100, 150, 200},
            slow = {-20, -30, -40},
            duration = 6,
            is_purgable_self = 1,
            alt_talent = "modifier_tinker_laser_7",
        },
        ["modifier_tinker_laser_3"] = 
        {
            skill_number = 1,
            mini_icon = "laser_3",
            skill_icon = "laser",
            rarity = "purple",
            main_epic = 1,

            magic = {-12, -20},
            duration = 3,
            effect_duration = 10,
            health_reduce = {-25, -40},
            max = 4,
        },
        ["modifier_tinker_laser_4"] = 
        {
            skill_number = 1,
            mini_icon = "laser_4",
            skill_icon = "laser",
            rarity = "purple",
            has_video = 1,

            heal = 25,
            damage_reduce = -25,
            duration = 3,
            bonus = 2,
            health = 50,
        },
        ["modifier_tinker_laser_7"] = 
        {
            skill_number = 1,
            mini_icon = "laser",
            skill_icon = "laser",
            rarity = "orange",
            has_video = 1,
            complexity = 1,

            duration = 2,
            range = 650,
            damage = 75,
            damage_inc = 75,
            root = 1.5,
            heal_reduce = -25,
            max = 4,
            interval = 0.2,
            range_bonus = 100,
            effect_duration = 10,
            skill_name = "tinker_laser_custom",
        },


        ["modifier_tinker_march_1"] = 
        {
            skill_number = 2,
            mini_icon = "march_1",
            skill_icon = "march",
            rarity = "blue",

            armor = {-6, -9, -12},
            stack = 20,
            max = {2, 3, 4},
            interval = 0.05,
            duration = 10,
            speed = 1200,
            talent_cd = 3,
        },
        ["modifier_tinker_march_2"] = 
        {
            skill_number = 2,
            mini_icon = "march_2",
            skill_icon = "march",
            rarity = "blue",

            heal = {12, 18, 24},
            speed = {20, 30, 40},
            speed_attack = {180, 270, 360},
        },
        ["modifier_tinker_march_3"] = 
        {
            skill_number = 2,
            mini_icon = "march_3",
            skill_icon = "march",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            duration = {1, 2},
            chance = 15,
            damage = {35, 60},
            talent_cd = 0.5,
        },
        ["modifier_tinker_march_4"] = 
        {
            skill_number = 2,
            mini_icon = "march_4",
            skill_icon = "march",
            rarity = "purple",
            has_video = 1,

            cast = -0.2,
            armor = 15,
            distance = 300,
            cd = -8,
            is_root_disabled = 1,
            trigger_ability = "tinker_march_of_the_machines_custom",
        },
        ["modifier_tinker_march_7"] = 
        {
            skill_number = 2,
            mini_icon = "march",
            skill_icon = "march",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            range = 900,
            width = 700,
            radius = 1200,
            duration = 8,
            max = 12,
            armor = -35,
            damage = 650,
            cd = 2,
            speed = 200,
            stun = 1.5,
            damage_radius = 300,
            hit_radius = 180,
            mana = -50,
            skill_name = "tinker_march_of_the_machines_custom",
        },

        ["modifier_tinker_matrix_1"] = 
        {
            skill_number = 3,
            mini_icon = "matrix_1",
            skill_icon = "matrix",
            rarity = "blue",

            attack = {12, 18, 24},
            base  = {20, 30, 40},
            damage = {60, 90, 120},
            chance = 30,
            chance_turret = 15,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_tinker_matrix_2"] = 
        {
            skill_number = 3,
            mini_icon = "matrix_2",
            skill_icon = "matrix",
            rarity = "blue",

            move = {40, 60, 80},
            slow = {-20, -30, -40},
            duration = 3,
        },
        ["modifier_tinker_matrix_3"] = 
        {
            skill_number = 3,
            mini_icon = "matrix_3",
            skill_icon = "matrix",
            rarity = "purple",
            main_epic = 1,

            stats = {30, 50},
            duration = 10,
            damage = {50, 80},
            max = 30,
        },
        ["modifier_tinker_matrix_4"] = 
        {
            skill_number = 3,
            mini_icon = "matrix_4",
            skill_icon = "matrix",
            rarity = "purple",
            has_video = 1,

            range = 350,
            health = 50,
            root = 2,
            talent_cd = 8,
            is_purgable_self = 1,
        },
        ["modifier_tinker_matrix_7"] = 
        {
            skill_number = 3,
            mini_icon = "matrix",
            skill_icon = "matrix",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            attacks = 8,
            attacks_turret = 3,
            duration = 3,
            effect_duration = 4,
            speed = 400,
            radius = 250,
            heal = 75,
            talent_cd = 5,
            is_through_bkb = 1,
            stack_duration = 8,
            skill_name = "tinker_deploy_turrets_custom",
        },

        ["modifier_tinker_rearm_1"] = 
        {
            skill_number = 4,
            mini_icon = "rearm_1",
            skill_icon = "rearm",
            rarity = "blue",

            base = {40, 60, 80},
            damage = {50, 75, 100},
            talent_cd = 5,
            radius = 250,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_tinker_rearm_2"] = 
        {
            skill_number = 4,
            mini_icon = "rearm_2",
            skill_icon = "rearm",
            rarity = "blue",

            cast = {-10, -15, -20},
            heal = {20, 30, 40},
        },
        ["modifier_tinker_rearm_3"] = 
        {
            skill_number = 4,
            mini_icon = "rearm_3",
            skill_icon = "rearm",
            rarity = "purple",
            main_epic = 1,

            health = {0.6, 1},
            damage = {1.2, 2},
            duration = 15,
        },
        ["modifier_tinker_rearm_4"] = 
        {
            skill_number = 4,
            mini_icon = "rearm_4",
            skill_icon = "rearm",
            rarity = "purple",

            cdr = 10,
            cd_items = -1,
            duration = 6,
            mana = 100,
        },
        ["modifier_tinker_rearm_7"] = 
        {
            skill_number = 4,
            mini_icon = "rearm",
            skill_icon = "rearm",
            rarity = "orange",
            has_video = 1,
            complexity = 3,
     
            damage_base = 30,
            damage = 50,
            damage_inc = 150,
            stun = 0.8,
            stack = 3,
            talent_cd = 15,
            range = 1500,
            damage_type = DAMAGE_TYPE_MAGICAL,
            trigger_ability = "tinker_heat_seeking_missile_custom",
            skill_name = "tinker_rearm_custom",
        },
    },

    npc_dota_hero_witch_doctor = 
    {
        ["modifier_witch_doctor_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",
            
            cd = {-1, -1.5, -2},
            range = {120, 180, 240},
        },
        ["modifier_witch_doctor_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            move = {40, 60, 80},
            armor = {8, 12, 16},
            move_alt = {20, 30, 40},
            armor_alt = {4, 6, 8},
            bonus = 2,
            duration = 5,
            alt_talent = "modifier_witch_doctor_voodoo_7",
        },
        ["modifier_witch_doctor_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            str = {10, 15, 20},
            mana = {6, 9, 12},
        },

        ["modifier_witch_doctor_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            status = 15,
            health = 50,
            base = 150,
            shield = 15,
            duration = 5,
            mana = 50,
            talent_cd = 6,
            is_breakable = 1,
        },
        ["modifier_witch_doctor_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            silence = 2.5,
            damage_reduce = -25,
            cast = -0.2,
            is_purgable_self = 1,
        },
        ["modifier_witch_doctor_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            damage_reduce = -60,
            duration = 2,
            bkb = 2,
            bkb_cd = 8,
            alt_talent = "modifier_witch_doctor_deathward_7",
        },

        ["modifier_witch_doctor_cask_1"] = 
        {
            skill_number = 1,
            mini_icon = "cask_1",
            skill_icon = "cask",
            rarity = "blue",

            speed = {30, 45, 60},
            speed_ward = {20, 30, 40},
            damage = {20, 30, 40},
            alt_talent = "modifier_witch_doctor_deathward_7"
        },
        ["modifier_witch_doctor_cask_2"] = 
        {
            skill_number = 1,
            mini_icon = "cask_2",
            skill_icon = "cask",
            rarity = "blue",

            range = {100, 150, 200},
            slow = {-16, -24, -32},
            duration = 3,
        },
        ["modifier_witch_doctor_cask_3"] = 
        {
            skill_number = 1,
            mini_icon = "cask_3",
            skill_icon = "cask",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            base = {90, 150},
            damage = {40, 65},
            duration = 8,
            interval = 1,
            heal = 50,
            chance = 40,
            chance_ward = 25,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_witch_doctor_cask_4"] = 
        {
            skill_number = 1,
            mini_icon = "cask_4",
            skill_icon = "cask",
            rarity = "purple",
            has_video = 1,

            range = 100,
            stun = 0.2,
            max = 2,
            radius = 700,
            talent_cd = 10,
        },
        ["modifier_witch_doctor_cask_7"] = 
        {
            skill_number = 1,
            mini_icon = "cask",
            skill_icon = "cask",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
     
            chance = 30,
            count = 1,
            is_basher = 1,
            talent_cd = 2,
            max = 7,
            speed = 50,
            duration = 6,
            radius = 1000,
            skill_name = "witch_doctor_paralyzing_cask_custom",
        },


        ["modifier_witch_doctor_voodoo_1"] = 
        {
            skill_number = 2,
            mini_icon = "voodoo_1",
            skill_icon = "voodoo",
            rarity = "blue",

            base = {10, 15, 20},
            heal = {0.5, 0.75, 1},
            damage = {0.5, 0.75, 1},
        },
        ["modifier_witch_doctor_voodoo_2"] = 
        {
            skill_number = 2,
            mini_icon = "voodoo_2",
            skill_icon = "voodoo",
            rarity = "blue",

            heal = {10, 15, 20},
            slow = {-16, -24, -32},
        },
        ["modifier_witch_doctor_voodoo_3"] = 
        {
            skill_number = 2,
            mini_icon = "voodoo_3",
            skill_icon = "voodoo",
            rarity = "purple",
            main_epic = 1,

            base = {30, 50},
            damage = {3, 5},
            chance = 15,
            talent_cd = 0.5,
            health = {8, 15},
            damage_type = DAMAGE_TYPE_MAGICAL,
            alt_talent = {"modifier_witch_doctor_voodoo_7", "modifier_witch_doctor_maledict_7"}
        },
        ["modifier_witch_doctor_voodoo_4"] = 
        {
            skill_number = 2,
            mini_icon = "voodoo_4",
            skill_icon = "voodoo",
            rarity = "purple",
            has_video = 1,

            cdr = 12,
            magic = 12,
            timer = 4,
            timer_max = 8,
            hex = 1.2,
            chance = 25,
            duration = 2,
        },
        ["modifier_witch_doctor_voodoo_7"] = 
        {
            skill_number = 2,
            mini_icon = "voodoo",
            skill_icon = "voodoo",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
     
            talent_cd = 5,
            mana = 40,
            delay = 1.5,
            damage = 500,
            heal = 250,
            passive = -40,
            radius = 400,
            mana_return = 50,
            trigger_ability = "witch_doctor_voodoo_restoration_custom",
            skill_name = "witch_doctor_voodoo_restoration_custom",
        },

        ["modifier_witch_doctor_maledict_1"] = 
        {
            skill_number = 3,
            mini_icon = "maledict_1",
            skill_icon = "maledict",
            rarity = "blue",

            spell = {6, 9, 12},
            damage = {20, 30, 40},
        },
        ["modifier_witch_doctor_maledict_2"] = 
        {
            skill_number = 3,
            mini_icon = "maledict_2",
            skill_icon = "maledict",
            rarity = "blue",

            cd = {-2, -3, -4},
            radius = {40, 60, 80},
            radius_voodoo = {40, 60, 80},
        },
        ["modifier_witch_doctor_maledict_3"] = 
        {
            skill_number = 3,
            mini_icon = "maledict_3",
            skill_icon = "maledict",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            max = 8,
            magic = {-25, -40},
            heal_reduce = {-25, -40},
            heal = {50, 80},
        },
        ["modifier_witch_doctor_maledict_4"] = 
        {
            skill_number = 3,
            mini_icon = "maledict_4",
            skill_icon = "maledict",
            rarity = "purple",
            has_video = 1,

            duration = 4,
            effect_duration = 2,
            cd_items = -1.5,
            move = 30,
        },
        ["modifier_witch_doctor_maledict_7"] = 
        {
            skill_number = 3,
            mini_icon = "maledict",
            skill_icon = "maledict",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            talent_cd = 2,
            speed = 1800,
            damage = 25,
            impact_damage = 200,
            radius = 200,
            damage_type = DAMAGE_TYPE_MAGICAL,
            skill_name = "witch_doctor_maledict_custom",
        },

        ["modifier_witch_doctor_deathward_1"] = 
        {
            skill_number = 4,
            mini_icon = "deathward_1",
            skill_icon = "deathward",
            rarity = "blue",

            attack = {20, 30, 40},
            damage = {8, 12, 16},
        },
        ["modifier_witch_doctor_deathward_2"] = 
        {
            skill_number = 4,
            mini_icon = "deathward_2",
            skill_icon = "deathward",
            rarity = "blue",

            cd = {-4, -6, -8},
            duration = {1, 1.5, 2},
        },
        ["modifier_witch_doctor_deathward_3"] = 
        {
            skill_number = 4,
            mini_icon = "deathward_3",
            skill_icon = "deathward",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            max = 6,
            damage = {60, 100},
            heal = {25, 40},
            duration = 8,
            bva = 0.7,
        },
        ["modifier_witch_doctor_deathward_4"] = 
        {
            skill_number = 4,
            mini_icon = "deathward_4",
            skill_icon = "deathward",
            rarity = "purple",
            has_video = 1,

            cast = -1.5,
            vision = 5,
            root = 1.5,
            chance = 25,
            talent_cd = 3,
            is_purgable_self = 1,
        },
        ["modifier_witch_doctor_deathward_7"] = 
        {
            skill_number = 4,
            mini_icon = "deathward",
            skill_icon = "deathward",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            bva = 0.5,
            channel = -50,
            health = 30,
            base = 500,
            armor = 8,
            magic = 40,
            charges = 2,
            skill_name = "witch_doctor_death_ward_custom",
            trigger_ability = "witch_doctor_death_ward_custom_legendary",
        },
    },

    npc_dota_hero_nyx_assassin = 
    {
        ["modifier_nyx_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            stats = {6, 9, 12},
            mana = {6, 9, 12},
        },
        ["modifier_nyx_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            status = {8, 12, 16},
            armor = {1, 1.5, 2},
            max = 8,
            duration = 5,
        },
        ["modifier_nyx_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            move = {30, 45, 60},
            gold = {100, 150, 200},
        },


        ["modifier_nyx_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            skill_icon = "vendetta",
            rarity = "purple",

            radius = 4000,
            damage = 12,
            cdr = 12,
            max = 8,
            mod_name = "modifier_nyx_assassin_innate_custom_perma",
            is_perma = 1,
        },
        ["modifier_nyx_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            magic = 15,
            shield = 20,
            duration = 4,
            no_mana = 400,
            talent_cd = 12,
            is_breakable = 1,
        },
        ["modifier_nyx_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            cd = -1,
            stun = 0.4,
            move = 40,
            duration = 4,
        },

        ["modifier_nyx_impale_1"] = 
        {
            skill_number = 1,
            mini_icon = "impale_1",
            skill_icon = "impale",
            rarity = "blue",

            damage = {80, 120, 160},
            heal = {10, 15, 20},
        },
        ["modifier_nyx_impale_2"] = 
        {
            skill_number = 1,
            mini_icon = "impale_2",
            skill_icon = "impale",
            rarity = "blue",

            cd = {-2, -3, -4},
            stun = {0.2, 0.3, 0.4},
        },
        ["modifier_nyx_impale_3"] = 
        {
            skill_number = 1,
            mini_icon = "impale_3",
            skill_icon = "impale",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            spell = {8, 15},
            damage = {25, 40},
            duration = 5,
            interval = 1,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_nyx_impale_4"] = 
        {
            skill_number = 1,
            mini_icon = "impale_4",
            skill_icon = "impale",
            rarity = "purple",

            cast = -0.2,
            damage_reduce = -40,
            duration = 4,
            cd_items = -0.8,
        },
        ["modifier_nyx_impale_7"] = 
        {
            skill_number = 1,
            mini_icon = "impale",
            skill_icon = "impale",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            talent_cd = 3,
            delay = 0.5,
            radius = 240,
            damage = 50,
            slow = -100,
            slow_duration = 1.5,
            max = 3,
            stack_duration = 14,
            stun = 0.2,
            stun_full = 2,
            damage_inc = 50,
            effect_duration = 7,
            skill_name = "nyx_assassin_impale_custom",
            trigger_ability = "nyx_assassin_impale_custom_legendary",
        },


        ["modifier_nyx_mind_1"] = 
        {
            skill_number = 2,
            mini_icon = "mind_1",
            skill_icon = "mind",
            rarity = "blue",

            damage = {16, 24, 32},
        },
        ["modifier_nyx_mind_2"] = 
        {
            skill_number = 2,
            mini_icon = "mind_2",
            skill_icon = "mind",
            rarity = "blue",

            range = {120, 180, 240},
            slow = {-20, -30, -40},
            duration = 4,
            is_purgable_self = 1,
        },
        ["modifier_nyx_mind_3"] = 
        {
            skill_number = 2,
            mini_icon = "mind_3",
            skill_icon = "mind",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal = {30, 50},
            cd = {-35, -60},
        },
        ["modifier_nyx_mind_4"] = 
        {
            skill_number = 2,
            mini_icon = "mind_4",
            skill_icon = "mind",
            rarity = "purple",
            has_video = 1,

            thresh = 50,
            mana = 20,
            silence = 2,
            speed = -180,
            talent_cd = 6,
            is_purgable_self = 1,
        },
        ["modifier_nyx_mind_7"] = 
        {
            skill_number = 2,
            mini_icon = "mind",
            skill_icon = "mind",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
    
            damage_min = 10,
            damage_max = 40,
            mana_damage = 70,
            mana = 30,
            duration = 3,
            cd_inc = -50,
            cd = 3,
            damage_type = DAMAGE_TYPE_MAGICAL, 
            skill_name = "nyx_assassin_jolt_custom",
        },

        ["modifier_nyx_carapace_1"] = 
        {
            skill_number = 3,
            mini_icon = "carapace_1",
            skill_icon = "carapace",
            rarity = "blue",

            agi = {10, 15, 20},
            max = 4,
            duration = 10,
        },
        ["modifier_nyx_carapace_2"] = 
        {
            skill_number = 3,
            mini_icon = "carapace_2",
            skill_icon = "carapace",
            rarity = "blue",

            heal = {10, 15, 20},
            bonus = 3,
            duration = 4,
        },
        ["modifier_nyx_carapace_3"] = 
        {
            skill_number = 3,
            mini_icon = "carapace_3",
            skill_icon = "carapace",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            health = {-1.5, -2.5},
            max = 10,
            cd = {2.5, 1.5},
            radius = 500,
            duration = 10,
        },
        ["modifier_nyx_carapace_4"] = 
        {
            skill_number = 3,
            mini_icon = "carapace_4",
            skill_icon = "carapace",
            rarity = "purple",
            has_video = 1,

            duration = 0.5,
            damage_reduce = -70,
        },
        ["modifier_nyx_carapace_7"] = 
        {
            skill_number = 3,
            mini_icon = "carapace",
            skill_icon = "carapace",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
     
            duration = 5,
            bva = 1.2,
            damage = 120,
            health = 16,
            creeps = 3,
            cd_inc = -50,
            damage_type = DAMAGE_TYPE_MAGICAL,
            skill_name = "nyx_assassin_spiked_carapace_custom",
        },

        ["modifier_nyx_vendetta_1"] = 
        {
            skill_number = 4,
            mini_icon = "vendetta_1",
            skill_icon = "vendetta",
            rarity = "blue",

            damage = {16, 24, 32},
            speed = {16, 24, 32},
            bonus = 2,
            duration = 5,
        },
        ["modifier_nyx_vendetta_2"] = 
        {
            skill_number = 4,
            mini_icon = "vendetta_2",
            skill_icon = "vendetta",
            rarity = "blue",

            heal_reduce = {-10, -15, -20},
            slow = {-10, -15, -20},
            bonus = 2,
            duration = 5,
            slow_duration = 3,
            is_through_bkb = 1,
        },
        ["modifier_nyx_vendetta_3"] = 
        {
            skill_number = 4,
            mini_icon = "vendetta_3",
            skill_icon = "vendetta",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            duration = 6,
            damage = {30, 50},
            cd = {-6, -10},
            cd_legendary = {-0.6, -1},
            bva = 1,
            alt_talent = "modifier_nyx_vendetta_7",
        },
        ["modifier_nyx_vendetta_4"] = 
        {
            skill_number = 4,
            mini_icon = "vendetta_4",
            skill_icon = "vendetta",
            rarity = "purple",
            has_video = 1,

            chance = 25,
            stun = 1,
            range = 100,
            talent_cd = 3,
            is_through_bkb = 1,
            is_basher = 1,
        },
        ["modifier_nyx_vendetta_7"] = 
        {
            skill_number = 4,
            mini_icon = "vendetta",
            skill_icon = "vendetta",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
        
            cd = 3.5,
            bva = 0.3,
            attacks = 2,
            armor = -6,
            heal = 125,
            duration = 15,
            linger = 6,
            cleave = 40,
            damage = 10,
            break_duration = 2,
            is_through_bkb = 1,
            skill_name = "nyx_assassin_vendetta_custom",
        },
    },

    npc_dota_hero_broodmother = 
    {
        ["modifier_broodmother_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            move = {8, 12, 16},
            slow = {-10, -15, -20},
            radius = 900,
        },
        ["modifier_broodmother_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            armor = {4, 6, 8},
            magic = {6, 9, 12},
            bonus = 2,
            health = 50,
        },
        ["modifier_broodmother_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            str = {8, 12, 16},
            health = {30, 45, 60},
        },

        ["modifier_broodmother_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",

            resist = 30,
            max = 8,
            radius = 3000,
        },
        ["modifier_broodmother_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            heal = 20,
            shield = 20,
            duration = 12,
        },
        ["modifier_broodmother_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            max_move = 50,
            max_move_real = 600,
            distance = 600,
            damage = 75,
            chance = 50,
            range = 800,
            duration = 10,
        },

        ["modifier_broodmother_insatiable_1"] = 
        {
            skill_number = 1,
            mini_icon = "insatiable_1",
            skill_icon = "insatiable",
            rarity = "blue",

            damage = {20, 30, 40},
            damage_inc = {30, 45, 60},
            damage_aura = {4, 6, 8},
            radius = 800,
            alt_talent = "modifier_broodmother_insatiable_7"
        },
        ["modifier_broodmother_insatiable_2"] = 
        {
            skill_number = 1,
            mini_icon = "insatiable_2",
            skill_icon = "insatiable",
            rarity = "blue",

            cd = {-2, -3, -4},
            duration = {2, 3, 4},
            duration_legendary = {1, 1.5, 2},
            alt_talent = "modifier_broodmother_insatiable_7"   
        },
        ["modifier_broodmother_insatiable_3"] = 
        {
            skill_number = 1,
            mini_icon = "insatiable_3",
            skill_icon = "insatiable",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            agi = {12, 20},
            cd = 3,
            duration = 3,
            bva = {-20, -35},
            radius = 800,
        },
        ["modifier_broodmother_insatiable_4"] = 
        {
            skill_number = 1,
            mini_icon = "insatiable_4",
            skill_icon = "insatiable",
            rarity = "purple",
            has_video = 1,

            status = 20,
            health = 50,
            talent_cd = 8,
            bkb = 2.5,
        },
        ["modifier_broodmother_insatiable_7"] = 
        {
            skill_number = 1,
            mini_icon = "insatiable",
            skill_icon = "insatiable",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
     
            duration = 3,
            damage_inc = 3,
            range = 750,
            speed = 1000,
            max_range = 1400,
            max = 40,
            heal_reduce = -25,
            skill_name = "broodmother_insatiable_hunger_custom",
        },


        ["modifier_broodmother_web_1"] = 
        {
            skill_number = 2,
            mini_icon = "web_1",
            skill_icon = "web",
            rarity = "blue",

            base = {16, 24, 32},
            damage = {1.6, 2.4, 3.2},
        },
        ["modifier_broodmother_web_2"] = 
        {
            skill_number = 2,
            mini_icon = "web_2",
            skill_icon = "web",
            rarity = "blue",

            heal_reduce = {-12, -18, -24},
            heal = {12, 18, 24},
            radius = 900,
        },
        ["modifier_broodmother_web_3"] = 
        {
            skill_number = 2,
            mini_icon = "web_3",
            skill_icon = "web",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {2.5, 4},
            base = {30, 50},
            duration = 8,
            max = 5,
            heal = 70,
            interval = 1,
            radius = 900,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_broodmother_web_4"] = 
        {
            skill_number = 2,
            mini_icon = "web_4",
            skill_icon = "web",
            rarity = "purple",
            has_video = 1,

            talent_cd = 12,
            radius = 600,
            knock_duration = 0.2,
            silence = 3,
            slow = -50,
            knock_distance = 30,
            alt_talent = "modifier_broodmother_web_7",
            trigger_ability = "broodmother_spin_web_custom_legendary",
        },
        ["modifier_broodmother_web_7"] = 
        {
            skill_number = 2,
            mini_icon = "web",
            skill_icon = "web",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            delay = 1,
            stun = 1,
            max_range = 1800,
            duration = 3,
            talent_cd = 5,
            speed = 2500,
            range = 900,
            health = 10,
            max = 5,
            effect_duration = 15,
            count = 2,
            is_root_disabled = 1,
            skill_name = "broodmother_spin_web_custom",
            trigger_ability = "broodmother_spin_web_custom_legendary",
        },

        ["modifier_broodmother_bite_1"] = 
        {
            skill_number = 3,
            mini_icon = "bite_1",
            skill_icon = "bite",
            rarity = "blue",

            speed = {40, 60, 80},
        },
        ["modifier_broodmother_bite_2"] = 
        {
            skill_number = 3,
            mini_icon = "bite_2",
            skill_icon = "bite",
            rarity = "blue",

            range = {40, 60, 80},
            damage_reduce = {-12, -18, -24},
        },
        ["modifier_broodmother_bite_3"] = 
        {
            skill_number = 3,
            mini_icon = "bite_3",
            skill_icon = "bite",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            armor = {-9, -16},
            max = 8,
            chance = 30,
            crit = {140, 180},
            duration = 5,
        },
        ["modifier_broodmother_bite_4"] = 
        {
            skill_number = 3,
            mini_icon = "bite_4",
            skill_icon = "bite",
            rarity = "purple",
            has_video = 1,

            chance = 8,
            chance_hero = 20, 
            stun = 1,
            talent_cd = 3,
            is_through_bkb = 1,
            is_basher = 1,
        },
        ["modifier_broodmother_bite_7"] = 
        {
            skill_number = 3,
            mini_icon = "bite",
            skill_icon = "bite",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
     
            max = 8,
            duration = 8,
            linger = 5,
            stun = 1.2,
            damage = 100,
            spider = 70,
            talent_cd = 2,
            is_through_bkb = 1,
            skill_name = "broodmother_incapacitating_bite_custom",
        },

        ["modifier_broodmother_spawn_1"] = 
        {
            skill_number = 4,
            mini_icon = "spawn_1",
            skill_icon = "spawn",
            rarity = "blue",

            spell = {8, 12, 16},
            damage = {100, 150, 200},
        },
        ["modifier_broodmother_spawn_2"] = 
        {
            skill_number = 4,
            mini_icon = "spawn_2",
            skill_icon = "spawn",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            range = {100, 150, 200},
        },
        ["modifier_broodmother_spawn_3"] = 
        {
            skill_number = 4,
            mini_icon = "spawn_3",
            skill_icon = "spawn",
            rarity = "purple",
            main_epic = 1,

            cd = {-0.4, -0.8},
            magic = {-25, -40},
            max = 5,
            duration = 8,
        },
        ["modifier_broodmother_spawn_4"] = 
        {
            skill_number = 4,
            mini_icon = "spawn_4",
            skill_icon = "spawn",
            rarity = "purple",

            cdr = 15,
            mana = 30,
            cd_items = -0.8,
        },
        ["modifier_broodmother_spawn_7"] = 
        {
            skill_number = 4,
            mini_icon = "spawn",
            skill_icon = "spawn",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            cd = -30,
            damage = 70,
            count = 1,
            duration = 12,
            max = 6,
            interval = 0.1,
            skill_name = "broodmother_spawn_spiderlings_custom",
        },
    },

    npc_dota_hero_night_stalker = 
    {
        ["modifier_stalker_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            cdr = {6, 9, 12},
            mana = {1, 1.5, 2},
        },
        ["modifier_stalker_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            armor = {6, 9, 12},
            damage_reduce = {-10, -15, -20},
        },
        ["modifier_stalker_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            max_move = {580, 595, 610},
            max = {30, 45, 60},
            move = {8, 12, 16},
        },

        ["modifier_stalker_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",

            duration = 3,
            move = 15,
            slow_resist = 50,
            stun = 1.2,
            talent_cd = 8,
        },
        ["modifier_stalker_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            magic = 15,
            health = 30,
            radius = 800,
            blind = 2,
            duration = 4,
            talent_cd = 20,
            is_breakable = 1,
        },
        ["modifier_stalker_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            has_video = 1,

            status = 20,
            shield = 20, 
            base = 200,
            shield_heal = 25,
        },

        ["modifier_stalker_void_1"] = 
        {
            skill_number = 1,
            mini_icon = "void_1",
            skill_icon = "void",
            rarity = "blue",

            spell = {6, 9, 12},
            damage = {4, 6, 8},
            creeps = {80, 120, 160},
        },
        ["modifier_stalker_void_2"] = 
        {
            skill_number = 1,
            mini_icon = "void_2",
            skill_icon = "void",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            range = {100, 150, 200},
        },
        ["modifier_stalker_void_3"] = 
        {
            skill_number = 1,
            mini_icon = "void_3",
            skill_icon = "void",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {20, 35},
            magic = {-20, -35},
            health = 50,
            radius = 900,
            cd = 2,
            duration = 12,
            damage_type = DAMAGE_TYPE_MAGICAL,
        },
        ["modifier_stalker_void_4"] = 
        {
            skill_number = 1,
            mini_icon = "void_4",
            skill_icon = "void",
            rarity = "purple",

            cast = -0.2,
            cd_items = -1,
            cd_items_fear = -0.4,
            cd_legendary = -0.25,
        },
        ["modifier_stalker_void_7"] = 
        {
            skill_number = 1,
            mini_icon = "void",
            skill_icon = "void",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            cd = 1,
            damage = 250,
            cd_inc = -50,
            void_stack = 2,
            max = 6,
            damage_k = 1.5,
            spawn_radius = 350,
            effect_duration = 4,
            check_radius = 1000,
            duration_orb = 16,
            duration_orb_creeps = 5,
            radius = 125,
            talent_cd = 16,
            skill_name = "night_stalker_void_custom",
            trigger_ability = "night_stalker_void_custom_legendary",
            banned_talent = "modifier_stalker_dark_7",
        },


        ["modifier_stalker_fear_1"] = 
        {
            skill_number = 2,
            mini_icon = "fear_1",
            skill_icon = "fear",
            rarity = "blue",

            damage = {1.2, 1.8, 2.4},
            radius = {40, 60, 80},
        },
        ["modifier_stalker_fear_2"] = 
        {
            skill_number = 2,
            mini_icon = "fear_2",
            skill_icon = "fear",
            rarity = "blue",

            duration = {1, 1.5, 2},
            cd = {-2, -3, -4},
        },
        ["modifier_stalker_fear_3"] = 
        {
            skill_number = 2,
            mini_icon = "fear_3",
            skill_icon = "fear",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal = {15, 25},
            health = {3, 5},
            duration = 8,
            max = 8,
        },
        ["modifier_stalker_fear_4"] = 
        {
            skill_number = 2,
            mini_icon = "fear_4",
            skill_icon = "fear",
            rarity = "purple",
            has_video = 1,

            timer = 4,
            fear = 1.5,
            move = 150,
            turn_slow = -70,
            radius = 650,
            knock_distance = 100,
            knock_duration = 0.3,
        },
        ["modifier_stalker_fear_7"] = 
        {
            skill_number = 2,
            mini_icon = "fear",
            skill_icon = "fear",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
     
            cd = 1,
            cd_inc = 0.5,
            damage = 120,
            heal = 75,
            radius = 1000,
            speed = 1500,
            duration = 3,
            stun = 0.3,
            knock_distance = 300,
            skill_name = "night_stalker_crippling_fear_custom",
        },

        ["modifier_stalker_hunter_1"] = 
        {
            skill_number = 3,
            mini_icon = "hunter_1",
            skill_icon = "hunter",
            rarity = "blue",

            range = {40, 60, 80},
            speed = {30, 45, 60},
            damage = {30, 45, 60},
            alt_talent = "modifier_stalker_dark_7",
        },
        ["modifier_stalker_hunter_2"] = 
        {
            skill_number = 3,
            mini_icon = "hunter_2",
            skill_icon = "hunter",
            rarity = "blue",

            duration = {1, 1.5, 2},
            damage = {12, 18, 24},
        },
        ["modifier_stalker_hunter_3"] = 
        {
            skill_number = 3,
            mini_icon = "hunter_3",
            skill_icon = "hunter",
            rarity = "purple",
            main_epic = 1,

            chance = {20, 35},
            damage = {18, 30},
            double_damage = 50,
            max = 30,
            dark_max = 10,
            alt_talent = "modifier_stalker_dark_7",
        },
        ["modifier_stalker_hunter_4"] = 
        {
            skill_number = 3,
            mini_icon = "hunter_4",
            skill_icon = "hunter",
            rarity = "purple",
            has_video = 1,

            cd_inc = -0.5,
            legendary_cd = -5,
            distance = 450,
            talent_cd = 10,
            speed = 1600,
            is_root_disabled = 1,
            alt_talent = "modifier_stalker_dark_7",
        },
        ["modifier_stalker_hunter_7"] = 
        {
            skill_number = 3,
            mini_icon = "hunter",
            skill_icon = "hunter",
            rarity = "orange",
            has_video = 1,
            has_video = 1,
            complexity = 1,
     
            duration = 6,
            attacks = 6,
            blind_duration = 4,
            effect_duration = 6,
            bva = -0.3,
            stun = 1.5,
            range = 900,
            is_through_bkb = 1,
            skill_name = "night_stalker_midnight_feast_custom",
        },

        ["modifier_stalker_dark_1"] = 
        {
            skill_number = 4,
            mini_icon = "dark_1",
            skill_icon = "dark",
            rarity = "blue",
            has_video = 1,

            damage = {60, 90, 120},
            duration = 5,
            interval = 1,
            talent_cd = 6,
            cd_min = 1,
            damage_type = DAMAGE_TYPE_PHYSICAL,
        },
        ["modifier_stalker_dark_2"] = 
        {
            skill_number = 4,
            mini_icon = "dark_2",
            skill_icon = "dark",
            rarity = "blue",

            heal = {10, 15, 20},
            cd = {-6, -9, -12},
            bonus = 2,
        },
        ["modifier_stalker_dark_3"] = 
        {
            skill_number = 4,
            mini_icon = "dark_3",
            skill_icon = "dark",
            rarity = "purple",
            main_epic = 1,

            base = {-3, -5},
            heal_reduce = {-25, -40},
            armor = {-30, -50},
            max = 12,
            duration = 6,
        },
        ["modifier_stalker_dark_4"] = 
        {
            skill_number = 4,
            mini_icon = "dark_4",
            skill_icon = "dark",
            rarity = "purple",
            has_video = 1,

            duration = 0.5,
            duration_legendary = 3,
            bkb = 2,
            max = 15,
            talent_cd = 10,
            alt_talent = "modifier_stalker_dark_7",
        },
        ["modifier_stalker_dark_7"] = 
        {
            skill_number = 4,
            mini_icon = "dark",
            skill_icon = "dark",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            range = 1200,
            charge = 1,
            speed = 3000,
            damage = 160,
            width = 200,
            cd_inc = 1.5,
            talent_cd = 5,
            stun = 0.5,
            is_root_disabled = 1,
            is_through_bkb = 1,
            trigger_ability = "night_stalker_darkness_custom_legendary",
            skill_name = "night_stalker_darkness_custom",
            banned_talent = "modifier_stalker_void_7",
        },
    },

    npc_dota_hero_jakiro = 
    {
        ["modifier_jakiro_hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

            stun = {0.2, 0.3, 0.4},
            range = {100, 150, 200},
        },
        ["modifier_jakiro_hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

            base = {30, 45, 60},
            mana = {2, 3, 4},
            heal = {2, 3, 4},
            duration = 5,
        },
        ["modifier_jakiro_hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

            move = {30, 45, 60},
            status = {10, 15, 20},
        },

        ["modifier_jakiro_hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",
            has_video = 1,

            silence = 2.5,
            talent_cd = 10,
            is_purgable_self = 1,
        },
        ["modifier_jakiro_hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",
            has_video = 1,

            move = 20,
            slow_resist = 50,
            armor = 15,
            magic = 15,
            duration = 4,
        },
        ["modifier_jakiro_hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",
            skill_icon = "macropyre",

            cast = 30,
            duration = 1.5,
            max = 60,
            cdr = 16,
            is_perma = 1,
            mod_name = "modifier_jakiro_macropyre_custom_cdr",
        },

        ["modifier_jakiro_dual_1"] = 
        {
            skill_number = 1,
            mini_icon = "dual_1",
            skill_icon = "dual",
            rarity = "blue",

            damage = {20, 30, 40},
            spell = {4, 6, 8},
            damage_ice = 1.5,
        },
        ["modifier_jakiro_dual_2"] = 
        {
            skill_number = 1,
            mini_icon = "dual_2",
            skill_icon = "dual",
            rarity = "blue",

            cd = {-1, -1.5, -2},
            slow = {-10, -15, -20},
        },
        ["modifier_jakiro_dual_3"] = 
        {
            skill_number = 1,
            mini_icon = "dual_3",
            skill_icon = "dual",
            rarity = "purple",
            main_epic = 1,

            heal_reduce = {-20, -35},
            magic = {-30, -50},
            duration = 12,
            ice_duration = 3,
            effect_duration = 10,
        },
        ["modifier_jakiro_dual_4"] = 
        {
            skill_number = 1,
            mini_icon = "dual_4",
            skill_icon = "dual",
            rarity = "purple",

            duration = 1,
            cd_items = 40,
        },
        ["modifier_jakiro_dual_7"] = 
        {
            skill_number = 1,
            mini_icon = "dual",
            skill_icon = "dual",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            cd = -50,
            damage = 4,
            range = 15,
            max = 25,
            timer = 7,
            stack_max = 20,
            spell_timer = 12,
            mana = -50,
            speed = 30,
            skill_name = "jakiro_dual_breath_custom",
        },

        ["modifier_jakiro_path_1"] = 
        {
            skill_number = 2,
            mini_icon = "path_1",
            skill_icon = "path",
            rarity = "blue",

            range = {100, 150, 200},
            damage = {8, 12, 16},
            duration = 8,
            max = 4,
        },
        ["modifier_jakiro_path_2"] = 
        {
            skill_number = 2,
            mini_icon = "path_2",
            skill_icon = "path",
            rarity = "blue",

            armor = {-4, -6, -8},
            slow = {-20, -30, -40},
            duration = 5,
        },
        ["modifier_jakiro_path_3"] = 
        {
            skill_number = 2,
            mini_icon = "path_3",
            skill_icon = "path",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            damage = {50, 100},
            crit = {125, 140},
            max = 4,
            duration = 6,
            targets = 3,
            radius = 1000,
        },
        ["modifier_jakiro_path_4"] = 
        {
            skill_number = 2,
            mini_icon = "path_4",
            skill_icon = "path",
            rarity = "purple",
            has_video = 1,

            cast = -0.2,
            damage = 10,
            damage_inc = 5,
            cd_inc = -4,
            cd_inc_legendary = -12,
            alt_talent = "modifier_jakiro_path_7",
        },
        ["modifier_jakiro_path_7"] = 
        {
            skill_number = 2,
            mini_icon = "path",
            skill_icon = "path",
            rarity = "orange",
            has_video = 1,
            complexity = 2,
     
            damage = 35,
            max = 4,
            duration = 12,
            armor = -65,
            shield = 220,
            stun = 0.5,
            is_through_bkb = 1,
            range = 300,
            speed = 100,
            effect_duration = 4,
            radius = 1000,
            cleave = 75,
            shield_duration = 15,
            shield_duration_creeps = 8,
            cleave_radius = 250,
            skill_name = "jakiro_ice_path_custom",
        },

        ["modifier_jakiro_liquid_1"] = 
        {
            skill_number = 3,
            mini_icon = "liquid_1",
            skill_icon = "liquid",
            rarity = "blue",

            fire_damage = {10, 15, 20},
            frost_damage = {6, 9, 12},
        },
        ["modifier_jakiro_liquid_2"] = 
        {
            skill_number = 3,
            mini_icon = "liquid_2",
            skill_icon = "liquid",
            rarity = "blue",

            duration = {1, 1.5, 2},
            heal = {12, 18, 24},
        },
        ["modifier_jakiro_liquid_3"] = 
        {
            skill_number = 3,
            mini_icon = "liquid_3",
            skill_icon = "liquid",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            speed = {70, 120},
            stats = {25, 40},
            max = 10,
            duration = 10,
            duration_creeps = 5,
        },
        ["modifier_jakiro_liquid_4"] = 
        {
            skill_number = 3,
            mini_icon = "liquid_4",
            skill_icon = "liquid",
            rarity = "purple",
            has_video = 1,

            chance = 20,
            max = 3,
            damage = 50,
            speed = 300,
        },
        ["modifier_jakiro_liquid_7"] = 
        {
            skill_number = 3,
            mini_icon = "liquid",
            skill_icon = "liquid",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
     
            max = 3,
            damage_reduce = -25,
            duration = 12,
            delay = 0.2,
            damage = 60,
            effect_duration = 12,
            talent_cd = 6,
            range = 200,
            heal = 30,
            trigger_ability = "jakiro_liquid_fire_custom_legendary",
            skill_name = "jakiro_liquid_fire_custom",
        },

        ["modifier_jakiro_macropyre_1"] = 
        {
            skill_number = 4,
            mini_icon = "macropyre_1",
            skill_icon = "macropyre",
            rarity = "blue",

            spell = {4, 6, 8},
            damage = {1.6, 2.4, 3.2},
        },
        ["modifier_jakiro_macropyre_2"] = 
        {
            skill_number = 4,
            mini_icon = "macropyre_2",
            skill_icon = "macropyre",
            rarity = "blue",

            health = {1, 1.5, 2},
            cd = {-4, -6, -8},
        },
        ["modifier_jakiro_macropyre_3"] = 
        {
            skill_number = 4,
            mini_icon = "macropyre_3",
            skill_icon = "macropyre",
            rarity = "purple",
            main_epic = 1,
            has_video = 1,

            heal = {20, 35},
            damage = {80, 150},
            chance = 15,
            talent_cd = 1,
            slow = -100,
            slow_duration = 0.3,
        },
        ["modifier_jakiro_macropyre_4"] = 
        {
            skill_number = 4,
            mini_icon = "macropyre_4",
            skill_icon = "macropyre",
            rarity = "purple",
            has_video = 1,

            duration = 2,
            radius = 150,
            radius_legendary = 60,
            delay = 1,
            root = 2,
            talent_cd = 8,
            is_purgable_self = 1,
            alt_talent = "modifier_jakiro_macropyre_7",
        },
        ["modifier_jakiro_macropyre_7"] = 
        {
            skill_number = 4,
            mini_icon = "macropyre",
            skill_icon = "macropyre",
            rarity = "orange",
            has_video = 1,
            complexity = 1,
     
            charge = 3,
            duration = -50,
            effect_duration = 15,
            damage = 180,
            max = 20,
            stack_max = 8,
            range = 800,
            radius = 300,
            cd = -5,
            damage_k = 1.5,
            mana = -60,
            skill_name = "jakiro_macropyre_custom",
        },
    },
}





local template = 
{

    npc_dota_hero_ = 
    {
        ["modifier__hero_1"] = 
        {
            skill_number = 0,
            mini_icon = "hero_1",
            rarity = "blue",

        },
        ["modifier__hero_2"] = 
        {
            skill_number = 0,
            mini_icon = "hero_2",
            rarity = "blue",

        },
        ["modifier__hero_3"] = 
        {
            skill_number = 0,
            mini_icon = "hero_3",
            rarity = "blue",

        },


        ["modifier__hero_4"] = 
        {
            skill_number = 0,
            mini_icon = "hero_4",
            rarity = "purple",

        },
        ["modifier__hero_5"] = 
        {
            skill_number = 0,
            mini_icon = "hero_5",
            rarity = "purple",

        },
        ["modifier__hero_6"] = 
        {
            skill_number = 0,
            mini_icon = "hero_6",
            rarity = "purple",

        },

        ["modifier___1"] = 
        {
            skill_number = 1,
            mini_icon = "_1",
            skill_icon = "",
            rarity = "blue",

        },
        ["modifier___2"] = 
        {
            skill_number = 1,
            mini_icon = "_2",
            skill_icon = "",
            rarity = "blue",

        },
        ["modifier___3"] = 
        {
            skill_number = 1,
            mini_icon = "_3",
            skill_icon = "",
            rarity = "purple",
            main_epic = 1,

        },
        ["modifier___4"] = 
        {
            skill_number = 1,
            mini_icon = "_4",
            skill_icon = "",
            rarity = "purple",

        },
        ["modifier___7"] = 
        {
            skill_number = 1,
            mini_icon = "",
            skill_icon = "",
            rarity = "orange",
            has_video = 1,
     
            skill_name = "",
        },


        ["modifier___1"] = 
        {
            skill_number = 2,
            mini_icon = "_1",
            skill_icon = "",
            rarity = "blue",

        },
        ["modifier___2"] = 
        {
            skill_number = 2,
            mini_icon = "_2",
            skill_icon = "",
            rarity = "blue",

        },
        ["modifier___3"] = 
        {
            skill_number = 2,
            mini_icon = "_3",
            skill_icon = "",
            rarity = "purple",
            main_epic = 1,

        },
        ["modifier___4"] = 
        {
            skill_number = 2,
            mini_icon = "_4",
            skill_icon = "",
            rarity = "purple",

        },
        ["modifier___7"] = 
        {
            skill_number = 2,
            mini_icon = "",
            skill_icon = "",
            rarity = "orange",
            has_video = 1,
     
            skill_name = "",
        },

        ["modifier___1"] = 
        {
            skill_number = 3,
            mini_icon = "_1",
            skill_icon = "",
            rarity = "blue",

        },
        ["modifier___2"] = 
        {
            skill_number = 3,
            mini_icon = "_2",
            skill_icon = "",
            rarity = "blue",

        },
        ["modifier___3"] = 
        {
            skill_number = 3,
            mini_icon = "_3",
            skill_icon = "",
            rarity = "purple",
            main_epic = 1,

        },
        ["modifier___4"] = 
        {
            skill_number = 3,
            mini_icon = "_4",
            skill_icon = "",
            rarity = "purple",

        },
        ["modifier___7"] = 
        {
            skill_number = 3,
            mini_icon = "",
            skill_icon = "",
            rarity = "orange",
            has_video = 1,
     
            skill_name = "",
        },

        ["modifier___1"] = 
        {
            skill_number = 4,
            mini_icon = "_1",
            skill_icon = "",
            rarity = "blue",

        },
        ["modifier___2"] = 
        {
            skill_number = 4,
            mini_icon = "_2",
            skill_icon = "",
            rarity = "blue",

        },
        ["modifier___3"] = 
        {
            skill_number = 4,
            mini_icon = "_3",
            skill_icon = "",
            rarity = "purple",
            main_epic = 1,

        },
        ["modifier___4"] = 
        {
            skill_number = 4,
            mini_icon = "_4",
            skill_icon = "",
            rarity = "purple",

        },
        ["modifier___7"] = 
        {
            skill_number = 4,
            mini_icon = "",
            skill_icon = "",
            rarity = "orange",
            has_video = 1,
     
            skill_name = "",
        },
    }
}

if test_skill then
    local data = global_values[hero_name]

    if not data then return end
    local array = 
    {
        [0] = "h",
        [1] = "q",
        [2] = "w",
        [3] = "e",
        [4] = "r",
        [5] = "s",
    }
    local ignore =
    {
        ["skill_number"] = true,
        ["mini_icon"] = true,
        ["rarity"] = true,
        ["has_video"] = true,
        ["complexity"] = true,
        ["skill_icon"] = true,
        ["skill_name"] = true,
        ["is_through_bkb"] = true,
        ["is_perma"] = true,
        ["is_purgable_self"] = true,
        ["is_purgable"] = true,
        ["is_root_disabled"] = true,
        ["is_blockable"] = true,
        ["mod_name"] = true,
        ["trigger_ability"] = true,
        ["main_epic"] = true,
        ["alt_talent"] = true,
        ["max_level"] = true,
        ["is_basher"] = true,
        ["is_breakable"] = true,
        ["update_mod"] = true,
        ["allow_illusion"] = true,
        ["banned_talent"] = true,
        ["alt_talent2"] = true,
        ["skill_change"] = true,
    }

    print(string.rep(" ", 1*2).."{")

    local print_skill = function(name, i)
        local talent_name = name..i
        if data[talent_name] then
            local skill_number = data[talent_name]["skill_number"]
            print(string.rep(" ", 1*4).."has_"..array[skill_number]..i.." = 0,")
            for param_name, param_data in pairs(data[talent_name]) do 
                if not ignore[param_name] then
                    if type(param_data) == "table" then
                        local result = array[skill_number]..i.."_"..param_name.." = 0,"
                        print(string.rep(" ", 1*4)..result)
                    end
                end
            end
            for param_name, param_data in pairs(data[talent_name]) do 
                if not ignore[param_name] then
                    if type(param_data) ~= "table" then
                        local result = array[skill_number]..i.."_"..param_name..' = caster:GetTalentValue("'..talent_name..'", "'..param_name..'", true),'
                        print(string.rep(" ", 1*4)..result)
                    end
                end
            end
            print(string.rep(" ", 1*4))
        end
    end

    local print_skill_2 = function(name, i)
        local talent_name = name..i
        if data[talent_name] then
            local skill_number = data[talent_name]["skill_number"]
            print()
            print('if caster:HasTalent("'..talent_name..'") then')
            print(string.rep(" ", 1*2).."self.talents.has_"..array[skill_number]..i.." = 1")
            for param_name, param_data in pairs(data[talent_name]) do 
                if not ignore[param_name] then
                    if type(param_data) == "table" then
                        local result = 'self.talents.'..array[skill_number]..i..'_'..param_name..' = caster:GetTalentValue("'..talent_name..'", "'..param_name..'")'
                        print(string.rep(" ", 1*2)..result)
                    end
                end
            end
            print("end")
        end
    end

    for i = 1,9 do
       print_skill(test_skill, i)
    end
    if more_test_skills then
        for _,name in pairs(more_test_skills) do
            print_skill(name:sub(1, -2), name:sub(-1))
        end
    end
    print(string.rep(" ", 1*2).."}")
    print("end")

    for i = 1,9 do
        print_skill_2(test_skill, i)
    end
    if more_test_skills then
        for _,name in pairs(more_test_skills) do
            print_skill_2(name:sub(1, -2), name:sub(-1))
        end
    end
    print()
    print("end")
    return
end

if client_id then
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(client_id) , "SendTalents", global_values)
end


if hero_name then
    local search_table = {}
    if type(hero_name) == "table" then
        search_table = hero_name
    else
        search_table[1] = hero_name
        if hero_name == "npc_dota_hero_broodmother" then
            search_table[2] = "broodmother_spiders"
        end
        if hero_name == "npc_dota_hero_invoker" then
            search_table[2] = "invoker_spells"
        end
        if hero_name == "npc_dota_hero_muerta" then
            search_table[2] = "muerta_quest"
        end
    end

    for _,name in pairs(search_table) do
        for table_name, table_data in pairs(global_values) do
            if table_name == name then

                if name == "general" or name == "broodmother_spiders" then
                    if not talents_icons["general"] then
                        talents_icons["general"] = {}
                    end
                    for talent_name,talent in pairs(table_data) do
                        if talent["damage_info"] then
                            talents_icons["general"][talent_name] = {}
                            talents_icons["general"][talent_name].icon = "general/" .. talent["skill_icon"]
                            if name == "broodmother_spiders" then
                                talents_icons["general"][talent_name].icon = "npc_dota_hero_broodmother/" .. talent["mini_icon"]
                            end
                            talents_icons["general"][talent_name].color = talent["rarity"]
                        end
                    end 
                end

                for talent_name,talent_data in pairs(table_data) do
                    if talent_data["is_perma"] == 1 and talent_data["mod_name"] then
                        perma_mods[talent_data["mod_name"]] = true
                    end
                    talents_heroes[talent_name] = name
                end
                ingame_talents[table_name] = table_data
                break
            end
        end
    end

end

end



talents_values:SendTalents(nil, {"general", "patrol", "alchemist_items"})

if test then
    --"printtest"
    talents_values:SendTalents(nil, "npc_dota_hero_ogre_magi", "modifier_ogremagi_multi_", {"modifier_ogremagi_hero_4"})
end
