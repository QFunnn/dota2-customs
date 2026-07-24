--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LOCAL_PID = Game.GetLocalPlayerID()
const AbilitySelectionMain = $("#AbilitySelectionMain")
const AbilitiesContainer = $("#AbilitiesContainer")
const AbilitySelectionBody = $("#AbilitySelectionBody")
const AbilitySelector_CloseButton = $("#AbilitySelector_CloseButton")
const CloseButton = $("#CloseButton")
const ItemInstance = $("#ItemInstance")
const AbilitySelectionHeader = $("#AbilitySelectionHeader")

let Cooldown = -1

const UNREMOVABLE_ABILITIES =
{
    "monkey_king_wukongs_command": true,
    "rubick_empty1" : true,
    "rubick_empty2" : true,
    "ability_marci_special_delivery" : true,
    "lone_druid_entangle" : true,
}

// SetupMovablePanel(AbilitySelectionMain, AbilitySelectionHeader, {align: [1,1], margin: [0,-45]})
 
let ABILITIES_INFO = {};
SubscribeAndFirePlayerTableByKey("globals", "abilities_info", function(v){
    ABILITIES_INFO = v
});

let SELECTION_INFO = {}
SubscribeAndFirePlayerTableByKey(`player_${LOCAL_PID}`, `ability_selection`, function(v){
    SELECTION_INFO = v

    UpdateSelection()
})

function UpdateSelection(){
    AbilitySelectionMain.SetHasClass("Show", SELECTION_INFO.state == "SHOW")

    let bIsReplacing = SELECTION_INFO.type != 1 && SELECTION_INFO.type != 2 && SELECTION_INFO.type_state == 0

    AbilitySelectionMain.SetHasClass("IsReplacing", bIsReplacing)
    AbilitySelectionMain.SetHasClass("IsDev", SELECTION_INFO.type == 7)
    AbilitySelectionMain.SetHasClass("HasInstance", SELECTION_INFO.sUsedItemName != undefined)

    AbilitySelectionMain.SetHasClass("Finished", SELECTION_INFO.state == "HIDE")

    if(SELECTION_INFO.sUsedItemName != undefined){
        ItemInstance.itemname = SELECTION_INFO.sUsedItemName
        AbilitySelectionMain.SetDialogVariable("item_instance_name", $.Localize(`#DOTA_Tooltip_ability_${SELECTION_INFO.sUsedItemName}`))
    }

    let t = bIsReplacing ? "replace" : "select"

    AbilitySelectionMain.SetDialogVariable("header", $.Localize(`#ABILITY_SELECTION_${t}`))
    AbilitySelectionMain.SetDialogVariable("desc", $.Localize(`#ABILITY_SELECTION_${t}_Desc`))

    UpdateToggleButton()
    UpdateCloseButton(bIsReplacing)

    if(SELECTION_INFO.state == "SHOW"){
        AbilitiesContainer.RemoveAndDeleteChildren()
        Game.EmitSound("ui.keybind_open")
    }

    let bEffectsEnabled = IsEffectsEnabled()

    if(SELECTION_INFO.abilities){
        let sssCount = SELECTION_INFO.sss_count || 0
        let idx = 0
        for (const _ in SELECTION_INFO.abilities) {
            let AbilityName = SELECTION_INFO.abilities[_]
            let isSSS = idx < sssCount

            try {
                UpdateAbilityByName(AbilityName, bEffectsEnabled, isSSS)
            } catch(e) {
                $.Msg("[UpdateAbility err]", AbilityName, " ", e)
            }
            idx++
        }
    }else{
        let Hero = Players.GetPlayerHeroEntityIndex(LOCAL_PID);

        for (let i = 0; i <= 32; i++) 
        {
            let Ability = Entities.GetAbility(Hero, i)
            let AbilityName = Abilities.GetAbilityName(Ability)
            if ( IsValidAbility(Ability) && UNREMOVABLE_ABILITIES[AbilityName] == undefined && IsAbilityUnlocked(AbilityName) && !Abilities.IsStolen(Ability))
            {
                UpdateAbilityByName(AbilityName, bEffectsEnabled)
            }
        }
    }

    if(SELECTION_INFO.state == "SHOW"){
        UpdateAbilityMask()
    }

    // $.Schedule(0.05, function(){
    //     AdjustMovablePanelPosition(AbilitySelectionMain)
    // })
}

