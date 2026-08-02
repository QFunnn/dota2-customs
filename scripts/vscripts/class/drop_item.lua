--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "class/drop_item"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayForEach
local e = {}
local f = require("class.entity_pool")
local g = f.EntityPool
e.DropItem = c()
local h = e.DropItem
h.name = "DropItem"
function h.prototype.____constructor(self, i, j, k)
	self.isDispose = false
	self.isLanded = false
	self.Quantitylimit = 9999999
	self.particleIDs = {}
	self.itemName = i
	self.position = j
	self.playerID = k
	self.id = DoUniqueString(i)
	local l = KeyValues.items[i]
	if l.Quantitylimit ~= nil and l.Quantitylimit ~= "" then
		self.Quantitylimit = toFiniteNumber(l.Quantitylimit)
	end
	local m = e.DropItem:GetModel(l)
	self.entityPoolKey = e.DropItem:GetEntityPoolKey(m, l.Skin)
	local n = g
	local o = g.Acquire
	local p = self.entityPoolKey
	local q = e.DropItem.Classname
	local r = j
	local s = l.Skin
	if s == nil then
		s = "default"
	end
	self.entity = o(
		n,
		p,
		q,
		{
			angles = "0 -90 0",
			model = m,
			origin = r,
			skin = s,
			targetname = self.id,
			StartingAnim = "ACT_DOTA_IDLE",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
		}
	)
	if l.Particle ~= nil then
		if self.playerID ~= nil then
			local t = PlayerResource:GetPlayer(self.playerID)
			if t ~= nil then
				local u = ParticleManager:CreateParticleForPlayer(l.Particle, PATTACH_ABSORIGIN_FOLLOW, self.entity, t)
				ParticleManager:SetParticleControlEnt(
					u,
					1,
					self.entity,
					PATTACH_INVALID,
					nil,
					self.entity:GetAbsOrigin(),
					true
				)
				local v = self.particleIDs
				v[#v + 1] = u
			end
		else
			local u = ParticleManager:CreateParticleForce(l.Particle, PATTACH_ABSORIGIN_FOLLOW, self.entity)
			local w = self.particleIDs
			w[#w + 1] = u
		end
	end
	local x = self.entity
	x:GameTimer(0.1, function()
		self:StartDropAnimation(x)
	end)
end
function h.Prewarm(self)
	local y = {}
	for i in pairs(KeyValues.items) do
		if i ~= "Version" then
			local l = KeyValues.items[i]
			local m = e.DropItem:GetModel(l)
			local z = l.Skin
			y[e.DropItem:GetEntityPoolKey(m, z)] = { model = m, skin = z }
		end
	end
	for A in pairs(y) do
		local B = y[A]
		local C = B.model == e.DropItem:GetModel(KeyValues.items.item_coin_stack) and 100 or 1
		g:Prewarm(
			A,
			e.DropItem.Classname,
			{
				angles = "0 -90 0",
				model = B.model,
				skin = B.skin or "default",
				targetname = "pooled_drop_item",
				StartingAnim = "ACT_DOTA_IDLE",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			},
			C
		)
	end
end
function h.GetModel(self, l)
	return (l.Model == nil or l.Model == "") and "models/development/invisiblebox.vmdl" or l.Model
end
function h.GetEntityPoolKey(self, m, z)
	return ((("drop_item:" .. m) .. ":") .. (z or "default")) .. ":0,-90,0:ACT_DOTA_IDLE"
end
function h.prototype.GetEntityIndex(self)
	return self.entity:GetEntityIndex()
end
function h.prototype.IsLanded(self)
	return self.isLanded
end
function h.prototype.StartDropAnimation(self, x)
	if self.isDispose or self.entity ~= x then
		return
	end
	local D = self.position
	local E = GameRules:GetGameTime()
	local F = 0.5
	local G = 180
	x:GameTimer(0, function()
		if self.isDispose or self.entity ~= x then
			return nil
		end
		local H = GameRules:GetGameTime() - E
		if H >= F then
			self.entity:SetLocalOrigin(D)
			self.isLanded = true
			return nil
		end
		local I = H / F
		local J = 4 * G * I * (1 - I)
		local K = Vector(D.x, D.y, D.z + J)
		self.entity:SetLocalOrigin(K)
		return 0
	end)
end
function h.prototype.dispose(self)
	if self.isDispose then
		return
	end
	self.isDispose = true
	if IsValid(self.entity) then
		g:Release(self.entityPoolKey, self.entity)
		self.entity = nil
	end
	d(self.particleIDs, function(L, M)
		ParticleManager:DestroyParticle(M, true)
	end)
	self.particleIDs = {}
end
h.Classname = "dota_prop_customtexture"
return e