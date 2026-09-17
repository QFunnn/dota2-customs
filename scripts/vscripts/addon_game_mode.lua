--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


do
	local config = LoadKeyValues("scripts_dedicated/xiuxian_server_key.kv")
	if type(config) == "table" then
		local key = type(config.key) == "string" and config.key:match("^%s*(.-)%s*$") or ""
		assert(key ~= "", "[LocalServerKey] Local key file has no nonempty string field 'key'")
		-- 忽略 version 参数，三个 API 均使用本场 Linux 本地密钥。
		local function getLocalKey()
			return key
		end
		_G.GetDedicatedServerKey = getLocalKey
		_G.GetDedicatedServerKeyV2 = getLocalKey
		_G.GetDedicatedServerKeyV3 = getLocalKey
		GetDedicatedServerKey = _G.GetDedicatedServerKey
		GetDedicatedServerKeyV2 = _G.GetDedicatedServerKeyV2
		GetDedicatedServerKeyV3 = _G.GetDedicatedServerKeyV3
		print("[LocalServerKey] Local key override installed")
	end
end
do
	local config = LoadKeyValues("scripts_dedicated/match_config.kv")
	if type(config) == "table" then
		local matchId = type(config.matchid) == "string" and config.matchid:match("^%s*(.-)%s*$") or ""
		assert(matchId ~= "", "[LocalMatchId] Local match config has no nonempty string field 'matchid'")
		function GameRules:Script_GetMatchID()
			return matchId
		end
		print("[LocalMatchId] Local match ID installed: " .. matchId)
	end
end
_G.PUBLISH_TIMESTAMP = "2026-9-16 21:38"

print("loading addon dota_super_mid compiled@2026-9-16 21:38:54")
local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
require("_pre_init")
require("utils.sunlight.index")
require("utils._index")
require("extends._index_server")
require("global._index")
local _____index = require("modules._index")
local ActivateModules = _____index.ActivateModules
local ____precache = require("precache")
local Precache = ____precache.default
require("modifiers._loader")
__TS__ObjectAssign(getfenv(), {
	Activate = function()
		ActivateModules(nil)
	end,
	Precache = Precache,
})
return ____exports