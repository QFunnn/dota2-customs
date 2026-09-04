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
local ____exports = {}
local setupSoldierBase, ApplyMonkeySoldierPetrifiedState, MONKEY_SOLDIER_OWNER_KEY
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local warningEffectRing = ____monster_base.warningEffectRing
function setupSoldierBase(self, soldier, caster)
	if not IsValidAlive(nil, soldier) then
		return
	end
	soldier[MONKEY_SOLDIER_OWNER_KEY] = caster:entindex()
	soldier:RemoveModifierByName("imba_void_underlord_walk")
end
function ____exports.PetrifyMonkeySoldier(self, soldier, caster, ability)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, soldier) then
		return
	end
	if not IsValid(nil, soldier) or soldier:IsNull() then
		return
	end
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_return_home.name)
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_ab2_leap.name)
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_active.name)
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_guard_counter.name)
	ApplyMonkeySoldierPetrifiedState(nil, soldier, caster, ability)
end
function ApplyMonkeySoldierPetrifiedState(self, soldier, caster, ability)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, soldier) then
		return
	end
	if not IsValid(nil, soldier) or soldier:IsNull() then
		return
	end
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_petrified.name)
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_stone_visual.name)
	soldier:StopAnimation()
	____exports.modifier_monkey_soldier_petrified:applys(soldier, caster, ability, { duration = -1 })
	____exports.modifier_monkey_soldier_stone_visual:applys(soldier, caster, ability, { duration = -1 })
	soldier:SetHealth(soldier:GetMaxHealth())
	setupSoldierBase(nil, soldier, caster)
end
____exports.MONKEY_SOLDIER_COUNT = 5
____exports.MONKEY_SOLDIER_UNIT_NAME = "monster_11027"
____exports.MONKEY_SOLDIER_SUMMON_TAG = "boss_monkey_petrified_soldier"
____exports.MONKEY_SOLDIER_STATUS_EFFECT =
	"particles/econ/items/monkey_king/mk_ti9_immortal/status_effect_mk_ti9_immortal_army.vpcf"
____exports.MONKEY_SOLDIER_ACTIVITY = "fur_army_soldier"
local MONKEY_SOLDIER_SPAWN_DISTANCE = 500
local MONKEY_SOLDIER_ACTIVE_HEALTH_RATE = 0.1
local MONKEY_SOLDIER_HEALTH_CHECK_INTERVAL = 0.1
local MONKEY_SOLDIER_TARGET_SEARCH_RADIUS = 3000
local MONKEY_SOLDIER_AB2_PREPARE_DURATION = 0.3
local MONKEY_SOLDIER_AB2_LEAP_DURATION = 0.5
local MONKEY_SOLDIER_AB2_LEAP_HEIGHT = 450
local MONKEY_SOLDIER_AB2_MOVE_INTERVAL = 0.03
local MONKEY_SOLDIER_AB2_START_ANIMATION = "mk_cast_treejump"
local MONKEY_SOLDIER_AB2_SOAR_ANIMATION = "cast04_spring_jumping_soar"
local MONKEY_SOLDIER_AB2_END_ANIMATION = "cast04_spring_jumping_end"
local MONKEY_SOLDIER_RETURN_HOME_SPEED = 420
local MONKEY_SOLDIER_RETURN_HOME_INTERVAL = 0.03
local MONKEY_SOLDIER_RETURN_HOME_ARRIVE_DISTANCE = 24
local MONKEY_SOLDIER_GUARD_RADIUS = 150
local MONKEY_SOLDIER_GUARD_ATTACK_RADIUS = 100
local MONKEY_SOLDIER_GUARD_COOLDOWN = 2
local MONKEY_SOLDIER_GUARD_CHECK_INTERVAL = 0.1
local MONKEY_SOLDIER_GUARD_DAMAGE_RATE = 5
local MONKEY_SOLDIER_GUARD_DAMAGE_TIME = 0.6
local MONKEY_SOLDIER_GUARD_DURATION = 1.73
local MONKEY_SOLDIER_GUARD_ATTACK_ANIMATION = "mk_attack_06_fastest_cudgel"
local MONKEY_SOLDIER_GUARD_REVEAL_SOUND = "Hero_MonkeyKing.Spring.Target"
local MONKEY_SOLDIER_GUARD_ATTACK_SOUND = "Hero_MonkeyKing.Attack"
local MONKEY_SOLDIER_AB2_JUMP_SOUND = "Hero_MonkeyKing.TreeJump.Cast"
local MONKEY_SOLDIER_POOL_KEY = "__monkey_soldier_entindexes__"
local MONKEY_SOLDIER_PENDING_KEY = "__monkey_soldier_pending_count__"
MONKEY_SOLDIER_OWNER_KEY = "__monkey_soldier_owner_entindex__"
local MONKEY_SOLDIER_HOME_POSITION_KEY = "__monkey_soldier_home_position__"
local MONKEY_SOLDIER_HOME_FORWARD_KEY = "__monkey_soldier_home_forward__"
local function getSoldierIndexes(self, caster)
	local indexes = caster[MONKEY_SOLDIER_POOL_KEY]
	if indexes then
		return indexes
	end
	local created = {}
	caster[MONKEY_SOLDIER_POOL_KEY] = created
	return created
