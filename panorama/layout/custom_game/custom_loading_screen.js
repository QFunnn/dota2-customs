--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

// Статус загрузки данных игроков с веб-сервера на экране загрузки.
// Пока данные грузятся - показываем "#upup_loading_label" (обычная надпись загрузки).
// Если хотя бы один игрок не смог загрузиться после всех попыток - сервер присылает
// state="error", и мы показываем "ошибка подключения к серверу" (игра при этом не стартует).

var g_SetupStatusReceived = false;

function SetLoadingState( state )
{
	var label = $( "#LoadingLabel" );
	if ( label === null )
		return;

	var isError = ( state === "error" );
	label.SetHasClass( "error", isError );

	if ( isError )
		label.text = $.Localize( "#upup_setup_error" );
	else
		label.text = $.Localize( "#upup_setup_loading" );
}

function OnSetupLoadStatus( data )
{
	g_SetupStatusReceived = true;
	SetLoadingState( data && data.state ? data.state : "loading" );
}

function RequestSetupLoadStatus( attemptsLeft )
{
	// Запрашиваем статус у сервера, повторяя, пока не придёт первый ответ
	// (на случай, если запрос ушёл раньше регистрации слушателя на сервере).
	GameEvents.SendCustomGameEventToServer( "event_request_setup_status", {} );
	if ( g_SetupStatusReceived )
		return;
	if ( attemptsLeft === undefined )
		attemptsLeft = 15;
	if ( attemptsLeft <= 0 )
		return;
	$.Schedule( 1.0, function() { RequestSetupLoadStatus( attemptsLeft - 1 ); } );
}

(function()
{
	GameEvents.Subscribe( "event_setup_load_status", OnSetupLoadStatus );
	RequestSetupLoadStatus();
})();