--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/large_number_health"
local b = require("lualib_bundle")
local c = b.__TS__Class
LARGE_NUMBER_HEALTH_TRIGGER = 1000000000
LARGE_NUMBER_HEALTH_PROXY_MAX = 1000000
LargeNumberHealth = c()
LargeNumberHealth.name = "LargeNumberHealth"
function LargeNumberHealth.prototype.____constructor(self) end
function LargeNumberHealth.IsActive(self, d)
	return d.__largeNumberHealth ~= nil
end
function LargeNumberHealth.GetHealth(self, d)
	local e = d.__largeNumberHealth
	return e and e.health
end
function LargeNumberHealth.GetMaxHealth(self, d)
	local f = d.__largeNumberHealth
	return f and f.max
end
function LargeNumberHealth.ToProxyValue(self, d, g)
	local h = d.__largeNumberHealth
	if h == nil then
		return math.max(0, math.floor(g))
	end
	if g <= 0 or h.max <= 0 then
		return 0
	end
	return math.floor(LARGE_NUMBER_HEALTH_PROXY_MAX * g / h.max)
end
function LargeNumberHealth.Refresh(self, d)
	if not IsServer() or d:IsHero() then
		return false
	end
	local i = math.max(1, math.floor(d:GetMaxHealth()))
	local j = d.__largeNumberHealth
	local k = j ~= nil
	local l = k or i >= LARGE_NUMBER_HEALTH_TRIGGER
	if not l then
		return false
	end
	local m = j ~= nil and j.health / math.max(1, j.max) or d:GetHealth_Engine() / math.max(1, d:GetMaxHealth_Engine())
	local h = { max = i, health = math.max(1, math.min(i, i * m)) }
	d.__largeNumberHealth = h
	self:SyncEngineHealth(d)
	return true
end
function LargeNumberHealth.SetHealth(self, d, n)
	local h = d.__largeNumberHealth
	if h == nil then
		return false
	end
	h.health = math.max(0, math.min(h.max, n))
	self:SyncEngineHealth(d)
	return true
end
function LargeNumberHealth.ModifyHealth(self, d, n)
	return self:SetHealth(d, n)
end
function LargeNumberHealth.Clear(self, d)
	if not IsServer() then
		return
	end
	d.__largeNumberHealth = nil
	CustomNetTables:SetTableValue("large_number_health", tostring(d:entindex()), nil)
end
function LargeNumberHealth.SyncEngineHealth(self, d)
	local h = d.__largeNumberHealth
	if h == nil then
		return
	end
	d:SetMaxHealth_Engine(LARGE_NUMBER_HEALTH_PROXY_MAX)
	d:SetBaseMaxHealth_Engine(LARGE_NUMBER_HEALTH_PROXY_MAX)
	local o = h.health <= 0 and 0 or math.max(1, self:ToProxyValue(d, h.health))
	d:SetHealth_Engine(o)
	CustomNetTables:SetTableValue(
		"large_number_health",
		tostring(d:entindex()),
		{ current = h.health, maximum = h.max }
	)
end