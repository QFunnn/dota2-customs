--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@enum ITEMS_PREVIEW_TYPES
ITEMS_PREVIEW_TYPES = {
    IMAGE = 1,      -- Картинка
    FX = 2,         -- Партикл
    SCENE = 3,      -- Сцена (в том числе юниты)
    VIDEO = 4,      -- Видео
    CHAT_WHEEL = 5, -- Фраза
}

---@enum ITEMS_DEFAULT_SLOTS
ITEMS_DEFAULT_SLOTS = {
    FX_HERO = "fx_hero",     -- Партиклы героев
    FX_ATTACK = "fx_attack", -- Партиклы атак
    TITLE = "title",         -- Банерв
}

---@enum ITEMS_TYPES
ITEMS_TYPES = {
    CHAT_WHEEL = 1, -- Фразы
    TITLE = 2,      -- Банеры
    FX_HERO = 3,    -- Партиклы героев
    FX_ATTACK = 4,  -- Партиклы атак
}

---@enum CHAT_WHEEL_TYPES
CHAT_WHEEL_TYPES = {
    TEXT = 1,
    SOUND = 2
}

---@enum CHAT_WHEEL_CATEGORY
CHAT_WHEEL_CATEGORY = {
    ALL = 0,
    RUSSIAN = 1,
    ENGLISH = 2,
}

---@class ChatWheelItemInfo
---@field Type CHAT_WHEEL_TYPES
---@field Category CHAT_WHEEL_CATEGORY
---@field Sound string | nil
---@field free boolean
---@field buyable boolean
---@field cost number | nil


