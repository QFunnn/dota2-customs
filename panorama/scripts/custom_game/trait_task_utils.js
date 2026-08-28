--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('trait_task_utils', exports); const require = GameUI.__require;

const TRAIT_182_THRESHOLDS = [20, 60, 80, 120];
function getTrait182DisplayLevel(progress, defaultLevel = 1) {
  if (progress == undefined) return defaultLevel;
  if (progress == "#activity_completed") return TRAIT_182_THRESHOLDS.length;
  const value = Number(progress);
  if (!Number.isFinite(value)) return defaultLevel;
  let level = 0;
  for (const threshold of TRAIT_182_THRESHOLDS) {
    if (value < threshold) break;
    level++;
  }
  return level;
}

exports.getTrait182DisplayLevel = getTrait182DisplayLevel;