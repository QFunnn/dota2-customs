--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict';

// ---------------- NetTable centralized listener ----------------
// init.js is loaded once by custom_ui_manifest. Keep the shared listener hub
// here so loading common.js in another HUD context cannot reset other HUDs.
(function InitNetTableListenerHub() {
	if (GameUI.CustomUIConfig().__NETTABLE_LISTENER_INIT_DONE__) {
		return;
	}
	const customUIConfig = GameUI.CustomUIConfig();
	customUIConfig.__NETTABLE_LISTENER_INIT_DONE__ = true;
	const previousHub = customUIConfig.__NETTABLE_LISTENER_HUB__;
	const nativeAPI = customUIConfig.__NETTABLE_NATIVE_API__ ?? {
		subscribe: previousHub?.rawSubscribe ?? CustomNetTables.SubscribeNetTableListener.bind(CustomNetTables),
		unsubscribe: previousHub?.rawUnsubscribe ?? CustomNetTables.UnsubscribeNetTableListener.bind(CustomNetTables),
	};
	customUIConfig.__NETTABLE_NATIVE_API__ = nativeAPI;
	customUIConfig.__NETTABLE_LISTENER_NEXT_ID__ ??= 1000000000;

	if (previousHub?.dispose) {
		previousHub.dispose();
	} else if (previousHub?.tables) {
		// Compatibility cleanup for the previous Hub implementation.
		for (const tableName in previousHub.tables) {
			const tableState = previousHub.tables[tableName];
			if (tableState && tableState.realListenerID != -1) {
				nativeAPI.unsubscribe(tableState.realListenerID);
			}
		}
	}

	const tables = {};
	const idToTable = {};

	function subscribe(tableName, callback) {
		let table = tables[tableName];
		if (!table) {
			table = {
				listenerID: -1,
				callbacks: {},
			};
			table.listenerID = nativeAPI.subscribe(tableName, (_tableName, key, value) => {
				for (const id in table.callbacks) {
					table.callbacks[id](key, value);
				}
			});
			tables[tableName] = table;
		}

		const id = ++customUIConfig.__NETTABLE_LISTENER_NEXT_ID__;
		table.callbacks[id] = callback;
		idToTable[id] = tableName;
		return id;
	}

	function unsubscribe(id) {
		const tableName = idToTable[id];
		if (tableName == undefined) {
			return false;
		}

		delete idToTable[id];
		const table = tables[tableName];
		if (!table) {
			return true;
		}

		delete table.callbacks[id];
		if (Object.keys(table.callbacks).length == 0) {
			nativeAPI.unsubscribe(table.listenerID);
			delete tables[tableName];
		}
		return true;
	}

	function dispose() {
		for (const tableName in tables) {
			nativeAPI.unsubscribe(tables[tableName].listenerID);
			delete tables[tableName];
		}
		for (const id in idToTable) {
			delete idToTable[id];
		}
	}

	const hub = { subscribe, unsubscribe, dispose };
	customUIConfig.__NETTABLE_LISTENER_HUB__ = hub;
	CustomNetTables.UnsubscribeNetTableListener = function (id) {
		if (unsubscribe(id)) {
			return;
		}
		return nativeAPI.unsubscribe(id);
	};
})();

// request相关
if (GameUI.CustomUIConfig()._Request_QueueIndex == undefined) {
	GameUI.CustomUIConfig()._Request_QueueIndex = 0;
}
if (GameUI.CustomUIConfig()._Request_Table == undefined) {
	GameUI.CustomUIConfig()._Request_Table = {};
}
if (GameUI.CustomUIConfig()._Request_Result == undefined) {
	GameUI.CustomUIConfig()._Request_Result = {};
}
if (GameUI.CustomUIConfig()._HUDRoot_ == undefined) {
	GameUI.CustomUIConfig()._HUDRoot_ = $.GetContextPanel();
}
if (GameUI.CustomUIConfig()._Request_Listener != undefined) {
	GameEvents.Unsubscribe(GameUI.CustomUIConfig()._Request_Listener);
}

GameUI.CustomUIConfig()._Request_Listener = GameEvents.Subscribe('server_request_event_result', function (data) {
	let index = data.queueIndex ?? '';
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
	if (!func) return;

	let s = '';
	for (let i = 1; i <= data.maxStep; i++) {
		s += GameUI.CustomUIConfig()._Request_Result[index][i];
	}
	try {
		func(JSON.parse(s));
	} catch (error) { }

	delete GameUI.CustomUIConfig()._Request_Result[index];
});

// Game.AddCommand("client_request_event_result", (_, queueIndex, result) => {
// 	let index = queueIndex ?? "";
// 	let func = GameUI.CustomUIConfig()._Request_Table[index];
// 	delete GameUI.CustomUIConfig()._Request_Table[index];
// 	if (!func) return;
// 	func(JSON.parse(result));
// }, "", 1 << 26);

