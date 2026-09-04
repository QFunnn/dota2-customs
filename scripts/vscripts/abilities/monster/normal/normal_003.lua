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
local modifier_normal_003_frost_armor, modifier_normal_003_frost_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 0.6
local SEARCH_RANGE = 700
local ARMOR_BONUS = 3
local SLOW_DURATION = 3
local SLOW_MOVESPEED = -30
local SLOW_ATTACK_SPEED = -30
local SLOW_EFFECT = "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_slow.vpcf"
local FROST_ARMOR_EFFECT = "particles/neutral_fx/ogre_magi_frost_armor.vpcf"
local PROJECTILE_EFFECT = "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf"
local PROJECTILE_SPEED = 900
local CAST_SOUND = "Hero_Winter_Wyvern.SplinterBlast.Cast"
local TARGET_SOUND = "Hero_Winter_Wyvern.SplinterBlast.Target"
local function findFrostArmorTarget(self, caster)
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		SEARCH_RANGE,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_FARTHEST,
		false
	)
	local target
	local minDist = 99999
	for ____, u in ipairs(allies) do
		do
			if not IsValidAlive(nil, u) or u == caster then
				goto __continue3
			end
			local len = u:GetAbsOrigin():__sub(caster:GetAbsOrigin()):Length2D()
			if len < minDist then
				minDist = len
				target = u
			end
		end
		::__continue3::
	end
	local ____temp_0
	if target and IsValidAlive(nil, target) then
		____temp_0 = target
	else
		____temp_0 = caster
	end
	return ____temp_0
end
--- 普通技能3 - 前摇 0.6s 面向目标友军，发射投射物，命中施加冰霜护甲（+3 护甲，攻击者被减速）
____exports.normal_003 = __TS__Class()
local normal_003 = ____exports.normal_003
normal_003.name = "normal_003"
__TS__ClassExtends(normal_003, MonsterAbility_CS)
function normal_003.prototype.Precache(self, context)
	PrecacheResource("particle", SLOW_EFFECT, context)
	PrecacheResource("particle", FROST_ARMOR_EFFECT, context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
end
function normal_003.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		castRange = 2500,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = findFrostArmorTarget(nil, caster)
			self._target = target
			caster:LockTargetForSpeed(target, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound(CAST_SOUND)
			local startPoint = caster:GetAbsOrigin():__add(Vector(0, 0, 96)):__add(caster:GetForwardVector():__mul(80))
			local target = self._target
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				projectile_type = "tracking",
				effect_name = PROJECTILE_EFFECT,
				target = target,
				projectile_speed = PROJECTILE_SPEED,
				start_point = startPoint,
				on_hit = function(____, hitTarget)
					if not hitTarget or not IsValidAlive(nil, hitTarget) then
						return true
					end
					modifier_normal_003_frost_armor:applys(hitTarget, caster, self, { duration = SLOW_DURATION * 3 })
					hitTarget:EmitSound(TARGET_SOUND)
					return true
				end,
			})
		end,
	}
end
normal_003 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_003)
____exports.normal_003 = normal_003
modifier_normal_003_frost_armor = __TS__Class()
modifier_normal_003_frost_armor.name = "modifier_normal_003_frost_armor"
__TS__ClassExtends(modifier_normal_003_frost_armor, MonsterModifier_CS)
function modifier_normal_003_frost_armor.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_normal_003_frost_armor.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	local attacker = event.attacker
	if not IsValidAlive(nil, attacker) or attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	modifier_normal_003_frost_slow:applys(attacker, self._caster, self._ability, { duration = SLOW_DURATION })
end
function modifier_normal_003_frost_armor.prototype.GetAttributeBonus(self)
	return { bonus_armor = ARMOR_BONUS }
end
function modifier_normal_003_frost_armor.prototype.GetEffectName(self)
	return FROST_ARMOR_EFFECT
end
function modifier_normal_003_frost_armor.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_normal_003_frost_armor.prototype.IsHidden(self)
	return false
end
function modifier_normal_003_frost_armor.prototype.IsDebuff(self)
	return false
end
function modifier_normal_003_frost_armor.prototype.IsPurgable(self)
	return true
end
modifier_normal_003_frost_armor =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_003_frost_armor") }, modifier_normal_003_frost_armor)
modifier_normal_003_frost_slow = __TS__Class()
modifier_normal_003_frost_slow.name = "modifier_normal_003_frost_slow"
__TS__ClassExtends(modifier_normal_003_frost_slow, MonsterModifier_CS)
function modifier_normal_003_frost_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed = SLOW_MOVESPEED, attack_speed = SLOW_ATTACK_SPEED }
end
function modifier_normal_003_frost_slow.prototype.GetEffectName(self)
	return SLOW_EFFECT
end
function modifier_normal_003_frost_slow.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_normal_003_frost_slow.prototype.IsHidden(self)
	return false
end
function modifier_normal_003_frost_slow.prototype.IsDebuff(self)
	return true
end
function modifier_normal_003_frost_slow.prototype.IsPurgable(self)
	return true
end
modifier_normal_003_frost_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_003_frost_slow") }, modifier_normal_003_frost_slow)
return ____exports