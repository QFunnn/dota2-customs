--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const PlayerID = Players.GetLocalPlayer()
const TeamID = Players.GetTeam( PlayerID )

let ROUND_INFO = {}
let LOCAL_PLAYER_TEAM_ROUND_INFO = {}

const CreepsList = $("#CreepsList")
const Body = $("#Body")

let CloseSchedule = -1
let CloseScheduleDelete = -1

let LastSavedCreeps = []

SubscribeAndFirePlayerTableByKey("round_info", `round_info`, function(v){
    ROUND_INFO = v

    if(Body.BHasClass("ShowCustom")){
        UpdateTooltip()
    }
})

// SubscribeAndFireNetTableByKey("globals", `team_${TeamID}_round_info`, function(v){
//     LOCAL_PLAYER_TEAM_ROUND_INFO = v
// })

SubscribeAndFirePlayerTableByKey(`team_${TeamID}`, `round_info`, function(v){
    LOCAL_PLAYER_TEAM_ROUND_INFO = v

    if(Body.BHasClass("ShowCustom")){
        UpdateTooltip()
    }
})

function UpdateTooltip(){
    if(Object.keys(ROUND_INFO).length <= 0 || Object.keys(LOCAL_PLAYER_TEAM_ROUND_INFO).length <= 0){
        CreepsList.RemoveAndDeleteChildren()

        return
    }
    
    let Creeps = []

    if(LOCAL_PLAYER_TEAM_ROUND_INFO.creeps != undefined){
        let RoundCreeps = toArray(LOCAL_PLAYER_TEAM_ROUND_INFO.creeps)

        RoundCreeps.sort(function(a, b){
            return LOCAL_PLAYER_TEAM_ROUND_INFO.creeps_info[b].health - LOCAL_PLAYER_TEAM_ROUND_INFO.creeps_info[a].health
        })

        Creeps.push(RoundCreeps)
    }

    if(LOCAL_PLAYER_TEAM_ROUND_INFO.extra_creeps != undefined){
        let ExtraCreeps = toArray(LOCAL_PLAYER_TEAM_ROUND_INFO.extra_creeps)

        ExtraCreeps.sort(function(a, b){
            return LOCAL_PLAYER_TEAM_ROUND_INFO.creeps_info[b].health - LOCAL_PLAYER_TEAM_ROUND_INFO.creeps_info[a].health
        })

        Creeps.push(ExtraCreeps)
    }

    let bSpecialDesc = false
    if(ROUND_INFO.info.type == 2 && ROUND_INFO.state == 2){
        Body.SetDialogVariable("desc", $.Localize("#ROUNDS_VoteGameModeDesc"))
        bSpecialDesc = true
    }
    if(ROUND_INFO.info.type == 2 && ROUND_INFO.state == 3 && ROUND_INFO.arena == "MINIGAMES"){
        Body.SetDialogVariable("desc", $.Localize("#ROUNDS_MinigamesDesc"))
        bSpecialDesc = true
    }
    if(ROUND_INFO.info.type == 2 && ROUND_INFO.state == 3 && ROUND_INFO.arena == "MASS_ARENA"){
        Body.SetDialogVariable("desc", $.Localize("#VOTES_LIST_ROUND_MODE_1_desc"))
        bSpecialDesc = true
    }
    if(ROUND_INFO.info.type == 2 && ROUND_INFO.state == 3 && ROUND_INFO.arena == "MINIGAMES" && ROUND_INFO.minigame_type != undefined){
        Body.SetDialogVariable("desc", $.Localize(`#VOTES_LIST_MINIGAME_TYPE_${ROUND_INFO.minigame_type}_desc`) + "<br><br>" + $.Localize("#ROUNDS_MinigamesBonusDesc"))
        bSpecialDesc = true
    }
    if(ROUND_INFO.info.type == 1 && LOCAL_PLAYER_TEAM_ROUND_INFO.is_duel == 1){
        Body.SetDialogVariable("desc", $.Localize(`#ROUNDS_DuelDesc`))
        bSpecialDesc = true
    }
    if(Creeps && Creeps[0] && Creeps[0].length > 0 && LOCAL_PLAYER_TEAM_ROUND_INFO.is_duel == 0){
        Body.SetDialogVariable("desc", $.Localize("#ROUNDS_CreepsRoundDesc"))
    }

    Body.SetHasClass("SpecialDesc", bSpecialDesc)

    if(JSON.stringify(LastSavedCreeps) == JSON.stringify(Creeps)){return}

    LastSavedCreeps = Creeps

    CreepsList.RemoveAndDeleteChildren()

    if(Creeps.length <= 0){return}

    for (const CreepList of Creeps) {
        for (const CreepName of CreepList) {
            let p = GetOrCreateCreep(CreepName)

            let Info = LOCAL_PLAYER_TEAM_ROUND_INFO.creeps_info[CreepName]

            let UnitScene = p.FindChildTraverse("UnitScene")
            if(UnitScene){
                UnitScene.SetUnit(CreepName, "", true)
            }

            let HealthRegen = Info.health_regen > 0 ? `+${Info.health_regen}` : Info.health_regen
            let ManaRegen = Info.mana_regen > 0 ? `+${Info.mana_regen}` : Info.mana_regen

            p.SetDialogVariable("name", $.Localize(`#${CreepName}`))
            p.SetDialogVariable("count", Info.count+"")
            p.SetDialogVariable("mana", Info.mana+"")
            p.SetDialogVariable("mana_regen", ManaRegen)
            p.SetDialogVariable("health", Info.health+"")
            p.SetDialogVariable("health_regen", HealthRegen)

            p.SetDialogVariable("damage", `${Info.damage_min} - ${Info.damage_max}`)
            p.SetDialogVariable("speed", Info.attack_speed.toFixed(2))
            p.SetDialogVariable("range", Info.attack_range+"")
            p.SetDialogVariable("phys", Info.physical_resist+"%")
            p.SetDialogVariable("magic", Info.magical_resist+"%")
            p.SetDialogVariable("resist", Info.resist+"%")

            let AbilitiesList = p.FindChildTraverse("AbilitiesList")
            if(AbilitiesList){
                for (const _ in Info.abilities) {
                    let AbilityName = Info.abilities[_]

                    let p = $.CreatePanel("DOTAAbilityImage", AbilitiesList, `Ability_${AbilityName}`, {class: "Ability", abilityname:AbilityName})
                    p.SetPanelEvent('onmouseover', function () {
						$.DispatchEvent("DOTAShowAbilityTooltip", p, AbilityName);
					});
				
					p.SetPanelEvent('onmouseout', function () {
						$.DispatchEvent("DOTAHideAbilityTooltip", p);
					});

                    // [NP-24] Alt-клик по способности крипа в «подробнее» → ТОТ ЖЕ формат, что и
                    // прямой пинг способности крипа («Остерегайтесь <abil> у <крип>»).
                    p.SetPanelEvent("onactivate", function(){
                        if(!IsDotaAltPressed()) return
                        let cfg = GameUI.CustomUIConfig()
                        if(!cfg.SendPingTextToChat || !cfg.BuildAbilityPingByName) return
                        cfg.SendPingTextToChat(cfg.BuildAbilityPingByName(AbilityName, CreepName))
                    })
                }
            }

            // [NP-24] Alt-клик по плитке крипа (портрет/имя) в «подробнее» → «Осторожно: <крип> ×N».
            p.hittest = true
            p.SetPanelEvent("onactivate", function(){
                if(!IsDotaAltPressed()) return
                let send = GameUI.CustomUIConfig().SendPingTextToChat
                if(!send) return
                let nameLoc = $.Localize("#"+CreepName)
                send("<font color='#ffcc55'>"+$.Localize("#PING_CAREFUL")+"</font> <font color='#c8c8c8'>"+nameLoc+"</font> ×"+Info.count)
            })
        }
    }
}

