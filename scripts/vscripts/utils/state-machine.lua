--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArrayIsArray = ____lualib.__TS__ArrayIsArray
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
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