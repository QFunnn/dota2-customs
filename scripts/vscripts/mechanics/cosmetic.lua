--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/cosmetic"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__DecorateLegacy
local g = b.__TS__New
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = {
	COSMETIC_TYPE.ATTACK_EFFECT,
	COSMETIC_TYPE.SPECIAL_SKILL_EFFECT,
	COSMETIC_TYPE.DASH_SKILL_EFFECT,
	COSMETIC_TYPE.DEFENSE_SKILL_EFFECT,
	COSMETIC_TYPE.ULTIMATE_SKILL_EFFECT,
}
local l = {
	[COSMETIC_TYPE.ATTACK_EFFECT] = true,
	[COSMETIC_TYPE.SPECIAL_SKILL_EFFECT] = true,
	[COSMETIC_TYPE.DASH_SKILL_EFFECT] = true,
	[COSMETIC_TYPE.DEFENSE_SKILL_EFFECT] = true,
	[COSMETIC_TYPE.ULTIMATE_SKILL_EFFECT] = true,
}
local m = c()
m.name = "CCosmetic"
d(m, CModule)
function m.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.kv = {}
	self.unitParticleReplacements = {}
end
function m.prototype.init(self, n)
	if not n then
	end
	self.kv = LoadKeyValues("scripts/npc/cosmetic.txt")
end
function m.prototype.GetKv(self, o)
	return self.kv[o]
end
function m.prototype.IsParticleReplaceCosmeticType(self, p)
	return l[p] == true
end
function m.prototype.RegisterParticleReplacements(self, q, p, o)
	if not IsServer() or not self:IsParticleReplaceCosmeticType(p) then
		return
	end
	if q.__cosmeticParticleReplacementsByType == nil then
		q.__cosmeticParticleReplacementsByType = {}
	end
	local r = self:GetKv(o)
	local s = r and r.particle
	if s ~= nil then
		q.__cosmeticParticleReplacementsByType[p] = s
	else
		e(q.__cosmeticParticleReplacementsByType, p)
	end
	self:SyncParticleReplacements(q)
end
function m.prototype.UnregisterParticleReplacements(self, q, p)
	if not IsServer() or not self:IsParticleReplaceCosmeticType(p) then
		return
	end
	if q.__cosmeticParticleReplacementsByType ~= nil then
		e(q.__cosmeticParticleReplacementsByType, p)
	end
	self:SyncParticleReplacements(q)
end
function m.prototype.GetParticleReplacement(self, q, t)
	if not IsValid(q) or q.entindex == nil then
		return t
	end
	local u = tostring(q:entindex())
	local v
	if IsServer() then
		v = self.unitParticleReplacements[u]
	else
		local w = CustomNetTables:GetNetData("cosmetic_particle_replace", u)
		v = w and w.particles
	end
	local x = v
	return x and x[t] or t
end
function m.prototype.SyncParticleReplacements(self, q)
	local u = tostring(q:entindex())
	local s = {}
	for y, p in ipairs(k) do
		local z = q.__cosmeticParticleReplacementsByType
		local x = z and z[p]
		if x ~= nil then
			for A, B in pairs(x) do
				s[A] = B
			end
		end
	end
	if next(s) == nil then
		e(self.unitParticleReplacements, u)
		CustomNetTables:SetNetData("cosmetic_particle_replace", u, nil)
		return
	end
	self.unitParticleReplacements[u] = s
	CustomNetTables:SetNetData("cosmetic_particle_replace", u, { particles = s })
end
m = f({ j }, m)
if Cosmetic == nil then
	Cosmetic = g(m)
end
return h