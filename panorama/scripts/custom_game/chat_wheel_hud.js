--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LocalPID = Players.GetLocalPlayer()

const MAIN_PANEL = $.GetContextPanel()

const CallBody = $("#CallBody")
const ChatWheelCursor = $("#ChatWheelCursor")
const WheelPointer = $("#WheelPointer")
const Arrow = $("#Arrow")
let DotaHUD = GetDotaHud();

const RegionSize = 45

const CallRegions = [
    {
        center: 0,
        line_id: 3,
    },
    {
        center: 45,
        line_id: 4,
    },
    {
        center: 90,
        line_id: 5,
    },
    {
        center: 135,
        line_id: 6,
    },
    {
        center: 180,
        line_id: 7,
    },
    {
        center: 225,
        line_id: 8,
    },
    {
        center: 270,
        line_id: 1,
    },
    {
        center: 315,
        line_id: 2,
    },
]

let CHAT_WHEEL_ITEMS = {}

let LOCAL_PLAYER_MUTES_TABLE = {}

let LOCAL_PLAYER_CHAT_ITEMS = {}

let bCallBodyIsActive = false
let CurrentSelectedCallLine = 0

let UISCALE_X = 1;
let UISCALE_Y = 1;

function UpdateChatWheel(){
    for (const LineID in LOCAL_PLAYER_CHAT_ITEMS) {
        let ItemName = LOCAL_PLAYER_CHAT_ITEMS[LineID]
        if(ItemName != ""){
            let ItemInfo = CHAT_WHEEL_ITEMS[ItemName]
            if(ItemInfo){
                let LinePanel2 = $(`#CallLine${LineID}`)
                if(LinePanel2){
                    let MainText = $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${ItemName}`)
                    // let Prefix = ItemInfo.ForAll == 1 ? $.Localize(`#CUSTOM_CHAT_WHEEL_Prefix`)+" " : ""
                    LinePanel2.SetDialogVariable("calllinetext", `${MainText}`)

                    LinePanel2.SetHasClass("TypeSound", ItemInfo.Type == 2)
                }
            }
        }
    }
}

function OpenCallBody(){
    bCallBodyIsActive = true
    MAIN_PANEL.AddClass("ShowCall")
}

function CloseCallBody(){
    bCallBodyIsActive = false
    MAIN_PANEL.RemoveClass("ShowCall")

    if(CurrentSelectedCallLine == 0){return}

    GameEvents.SendCustomGameEventToServer("chat_wheel_line_selected", {line_id:CurrentSelectedCallLine})

    CurrentSelectedCallLine = 0
}

// MF-18: локальная проверка мута по категории (стор GameUI.CustomUIConfig().MutePrefs,
// ключ — PlayerID цели). Мут по категории (флага all нет — «всё» = все 3 включены). Колесо чата входит в «Звуки».
function _MuteCatLocal(pid, cat){
    let cfg = GameUI.CustomUIConfig()
    let store = cfg && cfg.MutePrefs
    if(!store || !store[pid]){ return false }
    return store[pid][cat] ? true : false
}

function OnSayLine(event){
    if(IsPlayerMuted(event.caller_player)){return}
    if(_MuteCatLocal(event.caller_player, "sounds")){return}

    let ItemInfo = CHAT_WHEEL_ITEMS[event.item_name]
    if(ItemInfo){
        let Info = Game.GetPlayerInfo(event.caller_player)
        let HeroName = Info.player_selected_hero
        let playerColor = GetHEXPlayerColor(event.caller_player)

        let SoundIcon = ``

        if(ItemInfo.Type == 2){
            Game.EmitSound(ItemInfo.Sound)
            SoundIcon = `<img class='SoundIconChat' src='s2r://panorama/images/hud/reborn/icon_scoreboard_mute_sound_psd.vtex'> `
        }else{
            SoundIcon = `<img class='SoundIconChat' src='s2r://panorama/images/control_icons/chat_wheel_icon_png.vtex'> `
        }

        let Text = `<font color='${playerColor}'>${Info.player_name}</font>: ${SoundIcon}${$.Localize(`#CUSTOM_CHAT_WHEEL_Item_${event.item_name}`)}`

        let ChatLines = DotaHUD.FindChildTraverse("ChatLinesPanel")
        if(ChatLines){
            let msgPanel = $.CreatePanel("Panel", ChatLines, "", {class:"ChatLine"})
            msgPanel.BLoadLayout("file://{resources}/layout/custom_game/custom_chat_line.xml", false, false)
            msgPanel.hittest = false
    
            let HeroImage = msgPanel.FindChildTraverse("HeroImage")
    
            HeroImage.SetImage( "file://{images}/heroes/" + HeroName + ".png" );
    
            msgPanel.SetDialogVariable("chat_line", Text)
            $.Schedule(5, function(){
                msgPanel.AddClass("ExpireThis")
            })
        }
    }
}

