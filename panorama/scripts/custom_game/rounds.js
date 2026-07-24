--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const PlayerID = Players.GetLocalPlayer()
const TeamID = Players.GetTeam( PlayerID )
const MAIN_PANEL = $.GetContextPanel()

const RoundsMain = $("#RoundsMain")
const ProgressBar = $("#ProgressBar")
const ReadyButton = $("#ReadyButton")
const DuelOpponentIcon = $("#DuelOpponentIcon")
const DuelSpectatorOpponentIconF = $("#DuelSpectatorOpponentIconF")
const DuelSpectatorOpponentIconS = $("#DuelSpectatorOpponentIconS")
const MoreInfo = $("#MoreInfo")

let ROUND_INFO = {}
let LOCAL_PLAYER_TEAM_ROUND_INFO = {}

let LastTimeTimer = 0
let TimerSchedule = -1
let LastTimerNum = 0

let NeedClose = false

// [NP-24] последнее локализованное имя раунда для пинга в чат
let LastRoundName = ""

// [NP-24] Alt+ЛКМ по панели раунда -> пинг "Осторожно: <раунд>" в чат.
// onactivate НЕ всплывает в Panorama, поэтому клики по дочерним кнопкам
// (ReadyButton/MoreInfo) сюда не доходят и их поведение сохраняется.
RoundsMain.hittest = true
RoundsMain.SetPanelEvent("onactivate", function(){
    if(IsDotaAltPressed()){
        PingRound()
    }
})

// [NP-24] построить и отправить пинг с именем текущего раунда
function PingRound(){
    if(LastRoundName == ""){return}
    let cfg = GameUI.CustomUIConfig()
    if(!cfg || !cfg.SendPingTextToChat){return}
    let msg = $.Localize("#PING_ROUND_WARN").replace("%s1", "<font color='#ffcc55'>" + LastRoundName + "</font>")
    cfg.SendPingTextToChat(msg)
}

SubscribeAndFirePlayerTableByKey("round_info", `round_info`, function(v){
    ROUND_INFO = v

    UpdateRoundInfo()
})

SubscribeAndFirePlayerTableByKey(`team_${TeamID}`, `round_info`, function(v){
    LOCAL_PLAYER_TEAM_ROUND_INFO = v

    UpdateRoundInfo()
})

function UpdateRoundInfo(){
    if(Object.keys(ROUND_INFO).length <= 0 || Object.keys(LOCAL_PLAYER_TEAM_ROUND_INFO).length <= 0){return}
     
    RoundsMain.SetHasClass("Show", ROUND_INFO.state > 1)

    let bIsSpectator = Players.IsSpectator( PlayerID ) || (LOCAL_PLAYER_TEAM_ROUND_INFO != undefined && LOCAL_PLAYER_TEAM_ROUND_INFO.state == 5)
    ReadyButton.SetHasClass("CanBeReady", ROUND_INFO.state == 2 && !bIsSpectator)

    if(ROUND_INFO.state == 1){
        NeedClose = true
    }

    if(LOCAL_PLAYER_TEAM_ROUND_INFO.state == 3 && NeedClose == true && GameUI.CustomUIConfig().CloseDuelInfo != undefined){
        NeedClose = false
        let settingData = GetPlayerTablesValue(`player_${PlayerID}`, `setting_data`)
        if(settingData && settingData.autoclose_duel_info == 1){
            GameUI.CustomUIConfig().CloseDuelInfo()
        }
    }

    if(ROUND_INFO.state != 2){
        ReadyButton.RemoveClass("Ready")
    }

    if(TimerSchedule != -1){
        $.CancelScheduled(TimerSchedule)
        TimerSchedule = -1
    }
    
    if(ROUND_INFO.state == 1){return}

    // $.Msg(LOCAL_PLAYER_TEAM_ROUND_INFO.start_delay)

    LastTimeTimer = LOCAL_PLAYER_TEAM_ROUND_INFO.time + LOCAL_PLAYER_TEAM_ROUND_INFO.start_delay
    UpdateTimer()

    RoundsMain.SetDialogVariable("round_num", ""+ROUND_INFO.num)
    RoundsMain.SetDialogVariable("round_state", $.Localize(`#ROUNDS_STATE_${LOCAL_PLAYER_TEAM_ROUND_INFO.state}`))

    let RoundName = ""
    if(ROUND_INFO.info.type == 1){
        RoundName = ROUND_INFO.info.name
    }else if(ROUND_INFO.info.type == 2){
        if(ROUND_INFO.arena == "MINIGAMES"){
            if(ROUND_INFO.minigame_type != undefined){
                RoundName = `#VOTES_LIST_MINIGAME_TYPE_${ROUND_INFO.minigame_type}`
            }else{
                RoundName = `#ROUNDS_MINIGAMES`
            }
        }else if(ROUND_INFO.arena == "MASS_ARENA"){
            RoundName = `#ROUNDS_MASS_ARENA`
        }else{
            RoundName = `#ROUNDS_VOTING`
        }
    }else{
        RoundName = `#ROUNDS_BOSS_ARENA`
    }
    if(LOCAL_PLAYER_TEAM_ROUND_INFO.is_duel == 1){
        RoundName = `#ROUNDS_DUEL`
    }

    RoundsMain.SetDialogVariable("round_name", $.Localize(RoundName))
    LastRoundName = $.Localize(RoundName) // [NP-24] запоминаем для пинга

    ProgressBar.max = LOCAL_PLAYER_TEAM_ROUND_INFO.max_creeps
    ProgressBar.value = LOCAL_PLAYER_TEAM_ROUND_INFO.killed_creeps

    let RoundProgress = `${LOCAL_PLAYER_TEAM_ROUND_INFO.killed_creeps} / ${LOCAL_PLAYER_TEAM_ROUND_INFO.max_creeps}`
    if(LOCAL_PLAYER_TEAM_ROUND_INFO.state == 5){
        RoundProgress = LOCAL_PLAYER_TEAM_ROUND_INFO.max_creeps + ""
    }

    RoundsMain.SetDialogVariable("round_progress", RoundProgress)

    RoundsMain.SetHasClass("NoCreeps", LOCAL_PLAYER_TEAM_ROUND_INFO.max_creeps == 0)
    RoundsMain.SetHasClass("Duel", LOCAL_PLAYER_TEAM_ROUND_INFO.is_duel == 1)

    if(LOCAL_PLAYER_TEAM_ROUND_INFO.duel_opponent != undefined){
        let EnemyInfo = Game.GetPlayerInfo(LOCAL_PLAYER_TEAM_ROUND_INFO.duel_opponent)
        if(EnemyInfo){
            RoundsMain.SetDialogVariable("opponent_name", EnemyInfo.player_name)
            RoundsMain.SetDialogVariable("opponent_heroname", $.Localize(`#${EnemyInfo.player_selected_hero}`))

            DuelOpponentIcon.heroname = EnemyInfo.player_selected_hero
        }
    }

    RoundsMain.SetHasClass("DuelSpectator", false)

    if(LOCAL_PLAYER_TEAM_ROUND_INFO.duel_spectator_pair != undefined){
        let fPlayerInfo = Game.GetPlayerInfo(LOCAL_PLAYER_TEAM_ROUND_INFO.duel_spectator_pair.fPlayer)
        if(fPlayerInfo){
            RoundsMain.SetDialogVariable("f_name", fPlayerInfo.player_name)
            RoundsMain.SetDialogVariable("f_hero_name", $.Localize(`#${fPlayerInfo.player_selected_hero}`))
            DuelSpectatorOpponentIconF.heroname = fPlayerInfo.player_selected_hero
        }
        let sPlayerInfo = Game.GetPlayerInfo(LOCAL_PLAYER_TEAM_ROUND_INFO.duel_spectator_pair.sPlayer)
        if(sPlayerInfo){
            RoundsMain.SetDialogVariable("s_name", sPlayerInfo.player_name)
            RoundsMain.SetDialogVariable("s_hero_name", $.Localize(`#${sPlayerInfo.player_selected_hero}`))

            DuelSpectatorOpponentIconS.heroname = sPlayerInfo.player_selected_hero
        }
    }
}