---@type table<string, ChatWheelItemInfo>
CHAT_WHEEL_LIST = {
    wheel_1 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_1", -- Muda muda muda
        free = false,
        buyable = true,
        cost = 750,
    },
    wheel_2 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_2", -- The next level play
        free = true,
        buyable = false,
    },
    wheel_3 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_3",
        free = true,
        buyable = false,
    },
    wheel_4 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_4", -- Absolutely perfect
        free = true,
        buyable = false,
    },
    wheel_5 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_5", -- Nothing that can stop this man
        free = true,
        buyable = false,
    },
    wheel_6 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_6", -- Ah Crap
        free = false,
        buyable = true,
        cost = 500,
    },
    wheel_7 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_7", -- Airhorn
        free = false,
        buyable = true,
        cost = 500,
    },
    wheel_8 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_8", -- Damn son
        free = false,
        buyable = true,
        cost = 500
    },
    wheel_9 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_9", -- Normalin normalin
        free = true,
        buyable = false,
    },
    wheel_10 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_10", -- [DART]Noooooooooooooo
        free = false,
        buyable = true,
        cost = 500,
    },
    wheel_11 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_11", -- English mother******
        free = true,
        buyable = false,
    },
    wheel_12 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_12", -- Easy game
        free = false,
        buyable = true,
        cost = 500,
    },
    wheel_13 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_13", -- GTA wasted
        free = false,
        buyable = true,
        cost = 500,
    },
    wheel_14 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_14", -- FBI open
        free = false,
        buyable = true,
        cost = 500,
    },
    wheel_15 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_15", -- Get some help
        free = false,
        buyable = true,
        cost = 500,
    },
    boowomp = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "boowomp", -- Как пишется, так и слышится
        free = false,
        buyable = true,
        cost = 500
    },
    sponge_bob_fail = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "sponge_bob_fail", -- SpongeBob fail
        free = false,
        buyable = true,
        cost = 500
    },


    wheel_500 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_501 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_502 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_503 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_504 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
        cost = 75,
    },
    wheel_505 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_506 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_507 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_508 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_509 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_510 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_511 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_512 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_513 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_514 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },
    wheel_515 = {
        Type = CHAT_WHEEL_TYPES.TEXT,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        free = true,
        buyable = false,
    },


    wheel_1001 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1001", -- [Папаня] Лежать + сосать
        free = false,
        buyable = true,
        cost = 500
    },
    wheel_1002 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1002", -- [Папаня] Каааак, бл, кааак
        free = false,
        buyable = true,
        cost = 500
    },
    wheel_1003 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1003", -- Ебный рот этого казино
        free = false,
        buyable = true,
        cost = 750
    },
    wheel_1004 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1004", -- Ставлю душу своей матери
        free = false,
        buyable = true,
        cost = 750
    },
    wheel_1006 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1006", -- [Папаня] Боооомба
        free = false,
        buyable = true,
        cost = 500
    },
    wheel_1007 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1007", -- [Папаня] Ааааа, сейчас я вас буду резать
        free = false,
        buyable = true,
        cost = 500
    },
    wheel_1008 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1008", -- Отдайте мне мои деньги, я очень бедный
        free = false,
        buyable = true,
        cost = 550
    },
    wheel_1009 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1009", -- [Куплинов] Крыса тоже радуется, крысе радостно
        free = false,
        buyable = true,
        cost = 500
    },
    wheel_1010 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1010", -- Есть пробитие
        free = false,
        buyable = true,
        cost = 500
    },
    vse_zavali_ebalo = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "vse_zavali_ebalo",
        free = false,
        buyable = true,
        cost = 500
    },
    mel_blya_ebat_moi_hui = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "mel_blya_ebat_moi_hui",
        free = false,
        buyable = true,
        cost = 500
    },
    na_koleni_na_koleni = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "na_koleni_na_koleni",
        free = false,
        buyable = true,
        cost = 500
    },
    mel_na_mujika_ladno_pohui = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "mel_na_mujika_ladno_pohui",
        free = false,
        buyable = true,
        cost = 500
    },
    mel_eshe_posidim = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "mel_eshe_posidim",
        free = false,
        buyable = true,
        cost = 500
    },
    mel_poidet_shas_voznya = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "mel_poidet_shas_voznya",
        free = false,
        buyable = true,
        cost = 500
    },
    papich_da_eto_jestko = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "papich_da_eto_jestko",
        free = false,
        buyable = true,
        cost = 500
    },
    papich_kakoi_je_ti_debil = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "papich_kakoi_je_ti_debil",
        free = false,
        buyable = true,
        cost = 500
    },
    papich_legko_dlya_velikogo = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "papich_legko_dlya_velikogo",
        free = false,
        buyable = true,
        cost = 500
    },
    litvin_razjebu_kalitku = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "litvin_razjebu_kalitku",
        free = false,
        buyable = true,
        cost = 500
    },
    rentv_budem_zanimatsa_seksom = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "rentv_budem_zanimatsa_seksom",
        free = false,
        buyable = true,
        cost = 500
    },
    mel_skolko_nahui = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "mel_skolko_nahui",
        free = false,
        buyable = true,
        cost = 500
    },
    stop_mne_ne_priyatno = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "stop_mne_ne_priyatno",
        free = false,
        buyable = true,
        cost = 500
    },
    stary_bog_da_zavali = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "stary_bog_da_zavali",
        free = false,
        buyable = true,
        cost = 500
    },
    mel_ya_uje_krasni = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "mel_ya_uje_krasni",
        free = false,
        buyable = true,
        cost = 500
    },
    papich_kto_to_somnev_chto_ya = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "papich_kto_to_somnev_chto_ya",
        free = false,
        buyable = true,
        cost = 500
    },
    arj_ti_musor = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "arj_ti_musor",
        free = false,
        buyable = true,
        cost = 500
    },
    arj_dlya_sebya_vigral = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "arj_dlya_sebya_vigral",
        free = false,
        buyable = true,
        cost = 500
    },
    arj_u_vseh_lagaet = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "arj_u_vseh_lagaet",
        free = false,
        buyable = true,
        cost = 500
    },
    arj_chel_s_panelkoi = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "arj_chel_s_panelkoi",
        free = false,
        buyable = true,
        cost = 500
    },
    arj_daite_procent = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "arj_daite_procent",
        free = false,
        buyable = true,
        cost = 500
    },
    bb_domoi_volter = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "bb_domoi_volter",
        free = false,
        buyable = true,
        cost = 500
    },
    bot_otkis_malchik = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "bot_otkis_malchik",
        free = false,
        buyable = true,
        cost = 500
    },
    bot_zalagalo = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "bot_zalagalo",
        free = false,
        buyable = true,
        cost = 500
    },
    faaaah = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "faaaah",
        free = false,
        buyable = true,
        cost = 500
    },
    kisi_kisi_mya_mya = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "kisi_kisi_mya_mya",
        free = false,
        buyable = true,
        cost = 500
    },
    mel_idi_nah_dolbaeb = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "mel_idi_nah_dolbaeb",
        free = false,
        buyable = true,
        cost = 500
    },
    mib_mombo = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "mib_mombo",
        free = false,
        buyable = true,
        cost = 500
    },
    screenshot = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "screenshot",
        free = false,
        buyable = true,
        cost = 500
    },
    seychas_ya_vivalu_pencil = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "seychas_ya_vivalu_pencil",
        free = false,
        buyable = true,
        cost = 500
    },
    simple_timing = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "simple_timing",
        free = false,
        buyable = true,
        cost = 500
    },
    u_vas_pencil_skoro_otvalitsa = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "u_vas_pencil_skoro_otvalitsa",
        free = false,
        buyable = true,
        cost = 500
    },
    ww_bronya_ne_probita = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "ww_bronya_ne_probita",
        free = false,
        buyable = true,
        cost = 500
    },
    ww_ne_probil = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "ww_ne_probil",
        free = false,
        buyable = true,
        cost = 500
    },
    yandex_new_order = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "yandex_new_order",
        free = false,
        buyable = true,
        cost = 500
    },
}

