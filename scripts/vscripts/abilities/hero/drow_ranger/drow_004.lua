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
local modifier_drow_004_back_jump_attack, modifier_drow_004_extra_arrow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local ____drow_003 = require("abilities.hero.drow_ranger.drow_003")
local drow_003 = ____drow_003.drow_003
local DROW_004_BACK_JUMP_DURATION = 0.36
local DROW_004_BREAK_DESTRUCTIBLE_RADIUS = 125
local function IsDrow003FrostEnabled(self, caster)
	if not IsValidAlive(nil, caster) then
		return false
	end
	local frostArrowAbility = caster:FindAbilityByName(drow_003.name)
	return not not frostArrowAbility and frostArrowAbility:GetToggleState()
end
--- 卓尔游侠技能 004（后跳）：后跳躲避攻击，结束后获得连射 buff。
-- 无目标：沿当前面向反方向执行低空抛物线位移；可调数值见 csv/ak_abilities.csv（drow_004）。
____exports.drow_004 = __TS__Class()
local drow_004 = ____exports.drow_004
drow_004.name = "drow_004"
__TS__ClassExtends(drow_004, BaseHeroAbility)
function drow_004.prototype.Precache(self, context) end
function drow_004.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0.1,
		castAnimation = "",
		behavior = bit.bor(DOTA_ABILITY_BEHAVIOR_POINT, DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING),
		animationPlaybackRate = 1,
	}
end
function drow_004.prototype.OnAbilityPhaseStart(self)
	if not IsServer() then
		return false
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return false
	end
	caster:AddActivityModifier("ti6")
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
	return true
end
function drow_004.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pos = self:GetCursorPosition()
	local forward = GetDirection(nil, pos, caster:GetAbsOrigin())
	local jumpDistance = self:GetSpecialValue("drow_004", "back_jump_distance")
	local buffDuration = self:GetSpecialValue("drow_004", "extra_arrow_buff_duration")
	caster:KnockBack(caster, self, {
		duration = DROW_004_BACK_JUMP_DURATION,
		direction = forward,
		distance = jumpDistance,
		height = 90,
		heightType = "parabola",
		stun = false,
		particleName = "",
		removeOnDeath = true,
		block = true,
		blockUntraversable = true,
	})
	modifier_drow_004_back_jump_attack:applys(caster, caster, self, { duration = DROW_004_BACK_JUMP_DURATION })
	self:StartBackJumpDestructibleBreak(caster, DROW_004_BACK_JUMP_DURATION)
	Timers:CreateTimer(DROW_004_BACK_JUMP_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		modifier_drow_004_extra_arrow:applys(caster, caster, self, { duration = buffDuration })
	end)
end
function drow_004.prototype.StartBackJumpDestructibleBreak(self, caster, duration)
	local elapsed = 0
	Timers:CreateTimer(FrameTime(), function()
		if not IsValidAlive(nil, caster) then
			return nil
		end
		elapsed = elapsed + FrameTime()
		if MyGameDestructibleManager ~= nil then
			MyGameDestructibleManager:BreakCircleForHero(
				caster,
				caster:GetAbsOrigin(),
				DROW_004_BREAK_DESTRUCTIBLE_RADIUS,
				self
			)
		end
		local ____temp_2
		if elapsed < duration then
			____temp_2 = FrameTime()
		else
			____temp_2 = nil
		end
		return ____temp_2
	end)
end
drow_004 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_004)
____exports.drow_004 = drow_004
modifier_drow_004_back_jump_attack = __TS__Class()
modifier_drow_004_back_jump_attack.name = "modifier_drow_004_back_jump_attack"
__TS__ClassExtends(modifier_drow_004_back_jump_attack, BaseHeroModifier)
function modifier_drow_004_back_jump_attack.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.attackCount = 0
	self.hasTriggered = false
end
function modifier_drow_004_back_jump_attack.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_drow_004_back_jump_attack.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.attackCount = 0
	self.hasTriggered = false
	self:StartIntervalThink(FrameTime())
end
function modifier_drow_004_back_jump_attack.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local ability = self:GetAbility()
	if not ability then
		self:Destroy()
		return
	end
	local midDelayRatio = 30 * 0.01
	local damageRate = 20 * 0.01
	local attackTimes = math.max(1, math.floor(ability:GetSpecialValue("drow_004", "back_jump_attack_times")))
	if not self.hasTriggered then
		if self:GetElapsedTime() < DROW_004_BACK_JUMP_DURATION * midDelayRatio then
			return
		end
		self.hasTriggered = true
	end
	local attackDamage = MyGameAttribute:GetAttribute(caster, "total_attack_damage") * damageRate
	local attackRange = MyGameAttribute:GetAttribute(caster, "total_attack_range") or 0
	local searchRange = math.max(attackRange * 1.2, 1)
	local target = caster:GetMinDistanceUnit(searchRange)
	if target and IsValidAlive(nil, target) then
		local projectileName = caster:GetModelName() == "models/items/drow/drow_arcana/drow_arcana.vmdl"
				and "particles/econ/items/drow/drow_arcana/drow_arcana_frost_arrow.vpcf"
			or caster:GetRangedProjectileName()
		local ____MyGameAttack_4 = MyGameAttack
		local ____MyGameAttack_PerformAttack_5 = MyGameAttack.PerformAttack
		local ____IsDrow003FrostEnabled_result_3
		if IsDrow003FrostEnabled(nil, caster) then
			____IsDrow003FrostEnabled_result_3 = projectileName
		else
			____IsDrow003FrostEnabled_result_3 = caster:GetRangedProjectileName()
		end
		____MyGameAttack_PerformAttack_5(____MyGameAttack_4, caster, target, {
			use_projectile = true,
			attack_damage = attackDamage,
			is_sub_attack = true,
			disable_celled = true,
			projectile_name = ____IsDrow003FrostEnabled_result_3,
			use_effect = true,
			extra_data = { custom_tag = "drow_004_sub_attack", source_name = "drow_004" },
		})
		self.attackCount = self.attackCount + 1
	end
	if self.attackCount >= attackTimes then
		self:Destroy()
		return
	end
	self:StartIntervalThink(FrameTime() * 5)
