--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/state-machine.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArrayIsArray = ____lualib.__TS__ArrayIsArray
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
____debugRuntime.register(
	"utils/state-machine.lua",
	{
		["13"] = "23:1",
		["14"] = "28:5",
		["15"] = "23:1",
		["16"] = "31:1",
		["17"] = "31:14",
		["18"] = "31:1",
		["19"] = "42:17",
		["20"] = "36:5",
		["21"] = "43:39",
		["22"] = "43:17",
		["23"] = "43:23",
		["24"] = "45:9",
		["25"] = "47:9",
		["26"] = "42:5",
		["27"] = "50:5",
		["28"] = "51:9",
		["29"] = "52:9",
		["30"] = "54:9",
		["31"] = "54:9",
		["32"] = "54:42",
		["33"] = "55:19",
		["34"] = "57:19",
		["35"] = "59:13",
		["36"] = "60:22",
		["37"] = "61:21",
		["38"] = "61:36",
		["39"] = "61:42",
		["40"] = "61:21",
		["43"] = "65:21",
		["44"] = "66:21",
		["45"] = "67:25",
		["46"] = "68:25",
		["47"] = "66:21",
		["50"] = "75:23",
		["51"] = "76:23",
		["52"] = "78:21",
		["53"] = "79:21",
		["54"] = "79:36",
		["55"] = "79:42",
		["56"] = "79:21",
		["59"] = "83:25",
		["60"] = "83:29",
		["61"] = "84:33",
		["62"] = "84:33",
		["63"] = "84:60",
		["65"] = "84:102",
		["67"] = "84:23",
		["68"] = "86:17",
		["69"] = "87:17",
		["70"] = "88:17",
		["71"] = "89:17",
		["72"] = "90:17",
		["73"] = "92:17",
		["74"] = "59:38",
		["75"] = "54:42",
		["76"] = "54:9",
		["77"] = "50:5",
		["78"] = "97:5",
		["79"] = "98:9",
		["80"] = "99:9",
		["81"] = "97:5",
		["82"] = "102:5",
		["83"] = "103:9",
		["84"] = "102:5",
		["85"] = "106:5",
		["86"] = "107:9",
		["87"] = "106:5",
		["88"] = "111:5",
		["89"] = "112:9",
		["90"] = "111:5",
		["91"] = "116:5",
		["92"] = "117:9",
		["93"] = "116:5",
		["94"] = "121:5",
		["95"] = "122:9",
		["96"] = "121:5",
		["97"] = "129:5",
		["98"] = "130:15",
		["99"] = "131:14",
		["100"] = "132:13",
		["102"] = "135:15",
		["103"] = "136:9",
		["104"] = "129:5",
		["105"] = "139:5",
		["106"] = "140:13",
		["107"] = "141:13",
		["109"] = "144:13",
		["110"] = "145:13",
		["112"] = "148:9",
		["113"] = "139:5",
		["114"] = "151:5",
		["115"] = "152:9",
		["116"] = "153:17",
		["117"] = "154:17",
		["120"] = "158:9",
		["121"] = "151:5",
		["122"] = "161:5",
		["123"] = "162:13",
		["124"] = "163:13",
		["126"] = "166:13",
		["127"] = "167:13",
		["129"] = "170:13",
		["130"] = "171:13",
		["132"] = "174:9",
		["133"] = "161:5",
	}
)
local ____exports = {}
function ____exports.BuildTransition(self, from, to, onTransition)
	return { from = from, to = to, onTransition = onTransition }
end
____exports.StateMachine = __TS__Class()
local StateMachine = ____exports.StateMachine
StateMachine.name = "StateMachine"
function StateMachine.prototype.____constructor(self, option)
	self._isTransiting = false
	local ____option_0 = option
	local init = ____option_0.init
	local transitions = ____option_0.transitions
	self._curState = init
	self:setupTransitions(transitions)
end
function StateMachine.prototype.setupTransitions(self, transitions)
	self._originTransitions = transitions
	self._transitions = {}
	__TS__ArrayForEach(__TS__ObjectKeys(transitions), function(____, k)
		local key = k
		local value = transitions[key]
		self._transitions[key] = function()
			if not self:can(key) then
				self:postError(
					1000,
					(("You can not '" .. tostring(key)) .. "' now. Current state is ") .. tostring(self._curState)
				)
				return
			end
			if self._isTransiting then
				self:postError(
					1011,
					(
						(
							"This is transiting now. You cannot transition more times at one time. You can not '"
							.. tostring(key)
						) .. "' now. Current state is "
					) .. tostring(self._curState)
				)
				return
			end
			local curState = self._curState
			local dir = self:_findDir(curState, value)
			if dir == nil then
				self:postError(
					1000,
					(("You can not '" .. tostring(key)) .. "' now. Current state is ") .. tostring(self._curState)
				)
				return
			end
			local to = dir.to
			local onTransition = dir.onTransition
			local ____temp_1
			if type(to) == "function" then
				____temp_1 = to(nil, curState)
			else
				____temp_1 = to
			end
			local toState = ____temp_1
			self._isTransiting = true
			local ____ = self.onBefore and self:onBefore(curState, toState)
			local ____ = onTransition and onTransition(nil, curState, toState)
			self._curState = toState
			self._isTransiting = false
			local ____ = self.onAfter and self:onAfter(curState, toState)
		end
	end)
end
function StateMachine.prototype.postError(self, code, reason)
	self:logError(reason)
	local ____ = self.onError and self:onError(code, reason)
end
function StateMachine.prototype.logError(self, reason)
	print(reason)
end
function StateMachine.prototype.transition(self)
	return self._transitions
end
function StateMachine.prototype.state(self)
	return self._curState
end
function StateMachine.prototype.is(self, state)
	return self._curState == state
end
StateMachine.prototype["in"] = function(self, state)
	return __TS__ArrayIncludes(state, self._curState)
end
function StateMachine.prototype.can(self, t)
	local value = self._originTransitions[t]
	if not value then
		return false
	end
	local dir = self:_findDir(self._curState, value)
	return dir ~= nil
end
function StateMachine.prototype._findDir(self, from, dirs)
	if __TS__ArrayIsArray(dirs) then
		return self:_findDirOfArray(from, dirs)
	end
	if self:_isIncludeState(dirs.from, from) then
		return dirs
	end
	return nil
end
function StateMachine.prototype._findDirOfArray(self, from, dirs)
	for ____, dir in ipairs(dirs) do
		if self:_isIncludeState(dir.from, from) then
			return dir
		end
	end
	return nil
end
function StateMachine.prototype._isIncludeState(self, state, targetState)
	if state == "*" then
		return true
	end
	if targetState == state then
		return true
	end
	if __TS__ArrayIsArray(state) and __TS__ArrayIndexOf(state, targetState) ~= -1 then
		return true
	end
	return false
end
return ____exports