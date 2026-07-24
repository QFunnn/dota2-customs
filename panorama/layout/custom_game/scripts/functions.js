--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe("set_player_icon", set_player_icon);
function set_player_icon(data)
{	
	Entities.SetMinimapIcon( data.entity, "minimap_heroicon_" + Entities.GetUnitName(data.hero) );
}

GameEvents.Subscribe("select_unit_custom", select_unit_custom);
function select_unit_custom(event)
{	
	GameUI.SelectUnit( event.entity, event.replace == 1 )
}

GameEvents.Subscribe( 'set_camera_target', SetCamera );
function SetCamera( data )
{
	GameUI.SetCameraTargetPosition(data.location, 0.003);
}

GameEvents.Subscribe("check_smoke_disabled", check_smoke_disabled);
function check_smoke_disabled(data)
{	
	if (GameUI.IsControlDown())
	{
		GameEvents.SendCustomGameEventToServer( 'RemoveSmoke', {unit: data.unit} );
	}
}

function GetGameKeybind(command) 
{
    return Game.GetKeybindForCommand(command);
}

function set_pause()
{	
	GameEvents.SendCustomGameEventToServer( 'players_player_want_pause_game', {} );
}

let UnitToSelect = -1

let LocalPlayerID = -1
WaitPlayerID()

function WaitPlayerID(){
	LocalPlayerID = Players.GetLocalPlayer()
	if(LocalPlayerID == -1){
		$.Schedule(0, WaitPlayerID)
	}else{
		SubscribeAndFireNetTableByKey("players", `player_${LocalPlayerID}_select_unit`, function(v){
			UnitToSelect = v.entity
		})
	}
}

let LastSelectHeroTime = 0
let MaxDoubleDif = 0.4
let Pressed = false
let Used = false

// Отслеживаем идёт ли миниигра — в них F1 должен выделять secondary-unit,
// а не основного героя. Т.к. мы отключили кастомный F1-bind (чтобы работал
// нативный hold-to-follow Dota), делаем redirect: если в миниигре игрок
// выделил своего героя, автоматически переключаем на secondary-unit.
let IsMinigameActive = false
SubscribeAndFirePlayerTableByKey("round_info", "round_info", function(v){
	IsMinigameActive = (v && v.minigame_type !== undefined && v.arena === "MINIGAMES")
})

let LastRedirectTime = 0
GameEvents.Subscribe('dota_player_update_selected_unit', function(){
	if (!IsMinigameActive) return
	if (UnitToSelect === -1 || !Entities.IsValidEntity(UnitToSelect)) return

	// Анти-зацикливание: между redirect'ами минимум 0.1с.
	let now = Game.GetGameTime()
	if (now - LastRedirectTime < 0.1) return

	let heroEnt = Players.GetPlayerHeroEntityIndex(LocalPlayerID)
	if (UnitToSelect === heroEnt) return  // secondary == hero, не надо ничего делать

	let selected = Players.GetLocalPlayerPortraitUnit()
	if (selected !== heroEnt) return  // уже выбран secondary или кто-то ещё — ок

	LastRedirectTime = now
	GameUI.SelectUnit(UnitToSelect, false)
})

function select_hero()
{	
	if(Game.GameStateIsAfter( DOTA_GameState.DOTA_GAMERULES_STATE_GAME_IN_PROGRESS )){return}

	let CurrentTime = Game.GetGameTime()
	let SelectUnit = UnitToSelect
	if(SelectUnit == -1){
		SelectUnit = Players.GetPlayerHeroEntityIndex( LocalPlayerID )
	}
	if(Entities.IsValidEntity( SelectUnit )){
		if(CurrentTime <= LastSelectHeroTime){
			GameUI.MoveCameraToEntity( SelectUnit )
			Pressed = true

			$.Schedule(0.11, UpdateCamera)
		}

		LastSelectHeroTime = CurrentTime + MaxDoubleDif
		GameUI.SelectUnit( SelectUnit, false )
	}
}

