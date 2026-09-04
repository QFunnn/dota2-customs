--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local ____exports = {}
local modifier_elite_057_frozen_state
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local warningEffectRing = ____monster_base.warningEffectRing
local CAST_RANGE = 1300
local CAST_POINT = 0.8
local SCATTER_RADIUS = 800
local TRIGGER_RADIUS = 100
local DAMAGE_RADIUS = 100
local DAMAGE_RATE = 22
local TRAP_COUNT = 5
local TRAP_DURATION = 15
local TRAP_ARM_DELAY = 1
local EXPLOSION_DELAY = 0.1
local PASSIVE_TRAP_INTERVAL = 5
local ACTIVE_TRAP_MAX_COUNT = 6
local PASSIVE_TRAP_MAX_COUNT = 6
local PASSIVE_TRAP_SEARCH_RADIUS = 2000
local PASSIVE_TRAP_SPAWN_RADIUS = 260
local STUN_DURATION = 1
local TRAP_PARTICLE = "particles/unit/elite_057butterfly_portrait.vpcf"
local EXPLOSION_PARTICLE = "particles/unit/templar_assassin_trap_explode_butterfly.vpcf"
local TRAP_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts"
local EXPLOSION_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts"
local TRAP_CAST_SOUND = "Hero_Ancient_Apparition.IceVortexCast"
local TRAP_EXPLOSION_SOUND = "Hero_Crystal.CrystalNova"
--- 精英技能57 - 冰霜陷阱：在目标附近散布5个陷阱，踩中后爆炸造成冰冻和眩晕
____exports.elite_057 = __TS__Class()
local elite_057 = ____exports.elite_057
elite_057.name = "elite_057"
__TS__ClassExtends(elite_057, MonsterAbility_CS)
function elite_057.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self._targetPos = nil
	self.trapPositions = {}
	self.trapPids = {}
end
function elite_057.prototype.Precache(self, context)
	PrecacheResource("particle", TRAP_PARTICLE, context)
	PrecacheResource("particle", EXPLOSION_PARTICLE, context)
	PrecacheResource("soundfile", TRAP_SOUND_EVENTS, context)
	PrecacheResource("soundfile", EXPLOSION_SOUND_EVENTS, context)
end
function elite_057.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_0 = target:GetAbsOrigin()
			else
				____IsValidAlive_result_0 = caster:GetAbsOrigin()
			end
			self._targetPos = ____IsValidAlive_result_0
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			self.trapPositions = self:GenerateTrapPositions(caster, self._targetPos)
			for ____, pos in ipairs(self.trapPositions) do
				self:WarningRingEffect(pos, TRIGGER_RADIUS, CAST_POINT + 0.1)
			end
		end,
		OnInterrupt = function()
			self._targetPos = nil
			self.trapPositions = {}
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(TRAP_CAST_SOUND, caster)
			local center = self._targetPos or caster:GetAbsOrigin()
			self._targetPos = nil
			if #self.trapPositions <= 0 then
				self.trapPositions = self:GenerateTrapPositions(caster, center)
			end
			self.trapPids = {}
			for ____, pos in ipairs(self.trapPositions) do
				local pid = ParticleManager:CreateParticle(TRAP_PARTICLE, PATTACH_WORLDORIGIN, nil)
				ParticleManager:SetParticleControl(pid, 0, pos)
				local ____self_trapPids_1 = self.trapPids
				____self_trapPids_1[#____self_trapPids_1 + 1] = pid
			end
			____exports.modifier_elite_057_trap:applys(caster, caster, self, { duration = TRAP_DURATION })
		end,
	}
