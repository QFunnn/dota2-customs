--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const PanelDraggablePart = $("#AbilitySelectorPanelTop");
const PanelRoot = $("#AbilitySelectorPanelRoot");
let CanRandomAbilitySelection = true;

const UNREMOVABLE_ABILITIES = 
{
    "monkey_king_wukongs_command": true,
    "rubick_empty1" : true,
    "rubick_empty2" : true,
}

const ABILITIES_COLOR = {
    WHITE : {
        "sven_gods_strength_custom" : true,
        "kunkka_tidebringer_custom" : true,
        "dragon_knight_dragon_tail_custom" : true,
        "dragon_knight_dragon_blood_custom" : true,
        "dragon_knight_elder_dragon_form_custom" : true,
        "rattletrap_battery_assault_custom" : true,
        "drow_ranger_frost_arrows_custom" : true,
        "drow_ranger_multishot_custom" : true,
        "drow_ranger_marksmanship_custom" : true,
        "juggernaut_omni_slash_custom" : true,
        "muerta_gunslinger_custom" : true,
        "phantom_lancer_juxtapose_custom" : true,
        "vengefulspirit_magic_missile_custom" : true,
        "crystal_maiden_frostbite_custom" : true,
        "puck_phase_shift_custom" : true,
        "puck_dream_coil_custom" : true,
        "storm_spirit_electric_vortex_custom" : true,
        "storm_spirit_overload_custom" : true,
        "zuus_arc_lightning_custom" : true,
        "zuus_lightning_bolt_custom" : true,
        "zuus_heavenly_jump_custom" : true,
        "zuus_thundergods_vengeance_custom" : true,
        "zuus_static_field_custom" : true,
        "lina_laguna_blade_custom" : true,
        "shadow_shaman_shackles_custom" : true,
        "omniknight_hammer_of_purity_custom" : true,
        "huskar_inner_fire_custom" : true,
        "huskar_burning_spear_custom" : true,
        "alchemist_goblins_greed_custom" : true,
        "treant_leech_seed_custom" : true,
        "wisp_overcharge_custom" : true,
        "riki_backstab_custom" : true,
        "riki_tricks_of_the_trade_custom" : true,
        "sniper_take_aim_custom" : true,
        "sniper_assassinate_custom" : true,
        "luna_lucent_beam_custom" : true,
        "furion_force_of_nature_custom" : true,
        "chen_penitence_custom" : true,
        "chen_holy_persuasion_custom" : true,
        "chen_hand_of_god_custom" : true,
        "silencer_glaives_of_wisdom_custom" : true,
        "ogre_magi_fireblast_custom" : true,
        "ogre_magi_ignite_custom" : true,
        "bristleback_viscous_nasal_goo_custom" : true,
        "legion_commander_press_the_attack_custom" : true,
        "lone_druid_true_form_custom" : true,
        "naga_siren_song_of_the_siren_custom" : true,
        "troll_warlord_fervor_custom" : true,
        "ember_spirit_flame_guard_custom" : true,
        "ember_spirit_fire_remnant_custom" : true,
        "rubick_spell_steal_custom" : true,
        "disruptor_static_storm_custom" : true,
        "keeper_of_the_light_illuminate_custom" : true,
        "keeper_of_the_light_radiant_bind_custom" : true,
        "keeper_of_the_light_spirit_form_custom" : true,
        "skywrath_mage_arcane_bolt_custom" : true,
        "skywrath_mage_mystic_flare_custom" : true,
        "oracle_false_promise_custom" : true,
        "axe_berserkers_call" : true,
        "axe_culling_blade_custom" : true,
        "slardar_slithereen_crush_custom" : true,
        "slardar_amplify_damage_custom" : true,
        "tidehunter_gush_custom" : true,
        "tidehunter_kraken_shell_custom" : true,
        "tidehunter_anchor_smash_lua" : true,
        "skeleton_king_vampiric_aura_custom" : true,
        "life_stealer_feast_custom" : true,
        "bloodseeker_bloodrage_custom" : true,
        "nevermore_shadowraze1_custom" : true,
        "venomancer_poison_nova_custom" : true,
        "faceless_void_time_lock_custom" : true,
        "phantom_assassin_stifling_dagger_nb2017" : true,
        "phantom_assassin_blur_custom" : true,
        "viper_viper_strike_custom" : true,
        "bane_brain_sap_custom" : true,
        "lich_chain_frost_custom" : true,
        "lion_finger_of_death_custom" : true,
        "witch_doctor_voodoo_restoration_custom" : true,
        "witch_doctor_maledict_custom" : true,
        "enigma_malefice_custom" : true,
        "enigma_demonic_conversion_custom" : true,
        "enigma_midnight_pulse_custom" : true,
        "necrolyte_sadist_custom" : true,
        "necrolyte_heartstopper_aura_lua" : true,
        "night_stalker_darkness_custom" : true,
        "night_stalker_void_custom" : true,
        "night_stalker_hunter_in_the_night_custom" : true,
        "doom_bringer_devour_custom" : true,
        "doom_bringer_scorched_earth_custom" : true,
        "lycan_shapeshift_custom" : true,
        "undying_flesh_golem_custom" : true,
        "magnataur_empower_custom" : true,
        "broodmother_insatiable_hunger_custom" : true,
        "frostivus2018_weaver_geminate_attack_custom" : true,
        "spectre_desolate_custom" : true,
        "spectre_dispersion_custom" : true,
        "meepo_ransack_custom" : true,
        "nyx_assassin_spiked_carapace_custom" : true,
        "slark_shadow_dance_custom" : true,
        "pugna_life_drain_custom" : true,
        "dazzle_bad_juju_custom" : true,
        "batrider_flaming_lasso_custom" : true,
        "abaddon_borrowed_time_custom" : true,
        "abyssal_underlord_firestorm_custom" : true,
        "ancient_apparition_cold_feet_custom" : true,
        "abyssal_underlord_firestorm_custom" : true,
        "pangolier_shield_crash_custom" : true,
        "pangolier_heartpiercer_custom" : true,
        "grimstroke_spirit_walk_custom" : true,
        "snapfire_lil_shredder_custom" : true,
        "dawnbreaker_luminosity_custom" : true,
        "muerta_pierce_the_veil" : true,
        "centaur_return" : true,
        "abyssal_underlord_atrophy_aura" : true,
        "primal_beast_uproar" : true,
        "tiny_grow" : true,
        "skywrath_mage_concussive_shot" : true,
        "templar_assassin_meld" : true,
        "chaos_knight_chaos_bolt" : true,
        "tinker_defense_matrix" : true,
        "abaddon_aphotic_shield" : true,
        "alchemist_unstable_concoction" : true,
        "riki_backstab_custom" : true,
        "phantom_assassin_phantom_strike" : true,
        "clinkz_strafe" : true,
        "spectre_spectral_dagger" : true,
        "slark_dark_pact" : true,
        "enchantress_natures_attendants" : true,
        "weaver_shukuchi" : true,
        "crystal_maiden_brilliance_aura" : true,
        "troll_warlord_berserkers_rage" : true,
        "nevermore_dark_lord" : true,
        "dazzle_poison_touch" : true,
        "queenofpain_scream_of_pain" : true,
        "earthshaker_enchant_totem" : true,
        "spirit_breaker_bulldoze" : true,
        "ursa_overpower" : true,
        "mars_gods_rebuke" : true,
        "monkey_king_boundless_strike" : true,
        "elder_titan_natural_order" : true,
        "alchemist_corrosive_weaponry" : true,
        "enchantress_impetus" : true,
        "antimage_blink" : true,
        "shredder_reactive_armor" : true,
        "abaddon_death_coil" : true,
        "nyx_assassin_burrow" : true,
        "grimstroke_soul_chain" : true,
        "razor_storm_surge" : true,
    },
    BLUE : {
        "skeleton_king_reincarnation" : true,
        "skeleton_king_hellfire_blast" : true,
    },
    PURPLE : {
        "abyssal_underlord_firestorm_custom" : true,
        "elder_titan_earth_splitter" : true,
        "winter_wyvern_arctic_burn" : true,
        "doom_bringer_infernal_blade" : true,
        "enigma_midnight_pulse_custom" : true,
        "enigma_black_hole" : true,
        "zeus_static_field_lua" : true,
        "huskar_life_break" : true,
        "phoenix_sun_ray" : true,
        "spectre_dispersion_custom" : true,
        "death_prophet_spirit_siphon" : true,
        "custom_phantom_assassin_fan_of_knives" : true,
        "bloodseeker_rupture" : true,
        "item_spirit_vessel" : true,
        "terrorblade_reflection_lua" : true,
        "venomancer_poison_nova_custom" : true,
        "necrolyte_reapers_scythe_datadriven" : true,
        "necrolyte_heartstopper_aura_lua" : true,
        "zuus_static_field" : true,
        "item_blade_mail" : true,
        "item_panzer_custom" : true,
        "item_iron_talon" : true,
        "sandking_caustic_finale" : true,
        "sandking_caustic_finale_lua" : true,
        "jakiro_liquid_ice" : true,
        "jakiro_liquid_ice_lua" : true,
        "witch_doctor_maledict_custom" : true,
        "bloodseeker_blood_mist_custom" : true,
        "witch_doctor_voodoo_restoration_custom" : true,
        "item_shivas_guard_2" : true,
        "meepo_ransack_custom" : true,
        "shadow_demon_disseminate" : true,
        "dragon_knight_elder_dragon_form_custom" : true,
        "muerta_pierce_the_veil" : true,
        "zuus_arc_lightning_custom" : true,
        "venomancer_noxious_plague" : true,
        "drow_ranger_frost_arrows_custom" : true,
        "item_revenants_brooch" : true,
        "item_revenants_brooch_custom" : true,
        "item_giants_ring_custom" : true,
        "huskar_burning_spear" : true,
        "kez_kazurai_katana" : true,
        "kez_raptor_dance" : true,
        "zuus_heavenly_jump_custom" : true,
        "zuus_static_field_custom" : true,
        "death_prophet_spirit_siphon" : true,
    },
    PINK : {
        "lycan_shapeshift_custom" : true,
        "sven_gods_strength_custom" : true,
        "wisp_overcharge_custom" : true,
        "tiny_grow" : true,
        "undying_flesh_golem_custom" : true,
        "bloodseeker_bloodrage_custom" : true,
        "venomancer_poison_nova_custom" : true,
        "venomancer_noxious_plague" : true,
        "broodmother_insatiable_hunger_custom" : true,
        "meepo_ransack_custom" : true,
        "custom_terrorblade_metamorphosis" : true,
        "lina_laguna_blade_custom" : true,
        "rubick_spell_steal_custom" : true,
        "lich_chain_frost_custom" : true,
        "lion_finger_of_death_custom" : true,
        "obsidian_destroyer_arcane_orb" : true,
        "life_stealer_feast_custom"    : true,
        "pugna_life_drain_custom" :true,
    }
}

