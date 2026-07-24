--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LocalPlayerID = Players.GetLocalPlayer()

const WidgetPanel = $("#WidgetPanel")
const WidgetImage = $("#WidgetImage")

const WidgetList = $("#WidgetList")

const MAX_WIDGETS = 11

let CurrentWidget = 0
let WidgetAutoScroll = -1

let LOADED = false

CreateWidgets()

WidgetSetup(1)

function CreateWidgets(){
    WidgetList.RemoveAndDeleteChildren()

    for (let i = 1; i <= MAX_WIDGETS; i++) {
        let p = $.CreatePanel("Panel", WidgetList, `WidgetButton_${i}`, {class: "WidgetButton"})
        p.SetPanelEvent("onactivate", function(){
            WidgetSetup(i)
        })
    }
}

function WidgetSetup(num){
    if(num == undefined){return} 
    CurrentWidget = num

    WidgetImage.style.backgroundImage = `url("file://{images}/custom_game/bp_info/${num}.png")`
    WidgetImage.style.backgroundSize = "cover"
    WidgetImage.style.backgroundPosition = "top"
    WidgetImage.style.backgroundRepeat = "no-repeat"
    WidgetPanel.SetDialogVariable("current_widget", $.Localize(`#MENU_BATTLE_PASS_WIDGET_${num}`))

    for (let i = 0; i < WidgetList.GetChildCount(); i++) {
        const Child = WidgetList.GetChild(i)
        if(Child){
            Child.SetHasClass("Selected", i+1 == num)
        }
    }

    if(LOADED){
        if(WidgetAutoScroll != -1){
            $.CancelScheduled(WidgetAutoScroll)
            WidgetAutoScroll = -1
        }

        WidgetAutoScroll = $.Schedule(5, function(){
            NextWidget(1, true)
        })
    }
}

function NextWidget(num, bIsAuto){
    let WidgetNum = CurrentWidget
    if(WidgetNum+num > MAX_WIDGETS){
        WidgetNum = 1
    }else if(WidgetNum+num < 1){
        WidgetNum = MAX_WIDGETS
    }else{
        WidgetNum = WidgetNum+num
    }

    WidgetSetup(WidgetNum)
}

function BuyBattlePass(months){
    GameEvents.SendCustomGameEventToServer("BattlePassBuy", { duration_type: months });
}

$.GetContextPanel().Data().OnLoad = ()=>{
    if(LOADED == true){return}
    LOADED = true

    if(WidgetAutoScroll != -1){
        $.CancelScheduled(WidgetAutoScroll)
        WidgetAutoScroll = -1
    }

    WidgetAutoScroll = $.Schedule(5, function(){
        NextWidget(1, true)
    })
}

$.GetContextPanel().Data().OnUnLoad = ()=>{
    if(LOADED == false){return}
    LOADED = false

    if(WidgetAutoScroll != -1){
        $.CancelScheduled(WidgetAutoScroll)
        WidgetAutoScroll = -1
    }
}