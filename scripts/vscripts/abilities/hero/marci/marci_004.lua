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
local modifier_marci_004_dash
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifierMotionHorizontal_CS = ____modifier_base.BaseModifierMotionHorizontal_CS
local ____config = require("my_game_axe.greed_cave.config")
local IsGreedCaveRoomId = ____config.IsGreedCaveRoomId
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local BaseModifier = ____dota_ts_adapter.BaseModifier
local ____tween = require("utils.tween")
local tween = ____tween.tween
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local MARCI_004_DASH_PARTICLE =
	"particles/econ/items/windrunner/windranger_arcana/windranger_arcana_item_force_staff.vpcf"
local function parseMarci004DashDirection(self, kvDir)
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
local function isMarciDashInGreedCaveRoom(self, unit)
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
--- 玛西专用冲刺
____exports.marci_004 = __TS__Class()
local marci_004 = ____exports.marci_004
marci_004.name = "marci_004"
__TS__ClassExtends(marci_004, BaseHeroAbility)
function marci_004.prototype.Precache(self, context)
	PrecacheResource("particle", MARCI_004_DASH_PARTICLE, context)
end
function marci_004.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_POINT }
end
function marci_004.prototype.GetCastRange(self, location, target)
	if self:ResolveRulesetAbilityTopLevelNumber("AbilityCastRange") ~= nil then
		return BaseHeroAbility.prototype.GetCastRange(self, location, target)
	end
	if IsClient() then
		return self:GetSpecialValue("marci_004", "dash_distance")
	end
	return 25000
end
function marci_004.prototype.GetMaxLevel(self)
	return 1
end
function marci_004.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()
	local dir = GetDirection(nil, point, origin)
	local kvDistance = self:GetSpecialValue("marci_004", "dash_distance")
	local playerDistance = origin:__sub(point):Length2D()
	local minDistance = kvDistance * 0.618
	local maxDistance = kvDistance
	local distance = math.min(math.max(minDistance, playerDistance), maxDistance)
	local duration = self:GetSpecialValue("marci_004", "dash_duration")
	caster:AddNewModifier(caster, self, "modifier_cs_damage_reduction", { duration = 0.25, damage_reduction_pct = 100 })
	modifier_marci_004_dash:applys(caster, caster, self, {
		distance = distance,
		dir = dir,
		duration = duration,
		corridor_half_width = 500,
		cell_size = 80,
	})
end
marci_004 = __TS__DecorateLegacy({ registerAbility(nil) }, marci_004)
____exports.marci_004 = marci_004
modifier_marci_004_dash = __TS__Class()
modifier_marci_004_dash.name = "modifier_marci_004_dash"
__TS__ClassExtends(modifier_marci_004_dash, BaseModifierMotionHorizontal_CS)
function modifier_marci_004_dash.prototype.____constructor(self, ...)
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
	self.useStunnedState = true
	self.activityModifier = "forcestaff_friendly"
	self.skipGreedCaveCorridorNav = false
end
function modifier_marci_004_dash.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.distance = math.max(0, tonumber(kv.distance) or 0)
	self.duration = math.max(0, tonumber(kv.duration) or 0)
	self.direction = parseMarci004DashDirection(nil, kv.dir)
	self.targetPos = self._parent:GetAbsOrigin() + self.direction * self.distance
	self.corridorHalfWidth = math.max(80, tonumber(kv.corridor_half_width) or 280)
	self.cellSize = math.max(40, tonumber(kv.cell_size) or 80)
	self.soundName = kv.sound_name and tostring(kv.sound_name) or "DOTA_Item.ForceStaff.Activate"
	self.useStunnedState = kv.stunned ~= 0
	self.activityModifier = kv.activity_modifier and tostring(kv.activity_modifier) or "forcestaff_friendly"
	self.skipGreedCaveCorridorNav = isMarciDashInGreedCaveRoom(nil, self._parent)
	if self.distance <= 0 or self.duration <= 0 then
		self:Destroy()
		return
	end
	self.tweenSubject = { d = 0 }
	self.dashTween = tween(nil, self.duration, self.tweenSubject, { d = self.distance }, "outQuad")
	self.moved = 0
	self._parent:EmitSound(self.soundName)
	self:CreateDashParticle(self.direction)
	if not self:ApplyHorizontalMotionController() then
		self._parent:StopSound(self.soundName)
		self:Destroy()
	end
