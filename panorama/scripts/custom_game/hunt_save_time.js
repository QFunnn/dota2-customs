--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('hunt_save_time', exports); const require = GameUI.__require;

function FormatHuntSaveTime(time) {
  const missing = () => GetLocalization("#HuntSaveArchive_TimeUnknown");
  if (time == undefined || time === "") return missing();
  if (typeof time === "string" && time.trim() === "") return missing();
  const timestamp = Number(time);
  if (!Number.isFinite(timestamp)) return typeof time === "string" ? time : missing();
  if (timestamp <= 0) return missing();
  const date = new Date(timestamp * 1000);
  if (!Number.isFinite(date.getTime())) return missing();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  return `${month}/${day} ${hours}:${minutes}`;
}

exports.FormatHuntSaveTime = FormatHuntSaveTime;