end
local function setPendingCount(self, caster, count)
	caster[MONKEY_SOLDIER_PENDING_KEY] = math.max(0, count)
end
local function getPendingCount(self, caster)
	return caster[MONKEY_SOLDIER_PENDING_KEY] or 0
end
local function cloneVector(self, vector)
	return Vector(vector.x, vector.y, vector.z)
end
local function resolveSpawnPosition(self, caster, index)
	local directions = GetRotateVectors(
		nil,
		caster:GetForwardVector(),
		____exports.MONKEY_SOLDIER_COUNT,
		360 / ____exports.MONKEY_SOLDIER_COUNT
	)
	local direction = directions[index + 1] or caster:GetForwardVector()
	return GetGroundPosition(caster:GetAbsOrigin():__add(direction:__mul(MONKEY_SOLDIER_SPAWN_DISTANCE)), caster)
end
local function getOutwardDirection(self, caster, position)
	local direction = position:__sub(caster:GetAbsOrigin())
	direction.z = 0
	if direction:Length2D() <= 0.01 then
		return caster:GetForwardVector()
	end
	return direction:Normalized()
end
local function setSoldierHome(self, soldier, position, forward)
	soldier[MONKEY_SOLDIER_HOME_POSITION_KEY] = cloneVector(nil, position)
	soldier[MONKEY_SOLDIER_HOME_FORWARD_KEY] = cloneVector(nil, forward)
end
local function getSoldierHomePosition(self, soldier)
	local position = soldier[MONKEY_SOLDIER_HOME_POSITION_KEY]
	local ____position_0
	if position then
		____position_0 = cloneVector(nil, position)
	else
		____position_0 = nil
	end
	return ____position_0
end
local function getSoldierHomeForward(self, soldier)
	local forward = soldier[MONKEY_SOLDIER_HOME_FORWARD_KEY]
	local ____forward_1
	if forward then
		____forward_1 = cloneVector(nil, forward)
	else
		____forward_1 = nil
	end
	return ____forward_1