let CustomPosition = undefined

function ShowRandomAbilitySelection(data) 
{
    let parent = $("#AbilitySelectorAbilityBody")
    let abilities_list = data.data_list
    CanRandomAbilitySelection = (data.can_random === undefined) ? true : data.can_random

    let bEffectsEnabled = IsEffectsEnabled()

    $("#AbilitySelectorPanel").RemoveClass("IsOmniscientBook")

    
    // Обновление настроек позиции экрана выбора способностей
    // AdjustPosition()

    UpdateToggledText()

    // Обновление локализации номера абилки и кнопки закрыть
    $("#AbilitySelectorTitle").text= $.Localize("#AbilitySelectorTitle_1") + data.ability_number + $.Localize("#AbilitySelectorTitle_2");
    $("#AbilitySelection_Close").text = $.Localize("#AbilitySelection_Close");
    $("#AbilitySelector_CloseButton").enabled = CanRandomAbilitySelection;

    // Инициализация выбора способностей
    for (let ability_id in abilities_list) 
    {
        let ability_name = abilities_list[ability_id].ability_name;
        let ability_panel = parent.FindChildTraverse("ability_"+ability_id);
        if (ability_panel == undefined && ability_panel == null) 
        {
            ability_panel = $.CreatePanel("Panel", parent, "ability_"+ability_id);
            ability_panel.BLoadLayoutSnippet("AbilitySelectorAbility");     
        }

        // Визуальное название способности и ее иконка
        ability_panel.FindChildTraverse("AbilityImage").abilityname = ability_name;
        ability_panel.FindChildTraverse('AbilityName').text = $.Localize("#DOTA_Tooltip_ability_" + ability_name);

        // Визуальный эффект на уникальных способностях
        UpdateAbilityColorEffect(ability_panel, ability_name, bEffectsEnabled)

        // Возможность взять абилку
        SetAbilityPanelEvent(ability_panel, ability_name);

        // Обновление доп. способностей вместе с этой абилкой
        ability_panel.FindChildTraverse("LinkedAbilityPlusIcon").SetHasClass("LinkedAbilityCollapse", true);
        ability_panel.FindChildTraverse("LinkedAbilityImage_1").SetHasClass("LinkedAbilityCollapse", true);
        ability_panel.FindChildTraverse("LinkedAbilityImage_2").SetHasClass("LinkedAbilityCollapse", true);
        
        if (abilities_list[ability_id].linked_abilities != undefined)
        {   
            let linkedAbilityIndex = 1
            ability_panel.FindChildTraverse("LinkedAbilityPlusIcon").SetHasClass("LinkedAbilityCollapse", false);
            for (var LinkedAbilityName in abilities_list[ability_id].linked_abilities) 
            {
                if (linkedAbilityIndex<=2)
                {
                    ability_panel.FindChildTraverse("LinkedAbilityImage_"+linkedAbilityIndex).abilityname = LinkedAbilityName;
                    ability_panel.FindChildTraverse("LinkedAbilityImage_"+linkedAbilityIndex).SetHasClass("LinkedAbilityCollapse", false);
                    linkedAbilityIndex = linkedAbilityIndex+1
                }
            }
        } 
    }

    $.Schedule(0.05, function(){
        AdjustMovablePanelPosition(PanelRoot)
    })

    // Обновление кнопки закрыть
    $("#AbilitySelector_CloseButton").SetPanelEvent("onmouseover", function() 
    {
        $.DispatchEvent( "DOTAShowTextTooltip", $("#AbilitySelector_CloseButton"), $.Localize("#AbilitySelection_Close_Description"));
    });

    $("#AbilitySelector_CloseButton").SetPanelEvent("onactivate", function() 
    {
        CloseAbilitySelect();
    });

    // Добавление кулдауна на взятие абилки
    UpdateAbilityMask()

    // Включение отображения панели
    $("#AbilitySelectorPanelRoot").SetHasClass("Show", true);
}

