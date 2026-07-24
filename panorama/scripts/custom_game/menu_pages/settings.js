--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const MAIN_PANEL = $.GetContextPanel()
let ScheduleSlider = -1
let PreviousValue = undefined
let LastTime = 0
let BarragePanel = FindDotaHudElement("BarrgeMainPanel")

let CurrentGameSettings = $("#CurrentGameSettings")

// Табы для клавиш
let currentKeybindTab = "abilities"

//可以在换技能页面展示的 附属技能
let subsidiaryException = {
    "beastmaster_call_of_the_wild_hawk": true,
    "morphling_adaptive_strike_str": true,
    "morphling_morph_str": true,
    "puck_ethereal_jaunt": true,
    "templar_assassin_trap": true,
    "elder_titan_ancestral_spirit": true,
    "earth_spirit_stone_caller": true,
    "phoenix_sun_ray_toggle_move": true,
    "lone_druid_true_form_battle_cry": true,
    "troll_warlord_whirling_axes_melee": true,
    "ember_spirit_activate_fire_remnant": true,
    "techies_focused_detonate": true,
    "nevermore_shadowraze2": true,
    "nevermore_shadowraze3": true,
    "shadow_demon_shadow_poison_release": true,
    "monkey_king_primal_spring": true,
    "kunkka_torrent_storm": true,
    "rattletrap_overclocking": true,
    "enchantress_bunny_hop": true,
    "treant_eyes_in_the_forest": true,
    "ogre_magi_unrefined_fireblast": true,
    "earth_spirit_petrify": true,
    "juggernaut_swift_slash": true,
    "snapfire_gobble_up": true,
    "snapfire_spit_creep": true,
    "nyx_assassin_burrow": true,
    "shredder_chakram_2_lua": true,
    "tusk_walrus_kick": true,
    "grimstroke_scepter": true,
    "zuus_cloud": true,
    "spectre_haunt_single": true,
    "tiny_tree_channel": true,
    "tiny_toss_tree": true,
    "antimage_mana_overload": true,
    "keeper_of_the_light_will_o_wisp": true,
    "leshrac_greater_lightning_storm": true,
    "terrorblade_terror_wave": true,
    "templar_assassin_trap_teleport": true,
    "alchemist_berserk_potion": true,
    "bristleback_hairball": true,
    "broodmother_silken_bola": true,
    "rattletrap_jetpack": true,
    "dark_seer_normal_punch": true,
    "dragon_knight_fireball": true,
    "grimstroke_ink_over": true,
    "jakiro_liquid_ice": true,
    "jakiro_liquid_ice_lua": true,
    "kunkka_tidal_wave": true,
    "lich_ice_spire": true,
    "life_stealer_open_wounds": true,
    "magnataur_horn_toss": true,
    "meepo_petrify": true,
    "necrolyte_death_seeker": true,
    "ogre_magi_smash": true,
    "omniknight_hammer_of_purity": true,
    "pangolier_rollup": true,
    "phantom_assassin_fan_of_knives": true,
    "riki_poison_dart": true,
    "slark_fish_bait": true,
    "sniper_concussive_grenade": true,
    "storm_spirit_electric_rave": true,
    "shredder_flamethrower": true,
    "tinker_defense_matrix": true,
    "terrorblade_demon_zeal": true,
    "tiny_craggy_exterior": true,
    "tusk_frozen_sigil": true,
    "witch_doctor_voodoo_switcheroo": true,
};

let settingInited=false

const SettingsSpecialSettings = {
    DuelNotification : {
        main_panel: $("#DuelNotification"),
        panel: $("#SettingSlider_DuelNotification"),
        min: 0,
        max: 10,
        setting_name: "duel_notification_duration"
    },
    CameraDistance : {
        main_panel: $("#CameraDistance"),
        panel: $("#SettingSlider_CameraDistance"),
        min: 1000,
        default: 1134,
        max: 2000,
        setting_name: "camera_distance",
        on_update: (value)=>{
            GameUI.SetCameraDistance( value )
            GameEvents.SendEventClientSide( "client_side_server_command", { command : `r_farz ${value+1500}`} )

            SettingsSpecialSettings["CameraDistance"].main_panel.SetHasClass("ShowResetButton", value != SettingsSpecialSettings["CameraDistance"].default)
        }
    },
}

InitSetting();

function RefreshAbilityOrder(keys) {

        //遍历 玩家技能
        let parent = $("#AbilityOrderAbilityBody");
        $("#AbilityOrderAbilityBody").RemoveAndDeleteChildren()

        let playerHeroIndex = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer());
        let abilityIndex = 0;
        for (let i = 0; i <= 30; i++) {
            let ability = Entities.GetAbility(playerHeroIndex, i);
            let abilityName = Abilities.GetAbilityName(ability);
            if (IsValidAbility(ability) || true==subsidiaryException[abilityName]) 
            {
                abilityIndex = abilityIndex + 1;
                let panelID = "ability_"+abilityIndex;
                let panel = parent.FindChildTraverse(panelID);
                if (panel == undefined && panel == null) {
                    panel = $.CreatePanel("Panel", parent, panelID);
                    panel.BLoadLayoutSnippet("AbilityOrderAbility");     
                }
                panel.abilityname = abilityName;
                panel.FindChildTraverse("AbilityImage").abilityname = abilityName;
                panel.FindChildTraverse('AbilityName').text = $.Localize("#DOTA_Tooltip_ability_" + abilityName); 
            }      
        }

        //遍历按钮 设置事件
        for (let i = 1; i <= abilityIndex; i++) {

          if (parent.FindChildTraverse("ability_"+i))
          {      
              let buttonLeft = parent.FindChildTraverse("ability_"+i).FindChildTraverse("ButtonLeft");
              let buttonRight = parent.FindChildTraverse("ability_"+i).FindChildTraverse("ButtonRight");
              let ability_index = i
              let LockedAbility = parent.FindChildTraverse("ability_"+ability_index).FindChildTraverse("LockedAbility");
            
              if (GameUI.CustomUIConfig().abilities_locked == null)
              {
                GameUI.CustomUIConfig().abilities_locked = {}
              }

              SetPanelEventLockAb(parent, LockedAbility, ability_index)

              if (i==1) {
                 buttonLeft.enabled=false;
              } else {
                 (function(thisIndex){          
                     buttonLeft.SetPanelEvent("onactivate", function(){
                        GameEvents.SendCustomGameEventToServer("SwapAbility", {
                            player_id : Players.GetLocalPlayer(),
                            swap_1 : parent.FindChildTraverse("ability_"+(thisIndex-1)).abilityname,
                            swap_2 : parent.FindChildTraverse("ability_"+thisIndex).abilityname,
                         });
                     });
                 })(i);
              }
              // 禁用最右边按钮
              if (i==abilityIndex) {
                 buttonRight.enabled=false;  
              } else {
                 (function(thisIndex){ 
                     buttonRight.SetPanelEvent("onactivate", function(){
                        GameEvents.SendCustomGameEventToServer("SwapAbility", {
                            player_id : Players.GetLocalPlayer(),
                            swap_1 : parent.FindChildTraverse("ability_"+thisIndex).abilityname,
                            swap_2 : parent.FindChildTraverse("ability_"+(thisIndex+1)).abilityname,
                         });
                     });
                 })(i);
              }
            }
        }

}

function CloseAbilityOrder() {
    $.DispatchEvent("DropInputFocus")
    $("#page_setting").SetHasClass("Show", false);
}

function ToggleOrder() {
    $.DispatchEvent("DropInputFocus")
    $("#page_setting").ToggleClass("Show");
    RefreshAbilityOrder();
}

function UpdateInventory() {
  RefreshAbilityOrder()
}

function OnChangeSlider(SliderID, isPct) {
    if(!SettingsSpecialSettings[SliderID]){return}

    let SliderPanel = SettingsSpecialSettings[SliderID].panel
    let MainPanel = SettingsSpecialSettings[SliderID].main_panel
    if(SliderPanel && MainPanel){
        let Min = SettingsSpecialSettings[SliderID].min
        let Max = SettingsSpecialSettings[SliderID].max
        let Value = Math.floor(Min + (Max - Min) * SliderPanel.value)
        if(SliderPanel._previous_value != Value && SliderPanel.mousedown == true){
            let pct = isPct ? "%" : ""
            MainPanel.SetDialogVariable("slider_value", Value + pct)

            if(SettingsSpecialSettings[SliderID].on_update){
                SettingsSpecialSettings[SliderID].on_update(Value)
            }


            SliderPanel._previous_value = Value
            SliderPanel._last_time = Game.GetGameTime() + 1
        }
    }
}

function UpdateSliderSettings(){
    $.Schedule(0, UpdateSliderSettings)

    let bNeedUpdate = false
    for (const SliderID in SettingsSpecialSettings) {
        let panel = SettingsSpecialSettings[SliderID].panel
        if(panel._last_time != undefined && panel._last_time != 0 && panel._last_time < Game.GetGameTime()){
            panel._last_time = 0
            bNeedUpdate = true
        }
    }

    if(bNeedUpdate){
        UpdateSetting()
    }
}

UpdateSliderSettings()

function ResetSetting(SettingID){
    let Info = SettingsSpecialSettings[SettingID]
    if(!Info){return}

    let Value = parseInt(Info.default ?? Info.min)
    if(Value != undefined){
        Info.panel.value = Math.min(Math.max((Value - Info.min) / (Info.max - Info.min), 0), 1)
        Info.panel._previous_value = Value

        if(Info.on_update){
            Info.on_update(Value)
        }

        Info.main_panel.SetDialogVariable("slider_value", Value)
    }
}

function ToggleAutoDuel(isLabel) {
   
   if (isLabel) {
     $("#CheckAutoDuel").SetSelected( !$("#CheckAutoDuel").IsSelected() );
   }
   GameEvents.SendCustomGameEventToServer("ToggleAutoDuel", {selected:$("#CheckAutoDuel").IsSelected()});
   UpdateSetting();
} 

function ToggleAutoCreep(isLabel) {
  
  if (isLabel) {
    $("#CheckAutoCreep").SetSelected( !$("#CheckAutoCreep").IsSelected() );
  }
  GameEvents.SendCustomGameEventToServer("ToggleAutoCreep", {selected:$("#CheckAutoCreep").IsSelected()});
  UpdateSetting();
}