end
local function findGuardCounterTarget(self, soldier)
	if not IsValidAlive(nil, soldier) then
		return
	end
	local enemies = FindUnitsInRadius(
		soldier:GetTeamNumber(),
		soldier:GetAbsOrigin(),
		nil,
		MONKEY_SOLDIER_GUARD_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			return enemy
		end
	end
	return nil
end
function ____exports.FindMonkeySoldierNearestEnemyHeroPosition(self, caster, center)
	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		MONKEY_SOLDIER_TARGET_SEARCH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, hero in ipairs(heroes) do
		if IsValidAlive(nil, hero) then
			return hero:GetAbsOrigin()
		end
	end
	return nil
end
function ____exports.GetMonkeySoldiers(self, caster)
	if not IsValid(nil, caster) or caster:IsNull() then
		return {}
	end
	local indexes = getSoldierIndexes(nil, caster)
	local soldiers = {}
	local validIndexes = {}
	for ____, index in ipairs(indexes) do
		do
			local soldier = EntIndexToHScript(index)
			if not IsValid(nil, soldier) or soldier:IsNull() or soldier.__remove then
				goto __continue26
			end
			if soldier[MONKEY_SOLDIER_OWNER_KEY] ~= caster:entindex() then
				goto __continue26
			end
			soldiers[#soldiers + 1] = soldier
			validIndexes[#validIndexes + 1] = index
		end
		::__continue26::
	end
	caster[MONKEY_SOLDIER_POOL_KEY] = validIndexes
	return soldiers
end
function ____exports.EnsureMonkeySoldiers(self, caster, ability)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local soldiers = ____exports.GetMonkeySoldiers(nil, caster)
	local pendingCount = getPendingCount(nil, caster)
	local missingCount = ____exports.MONKEY_SOLDIER_COUNT - #soldiers - pendingCount
	if missingCount <= 0 then
		return
	end
	local ____this_3
	____this_3 = caster
	local ____opt_2 = ____this_3.GetRoomId
	local roomId = ____opt_2 and ____opt_2(____this_3)
	do
		local i = 0
		while i < missingCount do
			local currentIndex = #soldiers + pendingCount + i
			local spawnPos = resolveSpawnPosition(nil, caster, currentIndex)
			setPendingCount(nil, caster, getPendingCount(nil, caster) + 1)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = ____exports.MONKEY_SOLDIER_UNIT_NAME,
				summonTag = ____exports.MONKEY_SOLDIER_SUMMON_TAG,
				maxSummons = ____exports.MONKEY_SOLDIER_COUNT,
				replaceOldestWhenFull = false,
				position = spawnPos,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = true,
				onSpawn = function(____, unit)
					setPendingCount(nil, caster, getPendingCount(nil, caster) - 1)
					if not unit or not IsValid(nil, unit) or unit:IsNull() then
						return
					end
					if not IsValidAlive(nil, caster) then
						MyGameUnit:DestroyUnit(unit)
						return
					end
					setupSoldierBase(nil, unit, caster)
					local homePosition = unit:GetAbsOrigin()
					local homeForward = getOutwardDirection(nil, caster, homePosition)
					setSoldierHome(nil, unit, homePosition, homeForward)
					unit:SetForwardVectorWithoutInterrupt(homeForward)
					local indexes = getSoldierIndexes(nil, caster)
					indexes[#indexes + 1] = unit:entindex()
					____exports.PetrifyMonkeySoldier(nil, unit, caster, ability)
				end,
			})
			i = i + 1
		end
	end
end
function ____exports.ArrangeMonkeySoldiers(self, caster, soldiers, distance)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____GetRotateVectors_7 = GetRotateVectors
	local ____temp_5 = caster:GetForwardVector()
	local ____temp_6 = #soldiers
	local ____temp_4
	if #soldiers > 0 then
		____temp_4 = 360 / #soldiers
	else
		____temp_4 = 0
	end
	local directions = ____GetRotateVectors_7(nil, ____temp_5, ____temp_6, ____temp_4)
	do
		local i = 0
		while i < #soldiers do
			do
				local soldier = soldiers[i + 1]
				if not IsValidAlive(nil, soldier) then
					goto __continue41
				end
				local direction = directions[i + 1] or caster:GetForwardVector()
				local targetPos = GetGroundPosition(caster:GetAbsOrigin():__add(direction:__mul(distance)), caster)
				soldier:SetAbsOrigin(targetPos)
				FindClearSpaceForUnit(soldier, targetPos, true)
				soldier:SetForwardVectorWithoutInterrupt(getOutwardDirection(nil, caster, targetPos))
				setupSoldierBase(nil, soldier, caster)
			end
			::__continue41::
			i = i + 1
		end
	end
end
function ____exports.ReturnMonkeySoldierToHomeAndPetrify(self, soldier, caster, ability)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, soldier) then
		return
	end
	if not IsValid(nil, soldier) or soldier:IsNull() then
		return
	end
	local homePosition = getSoldierHomePosition(nil, soldier)
	if not homePosition then
		____exports.PetrifyMonkeySoldier(nil, soldier, caster, ability)
		return
	end
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_ab2_leap.name)
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_active.name)
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_petrified.name)
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_stone_visual.name)
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_guard_counter.name)
	if not soldier:HasModifier(____exports.modifier_monkey_soldier_return_home.name) then
		____exports.modifier_monkey_soldier_return_home:applys(soldier, caster, ability, { duration = -1 })
	end
