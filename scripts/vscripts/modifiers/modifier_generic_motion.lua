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
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArrayReverse = ____lualib.__TS__ArrayReverse
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifierMotionHorizontal_CS = ____modifier_base.BaseModifierMotionHorizontal_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____tween = require("utils.tween")
local tween = ____tween.tween
local ____config = require("my_game_axe.greed_cave.config")
local IsGreedCaveRoomId = ____config.IsGreedCaveRoomId
local function parseDirection(self, kvDir)
	if kvDir == nil then
		return Vector(0, 1, 0)
	end
	local raw = kvDir
	if type(raw) == "string" then
		local v = StringToVector(nil, raw)
		local ____opt_0 = v.Length2D
		local len2d = ____opt_0 and ____opt_0(v) or math.sqrt(v.x * v.x + v.y * v.y)
		if len2d <= 0 then
			return Vector(0, 1, 0)
		end
		return v:Normalized() or Vector(0, 1, 0)
	end
	if raw == nil or not (raw.x ~= nil) or not (raw.y ~= nil) then
		return Vector(0, 1, 0)
	end
	local v = raw
	local len = math.sqrt(v.x * v.x + v.y * v.y + (v.z or 0) * (v.z or 0)) or 1
	return Vector(v.x / len, v.y / len, (v.z or 0) / len)
end
--- G001 场地开阔，冲刺不做原生寻路绕墙。
local function isUnitInGreedCaveRoom(self, unit)
	local ____IsGreedCaveRoomId_4 = IsGreedCaveRoomId
	local ____this_3
	____this_3 = unit
	local ____opt_2 = ____this_3.GetRoomId
	if ____IsGreedCaveRoomId_4(nil, ____opt_2 and ____opt_2(____this_3)) then
		return true
	end
	local ____this_6
	____this_6 = unit
	local ____opt_5 = ____this_6.GetPlayerOwnerID
	local playerId = ____opt_5 and ____opt_5(____this_6)
	if playerId == nil or playerId < 0 then
		return false
	end
	local ____IsGreedCaveRoomId_11 = IsGreedCaveRoomId
	local ____opt_7 = MyGameRoomManager and MyGameRoomManager:GetPlayerRoom(playerId)
	return ____IsGreedCaveRoomId_11(nil, ____opt_7 and ____opt_7:GetRoomId())
end
____exports.modifier_generic_motion = __TS__Class()
local modifier_generic_motion = ____exports.modifier_generic_motion
modifier_generic_motion.name = "modifier_generic_motion"
__TS__ClassExtends(modifier_generic_motion, BaseModifierMotionHorizontal_CS)
function modifier_generic_motion.prototype.____constructor(self, ...)
	BaseModifierMotionHorizontal_CS.prototype.____constructor(self, ...)
	self.moved = 0
	self.elapsed = 0
