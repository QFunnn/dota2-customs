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
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_boss_faceless_5_void, modifier_boss_faceless_5_puppet_lifetime
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_faceless_1 = require("abilities.monster.boss_faceless.boss_faceless_1")
local StartBossFacelessDash = ____boss_faceless_1.StartBossFacelessDash
local MODIFIER_CHRONOSPHERE_AURA = "modifier_ak_faceless_void_chronosphere_aura"
local CHRONOSPHERE_PARTICLE =
	"particles/econ/items/faceless_void/faceless_void_mace_of_aeons/fv_chronosphere_aeons.vpcf"
local BLINK_START_PARTICLE = "particles/monster/boss_faceless/boss_faceless_3_blink_start.vpcf"
local BLINK_END_PARTICLE = "particles/monster/boss_faceless/boss_faceless_3_blink_end.vpcf"
local EXPLOSION_PARTICLE =
	"particles/events/crownfall/survivors/abilities/techies/techies_explosion_land_mine_explode.vpcf"
local SOUND_CHRONOSPHERE_CAST = "Hero_FacelessVoid.Chronosphere.MaceOfAeons"
local SOUND_VOID_IN = "Hero_Antimage.Blink_in"
local SOUND_VOID_OUT = "Hero_Antimage.Blink_out"
local SOUND_EXPLOSION = "Hero_Techies.StickyBomb.Detonate"
local PRECAST_TIME = 1
local CAST_DURATION = 8.2
local FIELD_RADIUS = 350
local FIELD_OFFSET = 650
local FIELD_POINT_SAMPLE_STEPS = 12
local DASH_POINT_SAMPLE_STEPS = 24
local DAMAGE_RATE = 15
local TARGET_SEARCH_RANGE = 2500
local PUPPET_UNIT_NAME = "monster_12013_puppet"
local PUPPET_SUMMON_TAG = "boss_faceless_5_puppet"
local PUPPET_COMBAT_DURATION = 6
local PUPPET_ALLOWED_ABILITY_NAMES = {
	"cyan_elite",
	"collision_effect",
	"boss_ai",
	"boss_faceless_2",
	"boss_faceless_4",
	"monster_melee_special_attack",
	"monster_linear_projectile_attack",
}
local EXPLOSION_SHAKE_AMPLITUDE = 24
local EXPLOSION_SHAKE_FREQUENCY = 60
local EXPLOSION_SHAKE_DURATION = 0.35
local EXPLOSION_SHAKE_RADIUS = 2400
local FIRST_FIELD_EXPLODE_DELAY = 0.8
local NEXT_ROUND_DELAY = 0.5
local WARNING_DURATION = 0.4
local BLINK_END_TO_DASH_DELAY = 0.3
local DASH_EXTRA_START_DELAY = 0.2
local DASH_PATH_WARNING_DURATION = 0.3
local DASH_PATH_WARNING_WIDTH = 180
local DASH_DURATION = 0.35
local START_FIELD_EXPLODE_AFTER_DASH = 0.1
local UNUSED_FIELD_EXPLODE_INTERVAL = 0.15
local DASH_STUN_DURATION_MULTIPLIER = 0.7
local SECOND_ROUND_DELAY = 0.4
local THIRD_ROUND_DELAY = 0.7
local NORMAL_FIELD_DURATION = 1.4
local FOUR_FIELD_DURATION = 2
--- 虚空领域
-- 虚空领主连续制造虚空结界，并在对向结界之间穿梭冲刺。
____exports.boss_faceless_5 = __TS__Class()
local boss_faceless_5 = ____exports.boss_faceless_5
boss_faceless_5.name = "boss_faceless_5"
__TS__ClassExtends(boss_faceless_5, MonsterAbility_CS)
function boss_faceless_5.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequence = 0
end
function boss_faceless_5.prototype.Precache(self, context)
	PrecacheResource("particle", CHRONOSPHERE_PARTICLE, context)
	PrecacheResource("particle", BLINK_START_PARTICLE, context)
	PrecacheResource("particle", BLINK_END_PARTICLE, context)
	PrecacheResource("particle", EXPLOSION_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context)
	PrecacheUnitByNameSync(PUPPET_UNIT_NAME, context)
