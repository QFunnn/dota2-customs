--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// Панель действий по игроку (Alt+ЛКМ по верхней панели ИЛИ ПКМ в таблице счёта).
// Показывает аватар/ник/уровень/героя + мут-категории (MF-18) + репорт (MF-9).

// MF-18: префы мута — общий клиентский стор GameUI.CustomUIConfig().MutePrefs, ключ — PlayerID цели.
// Категории: text/sounds/other (0/1); «мут всего» = все 3 включены (отдельного флага all НЕТ). Тот же стор
// читают фильтры чата/колеса/tip в других панелях. Персист между играми (по SteamID цели) —
// mute_prefs.js: он же заполняет стор при заходе, здесь только шлём изменения (MutePrefsSave).
function _ActorMutePrefs(pid)
{
	let cfg = GameUI.CustomUIConfig()
	if(!cfg.MutePrefs){ cfg.MutePrefs = {} }
	if(!cfg.MutePrefs[pid]){ cfg.MutePrefs[pid] = {text:0, sounds:0, other:0} }
	return cfg.MutePrefs[pid]
}
function _ActorApplyMute(pid)
{
	let p = _ActorMutePrefs(pid)
	// Голос+колесо = категория «Звуки». Текст/tip фильтруются на приёме по стору.
	Game.SetPlayerMuted( pid, p.sounds ? true : false )
	_ActorSyncOptions(pid)
}
// Опция активна → подчёркивание. Все 3 включены = «мут всего» → подчёркивание КРАСНОЕ,
// иначе ЖЁЛТОЕ (класс red на активных опциях).
function _ActorSyncOptions(pid)
{
	let p = _ActorMutePrefs(pid)
	let red = (p.text && p.sounds && p.other) ? true : false
	_ActorSetOpt("ActorMuteText", p.text, red)
	_ActorSetOpt("ActorMuteSounds", p.sounds, red)
	_ActorSetOpt("ActorMuteOther", p.other, red)
}
function _ActorSetOpt(id, on, red)
{
	let el = $("#" + id)
	if(!el){ return }
	el.SetHasClass("active", on ? true : false)
	el.SetHasClass("red", (on && red) ? true : false)
}
function ActorToggleMute(cat)
{
	let pid = $("#ActorPanel").target_player_id
	if(pid === undefined || pid === -1){ return }
	let p = _ActorMutePrefs(pid)
	p[cat] = p[cat] ? 0 : 1
	_ActorApplyMute(pid)
	MutePrefsSave(pid)   // персист по SteamID цели (mute_prefs.js)
}
// Репорт на игрока — тот же поток, что из таблицы счёта (сервер → форма). Панель закрываем.
function ActorReport()
{
	let pid = $("#ActorPanel").target_player_id
	if(pid === undefined || pid === -1){ return }
	GameEvents.SendCustomGameEventToServer("player_report_open", { PlayerID: Players.GetLocalPlayer(), target_player_id: pid })
	Cancle()
}

function ShowActorPanel(keys)
{
	var target_player_id = keys.target_player_id
	var targetPlayerInfo = Game.GetPlayerInfo( target_player_id )
	if (targetPlayerInfo != undefined)
	{
		$("#ActorPlayerImage").steamid = targetPlayerInfo.player_steamid
		$("#ActorHeroImage").SetImage( "file://{images}/heroes/" + targetPlayerInfo.player_selected_hero + ".png" )
		$("#PlayerName").text = targetPlayerInfo.player_name
		$("#HeroName").text = $.Localize("#hero_level")+" "+targetPlayerInfo.player_level +" "+ $.Localize("#"+targetPlayerInfo.player_selected_hero)
	}
	$("#ActorPanel").target_player_id = target_player_id
	// Действия (мут/репорт) не показываем на себе.
	var isSelf = (target_player_id == Players.GetLocalPlayer())
	$("#ActorActions").SetHasClass("self", isSelf)
	if(!isSelf){ _ActorSyncOptions(target_player_id) }
	$("#ActorPanel").RemoveClass("Hidden")
}

function Cancle()
{
	$("#ActorPanel").AddClass("Hidden");
}

(function()
{
	GameEvents.Subscribe("ShowActorPanel", ShowActorPanel);
})();