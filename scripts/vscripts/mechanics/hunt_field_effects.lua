--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "mechanics/hunt_field_effects"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayMap
local e = b.__TS__ArrayEvery
local f = b.__TS__ArrayIncludes
local g = b.__TS__ArrayFilter
local h = b.__TS__NumberToFixed
local i = {}
local j = 0.1
local k = "particles/warning/circular.vpcf"
i.CHuntFieldEffects = c()
local l = i.CHuntFieldEffects
l.name = "CHuntFieldEffects"
function l.prototype.____constructor(self, m, n)
	self.elapsed = 0
	self.paused = true
	self.disposed = false
	self.stopped = false
	self.debugTimes = {}
	self.context = n
	self.effects = d(m, function(o, p)
		return { config = p, nextAt = p.time, expiresAt = 0, tickAt = 0, phase = "waiting", particles = {}, marks = {}, bombs = {} }
	end)
	self.killListener = GameEvent("entity_killed", function(q)
		for o, r in ipairs(self.effects) do
			if IsValid(r.unit) and r.unit:entindex() == q.entindex_killed then
				self:EndInstance(r)
			end
		end
	end)
	self.timer = Timer:GameTimer(j, function()
		if self.disposed then
			return
		end
		local s = self:Enemies()
		if not self.paused and #s > 0 then
			self.elapsed = self.elapsed + j
			for o, r in ipairs(self.effects) do
				if self.disposed then
					return
				end
				if not self.stopped and r.phase == "waiting" and self.elapsed >= r.nextAt then
					self:SpawnInstance(r)
				end
				if r.phase ~= "waiting" then
					self:UpdateInstance(r)
				end
			end
		else
			for o, r in ipairs(self.effects) do
				self:SetHunterWarningAnimation(r, false)
				if IsValid(r.lightningZone) then
					local t = r.lightningZone:FindModifierByName("modifier_hunt_lightning_zone")
					if t ~= nil then
						t:SetStackCount(0)
					end
				end
				if IsValid(r.energyOrb) then
					local u = r.energyOrb:FindModifierByName("modifier_hunt_energy_orb")
					if u ~= nil then
						u:SetStackCount(0)
					end
				end
				if IsValid(r.tide) then
					local v = r.tide:FindModifierByName("modifier_hunt_tide")
					if v ~= nil then
						v:SetStackCount(0)
					end
				end
			end
		end
		if self.stopped and e(self.effects, function(o, r)
			return r.phase == "waiting"
		end) then
			self:Dispose()
			return
		end
		return j
	end)
end
function l.prototype.SetPaused(self, w)
	self.paused = w
	if w then
		for o, r in ipairs(self.effects) do
			if IsValid(r.lightningZone) then
				local x = r.lightningZone:FindModifierByName("modifier_hunt_lightning_zone")
				if x ~= nil then
					x:SetStackCount(0)
				end
			end
			if IsValid(r.energyOrb) then
				local y = r.energyOrb:FindModifierByName("modifier_hunt_energy_orb")
				if y ~= nil then
					y:SetStackCount(0)
				end
			end
			if IsValid(r.tide) then
				local z = r.tide:FindModifierByName("modifier_hunt_tide")
				if z ~= nil then
					z:SetStackCount(0)
				end
			end
			if IsValid(r.unit) then
				r.unit:Stop()
			end
			self:SetHunterWarningAnimation(r, false)
			if r.warning ~= nil then
				self:RemoveParticle(r, r.warning)
				r.warning = nil
			end
			if f({ "lightning", "immortal_totem" }, r.config.id) then
				self:ClearParticles(r)
			end
		end
	end
end
function l.prototype.Stop(self)
	if self.disposed or self.stopped then
		return
	end
	self.stopped = true
	self:Debug("future triggers disabled; current round will finish")
	if e(self.effects, function(o, r)
		return r.phase == "waiting"
	end) then
		self:Dispose()
	end
end
function l.prototype.IsDisposed(self)
	return self.disposed
end
function l.prototype.Dispose(self)
	if self.disposed then
		return
	end
	self:Debug("controller disposed")
	self.disposed = true
	if self.timer ~= nil then
		Timer:StopTimer(self.timer)
	end
	if self.killListener ~= nil then
		StopGameEvent(self.killListener)
	end
	for o, r in ipairs(self.effects) do
		self:EndInstance(r)
	end