GameUI.CustomUIConfig().CommandUniqueSuffix = String(Math.floor(Date.now() / 1000));

var offsetX = null;
var offsetY = null;
var Draggable = false;
var DragPanel = null;
function DragCallback() {
	var isLeftPressed = GameUI.IsMouseDown(0);
	if (isLeftPressed && DragPanel != null) {
		let position = GameUI.GetCursorPosition();
		if (offsetX == null || offsetY == null) {
			offsetX = DragPanel.GetPositionWithinWindow().x - position[0];
			offsetY = DragPanel.GetPositionWithinWindow().y - position[1];
			DragPanel.style.align = 'left top';
			DragPanel.style.margin = '0px 0px 0px 0px';
		}
		if (offsetX != null && offsetY != null) {
			DragPanel.SetPositionInPixels((position[0] + offsetX) / DragPanel.actualuiscale_x, (position[1] + offsetY) / DragPanel.actualuiscale_y, 0);
		}
	} else {
		offsetX = null;
		offsetY = null;
	}
	if (Draggable || isLeftPressed) {
		$.Schedule(Game.GetGameFrameTime(), DragCallback);
	} else {
		DragPanel = null;
	}
}
GameUI.CustomUIConfig()._PopupTempData = GameUI.CustomUIConfig()._PopupTempData ?? {};
GameUI.CustomUIConfig().StartDrag = function (panel) {
	Draggable = true;
	DragPanel = panel;
	DragCallback();
};
GameUI.CustomUIConfig().EndDrag = function () {
	Draggable = false;
};

/** NetData */
/** 用来接收数据 */
GameUI.CustomUIConfig().NET_DATA_STREAM = GameUI.CustomUIConfig().NET_DATA_STREAM ?? {};
/** 用来记录分段步数 */
GameUI.CustomUIConfig().NET_DATA_STREAM_STEP = GameUI.CustomUIConfig().NET_DATA_STREAM_STEP ?? {};
/** 用来记录传输中的数据，防止重复请求 */
GameUI.CustomUIConfig().NET_DATA_STREAM_KEY = GameUI.CustomUIConfig().NET_DATA_STREAM_KEY ?? {};
/** UI缓存，减少重复请求 */
GameUI.CustomUIConfig().NET_DATA_CACHE = GameUI.CustomUIConfig().NET_DATA_CACHE ?? {};
/** 记录已经被删除的请求uniqueID */
GameUI.CustomUIConfig().NET_DATA_DELETED_ID = GameUI.CustomUIConfig().NET_DATA_DELETED_ID ?? {};
/** 客户端全局数据 */
GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA = GameUI.CustomUIConfig().CLIENT_GLOBAL_DATA ?? {};
// $.Msg("NetData init");

