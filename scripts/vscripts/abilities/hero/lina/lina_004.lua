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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local ____modifier_generic_motion = require("modifiers.modifier_generic_motion")
local modifier_generic_dash = ____modifier_generic_motion.modifier_generic_dash
--- 燃烧路径粒子：cp0 起点，cp1 终点，cp2.x 持续时间
local LINA_004_TRAIL_PARTICLE = "particles/mars_spear_burning_trail.vpcf"
local LINA_004 = "particles/units/heroes/hero_batrider/batrider_stoked_firefly.vpcf"
--- 路径上插值采样间隔
local LINA_004_TRAIL_STEP = 120
--- 单帧位移超过该距离时视为传送，不补路径插值
local LINA_004_TRAIL_MAX_INTERPOLATE_DISTANCE = 900
--- 冲刺位移时间（秒）
local LINA_004_DASH_DURATION = 0.2
--- 冲刺期间减伤百分比
local LINA_004_DAMAGE_REDUCTION_PCT = 100
--- 减伤 modifier 持续时间（秒）
local LINA_004_DAMAGE_REDUCTION_DURATION = 0.35
--- 灼地伤害结算间隔（秒）
local LINA_004_TRAIL_TICK_INTERVAL = 0.2
--- 每个路径采样点的范围搜索半径
local LINA_004_TRAIL_WIDTH = 88
--- 冲刺结束后继续产生火焰的时间（秒）
local LINA_004_TRAIL_POST_DASH_DURATION = 1.5
--- 冲刺结束后原地继续产火的间隔（秒）
local LINA_004_TRAIL_POST_DASH_CREATE_INTERVAL = 0.3
--- 点阵火焰之间的间隔
local LINA_004_TRAIL_DOT_STEP = 120
--- 单个点阵火点的伤害搜索半径
local LINA_004_TRAIL_DOT_RADIUS = 80
--- 丽娜技能 004 - 烈焰冲刺
-- 表内 `trail_damage_pct` 表示每秒造成总攻击力的百分比（100 = 每秒 100%）；单次结算伤害按 `LINA_004_TRAIL_TICK_INTERVAL` 自动折算。
-- `trail_duration` 走 `GetSpecialValue` 的 DURATION 标签结算（如符印 item_G308 `tag_gem_duration:50` 即 +50% 灼地持续）。
____exports.lina_004 = __TS__Class()
local lina_004 = ____exports.lina_004
lina_004.name = "lina_004"
__TS__ClassExtends(lina_004, BaseHeroAbility)
function lina_004.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_004_TRAIL_PARTICLE, context)
end
function lina_004.prototype.GetAbilityConfig(self)
	return { castPoint = 0, castAnimation = ACT_DOTA_CAST_ABILITY_1, behavior = DOTA_ABILITY_BEHAVIOR_POINT }
end
function lina_004.prototype.GetCastRange(self, _location, _target)
	if IsClient() then
		return self:GetSpecialValue("lina_004", "dash_distance")
	end
	return 25000
end
function lina_004.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1.3)
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()
	local dir = GetDirection(nil, point, origin)
	local dashDistance = self:GetSpecialValue("lina_004", "dash_distance")
	local trailDuration = self:GetSpecialValue("lina_004", "trail_duration")
	local dashDuration = LINA_004_DASH_DURATION
	local damageReductionPct = LINA_004_DAMAGE_REDUCTION_PCT
	local damageReductionDuration = LINA_004_DAMAGE_REDUCTION_DURATION
	local trailTickInterval = LINA_004_TRAIL_TICK_INTERVAL
	local playerDistance = origin:__sub(point):Length2D()
	local minDistance = dashDistance * 0.618
	local maxDistance = dashDistance
	local distance = math.min(math.max(minDistance, playerDistance), maxDistance)
	local startPos = origin
	local trailCreateEndTime = GameRules:GetGameTime() + dashDuration + LINA_004_TRAIL_POST_DASH_DURATION
	caster:AddNewModifier(
		caster,
		self,
		"modifier_cs_damage_reduction",
		{ duration = damageReductionDuration, damage_reduction_pct = damageReductionPct }
	)
	modifier_generic_dash:applys(caster, caster, self, {
		distance = distance,
		dir = dir,
		duration = dashDuration,
		corridor_half_width = 500,
		cell_size = 80,
		break_destructibles = 1,
	})
	____exports.modifier_lina_004_effect:applys(
		caster,
		caster,
		self,
		{ duration = dashDuration + LINA_004_TRAIL_POST_DASH_DURATION }
	)
	local trailNodes = {}
	local startPosCopy = startPos:__add(Vector(0, 0, 0))
	self:CreateTrailDotMatrix(startPosCopy, trailNodes, trailDuration)
	local lastRecordedPos = startPosCopy
	local nextStationaryCreateTime = GameRules:GetGameTime() + LINA_004_TRAIL_POST_DASH_CREATE_INTERVAL
	local function positionTick()
		if not IsValid(nil, caster) or not caster:IsAlive() then
			return nil
		end
		local now = GameRules:GetGameTime()
		if now > trailCreateEndTime then
			return nil
		end
		local pos = caster:GetAbsOrigin()
		local isDashing = caster:HasModifier("modifier_generic_dash")
		local toCurrent = pos:__sub(lastRecordedPos)
		local d = toCurrent:Length2D()
		if d > LINA_004_TRAIL_MAX_INTERPOLATE_DISTANCE then
			lastRecordedPos = pos:__add(Vector(0, 0, 0))
			return FrameTime()
		end
		while d >= LINA_004_TRAIL_STEP do
			local dir = toCurrent:Normalized()
			local newPoint = lastRecordedPos:__add(dir:__mul(LINA_004_TRAIL_STEP))
			self:CreateTrailDotMatrix(newPoint, trailNodes, trailDuration)
			lastRecordedPos = newPoint:__add(Vector(0, 0, 0))
			toCurrent = pos:__sub(lastRecordedPos)
			d = toCurrent:Length2D()
		end
		if not isDashing and now >= nextStationaryCreateTime then
			local currentPos = pos:__add(Vector(0, 0, 0))
			self:CreateTrailDotMatrix(currentPos, trailNodes, trailDuration)
			nextStationaryCreateTime = now + LINA_004_TRAIL_POST_DASH_CREATE_INTERVAL
		end
		return FrameTime()
	end
	local function damageTick()
		if not IsValid(nil, caster) or not caster:IsAlive() then
			return nil
		end
		self:RemoveExpiredTrailNodes(trailNodes)
		if #trailNodes == 0 and GameRules:GetGameTime() > trailCreateEndTime then
			return nil
		end
		self:applyTrailDamageTick(caster, trailNodes)
		return trailTickInterval
	end
	Timers:CreateTimer(FrameTime(), positionTick)
	Timers:CreateTimer(trailTickInterval, damageTick)