end
function elite_057.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_057_passive_trap"
end
function elite_057.prototype.GenerateTrapPositions(self, caster, center)
	local positions = {}
	do
		local i = 0
		while i < TRAP_COUNT do
			local angle = RandomFloat(0, 360)
			local dist = RandomFloat(0, SCATTER_RADIUS)
			local dx = math.cos(angle * math.pi / 180) * dist
			local dy = math.sin(angle * math.pi / 180) * dist
			local x = center.x + dx
			local y = center.y + dy
			local z = GetGroundHeight(Vector(x, y, center.z), caster) or center.z
			positions[#positions + 1] = Vector(x, y, z)
			i = i + 1
		end
	end
	return positions
end
elite_057 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_057)
____exports.elite_057 = elite_057
____exports.modifier_elite_057_trap = __TS__Class()
local modifier_elite_057_trap = ____exports.modifier_elite_057_trap
modifier_elite_057_trap.name = "modifier_elite_057_trap"
__TS__ClassExtends(modifier_elite_057_trap, MonsterModifier_CS)
function modifier_elite_057_trap.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.trapPositions = {}
	self.trapPids = {}
	self.trapActive = {}
	self.pendingExplosionCount = 0
end
function modifier_elite_057_trap.prototype.DeclareEvents(self)
	return {
		{ event = BusinessEvents.ON_UNIT_DEATH, target = { scope = "global" } },
		{ event = BusinessEvents.ON_UNIT_SAFE_DESTROY, target = { scope = "global" } },
		{ event = BusinessEvents.ON_UNIT_REMOVE, target = { scope = "global" } },
	}
end
function modifier_elite_057_trap.prototype.OnUnitDeath_CS(self, event)
	if not IsServer() then
		return
	end
	local ____event_entindex_killed_2
	if event.entindex_killed then
		____event_entindex_killed_2 = EntIndexToHScript(event.entindex_killed)
	else
		____event_entindex_killed_2 = nil
	end
	local victim = ____event_entindex_killed_2
	if not victim or not self:IsParentUnit(victim) then
		return
	end
	self:Destroy()
end
function modifier_elite_057_trap.prototype.OnUnitSafeDestroy_CS(self, event)
	if not IsServer() then
		return
	end
	if not self:IsParentEntityIndex(event.UnitID) then
		return
	end
	self:Destroy()
end
function modifier_elite_057_trap.prototype.OnUnitRemove_CS(self, event)
	if not IsServer() then
		return
	end
	if not self:IsParentEntityIndex(event.UnitID) then
		return
	end
	self:Destroy()
end
function modifier_elite_057_trap.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		self:Destroy()
		return
	end
	self:AddTrapsFromAbility(ability)
	self:StartIntervalThink(0.1)
end
function modifier_elite_057_trap.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		self:Destroy()
		return
	end
	self:AddTrapsFromAbility(ability)
