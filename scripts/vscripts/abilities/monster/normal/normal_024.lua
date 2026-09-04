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
local SHADOW_STRIKE_CHANCE = 25
local SHADOW_STRIKE_DAMAGE_RATE = 6
local SHADOW_STRIKE_PARTICLE = "particles/templar_assassin_meld_hit.vpcf"
local SHADOW_STRIKE_SOUND = "Hero_PhantomAssassin.CoupDeGrace"
--- 普通技能24：影刃，攻击命中时概率造成额外伤害
____exports.normal_024 = __TS__Class()
local normal_024 = ____exports.normal_024
normal_024.name = "normal_024"
__TS__ClassExtends(normal_024, MonsterAbility_CS)
function normal_024.prototype.Precache(self, context)
	PrecacheResource("particle", SHADOW_STRIKE_PARTICLE, context)
end
function normal_024.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_024.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_024"
end
normal_024 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_024)
____exports.normal_024 = normal_024
local modifier_normal_024 = __TS__Class()
modifier_normal_024.name = "modifier_normal_024"
__TS__ClassExtends(modifier_normal_024, MonsterModifier_CS)
function modifier_normal_024.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_024.prototype.OnAttackLanded_CS(self, event)
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
	if RandomInt(1, 100) > SHADOW_STRIKE_CHANCE then
		return
	end
	self:PlayHitEffect(target)
	parent:MonsterDamage({
		victim = target,
		damage_rate = SHADOW_STRIKE_DAMAGE_RATE,
		ability = self:GetAbility(),
	})
end
function modifier_normal_024.prototype.IsValidEnemyTarget(self, parent, target)
	if not target or not IsValidAlive(nil, target) then
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
function modifier_normal_024.prototype.PlayHitEffect(self, target)
	local pfx = ParticleManager:CreateParticle(SHADOW_STRIKE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(pfx, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 3, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn(SHADOW_STRIKE_SOUND, target)
end
function modifier_normal_024.prototype.IsHidden(self)
	return true
end
function modifier_normal_024.prototype.IsPurgable(self)
	return false
end
modifier_normal_024 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_024") }, modifier_normal_024)
return ____exports