end
function modifier_generic_motion.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.direction = parseDirection(nil, kv.dir)
	self.speed = tonumber(kv.speed) or 0
	self.face_direction = kv.face_direction ~= 0
	local ____temp_12
	if kv.duration ~= nil and kv.duration > 0 then
		____temp_12 = tonumber(kv.duration)
	else
		____temp_12 = 999999
	end
	self.max_duration = ____temp_12
	local ____temp_13
	if kv.distance ~= nil and kv.distance > 0 then
		____temp_13 = tonumber(kv.distance)
	else
		____temp_13 = 999999
	end
	self.max_distance = ____temp_13
	if self.speed <= 0 then
		self:Destroy()
		return
	end
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end
function modifier_generic_motion.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveHorizontalMotionController(self)
end
function modifier_generic_motion.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_generic_motion.prototype.UpdateHorizontalMotion(self, me, dt)
	if not IsValid(nil, me) or me:IsNull() then
		self:Destroy()
		return
	end
	local step = self.speed * dt
	self.elapsed = self.elapsed + dt
	local pos = me:GetOrigin() + self.direction * step
	if not IsGridNavDisplacementWalkable(nil, pos) or not GridNav:CanFindPath(me:GetOrigin(), pos) then
		pos = me:GetOrigin()
	end
	local hitDistance = self.moved + step >= self.max_distance
	local hitDuration = self.elapsed >= self.max_duration
	if hitDistance or hitDuration then
		local remainDist = math.max(0, self.max_distance - self.moved)
		local ____hitDistance_14
		if hitDistance then
			____hitDistance_14 = remainDist
		else
			____hitDistance_14 = step
		end
		local finalStep = ____hitDistance_14
		local finalPos = me:GetOrigin() + self.direction * finalStep
		local ____temp_15
		if IsGridNavDisplacementWalkable(nil, finalPos) and GridNav:CanFindPath(me:GetOrigin(), finalPos) then
			____temp_15 = finalPos
		else
			____temp_15 = me:GetOrigin()
		end
		local useFinal = ____temp_15
		if self.face_direction then
			local angles = VectorToAngles(self.direction)
			me:SetAbsAngles(angles.x, angles.y, angles.z)
		end
		me:SetOrigin(useFinal)
		self:Destroy()
		return
	end
	self.moved = self.moved + step
	if self.face_direction then
		local angles = VectorToAngles(self.direction)
		me:SetAbsAngles(angles.x, angles.y, angles.z)
	end
	me:SetOrigin(pos)
end
function modifier_generic_motion.prototype.OnHorizontalMotionInterrupted(self)
	self:Destroy()
end
function modifier_generic_motion.prototype.IsHidden(self)
	return true
end
modifier_generic_motion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_motion)
____exports.modifier_generic_motion = modifier_generic_motion
____exports.modifier_generic_dash = __TS__Class()
local modifier_generic_dash = ____exports.modifier_generic_dash
modifier_generic_dash.name = "modifier_generic_dash"
__TS__ClassExtends(modifier_generic_dash, BaseModifierMotionHorizontal_CS)
function modifier_generic_dash.prototype.____constructor(self, ...)
	BaseModifierMotionHorizontal_CS.prototype.____constructor(self, ...)
	self.distance = 0
	self.duration = 0
	self.tweenSubject = { d = 0 }
	self.moved = 0
	self.pathIndex = 0
	self.pathBuilt = false
	self.corridorHalfWidth = 280
	self.cellSize = 80
	self.soundName = "DOTA_Item.ForceStaff.Activate"
	self.breakDestructibles = false
	self.breakDestructiblesRadius = ____exports.modifier_generic_dash.BREAK_DESTRUCTIBLE_RADIUS
	self.useStunnedState = true
	self.activityModifier = "forcestaff_friendly"
	self.skipGreedCaveCorridorNav = false
end
function modifier_generic_dash.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.distance = math.max(0, tonumber(kv.distance) or 0)
	self.duration = math.max(0, tonumber(kv.duration) or 0)
	self.direction = parseDirection(nil, kv.dir)
	self.targetPos = self._parent:GetAbsOrigin() + self.direction * self.distance
	self.corridorHalfWidth = math.max(80, tonumber(kv.corridor_half_width) or 280)
	self.cellSize = math.max(40, tonumber(kv.cell_size) or 80)
	self.soundName = kv.sound_name and tostring(kv.sound_name) or "DOTA_Item.ForceStaff.Activate"
	self.useStunnedState = kv.stunned ~= 0
	self.activityModifier = kv.activity_modifier and tostring(kv.activity_modifier) or "forcestaff_friendly"
	self.breakDestructibles = tonumber(kv.break_destructibles) == 1
	self.breakDestructiblesRadius = math.max(
		1,
		tonumber(kv.break_destructibles_radius) or ____exports.modifier_generic_dash.BREAK_DESTRUCTIBLE_RADIUS
	)
	self.skipGreedCaveCorridorNav = isUnitInGreedCaveRoom(nil, self._parent)
	if self.distance <= 0 or self.duration <= 0 then
		self:Destroy()
		return
	end
	self.tweenSubject = { d = 0 }
	self.dashTween = tween(nil, self.duration, self.tweenSubject, { d = self.distance }, "outQuad")
	self.moved = 0
	self._parent:EmitSound(self.soundName)
	if not self:ApplyHorizontalMotionController() then
		self._parent:StopSound(self.soundName)
		self:Destroy()
	end
