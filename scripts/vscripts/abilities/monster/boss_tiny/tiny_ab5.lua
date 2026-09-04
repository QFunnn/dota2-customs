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
local modifier_tiny_ab5_rock_storm
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local warningEffectRing = ____monster_base.warningEffectRing
--- 落石特效：cp0 原点，cp1.x = 范围，cp1.z = 三倍范围
local ROCK_DROP_PARTICLE = "particles/cb/rock_drop.vpcf"
--- 每个落点的伤害半径
local ROCK_DROP_DAMAGE_RADIUS = 200
--- 落点到生效的延迟
local ROCK_DROP_DAMAGE_DELAY = 0.5
--- 单次落石伤害系数
local ROCK_DROP_DAMAGE_RATE = 30
--- 落石命中时眩晕时间（秒）
local ROCK_DROP_STUN_DURATION = 0.5
--- 同一轮多个落点之间的最小水平间距（码），避免落点重叠
local TINY_AB5_LAND_MIN_DIST = 200
local TINY_AB5_LAND_PICK_ATTEMPTS = 36
--- 起点相对偏移（沿面朝方向，负数代表身后）
local TINY_AB5_START_OFFSET = -1000
--- 终点相对偏移（沿面朝方向，正数代表面前）
local TINY_AB5_END_OFFSET = 1500
--- 前进速度（每秒前进距离）
local TINY_AB5_FORWARD_SPEED = 2500
--- 间隔（秒）：每 0.1 秒一轮
local TINY_AB5_TICK_INTERVAL = 0.2
--- 每次间隔产生的落点数量
local TINY_AB5_POINTS_PER_TICK = 3
--- 横向随机范围（左右各 800）
local TINY_AB5_HORIZONTAL_RANGE = 400
--- 总持续时间：由距离 / 速度计算得出
local TINY_AB5_DURATION = (TINY_AB5_END_OFFSET - TINY_AB5_START_OFFSET) / TINY_AB5_FORWARD_SPEED
--- 落石预警粒子保留时长（秒）
local TINY_AB5_ROCK_PFX_LIFETIME = 1.5
____exports.tiny_ab5 = __TS__Class()
local tiny_ab5 = ____exports.tiny_ab5
tiny_ab5.name = "tiny_ab5"
__TS__ClassExtends(tiny_ab5, MonsterAbility_CS)
function tiny_ab5.prototype.Precache(self, context)
	PrecacheResource("particle", ROCK_DROP_PARTICLE, context)
end
function tiny_ab5.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 1.6,
		castDuration = 5.2,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		OnPhaseStart = function() end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local count = 0
			local maxCount = 3
			local interval = 1.8
			local runOnce
			runOnce = function()
				if not IsValid(nil, self) or self:IsNull() then
					return
				end
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:StartGesture(ACT_TINY_GROWL)
				count = count + 1
				local centerPos = caster:GetAbsOrigin()
				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					centerPos,
					nil,
					2000,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
					FIND_CLOSEST,
					false
				)
				if #enemies > 0 then
					if not IsValidAlive(nil, enemies[1]) then
						return
					end
					centerPos = enemies[1]:GetAbsOrigin():__add(RandomVector(150))
					caster:SetForwardVector(GetDirection(nil, centerPos, caster:GetAbsOrigin()))
				end
				local randomAngle = RandomFloat(0, 360)
				local forward = RotateVector2D(nil, Vector(1, 0, 0), randomAngle)
				local startPos = centerPos:__add(forward:__mul(TINY_AB5_START_OFFSET))
				local endPos = centerPos:__add(forward:__mul(TINY_AB5_END_OFFSET))
				self:WarningEffect(startPos, endPos, TINY_AB5_DURATION + 0.5, {
					startWidth = TINY_AB5_HORIZONTAL_RANGE,
					endWidth = TINY_AB5_HORIZONTAL_RANGE,
					getDirection = function()
						return forward
					end,
					type = 2,
				})
				self:Timer(1, function()
					if not IsValid(nil, self) or self:IsNull() then
						return
					end
					if not IsValidAlive(nil, caster) then
						return
					end
					ScreenShake(caster:GetAbsOrigin(), 5, 5, 1, 3000, 0, true)
					caster:RemoveGesture(ACT_DOTA_GENERIC_CHANNEL_1)
					modifier_tiny_ab5_rock_storm:applys(caster, caster, self, {
						duration = TINY_AB5_DURATION,
						center_x = centerPos.x,
						center_y = centerPos.y,
						center_z = centerPos.z,
						forward_x = forward.x,
						forward_y = forward.y,
					})
				end)
				if count < maxCount then
					Timers:CreateTimer(interval, function()
						runOnce(nil)
						return nil
					end)
				end
			end
			runOnce(nil)
		end,
	}
end
tiny_ab5 = __TS__DecorateLegacy({ registerAbility(nil) }, tiny_ab5)
____exports.tiny_ab5 = tiny_ab5
modifier_tiny_ab5_rock_storm = __TS__Class()
modifier_tiny_ab5_rock_storm.name = "modifier_tiny_ab5_rock_storm"
__TS__ClassExtends(modifier_tiny_ab5_rock_storm, MonsterModifier_CS)
function modifier_tiny_ab5_rock_storm.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.elapsed = 0
	self.tick = 0