function TogglHintsAbilitySelect(isLabel) {

    if (isLabel) 
    {
        $("#CheckHintsAbilitySelect").SetSelected(!$("#CheckHintsAbilitySelect").IsSelected());
    }
    UpdateSetting();
}


function TogglEffectAbilitySelect(isLabel) 
{
    if (isLabel) 
    {
        $("#CheckEffectAbilitySelect").SetSelected( !$("#CheckEffectAbilitySelect").IsSelected() );
    }
    UpdateSetting();
}

function TogglePenguinSound(isLabel){
    if (isLabel) 
    {
        $("#CheckPenguinSound").SetSelected( !$("#CheckPenguinSound").IsSelected() );
    }
    UpdateSetting();
}

function ToggleExtraCreature(isLabel){
    if (isLabel) 
    {
        $("#CheckMinimizedExtraCreature").SetSelected( !$("#CheckMinimizedExtraCreature").IsSelected() );
    }
    UpdateSetting();
}

function ToggleAutocloseDuelInfo(isLabel){
    if (isLabel) 
    {
        $("#CheckAutocloseDuelInfo").SetSelected( !$("#CheckAutocloseDuelInfo").IsSelected() );
    }
    UpdateSetting();
}

function ToggleAutoopenBetHistory(isLabel){
    if (isLabel) 
    {
        $("#CheckAutoopenBetHistory").SetSelected( !$("#CheckAutoopenBetHistory").IsSelected() );
    }
    UpdateSetting();
}

function ToggleNotificationsSetting(isLabel){
    if (isLabel)
    {
        $("#CheckNotifications").SetSelected( !$("#CheckNotifications").IsSelected() );
    }
    UpdateSetting();
}

// [NP-23] Доп. настройки.
function ToggleHideAegisHint(isLabel){
    if (isLabel){ $("#CheckHideAegisHint").SetSelected( !$("#CheckHideAegisHint").IsSelected() ); }
    UpdateSetting();
}
function ToggleWatchDuelAfterRound(isLabel){
    if (isLabel){ $("#CheckWatchDuelAfterRound").SetSelected( !$("#CheckWatchDuelAfterRound").IsSelected() ); }
    UpdateSetting();
}

// [NP-23] Дропдаун режима уведомления о призыве крипа (minimized_extra_creatures: 0=большое/1=маленькое/2=выкл).
// ВАЖНО: весь сетап в try/catch — иначе ошибка здесь ломала загрузку всего settings.js.
let ExtraCreatureNotifDropdown = $("#ExtraCreatureNotifDropdown")
function GetExtraCreatureNotifMode(){
    try {
        if(ExtraCreatureNotifDropdown){
            let sel = ExtraCreatureNotifDropdown.GetSelected()
            if(sel){ return parseInt(sel.GetAttributeString("data-value", "0")) || 0 }
        }
    } catch(e){}
    return 0
}
try {
    if(ExtraCreatureNotifDropdown){
        ExtraCreatureNotifDropdown.RemoveAllOptions()
        let _ecOpts = ["#SETTINGS_ExtraCreatureNotif_Big", "#SETTINGS_ExtraCreatureNotif_Small", "#SETTINGS_ExtraCreatureNotif_Off"]
        for(let i = 0; i < _ecOpts.length; i++){
            let o = $.CreatePanel("Label", ExtraCreatureNotifDropdown, "ecnotif_"+i)
            o.text = $.Localize(_ecOpts[i])
            o.SetAttributeString("data-value", String(i))
            o.AddClass("ECNotifOpt")
            ExtraCreatureNotifDropdown.AddOption(o)
        }
        // Применяем СОХРАНЁННОЕ значение сразу после создания опций. Важно: InitSetting() на строке
        // ~109 вызывается РАНЬШЕ этого сетапа → его SetSelected для дропдауна падал (опций ещё не было)
        // и settingInited уже выставлялся true, из-за чего значение из БД не применялось и дропдаун
        // застревал на «большое». Здесь опции уже есть, а setting_data обычно доступен → берём его.
        let _ecSd = GetPlayerTablesValue(`player_${Players.GetLocalPlayer()}`, "setting_data")
        let _ecVal = (_ecSd && (parseInt(_ecSd.minimized_extra_creatures) || 0)) || 0
        ExtraCreatureNotifDropdown.SetSelected("ecnotif_" + _ecVal)
        ExtraCreatureNotifDropdown.SetPanelEvent("oninputsubmit", function(){ UpdateSetting() })
    }
} catch(e){ $.Msg("[NP-23] ExtraCreature dropdown setup failed: " + e) }

function InitSetting(){
   let settingData = GetPlayerTablesValue(`player_${Players.GetLocalPlayer()}`, "setting_data")
   if (settingData && !settingInited)
   {
        settingInited = true
        $("#CheckHintsAbilitySelect").SetSelected(String(settingData.settings_hints_enabled) == "1");
        $("#CheckEffectAbilitySelect").SetSelected(String(settingData.settings_effect_select) == "1");
        $("#CheckPenguinSound").SetSelected(String(settingData.settings_penguin_sound) == "1");
        $("#CheckNotifications").SetSelected(String(settingData.settings_notifications) == "1");
        try { if(ExtraCreatureNotifDropdown){ ExtraCreatureNotifDropdown.SetSelected("ecnotif_" + (parseInt(settingData.minimized_extra_creatures) || 0)); } } catch(e){}
        $("#CheckAutocloseDuelInfo").SetSelected(String(settingData.autoclose_duel_info) == "1");
        $("#CheckAutoopenBetHistory").SetSelected(String(settingData.autoopen_bet_history) == "1");
        // [NP-23]
        $("#CheckHideAegisHint").SetSelected(String(settingData.hide_aegis_notification) == "1");
        $("#CheckWatchDuelAfterRound").SetSelected(String(settingData.watch_duel_after_round) == "1");

        for (const SettingName in SettingsSpecialSettings) {
            let Info = SettingsSpecialSettings[SettingName]
            let Value = parseInt(settingData[Info.setting_name] ?? Info.default ?? Info.min)
            if(Value != undefined){
                Info.panel.value = Math.min(Math.max((Value - Info.min) / (Info.max - Info.min), 0), 1)
                Info.panel._previous_value = Value

                if(Info.on_update){
                    Info.on_update(Value)
                }

                Info.main_panel.SetDialogVariable("slider_value", Value)
            }
        }
    }
}

function UpdateSetting()
{
    let settingData ={}
    settingData.effect_ability_selection = $("#CheckEffectAbilitySelect").IsSelected() ? 1 : 0;
    settingData.settings_hints_enabled = $("#CheckHintsAbilitySelect").IsSelected() ? 1 : 0;
    settingData.settings_penguin_sound = $("#CheckPenguinSound").IsSelected() ? 1 : 0;
    settingData.settings_notifications = $("#CheckNotifications").IsSelected() ? 1 : 0;
    settingData.minimized_extra_creatures = GetExtraCreatureNotifMode();
    settingData.autoclose_duel_info = $("#CheckAutocloseDuelInfo").IsSelected() ? 1 : 0;
    settingData.autoopen_bet_history = $("#CheckAutoopenBetHistory").IsSelected() ? 1 : 0;
    // [NP-23]
    settingData.hide_aegis_notification = $("#CheckHideAegisHint").IsSelected() ? 1 : 0;
    settingData.watch_duel_after_round = $("#CheckWatchDuelAfterRound").IsSelected() ? 1 : 0;

    for (const SettingName in SettingsSpecialSettings) {
        let Info = SettingsSpecialSettings[SettingName]
        if(Info.panel._previous_value != undefined){
            settingData[Info.setting_name] = Info.panel._previous_value
        }
    }
    GameEvents.SendCustomGameEventToServer("PlayerSettings", settingData);
}

(function() {
    GameEvents.Subscribe("RefreshAbilityOrder", function(){
        RefreshAbilityOrder();

        LoadBindsByTab();
    });
    CustomNetTables.SubscribeNetTableListener("hero_info", InitSetting);
    CustomNetTables.SubscribeNetTableListener("player_info", InitSetting);
    GameEvents.Subscribe( "dota_inventory_changed", UpdateInventory );
    RefreshAbilityOrder();
})();

// ============= Переключение верхних вкладок настроек =============
function OpenSettingsTab(tabName){
    let tabs = {Game: "TabGame", Camera: "TabCamera", Highlight: "TabHighlight"}
    // Кнопки вкладок (active highlight).
    for(let t in tabs){
        let tabBtn = $(`#${tabs[t]}`)
        if(tabBtn){ tabBtn.SetHasClass("Active", t === tabName) }
    }
    // Содержимое вкладок — элементы с класс TabContent + TabGame/TabCamera/TabHighlight.
    // Прячем те, что не соответствуют активной вкладке.
    let root = $.GetContextPanel()
    let gameEls = root.FindChildrenWithClassTraverse("TabGame")
    let cameraEls = root.FindChildrenWithClassTraverse("TabCamera")
    let highlightEls = root.FindChildrenWithClassTraverse("TabHighlight")
    for(let el of gameEls){ el.SetHasClass("Hidden", tabName !== "Game") }
    for(let el of cameraEls){ el.SetHasClass("Hidden", tabName !== "Camera") }
    for(let el of highlightEls){ el.SetHasClass("Hidden", tabName !== "Highlight") }

    // При первом открытии вкладки подсветки — инициализируем рендеринг.
    if(tabName === "Highlight" && !HL_inited && typeof InitHighlightSettings === "function"){
        InitHighlightSettings()
    }
}

