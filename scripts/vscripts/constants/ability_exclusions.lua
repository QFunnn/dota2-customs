--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Списки способностей/предметов, на которые НЕ срабатывают Multicast / Rearm,
-- а также частично перезаряжаются Rearm'ом (REARM_DISCOUNT).
-- Дублируют исходные таблицы из:
--   * heroes/hero_ogre_magi/ogre_magi_multicast_lua.lua (MULTICAST_ABILITIES с TYPE_NONE)
--   * heroes/hero_tinker/rearm.lua (ability_exempt_table + exempt_table + ability_discount_table)
-- Источник истины — там; здесь только публикация для клиента (ability_note.js).
-- При добавлении исключений/скидок в исходниках — синхронизируй сюда вручную.

if not IsServer() then return end

-- Способности, которые Multicast НЕ повторяет (subset MULTICAST_ABILITIES → TYPE_NONE)
local MULTICAST_EXEMPT = {
    ogre_magi_bloodlust = true,
    ogre_magi_fireblast = true,
    ogre_magi_unrefined_fireblast = true,
    ogre_magi_multicast_lua = true,
    item_manta_arena = true,
    item_diffusal_style = true,
    rubick_spell_steal_custom = true,
    item_refresher_arena = true,
    item_refresher_core = true,
    abyssal_underlord_firestorm_custom = true,
    item_fallen_sky = true,
    mars_bulwark = true,
    item_refresher_custom = true,
    sandking_burrowstrike = true,
    obsidian_destroyer_astral_imprisonment = true,
    item_book_of_shadows_custom = true,
    invoker_quas = true,
    invoker_wex = true,
    invoker_exort = true,
    invoker_invoke = true,
    ability_alchemist_unstable_concoction = true,
    ability_alchemist_unstable_concoction_throw = true,
    elder_titan_ancestral_spirit = true,
    elder_titan_return_spirit = true,
    ember_spirit_sleight_of_fist = true,
    monkey_king_tree_dance = true,
    monkey_king_primal_spring = true,
    monkey_king_primal_spring_early = true,
    arc_warden_tempest_double = true,
    arc_warden_tempest_double_lua = true,
    phoenix_sun_ray = true,
    phoenix_sun_ray_stop = true,
    phoenix_sun_ray_toggle_move = true,
    undying_tombstone_lua = true,
    item_relearn_book_lua = true,
    item_relearn_torn_page_lua = true,
    item_paragon_book = true,
    item_paragon_book_2 = true,
    item_book_of_strength_custom = true,
    item_book_of_agility_custom = true,
    item_book_of_intelligence_custom = true,
    shredder_chakram_lua = true,
    shredder_chakram_2_lua = true,
    item_aegis_lua = true,
    tusk_walrus_kick = true,
    warlock_fatal_bonds = true,
    nyx_assassin_burrow = true,
    nyx_assassin_unburrow = true,
    item_black_king_bar = true,
    item_smoke_of_deceit = true,
    item_ward_sentry = true,
    monkey_king_wukongs_command = true,
    wisp_tether = true,
    wisp_tether_break = true,
    ability_phoenix_supernova = true,
    brewmaster_primal_split = true,
    item_ex_machina_custom = true,
    item_manta = true,
    item_extra_creature_satyr_trickster = true,
    item_extra_creature_big_thunder_lizard = true,
    item_extra_creature_spider_range = true,
    item_extra_creature_dark_troll_warlord = true,
    item_extra_creature_ghost = true,
    item_extra_creature_centaur_khan = true,
    item_extra_creature_prowler_shaman = true,
    item_extra_creature_granite_golem = true,
    item_extra_creature_rock_golem = true,
    item_extra_creature_gnoll_assassin = true,
    item_extra_creature_kobold = true,
    item_extra_creature_timber_spider = true,
    item_extra_creature_explode_spider = true,
    item_dark_moon_shard = true,
    hoodwink_sharpshooter = true,
    witch_doctor_voodoo_switcheroo = true,
    dawnbreaker_converge = true,
    dawnbreaker_solar_guardian = true,
    dawnbreaker_celestial_hammer = true,
    crystal_maiden_freezing_field = true,
    shadow_demon_disseminate_custom = true,
    grimstroke_ink_creature = true,
    faceless_void_chronosphere = true,
    timbersaw_chakram_lua = true,
    timbersaw_chakram_2_lua = true,
    custom_legion_commander_duel = true,
    tusk_snowball = true,
    earth_spirit_rolling_boulder = true,
    item_clarity = true,
    item_faerie_fire = true,
    item_flask = true,
    item_tango = true,
    item_dust = true,
    item_bottle = true,
    item_heal_ward = true,
    item_mana_ward = true,
    item_staff_of_sanctuary = true,
    item_omniscient_book = true,
    item_teleport_ticket_secretshop = true,
    item_rune_forge = true,
    item_smoke_of_deceit_custom = true,
    item_vambrace = true,
    brewmaster_drunken_brawler = true,
    tiny_tree_grab_lua = true,
    tiny_tree_throw_lua = true,
    ancient_apparition_ice_blast = true,
    ancient_apparition_ice_blast_release = true,
    item_fusion_rune = true,
    item_blink = true,
    grimstroke_spirit_walk_custom = true,
    item_overwhelming_blink = true,
    item_swift_blink = true,
    item_arcane_blink = true,
    item_necronomicon = true,
    item_necronomicon_2 = true,
    item_necronomicon_3 = true,
    item_demonicon = true,
    item_elixer = true,
    item_royal_jelly = true,
    item_overflowing_elixir = true,
    item_fusion_rune_custom = true,
    chen_holy_persuasion_custom = true,
    razor_static_link = true,
    bounty_hunter_track = true,
    custom_terrorblade_metamorphosis = true,
    bane_nightmare = true,
    visage_summon_familiars = true,
    lycan_summon_wolves = true,
    invoker_forge_spirit_lua = true,
    item_tier1_token_custom = true,
    item_tier2_token_custom = true,
    item_tier3_token_custom = true,
    item_tier4_token_custom = true,
    item_tier5_token_custom = true,
    item_tier5_token_roshan_custom = true,
    item_tier1_token = true,
    item_tier2_token = true,
    item_tier3_token = true,
    item_tier4_token = true,
    item_tier5_token = true,
    faceless_void_time_zone = true,
    juggernaut_blade_fury = true,
    legion_commander_press_the_attack_custom = true,
    life_stealer_rage = true,
    chen_hand_of_god_custom = true,
}