end
function l.Supports(self, A)
	return f({ "immortal_totem", "healing_totem", "hunter", "siphon", "energy_orb", "lightning" }, A)
end
function l.prototype.Heroes(self)
	return g(self.context:heroes(), function(o, B)
		return IsValid(B) and B:IsAlive()
	end)
end
function l.prototype.Enemies(self)
	return g(self.context:enemies(), function(o, C)
		return IsValid(C) and C:IsAlive()
	end)
end
function l.prototype.FindPosition(self, D)
	if D == nil then
		D = 240
	end
	return GetRandomElement(g(self.context.validGridPositions, function(o, E)
		return GridNav:IsValidPosition(E) and self:Distance(E, self.context.center) >= D
	end))
end
function l.prototype.Debug(self, F, G)
	if self.context.debugLog == nil then
		return
	end
	if G ~= nil then
		local H = GameRules:GetGameTime()
		if H < (self.debugTimes[G] or -1) then
			return
		end
		self.debugTimes[G] = H + 5
	end
	self.context:debugLog((("elapsed=" .. h(self.elapsed, 1)) .. " ") .. F)
end
function l.prototype.SpawnInstance(self, r)
	local I = r.config.params
	if r.config.id == "immortal_totem" then
		r.phase = "active"
		r.expiresAt = self.elapsed + I.Duration
		r.tickAt = self.elapsed
		return
	end
	if r.config.id == "healing_totem" then
		local J = self.context.center
		local K = 0
		local L = 0
		for o, E in ipairs(self.context.validGridPositions) do
			K = math.max(K, math.abs(E.x - J.x))
			L = math.max(L, math.abs(E.y - J.y))
		end
		local M = self:Enemies()[1]
		if not IsValid(M) then
			return
		end
		local N = CreateModifierThinker(
			M,
			nil,
			"modifier_hunt_tide",
			{
				lane_count = I.LaneCount,
				lane_width = I.LaneWidth,
				wave_radius = I.WaveRadius,
				distance = I.Distance,
				speed = I.Speed,
				warning_time = I.WarningTime,
				damage_pct = I.DamagePct,
				field_half_width = K + GRID_SIZE / 2,
				field_half_height = L + GRID_SIZE / 2,
				hero_entindices = self:HeroIndices(),
			},
			J,
			M:GetTeamNumber(),
			false
		)
		local O
		if IsValid(N) then
			O = N:FindModifierByName("modifier_hunt_tide")
		else
			O = nil
		end
		local P = O
		if not IsValid(P) then
			if IsValid(N) then
				UTIL_Remove(N)
			end
			r.nextAt = self.elapsed + 0.5
			self:Debug("id=healing_totem failed to create tide thinker")
			return
		end
		r.tide = N
		r.phase = "active"
		return
	end
	if r.config.id == "lightning" then
		r.marks = d(self:Heroes(), function(o, B)
			return { hero = B, position = B:GetAbsOrigin() }
		end)
		if #r.marks == 0 then
			r.nextAt = self.elapsed + I.Interval
			return
		end
		r.phase = "tracking"
		r.expiresAt = self.elapsed + I.TrackTime
		return
	end
	if r.config.id == "siphon" then
		local Q = self:RandomHero()
		if Q == nil then
			r.nextAt = self.elapsed + 0.5
			return
		end
		local R = Q:GetAbsOrigin()
		local S = Vector(R.x, R.y, R.z)
		local T = CreateUnitByName("npc_hunt_field_auxiliary", S, false, nil, nil, DOTA_TEAM_BADGUYS)
		if not IsValid(T) then
			self:Debug("id=siphon spawn failed at hero position")
			r.nextAt = self.elapsed + 0.5
			return
		end
		T:AddNewModifier(T, nil, "modifier_hunt_field_unit", {})
		r.unit = T
		r.target = Q
		r.phase = "active"
		r.initialized = false
		r.expiresAt = self.elapsed + I.Duration
		r.tickAt = self.elapsed + I.TickInterval
		T:SetRenderColor(180, 80, 255)
		self:Debug(
			(
				(
					(
						(
							(("id=siphon spawned unit=" .. tostring(T:entindex())) .. " target=")
							.. tostring(Q:entindex())
						) .. " position="
					) .. VectorToString(S)
				) .. " lifetime="
			) .. tostring(I.Duration)
		)
		return
	end
	if r.config.id == "energy_orb" then
		local S = self:FindPosition()
		if S == nil then
			self:Debug("id=energy_orb spawn blocked: no valid grid at least 240 from center", "energy_orb:position")
			r.nextAt = self.elapsed + 0.5
			return
		end
		local M = self:Enemies()[1]
		if not IsValid(M) then
			r.nextAt = self.elapsed + 0.5
			return
		end
		local N = CreateModifierThinker(
			M,
			nil,
			"modifier_hunt_energy_orb",
			{ radius = I.PickupRadius, countdown = I.Countdown, damage_pct = I.DamagePct, hero_entindices = self:HeroIndices() },
			S,
			M:GetTeamNumber(),
			false
		)
		local U
		if IsValid(N) then
			U = N:FindModifierByName("modifier_hunt_energy_orb")
		else
			U = nil
		end
		local V = U
		if not IsValid(V) then
			if IsValid(N) then
				UTIL_Remove(N)
			end
			r.nextAt = self.elapsed + 0.5
			self:Debug("id=energy_orb spawn failed: thinker modifier unavailable")
			return
		end
		r.energyOrb = N
		r.phase = "active"
		self:Debug(
			(
				(
					(
						(
							(("id=energy_orb spawned thinker=" .. tostring(N:entindex())) .. " position=")
							.. VectorToString(S)
						) .. " pickupRadius="
					) .. tostring(I.PickupRadius)
				) .. " countdown="
			) .. tostring(I.Countdown)
		)
		return
	end
	local S = self:FindPosition()
	if S == nil then
		self:Debug(
			("id=" .. r.config.id) .. " spawn blocked: no valid grid at least 240 from center",
			r.config.id .. ":position"
		)
		r.nextAt = self.elapsed + 0.5
		return
	end
	local W = r.config.id == "hunter" and "npc_hunt_field_hunter" or "npc_hunt_field_auxiliary"
	local T = CreateUnitByName(W, S, false, nil, nil, DOTA_TEAM_BADGUYS)
	if not IsValid(T) then
		self:Debug(
			(((("id=" .. r.config.id) .. " spawn failed: CreateUnitByName name=") .. W) .. " position=")
				.. VectorToString(S),
			r.config.id .. ":create"
		)
		r.nextAt = self.elapsed + 0.5
		return
	end
	r.unit = T
	r.phase = "active"
	r.initialized = false
	r.expiresAt = self.elapsed + (I.Lifetime or I.Duration or I.Countdown or 0)
	r.tickAt = self.elapsed + (I.TickInterval or 1)
	self:Debug(
		(
			(
				(((("id=" .. r.config.id) .. " spawned unit=") .. tostring(T:entindex())) .. " position=")
				.. VectorToString(S)
			) .. " lifetime="
		) .. tostring(r.expiresAt - self.elapsed)
	)
	if r.config.id == "hunter" then
		T:SetBaseMoveSpeed(I.MoveSpeed)
		T:SetRenderColor(255, 80, 80)
	else
		T:SetRenderColor(255, 220, 80)
	end
