--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__ArraySetLength = ____lualib.__TS__ArraySetLength
local ____exports = {}
local FireMonsterWarningEnded
function FireMonsterWarningEnded(self, event)
	MyGameEvent:FireEvent(BusinessEvents.ON_MONSTER_WARNING_ENDED, event, { scope = "global" })
end
local WARNING_VIEW_TEAM = DOTA_TEAM_GOODGUYS
local WARNING_THINKER_EXTRA_DURATION = 1
--- 按队伍+范围查找可见的敌方英雄/小兵
function ____exports.findHeroesInRadius(self, teamNumber, searchPoint, radius)
	return FindUnitsInRadius(
		teamNumber,
		searchPoint,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
end
--- 线性预警效果
function ____exports.warningEffectLinear(self, caster, ability, start_pos, end_pos, duration, options)
	if duration <= 0 then
		return
	end
	local startWidth = options and options.startWidth or 128
	local endWidth = options and options.endWidth or 128
	local getDirection = options and options.getDirection
	local getStartPosition = options and options.getStartPosition
	local startThinker = CreateModifierThinker(
		nil,
		ability,
		"modifier_dummy_thinker",
		{ duration = duration + WARNING_THINKER_EXTRA_DURATION },
		start_pos,
		WARNING_VIEW_TEAM,
		false
	)
	local endThinker = CreateModifierThinker(
		nil,
		ability,
		"modifier_dummy_thinker",
		{ duration = duration + WARNING_THINKER_EXTRA_DURATION },
		start_pos,
		WARNING_VIEW_TEAM,
		false
	)
	local function areThinkersValid()
		return IsValid(nil, startThinker)
			and not startThinker:IsNull()
			and IsValid(nil, endThinker)
			and not endThinker:IsNull()
	end
	if not areThinkersValid(nil) then
		if IsValid(nil, startThinker) and not startThinker:IsNull() then
			startThinker:RemoveSelf()
		end
		if IsValid(nil, endThinker) and not endThinker:IsNull() then
			endThinker:RemoveSelf()
		end
		return
	end
	local effect = ParticleManager:CreateParticle(
		("particles/range_finder_linear_" .. tostring(options and options.type or 1)) .. ".vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		startThinker
	)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	ParticleManager:SetParticleControlEnt(
		effect,
		0,
		startThinker,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		start_pos,
		false
	)
	ParticleManager:SetParticleControlEnt(
		effect,
		1,
		endThinker,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		start_pos,
		false
	)
	ParticleManager:SetParticleControl(effect, 2, Vector(duration, startWidth, endWidth))
	local interval = 0.03
	local elapsed = 0
	local baseDir = end_pos:__sub(start_pos)
	local fullLength = baseDir:Length()
	local ____temp_10
	if fullLength > 0.0001 then
		____temp_10 = baseDir:Normalized()
	else
		____temp_10 = baseDir
	end
	local baseDirNorm = ____temp_10
	local lastDirection = baseDirNorm
	local directionLocked = false
	local lastStartPos = start_pos
	local function setThinkerPos(____, thinker, pos)
		if not IsValid(nil, thinker) or thinker:IsNull() then
			return pos
		end
		local groundZ = GetGroundHeight(pos, thinker)
		local ____pos_x_12 = pos.x
		local ____pos_y_13 = pos.y
		local ____temp_11
		if groundZ ~= nil then
			____temp_11 = groundZ
		else
			____temp_11 = pos.z
		end
		local finalPos = Vector(____pos_x_12, ____pos_y_13, ____temp_11)
		thinker:SetAbsOrigin(finalPos)
		return finalPos
	end
	local function resolveStartPos()
		if getStartPosition then
			local dynamicStart = getStartPosition(nil)
			if dynamicStart ~= nil then
				return dynamicStart
			end
		end
		if options and options.follow and IsValidAlive(nil, caster) then
			return caster:GetAbsOrigin()
		end
		return lastStartPos
	end
	local function updateThinkerAndColor()
		local t = elapsed / duration
		local clampedT = t < 0 and 0 or (t > 1 and 1 or t)
		lastStartPos = setThinkerPos(nil, startThinker, resolveStartPos(nil))
		if getDirection and not directionLocked then
			local dirVec = getDirection(nil)
			if dirVec ~= nil and dirVec:Length() > 0.0001 then
				lastDirection = dirVec:Normalized()
			else
				directionLocked = true
			end
		end
		local currentLength = fullLength * clampedT
		local currentEnd = lastStartPos:__add(lastDirection:__mul(currentLength))
		setThinkerPos(nil, endThinker, currentEnd)
		ParticleManager:SetParticleControl(effect, 15, Vector(1, 1 - clampedT, 0))
	end
	setThinkerPos(nil, startThinker, start_pos)
	setThinkerPos(nil, endThinker, start_pos)
	updateThinkerAndColor(nil)
	local function destroyWarning(____, immediate)
		ParticleManager:DestroyParticle(effect, immediate)
		ParticleManager:ReleaseParticleIndex(effect)
		if IsValid(nil, startThinker) and not startThinker:IsNull() then
			startThinker:RemoveSelf()
		end
		if IsValid(nil, endThinker) and not endThinker:IsNull() then
			endThinker:RemoveSelf()
		end
	end
	Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, caster) or not areThinkersValid(nil) then
			destroyWarning(nil, true)
			return
		end
		elapsed = elapsed + interval
		if elapsed >= duration then
			lastStartPos = setThinkerPos(nil, startThinker, resolveStartPos(nil))
			local finalEnd = lastStartPos:__add(lastDirection:__mul(fullLength))
			setThinkerPos(nil, endThinker, finalEnd)
			ParticleManager:SetParticleControl(effect, 15, Vector(1, 0, 0))
			destroyWarning(nil, true)
			FireMonsterWarningEnded(nil, {
				caster = caster:entindex(),
				ability_index = ability and ability:entindex(),
				ability_name = ability and ability:GetAbilityName(),
				warning_type = "linear",
				start_pos = lastStartPos,
				end_pos = finalEnd,
				radius = math.max(startWidth, endWidth),
				ended_at = GameRules:GetGameTime(),
			})
			return
		end
		updateThinkerAndColor(nil)
		return interval
	end)
