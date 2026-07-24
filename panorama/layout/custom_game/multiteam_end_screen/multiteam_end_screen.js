--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

const MAIN_PANEL = $.GetContextPanel();

const WinnerPlayerHeroScene = $("#WinnerPlayerHeroScene")

let count = 0;
let fcir = false;

(function()
{
	if ( ScoreboardUpdater_InitializeScoreboard === null ) { $.Msg( "WARNING: This file requires shared_scoreboard_updater.js to be included." ); }

	let scoreboardConfig =
	{
		"teamXmlName" : "file://{resources}/layout/custom_game/multiteam_end_screen/multiteam_end_screen_team.xml",
		"playerXmlName" : "file://{resources}/layout/custom_game/multiteam_end_screen/multiteam_end_screen_player.xml",
		"bIsEndScreen" : true,
	};

	let endScoreboardHandle = ScoreboardUpdater_InitializeScoreboard( scoreboardConfig, $( "#TeamsContainer" ) );
	MAIN_PANEL.RemoveClass("endgame")
	MAIN_PANEL.RemoveClass("endgame_2")
	MAIN_PANEL.RemoveClass("endgame_3")
	MAIN_PANEL.AddClass( "endgame");

	$.Schedule(0.5, function(){
		MAIN_PANEL.AddClass("endgame_2")
	});

	$.Schedule(1.3, function(){
		Game.EmitSound("Game_End_Scoreboard_Appear")
	});
	
	let teamInfoList = ScoreboardUpdater_GetSortedTeamInfoList( endScoreboardHandle );

	let delay = 1.8;
	let delay_per_panel = 1 / teamInfoList.length;
	for ( let teamInfo of teamInfoList )
	{
		let teamPanel = ScoreboardUpdater_GetTeamPanel( endScoreboardHandle, teamInfo.team_id );
		teamPanel.SetHasClass( "team_endgame", false );
		let callback = function( panel )
		{
			return function(){ panel.SetHasClass( "team_endgame", 1 ); }
		}( teamPanel );
		$.Schedule( delay, callback )
		delay += delay_per_panel;
	}

	$.Schedule(3, function(){
		MAIN_PANEL.AddClass("endgame_3")
	});
	
	let winningTeamId = Game.GetGameWinner();
	let winningTeamDetails = Game.GetTeamDetails( winningTeamId );
	MAIN_PANEL.SetHasClass("has_players_in_winner_team", winningTeamDetails.team_num_players > 0)

	if (Players.GetTeam(Players.GetLocalPlayer()) == winningTeamId) {
		MAIN_PANEL.SetDialogVariable("end_game_msg", $.Localize("#GAME_WIN_MSG"))
		MAIN_PANEL.AddClass("Win")

		Game.EmitSound("Creep.Sended")
	}
	else{
		MAIN_PANEL.SetDialogVariable("end_game_msg", $.Localize("#GAME_LOSE_MSG"))
		MAIN_PANEL.AddClass("Lose")

		Game.EmitSound("ui.npe_badge")
	}

	if(winningTeamDetails.team_num_players > 0){

		$.Schedule(0.6, function(){
			Game.EmitSound("Draft.PickMade")
		})

		$.Schedule(1.1, function(){
			Game.EmitSound("Loot_Drop_Stinger_Short")
		})

		let PlayerWinnerID = Game.GetPlayerIDsOnTeam( winningTeamId )[0]
		let PlayerWinnerInfo = Game.GetPlayerInfo( PlayerWinnerID )

		MAIN_PANEL.SetDialogVariable("winner_player_name", PlayerWinnerInfo.player_name)
		MAIN_PANEL.SetDialogVariable("winner_hero_name", $.Localize(`#${PlayerWinnerInfo.player_selected_hero}`))

		WinnerPlayerHeroScene.heroname = PlayerWinnerInfo.player_selected_hero
	}

	// Управление камерой и скрытие таймера игры
	GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, false )

	// Отключаем хоткей переключения на героя (F1) на финальном экране — иначе
	// игроки случайно дёргают камеру с таблицы статистики на труп героя.
	// Перебиваем биндинг no-op командой; восстанавливать не надо, end screen
	// держится до выхода из игры.
	DisableEndScreenHeroSelectKey()

	StartEndCamera()
})();

