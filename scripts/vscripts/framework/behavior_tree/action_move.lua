--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/behavior_tree/action_move"
function BTree_Patrol(b, c)
	if b.center == nil then
		b.center = b.unit:GetAbsOrigin()
	end
	local d = b.unit
	local e = d:GetAcquisitionRange()
	if not d:IsRooted() and not d:IsMoving() and not BTree_IsCasting(d, b) then
		local f = b.center + RandomVector(RandomInt(0, e))
		d:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, f)
		b.interval = 0.5
	end
	return BehaviorNodeStatus.Running
end
function BTree_MoveToAttackPosition(b, c)
	local d = b.unit
	local g = b.target
	if not IsValid(g) or not g:IsAlive() then
		return BehaviorNodeStatus.Failure
	end
	if d:IsMoving() then
		return BehaviorNodeStatus.Running
	end
	local h = CalcDistance(d, g)
	local i = d:Script_GetAttackRange()
	local j = i * 0.8
	local k = i
	local l = 100
	local m = nil
	if h >= j and h <= k then
		d:AddNewModifier(
			d,
			nil,
			"modifier_face_move",
			{ target = g:entindex(), moveType = "strafe", radius = i, duration = 1 }
		)
	elseif h < j then
		local n = CalcDirection(g, d)
		local o = j - h + l
		m = d:GetAbsOrigin() - n * o
	elseif h > k then
		local n = CalcDirection(d, g)
		local p = k - l
		m = g:GetAbsOrigin() + n * p
	end
	if m ~= nil then
		if GridNav:CanFindPath(d:GetAbsOrigin(), m) then
			d:MoveToPosition(m)
		else
			m = d:GetAbsOrigin() + RandomVector(200)
			if GridNav:CanFindPath(d:GetAbsOrigin(), m) then
				d:MoveToPosition(m)
			end
		end
	end
	b.interval = 0.5
	return BehaviorNodeStatus.Success
end
function BTree_FaceMove(b, c)
	local d = b.unit
	local g = b.target
	if not IsValid(g) or not g:IsAlive() then
		return BehaviorNodeStatus.Failure
	end
	local q = c.params
	local r = q and q.radius
	if r == nil then
		r = d:Script_GetAttackRange()
	end
	local e = r
	local s = d.AddNewModifier
	local t = g:entindex()
	local u = c.params
	local v = u and u.moveType
	if v == nil then
		v = "strafe"
	end
	s(d, d, nil, "modifier_face_move", { target = t, moveType = v, radius = e, duration = 1 })
	return BehaviorNodeStatus.Success
end
function BTree_MoveToEnemy(b, c)
	local d = b.unit
	local g = b.target
	if not IsValid(g) or not g:IsAlive() then
		return BehaviorNodeStatus.Failure
	end
	local h = CalcDistance(d, g)
	local i = d:Script_GetAttackRange()
	if h > i then
		local m = g:GetAbsOrigin()
		local n = CalcDirection(d, g)
		local w = h - i
		local x = m - n * i * 0.5
		d:MoveToPosition(x)
	end
	return BehaviorNodeStatus.Success
end
function BTree_EscapeFromEnemy(b, c)
	local d = b.unit
	local g = b.target
	if g == nil or not g:IsAlive() then
		return BehaviorNodeStatus.Failure
	end
	local y = d:GetAcquisitionRange() * 0.8
	local h = CalcDistance(d, g)
	if h < y then
		local n = CalcDirection(d, g)
		local m = d:GetAbsOrigin() + n * y
		if GridNav:CanFindPath(d:GetAbsOrigin(), m) then
			d:MoveToPosition(m)
		else
			m = d:GetAbsOrigin() + RandomVector(200)
			if GridNav:CanFindPath(d:GetAbsOrigin(), m) then
				d:MoveToPosition(m)
			end
		end
	end
	return BehaviorNodeStatus.Success
end