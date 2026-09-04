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
local HEAL_MAX_HEALTH_PCT = 5
local HEAL_PARTICLE = "particles/item/item_heal.vpcf"
local HEAL_SOUND = "Hero_Oracle.FalsePromise.Healed"
--- 普通技能47 - 嗜血：每次攻击命中敌人时恢复自身最大生命值的5%。
____exports.normal_047 = __TS__Class()
local normal_047 = ____exports.normal_047
normal_047.name = "normal_047"
__TS__ClassExtends(normal_047, MonsterAbility_CS)
function normal_047.prototype.Precache(self, context)
	PrecacheResource("particle", HEAL_PARTICLE, context)
end
function normal_047.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_047.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_normal_047.name
end
normal_047 = __TS__DecorateLegacy({
	registerAbility(nil),
	reloadable,
}, normal_047)
____exports.normal_047 = normal_047
____exports.modifier_normal_047 = __TS__Class()
local modifier_normal_047 = ____exports.modifier_normal_047
modifier_normal_047.name = "modifier_normal_047"
__TS__ClassExtends(modifier_normal_047, MonsterModifier_CS)
function modifier_normal_047.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_047.prototype.OnAttackLanded_CS(self, event)
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
	if not IsValidAlive(nil, parent) then
		return
	end
	local target = event.target
	if not self:IsValidEnemyTarget(parent, target) then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local healAmount = parent:GetMaxHealth() * (HEAL_MAX_HEALTH_PCT / 100)
	if healAmount <= 0 then
		return
	end
	local healEvent = parent:CustomHeal(healAmount, { ability = ability, source = "spell" })
	if healEvent.actual_amount <= 0 then
		return
	end
	self:PlayHealEffect()
end
function modifier_normal_047.prototype.IsValidEnemyTarget(self, parent, target)
	if not IsValidAlive(nil, target) then
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
function modifier_normal_047.prototype.PlayHealEffect(self)
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
function modifier_normal_047.prototype.IsHidden(self)
	return true
end
function modifier_normal_047.prototype.IsPurgable(self)
	return false
end
modifier_normal_047 = __TS__DecorateLegacy({
	registerModifier(nil),
	reloadable,
}, modifier_normal_047)
____exports.modifier_normal_047 = modifier_normal_047
return ____exports