---@class ItemInfo
---@field slot_type ITEMS_TYPES
---@field slot_name ITEMS_DEFAULT_SLOTS
---@field preview_type ITEMS_PREVIEW_TYPES
---@field preview_params ItemPreviewParams
---@field game_value string
---@field buyable boolean
---@field cost number | nil

---@class ItemPreviewParams
---@field fov string
---@field origin string
---@field look_at string

---@type table<string, ItemInfo>
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
        cost = 100,     -- Сколько стоит
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
        cost = 100,     -- Сколько стоит
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
        cost = 100,     -- Сколько стоит
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
        cost = 100,     -- Сколько стоит
    },
    summer_2021_emblem = {
        slot_type = ITEMS_TYPES.FX_HERO,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/events/summer_2021/summer_2021_emblem_effect.vpcf",

        --Для правильного положения партикла (FX)
        preview_params = {
            fov = "60",
            origin = "0 -250 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/events/summer_2021/summer_2021_emblem_effect.vpcf",

        buyable = true, -- Можно ли купить
        cost = 100,     -- Сколько стоит
    },
    desolation_attack = {
        slot_type = ITEMS_TYPES.FX_ATTACK,
        slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_desolator.vpcf",

        --Для правильного положения партикла (FX)
        preview_params = {
            fov = "40",
            origin = "0 0 225",
            look_at = "0 0 15"
        },

        game_value = "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_desolator.vpcf",

        buyable = false, -- Можно ли купить
        cost = 100,     -- Сколько стоит
    },
    moderator = {
        slot_type = ITEMS_TYPES.TITLE,
        slot_name = ITEMS_DEFAULT_SLOTS.TITLE,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/title/moderator/title_moderator.vpcf",

        preview_params = {
            fov = "55",
            origin = "0 -180 225",
            look_at = "0 0 120"
        },

        game_value = "particles/title/moderator/title_moderator.vpcf",

        buyable = false
    },
    moderator_v2 = {
        slot_type = ITEMS_TYPES.TITLE,
        slot_name = ITEMS_DEFAULT_SLOTS.TITLE,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/title/moderator_v2/title_moderator_v2.vpcf",

        preview_params = {
            fov = "55",
            origin = "0 -180 225",
            look_at = "0 0 120"
        },

        game_value = "particles/title/moderator_v2/title_moderator_v2.vpcf",

        buyable = false
    },
    moderator_v3 = {
        slot_type = ITEMS_TYPES.TITLE,
        slot_name = ITEMS_DEFAULT_SLOTS.TITLE,

        preview_type = ITEMS_PREVIEW_TYPES.FX,
        preview_value = "particles/title/moderator_v3/title_moderator_v3.vpcf",

        preview_params = {
            fov = "55",
            origin = "0 -180 225",
            look_at = "0 0 120"
        },

        game_value = "particles/title/moderator_v3/title_moderator_v3.vpcf",

        buyable = false
    },
}