end
--- 圆形预警效果（全部按半径，单位码）
function ____exports.warningEffectRing(self, caster, center, damageRadius, duration, options)
	if duration <= 0 or damageRadius <= 0 then
		return
	end
	local speed = options and options.speed or damageRadius / duration
	local getCenter = options and options.getCenter
	local anchor = CreateModifierThinker(
		nil,
		nil,
		"modifier_dummy_thinker",
		{ duration = duration + WARNING_THINKER_EXTRA_DURATION },
		center,
		WARNING_VIEW_TEAM,
		false
	)
	if not IsValid(nil, anchor) or anchor:IsNull() then
		return
	end
	local lastCenter = center
	local function setAnchorPos(____, pos)
		if not IsValid(nil, anchor) or anchor:IsNull() then
			return
		end
		local groundZ = GetGroundHeight(pos, anchor)
		local ____pos_x_25 = pos.x
		local ____pos_y_26 = pos.y
		local ____temp_24
		if groundZ ~= nil then
			____temp_24 = groundZ
		else
			____temp_24 = pos.z
		end
		lastCenter = Vector(____pos_x_25, ____pos_y_26, ____temp_24)
		anchor:SetAbsOrigin(lastCenter)
	end
	local function resolveCenter()
		if getCenter then
			local dynamicCenter = getCenter(nil)
			if dynamicCenter ~= nil then
				return dynamicCenter
			end
		end
		if options and options.follow and IsValidAlive(nil, caster) then
			return caster:GetAbsOrigin()
		end
		return lastCenter
	end
	setAnchorPos(nil, center)
	local effects = {}
	local function isValidViewer(____, viewer)
		return not not viewer
			and IsValid(nil, viewer)
			and IsValidEntity(viewer)
			and type(viewer.IsNull) == "function"
			and not viewer:IsNull()
	end
	local function createEffect(____, viewer)
		local ____viewer_29
		if viewer then
			____viewer_29 = ParticleManager:CreateParticleForPlayer(
				"particles/monster/ability_warning_ring.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				anchor,
				viewer
			)
		else
			____viewer_29 = ParticleManager:CreateParticleForTeam(
				"particles/monster/ability_warning_ring.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				anchor,
				WARNING_VIEW_TEAM
			)
		end
		local effect = ____viewer_29
		ParticleManager:SetParticleShouldCheckFoW(effect, false)
		ParticleManager:SetParticleControlEnt(
			effect,
			0,
			anchor,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			lastCenter,
			false
		)
		ParticleManager:SetParticleControl(effect, 1, Vector(damageRadius, 0, -speed * 1.4))
		ParticleManager:SetParticleControl(effect, 2, Vector(duration, 0, 0))
		effects[#effects + 1] = { id = effect, viewer = viewer }
	end
	if options and options.viewers then
		for ____, viewer in ipairs(options.viewers) do
			do
				if not isValidViewer(nil, viewer) then
					goto __continue37
				end
				createEffect(nil, viewer)
			end
			::__continue37::
		end
	else
		createEffect(nil)
	end
	local interval = 0.03
	local elapsed = 0
	local function updateColor()
		local t = elapsed / duration
		local clampedT = t < 0 and 0 or (t > 1 and 1 or t)
		local r = 1
		local g = 1 - clampedT
		local flashScale = 1
		if t > 0.75 then
			local flashT = (clampedT - 0.75) / 0.2
			local phase = flashT * flashT * math.pi * 2 * 6
			local pulse = (math.sin(phase) + 1) / 2
			flashScale = 1 + pulse * 0.4
		end
		for ____, effect in ipairs(effects) do
			ParticleManager:SetParticleControl(effect.id, 15, Vector(r * 0.7 * flashScale, g * 0.7 * flashScale, 0))
		end
	end
	updateColor(nil)
	local function destroyEffect(____, effect, immediate)
		ParticleManager:DestroyParticle(effect.id, immediate)
		ParticleManager:ReleaseParticleIndex(effect.id)
	end
	local function removeInactiveViewerEffects()
		if not (options and options.isViewerActive) then
			return
		end
		do
			local index = #effects - 1
			while index >= 0 do
				do
					local effect = effects[index + 1]
					if
						not effect.viewer
						or isValidViewer(nil, effect.viewer) and options:isViewerActive(effect.viewer)
					then
						goto __continue48
					end
					destroyEffect(nil, effect, true)
					__TS__ArraySplice(effects, index, 1)
				end
				::__continue48::
				index = index - 1
			end
		end
	end
	local function destroyWarning(____, immediate)
		for ____, effect in ipairs(effects) do
			destroyEffect(nil, effect, immediate)
		end
		__TS__ArraySetLength(effects, 0)
		if IsValid(nil, anchor) and not anchor:IsNull() then
			anchor:RemoveSelf()
		end
	end
	Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, caster) or not IsValid(nil, anchor) or anchor:IsNull() then
			destroyWarning(nil, false)
			return
		end
		elapsed = elapsed + interval
		removeInactiveViewerEffects(nil)
		setAnchorPos(nil, resolveCenter(nil))
		if elapsed >= duration then
			for ____, effect in ipairs(effects) do
				ParticleManager:SetParticleControl(effect.id, 15, Vector(1, 0, 0))
			end
			destroyWarning(nil, false)
			FireMonsterWarningEnded(nil, {
				caster = caster:entindex(),
				warning_type = "ring",
				position = lastCenter,
				radius = damageRadius,
				ended_at = GameRules:GetGameTime(),
			})
			return
		end
		updateColor(nil)
		return interval
	end)
end
return ____exports