function ShowRelearnBookAbilitySelection(params) 
{
    var parent = $("#AbilitySelectorAbilityBody");

    $("#AbilitySelectorPanel").SetHasClass("IsOmniscientBook", params.book_type == 1)

    // Обновление настроек позиции экрана выбора способностей
    // AdjustPosition()

    UpdateToggledText()

    // Обновление локализации и удаление элементов старых абилок
    $("#AbilitySelectorAbilityBody").RemoveAndDeleteChildren()
    $("#AbilitySelectorTitle").text = $.Localize("#unlearn_ability")
    $("#AbilitySelection_Close").text = $.Localize("#AbilityRelearnCloseSelection_Label");

    var playerHeroIndex = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer());
    var abilityIndex = 0;

    for (var i = 0; i <= 32; i++) 
    {
        var ability = Entities.GetAbility(playerHeroIndex, i)
        var abilityName = Abilities.GetAbilityName(ability)
        if ( (IsValidAbility(ability) || "wisp_spirits_lua" == abilityName ) && UNREMOVABLE_ABILITIES[abilityName] == undefined && IsAbilityUnlocked(abilityName))
        {
            abilityIndex = abilityIndex + 1;
            var panelID = "ability_"+abilityIndex;
            var panel = parent.FindChildTraverse(panelID);
            if (panel == undefined && panel == null) 
            {
                panel = $.CreatePanel("Panel", parent, panelID);
                panel.BLoadLayoutSnippet("AbilitySelectorAbility");     
            }
            panel.FindChildTraverse("AbilityImage").abilityname = abilityName;
            panel.FindChildTraverse('AbilityName').text = $.Localize("#DOTA_Tooltip_ability_" + abilityName);
            SetRelearnBookAbilityPanelEvent(panel, abilityName, params.book_type);
        }
    }

    $.Schedule(0.05, function(){
        AdjustMovablePanelPosition(PanelRoot)
    })
    
    // Обновление кнопки закрыть
    $("#AbilitySelector_CloseButton").SetPanelEvent("onmouseover", function() 
    {
        $.DispatchEvent( "DOTAShowTextTooltip", $("#AbilitySelector_CloseButton"), $.Localize("#AbilityRelearnSelection_Description")  );
    });
    $("#AbilitySelector_CloseButton").SetPanelEvent("onactivate", function() 
    {
        if (!$("#AbilitySelectorPanelRoot").BHasClass("Show")) {return}
        GameEvents.SendCustomGameEventToServer("builder_relearn_book_selected", {player_id : Players.GetLocalPlayer(), book_type: params.book_type});
        $("#AbilitySelectorPanelRoot").SetHasClass("Show", false);
    });

    $("#AbilitySelectorPanelRoot").SetHasClass("Show", true);
}

