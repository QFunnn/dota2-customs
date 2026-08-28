--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/behavior_tree_example"
function BTree_FindEnemy(b, c)
	local d = b.unit
	local e = c.params
	local f = e and e.SearchRadius
	if f == nil then
		f = 1000
	end
	local g = f
	local h = FindUnitsInRadius(
		d:GetTeamNumber(),
		d:GetAbsOrigin(),
		nil,
		g,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	if #h > 0 then
		b.target = h[1]
		return BehaviorNodeStatus.Success
	end
	return BehaviorNodeStatus.Failure
end
function BTree_FindAlly(b, c)
	local d = b.unit
	local i = c.params
	local j = i and i.SearchRadius
	if j == nil then
		j = 1000
	end
	local g = j
	local k = FindUnitsInRadius(
		d:GetTeamNumber(),
		d:GetAbsOrigin(),
		nil,
		g,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	if #k > 0 then
		b.target = k[1]
		return BehaviorNodeStatus.Success
	end
	return BehaviorNodeStatus.Failure
end
function BTree_CheckManaPct(b, c)
	local l = b.unit:GetManaPercent()
	local m = c.params
	local n = m and m.ManaPercent
	if n == nil then
		n = 50
	end
	return l < n
end
function BTree_IsInCombat(b, c)
	local d = b.unit
	local o = c.params
	local p = o and o.Radius
	if p == nil then
		p = 800
	end
	local g = p
	local h = FindUnitsInRadius(
		d:GetTeamNumber(),
		d:GetAbsOrigin(),
		nil,
		g,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	return #h > 0
end