--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Список предметов
ITEMS_LIST = {
    halloween_pumpkin = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_effect.vpcf",

        --Для правильного положения партикла (FX)
        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_effect.vpcf",

        buyable = true, -- Можно ли купить
        cost = 500, -- Сколько стоит
    },
    halloween_pumpkin_2 = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v1_effect.vpcf",

        --Для правильного положения партикла (FX)
        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v1_effect.vpcf",

        buyable = true, -- Можно ли купить
        cost = 500, -- Сколько стоит
    },
    halloween_pumpkin_3 = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v2_effect.vpcf",

        --Для правильного положения партикла (FX)
        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v2_effect.vpcf",

        buyable = true, -- Можно ли купить
        cost = 500, -- Сколько стоит
    },
    halloween_pumpkin_4 = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v3_effect.vpcf",

        --Для правильного положения партикла (FX)
        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v3_effect.vpcf",

        buyable = true, -- Можно ли купить
        cost = 500, -- Сколько стоит
    },
    ti10_aegis = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/ti10/emblem/ti10_emblem_effect.vpcf",

        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/ti10/emblem/ti10_emblem_effect.vpcf",

        buyable = true,
        cost = 500,
    },
    ti9_emblem = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/ti9/ti9_emblem_effect.vpcf",

        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/ti9/ti9_emblem_effect.vpcf",

        buyable = true,
        cost = 500,
    },
    summer_2021_emblem = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/summer_2021/summer_2021_emblem_effect.vpcf",

        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/summer_2021/summer_2021_emblem_effect.vpcf",

        buyable = true,
        cost = 500,
    },
    fall_2021_emblem = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/fall_2021/fall_2021_emblem_game_effect.vpcf",

        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/fall_2021/fall_2021_emblem_game_effect.vpcf",

        buyable = true,
        cost = 500,
    },
    fall_2022_emblem = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/fall_2022/player/fall_2022_emblem_effect_player_base.vpcf",

        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/fall_2022/player/fall_2022_emblem_effect_player_base.vpcf",

        buyable = true,
        cost = 500,
    },
    ti8_emblem = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/ti8/ti8_hero_effect.vpcf",

        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/ti8/ti8_hero_effect.vpcf",

        buyable = true,
        cost = 500,
    },
    desolation_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_desolator.vpcf",

        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_desolator.vpcf",

        buyable = true,
        cost = 300,
    },
    fire_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/units/heroes/hero_phoenix/phoenix_base_attack.vpcf",

        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/units/heroes/hero_phoenix/phoenix_base_attack.vpcf",

        buyable = true,
        cost = 300,
    },
    ice_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/items2_fx/skadi_projectile.vpcf",

        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/items2_fx/skadi_projectile.vpcf",

        buyable = true,
        cost = 300,
    },
    poison_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/units/heroes/hero_viper/viper_base_attack.vpcf",

        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/units/heroes/hero_viper/viper_base_attack.vpcf",

        buyable = true,
        cost = 300,
    },
    lightning_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/units/heroes/hero_void_spirit/base_attack/void_spirit_base_attack.vpcf",

        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/units/heroes/hero_void_spirit/base_attack/void_spirit_base_attack.vpcf",

        buyable = true,
        cost = 300,
    },
    wind_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/units/heroes/hero_windrunner/windrunner_base_attack.vpcf",

        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/units/heroes/hero_windrunner/windrunner_base_attack.vpcf",

        buyable = true,
        cost = 300,
    },
    tower_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/world_tower/tower_upgrade/ti7_dire_tower_projectile.vpcf",

        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/world_tower/tower_upgrade/ti7_dire_tower_projectile.vpcf",

        buyable = true,
        cost = 300,
    },
    arcane_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/units/heroes/hero_enigma/enigma_base_attack.vpcf",

        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/units/heroes/hero_enigma/enigma_base_attack.vpcf",

        buyable = true,
        cost = 300,
    },
    storm_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack.vpcf",

        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack.vpcf",

        buyable = true,
        cost = 300,
    },
    chaos_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/units/heroes/hero_wisp/wisp_base_attack.vpcf",

        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/units/heroes/hero_wisp/wisp_base_attack.vpcf",

        buyable = true,
        cost = 300,
    },
    weather_rain = {
        slot_type = ITEMS_TYPES.WEATHER,
        slot_name = ITEMS_DEFAULT_SLOTS.WEATHER,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/rain_fx/econ_rain.vpcf",

        preview_params = {
            fov = "60",
            origin = "0 0 200",
            look_at = "0 0 0"
        },

        game_value = "particles/rain_fx/econ_rain.vpcf",

        buyable = true, -- Можно ли купить
        cost = 200, -- Сколько стоит
    },
    weather_snow = {
        slot_type = ITEMS_TYPES.WEATHER,
        slot_name = ITEMS_DEFAULT_SLOTS.WEATHER,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/rain_fx/econ_snow.vpcf",

        preview_params = {
            fov = "60",
            origin = "0 0 200",
            look_at = "0 0 0"
        },

        game_value = "particles/rain_fx/econ_snow.vpcf",

        buyable = true,
        cost = 200,
    },
    golden_icon = {
        slot_type = ITEMS_TYPES.ICONS,
        slot_name = ITEMS_DEFAULT_SLOTS.ICONS,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/ui/hero_icons/gold_icon.vpcf",

        --Для правильного положения партикла (FX)
        preview_params = {
            fov = "55",
            origin = "0 0 260",
            look_at = "0 0 0"
        },

        game_value = "particles/ui/hero_icons/gold_icon.vpcf",

        buyable = true, -- Можно ли купить
        cost = 100, -- Сколько стоит
    },
    rainbow_icon = {
        slot_type = ITEMS_TYPES.ICONS,
        slot_name = ITEMS_DEFAULT_SLOTS.ICONS,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/ui/hero_icons/rainbow_icon.vpcf",

        --Для правильного положения партикла (FX)
        preview_params = {
            fov = "55",
            origin = "0 0 260",
            look_at = "0 0 0"
        },

        game_value = "particles/ui/hero_icons/rainbow_icon.vpcf",

        buyable = true, -- Можно ли купить
        cost = 100, -- Сколько стоит
    },
    white_icon = {
        slot_type = ITEMS_TYPES.ICONS,
        slot_name = ITEMS_DEFAULT_SLOTS.ICONS,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/ui/hero_icons/white_icon.vpcf",

        --Для правильного положения партикла (FX)
        preview_params = {
            fov = "55",
            origin = "0 0 260",
            look_at = "0 0 0"
        },

        game_value = "particles/ui/hero_icons/white_icon.vpcf",

        buyable = true, -- Можно ли купить
        cost = 100, -- Сколько стоит
    },
    newbloom_icon = {
        slot_type = ITEMS_TYPES.ICONS,
        slot_name = ITEMS_DEFAULT_SLOTS.ICONS,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/cosmetic/auras/newbloom/newbloom.vpcf",

        preview_params = {
            fov = "55",
            origin = "0 0 260",
            look_at = "0 0 0"
        },

        game_value = "particles/cosmetic/auras/newbloom/newbloom.vpcf",

        buyable = true,
        cost = 100,
    },
    pet_pudge = {
        slot_type = ITEMS_TYPES.PET,
        slot_name = ITEMS_DEFAULT_SLOTS.PET,

        preview_type = ITEMS_PREVIEW_TYPES.SCENE,
        preview_value = "npc_dota_courier",

        game_value = "models/items/courier/baekho/baekho.vmdl", --Модель пета
        game_value_2 = 1, --Размер модели

        buyable = true, -- Можно ли купить
        cost = 50, -- Сколько стоит
    },
}