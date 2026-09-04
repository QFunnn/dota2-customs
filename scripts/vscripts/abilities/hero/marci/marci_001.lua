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
local modifier_marci_001_strike_activity, modifier_marci_001_self_stunned
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 伤害倍数：造成总攻击力的该倍数伤害，1 = 100%。
local MARCI_001_STRIKE_COUNT = 3
local MARCI_001_TOTAL_DURATION = 0.3
local MARCI_001_STRIKE_INTERVAL = MARCI_001_TOTAL_DURATION / MARCI_001_STRIKE_COUNT
--- 释放过程中的隐藏伤害减免百分比。
local MARCI_001_CAST_DAMAGE_REDUCTION_PCT = 40
local MARCI_001_STRIKE_PARTICLE = "particles/hero/marci/ability_0001sunce_liner_aoe.vpcf"
local MARCI_001_CAST_PREVIEW_PARTICLE =
	"particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_range_finder_aoe.vpcf"
--- 梯形打击区域长度。
local MARCI_001_TRAPEZOID_LENGTH = 600
--- 梯形打击区域近身初始宽度。
local MARCI_001_TRAPEZOID_START_WIDTH = 300
--- 梯形打击区域末端宽度。
local MARCI_001_TRAPEZOID_END_WIDTH = 300
--- Snapfire 预警粒子的宽度 CP 按半宽展开，显示值需要用实际宽度的一半。
local MARCI_001_CAST_PREVIEW_WIDTH_CP_SCALE = 0.5
local MARCI_001_STRIKE_ACTIONS = {
	{ activityModifier = "flurry_attack_a", animationLength = 0.33 },
	{ activityModifier = "flurry_attack_b", animationLength = 0.33 },
	{ activityModifier = "flurry_pulse_attack", animationLength = 0.83 },
}
____exports.marci_001 = __TS__Class()
local marci_001 = ____exports.marci_001
marci_001.name = "marci_001"
__TS__ClassExtends(marci_001, BaseHeroAbility)
function marci_001.prototype.Precache(self, context)
	PrecacheResource("particle", MARCI_001_STRIKE_PARTICLE, context)
	PrecacheResource("particle", MARCI_001_CAST_PREVIEW_PARTICLE, context)
end
function marci_001.prototype.OnCastEffect(self)
	local effect = nil
	local beginFrame = -1
	local function destroyPreviewEffect()
		if effect == nil then
			return
		end
		ParticleManager:DestroyParticle(effect, true)
		ParticleManager:ReleaseParticleIndex(effect)
		effect = nil
	end
	return {
		begin = function(____, pos)
			destroyPreviewEffect(nil)
			beginFrame = GetFrameCount()
		end,
		update = function(____, pos)
			if effect == nil then
				if beginFrame < 0 or GetFrameCount() <= beginFrame then
					return
				end
				effect = ParticleManager:CreateParticle(MARCI_001_CAST_PREVIEW_PARTICLE, PATTACH_WORLDORIGIN, nil)
			end
			self:UpdateCastPreviewEffect(effect, pos)
		end,
		["end"] = function()
			destroyPreviewEffect(nil)
			beginFrame = -1
		end,
	}
end
function marci_001.prototype.GetAbilityConfig(self)
	return {
		castPoint = MARCI_001_TOTAL_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		animationPlaybackRate = 1.8,
	}
end
function marci_001.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local forward = self:GetCastForward(caster, origin)
	caster:SetForwardVectorWithoutInterrupt(forward)
	self:PlayStrikeEffect(origin, forward, MARCI_001_TRAPEZOID_LENGTH)
	modifier_marci_001_self_stunned:applys(caster, caster, self, { duration = MARCI_001_TOTAL_DURATION })
	caster:EmitSound("Hero_Marci.Unleash.Pulse")
	local trapezoidTargetIndexes = {}
	local trapezoidTargetSet = {}
	do
		local hitIndex = 0
		while hitIndex < MARCI_001_STRIKE_COUNT do
			local currentHitIndex = hitIndex
			local currentAction = MARCI_001_STRIKE_ACTIONS[currentHitIndex + 1]
			local currentDelay = currentHitIndex * MARCI_001_STRIKE_INTERVAL
			local isLastHit = currentHitIndex == MARCI_001_STRIKE_COUNT - 1
			Timers:CreateTimer(currentDelay, function()
				if not IsValidAlive(nil, caster) then
					return nil
				end
				self:PlayStrikeGesture(caster, currentAction)
				self:PerformTrapezoidStrike(caster, forward, trapezoidTargetIndexes, trapezoidTargetSet, isLastHit)
				return nil
			end)
			hitIndex = hitIndex + 1
		end
	end
