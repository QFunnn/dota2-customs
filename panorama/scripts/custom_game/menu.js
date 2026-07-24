--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LocalPlayerID = Players.GetLocalPlayer()

const MenuHeader = $("#MenuHeader")
const BattlePassBlockInfo = $("#BattlePassBlockInfo")
const DurationBattlePassPrice = $("#DurationBattlePassPrice")
const PlayerRankProfile = $("#PlayerRankProfile")

const MenuWindow = $("#MenuWindow")
const MainButtons = $("#MainButtons")
const Body = $("#Body")

const BattlePass = $("#BattlePass")
const Shop = $("#Shop")
const Inventory = $("#Inventory")
const ChatWheel = $("#ChatWheel")
const Leaderboard = $("#Leaderboard")
const Bans = $("#Bans")
// const Wiki = $("#Wiki")
const Settings = $("#Settings")
const BugReport = $("#BugReport")

const PromocodeTextEntry = $("#PromocodeTextEntry")
const SpecialNotification = $("#SpecialNotification")

let SpecialNotificationSchedule = -1
let LastClass = undefined


const AddCoinsMenu = $("#AddCoinsMenu")

const LoadingPanel = $("#LoadingPanel")
let LoadingSchedule = -1

const SettingKeyBindMenu = $("#SettingKeyBindMenu")

$.Schedule(0.1, SetupMenu);

SubscribeAndFireNetTableByKey("players_server_info", `player_${LocalPlayerID}`, function(v){
    player_table = v

    MenuHeader.SetDialogVariable("player_coins", v.profile.coins+"")

    let RatingText = `${$.Localize("#Score")}: ${v.profile.rating}`
    
    MenuHeader.SetDialogVariable("player_rating", RatingText)

    if (v.profile.rating_number_in_top > 0 && v.profile.rating_number_in_top <= 10 && v.profile.rating >= 5420) 
    {
        PlayerRankProfile.style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(10000) + '.png")';
    } else {
        PlayerRankProfile.style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(v.profile.rating) + '.png")';
    }

    MenuHeader.SetDialogVariable("player_rating_place", v.profile.rating_number_in_top + "")

    let bSubscribed = IsPlayerBattlePassSubscribedInTable(v)

    $.GetContextPanel().SetHasClass("local_player_battle_pass_subscribed", bSubscribed)

    if(bSubscribed){
        MenuHeader.SetDialogVariable("battle_pass_ends_in", `${v.profile.battle_pass.end_days} ${$.Localize("#bp_time_day")}`)
    }

    // DurationBattlePassPrice.SetHasClass("BattlePassActive", false)
    // BattlePassBlockInfo.SetHasClass("BattlePassActiveDuration", bSubscribed)

    // if(bSubscribed){
    //     let DaysText = ` ${$.Localize("#bp_time_rem")} ${v.profile.battle_pass.end_days} ${$.Localize("#bp_time_day")}`
    //     BattlePassBlockInfo.SetDialogVariable("battle_pass_days", DaysText)
    // }
})

function SetupMenu(){
    if(!BattlePass.BHasClass("BattlePassMenu")){
        BattlePass.BLoadLayout("file://{resources}/layout/custom_game/menu_pages/battle_pass.xml", false, false)
    }
    if(!Shop.BHasClass("ShopMenu")){
        Shop.BLoadLayout("file://{resources}/layout/custom_game/menu_pages/shop.xml", false, false)
    }
    if(!Inventory.BHasClass("InventoryMenu")){
        Inventory.BLoadLayout("file://{resources}/layout/custom_game/menu_pages/inventory.xml", false, false)
    }
    if(!ChatWheel.BHasClass("ChatWheelMenu")){
        ChatWheel.BLoadLayout("file://{resources}/layout/custom_game/menu_pages/chat_wheel.xml", false, false)
    }
    if(!Leaderboard.BHasClass("LeaderboardHUD")){
        Leaderboard.BLoadLayout("file://{resources}/layout/custom_game/menu_pages/leaderboard.xml", false, false)
    }
    // if(!Wiki.BHasClass("WikiMenu")){
    //     Wiki.BLoadLayout("file://{resources}/layout/custom_game/menu_pages/wiki.xml", false, false)
    // }
    if(!Bans.BHasClass("BansMenu")){
        Bans.BLoadLayout("file://{resources}/layout/custom_game/menu_pages/bans.xml", false, false)
    }
    if(!Settings.BHasClass("SettingsMenu")){
        Settings.BLoadLayout("file://{resources}/layout/custom_game/menu_pages/settings.xml", false, false)
    }
    if(!BugReport.BHasClass("BugReportMenu")){
        BugReport.BLoadLayout("file://{resources}/layout/custom_game/menu_pages/bug_report.xml", false, false)
    }
}

