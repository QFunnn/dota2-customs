--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let MAIN_PANEL = $.GetContextPanel()

let DotaHud = GetDotaHud()
let NetGraph = DotaHud.FindChildTraverse('NetGraph')

function NetGraphChecker(){
    if(Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_POST_GAME)){
        $.Schedule(0.5, NetGraphChecker)
    }

    if(NetGraph){
        MAIN_PANEL.SetHasClass("NetGraphVisible", NetGraph.BHasClass("Visible"))
    }
}

// [NP-24] актуальные значения статов для пинга в чат (Alt+ЛКМ)
let StatVals = {aegis:"", creeps:"", magic:"", phys:""}

SubscribeAndFireNetTableByKey("globals", "dynamic_settings_values", function(v){
    MAIN_PANEL.SetDialogVariable("aegis", v.aegis)
    MAIN_PANEL.SetDialogVariable("creeps", v.creeps)
    MAIN_PANEL.SetDialogVariable("magical_resist", v.magical_resist.toFixed(2) + "%")
    MAIN_PANEL.SetDialogVariable("physical_resist", v.physical_resist.toFixed(2) + "%")

    // [NP-24] сохраняем последние значения для пинга
    StatVals.aegis = v.aegis
    StatVals.creeps = v.creeps
    StatVals.magic = v.magical_resist.toFixed(2) + "%"
    StatVals.phys = v.physical_resist.toFixed(2) + "%"
})

// [NP-24] отправить один стат в общий чат через готовую систему пингов.
// iconItem (необязательно) — имя предмета без "item_"; добавит инлайн-иконку предмета слева.
function PingStat(key, val, iconItem){
    let cfg = GameUI.CustomUIConfig()
    if(!cfg || !cfg.SendPingTextToChat) return
    let icon = iconItem ? "<img class='PingItemIcon' src='file://{images}/items/"+iconItem+".png'/>" : ""
    cfg.SendPingTextToChat(icon + $.Localize(key).replace("%s1", val))
}

// [NP-24] вешаем Alt+ЛКМ-пинги на ячейки/подписи статов; если панели ещё не готовы — повтор
function SetupStatPings(){
    let cellAegis  = MAIN_PANEL.FindChildTraverse("CellAegis")
    let cellCreeps = MAIN_PANEL.FindChildTraverse("CellCreeps")
    let cellMagic  = MAIN_PANEL.FindChildTraverse("CellMagic")
    let cellPhys   = MAIN_PANEL.FindChildTraverse("CellPhys")

    if(!cellAegis || !cellCreeps || !cellMagic || !cellPhys){
        $.Schedule(0.5, SetupStatPings)
        return
    }

    // [NP-24] Пинг только по самим ЗНАЧЕНИЯМ (на названия категорий клик не вешаем).
    cellAegis.SetPanelEvent("onactivate", function(){
        if(IsDotaAltPressed()) PingStat("#PING_STAT_AEGIS", StatVals.aegis, "aegis")
    })
    cellCreeps.SetPanelEvent("onactivate", function(){
        if(IsDotaAltPressed()) PingStat("#PING_STAT_CREEPS", StatVals.creeps, "extra_creature_ogreseal")
    })
    cellMagic.SetPanelEvent("onactivate", function(){
        if(IsDotaAltPressed()) PingStat("#PING_STAT_MAGIC_RESIST", StatVals.magic)
    })
    cellPhys.SetPanelEvent("onactivate", function(){
        if(IsDotaAltPressed()) PingStat("#PING_STAT_PHYS_RESIST", StatVals.phys)
    })
}

SetupStatPings()

NetGraphChecker()