end
function boss_faceless_5.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = PRECAST_TIME,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 0.8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = self:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, PRECAST_TIME, 10)
			end
		end,
		OnStart = function()
			return self:StartVoidDomain()
		end,
		OnFinish = function()
			return self:Cleanup()
		end,
		OnInterrupt = function()
			return self:Cleanup()
		end,
	}
end
function boss_faceless_5.prototype.StartVoidDomain(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.sequence = self.sequence + 1
	local currentSequence = self.sequence
	local startCenter = GetGroundPosition(caster:GetAbsOrigin(), caster)
	self:CreateField(startCenter, FIRST_FIELD_EXPLODE_DELAY + 0.1)
	self:Timer(FIRST_FIELD_EXPLODE_DELAY, function()
		if not self:IsCurrentSequence(currentSequence) then
			return
		end
		self:ExplodeField(startCenter)
		self:HideCaster()
		self:Timer(NEXT_ROUND_DELAY, function()
			if not self:IsCurrentSequence(currentSequence) then
				return
			end
			self:RunFieldRound(currentSequence, { "left", "right" }, function()
				self:Timer(SECOND_ROUND_DELAY, function()
					if not self:IsCurrentSequence(currentSequence) then
						return
					end
					self:RunFieldRound(currentSequence, { "up", "down" }, function()
						self:Timer(THIRD_ROUND_DELAY, function()
							if not self:IsCurrentSequence(currentSequence) then
								return
							end
							self:RunFieldRound(currentSequence, { "left", "right", "up", "down" })
						end)
					end)
				end)
			end)
		end)
	end)
end
function boss_faceless_5.prototype.RunFieldRound(self, sequence, names, afterRound)
	if not self:IsCurrentSequence(sequence) then
		return
	end
	local caster = self:GetCaster()
	local targetCenter = self:ResolveTargetCenter(caster)
	local fields = self:BuildFieldPoints(targetCenter, names)
	for ____, field in ipairs(fields) do
		local currentField = field
		self:WarningRingEffect(currentField.center, FIELD_RADIUS, WARNING_DURATION)
	end
	self:Timer(WARNING_DURATION, function()
		if not self:IsCurrentSequence(sequence) then
			return
		end
		for ____, field in ipairs(fields) do
			local currentField = field
			currentField.thinker =
				self:CreateField(currentField.center, #fields == 4 and FOUR_FIELD_DURATION or NORMAL_FIELD_DURATION)
		end
		if #fields == 4 then
			self:RunFourFieldDashes(sequence, fields, afterRound)
			return
		end
		local startField, endField = unpack(self:PickOppositeFieldPair(fields))
		self:PlayWorldParticle(
			BLINK_END_PARTICLE,
			startField.center,
			GetDirection(nil, endField.center, startField.center)
		)
		self:WarningDashPath(startField, endField)
		self:Timer(BLINK_END_TO_DASH_DELAY + DASH_EXTRA_START_DELAY, function()
			if not self:IsCurrentSequence(sequence) then
				return
			end
			self:ShowCasterAt(startField.center, endField.center)
			self:DashBetweenFields(sequence, fields, startField, endField, afterRound)
		end)
	end)
end
function boss_faceless_5.prototype.RunFourFieldDashes(self, sequence, fields, afterRound)
	local ____temp_0
	if RandomInt(0, 1) == 1 then
		____temp_0 = { "up", "down" }
	else
		____temp_0 = { "left", "right" }
	end
	local bossAxis = ____temp_0
	local ____temp_1
	if bossAxis[1] == "up" then
		____temp_1 = { "left", "right" }
	else
		____temp_1 = { "up", "down" }
	end
	local puppetAxis = ____temp_1
	local bossStartField, bossEndField = unpack(self:PickFieldPairByAxis(fields, bossAxis))
	local puppetStartField, puppetEndField = unpack(self:PickFieldPairByAxis(fields, puppetAxis))
	self:SpawnPuppetForFourFieldDash(sequence, puppetStartField, puppetEndField)
	self:PlayWorldParticle(
		BLINK_END_PARTICLE,
		bossStartField.center,
		GetDirection(nil, bossEndField.center, bossStartField.center)
	)
	self:PlayWorldParticle(
		BLINK_END_PARTICLE,
		puppetStartField.center,
		GetDirection(nil, puppetEndField.center, puppetStartField.center)
	)
	self:WarningDashPath(bossStartField, bossEndField)
	self:WarningDashPath(puppetStartField, puppetEndField)
	self:Timer(BLINK_END_TO_DASH_DELAY + DASH_EXTRA_START_DELAY, function()
		if not self:IsCurrentSequence(sequence) then
			return
		end
		local puppet = self:GetStagedPuppet()
		local totalDashCount = IsValidAlive(nil, puppet) and 2 or 1
		local finishedDashCount = 0
		local function onDashFinished()
			finishedDashCount = finishedDashCount + 1
			if finishedDashCount < totalDashCount then
				return
			end
			if not self:IsCurrentSequence(sequence) then
				return
			end
			if IsValidAlive(nil, puppet) then
				self:ReleasePuppetForCombat(puppet)
			end
			if afterRound ~= nil then
				afterRound(nil)
			end
			if not afterRound then
				self:DestroyDuration()
			end
		end
		self:ShowCasterAt(bossStartField.center, bossEndField.center)
		self:DashBetweenFields(sequence, fields, bossStartField, bossEndField, onDashFinished, false, false)
		if IsValidAlive(nil, puppet) then
			self:ShowUnitAt(puppet, puppetStartField.center, puppetEndField.center)
			self:DashBetweenFields(
				sequence,
				fields,
				puppetStartField,
				puppetEndField,
				onDashFinished,
				false,
				false,
				puppet
			)
		end
	end)
end
function boss_faceless_5.prototype.SpawnPuppetForFourFieldDash(self, sequence, startField, endField)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____opt_4 = caster.GetRoomId
	local roomId = ____opt_4 and ____opt_4(caster)
	local startPosition = GetGroundPosition(startField.center, caster)
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = PUPPET_UNIT_NAME,
		summonTag = (PUPPET_SUMMON_TAG .. "_") .. tostring(caster:entindex()),
		maxSummons = 1,
		position = startPosition,
		roomId = roomId,
		team = caster:GetTeamNumber(),
		owner = caster,
		summoner = caster,
		destroyWithSummoner = true,
		findClearSpace = true,
		onSpawn = function(____, unit)
			if not unit or not IsValid(nil, unit) or unit:IsNull() then
				return
			end
			if not self:IsCurrentSequence(sequence) then
				unit:AddNoDraw()
				MyGameUnit:DestroyUnit(unit)
				return
			end
			self.stagedPuppetIndex = unit:entindex()
			self:PreparePuppetAbilities(unit)
			unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, endField.center, startField.center))
			modifier_boss_faceless_5_void:applys(
				unit,
				caster,
				self,
				{ duration = BLINK_END_TO_DASH_DELAY + DASH_EXTRA_START_DELAY + DASH_DURATION + 0.3 }
			)
		end,
	})