end
function l.prototype.UpdateInstance(self, r)
	if r.config.id == "energy_orb" or r.config.id == "healing_totem" then
		local X
		if r.config.id == "energy_orb" then
			X = r.energyOrb
		else
			X = r.tide
		end
		local N = X
		local Y = r.config.id == "energy_orb" and "modifier_hunt_energy_orb" or "modifier_hunt_tide"
		self:UpdateThinker(r, N, Y)
		return
	end
	if r.config.id == "lightning" then
		self:UpdateLightning(r)
		return
	end
	if r.config.id == "immortal_totem" then
		self:UpdateBombardment(r)
		return
	end
	local T = r.unit
	if not IsValid(T) or not T:IsAlive() then
		self:EndInstance(r)
		return
	end
	if not r.initialized then
		if not T:HasModifier("modifier_common") then
			self:Debug(
				(("id=" .. r.config.id) .. " waiting for modifier_common unit=") .. tostring(T:entindex()),
				r.config.id .. ":init"
			)
			return
		end
		r.initialized = true
		self:Debug((("id=" .. r.config.id) .. " initialized unit=") .. tostring(T:entindex()))
	end
	local I = r.config.params
	repeat
		local Z = r.config.id
		local _ = Z == "hunter"
		if _ then
			self:UpdateHunter(r, T)
			break
		end
		_ = _ or Z == "siphon"
		if _ then
			do
				local Q = r.target
				if
					Q == nil
					or not f(self:Heroes(), Q)
					or self:Distance(T:GetAbsOrigin(), Q:GetAbsOrigin()) >= I.BreakDistance
					or self.elapsed >= r.expiresAt
				then
					self:EndInstance(r)
					return
				end
				if #r.particles == 0 then
					self:AddParticle(r, "particles/units/heroes/hero_pugna/pugna_life_drain.vpcf", T:GetAbsOrigin())
				end
				ParticleManager:SetParticleControl(r.particles[1], 0, T:GetAbsOrigin())
				ParticleManager:SetParticleControl(r.particles[1], 1, Q:GetAbsOrigin())
				if self.elapsed >= r.tickAt then
					r.tickAt = r.tickAt + I.TickInterval
					self:Damage(T, { Q }, I.DamagePct)
					if not self.disposed and r.phase ~= "waiting" then
						self:HealEnemies(I.HealPct)
					end
				end
				break
			end
		end
	until true