end
function ____exports.ActivateMonkeySoldier(self, soldier, caster, ability)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, soldier) or not IsValidAlive(nil, caster) then
		return
	end
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_petrified.name)
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_stone_visual.name)
	soldier:RemoveModifierByName(____exports.modifier_monkey_soldier_guard_counter.name)
	if not soldier:HasModifier(____exports.modifier_monkey_soldier_active.name) then
		____exports.modifier_monkey_soldier_active:applys(soldier, caster, ability, { duration = -1 })
	end
	setupSoldierBase(nil, soldier, caster)
end
function ____exports.StartMonkeySoldierAb2Leap(self, soldier, caster, ability, targetPos)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, soldier) or not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(MONKEY_SOLDIER_AB2_JUMP_SOUND, soldier)
	____exports.modifier_monkey_soldier_ab2_leap:applys(
		soldier,
		caster,
		ability,
		{ target_x = targetPos.x, target_y = targetPos.y, target_z = targetPos.z }
	)
end
function ____exports.ResetMonkeySoldiers(self, caster, ability)
	local soldiers = ____exports.GetMonkeySoldiers(nil, caster)
	for ____, soldier in ipairs(soldiers) do
		____exports.PetrifyMonkeySoldier(nil, soldier, caster, ability)
	end
end
function ____exports.CleanupMonkeySoldiers(self, caster)
	if not IsServer() then
		return
	end
	local soldiers = ____exports.GetMonkeySoldiers(nil, caster)
	for ____, soldier in ipairs(soldiers) do
		do
			if not IsValid(nil, soldier) or soldier:IsNull() or soldier.__remove then
				goto __continue69
			end
			MyGameUnit:DestroyUnit(soldier)
		end
		::__continue69::
	end
	caster[MONKEY_SOLDIER_POOL_KEY] = {}
	caster[MONKEY_SOLDIER_PENDING_KEY] = 0
end
____exports.modifier_monkey_soldier_petrified = __TS__Class()
local modifier_monkey_soldier_petrified = ____exports.modifier_monkey_soldier_petrified
modifier_monkey_soldier_petrified.name = "modifier_monkey_soldier_petrified"
__TS__ClassExtends(modifier_monkey_soldier_petrified, MonsterModifier_CS)
function modifier_monkey_soldier_petrified.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.guardCooldownRemaining = 0
end
function modifier_monkey_soldier_petrified.prototype.IsHidden(self)
	return true
end
function modifier_monkey_soldier_petrified.prototype.IsPurgable(self)
	return false
end
function modifier_monkey_soldier_petrified.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_monkey_soldier_petrified.prototype.GetActivityTranslationModifiers(self)
	return ____exports.MONKEY_SOLDIER_ACTIVITY
end
function modifier_monkey_soldier_petrified.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(MONKEY_SOLDIER_GUARD_CHECK_INTERVAL)
end
function modifier_monkey_soldier_petrified.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	if self.guardCooldownRemaining > 0 then
		self.guardCooldownRemaining = math.max(0, self.guardCooldownRemaining - MONKEY_SOLDIER_GUARD_CHECK_INTERVAL)
		return
	end
	if parent:HasModifier(____exports.modifier_monkey_soldier_guard_counter.name) then
		return
	end
	local target = findGuardCounterTarget(nil, parent)
	if not IsValidAlive(nil, target) then
		return
	end
	if not target then
		return
	end
	self.guardCooldownRemaining = MONKEY_SOLDIER_GUARD_COOLDOWN
	local targetPos = target:GetAbsOrigin()
	____exports.modifier_monkey_soldier_guard_counter:applys(
		parent,
		caster,
		self:GetAbility(),
		{
			duration = MONKEY_SOLDIER_GUARD_DURATION,
			target_x = targetPos.x,
			target_y = targetPos.y,
			target_z = targetPos.z,
		}
	)
end
function modifier_monkey_soldier_petrified.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end
modifier_monkey_soldier_petrified = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_soldier_petrified)
____exports.modifier_monkey_soldier_petrified = modifier_monkey_soldier_petrified
____exports.modifier_monkey_soldier_stone_visual = __TS__Class()
local modifier_monkey_soldier_stone_visual = ____exports.modifier_monkey_soldier_stone_visual
modifier_monkey_soldier_stone_visual.name = "modifier_monkey_soldier_stone_visual"
__TS__ClassExtends(modifier_monkey_soldier_stone_visual, MonsterModifier_CS)
function modifier_monkey_soldier_stone_visual.prototype.IsHidden(self)
	return true
