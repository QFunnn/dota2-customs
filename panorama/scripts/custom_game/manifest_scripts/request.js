--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig()._Request_QueueIndex ??= 0;
GameUI.CustomUIConfig()._Request_Table ??= {};
GameUI.CustomUIConfig()._Request_Result ??= {};
GameUI.CustomUIConfig()._Request_Timeout_Table ??= {};
if (GameUI.CustomUIConfig()._Request_Listener != undefined) {
	GameEvents.Unsubscribe(GameUI.CustomUIConfig()._Request_Listener);
}
function Think() {
	let playerID = Players.GetLocalPlayer();
	if (playerID == -1) {
		$.Schedule(0, Think);
	} else {
		GameUI.CustomUIConfig()._Request_Listener = CustomNetTables.SubscribeNetTableListener(`request_${playerID}`, (tableName, queueIndex, data) => {
			let index = queueIndex.replaceAll(`_____${data.nowStep}`, "");
			if (GameUI.CustomUIConfig()._Request_Result[index] == undefined) {
				GameUI.CustomUIConfig()._Request_Result[index] = {};
			}
			GameUI.CustomUIConfig()._Request_Result[index][data.nowStep] = data.result;
			let bFinished = true;
			for (let i = data.maxStep; i > 0; i--) {
				let a = GameUI.CustomUIConfig()._Request_Result[index][i];
				if (a == undefined) {
					bFinished = false;
				}
			}
			if (!bFinished) return;
			let func = GameUI.CustomUIConfig()._Request_Table[index];
			delete GameUI.CustomUIConfig()._Request_Table[index];
			let scheduleID = GameUI.CustomUIConfig()._Request_Timeout_Table[index];
			if (scheduleID != undefined) {
				$.CancelScheduled(scheduleID);
				delete GameUI.CustomUIConfig()._Request_Timeout_Table[index];
			}
			if (!func) return;

			let s = "";
			for (let i = 1; i <= data.maxStep; i++) {
				s += GameUI.CustomUIConfig()._Request_Result[index][i];
			}
			try {
				func(JSON.parse(s));
			} catch (error) {
			}
			// func(JSON.parse(data.result));

			GameEvents.SendCustomEventToServer("cancel_server_request_event", {
				queueIndex: index
			});
			delete GameUI.CustomUIConfig()._Request_Result[index];
		});
	}
}
Think();