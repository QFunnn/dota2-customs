--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "modifiers/hunt_boss/modifier_hunt_tide"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ArrayFilter
local g = b.__TS__ArrayMap
local h = b.__TS__ArrayIncludes
local i = b.__TS__NumberToFixed
local j = b.__TS__DecorateLegacy
local k = {}
local l = require("modifiers.eom_modifier.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
local o = "particles/warning/linear.vpcf"
local p = "particles/units/heroes/hero_kunkka/kunkka_shard_tidal_wave.vpcf"
local q = c()
q.name = "modifier_hunt_tide"
d(q, m)
function q.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.lanes = {}
	self.gapIndices = {}
	self.spacing = 0
	self.radius = 0
	self.distance = 0
	self.speed = 0
	self.actualSpeed = 0
	self.remaining = 0
	self.damagePct = 0
	self.heroIndices = {}
	self.generation = 0
	self.phase = "warning"
	self.active = false
	self.ended = false
	self.warnings = {}
	self.bullets = {}
	self.hitHeroes = {}
end
function q.prototype.OnCreated(self, r)
	if not IsServer() then
		return
	end
	self.direction = RandomVector(1)
	self.spacing = r.lane_width
	self.radius = r.wave_radius
	self.speed = r.speed
	self.remaining = r.warning_time
	self.damagePct = r.damage_pct
	self.heroIndices = g(
		f(e(r.hero_entindices, ","), function(s, t)
			return t ~= ""
		end),
		function(s, t)
			return toFiniteNumber(t, -1)
		end
	)
	local u = self:GetParent():GetAbsOrigin()
	local v = self.direction
	local w = math.abs(v.x) * r.field_half_width + math.abs(v.y) * r.field_half_height
	local x = math.abs(v.y) * r.field_half_width + math.abs(v.x) * r.field_half_height
	self.distance = math.max(r.distance, 2 * (w + self.radius))
	local y = math.max(r.lane_count, math.ceil(2 * x / self.spacing) + 1)
	do
		local t = 0
		while t < y do
			local z = (t - (y - 1) / 2) * self.spacing
			local A = u + Vector(-v.y * z, v.x * z, 0)
			local B = self.lanes
			B[#B + 1] = {
				start = A + Vector(-v.x * self.distance / 2, -v.y * self.distance / 2, 0),
				["end"] = A + Vector(v.x * self.distance / 2, v.y * self.distance / 2, 0),
			}
			t = t + 1
		end
	end
	local C = f(
		g(self.lanes, function(s, D, t)
			return t
		end),
		function(s, t)
			return t > 0 and t < y - 1
		end
	)
	local E = GetRandomElement(C)
	local F = GetRandomElement(f(C, function(s, t)
		return math.abs(t - E) > 1
	end))
	self.gapIndices = { E, F }
	self:Trace(
		(
			(
				(
					(
						(
							(
								(
									(
										(
											(
												(
													(
														(
															(
																(
																	(
																		(
																			(
																				"plan waves="
																				.. tostring(
																					#self.lanes - #self.gapIndices
																				)
																			) .. " lanes="
																		) .. tostring(#self.lanes)
																	) .. " gaps="
																)
																.. table.concat(
																	g(self.gapIndices, function(s, t)
																		return t + 1
																	end),
																	","
																)
															) .. " center="
														) .. VectorToString(u)
													) .. " gapWidth="
												) .. tostring(2 * self.spacing - 2 * self.radius)
											) .. " spacing="
										) .. tostring(self.spacing)
									) .. " radius="
								) .. tostring(self.radius)
							) .. " distance="
						) .. tostring(self.distance)
					) .. " direction="
				) .. VectorToString(self.direction)
			) .. " particle="
		) .. p
	)
	self:SetStackCount(1)
	self.active = true
	self:ShowWaves()
	self:StartIntervalThink(0.1)
end
function q.prototype.OnRefresh(self, r)
	if not IsServer() or self.ended then
		return
	end
	self.heroIndices = g(
		f(e(r.hero_entindices, ","), function(s, t)
			return t ~= ""
		end),
		function(s, t)
			return toFiniteNumber(t, -1)
		end
	)
end
function q.prototype.OnStackCountChanged(self)
	if not IsServer() or self.ended then
		return
	end
	self.active = self:GetStackCount() > 0
	if not self.active then
		self:ClearWarnings()
		self:StopBullets()
	end
end
function q.prototype.OnIntervalThink(self)
	if not IsServer() or self.ended or self:GetStackCount() == 0 then
		return
	end
	self.remaining = math.max(0, self.remaining - 0.1)
	if self.phase == "warning" and self.remaining <= 0.0001 then
		self:ClearWarnings()
		self.phase = "wave"
		self.actualSpeed = self.speed * math.max(0.01, Bullet.slowFactor)
		self.remaining = self.distance / self.actualSpeed
	end
	if self.phase == "wave" and self.remaining <= 0.0001 then
		self:Destroy()
		return
	end
	self:ShowWaves()
end
function q.prototype.ShowWaves(self)
	if self.phase == "warning" then
		if #self.warnings > 0 then
			return
		end
		do
			local t = 0
			while t < #self.lanes do
				do
					if h(self.gapIndices, t) then
						goto G
					end
					local H = self.lanes[t + 1]
					local I = ParticleManager:CreateParticle(o, PATTACH_WORLDORIGIN, self:GetParent())
					ParticleManager:SetParticleControl(I, 0, H.start)
					ParticleManager:SetParticleControl(I, 1, H["end"])
					ParticleManager:SetParticleControl(I, 2, Vector(self.radius, self.remaining, 0))
					local J = self.warnings
					J[#J + 1] = I
				end
				::G::
				t = t + 1
			end
		end
		return
	end
	if #self.bullets > 0 then
		return
	end
	local K = self.generation
	local v = self.direction
	local L = math.min(self.distance, self.remaining * self.actualSpeed)
	do
		local t = 0
		while t < #self.lanes do
			do
				if h(self.gapIndices, t) then
					goto M
				end
				local H = self.lanes[t + 1]
				local N = H["end"] + Vector(-v.x * L, -v.y * L, 0)
				local O = false
				local P = Bullet:CreateLinearBullet({
					caster = self:GetParent(),
					spawnOrigin = N,
					direction = v,
					distance = L,
					moveSpeed = self.actualSpeed / math.max(0.01, Bullet.slowFactor),
					radius = self.radius,
					ignoreBlock = true,
					effectName = p,
					teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
					typeFilter = DOTA_UNIT_TARGET_HERO,
					OnBulletCreated = function(Q)
						return self:Trace(
							(
								(
									(
										(
											(
												(
													(
														(
															(
																(
																	(
																		(
																			(
																				("created lane=" .. tostring(t + 1))
																				.. " bullet="
																			)
																			.. tostring(Q.__projIndex)
																		) .. " start="
																	) .. VectorToString(N)
																) .. " end="
															) .. VectorToString(H["end"])
														) .. " distance="
													) .. i(L, 1)
												) .. " speed="
											) .. tostring(Q.moveSpeed)
										) .. " lifetime="
									) .. tostring(Q.__lifeTime)
								) .. " particle="
							) .. tostring(Q.__particleID)
						)
					end,
					OnBulletThink = function(R, Q)
						if O or self:Distance(N, R) < L / 2 then
							return
						end
						O = true
						self:Trace(
							(
								(
									(
										(
											(
												(
													(("moving lane=" .. tostring(t + 1)) .. " bullet=")
													.. tostring(Q.__projIndex)
												) .. " position="
											) .. VectorToString(R)
										) .. " travelled="
									) .. tostring(self:Distance(N, R))
								) .. " remainingTime="
							) .. tostring(Q.__lifeTimeRemaining)
						)
					end,
					OnBulletDestroy = function(Q)
						return self:Trace(
							(
								(
									(
										(
											(
												(
													(
														(
															(
																(
																	(
																		(
																			(
																				("destroyed lane=" .. tostring(t + 1))
																				.. " bullet="
																			)
																			.. tostring(Q.__projIndex)
																		) .. " position="
																	) .. VectorToString(Q.__position)
																) .. " travelled="
															) .. tostring(self:Distance(N, Q.__position))
														) .. " expected="
													) .. tostring(L)
												) .. " remainingTime="
											) .. tostring(Q.__lifeTimeRemaining)
										) .. " active="
									) .. tostring(self.active)
								) .. " ended="
							) .. tostring(self.ended)
						)
					end,
					OnBulletHit = function(S)
						if
							self.ended
							or not self.active
							or K ~= self.generation
							or not IsValid(S)
							or not S:IsAlive()
							or not h(self.heroIndices, S:entindex())
							or self.hitHeroes[S:entindex()]
						then
							return
						end
						self.hitHeroes[S:entindex()] = true
						self:GetParent():DealDamage(
							S,
							nil,
							S:GetMaxHealth() * self.damagePct * 0.01,
							EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
							EOM_DAMAGE_FLAGS.NO_CRIT
								+ EOM_DAMAGE_FLAGS.NO_DAMAGE_AMPLIFY
								+ EOM_DAMAGE_FLAGS.NO_MANA_REGEN
								+ EOM_DAMAGE_FLAGS.NO_INCOMING_AMPLIFY
								+ EOM_DAMAGE_FLAGS.NO_INCOMING_ADJUST
						)
					end,
				})
				if P ~= nil then
					local T = self.bullets
					T[#T + 1] = P
				else
					self:Trace("create failed lane=" .. tostring(t + 1))
				end
			end
			::M::
			t = t + 1
		end
	end
end
function q.prototype.OnDestroy(self)
	if not IsServer() or self.ended then
		return
	end
	self.ended = true
	self:ClearWarnings()
	self:StopBullets()
	self.active = false
	self.heroIndices = {}
	local U = self:GetParent()
	if IsValid(U) then
		Timer:Timer(0, function()
			if IsValid(U) then
				UTIL_Remove(U)
			end
		end)
	end
end
function q.prototype.Trace(self, V)
	print("[HuntTide] " .. V)
end
function q.prototype.Distance(self, W, X)
	return math.sqrt((W.x - X.x) ^ 2 + (W.y - X.y) ^ 2)
end
function q.prototype.ClearWarnings(self)
	for s, I in ipairs(self.warnings) do
		ParticleManager:DestroyParticle(I, true)
		ParticleManager:ReleaseParticleIndex(I)
	end
	self.warnings = {}
end
function q.prototype.StopBullets(self)
	self.generation = self.generation + 1
	local Y = self.bullets
	self.bullets = {}
	for s, P in ipairs(Y) do
		Bullet:DestroyBulletByID(P)
	end
end
function q.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
q = j(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
return k