if (GameUI.CustomUIConfig().NET_DATA_LISTENER != undefined) {
	GameEvents.Unsubscribe(GameUI.CustomUIConfig().NET_DATA_LISTENER);
}
var safeParse = function (str) {
	try {
		return JSON.parse(str);
	} catch (error) {
		error.message += '\n\tparams={str:' + str.length + '}';
		return null;
	}
};
/** net_data 前端 */
GameUI.CustomUIConfig().NETDATA_SPECIAL_RECONSTRUCT = {
	info_shop_product_group_by_tag: (data) => {
		let settings = CustomNetTables.GetTableValue('common', 'settings');
		let isToolMode = settings.is_in_tools_mode == 1;
		// 获取当前时间戳,秒
		var now = Math.floor(Date.now() / 1000);
		if (data) {
			for (const tag in data) {
				let len = data[tag].length;
				if (len > 0) {
					for (let index = data[tag].length - 1; index >= 0; index--) {
						const storeItem = data[tag][index];
						let flag = true;
						if (!isToolMode && storeItem.start_time != 0 && storeItem.start_time > now) {
							flag = false;
						}
						if (storeItem.end_time < now && storeItem.end_time != 0) {
							flag = false;
						}
						if (!flag) {
							data[tag].splice(index, 1);
						}
					}
				}
			}
		}
	},
};
/** NetData */
GameUI.CustomUIConfig().NET_DATA_LISTENER = GameEvents.Subscribe('net_data_stream', (data) => {
	if (data.deleted) {
		delete GameUI.CustomUIConfig().NET_DATA_STREAM[data.id];
		delete GameUI.CustomUIConfig().NET_DATA_STREAM_STEP[data.id];
		if (GameUI.CustomUIConfig().NET_DATA_DELETED_ID[data.id] != undefined) {
			$.CancelScheduled(GameUI.CustomUIConfig().NET_DATA_DELETED_ID[data.id]);
		}
		GameUI.CustomUIConfig().NET_DATA_DELETED_ID[data.id] = $.Schedule(10, () => {
			delete GameUI.CustomUIConfig().NET_DATA_DELETED_ID[data.id];
		});
	} else {
		if (GameUI.CustomUIConfig().NET_DATA_DELETED_ID[data.id] != undefined) {
			return;
		}
		if (GameUI.CustomUIConfig().NET_DATA_STREAM[data.id] == undefined) {
			GameUI.CustomUIConfig().NET_DATA_STREAM[data.id] = [];
			GameUI.CustomUIConfig().NET_DATA_STREAM_STEP[data.id] = 0;
		}
		if (data.done == 1) {
			GameUI.CustomUIConfig().NET_DATA_STREAM_STEP[data.id] = data.step + 1;
		}
		GameUI.CustomUIConfig().NET_DATA_STREAM[data.id][data.step] = data.data;
		if (GameUI.CustomUIConfig().NET_DATA_STREAM_STEP[data.id] > 0 && GameUI.CustomUIConfig().NET_DATA_STREAM[data.id].length == GameUI.CustomUIConfig().NET_DATA_STREAM_STEP[data.id]) {
			let f = false;
			for (let i = 0; i < GameUI.CustomUIConfig().NET_DATA_STREAM[data.id].length; i++) {
				if (!(typeof GameUI.CustomUIConfig().NET_DATA_STREAM[data.id][i] == 'string' && GameUI.CustomUIConfig().NET_DATA_STREAM[data.id][i].length > 0)) {
					f = true;
				}
			}
			if (!f) {
				let result = safeParse(GameUI.CustomUIConfig().NET_DATA_STREAM[data.id].join(''));
				if (result !== null) {
					if (typeof GameUI.CustomUIConfig().NETDATA_SPECIAL_RECONSTRUCT[data.key] == 'function') {
						GameUI.CustomUIConfig().NETDATA_SPECIAL_RECONSTRUCT[data.key](result);
					}
					GameUI.CustomUIConfig().NET_DATA_CACHE[data.key + data.bindPlayerID] = result;
					GameEvents.SendEventClientSide('custom_net_data_changed_client', { key: data.key, PlayerID: data.bindPlayerID });
				}
				delete GameUI.CustomUIConfig().NET_DATA_STREAM[data.id];
				delete GameUI.CustomUIConfig().NET_DATA_STREAM_STEP[data.id];
				delete GameUI.CustomUIConfig().NET_DATA_STREAM_KEY[data.key + data.bindPlayerID];
			}
		}
	}
});

function EmitSoundForPlayer(tData) {
	Game.EmitSound(tData.soundname);
}

function OnErrorMessage({ message, sound = 'General.CastFail_Custom' }) {
	GameUI.SendCustomHUDError(message, sound);
}

function OnSelectUnits({ units }) {
	let b = false;
	let a = units.split(',');
	for (let index = 0; index < a.length; index++) {
		let iEntIndex = Number(a[index]);
		if (isFinite(iEntIndex) && Entities.IsValidEntity(iEntIndex) && Entities.IsControllableByPlayer(iEntIndex, Players.GetLocalPlayer()) && Entities.IsSelectable(iEntIndex)) {
			if (!b) {
				b = true;
				GameUI.SelectUnit(-1, false);
			}
			GameUI.SelectUnit(iEntIndex, true);
		}
	}
}

let sendedLang = false;
let stopUpdate = false;
function Update() {
	$.Schedule(0.1, () => {
		if (!sendedLang) {
			if (Players.GetLocalPlayer() != -1) {
				sendedLang = true;
				stopUpdate = true;
				GameEvents.SendCustomGameEventToServer('PlayerLanguage', { PlayerID: Players.GetLocalPlayer(), language: $.Language().toLowerCase() });
			}
		}
		if (!stopUpdate) {
			Update();
		}
	});
}
GameUI.CustomUIConfig()._UNIT_STATES_DATA = {};
function UnitDataUpdate() {
	$.Schedule(0.03, () => {
		GameUI.CustomUIConfig()._UNIT_STATES_DATA = {};
		UnitDataUpdate();
	});
}

if (GameUI.CustomUIConfig()._PopupPropsList == undefined) {
	GameUI.CustomUIConfig()._PopupPropsList = {};
}
if (GameUI.CustomUIConfig()._PopupMainPropsList == undefined) {
	GameUI.CustomUIConfig()._PopupMainPropsList = {};
}
/** 观战相关 */
GameUI.GetSpectatorViewingInfo = () => {
	return {
		player_id: Players.GetLocalPlayer(),
		illusion: false,
	};
};