GameEvents.Subscribe("player_unpause_chat", player_unpause_chat);

function UpdateCamera(){
	if (!Pressed) return

	let SelectUnit = UnitToSelect
	if (SelectUnit === -1) {
		SelectUnit = Players.GetPlayerHeroEntityIndex(LocalPlayerID)
	}
	if (!Entities.IsValidEntity(SelectUnit)) return

	Used = true

	// Panorama-API вместо server-command — следим за юнитом напрямую.
	// 10 Гц достаточно для плавности, не создаёт нагрузки на сервер-route.
	GameUI.MoveCameraToEntity(SelectUnit)
	$.Schedule(0.1, UpdateCamera)
}

function player_unpause_chat( data )
{
	let dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()
	let Hudchat = dotaHud.FindChildTraverse("HudChat")
	let LinesPanel = Hudchat.FindChildTraverse("ChatLinesPanel")

	let player_name = Players.GetPlayerName( data.id )
	let hero_name = player_name + " " + $.Localize("#cha_unpause_player")
	let color = "white;"

	var playerInfo = Game.GetPlayerInfo( data.id );
	if ( playerInfo )
	{
		if ( GameUI.CustomUIConfig().team_colors )
		{
			var teamColor = GameUI.CustomUIConfig().team_colors[ playerInfo.player_team_id ];
			if ( teamColor )
			{
				color = teamColor;
			}
		}
	}

	let player_color_style = "font-size:18px;font-weight:bold;text-shadow: 1px 1.5px 0px 2 black;color:" + color
	let ChatPanelSound = $.CreatePanel("Panel", LinesPanel, "", { style:"margin-left:37px;flow-children: right;width:100%;" });
	let LabelSound = $.CreatePanel("Label", ChatPanelSound, "", { text:`${hero_name}`, style:"font-size:18px;font-weight:bold;text-shadow: 1px 1.5px 0px 2 black;color:white;" });

	$.Schedule( 7, function(){
		if (ChatPanelSound) {
	    	ChatPanelSound.AddClass('ChatLine');  
		}
	})
}

GameEvents.Subscribe("immediate_purchase:key_check", (event) => {
	GameEvents.SendCustomGameEventToServer("immediate_purchase:response", {
		result: GameUI.IsAltDown(),
		item: event.item,
		has_stack: event.has_stack,
		item_name: event.item_name,
	});
});

(function()
{
	const name_bind = "set_pause" + Math.floor(Math.random() * 99999999);
    Game.AddCommand(name_bind, set_pause, "", 0);
    Game.CreateCustomKeyBind(GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_PAUSE), name_bind);

	// === ТЕСТ: кастомный F1-bind закомментирован, чтобы Dota нативно обрабатывала
	// select-hero (включая hold-to-follow). Если заработает — вернёмся к тому,
	// чтобы в миниграх переключать на secondary-unit альтернативным способом
	// (например, автоматический GameUI.SelectUnit при спавне unit на сервере).
	// const name_bind2 = "select_hero" + Math.floor(Math.random() * 99999999);
    // Game.AddCommand("+"+name_bind2, select_hero, "", 0);
    // Game.AddCommand("-"+name_bind2, function(){
	// 	Pressed = false
	//
	// 	if(Used){
	// 		Used = false
	// 		let pos = GameUI.GetCameraLookAtPosition()
	// 		GameEvents.SendEventClientSide( "client_side_server_command", { command : `+dota_camera_center_on_hero`} )
	// 		GameEvents.SendEventClientSide( "client_side_server_command", { command : `-dota_camera_center_on_hero`} )
	// 		GameUI.SetCameraTargetPosition( pos, -1 )
	// 	}
	// }, "", 0);
    // Game.CreateCustomKeyBind(GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_SELECT), "+"+name_bind2);
})();