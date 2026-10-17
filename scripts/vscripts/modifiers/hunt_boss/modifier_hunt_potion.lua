--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "modifiers/hunt_boss/modifier_hunt_potion"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__New
local f = b.__TS__ArraySplice
local g = b.__TS__ArrayIncludes
local h = b.__TS__ArrayFilter
local i = b.__TS__ArrayEvery
local j = b.__TS__DecorateLegacy
local k = {}
local l = require("class.drop_item")
local m = l.DropItem
local n = require("class.weight_pool")
local o = n.CWeightPool
local p = require("modifiers.eom_modifier.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
local s = 0.1
local t = 240
local u = 200
local v = 0.5
local w = c()
w.name = "modifier_hunt_potion"
d(w, q)
function w.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.ended = false
	self.interval = 0
	self.count = 0
	self.lifetime = 0
	self.elapsedTime = 0
	self.nextTriggerTime = 0
	self.pendingCount = 0
	self.nextRetryTime = 0
	self.validGridPositions = {}
	self.heroes = function()
		return {}
	end
	self.itemPool = e(o)
	self.drops = {}
end
function w.prototype.OnCreated(self, x)
	if not IsServer() then
		return
	end
	self.interval = toFiniteNumber(x.interval, 0)
	self.count = math.floor(toFiniteNumber(x.count, 0))
	self.lifetime = toFiniteNumber(x.lifetime, 0)
	self.nextTriggerTime = math.max(0, toFiniteNumber(x.firstDelay, 0))
	self.testPlayerID = x.testPlayerID ~= nil and x.testPlayerID or nil
	for y, z in ipairs({ "item_health_potion_1", "item_health_potion_2", "item_health_potion_3" }) do
		local A = toFiniteNumber(x[z], 0)
		if A > 0 and KeyValues.items[z] ~= nil then
			self.itemPool:Set(z, A)
		end
	end
	if self.interval <= 0 or self.count <= 0 or self.lifetime <= 0 or self.itemPool.ValidCount <= 0 then
		self:Destroy()
		return
	end
	self:StartIntervalThink(s)
end
function w.prototype.SetSpawnContext(self, B, C)
	self.validGridPositions = B
	self.heroes = C
end
function w.prototype.SetPaused(self, D)
	if not IsServer() or self.ended then
		return
	end
	self:SetStackCount(D and 0 or 1)
end
function w.prototype.OnIntervalThink(self)
	if not IsServer() or self.ended or self:GetStackCount() == 0 then
		return
	end
	if self:GetStackCount() == 1 then
		self.elapsedTime = self.elapsedTime + s
		while self.elapsedTime >= self.nextTriggerTime do
			self.pendingCount = self.pendingCount + self.count
			self.nextTriggerTime = self.nextTriggerTime + self.interval
		end
		if self.pendingCount > 0 and self.elapsedTime >= self.nextRetryTime then
			self:SpawnBatch()
			self.nextRetryTime = self.elapsedTime + v
		end
	end
	self:TryAutoPickup()
	if self.ended or self:GetStackCount() == 0 then
		return
	end
	do
		local E = #self.drops - 1
		while E >= 0 do
			do
				local F = self.drops[E + 1]
				if F.dropItem.isDispose or not IsValid(F.dropItem.entity) then
					self:RemoveDrop(F)
					f(self.drops, E, 1)
					goto G
				end
				F.remainingLifetime = F.remainingLifetime - s
				if F.remainingLifetime <= 0 then
					self:RemoveDrop(F)
					f(self.drops, E, 1)
				end
			end
			::G::
			E = E - 1
		end
	end
	if self:GetStackCount() == 2 and #self.drops == 0 then
		self:Destroy()
	end
end
function w.prototype.OnDestroy(self)
	if not IsServer() or self.ended then
		return
	end
	self.ended = true
	for y, F in ipairs(self.drops) do
		self:RemoveDrop(F)
	end
	self.drops = {}
	self.pendingCount = 0
	self.validGridPositions = {}
	self.heroes = function()
		return {}
	end
	local H = self:GetParent()
	if IsValid(H) then
		Timer:Timer(0, function()
			if IsValid(H) then
				UTIL_Remove(H)
			end
		end)
	end
end
function w.prototype.SpawnBatch(self)
	local I = math.min(self.pendingCount, self.count)
	do
		local E = 0
		while E < I do
			do
				local J = self:FindRandomFieldPosition()
				local z = self.itemPool:Random()
				if J == nil or z == nil then
					break
				end
				local K = e(m, z, J)
				local F = { dropItem = K, interactionIndex = -1, remainingLifetime = self.lifetime }
				F.interactionIndex = Interaction:RegisterInteract(K.entity, InteractType.Chest, u, function(y, L)
					return self:PickupDrop(F, L)
				end, nil, nil, z)
				if F.interactionIndex == -1 then
					K:dispose()
					goto M
				end
				local N = self.drops
				N[#N + 1] = F
				self.pendingCount = self.pendingCount - 1
			end
			::M::
			E = E + 1
		end
	end
end
function w.prototype.PickupDrop(self, F, L)
	if
		self.ended
		or self:GetStackCount() == 0
		or F.dropItem.isDispose
		or not F.dropItem:IsLanded()
		or not IsValid(F.dropItem.entity)
		or not IsValid(L)
		or not L:IsAlive()
		or not L:IsRealHero()
		or not g(self:heroes(), L)
	then
		return false
	end
	L:AddItemByName(F.dropItem.itemName)
	self:RemoveDrop(F)
	return true
end
function w.prototype.TryAutoPickup(self)
	local O
	if self.testPlayerID ~= nil then
		O = { self.testPlayerID }
	else
		local P = CustomNetTables:GetNetData("hunt_boss", "state")
		O = P and P.active_player_ids or {}
	end
	local Q = O
	for y, R in ipairs(Q) do
		do
			if self.ended or self:GetStackCount() == 0 then
				break
			end
			local L = PlayerResource:GetSelectedHeroEntity(R)
			if not IsValid(L) or not L:IsAlive() or not L:IsRealHero() then
				goto S
			end
			local T = Service:GetPlayerSetting(R, "setting_switch_auto_pick_drop_item", false)
			local U
			local V = u
			for y, F in ipairs(self.drops) do
				do
					local W = F.dropItem
					local X = W.isDispose or not W:IsLanded() or not IsValid(W.entity)
					if not X then
						local Y = not T
						if Y then
							local Z = KeyValues.items[W.itemName]
							if Z ~= nil then
								Z = Z.AutoPickUp
							end
							Y = Z ~= 1
						end
						X = Y
					end
					if X then
						goto _
					end
					local a0 = (L:GetAbsOrigin() - W.entity:GetAbsOrigin()):Length2D()
					if a0 <= V then
						U = F
						V = a0
					end
				end
				::_::
			end
			if U ~= nil then
				Interaction:ExecutePrimaryCallback(U.interactionIndex, L, R)
			end
		end
		::S::
	end
end
function w.prototype.FindRandomFieldPosition(self)
	local C = h(self:heroes(), function(y, L)
		return IsValid(L) and L:IsAlive()
	end)
	return GetRandomElement(h(self.validGridPositions, function(y, a1)
		return GridNav:IsValidPosition(a1)
			and i(C, function(y, L)
				return CalcDistance(a1, L:GetAbsOrigin()) >= t
			end)
			and i(self.drops, function(y, F)
				return F.dropItem.isDispose or CalcDistance(a1, F.dropItem.position) >= 96
			end)
	end))
end
function w.prototype.RemoveDrop(self, F)
	if F.interactionIndex ~= -1 then
		Interaction:UnregisterInteractable(F.interactionIndex)
		F.interactionIndex = -1
	end
	F.dropItem:dispose()
end
w = j(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	w
)
function k.GetHuntPotionController(self, a2)
	local a3 = a2:FindModifierByName("modifier_hunt_potion")
	return IsValid(a3) and a3 or nil
end
return k