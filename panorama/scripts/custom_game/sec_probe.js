--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// [SEC-EVT] ВРЕМЕННЫЙ диагностический probe. Удалить вместе с include в actor_confirm.xml
// и листенером zxc_sec_probe (addon_game_mode.lua) после того, как факт установлен.
//
// Отвечает на один вопрос: переживает ли ПОДДЕЛАННЫЙ PlayerID путь клиент → сервер?
// Весь мод доверяет event.PlayerID как отправителю (аудит 2026-06-23, M2/M3), но
// проверено это не было: движок, возможно, сам перезаписывает поле авторитетным значением.
//
// Шлём заведомо чужой PlayerID: 999 при реальном локальном PlayerID в поле real.
// Смотреть в консоли сервера (DEBUG_PRINT_STATUS=true) строку [SEC-EVT] PROBE:
//   claimed=999          -> клиентское поле ПЕРЕЖИВАЕТ -> дыра реальна, чинить обязательно.
//   claimed=<реальный>   -> движок перезаписывает PlayerID -> импersonation невозможен.
//
// Только в тулзах: на проде не отправляется вообще.

(function _SecProbeInit(){
	if(!Game.IsInToolsMode()){ return }

	let local_pid = Game.GetLocalPlayerID()
	if(local_pid === -1){
		$.Schedule(0.5, _SecProbeInit)
		return
	}

	GameEvents.SendCustomGameEventToServer("zxc_sec_probe", {
		PlayerID: 999,      // заведомая подделка
		real: local_pid,    // кто на самом деле шлёт
	})
})();