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
local ____tstl_2Dutils = require("utils.tstl-utils")
local reloadable = ____tstl_2Dutils.reloadable
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local MAX_HEALTH_DAMAGE_PCT = 1
local MAX_SHIELD_DAMAGE_PCT = 1
local HIT_PARTICLE = "particles/neutral_fx/miniboss_dire_shield_hit.vpcf"
local HIT_SOUND = "Hero_Nightstalker.Void"
--- 普通技能51 - 深殿掠击：攻击命中时附加目标最大生命和最大护盾的百分比伤害。
____exports.normal_051 = __TS__Class()
local normal_051 = ____exports.normal_051
normal_051.name = "normal_051"
__TS__ClassExtends(normal_051, MonsterAbility_CS)
function normal_051.prototype.Precache(self, context)
	PrecacheResource("particle", HIT_PARTICLE, context)
end
function normal_051.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_051.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_normal_051.name
end
normal_051 = __TS__DecorateLegacy({
	registerAbility(nil),
	reloadable,
}, normal_051)
____exports.normal_051 = normal_051
____exports.modifier_normal_051 = __TS__Class()
local modifier_normal_051 = ____exports.modifier_normal_051
modifier_normal_051.name = "modifier_normal_051"
__TS__ClassExtends(modifier_normal_051, MonsterModifier_CS)
function modifier_normal_051.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_051.prototype.OnAttackLanded_CS(self, event)
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
	if event.is_base_attack == false then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local target = event.target
	if not self:IsValidEnemyTarget(parent, target) then
		return
	end
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	local damage = self:CalculateBonusDamage(target)
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = parent,
		damage = damage,
		damage_type = 4,
		ability = ability,
		extra_data = { custom_tag = "normal_051_deep_temple_strike", source_name = "深殿掠击" },
	})
	self:PlayHitEffects(target)
end
function modifier_normal_051.prototype.CalculateBonusDamage(self, target)
	local maxHealth = math.max(0, target:GetMaxHealth())
	local ____math_max_2 = math.max
	local ____this_1
	____this_1 = target
	local ____opt_0 = ____this_1.GetTotalEnergyShield
	local maxShield = ____math_max_2(
		0,
		____opt_0 and ____opt_0(____this_1) or MyGameAttribute:GetAttribute(target, "total_energy_shield") or 0
	)
	return maxHealth * (MAX_HEALTH_DAMAGE_PCT / 100) + maxShield * (MAX_SHIELD_DAMAGE_PCT / 100)
end
function modifier_normal_051.prototype.IsValidEnemyTarget(self, parent, target)
	if not IsValidAlive(nil, target) then
		return false
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return false
	end
	local ____this_4
	____this_4 = target
	local ____opt_3 = ____this_4.GetUnitType
	local unitType = ____opt_3 and ____opt_3(____this_4)
	return unitType ~= UnitType.BUILDING and unitType ~= UnitType.DESTRUCTIBLE
end
function modifier_normal_051.prototype.PlayHitEffects(self, target)
	local particle = ParticleManager:CreateParticle(HIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn(HIT_SOUND, target)
end
function modifier_normal_051.prototype.IsHidden(self)
	return true
end
function modifier_normal_051.prototype.IsPurgable(self)
	return false
end
modifier_normal_051 = __TS__DecorateLegacy({
	registerModifier(nil),
	reloadable,
}, modifier_normal_051)
____exports.modifier_normal_051 = modifier_normal_051
return ____exports