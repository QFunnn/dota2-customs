--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// MF-18 (этап 2): загрузка/сохранение мут-префов между играми.
//
// Стор GameUI.CustomUIConfig().MutePrefs общий для всех панорама-контекстов (ключ — PlayerID
// цели), но живёт только в памяти клиента -> при перезаходе сбрасывался. Здесь он заполняется
// из приватной player-table `mute_prefs`, которую сервер публикует уже отрезолвленной в
// PlayerID текущей игры (в БД префы лежат по steamid32 цели — слот между играми разный).
//
// Реконнект работает сам собой: значение player-table хранится на сервере, панорама после
// перезахода переподписывается и получает его первым же вызовом (SubscribeAndFire).
//
// Подключён в actor_confirm.xml (HUD, живёт всю игру) — достаточно ОДНОГО загрузчика на клиент,
// т.к. стор общий. Отправку изменений (MutePrefsSave) вызывают панели с UI мута; строка таблицы
// счёта шлёт то же событие напрямую — у неё нет доступа к utils.js.

function _MutePrefsStoreShared(){
	let cfg = GameUI.CustomUIConfig()
	if(!cfg.MutePrefs){ cfg.MutePrefs = {} }
	return cfg.MutePrefs
}

// Применяем префы из БД к клиенту. Голос отдаём движку (Game.SetPlayerMuted), текст/остальное
// фильтруются на приёме по стору.
function _MutePrefsApplyFromServer(data){
	let store = _MutePrefsStoreShared()
	let local_pid = Game.GetLocalPlayerID()

	for(let pid = 0; pid <= 24; pid++){
		if(pid === local_pid){ continue }
		if(!Players.IsValidPlayerID(pid)){ continue }

		let entry = (data && data[pid]) ? data[pid] : null
		if(!store[pid]){ store[pid] = {text:0, sounds:0, other:0} }

		store[pid].text  = (entry && entry.text)  ? 1 : 0
		store[pid].other = (entry && entry.other) ? 1 : 0

		// Голос: ИЛИ между префом из БД и движковым мутом. Движок помнит voice-mute по SteamID
		// сам (в т.ч. мут, поставленный вне нашего UI) — не размучиваем его тем, что в БД 0.
		let db_sounds = (entry && entry.sounds) ? true : false
		store[pid].sounds = (db_sounds || Game.IsPlayerMuted(pid)) ? 1 : 0

		if(db_sounds && !Game.IsPlayerMuted(pid)){ Game.SetPlayerMuted(pid, true) }
	}
}

// Сохранить префы по цели (сервер обновит свой словарь по steamid32 и запишет в БД).
function MutePrefsSave(pid){
	let store = _MutePrefsStoreShared()
	let p = store[pid]
	if(!p){ return }

	GameEvents.SendCustomGameEventToServer("mute_prefs_changed", {
		PlayerID: Players.GetLocalPlayer(),
		target_player_id: pid,
		text: p.text ? 1 : 0,
		sounds: p.sounds ? 1 : 0,
		other: p.other ? 1 : 0,
	})
}

// Классическая дотовская кнопка мута (в таблице счёта: per-player по ЛКМ и «замутить всех»)
// меняет движковый voice-mute НАПРЯМУЮ, мимо нашего UI. Поллим состояние движка и отражаем его
// в категорию `sounds` общего стора + персистим (MutePrefsSave -> БД по SteamID цели). Реагируем
// и на мут, и на анмут — чтобы иконки/фильтры совпадали с реальностью, а классический мут пережил
// реконнект и следующую игру. Наш собственный UI ставит engine == sounds, поэтому лишних сейвов
// не будет: срабатывает только на РАСХОЖДЕНИЕ, т.е. когда мут пришёл извне нашего UI.
(function _EngineMuteSyncPoll(){
	let local_pid = Game.GetLocalPlayerID()
	if(local_pid !== -1){
		let store = _MutePrefsStoreShared()
		for(let pid = 0; pid <= 24; pid++){
			if(pid === local_pid){ continue }
			if(!Players.IsValidPlayerID(pid)){ continue }
			if(!store[pid]){ store[pid] = {text:0, sounds:0, other:0} }

			let engine_muted = Game.IsPlayerMuted(pid) ? 1 : 0
			if(engine_muted !== store[pid].sounds){
				store[pid].sounds = engine_muted
				MutePrefsSave(pid)   // персист классического мут/анмута (по SteamID цели)
			}
		}
	}
	$.Schedule(0.4, _EngineMuteSyncPoll)
})();

// На раннем парсе HUD локальный PlayerID и PlayerTables могут быть ещё не готовы
// (SubscribeAndFirePlayerTableByKey вернёт -1) — в этом случае пробуем снова, иначе префы
// молча не загрузились бы вовсе.
(function _MutePrefsInit(){
	let local_pid = Game.GetLocalPlayerID()
	if(local_pid !== -1){
		let handle = SubscribeAndFirePlayerTableByKey(`player_${local_pid}`, `mute_prefs`, function(v){
			_MutePrefsApplyFromServer(v)
			// Повтор: на заходе/реконнекте таблица может прийти раньше, чем часть игроков
			// станет валидной (Players.IsValidPlayerID) — тогда их префы пропустились бы,
			// а повторной публикации не будет (значение на сервере не менялось).
			$.Schedule(2.0, function(){ _MutePrefsApplyFromServer(v) })
		})
		if(handle !== -1){ return }
	}
	$.Schedule(0.5, _MutePrefsInit)
})();