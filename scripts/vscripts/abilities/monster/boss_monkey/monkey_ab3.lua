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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____monkey_movement = require("abilities.monster.boss_monkey.monkey_movement")
local ResolveMonkeyBlinkPoint = ____monkey_movement.ResolveMonkeyBlinkPoint
local MONKEY_AB3_CAST_POINT = 1.6
local MONKEY_AB3_CAST_DURATION = 3.4
local MONKEY_AB3_DUMMY_NAME = "monster_12015"
local MONKEY_AB3_DUMMY_COUNT = 5
local MONKEY_AB3_DUMMY_DISTANCE = 300
local MONKEY_AB3_DUMMY_DURATION = 2.6
local MONKEY_AB3_DUMMY_ANGLE_INTERVAL = 360 / MONKEY_AB3_DUMMY_COUNT
local MONKEY_AB3_DUMMY_ROTATE_ANGLE = 30
local MONKEY_AB3_STRIKE_LENGTH = 1300
local MONKEY_AB3_STRIKE_WIDTH = 150
local MONKEY_AB3_STRIKE_DAMAGE = 32
local MONKEY_AB3_RELEASE_KNOCKBACK_RADIUS = 400
local MONKEY_AB3_RELEASE_KNOCKBACK_DISTANCE = 400
local MONKEY_AB3_RELEASE_KNOCKBACK_DURATION = 0.3
local MONKEY_AB3_RELEASE_KNOCKBACK_HEIGHT = 0
____exports.monkey_ab3 = __TS__Class()
local monkey_ab3 = ____exports.monkey_ab3
monkey_ab3.name = "monkey_ab3"
__TS__ClassExtends(monkey_ab3, MonsterAbility_CS)
function monkey_ab3.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.dummies = {}
	self.castToken = 0
end
function monkey_ab3.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = MONKEY_AB3_CAST_POINT,
		castDuration = MONKEY_AB3_CAST_DURATION,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:SetAnimation("mk_cast_fur_army_cp_effigy")
			caster:EmitSound("Hero_MonkeyKing.FurArmy.Channel")
		end,
		OnStart = function()
			self:StartFurArmy()
		end,
		OnFinish = function()
			self:CleanupDummies()
		end,
		OnInterrupt = function()
			self:CleanupDummies()
		end,
	}