function DisableEndScreenHeroSelectKey(){
	// Перебиваем все камера/select-бинды no-op'ом — на финальном экране
	// нельзя дёргать камеру (F1, групп-селект, центрирование, ARROWS и т.д.).
	let commandsToDisable = [
		DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_SELECT,
		DOTAKeybindCommand_t.DOTA_KEYBIND_SELECT_ALL_OTHER_UNITS,
		DOTAKeybindCommand_t.DOTA_KEYBIND_SELECT_COURIER,
		DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_GRIP,
		DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_FOLLOW,
		DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_CENTER_PLAYER,
		DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_MOVE_UP,
		DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_MOVE_DOWN,
		DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_MOVE_LEFT,
		DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_MOVE_RIGHT,
		DOTAKeybindCommand_t.DOTA_KEYBIND_SELECT_ALL,
	]
	for(let kbCmd of commandsToDisable){
		try {
			if(kbCmd === undefined || kbCmd === null) continue
			let key = Game.GetKeybindForCommand(kbCmd)
			if(!key || typeof key !== "string" || key === "") continue
			let cmd = "EndScreenNoop_" + Math.floor(Math.random() * 99999999)
			Game.AddCommand("+" + cmd, function(){}, "", 0)
			Game.AddCommand("-" + cmd, function(){}, "", 0)
			Game.CreateCustomKeyBind(key.toUpperCase(), "+" + cmd)
		} catch(e){ $.Msg("[EndScreen] disable keybind failed for ", kbCmd, ": ", String(e)) }
	}
}

function OpenMatchResults(){
	let MatchIDTable = CustomNetTables.GetTableValue("globals", "match_id")
	if(MatchIDTable){
		$.DispatchEvent("ExternalBrowserGoToURL", `https://ancientarena.pro/match/${MatchIDTable.id}`)
	}
}


function CameraLock()
{
	GameUI.SetCameraTargetPosition([0, 4864, 0], 0.1);
	$.Schedule(0, CameraLock);
}

function CameraYaw()
{
	count = count + 0.1
	let yaw = 0
	if (fcir === false) {
		yaw = 45+count
	}else{
		yaw = count
	}
	if (yaw >= 360) {
		fcir = true
		count = 0
		yaw = 0
	}
	GameUI.SetCameraYaw(yaw);
	$.Schedule(0, CameraYaw);
}

function StartEndCamera(){
	GameUI.SetCameraTerrainAdjustmentEnabled( false )
	GameUI.SetCameraPitchMin(400);
	GameUI.SetCameraPitchMax(400);
	let CameraLookAt = GameUI.GetCameraLookAtPosition()
	let CameraYaw = GameUI.GetCameraYaw()
	let iDelay = 0
	if(CameraLookAt[0] != 0 || CameraLookAt[1] != 4864){
		iDelay = 0.5
		GameUI.SetCameraTargetPosition( [0, 4864, 0], 0.5 )
		
	}
	if(CameraYaw != 45){
		iDelay = 0.5
		animateValue(CameraYaw, 45, 0.5, function(value){
			GameUI.SetCameraYaw(value)
		})
	}

	if(iDelay > 0){
		$.Schedule(iDelay, CameraAnimation)
	}else{
		CameraAnimation()
	}
}

function CameraAnimation(){
	CameraYaw()
	CameraLock()
}

function easeInOut(t) {
    return t < 0.5
        ? 2 * t * t
        : -1 + (4 - 2 * t) * t;
}

function animateValue(from, to, duration, onUpdate) {
    const start = Game.GetGameTime();

    function tick() {
		let now = Game.GetGameTime()
        const progress = Math.min((now - start) / duration, 1);
        const eased = easeInOut(progress);
        const value = from + (to - from) * eased;

        onUpdate(value);
		if (progress < 1) $.Schedule(0, tick);
    }

	tick()
}

const SettingsButton = $("#SettingsButton")

SubscribeAndFireNetTableByKey("globals", "current_game_settings", function(v){
    let Text = ""
    let Array = toArray(v)
    if(Array){
        let i = 0
        for (const SettingInfo of Array) {
            i++;
            let Value = SettingInfo.value % 1 === 0  ?  SettingInfo.value :  SettingInfo.value.toFixed(2)
			Value = parseFloat(Value)
            if(i > 1 ){
                Text+="<br>"
            }
            Text+=`<font color="#ccc">${$.Localize(`#SETTINGS_VALUE_${SettingInfo.name}`)}:</font> <b>${Value}</b>`
        }
        SettingsButton.SetPanelEvent('onmouseover', function() {
            $.DispatchEvent('DOTAShowTextTooltip', SettingsButton, Text); 
        })
        SettingsButton.SetPanelEvent('onmouseout', function() 
        {
            $.DispatchEvent('DOTAHideTextTooltip', SettingsButton);
        })
    }
})