end
function modifier_marci_004_dash.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveHorizontalMotionController(self)
end
function modifier_marci_004_dash.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_marci_004_dash.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_marci_004_dash.prototype.GetActivityTranslationModifiers(self)
	return self.activityModifier
end
function modifier_marci_004_dash.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_marci_004_dash.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = self.useStunnedState, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_marci_004_dash.prototype.UpdateHorizontalMotion(self, me, dt)
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
function modifier_marci_004_dash.prototype.CreateDashParticle(self, dir)
	local parent = self:GetParent()
	parent:AddNewModifier(parent, nil, "modifier_marci_004_dash_buff", { duration = self.duration * 0.6 })
end
function modifier_marci_004_dash.prototype.breakDestructiblesInRange(self, me)
	if not IsServer() then
		return
	end
	if self.skipGreedCaveCorridorNav then
		return
	end
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(
			me,
			me:GetAbsOrigin(),
			modifier_marci_004_dash.BREAK_DESTRUCTIBLE_RADIUS,
			self:GetAbility()
		)
	end
end
function modifier_marci_004_dash.prototype.moveStraight(self, me, step)
	local newPos = me:GetOrigin() + self.direction * step
	local angles = VectorToAngles(self.direction)
	me:SetAbsAngles(0, angles.y, 0)
	me:SetOrigin(newPos)
end
function modifier_marci_004_dash.prototype.moveAlongPath(self, me, stepTotal)
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
				goto __continue51
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
		::__continue51::
	end
	self.pathPos = currentPos
	local ____temp_14
	if self.pathIndex < #self.pathPoints - 1 then
		____temp_14 = self.pathPoints[self.pathIndex + 1 + 1]:__sub(currentPos)
	else
		____temp_14 = currentPos:__sub(me:GetOrigin())
	end
	local forward = ____temp_14
	if forward:Length2D() > 0.01 then
		local angles = VectorToAngles(forward)
		me:SetAbsAngles(0, angles.y, 0)
	end
	me:SetOrigin(currentPos)
end
function modifier_marci_004_dash.prototype.buildCorridorPath(self, start)
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
					goto __continue64
				end
				if nb.j < -maxSide or nb.j > maxSide then
					goto __continue64
				end
				local nk = keyOf(nil, nb.i, nb.j)
				if visited[nk] then
					goto __continue64
				end
				local p = cellPos(nil, nb.i, nb.j)
				if not isWalkable(nil, p) then
					goto __continue64
				end
				if not GridNav:CanFindPath(worldPos, p) then
					goto __continue64
				end
				visited[nk] = true
				prev[nk] = curKey
				queue[#queue + 1] = nb
			end
			::__continue64::
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
				goto __continue73
			end
			points[#points + 1] = p
		end
		::__continue73::
	end
	if #points >= 2 then
		self.pathPoints = points
	end
end
function modifier_marci_004_dash.prototype.finishDash(self)
	self:Destroy()
end
function modifier_marci_004_dash.prototype.OnHorizontalMotionInterrupted(self)
	self:Destroy()
end
function modifier_marci_004_dash.prototype.IsHidden(self)
	return true
end
modifier_marci_004_dash.BREAK_DESTRUCTIBLE_RADIUS = 125
modifier_marci_004_dash = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_marci_004_dash)
____exports.modifier_marci_004_dash_buff = __TS__Class()
local modifier_marci_004_dash_buff = ____exports.modifier_marci_004_dash_buff
modifier_marci_004_dash_buff.name = "modifier_marci_004_dash_buff"
__TS__ClassExtends(modifier_marci_004_dash_buff, BaseModifier)
function modifier_marci_004_dash_buff.prototype.IsHidden(self)
	return true
end
function modifier_marci_004_dash_buff.prototype.GetEffectName(self)
	return "particles/windranger_arcana_item_force_staff.vpcf"
end
modifier_marci_004_dash_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_marci_004_dash_buff)
____exports.modifier_marci_004_dash_buff = modifier_marci_004_dash_buff
return ____exports