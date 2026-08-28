--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_ice_vortex_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = 275
local k = c()
k.name = "modifier_ice_vortex_custom"
d(k, h)
function k.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.radius = j
	self.hasDealtDamage = false
end
function k.prototype.OnCreated(self, l)
	self.radius = l.radius or j
	if IsServer() then
		self.damage = l.damage
		self.frozen = l.frozen
		self.entIndex = l.entIndex
		self:SetStackCount(self.radius)
		local m = self:GetCaster()
		if IsValid(m) then
			if m.__iceVortexThinkers == nil then
				m.__iceVortexThinkers = {}
			end
			local n = m.__iceVortexThinkers
			n[#n + 1] = self:GetParent()
		end
		self:StartIntervalThink(1)
	else
		self:CreateParticle()
	end
end
function k.prototype.OnStackCountChanged(self)
	if IsClient() then
		self.radius = self:GetStackCount()
		if self.particleID ~= nil then
			ParticleManager:SetParticleControl(self.particleID, 1, Vector(self.radius, 0, 0))
		end
	end
end
function k.prototype.CreateParticle(self)
	self.radius = self:GetStackCount() or self.radius
	self.particleID = ParticleManager:CreateParticle(
		"particles/units/benediction/ancient_ice_vortex.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.particleID, 1, Vector(self.radius, 0, 0))
	self:AddParticle(self.particleID, false, false, -1, false, false)
end
function k.prototype.CanMerge(self, o)
	return not self.hasDealtDamage and (o - self:GetParent():GetAbsOrigin()):Length2D() <= self.radius
end
function k.prototype.Merge(self, o, p, q, r, s)
	if s == nil then
		s = j
	end
	local t = self:GetParent():GetAbsOrigin()
	local u = o - t
	local v = u:Length2D()
	if v + s > self.radius then
		if v + self.radius <= s then
			self:GetParent():SetAbsOrigin(o)
			self.radius = s
		elseif v > 0 then
			local w = (v + self.radius + s) * 0.5
			local x = u * (w - self.radius) / v
			self:GetParent():SetAbsOrigin(t + x)
			self.radius = w
		end
	end
	self.damage = self.damage + p
	self.frozen = self.frozen + q
	self:SetStackCount(self.radius)
	self:SetDuration(math.max(self:GetRemainingTime(), r), true)
end
function k.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local m = self:GetCaster()
	if IsValid(m) and m.__iceVortexThinkers ~= nil then
		ArrayRemove(m.__iceVortexThinkers, self:GetParent())
	end
	local y = self:GetParent()
	if IsValid(y) then
		Timer:GameTimer(0, function()
			if IsValid(y) then
				y:RemoveSelf()
			end
		end)
	end
end
function k.prototype.OnIntervalThink(self)
	local m = self:GetCaster()
	if IsValid(m) then
		local z = FindUnitsInRadius(
			m:GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			nil,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		if #z > 0 then
			self.hasDealtDamage = true
		end
		for A, B in ipairs(z) do
			m:Frozen(B, self.frozen)
			m:DealDamage(B, nil, self.damage)
		end
	end
end
k = e(
	{ i(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	k
)
return f