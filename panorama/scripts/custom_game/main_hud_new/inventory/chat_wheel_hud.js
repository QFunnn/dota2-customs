--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
var _a;
const CHAT_WHEEL_POPUP_PANEL = $.GetContextPanel();
const CallBody = $("#CallBody");
const ChatWheelCursor = $("#ChatWheelCursor");
const WheelPointer = $("#WheelPointer");
const Arrow = $("#Arrow");
const DotaHUD = getDotaHud();
const RegionSize = 45;
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
];
let CHAT_WHEEL_POPUP_ITEMS = {};
let CHAT_WHEEL_MESSAGES_DISABLED = false;
let bCallBodyIsActive = false;
let CurrentSelectedCallLine = 0;
let UISCALE_X = 1;
let UISCALE_Y = 1;
function UpdatePopupChatWheel(PlayerInfo) {
    for (const LineID in PlayerInfo) {
        const itemName = PlayerInfo[LineID];
        if (itemName == "")
            continue;
        const itemInfo = CHAT_WHEEL_POPUP_ITEMS[itemName];
        if (!itemInfo)
            continue;
        const linePanel2 = $(`#CallLine${LineID}`);
        if (!linePanel2)
            continue;
        let MainText = $.Localize(`#CUSTOM_CHAT_WHEEL_Item_${itemName}`);
        // let Prefix = ItemInfo.ForAll == 1 ? $.Localize(`#CUSTOM_CHAT_WHEEL_Prefix`)+" " : ""
        linePanel2.SetDialogVariable("calllinetext", `${MainText}`);
        linePanel2.SetHasClass("TypeSound", itemInfo.Type == 2);
    }
}
function OpenCallBody() {
    bCallBodyIsActive = true;
    CHAT_WHEEL_POPUP_PANEL.AddClass("ShowCall");
}
function CloseCallBody() {
    bCallBodyIsActive = false;
    CHAT_WHEEL_POPUP_PANEL.RemoveClass("ShowCall");
    if (CurrentSelectedCallLine == 0)
        return;
    GameEvents.SendCustomGameEventToServer("chat_wheel_line_selected", { line_id: CurrentSelectedCallLine });
    CurrentSelectedCallLine = 0;
}
function OnSayLine(event) {
    if (CHAT_WHEEL_MESSAGES_DISABLED || Game.IsPlayerMuted(event.caller_player))
        return;
    const itemInfo = CHAT_WHEEL_POPUP_ITEMS[event.item_name];
    if (!itemInfo) {
        return;
    }
    const playerInfo = Game.GetPlayerInfo(event.caller_player);
    const heroName = playerInfo.player_selected_hero;
    const playerColor = GetHEXPlayerColor(event.caller_player);
    let soundIcon = ``;
    if (itemInfo.Type == 2) {
        Game.EmitSound(itemInfo.Sound);
        soundIcon = `<img class='SoundIconChat' src='s2r://panorama/images/hud/reborn/icon_scoreboard_mute_sound_psd.vtex'> `;
    }
    else {
        soundIcon = `<img class='SoundIconChat' src='s2r://panorama/images/control_icons/chat_wheel_icon_png.vtex'> `;
    }
    const text = `<font color='${playerColor}'>${playerInfo.player_name}</font>: ${soundIcon}${$.Localize(`#CUSTOM_CHAT_WHEEL_Item_${event.item_name}`)}`;
    const chatLines = DotaHUD.FindChildTraverse("ChatLinesPanel");
    if (chatLines) {
        const msgPanel = $.CreatePanel("Panel", chatLines, "", { class: "ChatLine" });
        msgPanel.BLoadLayout("file://{resources}/layout/custom_game/custom_chat_line/custom_chat_line.xml", false, false);
        msgPanel.hittest = false;
        const heroImage = msgPanel.FindChildTraverse("HeroImage");
        heroImage === null || heroImage === void 0 ? void 0 : heroImage.SetImage("file://{images}/heroes/" + heroName + ".png");
        msgPanel.SetDialogVariable("chat_line", text);
        $.Schedule(5, function () {
            msgPanel.AddClass("ExpireThis");
        });
    }
}
function Updater() {
    $.Schedule(0, Updater);
    UISCALE_X = DotaHUD.actualuiscale_x;
    UISCALE_Y = DotaHUD.actualuiscale_y;
    if (!bCallBodyIsActive) {
        return;
    }
    let ScreenWidth = Game.GetScreenWidth();
    let ScreenHeight = Game.GetScreenHeight();
    let CenterX = ScreenWidth / 2;
    let CenterY = ScreenHeight / 2;
    let CenterPos = [CenterX, CenterY, 0];
    let Cursor = GameUI.GetCursorPosition();
    let CursorPos = [Cursor[0], Cursor[1], 0];
    //@ts-ignore
    const cursorDistance = Game.Length2D(CursorPos, CenterPos);
    let Direction = VectorMin(CursorPos, CenterPos);
    //@ts-ignore
    Direction = Game.Normalized(Direction);
    let newPos = CursorPos;
    if (cursorDistance > 33) {
        newPos = VectorAdd(CenterPos, VectorScale(Direction, 33));
    }
    ChatWheelCursor.style.x = ToAbsPixelValueX(newPos[0]) - 23 + "px;";
    ChatWheelCursor.style.y = ToAbsPixelValueX(newPos[1]) - 23 + "px;";
    let CurrentAngle = angle(CursorPos[0], CursorPos[1], CenterPos[0], CenterPos[1]);
    let SelectedOne = false;
    for (const Region of CallRegions) {
        let Min = Region.center - RegionSize / 2;
        if (Min < 0) {
            Min = Min + 360;
        }
        let Max = Region.center + RegionSize / 2;
        if (Max > 360) {
            Max = Max - 360;
        }
        let Center2 = Region.center == 0 ? 360 : Region.center;
        let bIsActiveRegion = cursorDistance > 25 && ((CurrentAngle > Min && CurrentAngle < Center2) || (CurrentAngle >= Region.center && CurrentAngle < Max));
        let LinePanel = $(`#CallLine${Region.line_id}`);
        if (LinePanel) {
            LinePanel.SetHasClass("Selected", bIsActiveRegion);
        }
        if (bIsActiveRegion) {
            SelectedOne = true;
            WheelPointer.style.transform = `rotateZ(${Region.center + 90}deg)`;
            Arrow.style.transform = `translateX(60px) translateY(0px) rotateZ(${Region.center}deg)`;
            CurrentSelectedCallLine = Region.line_id;
        }
    }
    CallBody.SetHasClass("CallLineSelected", SelectedOne);
    if (!SelectedOne) {
        CurrentSelectedCallLine = 0;
    }
}
//@ts-ignore
function getDistancePoints(x1, y1, x2, y2) {
    return Math.sqrt(Math.pow((x1 - x2), 2) + Math.pow((y1 - y2), 2));
}
//@ts-ignore
function ToAbsPixelValueX(value) {
    return Math.floor((1 / UISCALE_X) * value);
}
//@ts-ignore
function ToAbsPixelValueY(value) {
    return Math.floor((1 / UISCALE_Y) * value);
}
//@ts-ignore
function VectorMin(v1, v2) {
    return [v1[0] - v2[0], v1[1] - v2[1], 0];
}
//@ts-ignore
function VectorAdd(v1, v2) {
    return [v1[0] + v2[0], v1[1] + v2[1], 0];
}
//@ts-ignore
function VectorScale(v1, c) {
    return [v1[0] * c, v1[1] * c, 0];
}
//@ts-ignore
function angle(cx, cy, ex, ey) {
    var dy = ey - cy;
    var dx = ex - cx;
    var theta = Math.atan2(dy, dx) + Math.PI;
    theta *= 180 / Math.PI;
    return theta;
}
function toBooleanSetting(value) {
    return value === true || value === 1;
}
function updateChatWheelSettings() {
    const settings = CustomNetTables.GetTableValue("player_settings", String(getSteamId32(Players.GetLocalPlayer())));
    CHAT_WHEEL_MESSAGES_DISABLED = toBooleanSetting(settings === null || settings === void 0 ? void 0 : settings.disableChatWheelMessages);
}
$.Msg("[ChatWheel] Initializing chat wheel HUD");
CHAT_WHEEL_POPUP_ITEMS = (_a = CustomNetTables.GetTableValue("chat_wheel", "list")) !== null && _a !== void 0 ? _a : {};
for (let i = 1; i < 9; i++) {
    const linePanel2 = $(`#CallLine${i}`);
    if (linePanel2) {
        linePanel2.SetDialogVariable("calllinetext", $.Localize("#CUSTOM_CHAT_WHEEL_Default"));
    }
}
$.Schedule(0.1, function () {
    var _a;
    const chatWheelPlayerTable = (_a = CustomNetTables.GetTableValue("chat_wheel", String(Players.GetLocalPlayer()))) !== null && _a !== void 0 ? _a : {};
    UpdatePopupChatWheel(chatWheelPlayerTable);
    updateChatWheelSettings();
    CustomNetTables.SubscribeNetTableListener("chat_wheel", function (_, key, value) {
        if (key == String(Players.GetLocalPlayer())) {
            UpdatePopupChatWheel(value);
        }
    });
    CustomNetTables.SubscribeNetTableListener("player_settings", function (_, key, _value) {
        if (key == String(getSteamId32(Players.GetLocalPlayer()))) {
            updateChatWheelSettings();
        }
    });
});
Updater();
GameEvents.Subscribe("chat_wheel_say_line", OnSayLine);
GameUI.CustomUIConfig().OpenChatWheel = () => OpenCallBody();
GameUI.CustomUIConfig().CloseChatWheel = () => CloseCallBody();
$.Msg("[ChatWheel] Chat wheel HUD initialized");