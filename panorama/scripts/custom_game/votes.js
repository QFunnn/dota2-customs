--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let LocalPlayerID = Game.GetLocalPlayerID();

const VoteBody = $("#VoteBody")
const VotesList = $("#VotesList")
const VoteHeaderTimerLabel = $("#VoteHeaderTimerLabel")
let LastTimeTimer = 0
let TimerSchedule = -1
let LastTimerNum = 0

// [NP-1] true, если локальный игрок — вылетевший зритель финальной дуэли:
// видит ход голосования, но голосовать не может (клики игнорируются).
let LastDuelSpectator = false

let VOTES = {
    ROUND_MODE: {},
    MINIGAME_TYPE: {},
    LAST_DUEL: {},
}

const VoteResult = $("#VoteResult")
const ResultOption = $("#ResultOption")

const VoteConfirmPanel = $("#VoteConfirmPanel")
const Confirm = $("#Confirm")
const Reject = $("#Reject")

let RemoveScheduler = -1
let RemoveScheduler2 = -1

VotesList.RemoveAndDeleteChildren()

SubscribeAndFireNetTableByKey("globals", `vote_ROUND_MODE_settings`, function(v){
    VOTES["ROUND_MODE"] = v
    CreateVote("ROUND_MODE", v)
})

SubscribeAndFireNetTableByKey("globals", `vote_MINIGAME_TYPE_settings`, function(v){
    VOTES["MINIGAME_TYPE"] = v
    CreateVote("MINIGAME_TYPE", v)
})

SubscribeAndFireNetTableByKey("globals", `vote_LAST_DUEL_settings`, function(v){
    VOTES["LAST_DUEL"] = v
    CreateVote("LAST_DUEL", v)
})

SubscribeAndFireNetTableByKey("globals", `vote_ROUND_MODE_info`, function(v){
    UpdateVote("ROUND_MODE", v)
})

SubscribeAndFireNetTableByKey("globals", `vote_MINIGAME_TYPE_info`, function(v){
    UpdateVote("MINIGAME_TYPE", v)
})

SubscribeAndFireNetTableByKey("globals", `vote_LAST_DUEL_info`, function(v){
    UpdateVote("LAST_DUEL", v)
})

GameEvents.Subscribe("vote_result_show", ShowResult);

function ShowResult(v){

    if(RemoveScheduler != -1){
        $.CancelScheduled(RemoveScheduler)
        RemoveScheduler = -1
    }

    if(RemoveScheduler2 != -1){
        $.CancelScheduled(RemoveScheduler2)
        RemoveScheduler2 = -1
    }

    VoteResult.AddClass("Show")

    let Settings = VOTES[v.vote]

    VoteResult.SetDialogVariable("option_name", $.Localize(`#VOTES_LIST_${v.vote}_${v.option}`))
    VoteResult.SetDialogVariable("option_desc", $.Localize(`#VOTES_LIST_${v.vote}_${v.option}_desc`))

    let PlayersVotes = {}
    for (const _ in Settings.options) {
        let OptionID = Settings.options[_]

        PlayersVotes[OptionID] = 0
    }

    let MaxVotes = 0
    for (const PlayerID in v.values.player_votes) {
        MaxVotes++;

        PlayersVotes[v.values.player_votes[PlayerID].voted_option]++;
    }

    let LocalPlayerVote = v.values.player_votes[LocalPlayerID] ? v.values.player_votes[LocalPlayerID].voted_option : -1

    let VotedCount = PlayersVotes[v.option]

    let OptionText = `${VotedCount} / ${MaxVotes}`

    VoteResult.SetDialogVariable("option_value", OptionText)

    ResultOption.SetHasClass("SelfOption", LocalPlayerVote == v.option)
    ResultOption.SetHasClass("SelfOption2", LocalPlayerVote == v.option)

    let ProgressBar = ResultOption.FindChildTraverse("ResultVoteOptionProgressbar")
    if(ProgressBar){
        ProgressBar.max = MaxVotes
        ProgressBar.value = VotedCount
    }

    RemoveScheduler = $.Schedule(0.25, ()=>{
        Game.EmitSound("Draft.PickMade")
    })

    RemoveScheduler2 = $.Schedule(4, ()=>{
        VoteResult.RemoveClass("Show")
    })
}

