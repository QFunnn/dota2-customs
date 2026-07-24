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
    GameEvents.Subscribe('particle_s2c', (event) => {
        GameEvents.SendEventClientSide('particle_s2c_local', event);
    });
    class ParticleManager_s2c {
        static Init(bReload) {
            let iFpsLvlLast;
            const tFps = Array(5).fill(999);
            GameUI.CustomUIConfig().tools.Timer.GameTimer(() => {
                if (Players.IsValidPlayerID(Players.GetLocalPlayer()))
                    return 1;
                tFps[0] = tFps[1];
                tFps[1] = tFps[2];
                tFps[2] = tFps[3];
                tFps[3] = tFps[4];
                tFps[4] = 1 / Game.GetGameFrameTime();
                let iFpsLvl = Math.floor((tFps[0] + tFps[1] + tFps[2] + tFps[3] + tFps[4]) * 0.02);
                if (iFpsLvl > 10)
                    iFpsLvl = 10;
                if (iFpsLvl != iFpsLvlLast) {
                    iFpsLvlLast = iFpsLvl;
                    GameEvents.SendCustomGameEventToServer('particle_s2c_fps', {
                        lvl: iFpsLvl
                    });
                }
                return 1;
            }, 1, 'ParticleManagerFps');
        }
        static SetPlayerBlock(iParticleBlockLevel) {
            if (GameUI.CustomUIConfig().tools.NetEventData.GetTableValue('particle_s2c', 'block') != iParticleBlockLevel) {
                GameEvents.SendCustomGameEventToServer('particle_s2c_block', {
                    'block': iParticleBlockLevel
                });
            }
        }
        static CheckClientBlocked(tCfg = { 'weight': 2 }) {
            const iLevel = GameUI.CustomUIConfig().tools.NetEventData.GetTableValue('particle_s2c', 'block');
            if (iLevel == undefined || iLevel == 0) {
                return true;
            }
            else if (iLevel == 1) {
                return !(tCfg.weight == 2 || (tCfg.weight == 1 && tCfg.pid != Players.GetLocalPlayer()));
            }
            else if (iLevel == 2) {
                return !(tCfg.weight == 2 || tCfg.weight == 1);
            }
            return false;
        }
    }
    tools.ParticleManager_s2c = ParticleManager_s2c;
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;