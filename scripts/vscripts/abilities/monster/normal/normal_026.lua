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
local VOID_SHOCK_CHANCE = 20
local VOID_SHOCK_DAMAGE_RATE = 7
local SILENCE_DURATION = 1
local VOID_SHOCK_PARTICLE = "particles/econ/items/death_prophet/death_prophet_ti9/death_prophet_silence_ti9_moth.vpcf"
local VOID_SHOCK_SOUND = "Hero_VoidSpirit.Pulse.Cast"
--- 普通技能26：虚空震击，攻击命中时概率造成额外魔法伤害并短暂沉默目标
____exports.normal_026 = __TS__Class()
local normal_026 = ____exports.normal_026
normal_026.name = "normal_026"
__TS__ClassExtends(normal_026, MonsterAbility_CS)
function normal_026.prototype.Precache(self, context)
	PrecacheResource("particle", VOID_SHOCK_PARTICLE, context)
end
function normal_026.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_026.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_026"
end
normal_026 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_026)
____exports.normal_026 = normal_026
local modifier_normal_026 = __TS__Class()
modifier_normal_026.name = "modifier_normal_026"
__TS__ClassExtends(modifier_normal_026, MonsterModifier_CS)
function modifier_normal_026.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_026.prototype.OnAttackLanded_CS(self, event)
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
	if RandomInt(1, 100) > VOID_SHOCK_CHANCE then
		return
	end
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	self:PlayShockEffect(target)
	parent:MonsterDamage({ victim = target, damage_rate = VOID_SHOCK_DAMAGE_RATE, damage_type = 2, ability = ability })
	target:AddNewModifier(parent, ability, "modifier_normal_026_silence", { duration = SILENCE_DURATION })
end
function modifier_normal_026.prototype.IsValidEnemyTarget(self, parent, target)
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
function modifier_normal_026.prototype.PlayShockEffect(self, target)
	local pfx = ParticleManager:CreateParticle(VOID_SHOCK_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(pfx, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 5, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 1, Vector(50, 50, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn(VOID_SHOCK_SOUND, target)
end
function modifier_normal_026.prototype.IsHidden(self)
	return true
end
function modifier_normal_026.prototype.IsPurgable(self)
	return false
end
modifier_normal_026 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_026") }, modifier_normal_026)
local modifier_normal_026_silence = __TS__Class()
modifier_normal_026_silence.name = "modifier_normal_026_silence"
__TS__ClassExtends(modifier_normal_026_silence, MonsterModifier_CS)
function modifier_normal_026_silence.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true }
end
function modifier_normal_026_silence.prototype.IsPurgable(self)
	return true
end
modifier_normal_026_silence =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_026_silence") }, modifier_normal_026_silence)
return ____exports