end
function modifier_monkey_soldier_stone_visual.prototype.IsPurgable(self)
	return false
end
function modifier_monkey_soldier_stone_visual.prototype.GetStatusEffectName(self)
	return ____exports.MONKEY_SOLDIER_STATUS_EFFECT
end
modifier_monkey_soldier_stone_visual =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_soldier_stone_visual)
____exports.modifier_monkey_soldier_stone_visual = modifier_monkey_soldier_stone_visual
____exports.modifier_monkey_soldier_guard_counter = __TS__Class()
local modifier_monkey_soldier_guard_counter = ____exports.modifier_monkey_soldier_guard_counter
modifier_monkey_soldier_guard_counter.name = "modifier_monkey_soldier_guard_counter"
__TS__ClassExtends(modifier_monkey_soldier_guard_counter, MonsterModifier_CS)
function modifier_monkey_soldier_guard_counter.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.hasRestoredVisual = false
end
function modifier_monkey_soldier_guard_counter.prototype.IsHidden(self)
	return true
end
function modifier_monkey_soldier_guard_counter.prototype.IsPurgable(self)
	return false
end
function modifier_monkey_soldier_guard_counter.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	if params.target_x == nil or params.target_y == nil or params.target_z == nil then
		self:Destroy()
		return
	end
	self.targetPos = Vector(params.target_x, params.target_y, params.target_z)
	self.originPos = cloneVector(nil, parent:GetAbsOrigin())
	parent:RemoveModifierByName(____exports.modifier_monkey_soldier_stone_visual.name)
	EmitSoundOn(MONKEY_SOLDIER_GUARD_REVEAL_SOUND, parent)
	local direction = self.targetPos:__sub(parent:GetAbsOrigin())
	direction.z = 0
	if direction:Length2D() > 0.01 then
		parent:SetForwardVectorWithoutInterrupt(direction:Normalized())
	end
	warningEffectRing(
		nil,
		parent,
		self.targetPos,
		MONKEY_SOLDIER_GUARD_ATTACK_RADIUS,
		MONKEY_SOLDIER_GUARD_DAMAGE_TIME,
		{ speed = 0 }
	)
	parent:SetAnimation(MONKEY_SOLDIER_GUARD_ATTACK_ANIMATION)
	self:Timer(MONKEY_SOLDIER_GUARD_DAMAGE_TIME, function()
		return self:ApplyCounterDamage()
	end)
	self:Timer(MONKEY_SOLDIER_GUARD_DURATION, function()
		return self:Destroy()
	end)
end
function modifier_monkey_soldier_guard_counter.prototype.ApplyCounterDamage(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) or not self.targetPos then
		return
	end
	EmitSoundOnLocationWithCaster(self.targetPos, MONKEY_SOLDIER_GUARD_ATTACK_SOUND, caster)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		self.targetPos,
		nil,
		MONKEY_SOLDIER_GUARD_ATTACK_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = MONKEY_SOLDIER_GUARD_DAMAGE_RATE,
				ability = self:GetAbility(),
			})
		end
	end
	if not parent:HasModifier(____exports.modifier_monkey_soldier_stone_visual.name) then
		____exports.modifier_monkey_soldier_stone_visual:applys(parent, caster, self:GetAbility(), { duration = -1 })
	end
	self.hasRestoredVisual = true
end
function modifier_monkey_soldier_guard_counter.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:StopAnimation()
	if self.originPos and IsValidAlive(nil, parent) then
		parent:SetAbsOrigin(self.originPos)
		FindClearSpaceForUnit(parent, self.originPos, true)
	end
	if
		not self.hasRestoredVisual
		and IsValidAlive(nil, caster)
		and not parent:HasModifier(____exports.modifier_monkey_soldier_stone_visual.name)
	then
		____exports.modifier_monkey_soldier_stone_visual:applys(parent, caster, self:GetAbility(), { duration = -1 })
	end