-- Айтемы, которые можно «применить сразу при покупке» удержанием ALT
-- (если в радиусе магазина). Для отображения плашки Fast Use в тултипе
-- (см. ability_note.js → FAST_USE_STRIP_CONFIG). При добавлении нового
-- айтема с таким же ALT-механизмом — допиши сюда.
local FAST_USE_ABILITIES = {
    item_relearn_book_lua = true,
    item_relearn_book_sss = true,
    item_relearn_book_return = true,
    item_relearn_torn_page_lua = true,
    item_book_of_strength_custom = true,
    item_book_of_agility_custom = true,
    item_book_of_intelligence_custom = true,
    item_essence_of_speed = true,
    item_gem_shard = true,
    item_gem_shard_2 = true,
    item_extra_creature_satyr_trickster = true,
    item_extra_creature_big_thunder_lizard = true,
    item_extra_creature_centaur_khan = true,
    item_extra_creature_dark_troll_warlord = true,
    item_extra_creature_elf_wolf = true,
    item_extra_creature_explode_spider = true,
    item_extra_creature_ghost = true,
    item_extra_creature_gnoll_assassin = true,
    item_extra_creature_granite_golem = true,
    item_extra_creature_kobold = true,
    item_extra_creature_ogreseal = true,
    item_extra_creature_prowler_shaman = true,
    item_extra_creature_rock_golem = true,
    item_extra_creature_roshling_big = true,
    item_extra_creature_siltbreaker = true,
    item_extra_creature_spider_range = true,
    item_extra_creature_timber_spider = true,
    item_extra_creature_warpine = true,
}

