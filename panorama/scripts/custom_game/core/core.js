--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var global = this;
function print(...args) {
    let params = [];
    for (let i = 0; i < arguments.length; i++) {
        params.push(arguments[i], ' ');
    }
    return $.Msg(...params);
}

var _a, _b, _c, _d;
ENV_NAME = $.GetContextPanel().layoutfile;
let CustomUIConfig = GameUI.CustomUIConfig();
let __core__ = CustomUIConfig.__core__ ? (CustomUIConfig.__core__[ENV_NAME] = (_a = CustomUIConfig.__core__[ENV_NAME]) !== null && _a !== void 0 ? _a : {}) : ((CustomUIConfig.__core__ = {})[ENV_NAME] = {});
if ($.GetContextPanel()['__loaded__'] == undefined) {
    $.GetContextPanel()['__loaded__'] = true;
    __core__.iLoad = 1;
}
else {
    __core__.iLoad += 1;
}
LoadCount = () => __core__.iLoad;
let bLoading = 'CustomLoadingScreenContainer' == $.GetContextPanel().id;
let bMain = 'CustomUI' == $.GetContextPanel().id;
{
    if (bMain || bLoading) {
        if (CustomUIConfig.__lib__ == undefined) {
            CustomUIConfig.__lib__ = {};
        }
        else {
            for (const k in CustomUIConfig.__lib__)
                global[k] = CustomUIConfig.__lib__[k];
        }
    }
    else {
        for (const k in CustomUIConfig.__lib__)
            global[k] = CustomUIConfig.__lib__[k];
    }
}
{
    if (bMain || bLoading) {
        for (const v of Object.values((_b = GameUI.CustomUIConfig().tools) !== null && _b !== void 0 ? _b : {})) {
            if (typeof (v['Init']) == 'function') {
                v['Init'](LoadCount() > 1);
            }
        }
    }
    $['_Localize'] = (_c = $['_Localize']) !== null && _c !== void 0 ? _c : $.Localize;
    $.Localize = function (token, value, parent) {
        if (value == undefined) {
            if (parent)
                return $['_Localize'](token, parent);
            return $['_Localize'](token, $.GetContextPanel());
        }
        if (parent)
            return $['_Localize'](token, value, parent);
        return $['_Localize'](token, value, $.GetContextPanel());
    };
    $['_Warning'] = $['_Warning'] || $.Warning;
    $.Warning = function (...args) {
        GameUI.CustomUIConfig().UploadError(args.join('\n'));
    };
}
if (GameUI.CustomUIConfig().UploadError == undefined) {
    const tErrorRecord = {};
    GameUI.CustomUIConfig().UploadError = function (error, sExtraMgs, sTag) {
        var _a, _b;
        let hError = error;
        if (error == undefined) {
            hError = new Error("未知错误");
        }
        else if (typeof error == 'string') {
            hError = { name: error, message: error, stack: error };
        }
        if (sExtraMgs) {
            $['_Warning'](hError.stack + '\n' + sExtraMgs);
        }
        else {
            $['_Warning'](hError.stack);
        }
        let sMsg = hError.message;
        let t = sMsg.match(/Invalid value for property \'.*\':/);
        if (t) {
            sMsg = t[0];
        }
        if (tErrorRecord[sMsg] == undefined) {
            tErrorRecord[sMsg] = true;
            if (sExtraMgs) {
                GameEvents.SendCustomGameEventToServer('upload_error', { name: sMsg, msg: sExtraMgs + '\n' + ((_a = hError.stack) !== null && _a !== void 0 ? _a : ''), tag: sTag });
            }
            else {
                GameEvents.SendCustomGameEventToServer('upload_error', { name: sMsg, msg: (_b = hError.stack) !== null && _b !== void 0 ? _b : '', tag: sTag });
            }
        }
    };
    GameUI.CustomUIConfig().tools.Timer.Timer(() => {
        const tError = GameUI.CustomUIConfig().tools.js2lua('ClientLuaError');
        if (tError != undefined) {
            for (const t of tError) {
                GameEvents.SendCustomGameEventToServer('upload_error', t);
            }
        }
        return 1;
    }, 1, 'UploadError');
}
{
    if (bMain && !CustomUIConfig.__client_finished_loading__) {
        const notify = () => {
            const iCLuaLoad = CustomUIConfig.tools.runlua(`return _G.__core__iLoad`);
            if (iCLuaLoad != undefined && Players.IsValidPlayerID(Players.GetLocalPlayer())) {
                $.Schedule(1, () => {
                    CustomUIConfig.__client_finished_loading__ = true;
                    GameEvents.SendCustomGameEventToServer("client_finished_loading", {});
                });
                return;
            }
            $.Schedule(0.1, notify);
        };
        $.Schedule(0, notify);
    }
}
if (CustomUIConfig.tools) {
    if (CustomUIConfig.tools.EventManager) {
        CustomUIConfig.tools.EventManager.Fire('ON_LOAD_XML', { sEnvName: ENV_NAME, bReload: LoadCount() > 1 });
    }
}
print('UI loaded', ENV_NAME, __core__.iLoad);
if (Game.IsInToolsMode()) {
    const time_delay = Game.Time() + 0.1;
    Players['_GetLocalPlayer'] = (_d = Players['_GetLocalPlayer']) !== null && _d !== void 0 ? _d : Players.GetLocalPlayer;
    Players.GetLocalPlayer = () => {
        if (Game.Time() > time_delay)
            return Players['_GetLocalPlayer']();
        return -1;
    };
}