end
function modifier_generic_dash.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveHorizontalMotionController(self)
end
function modifier_generic_dash.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_generic_dash.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_generic_dash.prototype.GetActivityTranslationModifiers(self)
	return self.activityModifier
end
function modifier_generic_dash.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_generic_dash.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = self.useStunnedState, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_generic_dash.prototype.UpdateHorizontalMotion(self, me, dt)
	if not IsValid(nil, me) or me:IsNull() then
		self:Destroy()
		return
	end
	local prev = self.moved
	self.dashTween:update(dt)
	local cur = self.tweenSubject.d
	local step = math.max(0, cur - prev)
	if step <= 0 then
		return
	end
	if self.skipGreedCaveCorridorNav then
		local straightPos = me:GetOrigin() + self.direction * step
		if not IsGridNavDisplacementWalkable(nil, straightPos) then
			self:finishDash()
			return
		end
		self:moveStraight(me, step)
	elseif self.pathPoints and #self.pathPoints >= 2 and self.pathPos then
		self:moveAlongPath(me, step)
	else
		local straightPos = me:GetOrigin() + self.direction * step
		if GridNav:CanFindPath(me:GetOrigin(), straightPos) then
			self:moveStraight(me, step)
		else
			if not self.pathBuilt then
				self:buildCorridorPath(me:GetOrigin())
				self.pathBuilt = true
			end
			if self.pathPoints and #self.pathPoints >= 2 then
				self.pathIndex = 0
				self.pathPos = self.pathPoints[1]
				self:moveAlongPath(me, step)
			else
				self:finishDash()
				return
			end
		end
	end
	if cur >= self.distance then
		self:breakDestructiblesInRange(me)
		self:finishDash()
		return
	end
	self.moved = cur
	self:breakDestructiblesInRange(me)
end
function modifier_generic_dash.prototype.breakDestructiblesInRange(self, me)
	if not IsServer() then
		return
	end
	if self.skipGreedCaveCorridorNav then
		return
	end
	if not self.breakDestructibles then
		return
	end
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(
			me,
			me:GetAbsOrigin(),
			self.breakDestructiblesRadius,
			self:GetAbility()
		)
	end
end
function modifier_generic_dash.prototype.moveStraight(self, me, step)
	local newPos = me:GetOrigin() + self.direction * step
	local angles = VectorToAngles(self.direction)
	me:SetAbsAngles(0, angles.y, 0)
	me:SetOrigin(newPos)
end
function modifier_generic_dash.prototype.moveAlongPath(self, me, stepTotal)
	if not self.pathPoints or #self.pathPoints < 2 or not self.pathPos then
		return
	end
	local remaining = stepTotal
	local currentPos = self.pathPos
	while remaining > 0 and self.pathIndex < #self.pathPoints - 1 do
		do
			local nextPoint = self.pathPoints[self.pathIndex + 1 + 1]
			local toNext = nextPoint:__sub(currentPos)
			local distToNext = toNext:Length2D()
			if distToNext <= 0.01 then
				self.pathIndex = self.pathIndex + 1
				currentPos = nextPoint
				goto __continue58
			end
			if remaining >= distToNext then
				remaining = remaining - distToNext
				self.pathIndex = self.pathIndex + 1
				currentPos = nextPoint
			else
				local dir = toNext:Normalized()
				currentPos = currentPos + dir * remaining
				remaining = 0
			end
		end
		::__continue58::
	end
	self.pathPos = currentPos
	local ____temp_18
	if self.pathIndex < #self.pathPoints - 1 then
		____temp_18 = self.pathPoints[self.pathIndex + 1 + 1]:__sub(currentPos)
	else
		____temp_18 = currentPos:__sub(me:GetOrigin())
	end
	local forward = ____temp_18
	if forward:Length2D() > 0.01 then
		local angles = VectorToAngles(forward)
		me:SetAbsAngles(0, angles.y, 0)
	end
	me:SetOrigin(currentPos)