-- Способности с моментальным убийством крипов (наносят 100% maxhp dmg).
-- Источник истины — utils/damage_filter_util.lua (abilities_max_health_damage
-- + abilities_oneshot_curse). При добавлении сюда тоже синхронизируй.
local INSTA_KILL_ABILITIES = {
    pudge_meat_hook = true,
    mirana_arrow = true,
    night_stalker_hunter_in_the_night_custom = true,
    item_hand_of_midas_custom = true,
    doom_bringer_devour_custom = true,
    enigma_demonic_conversion_custom = true,
    snapfire_gobble_up_custom = true,
    life_stealer_infest = true,
    life_stealer_consume = true,
}

-- Способности, которые Rearm НЕ перезаряжает (ability_exempt_table из rearm.lua)
local REARM_EXEMPT = {
    ability_phoenix_supernova = true,
    arc_warden_tempest_double = true,
    arc_warden_tempest_double_lua = true,
    zuus_thundergods_wrath = true,
    furion_wrath_of_nature = true,
    ancient_apparition_ice_blast = true,
    spectre_haunt = true,
    silencer_global_silence = true,
    skeleton_king_reincarnation = true,
    abaddon_borrowed_time_custom = true,
    oracle_false_promise_custom = true,
    dazzle_shallow_grave = true,
    slark_shadow_dance = true,
    dark_willow_shadow_realm = true,
    slark_depth_shroud = true,
    undying_tombstone_lua = true,
    shadow_shaman_mass_serpent_ward = true,
    warlock_rain_of_chaos = true,
    rattletrap_overclocking = true,
    rattletrap_jetpack = true,
    dazzle_good_juju = true,
    bounty_drop_custom = true,
    slark_depth_shroud_custom = true,
    slark_shadow_dance_custom = true,
    chen_holy_persuasion_custom = true,
    razor_static_link = true,
    puck_phase_shift_custom = true,
    muerta_pierce_the_veil = true,
    ability_disruptor_aeon = true,
    ability_undying_reincarnate = true,
    ability_marci_special_delivery = true,
    -- предметы из exempt_table
    item_hand_of_midas_custom = true,
    item_refresher_custom = true,
    item_black_king_bar = true,
    item_arcane_boots = true,
    item_guardian_greaves = true,
    item_sphere = true,
    item_aeon_disk = true,
    item_demonicon = true,
    item_aeon_disk_lua = true,
    item_ex_machina_custom = true,
}

-- Способности с частичной перезарядкой Rearm — Rearm снимает X% от ПОЛНОГО CD
-- (а не полностью обнуляет). Значение — integer percent (40 / 50), а не float
-- ratio (0.4 / 0.5): JSON-передача целых стабильнее, в тултипе подставляется
-- напрямую без умножения на 100. Источник истины — ability_discount_table в
-- heroes/hero_tinker/rearm.lua. REARM_EXEMPT имеет приоритет: если способность
-- одновременно в обоих списках — Rearm её игнорирует полностью.
local REARM_DISCOUNT = {
    faceless_void_chronosphere = 40,
    zuus_cloud_custom = 50,
    mirana_arrow = 50,
    night_stalker_hunter_in_the_night_custom = 50,
    doom_bringer_devour_custom = 50,
    pudge_meat_hook = 50,
    life_stealer_infest = 50,
    enigma_demonic_conversion_custom = 50,
    snapfire_gobble_up_custom = 50,
}