end
function boss_faceless_5.prototype.PreparePuppetAbilities(self, puppet)
	puppet:RemoveModifierByName("modifier_monster_ai_wander")
	local abilityCount = puppet:GetAbilityCount()
	do
		local index = 0
		while index < abilityCount do
			do
				local currentIndex = index
				local ability = puppet:GetAbilityByIndex(currentIndex)
				if not ability then
					goto __continue48
				end
				local abilityName = ability:GetAbilityName()
				local enabled = __TS__ArrayIncludes(PUPPET_ALLOWED_ABILITY_NAMES, abilityName)
				ability:SetActivated(enabled)
				if enabled and ability:GetLevel() <= 0 then
					ability:SetLevel(1)
				end
			end
			::__continue48::
			index = index + 1
		end
	end
end
function boss_faceless_5.prototype.GetStagedPuppet(self)
	if not self.stagedPuppetIndex then
		return nil
	end
	local puppet = EntIndexToHScript(self.stagedPuppetIndex)
	if not IsValidAlive(nil, puppet) then
		return nil
	end
	return puppet
end
function boss_faceless_5.prototype.ReleasePuppetForCombat(self, puppet)
	self.stagedPuppetIndex = nil
	modifier_boss_faceless_5_void:remove(puppet)
	self:PreparePuppetAbilities(puppet)
	modifier_boss_faceless_5_puppet_lifetime:applys(
		puppet,
		self:GetCaster(),
		self,
		{ duration = PUPPET_COMBAT_DURATION }
	)
