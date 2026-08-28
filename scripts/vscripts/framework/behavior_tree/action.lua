--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/behavior_tree/action"
local b = require("lualib_bundle")
local c = b.__TS__Delete
function BTree_Ability(d, e)
	local f = d.unit
	local g = d.target
	if e.params == nil then
		return BehaviorNodeStatus.Failure
	end
	local h = e.params.ability_name
	if h == nil or h == "" then
		return BehaviorNodeStatus.Failure
	end
	if g == nil or not g:IsAlive() then
		return BehaviorNodeStatus.Failure
	end
	local i = f:FindAbilityByName(h)
	if i == nil then
		i = f:AddAbility(h, 1)
	end
	if i == nil then
		print("技能不存在:", h)
		return BehaviorNodeStatus.Failure
	end
	if not i:IsAbilityReady() then
		return BehaviorNodeStatus.Failure
	end
	if type(i.AutoSpell) == "function" and i:AutoSpell() then
		d.isCasting = true
		d.castingAbilityName = h
		d.castingStartTime = GameRules:GetGameTime()
		if d.debug then
			print(
				(((("[" .. f:GetUnitName()) .. "-") .. tostring(f:GetEntityIndex())) .. "】⚡ 手动释放技能: ")
					.. tostring(h)
			)
		end
		return BehaviorNodeStatus.Success
	end
	return BehaviorNodeStatus.Failure
end
function BTree_Wait(d, e)
	local j = e.params
	local k = j and j.Duration
	if k == nil then
		k = 0.3
	end
	local l = k
	local m = "waitStartTime_" .. e.name
	local n = GameRules:GetGameTime()
	if d[m] == nil then
		d[m] = n
	end
	local o = n - d[m]
	if o >= l then
		c(d, m)
		return BehaviorNodeStatus.Success
	end
	d.interval = l - o
	return BehaviorNodeStatus.Running
end
function BTree_CheckAttackStatus(d, e)
	local f = d.unit
	local g = d.target
	if g == nil or not g:IsAlive() then
		return BehaviorNodeStatus.Failure
	end
	if BTree_IsCasting(f, d) then
		return BehaviorNodeStatus.Running
	end
	local p = e.params
	local q = p and p.ability
	if q == nil then
		q = "custom_attack"
	end
	local h = q
	local r = f:FindAbilityByName(h)
	if IsValid(r) and not r:IsCooldownReady() then
		return BehaviorNodeStatus.Failure
	end
	local s = CalcDistance(f, g)
	local t = f:Script_GetAttackRange() + 50
	if s > t then
		return BehaviorNodeStatus.Failure
	end
	return BehaviorNodeStatus.Success
end
function BTree_Attack(d, e)
	local f = d.unit
	local g = d.target
	if g == nil or not g:IsAlive() then
		return BehaviorNodeStatus.Failure
	end
	local u = e.params
	local v = u and u.ability
	if v == nil then
		v = "custom_attack"
	end
	local h = v
	local i = f:FindAbilityByName(h)
	if i == nil then
		i = f:AddAbility(h, 1)
	end
	if i == nil then
		return BehaviorNodeStatus.Failure
	end
	f:RemoveModifierByName("modifier_face_move")
	d.interval = f:ActiveSequenceDuration()
	f:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, i, g:GetAbsOrigin())
	return BehaviorNodeStatus.Success
end
function BTree_CheckAbilityStatus(d, e)
	local f = d.unit
	if BTree_IsCasting(f, d) then
		return BehaviorNodeStatus.Running
	end
	if BTree_IsInSkillInterval(d) then
		return BehaviorNodeStatus.Failure
	end
	if f:IsSilenced() then
		return BehaviorNodeStatus.Failure
	end
	return BehaviorNodeStatus.Success
end
function BTree_SpellAbility(d, e)
	local f = d.unit
	local w = "abilityLoopIndex_" .. e.name
	local x = d[w]
	if x == nil then
		x = 0
	end
	local y = x
	local z = f:GetAbilityCount()
	do
		local A = 0
		while A < z do
			local B = (y + A) % z
			local i = f:GetAbilityByIndex(B)
			if IsValid(i) and not i:IsPassive() then
				if type(i.AutoSpell) == "function" and i:AutoSpell() then
					d[w] = (B + 1) % z
					return BehaviorNodeStatus.Success
				end
			end
			A = A + 1
		end
	end
	return BehaviorNodeStatus.Failure
end
function BTree_Dash(d, e)
	local f = d.unit
	local g = d.target
	if e.params == nil then
		return BehaviorNodeStatus.Failure
	end
	local s = toFiniteNumber(e.params.Distance)
	if s <= 0 then
		return BehaviorNodeStatus.Failure
	end
	if not IsValid(g) or not g:IsAlive() then
		return BehaviorNodeStatus.Failure
	end
	if f:HasModifier("modifier_dash") then
		return BehaviorNodeStatus.Running
	end
	local C = toFiniteNumber(e.params.Height, 100)
	local l = toFiniteNumber(e.params.Duration, 0.5)
	local D = e.params.Mode or "toward"
	local E
	repeat
		local F = D
		local G, H
		local I = F == "away"
		if I then
			E = CalcDirection(f, g)
			break
		end
		I = I or F == "around"
		if I then
			G = CalcDirection(g, f)
			H = RandomInt(45, 90) * (RandomInt(0, 1) == 0 and 1 or -1)
			E = Rotation2D(G, H, true)
			break
		end
		I = I or F == "random"
		if I then
			E = RandomVector(1)
			break
		end
		I = I or F == "toward"
		do
			E = CalcDirection(g, f)
			break
		end
	until true
	f:Dash(E, s, C, l, function()
		BTree_Ability(d, e)
	end)
	d.interval = l + 0.5
	return BehaviorNodeStatus.Success
end
function BTree_Heal(d, e)
	local f = d.unit
	f:Heal(f:GetMaxHealth() * 0.5, nil)
	ParticleManager:CreateParticleForce(
		"particles/generic_gameplay/generic_lifesteal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		f
	)
	return BehaviorNodeStatus.Success
end
function BTree_Stagger(d, e)
	local f = d.unit
	local J = e.params
	local K = J and J.Duration
	if K == nil then
		K = 1.5
	end
	local l = K
	f:AddNewModifier(f, nil, "modifier_stagger", { duration = l })
	return BehaviorNodeStatus.Success
end