--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var global = this;
var tools;
(function (tools) {
    var _a;
    const tRequestData = GameUI.CustomUIConfig()['__Request_data'] = (_a = GameUI.CustomUIConfig()['__Request_data']) !== null && _a !== void 0 ? _a : {
        resolve: {},
    };
    GameEvents.Subscribe('request_result', ({ event, key, time, res }) => {
        if (tRequestData.resolve[event] && tRequestData.resolve[event][key] && tRequestData.resolve[event][key]['time'] == time) {
            tRequestData.resolve[event][key](JSON.parse(res));
            delete tRequestData.resolve[event][key];
        }
    });
    async function Request(event, params, key = event) {
        var _a;
        const time = new Date().getTime();
        const resolve = (_a = tRequestData.resolve[event]) === null || _a === void 0 ? void 0 : _a[key];
        if (resolve != undefined && (time - resolve['time']) < 60000) {
            return;
        }
        GameEvents.SendCustomGameEventToServer('request', {
            event,
            key,
            time: time.toString(),
            params: JSON.stringify(params)
        });
        return await new Promise(resolve => {
            var _a;
            resolve['time'] = time;
            tRequestData.resolve[event] = (_a = tRequestData.resolve[event]) !== null && _a !== void 0 ? _a : {};
            tRequestData.resolve[event][key] = resolve;
        });
    }
    tools.Request = Request;
    function UnregRequest(event, key = event) {
        if (tRequestData.resolve[event] && tRequestData.resolve[event][key]) {
            delete tRequestData.resolve[event][key];
        }
    }
    tools.UnregRequest = UnregRequest;
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;