end
function boss_faceless_5.prototype.DestroyStagedPuppet(self)
	local puppet = self:GetStagedPuppet()
	self.stagedPuppetIndex = nil
	if not puppet or not IsValid(nil, puppet) or puppet:IsNull() or puppet.__remove then
		return
	end
	modifier_boss_faceless_5_void:remove(puppet)
	puppet:AddNoDraw()
	MyGameUnit:DestroyUnit(puppet)
end
function boss_faceless_5.prototype.WarningDashPath(self, startField, endField)
	self:WarningEffect(
		startField.center,
		endField.center,
		DASH_PATH_WARNING_DURATION + 0.3,
		{ startWidth = DASH_PATH_WARNING_WIDTH, endWidth = DASH_PATH_WARNING_WIDTH }
	)
end
function boss_faceless_5.prototype.DashBetweenFields(
	self,
	sequence,
	fields,
	startField,
	endField,
	afterRound,
	explodeUnusedFields,
	hideCasterAfterDash,
	dashUnit
)
	if explodeUnusedFields == nil then
		explodeUnusedFields = true
	end
	if hideCasterAfterDash == nil then
		hideCasterAfterDash = afterRound ~= nil
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local unit = dashUnit or caster
	if not IsValidAlive(nil, unit) then
		return
	end
	local dashStart = GetGroundPosition(unit:GetAbsOrigin(), unit)
	local dashEnd = self:ResolveDashEndPoint(unit, dashStart, endField.center)
	local distance = GetDistance(nil, dashStart, dashEnd)
	local ____temp_6
	if distance > 1 then
		____temp_6 = GetDirection(nil, dashEnd, dashStart)
	else
		____temp_6 = GetDirection(nil, endField.center, startField.center)
	end
	local direction = ____temp_6
	StartBossFacelessDash(nil, self, {
		dashUnit = unit,
		direction = direction,
		distance = distance,
		duration = DASH_DURATION,
		stopOnHit = false,
		stunDurationMultiplier = DASH_STUN_DURATION_MULTIPLIER,
	})
	self:Timer(START_FIELD_EXPLODE_AFTER_DASH, function()
		if not self:IsCurrentSequence(sequence) then
			return
		end
		self:ExplodeField(startField.center, startField.thinker)
	end)
	self:Timer(DASH_DURATION, function()
		if not self:IsCurrentSequence(sequence) then
			return
		end
		if hideCasterAfterDash and unit == caster then
			self:HideCaster()
		end
		self:ExplodeField(endField.center, endField.thinker)
		if explodeUnusedFields then
			self:ScheduleUnusedFieldExplosions(sequence, fields, startField, endField)
		end
		if afterRound ~= nil then
			afterRound(nil)
		end
	end)
end
function boss_faceless_5.prototype.ScheduleUnusedFieldExplosions(self, sequence, fields, startField, endField)
	local extraIndex = 0
	for ____, field in ipairs(fields) do
		do
			local currentField = field
			if currentField.name == startField.name or currentField.name == endField.name then
				goto __continue68
			end
			local currentDelay = UNUSED_FIELD_EXPLODE_INTERVAL * (extraIndex + 1)
			extraIndex = extraIndex + 1
			self:Timer(currentDelay, function()
				if not self:IsCurrentSequence(sequence) then
					return
				end
				self:ExplodeField(currentField.center, currentField.thinker)
			end)
		end
		::__continue68::
	end
end
function boss_faceless_5.prototype.ResolveTargetCenter(self, caster)
	local target = self:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
	if target and IsValidAlive(nil, target) then
		return GetGroundPosition(target:GetAbsOrigin(), target)
	end
	return GetGroundPosition(caster:GetAbsOrigin(), caster)
end
function boss_faceless_5.prototype.BuildFieldPoints(self, center, names)
	local result = {}
	for ____, name in ipairs(names) do
		local currentName = name
		result[#result + 1] = {
			name = currentName,
			center = self:OffsetPoint(center, currentName),
		}
	end
	return result
