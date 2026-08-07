--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "class/dungeon_trap"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayFilter
local e = b.__TS__ArrayIncludes
local f = b.__TS__Delete
local g = {}
local h = {
	enabled = true,
	common = { maxTriggerCount = 100, enemyDamageAttackFactor = 5 },
	floor = { enabled = true },
	projectile = {
		enabled = true,
		interval = 3,
		defaultBullet = {
			effectName = "particles/traps/firetrap/trap_breathe_fire.vpcf",
			moveSpeed = 1200,
			soundName = "Hero_DragonKnight.BreathFire",
		},
		terrainBullets = {
			ice = {
				effectName = "particles/traps/based_crossbow_bolts/ice_based_crossbow_bolts/ice_based_crossbow_bolts_fx.vpcf",
			},
			jungle = {
				effectName = "particles/traps/based_crossbow_bolts/rock_based_crossbow_bolts/rock_based_crossbow_bolts_fx.vpcf",
				moveSpeed = 600,
				bulletSoundName = "Hero_EarthSpirit.RollingBoulder.Loop",
				soundName = "Hero_EarthSpirit.RollingBoulder.Cast",
			},
			sand = {
				effectName = "particles/traps/based_crossbow_bolts/wind_based_crossbow_bolts/wind_based_crossbow_bolts_fx.vpcf",
			},
		},
	},
	cutterSaw = { enabled = true, model = "models/eom/props/sm_trap/trap_cutter_saw.vmdl", distance = 600 },
	flameColumn = {
		enabled = true,
		model = "models/eom/props/sm_column/eom_column_4_0.vmdl",
		interval = 10,
		warningDuration = 2,
		fireDuration = 3,
		damageInterval = 0.25,
		radius = 350,
		angle = 60,
		damageScale = 0.5,
		particleHeight = 300,
	},
	fallenIceSpikes = {
		enabled = false,
		terrainTheme = "ice",
		interval = 2,
		chance = 100,
		maxCount = 20,
		warningDuration = 1.5,
		radius = 150,
	},
	sandTornado = { enabled = false, chance = 100 },
}
local function i(self, j, k)
	return string.sub(j, -string.len(k)) == k
end
g.DungeonTrap = c()
local l = g.DungeonTrap
l.name = "DungeonTrap"
function l.prototype.____constructor(self, m)
	self.context = m
	self.traps = {}
	self.trapTriggerCounts = {}
	self.trapEnemyDamage = 0
	self.flameColumnState = { traps = {}, directionThinkers = {}, particleIDs = {} }
	self.fallenIceSpikesState = { count = 0 }
end
function l.prototype.Prepare(self)
	if not h.enabled then
		return
	end
	self:CreateTraps()
	self:RegisterFloorTrapEvent()
end
function l.prototype.Activate(self)
	if not h.enabled then
		return
	end
	self:RefreshTrapEnemyDamage()
	if not self.context:isCombatRoom() then
		return
	end
	self:StartSandTornado()
	self:StartCutterSawTrap()
	self:StartFlameColumnTraps()
	self:StartFallenIceSpikesTrap()
	self:StartProjectileTraps()
end
function l.prototype.StopCombat(self)
	self:StopProjectileTraps()
	self:ClearSandTornado()
	self:ClearCutterSawUnitTrap()
	self:ClearFlameColumnTraps()
	self:StopFallenIceSpikesTrap()
	self:RemoveBossShrink()
end
function l.prototype.Complete(self)
	self:StopCombat()
	self:UnregisterFloorTrapEvent()
end
function l.prototype.Dispose(self)
	self:Complete()
	self:RemoveCutterSawUnits()
	if IsValid(self.trapThinker) then
		self.trapThinker:RemoveSelf()
	end
	self.trapThinker = nil
	self.traps = {}
	self.trapTriggerCounts = {}
end
function l.prototype.GetTrapList(self)
	return self.traps
end
function l.prototype.AddBossShrink(self)
	local n = self.trapThinker
	if IsValid(n) and not self.context:isDisposed() and not self.context:isCombatEnd() then
		n:AddNewModifier(n, nil, "modifier_boss_shrink", {})
	end
end
function l.prototype.RemoveBossShrink(self)
	if IsValid(self.trapThinker) then
		self.trapThinker:RemoveModifierByName("modifier_boss_shrink")
	end
