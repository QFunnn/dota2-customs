--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "framework/particle_clear"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__New
local g = {}
local h = require("lib.tstl-utils")
local i = h.reloadable
local j = c()
j.name = "CParticleClear"
d(j, CModule)
function j.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.particleCounterByPlayer = {}
	self.maxCountByPlayer = {}
	self.totalCounter = 0
	self.sharedMaxCount = 10
	self.MAX_TOTAL_COUNT = 500
end
function j.prototype.init(self, k)
	if not k then
		self:RefreshMaxCount()
		Timer:GameTimer(1, function()
			self.particleCounterByPlayer = {}
			self.totalCounter = 0
			self:RefreshMaxCount()
			return 1
		end)
	end
end
function j.prototype.RefreshMaxCount(self)
	self.maxCountByPlayer = {}
	local l
	local function m(n, o)
		local p = CustomNetTables:GetTableValue("service", "player_key_values" .. tostring(o))
		local q = 10
		if p ~= nil and p.data ~= nil then
			local r = json.decode(p.data)
			if r ~= nil and r.Setting_ParticleLevel ~= nil then
				local s = toFiniteNumber(r.Setting_ParticleLevel.value)
				q = 10 * math.pow(1.6, s)
			end
		end
		self.maxCountByPlayer[o] = q
		l = l == nil and q or math.min(l, q)
	end
	if IsServer() then
		Game:EachPlayer(m)
	else
		m(nil, GetLocalPlayerID())
	end
	self.sharedMaxCount = l or 10
end
function j.prototype.GetMaxCount(self, o)
	return self.maxCountByPlayer[o] or self.sharedMaxCount or 10
end
function j.prototype.GetCount(self, o)
	return self.particleCounterByPlayer[o] or 0
end
function j.prototype.GetTotalCount(self)
	return self.totalCounter
end
function j.prototype.GetMaxTotalCount(self)
	return self.MAX_TOTAL_COUNT
end
function j.prototype.CanCreate(self, o, t)
	if t == nil then
		t = ParticleEffectLevel.Medium
	end
	if t == ParticleEffectLevel.Low and self:GetMaxCount(o) <= 10 then
		return false
	end
	return self:GetCount(o) < self:GetMaxCount(o) and self.totalCounter < self.MAX_TOTAL_COUNT
end
function j.prototype.Record(self, o)
	self.particleCounterByPlayer[o] = self:GetCount(o) + 1
	self.totalCounter = self.totalCounter + 1
end
j = e({ i }, j)
if ParticleClear == nil then
	ParticleClear = f(j)
end
return g