function CreateVote(VoteName, v){
    let Instance = GetOrCreateVoteInstance(VotesList, VoteName)

    Instance.SetDialogVariable("instance_name", $.Localize(`#VOTES_LIST_${VoteName}`))
    Instance.SetDialogVariable("instance_desc", $.Localize(`#VOTES_LIST_${VoteName}_desc`))

    let VoteInstanceInfo = Instance.FindChildTraverse("VoteInstanceInfo")
	if(VoteInstanceInfo){
		VoteInstanceInfo.SetPanelEvent('onmouseover', function() {
			$.DispatchEvent('DOTAShowTextTooltip', VoteInstanceInfo, $.Localize(`#VOTES_LIST_${VoteName}_tooltip`)); 
		});
			
		VoteInstanceInfo.SetPanelEvent('onmouseout', function() {
			$.DispatchEvent('DOTAHideTextTooltip', VoteInstanceInfo);
		});
	}

    let Container = Instance.FindChildTraverse("VoteInstanceOptions")
    if(Container){
        for (const _ in v.options) {
            let OptionID = v.options[_]
            let Option = GetOrCreateVoteOption(Container, OptionID)

            Option.SetDialogVariable("option_name", $.Localize(`#VOTES_LIST_${VoteName}_${OptionID}`))
            // Option.SetDialogVariable("option_desc", $.Localize(`#VOTES_LIST_${VoteName}_${OptionID}_desc`))

            let VoteOptionInfo = Option.FindChildTraverse("VoteOptionInfo")
            if(VoteOptionInfo){
                VoteOptionInfo.SetPanelEvent('onmouseover', function() {
                    $.DispatchEvent('DOTAShowTextTooltip', VoteOptionInfo, $.Localize(`#VOTES_LIST_${VoteName}_${OptionID}_desc`)); 
                });
                    
                VoteOptionInfo.SetPanelEvent('onmouseout', function() {
                    $.DispatchEvent('DOTAHideTextTooltip', VoteOptionInfo);
                });
            }

            Option.SetDialogVariable("option_value", "0 / 0")

            let VoteOptionProgressbar = Option.FindChildTraverse("VoteOptionProgressbar")
            if(VoteOptionProgressbar){
                VoteOptionProgressbar.max = 0
                VoteOptionProgressbar.value = 0
            }

            Option.SetPanelEvent("onactivate", function() {
                // [NP-1] Вылетевший зритель финальной дуэли не голосует.
                if(VoteName == "LAST_DUEL" && LastDuelSpectator){return}
                if(Option.BHasClass("Voted")){return}

                if(v.double_confirm == 1){
                    Game.EmitSound( "General.ButtonClick" );
                    ShowDoubleConfirm(VoteName, OptionID)
                }else{
                    Game.EmitSound( "General.ButtonClick" );
                    GameEvents.SendCustomGameEventToServer("votes_player_voted", {VoteName:VoteName, Option:OptionID});
                }
            })
        }
    }
}

function ShowDoubleConfirm(VoteName, OptionID){
    VoteBody.AddClass("ShowConfirm")
    VoteConfirmPanel.AddClass("ShowConfirm")

    // Блокируем клики по фоновому списку вариантов пока висит confirm — иначе
    // под затемнённым фоном можно поменять выбор через клик на другой вариант.
    VotesList.hittestchildren = false

    VoteConfirmPanel.SetDialogVariable("voted_for", $.Localize(`#VOTES_LIST_${VoteName}_${OptionID}`))

    Confirm.SetPanelEvent("onactivate", function(){
        Game.EmitSound( "General.ButtonClick" );
        GameEvents.SendCustomGameEventToServer("votes_player_voted", {VoteName:VoteName, Option:OptionID});

        VoteBody.RemoveClass("ShowConfirm")
        VoteConfirmPanel.RemoveClass("ShowConfirm")
        VotesList.hittestchildren = true
    })

    Reject.SetPanelEvent("onactivate", function(){
        Game.EmitSound( "General.ButtonClick" );
        VoteBody.RemoveClass("ShowConfirm")
        VoteConfirmPanel.RemoveClass("ShowConfirm")
        VotesList.hittestchildren = true
    })
}

