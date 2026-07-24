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
    class Player {
        static Init(bReload) {
            const t = CustomNetTables.GetTableValue('0', 'player');
            if (t)
                Player.Update(t);
            CustomNetTables.SubscribeNetTableListener('0', (sTable, sKey, t) => {
                if (sKey == 'player')
                    Player.Update(t);
            });
            const notify = () => {
                if (Players.IsValidPlayerID(Players.GetLocalPlayer())) {
                    GameEvents.SendCustomGameEventToServer('player_language', { 'l': $.Language().toLowerCase() });
                    return;
                }
                $.Schedule(0.1, notify);
            };
            $.Schedule(0, notify);
            const hero_update = () => {
                for (const k in Player.O2P) {
                    const iPlayerID = Player.O2P[k];
                    const iEntID = Players.GetPlayerHeroEntityIndex(iPlayerID);
                    if (this.P2H[iPlayerID] != iEntID) {
                        this.P2H[iPlayerID] = iEntID;
                        GameUI.CustomUIConfig().tools.runlua(`
                            _G.__player__P2H = _G.__player__P2H or {}
                            _G.__player__P2H[${iPlayerID}] = ${iEntID}
                        `);
                    }
                }
                $.Schedule(0, hero_update);
            };
            $.Schedule(0, hero_update);
        }
        static Update(t) {
            var _a;
            if (t == undefined)
                return;
            Player.iCount = t.count;
            Player.iHost = (_a = t.host) !== null && _a !== void 0 ? _a : -1;
            for (const sPlayerID in t.p2a) {
                let iAccountID = t.p2a[sPlayerID];
                let iPlayerID = Number(sPlayerID);
                Player.P2A[sPlayerID] = iAccountID;
                Player.A2P[iAccountID] = iPlayerID;
                if (t.p2o) {
                    let iOrder = t.p2o[sPlayerID];
                    Player.P2O[sPlayerID] = iOrder;
                    Player.O2P[iOrder] = iPlayerID;
                }
                if (t.disconnect && t.disconnect[sPlayerID] == 1) {
                    Player.tDisconnect[sPlayerID] = true;
                }
                else {
                    delete Player.tDisconnect[sPlayerID];
                }
                if (t.abandoned && t.abandoned[sPlayerID] == 1) {
                    Player.tAbandoned[sPlayerID] = true;
                }
                else {
                    delete Player.tAbandoned[sPlayerID];
                }
                if (t.fake && t.fake[sPlayerID] == 1) {
                    Player.tFake[sPlayerID] = true;
                }
                else {
                    delete Player.tFake[sPlayerID];
                }
                if (t.language) {
                    Player.tLanguage[sPlayerID] = t.language[sPlayerID];
                }
            }
        }
        static PlayerCount() {
            return Player.iCount;
        }
        static PlayerHost() {
            return Player.iHost;
        }
        static PlayerCount_NotDisconnected() {
            return Player.iCount - Object.keys(Player.tDisconnect).length;
        }
        static PlayerCount_NotAbandoned() {
            return Player.iCount - Object.keys(Player.tAbandoned).length;
        }
        static IsValidPlayer(iPlayerID) {
            return this.P2A[iPlayerID] != undefined;
        }
        static IsFakePlayer(iPlayerID) {
            return this.tFake[iPlayerID] != undefined;
        }
        static EachPlayer(func) {
            for (const k in Player.O2P) {
                let iOrder = Number(k);
                let iPlayerID = Player.O2P[k];
                if (func(iPlayerID, iOrder)) {
                    return;
                }
            }
        }
        static RandomPlayer(params) {
            let t = [];
            for (const k in Player.O2P) {
                let id = Player.O2P[k];
                if ((!params.bNotDisconnected || !Player.tDisconnect[id])
                    && (!params.bNotAbandoned || !Player.tAbandoned[id])
                    && (params.tIgnoreID == undefined || params.tIgnoreID.findIndex((id2) => id2 == id) == -1)) {
                    t.push(id);
                }
            }
            return t[Math.floor(Math.random() * t.length)];
        }
        static FocusPlayer(iPlayerID) {
            var _a;
            if (iPlayerID != undefined && Players.IsValidPlayerID(iPlayerID)) {
                this.iFocusPlayerID = iPlayerID;
            }
            return (_a = this.iFocusPlayerID) !== null && _a !== void 0 ? _a : Players.GetLocalPlayer();
        }
        static IsPlayerDisconnected(iPlayerID) {
            return Player.tDisconnect[iPlayerID] == true;
        }
        static IsPlayerAbandoned(iPlayerID) {
            return Player.tAbandoned[iPlayerID] == true;
        }
        static Player_EntityToID(iEntID) {
            let iPlayerID = Entities.GetPlayerOwnerID(iEntID);
            return iPlayerID;
        }
        static Player_IDToOrder(iPlayerID) {
            var _a;
            return (_a = Player.P2O[iPlayerID]) !== null && _a !== void 0 ? _a : 0;
        }
        static Player_OrderToID(iOrder) {
            var _a;
            return (_a = Player.O2P[iOrder]) !== null && _a !== void 0 ? _a : -1;
        }
        static Player_IDToAccount(iPlayerID) {
            var _a;
            return (_a = Player.P2A[iPlayerID]) !== null && _a !== void 0 ? _a : 0;
        }
        static Player_AccountToID(iAccountID) {
            var _a;
            return (_a = Player.A2P[iAccountID]) !== null && _a !== void 0 ? _a : -1;
        }
        static PlayerLanguage(iPlayerID) {
            if (iPlayerID == Players.GetLocalPlayer())
                return $.Language().toLowerCase();
            return Player.tLanguage[iPlayerID];
        }
        static PlayerHero(iPlayerID) {
            var _a;
            return (_a = this.P2H[iPlayerID]) !== null && _a !== void 0 ? _a : -1;
        }
    }
    Player.iCount = 0;
    Player.iHost = -1;
    Player.P2O = {};
    Player.O2P = {};
    Player.P2A = {};
    Player.A2P = {};
    Player.P2H = {};
    Player.tDisconnect = {};
    Player.tAbandoned = {};
    Player.tFake = {};
    Player.tLanguage = {};
    tools.Player = Player;
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;