// ============= Подсветка способностей (HL = Highlight) =============
// Реализация: 4 тоггла + 10 цветовых рядов. При клике на цвет — открывается
// палитра из 24 пресетов под нужным рядом. Сохранение через PlayerSettings.
// Тоггл «Подсвечивать модифицированные» убран из UI — отключается через
// установку color_modified в "none" в палитре.
const HL_TOGGLES = [
    {id: "Master",        key: "highlight_master_enabled"},
    {id: "Sss",           key: "highlight_sss_enabled"},
    {id: "UseCategories", key: "highlight_use_categories"},
]
const HL_COLORS_BASIC = [
    {id: "DefaultSss", key: "color_default_sss", label: "#HL_color_default_sss", default: "#ff8c42"},
    {id: "Modified",   key: "color_modified",    label: "#HL_color_modified",    default: "#ffffff"},
]
const HL_COLORS_CATEGORIES = [
    {id: "Forms",    key: "color_forms",    label: "#HL_color_forms",    default: "#ff8c42"},
    {id: "Splashes", key: "color_splashes", label: "#HL_color_splashes", default: "#ff8c42"},
    {id: "Op",       key: "color_op",       label: "#HL_color_op",       default: "#ff8c42"},
    {id: "Bkb",      key: "color_bkb",      label: "#HL_color_bkb",      default: "#ff8c42"},
    {id: "Bashes",   key: "color_bashes",   label: "#HL_color_bashes",   default: "#ff8c42"},
    {id: "Percent",  key: "color_percent",  label: "#HL_color_percent",  default: "#ff8c42"},
    {id: "Saves",    key: "color_saves",    label: "#HL_color_saves",    default: "#ff8c42"},
    {id: "Useful",   key: "color_useful",   label: "#HL_color_useful",   default: "#ff8c42"},
]
// Палитра — 28 пресетов + 1 спец-вариант "none" (без подсветки).
// Спец-значение "none" хранится в настройках как строка и трактуется
// GetAbilityHighlightColor как «не подсвечивать эту категорию».
const HL_PALETTE = [
    "none",  // ← первая ячейка: «без цвета»
    "#ff8c42", "#ff5722", "#bf360c", "#8b0000",
    "#e53935", "#ec407a", "#ff4081", "#d81b60",
    "#9b59b6", "#7b1fa2", "#3f51b5", "#3498db",
    "#2196f3", "#00bcd4", "#1abc9c", "#26a69a",
    "#27ae60", "#4caf50", "#a4de02", "#c0ca33",
    "#f1c40f", "#ffc107", "#ffffff", "#bdc3c7",
    "#90a4ae", "#607d8b", "#424242", "#000000",
]

let HL_settings = {}
let HL_inited = false
let HL_currentPaletteRow = null   // {id, key} текущего открытого color picker'а
let HL_PendingColor = null        // выбранный, но не подтверждённый цвет (Confirm-flow)

// Полный список всех кастомных способностей — для рандом-сэмплинга в preview-grid.
// Источник: PlayerTable globals/abilities_info (zxc_server.lua → KeyValues:LoadAbilities).
let HL_ALL_ABILITIES = []
SubscribeAndFirePlayerTableByKey("globals", "abilities_info", function(v){
    if(!v || typeof v !== "object") return
    HL_ALL_ABILITIES = Object.keys(v)
})

function HL_GetSaved(key, fallback){
    if(HL_settings[key] !== undefined && HL_settings[key] !== null && HL_settings[key] !== "") return HL_settings[key]
    return fallback
}

// Только подгружает данные с сервера в HL_settings (без UI). Может вызываться
// многократно — при каждом обновлении setting_data PlayerTable.
function HL_LoadSettingsFromServer(){
    let data = GetPlayerTablesValue(`player_${Players.GetLocalPlayer()}`, "setting_data")
    if(!data) return
    for(let t of HL_TOGGLES){ HL_settings[t.key] = parseInt(data[t.key] ?? 1) }
    for(let c of HL_COLORS_BASIC) { HL_settings[c.key] = data[c.key] || c.default }
    for(let c of HL_COLORS_CATEGORIES) { HL_settings[c.key] = data[c.key] || c.default }
}

function InitHighlightSettings(){
    if(HL_inited) return

    // Проверяем что DOM готов — ищем хотя бы один из ключевых элементов.
    let testEl = $("#HL_Toggle_Master")
    if(!testEl){
        $.Msg("[HL] InitHighlightSettings: DOM не готов, повтор через 0.2s")
        $.Schedule(0.2, InitHighlightSettings)
        return
    }

    HL_LoadSettingsFromServer()

    // Рендерим тогглы.
    for(let t of HL_TOGGLES){
        let btn = $(`#HL_Toggle_${t.id}`)
        if(btn){
            btn.SetSelected(HL_settings[t.key] == 1)
            btn.SetPanelEvent("onactivate", () => HL_OnToggle(t.id, t.key))
        }
    }

    // Рендерим цветовые ряды (после рендера ставим HL_inited=true только если успешно).
    let basicContainer = $("#HL_ColorRowsBasic")
    let categoriesContainer = $("#HL_ColorRowsCategories")
    if(!basicContainer || !categoriesContainer){
        $.Msg("[HL] контейнеры цветов не найдены, инит пропущен")
        return
    }
    HL_RenderColorRow(basicContainer, HL_COLORS_BASIC)
    HL_RenderColorRow(categoriesContainer, HL_COLORS_CATEGORIES)

    // Палитра — один раз.
    HL_BuildPalette()
    HL_UpdateCategorySectionVisibility()

    HL_inited = true
    $.Msg("[HL] InitHighlightSettings: done")
}

// Локальный helper — настройки могут хранить "none" как «без подсветки».
function HL_IsNoColor(c){ return !c || c === "none" || c === "" }

function HL_ApplySwatchStyle(outer, inner, val){
    if(!outer || !inner) return
    if(HL_IsNoColor(val)){
        outer.AddClass("NoColor")
        inner.style.backgroundColor = "transparent"
    } else {
        outer.RemoveClass("NoColor")
        inner.style.backgroundColor = val
    }
}

function HL_RenderColorRow(container, rows){
    if(!container) return
    container.RemoveAndDeleteChildren()
    for(let r of rows){
        let row = $.CreatePanel("Panel", container, `HL_Row_${r.id}`)
        row.BLoadLayoutSnippet("HighlightColorRow")
        row.SetDialogVariable("label", $.Localize(r.label))

        let swatchOuter = row.FindChildrenWithClassTraverse("HighlightColorRowSwatch")[0]
        let swatchInner = row.FindChildrenWithClassTraverse("HighlightColorRowSwatchInner")[0]
        HL_ApplySwatchStyle(swatchOuter, swatchInner, HL_settings[r.key])
        if(swatchOuter){ swatchOuter.SetPanelEvent("onactivate", () => HL_OpenPalette(r.id, r.key)) }
    }
}

// ============= Палитра: расширенная UX (preview + tooltip + current) =============
// Hex → локализационный ключ имени цвета для tooltip'а.
const HL_COLOR_NAMES = {
    "none":    "#HL_color_name_none",
    "#ff8c42": "#HL_color_name_orange",
    "#ff5722": "#HL_color_name_deeporange",
    "#bf360c": "#HL_color_name_brick",
    "#8b0000": "#HL_color_name_darkred",
    "#e53935": "#HL_color_name_red",
    "#ec407a": "#HL_color_name_pink",
    "#ff4081": "#HL_color_name_raspberry",
    "#d81b60": "#HL_color_name_magenta",
    "#9b59b6": "#HL_color_name_purple",
    "#7b1fa2": "#HL_color_name_darkpurple",
    "#3f51b5": "#HL_color_name_indigo",
    "#3498db": "#HL_color_name_blue",
    "#2196f3": "#HL_color_name_lightblue",
    "#00bcd4": "#HL_color_name_cyan",
    "#1abc9c": "#HL_color_name_teal",
    "#26a69a": "#HL_color_name_seafoam",
    "#27ae60": "#HL_color_name_green",
    "#4caf50": "#HL_color_name_lightgreen",
    "#a4de02": "#HL_color_name_lime",
    "#c0ca33": "#HL_color_name_olive",
    "#f1c40f": "#HL_color_name_yellow",
    "#ffc107": "#HL_color_name_amber",
    "#ffffff": "#HL_color_name_white",
    "#bdc3c7": "#HL_color_name_lightgray",
    "#90a4ae": "#HL_color_name_bluegray",
    "#607d8b": "#HL_color_name_gray",
    "#424242": "#HL_color_name_darkgray",
    "#000000": "#HL_color_name_black",
}
function HL_GetColorName(hex){
    let key = HL_COLOR_NAMES[hex] || "#HL_color_name_unknown"
    return $.Localize(key)
}

// Возвращает 8 способностей для preview-grid:
//   [0] ГАРАНТИРОВАННО из категории, которую сейчас настраиваем (Modified → из
//       ABILITY_MODIFIED, DefaultSss → любая SSS, Forms/Splashes/etc → из этой
//       SSS-подкатегории).
//   [1..7] случайные из ВСЕХ кастомных способностей (HL_ALL_ABILITIES), без
//       дубликатов с [0]. Цвет каждой считается отдельно в HL_GetPreviewColorFor,
//       так что не-модифицированные/не-SSS останутся без подсветки.
function HL_BuildPreviewAbilities(rowId){
    let result = []
    let upper = (rowId || "").toUpperCase()
    let allSss = (typeof ABILITY_SSS_SUBGROUP !== "undefined") ? Object.keys(ABILITY_SSS_SUBGROUP) : []

    // 1) Первая — из настраиваемой категории.
    let main = null
    if(rowId === "Modified" && typeof ABILITY_MODIFIED !== "undefined" && ABILITY_MODIFIED){
        let mods = Object.keys(ABILITY_MODIFIED)
        if(mods.length) main = mods[Math.floor(Math.random() * mods.length)]
    } else if(rowId === "DefaultSss" && allSss.length){
        main = allSss[Math.floor(Math.random() * allSss.length)]
    } else if(allSss.length){
        let inCat = allSss.filter(a => ABILITY_SSS_SUBGROUP[a] === upper)
        if(inCat.length){
            main = inCat[Math.floor(Math.random() * inCat.length)]
        }
    }
    if(main) result.push(main)

    // 2) 7 случайных из всего пула (если abilities_info ещё не приехал — fallback на SSS).
    let pool = (HL_ALL_ABILITIES.length > 0 ? HL_ALL_ABILITIES : allSss).filter(a => a !== main)
    for(let i = pool.length - 1; i > 0; i--){
        let j = Math.floor(Math.random() * (i + 1))
        let tmp = pool[i]; pool[i] = pool[j]; pool[j] = tmp
    }
    for(let i = 0; i < pool.length && result.length < 8; i++){
        result.push(pool[i])
    }
    return result
}

