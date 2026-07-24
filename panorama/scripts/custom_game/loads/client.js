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

var _a, _b, _c;
let iServiceLoadCount = (_a = GameUI.CustomUIConfig()['ServiceLoadCount']) !== null && _a !== void 0 ? _a : 0;
let iNettableID_client_load;
let iScheduleID;
let load_check = () => {
    let iServiceLoadCountCur = iServiceLoadCount;
    let tScripts = {};
    let tInfo = [];
    let iFinished = 0;
    function waitLua() {
        const iLuaLoadCount = GameUI.CustomUIConfig().tools.runlua(`return _G.__load_service_load_count`);
        if (iLuaLoadCount == undefined) {
            iScheduleID = $.Schedule(0, waitLua);
        }
        else {
            startFile();
        }
    }
    function startFile() {
        CustomNetTables.GetAllTableValues('client_load').map((v) => {
            onFileLoad(v.key, v.value);
        });
        iNettableID_client_load = CustomNetTables.SubscribeNetTableListener('client_load', (sTab, sKey, t) => {
            onFileLoad(sKey, t);
        });
        iScheduleID = $.Schedule(0, checkFileFinished);
    }
    function onFileLoad(sKey, t) {
        if (sKey == '_INFO_') {
            tInfo = [];
            for (let i = 1; true; ++i) {
                if (t[i] == undefined)
                    break;
                tInfo.push({
                    path: t[i][1],
                    count: t[i][2],
                    load_count: t[i][3],
                });
            }
            for (let i = iFinished; i < tInfo.length; ++i) {
                let { path, count } = tInfo[i];
                if (count > 0) {
                    let tScript = tScripts[path];
                    if (tScript == undefined)
                        return;
                    for (; count > 0; --count)
                        if (!tScript[count])
                            return;
                }
                print('/// System_Client_Js ///', `load_check notify lua file=${path} file_index=${i} load_count=${iServiceLoadCountCur}`);
                ++iFinished;
                GameEvents.SendEventClientSide('client_load', tInfo[i]);
            }
        }
        else {
            let tParams = sKey.split(',');
            if (1 == tParams.length)
                return;
            const sPath = tParams[0];
            tParams = tParams[1].split('/');
            const iOrder = Number(tParams[0]);
            let iCount = Number(tParams[1]);
            if (undefined == tScripts[sPath])
                tScripts[sPath] = {};
            tScripts[sPath][iOrder] = true;
            for (; iCount > 0; --iCount)
                if (!tScripts[sPath][iCount])
                    return;
            for (let i = iFinished; i < tInfo.length; ++i) {
                let { path, count } = tInfo[i];
                if (count > 0) {
                    let tScript = tScripts[path];
                    if (tScript == undefined)
                        return;
                    for (; count > 0; --count)
                        if (!tScript[count])
                            return;
                }
                print('/// System_Client_Js ///', `load_check notify lua file=${path} file_index=${i} load_count=${iServiceLoadCountCur}`);
                ++iFinished;
                GameEvents.SendEventClientSide('client_load', tInfo[i]);
            }
        }
    }
    function checkFileFinished() {
        if (iNettableID_client_load == undefined) {
            return;
        }
        if (tInfo.length > 0 && tInfo.length == iFinished) {
            print('/// System_Client_Js ///', `load_check finished ${iFinished}/${tInfo.length} load_count=${iServiceLoadCountCur}`);
            tScripts = {};
            tInfo = [];
            iFinished = 0;
            CustomNetTables.UnsubscribeNetTableListener(iNettableID_client_load);
            iNettableID_client_load = undefined;
            GameEvents.SendEventClientSide('client_load_finished', {});
            iScheduleID = $.Schedule(0, checkLuaFinished);
            return;
        }
        iScheduleID = $.Schedule(0, checkFileFinished);
    }
    function checkLuaFinished() {
        const iLuaLoadCount = GameUI.CustomUIConfig().tools.runlua(`return _G.__load_service_load_count`);
        if (iLuaLoadCount >= iServiceLoadCount) {
            delete GameUI.CustomUIConfig()['__config__'];
            GameUI.CustomUIConfig().tools.EventManager.Fire('ON_SERVICE_LOAD', { count: iServiceLoadCountCur });
            iScheduleID = undefined;
            return;
        }
        iScheduleID = $.Schedule(0, checkLuaFinished);
    }
    iScheduleID = $.Schedule(0, waitLua);
};
if (iServiceLoadCount < ((_c = (_b = CustomNetTables.GetTableValue('service', 'load')) === null || _b === void 0 ? void 0 : _b.count) !== null && _c !== void 0 ? _c : 0)) {
    iServiceLoadCount = CustomNetTables.GetTableValue('service', 'load').count;
    GameUI.CustomUIConfig()['ServiceLoadCount'] = iServiceLoadCount;
    print('/// System_Client_Js ///', `First load_check at load_count=${iServiceLoadCount}`);
    load_check();
}
CustomNetTables.SubscribeNetTableListener('service', (sTab, sKey, t) => {
    if (t != undefined && sKey == 'load') {
        if (iServiceLoadCount != t.count) {
            iServiceLoadCount = t.count;
            GameUI.CustomUIConfig()['ServiceLoadCount'] = iServiceLoadCount;
            if (iNettableID_client_load != undefined) {
                CustomNetTables.UnsubscribeNetTableListener(iNettableID_client_load);
                iNettableID_client_load = undefined;
            }
            if (iScheduleID != undefined) {
                $.CancelScheduled(iScheduleID);
                iScheduleID = undefined;
            }
            print('/// System_Client_Js ///', `Next load_check at load_count=${iServiceLoadCount}`);
            load_check();
        }
    }
});