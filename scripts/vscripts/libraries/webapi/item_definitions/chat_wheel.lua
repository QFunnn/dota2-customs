--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function _CreateChatWheelDef(name, def, unlocked_with, rarity)
	if def.channels then
		def.color = name
	end

	ITEM_DEFINITIONS["chat_wheel_" .. name] = {
		unlocked_with = unlocked_with,
		chat_wheel_details = def,
		rarity = rarity or ITEM_RARITIES.COMMON,

		-- Filler values
		slot = INVENTORY_SLOTS.MISC,
		type = ITEM_TYPES.PASSIVE,
		is_hidden = true,
		is_hidden_owned = true,
	}
end

function CreateChatWheelDef_Currency(name, def, cost, rarity)
	_CreateChatWheelDef(name, def, { currency = cost }, rarity)
end

function CreateChatWheelDef_Treasure(name, def, treasure_name, rarity)
	_CreateChatWheelDef(name, def, { treasure = treasure_name }, rarity)
end

function CreateChatWheelDef_Hidden(name, def, rarity)
	_CreateChatWheelDef(name, def, { other = "promo" }, rarity)
end

-- ======================= SOUNDS ========================
-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Currency("cw_what_the_f_just_happened", { sound = "soundboard.what_the_f_just_happened", group = "english_commentators" }, 4999, ITEM_RARITIES.MYTHICAL)
CreateChatWheelDef_Currency("cw_a_net_net_da", { sound = "soundboard.a_net_net_da", group = "russian_commentators" }, 999, ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Currency("cw_eto_takaya_dushka", { sound = "soundboard.eto_takaya_dushka", group = "russian_commentators" }, 999, ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Currency("cw_chto_eto_kakaya_zhest", { sound = "soundboard.chto_eto_kakaya_zhest", group = "russian_commentators" }, 1999, ITEM_RARITIES.RARE)
CreateChatWheelDef_Currency("cw_a_nu_ka_idi_suda", { sound = "soundboard.a_nu_ka_idi_suda", group = "russian_commentators" }, 1999, ITEM_RARITIES.RARE)
CreateChatWheelDef_Currency("cw_lai_ni_da", { sound = "soundboard.lai_ni_da", group = "chinese_commentators" }, 999, ITEM_RARITIES.UNCOMMON)

-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Currency("cw_aghs_1", { sound = "soundboard.ti10eventgame.reward1", group = "aghanim_lines" }, 999, ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Currency("cw_aghs_2", { sound = "soundboard.ti10eventgame.reward2", group = "aghanim_lines" }, 1999, ITEM_RARITIES.RARE)
CreateChatWheelDef_Currency("cw_aghs_3", { sound = "soundboard.ti10eventgame.reward3", group = "aghanim_lines" }, 1999, ITEM_RARITIES.RARE)
CreateChatWheelDef_Currency("cw_aghs_4", { sound = "soundboard.ti10eventgame.reward4", group = "aghanim_lines" }, 4999, ITEM_RARITIES.MYTHICAL)
CreateChatWheelDef_Currency("cw_aghs_5", { sound = "soundboard.ti10eventgame.reward5", group = "aghanim_lines" }, 9999, ITEM_RARITIES.LEGENDARY)

-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Treasure("cw_boing", { sound = "soundboard.pitch.boing", group = "basic" }, "treasure_chat_wheel_1", ITEM_RARITIES.COMMON)
CreateChatWheelDef_Treasure("cw_moo", { sound = "soundboard.pitch.moo", group = "basic" }, "treasure_chat_wheel_1", ITEM_RARITIES.COMMON)
CreateChatWheelDef_Treasure("cw_orchestra", { sound = "soundboard.pitch.orchit", group = "basic" }, "treasure_chat_wheel_1", ITEM_RARITIES.COMMON)
CreateChatWheelDef_Treasure("cw_heehaw", { sound = "soundboard.pitch.heehaw", group = "basic" }, "treasure_chat_wheel_2", ITEM_RARITIES.COMMON)
CreateChatWheelDef_Treasure("cw_woopwoo", { sound = "soundboard.pitch.woopwoo", group = "basic" }, "treasure_chat_wheel_2", ITEM_RARITIES.COMMON)
CreateChatWheelDef_Treasure("cw_oops", { sound = "soundboard.pitch.oops", group = "basic" }, "treasure_chat_wheel_2", ITEM_RARITIES.COMMON)

-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Treasure("cw_holy_moly", { sound = "soundboard.holy_moly", group = "english_commentators" }, "treasure_chat_wheel_1", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("cw_takaya_haliava", { sound = "soundboard.takaya_haliava", group = "russian_commentators" }, "treasure_chat_wheel_1", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("cw_wo_shi_yi", { sound = "soundboard.wo_shi_yi", group = "chinese_commentators" }, "treasure_chat_wheel_1", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("cw_oh_my_god_what_oh_oh", { sound = "soundboard.oh_my_god_what_oh_oh", group = "english_commentators" }, "treasure_chat_wheel_2", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("cw_aaah_aaah_chto", { sound = "soundboard.aaah_aaah_chto", group = "russian_commentators" }, "treasure_chat_wheel_2", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("cw_ni_xing_ni", { sound = "soundboard.ni_xing_ni", group = "chinese_commentators" }, "treasure_chat_wheel_2", ITEM_RARITIES.UNCOMMON)

-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Treasure("cw_coming_through_with_the_woooo", { sound = "soundboard.coming_through_with_the_woooo", group = "english_commentators" }, "treasure_chat_wheel_1", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("cw_hui_tian_mie", { sound = "soundboard.hui_tian_mie", group = "chinese_commentators" }, "treasure_chat_wheel_1", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("cw_see_you_later_nerds", { sound = "soundboard.see_you_later_nerds", group = "english_commentators" }, "treasure_chat_wheel_2", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("cw_tiao_zou_le", { sound = "soundboard.tiao_zou_le", group = "chinese_commentators" }, "treasure_chat_wheel_2", ITEM_RARITIES.RARE)

-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Treasure("cw_nothing_that_can_stop_this_man", { sound = "soundboard.nothing_that_can_stop_this_man", group = "english_commentators" }, "treasure_chat_wheel_1", ITEM_RARITIES.MYTHICAL)
CreateChatWheelDef_Treasure("cw_kisi_kisi", { sound = "talent.season12.899273569.2", group = "russian_commentators" }, "treasure_chat_wheel_1", ITEM_RARITIES.MYTHICAL)
CreateChatWheelDef_Treasure("cw_ay_ay_ay_cn", { sound = "soundboard.ay_ay_ay_cn", group = "chinese_commentators" }, "treasure_chat_wheel_2", ITEM_RARITIES.MYTHICAL)
CreateChatWheelDef_Treasure("cw_plaki_plaki", { sound = "talent.season11.899273569.1", group = "russian_commentators" }, "treasure_chat_wheel_2", ITEM_RARITIES.MYTHICAL)

-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Treasure("cw_dc_wow", { sound = "soundboard.darkcarnival_wow", group = "dark_carnival" }, "treasure_chat_wheel_dc", ITEM_RARITIES.COMMON)
CreateChatWheelDef_Treasure("cw_dc_snoring", { sound = "custom_dc.snoring", group = "dark_carnival" }, "treasure_chat_wheel_dc", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("cw_dc_money_and_bones", { sound = "soundboard.money_and_bones", group = "dark_carnival" }, "treasure_chat_wheel_dc", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("cw_dc_idiots", { sound = "soundboard.darkcarnival_are_we_the_idiots", group = "dark_carnival" }, "treasure_chat_wheel_dc", ITEM_RARITIES.MYTHICAL)

-- ======================= EMOJIES =======================
-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Currency("a_100", { emoji_id = 1 }, 250)
CreateChatWheelDef_Currency("a_101", { emoji_id = 2 }, 250)
CreateChatWheelDef_Currency("a_102", { emoji_id = 3 }, 250)
CreateChatWheelDef_Currency("a_103", { emoji_id = 4 }, 250)
CreateChatWheelDef_Currency("a_104", { emoji_id = 5 }, 250)
CreateChatWheelDef_Currency("a_105", { emoji_id = 6 }, 250)
CreateChatWheelDef_Currency("a_106", { emoji_id = 7 }, 250)
CreateChatWheelDef_Currency("a_107", { emoji_id = 9 }, 250)
CreateChatWheelDef_Currency("a_108", { emoji_id = 10 }, 250)
CreateChatWheelDef_Currency("a_109", { emoji_id = 13 }, 250)
CreateChatWheelDef_Currency("a_110", { emoji_id = 14 }, 250)
CreateChatWheelDef_Currency("a_111", { emoji_id = 15 }, 250)

-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Currency("b_101", { emoji_id = 12 }, 500)
CreateChatWheelDef_Currency("b_102", { emoji_id = 18 }, 500)
CreateChatWheelDef_Currency("b_103", { emoji_id = 19 }, 500)
CreateChatWheelDef_Currency("b_104", { emoji_id = 21 }, 500)
CreateChatWheelDef_Currency("b_105", { emoji_id = 22 }, 500)
CreateChatWheelDef_Currency("b_106", { emoji_id = 23 }, 500)
CreateChatWheelDef_Currency("b_107", { emoji_id = 24 }, 500)
CreateChatWheelDef_Currency("b_108", { emoji_id = 25 }, 500)
CreateChatWheelDef_Currency("b_109", { emoji_id = 26 }, 500)
CreateChatWheelDef_Currency("b_110", { emoji_id = 27 }, 500)
CreateChatWheelDef_Currency("b_111", { emoji_id = 28 }, 500)
CreateChatWheelDef_Currency("b_112", { emoji_id = 29 }, 500)

-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Currency("c_101", { emoji_id = 8 }, 999)
CreateChatWheelDef_Currency("c_102", { emoji_id = 11 }, 999)
CreateChatWheelDef_Currency("c_103", { emoji_id = 16 }, 999)
CreateChatWheelDef_Currency("c_104", { emoji_id = 17 }, 999)
CreateChatWheelDef_Currency("c_105", { emoji_id = 20 }, 999)
CreateChatWheelDef_Currency("c_106", { emoji_id = 71 }, 999)
CreateChatWheelDef_Currency("c_107", { emoji_id = 107 }, 999)
CreateChatWheelDef_Currency("c_108", { emoji_id = 262 }, 999)
CreateChatWheelDef_Currency("c_109", { emoji_id = 343 }, 999)
CreateChatWheelDef_Currency("c_110", { emoji_id = 121 }, 999)
CreateChatWheelDef_Currency("c_111", { emoji_id = 123 }, 999)
CreateChatWheelDef_Currency("c_112", { emoji_id = 126 }, 999)

-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Currency("d_101", { emoji_id = 127 }, 1999)
CreateChatWheelDef_Currency("d_102", { emoji_id = 128 }, 1999)
CreateChatWheelDef_Currency("d_103", { emoji_id = 129 }, 1999)
CreateChatWheelDef_Currency("d_104", { emoji_id = 130 }, 1999)
CreateChatWheelDef_Currency("d_105", { emoji_id = 131 }, 1999)
CreateChatWheelDef_Currency("d_106", { emoji_id = 256 }, 1999)

CreateChatWheelDef_Hidden("p_101", { emoji_id = 78 })


-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Treasure("dc_100", { emoji_id = 428 }, "treasure_chat_wheel_dc", ITEM_RARITIES.COMMON)
CreateChatWheelDef_Treasure("dc_103", { emoji_id = 426 }, "treasure_chat_wheel_dc", ITEM_RARITIES.COMMON)
CreateChatWheelDef_Treasure("dc_107", { emoji_id = 423 }, "treasure_chat_wheel_dc", ITEM_RARITIES.COMMON)
CreateChatWheelDef_Treasure("dc_110", { emoji_id = 431 }, "treasure_chat_wheel_dc", ITEM_RARITIES.COMMON)
CreateChatWheelDef_Treasure("dc_101", { emoji_id = 425 }, "treasure_chat_wheel_dc", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("dc_104", { emoji_id = 432 }, "treasure_chat_wheel_dc", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("dc_108", { emoji_id = 427 }, "treasure_chat_wheel_dc", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("dc_102", { emoji_id = 421 }, "treasure_chat_wheel_dc", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("dc_105", { emoji_id = 424 }, "treasure_chat_wheel_dc", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("dc_109", { emoji_id = 428 }, "treasure_chat_wheel_dc", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("dc_109", { emoji_id = 429 }, "treasure_chat_wheel_dc", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("dc_106", { emoji_id = 430 }, "treasure_chat_wheel_dc", ITEM_RARITIES.MYTHICAL)

-- ======================= COLORS ========================
-- ALL ACTUAL ITEM NAMES ARE PREFIXED WITH chat_wheel_
CreateChatWheelDef_Currency("color_abaddon", { channels = 4 }, 999, ITEM_RARITIES.COMMON)
CreateChatWheelDef_Currency("color_anti_mage", { channels = 1 }, 999, ITEM_RARITIES.COMMON)
CreateChatWheelDef_Currency("color_bristleback", { channels = 1 }, 999, ITEM_RARITIES.COMMON)
CreateChatWheelDef_Currency("color_centaur", { channels = 1 }, 999, ITEM_RARITIES.COMMON)

CreateChatWheelDef_Treasure("electric", { channels = 1 }, "treasure_chat_wheel_1", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("color_alchemist", { channels = 1 }, "treasure_chat_wheel_1", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("color_bloodseeker", { channels = 3 }, "treasure_chat_wheel_2", ITEM_RARITIES.UNCOMMON)
CreateChatWheelDef_Treasure("color_broodmother", { channels = 3 }, "treasure_chat_wheel_2", ITEM_RARITIES.UNCOMMON)

CreateChatWheelDef_Treasure("color_aa", { channels = 1 }, "treasure_chat_wheel_1", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("color_batrider", { channels = 1 }, "treasure_chat_wheel_2", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("color_bounty_hunter", { channels = 1 }, "treasure_chat_wheel_2", ITEM_RARITIES.RARE)
CreateChatWheelDef_Treasure("color_brewmaster", { channels = 1 }, "treasure_chat_wheel_1", ITEM_RARITIES.RARE)

CreateChatWheelDef_Treasure("color_bane", { channels = 2 }, "treasure_chat_wheel_2", ITEM_RARITIES.MYTHICAL)
CreateChatWheelDef_Treasure("color_chaos_knight", { channels = 3 }, "treasure_chat_wheel_1", ITEM_RARITIES.MYTHICAL)

CreateChatWheelDef_Treasure("rainbow", { channels = 1 }, "treasure_chat_wheel_2", ITEM_RARITIES.LEGENDARY)
CreateChatWheelDef_Treasure("invert_bw", { channels = 1 }, "treasure_chat_wheel_1", ITEM_RARITIES.LEGENDARY)

CreateChatWheelDef_Treasure("color_dc", { channels = 3 }, "treasure_chat_wheel_dc", ITEM_RARITIES.MYTHICAL)