// Считает реальный цвет способности для preview, с учётом ОЖИДАЕМОГО изменения
// (HL_PendingColor для HL_currentPaletteRow.key). Логика 1:1 как в
// ability_colors.js GetAbilityHighlightColor, но с подменой нужного поля.
// Возвращает hex или null (если способность не подсвечивается).
function HL_GetPreviewColorFor(abilityName){
    if(!HL_currentPaletteRow) return null
    let s = HL_settings
    let key = HL_currentPaletteRow.key
    let pending = HL_PendingColor

    if(!s.highlight_master_enabled) return null

    let subgroup = (typeof ABILITY_SSS_SUBGROUP !== "undefined") ? ABILITY_SSS_SUBGROUP[abilityName] : null
    if(subgroup){
        if(!s.highlight_sss_enabled) return null
        if(s.highlight_use_categories){
            let catKey = "color_" + subgroup.toLowerCase()
            let c = (catKey === key) ? pending : s[catKey]
            return HL_IsNoColor(c) ? null : c
        }
        let c = (key === "color_default_sss") ? pending : s.color_default_sss
        return HL_IsNoColor(c) ? null : c
    }

    let isModified = (typeof ABILITY_MODIFIED !== "undefined" && ABILITY_MODIFIED && ABILITY_MODIFIED[abilityName])
    if(isModified){
        let c = (key === "color_modified") ? pending : s.color_modified
        return HL_IsNoColor(c) ? null : c
    }

    return null
}

// Строит preview-grid из 8 ability-панелей со структурой 1:1 как в ability_selection
// (тот же particle + opacity-mask + HasColor класс → одинаковое свечение).
function HL_BuildPreviewGrid(rowId){
    let grid = $("#HL_PreviewGrid")
    if(!grid) return
    grid.RemoveAndDeleteChildren()
    let abilities = HL_BuildPreviewAbilities(rowId)
    for(let i = 0; i < abilities.length; i++){
        let abName = abilities[i]
        let panel = $.CreatePanel("Panel", grid, `HL_PreviewAb_${i}`)
        panel.BLoadLayoutSnippet("HL_PreviewAbility")
        panel.zxcAbilityName = abName
        let img = panel.FindChildrenWithClassTraverse("HL_PreviewAbilityImage")[0]
        if(img){ img.abilityname = abName }
    }
}

// Перерисовка цветов preview-grid. Каждая способность получает СВОЙ цвет (через
// HL_GetPreviewColorFor), а не общий — поэтому не-модифицированные/не-SSS
// способности корректно остаются без подсветки даже если pending hex задан.
// ВАЖНО: Panorama бросает "Failed to parse style value for washColor" при
// пустой строке, поэтому при отсутствии цвета не трогаем washColor вообще —
// видимость управляется классом HasColor через CSS (visibility: collapse).
function HL_UpdatePreviewColors(){
    let grid = $("#HL_PreviewGrid")
    if(!grid) return
    for(let i = 0; i < grid.GetChildCount(); i++){
        let panel = grid.GetChild(i)
        if(!panel || !panel.zxcAbilityName) continue
        let color = HL_GetPreviewColorFor(panel.zxcAbilityName)
        let noColor = HL_IsNoColor(color)
        panel.SetHasClass("HasColor", !noColor)
        if(!noColor){
            let fxList = panel.FindChildrenWithClassTraverse("AbilityColorFx")
            let fx = fxList && fxList[0]
            if(fx && fx.style){
                fx.style.washColor = color
            }
        }
    }
}

// Помечает Current-классом swatch в палитре с тем же hex что текущий цвет категории.
function HL_HighlightCurrentSwatch(currentHex){
    let grid = $("#HL_PaletteGrid")
    if(!grid) return
    for(let i = 0; i < grid.GetChildCount(); i++){
        let sw = grid.GetChild(i)
        if(!sw) continue
        sw.SetHasClass("Current", sw.zxcHex === currentHex)
    }
}

function HL_BuildPalette(){
    let grid = $("#HL_PaletteGrid")
    if(!grid) return
    grid.RemoveAndDeleteChildren()
    for(let i = 0; i < HL_PALETTE.length; i++){
        let hex = HL_PALETTE[i]
        let sw = $.CreatePanel("Panel", grid, `HL_Palette_${i}`)
        sw.BLoadLayoutSnippet("HighlightPaletteSwatch")
        let inner = sw.FindChildrenWithClassTraverse("HighlightPaletteSwatchInner")[0]
        HL_ApplySwatchStyle(sw, inner, hex)
        sw.zxcHex = hex
        sw.SetPanelEvent("onactivate", () => HL_OnPickColor(hex))

        // 0.6с hover → tooltip с именем цвета. (preview-grid обновляется по
        // клику на swatch, не по hover — пользователь должен явно выбрать.)
        let nameSchedule = null
        sw.SetPanelEvent("onmouseover", function(){
            nameSchedule = $.Schedule(0.6, function(){
                $.DispatchEvent("DOTAShowTextTooltip", sw, HL_GetColorName(hex))
            })
        })
        sw.SetPanelEvent("onmouseout", function(){
            if(nameSchedule){ $.CancelScheduled(nameSchedule); nameSchedule = null }
            $.DispatchEvent("DOTAHideTextTooltip")
        })
    }
    HL_HidePalette()
}

function HL_OpenPalette(rowId, key){
    HL_currentPaletteRow = {id: rowId, key: key}
    HL_PendingColor = HL_settings[key]   // изначально pending = текущий

    let popup = $("#HL_PalettePopup")
    if(!popup) return

    // Заголовок: "Цвет: <название строки>" — берём label из HL_COLORS_*.
    let rowDef = HL_COLORS_BASIC.concat(HL_COLORS_CATEGORIES).find(c => c.id === rowId)
    let rowLabel = rowDef ? $.Localize(rowDef.label) : rowId
    popup.SetDialogVariable("popup_title", $.Localize("#HL_PALETTE_TITLE_PREFIX") + " " + rowLabel)

    // Preview-grid: 8 способностей, первая — из текущей категории.
    HL_BuildPreviewGrid(rowId)
    HL_UpdatePreviewColors()
    HL_HighlightCurrentSwatch(HL_settings[key])

    popup.AddClass("Visible")
}

function ClosePalettePopup(){ HL_HidePalette() }
function HL_HidePalette(){
    let popup = $("#HL_PalettePopup")
    if(popup){ popup.RemoveClass("Visible") }
    $.DispatchEvent("DOTAHideTextTooltip")
    // Чистим preview-grid чтобы не держать DOTAParticleScenePanel в памяти.
    let grid = $("#HL_PreviewGrid")
    if(grid){ grid.RemoveAndDeleteChildren() }
    HL_currentPaletteRow = null
    HL_PendingColor = null
}

// Клик по цвету в палитре — только "примеряет" цвет в preview, НЕ сохраняет.
// Реальное сохранение — по нажатию Confirm.
function HL_OnPickColor(hex){
    if(!HL_currentPaletteRow) return
    HL_PendingColor = hex
    HL_UpdatePreviewColors()
    HL_HighlightCurrentSwatch(hex)
}

// Подтверждение pending-цвета: пишем в HL_settings, обновляем swatch в строке,
// шлём локально (мгновенно) + на сервер (персист), закрываем попап.
function HL_ConfirmColor(){
    if(!HL_currentPaletteRow || HL_PendingColor === null){
        HL_HidePalette()
        return
    }
    let hex = HL_PendingColor
    let key = HL_currentPaletteRow.key
    let rowId = HL_currentPaletteRow.id
    HL_settings[key] = hex
    let row = $(`#HL_Row_${rowId}`)
    if(row){
        let outer = row.FindChildrenWithClassTraverse("HighlightColorRowSwatch")[0]
        let inner = row.FindChildrenWithClassTraverse("HighlightColorRowSwatchInner")[0]
        HL_ApplySwatchStyle(outer, inner, hex)
    }
    HL_ApplyLocal(key, hex)
    HL_Save()
    HL_HidePalette()
}

function HL_OnToggle(id, key){
    let btn = $(`#HL_Toggle_${id}`)
    let val = btn.IsSelected() ? 1 : 0
    HL_settings[key] = val
    if(key === "highlight_use_categories"){ HL_UpdateCategorySectionVisibility() }
    HL_ApplyLocal(key, val)
    HL_Save()
}

// Клик по label рядом с чекбоксом — переключает чекбокс (как в игровых настройках).
function HL_OnToggleLabel(id){
    let btn = $(`#HL_Toggle_${id}`)
    if(!btn) return
    btn.SetSelected(!btn.IsSelected())
    let toggle = HL_TOGGLES.find(t => t.id === id)
    if(toggle){ HL_OnToggle(toggle.id, toggle.key) }
}

// Локальное применение изменения в HIGHLIGHT_SETTINGS (ability_colors.js) +
// уведомление слушателей. Не ждём server roundtrip — открытые bans-полосы и
// селектор перерисовываются сразу. Если API ещё не зарегистрирован (порядок
// загрузки скриптов) — no-op, серверный roundtrip всё равно догонит.
function HL_ApplyLocal(key, value){
    let cfg = GameUI.CustomUIConfig()
    if(cfg && typeof cfg.ApplyHighlightSetting === "function"){
        cfg.ApplyHighlightSetting(key, value)
    }
}

function HL_UpdateCategorySectionVisibility(){
    let visible = HL_settings.highlight_use_categories == 1
    let lbl = $("#HL_CategoryColorsLabel")
    let body = $("#HL_ColorRowsCategories")
    if(lbl){ lbl.style.visibility = visible ? "visible" : "collapse" }
    if(body){ body.style.visibility = visible ? "visible" : "collapse" }
}

function HL_Save(){
    GameEvents.SendCustomGameEventToServer("PlayerSettings", HL_settings)
}

// При обновлении setting_data только синхронизируем HL_settings — UI рендерится
// лениво при первом открытии вкладки (см. OpenSettingsTab → InitHighlightSettings).
SubscribeAndFirePlayerTableByKey(`player_${Players.GetLocalPlayer()}`, "setting_data", function(v){
    if(!v) return
    HL_LoadSettingsFromServer()
})

SubscribeAndFireNetTableByKey("globals", "current_game_settings", function(v){
    let Text = ""
    let Array = toArray(v)
    if(Array){
        let i = 0
        for (const SettingInfo of Array) {
            i++;
            let Value = SettingInfo.value % 1 === 0  ?  SettingInfo.value :  SettingInfo.value.toFixed(2)
			Value = parseFloat(Value)
            if(i > 1 ){
                Text+="<br>"
            }
            Text+=`<font color="#ccc">${$.Localize(`#SETTINGS_VALUE_${SettingInfo.name}`)}:</font> <b>${Value}</b>`
        }
        CurrentGameSettings.SetPanelEvent('onmouseover', function() {
            $.DispatchEvent('DOTAShowTextTooltip', CurrentGameSettings, Text); 
        })
        CurrentGameSettings.SetPanelEvent('onmouseout', function() 
        {
            $.DispatchEvent('DOTAHideTextTooltip', CurrentGameSettings);
        })
    }
})

