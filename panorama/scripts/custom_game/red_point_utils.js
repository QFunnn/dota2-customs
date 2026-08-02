--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('red_point_utils', exports); const require = GameUI.__require;

const createRedPointKey = (...segments) => {
  return segments.join("|");
};
const hasRedPoint = (redPoints, ...segments) => {
  const key = createRedPointKey(...segments);
  return redPoints.some(redPoint => redPoint == key || redPoint.startsWith(`${key}|`));
};

exports.createRedPointKey = createRedPointKey;
exports.hasRedPoint = hasRedPoint;