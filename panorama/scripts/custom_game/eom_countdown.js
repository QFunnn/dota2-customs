--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Countdown', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var GenericPanel = require('./GenericPanel.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_Countdown = props => {
  const merged = libs.mergeProps$1({
    updateInterval: 1,
    timeDialogVariable: "countdown_time",
    text: "#countdown_time",
    onlyCoundown: true,
    short: false,
    server_time: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "endTime", "updateInterval", "timeDialogVariable", "text", "onlyCoundown", "limitTime", "short", "server_time"]);
  let ref;
  const refresh = () => {
    let timeNow = 0;
    if (local.server_time) {
      timeNow = ServerTimestamp();
    } else {
      timeNow = Math.floor(Date.now() / 1000);
    }
    const diff = local.onlyCoundown ? local.endTime - timeNow : Math.abs(local.endTime - timeNow);
    let days = Math.max(0, Math.floor(diff / 86400));
    let hours = Math.max(0, Math.floor(diff % 86400 / 3600));
    let minutes = Math.max(0, Math.floor(diff % 3600 / 60));
    const remainingSeconds = Math.max(0, diff % 60);
    if (local.limitTime != undefined) {
      if (local.limitTime.day != undefined && days >= local.limitTime.day) {
        days = local.limitTime.day;
        hours = 0;
        minutes = 0;
      } else if (local.limitTime.hours != undefined && hours >= local.limitTime.hours) {
        days = 0;
        hours = local.limitTime.hours;
        minutes = 0;
      } else if (local.limitTime.minutes != undefined && minutes >= local.limitTime.minutes) {
        days = 0;
        hours = 0;
        minutes = local.limitTime.minutes;
      }
    }
    if (ref?.IsValid()) {
      if (local.short) {
        let text = "";
        if (days > 0) {
          text += days.toString() + $.Localize("#day");
        }
        if (hours > 0) {
          text += hours.toString() + $.Localize("#hour");
        }
        text += minutes.toString() + $.Localize("#min");
        if (hours <= 0) {
          text += remainingSeconds.toString() + $.Localize("#sec");
        }
        ref.text = text;
      } else {
        ref.text = $.Localize(local.text, ref).replace("{day}", days.toString().length == 1 ? "0" + days.toString() : days.toString()).replace("{hour}", hours.toString().length == 1 ? "0" + hours.toString() : hours.toString()).replace("{min}", minutes.toString().length == 1 ? "0" + minutes.toString() : minutes.toString()).replace("{sec}", remainingSeconds.toString().length == 1 ? "0" + remainingSeconds.toString() : remainingSeconds.toString());
      }
    }
  };
  libs.onMount(() => {
    refresh();
    const timer = setInterval(() => {
      refresh();
    }, local.updateInterval * 1000);
    libs.onCleanup(() => {
      clearInterval(timer);
    });
  });
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Countdown"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Countdown"
    })), true);
    libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
      ref(r$) {
        const _ref$ = ref;
        typeof _ref$ === "function" ? _ref$(r$) : ref = r$;
      }
    }));
    return _el$;
  })();
};

exports.EOM_Countdown = EOM_Countdown;