end
function boss_faceless_5.prototype.OffsetPoint(self, center, name)
	local offset = Vector(0, 0, 0)
	if name == "left" then
		offset = Vector(-FIELD_OFFSET, 0, 0)
	elseif name == "right" then
		offset = Vector(FIELD_OFFSET, 0, 0)
	elseif name == "up" then
		offset = Vector(0, FIELD_OFFSET, 0)
	else
		offset = Vector(0, -FIELD_OFFSET, 0)
	end
	local point = center:__add(offset)
	return self:ResolveFieldPoint(center, point)
end
function boss_faceless_5.prototype.ResolveFieldPoint(self, anchor, desiredPoint)
	local caster = self:GetCaster()
	local anchorPoint = GetGroundPosition(anchor, caster)
	local desiredGround = GetGroundPosition(desiredPoint, caster)
	if self:IsReachableGroundPoint(anchorPoint, desiredGround) then
		return desiredGround
	end
	local delta = desiredGround:__sub(anchorPoint)
	do
		local i = FIELD_POINT_SAMPLE_STEPS - 1
		while i >= 1 do
			local rate = i / FIELD_POINT_SAMPLE_STEPS
			local candidate = GetGroundPosition(anchorPoint:__add(delta:__mul(rate)), caster)
			if self:IsReachableGroundPoint(anchorPoint, candidate) then
				return candidate
			end
			i = i - 1
		end
	end
	return anchorPoint
end
function boss_faceless_5.prototype.ResolveDashEndPoint(self, unit, startPoint, desiredEndPoint)
	local startGround = GetGroundPosition(startPoint, unit)
	local desiredGround = GetGroundPosition(desiredEndPoint, unit)
	local delta = desiredGround:__sub(startGround)
	local safePoint = startGround
	do
		local i = 1
		while i <= DASH_POINT_SAMPLE_STEPS do
			local rate = i / DASH_POINT_SAMPLE_STEPS
			local candidate = GetGroundPosition(startGround:__add(delta:__mul(rate)), unit)
			if not self:IsReachableGroundPoint(startGround, candidate) then
				break
			end
			safePoint = candidate
			i = i + 1
		end
	end
	return safePoint
