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
local DETECT_RANGE = 500
local MIN_DISTANCE = 200
local COLLISION_RANGE = 120
local DASH_DISTANCE = 400
local DASH_DURATION = 0.35
local COOLDOWN = 7
local CHECK_INTERVAL = 0.2
local DAMAGE_RATE = 5
local pfx = "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
local pfx2 = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf"
local DASH_PRE_MOVE_SOUND = "Hero_DoomBringer.InfernalBlade.PreAttack"
local HIT_SOUND = "Hero_VoidSpirit.Pulse.Target"
--- 普通技能2 - 被动：仅在有仇恨目标且无当前攻击目标时，500 内距离>200 向仇恨目标突进，碰撞造成伤害，7秒CD
____exports.normal_002 = __TS__Class()
local normal_002 = ____exports.normal_002
normal_002.name = "normal_002"
__TS__ClassExtends(normal_002, MonsterAbility_CS)
function normal_002.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function normal_002.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_002"
end
normal_002 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_002)
____exports.normal_002 = normal_002
____exports.modifier_normal_002 = __TS__Class()
local modifier_normal_002 = ____exports.modifier_normal_002
modifier_normal_002.name = "modifier_normal_002"
__TS__ClassExtends(modifier_normal_002, MonsterModifier_CS)
function modifier_normal_002.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.cooldownEndTime = 0
end
function modifier_normal_002.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(CHECK_INTERVAL)
end
function modifier_normal_002.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_normal_002.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CAST_ABILITY_1
end
function modifier_normal_002.prototype.GetOverrideAnimationRate(self)
	return 3
end
function modifier_normal_002.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if caster:IsStunned() or caster:IsChanneling() or caster:IsSilenced() then
		return
	end
	local ____opt_0 = caster.IsMonsterCasting
	if ____opt_0 and ____opt_0(caster) then
		return
	end
	if GameRules:GetGameTime() < self.cooldownEndTime then
		return
	end
	local ____opt_2 = caster.GetAggroTarget
	local aggroTarget = ____opt_2 and ____opt_2(caster)
	if not aggroTarget or not IsValidAlive(nil, aggroTarget) or not aggroTarget:IsHero() then
		return
	end
	if aggroTarget:GetTeamNumber() == caster:GetTeamNumber() then
		return
	end
	local ____opt_4 = caster.GetAttackTarget
	local attackTarget = ____opt_4 and ____opt_4(caster)
	if attackTarget ~= nil and IsValidAlive(nil, attackTarget) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local dist = GetDistance(nil, origin, aggroTarget:GetAbsOrigin())
	if dist <= MIN_DISTANCE or dist > DETECT_RANGE then
		return
	end
	self.cooldownEndTime = GameRules:GetGameTime() + COOLDOWN + math.random(-1, 2)
	self:PerformDash(aggroTarget)
end
function modifier_normal_002.prototype.PerformDash(self, target)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local dir = GetDirection(nil, target:GetAbsOrigin(), origin)
	local targetPoint = origin:__add(dir:__mul(DASH_DISTANCE))
	caster:SetForwardVector(dir)
	____exports.modifier_normal_002_pfx:applys(caster, caster, ability, { duration = DASH_DURATION + 0.7 })
	SafelyCall(nil, function()
		EmitSoundOn(DASH_PRE_MOVE_SOUND, caster)
		caster:Mover(targetPoint, DASH_DURATION, function(____, pos)
			if not IsValidAlive(nil, target) then
				return false
			end
			if GetDistance(nil, pos, target:GetAbsOrigin()) <= COLLISION_RANGE then
				return true
			end
			return false
		end)
	end, "normal_002.PerformDash")
end
function modifier_normal_002.prototype.IsHidden(self)
	return true
end
function modifier_normal_002.prototype.IsPurgable(self)
	return false
end
modifier_normal_002 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_002)
____exports.modifier_normal_002 = modifier_normal_002
____exports.modifier_normal_002_pfx = __TS__Class()
local modifier_normal_002_pfx = ____exports.modifier_normal_002_pfx
modifier_normal_002_pfx.name = "modifier_normal_002_pfx"
__TS__ClassExtends(modifier_normal_002_pfx, MonsterModifier_CS)
function modifier_normal_002_pfx.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_002_pfx.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	self:PlayDamageEffects(event.target)
	self:Destroy()
end
function modifier_normal_002_pfx.prototype.PlayDamageEffects(self, target)
	local caster = self:GetCaster()
	ScreenShake(target:GetAbsOrigin(), 5, 5, 0.2, 1000, 0, true)
	if IsValidAlive(nil, target) and IsValidAlive(nil, caster) then
		EmitSoundOn(HIT_SOUND, target)
		self:PlayEffects(target)
		caster:MonsterDamage({
			victim = target,
			damage_rate = DAMAGE_RATE,
			ability = self:GetAbility(),
		})
	end
end
function modifier_normal_002_pfx.prototype.PlayEffects(self, target)
	local pfx = ParticleManager:CreateParticle(pfx2, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_normal_002_pfx.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_normal_002_pfx.prototype.GetAttributeBonus(self)
	return { bonus_movespeed = 100, bonus_attack_range = 50 }
end
function modifier_normal_002_pfx.prototype.GetStatusEffectName(self)
	return pfx
end
modifier_normal_002_pfx = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_002_pfx)
____exports.modifier_normal_002_pfx = modifier_normal_002_pfx
return ____exports