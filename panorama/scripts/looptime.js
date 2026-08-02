--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


GameUI.LoopTime = {
    timedataj: {}
};
GameUI.CustomUIConfig().JsDateTime = GameUI.parseInt(new Date().getTime());
/* 全局倒计时 */
GameUI.LoopTime.LoopFun = function (uuid) {
    if (GameUI.LoopTimeuuid == uuid) {
        var times = GameUI.parseInt(new Date().getTime());
        var gametime = Game.GetGameTime();
        GameUI.CustomUIConfig().JsDateTime = times;
        GameUI.CustomUIConfig().JsGameTime = gametime;
        for (var key in GameUI.LoopTime.timedataj) {
            if (GameUI.LoopTime.timedataj[key] != undefined) {
                try {
                    if (GameUI.LoopTime.timedataj[key].time == 0 || (times - GameUI.LoopTime.timedataj[key].t >= GameUI.LoopTime.timedataj[key].time)) {
                        GameUI.LoopTime.timedataj[key].n++;
                        var isend = GameUI.LoopTime.timedataj[key].num > 0 && GameUI.LoopTime.timedataj[key].n >= GameUI.LoopTime.timedataj[key].num;
                        var timedataj_ = GameUI.LoopTime.timedataj[key];
                        if (isend) {
                            delete GameUI.LoopTime.timedataj[key];
                        } else {
                            GameUI.LoopTime.timedataj[key].t = times;
                        }
                        timedataj_.fun(times, timedataj_.n, gametime, isend);
                    }
                } catch (error) {
                    if (GameUI.LoopTime.timedataj[key] != undefined) {
                        delete GameUI.LoopTime.timedataj[key];
                    }
                }
            }
        }
        /* Game.GetGameFrameTime() */
        $.Schedule(Game.GetGameFrameTime(), function () { GameUI.LoopTime.LoopFun(uuid); });
    }
};
/* key 次数 时间 方法 是否立即 */
GameUI.LoopTime.Schedule = function (time, fun) {
    var uuid = 'Schedule_' + GameUI.parseInt(Math.random() * 1000) + GameUI.parseInt(Game.GetGameTime() * 1000) + GameUI.parseInt(Math.random() * 1000);
    GameUI.LoopTime.AddTime(uuid, 1, time, fun, 1);
};
/* islj-为undefined 立即执行一次 */
GameUI.LoopTime.AddTime = function (key, num, time, fun, islj) {
    GameUI.LoopTime.timedataj[key] = {
        num: num,
        n: 0,/* 0-循环 >0 指定次数 */
        time: time * 1000,/* 0-立即 >0定时 */
        t: islj == undefined ? 0 : GameUI.CustomUIConfig().JsDateTime,
        fun: fun,
    };
};
GameUI.LoopTime.DelTime = function (key) {
    if (GameUI.LoopTime.timedataj[key] != undefined) {
        delete GameUI.LoopTime.timedataj[key];
    }
};
(function () {
    // GameUI.Msg(2, '定时器校验-----------定时器初始化', GameUI.LoopTime);
    if (GameUI.LoopTimeuuid == undefined || GameUI.LoopTimeuuid > 100000) {
        GameUI.LoopTimeuuid = 1;
    } else {
        GameUI.looptimeuuid++;
    }
    GameUI.LoopTime.LoopFun(GameUI.LoopTimeuuid);
})();