GameUI.CustomUIConfig()._Camera_Lock_Target_Ent = -1;
GameUI.CustomUIConfig()._Cosmetic_Preview_Live = false;
GameUI.CustomUIConfig()._Camera_Yaw = 0;
GameUI.CustomUIConfig()._Camera_Distance = 1590;
GameUI.CustomUIConfig()._Camera_Pitch = 60;
GameUI.CustomUIConfig()._Camera_HeightOffset = -340;

GameUI.CustomUIConfig().SetCameraYaw_C4 = (value) => {
	if (!GameUI.CustomUIConfig()._Cosmetic_Preview_Live) {
		GameUI.SetCameraYaw(value);
	}
	GameUI.CustomUIConfig()._Camera_Yaw = value;
};
GameUI.CustomUIConfig().SetCameraDistance_C4 = (value) => {
	if (!GameUI.CustomUIConfig()._Cosmetic_Preview_Live) {
		GameUI.SetCameraDistance(value);
	}
	GameUI.CustomUIConfig()._Camera_Distance = value;
};
GameUI.CustomUIConfig().SetCameraPitch_C4 = (value) => {
	if (!GameUI.CustomUIConfig()._Cosmetic_Preview_Live) {
		GameUI.SetCameraPitchMin(value);
		GameUI.SetCameraPitchMax(value);
	}
	GameUI.CustomUIConfig()._Camera_Pitch = value;
};
GameUI.CustomUIConfig().SetCameraLookAtPositionHeightOffset_C4 = (value) => {
	if (!GameUI.CustomUIConfig()._Cosmetic_Preview_Live) {
		GameUI.SetCameraLookAtPositionHeightOffset(value);
	}
	GameUI.CustomUIConfig()._Camera_HeightOffset = value;
};
GameUI.CustomUIConfig().CameraLockTargetWithAnimation = function (entIndex) {
	if (entIndex == undefined || entIndex == -1) {
		GameUI.SetCameraTarget(-1);
		return;
	}
	if (GameUI.CustomUIConfig()._Camera_Lock_Target_Ent == entIndex) {
		return;
	}
	if (Entities.IsValidEntity(entIndex)) {
		GameUI.CustomUIConfig()._Camera_Lock_Target_Ent = entIndex;
		if (!GameUI.CustomUIConfig()._Cosmetic_Preview_Live) {
			GameUI.SetCameraTarget(entIndex);
		}
	}
};

(function () {
	// // 获取客户端语言
	Update();
	UnitDataUpdate();
	GameEvents.Subscribe('error_message', OnErrorMessage);
	GameEvents.Subscribe('emit_sound_for_player', EmitSoundForPlayer);
	GameEvents.Subscribe('select_units', OnSelectUnits);

	GameEvents.Subscribe('set_camera_yaw', (data) => {
		GameUI.CustomUIConfig().SetCameraYaw_C4(data.yaw);
	});

	GameEvents.Subscribe('set_camera_target', (data) => {
		GameUI.CustomUIConfig().CameraLockTargetWithAnimation(data.target);
	});

	let HUD = $.GetContextPanel()?.GetParent()?.GetParent();
	if (HUD) {
		let PausedInfo = HUD?.FindChildTraverse('PausedInfo');
		if (PausedInfo) {
			PausedInfo.style.visibility = 'collapse';
		}
		let pToggleScoreboardButton = HUD?.FindChildTraverse('ToggleScoreboardButton');
		if (pToggleScoreboardButton) {
			pToggleScoreboardButton.style.visibility = 'collapse';
		}
		let ButtonBar = HUD?.FindChildTraverse('ButtonBar');
		if (ButtonBar) {
			ButtonBar.style.visibility = 'collapse';
		}

		let ToggleCoachingPanelButton = HUD?.FindChildTraverse('ToggleCoachingPanelButton');
		if (ToggleCoachingPanelButton) {
			ToggleCoachingPanelButton.style.visibility = 'collapse';
		}

		let HudChat = HUD?.FindChildTraverse('HudChat');
		if (HudChat) {
			HudChat.style.horizontalAlign = 'left';
			HudChat.style.transform = 'translateY(60px)';
			HudChat.style.width = '600px';
			HudChat.style.visibility = 'collapse';
			HudChat.SetAcceptsFocus(false);
		}

		let HudMiniMap = HUD?.FindChildTraverse('minimap_container');
		if (HudMiniMap) {
			HudMiniMap.style.visibility = 'collapse';
		}
	}

	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_KILLCAM, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_QUICK_STATS, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_BAR, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_PREGAME_STRATEGYUI, false);

	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_GAME_NAME, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_CLOCK, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_PANEL, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_PANEL, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_QUICKBUY, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_COURIER, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_PROTECT, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_GOLD, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_KILLCAM, false);
	// for (let index = 0; index < 50; index++) {
	// 	GameUI.SetDefaultUIEnabled(index, true);
	// }

	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_CUSTOMUI_BEHIND_HUD_ELEMENTS, false);
})();