function UpdateAbilityByName(AbilityName, bEffectsEnabled, isSSS){
    let p = GetOrCreateAbility(AbilityName)

    // Маркер «эта способность из гарантированного SSS-блока» — визуально выделяет
    // первые N способностей в окне выбора (см. css .Ability.IsSSS).
    p.SetHasClass("IsSSS", isSSS === true)

    let AbilityImage = p.FindChildTraverse("AbilityImage")
    if(AbilityImage){
        AbilityImage.abilityname = AbilityName

        SetShowAbility(AbilityImage, AbilityName)
    }

    UpdateAbilityColorEffect(p, AbilityName, bEffectsEnabled)

    p.SetDialogVariable("ability_name", $.Localize(`#DOTA_Tooltip_ability_${AbilityName}`))

    if(ABILITIES_INFO[AbilityName]){
        let i = 0
        for (const LinkedAbilityName in ABILITIES_INFO[AbilityName].LinkedAbilities) {
            if(i >= 3){break}

            let LinkedAbilityPanel = p.FindChildTraverse(`linked_ability_${i}`)
            if(LinkedAbilityPanel){
                LinkedAbilityPanel.abilityname = LinkedAbilityName
                LinkedAbilityPanel.AddClass("ActiveLinkedAbility")

                SetShowAbility(LinkedAbilityPanel, LinkedAbilityName)
            }

            i++;
        }
    }

    p.SetPanelEvent("onactivate", function(){
        if(!AbilitySelectionMain.BHasClass("Cooldown") && !AbilitySelectionMain.BHasClass("Finished")){
            GameEvents.SendCustomGameEventToServer("ability_selection_ability_selected", {abilityname: AbilityName});
            AbilitySelectionMain.AddClass("Finished")

            Game.EmitSound("General.SelectAction")
        }
    })

    p.SetPanelEvent("oncontextmenu", function(){
        if(SELECTION_INFO.type == 7 && !AbilitySelectionMain.BHasClass("Cooldown") && !AbilitySelectionMain.BHasClass("Finished")){
            GameEvents.SendCustomGameEventToServer("ability_selection_ability_selected", {abilityname: "DONT_DELETE"});
            AbilitySelectionMain.AddClass("Finished")

            Game.EmitSound("General.SelectAction")
        }
    })
}

function CloseAbilitySelect(){
    if(!AbilitySelectionMain.BHasClass("Cooldown") && !AbilitySelectionMain.BHasClass("Finished")){
        GameEvents.SendCustomGameEventToServer("ability_selection_ability_selected", {});
        AbilitySelectionMain.AddClass("Finished")

        Game.EmitSound("General.SelectAction")
    }
}

function HideAbilitySelect(){
    AbilitySelectionBody.ToggleClass("ToggledHide")
    AbilitySelector_CloseButton.SetHasClass("ToggledHide", AbilitySelectionBody.BHasClass("ToggledHide"))

    UpdateToggleButton()
}

function UpdateToggleButton(){
    let ToggledText = AbilitySelectionBody.BHasClass("ToggledHide") ? $.Localize("#AbilitySelection_Show") : $.Localize("#AbilitySelection_Hide")
    AbilitySelectionMain.SetDialogVariable("toggled_text", ToggledText)
}

function UpdateCloseButton(bIsReplacing){
    let ToggledText = bIsReplacing ? $.Localize("#AbilitySelection_Return") : $.Localize("#AbilitySelection_Random")
    AbilitySelectionMain.SetDialogVariable("close_text", ToggledText)

    let Desc = bIsReplacing ? $.Localize("#AbilityRelearnSelection_Description") : $.Localize("#AbilitySelection_Close_Description")
    AbilitySelector_CloseButton.SetPanelEvent("onmouseover", function(){
        $.DispatchEvent( "DOTAShowTextTooltip", AbilitySelector_CloseButton, Desc );
    });
    CloseButton.SetPanelEvent("onmouseover", function(){
        $.DispatchEvent( "DOTAShowTextTooltip", CloseButton, Desc );
    });
}

