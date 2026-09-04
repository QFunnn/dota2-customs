--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local MONKEY_MOVE_SAMPLE_STEPS = 12
function ____exports.GetMonkeyGroundPoint(self, unit, point)
	return GetGroundPosition(point, unit)
end
function ____exports.IsMonkeyBlinkPointReachable(self, origin, point)
	if not IsGridNavDisplacementWalkable(nil, origin) then
		return false
	end
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	return GridNav:FindPathLength(origin, point) ~= -1
end
local function IsMonkeyMoveSegmentReachable(self, unit, origin, point)
	local delta = point:__sub(origin)
	do
		local i = 1
		while i <= MONKEY_MOVE_SAMPLE_STEPS do
			local rate = i / MONKEY_MOVE_SAMPLE_STEPS
			local sample = ____exports.GetMonkeyGroundPoint(nil, unit, origin:__add(delta:__mul(rate)))
			if not ____exports.IsMonkeyBlinkPointReachable(nil, origin, sample) then
				return false
			end
			i = i + 1
		end
	end
	return true
end
function ____exports.ResolveMonkeyBlinkPoint(self, unit, targetPoint)
	local origin = ____exports.GetMonkeyGroundPoint(nil, unit, unit:GetAbsOrigin())
	local target = ____exports.GetMonkeyGroundPoint(nil, unit, targetPoint)
	if
		____exports.IsMonkeyBlinkPointReachable(nil, origin, target)
		and IsMonkeyMoveSegmentReachable(nil, unit, origin, target)
	then
		return target
	end
	local delta = target:__sub(origin)
	do
		local i = MONKEY_MOVE_SAMPLE_STEPS - 1
		while i >= 1 do
			local rate = i / MONKEY_MOVE_SAMPLE_STEPS
			local candidate = ____exports.GetMonkeyGroundPoint(nil, unit, origin:__add(delta:__mul(rate)))
			if
				____exports.IsMonkeyBlinkPointReachable(nil, origin, candidate)
				and IsMonkeyMoveSegmentReachable(nil, unit, origin, candidate)
			then
				return candidate
			end
			i = i - 1
		end
	end
	return nil
end
return ____exports