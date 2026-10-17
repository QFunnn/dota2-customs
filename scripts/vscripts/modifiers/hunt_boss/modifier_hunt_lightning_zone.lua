--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "modifiers/hunt_boss/modifier_hunt_lightning_zone"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ArrayMap
local g = b.__TS__ArrayFilter
local h = b.__TS__ArraySome
local i = b.__TS__DecorateLegacy
local j = {}
local k = require("modifiers.eom_modifier.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = c()
n.name = "modifier_hunt_lightning_zone"
d(n, l)
function n.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.radius = 0
	self.remaining = 0
	self.tickRemaining = 0
	self.interval = 0
	self.damagePct = 0
	self.tickDamagePct = 0
	self.struck = false
	self.ended = false
	self.positions = {}
	self.heroIndices = {}
	self.particles = {}
end
function n.prototype.OnCreated(self, o)
	if not IsServer() then
		return
	end
	self.radius = o.radius
	self.remaining = o.lifetime
	self.interval = math.max(0.1, o.tick_interval)
	self.tickRemaining = self.interval
	self.damagePct = o.damage_pct
	self.tickDamagePct = o.tick_damage_pct
	self.positions = f(e(o.positions, ";"), function(p, q)
		local r = f(e(q, ","), function(p, s)
			return toFiniteNumber(s, 0)
		end)
		return Vector(r[1], r[2], r[3])
	end)
	self.heroIndices = f(
		g(e(o.hero_entindices, ","), function(p, t)
			return t ~= ""
		end),
		function(p, t)
			return toFiniteNumber(t, -1)
		end
	)
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end
function n.prototype.OnRefresh(self, o)
	if not IsServer() or self.ended then
		return
	end
	self.heroIndices = f(
		g(e(o.hero_entindices, ","), function(p, t)
			return t ~= ""
		end),
		function(p, t)
			return toFiniteNumber(t, -1)
		end
	)
end
function n.prototype.OnStackCountChanged(self)
	if IsServer() and not self.ended and self:GetStackCount() == 0 then
		self:ClearParticles()
	end
end
function n.prototype.OnIntervalThink(self)
	if not IsServer() or self.ended or self:GetStackCount() == 0 then
		return
	end
	if not self.struck then
		self.struck = true
		self:Strike()
		self:ShowZones()
		self:Damage(self.damagePct)
		return
	end
	self.remaining = math.max(0, self.remaining - 0.1)
	if self.remaining <= 0.0001 then
		self:Destroy()
		return
	end
	self:ShowZones()
	self.tickRemaining = self.tickRemaining - 0.1
	if self.tickRemaining <= 0.0001 then
		self.tickRemaining = self.tickRemaining + self.interval
		self:Damage(self.tickDamagePct)
	end
end
function n.prototype.Strike(self)
	local u = self:GetParent()
	for p, v in ipairs(self.positions) do
		local w =
			ParticleManager:CreateParticle("particles/abilities/zuus_thundergods_wrath.vpcf", PATTACH_WORLDORIGIN, u)
		ParticleManager:SetParticleControl(w, 0, v + Vector(0, 0, 900))
		ParticleManager:SetParticleControl(w, 1, v)
		ParticleManager:ReleaseParticleIndex(w)
		local x = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_zuus/zuus_lightning_bolt_aoe.vpcf",
			PATTACH_WORLDORIGIN,
			u
		)
		ParticleManager:SetParticleControl(x, 0, v)
		ParticleManager:SetParticleControl(x, 1, Vector(self.radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(x)
	end
	u:EmitSound("Hero_Zuus.LightningBolt")
end
function n.prototype.ShowZones(self)
	if #self.particles > 0 then
		return
	end
	for p, v in ipairs(self.positions) do
		local y = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_disruptor/disruptor_static_storm.vpcf",
			PATTACH_WORLDORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(y, 0, v)
		ParticleManager:SetParticleControl(y, 1, Vector(self.radius, 0, 0))
		ParticleManager:SetParticleControl(y, 2, Vector(self.remaining, 0, 0))
		local z = self.particles
		z[#z + 1] = y
	end
end
function n.prototype.Damage(self, A)
	local u = self:GetParent()
	for p, t in ipairs(self.heroIndices) do
		do
			if self.ended or self:GetStackCount() == 0 or not IsValid(u) then
				break
			end
			local B = EntIndexToHScript(t)
			if
				not IsValid(B)
				or not B:IsAlive()
				or not B:IsRealHero()
				or not h(self.positions, function(p, v)
					return CalcDistance(v, B:GetAbsOrigin()) <= self.radius
				end)
			then
				goto C
			end
			u:DealDamage(
				B,
				nil,
				B:GetMaxHealth() * A * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
				EOM_DAMAGE_FLAGS.NO_CRIT
					+ EOM_DAMAGE_FLAGS.NO_DAMAGE_AMPLIFY
					+ EOM_DAMAGE_FLAGS.NO_MANA_REGEN
					+ EOM_DAMAGE_FLAGS.NO_INCOMING_AMPLIFY
					+ EOM_DAMAGE_FLAGS.NO_INCOMING_ADJUST
			)
		end
		::C::
	end
end
function n.prototype.OnDestroy(self)
	if not IsServer() or self.ended then
		return
	end
	self.ended = true
	self:ClearParticles()
	self.heroIndices = {}
	self.positions = {}
	local u = self:GetParent()
	if IsValid(u) then
		Timer:Timer(0, function()
			if IsValid(u) then
				UTIL_Remove(u)
			end
		end)
	end
end
function n.prototype.ClearParticles(self)
	local D = self.particles
	self.particles = {}
	for p, y in ipairs(D) do
		ParticleManager:DestroyParticle(y, true)
		ParticleManager:ReleaseParticleIndex(y)
	end
end
function n.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
n = i(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	n
)
return j