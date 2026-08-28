--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/behavior_tree/index"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.Map
local f = b.__TS__New
local g = b.__TS__ArraySort
local h = b.__TS__Delete
local i = b.__TS__DecorateLegacy
local j = {}
local k = require("lib.tstl-utils")
local l = k.reloadable
require("framework.behavior_tree.behavior_tree_type")
require("framework.behavior_tree.action")
require("framework.behavior_tree.action_move")
require("framework.behavior_tree.condition")
local m = 0.2
local n = 0.05
local o = c()
o.name = "MBehaviorTree"
d(o, CModule)
function o.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.trees = {}
	self.registeredUnits = {}
end
function o.prototype.init(self, p)
	if not p then
		self.registeredUnits = {}
	end
	self.trees = {}
	Event:Register("ability_end", function(q, r)
		local s = r.caster
		if not IsValid(s) then
			return
		end
		local t = self:GetUnitBehaviorData(s)
		if not t then
			return
		end
		local u = r.ability
		if not IsValid(u) then
			return
		end
		local v = u:GetSpecialValueFor("skill_interval")
		if v > 0 then
			t.context.skill_interval_end = GameRules:GetGameTime() + v
		end
		local w = u:GetSpecialValueFor("backswing")
		if w > 0 then
			t.context.skill_backswing_end = GameRules:GetGameTime() + w
		end
	end, self)
	Event:Register("ability_cast_complete", function(q, r)
		local t = self:GetUnitBehaviorData(r.caster)
		if t ~= nil and t.context ~= nil then
			local u = r.ability
			if not IsValid(u) then
				return
			end
			local x = r.caster:ActiveSequenceDuration()
			local y = u:GetCastPoint()
			local z = x - y
			t.context.skill_backswing_end = GameRules:GetGameTime() + z
			local v = u:GetSpecialValueFor("skill_interval")
			if v > 0 then
				t.context.skill_interval_end = GameRules:GetGameTime() + v + z
			end
		end
	end, self)
	Event:Register("attack_event", function(q, r)
		local A = r.attacker
		if not IsValid(A) then
			return
		end
		local t = self:GetUnitBehaviorData(A)
		if t == nil then
			return
		end
		local B, C = KeyValues:GetUnitData(A, "AttackPlaybackRate", "AttackBackswing")
		if B == nil or B == 0 then
			B = 1
		end
		local D = A:ActiveSequenceDuration()
		local E = A:GetAttackAnimationPoint()
		C = C or 0
		local z = (D - E) / B
		local F = math.max(z, C or 0)
		t.context.attack_backswing_end = GameRules:GetGameTime() + F
		local G = D / B
		local H = E / B
	end, self)
end
function o.prototype.LoadTree(self, I)
	if self.trees[I] ~= nil then
		return self.trees[I]
	end
	self:print("Loading behavior tree:", I)
	local J = LoadKeyValues(("scripts/npc/behavior_trees/" .. I) .. ".btree")
	if J == nil then
		print("[BehaviorTree] Failed to load tree: " .. I)
		return nil
	end
	local K = self:ParseNode(J, "Root")
	if K == nil then
		print("[BehaviorTree] Failed to parse tree: " .. I)
		return nil
	end
	self.trees[I] = K
	print("[BehaviorTree] Loaded tree: " .. I)
	return K