end
function modifier_elite_057_trap.prototype.AddTrapsFromAbility(self, ability)
	do
		local i = 0
		while i < #ability.trapPositions do
			local currentPos = ability.trapPositions[i + 1]
			local currentPid = ability.trapPids[i + 1]
			while self:GetActiveTrapCount() >= ACTIVE_TRAP_MAX_COUNT do
				if not self:ExplodeOldestActiveTrap() then
					break
				end
			end
			local ____self_trapPositions_3 = self.trapPositions
			____self_trapPositions_3[#____self_trapPositions_3 + 1] = currentPos
			local ____self_trapPids_4 = self.trapPids
			____self_trapPids_4[#____self_trapPids_4 + 1] = currentPid
			local ____self_trapActive_5 = self.trapActive
			____self_trapActive_5[#____self_trapActive_5 + 1] = true
			i = i + 1
		end
	end
end
function modifier_elite_057_trap.prototype.GetActiveTrapCount(self)
	local count = 0
	for ____, active in ipairs(self.trapActive) do
		if active then
			count = count + 1
		end
	end
	return count
end
function modifier_elite_057_trap.prototype.ExplodeOldestActiveTrap(self)
	do
		local i = 0
		while i < #self.trapActive do
			do
				if not self.trapActive[i + 1] then
					goto __continue43
				end
				self.trapActive[i + 1] = false
				self:DestroyTrapParticle(self.trapPids[i + 1])
				self:StartDelayedExplosion(self.trapPositions[i + 1])
				return true
			end
			::__continue43::
			i = i + 1
		end
	end
	return false
end
function modifier_elite_057_trap.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local anyActive = false
	do
		local i = 0
		while i < #self.trapPositions do
			do
				if not self.trapActive[i + 1] then
					goto __continue48
				end
				anyActive = true
				local pos = self.trapPositions[i + 1]
				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					pos,
					nil,
					TRIGGER_RADIUS,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				if #enemies == 0 then
					goto __continue48
				end
				self.trapActive[i + 1] = false
				self:DestroyTrapParticle(self.trapPids[i + 1])
				self:StartDelayedExplosion(pos)
			end
			::__continue48::
			i = i + 1
		end
	end
	if not anyActive and self.pendingExplosionCount <= 0 then
		self:Destroy()
	end
end
function modifier_elite_057_trap.prototype.StartDelayedExplosion(self, pos)
	self.pendingExplosionCount = self.pendingExplosionCount + 1
	Timers:CreateTimer(EXPLOSION_DELAY, function()
		self.pendingExplosionCount = math.max(self.pendingExplosionCount - 1, 0)
		if self:IsNull() then
			return
		end
		self:ExplodeTrap(pos)
		if not self:HasActiveTrap() and self.pendingExplosionCount <= 0 then
			self:Destroy()
		end
	end)
end
function modifier_elite_057_trap.prototype.ExplodeTrap(self, pos)
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	ParticleManager:SetParticleControl(pfx, 1, Vector(DAMAGE_RADIUS, DAMAGE_RADIUS, DAMAGE_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(pos, TRAP_EXPLOSION_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue58
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
			AddDeBuffStatus(nil, enemy, caster, ability, DebuffStatusType.STUN, { duration = STUN_DURATION })
			modifier_elite_057_frozen_state:applys(enemy, caster, ability, { duration = STUN_DURATION })
		end
		::__continue58::
	end
end
function modifier_elite_057_trap.prototype.HasActiveTrap(self)
	for ____, active in ipairs(self.trapActive) do
		if active then
			return true
		end
	end
	return false
end
function modifier_elite_057_trap.prototype.DestroyTrapParticle(self, pfx)
	ParticleManager:DestroyParticle(pfx, false)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_elite_057_trap.prototype.IsParentUnit(self, unit)
	local parent = self:GetParent()
	return not not parent and IsValid(nil, parent) and unit == parent
end
function modifier_elite_057_trap.prototype.IsParentEntityIndex(self, unitIndex)
	local parent = self:GetParent()
	return not not parent and IsValid(nil, parent) and parent:entindex() == unitIndex
end
function modifier_elite_057_trap.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	do
		local i = 0
		while i < #self.trapPids do
			if self.trapActive[i + 1] and self.trapPids[i + 1] then
				self:DestroyTrapParticle(self.trapPids[i + 1])
			end
			i = i + 1
		end
	end
	self.trapPositions = {}
	self.trapPids = {}
	self.trapActive = {}
end
function modifier_elite_057_trap.prototype.IsHidden(self)
	return true
end
function modifier_elite_057_trap.prototype.IsPurgable(self)
	return false
end
function modifier_elite_057_trap.prototype.RemoveOnDeath(self)
	return true
end
modifier_elite_057_trap = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_057_trap)
____exports.modifier_elite_057_trap = modifier_elite_057_trap
local modifier_elite_057_passive_trap = __TS__Class()
modifier_elite_057_passive_trap.name = "modifier_elite_057_passive_trap"
__TS__ClassExtends(modifier_elite_057_passive_trap, MonsterModifier_CS)
function modifier_elite_057_passive_trap.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.traps = {}
	self.nextCreateTime = 0
end
function modifier_elite_057_passive_trap.prototype.DeclareEvents(self)
	return {
		{ event = BusinessEvents.ON_UNIT_DEATH, target = { scope = "global" } },
		{ event = BusinessEvents.ON_UNIT_SAFE_DESTROY, target = { scope = "global" } },
		{ event = BusinessEvents.ON_UNIT_REMOVE, target = { scope = "global" } },
	}
end
function modifier_elite_057_passive_trap.prototype.OnUnitDeath_CS(self, event)
	if not IsServer() then
		return
	end
	local ____event_entindex_killed_6
	if event.entindex_killed then
		____event_entindex_killed_6 = EntIndexToHScript(event.entindex_killed)
	else
		____event_entindex_killed_6 = nil
	end
	local victim = ____event_entindex_killed_6
	if not victim or not self:IsParentUnit(victim) then
		return
	end
	self:Destroy()
end
function modifier_elite_057_passive_trap.prototype.OnUnitSafeDestroy_CS(self, event)
	if not IsServer() then
		return
	end
	if not self:IsParentEntityIndex(event.UnitID) then
		return
	end
	self:Destroy()
end
function modifier_elite_057_passive_trap.prototype.OnUnitRemove_CS(self, event)
	if not IsServer() then
		return
	end
	if not self:IsParentEntityIndex(event.UnitID) then
		return
	end
	self:Destroy()
end
function modifier_elite_057_passive_trap.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.nextCreateTime = GameRules:GetGameTime() + PASSIVE_TRAP_INTERVAL
	self:StartIntervalThink(0.1)
end
function modifier_elite_057_passive_trap.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self:CleanupExpiredTraps()
	self:CheckTriggeredTraps()
	self:TryCreateTrap(parent)
end
function modifier_elite_057_passive_trap.prototype.TryCreateTrap(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	local now = GameRules:GetGameTime()
	if now < self.nextCreateTime then
		return
	end
	self.nextCreateTime = now + PASSIVE_TRAP_INTERVAL
	if not self:HasNearbyEnemy(parent) then
		return
	end
	local pos = self:GetSpawnPosition(parent)
	if not pos then
		return
	end
	self:ExplodeOldestTrapIfFull()
	local pfx = ParticleManager:CreateParticle(TRAP_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	warningEffectRing(nil, parent, pos, TRIGGER_RADIUS, TRAP_ARM_DELAY)
	local ____self_traps_7 = self.traps
	____self_traps_7[#____self_traps_7 + 1] =
		{ pos = pos, pfx = pfx, activeTime = now + TRAP_ARM_DELAY, endTime = now + TRAP_DURATION }
end
function modifier_elite_057_passive_trap.prototype.ExplodeOldestTrapIfFull(self)
	if #self.traps < PASSIVE_TRAP_MAX_COUNT then
		return
	end
	local oldestTrap = table.remove(self.traps, 1)
	if not oldestTrap then
		return
	end
	self:DestroyTrapParticle(oldestTrap)
	self:StartDelayedExplosion(oldestTrap.pos)
end
function modifier_elite_057_passive_trap.prototype.HasNearbyEnemy(self, parent)
	if not IsValidAlive(nil, parent) then
		return false
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		PASSIVE_TRAP_SEARCH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	return #enemies > 0
end
function modifier_elite_057_passive_trap.prototype.GetSpawnPosition(self, parent)
	if not IsValidAlive(nil, parent) then
		return nil
	end
	local origin = parent:GetAbsOrigin()
	do
		local i = 0
		while i < 8 do
			local rawPos = origin:__add(RandomVector(RandomFloat(80, PASSIVE_TRAP_SPAWN_RADIUS)))
			local pos = GetGroundPosition(rawPos, parent)
			if IsGridNavDisplacementWalkable(nil, pos) then
				return pos
			end
			i = i + 1
		end
	end
	return GetGroundPosition(origin, parent)
end
function modifier_elite_057_passive_trap.prototype.CheckTriggeredTraps(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	do
		local i = #self.traps - 1
		while i >= 0 do
			do
				local trap = self.traps[i + 1]
				if trap.activeTime > GameRules:GetGameTime() then
					goto __continue106
				end
				local enemies = FindUnitsInRadius(
					parent:GetTeamNumber(),
					trap.pos,
					nil,
					TRIGGER_RADIUS,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				if #enemies <= 0 then
					goto __continue106
				end
				self:DestroyTrapParticle(trap)
				self:StartDelayedExplosion(trap.pos)
				__TS__ArraySplice(self.traps, i, 1)
			end
			::__continue106::
			i = i - 1
		end
	end
end
function modifier_elite_057_passive_trap.prototype.StartDelayedExplosion(self, pos)
	self:Timer(EXPLOSION_DELAY, function()
		return self:ExplodeTrap(pos)
	end)
end
function modifier_elite_057_passive_trap.prototype.CleanupExpiredTraps(self)
	local now = GameRules:GetGameTime()
	do
		local i = #self.traps - 1
		while i >= 0 do
			do
				local trap = self.traps[i + 1]
				if trap.endTime > now then
					goto __continue112
				end
				self:DestroyTrapParticle(trap)
				__TS__ArraySplice(self.traps, i, 1)
			end
			::__continue112::
			i = i - 1
		end
	end
end
function modifier_elite_057_passive_trap.prototype.ExplodeTrap(self, pos)
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	ParticleManager:SetParticleControl(pfx, 1, Vector(DAMAGE_RADIUS, DAMAGE_RADIUS, DAMAGE_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(pos, TRAP_EXPLOSION_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue116
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
			AddDeBuffStatus(nil, enemy, caster, ability, DebuffStatusType.STUN, { duration = STUN_DURATION })
			modifier_elite_057_frozen_state:applys(enemy, caster, ability, { duration = STUN_DURATION })
		end
		::__continue116::
	end
end
function modifier_elite_057_passive_trap.prototype.DestroyTrapParticle(self, trap)
	ParticleManager:DestroyParticle(trap.pfx, false)
	ParticleManager:ReleaseParticleIndex(trap.pfx)
end
function modifier_elite_057_passive_trap.prototype.IsParentUnit(self, unit)
	local parent = self:GetParent()
	return not not parent and IsValid(nil, parent) and unit == parent
end
function modifier_elite_057_passive_trap.prototype.IsParentEntityIndex(self, unitIndex)
	local parent = self:GetParent()
	return not not parent and IsValid(nil, parent) and parent:entindex() == unitIndex
end
function modifier_elite_057_passive_trap.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	for ____, trap in ipairs(self.traps) do
		self:DestroyTrapParticle(trap)
	end
	self.traps = {}
end
function modifier_elite_057_passive_trap.prototype.IsHidden(self)
	return true
end
function modifier_elite_057_passive_trap.prototype.IsPurgable(self)
	return false
end
function modifier_elite_057_passive_trap.prototype.RemoveOnDeath(self)
	return true
end
modifier_elite_057_passive_trap =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_057_passive_trap") }, modifier_elite_057_passive_trap)
modifier_elite_057_frozen_state = __TS__Class()
modifier_elite_057_frozen_state.name = "modifier_elite_057_frozen_state"
__TS__ClassExtends(modifier_elite_057_frozen_state, MonsterModifier_CS)
function modifier_elite_057_frozen_state.prototype.CheckState(self)
	return { [MODIFIER_STATE_FROZEN] = true }
end
function modifier_elite_057_frozen_state.prototype.IsHidden(self)
	return true
end
function modifier_elite_057_frozen_state.prototype.IsPurgable(self)
	return false
end
modifier_elite_057_frozen_state =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_057_frozen_state") }, modifier_elite_057_frozen_state)
return ____exports