function Updater(){
    $.Schedule(0, Updater)

    UISCALE_X = DotaHUD.actualuiscale_x;
    UISCALE_Y = DotaHUD.actualuiscale_y;

    if(!bCallBodyIsActive){
        return
    }

    let ScreenWidth = Game.GetScreenWidth()
    let ScreenHeight = Game.GetScreenHeight()

    let CenterX = ScreenWidth / 2
    let CenterY = ScreenHeight / 2
    let CenterPos = [CenterX, CenterY, 0]

    let Cursor = GameUI.GetCursorPosition();
    let CursorPos = [Cursor[0], Cursor[1], 0]

    let CursorDistance = Game.Length2D(CursorPos, CenterPos)

    let Direction = VectorMin( CursorPos, CenterPos );
	Direction = Game.Normalized( Direction );

    let newPos = CursorPos

    if(CursorDistance > 33){
        newPos = VectorAdd(CenterPos, VectorScale(Direction, 33))
    }

    ChatWheelCursor.style.x = ToAbsPixelValueX(newPos[0])-23 + "px;"
    ChatWheelCursor.style.y = ToAbsPixelValueX(newPos[1])-23 + "px;"

    let CurrentAngle = angle(CursorPos[0], CursorPos[1], CenterPos[0], CenterPos[1])
    let SelectedOne = false
    for (const Region of CallRegions) {
        let Min = Region.center - RegionSize/2
        if(Min < 0){
            Min = Min + 360
        }
        let Max = Region.center + RegionSize/2
        if(Max > 360){
            Max = Max - 360
        }

        let Center2 = Region.center == 0 ? 360 : Region.center

        let bIsActiveRegion = CursorDistance > 25 && ((CurrentAngle > Min && CurrentAngle < Center2) || (CurrentAngle >= Region.center && CurrentAngle < Max))

        let LinePanel = $(`#CallLine${Region.line_id}`)
        if(LinePanel){
            LinePanel.SetHasClass("Selected", bIsActiveRegion)
        }

        if(bIsActiveRegion){
            SelectedOne = true

            WheelPointer.style.transform = `rotateZ(${Region.center+90}deg)`;

            Arrow.style.transform = `translateX(60px) translateY(0px) rotateZ(${Region.center}deg)`;

            CurrentSelectedCallLine = Region.line_id
        }
    }

    CallBody.SetHasClass("CallLineSelected", SelectedOne)

    if(!SelectedOne){
        CurrentSelectedCallLine = 0
    }
}

function getDistancePoints(x1, y1, x2, y2) {
    return Math.sqrt(Math.pow((x1 - x2), 2) + Math.pow((y1 - y2), 2));
}

function ToAbsPixelValueX(value) {
    return Math.floor((1 / UISCALE_X) * value);
}
function ToAbsPixelValueY(value) {
    return Math.floor((1 / UISCALE_Y) * value);
}

function VectorMin( v1, v2 ) {
	return [ v1[0]-v2[0], v1[1]-v2[1], 0 ];
}
function VectorAdd( v1, v2 ) {
	return [ v1[0]+v2[0], v1[1]+v2[1], 0 ];
}
function VectorScale( v1, c ) {
	return [ v1[0]*c, v1[1]*c, 0 ];
}

function angle(cx, cy, ex, ey) {
    var dy = ey - cy;
    var dx = ex - cx;
    var theta = Math.atan2(dy, dx)+ Math.PI;
    theta *= 180 / Math.PI;
    return theta;
}

function IsPlayerMuted(PlayerID){
    if(LOCAL_PLAYER_MUTES_TABLE[PlayerID] == 1){
        return true
    }

    return false
}

(function(){
    SubscribeAndFirePlayerTableByKey("chat_wheel", "list", function(v){
        CHAT_WHEEL_ITEMS = v

        UpdateChatWheel()
    })

    for (let i = 1; i < 9; i++) {
        let LinePanel2 = $(`#CallLine${i}`)
        if(LinePanel2){
            LinePanel2.SetDialogVariable("calllinetext", $.Localize("#CUSTOM_CHAT_WHEEL_Default"))
        }
    }
    // $.Schedule(0.1, function(){
        SubscribeAndFirePlayerTableByKey(`player_${LocalPID}`, `chat_wheel`, function(v){
            LOCAL_PLAYER_CHAT_ITEMS = v
            UpdateChatWheel()
        })
        SubscribeAndFirePlayerTableByKey(`player_${LocalPID}`, `mutes`, function(v){
            LOCAL_PLAYER_MUTES_TABLE = v
        })
    // })

    Updater()

    GameEvents.Subscribe("chat_wheel_say_line", OnSayLine)

    GameUI.CustomUIConfig().OpenChatWheel = OpenCallBody
    GameUI.CustomUIConfig().CloseChatWheel = CloseCallBody
})();