function GetOrCreateVoteInstance(Container, VoteName) {
    let f = Container.FindChildTraverse(`VoteInstance_${VoteName}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", Container, `VoteInstance_${VoteName}`, {})
        panel.BLoadLayoutSnippet("VoteInstance")

        return panel
    }
}

function GetOrCreateVoteOption(Container, OptionNum) {
    let f = Container.FindChildTraverse(`Option_${OptionNum}`)
    if(f){
        return f
    }else{
        let panel = $.CreatePanel("Panel", Container, `Option_${OptionNum}`, {})
        panel.BLoadLayoutSnippet("VoteOption")

        return panel
    }
}

function UpdateTimer(){
    let RawDif = LastTimeTimer - Game.GetGameTime()
    let Diff = Math.max(Math.ceil(Math.abs(RawDif)), 0)

    if(LastTimeTimer > 0 && RawDif > 0){
		TimerSchedule = $.Schedule(0.2, UpdateTimer)
	}else{
		VoteHeaderTimerLabel.RemoveClass("Warning")
	}

	VoteHeaderTimerLabel.SetDialogVariable("timer_time", GetTimeString(Diff))

	VoteHeaderTimerLabel.SetHasClass("Warning", Diff <= 10)

	if(Diff <= 5 && LastTimerNum != Diff){
		LastTimerNum = Math.ceil(Diff)
		Game.EmitSound("Tutorial.TaskProgress")
	}
}

function UpdateVote(VoteName, v) {
    let Settings = VOTES[VoteName]
    let bEnded = v.ended

    let Instance = GetOrCreateVoteInstance(VotesList, VoteName)

    // [NP-1] Финальную дуэль (LAST_DUEL) видят ВСЕ, включая вылетевших — чтобы
    // следить за ходом голосования. Но вылетевшие (их нет в v.eligible_players,
    // которое сервер заполняет живыми) НЕ участвуют: кнопки некликабельны и
    // результаты (кто за что) показываются им сразу. Прочие голосования не затронуты.
    let bLastDuelSpectator = false
    if(VoteName == "LAST_DUEL" && v.eligible_players != undefined){
        bLastDuelSpectator = v.eligible_players[LocalPlayerID] == undefined
    }
    if(VoteName == "LAST_DUEL"){
        LastDuelSpectator = bLastDuelSpectator
    }

    Instance.SetHasClass("Show", bEnded == 0)
    Instance.SetHasClass("Spectating", bLastDuelSpectator)

    // Зрителю (вылетевшему) блокируем интерактив опций — без визуального «нажатия».
    let OptsContainer = Instance.FindChildTraverse("VoteInstanceOptions")
    if(OptsContainer){
        OptsContainer.hittestchildren = !bLastDuelSpectator
    }

    if(VoteBody.BHasClass("ShowConfirm") && bEnded == 1){
        VoteBody.RemoveClass("ShowConfirm")
        // Восстанавливаем кликабельность фона если confirm закрылся из-за окончания голосования.
        VotesList.hittestchildren = true
    }
    if(VoteConfirmPanel.BHasClass("ShowConfirm") && bEnded == 1){
        VoteConfirmPanel.RemoveClass("ShowConfirm")
    }
    if(bEnded == 1){
        $.Schedule(0.21, ()=>{
            Instance.SetHasClass("ShowVisibility", bEnded == 0)
        })
    }else{
        Instance.SetHasClass("ShowVisibility", bEnded == 0)
    }

    let AllHidden = true
    for (let i = 0; i < VotesList.GetChildCount(); i++) {
        const Child = VotesList.GetChild(i)
        if(Child && Child.BHasClass("Show")){
            AllHidden = false
        }
    }

    VoteBody.SetHasClass("ShowVotes", AllHidden == false)

    if(TimerSchedule != -1){
        $.CancelScheduled(TimerSchedule)
        TimerSchedule = -1
    }

    LastTimeTimer = v.end_time
    if(!AllHidden){
        UpdateTimer()
    }

    let PlayersVotes = {}
    for (const _ in Settings.options) {
        let OptionID = Settings.options[_]

        PlayersVotes[OptionID] = 0
    }

    let MaxVotes = 0
    for (const PlayerID in v.player_votes) {
        MaxVotes++;

        PlayersVotes[v.player_votes[PlayerID].voted_option]++;
    }

    let ExceptionsArray = v.exceptions == undefined ? [] : toArray(v.exceptions)

    // [NP-1] Зритель финальной дуэли видит результаты (кто за что) сразу.
    let bShowResults = (v.player_votes[LocalPlayerID] != undefined && v.player_votes[LocalPlayerID].can_vote == 0) || bLastDuelSpectator

    let LocalPlayerVote = v.player_votes[LocalPlayerID] ? v.player_votes[LocalPlayerID].voted_option : -1

    for (const OptionID in PlayersVotes) {
        let VotedCount = PlayersVotes[OptionID]

        let Option = GetOrCreateVoteOption(Instance, OptionID)

        let CurrentVoted = 0
        if(bShowResults){
            CurrentVoted = VotedCount
        }

        let OptionText = `${CurrentVoted} / ${MaxVotes}`

        Option.SetDialogVariable("option_value", OptionText)

        Option.SetHasClass("SelfOption", LocalPlayerVote == OptionID)

        Option.SetHasClass("Voted", LocalPlayerVote != -1 || bEnded == 1)

        Option.SetHasClass("Exception", ExceptionsArray.includes(parseInt(OptionID)))

        let ProgressBar = Option.FindChildTraverse("VoteOptionProgressbar")
        if(ProgressBar){
            ProgressBar.max = MaxVotes
            ProgressBar.value = CurrentVoted
        }

    }
}
