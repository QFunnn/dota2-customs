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
--- 减速：移速 -25%（百分比），攻速 -40（与项目内减速刻度一致）
local DEBUFF_DURATION = 3
local SLOW_MOVESPEED_PCT = 25
local SLOW_ATTACK_SPEED = 40
local AQUA_DOT_TICKS = 3
--- 持续 debuff 辅层：水流环绕感（AddParticle 绑定单位，与 GetEffectName 叠加以强化「持续」而非爆发）
local PFX_DEBUFF_STREAM = "particles/viper_poison_crimson_debuff_ti7.vpcf"
--- 普通技能10 - 被动：攻击命中施加「潮蚀」减速（攻速 -40、移速 -25%），持续 3 秒；每秒 10 点魔法持续伤害；水系特效。
____exports.normal_010 = __TS__Class()
local normal_010 = ____exports.normal_010
normal_010.name = "normal_010"
__TS__ClassExtends(normal_010, MonsterAbility_CS)
function normal_010.prototype.Precache(self, context)
	PrecacheResource("particle", PFX_DEBUFF_STREAM, context)
end
function normal_010.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_010.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_010"
end
normal_010 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_010)
____exports.normal_010 = normal_010
____exports.modifier_normal_010 = __TS__Class()
local modifier_normal_010 = ____exports.modifier_normal_010
modifier_normal_010.name = "modifier_normal_010"
__TS__ClassExtends(modifier_normal_010, MonsterModifier_CS)
function modifier_normal_010.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_010.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	____exports.modifier_normal_010_aqua_slow:applys(
		target,
		event.attacker,
		self:GetAbility(),
		{ duration = DEBUFF_DURATION }
	)
	self._caster:EmitSound("hero_viper.poisonAttack.Cast.ti7")
end
function modifier_normal_010.prototype.IsHidden(self)
	return true
end
modifier_normal_010 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_010)
____exports.modifier_normal_010 = modifier_normal_010
____exports.modifier_normal_010_aqua_slow = __TS__Class()
local modifier_normal_010_aqua_slow = ____exports.modifier_normal_010_aqua_slow
modifier_normal_010_aqua_slow.name = "modifier_normal_010_aqua_slow"
__TS__ClassExtends(modifier_normal_010_aqua_slow, MonsterModifier_CS)
function modifier_normal_010_aqua_slow.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.dotTicksLeft = AQUA_DOT_TICKS
end
function modifier_normal_010_aqua_slow.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local streamPid = ParticleManager:CreateParticle(PFX_DEBUFF_STREAM, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		streamPid,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(streamPid, false, false, -1, false, true)
	self.dotTicksLeft = AQUA_DOT_TICKS
	self:AquaDotTick()
	self.dotTicksLeft = self.dotTicksLeft - 1
	if self.dotTicksLeft <= 0 then
		return
	end
	self:StartIntervalThink(1)
end
function modifier_normal_010_aqua_slow.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self.dotTicksLeft = AQUA_DOT_TICKS
	self:AquaDotTick()
	self.dotTicksLeft = self.dotTicksLeft - 1
	if self.dotTicksLeft <= 0 then
		return
	end
	self:StartIntervalThink(1)
end
function modifier_normal_010_aqua_slow.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:AquaDotTick()
	self.dotTicksLeft = self.dotTicksLeft - 1
	if self.dotTicksLeft <= 0 then
		self:StartIntervalThink(-1)
	end
end
function modifier_normal_010_aqua_slow.prototype.AquaDotTick(self)
	local victim = self:GetParent()
	local attacker = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, victim) then
		return
	end
	if not IsValidAlive(nil, attacker) then
		return
	end
	attacker:MonsterDamage({
		victim = victim,
		damage_rate = 2,
		ability = self:GetAbility(),
	})
end
function modifier_normal_010_aqua_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -SLOW_MOVESPEED_PCT, attack_speed = -SLOW_ATTACK_SPEED }
end
function modifier_normal_010_aqua_slow.prototype.GetEffectName(self)
	return PFX_DEBUFF_STREAM
end
function modifier_normal_010_aqua_slow.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_normal_010_aqua_slow.prototype.IsHidden(self)
	return false
end
function modifier_normal_010_aqua_slow.prototype.IsDebuff(self)
	return true
end
function modifier_normal_010_aqua_slow.prototype.IsPurgable(self)
	return true
end
modifier_normal_010_aqua_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_010_aqua_slow)
____exports.modifier_normal_010_aqua_slow = modifier_normal_010_aqua_slow
return ____exports