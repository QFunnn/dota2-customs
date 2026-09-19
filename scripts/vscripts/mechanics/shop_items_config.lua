--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@enum ITEMS_PREVIEW_TYPES
ITEMS_PREVIEW_TYPES = {
	IMAGE = 1, -- Картинка
	FX = 2, -- Партикл
	SCENE = 3, -- Сцена (в том числе юниты)
	VIDEO = 4, -- Видео
	CHAT_WHEEL = 5, -- Фраза
}

---@enum ITEMS_DEFAULT_SLOTS
ITEMS_DEFAULT_SLOTS = {
	FX_HERO = "fx_hero", -- Партиклы героев
	FX_ATTACK = "fx_attack", -- Партиклы атак
	TITLE = "title", -- Банерв
}

---@enum ITEMS_TYPES
ITEMS_TYPES = {
	CHAT_WHEEL = 1, -- Фразы
	TITLE = 2, -- Банеры
	FX_HERO = 3, -- Партиклы героев
	FX_ATTACK = 4, -- Партиклы атак
}

---@enum CHAT_WHEEL_TYPES
CHAT_WHEEL_TYPES = {
	TEXT = 1,
	SOUND = 2,
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
		cost = 500,
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
		cost = 500,
	},
	sponge_bob_fail = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.ENGLISH,

		Sound = "sponge_bob_fail", -- SpongeBob fail
		free = false,
		buyable = true,
		cost = 500,
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
		cost = 1200,
	},
	wheel_1002 = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "item_wheel_1002", -- [Папаня] Каааак, бл, кааак
		free = false,
		buyable = true,
		cost = 1200,
	},
	wheel_1003 = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "item_wheel_1003", -- Ебный рот этого казино
		free = false,
		buyable = true,
		cost = 1400,
	},
	wheel_1004 = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "item_wheel_1004", -- Ставлю душу своей матери
		free = false,
		buyable = true,
		cost = 1500,
	},
	wheel_1006 = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "item_wheel_1006", -- [Папаня] Боооомба
		free = false,
		buyable = true,
		cost = 1500,
	},
	wheel_1007 = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "item_wheel_1007", -- [Папаня] Ааааа, сейчас я вас буду резать
		free = false,
		buyable = true,
		cost = 1200,
	},
	wheel_1008 = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "item_wheel_1008", -- Отдайте мне мои деньги, я очень бедный
		free = false,
		buyable = true,
		cost = 800,
	},
	wheel_1009 = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "item_wheel_1009", -- [Куплинов] Крыса тоже радуется, крысе радостно
		free = false,
		buyable = true,
		cost = 800,
	},
	wheel_1010 = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "item_wheel_1010", -- Есть пробитие
		free = false,
		buyable = true,
		cost = 1000,
	},
	vse_zavali_ebalo = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "vse_zavali_ebalo",
		free = false,
		buyable = true,
		cost = 1200,
	},
	mel_blya_ebat_moi_hui = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "mel_blya_ebat_moi_hui",
		free = false,
		buyable = true,
		cost = 1400,
	},
	na_koleni_na_koleni = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "na_koleni_na_koleni",
		free = false,
		buyable = true,
		cost = 1200,
	},
	mel_na_mujika_ladno_pohui = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "mel_na_mujika_ladno_pohui",
		free = false,
		buyable = true,
		cost = 1200,
	},
	mel_eshe_posidim = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "mel_eshe_posidim",
		free = false,
		buyable = true,
		cost = 1200,
	},
	mel_poidet_shas_voznya = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "mel_poidet_shas_voznya",
		free = false,
		buyable = true,
		cost = 1200,
	},
	papich_da_eto_jestko = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "papich_da_eto_jestko",
		free = false,
		buyable = true,
		cost = 1350,
	},
	papich_kakoi_je_ti_debil = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "papich_kakoi_je_ti_debil",
		free = false,
		buyable = true,
		cost = 1500,
	},
	papich_legko_dlya_velikogo = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "papich_legko_dlya_velikogo",
		free = false,
		buyable = true,
		cost = 500,
	},
	litvin_razjebu_kalitku = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "litvin_razjebu_kalitku",
		free = false,
		buyable = true,
		cost = 1750,
	},
	rentv_budem_zanimatsa_seksom = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "rentv_budem_zanimatsa_seksom",
		free = false,
		buyable = true,
		cost = 1200,
	},
	mel_skolko_nahui = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "mel_skolko_nahui",
		free = false,
		buyable = true,
		cost = 1200,
	},
	stop_mne_ne_priyatno = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "stop_mne_ne_priyatno",
		free = false,
		buyable = true,
		cost = 1250,
	},
	stary_bog_da_zavali = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "stary_bog_da_zavali",
		free = false,
		buyable = true,
		cost = 2000,
	},
	mel_ya_uje_krasni = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "mel_ya_uje_krasni",
		free = false,
		buyable = true,
		cost = 500,
	},
	papich_kto_to_somnev_chto_ya = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "papich_kto_to_somnev_chto_ya",
		free = false,
		buyable = true,
		cost = 500,
	},
	arj_ti_musor = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "arj_ti_musor",
		free = false,
		buyable = true,
		cost = 1800,
	},
	arj_dlya_sebya_vigral = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "arj_dlya_sebya_vigral",
		free = false,
		buyable = true,
		cost = 1800,
	},
	arj_u_vseh_lagaet = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "arj_u_vseh_lagaet",
		free = false,
		buyable = true,
		cost = 1800,
	},
	arj_chel_s_panelkoi = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "arj_chel_s_panelkoi",
		free = false,
		buyable = true,
		cost = 1800,
	},
	arj_daite_procent = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "arj_daite_procent",
		free = false,
		buyable = true,
		cost = 1800,
	},
	bb_domoi_volter = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "bb_domoi_volter",
		free = false,
		buyable = true,
		cost = 1200,
	},
	bot_otkis_malchik = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "bot_otkis_malchik",
		free = false,
		buyable = true,
		cost = 1000,
	},
	bot_zalagalo = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "bot_zalagalo",
		free = false,
		buyable = true,
		cost = 1000,
	},
	faaaah = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.ENGLISH,

		Sound = "faaaah",
		free = false,
		buyable = true,
		cost = 900,
	},
	kisi_kisi_mya_mya = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "kisi_kisi_mya_mya",
		free = false,
		buyable = true,
		cost = 12000,
	},
	mel_idi_nah_dolbaeb = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "mel_idi_nah_dolbaeb",
		free = false,
		buyable = true,
		cost = 500,
	},
	mib_mombo = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.ENGLISH,

		Sound = "mib_mombo",
		free = false,
		buyable = true,
		cost = 1000,
	},
	screenshot = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.ENGLISH,

		Sound = "screenshot",
		free = false,
		buyable = true,
		cost = 750,
	},
	seychas_ya_vivalu_pencil = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "seychas_ya_vivalu_pencil",
		free = false,
		buyable = true,
		cost = 1600,
	},
	simple_timing = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "simple_timing",
		free = false,
		buyable = true,
		cost = 2000,
	},
	u_vas_pencil_skoro_otvalitsa = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "u_vas_pencil_skoro_otvalitsa",
		free = false,
		buyable = true,
		cost = 1500,
	},
	ww_bronya_ne_probita = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "ww_bronya_ne_probita",
		free = false,
		buyable = true,
		cost = 800,
	},
	ww_ne_probil = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.RUSSIAN,

		Sound = "ww_ne_probil",
		free = false,
		buyable = true,
		cost = 800,
	},
	yandex_new_order = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.ENGLISH,

		Sound = "yandex_new_order",
		free = false,
		buyable = true,
		cost = 750,
	},
	perdesh = {
		Type = CHAT_WHEEL_TYPES.SOUND,
		Category = CHAT_WHEEL_CATEGORY.ENGLISH,

		Sound = "perdesh",
		free = false,
		buyable = true,
		cost = 900,
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
---@field dust_cost number | nil
---@field case_exclusive boolean | nil

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

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_effect.vpcf",

		buyable = false,
		dust_cost = 2000,
	},
	halloween_pumpkin_2 = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v1_effect.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v1_effect.vpcf",

		buyable = false,
		dust_cost = 2000,
	},
	halloween_pumpkin_3 = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v2_effect.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v2_effect.vpcf",

		buyable = false,
		dust_cost = 2000,
	},
	halloween_pumpkin_4 = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v3_effect.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/diretide_2020/emblem/fall20_emblem_v3_effect.vpcf",

		buyable = false,
		dust_cost = 2000,
	},
	oracle_false_promise_orbitb = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_oracle/oracle_false_promise_orbitb.vpcf",

		preview_params = {
			fov = "110",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_oracle/oracle_false_promise_orbitb.vpcf",

		buyable = true,
		cost = 820,
	},
	bane_slumber_nightmare = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/bane/slumbering_terror/bane_slumber_nightmare.vpcf",

		preview_params = {
			fov = "110",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/bane/slumbering_terror/bane_slumber_nightmare.vpcf",

		case_exclusive = true,
		dust_cost = 550,

		buyable = false,
		cost = 3500,
	},
	summer_2021_emblem = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/summer_2021/summer_2021_emblem_effect.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/summer_2021/summer_2021_emblem_effect.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 2000,
	},
	ti10_aegis = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/ti10/emblem/ti10_emblem_effect.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/ti10/emblem/ti10_emblem_effect.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 2000,
	},
	ti9_emblem = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/ti9/ti9_emblem_effect.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/ti9/ti9_emblem_effect.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 2000,
	},
	fall_2021_emblem = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/fall_2021/fall_2021_emblem_game_effect.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/fall_2021/fall_2021_emblem_game_effect.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 2000,
	},
	omni_2021_immortal_buff_ring = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/omniknight/omni_2021_immortal/omni_2021_immortal_buff_ring.vpcf",

		preview_params = {
			fov = "60",
			origin = "210 0 255",
			look_at = "0 0 35",
		},

		game_value = "particles/econ/items/omniknight/omni_2021_immortal/omni_2021_immortal_buff_ring.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 450,
	},
	fall_2022_emblem = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/fall_2022/player/fall_2022_emblem_effect_player_base.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/fall_2022/player/fall_2022_emblem_effect_player_base.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 2000,
	},
	ti8_emblem = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/ti8/ti8_hero_effect.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/ti8/ti8_hero_effect.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 2000,
	},
	fountain_effect_ti8 = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/cosmetic/auras/fountain_effect_ti8/fountain_effect_ti8.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/cosmetic/auras/fountain_effect_ti8/fountain_effect_ti8.vpcf",

		buyable = true,
		case_exclusive = true,
		dust_cost = 2000,
	},
	newbloom = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/cosmetic/auras/newbloom/newbloom.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/cosmetic/auras/newbloom/newbloom.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 320,
	},
	silencer_last_word_status_ti6 = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -250 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 900,
	},
	oracle_ti10_immortal_purifyingflames = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/oracle/oracle_ti10_immortal/oracle_ti10_immortal_purifyingflames.vpcf",

		preview_params = {
			fov = "70",
			origin = "215 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/oracle/oracle_ti10_immortal/oracle_ti10_immortal_purifyingflames.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 350,
	},
	enchantress_2021_immortal_14_imps = {
		slot_type = ITEMS_TYPES.FX_HERO,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_HERO,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/enchantress/enchantress_2021_immortal/enchantress_2021_immortal_14_imps.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 -160 655",
			look_at = "0 0 70",
		},

		game_value = "particles/econ/items/enchantress/enchantress_2021_immortal/enchantress_2021_immortal_14_imps.vpcf",

		buyable = true,
		case_exclusive = true,
		dust_cost = 150,
	},
	oracle_carnival_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/oracle/oracle_carnival/oracle_carnival_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/oracle/oracle_carnival/oracle_carnival_base_attack.vpcf",

		buyable = true,
		case_exclusive = true,
		dust_cost = 150,
	},
	desolation_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_desolator.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_desolator.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 150,
	},
	fire_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_phoenix/phoenix_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_phoenix/phoenix_base_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 80,
	},
	ice_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/items2_fx/skadi_projectile.vpcf",

		preview_params = {
			fov = "50",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/items2_fx/skadi_projectile.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 80,
	},
	poison_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_viper/viper_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_viper/viper_base_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 80,
	},
	lightning_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_void_spirit/base_attack/void_spirit_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_void_spirit/base_attack/void_spirit_base_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 120,
	},
	wind_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_windrunner/windrunner_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_windrunner/windrunner_base_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 120,
	},
	tower_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/world_tower/tower_upgrade/ti7_dire_tower_projectile.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/world_tower/tower_upgrade/ti7_dire_tower_projectile.vpcf",

		buyable = true,
		cost = 750,
	},
	arcane_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_enigma/enigma_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_enigma/enigma_base_attack.vpcf",

		buyable = true,
		cost = 750,
	},
	attack_fall_2021 = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/fall_2021/attack_modifier_fall_2021.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/fall_2021/attack_modifier_fall_2021.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 800,
	},
	attack_ti10 = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/events/ti10/attack_modifier_ti10.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/events/ti10/attack_modifier_ti10.vpcf",

		buyable = true,
		cost = 900,
	},
	drow_ti9_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/drow/drow_ti9_immortal/drow_ti9_base_attack.vpcf",

		preview_params = {
			fov = "45",
			origin = "225 0 0",
			look_at = "0 0 0",
		},

		game_value = "particles/econ/items/drow/drow_ti9_immortal/drow_ti9_base_attack.vpcf",

		buyable = true,
		cost = 1200,
	},
	luna_cosmic_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/luna/luna_cosmic/luna_cosmic_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/luna/luna_cosmic/luna_cosmic_attack.vpcf",

		buyable = true,
		cost = 1000,
	},
	necrolyte_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/necrolyte/necronub_base_attack/necrolyte_base_attack_ka.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/necrolyte/necronub_base_attack/necrolyte_base_attack_ka.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 950,
	},
	puck_aproset_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/puck/puck_alliance_set/puck_base_attack_aproset.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/puck/puck_alliance_set/puck_base_attack_aproset.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 450,
	},
	rubick_wandering_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/rubick/rubick_staff_wandering/rubick_base_attack_whset.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/rubick/rubick_staff_wandering/rubick_base_attack_whset.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 260,
	},
	storm_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack.vpcf",

		buyable = true,
		cost = 750,
	},
	skywrath_aracana_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_base_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 280,
	},
	skywrath_aracana_v2_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_base_attack_v2.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_base_attack_v2.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 320,
	},
	viper_poison_attack_ti7 = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/viper/viper_ti7_immortal/viper_poison_attack_ti7.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/viper/viper_ti7_immortal/viper_poison_attack_ti7.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 550,
	},
	viper_poison_crimson_attack_ti7 = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/viper/viper_ti7_immortal/viper_poison_crimson_attack_ti7.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/viper/viper_ti7_immortal/viper_poison_crimson_attack_ti7.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 750,
	},
	io_calavera_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/wisp/calavera/io_calavera_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/wisp/calavera/io_calavera_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 120,
	},
	witch_doctor_ribbitar_ward_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/witch_doctor/witch_doctor_ribbitar/witch_doctor_ribbitar_ward_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/witch_doctor/witch_doctor_ribbitar/witch_doctor_ribbitar_ward_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 90,
	},
	dire_tower_2021_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/world/towers/dire_tower_2021/dire_tower_2021_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/world/towers/dire_tower_2021/dire_tower_2021_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 320,
	},
	dire_tower_2022_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/world/towers/dire_tower_2022/dire_tower_2022_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/world/towers/dire_tower_2022/dire_tower_2022_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 320,
	},
	radiant_tower_2021_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/world/towers/radiant_tower_2021/radiant_tower_2021_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/world/towers/radiant_tower_2021/radiant_tower_2021_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 320,
	},
	radiant_tower_2022_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/world/towers/radiant_tower_2022/radiant_tower_2022_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/world/towers/radiant_tower_2022/radiant_tower_2022_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 320,
	},
	ti10_dire_tower_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 320,
	},
	ti10_dire_tower_cyan_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_cyan_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/world/towers/ti10_dire_tower/ti10_dire_tower_cyan_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 320,
	},
	catapult_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/events/crownfall/survivors/enemies/catapult_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/events/crownfall/survivors/enemies/catapult_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 80,
	},
	rod_of_atos_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/items2_fx/rod_of_atos_attack.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/items2_fx/rod_of_atos_attack.vpcf",

		buyable = true,
		cost = 850,
	},
	black_dragon_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/neutral_fx/black_dragon_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/neutral_fx/black_dragon_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 1050,
	},
	thunderlizard_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/neutral_fx/thunderlizard_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/neutral_fx/thunderlizard_base_attack.vpcf",

		buyable = true,
		cost = 750,
	},
	arc_warden_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_arc_warden/arc_warden_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_arc_warden/arc_warden_base_attack.vpcf",

		buyable = true,
		cost = 750,
	},
	cm_persona_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_attack.vpcf",

		buyable = true,
		cost = 900,
	},
	dark_willow_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_dark_willow/dark_willow_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_dark_willow/dark_willow_base_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 140,
	},
	dark_willow_shadow_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_dark_willow/dark_willow_shadow_attack.vpcf",

		preview_params = {
			fov = "55",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_dark_willow/dark_willow_shadow_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 240,
	},
	dark_willow_willowisp_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_dark_willow/dark_willow_willowisp_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_dark_willow/dark_willow_willowisp_base_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 1200,
	},
	death_prophet_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_death_prophet/death_prophet_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_death_prophet/death_prophet_base_attack.vpcf",

		buyable = true,
		cost = 750,
	},
	dragon_knight_elder_dragon_attack_black = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_attack_black.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_attack_black.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 400,
	},
	huskar_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_huskar/huskar_base_attack.vpcf",

		preview_params = {
			fov = "60",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_huskar/huskar_base_attack.vpcf",

		buyable = true,
		cost = 800,
	},
	invoker_kid_base_attack_all = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_invoker_kid/invoker_kid_base_attack_all.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_invoker_kid/invoker_kid_base_attack_all.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 4000,
	},
	lion_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_lion/lion_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_lion/lion_base_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 220,
	},
	mirana_solar_blessing_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_mirana/mirana_solar_blessing_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_mirana/mirana_solar_blessing_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 260,
	},
	oracle_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_oracle/oracle_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_oracle/oracle_base_attack.vpcf",

		buyable = true,
		cost = 750,
	},
	troll_warlord_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_troll_warlord/troll_warlord_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 225 0",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_troll_warlord/troll_warlord_base_attack.vpcf",

		buyable = true,
		cost = 750,
	},
	warlock_base_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_warlock/warlock_base_attack.vpcf",

		preview_params = {
			fov = "55",
			origin = "0 0 80",
			look_at = "0 0 60",
		},

		game_value = "particles/units/heroes/hero_warlock/warlock_base_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 120,
	},
	winter_wyvern_arctic_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_winter_wyvern/winter_wyvern_arctic_attack.vpcf",

		preview_params = {
			fov = "55",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_winter_wyvern/winter_wyvern_arctic_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 90,
	},
	fountain_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/base_attacks/fountain_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/base_attacks/fountain_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 180,
	},
	templar_assassin_meld_focal_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/econ/items/templar_assassin/templar_assassin_focal/templar_assassin_meld_focal_attack.vpcf",

		preview_params = {
			fov = "75",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/econ/items/templar_assassin/templar_assassin_focal/templar_assassin_meld_focal_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 12500,
	},
	chaos_attack = {
		slot_type = ITEMS_TYPES.FX_ATTACK,
		slot_name = ITEMS_DEFAULT_SLOTS.FX_ATTACK,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/units/heroes/hero_wisp/wisp_base_attack.vpcf",

		preview_params = {
			fov = "40",
			origin = "0 0 225",
			look_at = "0 0 15",
		},

		game_value = "particles/units/heroes/hero_wisp/wisp_base_attack.vpcf",

		buyable = false,
		case_exclusive = true,
		dust_cost = 120,
	},
	moderator = {
		slot_type = ITEMS_TYPES.TITLE,
		slot_name = ITEMS_DEFAULT_SLOTS.TITLE,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/title/moderator/title_moderator.vpcf",

		preview_params = {
			fov = "55",
			origin = "0 -180 225",
			look_at = "0 0 120",
		},

		game_value = "particles/title/moderator/title_moderator.vpcf",

		buyable = false,
	},
	moderator_v2 = {
		slot_type = ITEMS_TYPES.TITLE,
		slot_name = ITEMS_DEFAULT_SLOTS.TITLE,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/title/moderator_v2/title_moderator_v2.vpcf",

		preview_params = {
			fov = "55",
			origin = "0 -180 225",
			look_at = "0 0 120",
		},

		game_value = "particles/title/moderator_v2/title_moderator_v2.vpcf",

		buyable = false,
	},
	moderator_v3 = {
		slot_type = ITEMS_TYPES.TITLE,
		slot_name = ITEMS_DEFAULT_SLOTS.TITLE,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/title/moderator_v3/title_moderator_v3.vpcf",

		preview_params = {
			fov = "55",
			origin = "0 -180 225",
			look_at = "0 0 120",
		},

		game_value = "particles/title/moderator_v3/title_moderator_v3.vpcf",

		buyable = false,
	},
	moderator_v4 = {
		slot_type = ITEMS_TYPES.TITLE,
		slot_name = ITEMS_DEFAULT_SLOTS.TITLE,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/title/moderator_v4/title_moderator_v4.vpcf",

		preview_params = {
			fov = "55",
			origin = "0 -180 225",
			look_at = "0 0 120",
		},

		game_value = "particles/title/moderator_v4/title_moderator_v4.vpcf",

		buyable = false,
	},
	streamer = {
		slot_type = ITEMS_TYPES.TITLE,
		slot_name = ITEMS_DEFAULT_SLOTS.TITLE,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/title/streamer/title_streamer.vpcf",

		preview_params = {
			fov = "80",
			origin = "0 -100 260",
			look_at = "0 0 70",
		},

		game_value = "particles/title/streamer/title_streamer.vpcf",

		buyable = false,
	},
	legend = {
		slot_type = ITEMS_TYPES.TITLE,
		slot_name = ITEMS_DEFAULT_SLOTS.TITLE,

		preview_type = ITEMS_PREVIEW_TYPES.FX,
		preview_value = "particles/title/legend/title_legend.vpcf",

		preview_params = {
			fov = "55",
			origin = "0 -180 225",
			look_at = "0 0 120",
		},

		game_value = "particles/title/legend/title_legend.vpcf",

		buyable = false,
		dust_cost = 32500,
		case_exclusive = true,
	},
}