function UpdateTimer(){
    let RawDif = LastTimeTimer - Game.GetGameTime()
    if(LOCAL_PLAYER_TEAM_ROUND_INFO.state == 4){
        RawDif = Game.GetGameTime() - LastTimeTimer
    }
    let Diff = Math.max(Math.ceil(Math.abs(RawDif)), 0)

    if(LastTimeTimer > 0){
		TimerSchedule = $.Schedule(0.2, UpdateTimer)
	}else{
		RoundsMain.RemoveClass("Warning")
	}

	RoundsMain.SetDialogVariable("round_time", GetTimeString(Diff))

	RoundsMain.SetHasClass("Warning", (RawDif < 0 || Diff <= 5) && LOCAL_PLAYER_TEAM_ROUND_INFO.state < 4)

    MAIN_PANEL.SetHasClass("TimePulse", false)

    if(LOCAL_PLAYER_TEAM_ROUND_INFO.state == 2 || ROUND_INFO.minigame_type != undefined || ROUND_INFO.arena == "MASS_ARENA"){
        MAIN_PANEL.SetHasClass("TimePulse", Diff <= 3)

        if(Diff <= 3 && LastTimerNum != Diff){
            MAIN_PANEL.SetDialogVariable("last_time", Math.ceil(Diff))
            LastTimerNum = Math.ceil(Diff)
            Game.EmitSound("Tutorial.TaskProgress")
        }
    }
}

function ToggleReady(){
    if(!ReadyButton.BHasClass("Ready") || Game.IsInToolsMode()){
        ReadyButton.ToggleClass("Ready")

        GameEvents.SendCustomGameEventToServer("rounds_player_ready", {});
    }
}

GameEvents.Subscribe('ResetPlayerReadyList', function(){
    ReadyButton.RemoveClass("Ready")
});

function ToggleTooltip(){
    if(GameUI.CustomUIConfig().ToggleTooltip){
        GameUI.CustomUIConfig().ToggleTooltip()
    }
}

// MoreInfo.SetPanelEvent("onmouseover", () => 
// {
//     $.DispatchEvent(
//         "UIShowCustomLayoutParametersTooltip",
//         MoreInfo,
//         "RoundsTooltip",
//         "file://{resources}/layout/custom_game/rounds_tooltip.xml",
//         ""
//     );
// });

// MoreInfo.SetPanelEvent("onmouseout", () => 
// {
//     $.DispatchEvent("UIHideCustomLayoutTooltip", MoreInfo, "RoundsTooltip");
// });

// Обработка подсказок для панели раундов
GameEvents.Subscribe("cha_hint_visible", function(params) {
    if (params.hint == "creeps_info")
    {
        if (!GameUI.CustomUIConfig().HintOutlineParticles) {
            GameUI.CustomUIConfig().HintOutlineParticles = {}
        }
        // Используем глобальную функцию из hints.js с передачей контекста
        if (GameUI.CustomUIConfig().CreateHintParticle) {
            GameUI.CustomUIConfig().HintOutlineParticles["creeps_info"] = GameUI.CustomUIConfig().CreateHintParticle(MoreInfo, $.GetContextPanel())
        }
    }
})