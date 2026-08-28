--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/behavior_tree/condition"
function BTree_IsInAttackBackswing(b)
	return b.attack_backswing_end ~= nil and b.attack_backswing_end > GameRules:GetGameTime()
end
function BTree_IsInSkillBackswing(b)
	return b.skill_backswing_end ~= nil and b.skill_backswing_end > GameRules:GetGameTime()
end
BT_TARGET_SEARCH_INTERVAL = 0.5
function BTree_IsCasting(c, b)
	return c:GetCurrentActiveAbility() ~= nil
		or c:IsChanneling()
		or c:HasModifier("modifier_passive_cast")
		or c:HasModifier("modifier_simulate_cast")
		or BTree_IsInAttackBackswing(b)
		or BTree_IsInSkillBackswing(b)
end
function BTree_IsInSkillInterval(b)
	return b.skill_interval_end ~= nil and b.skill_interval_end > GameRules:GetGameTime()
end
function BTree_CheckHealthPct(b, d)
	local e = b.unit:GetHealthPercent()
	local f = d.params
	local g = f and f.HealthPercent
	if g == nil then
		g = 0
	end
	return e <= g
end
function BTree_CheckDistance(b, d)
	local h = d.params
	local i = h and h.Distance
	if i == nil then
		i = 0
	end
	local j = i
	local k = d.params
	local l = k and k.Flag
	if l == nil then
		l = "<="
	end
	local m = l
	local c = b.unit
	local n = b.target
	if not IsValid(n) then
		return false
	end
	local o = CalcDistance(c, n)
	if m == "<=" then
		return o <= j
	end
	return o > j
end
function BTree_CheckEnemy(b, d)
	local c = b.unit
	local n = b.target
	if c:HasState(StateEnum.BLIND) then
		b.target = nil
		return false
	end
	local p = d.params
	local q = p and p.Radius
	if q == nil then
		q = c:GetAcquisitionRange()
	end
	local r = q
	if IsValid(n) then
		if not n:IsAlive() then
			b.target = nil
			return false
		end
		if CalcDistance(c, n) <= r then
			return true
		end
	end
	local s = GameRules:GetGameTime()
	local t = "nextEnemySearch_" .. d.name
	local u = b[t]
	if u ~= nil and s < u then
		return false
	end
	local v = b
	local w = toFiniteNumber
	local x = d.params
	v[t] = s + w(x and x.SearchInterval, BT_TARGET_SEARCH_INTERVAL)
	local y = Player:FindNearestAliveEnemyHero(c:GetTeamNumber(), c:GetAbsOrigin(), r)
	if y ~= nil then
		b.target = y
		return true
	end
	return false
end
function BTree_CheckStartTime(b, d)
	if b.createTime == nil then
		return false
	end
	local z = GameRules:GetGameTime()
	local A = d.params
	local B = A and A.Delay
	if B == nil then
		B = 0
	end
	local C = B
	return z >= b.createTime + C
end
function BTree_CheckTargetDistance(b, d)
	local c = b.unit
	local n = b.target
	local D = d.params
	local E = D and D.radius
	if E == nil then
		E = c:Script_GetAttackRange() + 50
	end
	local r = E
	if not IsValid(n) or not n:IsAlive() then
		return false
	end
	if CalcDistance(c, n) <= r then
		return true
	end
	return false
end
function BTree_CheckDistanceRange(b, d)
	local c = b.unit
	local n = b.target
	if not IsValid(n) or not n:IsAlive() then
		return false
	end
	local F = d.params
	local G = F and F.MinDistance
	if G == nil then
		G = 0
	end
	local H = G
	local I = d.params
	local J = I and I.MaxDistance
	if J == nil then
		J = 99999
	end
	local K = J
	local o = CalcDistance(c, n)
	return o >= H and o <= K
end
function BTree_HasReincarnationBuff(b, d)
	return b.unit:HasModifier("modifier_boss_reincarnation_buff")
end
function BTree_HasSummonedSkeletons(b, d)
	local c = b.unit
	local L = c:FindAbilityByName("boss_summon_skeleton")
	if not IsValid(L) then
		return false
	end
	local M = L.summonRecords
	if M == nil then
		return false
	end
	do
		local N = 0
		while N < #M do
			local O = M[N + 1]
			if IsValid(O) and O:IsAlive() then
				return true
			end
			N = N + 1
		end
	end
	return false
end