end
modifier_drow_004_back_jump_attack = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_004_back_jump_attack)
modifier_drow_004_extra_arrow = __TS__Class()
modifier_drow_004_extra_arrow.name = "modifier_drow_004_extra_arrow"
__TS__ClassExtends(modifier_drow_004_extra_arrow, BaseHeroModifier)
function modifier_drow_004_extra_arrow.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.activeAttackCount = 0
end
function modifier_drow_004_extra_arrow.GetLocalizationCN(self)
	return { name = "急冻箭矢", description = "攻击发射急冻箭矢" }
end
function modifier_drow_004_extra_arrow.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = true, isPurgeException = true }
end
function modifier_drow_004_extra_arrow.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.activeAttackCount = 0
	local ability = self:GetAbility()
	local ____ability_6
	if ability then
		____ability_6 = math.max(1, math.floor(ability:GetSpecialValue("drow_004", "extra_arrow_max_active_attacks")))
	else
		____ability_6 = 3
	end
	local maxActive = ____ability_6
	self:SetStackCount(maxActive)
end
function modifier_drow_004_extra_arrow.prototype.GetAttributeBonus(self)
	return { bonus_attack_range = 300 }
end
function modifier_drow_004_extra_arrow.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK }
end
function modifier_drow_004_extra_arrow.prototype.OnAttack_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	if not event.target or not IsValidAlive(nil, event.target) then
		return
	end
	local ____this_8
	____this_8 = event.target
	local ____opt_7 = ____this_8.GetUnitType
	local targetType = ____opt_7 and ____opt_7(____this_8)
	if targetType == UnitType.BUILDING or targetType == UnitType.DESTRUCTIBLE then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.activeAttackCount = self.activeAttackCount + 1
	self:DecrementStackCount()
	local damageRate = 20 * 0.01
	local maxActiveAttacks =
		math.max(1, math.floor(ability:GetSpecialValue("drow_004", "extra_arrow_max_active_attacks")))
	local attackDamage = MyGameAttribute:GetAttribute(parent, "total_attack_damage") * damageRate
	local target = event.target
	local firedCount = 0
	Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) then
			return
		end
		local attackDir = GetDirection(nil, target:GetAbsOrigin(), parent:GetAbsOrigin())
		local basePos = parent:GetAbsOrigin() + Vector(0, 0, 150)
		local forwardDir = Vector(attackDir.x, attackDir.y, 0):Normalized()
		local rightDir = RotateVector2D(nil, forwardDir, 90):Normalized()
		local upDir = Vector(0, 0, 1)
		local radius = 75
		local theta = RandomFloat(0, 360) * math.pi / 180
		local startPos = basePos + rightDir * (radius * math.cos(theta)) + upDir * (radius * math.sin(theta))
		local projectileName = parent:GetModelName() == "models/items/drow/drow_arcana/drow_arcana.vmdl"
				and "particles/econ/items/drow/drow_arcana/drow_arcana_frost_arrow.vpcf"
			or parent:GetRangedProjectileName()
		local ____MyGameAttack_10 = MyGameAttack
		local ____MyGameAttack_PerformAttack_11 = MyGameAttack.PerformAttack
		local ____IsDrow003FrostEnabled_result_9
		if IsDrow003FrostEnabled(nil, parent) then
			____IsDrow003FrostEnabled_result_9 = projectileName
		else
			____IsDrow003FrostEnabled_result_9 = parent:GetRangedProjectileName()
		end
		____MyGameAttack_PerformAttack_11(____MyGameAttack_10, parent, target, {
			use_projectile = true,
			attack_damage = attackDamage,
			is_sub_attack = true,
			disable_celled = true,
			attack_start_pos = startPos,
			projectile_name = ____IsDrow003FrostEnabled_result_9,
			use_effect = true,
			extra_data = { custom_tag = "drow_004_sub_attack", source_name = "drow_004" },
		})
		firedCount = firedCount + 1
		if firedCount >= 2 then
			return
		end
		return FrameTime() * 5
	end)
	if self.activeAttackCount >= maxActiveAttacks then
		self:Destroy()
	end
end
modifier_drow_004_extra_arrow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_004_extra_arrow)
return ____exports