end
function l.prototype.CreateTraps(self)
	self.trapThinker = CreateModifierThinker(
		nil,
		nil,
		"modifier_trap_thinker",
		{},
		self.context:getPosition(),
		DOTA_TEAM_BADGUYS,
		false
	)
	local o = Entities:FindAllByClassname("prop_dynamic")
	local p = self.context:getSpawnGroup()
	for q, r in ipairs(o) do
		do
			if r:GetSpawnGroupHandle() ~= p then
				goto s
			end
			local t = r:GetName()
			local u = r
			local v = tostring
			local w
			if u.GetModelName ~= nil then
				w = u:GetModelName()
			else
				w = ""
			end
			local x = v(w)
			local y = h.projectile.enabled and i(nil, t, "trap_fire_model")
			local z = h.cutterSaw.enabled and (i(nil, t, "cutter_saw") or x == h.cutterSaw.model)
			if y then
				local A = self.traps
				A[#A + 1] = r
			elseif z then
				local B = r:GetAbsOrigin()
				local C = r:GetForwardVector():Normalized()
				local D = self:CreateCutterSawUnitFromProp(r, B, C)
				if IsValid(D) then
					local E = self.traps
					E[#E + 1] = D
				end
			end
		end
		::s::
	end
end
function l.prototype.RegisterFloorTrapEvent(self)
	if not h.floor.enabled then
		return
	end
	if self.floorTrapEventID ~= nil then
		return
	end
	self.floorTrapEventID = Event:Register("trap_floor", function(q, F)
		self:OnFloorTrapTriggered(F.trap, F.caster)
	end)
end
function l.prototype.UnregisterFloorTrapEvent(self)
	if self.floorTrapEventID ~= nil then
		Event:Unregister(self.floorTrapEventID)
		self.floorTrapEventID = nil
	end
end
function l.prototype.OnFloorTrapTriggered(self, r, G)
	if self.context:isDisposed() or self.context:isCombatEnd() then
		return
	end
	if not self:TryConsumeTrapTrigger(r) then
		return
	end
	local H = r:GetAbsOrigin()
	self:CreateFloorTrapWarning(r, H)
	G:GameTimer(1, function()
		return self:DamageFloorTrap(r, G, H)
	end)
end
function l.prototype.CreateFloorTrapWarning(self, r, H)
	local I = {
		["models/eom/props/sm_trap/eom_trap01.vmdl"] = "particles/traps/spikes/spiketrap_anticipate.vpcf",
		["models/eom/props/sm_trap/eom_trap03.vmdl"] = "particles/traps/spikes/spiketrap_anticipate_01.vpcf",
	}
	local J = "particles/traps/spikes/spiketrap_anticipate.vpcf"
	local K = I[r:GetModelName()] or J
	local L = ParticleManager:CreateParticleForce(K, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(L, 0, H)
	ParticleManager:ReleaseParticleIndex(L)
end
function l.prototype.DamageFloorTrap(self, r, G, H)
	local n = self.trapThinker
	if self.context:isDisposed() or self.context:isCombatEnd() then
		return
	end
	if not IsValid(G) or not IsValid(r) or not IsValid(n) then
		return
	end
	r:FireOutput("OnUser1", nil, nil, nil, 0)
	r:EmitSound("TrapFloor")
	local M = GRID_SIZE * 0.5
	local N = { H + Vector(M, M, 0), H + Vector(-M, M, 0), H + Vector(-M, -M, 0), H + Vector(M, -M, 0) }
	local O = FindUnitsInRadius(
		DOTA_TEAM_GOODGUYS,
		H,
		nil,
		GRID_SIZE * 0.7071,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for q, P in ipairs(O) do
		if IsPointInPolygon(P:GetAbsOrigin(), N) then
			n:DealDamage(P, nil, self:GetTrapDamage(P), nil, EOM_DAMAGE_FLAGS.TRAP)
		end
	end
end
function l.prototype.StartProjectileTraps(self)
	self:StopProjectileTraps()
	local Q = h.projectile
	if not Q.enabled then
		return
	end
	self.projectileTrapTimerID = Timer:GameTimer(Q.interval, function()
		if self.context:isDisposed() or self.context:isCombatEnd() then
			self.projectileTrapTimerID = nil
			return
		end
		local n = self.trapThinker
		local R = self:GetProjectileTrapBulletConfig()
		for q, r in ipairs(self.traps) do
			do
				if not IsValid(r) or not i(nil, r:GetName(), "trap_fire_model") then
					goto S
				end
				if not self:TryConsumeTrapTrigger(r) then
					goto S
				end
				self:FireProjectileTrap(r, n, R)
			end
			::S::
		end
		return Q.interval
	end)
end
function l.prototype.StopProjectileTraps(self)
	if self.projectileTrapTimerID ~= nil then
		Timer:StopTimer(self.projectileTrapTimerID)
		self.projectileTrapTimerID = nil
	end
end
function l.prototype.GetProjectileTrapBulletConfig(self)
	local Q = h.projectile
	local T = Q.terrainBullets[self.context:getTerrainThemeKey()]
	return {
		effectName = T and T.effectName or Q.defaultBullet.effectName,
		moveSpeed = T and T.moveSpeed or Q.defaultBullet.moveSpeed,
		soundName = T and T.soundName or Q.defaultBullet.soundName,
		bulletSoundName = T and T.bulletSoundName or Q.defaultBullet.bulletSoundName,
	}
end
function l.prototype.FireProjectileTrap(self, r, n, Q)
	r:FireOutput("OnUser1", nil, nil, nil, 0)
	local U = Q.bulletSoundName
	Bullet:CreateLinearBullet({
		caster = n,
		spawnOrigin = r:GetAbsOrigin(),
		direction = r:GetForwardVector():Normalized(),
		effectName = Q.effectName,
		radius = BULLET_WIDTH,
		teamFilter = DOTA_UNIT_TARGET_TEAM_BOTH,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		moveSpeed = Q.moveSpeed,
		distance = 3000,
		ignoreBlock = true,
		destroyOnBounce = true,
		thinker = U ~= nil,
		interval = 1,
		OnBulletCreated = function(V)
			if U ~= nil and IsValid(V.__thinker) then
				EmitSoundOn(U, V.__thinker)
			end
		end,
		OnBulletDestroy = function(V)
			if U ~= nil and IsValid(V.__thinker) then
				StopSoundOn(U, V.__thinker)
			end
		end,
		OnIntervalThink = function(V)
			V.ignoreBlock = false
			return -1
		end,
		OnBulletHit = function(W)
			if IsValid(n) then
				n:DealDamage(W, nil, self:GetTrapDamage(W), nil, EOM_DAMAGE_FLAGS.TRAP)
			end
		end,
	})
	r:EmitSound(Q.soundName)
end
function l.prototype.StartCutterSawTrap(self)
	if not h.cutterSaw.enabled then
		return false
	end
	local X = false
	do
		local Y = 0
		while Y < #self.traps do
			do
				local r = self.traps[Y + 1]
				if not self:IsCutterSawTrap(r) then
					goto Z
				end
				local _ = r:GetAbsOrigin()
				local C = r:GetForwardVector():Normalized()
				local a0 = _ + C * h.cutterSaw.distance
				if self:CreateCutterSawUnitTrap(r, _, a0) then
					X = true
				end
			end
			::Z::
			Y = Y + 1
		end
	end
	return X
end
function l.prototype.CreateCutterSawUnitFromProp(self, a1, B, C)
	local n = self.trapThinker
	if not IsValid(n) then
		print(
			("[DungeonTrap " .. tostring(self.context:getRoomID()))
				.. "] replace cutter_saw failed: trapThinker invalid"
		)
		return nil
	end
	local D = CreateUnitByName("cutter_saw", B, true, n, n, n:GetTeamNumber())
	if not IsValid(D) then
		print(
			(
				("[DungeonTrap " .. tostring(self.context:getRoomID()))
				.. "] replace cutter_saw failed: create unit failed name="
			) .. a1:GetName()
		)
		return nil
	end
	D:SetForwardVector(C)
	D:SetAbsOrigin(B)
	a1:RemoveSelf()
	return D
end
function l.prototype.IsCutterSawTrap(self, r)
	if not IsValid(r) then
		return false
	end
	local W = r
	return i(nil, r:GetName(), "cutter_saw") or W.GetUnitName ~= nil and W:GetUnitName() == "cutter_saw"
end
function l.prototype.CreateCutterSawUnitTrap(self, D, _, a0)
	local n = self.trapThinker
	if not IsValid(n) then
		print(
			("[DungeonTrap " .. tostring(self.context:getRoomID()))
				.. "] CreateCutterSawUnitTrap failed: trapThinker invalid"
		)
		return false
	end
	if not IsValid(D) then
		print(
			("[DungeonTrap " .. tostring(self.context:getRoomID()))
				.. "] CreateCutterSawUnitTrap failed: cutter invalid"
		)
		return false
	end
	local a2 = CalcDistance(_, a0)
	if a2 <= 0 then
		print(
			(("[DungeonTrap " .. tostring(self.context:getRoomID())) .. "] CreateCutterSawUnitTrap failed: distance=")
				.. tostring(a2)
		)
		return false
	end
	local a3 = D:AddNewModifier(
		n,
		nil,
		"modifier_dungeon_cutter_saw_unit",
		{ start_position = VectorToString(_), end_position = VectorToString(a0) }
	)
	if not IsValid(a3) then
		print(("[DungeonTrap " .. tostring(self.context:getRoomID())) .. "] cutter unit modifier create failed")
		return false
	end
	a3.damageFunc = function(q, P)
		return self:GetTrapDamage(P)
	end
	return true
end
function l.prototype.ClearCutterSawUnitTrap(self)
	do
		local Y = 0
		while Y < #self.traps do
			do
				local r = self.traps[Y + 1]
				if not self:IsCutterSawTrap(r) then
					goto a4
				end
				local a5 = r
				if a5.RemoveModifierByName ~= nil then
					a5:RemoveModifierByName("modifier_dungeon_cutter_saw_unit")
				end
			end
			::a4::
			Y = Y + 1
		end
	end
end
function l.prototype.RemoveCutterSawUnits(self)
	for q, r in ipairs(self.traps) do
		if self:IsCutterSawTrap(r) then
			self.context:removeUnit(r)
		end
	end
end
function l.prototype.StartFallenIceSpikesTrap(self)
	local Q = h.fallenIceSpikes
	if not Q.enabled then
		return false
	end
	if self.context:getTerrainThemeKey() ~= Q.terrainTheme then
		return false
	end
	if not self.context:isCombatRoom() then
		return false
	end
	if not IsValid(self.trapThinker) then
		return false
	end
	if self.fallenIceSpikesState.timerID ~= nil then
		return false
	end
	self.fallenIceSpikesState.count = 0
	self.fallenIceSpikesState.timerID = Timer:GameTimer(Q.interval, function()
		if self.context:isDisposed() or self.context:isCombatEnd() or self.fallenIceSpikesState.count >= Q.maxCount then
			self.fallenIceSpikesState.timerID = nil
			return
		end
		if RollPercentage(Q.chance) then
			self:CreateFallenIceSpikesTrap()
		end
		return Q.interval
	end)
	return true
end
function l.prototype.StopFallenIceSpikesTrap(self)
	if self.fallenIceSpikesState.timerID ~= nil then
		Timer:StopTimer(self.fallenIceSpikesState.timerID)
		self.fallenIceSpikesState.timerID = nil
	end
end
function l.prototype.CreateFallenIceSpikesTrap(self)
	local n = self.trapThinker
	local Q = h.fallenIceSpikes
	if not IsValid(n) or self.fallenIceSpikesState.count >= Q.maxCount then
		return
	end
	local B = self.context:getRandomValidGridPosition() or self.context:getPosition()
	local H = GetGroundPosition(B, nil)
	local a6, a7 = self.fallenIceSpikesState, "count"
	a6[a7] = a6[a7] + 1
	local a8 = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(a8, 0, H)
	ParticleManager:SetParticleControl(a8, 1, H)
	ParticleManager:SetParticleControl(a8, 2, Vector(Q.radius, Q.warningDuration, 0))
	ParticleManager:ReleaseParticleIndex(a8)
	n:GameTimer(Q.warningDuration - 0.5, function()
		if self.context:isDisposed() or self.context:isCombatEnd() or not IsValid(n) then
			return
		end
		local L = ParticleManager:CreateParticle(
			"particles/traps/fallen_ice_spikes/fallen_ice_spikes_fx.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(L, 0, H)
		ParticleManager:ReleaseParticleIndex(L)
		EmitSoundOnLocationWithCaster(H, "hero_Crystal.freezingField.explosion", n)
		n:GameTimer(0.5, function()
			if self.context:isDisposed() or self.context:isCombatEnd() or not IsValid(n) then
				return
			end
			local O = FindUnitsInRadius(
				n:GetTeamNumber(),
				H,
				nil,
				Q.radius,
				DOTA_UNIT_TARGET_TEAM_BOTH,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			do
				local Y = 0
				while Y < #O do
					do
						local P = O[Y + 1]
						if not IsValid(P) or P == n then
							goto a9
						end
						n:DealDamage(P, nil, self:GetTrapDamage(P), nil, EOM_DAMAGE_FLAGS.TRAP)
					end
					::a9::
					Y = Y + 1
				end
			end
		end)
	end)
end
function l.prototype.StartFlameColumnTraps(self)
	local Q = h.flameColumn
	if not Q.enabled then
		return false
	end
	if not IsValid(self.trapThinker) then
		return false
	end
	self:ClearFlameColumnTraps()
	local aa = Entities:FindAllByClassname("npc_dota_building")
	do
		local Y = 0
		while Y < #aa do
			do
				local ab = aa[Y + 1]
				if not IsValid(ab) then
					goto ac
				end
				if ab:GetSpawnGroupHandle() ~= self.context:getSpawnGroup() then
					goto ac
				end
				if ab:GetModelName() ~= Q.model then
					goto ac
				end
				local ad = self.flameColumnState.traps
				ad[#ad + 1] = ab
				self:CreateFlameColumnDirectionThinkers(ab)
			end
			::ac::
			Y = Y + 1
		end
	end
	if #self.flameColumnState.traps <= 0 then
		return false
	end
	self.flameColumnState.timerID = Timer:GameTimer(0, function()
		return self:RunFlameColumnCycle()
	end)
	return true
end
function l.prototype.RunFlameColumnCycle(self)
	if not self:CanRunFlameColumnTraps() then
		self.flameColumnState.timerID = nil
		return
	end
	self:RemoveInvalidFlameColumnTraps()
	if #self.flameColumnState.traps <= 0 then
		self.flameColumnState.timerID = nil
		return
	end
	for q, r in ipairs(self.flameColumnState.traps) do
		self:CreateFlameColumnWarnings(r)
	end
	Timer:GameTimer(h.flameColumn.warningDuration, function()
		self:FireAllFlameColumnTraps()
	end)
	return h.flameColumn.interval
end
function l.prototype.RemoveInvalidFlameColumnTraps(self)
	self.flameColumnState.traps = d(self.flameColumnState.traps, function(q, r)
		if self:IsFlameColumnTrapUsable(r) then
			return true
		end
		self:DestroyFlameColumnDirectionThinkers(r)
		return false
	end)
end
function l.prototype.FireAllFlameColumnTraps(self)
	if not self:CanRunFlameColumnTraps() then
		return
	end
	for q, r in ipairs(self.flameColumnState.traps) do
		if self:IsFlameColumnTrapUsable(r) then
			self:StartFlameColumnFire(r)
		end
	end
end
function l.prototype.ClearFlameColumnTraps(self)
	if self.flameColumnState.timerID ~= nil then
		Timer:StopTimer(self.flameColumnState.timerID)
		self.flameColumnState.timerID = nil
	end
	do
		local Y = 0
		while Y < #self.flameColumnState.particleIDs do
			local L = self.flameColumnState.particleIDs[Y + 1]
			if L ~= nil then
				ParticleManager:DestroyParticle(L, true)
				ParticleManager:ReleaseParticleIndex(L)
			end
			Y = Y + 1
		end
	end
	self.flameColumnState.particleIDs = {}
	do
		local Y = 0
		while Y < #self.flameColumnState.traps do
			local ae = self.flameColumnState.traps[Y + 1]
			if IsValid(ae) then
				ae:StopSound("Hero_Batrider.Firefly.loop")
			end
			Y = Y + 1
		end
	end
	self.flameColumnState.traps = {}
	self:DestroyAllFlameColumnDirectionThinkers()
	self.flameColumnState.directionThinkers = {}
end
function l.prototype.CreateFlameColumnWarnings(self, ae)
	local Q = h.flameColumn
	local af = self:GetFlameColumnDirectionThinkers(ae)
	do
		local Y = 0
		while Y < #af do
			do
				local ag = af[Y + 1]
				if not IsValid(ag) then
					goto ah
				end
				local ai = ag:GetAbsOrigin()
				local L = ParticleManager:CreateParticle("particles/warning/sector.vpcf", PATTACH_ABSORIGIN_FOLLOW, ag)
				ParticleManager:SetParticleControlEnt(L, 0, ag, PATTACH_ABSORIGIN_FOLLOW, nil, ai, true)
				ParticleManager:SetParticleControl(L, 1, Vector(Q.radius, Q.angle, Q.warningDuration))
				ParticleManager:ReleaseParticleIndex(L)
			end
			::ah::
			Y = Y + 1
		end
	end
end
function l.prototype.StartFlameColumnFire(self, ae)
	local Q = h.flameColumn
	local aj = {}
	local af = self:GetFlameColumnDirectionThinkers(ae)
	do
		local Y = 0
		while Y < #af do
			do
				local ag = af[Y + 1]
				if not IsValid(ag) then
					goto ak
				end
				local ai = ag:GetAbsOrigin()
				local C = ag:GetForwardVector()
				local L = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_shredder/shredder_flame_thrower.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					ag
				)
				ParticleManager:SetParticleControlEnt(L, 0, ag, PATTACH_ABSORIGIN_FOLLOW, nil, ai, true)
				ParticleManager:SetParticleControl(L, 1, ai + C * Q.radius)
				aj[#aj + 1] = L
				local al = self.flameColumnState.particleIDs
				al[#al + 1] = L
			end
			::ak::
			Y = Y + 1
		end
	end
	ae:EmitSound("Hero_Batrider.Firefly.loop")
	local am = GameRules:GetGameTime()
	Timer:GameTimer(0, function()
		if not self:CanRunFlameColumnTraps() or not self:IsFlameColumnTrapUsable(ae) then
			self:DestroyFlameColumnParticles(aj, true)
			if IsValid(ae) then
				ae:StopSound("Hero_Batrider.Firefly.loop")
			end
			return
		end
		if GameRules:GetGameTime() - am >= Q.fireDuration then
			self:DestroyFlameColumnParticles(aj, false)
			ae:StopSound("Hero_Batrider.Firefly.loop")
			return
		end
		self:DamageFlameColumnTargets(ae)
		return Q.damageInterval
	end)
end
function l.prototype.DestroyFlameColumnParticles(self, aj, an)
	do
		local Y = 0
		while Y < #aj do
			do
				local L = aj[Y + 1]
				if L == nil or not e(self.flameColumnState.particleIDs, L) then
					goto ao
				end
				ArrayRemove(self.flameColumnState.particleIDs, L)
				ParticleManager:DestroyParticle(L, an)
				ParticleManager:ReleaseParticleIndex(L)
			end
			::ao::
			Y = Y + 1
		end
	end
end
function l.prototype.DamageFlameColumnTargets(self, ae)
	local n = self.trapThinker
	if not IsValid(n) then
		return
	end
	local Q = h.flameColumn
	local O = FindUnitsInRadius(
		n:GetTeamNumber(),
		ae:GetAbsOrigin(),
		nil,
		Q.radius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	do
		local Y = 0
		while Y < #O do
			do
				local P = O[Y + 1]
				if not IsValid(P) or P == ae or P == n then
					goto ap
				end
				local aq = self:GetTrapDamage(P) * Q.damageInterval / Q.fireDuration * Q.damageScale
				n:DealDamage(P, nil, aq, nil, EOM_DAMAGE_FLAGS.TRAP)
			end
			::ap::
			Y = Y + 1
		end
	end
end
function l.prototype.CanRunFlameColumnTraps(self)
	return not self.context:isDisposed() and not self.context:isCombatEnd() and IsValid(self.trapThinker)
end
function l.prototype.IsFlameColumnTrapUsable(self, ae)
	return IsValid(ae) and ae:IsAlive() and ae:GetHealth() > 1 and e(self.flameColumnState.traps, ae)
end
function l.prototype.GetFlameColumnParticleOrigin(self, ae)
	local ar = ae:GetAbsOrigin()
	return Vector(ar.x, ar.y, h.flameColumn.particleHeight)
end
function l.prototype.CreateFlameColumnDirectionThinkers(self, ae)
	self:DestroyFlameColumnDirectionThinkers(ae)
	local af = {}
	local ar = self:GetFlameColumnParticleOrigin(ae)
	local as = { Vector(0, 1, 0), Vector(0, -1, 0), Vector(-1, 0, 0), Vector(1, 0, 0) }
	do
		local Y = 0
		while Y < #as do
			do
				local C = as[Y + 1]
				if C == nil then
					goto at
				end
				local ag = CreateModifierThinker(ae, nil, "modifier_custom_thinker", {}, ar, ae:GetTeamNumber(), false)
				if not IsValid(ag) then
					goto at
				end
				ag:SetForwardVector(C)
				af[#af + 1] = ag
			end
			::at::
			Y = Y + 1
		end
	end
	self.flameColumnState.directionThinkers[ae:GetEntityIndex()] = af
end
function l.prototype.DestroyFlameColumnDirectionThinkers(self, ae)
	if not IsValid(ae) then
		return
	end
	local au = ae:GetEntityIndex()
	local af = self.flameColumnState.directionThinkers[au] or {}
	self:DestroyFlameColumnDirectionThinkerList(af)
	f(self.flameColumnState.directionThinkers, au)
end
function l.prototype.DestroyAllFlameColumnDirectionThinkers(self)
	for au, af in pairs(self.flameColumnState.directionThinkers) do
		self:DestroyFlameColumnDirectionThinkerList(af)
		f(self.flameColumnState.directionThinkers, au)
	end
end
function l.prototype.DestroyFlameColumnDirectionThinkerList(self, af)
	do
		local Y = 0
		while Y < #af do
			local ag = af[Y + 1]
			if IsValid(ag) then
				ag:RemoveSelf()
			end
			Y = Y + 1
		end
	end
end
function l.prototype.GetFlameColumnDirectionThinkers(self, ae)
	return self.flameColumnState.directionThinkers[ae:GetEntityIndex()] or {}
end
function l.prototype.StartSandTornado(self)
	local Q = h.sandTornado
	if not Q.enabled then
		return
	end
	if self.context:getTerrainThemeKey() ~= "sand" then
		return
	end
	if not self.context:isCombatRoom() or self.context:isBossRoom() then
		return
	end
	if not RollPercentage(Q.chance) then
		return
	end
	local n = self.trapThinker
	if self.sandTornado ~= nil or not IsValid(n) then
		return
	end
	local av = self.context:getRandomValidGridPosition() or self.context:getPosition()
	local aw = CreateUnitByName("laser_unit", av, true, n, n, n:GetTeamNumber())
	aw:Stop()
	local a3 = aw:AddNewModifier(n, nil, "modifier_dungeon_sand_tornado", {})
	if IsValid(a3) then
		a3.damageFunc = function(q, P)
			return self:GetTrapDamage(P)
		end
	end
	self.sandTornado = aw
end
function l.prototype.ClearSandTornado(self)
	if self.sandTornado ~= nil then
		self.context:removeUnit(self.sandTornado)
		self.sandTornado = nil
	end
end
function l.prototype.TryConsumeTrapTrigger(self, r)
	if not IsValid(r) then
		return false
	end
	local au = r:GetEntityIndex()
	local ax = self.trapTriggerCounts[au] or 0
	if ax >= h.common.maxTriggerCount then
		return false
	end
	self.trapTriggerCounts[au] = ax + 1
	return true
end
function l.prototype.RefreshTrapEnemyDamage(self)
	local ay = 0
	Game:EachPlayer(function(q, az)
		local aA = PlayerResource:GetSelectedHeroEntity(az)
		if IsValid(aA) and aA:IsRealHero() then
			ay = ay + aA:GetAttackDamage()
		end
	end)
	self.trapEnemyDamage = ay * h.common.enemyDamageAttackFactor
end
function l.prototype.GetTrapDamage(self, P)
	if not P:IsRealHero() and P:GetTeamNumber() ~= DOTA_TEAM_GOODGUYS then
		return self.trapEnemyDamage
	end
	local aB = P:GetMaxHealth() * TRAP_DAMAGE_FACTOR
	local aC = GameRules:GetCustomGameDifficulty()
	local aD = DIFFICULTY_TRAP_DAMAGE_REDUCTION[aC] or 0
	if P:IsRealHero() and aD ~= 0 then
		aB = aB * (1 + aD / 100)
	end
	return aB
end
return g