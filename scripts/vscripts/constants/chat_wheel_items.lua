--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Перезарядка одного заряда
CHAT_WHEEL_COOLDOWN = 30

-- Максимум зарядов одновременно у игрока
CHAT_WHEEL_MAX_BEFORE_COOLDOWN = 2

--Список всех объектов доступных для использования в чате
CHAT_WHEEL_LIST = {
    -- Аудио [ENGLISH] (100 монет)
    wheel_1 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_1", -- Muda muda muda
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_2 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_2", -- The next level play
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_3 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_3", -- To be continued
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_4 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_4", -- Absolutely perfect
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_5 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_5", -- Nothing that can stop this man
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_6 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_6", -- Ah Crap
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_7 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_7", -- Airhorn
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_8 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_8", -- Damn son
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_9 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_9", -- Normalin normalin
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_10 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_10", -- [DART]Noooooooooooooo
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_11 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_11", -- English mother******
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_12 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_12", -- Easy game
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_13 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_13", -- GTA wasted
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_14 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_14", -- FBI open
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_15 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.ENGLISH,

        Sound = "item_wheel_15", -- Get some help
        free = false,
        buyable = true,
        cost = 100,
    },
    -- Текстовые [ENGLISH] (бесплатные)
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

    -- Аудио [RUSSIAN] (100 монет)
    wheel_1000 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1000",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1001 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1001",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1002 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1002",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1003 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1003",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1004 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1004",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1005 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1005",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1006 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1006",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1007 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1007",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1008 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1008",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1009 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1009",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1010 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1010",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1011 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1011",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1012 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1012",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1013 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1013",
        free = false,
        buyable = true,
        cost = 100,
    },
    wheel_1014 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1014",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1015 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1015",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1016 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1016",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1017 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1017",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1018 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1018",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1019 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1019",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1020 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1020",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1021 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1021",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1022 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1022",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1023 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1023",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1024 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1024",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1025 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1025",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1026 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1026",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1027 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1027",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1028 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1028",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },
    wheel_1029 = {
        Type = CHAT_WHEEL_TYPES.SOUND,
        Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

        Sound = "item_wheel_1029",
        free = false,
        buyable = true,
        cost = 100,
        is_new = true,
    },

    -- Общие звуковые (50 монет)
    -- [перенесены из RU в общую группу: бывш. 1027/1030 -> 2000/2001 (языконезависимые)]
    wheel_2000 = {
        Type = CHAT_WHEEL_TYPES.SOUND,

        Sound = "item_wheel_2000",
        free = false,
        buyable = true,
        cost = 50,
    },
    wheel_2001 = {
        Type = CHAT_WHEEL_TYPES.SOUND,

        Sound = "item_wheel_2001",
        free = false,
        buyable = true,
        cost = 50,
    },
    glados_win_99 = {
        Type = CHAT_WHEEL_TYPES.SOUND,

        Sound = "soundboard.glados.probability_99",
        free = false,
        buyable = true,
        cost = 50,
    },
    glados_win_1 = {
        Type = CHAT_WHEEL_TYPES.SOUND,

        Sound = "soundboard.glados.probability_1",
        free = false,
        buyable = true,
        cost = 50,
    },
    you_have_failed_me = {
        Type = CHAT_WHEEL_TYPES.SOUND,

        Sound = "soundboard.ddb_you_have_failed_me",
        free = false,
        buyable = true,
        cost = 50,
    },
    do_you_love_me = {
        Type = CHAT_WHEEL_TYPES.SOUND,

        Sound = "soundboard.ddb_do_you_love_me",
        free = false,
        buyable = true,
        cost = 50,
    },
    for_eternity = {
        Type = CHAT_WHEEL_TYPES.SOUND,

        Sound = "soundboard.ddb_for_eternity",
        free = false,
        buyable = true,
        cost = 50,
    },
    run_little_mouse = {
        Type = CHAT_WHEEL_TYPES.SOUND,

        Sound = "soundboard.ddb_run_little_mouse",
        free = false,
        buyable = true,
        cost = 50,
    },
    very_wise = {
        Type = CHAT_WHEEL_TYPES.SOUND,

        Sound = "soundboard.ddb_very_wise",
        free = false,
        buyable = true,
        cost = 50,
    },

    -- Общие текстовые (50 монет)
    zxc = {
        Type = CHAT_WHEEL_TYPES.TEXT,

        free = false,
        buyable = true,
        cost = 50,
    },

}