end
function modifier_generic_dash.prototype.buildCorridorPath(self, start)
	local toTarget = self.targetPos:__sub(start)
	local totalDist = toTarget:Length2D()
	if totalDist <= 0 then
		return
	end
	local mainDir = toTarget:Normalized()
	local rightDir = RotateVector2D(nil, mainDir, 90)
	local maxForward = math.max(1, math.floor(totalDist / self.cellSize))
	local maxSide = math.max(1, math.floor(self.corridorHalfWidth / self.cellSize))
	local function keyOf(____, i, j)
		return (tostring(i) .. "_") .. tostring(j)
	end
	local function cellPos(____, i, j)
		return start + mainDir * (i * self.cellSize) + rightDir * (j * self.cellSize)
	end
	local visited = {}
	local prev = {}
	local queue = {}
	local startKey = keyOf(nil, 0, 0)
	visited[startKey] = true
	queue[#queue + 1] = { i = 0, j = 0 }
	local bestKey
	local bestDist = 1000000000
	local function isWalkable(____, pos)
		return GridNav:IsTraversable(pos) and not GridNav:IsBlocked(pos)
	end
	while #queue > 0 do
		local curCell = table.remove(queue, 1)
		local curKey = keyOf(nil, curCell.i, curCell.j)
		local worldPos = cellPos(nil, curCell.i, curCell.j)
		local dTarget = self.targetPos:__sub(worldPos):Length2D()
		if dTarget < bestDist then
			bestDist = dTarget
			bestKey = curKey
		end
		if dTarget <= self.cellSize * 0.5 then
			bestKey = curKey
			break
		end
		local neighbors = {
			{ i = curCell.i + 1, j = curCell.j },
			{ i = curCell.i - 1, j = curCell.j },
			{ i = curCell.i, j = curCell.j + 1 },
			{ i = curCell.i, j = curCell.j - 1 },
		}
		for ____, nb in ipairs(neighbors) do
			do
				if nb.i < 0 or nb.i > maxForward then
					goto __continue71
				end
				if nb.j < -maxSide or nb.j > maxSide then
					goto __continue71
				end
				local nk = keyOf(nil, nb.i, nb.j)
				if visited[nk] then
					goto __continue71
				end
				local p = cellPos(nil, nb.i, nb.j)
				if not isWalkable(nil, p) then
					goto __continue71
				end
				if not GridNav:CanFindPath(worldPos, p) then
					goto __continue71
				end
				visited[nk] = true
				prev[nk] = curKey
				queue[#queue + 1] = nb
			end
			::__continue71::
		end
	end
	if not bestKey then
		return
	end
	local cells = {}
	local curKey = bestKey
	while curKey do
		local parts = __TS__StringSplit(curKey, "_")
		local ci = tonumber(parts[1])
		local cj = tonumber(parts[2])
		cells[#cells + 1] = { i = ci, j = cj }
		curKey = prev[curKey]
	end
	__TS__ArrayReverse(cells)
	local points = { start }
	for ____, c in ipairs(cells) do
		do
			local p = cellPos(nil, c.i, c.j)
			local last = points[#points]
			if p:__sub(last):Length2D() < 10 then
				goto __continue80
			end
			points[#points + 1] = p
		end
		::__continue80::
	end
	if #points >= 2 then
		self.pathPoints = points
	end
end
function modifier_generic_dash.prototype.finishDash(self)
	self:Destroy()
end
function modifier_generic_dash.prototype.OnHorizontalMotionInterrupted(self)
	self:Destroy()
end
function modifier_generic_dash.prototype.IsHidden(self)
	return true
end
function modifier_generic_dash.prototype.GetEffectName(self)
	return "particles/hero/vengeful_arcana_forcestaff_v3.vpcf"
end
modifier_generic_dash.BREAK_DESTRUCTIBLE_RADIUS = 125
modifier_generic_dash = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_dash)
____exports.modifier_generic_dash = modifier_generic_dash
return ____exports