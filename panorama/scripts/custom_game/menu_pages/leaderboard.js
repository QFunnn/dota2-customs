--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LocalPID = Players.GetLocalPlayer()
const MAIN_PANEL = $.GetContextPanel()
const LeaderboardWindow = $("#LeaderboardWindow")
const SeasonsContainer = $("#SeasonsContainer")
const PlayersTable = $("#PlayersTable")

let player_table = undefined

let SeasonsInfo = {}
let SelectedSeason = -1

let Tops = {}

let LOADED = false

let Schedules = []

SubscribeAndFireNetTableByKey("players_server_info", `player_${LocalPID}`, function(v){
    player_table = v
})

SubscribeAndFireNetTableByKey("globals", `rating_seasons`, function(v){
    SeasonsInfo = v
})

function SetupLeaderboard(){
    SeasonsContainer.RemoveAndDeleteChildren()
    let Table = SeasonsInfo.AllSeasons
    if(Table){
        let i = 0
        for (const key in Table) {
            i++;
            let bCurrentSeason = (i == 1)
            let Season = Table[key]
            let SeasonPanel = $.CreatePanel("Panel", SeasonsContainer, "Season_"+Season.id, {class: bCurrentSeason ? "Current" : ""})
            SeasonPanel.BLoadLayoutSnippet("Season")
            SeasonPanel.SetDialogVariable("SeasonName", Season.num+" "+$.Localize("#season_name"))
            SeasonPanel.SetDialogVariable("SeasonDates", GetDateString(Season.start, false) + " - " + GetDateString(Season.end, false))
            SeasonPanel.SetPanelEvent("onactivate", function(){
                SelectSeason(Season.id)
            })
        }
    }
}

function SelectSeason(SeasonID){
    if(SelectedSeason == SeasonID){
        return
    }

    SelectedSeason = SeasonID
    DeselectAllExceptOf(SeasonsContainer, SeasonID)

    UpdateRating()
}

function UpdateRating(){
    if(SelectedSeason == -1){
        return
    }

    let Table = Tops[SelectedSeason]
    if(!Table){
        GameEvents.SendCustomGameEventToServer( "server_get_rating_season_info", {season: SelectedSeason} )
    }else{
        LoadSeasonRating(SelectedSeason)
    }
}

function LoadSeasonRating(SeasonID){
    PlayersTable.RemoveAndDeleteChildren()

    let Top = Tops[SeasonID]

    for (var i = 1; i <= 100; i++)
    {
        if (Top[i] != undefined)
        {
            CreatePlayer(Top[i].steamid, Top[i].value, PlayersTable, i, false)
        }    
    }
}

function DeselectAllExceptOf(p, SeasonID){
    let Childs = p.GetChildCount()
    for (let i = 0; i < Childs; i++) {
        const Child = p.GetChild(i)
        if(Child){
            if(Child.id != "Season_"+SeasonID){
                Child.RemoveClass("Selected")
            }else{
                Child.AddClass("Selected")
            }
        }
    }
}

function CreatePlayer(id, rating, panel, number, time, round) 
{
    var Line = $.CreatePanel("Panel", panel, "");
    Line.AddClass("LinePlayer");

    let Time = 0.04 + (0.02 * number)

    let sch = $.Schedule(Time, function() {
        if(Line && Line.IsValid()){
            Line.AddClass("Appear")
        }
    })

    Schedules.push(sch)

    Line.SetHasClass("LocalPlayer", IsLocalPlayer(id))

    var RankPanel = $.CreatePanel("Panel", Line, "");
    RankPanel.AddClass("RankPanel");

    var RankImage = $.CreatePanel("Panel", RankPanel, "");
    RankImage.AddClass("RankImage");
    if (number <= 10 && rating >= 5420)
    {
        RankImage.style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(10000) + '.png")';
    } else {
        RankImage.style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(rating) + '.png")';
    }
    RankImage.style.backgroundSize = "100%" 

    var Rank_number = $.CreatePanel("Label", RankImage, "");
    Rank_number.AddClass("Rank_number");
    Rank_number.text = number

    var AvatarNicknamePanel = $.CreatePanel("Panel", Line, "");
    AvatarNicknamePanel.AddClass("AvatarNicknamePanel");

    $.CreatePanel("DOTAAvatarImage", AvatarNicknamePanel, "AvatarLeaderboard", { style: "width:40px;height:40px;vertical-align:center;", accountid: id });
    $.CreatePanel("DOTAUserName", AvatarNicknamePanel, "NickLeaderboard", { class:"DOTAUserNameCustom", style: "vertical-align:center;margin-left:10px;height: 20px;", accountid: id });

    var Rating = $.CreatePanel("Label", Line, "");
    Rating.AddClass("RatingLabel");
    if (time)
    {   
        var hours = Math.floor(rating / 60 / 60);
        var minutes = Math.floor(rating / 60) - (hours * 60);
        var seconds = rating % 60;
        var formatted = hours + ':' + minutes + ':' + seconds;
        Rating.text = String(formatted) + " (" + round + ")"
        RankImage.style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(10000) + '.png")';
    } else {
        Rating.text = String(rating)
    }
}

function IsLocalPlayer(SteamID){
    return player_table && player_table.steamid == SteamID
}

function OpenLeaderboard()
{
    LeaderboardWindow.ToggleClass("Show")

    if(SelectedSeason == -1 && SeasonsInfo.CurrentSeason && SeasonsInfo.CurrentSeason.id != undefined){
        SelectSeason(SeasonsInfo.CurrentSeason.id)
    }
}

function UpdateTopInfo(Info){
    if(Tops[Info.season] == undefined){
        Tops[Info.season] = Info.top

        if(LOADED){
            LoadSeasonRating(Info.season)
        }
    }
}

MAIN_PANEL.Data().OnLoad = ()=>{
    if(LOADED == true){return}
    LOADED = true

    if(SelectedSeason == -1 && SeasonsInfo.CurrentSeason && SeasonsInfo.CurrentSeason.id != undefined){
        SelectSeason(SeasonsInfo.CurrentSeason.id)
    }else if(SelectedSeason != -1 && SeasonsInfo.CurrentSeason && SeasonsInfo.CurrentSeason.id != undefined){
        UpdateRating()
    }
}

MAIN_PANEL.Data().OnUnLoad = ()=>{
    if(LOADED == false){return}
    LOADED = false

    PlayersTable.RemoveAndDeleteChildren()

    for (const Sch of Schedules) {
        $.CancelScheduled( Sch )
    }
    Schedules = []
}

GameEvents.Subscribe("server_send_rating_season_info", UpdateTopInfo)

SetupLeaderboard()