function GetOrCreateCreep(CreepName){
    let f = CreepsList.FindChildTraverse(`Creep_${CreepName}`)
    if(f){
        return f
    }else{
        let p = $.CreatePanel("Panel", CreepsList, `Creep_${CreepName}`, {})
        p.BLoadLayoutSnippet("Creep")

        return p
    }
}

function ToggleTooltip(){
    Body.ToggleClass("ShowCustom")

    if(CloseSchedule != -1){
        $.CancelScheduled(CloseSchedule)
        CloseSchedule = -1
    }

    if(Body.BHasClass("ShowCustom")){
        if(CloseScheduleDelete != -1){
            $.CancelScheduled(CloseScheduleDelete)
            CloseScheduleDelete = -1
        }

        UpdateTooltip()
    }else{
        if(CloseScheduleDelete != -1){
            $.CancelScheduled(CloseScheduleDelete)
            CloseScheduleDelete = -1
        }

        CloseScheduleDelete = $.Schedule(0.16, function(){
            LastSavedCreeps = []
            CreepsList.RemoveAndDeleteChildren()
        })
    }
}

function ShowTooltipForTime(data){
    Body.AddClass("ShowCustom")

    if(CloseScheduleDelete != -1){
        $.CancelScheduled(CloseScheduleDelete)
        CloseScheduleDelete = -1
    }

    if(CloseSchedule != -1){
        $.CancelScheduled(CloseSchedule)
        CloseSchedule = -1
    }

    CloseSchedule = $.Schedule(data.duration, function(){
        Body.RemoveClass("ShowCustom")
    })
}

function SetDuelActive(bool){
    Body.SetHasClass("DuelActive", bool)
}

GameEvents.Subscribe("ROUNDS_SHOW_ROUND_TOOLTIP", ShowTooltipForTime)

GameUI.CustomUIConfig().ToggleTooltip = ToggleTooltip
GameUI.CustomUIConfig().SetDuelActive = SetDuelActive