function GetOrCreateAbility(AbilityName){
	let f = AbilitiesContainer.FindChildTraverse(`ability_${AbilityName}`)
	if(f){
		return f
	}else{
		let p = $.CreatePanel("Panel", AbilitiesContainer, `ability_${AbilityName}`, {})
		p.BLoadLayoutSnippet("Ability")

		return p
	}
}

function IsEffectsEnabled(){
    let settings = GetPlayerTablesValue(`player_${Players.GetLocalPlayer()}`, "setting_data")

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
    // ВЕСЬ метод в try/catch — если падает, не блокируем дальнейший рендер
    // UpdateAbilityByName (иначе не выставится имя/onclick для этой способности).
    try {
        let color = null
        if(typeof GetAbilityHighlightColor === "function"){
            color = GetAbilityHighlightColor(ability_name)
        }

        ability_panel.SetHasClass("HasColor", color !== null)

        // AbilityColorFx — это КЛАСС не ID.
        let fxList = ability_panel.FindChildrenWithClassTraverse("AbilityColorFx")
        let fx = fxList && fxList[0]

        if(fx && fx.style){
            // washColor принимает #RRGGBB / #RRGGBBAA / rgb(a)(...). Кривые значения
            // (для части способностей цвет приходит в неподдерживаемом формате) роняют
            // парсер и сыпят "Failed to parse style value for washColor" — валидируем.
            let valid = color !== null && /^(#[0-9a-fA-F]{6}([0-9a-fA-F]{2})?|rgba?\([^)]*\))$/.test(String(color).trim())
            fx.style.washColor = valid ? color : ""
        }
    } catch(e){
        $.Msg("[HL-FX err]", ability_name, " ", String(e))
    }
}

// Перерисовка при появлении данных подписок (bans_categories, modified, settings).
// При первом открытии селектора bans_categories может ещё не быть загружен —
// без этого хука SSS-способности останутся без подсветки до следующего открытия.
function _zxcRerenderSelection(){
    if(typeof UpdateSelection === "function"){ UpdateSelection() }
}
SubscribeAndFirePlayerTableByKey("globals", "bans_categories", _zxcRerenderSelection)
SubscribeAndFirePlayerTableByKey("globals", "modified_abilities", _zxcRerenderSelection)
SubscribeAndFirePlayerTableByKey(`player_${Game.GetLocalPlayerID()}`, "setting_data", _zxcRerenderSelection)

// Локальные изменения настроек подсветки (палитра/тогглы в settings.js) —
// триггерят немедленную перерисовку без server roundtrip. См. ability_colors.js
// (GameUI.CustomUIConfig().OnHighlightChange / ApplyHighlightSetting).
let _cfg = GameUI.CustomUIConfig()
if(_cfg){
    if(!_cfg.HighlightChangeListeners) _cfg.HighlightChangeListeners = []
    _cfg.HighlightChangeListeners.push(_zxcRerenderSelection)
}

function SetShowAbility(panel, abilityname){
    panel.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowAbilityTooltip", panel, abilityname);
    });

    panel.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideAbilityTooltip");
    });
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

function UpdateAbilityMask() 
{
    if (Cooldown == -1){
        Cooldown = 0.8
    }

    var angle = Cooldown / 0.8 * 360;
    Cooldown = Cooldown - 0.04

    AbilitySelectionMain.SetHasClass("Cooldown", Cooldown > 0)
     
    if (Cooldown >= 0)
    {
        for (let i = 0; i <= AbilitiesContainer.GetChildCount(); i++){
            var child = AbilitiesContainer.GetChild(i);
            if (child){
                child.FindChildTraverse("CooldownOverlay").style.clip="radial( 50.0% 50.0%, 0.0deg, -"+angle+"deg)";
            }
        }
        $.Schedule(0.04, UpdateAbilityMask)
    }else{
        Cooldown = -1
    }
}