end
function o.prototype.ParseNode(self, L, M)
	local N = L.Type
	if N == nil then
		print("[BehaviorTree] Node missing Type field: " .. M)
		return nil
	end
	local O = N
	local P = M
	local Q = L.Description
	local R
	if L.Threshold ~= nil then
		R = tonumber(L.Threshold)
	else
		R = nil
	end
	local S = { type = O, name = P, description = Q, threshold = R }
	if L.Params ~= nil then
		S.params = {}
		for T, U in pairs(L.Params) do
			if type(T) == "string" then
				local V = tonumber(U)
				S.params[T] = V ~= nil and V or U
			end
		end
	end
	if L.Children ~= nil then
		S.children = {}
		local W = f(e)
		for X, Y in pairs(L.Children) do
			if type(X) == "string" then
				local Z = self:ParseNode(Y, X)
				if Z ~= nil then
					local _ = S.children
					_[#_ + 1] = Z
					local a0 = toFiniteNumber(Y.Index, 0)
					W:set(Z, a0)
				end
			end
		end
		g(S.children, function(q, a1, a2)
			return (W:get(a1) or 0) - (W:get(a2) or 0)
		end)
	end
	return S
end
function o.prototype.GetTree(self, I)
	return self.trees[I]
end
function o.prototype.ClearCache(self)
	self.trees = {}
end
function o.prototype.RegisterUnit(self, a3, I, a4)
	if a4 == nil then
		a4 = m
	end
	if a3 == nil or not a3:IsAlive() then
		print("[BehaviorTree] RegisterUnit failed: invalid unit")
		return
	end
	local a5 = a3:GetEntityIndex()
	local T = "unit_" .. tostring(a5)
	local a6 = math.max(n, toFiniteNumber(a4, m))
	if self.registeredUnits[T] ~= nil then
		self:UnregisterUnit(a3)
	end
	local a7 = self:LoadTree(I)
	if a7 == nil then
		print("[BehaviorTree] RegisterUnit failed: tree not found: " .. I)
		return
	end
	local a8 = "behavior_tree_" .. tostring(a5)
	local a9 = { unit = a3, createTime = GameRules:GetGameTime() }
	self.registeredUnits[T] = { treeName = I, interval = a6, timerName = a8, context = a9 }
	a3:StartThink(RandomFloat(0.01, a6), a8, function()
		if a3 == nil or not a3:IsAlive() or not IsValidEntity(a3) then
			self:UnregisterUnit(a3)
			return -1
		end
		if a3:HasState(StateEnum.AI_DISABLED) then
			return a6
		end
		local aa = self:Execute(I, a9)
		if aa == BehaviorNodeStatus.Running then
			return math.max(a9.interval or a6, a6)
		end
		a9.interval = nil
		return a6
	end)
end
function o.prototype.UnregisterUnit(self, a3)
	if a3 == nil then
		return
	end
	local a5 = a3:GetEntityIndex()
	local T = "unit_" .. tostring(a5)
	local t = self.registeredUnits[T]
	if t ~= nil then
		a3:StartThink(-1, t.timerName, function() end)
		h(self.registeredUnits, T)
	end
end
function o.prototype.GetUnitBehaviorData(self, a3)
	if a3 == nil then
		return nil
	end
	local T = "unit_" .. tostring(a3:GetEntityIndex())
	return self.registeredUnits[T]
end
function o.prototype.ClearTarget(self, a3)
	local t = self:GetUnitBehaviorData(a3)
	if t ~= nil and t.context ~= nil then
		t.context.target = nil
	end
end
function o.prototype.SetTarget(self, a3, ab)
	local t = self:GetUnitBehaviorData(a3)
	if t ~= nil and t.context ~= nil then
		t.context.target = ab
	end
end
function o.prototype.GetTarget(self, a3)
	local t = self:GetUnitBehaviorData(a3)
	if t ~= nil and t.context ~= nil then
		return t.context.target
	end
end
function o.prototype.Execute(self, I, a9)
	local a7 = self:GetTree(I) or self:LoadTree(I)
	if a7 == nil then
		return BehaviorNodeStatus.Failure
	end
	local ac = a9
	local ad = a7.params
	local ae = ad and ad.Debug
	if ae == nil then
		ae = 0
	end
	ac.debug = ae == 1
	if a9.debug then
		a9.executionDepth = 0
		a9.executionPath = {}
		local af = a9.unit:GetUnitName()
		local ag = a9.unit:GetEntityIndex()
		print(((((("\n[" .. af) .. "-") .. tostring(ag)) .. "] ===== 开始执行行为树: ") .. I) .. " =====")
	end
	local ah = self:ExecuteNode(a7, a9)
	if a9.debug then
		local af = a9.unit:GetUnitName()
		local ag = a9.unit:GetEntityIndex()
		print(
			((((((("[" .. af) .. "-") .. tostring(ag)) .. "] ===== 行为树执行结束: ") .. I) .. " [") .. ah)
				.. "] =====\n"
		)
	end
	return ah
end
function o.prototype.ExecuteNode(self, S, a9)
	if a9.debug then
		local ai = string.rep("  ", math.floor(a9.executionDepth or 0))
		local aj = (S.type .. ":") .. S.name
		local af = a9.unit:GetUnitName()
		local ag = a9.unit:GetEntityIndex()
		if a9.executionPath then
			local ak = a9.executionPath
			ak[#ak + 1] = aj
		end
		print(
			(
				(((((((("[" .. af) .. "-") .. tostring(ag)) .. "] ") .. ai) .. "→ ") .. aj) .. " [")
				.. (S.description or "")
			) .. "]"
		)
		if a9.executionDepth ~= nil then
			a9.executionDepth = a9.executionDepth + 1
		end
	end
	local ah
	repeat
		local al = S.type
		local am = al == BehaviorNodeType.Root
		if am then
			if S.children ~= nil and #S.children > 0 then
				ah = self:ExecuteNode(S.children[1], a9)
			else
				ah = BehaviorNodeStatus.Failure
			end
			break
		end
		am = am or al == BehaviorNodeType.Sequence
		if am then
			ah = self:ExecuteSequence(S, a9)
			break
		end
		am = am or al == BehaviorNodeType.Selector
		if am then
			ah = self:ExecuteSelector(S, a9)
			break
		end
		am = am or al == BehaviorNodeType.Parallel
		if am then
			ah = self:ExecuteParallel(S, a9)
			break
		end
		am = am or al == BehaviorNodeType.Rotation
		if am then
			ah = self:ExecuteRotation(S, a9)
			break
		end
		am = am or al == BehaviorNodeType.Polling
		if am then
			ah = self:ExecutePolling(S, a9)
			break
		end
		am = am or al == BehaviorNodeType.Action
		if am then
			ah = self:ExecuteAction(S, a9)
			break
		end
		am = am or al == BehaviorNodeType.Condition
		if am then
			ah = self:ExecuteCondition(S, a9)
			break
		end
		am = am or al == BehaviorNodeType.Cooldown
		if am then
			ah = self:ExecuteCooldown(S, a9)
			break
		end
		do
			print("[BehaviorTree] Unknown node type: " .. tostring(S.type))
			ah = BehaviorNodeStatus.Failure
		end
	until true
	if a9.debug then
		if a9.executionDepth ~= nil and a9.executionDepth > 0 then
			a9.executionDepth = a9.executionDepth - 1
		end
		local ai = string.rep("  ", math.floor(a9.executionDepth or 0))
		local af = a9.unit:GetUnitName()
		local ag = a9.unit:GetEntityIndex()
		local aj = (S.type .. ":") .. S.name
		local an = ""
		repeat
			local ao = ah
			local ap = ao == BehaviorNodeStatus.Success
			if ap then
				an = "✅"
				break
			end
			ap = ap or ao == BehaviorNodeStatus.Failure
			if ap then
				an = "❌"
				break
			end
			ap = ap or ao == BehaviorNodeStatus.Running
			if ap then
				an = "🔄"
				break
			end
		until true
		print(
			(((((((((("[" .. af) .. "-") .. tostring(ag)) .. "] ") .. ai) .. "← ") .. aj) .. " [") .. ah) .. "] ")
				.. an
		)
		if a9.executionPath and #a9.executionPath > 0 then
			table.remove(a9.executionPath)
		end
	end
	return ah
end
function o.prototype.ExecuteSequence(self, S, a9)
	if S.children == nil or #S.children == 0 then
		return BehaviorNodeStatus.Success
	end
	do
		local aq = 0
		while aq < #S.children do
			local ah = self:ExecuteNode(S.children[aq + 1], a9)
			if ah == BehaviorNodeStatus.Failure then
				return BehaviorNodeStatus.Failure
			end
			if ah == BehaviorNodeStatus.Running then
				return BehaviorNodeStatus.Running
			end
			aq = aq + 1
		end
	end
	return BehaviorNodeStatus.Success
end
function o.prototype.ExecuteSelector(self, S, a9)
	if S.children == nil or #S.children == 0 then
		return BehaviorNodeStatus.Failure
	end
	do
		local aq = 0
		while aq < #S.children do
			local ah = self:ExecuteNode(S.children[aq + 1], a9)
			if ah == BehaviorNodeStatus.Success then
				return BehaviorNodeStatus.Success
			end
			if ah == BehaviorNodeStatus.Running then
				return BehaviorNodeStatus.Running
			end
			aq = aq + 1
		end
	end
	return BehaviorNodeStatus.Failure
end
function o.prototype.ExecuteParallel(self, S, a9)
	if S.children == nil or #S.children == 0 then
		return BehaviorNodeStatus.Success
	end
	local ar = false
	local as = 0
	local at = S.threshold or #S.children
	do
		local aq = 0
		while aq < #S.children do
			local ah = self:ExecuteNode(S.children[aq + 1], a9)
			if ah == BehaviorNodeStatus.Running then
				ar = true
			elseif ah == BehaviorNodeStatus.Success then
				as = as + 1
			end
			aq = aq + 1
		end
	end
	if as >= at then
		return BehaviorNodeStatus.Success
	end
	if ar then
		return BehaviorNodeStatus.Running
	end
	return BehaviorNodeStatus.Failure
end
function o.prototype.ExecuteRotation(self, S, a9)
	if S.children == nil or #S.children == 0 then
		return BehaviorNodeStatus.Failure
	end
	local au = "rotation_" .. S.name
	local av = a9[au]
	if av == nil then
		av = 0
	end
	local ah = self:ExecuteNode(S.children[av + 1], a9)
	a9[au] = (av + 1) % #S.children
	return ah
end
function o.prototype.ExecutePolling(self, S, a9)
	if S.children == nil or #S.children == 0 then
		return BehaviorNodeStatus.Failure
	end
	local aw = "polling_" .. S.name
	local ax = a9[aw]
	if ax == nil then
		ax = 0
	end
	do
		local aq = 0
		while aq < #S.children do
			local ay = (ax + aq) % #S.children
			local ah = self:ExecuteNode(S.children[ay + 1], a9)
			if ah == BehaviorNodeStatus.Success or ah == BehaviorNodeStatus.Running then
				a9[aw] = (ay + 1) % #S.children
				return ah
			end
			aq = aq + 1
		end
	end
	return BehaviorNodeStatus.Failure
end
function o.prototype.ExecuteAction(self, S, a9)
	local az = "BTree_" .. S.name
	local aA = _G[az]
	if aA == nil or type(aA) ~= "function" then
		local aB = _G.BTree_Ability
		local aC = S.params
		if (aC and aC.ability_name) ~= nil and type(aB) == "function" then
			return aB(a9, S)
		end
		print("[BehaviorTree] No global function found for action: " .. az)
		return BehaviorNodeStatus.Failure
	end
	return aA(a9, S)
end
function o.prototype.ExecuteCondition(self, S, a9)
	local az = "BTree_" .. S.name
	local aA = _G[az]
	if aA == nil or type(aA) ~= "function" then
		print("[BehaviorTree] No global function found for condition: " .. az)
		return BehaviorNodeStatus.Failure
	end
	local ah = aA(a9, S)
	if ah and S.children ~= nil and #S.children > 0 then
		return self:ExecuteNode(S.children[1], a9)
	end
	return ah and BehaviorNodeStatus.Success or BehaviorNodeStatus.Failure
end
function o.prototype.ExecuteCooldown(self, S, a9)
	local aD = GameRules:GetGameTime()
	local aE = "cooldown_" .. S.name
	local aF = a9[aE]
	if aF == nil or aD >= aF then
		if S.children ~= nil and #S.children > 0 then
			local aa = self:ExecuteNode(S.children[1], a9)
			if aa == BehaviorNodeStatus.Success then
				local aG = S.params
				local aH = aG and aG.cd
				if aH == nil then
					aH = 0.5
				end
				local aI = aH
				a9[aE] = aD + aI
			end
			return aa
		end
		return BehaviorNodeStatus.Success
	end
	return BehaviorNodeStatus.Failure
end
function o.prototype.PrintTree(self, I)
	local a7 = self.trees[I]
	if a7 == nil then
		print("[BehaviorTree] Tree not found: " .. I)
		return
	end
	print(("\n========== Behavior Tree: " .. I) .. " ==========")
	self:PrintNode(a7, 0)
	print(string.rep("=", math.floor(50)) .. "\n")
end
function o.prototype.PrintNode(self, S, aJ)
	local ai = string.rep("  ", math.floor(aJ))
	print((((ai .. "[") .. S.type) .. "] ") .. S.name)
	if S.description ~= nil then
		print((ai .. "  Description: ") .. S.description)
	end
	if S.threshold ~= nil then
		print((ai .. "  Threshold: ") .. tostring(S.threshold))
	end
	if S.params ~= nil then
		print(ai .. "  Params:")
		for T, U in pairs(S.params) do
			print((((ai .. "    ") .. tostring(T)) .. ": ") .. tostring(U))
		end
	end
	if S.children ~= nil and #S.children > 0 then
		print(((ai .. "  Children (") .. tostring(#S.children)) .. "):")
		do
			local aq = 0
			while aq < #S.children do
				self:PrintNode(S.children[aq + 1], aJ + 2)
				aq = aq + 1
			end
		end
	end
end
function o.prototype.PrintDebugStatus(self)
	print("\n[BehaviorTree] Debug Status Report")
	print("=====================================")
	local aK = 0
	for T, t in pairs(self.registeredUnits) do
		local a3 = t.unit
		local aa = t.debug and "🔧 DEBUG" or "NORMAL"
		print(
			(
				(
					(
						(((("  " .. tostring(a3:GetUnitName())) .. "-") .. tostring(a3:GetEntityIndex())) .. ": ")
						.. tostring(t.treeName)
					) .. " ["
				) .. aa
			) .. "]"
		)
		aK = aK + 1
	end
	print("Total registered units: " .. tostring(aK))
	print("=====================================\n")
end
o = i({ l }, o)
if BehaviorTree == nil then
	BehaviorTree = f(o)
end
return j