end
function lina_004.prototype.applyTrailDamageTick(self, caster, trailNodes)
	if #trailNodes == 0 then
		return
	end
	local trailDamagePctPerSecond = self:GetSpecialValue("lina_004", "trail_damage_pct")
	local trailWidth = LINA_004_TRAIL_DOT_RADIUS
	local damage = self:GetAllAttackDamage(caster) * trailDamagePctPerSecond * LINA_004_TRAIL_TICK_INTERVAL / 100
	local hitSet = __TS__New(Set)
	for ____, node in ipairs(trailNodes) do
		local units = self:FindMonsterEnemies(node.pos, trailWidth)
		for ____, u in ipairs(units) do
			do
				if not IsValidAlive(nil, u) then
					goto __continue20
				end
				local id = u:GetEntityIndex()
				if hitSet:has(id) then
					goto __continue20
				end
				hitSet:add(id)
				Damage:ApplyDamage({
					attacker = caster,
					victim = u,
					damage = damage,
					damage_type = 2,
					ability = self,
				})
			end
			::__continue20::
		end
	end
end
function lina_004.prototype.CreateTrailDotMatrix(self, center, trailNodes, trailDurationSeconds)
	local now = GameRules:GetGameTime()
	local expireAt = now + trailDurationSeconds
	local radius = LINA_004_TRAIL_WIDTH
	local dotCount = math.floor(radius / LINA_004_TRAIL_DOT_STEP)
	do
		local xIndex = -dotCount
		while xIndex <= dotCount do
			local currentX = xIndex * LINA_004_TRAIL_DOT_STEP
			do
				local yIndex = -dotCount
				while yIndex <= dotCount do
					do
						local currentY = yIndex * LINA_004_TRAIL_DOT_STEP
						if currentX * currentX + currentY * currentY > radius * radius then
							goto __continue27
						end
						local pos = center:__add(Vector(currentX, currentY, 0))
						local currentPos = pos:__add(Vector(0, 0, 0))
						trailNodes[#trailNodes + 1] = { pos = currentPos, expireAt = expireAt }
						self:PlayEffect(currentPos, currentPos, trailDurationSeconds)
					end
					::__continue27::
					yIndex = yIndex + 1
				end
			end
			xIndex = xIndex + 1
		end
	end
end
function lina_004.prototype.RemoveExpiredTrailNodes(self, trailNodes)
	local now = GameRules:GetGameTime()
	do
		local i = #trailNodes - 1
		while i >= 0 do
			local currentIndex = i
			local node = trailNodes[currentIndex + 1]
			if node.expireAt <= now then
				__TS__ArraySplice(trailNodes, currentIndex, 1)
			end
			i = i - 1
		end
	end
end
function lina_004.prototype.PlayEffect(self, startPos, endPos, trailDurationSeconds)
	local caster = self:GetCaster()
	local pid = MyGameHeroParticleManager:CreateParticle(LINA_004_TRAIL_PARTICLE, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(pid, 0, startPos)
	MyGameHeroParticleManager:SetParticleControl(pid, 1, endPos)
	MyGameHeroParticleManager:SetParticleControl(pid, 2, Vector(trailDurationSeconds, 0, 0))
	MyGameHeroParticleManager:SetParticleControl(pid, 3, Vector(100, 0, 0))
	MyGameHeroParticleManager:ReleaseParticleIndex(pid)
end
lina_004 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_004)
____exports.lina_004 = lina_004
____exports.modifier_lina_004_effect = __TS__Class()
local modifier_lina_004_effect = ____exports.modifier_lina_004_effect
modifier_lina_004_effect.name = "modifier_lina_004_effect"
__TS__ClassExtends(modifier_lina_004_effect, BaseModifier)
function modifier_lina_004_effect.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
end
function modifier_lina_004_effect.prototype.GetEffectName(self)
	return LINA_004
end
modifier_lina_004_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_lina_004_effect)
____exports.modifier_lina_004_effect = modifier_lina_004_effect
return ____exports