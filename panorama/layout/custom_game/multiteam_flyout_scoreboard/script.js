--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LocalPlayer = Players.GetLocalPlayer()

// === MF-18: единый мут по игроку ===
// 3 категории: text / sounds (голос+колесо) / other (типы). Все 3 включены = «мут всего»
// (иконка красная), 1-2 = частичный (жёлтая). ЛКМ по кнопке = быстро мут/размут всего,
// ПКМ = панель игрока с настройками. Префы — общий стор GameUI.CustomUIConfig().MutePrefs
// (ключ — PlayerID цели); тот же стор читают фильтры чата/колеса/tip в других панелях.
function _MutePrefsStore(){
    let cfg = GameUI.CustomUIConfig()
    if(!cfg.MutePrefs){ cfg.MutePrefs = {} }
    return cfg.MutePrefs
}
function _GetMutePrefs(pid){
    let store = _MutePrefsStore()
    if(!store[pid]){ store[pid] = {text:0, sounds:0, other:0} }
    return store[pid]
}
function _ApplyMute(pid){
    let p = _GetMutePrefs(pid)
    // Голос+колесо = категория «Звуки». Текст/tip фильтруются на приёме по стору.
    Game.SetPlayerMuted( pid, p.sounds ? true : false )
    _UpdateMuteIcon(pid)
}
function _UpdateMuteIcon(pid){
    let btn = $.GetContextPanel().FindChildTraverse("MuteButton")
    if(!btn){ return }
    let p = _GetMutePrefs(pid)
    let any = (p.text || p.sounds || p.other) ? true : false
    let all = (p.text && p.sounds && p.other) ? true : false
    btn.SetHasClass("mute_all", all)                 // все 3 → красный
    btn.SetHasClass("mute_custom", (!all && any))    // 1-2 → жёлтый
}
// ЛКМ — быстро мут/размут всего (все 3 категории).
function ToggleMuteAll(){
    let pid = $.GetContextPanel().GetAttributeInt( "player_id", -1 )
    if( pid === -1 ){ return }
    let p = _GetMutePrefs(pid)
    let v = (p.text && p.sounds && p.other) ? 0 : 1
    p.text = v; p.sounds = v; p.other = v
    _ApplyMute(pid)
    _SaveMutePrefs(pid)
}
// Персист (MF-18 этап 2): сервер обновит словарь по steamid32 цели и запишет в БД.
// Шлём событие напрямую, а не через MutePrefsSave: в контексте строки таблицы нет utils.js
// (SubscribeAndFirePlayerTableByKey тут недоступна — на этом уже падал script.js).
function _SaveMutePrefs(pid){
    let p = _GetMutePrefs(pid)
    GameEvents.SendCustomGameEventToServer("mute_prefs_changed", {
        PlayerID: Players.GetLocalPlayer(),
        target_player_id: pid,
        text: p.text ? 1 : 0,
        sounds: p.sounds ? 1 : 0,
        other: p.other ? 1 : 0,
    })
}
// ПКМ — открыть панель игрока (ActorPanel: аватар/герой + мут-категории + репорт).
// Через сервер (как Alt+клик): сервер шлёт ShowActorPanel обратно этому игроку.
function OpenActorPanel(){
    let pid = $.GetContextPanel().GetAttributeInt( "player_id", -1 )
    if( pid === -1 ){ return }
    GameEvents.SendCustomGameEventToServer("actor_panel_open", { PlayerID: Players.GetLocalPlayer(), target_player_id: pid })
}

// Открыть форму репорта на этого игрока. Кросс-панель через сервер (строка →
// сервер → show_player_report обратно этому игроку → HUD player_report).
function OpenReport(){
	var playerId = $.GetContextPanel().GetAttributeInt( "player_id", -1 );
	if ( playerId !== -1 )
	{
		GameEvents.SendCustomGameEventToServer("player_report_open", { PlayerID: Players.GetLocalPlayer(), target_player_id: playerId })
	}
}

  function HeroIconClicked(bDoubleClick)
{
    
    var targetPlayerId= $.GetContextPanel().GetAttributeInt( "player_id", -1 )
    var targetHero =Players.GetPlayerHeroEntityIndex(targetPlayerId)
    if  (targetHero!=undefined) {
        GameUI.SelectUnit(targetHero, false)
        // Камера — только по двойному клику, клиентски (без серверного лока → без дрейфа)
        if(bDoubleClick && Entities.IsValidEntity(targetHero)){
            GameUI.MoveCameraToEntity(targetHero)
        }
    }
    GameEvents.SendCustomGameEventToServer('HeroIconClicked', {playerId:Players.GetLocalPlayer(), targetPlayerId:targetPlayerId,doubleClick:bDoubleClick,controldown:GameUI.IsControlDown(),altdown:GameUI.IsAltDown()})
}

let playerId = $.GetContextPanel().GetAttributeInt("player_id", -1);

// MF-18: инициализация иконки мута из текущих префов при сборке строки.
// Фикс бага персиста голоса: движок помнит voice-mute по SteamID между играми, но иконка
// не ставилась → в новой игре реально замучен, а иконки нет. Отражаем engine-мут как sounds.
(function _InitMuteIcon(){
	if(playerId === -1){ return }
	let p = _GetMutePrefs(playerId)
	if(Game.IsPlayerMuted(playerId) && !p.sounds){ p.sounds = 1 }
	_UpdateMuteIcon(playerId)
})();

// Синк иконки: префы меняются и из панели игрока (другой контекст) — периодически
// перечитываем стор и обновляем цвет иконки (красный «Всё» / жёлтый частичный).
(function _MuteIconPoll(){
	if(playerId !== -1){ _UpdateMuteIcon(playerId) }
	$.Schedule(0.3, _MuteIconPoll)
})();