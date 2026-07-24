--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var g_ScoreboardHandle = null;

function SwitchCheckboxState(id, base_state=false) {
	let checkbox = $("#" + id)
	if (checkbox.selected == undefined) {checkbox.selected = base_state}
	checkbox.selected = !checkbox.selected
	//$.Msg("state:", checkbox.selected)
	checkbox.SetSelected(checkbox.selected)
	return checkbox.selected
}

function SetFlyoutScoreboardVisible( bVisible )
{
	$.GetContextPanel().SetHasClass( "flyout_scoreboard_visible", bVisible );
	if ( bVisible )
	{
		ScoreboardUpdater_SetScoreboardActive( g_ScoreboardHandle, true );
	}
	else
	{
		ScoreboardUpdater_SetScoreboardActive( g_ScoreboardHandle, false );
	}
}

function ToggleAbilities() {
	let state = SwitchCheckboxState("ToggleAbilities")
	$.GetContextPanel().SetHasClass("abilities_toggled", state)
}

function ToggleItems() {
	let state = SwitchCheckboxState("ToggleItems")
	$.GetContextPanel().SetHasClass("items_toggled", state)
}

// MF-18: «Мут всех» переведён на общий стор мута (GameUI.CustomUIConfig().MutePrefs) —
// те же 3 категории, что и в панели игрока. Иначе мутился только голос, а фильтры
// текста/колеса/tip не применялись, и инлайн-подмена фона иконки конфликтовала с
// классами mute_all/mute_custom. Иконки строк подхватят изменение своим поллингом.
function ToggleAllMute() {
	let mute_all_button = $("#MuteAllButton")
	if (mute_all_button.state == undefined) {
		mute_all_button.state = true
	}
	else {
		mute_all_button.state = !mute_all_button.state
	}
	let v = mute_all_button.state ? 1 : 0
	let cfg = GameUI.CustomUIConfig()
	if (!cfg.MutePrefs) { cfg.MutePrefs = {} }
	for (var i=0; i<=24;i++) {
		if (Players.IsValidPlayerID(i) && Game.GetLocalPlayerID() != i) {
			if (!cfg.MutePrefs[i]) { cfg.MutePrefs[i] = {text:0, sounds:0, other:0} }
			cfg.MutePrefs[i].text = v
			cfg.MutePrefs[i].sounds = v
			cfg.MutePrefs[i].other = v
			Game.SetPlayerMuted( i, v ? true : false )
		}
	}
	// Персист (MF-18 этап 2). Отдельное событие вместо 24 одиночных: сервер применит
	// ко всем игрокам игры и запишет в БД ОДИН раз.
	GameEvents.SendCustomGameEventToServer("mute_prefs_all_changed", {
		PlayerID: Players.GetLocalPlayer(),
		value: v,
	})
}

function ToggleMuteSounds()
{
    $("#MuteVoicesButton").SetHasClass("muted_chat_wheel", !$("#MuteVoicesButton").BHasClass("muted_chat_wheel"))
    GameUI.CustomUIConfig().MuteSoundsChatWheel = $("#MuteVoicesButton").BHasClass("muted_chat_wheel")
}

(function()
{
	if ( ScoreboardUpdater_InitializeScoreboard === null ) { $.Msg( "WARNING: This file requires shared_scoreboard_updater.js to be included." ); }

	var scoreboardConfig =
	{
		"teamXmlName" : "file://{resources}/layout/custom_game/multiteam_flyout_scoreboard/multiteam_flyout_scoreboard_team.xml",
		"playerXmlName" : "file://{resources}/layout/custom_game/multiteam_flyout_scoreboard/multiteam_flyout_scoreboard_player.xml",
	};
	g_ScoreboardHandle = ScoreboardUpdater_InitializeScoreboard( scoreboardConfig, $( "#TeamsContainer" ) );
	

	SetFlyoutScoreboardVisible( false );

	$.Schedule(5, function() {
		ToggleAbilities()
		ToggleItems()
	})
	
	
	$.RegisterEventHandler( "DOTACustomUI_SetFlyoutScoreboardVisible", $.GetContextPanel(), SetFlyoutScoreboardVisible );

	// При открытии формы репорта — прячем таблицу счёта, чтобы форма была одна на экране.
	GameEvents.Subscribe( "show_player_report", function () { SetFlyoutScoreboardVisible( false ); } );
})();