function SetRelearnBookAbilityPanelEvent(panel,abilityName, book_type) 
{
    panel.SetPanelEvent("onactivate", function()
    {
        if (!$("#AbilitySelectorPanelRoot").BHasClass("Show")) {return}
        GameEvents.SendCustomGameEventToServer("builder_relearn_book_selected", {ability_name : abilityName, player_id : Players.GetLocalPlayer(), book_type: book_type});
        $("#AbilitySelectorTitle").text = $.Localize("#record_ability")
        $("#AbilitySelectorPanelRoot").SetHasClass("Show", false);
    });
    panel.SetPanelEvent("oncontextmenu", function()
    {   
        if(book_type == 1){
            if (!$("#AbilitySelectorPanelRoot").BHasClass("Show")) {return}
            GameEvents.SendCustomGameEventToServer("builder_relearn_book_selected", {ability_name : "DONT_DELETE", player_id : Players.GetLocalPlayer(), book_type: book_type});
            $("#AbilitySelectorTitle").text = $.Localize("#record_ability")
            $("#AbilitySelectorPanelRoot").SetHasClass("Show", false);
        }
    });
    panel.SetPanelEvent("onmouseover", function() 
    {
        $.DispatchEvent("DOTAShowAbilityTooltip", panel, abilityName);
    });
    panel.SetPanelEvent("onmouseout", function() 
    {
        $.DispatchEvent("DOTAHideAbilityTooltip");
    })    
}