let CurrentOpenedPage = ""
OpenMenuPage("BattlePass")

function OpenMenuPage(page){
    if(CurrentOpenedPage == page){
        return false
    }

    CurrentOpenedPage = page
    ToggleAllExceptOf(page)

    return true
}

GameUI.CustomUIConfig().OpenMenuPageSpecial = OpenMenuPage

function ToggleMenu(bIsButton){
    if(bIsButton){
        // Закрываем Wiki если оно открыто
        if(GameUI.CustomUIConfig().CloseWiki){
            GameUI.CustomUIConfig().CloseWiki()
        }
        
        MenuWindow.SetFocus()
        MenuWindow.ToggleClass("Show")
    }else{
        MenuWindow.RemoveClass("Show")
    }

    if(!MenuWindow.BHasClass("Show")){
        for (let i = 0; i < Body.GetChildCount(); i++) {
            const Child = Body.GetChild(i)
            if(Child){
                if(Child.Data().OnUnLoad){
                    Child.Data().OnUnLoad()
                }
            }
        }
    }else if(CurrentOpenedPage != ""){
        let p = $(`#${CurrentOpenedPage}`)
        if(p && p.Data().OnLoad){
            p.Data().OnLoad()
        }
    }
}

// Функция для принудительного закрытия меню
function CloseMenu(){
    if(MenuWindow.BHasClass("Show")){
        MenuWindow.RemoveClass("Show")
        // Вызываем OnUnLoad для всех страниц
        for (let i = 0; i < Body.GetChildCount(); i++) {
            const Child = Body.GetChild(i)
            if(Child && Child.Data().OnUnLoad){
                Child.Data().OnUnLoad()
            }
        }
    }
}

GameUI.CustomUIConfig().ToggleMenu = ToggleMenu
GameUI.CustomUIConfig().CloseMenu = CloseMenu


function ToggleAllExceptOf(page){
    for (let i = 0; i < MainButtons.GetChildCount(); i++) {
        const Child = MainButtons.GetChild(i)
        if(Child){
            Child.SetHasClass("Toggled", Child.id == `${page}Button`)
        }
    }
    for (let i = 0; i < Body.GetChildCount(); i++) {
        const Child = Body.GetChild(i)
        if(Child){
            Child.SetHasClass("Toggled", Child.id == page)
            if(Child.id == page){
                if(Child.Data().OnLoad){
                    Child.Data().OnLoad()
                }
            }else{
                if(Child.Data().OnUnLoad){
                    Child.Data().OnUnLoad()
                }
            }
        }
    }
}

function UsePromocode(){
    let Code = PromocodeTextEntry.text
    PromocodeTextEntry.text = ""

    if(Code != ""){
        CreateLoading()
        GameEvents.SendCustomGameEventToServer( "server_on_player_use_promocode", {code: Code} )
    } 
}

GameEvents.Subscribe( 'menu_loading', CreateLoading );

function CreateLoading(event){
    Game.EmitSound("ui_hero_transition")

    let Duration = event ? event.duration ?? 10 : 10

    LoadingPanel.AddClass("ShowLoading")

    if(LoadingSchedule != -1){
        $.CancelScheduled(LoadingSchedule)
        LoadingSchedule = -1
    }

    LoadingSchedule = $.Schedule(Duration, function(){
        LoadingPanel.RemoveClass("ShowLoading")
    })
}