function SetPanelEventLockAb(parent, panel, ab_index)
{
    let ability_name = parent.FindChildTraverse("ability_"+(ab_index)).abilityname
    panel.SetPanelEvent("onactivate", function()
    {
        if (GameUI.CustomUIConfig().abilities_locked[ability_name] == null || GameUI.CustomUIConfig().abilities_locked[ability_name] == false)
        {
            GameUI.CustomUIConfig().abilities_locked[ability_name] = true
            panel.SetHasClass("LockedAbilityLock", true)
        } else {
            GameUI.CustomUIConfig().abilities_locked[ability_name] = false
            panel.SetHasClass("LockedAbilityLock", false)
        }
    });
    if (GameUI.CustomUIConfig().abilities_locked[ability_name] == null || GameUI.CustomUIConfig().abilities_locked[ability_name] == false)
    {
        panel.SetHasClass("LockedAbilityLock", false)
    }
    else
    {
        panel.SetHasClass("LockedAbilityLock", true)
    }
}






















const SettingsKeybindsList = $("#SettingsKeybindsList")

let LOCKED_KEY_BINDS = 
[
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_EXPLICIT_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_QUICKCAST_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY2_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY3_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY1_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_SECONDARY2_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_ULTIMATE_AUTOMATIC_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY1),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY1_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6_QUICKCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY1_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6_AUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY1_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY2_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY3_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY4_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY5_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_INVENTORY6_QUICKAUTOCAST),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_STOP),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_HOLD),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_ATTACK),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_MOVE),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_SELECT),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_PAUSE),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_OPEN),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SCOREBOARD),
    GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_SCREENSHOT),
];

const RU_TO_ENG_TABLE = {
    'й':'q','ц':'w','у':'e','к':'r','е':'t','н':'y','г':'u','ш':'i','щ':'o','з':'p','х':'[','ъ':']',
    'ф':'a','ы':'s','в':'d','а':'f','п':'g','р':'h','о':'j','л':'k','д':'l','ж':';','э':'\'',
    'я':'z','ч':'x','с':'c','м':'v','и':'b','т':'n','ь':'m','б':',','ю':'.','ё':'`'
}

function GetEnglishButton(Button){
    if(typeof Button == "string"){
        if(RU_TO_ENG_TABLE[Button.toLowerCase()]){
            return RU_TO_ENG_TABLE[Button.toLowerCase()].toUpperCase()
        }
        return Button.toUpperCase()
    }
    return Button;
}

let CustomBinds = {
    MovePanels: {
        DefaultBind: undefined,
        Func: ()=>{
            if(GameUI.CustomUIConfig().TogglePanelsMove == undefined){
                GameUI.CustomUIConfig().TogglePanelsMove = false
            }
            GameUI.CustomUIConfig().TogglePanelsMove = !GameUI.CustomUIConfig().TogglePanelsMove 

            if(GameUI.CustomUIConfig().MakeDescVisible){
                GameUI.CustomUIConfig().MakeDescVisible(GameUI.CustomUIConfig().TogglePanelsMove)
            }
        }
    },
    MoveAbilities: {
        DefaultBind: undefined,
        Func: ()=>{
            if(GameUI.CustomUIConfig().ToggleAbilitiesReorder){
                GameUI.CustomUIConfig().ToggleAbilitiesReorder()
            }
        }
    },
    OpenWiki: {
        DefaultBind: undefined,
        Func: ()=>{
            if(GameUI.CustomUIConfig().ToggleWiki){
                GameUI.CustomUIConfig().ToggleWiki(true)
            }
        }
    },
    OpenBans: {
        DefaultBind: undefined,
        Func: ()=>{
            // Вызываем функцию напрямую через CustomUIConfig
            if(GameUI.CustomUIConfig().ToggleBansMenu){
                GameUI.CustomUIConfig().ToggleBansMenu()
            }
        }
    },
    OpenNotifications: {
        DefaultBind: undefined,
        Func: ()=>{
            if(GameUI.CustomUIConfig().ToggleNotifications){
                GameUI.CustomUIConfig().ToggleNotifications()
            }
        }
    },
    OpenBonusStash: {
        DefaultBind: undefined,
        Func: ()=>{
            if(GameUI.CustomUIConfig().ToggleStash){
                GameUI.CustomUIConfig().ToggleStash()
            }
        }
    },
}

let AbilitiesSettings = {}


    // let BindsObject = v.keybinds || {}
    // let QuickcastObject = v.quickcasts || {}
    
    // for (const BindName in CustomBinds) {
    //     AbilitiesSettings[BindName] = {
    //         Bind: "",
    //         Quickcast: false,
    //         IsCustom: true,
    //     }

    //     if(BindsObject[BindName] || CustomBinds[BindName].DefaultBind != undefined){
    //         let Bind = BindsObject[BindName]
    //         if(Bind == undefined){
    //             Bind = CustomBinds[BindName].DefaultBind
    //         }

    //         Bind = GetEnglishButton(Bind)

    //         if(!IsKeyBindLocked(Bind)){

    //             AbilitiesSettings[BindName].Bind = Bind

    //             SetKeyBindButton(BindName, Bind, CustomBinds[BindName].Func)
    //             // if (Bind != "space" && english_language_button[Bind])
    //             // {
    //             //     SetKeyBindButton(BindName, english_language_button[Bind], CustomBinds[BindName].Func)  
    //             // }
    //         }
    //     }

    //     UpdateBindButton(BindName, true)
    // }

    // for (let i = 1; i <= 10; i++) {
    //     AbilitiesSettings[i] = {
    //         Bind: "",
    //         Quickcast: false,
    //     }

    //     let BindName = BindsObject[i]
    //     if(BindName != null && BindName != ""){
    //         let Bind = GetEnglishButton(BindName)
    //         if (!IsKeyBindLocked(Bind))
    //         {   
    //             AbilitiesSettings[i].Bind = Bind
    //             SetKeyBindButton(i, Bind)
    //         }
    //     }

    //     let bQuickcastEnabled = QuickcastObject[i]
    //     if(bQuickcastEnabled != null){
    //         AbilitiesSettings[i].Quickcast = bQuickcastEnabled == 1
    //     }

    //     UpdateBindButton(i)
    // }

function UpdateBindButton(ability_num, bIsCustom)
{
    let panel = GetOrCreateKeyBind(ability_num, bIsCustom)

    panel.SetHasClass("IsCustom", bIsCustom == true)
    
    // Определяем к какому табу относится этот бинд
    // ability_num 1-10 соответствуют способностям 7-16 (обычные бинды)
    // bIsCustom === true - это кастомные бинды (F-клавиши и т.д.)
    let isAbilityBind = !bIsCustom && ability_num >= 1 && ability_num <= 10
    let shouldShow = false
    
    if (currentKeybindTab === "abilities") {
        // Таб "Способности": показываем только способности 7-16 (keybind 1-10)
        shouldShow = isAbilityBind
    } else {
        // Таб "Другое": показываем только кастомные бинды
        shouldShow = bIsCustom
    }
    
    panel.SetHasClass("Hidden", !shouldShow)

    let BindName = ""

    if (AbilitiesSettings[ability_num])
    {
        BindName = AbilitiesSettings[ability_num].Bind.toUpperCase();
    }

    if(!bIsCustom){
        let KeybindCheckbox = panel.FindChildTraverse("KeybindCheckbox")
        if(KeybindCheckbox){
            KeybindCheckbox.SetSelected(AbilitiesSettings[ability_num].Quickcast == 1)
        }
    }

    let CustomBinder = panel.FindChildTraverse("CustomBinder")
    if(CustomBinder){
        CustomBinder.LastKeyBind = BindName
        CustomBinder.SetDialogVariable("keybind", BindName)
    }
}

