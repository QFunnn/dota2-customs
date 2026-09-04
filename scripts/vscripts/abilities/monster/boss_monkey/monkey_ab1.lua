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
local MONKEY_AB1_CAST_POINT = 1
local MONKEY_AB1_CAST_DURATION = 1.2
local MONKEY_AB1_STRIKE_DELAY = 0.5
local MONKEY_AB1_STRIKE_LENGTH = 1200
local MONKEY_AB1_STRIKE_WIDTH = 200
local MONKEY_AB1_STRIKE_DAMAGE = 25
local MONKEY_AB1_LAND_RADIUS = 500
local MONKEY_AB1_LAND_DAMAGE = 30
local MONKEY_AB1_JUMP_DISTANCE = 1100
____exports.monkey_ab1 = __TS__Class()
local monkey_ab1 = ____exports.monkey_ab1
monkey_ab1.name = "monkey_ab1"
__TS__ClassExtends(monkey_ab1, MonsterAbility_CS)
function monkey_ab1.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = MONKEY_AB1_CAST_POINT,
		castDuration = MONKEY_AB1_CAST_DURATION,
		isNotMove = true,
		castAnimation = ACT_DOTA_SPAWN,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			____exports.modifier_monkey_ab1_pre:applys(caster, caster, self, { duration = MONKEY_AB1_CAST_POINT })
			local target = caster:GetMinDistanceUnit(3600)
			if target then
				caster:LockTargetForSpeed(target, 0.7, 5)
			end
			self:WarningEffect(
				caster:GetAbsOrigin(),
				caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(1200)),
				0.8,
				{
					getDirection = function()
						return self._caster:GetForwardVector()
					end,
					startWidth = 128,
					endWidth = 128,
					follow = true,
				}
			)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			____exports.modifier_monkey_ab1_1:applys(caster, caster, self, { duration = 0.7 })
		end,
	}
end
function monkey_ab1.prototype.ApplyLineStrike(self, startPos, endPos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		startPos,
		endPos,
		nil,
		MONKEY_AB1_STRIKE_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue9
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = MONKEY_AB1_STRIKE_DAMAGE, ability = self })
			self:ApplyKnockup(enemy, caster:GetAbsOrigin())
		end
		::__continue9::
	end
end
function monkey_ab1.prototype.ApplyLandingImpact(self, center)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local particle = ParticleManager:CreateParticle(
		"particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_arcana_fire.vpcf",
		PATTACH_CUSTOMORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle, 0, center)
	ParticleManager:SetParticleControl(particle, 1, Vector(MONKEY_AB1_LAND_RADIUS * 0.9, 0, 0))
	ParticleManager:SetParticleControl(particle, 2, Vector(MONKEY_AB1_LAND_RADIUS * 0.9, 0, 0))
	ParticleManager:SetParticleControl(particle, 3, Vector(MONKEY_AB1_LAND_RADIUS * 0.9, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
	caster:EmitSound("Hero_MonkeyKing.Strike.Impact")
	ScreenShake(caster:GetAbsOrigin(), 15, 15, 0.1, 3000, 0, true)
	self:Timer(0.1, function()
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			center,
			nil,
			MONKEY_AB1_LAND_RADIUS * 0.6,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) or enemy == caster or enemy:FindModifierByName("modifier_immune") then
					goto __continue15
				end
				caster:MonsterDamage({ victim = enemy, damage_rate = MONKEY_AB1_LAND_DAMAGE, ability = self })
				self:ApplyKnockup(enemy, center)
			end
			::__continue15::
		end
	end)
	self:Timer(0.2, function()
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			center,
			nil,
			MONKEY_AB1_LAND_RADIUS * 0.8,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) or enemy == caster or enemy:FindModifierByName("modifier_immune") then
					goto __continue19
				end
				caster:MonsterDamage({ victim = enemy, damage_rate = MONKEY_AB1_LAND_DAMAGE, ability = self })
				self:ApplyKnockup(enemy, center)
			end
			::__continue19::
		end
	end)