end
function marci_001.prototype.GetCastForward(self, caster, origin)
	local cursor = self:GetCursorPosition()
	return self:GetForwardFromPoint(caster, origin, cursor)
end
function marci_001.prototype.GetForwardFromPoint(self, caster, origin, point)
	local cursor = point
	local toCursor = cursor - origin
	toCursor.z = 0
	if toCursor:Length2D() <= 1 then
		return caster:GetForwardVector()
	end
	return toCursor:Normalized()
end
function marci_001.prototype.UpdateCastPreviewEffect(self, effect, cursor)
	local caster = self:GetCaster()
	if not caster or effect == nil then
		return
	end
	local origin = caster:GetAbsOrigin()
	local forward = self:GetForwardFromPoint(caster, origin, cursor)
	local endPoint = origin + forward * MARCI_001_TRAPEZOID_LENGTH * 0.9
	local previewSize = Vector(
		MARCI_001_TRAPEZOID_START_WIDTH * MARCI_001_CAST_PREVIEW_WIDTH_CP_SCALE,
		MARCI_001_TRAPEZOID_END_WIDTH * MARCI_001_CAST_PREVIEW_WIDTH_CP_SCALE,
		0
	)
	ParticleManager:SetParticleControl(effect, 0, origin)
	ParticleManager:SetParticleControl(effect, 1, endPoint)
	ParticleManager:SetParticleControl(effect, 2, previewSize)
end
function marci_001.prototype.PlayStrikeGesture(self, caster, action)
	modifier_marci_001_strike_activity:applys(
		caster,
		caster,
		self,
		{ duration = MARCI_001_STRIKE_INTERVAL, activity_modifier = action.activityModifier }
	)
	caster:RemoveGesture(ACT_DOTA_ATTACK)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, action.animationLength / MARCI_001_STRIKE_INTERVAL)
end
function marci_001.prototype.PerformTrapezoidStrike(
	self,
	caster,
	forward,
	lockedTargetIndexes,
	lockedTargetSet,
	applyStun
)
	local origin = caster:GetAbsOrigin()
	local knockbackDistance = self:GetSpecialValue("marci_001", "knockback_distance")
	local knockbackDuration = self:GetSpecialValue("marci_001", "knockback_duration")
	local damage_rate = self:GetSpecialValue("marci_001", "attack_damage_multiplier")
	local ____applyStun_0
	if applyStun then
		____applyStun_0 = self:GetSpecialValue("marci_001", "stun_duration")
	else
		____applyStun_0 = 0
	end
	local stunDuration = ____applyStun_0
	local damage = self:GetAllAttackDamage(caster) * damage_rate * 0.01
	local searchRadius = self:GetTrapezoidSearchRadius()
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakTrapezoidForHero(
			caster,
			origin,
			forward,
			MARCI_001_TRAPEZOID_LENGTH,
			MARCI_001_TRAPEZOID_START_WIDTH,
			MARCI_001_TRAPEZOID_END_WIDTH,
			self
		)
	end
	local enemies = self:FindMonsterEnemies(origin, searchRadius) or {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue25
			end
			if not self:IsPointInStrikeTrapezoid(origin, forward, enemy:GetAbsOrigin()) then
				goto __continue25
			end
			local enemyIndex = enemy:entindex()
			if lockedTargetSet[enemyIndex] then
				goto __continue25
			end
			lockedTargetSet[enemyIndex] = true
			lockedTargetIndexes[#lockedTargetIndexes + 1] = enemyIndex
		end
		::__continue25::
	end
	caster:EmitSound("Hero_Marci.Flurry.Attack")
	for ____, targetIndex in ipairs(lockedTargetIndexes) do
		do
			local target = EntIndexToHScript(targetIndex)
			if not IsValidAlive(nil, target) then
				goto __continue30
			end
			self:ApplyStrikeDamage(
				caster,
				target,
				damage,
				knockbackDistance,
				knockbackDuration,
				applyStun,
				stunDuration,
				origin
			)
		end
		::__continue30::
	end
end
function marci_001.prototype.ApplyStrikeDamage(
	self,
	caster,
	target,
	damage,
	knockbackDistance,
	knockbackDuration,
	stun,
	stunDuration,
	knockbackOrigin
)
	if not IsValidAlive(nil, target) then
		return
	end
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = damage + 6,
		damage_type = 1,
		ability = self,
	})
	target:KnockBack(caster, self, {
		duration = knockbackDuration,
		distance = knockbackDistance,
		height = 0,
		stun = stun,
		stunDuration = stunDuration,
		origin_pos = knockbackOrigin,
		removeOnDeath = true,
	})
