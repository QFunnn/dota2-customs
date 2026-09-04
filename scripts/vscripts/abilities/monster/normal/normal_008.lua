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
local EXTRA_ATTACK_COUNT_MIN = 5
local EXTRA_ATTACK_COUNT_MAX = 7
local EXTRA_ATTACK_INTERVAL = 0.1
local SCATTER_RADIUS = 400
local PROJECTILE_RADIUS = 60
local PROJECTILE_SPEED_FALLBACK = 1100
local PROJECTILE_EFFECT = "particles/units/heroes/hero_venomancer/venomancer_plague_ward_projectile_2.vpcf"
--- 普通技能8 - 被动：攻击时连续对当前目标区域补发多枚追击投射物
____exports.normal_008 = __TS__Class()
local normal_008 = ____exports.normal_008
normal_008.name = "normal_008"
__TS__ClassExtends(normal_008, MonsterAbility_CS)
function normal_008.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
end
function normal_008.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_008.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_008"
end
normal_008 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_008)
____exports.normal_008 = normal_008
local modifier_normal_008 = __TS__Class()
modifier_normal_008.name = "modifier_normal_008"
__TS__ClassExtends(modifier_normal_008, MonsterModifier_CS)
function modifier_normal_008.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK }
end
function modifier_normal_008.prototype.OnAttack_CS(self, event)
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
	local ____this_1
	____this_1 = event.target
	local ____opt_0 = ____this_1.GetUnitType
	local unitType = ____opt_0 and ____opt_0(____this_1)
	if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
		return
	end
	if event.is_sub_attack then
		return
	end
	local originalTarget = event.target
	local originalDamage = event.attack_damage
	local extraAttackCount = RandomInt(EXTRA_ATTACK_COUNT_MIN, EXTRA_ATTACK_COUNT_MAX)
	local firedCount = 0
	self:Timer(0, function()
		if not IsValidAlive(nil, parent) then
			return nil
		end
		if firedCount >= extraAttackCount then
			return nil
		end
		if not IsValidAlive(nil, originalTarget) then
			return nil
		end
		self:FireScatterProjectile(parent, originalTarget, originalDamage)
		firedCount = firedCount + 1
		return firedCount < extraAttackCount and EXTRA_ATTACK_INTERVAL or nil
	end)
end
function modifier_normal_008.prototype.FireScatterProjectile(self, attacker, originalTarget, attackDamage)
	if not IsValidAlive(nil, attacker) then
		return
	end
	local startPoint = self:GetProjectileStartPoint(attacker)
	if not startPoint then
		return
	end
	if not IsValidAlive(nil, originalTarget) then
		return
	end
	local scatterPoint = originalTarget:GetAbsOrigin():__add(RandomVector(RandomFloat(0, SCATTER_RADIUS)))
	local groundedTarget = GetGroundPosition(scatterPoint, originalTarget)
	local targetPoint = Vector(scatterPoint.x, scatterPoint.y, groundedTarget.z)
	EmitSoundOnLocationWithCaster(startPoint, "Hero_VenomancerWard.Attack", attacker)
	CreateProjectile(nil, {
		ability = self:GetAbility(),
		caster = attacker,
		effect_name = PROJECTILE_EFFECT,
		start_point = startPoint,
		target = targetPoint,
		projectile_type = "linear",
		projectile_speed = PROJECTILE_SPEED_FALLBACK or attacker:GetProjectileSpeed(),
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		projectile_distance = MyGameAttribute:GetAttribute(attacker, "total_attack_range") + 300,
		projectile_range = PROJECTILE_RADIUS,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, attacker) then
				return true
			end
			local ____this_3
			____this_3 = hitTarget
			local ____opt_2 = ____this_3.GetUnitType
			local unitType = ____opt_2 and ____opt_2(____this_3)
			if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
				return true
			end
			MyGameAttack:PerformAttack(attacker, hitTarget, {
				use_projectile = false,
				is_sub_attack = true,
				attack_damage = MyGameAttribute:GetAttribute(attacker, "total_attack_damage") * 0.6,
			})
			AddDeBuffStatus(
				nil,
				hitTarget,
				attacker,
				self:GetAbility(),
				DebuffStatusType.POISON,
				{ stack = 1, duration = 5 }
			)
			return true
		end,
	})
end
function modifier_normal_008.prototype.GetProjectileStartPoint(self, attacker)
	if not IsValidAlive(nil, attacker) then
		return nil
	end
	local function tryGet(____, name)
		if not IsValidAlive(nil, attacker) then
			return nil
		end
		local idx = attacker:ScriptLookupAttachment(name)
		if idx < 0 then
			return nil
		end
		local pos = attacker:GetAttachmentOrigin(idx)
		if pos.x == 0 and pos.y == 0 and pos.z == 0 then
			return nil
		end
		return pos
	end
	return tryGet(nil, "attach_attack1")
		or tryGet(nil, "attach_attack2")
		or attacker:GetAbsOrigin():__add(Vector(0, 0, attacker:GetBoundingMaxs().z * 0.7))
		or attacker:GetAbsOrigin()
end
function modifier_normal_008.prototype.IsHidden(self)
	return true
end
function modifier_normal_008.prototype.IsPurgable(self)
	return false
end
modifier_normal_008 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_008") }, modifier_normal_008)
return ____exports