end
modifier_monkey_soldier_guard_counter =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_soldier_guard_counter)
____exports.modifier_monkey_soldier_guard_counter = modifier_monkey_soldier_guard_counter
____exports.modifier_monkey_soldier_active = __TS__Class()
local modifier_monkey_soldier_active = ____exports.modifier_monkey_soldier_active
modifier_monkey_soldier_active.name = "modifier_monkey_soldier_active"
__TS__ClassExtends(modifier_monkey_soldier_active, MonsterModifier_CS)
function modifier_monkey_soldier_active.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.isReturningHome = false
end
function modifier_monkey_soldier_active.prototype.IsHidden(self)
	return true
end
function modifier_monkey_soldier_active.prototype.IsPurgable(self)
	return false
end
function modifier_monkey_soldier_active.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetHealth(parent:GetMaxHealth())
	self:StartIntervalThink(MONKEY_SOLDIER_HEALTH_CHECK_INTERVAL)
end
function modifier_monkey_soldier_active.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_MIN_HEALTH_TRIGGER }
end
function modifier_monkey_soldier_active.prototype.GetAttributeBonus(self)
	return { min_health = 1 }
end
function modifier_monkey_soldier_active.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	if parent:GetHealth() <= parent:GetMaxHealth() * MONKEY_SOLDIER_ACTIVE_HEALTH_RATE then
		self:StartReturnHome(parent, caster)
	end
end
function modifier_monkey_soldier_active.prototype.OnMinHealthTrigger_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if event.victim ~= parent then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) then
		return
	end
	self:StartReturnHome(parent, caster)
end
function modifier_monkey_soldier_active.prototype.StartReturnHome(self, parent, caster)
	if self.isReturningHome then
		return
	end
	self.isReturningHome = true
	____exports.ReturnMonkeySoldierToHomeAndPetrify(nil, parent, caster, self:GetAbility())
end
function modifier_monkey_soldier_active.prototype.CheckState(self)
	return {}
end
modifier_monkey_soldier_active = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_soldier_active)
____exports.modifier_monkey_soldier_active = modifier_monkey_soldier_active
____exports.modifier_monkey_soldier_return_home = __TS__Class()
local modifier_monkey_soldier_return_home = ____exports.modifier_monkey_soldier_return_home
modifier_monkey_soldier_return_home.name = "modifier_monkey_soldier_return_home"
__TS__ClassExtends(modifier_monkey_soldier_return_home, MonsterModifier_CS)
function modifier_monkey_soldier_return_home.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.completed = false
end
function modifier_monkey_soldier_return_home.prototype.IsHidden(self)
	return true
end
function modifier_monkey_soldier_return_home.prototype.IsPurgable(self)
	return false
end
function modifier_monkey_soldier_return_home.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	self.targetPos = getSoldierHomePosition(nil, parent)
	self.targetForward = getSoldierHomeForward(nil, parent)
	if not self.targetPos then
		self:Destroy()
		return
	end
	parent:SetHealth(parent:GetMaxHealth())
	self:StartIntervalThink(MONKEY_SOLDIER_RETURN_HOME_INTERVAL)
end
function modifier_monkey_soldier_return_home.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_monkey_soldier_return_home.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
function modifier_monkey_soldier_return_home.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) or not self.targetPos then
		self:Destroy()
		return
	end
	local currentPos = parent:GetAbsOrigin()
	local toTarget = self.targetPos:__sub(currentPos)
	toTarget.z = 0
	local distance = toTarget:Length2D()
	if distance <= MONKEY_SOLDIER_RETURN_HOME_ARRIVE_DISTANCE then
		parent:SetAbsOrigin(self.targetPos)
		FindClearSpaceForUnit(parent, self.targetPos, true)
		if self.targetForward then
			parent:SetForwardVectorWithoutInterrupt(self.targetForward)
		end
		self.completed = true
		self:Destroy()
		return
	end
	local direction = toTarget:Normalized()
	local stepDistance = math.min(distance, MONKEY_SOLDIER_RETURN_HOME_SPEED * MONKEY_SOLDIER_RETURN_HOME_INTERVAL)
	local nextPos = GetGroundPosition(currentPos:__add(direction:__mul(stepDistance)), parent)
	parent:SetAbsOrigin(nextPos)
	parent:SetForwardVectorWithoutInterrupt(direction)
