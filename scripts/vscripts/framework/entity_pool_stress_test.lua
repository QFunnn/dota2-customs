--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/entity_pool_stress_test"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__New
local f = b.__TS__NumberToFixed
local g = {}
local h = require("class.drop_item")
local i = h.DropItem
local j = require("class.shop_item")
local k = j.ShopItem
local l = 0.15
local m = 0.75
local n = c()
n.name = "EntityPoolStressTest"
d(n, CModule)
function n.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.activeEntities = {}
	self.activeInteractionIndices = {}
	self.activeRoomDrops = {}
	self.activeCoinPickups = {}
	self.activeRun = 0
end
function n.prototype.init(self, o)
	if not o then
		if IsServer() then
			if IsInToolsMode() then
				self:RegisterCommands()
			end
		end
	end
end
function n.prototype.RegisterCommands(self)
	Convars:RegisterCommand("entity_pool_test_drop", function(p, ...)
		local q = { ... }
		local r = self:GetCount(q[1], 15)
		local s = self:GetLifetime(q[2])
		local t = self:GetCoinTestOrigin(q[3], q[4], q[5])
		self:RunCoinDropTest(r, s, t)
	end, "Spawn real auto-pickup coin drops at one position: entity_pool_test_drop [count=15] [lifetime=5] [x y z]", 0)
	Convars:RegisterCommand(
		"entity_pool_test_coin",
		function(p, ...)
			local q = { ... }
			local u = string.lower(tostring(q[1] or "full"))
			local r = self:GetCount(q[2], 15)
			local s = self:GetLifetime(q[3])
			local t = self:GetCoinTestOrigin(q[4], q[5], q[6])
			self:RunCoinStressTest(u, r, s, t)
		end,
		"Coin pickup stress test. Modes: world, interaction, effect, item, full. Usage: entity_pool_test_coin [mode=full] [count=15] [lifetime=5] [x y z]",
		0
	)
	Convars:RegisterCommand("entity_pool_test_shop", function(p, ...)
		local q = { ... }
		self:RunTest("shop", self:GetCount(q[1]), self:GetLifetime(q[2]), function(v, t)
			return e(k, "item_coin_stack", 1, t)
		end)
	end, "Spawn pooled ShopItem instances: entity_pool_test_shop [count=100] [lifetime=5]", 0)
	Convars:RegisterCommand("entity_pool_test_cleanup", function()
		self:BeginRun()
		print("[EntityPoolTest] cleaned up active test entities")
	end, "Immediately recycle active entity pool test instances", 0)
