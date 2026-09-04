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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local INTERNAL_COOLDOWN = 8
local HEAL_MAX_HEALTH_PCT = 20
local DAMAGE_REDUCTION_DURATION = 1
local DAMAGE_REDUCTION_PCT = 80
local BLINK_MIN_DISTANCE = 650
local BLINK_MAX_DISTANCE = 900
local RANDOM_POINT_ATTEMPTS = 24
local FALLBACK_ANGLE_OFFSETS = {
	0,
	25,
	-25,
	50,
	-50,
	80,
	-80,
	120,
	-120,
	180,
}
local BLINK_BACK_ARC_DEGREES = 90
local BLINK_START_EFFECT = "particles/units/heroes/hero_queenofpain/queen_blink_start.vpcf"
local BLINK_END_EFFECT = "particles/units/heroes/hero_queenofpain/queen_blink_end.vpcf"
local HEAL_EFFECT = "particles/item/item_heal.vpcf"
local BLINK_OUT_SOUND = "Hero_QueenOfPain.Blink_out"
local BLINK_IN_SOUND = "Hero_QueenOfPain.Blink_in"
local HEAL_SOUND = "Hero_Oracle.FalsePromise.Healed"
--- 普通技能46 - 闪现：受击闪现后恢复生命，并短暂获得伤害减免。
____exports.normal_046 = __TS__Class()
local normal_046 = ____exports.normal_046
normal_046.name = "normal_046"
__TS__ClassExtends(normal_046, MonsterAbility_CS)
function normal_046.prototype.Precache(self, context)
	PrecacheResource("particle", BLINK_START_EFFECT, context)
	PrecacheResource("particle", BLINK_END_EFFECT, context)
	PrecacheResource("particle", HEAL_EFFECT, context)
end
function normal_046.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_046.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_normal_046.name
end
normal_046 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_046)
____exports.normal_046 = normal_046
____exports.modifier_normal_046 = __TS__Class()
local modifier_normal_046 = ____exports.modifier_normal_046
modifier_normal_046.name = "modifier_normal_046"
__TS__ClassExtends(modifier_normal_046, MonsterModifier_CS)
function modifier_normal_046.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.nextTriggerTime = 0
end
function modifier_normal_046.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_normal_046.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local ____opt_0 = parent.IsMonsterCasting
	if (____opt_0 and ____opt_0(parent)) == true then
		return
	end
	if GameRules:GetGameTime() < self.nextTriggerTime then
		return
	end
	if RandomFloat(0, 1) > 0.25 then
		return
	end
	local attacker = event.attacker
	if not self:IsValidEnemyAttacker(parent, attacker) then
		return
	end
	local blinkPoint = self:FindBlinkPointBehindAttacker(parent, attacker)
	if not blinkPoint then
		return
	end
	self.nextTriggerTime = GameRules:GetGameTime() + INTERNAL_COOLDOWN
	self:BlinkTo(parent, attacker, blinkPoint)
	self:ApplyBlinkSurvivalBonus(parent)
end
function modifier_normal_046.prototype.IsValidEnemyAttacker(self, parent, attacker)
	if not IsValidAlive(nil, attacker) then
		return false
	end
	if attacker == parent then
		return false
	end
	if attacker:IsBuilding() then
		return false
	end
	return attacker:GetTeamNumber() ~= parent:GetTeamNumber()
end
function modifier_normal_046.prototype.FindBlinkPointBehindAttacker(self, parent, attacker)
	local parentOrigin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	local attackerOrigin = GetGroundPosition(attacker:GetAbsOrigin(), attacker)
	local backDirection = self:GetAttackerBackDirection(parent, attacker, attackerOrigin)
	do
		local i = 0
		while i < RANDOM_POINT_ATTEMPTS do
			local angle = RandomFloat(-BLINK_BACK_ARC_DEGREES / 2, BLINK_BACK_ARC_DEGREES / 2)
			local distance = RandomFloat(BLINK_MIN_DISTANCE, BLINK_MAX_DISTANCE)
			local direction = RotateVector2D(nil, backDirection, angle):Normalized()
			local point = GetGroundPosition(attackerOrigin:__add(direction:__mul(distance)), parent)
			if self:IsValidBlinkPoint(parentOrigin, attackerOrigin, point) then
				return point
			end
			i = i + 1
		end
	end
	for ____, angleOffset in ipairs(FALLBACK_ANGLE_OFFSETS) do
		local direction = RotateVector2D(nil, backDirection, angleOffset):Normalized()
		local point = GetGroundPosition(attackerOrigin:__add(direction:__mul(BLINK_MIN_DISTANCE)), parent)
		if self:IsValidBlinkPoint(parentOrigin, attackerOrigin, point) then
			return point
		end
	end
	return nil
