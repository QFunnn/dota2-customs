--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/class/map_class.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["6"] = 2,
		["7"] = 3,
		["8"] = 3,
		["9"] = 4,
		["10"] = 4,
		["11"] = 6,
		["12"] = 7,
		["13"] = 7,
		["14"] = 8,
		["15"] = 8,
		["16"] = 9,
		["17"] = 9,
		["18"] = 10,
		["19"] = 10,
		["20"] = 11,
		["21"] = 11,
		["22"] = 12,
		["23"] = 12,
		["24"] = 13,
		["25"] = 13,
		["26"] = 15,
		["27"] = 15,
		["28"] = 15,
		["29"] = 31,
		["30"] = 32,
		["31"] = 31,
		["32"] = 34,
		["33"] = 34,
		["34"] = 30,
	}
)
local f = {}
f.BATTLE_RESULT = BATTLE_RESULT or {}
f.BATTLE_RESULT.WIN = 1
f.BATTLE_RESULT[f.BATTLE_RESULT.WIN] = "WIN"
f.BATTLE_RESULT.LOSE = 2
f.BATTLE_RESULT[f.BATTLE_RESULT.LOSE] = "LOSE"
f.BUNNY_STATE = BUNNY_STATE or {}
f.BUNNY_STATE.IDLE = 1
f.BUNNY_STATE[f.BUNNY_STATE.IDLE] = "IDLE"
f.BUNNY_STATE.WIN = 2
f.BUNNY_STATE[f.BUNNY_STATE.WIN] = "WIN"
f.BUNNY_STATE.LOSE = 3
f.BUNNY_STATE[f.BUNNY_STATE.LOSE] = "LOSE"
f.BUNNY_STATE.BATTLE_CONFIRM = 4
f.BUNNY_STATE[f.BUNNY_STATE.BATTLE_CONFIRM] = "BATTLE_CONFIRM"
f.BUNNY_STATE.FINISH_TELEPORT = 5
f.BUNNY_STATE[f.BUNNY_STATE.FINISH_TELEPORT] = "FINISH_TELEPORT"
f.BUNNY_STATE.BACK_TELEPORT = 6
f.BUNNY_STATE[f.BUNNY_STATE.BACK_TELEPORT] = "BACK_TELEPORT"
f.BUNNY_STATE.BACK_TELEPORT_FINISH = 7
f.BUNNY_STATE[f.BUNNY_STATE.BACK_TELEPORT_FINISH] = "BACK_TELEPORT_FINISH"
f.CBunnyGirl = d()
local g = f.CBunnyGirl
g.name = "CBunnyGirl"
function g.prototype.____constructor(self, h)
	self.player_id = h
end
function g.prototype.dispose(self) end
g.MAX_NUM = 5
return f