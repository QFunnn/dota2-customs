--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


PlayerOutboundApi = PlayerOutboundApi or {}

---@param uid string
---@param settingsTable table
---@param callback function|nil
function PlayerOutboundApi:ChangeSettings(uid, settingsTable, callback)
	OutboundRequestSender:SendJson("POST", "/player/change-settings", {
		uid = uid,
		settings = settingsTable,
	}, callback)
end

---@param uid string
---@param bans table
---@param callback function|nil
function PlayerOutboundApi:UpdateBans(uid, bans, callback)
	OutboundRequestSender:SendJson("POST", "/player/update-bans", {
		uid = uid,
		bans = bans,
	}, callback)
end

---@param uid string
---@param callback function
function PlayerOutboundApi:Login(uid, callback)
	OutboundRequestSender:SendJson("POST", "/player/login", {
		uid = uid,
	}, callback)
end