end
function marci_001.prototype.GetTrapezoidSearchRadius(self)
	local endHalfWidth = MARCI_001_TRAPEZOID_END_WIDTH * 0.5
	return math.sqrt(MARCI_001_TRAPEZOID_LENGTH * MARCI_001_TRAPEZOID_LENGTH + endHalfWidth * endHalfWidth)
end
function marci_001.prototype.GetStrikeRightVector(self, forward)
	return Vector(-forward.y, forward.x, 0)
end
function marci_001.prototype.IsPointInStrikeTrapezoid(self, origin, forward, point)
	local toPoint = point - origin
	toPoint.z = 0
	local forwardDistance = toPoint.x * forward.x + toPoint.y * forward.y
	if forwardDistance < 0 or forwardDistance > MARCI_001_TRAPEZOID_LENGTH then
		return false
	end
	local right = self:GetStrikeRightVector(forward)
	local sideDistance = math.abs(toPoint.x * right.x + toPoint.y * right.y)
	local t = forwardDistance / MARCI_001_TRAPEZOID_LENGTH
	local width = MARCI_001_TRAPEZOID_START_WIDTH
		+ (MARCI_001_TRAPEZOID_END_WIDTH - MARCI_001_TRAPEZOID_START_WIDTH) * t
	return sideDistance <= width * 0.5
end
function marci_001.prototype.PlayStrikeEffect(self, origin, forward, radius)
	local caster = self:GetCaster()
	local strikeFx =
		MyGameHeroParticleManager:CreateParticle(MARCI_001_STRIKE_PARTICLE, PATTACH_WORLDORIGIN, nil, caster)
	MyGameHeroParticleManager:SetParticleControlTransformForward(strikeFx, 0, origin, forward)
	MyGameHeroParticleManager:SetParticleControl(strikeFx, 1, Vector(radius, radius, radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(strikeFx)
end
marci_001 = __TS__DecorateLegacy({ registerAbility(nil) }, marci_001)
____exports.marci_001 = marci_001
modifier_marci_001_strike_activity = __TS__Class()
modifier_marci_001_strike_activity.name = "modifier_marci_001_strike_activity"
__TS__ClassExtends(modifier_marci_001_strike_activity, BaseHeroModifier)
function modifier_marci_001_strike_activity.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.activityModifier = ""
end
function modifier_marci_001_strike_activity.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ____params_activity_modifier_3
	if params.activity_modifier then
		____params_activity_modifier_3 = tostring(params.activity_modifier)
	else
		____params_activity_modifier_3 = ""
	end
	self.activityModifier = ____params_activity_modifier_3
end
function modifier_marci_001_strike_activity.prototype.OnRefresh(self, params)
	self:OnCreated(params)
end
function modifier_marci_001_strike_activity.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_marci_001_strike_activity.prototype.GetActivityTranslationModifiers(self)
	return self.activityModifier
end
function modifier_marci_001_strike_activity.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
modifier_marci_001_strike_activity = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_marci_001_strike_activity)
modifier_marci_001_self_stunned = __TS__Class()
modifier_marci_001_self_stunned.name = "modifier_marci_001_self_stunned"
__TS__ClassExtends(modifier_marci_001_self_stunned, BaseHeroModifier)
function modifier_marci_001_self_stunned.prototype.GetAttributeBonus(self)
	return { damage_reduction_pct = MARCI_001_CAST_DAMAGE_REDUCTION_PCT }
end
function modifier_marci_001_self_stunned.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
function modifier_marci_001_self_stunned.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = true, isPurgable = false, isPurgeException = false }
end
modifier_marci_001_self_stunned = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_marci_001_self_stunned)
return ____exports