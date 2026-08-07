--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/keyboard_control"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringReplace
local f = b.__TS__Delete
local g = b.__TS__DecorateLegacy
local h = b.__TS__New
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["14"] = 4,
		["15"] = 4,
		["16"] = 5,
		["18"] = 5,
		["19"] = 6,
		["20"] = 15,
		["21"] = 22,
		["22"] = 4,
		["23"] = 23,
		["24"] = 24,
		["26"] = 26,
		["27"] = 27,
		["29"] = 30,
		["30"] = 31,
		["31"] = 31,
		["32"] = 31,
		["33"] = 32,
		["34"] = 33,
		["35"] = 34,
		["36"] = 35,
		["37"] = 36,
		["38"] = 37,
		["39"] = 38,
		["40"] = 39,
		["41"] = 40,
		["42"] = 41,
		["43"] = 42,
		["44"] = 43,
		["47"] = 46,
		["48"] = 47,
		["49"] = 48,
		["50"] = 49,
		["51"] = 50,
		["52"] = 52,
		["53"] = 52,
		["54"] = 52,
		["55"] = 52,
		["56"] = 52,
		["57"] = 52,
		["58"] = 52,
		["59"] = 52,
		["61"] = 54,
		["62"] = 55,
		["66"] = 60,
		["67"] = 61,
		["68"] = 63,
		["73"] = 68,
		["74"] = 31,
		["75"] = 31,
		["76"] = 71,
		["77"] = 71,
		["78"] = 71,
		["79"] = 72,
		["80"] = 71,
		["81"] = 71,
		["82"] = 71,
		["83"] = 71,
		["84"] = 74,
		["85"] = 74,
		["86"] = 74,
		["87"] = 75,
		["88"] = 74,
		["89"] = 74,
		["90"] = 74,
		["91"] = 74,
		["93"] = 79,
		["94"] = 80,
		["95"] = 81,
		["96"] = 81,
		["97"] = 81,
		["98"] = 82,
		["99"] = 82,
		["100"] = 82,
		["101"] = 82,
		["102"] = 81,
		["103"] = 81,
		["104"] = 81,
		["105"] = 81,
		["106"] = 84,
		["107"] = 84,
		["108"] = 84,
		["109"] = 85,
		["110"] = 85,
		["111"] = 85,
		["112"] = 85,
		["113"] = 84,
		["114"] = 84,
		["115"] = 84,
		["116"] = 84,
		["117"] = 87,
		["119"] = 89,
		["120"] = 90,
		["123"] = 23,
		["124"] = 94,
		["125"] = 95,
		["126"] = 96,
		["127"] = 97,
		["129"] = 99,
		["131"] = 101,
		["132"] = 101,
		["133"] = 101,
		["134"] = 101,
		["135"] = 101,
		["137"] = 94,
		["138"] = 104,
		["139"] = 105,
		["140"] = 106,
		["141"] = 107,
		["143"] = 109,
		["145"] = 111,
		["146"] = 111,
		["147"] = 111,
		["148"] = 111,
		["149"] = 111,
		["151"] = 104,
		["152"] = 114,
		["153"] = 115,
		["154"] = 116,
		["155"] = 117,
		["156"] = 118,
		["157"] = 119,
		["158"] = 120,
		["159"] = 121,
		["160"] = 122,
		["161"] = 123,
		["162"] = 124,
		["165"] = 127,
		["166"] = 114,
		["167"] = 4,
		["168"] = 135,
		["169"] = 136,
	}
)
local j = {}
local k = require("lib.tstl-utils")
local l = k.reloadable
local m = c()
m.name = "CKeyboardControl"
d(m, CModule)
function m.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.commandList = { move_up = "w", move_left = "a", move_down = "s", move_right = "d" }
	self.dotaCommandList =
		{ ["dota_ability_execute 0"] = "j", ["dota_ability_execute 1"] = "k", ["dota_ability_execute 2"] = "l" }
	self.allPlayerPressCommandList = {}
end
function m.prototype.init(self, n)
	if not n then
	end
	if self.timer then
		StopTimer(self.timer)
	end
	if IsServer() then
		self.timer = GameTimer(0, function()
			for o, p in pairs(self.allPlayerPressCommandList) do
				local q = vec3_zero
				local r = false
				for s, t in pairs(p) do
					if s == "move_up" then
						q = q + vec3_top
					elseif s == "move_left" then
						q = q + vec3_left
					elseif s == "move_down" then
						q = q + vec3_bottom
					elseif s == "move_right" then
						q = q + vec3_right
					end
				end
				local u = PlayerResource:GetSelectedHeroEntity(tonumber(o))
				if u then
					if not u:GetCurrentActiveAbility() then
						if not VectorIsZero(q) then
							q = q:Normalized()
							executeOrder(
								u,
								DOTA_UNIT_ORDER_MOVE_TO_POSITION,
								GetGroundPosition(u:GetAbsOrigin(), u) + q * 100
							)
						else
							if not u:IsIdle() then
								u:Stop()
							end
						end
					else
						if not VectorIsZero(q) then
							q = q:Normalized()
							u:SetAbsOrigin(u:GetAbsOrigin() + q * 100 * FRAME_TIME)
						end
					end
				end
			end
			return FRAME_TIME
		end)
		Convars:RegisterCommand("press_key", function(v, o, s)
			self:pressKey(s, o)
		end, "", FCVAR_USERINFO)
		Convars:RegisterCommand("release_key", function(v, o, s)
			self:releaseKey(s, o)
		end, "", FCVAR_USERINFO)
	end
	if IsClient() then
		for s, w in pairs(self.commandList) do
			Convars:RegisterCommand("+" .. s, function(v, x)
				self:pressKey(v, GetLocalPlayerID())
			end, "", 0)
			Convars:RegisterCommand("-" .. s, function(v, x)
				self:releaseKey(v, GetLocalPlayerID())
			end, "", 0)
			SendToConsole((("bind " .. w) .. " +") .. s)
		end
		for s, w in pairs(self.dotaCommandList) do
			SendToConsole((("bind " .. w) .. " ") .. s)
		end
	end
end
function m.prototype.pressKey(self, s, o)
	if IsServer() then
		if self.allPlayerPressCommandList[o] == nil then
			self.allPlayerPressCommandList[o] = {}
		end
		self.allPlayerPressCommandList[o][s] = 1
	else
		SendToConsole((("press_key " .. tostring(o)) .. " ") .. e(e(s, "+", ""), "-", ""))
	end
end
function m.prototype.releaseKey(self, s, o)
	if IsServer() then
		if self.allPlayerPressCommandList[o] == nil then
			self.allPlayerPressCommandList[o] = {}
		end
		f(self.allPlayerPressCommandList[o], s)
	else
		SendToConsole((("release_key " .. tostring(o)) .. " ") .. e(e(s, "+", ""), "-", ""))
	end
end
function m.prototype.getDirection(self, o)
	local q = vec3_zero
	for s, y in pairs(self.allPlayerPressCommandList[tostring(o)]) do
		if s == "move_up" then
			q = q + vec3_top
		elseif s == "move_left" then
			q = q + vec3_left
		elseif s == "move_down" then
			q = q + vec3_bottom
		elseif s == "move_right" then
			q = q + vec3_right
		end
	end
	return q
end
m = g({ l }, m)
if _G.KeyboardControl == nil then
	_G.KeyboardControl = h(m)
end
return j