function GetOrCreateKeyBind(ability_num, bIsCustom){
    let f = SettingsKeybindsList.FindChildTraverse(`Keybind_${ability_num}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", SettingsKeybindsList, `Keybind_${ability_num}`)
        panel.BLoadLayoutSnippet("KeyBind")

        panel.SetDialogVariable("keybind_name", $.Localize("#keybind_" + ability_num))

        let CustomBinder = panel.FindChildTraverse("CustomBinder")
        if(CustomBinder){ 
            CustomBinder.SetPanelEvent("onactivate", function() {
                SetPreActivateBind(panel, ability_num, bIsCustom)
            })
        }

        if(!bIsCustom){
            let BindQuickcast = panel.FindChildTraverse("BindQuickcast")
            if(BindQuickcast){
                BindQuickcast.SetPanelEvent("onactivate", function(){
                    OnKeyBindQuickcast(panel, ability_num, true)
                })
            }

            let KeybindCheckbox = panel.FindChildTraverse("KeybindCheckbox")
            if(KeybindCheckbox){
                KeybindCheckbox.SetPanelEvent("onactivate", function(){
                    OnKeyBindQuickcast(panel, ability_num, false)
                })
            }
        }

        return panel
    }
}

function OnKeyBindQuickcast(panel, ability_num, bIsLabel){
    let KeybindCheckbox = panel.FindChildTraverse("KeybindCheckbox")
    if(!KeybindCheckbox){
        return
    }

    if(bIsLabel){
        KeybindCheckbox.SetSelected(!KeybindCheckbox.IsSelected())
    }

    let Selected = KeybindCheckbox.IsSelected()

    if(AbilitiesSettings[ability_num]){
        AbilitiesSettings[ability_num].Quickcast = Selected

        GameEvents.SendCustomGameEventToServer("custom_keybind_quickcast_changed", { bind_num: ability_num, enabled: Selected });
    }
}

function SetPreActivateBind(panel, BindName, bIsCustom)
{
    ResetKeyBind(BindName, bIsCustom)

    let CustomKeybindEntry = panel.FindChildTraverse("CustomKeybindEntry")
    if(CustomKeybindEntry){
        CustomKeybindEntry.text = ""
        CustomKeybindEntry.SetFocus()
    }

    let CustomBinder = panel.FindChildTraverse("CustomBinder")
    if(CustomBinder){ 
        CustomBinder.SetHasClass("ActiveBind", true)
        CustomBinder.SetDialogVariable("keybind", "")
    }
    if(CustomKeybindEntry && CustomBinder){
        CustomKeybindEntry._bPrevIsDropDown = false
        CheckFocusPanel(CustomKeybindEntry, CustomBinder)
        CustomKeybindEntry.SetPanelEvent("ontextentrychange", function () 
        {
            if(CustomKeybindEntry){
                // let bIsEnglish = /^[A-Za-z0-9 !"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]$/.test(CustomKeybindEntry.text)
                // if(!bIsEnglish && CustomKeybindEntry.text != ""){
                //     CustomKeybindEntry.text = ""
                // }
                let Bind = CustomKeybindEntry.text
                if(Bind != ""){

                    if(Bind == " "){
                        Bind = "space"
                    }
                    Bind = GetEnglishButton(Bind)
                    OnSubmitted(panel, BindName, Bind, bIsCustom)
                }
            }
        })

        let DropDown = panel.FindChildTraverse("DropDownBinds")
        if(DropDown){
            DropDown.SetPanelEvent("oninputsubmit", function () 
            {
                let SelectedOption = DropDown.GetSelected()
                if(SelectedOption){
                    let Bind = SelectedOption.id.replace("Bind_", "")
                    if(Bind != "-"){
                        OnSubmitted(panel, BindName, Bind, bIsCustom)
                    }else if(!DropDown._bAuto){
                        $.DispatchEvent("SetInputFocus", CustomKeybindEntry)
                    }
                }
            })
        }
    }
}

function OnSubmitted(panel, BindName, Bind, bIsCustom)
{
    if(!AbilitiesSettings[BindName]){return}

    let DropDown = panel.FindChildTraverse("DropDownBinds")
    if(DropDown){
        DropDown._bAuto = true
        DropDown.SetSelectedIndex(0)
        DropDown._bAuto = false
    }

    let CurrentBind = Bind

    if (IsDefaultKeyBindLocked(CurrentBind))
    {
        let CustomBinder = panel.FindChildTraverse("CustomBinder")
        if(CustomBinder){ 
            CustomBinder.SetHasClass("ActiveBind", false)
        }
        $.DispatchEvent("DropInputFocus")

        EmitErrorToPlayer("#dota_hud_error_binded_by_dota", "UUI_SOUNDS.NoGold")

        return
    }

    if(IsCustomKeyBindLocked(CurrentBind)){
        for (const CustomBindName in AbilitiesSettings) {
            let Info = AbilitiesSettings[CustomBindName]
            if(Info && Info.Bind.toUpperCase() == CurrentBind){
                AbilitiesSettings[CustomBindName].Bind = ""
                UpdateBindButton(CustomBindName, Info.IsCustom)

                GameEvents.SendCustomGameEventToServer("custom_keybind_changed", { bind_num: CustomBindName, key: "" });
            }
        }
    }

    AbilitiesSettings[BindName].Bind = CurrentBind

    let CustomBinder = panel.FindChildTraverse("CustomBinder")
    if(CustomBinder){ 
        CustomBinder.SetHasClass("ActiveBind", false)
        CustomBinder.LastKeyBind = CurrentBind
        CustomBinder.SetDialogVariable("keybind", CurrentBind)
    }
    $.DispatchEvent("DropInputFocus")

    let Func = undefined
    if(bIsCustom){
        Func = CustomBinds[BindName]
    }

    if (CurrentBind != "")
    {
        GameEvents.SendCustomGameEventToServer("custom_keybind_changed", { bind_num: BindName, key: CurrentBind });
        SetKeyBindButton(BindName, CurrentBind, Func)
        // if (CurrentBind != "space" && english_language_button[CurrentBind])
        // {
        //     SetKeyBindButton(BindName, english_language_button[CurrentBind], Func)  
        // }
    }
    else
    {
        GameEvents.SendCustomGameEventToServer("custom_keybind_changed", { bind_num: BindName, key: "" });
    }
}

function CheckFocusPanel(panel, button_panel)
{
    if (panel.BHasKeyFocus() || (button_panel.FindChildTraverse("DropDownBinds") && button_panel.FindChildTraverse("DropDownBinds").BHasClass("DropDownMenuVisible")))
    {
        if(button_panel.FindChildTraverse("DropDownBinds") && button_panel.FindChildTraverse("DropDownBinds").BHasClass("DropDownMenuVisible")){
            panel._bPrevIsDropDown = true
        }else{
            panel._bPrevIsDropDown = false
        }
        $.Schedule( 1/144, () => 
        { 
            CheckFocusPanel(panel, button_panel)
        })
        return
    }else if(panel._bPrevIsDropDown){
        $.DispatchEvent("SetInputFocus", panel)

        $.Schedule( 1/144, () => 
        { 
            CheckFocusPanel(panel, button_panel)
        })
        return
    }

    button_panel.SetHasClass("ActiveBind", false)
    if(button_panel.LastKeyBind != undefined){
        button_panel.SetDialogVariable("keybind", button_panel.LastKeyBind)
    }
}

function UpdateSkillBar()
{
    let hud_abilities = GetDotaHud()
    let hud_abilities_panel = hud_abilities.FindChildTraverse("abilities")
    let ability_list = GetAbilityList()
    if (hud_abilities_panel && hud_abilities_panel.GetChildCount() > 6) 
    {
        for (let i = 6; i < hud_abilities_panel.GetChildCount(); i++) 
        {
            let ability_panel = hud_abilities_panel.GetChild(i)
            if (ability_panel)
            {
                let Hotkey = ability_panel.FindChildTraverse("Hotkey")
                let HotkeyText = ability_panel.FindChildTraverse("HotkeyText")
                let ability_name = ability_panel.FindChildTraverse("AbilityImage").abilityname
                for (let keybind_name = 7; keybind_name <= 16; keybind_name++) {
                    if (ability_name && ability_name == ability_list[keybind_name] && BINDS_LIST["ability_"+keybind_name] != undefined && BINDS_LIST["ability_"+keybind_name].CurrentBind != undefined)
                    {  
                        if (HotkeyText)
                        {
                            HotkeyText.text = String(BINDS_LIST["ability_"+keybind_name].CurrentBind).toUpperCase()
                        }
                        if (Hotkey)
                        {
                            Hotkey.style.visibility = "visible"
                        }
                        break
                    }
                    else
                    {
                        if (HotkeyText)
                        {
                            HotkeyText.text = ""
                        }
                        if (Hotkey)
                        {
                            Hotkey.style.visibility = "collapse"
                        }
                    }
                }
            }
        }
    }
    
    $.Schedule(1, UpdateSkillBar)
}

function GetAbilityList()
{
    let ability_list = {}
    let playerHeroIndex = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID());
    let ability_index = 7
    for (let i = 6; i <= 30; i++) 
    {
        let ability = Entities.GetAbility(playerHeroIndex, i);
        let abilityName = Abilities.GetAbilityName(ability);
        if (IsValidAbilityCheck(ability)) 
        {
        	ability_list[ability_index] = abilityName
            ability_index++;
        }      
    }
    return ability_list
}

function IsValidAbilityCheck(abilityIndex) 
{
    let result = false;
    let abilityName = Abilities.GetAbilityName(abilityIndex);
    if (abilityName != null && abilityName != "" && abilityName.substring(0, 14) != "special_bonus_" && abilityName != "generic_hidden" )
    {
        if (!Abilities.IsHidden(abilityIndex))
        {
            result = true;
        }
        if(IsOtherAbility(abilityName)){
            if (bitAnd(Abilities.GetBehavior( abilityIndex ), DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_PASSIVE) == DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_PASSIVE)
            {
                result = false;
            }
        }
    }
    return result;
}

function bitAnd(a, b) 
{
    return a & b;
}

function SetKeyBindButton(BindName, button_keypad, func)
{
    const name_bind = "KeyBind_Custom_" + Math.floor(Math.random() * 99999999);
    Game.CreateCustomKeyBind(button_keypad.toUpperCase(), "+"+name_bind);
    Game.AddCommand("+"+name_bind, () =>
    {
        if(func){
            func(BindName)
        }else{
            UseAbility(BindName, true)
        }
    }, "", 0);
    Game.AddCommand("-"+name_bind, () => 
    {
        if(!func){
            UseAbility(BindName, false)
        }
    }, "", 0);
}

function UseAbility(ability_num, down)
{
    let Quickcast = AbilitiesSettings[ability_num] ? AbilitiesSettings[ability_num].Quickcast : 0
    let ability_list = GetAbilityList()
    let ability_name_in_skill = ability_list[ability_num]
    if (ability_name_in_skill != "none")
    {
        CastAbility(
            Entities.GetAbilityByName( Players.GetLocalPlayerPortraitUnit(), ability_name_in_skill ), 
            Players.GetLocalPlayerPortraitUnit(), 
            Quickcast, 
            GameUI.IsShiftDown(),
            down
        )
    }
}

function ResetKeyBind(ability_num, bIsCustom)
{
    if(!AbilitiesSettings[ability_num] || AbilitiesSettings[ability_num].Bind == ""){return}

    let key_bind_name = AbilitiesSettings[ability_num].Bind.toUpperCase()
    const name_bind = "KeyBind_Custom_" + Math.floor(Math.random() * 99999999);
    Game.AddCommand(name_bind, () => {}, "", 0);
    Game.CreateCustomKeyBind(key_bind_name, name_bind);
    AbilitiesSettings[ability_num].Bind = ""
}

function GetGameKeybind(command) 
{
    if (command == null || command == undefined)
    {
        return ""
    }
    return Game.GetKeybindForCommand(command).toLowerCase();
}

function IsKeyBindLocked(button)
{
    if(button == undefined || typeof(button) != "string"){return true}

    button = button.replace(/alt-/g, '')
    button = button.replace(/ctrl-/g, '')
    for (button_original of LOCKED_KEY_BINDS)
    {
        if (button_original.toUpperCase() == button.toUpperCase())
        {
            return true
        }
    }
    for (button_original in AbilitiesSettings)
    {
        let button_name = AbilitiesSettings[button_original].Bind
        if (button_name.toUpperCase() == button.toUpperCase())
        {
            return true
        }
    }
    return false
}

function IsDefaultKeyBindLocked(button)
{
    if(button == undefined || typeof(button) != "string"){return true}
    button = button.replace(/alt-/g, '')
    button = button.replace(/ctrl-/g, '')
    for (button_original of LOCKED_KEY_BINDS)
    {
        if (button_original.toUpperCase() == button.toUpperCase())
        {
            return true
        }
    }
    return false
}

function IsCustomKeyBindLocked(button)
{
    if(button == undefined || typeof(button) != "string"){return true}

    button = button.replace(/alt-/g, '')
    button = button.replace(/ctrl-/g, '')
    for (BindName in BINDS_LIST)
    {
        let CurrentBind = BINDS_LIST[BindName].CurrentBind
        if (CurrentBind && CurrentBind.toUpperCase() == button.toUpperCase())
        {
            return true
        }
    }
    return false
}

function GetCustomKeyBindLockedExcept(button, FindBindName)
{
    if(button == undefined || typeof(button) != "string"){return true}

    button = button.replace(/alt-/g, '')
    button = button.replace(/ctrl-/g, '')
    for (BindName in BINDS_LIST)
    {
        let CurrentBind = BINDS_LIST[BindName].CurrentBind
        if (CurrentBind && CurrentBind.toUpperCase() == button.toUpperCase() && BindName != FindBindName)
        {
            return BindName
        }
    }
    return undefined
}

// ===== ТАБЫ ДЛЯ КЛАВИШ =====
function SwitchKeybindTab(tab) {
    currentKeybindTab = tab
    
    // Переключаем активный класс на табах
    $("#TabAbilities").SetHasClass("Active", tab === "abilities")
    $("#TabOther").SetHasClass("Active", tab === "other")
    
    // Обновляем отображение клавиш
    for (const BindName in CustomBinds) {
        UpdateBindButton(BindName, true)
    }
    
    for (let i = 1; i <= 10; i++) {
        UpdateBindButton(i)
    }
}

let BINDS_LIST = {
    ability_7:{
        BindType: "Abilities",
        DefaultBind: undefined,

        AbilityNum: 1,

        Func: (down)=>{CastBonusAbility("ability_7", down)},

        Quickcast: false,
        CurrentBind: undefined,
    },
    ability_8:{
        BindType: "Abilities",
        DefaultBind: undefined,

        AbilityNum: 2,

        Func: (down)=>{CastBonusAbility("ability_8", down)},

        Quickcast: false,
        CurrentBind: undefined,
    },
    ability_9:{
        BindType: "Abilities",
        DefaultBind: undefined,

        AbilityNum: 3,

        Func: (down)=>{CastBonusAbility("ability_9", down)},

        Quickcast: false,
        CurrentBind: undefined,
    },
    ability_10:{
        BindType: "Abilities",
        DefaultBind: undefined,

        AbilityNum: 4,

        Func: (down)=>{CastBonusAbility("ability_10", down)},

        Quickcast: false,
        CurrentBind: undefined,
    },
    ability_11:{
        BindType: "Abilities",
        DefaultBind: undefined,

        AbilityNum: 5,

        Func: (down)=>{CastBonusAbility("ability_11", down)},

        Quickcast: false,
        CurrentBind: undefined,
    },
    ability_12:{
        BindType: "Abilities",
        DefaultBind: undefined,

        AbilityNum: 6,

        Func: (down)=>{CastBonusAbility("ability_12", down)},

        Quickcast: false,
        CurrentBind: undefined,
    },
    ability_13:{
        BindType: "Abilities",
        DefaultBind: undefined,

        AbilityNum: 7,

        Func: (down)=>{CastBonusAbility("ability_13", down)},

        Quickcast: false,
        CurrentBind: undefined,
    },
    ability_14:{
        BindType: "Abilities",
        DefaultBind: undefined,

        AbilityNum: 8,

        Func: (down)=>{CastBonusAbility("ability_14", down)},

        Quickcast: false,
        CurrentBind: undefined,
    },
    ability_15:{
        BindType: "Abilities",
        DefaultBind: undefined,

        AbilityNum: 9,

        Func: (down)=>{CastBonusAbility("ability_15", down)},

        Quickcast: false,
        CurrentBind: undefined,
    },
    ability_16:{
        BindType: "Abilities",
        DefaultBind: undefined,

        AbilityNum: 10,

        Func: (down)=>{CastBonusAbility("ability_16", down)},

        Quickcast: false,
        CurrentBind: undefined,
    },

    // MovePanels: {
    //     BindType: "Other",
    //     DefaultBind: undefined,

    //     Func: (down)=>{
    //         if(!down){return}

    //         if(GameUI.CustomUIConfig().TogglePanelsMove == undefined){
    //             GameUI.CustomUIConfig().TogglePanelsMove = false
    //         }
    //         GameUI.CustomUIConfig().TogglePanelsMove = !GameUI.CustomUIConfig().TogglePanelsMove 

    //         if(GameUI.CustomUIConfig().MakeDescVisible){
    //             GameUI.CustomUIConfig().MakeDescVisible(GameUI.CustomUIConfig().TogglePanelsMove)
    //         }
    //     },

    //     CurrentBind: undefined,
    // },
    MoveAbilities: {
        BindType: "Other",
        DefaultBind: "F8",

        Func: (down)=>{
            if(!down){return}

            if(GameUI.CustomUIConfig().ToggleAbilitiesReorder){
                GameUI.CustomUIConfig().ToggleAbilitiesReorder()
            }
        },

        CurrentBind: undefined,
    },
    OpenWiki: {
        BindType: "Other",
        DefaultBind: undefined,

        Func: (down)=>{
            if(!down){return}

            if(GameUI.CustomUIConfig().ToggleWiki){
                GameUI.CustomUIConfig().ToggleWiki(true)
            }
        },

        CurrentBind: undefined,
    },
    OpenBans: {
        BindType: "Other",
        DefaultBind: undefined,

        Func: (down)=>{
            if(!down){return}

            // Вызываем функцию напрямую через CustomUIConfig
            if(GameUI.CustomUIConfig().ToggleBansMenu){
                GameUI.CustomUIConfig().ToggleBansMenu()
            }
        },

        CurrentBind: undefined,
    },
    OpenNotifications: {
        BindType: "Other",
        DefaultBind: undefined,

        Func: (down)=>{
            if(!down){return}

            if(GameUI.CustomUIConfig().ToggleNotifications){
                GameUI.CustomUIConfig().ToggleNotifications()
            }
        },
        
        CurrentBind: undefined,
    },
    OpenBonusStash: {
        BindType: "Other",
        DefaultBind: undefined,

        Func: (down)=>{
            if(!down){return}

            if(GameUI.CustomUIConfig().ToggleStash){
                GameUI.CustomUIConfig().ToggleStash()
            }
        },

        CurrentBind: undefined,
    },
}

const KeybindsTabs = $("#KeybindsTabs")

let CurrentOpenedBindTab = ""

OpenBindTab("Abilities")

UpdateSkillBar()

let PLAYER_SETTINGS_DATA = {}
// [keybind-default] Какие дефолтные бинды уже отправлены на сохранение в БД в этой сессии —
// чтобы не слать повторно до round-trip'а (после него значение придёт из БД).
let _defaultsSavedToDB = {}
SubscribeAndFirePlayerTableByKey(`player_${Players.GetLocalPlayer()}`, `setting_data`, function(v){
    PLAYER_SETTINGS_DATA = v

    if(PLAYER_SETTINGS_DATA){
        // keybinds у нового игрока может прийти пустым/undefined (в БД NULL или []),
        // но дефолты (DefaultBind, напр. MoveAbilities=F8) всё равно должны примениться.
        let _keybinds = PLAYER_SETTINGS_DATA.keybinds || {}
        for (const BindName in BINDS_LIST) {
            let PlayerBind = _keybinds[BindName]

            let Bind = PlayerBind
            if(Bind == undefined){
                Bind = BINDS_LIST[BindName].DefaultBind
                // Нет сохранённого бинда, но есть дефолт → СРАЗУ пишем его в БД
                // (custom_keybind_changed → сервер OnPlayerChangeKeyBind → сохранение), чтобы при
                // следующем заходе значение читалось из БД, а не применялось локально. Гард не даёт
                // дублировать до round-trip'а; на след. сессии PlayerBind придёт из БД → ветка не сработает.
                if(Bind != undefined && !_defaultsSavedToDB[BindName]){
                    _defaultsSavedToDB[BindName] = true
                    GameEvents.SendCustomGameEventToServer("custom_keybind_changed", { bind_num: BindName, key: Bind })
                }
            }

            Bind = GetEnglishButton(Bind)

            if(!IsKeyBindLocked(Bind)){
                BINDS_LIST[BindName].CurrentBind = Bind
                SetBind(Bind, BINDS_LIST[BindName].Func)
            }
        }
    }

    if(PLAYER_SETTINGS_DATA && PLAYER_SETTINGS_DATA.quickcasts){
        for (const BindName in BINDS_LIST) {
            let PlayerQuickcast = PLAYER_SETTINGS_DATA.quickcasts[BindName]
            if(PlayerQuickcast != undefined){
                BINDS_LIST[BindName].Quickcast = PlayerQuickcast == 1
            }
        }
    }

    LoadBindsByTab()

    UpdateAbilityOrderSubTitle()
})

function UpdateAbilityOrderSubTitle(){
    let label = $("#AbilityOrderSubTitle")
    if(!label || !label.IsValid()) return

    let bind = BINDS_LIST["MoveAbilities"] && BINDS_LIST["MoveAbilities"].CurrentBind
    if(bind && bind != ""){
        label.text = "Используйте стрелки или нажмите " + bind.toUpperCase() + " чтоб поменять порядок способностей"
    }else{
        label.text = "Назначьте кнопку перемещения способностей в настройке клавиш в разделе другое или же используйте стрелки для перемещения способностей"
    }
}

function IsValidAbilityForBind(iEntindex) 
{
    let abilityName = Abilities.GetAbilityName(iEntindex);
    if (abilityName && abilityName != "" && abilityName.substring(0, 14) != "special_bonus_" && abilityName!= "generic_hidden" )
    {
        if (!Abilities.IsHidden(iEntindex))
        {
            return true
        }
        if(IsOtherAbility(abilityName)){
            if (bitAnd(Abilities.GetBehavior( iEntindex ), DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_PASSIVE) == DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_PASSIVE)
            {
                return false
            }
        }
    }
    return false
}

function GetAbilityByNum(iNum)
{
    let PlayerHero = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID());
    let j = 1
    for (let i = 6; i <= 30; i++) 
    {
        let iEntindex = Entities.GetAbility(PlayerHero, i);
        if (IsValidAbilityForBind(iEntindex)) 
        {
            if(j == iNum){
                return iEntindex
            }

            j++;
        }      
    }
    return undefined
}

function SetBind(KeyName, func)
{
    if(!func){return}

    const name_bind = "KeyBind_Custom_" + Math.floor(Math.random() * 99999999);
    Game.CreateCustomKeyBind(KeyName.toUpperCase(), "+"+name_bind);
    Game.AddCommand("+"+name_bind, () =>
    {
        func(true)
    }, "", 0);
    Game.AddCommand("-"+name_bind, () => 
    {
        func(false)
    }, "", 0);
}

function CastBonusAbility(BindName, bKeyDown){
    if(!BINDS_LIST[BindName] || BINDS_LIST[BindName].BindType != "Abilities") {return}

    let bQuickCast = BINDS_LIST[BindName].Quickcast
    let iAbilityIndex = GetAbilityByNum(BINDS_LIST[BindName].AbilityNum)
    if (iAbilityIndex != undefined)
    {
        CastAbility(
            iAbilityIndex, 
            Players.GetLocalPlayerPortraitUnit(), 
            bQuickCast, 
            GameUI.IsShiftDown(),
            bKeyDown
        )
    }
}

function OpenBindTab(Tab){
    if(CurrentOpenedBindTab == Tab){
        return
    }

    CurrentOpenedBindTab = Tab

    for (let i = 0; i < KeybindsTabs.GetChildCount(); i++) {
        const Child = KeybindsTabs.GetChild(i)
        if(Child){
            Child.SetHasClass("Selected", Child.id == `Tab${Tab}`)
        }
    }

    SettingsKeybindsList.RemoveAndDeleteChildren()

    LoadBindsByTab()
}

function LoadBindsByTab(){
    let List = Object.keys(BINDS_LIST)
    let conds = []
    conds.push(item => BINDS_LIST[item] && BINDS_LIST[item].BindType == CurrentOpenedBindTab )

    List = filterItems(List, conds)

    for (const BindName of List) {
        let BindInfo = BINDS_LIST[BindName]

        if(!BindInfo){continue}

        let p = GetOrCreateKeyBindPanel(BindInfo, BindName)

        p.SetDialogVariable("keybind", BindInfo.CurrentBind ?? "")

        if(BindInfo.BindType == "Abilities"){
            let AbilityInSlot = GetAbilityByNum(BindInfo.AbilityNum)
            p.SetHasClass("IsEmptyAbility", !(AbilityInSlot && AbilityInSlot != -1))

            if(AbilityInSlot && AbilityInSlot != -1){
                let BindAbilityImage = p.FindChildTraverse("BindAbilityImage")
                if(BindAbilityImage){
                    BindAbilityImage.abilityname = Abilities.GetAbilityName(AbilityInSlot)
                }
            }

            let KeyBindQuickcastCheckbox = p.FindChildTraverse("KeyBindQuickcastCheckbox")
            if(KeyBindQuickcastCheckbox){
                KeyBindQuickcastCheckbox.SetSelected(BindInfo.Quickcast)
            }
        }
    }
}

function GetOrCreateKeyBindPanel(BindInfo, BindName){
    let f = SettingsKeybindsList.FindChildTraverse(`Keybind_${BindName}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", SettingsKeybindsList, `Keybind_${BindName}`)
        panel.BLoadLayoutSnippet("KeyBindPanel")

        panel.SetDialogVariable("keybind_name", $.Localize("#keybind_" + BindName))

        panel.SetHasClass("IsAbility", BindInfo.BindType == "Abilities")
        panel.SetHasClass("IsBasic", BindInfo.BindType != "Abilities")

        let KeyBindPanel = panel.FindChildTraverse("KeyBindPanel")
        if(KeyBindPanel){ 
            KeyBindPanel.SetPanelEvent("onactivate", function() {
                if(GameUI.CustomUIConfig().OpenKeyBindSetter){
                    GameUI.CustomUIConfig().OpenKeyBindSetter()
                }
                if(GameUI.CustomUIConfig().SetupKeyBindSetter){
                    GameUI.CustomUIConfig().SetupKeyBindSetter((MainPanel)=>{
                        MainPanel._CurrentBind = undefined
                        MainPanel._needFocus = true
                        MainPanel.SetDialogVariable("keybind_name", $.Localize("#keybind_" + BindName))
                        MainPanel.SetDialogVariable("keybind", BindInfo.CurrentBind ?? "...")

                        let CustomKeybindEntry = MainPanel.FindChildTraverse("CustomKeybindEntry")
                        if(CustomKeybindEntry){
                            CustomKeybindEntry.text = ""
                            CustomKeybindEntry.SetFocus()

                            FocusUpdater(MainPanel, CustomKeybindEntry)
                            CustomKeybindEntry.SetPanelEvent("ontextentrychange", function () 
                            {
                                if(CustomKeybindEntry && MainPanel._needFocus){
                                    // let bIsEnglish = /^[A-Za-z0-9 !"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]$/.test(CustomKeybindEntry.text)
                                    // if(!bIsEnglish && CustomKeybindEntry.text != ""){
                                    //     CustomKeybindEntry.text = ""
                                    // }
                                    let Bind = CustomKeybindEntry.text
                                    if(Bind != ""){
                                        CustomKeybindEntry.text = ""
                                        if(Bind == " "){
                                            Bind = "space"
                                        }
                                        Bind = GetEnglishButton(Bind)
                                        OnKeySubmited(BindInfo, BindName, MainPanel, Bind)
                                        // OnSubmitted(panel, BindName, Bind, bIsCustom)
                                    }
                                }
                            })

                            let DropDown = MainPanel.FindChildTraverse("DropDownBinds")
                            if(DropDown){
                                DropDown.SetSelectedIndex(0)

                                DropDown.SetPanelEvent("oninputsubmit", function () 
                                {
                                    let SelectedOption = DropDown.GetSelected()
                                    if(SelectedOption && MainPanel._needFocus){
                                        let Bind = SelectedOption.id.replace("Bind_", "")
                                        if(Bind != "-"){
                                            OnKeySubmited(BindInfo, BindName, MainPanel, Bind)
                                        }
                                    }
                                })
                            }
                        }

                        let SettingKeyBindSubmitButton = MainPanel.FindChildTraverse("SettingKeyBindSubmitButton")
                        if(SettingKeyBindSubmitButton){
                            SettingKeyBindSubmitButton.SetPanelEvent("onactivate", function(){
                                if(MainPanel._CurrentBind != undefined && MainPanel._needFocus && MainPanel._CurrentBind != BindInfo.CurrentBind){
                                    if(IsCustomKeyBindLocked(MainPanel._CurrentBind)){
                                        for (const CustomBindName in BINDS_LIST) {
                                            let Info = BINDS_LIST[CustomBindName]
                                            if(Info && Info.CurrentBind && Info.CurrentBind.toUpperCase() == MainPanel._CurrentBind){
                                                BINDS_LIST[CustomBindName].CurrentBind = ""

                                                GameEvents.SendCustomGameEventToServer("custom_keybind_changed", { bind_num: CustomBindName, key: "" });
                                            }
                                        }
                                    }

                                    let PrevBind = BINDS_LIST[BindName].CurrentBind

                                    BINDS_LIST[BindName].CurrentBind = MainPanel._CurrentBind

                                    if(PrevBind != undefined && !IsCustomKeyBindLocked(PrevBind)){
                                        ResetOldKeyBind(PrevBind)
                                    }
                                    GameEvents.SendCustomGameEventToServer("custom_keybind_changed", { bind_num: BindName, key: MainPanel._CurrentBind });

                                    LoadBindsByTab()
                                }
                                if(GameUI.CustomUIConfig().CloseKeyBindSetter){
                                    GameUI.CustomUIConfig().CloseKeyBindSetter()
                                }
                            })
                        }
                    })
                }
            })
        }

        if(BindInfo.BindType == "Abilities"){
            let KeyBindQuickcast = panel.FindChildTraverse("KeyBindQuickcast")
            if(KeyBindQuickcast){
                KeyBindQuickcast.SetPanelEvent("onactivate", function(){
                    OnToggleQuickcast(panel, BindName, true)
                })
            }

            let KeyBindQuickcastCheckbox = panel.FindChildTraverse("KeyBindQuickcastCheckbox")
            if(KeyBindQuickcastCheckbox){
                KeyBindQuickcastCheckbox.SetPanelEvent("onactivate", function(){
                    OnToggleQuickcast(panel, BindName, false)
                })
            }
        }

        return panel
    }
}

