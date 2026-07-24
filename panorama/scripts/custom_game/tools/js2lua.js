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
    function js2lua(sKey, params) {
        GameEvents.SendEventClientSide('js2lua', { 'key': sKey, 'params': params });
        if (js2lua['bridge'] == undefined) {
            for (const i of Entities.GetAllEntitiesByClassname('item_lua')) {
                if (Abilities.GetAbilityName(i) == 'item_js2lua') {
                    js2lua['bridge'] = i;
                    break;
                }
            }
            if (js2lua['bridge'] == undefined)
                return;
        }
        let r = Abilities.GetAbilityTextureName(js2lua['bridge']);
        if (r == undefined || r == '' || r == 'item_lockicon')
            return;
        return JSON.parse(r);
    }
    tools.js2lua = js2lua;
    function runlua(lua) {
        let t = js2lua('run', { 'lua': lua });
        if (t) {
            if (t.b == false)
                throw t.r;
            return t.r;
        }
    }
    tools.runlua = runlua;
    function AttributeGet(iEntID, sAttributeName, key, ...args) {
        const v = js2lua('AttributeGet', {
            'ent_id': iEntID,
            'name': sAttributeName,
            'key': key,
            'args': args,
        });
        if (v != undefined && typeof v != 'object') {
            return v;
        }
    }
    tools.AttributeGet = AttributeGet;
    function AttributeData(iEntID, sAttributeName) {
        var _a;
        return (_a = js2lua('AttributeData', {
            'ent_id': iEntID,
            'name': sAttributeName,
        })) !== null && _a !== void 0 ? _a : [];
    }
    tools.AttributeData = AttributeData;
    function EntIndexToHScript(iEntID) {
        return ['__lua__', `EntIndexToHScript(${iEntID})`];
    }
    tools.EntIndexToHScript = EntIndexToHScript;
    function BuffToModifier(iEntID, iBuffID) {
        return ['__lua__', `EntIndexToHScript(${iEntID}):FindModifierByJsBuff("${Buffs.GetName(iEntID, iBuffID)}",${Buffs.GetCreationTime(iEntID, iBuffID)})`];
    }
    tools.BuffToModifier = BuffToModifier;
    function PolymerIDToDiyPolymer(iEntID, iPolymerID) {
        return ['__lua__', `EntIndexToHScript(${iEntID}):FindPolymerByID(${iPolymerID})`];
    }
    tools.PolymerIDToDiyPolymer = PolymerIDToDiyPolymer;
    Entities.UnitFilter = (entid, teamFilter, typeFilter, flagFilter, team) => {
        var _a;
        return (_a = js2lua('UnitFilter', { 'ent_id': entid, 'target_team': teamFilter, 'target_type': typeFilter, 'target_flags': flagFilter, team })) !== null && _a !== void 0 ? _a : -1;
    };
    Abilities.GetCooldownModified = (iAbltID) => {
        let iEntID = Abilities.GetCaster(iAbltID);
        let fBaseCooldown = Abilities.GetCooldown(iAbltID);
        let fCooldown = GameUI.CustomUIConfig().tools.AttributeKind.Cooldown.Get(iEntID, undefined, { 'ability': EntIndexToHScript(iAbltID) });
        let fVal = fBaseCooldown * (1 - fCooldown / (fCooldown + 300));
        let fMin = fBaseCooldown * (1 - 1200 / (1200 + 300));
        return Math.max(fVal, fMin);
    };
    Abilities.GetManaCostModified = (iAbltID) => {
        Abilities.GetCaster(iAbltID);
        return Abilities.GetManaCost(iAbltID);
    };
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;