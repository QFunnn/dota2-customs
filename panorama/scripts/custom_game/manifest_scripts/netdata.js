--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


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
var NETDATA_SPECIAL_RECONSTRUCT = {};
/** NetData */
GameUI.CustomUIConfig().NET_DATA_LISTENER = GameEvents.Subscribe("net_data_stream", (data) => {
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
				if (!(typeof (GameUI.CustomUIConfig().NET_DATA_STREAM[data.id][i]) == "string" && GameUI.CustomUIConfig().NET_DATA_STREAM[data.id][i].length > 0)) {
					f = true;
				}
			}
			if (!f) {
				let result = safeParse(GameUI.CustomUIConfig().NET_DATA_STREAM[data.id].join(''));
				if (result !== null) {
					if (typeof NETDATA_SPECIAL_RECONSTRUCT[data.key] == "function") {
						result = NETDATA_SPECIAL_RECONSTRUCT[data.key](result);
					}
					GameUI.CustomUIConfig().NET_DATA_CACHE[data.key + data.bindPlayerID] ??= {}
					// $.Msg("netdata"," ", data.key," ", data.override)
					GameUI.CustomUIConfig().NET_DATA_CACHE[data.key + data.bindPlayerID] = data.override == 1? result: ServiceTableOverride(GameUI.CustomUIConfig().NET_DATA_CACHE[data.key + data.bindPlayerID], result);
					GameEvents.SendEventClientSide("custom_net_data_changed_client", { key: data.key, PlayerID: data.bindPlayerID });
				}
				delete GameUI.CustomUIConfig().NET_DATA_STREAM[data.id];
				delete GameUI.CustomUIConfig().NET_DATA_STREAM_STEP[data.id];
				delete GameUI.CustomUIConfig().NET_DATA_STREAM_KEY[data.key + data.bindPlayerID];
			}
		}
	}
});

function ServiceTableOverride(mainTable, table) {
	for (const k in table) {
		const v = table[k];
		if (typeof v == "object") {
			if (typeof mainTable[k] == "object") {
				mainTable[k] = ServiceTableOverride(mainTable[k], v);
			} else {
				mainTable[k] = ServiceTableOverride({}, v);
			}
		} else {
			if (v == "nil") {
				delete mainTable[k];
			} else {
				mainTable[k] = v;
			}
		}
	}
	return mainTable;
}