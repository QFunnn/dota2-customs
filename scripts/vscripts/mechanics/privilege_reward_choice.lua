--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/privilege_reward_choice"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFind
local f = b.__TS__ArrayFilter
local g = b.__TS__StringSplit
local h = b.__TS__ArraySome
local i = b.__TS__DecorateLegacy
local j = b.__TS__New
local k = {}
local l = require("lib.tstl-utils")
local m = l.reloadable
local n = c()
n.name = "CPrivilegeRewardChoice"
d(n, CModule)
function n.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.logPrefix = "[PrivilegeRewardChoice]"
	self.requestSerial = 0
end
function n.prototype.initPriority(self)
	return -8
end
function n.prototype.init(self, o)
	if not o then
		self.requestSerial = 0
	end
	CustomUIEvent("select_privilege_reward", function(self, ...)
		return self:OnSelectReward(...)
	end, self)
	local p = ChoiceManager:RegisterChoiceModule(MultiChoiceType.PrivilegeReward, self)
	self:print((((self.logPrefix .. " init reload=") .. tostring(o)) .. " registered=") .. tostring(p))
end
function n.prototype.RequestEnqueue(self, q, r, s, t)
	local u = math.max(0, math.floor(t))
	if u <= 0 or s <= 0 then
		self:print(
			(
				(
					(
						((((self.logPrefix .. " enqueue rejected player=") .. tostring(q)) .. " kind=") .. r)
						.. " rarity="
					) .. tostring(s)
				) .. " count="
			) .. tostring(t)
		)
		return false
	end
	local v = {
		requestId = self:GenerateRequestId(q),
		playerId = q,
		choiceType = MultiChoiceType.PrivilegeReward,
		choiceCount = u,
		snapshot = { kind = r, rarity = s },
	}
	local w = ChoiceManager:EnqueueChoice(q, v)
	self:print(
		(
			(
				(
					(
						(((((self.logPrefix .. " enqueue player=") .. tostring(q)) .. " kind=") .. r) .. " rarity=")
						.. tostring(s)
					) .. " count="
				) .. tostring(u)
			) .. " result="
		) .. tostring(w)
	)
	return w
end
function n.prototype.OpenByManager(self, v)
	if v.choiceType ~= MultiChoiceType.PrivilegeReward or v.choiceCount <= 0 then
		return false
	end
	local x = v.snapshot
	if x == nil then
		return false
	end
	local y = self:BuildSelection(v.playerId, x.kind, x.rarity, v.choiceCount)
	if #y.options <= 0 then
		self:print(
			(
				((((self.logPrefix .. " no options player=") .. tostring(v.playerId)) .. " kind=") .. x.kind)
				.. " rarity="
			) .. tostring(x.rarity)
		)
		return false
	end
	x.selection = y
	self:PushSelection(v.playerId, y)
	return true
end
function n.prototype.OnSelectReward(self, z)
	local q = z.PlayerID
	local v = ChoiceManager:GetActiveRequest(q, MultiChoiceType.PrivilegeReward)
	if v == nil then
		return false
	end
	local x = v.snapshot
	local y = x and x.selection
	local A = y
	local B = A and e(y and y.options, function(C, D)
		return D.name == z.itemName
	end)
	if x == nil or y == nil or B == nil then
		return false
	end
	if not self:GrantReward(q, x.kind, B) then
		y.options = f(y.options, function(C, D)
			return D.name ~= B.name
		end)
		if #y.options > 0 then
			self:PushSelection(q, y)
			return false
		end
		return self:ConsumeRequest(q, v.requestId)
	end
	Notification:CombatToPlayer(
		q,
		{ message = "Notify_privilege_reward_choice", item_name = B.name, item_name_rarity = B.rarity }
	)
	v.choiceCount = v.choiceCount - 1
	if v.choiceCount <= 0 then
		return self:ConsumeRequest(q, v.requestId)
	end
	local E = self:BuildSelection(q, x.kind, x.rarity, v.choiceCount)
	if #E.options <= 0 then
		return self:ConsumeRequest(q, v.requestId)
	end
	x.selection = E
	self:PushSelection(q, E)
	return true
end
function n.prototype.BuildSelection(self, q, r, s, F)
	local G = {}
	local H = "#PrivilegeRewardChoiceArtifactTitle"
	if r == PrivilegeRewardKind.MeepoArtifact then
		G = Artifact:GetSelectableArtifactOptions(q, "Meepo", s)
		H = "#PrivilegeRewardChoiceMeepoArtifactTitle"
	elseif r == PrivilegeRewardKind.Artifact then
		G = Artifact:GetSelectableArtifactOptions(q, "Shop", s)
	elseif r == PrivilegeRewardKind.WindBless then
		G = Bless:GetSelectableBlessOptions(q, "Wind", s)
		H = "#PrivilegeRewardChoiceWindBlessTitle"
	end
	return { options = G, title = H, remaining_count = F }
end
function n.prototype.GrantReward(self, q, r, B)
	local I = PlayerResource:GetSelectedHeroEntity(q)
	if I == nil then
		return false
	end
	if r == PrivilegeRewardKind.WindBless then
		local J = Bless:AddBless(I, B)
		if J == nil then
			return false
		end
		Event:Fire("bless_selected", { playerID = q, blessName = B.name, rarity = B.rarity })
		return true
	end
	local K = r == PrivilegeRewardKind.MeepoArtifact and "Meepo" or "Shop"
	local L = KeyValues.artifact[B.name]
	local M = tostring
	local N
	if L ~= nil then
		N = L.RarityRange
	end
	local O = N
	if O == nil then
		O = ""
	end
	local P = g(M(O), "|")
	local Q = tostring
	local R
	if L ~= nil then
		R = L.Access
	end
	local S = R
	if S == nil then
		S = ""
	end
	if Q(S) ~= K or not h(P, function(C, D)
		return toFiniteNumber(D, 0) == B.rarity
	end) then
		return false
	end
	if not Artifact:CanObtainArtifact(I, B.name) then
		return false
	end
	return I:AddItemByName(B.name, B.rarity) ~= nil
end
function n.prototype.PushSelection(self, q, y)
	CustomNetTables:SetNetData("common", "privilege_reward_selection", y, q)
end
function n.prototype.ConsumeRequest(self, q, T)
	CustomNetTables:SetNetData("common", "privilege_reward_selection", nil, q)
	return ChoiceManager:DequeueCurrent(q, T, true, MultiChoiceType.PrivilegeReward)
end
function n.prototype.GenerateRequestId(self, q)
	self.requestSerial = self.requestSerial + 1
	return (((("privilege_reward_" .. tostring(q)) .. "_") .. tostring(GameRules:GetGameTime())) .. "_")
		.. tostring(self.requestSerial)
end
function n.prototype.reset(self)
	self.requestSerial = 0
	Game:EachPlayer(function(C, q)
		CustomNetTables:SetNetData("common", "privilege_reward_selection", nil, q)
	end)
end
n = i({ m }, n)
if PrivilegeRewardChoice == nil then
	PrivilegeRewardChoice = j(n)
end
return k