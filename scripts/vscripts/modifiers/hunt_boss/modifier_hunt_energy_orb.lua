--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "modifiers/hunt_boss/modifier_hunt_energy_orb"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ArrayFilter
local g = b.__TS__ArrayMap
local h = b.__TS__ArraySome
local i = b.__TS__ArrayReduce
local j = b.__TS__ArrayIncludes
local k = b.__TS__DecorateLegacy
local l = {}
local m = require("modifiers.eom_modifier.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
local p = c()
p.name = "modifier_hunt_energy_orb"
d(p, n)
function p.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.radius = 0
	self.remaining = 0
	self.damagePct = 0
	self.heroIndices = {}
	self.ended = false
	self.indicators = {}
	self.soundPlaying = false
	self.finishing = false
end
function p.prototype.OnCreated(self, q)
	if not IsServer() then
		return
	end
	self.radius = q.radius
	self.remaining = q.countdown
	self.damagePct = q.damage_pct
	self.heroIndices = g(
		f(e(q.hero_entindices, ","), function(r, s)
			return s ~= ""
		end),
		function(r, s)
			return toFiniteNumber(s, -1)
		end
	)
	self:SetStackCount(1)
	self:ShowVisuals()
	self:StartIntervalThink(0.1)
end
function p.prototype.OnRefresh(self, q)
	if not IsServer() or self.ended then
		return
	end
	self.heroIndices = g(
		f(e(q.hero_entindices, ","), function(r, s)
			return s ~= ""
		end),
		function(r, s)
			return toFiniteNumber(s, -1)
		end
	)
	if not self.finishing and self:GetStackCount() > 0 then
		self:UpdateIndicators()
	end
end
function p.prototype.OnStackCountChanged(self)
	if not IsServer() or self.ended or self:GetStackCount() ~= 0 then
		return
	end
	self:ClearVisuals()
	self:StopStormSound(self:GetParent())
end
function p.prototype.OnIntervalThink(self)
	if not IsServer() or self.finishing or self:GetStackCount() == 0 then
		return
	end
	local t = self:GetParent()
	if not IsValid(t) or not t:IsAlive() then
		self:Finish()
		return
	end
	local u = self:Heroes()
	local v = t:GetAbsOrigin()
	if h(u, function(r, w)
		return self:Distance(v, w:GetAbsOrigin()) <= self.radius
	end) then
		self:Finish()
		return
	end
	self.remaining = math.max(0, self.remaining - 0.1)
	if self.remaining <= 0.0001 then
		self.finishing = true
		local x = i(u, function(r, y, w)
			return math.max(y, self:Distance(v, w:GetAbsOrigin()))
		end, self.radius)
		local z = ParticleManager:CreateParticle(
			"particles/units/benediction/razor_plasmafield.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(z, 0, v)
		ParticleManager:SetParticleControl(z, 1, Vector(x, x, 0))
		local A = false
		Timer:Timer(1, function()
			if not A then
				A = true
				ParticleManager:SetParticleControl(z, 1, Vector(x, 0, 0))
				return 1
			end
			ParticleManager:DestroyParticle(z, true)
			ParticleManager:ReleaseParticleIndex(z)
		end)
		t:EmitSound("Ability.PlasmaField")
		do
			local B, C = pcall(function()
				for r, w in ipairs(u) do
					do
						if self.ended or self:GetStackCount() == 0 or not IsValid(t) then
							break
						end
						if not IsValid(w) or not w:IsAlive() then
							goto D
						end
						t:DealDamage(
							w,
							nil,
							w:GetMaxHealth() * self.damagePct * 0.01,
							EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
							EOM_DAMAGE_FLAGS.NO_CRIT
								+ EOM_DAMAGE_FLAGS.NO_DAMAGE_AMPLIFY
								+ EOM_DAMAGE_FLAGS.NO_MANA_REGEN
								+ EOM_DAMAGE_FLAGS.NO_INCOMING_AMPLIFY
								+ EOM_DAMAGE_FLAGS.NO_INCOMING_ADJUST
						)
					end
					::D::
				end
			end)
			do
				if not self.ended then
					self:Destroy()
				end
			end
			if not B then
				error(C, 0)
			end
		end
		return
	end
	self:ShowVisuals()
end
function p.prototype.ShowVisuals(self)
	local t = self:GetParent()
	local v = t:GetAbsOrigin()
	if self.storm == nil then
		self.storm = ParticleManager:CreateParticle(
			"particles/econ/items/razor/razor_arcana/razor_arcana_eye_of_the_storm_rain.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			t
		)
		t:EmitSound("Hero_Razor.Storm.Loop")
		self.soundPlaying = true
	end
	if self.pickupRing == nil then
		self.pickupRing =
			ParticleManager:CreateParticle("particles/hunt/energy_orb_pickup.vpcf", PATTACH_WORLDORIGIN, t)
		ParticleManager:SetParticleControl(self.pickupRing, 0, v)
		ParticleManager:SetParticleControl(self.pickupRing, 1, Vector(self.radius, 0, 0))
		ParticleManager:SetParticleControl(self.pickupRing, 2, Vector(math.max(0.1, self.remaining), 0, 0))
	end
	self:UpdateIndicators()
end
function p.prototype.Heroes(self)
	return f(
		g(self.heroIndices, function(r, s)
			return EntIndexToHScript(s)
		end),
		function(r, w)
			return IsValid(w) and w:IsAlive() and w:IsRealHero()
		end
	)
end
function p.prototype.UpdateIndicators(self)
	local u = self:Heroes()
	local t = self:GetParent()
	self.indicators = f(self.indicators, function(r, E)
		if j(u, E.hero) then
			return true
		end
		ParticleManager:DestroyParticle(E.particle, true)
		ParticleManager:ReleaseParticleIndex(E.particle)
		return false
	end)
	for r, w in ipairs(u) do
		do
			if h(self.indicators, function(r, E)
				return E.hero == w
			end) then
				goto F
			end
			local G = w:GetPlayerOwner()
			if not IsValid(G) then
				goto F
			end
			local H = ParticleManager:CreateParticleForPlayer(
				"particles/generic_gameplay/arrow_prompt/arrow_prompt.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				G
			)
			ParticleManager:SetParticleControlEnt(H, 0, w, PATTACH_ABSORIGIN_FOLLOW, "", w:GetAbsOrigin(), false)
			ParticleManager:SetParticleControlEnt(H, 1, t, PATTACH_ABSORIGIN_FOLLOW, "", t:GetAbsOrigin(), false)
			local I = self.indicators
			I[#I + 1] = { hero = w, particle = H }
		end
		::F::
	end
end
function p.prototype.OnDestroy(self)
	if not IsServer() or self.ended then
		return
	end
	self.ended = true
	self.finishing = true
	self:ClearVisuals()
	self:StopStormSound(self:GetParent())
	self.heroIndices = {}
	local t = self:GetParent()
	if IsValid(t) then
		Timer:Timer(0, function()
			if IsValid(t) then
				UTIL_Remove(t)
			end
		end)
	end
end
function p.prototype.Finish(self)
	if self.finishing then
		return
	end
	self.finishing = true
	self:Destroy()
end
function p.prototype.Distance(self, J, K)
	return math.sqrt((J.x - K.x) ^ 2 + (J.y - K.y) ^ 2)
end
function p.prototype.ClearVisuals(self)
	for r, H in ipairs({ self.storm, self.pickupRing, unpack(g(self.indicators, function(r, E)
		return E.particle
	end)) }) do
		do
			if H == nil then
				goto L
			end
			ParticleManager:DestroyParticle(H, true)
			ParticleManager:ReleaseParticleIndex(H)
		end
		::L::
	end
	self.storm = nil
	self.pickupRing = nil
	self.indicators = {}
end
function p.prototype.StopStormSound(self, t)
	if not self.soundPlaying or not IsValid(t) then
		return
	end
	t:StopSound("Hero_Razor.Storm.Loop")
	self.soundPlaying = false
end
function p.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
p = k(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
return l