--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


(function() {
    "use strict";
    // Реестр таймеров по типам (spin и др.) для отмены при закрытии окна.
    var timers = {};
    var scheduledTimers = {};
    var nextId = 1;
    
    function generateId() {
        return "timer_" + nextId++ + "_" + Date.now();
    }
    
    var TimerRegistry = {
        create: function(type, delay, callback, context) {
            var id = generateId();
            var timerId = GameUI.LoopTime.AddTime(id, 1, delay, callback, context || 1);
            
            if (!timers[type]) timers[type] = {};
            timers[type][id] = timerId;
            
            return { id: id, timerId: timerId };
        },

        schedule: function(delay, callback, type) {
            var id = generateId();
            var wrappedCallback = function() {
                callback();
                if (type) {
                    delete timers[type][id];
                } else {
                    delete scheduledTimers[id];
                }
            };
            
            GameUI.LoopTime.Schedule(delay, wrappedCallback);
            
            if (type) {
                if (!timers[type]) timers[type] = {};
                timers[type][id] = true;
            } else {
                scheduledTimers[id] = true;
            }
            
            return id;
        },

        cancel: function(id) {
            if (!id) return false;

            for (var type in timers) {
                if (timers[type][id]) {
                    var timerId = timers[type][id];
                    if (typeof timerId === "string") {
                        GameUI.LoopTime.DelTime(timerId);
                    }
                    delete timers[type][id];
                    return true;
                }
            }

            if (scheduledTimers[id]) {
                delete scheduledTimers[id];
                return true;
            }
            
            return false;
        },

        cancelTimer: function(timerObj) {
            if (!timerObj || !timerObj.id) return false;
            return TimerRegistry.cancel(timerObj.id);
        },

        clearAll: function(type) {
            if (!type) {
                for (var t in timers) {
                    for (var id in timers[t]) {
                        var timerId = timers[t][id];
                        if (typeof timerId === "string") {
                            GameUI.LoopTime.DelTime(timerId);
                        }
                    }
                }
                timers = {};
                scheduledTimers = {};
                return;
            }
            
            if (timers[type]) {
                for (var id in timers[type]) {
                    var timerId = timers[type][id];
                    if (typeof timerId === "string") {
                        GameUI.LoopTime.DelTime(timerId);
                    }
                }
                timers[type] = {};
            }
        },

        getAll: function() {
            return {
                typed: timers,
                scheduled: scheduledTimers
            };
        }
    };

    if (!GameUI.CustomUIConfig().Casv2Utils) {
        GameUI.CustomUIConfig().Casv2Utils = {};
    }
    GameUI.CustomUIConfig().Casv2Utils.TimerRegistry = TimerRegistry;
})();