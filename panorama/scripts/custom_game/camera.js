--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]



// 自制观察视角镜头
if (FindDotaHudElement('PortraitContainer')){
    var pc = FindDotaHudElement('PortraitContainer');
    pc.style['tooltip-position'] = 'top';
    pc.SetPanelEvent("onactivate",
        function () {
            ToggleViewCamera();
        }
    );
    pc.SetPanelEvent("onmouseover",
        function () {
            $.DispatchEvent("DOTAShowTitleTextTooltip", pc, $.Localize("#tips_camera_title"), $.Localize("#tips_camera"));
        }
    );
    pc.SetPanelEvent("onmouseout",
        function () {
            $.DispatchEvent("DOTAHideTextTooltip");
            $.DispatchEvent("DOTAHideTitleTextTooltip");
        } 
    );
}
function OnESCCamera(){
    ShowExclusionWindow('panel_draw_card', false);
    OnHideCameraText();
    ResetCamera();
}
function ToggleViewCamera(force_show, text){
    Game.EmitSound("camera.move");
    GameEvents.SendCustomGameEventToServer("cancel_pick_chess_position", { player_id: Game.GetLocalPlayerID() });
    // GameUI.SelectUnit(Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer()), false);
    hide_cursor_hero();
    if (GameUI.GetCameraYaw() != 0 && !force_show){
        // 不显示
        ShowExclusionWindow('panel_draw_card', false);
        OnHideCameraText();
        ResetCamera();
    }
    else{
        // 显示
        // GameUI.SetCameraDistance(500);
        ShowExclusionWindow('panel_draw_card', false);
        OnShowCameraText(text || $.Localize('#camera_view'));
        SetCamera();
        GameUI.SetCameraPitchMax(40);
        GameUI.SetCameraPitchMin(40);
    }
}

function SetCamera(){
    smoothCameraDistance();
    if (Entities.IsHero( Players.GetLocalPlayerPortraitUnit() )){
        // 信使
        g_targetDistance = 800;
        GameUI.SetCameraYaw(1); 
        GameUI.SetCameraTarget( Players.GetLocalPlayerPortraitUnit() );
    }
    else{
        // 普通单位
        g_targetDistance = 800;
        if (!Entities.GetAbsAngles( Players.GetLocalPlayerPortraitUnit() )){
            return;
        }
        var y = Entities.GetAbsAngles( Players.GetLocalPlayerPortraitUnit() )[1]+90;
        if (y == 0){
            y = 1;
        }
        GameUI.SetCameraYaw(y);
        GameUI.SetCameraTarget( Players.GetLocalPlayerPortraitUnit() );
    }
}

function ResetCamera(){
    // GameUI.SetCameraDistance(1300);
    g_targetDistance = 1400;
    smoothCameraDistance();
    GameUI.SetCameraPitchMax(60);
    GameUI.SetCameraPitchMin(60);
    GameUI.SetCameraYaw(0);
    GameUI.SetCameraTarget(-1);

    Game.EmitSound("camera.move");
    GameEvents.SendCustomGameEventToServer("cancel_pick_chess_position", { player_id: Game.GetLocalPlayerID() });
}

// $.Msg(Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_ESCAPE));
SetHotKey('ESCAPE', OnBackHome);
SetHotKey('`', OnBackHome);
SetHotKey('F2', OnBackHome);
SetHotKey('TAB', OnTabHome);
SetHotKey('I', ToggleViewCamera);

var TEAM_2_PLAYERID = {};
var PLAYERID_2_TEAM = {};
var CURR_CAMERA_PLAYER_ID = Players.GetLocalPlayer();
var CURR_CAMERA_TEAM_ID = Players.GetTeam(Players.GetLocalPlayer());
for (var i = 0; i <= 11; i++) {
    if (Players.GetTeam(i)) {
        TEAM_2_PLAYERID[Players.GetTeam(i)] = i;
        PLAYERID_2_TEAM[i] = Players.GetTeam(i);
    }
}
var teamid2steamid = {};
var teamid2playerid = {};
for (var i = 0; i <= 7; i++) {
    if (Game.GetPlayerInfo(i)) {
        var team = Players.GetTeam(i);
        teamid2steamid[team] = Game.GetPlayerInfo(i).player_steamid;
        teamid2playerid[team] = i;
    }
}