-- Формы с полётом (беспрепятственное передвижение) — для плашки Flying Form в тултипе
-- (см. ability_note.js → FLYING_FORM_STRIP_CONFIG). Текст плашки поясняет: даёт беспрепятственное
-- передвижение, а ПЕРЕКЛЮЧАЕМЫЕ формы дополнительно тратят 2% макс.маны/сек (drain — отдельно,
-- через modifier_infinite_form_mana_drain в их OnToggle). Здесь список — только для плашки.
-- Переключаемые (тратят ману 2%/сек): Lycan, Lone Druid, Sven, Undying, Keeper, Terrorblade,
-- Lina Flame Cloak, а также Arctic Burn С АГАНИМОМ (ванильная валвовская toggle-форма; дрейн
-- навешивается через вотчер modifier_arctic_burn_no_collision по GetToggleState, т.к. своего скрипта нет).
-- Не-переключаемые (только беспрепятственное передвижение, без траты): DK Dragon Form, Visage.
local FLYING_FORM_ABILITIES = {
    lycan_shapeshift_custom = true,
    lone_druid_true_form_custom = true,
    sven_gods_strength_custom = true,
    undying_flesh_golem_custom = true,
    keeper_of_the_light_spirit_form_custom = true,
    custom_terrorblade_metamorphosis = true,
    lina_flame_cloak_custom = true,
    dragon_knight_elder_dragon_form_custom = true,
    visage_silent_as_the_grave = true,
    winter_wyvern_arctic_burn = true,
}

-- На момент require'а addon_init.lua глобал CustomNetTables ещё не инициализирован
-- (Dota создаёт его позже в pipeline'е, ближе к Activate()). Откладываем
-- публикацию через ListenToGameEvent — событие game_rules_state_change
-- гарантированно стреляет когда CustomNetTables уже доступен.
local function PublishExclusionTables()
    if not CustomNetTables then return end
    CustomNetTables:SetTableValue("globals", "multicast_exempt", MULTICAST_EXEMPT)
    CustomNetTables:SetTableValue("globals", "rearm_exempt", REARM_EXEMPT)
    CustomNetTables:SetTableValue("globals", "rearm_discount", REARM_DISCOUNT)
    CustomNetTables:SetTableValue("globals", "insta_kill_abilities", INSTA_KILL_ABILITIES)
    CustomNetTables:SetTableValue("globals", "fast_use_abilities", FAST_USE_ABILITIES)
    CustomNetTables:SetTableValue("globals", "flying_form_abilities", FLYING_FORM_ABILITIES)

    -- Info по SSS Relearn Book — для динамической подстановки в тултип ({rounds}/{count}).
    -- Source of truth — constants/main.lua → GIVE_SSS_RELEARN_BOOK_ROUNDS / SSS_RELEARN_BOOK_COUNT.
    if GIVE_SSS_RELEARN_BOOK_ROUNDS and SSS_RELEARN_BOOK_COUNT then
        CustomNetTables:SetTableValue("globals", "sss_relearn_book_info", {
            rounds = table.concat(GIVE_SSS_RELEARN_BOOK_ROUNDS, ", "),
            count = SSS_RELEARN_BOOK_COUNT,
        })
    end

    local mc_count = 0
    for _ in pairs(MULTICAST_EXEMPT) do mc_count = mc_count + 1 end
    local rm_count = 0
    for _ in pairs(REARM_EXEMPT) do rm_count = rm_count + 1 end
    local rd_count = 0
    for _ in pairs(REARM_DISCOUNT) do rd_count = rd_count + 1 end
    local ik_count = 0
    for _ in pairs(INSTA_KILL_ABILITIES) do ik_count = ik_count + 1 end
    print(string.format("[ABILITY_EXCLUSIONS] NetTables published — multicast=%d entries, rearm=%d entries, rearm_discount=%d entries, insta_kill=%d entries", mc_count, rm_count, rd_count, ik_count))
end

local _publish_done = false
ListenToGameEvent("game_rules_state_change", function()
    if _publish_done then return end
    if not CustomNetTables then return end
    PublishExclusionTables()
    _publish_done = true
end, nil)