function CloseLoading(){
    if(LoadingSchedule != -1){
        $.CancelScheduled(LoadingSchedule)
        LoadingSchedule = -1
    }

    LoadingPanel.RemoveClass("ShowLoading")
}

GameEvents.Subscribe( 'menu_special_notification', CreateSpecialNotification );

function CreateSpecialNotification(event){

    CloseLoading()

    let Text = event.text
    let SpecialClass = event.class
    let Duration = event.duration ?? 3
    let Type = event.type

    if(Type == 2){
        Game.EmitSound("ui.trophy_levelup")
    }else{
        Game.EmitSound("Relic.Received")
    }

    if(Text != undefined){
        SpecialNotification.SetDialogVariable("special_notification_text", $.Localize(Text))
    }

    if(LastClass != undefined){
        SpecialNotification.RemoveClass(LastClass)
    }

    if(SpecialClass){
        SpecialNotification.AddClass(SpecialClass)

        LastClass = SpecialClass
    }

    SpecialNotification.AddClass("ShowSpecialNotification")

    if(SpecialNotificationSchedule != -1){
        $.CancelScheduled(SpecialNotificationSchedule)
        SpecialNotificationSchedule = -1
    }

    SpecialNotificationSchedule = $.Schedule(Duration, function(){
        SpecialNotification.RemoveClass("ShowSpecialNotification")
    })
}



function OpenAddCoins(){
    AddCoinsMenu.ToggleClass("ShowAddCoins")
}

function CloseAddCoins(){
    AddCoinsMenu.RemoveClass("ShowAddCoins")
}

$.RegisterForUnhandledEvent("DOTAUnhandledEscapeKey", function(){
    if(SettingKeyBindMenu.BHasClass("ShowKeyBindSetting")){
        CloseKeyBindSetter()
    }else{
        ToggleMenu(false)
    }
})

// Функция для переключения меню с банами из биндов
function ToggleBansMenu(){
    let wasOpen = MenuWindow && MenuWindow.BHasClass("Show")
    
    if(wasOpen){
        // Если меню было открыто - закрываем БЕЗ SetFocus
        MenuWindow.RemoveClass("Show")
        // Вызываем OnUnLoad для всех страниц
        for (let i = 0; i < Body.GetChildCount(); i++) {
            const Child = Body.GetChild(i)
            if(Child && Child.Data().OnUnLoad){
                Child.Data().OnUnLoad()
            }
        }
    }else{
        // Закрываем Wiki если оно открыто
        if(GameUI.CustomUIConfig().CloseWiki){
            GameUI.CustomUIConfig().CloseWiki()
        }
        
        // Если меню было закрыто - открываем и показываем баны
        MenuWindow.AddClass("Show")
        if(GameUI.CustomUIConfig().OpenMenuPageSpecial){
            GameUI.CustomUIConfig().OpenMenuPageSpecial("Bans")
        }
    }
}

// Регистрируем функцию для использования в биндах
GameUI.CustomUIConfig().ToggleBansMenu = ToggleBansMenu


function OpenKeyBindSetter(){
    SettingKeyBindMenu.AddClass("ShowKeyBindSetting")
}

function CloseKeyBindSetter(){
    SettingKeyBindMenu.RemoveClass("ShowKeyBindSetting")
    SettingKeyBindMenu._needFocus = false
    ClearKeyBind()
}

function SetupKeyBindSetter(func){
    if(!func){return}

    func(SettingKeyBindMenu)
}

function ClearKeyBind(){
    SettingKeyBindMenu._CurrentBind = ""
    SettingKeyBindMenu.SetDialogVariable("keybind", "")
    SettingKeyBindMenu.RemoveClass("Overrides")
}

GameUI.CustomUIConfig().OpenKeyBindSetter = OpenKeyBindSetter
GameUI.CustomUIConfig().CloseKeyBindSetter = CloseKeyBindSetter
GameUI.CustomUIConfig().SetupKeyBindSetter = SetupKeyBindSetter

function BlockActions(){

}