function OnKeySubmited(BindInfo, BindName, MainPanel, Bind){
    if(!IsDefaultKeyBindLocked(Bind)){
        MainPanel.SetDialogVariable("keybind", Bind)
        MainPanel._CurrentBind = Bind

        let OverrideBind = GetCustomKeyBindLockedExcept(Bind, BindName)

        MainPanel.SetHasClass("Overrides", OverrideBind != undefined)

        if(OverrideBind != undefined){
            MainPanel.SetDialogVariable("bind_name", $.Localize("#keybind_" + OverrideBind))
        }
    }else{
        EmitErrorToPlayer("#dota_hud_error_binded_by_dota", "UUI_SOUNDS.NoGold")
    }
}

function FocusUpdater(MainPanel, EntryPanel)
{
    if(MainPanel._needFocus){
        if(!(MainPanel.FindChildTraverse("DropDownBinds") && MainPanel.FindChildTraverse("DropDownBinds").BHasClass("DropDownMenuVisible"))){
            $.DispatchEvent("SetInputFocus", EntryPanel)
        }

        $.Schedule(1/144, () => 
        { 
            FocusUpdater(MainPanel, EntryPanel)
        })
    }
}

function ResetOldKeyBind(Bind)
{
    if(!Bind || typeof(Bind) != "string"){return}
    
    const name_bind = "KeyBind_Custom_" + Math.floor(Math.random() * 99999999);
    Game.AddCommand(name_bind, () => {}, "", 0);
    Game.CreateCustomKeyBind(Bind, name_bind);
}

function OnToggleQuickcast(panel, BindName, bIsLabel){
    let KeyBindQuickcastCheckbox = panel.FindChildTraverse("KeyBindQuickcastCheckbox")
    if(!KeyBindQuickcastCheckbox){
        return
    }

    if(bIsLabel){
        KeyBindQuickcastCheckbox.SetSelected(!KeyBindQuickcastCheckbox.IsSelected())
    }

    let Selected = KeyBindQuickcastCheckbox.IsSelected()

    if(BINDS_LIST[BindName]){
        BINDS_LIST[BindName].Quickcast = Selected

        GameEvents.SendCustomGameEventToServer("custom_keybind_quickcast_changed", { bind_num: BindName, enabled: Selected });
    }
}