function UpdateAbilityMask() 
{
    var parent = $("#AbilitySelectorAbilityBody");
    
    if (parent.cooldown == undefined) 
    {
        parent.cooldown = 0.8
        for (var i = 0; i <= 10; i++)   
        {
            var panelID = "ability_"+i;
            var panel = parent.FindChildTraverse(panelID);
            if (panel)
            {
                panel.SetHasClass("Loading", true)
                $("#AbilitySelector_CloseButton").SetHasClass("Loading", true)
                panel.FindChildTraverse("CooldownOverlay").RemoveClass("Hidden");
            }
        }
    }

    var angle = parent.cooldown / 0.8 * 360;
    parent.cooldown = parent.cooldown - 0.04
     
    if (parent.cooldown<=0)
    {
        parent.cooldown = undefined
        for (var i = 0; i <= 10; i++) 
        {
            var panelID = "ability_"+i;
            var panel = parent.FindChildTraverse(panelID);
            if (panel)
            {
                panel.SetHasClass("Loading", false)
                $("#AbilitySelector_CloseButton").SetHasClass("Loading", false)
                panel.FindChildTraverse("CooldownOverlay").AddClass("Hidden");
            }
        }
    } 
    else 
    {
        for (var i = 0; i <=10; i++) 
        {
            var panelID = "ability_"+i;
            var panel = parent.FindChildTraverse(panelID);
            if (panel)
            {
                panel.FindChildTraverse("CooldownOverlay").style.clip="radial( 50.0% 50.0%, 0.0deg, -"+angle+"deg)";
            }               
        }
        $.Schedule(0.04, UpdateAbilityMask)
    } 
}

function SetAbilityPanelEvent(panel,abilityName) 
{
    panel.SetPanelEvent("onactivate", function()
    {
        if (!$("#AbilitySelectorPanelRoot").BHasClass("Show")) {return}
        if (panel.BHasClass("Loading")) {return}
        GameEvents.SendCustomGameEventToServer("AbilitySelected", {ability_name : abilityName, player_id : Players.GetLocalPlayer(), spell_book_selected: false});
        $("#AbilitySelectorPanelRoot").SetHasClass("Show", false);
    });
    panel.SetPanelEvent("oncontextmenu", function()
    {   
    });
    panel.SetPanelEvent("onmouseover", function() 
    {
        $.DispatchEvent("DOTAShowAbilityTooltip", panel, abilityName);
    });
    panel.SetPanelEvent("onmouseout", function() 
    {
        $.DispatchEvent("DOTAHideAbilityTooltip");
    })
}

function CloseAbilitySelect() 
{
    if ($("#AbilitySelector_CloseButton").BHasClass("Loading")) {return}
    GameEvents.SendCustomGameEventToServer("AbilitySelected", {player_id : Players.GetLocalPlayer()});
    $("#AbilitySelectorPanelRoot").SetHasClass("Show", false);
}

