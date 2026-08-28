--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
	self.MAX_TOTAL_COUNT = 500
end
function j.prototype.init(self, k)
	if not k then
		Timer:GameTimer(1, function()
			self.particleCounterByPlayer = {}
			self.totalCounter = 0
			self:RefreshMaxCount()
			return 1
		end)
	end
end
function j.prototype.RefreshMaxCount(self)
	if not IsServer() then
		return
	end
	self.maxCountByPlayer = {}
	Game:EachPlayer(function(l, m)
		local n = CustomNetTables:GetTableValue("service", "player_key_values" .. tostring(m))
		local o = 420
		if n ~= nil and n.data ~= nil then
			local p = json.decode(n.data)
			if p ~= nil and p.Setting_ParticleLevel ~= nil then
				local q = toFiniteNumber(p.Setting_ParticleLevel.value)
				o = 10 * math.pow(1.6, q)
			end
		end
		self.maxCountByPlayer[m] = o
	end)
end
function j.prototype.GetMaxCount(self, m)
	return self.maxCountByPlayer[m] or 420
end
function j.prototype.GetCount(self, m)
	return self.particleCounterByPlayer[m] or 0
end
function j.prototype.GetTotalCount(self)
	return self.totalCounter
end
function j.prototype.GetMaxTotalCount(self)
	return self.MAX_TOTAL_COUNT
end
function j.prototype.CanCreate(self, m)
	return self:GetCount(m) < self:GetMaxCount(m) and self.totalCounter < self.MAX_TOTAL_COUNT
end
function j.prototype.Record(self, m)
	self.particleCounterByPlayer[m] = self:GetCount(m) + 1
	self.totalCounter = self.totalCounter + 1
end
j = e({ i }, j)
if ParticleClear == nil then
	ParticleClear = f(j)
end
return g