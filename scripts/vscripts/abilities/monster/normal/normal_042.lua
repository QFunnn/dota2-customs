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
local HEAL_REDUCTION_PCT_PER_STACK = 10
____exports.WOUND_DURATION = 8
local WOUND_CHECK_INTERVAL = 0.1
____exports.SHIELD_SUPPRESS_DURATION = 10
local SHIELD_SUPPRESS_INTERVAL = 0.1
local WOUND_EFFECT = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf"
--- 普通技能42 - 暗噬伤口：攻击命中附加独立计时的减疗伤口
____exports.normal_042 = __TS__Class()
local normal_042 = ____exports.normal_042
normal_042.name = "normal_042"
__TS__ClassExtends(normal_042, MonsterAbility_CS)
function normal_042.prototype.Precache(self, context)
	PrecacheResource("particle", WOUND_EFFECT, context)
end
function normal_042.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_042.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_042"
end
normal_042 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_042)
____exports.normal_042 = normal_042
local modifier_normal_042 = __TS__Class()
modifier_normal_042.name = "modifier_normal_042"
__TS__ClassExtends(modifier_normal_042, MonsterModifier_CS)
function modifier_normal_042.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_042.prototype.OnAttackLanded_CS(self, event)
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
	local hasDarknessBuff = parent:HasModifier("modifier_env_monster_darkness")
	local duration = ____exports.WOUND_DURATION
	if hasDarknessBuff then
		duration = duration * 3
	end
	____exports.modifier_normal_042_wound:applys(target, parent, self:GetAbility(), { duration = duration })
	local ____opt_0 = target.IsRealHero
	if ____opt_0 and ____opt_0(target) then
		____exports.modifier_normal_042_shield_suppress:applys(
			target,
			parent,
			self:GetAbility(),
			{ duration = ____exports.SHIELD_SUPPRESS_DURATION }
		)
	end
	target:EmitSound("Hero_Nightstalker.Void.Nihility")
end
function modifier_normal_042.prototype.IsValidEnemyTarget(self, parent, target)
	if not target or not IsValidAlive(nil, target) then
		return false
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return false
	end
	local ____this_3
	____this_3 = target
	local ____opt_2 = ____this_3.GetUnitType
	local unitType = ____opt_2 and ____opt_2(____this_3)
	return unitType ~= UnitType.BUILDING and unitType ~= UnitType.DESTRUCTIBLE
end
function modifier_normal_042.prototype.IsHidden(self)
	return true
end
function modifier_normal_042.prototype.IsPurgable(self)
	return false
end
modifier_normal_042 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_042") }, modifier_normal_042)
____exports.modifier_normal_042_wound = __TS__Class()
local modifier_normal_042_wound = ____exports.modifier_normal_042_wound
modifier_normal_042_wound.name = "modifier_normal_042_wound"
__TS__ClassExtends(modifier_normal_042_wound, MonsterModifier_CS)
function modifier_normal_042_wound.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.expireTimes = {}
end
function modifier_normal_042_wound.GetLocalizationCN(self)
	return { name = "暗噬伤口", description = "每层使受到的治疗降低10%%。" }
end
function modifier_normal_042_wound.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:AddIndependentStack()
	self:StartIntervalThink(WOUND_CHECK_INTERVAL)
end
function modifier_normal_042_wound.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:AddIndependentStack()
end
function modifier_normal_042_wound.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RemoveExpiredStacks()
end
function modifier_normal_042_wound.prototype.AddIndependentStack(self)
	local ____self_expireTimes_4 = self.expireTimes
	____self_expireTimes_4[#____self_expireTimes_4 + 1] = GameRules:GetGameTime() + ____exports.WOUND_DURATION
	self:RefreshStackCount()
end
function modifier_normal_042_wound.prototype.RemoveExpiredStacks(self)
	local now = GameRules:GetGameTime()
	local activeExpireTimes = {}
	for ____, expireTime in ipairs(self.expireTimes) do
		if expireTime > now then
			activeExpireTimes[#activeExpireTimes + 1] = expireTime
		end
	end
	self.expireTimes = activeExpireTimes
	if #self.expireTimes <= 0 then
		self:Destroy()
		return
	end
	self:RefreshStackCount()
end
function modifier_normal_042_wound.prototype.RefreshStackCount(self)
	self:SetStackCount(#self.expireTimes)
	self:RefreshAttributes()
end
function modifier_normal_042_wound.prototype.GetAttributeBonus(self)
	return { regen_amp_pct = -HEAL_REDUCTION_PCT_PER_STACK * self:GetStackCount() }
end
function modifier_normal_042_wound.prototype.IsHidden(self)
	return false
end
function modifier_normal_042_wound.prototype.IsDebuff(self)
	return true
end
function modifier_normal_042_wound.prototype.IsPurgable(self)
	return true
end
function modifier_normal_042_wound.prototype.GetTexture(self)
	return "night_stalker_void"
end
function modifier_normal_042_wound.prototype.GetEffectName(self)
	return WOUND_EFFECT
end
function modifier_normal_042_wound.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_normal_042_wound =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_042_wound") }, modifier_normal_042_wound)
____exports.modifier_normal_042_wound = modifier_normal_042_wound
____exports.modifier_normal_042_shield_suppress = __TS__Class()
local modifier_normal_042_shield_suppress = ____exports.modifier_normal_042_shield_suppress
modifier_normal_042_shield_suppress.name = "modifier_normal_042_shield_suppress"
__TS__ClassExtends(modifier_normal_042_shield_suppress, MonsterModifier_CS)
function modifier_normal_042_shield_suppress.GetLocalizationCN(self)
	return { name = "护盾压制", description = "基础护盾无法恢复。" }
end
function modifier_normal_042_shield_suppress.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SuppressShieldRecharge()
	self:StartIntervalThink(SHIELD_SUPPRESS_INTERVAL)
end
function modifier_normal_042_shield_suppress.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:SuppressShieldRecharge()
end
function modifier_normal_042_shield_suppress.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:SuppressShieldRecharge()
end
function modifier_normal_042_shield_suppress.prototype.SuppressShieldRecharge(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent.__last_energy_shield_combat_time__ = GameRules:GetGameTime()
end
function modifier_normal_042_shield_suppress.prototype.IsHidden(self)
	return false
end
function modifier_normal_042_shield_suppress.prototype.IsDebuff(self)
	return true
end
function modifier_normal_042_shield_suppress.prototype.IsPurgable(self)
	return true
end
function modifier_normal_042_shield_suppress.prototype.GetTexture(self)
	return "miniboss_minion_deflecting_shield"
end
modifier_normal_042_shield_suppress = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_normal_042_shield_suppress") },
	modifier_normal_042_shield_suppress
)
____exports.modifier_normal_042_shield_suppress = modifier_normal_042_shield_suppress
return ____exports