end
function monkey_ab1.prototype.ApplyKnockup(self, target, originPos)
	if not IsValidAlive(nil, target) then
		return
	end
	target:KnockBack(self:GetCaster(), self, {
		origin_pos = originPos,
		duration = 0.2,
		stun = true,
		stunDuration = 0.8,
		distance = 0,
		height = 200,
	})
end
monkey_ab1 = __TS__DecorateLegacy({ registerAbility(nil) }, monkey_ab1)
____exports.monkey_ab1 = monkey_ab1
____exports.modifier_monkey_ab1_pre = __TS__Class()
local modifier_monkey_ab1_pre = ____exports.modifier_monkey_ab1_pre
modifier_monkey_ab1_pre.name = "modifier_monkey_ab1_pre"
__TS__ClassExtends(modifier_monkey_ab1_pre, BaseModifier_CS)
function modifier_monkey_ab1_pre.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(MONKEY_AB1_STRIKE_DELAY)
end
function modifier_monkey_ab1_pre.prototype.OnIntervalThink(self)
	self:StartIntervalThink(-1)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:EmitSound("Hero_MonkeyKing.Strike.Cast")
	caster:StartGesture(ACT_DOTA_MK_STRIKE)
end
function modifier_monkey_ab1_pre.prototype.GetEffectName(self)
	return "particles/underlord_2021_immortal_portal_buildup_crimson_max.vpcf"
end
function modifier_monkey_ab1_pre.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_wraithking_ghosts.vpcf"
end
modifier_monkey_ab1_pre = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_ab1_pre)
____exports.modifier_monkey_ab1_pre = modifier_monkey_ab1_pre
____exports.modifier_monkey_ab1_1 = __TS__Class()
local modifier_monkey_ab1_1 = ____exports.modifier_monkey_ab1_1
modifier_monkey_ab1_1.name = "modifier_monkey_ab1_1"
__TS__ClassExtends(modifier_monkey_ab1_1, BaseModifier_CS)
function modifier_monkey_ab1_1.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) then
		return
	end
	local startPos = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local endPos = startPos:__add(forward:__mul(MONKEY_AB1_STRIKE_LENGTH))
	local strikeParticle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_strike.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(strikeParticle, 0, startPos)
	ParticleManager:SetParticleControl(strikeParticle, 1, endPos)
	ParticleManager:ReleaseParticleIndex(strikeParticle)
	caster:EmitSound("Hero_MonkeyKing.Strike.Impact")
	ability:ApplyLineStrike(startPos, endPos)
	____exports.monkey_ab1_roll_modifer:applys(caster, caster, ability, { duration = 0.7 })
	local jumpPos = ResolveMonkeyBlinkPoint(nil, caster, startPos:__add(forward:__mul(MONKEY_AB1_JUMP_DISTANCE)))
	if not jumpPos then
		self.landingPos = startPos
		return
	end
	self.landingPos = jumpPos
	caster:Mover(jumpPos, 0.5)
	local jumpTrail = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(jumpTrail, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(jumpTrail)
end
function modifier_monkey_ab1_1.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not self.landingPos then
		return
	end
	ability:ApplyLandingImpact(self.landingPos)
end
modifier_monkey_ab1_1 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_ab1_1)
____exports.modifier_monkey_ab1_1 = modifier_monkey_ab1_1
____exports.monkey_ab1_roll_modifer = __TS__Class()
local monkey_ab1_roll_modifer = ____exports.monkey_ab1_roll_modifer
monkey_ab1_roll_modifer.name = "monkey_ab1_roll_modifer"
__TS__ClassExtends(monkey_ab1_roll_modifer, BaseModifier_CS)
function monkey_ab1_roll_modifer.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function monkey_ab1_roll_modifer.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_MK_SPRING_SOAR
end
function monkey_ab1_roll_modifer.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGesture(ACT_DOTA_MK_SPRING_END)
end
monkey_ab1_roll_modifer = __TS__DecorateLegacy({ registerModifier(nil) }, monkey_ab1_roll_modifer)
____exports.monkey_ab1_roll_modifer = monkey_ab1_roll_modifer
return ____exports