function HideAbilitySelect() 
{
    $("#AbilitySelectorPanel").ToggleClass("HidePanel")
    $("#AbilitySelector_CloseButton").ToggleClass("HidePanel")

    UpdateToggledText()
}

function UpdateToggledText(){
    let ToggledText = $("#AbilitySelectorPanel").BHasClass("HidePanel") ? $.Localize("#AbilitySelection_Show") : $.Localize("#AbilitySelection_Hide")
    $("#AbilitySelector_HideButton").SetDialogVariable("toggled_text", ToggledText)
}

function AdjustPosition()
{
    if ($("#AbilitySelectorPanelRoot").dockRight)
    {
        $("#AbilitySelectorPanelRoot").SetHasClass("AbilitySelectorPanelRootSide", true)
        $("#AbilitySelectorPanel").SetHasClass("AbilitySelectorPanelSide", true)
        $("#AbilitySelectorAbilityBody").SetHasClass("AbilitySelectorAbilityBodySide", true)

        $("#AbilitySelectorPanelRoot").SetHasClass("AbilitySelectorPanelRoot", false)
        $("#AbilitySelectorPanel").SetHasClass("AbilitySelectorPanel", false)
        $("#AbilitySelectorAbilityBody").SetHasClass("AbilitySelectorAbilityBody", false)
    }
    else
    {
        $("#AbilitySelectorPanelRoot").SetHasClass("AbilitySelectorPanelRootSide", false)
        $("#AbilitySelectorPanel").SetHasClass("AbilitySelectorPanelSide", false)
        $("#AbilitySelectorAbilityBody").SetHasClass("AbilitySelectorAbilityBodySide", false)
        
        $("#AbilitySelectorPanelRoot").SetHasClass("AbilitySelectorPanelRoot", true)
        $("#AbilitySelectorPanel").SetHasClass("AbilitySelectorPanel", true)
        $("#AbilitySelectorAbilityBody").SetHasClass("AbilitySelectorAbilityBody", true)
    }
    if (FindDotaHudElement("AbilitySelectorPanelRoot").dockWidth) 
    {
        $("#AbilitySelectorPanelRoot").SetHasClass("SelectorMini", true)
    }
    else {
        $("#AbilitySelectorPanelRoot").SetHasClass("SelectorMini", false)
    }
}

function IsEffectsEnabled(){
    let settings = GetPlayerTablesValue(`player_${Players.GetLocalPlayer()}`, "setting_data")
    // CustomNetTables.GetTableValue("player_info", "setting_data_"+Players.GetLocalPlayer())

    return (settings && settings.settings_effect_select == 1)
}

function GetAbilityColor(AbilityName){
    for (const COLOR in ABILITIES_COLOR) {
        if(ABILITIES_COLOR[COLOR][AbilityName]){
            return COLOR
        }
    }

    return undefined
}

function UpdateAbilityColorEffect(ability_panel, ability_name, bIsEnabled)
{
    ability_panel.SetHasClass("HasColor", bIsEnabled && GetAbilityColor(ability_name) != undefined)
    if(!bIsEnabled){return}

    let AbilityColor = GetAbilityColor(ability_name)
    if(AbilityColor == undefined){return}

    ability_panel.SetHasClass("BlueColor", AbilityColor == "BLUE")
    ability_panel.SetHasClass("PurpleColor", AbilityColor == "PURPLE")
    ability_panel.SetHasClass("PinkColor", AbilityColor == "PINK")
}

function IsAbilityUnlocked(ability_name)
{
    if (GameUI.CustomUIConfig().abilities_locked == null)
    {
        return true
    }
    if (GameUI.CustomUIConfig().abilities_locked[ability_name] == null)
    {
        return true
    }
    if (GameUI.CustomUIConfig().abilities_locked[ability_name] == false)
    {
        return true
    }
    if (GameUI.CustomUIConfig().abilities_locked[ability_name] == true)
    {
        return false
    }
}

(function() 
{
    GameEvents.Subscribe("ShowRandomAbilitySelection", ShowRandomAbilitySelection);
    GameEvents.Subscribe("ShowRelearnBookAbilitySelection", ShowRelearnBookAbilitySelection);
    GameEvents.SendCustomGameEventToServer("ClientReconnected", {});

    SetupMovablePanel(PanelRoot, PanelDraggablePart, {align: [1,1], margin: [0,0]})
})();