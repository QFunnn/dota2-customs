--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const PauseAvatar = $("#PauseAvatar")
const PauseName = $("#PauseName")

const PauseOwner = $("#PauseOwner")

const PauseDelayContainer = $("#PauseDelayContainer")

let LastTime = 0
let TimerSchedule = -1
let LastTimerNum = 0

SubscribeAndFireNetTableByKey("globals", `pause_owner`, function(v){
    PauseOwner.SetHasClass("Show", v.owner_pid != -1)
    if(v.owner_pid != -1){
        PauseAvatar.steamid = Game.GetPlayerInfo(v.owner_pid).player_steamid
        PauseName.steamid = Game.GetPlayerInfo(v.owner_pid).player_steamid
    }
})

SubscribeAndFireNetTableByKey("globals", `pause_unpause_delay`, function(v){
    if(TimerSchedule != -1){
        $.CancelScheduled(TimerSchedule)
        TimerSchedule = -1
    }

    LastTime = v.time-0.1
    if(LastTime > 0){
        UpdateTimer()
    }

    PauseDelayContainer.SetHasClass("Show", LastTime > 0)
})

function UpdateTimer(){
    let RawDif = LastTime - Game.Time()
    let Diff = Math.max(Math.ceil(Math.abs(RawDif)), 0)

    if(LastTime > 0 && Diff > 0){
		TimerSchedule = $.Schedule(0.2, UpdateTimer)
	}

	PauseDelayContainer.SetDialogVariable("timer_time", Diff)

    if(LastTimerNum != Diff){
		LastTimerNum = Math.ceil(Diff)
		Game.EmitSound("Tutorial.TaskProgress")
	}
}