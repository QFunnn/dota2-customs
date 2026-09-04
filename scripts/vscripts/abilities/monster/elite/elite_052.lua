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
local WARNING_RADIUS = 180
local EXPLOSION_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
local EXPLOSION_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_primal_beast.vsndevts"
local EXPLOSION_SOUND = "Hero_PrimalBeast.RockThrow.Impact"
--- 精英技能 52 - 被动：攻击前摇提示落点，攻击命中时播放爆破特效。
____exports.elite_052 = __TS__Class()
local elite_052 = ____exports.elite_052
elite_052.name = "elite_052"
__TS__ClassExtends(elite_052, MonsterAbility_CS)
function elite_052.prototype.Precache(self, context)
	PrecacheResource("particle", EXPLOSION_PARTICLE, context)
	PrecacheResource("soundfile", EXPLOSION_SOUND_EVENTS, context)
	PrecacheResource("particle", "particles/monster/ability_warning_ring.vpcf", context)
end
function elite_052.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function elite_052.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_052_passive"
end
elite_052 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_052)
____exports.elite_052 = elite_052
local modifier_elite_052_passive = __TS__Class()
modifier_elite_052_passive.name = "modifier_elite_052_passive"
__TS__ClassExtends(modifier_elite_052_passive, MonsterModifier_CS)
function modifier_elite_052_passive.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_START, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_052_passive.prototype.OnAttackStart_CS(self, event)
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
	local target = event.target
	if not self:IsValidEnemyTarget(parent, target) then
		return
	end
	if GetDistance(nil, parent:GetAbsOrigin(), target:GetAbsOrigin()) > 250 then
		parent:Mover(parent:GetAbsOrigin():__add(parent:GetForwardVector():__mul(200)), 0.35)
	end
end
function modifier_elite_052_passive.prototype.OnAttackLanded_CS(self, event)
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
	local target = event.target
	if not self:IsValidEnemyTarget(parent, target) then
		return
	end
	self:PlayExplosionEffect(parent, target:GetAbsOrigin())
end
function modifier_elite_052_passive.prototype.IsValidEnemyTarget(self, parent, target)
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) then
		return false
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return false
	end
	local ____this_1
	____this_1 = target
	local ____opt_0 = ____this_1.GetUnitType
	local unitType = ____opt_0 and ____opt_0(____this_1)
	return unitType ~= UnitType.BUILDING and unitType ~= UnitType.DESTRUCTIBLE
end
function modifier_elite_052_passive.prototype.PlayExplosionEffect(self, parent, origin)
	local point = GetGroundPosition(origin, parent)
	local pfx = ParticleManager:CreateParticle(EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point)
	ParticleManager:SetParticleControl(pfx, 1, Vector(WARNING_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(pfx, 3, point)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(point, EXPLOSION_SOUND, parent)
end
function modifier_elite_052_passive.prototype.IsHidden(self)
	return true
end
function modifier_elite_052_passive.prototype.IsPurgable(self)
	return false
end
modifier_elite_052_passive =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_052_passive") }, modifier_elite_052_passive)
return ____exports