end
function n.prototype.RunTest(self, w, r, s, x)
	local y = self:BeginRun()
	local z = self:GetTestOrigin()
	local A = Time()
	do
		local B = 0
		while B < r do
			local C = B % 10
			local D = math.floor(B / 10)
			local t = Vector(z.x + C * 96, z.y + D * 96, z.z)
			local E = self.activeEntities
			E[#E + 1] = x(nil, t)
			B = B + 1
		end
	end
	local F = (Time() - A) * 1000
	print(
		(
			(
				((((("[EntityPoolTest] " .. w) .. ": acquired ") .. tostring(r)) .. " entities in ") .. f(F, 2))
				.. " ms; recycle in "
			) .. f(s, 1)
		) .. " s"
	)
	self:ScheduleCleanup(y, s, function()
		print(((("[EntityPoolTest] " .. w) .. ": recycled ") .. tostring(r)) .. " entities")
	end)
end
function n.prototype.RunCoinDropTest(self, r, s, z)
	local y = self:BeginRun()
	local G = DungeonManager:GetCurrentRoom()
	if G == nil then
		print(
			"[EntityPoolTest] no active dungeon room; interactable coins require a room for modifier_hero auto-pickup"
		)
		return
	end
	local F = self:SpawnCoinDrops(r, z, "full", G, true)
	print(
		(
			(
				(
					(
						("[EntityPoolTest] full: spawned " .. tostring(r))
						.. " real auto-pickup coins at one position in "
					) .. f(F, 2)
				) .. " ms; cleanup in "
			) .. f(s, 1)
		) .. " s"
	)
	self:ScheduleCleanup(y, s, function()
		print("[EntityPoolTest] full: recycled remaining test coins")
	end)
end
function n.prototype.RunCoinStressTest(self, u, r, s, z)
	if not self:IsCoinStressMode(u) then
		print(
			("[EntityPoolTest] unknown coin mode '" .. tostring(u))
				.. "'. Use world, interaction, effect, item, or full."
		)
		return
	end
	local y = self:BeginRun()
	if u == "item" then
		local H = self:GetTestHero()
		if H == nil then
			print("[EntityPoolTest] no valid hero for temporary coin item test")
			return
		end
		local A = Time()
		do
			local B = 0
			while B < r do
				H:AddItemByName("item_coin_stack")
				B = B + 1
			end
		end
		local I = (Time() - A) * 1000
		print(
			(
				(("[EntityPoolTest] item: queued " .. tostring(r)) .. " temporary item_coin_stack instances in ")
				.. f(I, 2)
			) .. " ms; their OnCreated rewards resolve on the next server frame"
		)
		return
	end
	if u == "world" then
		local A = Time()
		do
			local B = 0
			while B < r do
				local J = self.activeEntities
				J[#J + 1] = e(i, "item_coin_stack", z)
				B = B + 1
			end
		end
		local F = (Time() - A) * 1000
		print(
			(
				(
					(
						(
							("[EntityPoolTest] world: acquired " .. tostring(r))
							.. " pooled coin props at one position in "
						) .. f(F, 2)
					) .. " ms; cleanup in "
				) .. f(s, 1)
			) .. " s"
		)
		self:ScheduleCleanup(y, s, function()
			return print(("[EntityPoolTest] world: recycled " .. tostring(r)) .. " coin props")
		end)
		return
	end
	local H = self:GetTestHero()
	if H == nil then
		print("[EntityPoolTest] no valid hero for coin interaction test")
		return
	end
	if u == "full" then
		local G = DungeonManager:GetCurrentRoom()
		if G == nil then
			print("[EntityPoolTest] no active dungeon room; full mode requires the normal auto-pickup system")
			return
		end
		local F = self:SpawnCoinDrops(r, z, u, G, true)
		print(
			(
				(
					((("[EntityPoolTest] full: spawned " .. tostring(r)) .. " coins at one position in ") .. f(F, 2))
					.. " ms; normal auto-pickup runs every "
				) .. f(l, 2)
			) .. " s"
		)
		self:ScheduleCleanup(y, s, function()
			return print("[EntityPoolTest] full: recycled remaining test coins")
		end)
		return
	end
	local F = self:SpawnCoinDrops(r, z, u)
	print(
		(
			(((("[EntityPoolTest] " .. u) .. ": spawned ") .. tostring(r)) .. " test coins at one position in ") .. f(
				F,
				2
			)
		) .. " ms; synthetic pickup begins after landing"
	)
	self:StartSyntheticPickupSequence(y, u, H, r)
	self:ScheduleCleanup(y, math.max(s, m + r * l + 0.5), function()
		print(("[EntityPoolTest] " .. u) .. ": recycled remaining test coins")
	end)
end
function n.prototype.SpawnCoinDrops(self, r, z, u, G, K)
	if K == nil then
		K = false
	end
	local A = Time()
	Interaction:BeginSyncBatch()
	do
		local B = 0
		while B < r do
			local L = e(i, "item_coin_stack", z)
			local M = self.activeEntities
			M[#M + 1] = L
			local N = Interaction:RegisterInteract(L.entity, InteractType.Chest, 200, function(v, H)
				if u == "full" then
					H:AddItemByName("item_coin_stack")
				end
				L:dispose()
			end, nil, nil, "item_coin_stack")
			if N ~= -1 then
				local O = self.activeInteractionIndices
				O[#O + 1] = N
				local P = self.activeCoinPickups
				P[#P + 1] = { dropItem = L, entityIndex = N }
				if K and G ~= nil then
					G:RegisterDropItemForAutoPickup(L, N)
					local Q = self.activeRoomDrops
					Q[#Q + 1] = { dropItem = L, room = G, entityIndex = N }
				end
			end
			B = B + 1
		end
	end
	Interaction:EndSyncBatch()
	return (Time() - A) * 1000
end
function n.prototype.StartSyntheticPickupSequence(self, y, u, H, R)
	local S = 0
	local T = 0
	local A = Time()
	Timer:GameTimer(m, function()
		if y ~= self.activeRun then
			return
		end
		local U = self.activeCoinPickups[1]
		if U == nil then
			local V = (Time() - A) * 1000
			print(
				(
					(
						(
							(
								(
									(((("[EntityPoolTest] " .. u) .. ": completed ") .. tostring(S)) .. "/")
									.. tostring(R)
								) .. " sequential pickups in "
							) .. f(V, 2)
						) .. " ms; callback work "
					) .. f(T, 2)
				) .. " ms"
			)
			return
		end
		local W = IsValid(U.dropItem.entity) and U.dropItem.entity:GetAbsOrigin() or vec3_origin
		local X = Time()
		Interaction:ExecutePrimaryCallback(U.entityIndex, H, H:GetPlayerOwnerID())
		if u == "effect" then
			self:CreatePickupParticle(W, H)
		end
		Interaction:UnregisterInteractable(U.entityIndex)
		T = T + (Time() - X) * 1000
		ArrayRemove(self.activeInteractionIndices, U.entityIndex)
		table.remove(self.activeCoinPickups, 1)
		S = S + 1
		return l
	end)
end
function n.prototype.CreatePickupParticle(self, W, H)
	local Y =
		ParticleManager:CreateParticleForce("particles/generic_gameplay/drop_item_pick.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(Y, 0, W)
	ParticleManager:SetParticleControlEnt(Y, 1, H, PATTACH_POINT_FOLLOW, "attach_hitloc", H:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(Y)
end
function n.prototype.IsCoinStressMode(self, u)
	return u == "world" or u == "interaction" or u == "effect" or u == "item" or u == "full"
end
function n.prototype.Cleanup(self)
	Interaction:BeginSyncBatch()
	for v, Z in ipairs(self.activeInteractionIndices) do
		Interaction:UnregisterInteractable(Z)
	end
	self.activeInteractionIndices = {}
	Interaction:EndSyncBatch()
	for v, U in ipairs(self.activeRoomDrops) do
		U.room:UnregisterDropItemForAutoPickup(U.dropItem, U.entityIndex)
	end
	self.activeRoomDrops = {}
	self.activeCoinPickups = {}
	for v, _ in ipairs(self.activeEntities) do
		_:dispose()
	end
	self.activeEntities = {}
end
function n.prototype.BeginRun(self)
	self.activeRun = self.activeRun + 1
	self:Cleanup()
	return self.activeRun
end
function n.prototype.ScheduleCleanup(self, y, a0, a1)
	Timer:GameTimer(a0, function()
		if y ~= self.activeRun then
			return
		end
		self:Cleanup()
		a1(nil)
	end)
end
function n.prototype.GetTestOrigin(self)
	local z = Vector(0, 0, 128)
	Game:EachPlayer(function(v, a2)
		local H = PlayerResource:GetSelectedHeroEntity(a2)
		if IsValid(H) then
			z = H:GetAbsOrigin() + Vector(300, 0, 0)
			return true
		end
	end)
	return z
end
function n.prototype.GetCoinTestOrigin(self, a3, a4, a5)
	if a3 ~= nil and a4 ~= nil and a5 ~= nil then
		return Vector(toFiniteNumber(a3), toFiniteNumber(a4), toFiniteNumber(a5))
	end
	local H = self:GetTestHero()
	if H ~= nil then
		return H:GetAbsOrigin() + Vector(200, 0, 0)
	end
	return Vector(0, 0, 128)
end
function n.prototype.GetTestHero(self)
	local a6
	Game:EachPlayer(function(v, a2)
		local H = PlayerResource:GetSelectedHeroEntity(a2)
		if IsValid(H) then
			a6 = H
			return true
		end
	end)
	return a6
end
function n.prototype.GetCount(self, a7, a8)
	if a8 == nil then
		a8 = 100
	end
	return math.floor(math.max(1, math.min(toFiniteNumber(a7, a8), 500)))
end
function n.prototype.GetLifetime(self, a7)
	return math.max(0.1, math.min(toFiniteNumber(a7, 5), 60))
end
g.EntityPoolTest = e(n)
return g