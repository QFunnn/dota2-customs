--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('number_format', exports); const require = GameUI.__require;

function normalizeDisplayNumber(value) {
  if (!Number.isFinite(value)) return 0;
  const integer = Math.round(value);
  if (Math.abs(value - integer) < 1e-9) {
    return integer;
  }
  return Number(value.toPrecision(12));
}

exports.normalizeDisplayNumber = normalizeDisplayNumber;