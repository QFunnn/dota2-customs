--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "class/entity_pool"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ObjectAssign
local e = {}
e.EntityPool = c()
local f = e.EntityPool
f.name = "EntityPool"
function f.prototype.____constructor(self) end
function f.Acquire(self, g, h, i)
	local j = self.entities[g]
	local k
	while j ~= nil and #j > 0 and k == nil do
		local l = table.remove(j)
		if IsValid(l) then
			k = l
		end
	end
	if k == nil then
		k = SpawnEntityFromTableSynchronous(h, i)
	end
	self:ApplyDynamicState(k, i)
	return k
end
function f.ApplyDynamicState(self, k, i)
	k:RemoveEffects(EF_NODRAW)
	if i.origin ~= nil then
		k:SetAbsOrigin(i.origin)
	end
	if i.targetname ~= nil then
		k:SetEntityName(i.targetname)
	end
end
function f.Release(self, g, k)
	if not IsValid(k) then
		return
	end
	local j = self.entities[g]
	if j == nil then
		j = {}
		self.entities[g] = j
	end
	if #j >= self.MaxInactivePerKey then
		k:RemoveSelf()
		return
	end
	k:AddEffects(EF_NODRAW)
	k:SetAbsOrigin(self.HiddenOrigin)
	j[#j + 1] = k
end
function f.Prewarm(self, g, h, i, m)
	local j = self.entities[g]
	if j == nil then
		j = {}
		self.entities[g] = j
	end
	while #j < math.min(m, self.MaxInactivePerKey) do
		local k = SpawnEntityFromTableSynchronous(h, d({}, i, { origin = self.HiddenOrigin }))
		k:AddEffects(EF_NODRAW)
		j[#j + 1] = k
	end
end
function f.Clear(self)
	for g in pairs(self.entities) do
		for n, k in ipairs(self.entities[g]) do
			if IsValid(k) then
				k:RemoveSelf()
			end
		end
	end
	self.entities = {}
end
f.HiddenOrigin = Vector(10000, 10000, -10000)
f.MaxInactivePerKey = 128
f.entities = {}
return e