--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__Delete = ____lualib.__TS__Delete
local ____exports = {}
____exports.AbilityCastFxManager = __TS__Class()
local AbilityCastFxManager = ____exports.AbilityCastFxManager
AbilityCastFxManager.name = "AbilityCastFxManager"
function AbilityCastFxManager.prototype.____constructor(self)
	self._previewByPlayer = {}
	print("[AbilityCastFxManager]AbilityCastFxManager constructor")
end
function AbilityCastFxManager.prototype.UpdatePreview(self, caster, ability, pos)
	if not IsClient() then
		return
	end
	if not caster or not ability then
		return
	end
	local playerId = caster:GetPlayerOwnerID()
	if playerId == nil or playerId < 0 then
		return
	end
	local frame = GetFrameCount()
	local current = self._previewByPlayer[playerId]
	local nextState = {
		playerId = playerId,
		abilityEntIndex = ability:entindex(),
		casterEntIndex = caster:entindex(),
		lastFrame = frame,
		castEffect = current and current.castEffect,
	}
	local switched = not current
		or current.abilityEntIndex ~= nextState.abilityEntIndex
		or current.casterEntIndex ~= nextState.casterEntIndex
	if switched then
		self:_endPreview(playerId)
		local ____this_3
		____this_3 = ability
		local ____opt_2 = ____this_3.OnCastEffect
		nextState.castEffect = ____opt_2 and ____opt_2(____this_3)
		self._previewByPlayer[playerId] = nextState
		self:_safeBegin(nextState, pos)
		return
	end
	self._previewByPlayer[playerId] = nextState
	self:_safeUpdate(nextState, pos)
end
function AbilityCastFxManager.prototype.TickByAbility(self, ability)
	if not IsClient() then
		return
	end
	if not ability then
		return
	end
	local caster = ability:GetCaster()
	if not caster then
		return
	end
	local playerId = caster:GetPlayerOwnerID()
	if playerId == nil or playerId < 0 then
		return
	end
	local state = self._previewByPlayer[playerId]
	if not state then
		return
	end
	if state.abilityEntIndex ~= ability:entindex() or state.casterEntIndex ~= caster:entindex() then
		return
	end
	local frame = GetFrameCount()
	if frame > state.lastFrame + 1 then
		self:_endPreview(playerId)
	end
end
function AbilityCastFxManager.prototype._endPreview(self, playerId)
	local state = self._previewByPlayer[playerId]
	if not state then
		return
	end
	__TS__Delete(self._previewByPlayer, playerId)
	self:SafelyCall(function()
		local ____opt_6 = state.castEffect
		local ____opt_4 = ____opt_6 and ____opt_6["end"]
		return ____opt_4 and ____opt_4(____opt_6)
	end)
end
function AbilityCastFxManager.prototype._safeBegin(self, state, pos)
	self:SafelyCall(function()
		local ____opt_10 = state.castEffect
		local ____opt_8 = ____opt_10 and ____opt_10.begin
		return ____opt_8 and ____opt_8(____opt_10, pos)
	end)
	self:SafelyCall(function()
		local ____opt_14 = state.castEffect
		local ____opt_12 = ____opt_14 and ____opt_14.update
		return ____opt_12 and ____opt_12(____opt_14, pos)
	end)
end
function AbilityCastFxManager.prototype._safeUpdate(self, state, pos)
	self:SafelyCall(function()
		local ____opt_18 = state.castEffect
		local ____opt_16 = ____opt_18 and ____opt_18.update
		return ____opt_16 and ____opt_16(____opt_18, pos)
	end)
end
function AbilityCastFxManager.prototype.SafelyCall(self, func, error_msg)
	if IsInToolsMode() then
		return func()
	end
	local success, result = xpcall(func, function(err)
		local text = tostring(err)
		local foreseeable = type(IsForeseeableInvalidEntityError) == "function"
			and IsForeseeableInvalidEntityError(nil, text)
		if foreseeable then
			print("[xpcall_error][foreseeable] " .. text)
		elseif MyGameLogger and MyGameLogger.error then
			MyGameLogger:error("[xpcall_error] " .. text)
		end
		local ____error_msg_20
		if error_msg then
			____error_msg_20 = (("[xpcall_error] " .. error_msg) .. " | ") .. text
		else
			____error_msg_20 = "[xpcall_error] " .. text
		end
		return ____error_msg_20
	end)
	local ____success_21
	if success then
		____success_21 = result
	else
		____success_21 = nil
	end
	return ____success_21
end
return ____exports