end
function modifier_tiny_ab5_rock_storm.prototype.IsHidden(self)
	return false
end
function modifier_tiny_ab5_rock_storm.prototype.IsPurgable(self)
	return false
end
function modifier_tiny_ab5_rock_storm.prototype.IsDebuff(self)
	return false
end
function modifier_tiny_ab5_rock_storm.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.elapsed = 0
	self.tick = 0
	self.centerPos = Vector(params.center_x, params.center_y, params.center_z)
	self.lockedForward = Vector(params.forward_x, params.forward_y, 0):Normalized()
	self.lockedRight = Vector(-self.lockedForward.y, self.lockedForward.x, 0)
	self:StartIntervalThink(TINY_AB5_TICK_INTERVAL)
end
function modifier_tiny_ab5_rock_storm.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.elapsed = self.elapsed + TINY_AB5_TICK_INTERVAL
	self.tick = self.tick + 1
	local forward = self.lockedForward
	local right = self.lockedRight
	local currentOffset = math.min(TINY_AB5_START_OFFSET + self.elapsed * TINY_AB5_FORWARD_SPEED, TINY_AB5_END_OFFSET)
	local centerLine = self.centerPos:__add(forward:__mul(currentOffset))
	local landPositions =
		self:PickNonOverlappingLandPositions(centerLine, forward, right, parent, TINY_AB5_POINTS_PER_TICK)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	for ____, pos in ipairs(landPositions) do
		local pfx = ParticleManager:CreateParticle(ROCK_DROP_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(pfx, 0, pos)
		ParticleManager:SetParticleControl(
			pfx,
			1,
			Vector(ROCK_DROP_DAMAGE_RADIUS, ROCK_DROP_DAMAGE_RADIUS, ROCK_DROP_DAMAGE_RADIUS * 3)
		)
		Timers:CreateTimer(TINY_AB5_ROCK_PFX_LIFETIME, function()
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			return nil
		end)
		warningEffectRing(nil, parent, pos, ROCK_DROP_DAMAGE_RADIUS, 1)
		EmitSoundOnLocationWithCaster(pos, "Hero_Tiny_Tree.Throw", caster)
		Timers:CreateTimer(ROCK_DROP_DAMAGE_DELAY, function()
			if not IsValidAlive(nil, caster) then
				return nil
			end
			if not ability or not IsValid(nil, ability) or ability:IsNull() then
				return nil
			end
			EmitSoundOnLocationWithCaster(pos, "Hero_Tiny_Tree.Impact", caster)
			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				pos,
				nil,
				ROCK_DROP_DAMAGE_RADIUS,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			for ____, enemy in ipairs(enemies) do
				if IsValidAlive(nil, enemy) then
					caster:MonsterDamage({ victim = enemy, damage_rate = ROCK_DROP_DAMAGE_RATE, ability = ability })
					AddDeBuffStatus(
						nil,
						enemy,
						caster,
						ability,
						DebuffStatusType.STUN,
						{ duration = ROCK_DROP_STUN_DURATION }
					)
				end
			end
			return nil
		end)
	end
	if self.elapsed >= TINY_AB5_DURATION then
		self:Destroy()
	end
end
function modifier_tiny_ab5_rock_storm.prototype.PickNonOverlappingLandPositions(
	self,
	centerLine,
	forward,
	right,
	parent,
	count
)
	local minD = TINY_AB5_LAND_MIN_DIST
	local out = {}
	local function toGround(____, raw)
		local gz = GetGroundHeight(raw, parent)
		local ____raw_x_1 = raw.x
		local ____raw_y_2 = raw.y
		local ____temp_0
		if gz ~= nil then
			____temp_0 = gz
		else
			____temp_0 = raw.z
		end
		return Vector(____raw_x_1, ____raw_y_2, ____temp_0)
	end
	do
		local i = 0
		while i < count do
			local chosen
			do
				local attempt = 0
				while attempt < TINY_AB5_LAND_PICK_ATTEMPTS do
					local sideOffset = RandomFloat(-TINY_AB5_HORIZONTAL_RANGE, TINY_AB5_HORIZONTAL_RANGE)
					local forwardJitter = RandomFloat(-200, 200)
					local raw = centerLine:__add(right:__mul(sideOffset)):__add(forward:__mul(forwardJitter))
					local pos = toGround(nil, raw)
					local ok = true
					for ____, p in ipairs(out) do
						if GetDistance(nil, pos, p) < minD then
							ok = false
							break
						end
					end
					if ok then
						chosen = pos
						break
					end
					attempt = attempt + 1
				end
			end
			if not chosen then
				local baseSide = RandomFloat(-TINY_AB5_HORIZONTAL_RANGE * 0.4, TINY_AB5_HORIZONTAL_RANGE * 0.4)
				local lateral = baseSide + (i - (count - 1) / 2) * minD
				local raw = centerLine:__add(right:__mul(lateral))
				chosen = toGround(nil, raw)
			end
			out[#out + 1] = chosen
			i = i + 1
		end
	end
	return out
end
modifier_tiny_ab5_rock_storm =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_tiny_ab5_rock_storm") }, modifier_tiny_ab5_rock_storm)
return ____exports