end
function boss_faceless_5.prototype.IsReachableGroundPoint(self, origin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not IsGridNavDisplacementWalkable(nil, origin) then
		return true
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	return GridNav:FindPathLength(origin, point) ~= -1
end
function boss_faceless_5.prototype.PickOppositeFieldPair(self, fields)
	local ____temp_9
	if #fields == 4 and RandomInt(0, 1) == 1 then
		____temp_9 = { "up", "down" }
	else
		____temp_9 = { "left", "right" }
	end
	local axis = ____temp_9
	return self:PickFieldPairByAxis(fields, axis)
end
function boss_faceless_5.prototype.PickFieldPairByAxis(self, fields, axis)
	local first = __TS__ArrayFind(fields, function(____, field)
		return field.name == axis[1]
	end) or fields[1]
	local second = __TS__ArrayFind(fields, function(____, field)
		return field.name == axis[2]
	end) or fields[2]
	if RandomInt(0, 1) == 1 then
		return { second, first }
	end
	return { first, second }
end
function boss_faceless_5.prototype.CreateField(self, center, duration)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	AddFOWViewer(caster:GetTeamNumber(), center, FIELD_RADIUS, duration, false)
	caster:EmitSound(SOUND_CHRONOSPHERE_CAST)
	return CreateModifierThinker(
		caster,
		self,
		MODIFIER_CHRONOSPHERE_AURA,
		{ duration = duration, radius = FIELD_RADIUS },
		center,
		caster:GetTeamNumber(),
		false
	)
end
function boss_faceless_5.prototype.ExplodeField(self, center, thinker)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local particle = ParticleManager:CreateParticle(EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, center)
	ParticleManager:SetParticleControl(particle, 1, center:__add(Vector(FIELD_RADIUS, 0, 16)))
	ParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOnLocationWithCaster(center, SOUND_EXPLOSION, caster)
	ScreenShake(
		center,
		EXPLOSION_SHAKE_AMPLITUDE,
		EXPLOSION_SHAKE_FREQUENCY,
		EXPLOSION_SHAKE_DURATION,
		EXPLOSION_SHAKE_RADIUS,
		0,
		true
	)
	if thinker and IsValid(nil, thinker) and not thinker:IsNull() then
		thinker:RemoveSelf()
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		FIELD_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy == caster then
				goto __continue104
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
		end
		::__continue104::
	end
end
function boss_faceless_5.prototype.HideCaster(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlayWorldParticle(BLINK_START_PARTICLE, caster:GetAbsOrigin(), caster:GetForwardVector())
	EmitSoundOn(SOUND_VOID_OUT, caster)
	modifier_boss_faceless_5_void:applys(caster, caster, self, { duration = CAST_DURATION })
end
function boss_faceless_5.prototype.ShowCasterAt(self, startCenter, endCenter)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:ShowUnitAt(caster, startCenter, endCenter)
end
function boss_faceless_5.prototype.ShowUnitAt(self, unit, startCenter, endCenter)
	if not IsValidAlive(nil, unit) then
		return
	end
	modifier_boss_faceless_5_void:remove(unit)
	local startPosition = GetGroundPosition(startCenter, unit)
	FindClearSpaceForUnit(unit, startPosition, true)
	unit:SetForwardVector(GetDirection(nil, endCenter, startCenter))
	EmitSoundOn(SOUND_VOID_IN, unit)
end
function boss_faceless_5.prototype.PlayWorldParticle(self, particleName, origin, direction)
	local particle = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 3, origin)
	ParticleManager:SetParticleControlForward(particle, 0, direction)
	ParticleManager:SetParticleControlForward(particle, 3, direction)
	ParticleManager:ReleaseParticleIndex(particle)
end
function boss_faceless_5.prototype.IsCurrentSequence(self, sequence)
	return sequence == self.sequence and IsValidAlive(nil, self:GetCaster())
end
function boss_faceless_5.prototype.Cleanup(self)
	self.sequence = self.sequence + 1
	self:DestroyStagedPuppet()
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		modifier_boss_faceless_5_void:remove(caster)
	end
end
boss_faceless_5 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_faceless_5)
____exports.boss_faceless_5 = boss_faceless_5
--- Boss 穿梭期间的隐身状态：不可见、无敌、不可选中
modifier_boss_faceless_5_void = __TS__Class()
modifier_boss_faceless_5_void.name = "modifier_boss_faceless_5_void"
__TS__ClassExtends(modifier_boss_faceless_5_void, MonsterModifier_CS)
function modifier_boss_faceless_5_void.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:AddNoDrawWithWearables()
	end
end
function modifier_boss_faceless_5_void.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveNoDrawWithWearables()
	end
end
function modifier_boss_faceless_5_void.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end
function modifier_boss_faceless_5_void.prototype.IsHidden(self)
	return true
end
function modifier_boss_faceless_5_void.prototype.IsPurgable(self)
	return false
end
modifier_boss_faceless_5_void =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_faceless_5_void") }, modifier_boss_faceless_5_void)
--- 虚空傀儡寿命控制：战斗行为完全交给 boss_ai
modifier_boss_faceless_5_puppet_lifetime = __TS__Class()
modifier_boss_faceless_5_puppet_lifetime.name = "modifier_boss_faceless_5_puppet_lifetime"
__TS__ClassExtends(modifier_boss_faceless_5_puppet_lifetime, MonsterModifier_CS)
function modifier_boss_faceless_5_puppet_lifetime.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local puppet = self:GetParent()
	local owner = self:GetCaster()
	if not IsValidAlive(nil, puppet) or not IsValidAlive(nil, owner) then
		self:Destroy()
	end
end
function modifier_boss_faceless_5_puppet_lifetime.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local puppet = self:GetParent()
	if not IsValid(nil, puppet) or puppet:IsNull() or puppet.__remove or not puppet:IsAlive() then
		return
	end
	puppet:ForceKill(false)
end
function modifier_boss_faceless_5_puppet_lifetime.prototype.IsHidden(self)
	return true
end
function modifier_boss_faceless_5_puppet_lifetime.prototype.IsPurgable(self)
	return false
end
function modifier_boss_faceless_5_puppet_lifetime.prototype.RemoveOnDeath(self)
	return true
end
modifier_boss_faceless_5_puppet_lifetime = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_faceless_5_puppet_lifetime") },
	modifier_boss_faceless_5_puppet_lifetime
)
return ____exports