end
function modifier_normal_046.prototype.GetAttackerBackDirection(self, parent, attacker, attackerOrigin)
	local attackerForward = attacker:GetForwardVector()
	local backDirection = Vector(-attackerForward.x, -attackerForward.y, 0)
	if backDirection:Length2D() > 0.001 then
		return backDirection:Normalized()
	end
	local fallbackDirection = GetDirection(nil, parent:GetAbsOrigin(), attackerOrigin)
	if fallbackDirection:Length2D() > 0.001 then
		return fallbackDirection
	end
	return Vector(1, 0, 0)
end
function modifier_normal_046.prototype.IsValidBlinkPoint(self, parentOrigin, attackerOrigin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(parentOrigin, point) then
		return false
	end
	if GridNav:FindPathLength(parentOrigin, point) == -1 then
		return false
	end
	local distance = GetDistance(nil, attackerOrigin, point)
	return distance >= BLINK_MIN_DISTANCE and distance <= BLINK_MAX_DISTANCE
end
function modifier_normal_046.prototype.BlinkTo(self, parent, attacker, blinkPoint)
	local origin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	self:PlayBlinkEffect(BLINK_START_EFFECT, origin)
	EmitSoundOn(BLINK_OUT_SOUND, parent)
	ProjectileManager:ProjectileDodge(parent)
	FindClearSpaceForUnit(parent, blinkPoint, true)
	local finalOrigin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	parent:SetForwardVector(GetDirection(nil, attacker:GetAbsOrigin(), finalOrigin))
	self:PlayBlinkEffect(BLINK_END_EFFECT, finalOrigin)
	EmitSoundOn(BLINK_IN_SOUND, parent)
end
function modifier_normal_046.prototype.ApplyBlinkSurvivalBonus(self, parent)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local healAmount = parent:GetMaxHealth() * (HEAL_MAX_HEALTH_PCT / 100)
	if healAmount > 0 then
		local healEvent = parent:CustomHeal(healAmount, { ability = ability, source = "spell" })
		if healEvent.actual_amount > 0 then
			self:PlayHealEffects(parent)
		end
	end
	____exports.modifier_normal_046_damage_reduction:applys(
		parent,
		parent,
		ability,
		{ duration = DAMAGE_REDUCTION_DURATION }
	)
end
function modifier_normal_046.prototype.PlayBlinkEffect(self, effectName, position)
	local pfx = ParticleManager:CreateParticle(effectName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_normal_046.prototype.PlayHealEffects(self, parent)
	local caster = self:GetParent()
	local pfx = ParticleManager:CreateParticle(
		"particles/radiant_fountain_regen_summerrewardline_2026_health_initial_cough.vpcf",
		PATTACH_POINT_FOLLOW,
		caster
	)
	EmitSoundOn(HEAL_SOUND, caster)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	Timers:CreateTimer(0.25, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function modifier_normal_046.prototype.IsHidden(self)
	return true
end
function modifier_normal_046.prototype.IsPurgable(self)
	return false
end
modifier_normal_046 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_046)
____exports.modifier_normal_046 = modifier_normal_046
____exports.modifier_normal_046_damage_reduction = __TS__Class()
local modifier_normal_046_damage_reduction = ____exports.modifier_normal_046_damage_reduction
modifier_normal_046_damage_reduction.name = "modifier_normal_046_damage_reduction"
__TS__ClassExtends(modifier_normal_046_damage_reduction, MonsterModifier_CS)
function modifier_normal_046_damage_reduction.GetLocalizationCN(self)
	return { name = "闪现护势", description = "获得80%%伤害减免。" }
end
function modifier_normal_046_damage_reduction.prototype.GetAttributeBonus(self)
	return { damage_reduction_pct = DAMAGE_REDUCTION_PCT }
end
function modifier_normal_046_damage_reduction.prototype.GetTexture(self)
	return "largo_song_good_vibrations_rhythm"
end
function modifier_normal_046_damage_reduction.prototype.IsHidden(self)
	return false
end
function modifier_normal_046_damage_reduction.prototype.IsPurgable(self)
	return false
end
modifier_normal_046_damage_reduction =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_046_damage_reduction)
____exports.modifier_normal_046_damage_reduction = modifier_normal_046_damage_reduction
return ____exports