end
function monkey_ab3.prototype.StartFurArmy(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:KnockBackEnemiesOnRelease(caster)
	self:CleanupDummies()
	local ____self_0, ____castToken_1 = self, "castToken"
	local ____self_castToken_2 = ____self_0[____castToken_1] + 1
	____self_0[____castToken_1] = ____self_castToken_2
	local token = ____self_castToken_2
	self.dummies = {}
	local directions =
		GetRotateVectors(nil, caster:GetForwardVector(), MONKEY_AB3_DUMMY_COUNT, MONKEY_AB3_DUMMY_ANGLE_INTERVAL)
	local pendingDummyCount = #directions
	for ____, direction in ipairs(directions) do
		local currentDirection = self:NormalizeStrikeDirection(direction)
		MyGameUnit:CreateUnitAsync({
			unitName = MONKEY_AB3_DUMMY_NAME,
			position = caster:GetAbsOrigin(),
			findClearSpace = false,
			owner = caster,
			entityOwner = caster,
			team = caster:GetTeam(),
			unitType = UnitType.SUMMONED,
			roomId = caster:GetRoomId(),
			onSpawn = function(____, dummy)
				pendingDummyCount = pendingDummyCount - 1
				if not dummy or not IsValidAlive(nil, dummy) or not self:IsCurrentCastActive(token) then
					if dummy and IsValid(nil, dummy) and not dummy:IsNull() then
						MyGameUnit:DestroyUnit(dummy)
					end
					if pendingDummyCount <= 0 then
						self:ScheduleFurArmyStrikes(caster, token)
					end
					return
				end
				dummy:SetForwardVector(currentDirection)
				dummy:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
				dummy:RemoveModifierByName("imba_void_underlord_walk")
				local noPlayerAbility = dummy:AddAbility("no_player")
				if noPlayerAbility then
					noPlayerAbility:SetLevel(1)
				end
				local ____self_dummies_3 = self.dummies
				____self_dummies_3[#____self_dummies_3 + 1] = { unit = dummy, direction = currentDirection }
				local targetPos = ResolveMonkeyBlinkPoint(
					nil,
					caster,
					currentDirection:__mul(MONKEY_AB3_DUMMY_DISTANCE):__add(caster:GetAbsOrigin())
				)
				if targetPos then
					dummy:Mover(targetPos, 0.5)
				end
				if pendingDummyCount <= 0 then
					self:ScheduleFurArmyStrikes(caster, token)
				end
			end,
		})
	end
	if pendingDummyCount <= 0 then
		self:ScheduleFurArmyStrikes(caster, token)
	end
end
function monkey_ab3.prototype.ScheduleFurArmyStrikes(self, caster, token)
	self:Timer(0.55, function()
		if not self:IsCurrentCastActive(token) then
			self:CleanupDummies()
			return
		end
		for ____, dummyState in ipairs(self.dummies) do
			do
				local currentDummy = dummyState.unit
				if not IsValidAlive(nil, currentDummy) then
					goto __continue22
				end
				currentDummy:SetForwardVector(dummyState.direction)
				____exports.monkey_ab3_dumy_modifier:applys(
					currentDummy,
					currentDummy,
					self,
					{ duration = MONKEY_AB3_DUMMY_DURATION }
				)
				self:PrepareDummyStrike(currentDummy, dummyState.direction)
				self:GetCaster():StartGesture(ACT_DOTA_ATTACK)
			end
			::__continue22::
		end
	end)
	self:Timer(1.4, function()
		if not self:IsCurrentCastActive(token) then
			self:CleanupDummies()
			return
		end
		self:Timer(0.3, function()
			self:RotateDummiesAndStrike(caster, token)
		end)
	end)
	self:Timer(2.2, function()
		if not self:IsCurrentCastActive(token) then
			self:CleanupDummies()
			return
		end
		self:Timer(0.3, function()
			self:RotateDummiesAndStrike(caster, token)
		end)
	end)
end
function monkey_ab3.prototype.NormalizeStrikeDirection(self, direction)
	local flatDirection = Vector(direction.x, direction.y, 0)
	if flatDirection:Length2D() <= 0.01 then
		local casterForward = self:GetCaster():GetForwardVector()
		return Vector(casterForward.x, casterForward.y, 0):Normalized()
	end
	return flatDirection:Normalized()
end
function monkey_ab3.prototype.RotateDummiesAndStrike(self, caster, token)
	if not self:IsCurrentCastActive(token) then
		self:CleanupDummies()
		return
	end
	local center = caster:GetAbsOrigin()
	caster:StartGesture(ACT_DOTA_ATTACK)
	for ____, dummyState in ipairs(self.dummies) do
		do
			local currentDummy = dummyState.unit
			if not IsValidAlive(nil, currentDummy) then
				goto __continue35
			end
			local nextDirection =
				self:NormalizeStrikeDirection(RotateVector2D(nil, dummyState.direction, MONKEY_AB3_DUMMY_ROTATE_ANGLE))
			local idealPos = center:__add(nextDirection:__mul(MONKEY_AB3_DUMMY_DISTANCE))
			local rotatedPos = ResolveMonkeyBlinkPoint(nil, currentDummy, idealPos) or currentDummy:GetAbsOrigin()
			dummyState.direction = nextDirection
			currentDummy:SetAbsOrigin(rotatedPos)
			currentDummy:SetForwardVector(nextDirection)
			self:PrepareDummyStrike(currentDummy, nextDirection)
		end
		::__continue35::
	end
end
function monkey_ab3.prototype.KnockBackEnemiesOnRelease(self, caster)
	local origin = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		MONKEY_AB3_RELEASE_KNOCKBACK_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue39
			end
			enemy:KnockBack(
				caster,
				self,
				{
					origin_pos = origin,
					duration = MONKEY_AB3_RELEASE_KNOCKBACK_DURATION,
					distance = MONKEY_AB3_RELEASE_KNOCKBACK_DISTANCE,
					height = MONKEY_AB3_RELEASE_KNOCKBACK_HEIGHT,
				}
			)
		end
		::__continue39::
	end
end
function monkey_ab3.prototype.IsCurrentCastActive(self, token)
	return token == self.castToken and IsValidAlive(nil, self:GetCaster())
end
function monkey_ab3.prototype.CleanupDummies(self)
	self.castToken = self.castToken + 1
	for ____, dummyState in ipairs(self.dummies) do
		do
			local currentDummy = dummyState.unit
			if not IsValid(nil, currentDummy) or currentDummy:IsNull() or currentDummy.__remove then
				goto __continue44
			end
			currentDummy:RemoveSelf()
		end
		::__continue44::
	end
	self.dummies = {}
end
function monkey_ab3.prototype.PrepareDummyStrike(self, dummy, direction)
	if not IsValidAlive(nil, dummy) then
		return
	end
	local strikeDirection = self:NormalizeStrikeDirection(direction)
	local startPos = dummy:GetAbsOrigin()
	local endPos = startPos:__add(strikeDirection:__mul(MONKEY_AB3_STRIKE_LENGTH))
	dummy:SetForwardVector(strikeDirection)
	self:CreateWarningLine(startPos, endPos)
	self:StartDummyStrike(dummy, startPos, endPos)
end
function monkey_ab3.prototype.CreateWarningLine(self, startPos, endPos)
	local warningLine = ParticleManager:CreateParticle(
		"particles/void_spirit_astral_step_ground_dark_red.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(warningLine, 0, startPos)
	ParticleManager:SetParticleControl(warningLine, 2, endPos)
	ParticleManager:ReleaseParticleIndex(warningLine)
end
function monkey_ab3.prototype.StartDummyStrike(self, dummy, startPos, endPos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, dummy) then
		return
	end
	local startX = startPos.x
	local startY = startPos.y
	local startZ = startPos.z
	local endX = endPos.x
	local endY = endPos.y
	local endZ = endPos.z
	dummy:StartGesture(ACT_DOTA_MK_STRIKE)
	self:Timer(0.4, function()
		if not IsValidAlive(nil, caster) or not IsValidAlive(nil, dummy) then
			return
		end
		local lockedDirection = Vector(endX - startX, endY - startY, 0):Normalized()
		dummy:SetForwardVector(lockedDirection)
		____exports.modifier_monkey_ab3_1:applys(dummy, caster, self, {
			duration = 0.3,
			start_x = startX,
			start_y = startY,
			start_z = startZ,
			end_x = endX,
			end_y = endY,
			end_z = endZ,
		})
	end)
end
monkey_ab3 = __TS__DecorateLegacy({ registerAbility(nil) }, monkey_ab3)
____exports.monkey_ab3 = monkey_ab3
____exports.monkey_ab3_dumy_modifier = __TS__Class()
local monkey_ab3_dumy_modifier = ____exports.monkey_ab3_dumy_modifier
monkey_ab3_dumy_modifier.name = "monkey_ab3_dumy_modifier"
__TS__ClassExtends(monkey_ab3_dumy_modifier, BaseModifier_CS)
function monkey_ab3_dumy_modifier.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:SetAnimation("mk_fur_army_soldier_idle_v2")
end
function monkey_ab3_dumy_modifier.prototype.GetStatusEffectName(self)
	return "particles/econ/items/monkey_king/mk_ti9_immortal/status_effect_mk_ti9_immortal_army.vpcf"
end
function monkey_ab3_dumy_modifier.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveSelf()
end
function monkey_ab3_dumy_modifier.prototype.CheckState(self)
	return { [MODIFIER_STATE_UNSELECTABLE] = true }
end
monkey_ab3_dumy_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, monkey_ab3_dumy_modifier)
____exports.monkey_ab3_dumy_modifier = monkey_ab3_dumy_modifier
____exports.modifier_monkey_ab3_1 = __TS__Class()
local modifier_monkey_ab3_1 = ____exports.modifier_monkey_ab3_1
modifier_monkey_ab3_1.name = "modifier_monkey_ab3_1"
__TS__ClassExtends(modifier_monkey_ab3_1, BaseModifier_CS)
function modifier_monkey_ab3_1.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) then
		return
	end
	local startPos = Vector(params.start_x, params.start_y, params.start_z)
	local endPos = Vector(params.end_x, params.end_y, params.end_z)
	local strikeParticle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_strike.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(strikeParticle, 0, startPos)
	ParticleManager:SetParticleControl(strikeParticle, 1, endPos)
	ParticleManager:ReleaseParticleIndex(strikeParticle)
	caster:EmitSound("Hero_MonkeyKing.Strike.Impact")
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		startPos,
		endPos,
		nil,
		MONKEY_AB3_STRIKE_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue65
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = MONKEY_AB3_STRIKE_DAMAGE, ability = ability })
			enemy:KnockBack(caster, ability, {
				origin_pos = startPos,
				duration = 0.2,
				stun = true,
				stunDuration = 1,
				distance = 0,
				height = 100,
			})
		end
		::__continue65::
	end
end
modifier_monkey_ab3_1 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_ab3_1)
____exports.modifier_monkey_ab3_1 = modifier_monkey_ab3_1
return ____exports