end
function l.prototype.Explode(self, r, T, a0, a1)
	T:EmitSound("Hero_LifeStealer.Consume")
	local a2 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_explode.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		T
	)
	ParticleManager:SetParticleControl(a2, 1, Vector(a1, a1, a1))
	ParticleManager:ReleaseParticleIndex(a2)
	self:EndInstance(r, "kill")
	self:Damage(T, a0, r.config.params.DamagePct)
end
function l.prototype.UpdateHunter(self, r, T)
	local I = r.config.params
	if r.phase == "warning" then
		self:SetHunterWarningAnimation(r, true)
		if r.warning == nil then
			r.warning = self:Warning(r, T:GetAbsOrigin(), I.BlastRadius, r.tickAt - self.elapsed)
		end
		if self.elapsed >= r.tickAt then
			local a0 = g(self:Heroes(), function(o, B)
				return self:Distance(T:GetAbsOrigin(), B:GetAbsOrigin()) <= I.BlastRadius
			end)
			self:Debug(
				(
					((("id=hunter explode targets=" .. tostring(#a0)) .. " radius=") .. tostring(I.BlastRadius))
					.. " damagePct="
				) .. tostring(I.DamagePct)
			)
			self:Explode(r, T, a0, I.BlastRadius)
		end
		return
	end
	if self.elapsed >= r.expiresAt then
		self:Debug("id=hunter ended: lifetime expired phase=" .. r.phase)
		self:EndInstance(r)
		return
	end
	if r.target == nil or not f(self:Heroes(), r.target) then
		r.target = self:RandomHero()
	end
	if r.target == nil then
		self:Debug("id=hunter ended: no alive hero")
		self:EndInstance(r)
		return
	end
	if self:Distance(T:GetAbsOrigin(), r.target:GetAbsOrigin()) <= I.TriggerDistance then
		self:Debug(
			(
				(
					(("id=hunter warning target=" .. tostring(r.target:entindex())) .. " warningTime=")
					.. tostring(I.WarningTime)
				) .. " lifetimeRemaining="
			) .. tostring(r.expiresAt - self.elapsed)
		)
		T:Stop()
		r.phase = "warning"
		r.tickAt = self.elapsed + I.WarningTime
		self:SetHunterWarningAnimation(r, true)
	else
		T:MoveToPosition(r.target:GetAbsOrigin())
	end
end
function l.prototype.SetHunterWarningAnimation(self, r, a3)
	local a4 = r.config.id ~= "hunter"
	if not a4 then
		local a5 = r.hunterWarningAnimating
		if a5 == nil then
			a5 = false
		end
		a4 = a5 == a3
	end
	if a4 then
		return
	end
	local T = r.unit
	if IsValid(T) then
		if a3 then
			T:StartGesture(ACT_DOTA_CHANNEL_ABILITY_4)
		else
			T:FadeGesture(ACT_DOTA_CHANNEL_ABILITY_4)
		end
	end
	r.hunterWarningAnimating = a3
end
function l.prototype.UpdateLightning(self, r)
	local I = r.config.params
	if r.phase == "tracking" then
		r.marks = g(r.marks, function(o, a6)
			return f(self:Heroes(), a6.hero)
		end)
		if #r.marks == 0 then
			self:EndInstance(r)
			return
		end
		for o, a6 in ipairs(r.marks) do
			local S = a6.hero:GetAbsOrigin()
			a6.position = Vector(S.x, S.y, S.z)
		end
		if #r.particles ~= #r.marks then
			self:ClearParticles(r)
			for o, a6 in ipairs(r.marks) do
				self:Warning(r, a6.position, I.Radius, math.max(j, r.expiresAt - self.elapsed))
			end
		end
		do
			local a7 = 0
			while a7 < #r.marks do
				ParticleManager:SetParticleControl(r.particles[a7 + 1], 0, r.marks[a7 + 1].position)
				ParticleManager:SetParticleControl(r.particles[a7 + 1], 1, r.marks[a7 + 1].position)
				a7 = a7 + 1
			end
		end
		if self.elapsed >= r.expiresAt then
			self:ClearParticles(r)
			r.phase = "warning"
			r.expiresAt = self.elapsed + I.WarningTime
		end
		return
	end
	if r.phase == "warning" then
		if #r.particles == 0 then
			for o, a6 in ipairs(r.marks) do
				self:Warning(r, a6.position, I.Radius, math.max(j, r.expiresAt - self.elapsed))
			end
		end
		if self.elapsed < r.expiresAt then
			return
		end
		self:ClearParticles(r)
		local M = self:Enemies()[1]
		if not IsValid(M) then
			return
		end
		local N = CreateModifierThinker(
			M,
			nil,
			"modifier_hunt_lightning_zone",
			{
				radius = I.Radius,
				lifetime = I.Duration,
				tick_interval = I.TickInterval,
				damage_pct = I.DamagePct,
				tick_damage_pct = I.TickDamagePct,
				positions = table.concat(
					d(r.marks, function(o, a6)
						return table.concat({ a6.position.x, a6.position.y, a6.position.z }, ",")
					end),
					";"
				),
				hero_entindices = self:HeroIndices(),
			},
			r.marks[1].position,
			M:GetTeamNumber(),
			false
		)
		if not IsValid(N) or not IsValid(N:FindModifierByName("modifier_hunt_lightning_zone")) then
			if IsValid(N) then
				UTIL_Remove(N)
			end
			self:Debug("id=lightning failed to create zone thinker")
			self:EndInstance(r)
			return
		end
		r.lightningZone = N
		r.phase = "zone"
		self:Debug((("id=lightning strike marks=" .. tostring(#r.marks)) .. " duration=") .. tostring(I.Duration))
		return
	end
	if r.phase == "zone" then
		self:UpdateThinker(r, r.lightningZone, "modifier_hunt_lightning_zone")
	end
end
function l.prototype.HeroIndices(self)
	return table.concat(
		d(
			g(self.context:heroes(), function(o, B)
				return IsValid(B)
			end),
			function(o, B)
				return B:entindex()
			end
		),
		","
	)
end
function l.prototype.UpdateThinker(self, r, N, Y)
	local a8
	if IsValid(N) then
		a8 = N:FindModifierByName(Y)
	else
		a8 = nil
	end
	local V = a8
	if not IsValid(V) then
		self:EndInstance(r)
	else
		local a9 = self:HeroIndices()
		if a9 ~= r.heroIndices then
			r.heroIndices = a9
			local aa = V:GetCaster()
			N:AddNewModifier(IsValid(aa) and aa or nil, nil, Y, { hero_entindices = a9 })
		end
		if V:GetStackCount() == 0 then
			V:SetStackCount(1)
		end
	end
end
function l.prototype.UpdateBombardment(self, r)
	local I = r.config.params
	if self.elapsed < r.expiresAt and self.elapsed >= r.tickAt then
		local S = self:FindPosition(0)
		if S ~= nil then
			r.tickAt = r.tickAt + I.BombInterval
			local ab = r.bombs
			ab[#ab + 1] = { position = S, explodeAt = self.elapsed + I.WarningTime }
		else
			r.tickAt = self.elapsed + 0.5
		end
	end
	local ac = {}
	for o, ad in ipairs(r.bombs) do
		if self.elapsed >= ad.explodeAt then
			if ad.particle ~= nil then
				self:RemoveParticle(r, ad.particle)
			end
			local ae = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_techies/techies_blast_off.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(ae, 0, ad.position)
			ParticleManager:SetParticleControl(ae, 1, Vector(I.Radius, 0, 1))
			ParticleManager:SetParticleControl(ae, 2, Vector(I.Radius, 0, 1))
			ParticleManager:ReleaseParticleIndex(ae)
			self:Damage(
				self:Enemies()[1],
				g(self:Heroes(), function(o, B)
					return self:Distance(ad.position, B:GetAbsOrigin()) <= I.Radius
				end),
				I.DamagePct
			)
			if self.disposed then
				return
			end
		else
			if ad.particle == nil then
				ad.particle = self:Warning(r, ad.position, I.Radius, ad.explodeAt - self.elapsed)
			end
			ac[#ac + 1] = ad
		end
	end
	r.bombs = ac
	if self.elapsed >= r.expiresAt and #r.bombs == 0 then
		self:EndInstance(r)
	end
end
function l.prototype.RandomHero(self, S, af)
	local a0 = g(self:Heroes(), function(o, B)
		return S == nil or af == nil or self:Distance(S, B:GetAbsOrigin()) <= af
	end)
	return #a0 > 0 and a0[RandomInt(0, #a0 - 1) + 1] or nil
end
function l.prototype.Damage(self, M, a0, ag)
	if not IsValid(M) then
		return
	end
	for o, B in ipairs(a0) do
		do
			if self.disposed then
				return
			end
			if not f(self:Heroes(), B) then
				goto ah
			end
			M:DealDamage(
				B,
				nil,
				B:GetMaxHealth() * ag * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
				EOM_DAMAGE_FLAGS.NO_CRIT
					+ EOM_DAMAGE_FLAGS.NO_DAMAGE_AMPLIFY
					+ EOM_DAMAGE_FLAGS.NO_MANA_REGEN
					+ EOM_DAMAGE_FLAGS.NO_INCOMING_AMPLIFY
					+ EOM_DAMAGE_FLAGS.NO_INCOMING_ADJUST
			)
		end
		::ah::
	end
end
function l.prototype.HealEnemies(self, ag)
	for o, C in ipairs(self:Enemies()) do
		C:Heal(C:GetMaxHealth() * ag * 0.01, nil)
	end
end
function l.prototype.Distance(self, ai, aj)
	return math.sqrt((ai.x - aj.x) ^ 2 + (ai.y - aj.y) ^ 2)
end
function l.prototype.Warning(self, r, S, a1, ak, Y)
	if Y == nil then
		Y = k
	end
	local a2 = self:AddParticle(r, Y, S)
	ParticleManager:SetParticleControl(a2, 1, S)
	ParticleManager:SetParticleControl(a2, 2, Vector(a1, math.max(j, ak), 0))
	return a2
end
function l.prototype.AddParticle(self, r, Y, S)
	local a2 = ParticleManager:CreateParticle(Y, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(a2, 0, S)
	local al = r.particles
	al[#al + 1] = a2
	return a2
end
function l.prototype.RemoveParticle(self, r, a2)
	ParticleManager:DestroyParticle(a2, true)
	ParticleManager:ReleaseParticleIndex(a2)
	r.particles = g(r.particles, function(o, am)
		return am ~= a2
	end)
end
function l.prototype.ClearParticles(self, r)
	for o, a2 in ipairs(r.particles) do
		ParticleManager:DestroyParticle(a2, true)
		ParticleManager:ReleaseParticleIndex(a2)
	end
	r.particles = {}
	r.warning = nil
	for o, ad in ipairs(r.bombs) do
		ad.particle = nil
	end
end
function l.prototype.EndInstance(self, r, an)
	if an == nil then
		an = "remove"
	end
	self:SetHunterWarningAnimation(r, false)
	self:ClearParticles(r)
	local ao = r.lightningZone
	local ap = r.energyOrb
	local P = r.tide
	r.lightningZone = nil
	r.energyOrb = nil
	r.tide = nil
	r.heroIndices = nil
	if IsValid(ao) then
		ao:RemoveModifierByName("modifier_hunt_lightning_zone")
	end
	if IsValid(ap) then
		ap:RemoveModifierByName("modifier_hunt_energy_orb")
	end
	if IsValid(P) then
		P:RemoveModifierByName("modifier_hunt_tide")
	end
	local T = r.unit
	r.unit = nil
	r.target = nil
	r.marks = {}
	r.bombs = {}
	r.phase = "waiting"
	r.nextAt = self.elapsed + r.config.params.Interval
	if IsValid(T) then
		if an == "kill" then
			if T:IsAlive() then
				T:Kill(nil, T)
			end
		else
			UTIL_Remove(T)
		end
	end
end
return i