end
function modifier_monkey_soldier_return_home.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:StopAnimation()
	local caster = self:GetCaster()
	if self.completed and IsValidAlive(nil, caster) then
		local ability = self:GetAbility()
		Timers:CreateTimer(FrameTime() * 5, function()
			if not IsValidAlive(nil, parent) then
				return
			end
			if not IsValid(nil, parent) or parent:IsNull() or parent.__remove then
				return
			end
			if not IsValidAlive(nil, caster) then
				return
			end
			if parent:HasModifier(____exports.modifier_monkey_soldier_active.name) then
				return
			end
			if parent:HasModifier(____exports.modifier_monkey_soldier_ab2_leap.name) then
				return
			end
			if parent:HasModifier(____exports.modifier_monkey_soldier_return_home.name) then
				return
			end
			ApplyMonkeySoldierPetrifiedState(nil, parent, caster, ability)
		end)
	end
end
function modifier_monkey_soldier_return_home.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end
modifier_monkey_soldier_return_home =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_soldier_return_home)
____exports.modifier_monkey_soldier_return_home = modifier_monkey_soldier_return_home
____exports.modifier_monkey_soldier_ab2_leap = __TS__Class()
local modifier_monkey_soldier_ab2_leap = ____exports.modifier_monkey_soldier_ab2_leap
modifier_monkey_soldier_ab2_leap.name = "modifier_monkey_soldier_ab2_leap"
__TS__ClassExtends(modifier_monkey_soldier_ab2_leap, MonsterModifier_CS)
function modifier_monkey_soldier_ab2_leap.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.elapsed = 0
	self.isLeaping = false
end
function modifier_monkey_soldier_ab2_leap.prototype.IsHidden(self)
	return true
end
function modifier_monkey_soldier_ab2_leap.prototype.IsPurgable(self)
	return false
end
function modifier_monkey_soldier_ab2_leap.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local targetX = params.target_x or parent:GetAbsOrigin().x
	local targetY = params.target_y or parent:GetAbsOrigin().y
	local targetZ = params.target_z or parent:GetAbsOrigin().z
	self.targetPos = GetGroundPosition(Vector(targetX, targetY, targetZ), parent)
	parent:SetForwardVectorWithoutInterrupt(GetDirection(nil, self.targetPos, parent:GetAbsOrigin()))
	parent:SetAnimation(MONKEY_SOLDIER_AB2_START_ANIMATION)
	self:Timer(MONKEY_SOLDIER_AB2_PREPARE_DURATION, function()
		if not IsValidAlive(nil, parent) or not self.targetPos then
			self:Destroy()
			return
		end
		self.startPos = parent:GetAbsOrigin()
		self.elapsed = 0
		self.isLeaping = true
		parent:SetAnimation(MONKEY_SOLDIER_AB2_SOAR_ANIMATION)
		self:StartIntervalThink(MONKEY_SOLDIER_AB2_MOVE_INTERVAL)
	end)
end
function modifier_monkey_soldier_ab2_leap.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not self.startPos or not self.targetPos then
		self:Destroy()
		return
	end
	self.elapsed = self.elapsed + MONKEY_SOLDIER_AB2_MOVE_INTERVAL
	local progress = math.min(self.elapsed / MONKEY_SOLDIER_AB2_LEAP_DURATION, 1)
	local horizontal = self.startPos:__add(self.targetPos:__sub(self.startPos):__mul(progress))
	local height = MONKEY_SOLDIER_AB2_LEAP_HEIGHT * 4 * progress * (1 - progress)
	parent:SetAbsOrigin(Vector(horizontal.x, horizontal.y, horizontal.z + height))
	if progress >= 1 then
		parent:SetAbsOrigin(self.targetPos)
		FindClearSpaceForUnit(parent, self.targetPos, true)
		parent:SetAnimation(MONKEY_SOLDIER_AB2_END_ANIMATION)
		self:StartIntervalThink(-1)
		self:Timer(0.2, function()
			return self:Destroy()
		end)
	end
end
function modifier_monkey_soldier_ab2_leap.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:StopAnimation()
end
function modifier_monkey_soldier_ab2_leap.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_COMMAND_RESTRICTED] = true }
end
modifier_monkey_soldier_ab2_leap = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_soldier_ab2_leap)
____exports.modifier_monkey_soldier_ab2_leap = modifier_monkey_soldier_ab2_leap
return ____exports