function OnBackHome() {
    if (CENTER_ENTITY_INDEX[Players.GetTeam(Players.GetLocalPlayer())]) {
        
        if (GameUI.GetCameraYaw() != 0){
            OnESCCamera();
        }
        
        CURR_CAMERA_PLAYER_ID = Players.GetLocalPlayer();
        GameUI.SelectUnit(Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer()), false);
        
        $.Schedule(0.1, function () {
            // GameUI.SetCameraTarget(-1);
            GameUI.SetCameraTargetPosition(CENTER_ENTITY_INDEX[Players.GetTeam(Players.GetLocalPlayer())], 0.2);
        });
    }
}
function OnTabHome() {
    var hero = null;
    var death_team_info = CustomNetTables.GetTableValue("game_info", 'death_team');

    if (GameUI.GetCameraYaw() != 0){
        OnESCCamera();
    }
    // 容错
    if (!CURR_CAMERA_TEAM_ID){
        CURR_CAMERA_TEAM_ID = 6;
    }

    for (var i = 1; i <= 9; i++) {
        CURR_CAMERA_TEAM_ID = CURR_CAMERA_TEAM_ID + 1;

        if (CURR_CAMERA_TEAM_ID > 13) {
            CURR_CAMERA_TEAM_ID = 6;
        }
        var player_id = TEAM_2_PLAYERID[CURR_CAMERA_TEAM_ID + ''];
        // if (!Players.IsValidPlayerID(CURR_CAMERA_PLAYER_ID)){
        //     continue;
        // }
        if (player_id == undefined) {
            continue;
        }
        if (death_team_info[CURR_CAMERA_TEAM_ID + '']) {
            continue;
        }
        // hero = Players.GetPlayerHeroEntityIndex(player_id);
        // if (!hero){
        //     continue;
        // }
        // if (!Entities.IsAlive(hero)){
        //     continue;
        // }
        // $.Msg(player_id);
        // if (!CENTER_ENTITY_INDEX[Players.GetTeam(CURR_CAMERA_PLAYER_ID)]){
        //     $.Msg('continue;CURR_CAMERA_PLAYER_ID='+CURR_CAMERA_PLAYER_ID+',team='+Players.GetTeam(CURR_CAMERA_PLAYER_ID));
        //     continue;
        // }
        break;
    }
    // if (!hero){
    //     return;
    // }

    // GameUI.SetCameraTarget( parseInt(CENTER_ENTITY_INDEX[CURR_CAMERA_PLAYER_ID]) );
    
    GameEvents.SendCustomGameEventToServer("reset_fow", {
        "local_player_team": Players.GetTeam(Players.GetLocalPlayer()),
        "target_player_team": CURR_CAMERA_TEAM_ID,
    });
    IS_CAMERA_MOVING = true;

    $.Schedule(0.1, function () {
        // GameUI.SetCameraTarget(-1);
        GameUI.SetCameraTargetPosition(CENTER_ENTITY_INDEX[CURR_CAMERA_TEAM_ID], 0.2);
        IS_CAMERA_MOVING = false;
        if (teamid2playerid[CURR_CAMERA_TEAM_ID] || teamid2playerid[CURR_CAMERA_TEAM_ID] == 0){
            GameUI.SelectUnit(Players.GetPlayerHeroEntityIndex(teamid2playerid[CURR_CAMERA_TEAM_ID]), false);
        }
    });

}

// 视角控制
var g_targetDistance = 1400;
var g_currDistance = 1400;
var g_MaxDistance = 2000;
var g_MinDistance = 500;
var g_camera_angle = 60;
var g_camera_angle_target = 60;

GameUI.SetCameraDistance(1400);
GameUI.SetCameraPitchMax(60);
GameUI.SetCameraPitchMin(60);

smoothCameraDistance();
function smoothCameraDistance() {
    if (GameUI.GetCameraYaw() != 0){
        g_MinDistance = 300;
    }
    else{
        g_MinDistance = 1400;
    }

    if (g_targetDistance > g_MaxDistance) {
        g_targetDistance = g_MaxDistance;
    }
    if (g_targetDistance < g_MinDistance) {
        g_targetDistance = g_MinDistance;
    }

    if (g_currDistance < g_targetDistance) {
        g_currDistance = g_currDistance + 50;
        if (g_currDistance > g_targetDistance) {
            g_currDistance = g_targetDistance;
        }
        $.Schedule(1.0 / 30.0, smoothCameraDistance);
    }
    if (g_currDistance > g_targetDistance) {
        g_currDistance = g_currDistance - 50;
        if (g_currDistance < g_targetDistance) {
            g_currDistance = g_targetDistance;
        }
        $.Schedule(1.0 / 30.0, smoothCameraDistance);
    }

    GameUI.SetCameraDistance(g_currDistance);
    return;
}