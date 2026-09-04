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
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 叠层头顶特效：cp0 为原点，cp1.x 为下一次攻击是否触发爆发(1/0)，cp1.y 为层数
local PA_003_MARK_OVERHEAD_PARTICLE = "particles/pa/ability_003_1_counter.vpcf"
--- 满层触发伤害特效
local PA_003_BURST_IMPACT_PARTICLE = "particles/hero/pa/phantom_assassin_crit_impact.vpcf"
local PA_003_BURST_SOUND = "Hero_PhantomAssassin.CoupDeGrace"
local PA_003_MARK_MAX_STACK_REDUCE_KEY = "pa_003_mark_max_stack_reduce"
--- 幻影刺客技能 003 - 印记爆发（被动）
-- 攻击命中时给目标添加可叠加 debuff，达到满层后触发一次伤害并清空该 debuff。
____exports.pa_003 = __TS__Class()
local pa_003 = ____exports.pa_003
pa_003.name = "pa_003"
__TS__ClassExtends(pa_003, BaseHeroAbility)
function pa_003.prototype.Precache(self, context)
	PrecacheResource("particle", PA_003_MARK_OVERHEAD_PARTICLE, context)
	PrecacheResource("particle", PA_003_BURST_IMPACT_PARTICLE, context)
end
function pa_003.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function pa_003.prototype.GetIntrinsicModifierName(self)
	return "modifier_pa_003_mark_attacker"
end
pa_003 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_003)
____exports.pa_003 = pa_003
--- 攻击者身上的被动驱动 Modifier：命中时给目标叠层，满层触发伤害并清空。
____exports.modifier_pa_003_mark_attacker = __TS__Class()
local modifier_pa_003_mark_attacker = ____exports.modifier_pa_003_mark_attacker
modifier_pa_003_mark_attacker.name = "modifier_pa_003_mark_attacker"
__TS__ClassExtends(modifier_pa_003_mark_attacker, BaseHeroModifier)
function modifier_pa_003_mark_attacker.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self._tempCrit = false
end
function modifier_pa_003_mark_attacker.GetLocalizationCN(self)
	return { name = "印记爆发", description = "攻击命中时给目标添加可叠加印记" }
end
function modifier_pa_003_mark_attacker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_START, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_pa_003_mark_attacker.prototype.OnAttackStart_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	self._tempCrit = false
	local mark = ____exports.modifier_pa_003_mark_debuff:find_on(target)
	if not mark then
		return
	end
	local ability = self:GetAbility()
	local ____temp_0
	if ability and IsValid(nil, ability) then
		____temp_0 = math.max(1, math.floor(self:GetSpecialValue("pa_003", "mark_max_stack")))
	else
		____temp_0 = 5
	end
	local baseStack = ____temp_0
	local ____tonumber_3 = tonumber
	local ____opt_1 = parent.GetCustomValue
	local reduce = ____tonumber_3(____opt_1 and ____opt_1(parent, PA_003_MARK_MAX_STACK_REDUCE_KEY) or 0) or 0
	local markMaxStack = math.max(1, baseStack - reduce)
	local willReachMax = mark:GetCurrentMarkCount() >= markMaxStack - 1
	if not willReachMax then
		return
	end
	self._tempCrit = true
	local speed = MyGameAttribute:GetAttribute(parent, "total_attack_speed") / 100
	parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, math.max(speed, 0.1))
end
function modifier_pa_003_mark_attacker.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) then
		return
	end
	local mark = ____exports.modifier_pa_003_mark_debuff:find_on(target)
	if not mark then
		mark = ____exports.modifier_pa_003_mark_debuff:applys(
			target,
			caster,
			ability,
			{ duration = math.max(0.03, self:GetSpecialValue("pa_003", "mark_duration")) }
		)
	end
	if not mark then
		return
	end
	local reachedMax = mark:AddMarkStack()
	if not reachedMax then
		return
	end
	local damage = MyGameAttribute:GetAttribute(caster, "total_agility")
		* math.max(0.01, self:GetSpecialValue("pa_003", "agility_damage_multiplier") / 100)
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = damage,
		damage_type = 1,
		ability = ability,
	})
	ScreenShake(target:GetAbsOrigin(), 10, 10, 0.1, 1200, 0, true)
	self:PlayEffects(target)
	mark:Destroy()
end
function modifier_pa_003_mark_attacker.prototype.PlayEffects(self, target)
	ScreenShake(target:GetAbsOrigin(), 7, 7, 0.3, 1000, 0, true)
	target:EmitSound(PA_003_BURST_SOUND)
	local pfx_name = self:GetParent():GetModelName() == "models/heroes/phantom_assassin/pa_arcana.vmdl"
			and "particles/pa/ability_eff_1econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf"
		or PA_003_BURST_IMPACT_PARTICLE
	local particle = MyGameHeroParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN, target, self:GetParent())
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		target,
		PATTACH_ABSORIGIN,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_ABSORIGIN,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlTransformForward(
		particle,
		1,
		target:GetAbsOrigin(),
		GetDirection(nil, self:GetParent():GetAbsOrigin(), target:GetAbsOrigin())
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
function modifier_pa_003_mark_attacker.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_pa_003_mark_attacker.prototype.GetActivityTranslationModifiers(self)
	if not IsServer() then
		return ""
	end
	if self._tempCrit then
		self._tempCrit = false
		return "phantom_attack"
	end
	return ""
end
modifier_pa_003_mark_attacker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_003_mark_attacker)
____exports.modifier_pa_003_mark_attacker = modifier_pa_003_mark_attacker
____exports.modifier_pa_003_mark_debuff = __TS__Class()
local modifier_pa_003_mark_debuff = ____exports.modifier_pa_003_mark_debuff
modifier_pa_003_mark_debuff.name = "modifier_pa_003_mark_debuff"
__TS__ClassExtends(modifier_pa_003_mark_debuff, BaseHeroModifier)
function modifier_pa_003_mark_debuff.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.markExpireTimes = {}
end
function modifier_pa_003_mark_debuff.GetLocalizationCN(self)
	return { name = "印记", description = "达到满层后触发一次伤害并清空该印记" }
end
function modifier_pa_003_mark_debuff.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = true, isPurgable = true, isPurgeException = true }
end
function modifier_pa_003_mark_debuff.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self.markExpireTimes = {}
	self.overheadParticleId =
		ParticleManager:CreateParticle(PA_003_MARK_OVERHEAD_PARTICLE, PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	self:UpdateOverheadStackFx()
	self:StartIntervalThink(0.1)
end
function modifier_pa_003_mark_debuff.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.overheadParticleId ~= nil then
		ParticleManager:DestroyParticle(self.overheadParticleId, true)
		ParticleManager:ReleaseParticleIndex(self.overheadParticleId)
		self.overheadParticleId = nil
	end
end
function modifier_pa_003_mark_debuff.prototype.AddMarkStack(self)
	local now = GameRules:GetGameTime()
	self:CleanupExpiredStacks(now)
	local ability = self:GetAbility()
	local ____temp_4
	if ability and IsValid(nil, ability) then
		____temp_4 = math.max(1, math.floor(self:GetSpecialValue("pa_003", "mark_max_stack")))
	else
		____temp_4 = 5
	end
	local baseStack = ____temp_4
	local ____tonumber_7 = tonumber
	local ____this_6
	____this_6 = self._caster
	local ____opt_5 = ____this_6.GetCustomValue
	local reduce = ____tonumber_7(____opt_5 and ____opt_5(____this_6, PA_003_MARK_MAX_STACK_REDUCE_KEY) or 0) or 0
	local maxStack = math.max(1, baseStack - reduce)
	if #self.markExpireTimes > maxStack then
		self.markExpireTimes = __TS__ArraySlice(self.markExpireTimes, -maxStack)
	end
	if #self.markExpireTimes < maxStack then
		local ____self_markExpireTimes_8 = self.markExpireTimes
		____self_markExpireTimes_8[#____self_markExpireTimes_8 + 1] = now
			+ math.max(0.03, self:GetSpecialValue("pa_003", "mark_duration"))
	end
	local next = #self.markExpireTimes
	self:SetStackCount(next)
	self:SyncModifierDuration(now)
	self:UpdateOverheadStackFx()
	return next >= maxStack
end
function modifier_pa_003_mark_debuff.prototype.GetCurrentMarkCount(self)
	local now = GameRules:GetGameTime()
	self:CleanupExpiredStacks(now)
	local ability = self:GetAbility()
	local ____temp_9
	if ability and IsValid(nil, ability) then
		____temp_9 = math.max(1, math.floor(self:GetSpecialValue("pa_003", "mark_max_stack")))
	else
		____temp_9 = 5
	end
	local baseStack = ____temp_9
	local ____tonumber_12 = tonumber
	local ____this_11
	____this_11 = self._caster
	local ____opt_10 = ____this_11.GetCustomValue
	local reduce = ____tonumber_12(____opt_10 and ____opt_10(____this_11, PA_003_MARK_MAX_STACK_REDUCE_KEY) or 0) or 0
	local maxStack = math.max(1, baseStack - reduce)
	if #self.markExpireTimes > maxStack then
		self.markExpireTimes = __TS__ArraySlice(self.markExpireTimes, -maxStack)
	end
	local count = #self.markExpireTimes
	if count ~= self:GetStackCount() then
		self:SetStackCount(count)
		self:UpdateOverheadStackFx()
	end
	return count
end
function modifier_pa_003_mark_debuff.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local now = GameRules:GetGameTime()
	local changed = self:CleanupExpiredStacks(now)
	if not changed then
		return
	end
	local ability = self:GetAbility()
	local ____temp_13
	if ability and IsValid(nil, ability) then
		____temp_13 = math.max(1, math.floor(self:GetSpecialValue("pa_003", "mark_max_stack")))
	else
		____temp_13 = 5
	end
	local baseStack = ____temp_13
	if not IsValidAlive(nil, self._caster) then
		return
	end
	local ____tonumber_16 = tonumber
	local ____this_15
	____this_15 = self._caster
	local ____opt_14 = ____this_15.GetCustomValue
	local reduce = ____tonumber_16(____opt_14 and ____opt_14(____this_15, PA_003_MARK_MAX_STACK_REDUCE_KEY) or 0) or 0
	local maxStack = math.max(1, baseStack - reduce)
	if #self.markExpireTimes > maxStack then
		self.markExpireTimes = __TS__ArraySlice(self.markExpireTimes, -maxStack)
	end
	local count = #self.markExpireTimes
	self:SetStackCount(count)
	self:UpdateOverheadStackFx()
	if count <= 0 then
		self:Destroy()
		return
	end
	self:SyncModifierDuration(now)
end
function modifier_pa_003_mark_debuff.prototype.CleanupExpiredStacks(self, now)
	local before = #self.markExpireTimes
	self.markExpireTimes = __TS__ArrayFilter(self.markExpireTimes, function(____, expireAt)
		return expireAt > now
	end)
	return #self.markExpireTimes ~= before
end
function modifier_pa_003_mark_debuff.prototype.SyncModifierDuration(self, now)
	if #self.markExpireTimes <= 0 then
		return
	end
	local latestExpire = self.markExpireTimes[#self.markExpireTimes]
	self:SetDuration(math.max(latestExpire - now, 0.03), true)
end
function modifier_pa_003_mark_debuff.prototype.UpdateOverheadStackFx(self)
	if self.overheadParticleId == nil then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	local origin = self:GetParent():GetAbsOrigin()
	local ability = self:GetAbility()
	local ____temp_17
	if ability and IsValid(nil, ability) then
		____temp_17 = math.max(1, math.floor(self:GetSpecialValue("pa_003", "mark_max_stack")))
	else
		____temp_17 = 5
	end
	local baseStack = ____temp_17
	if not IsValidAlive(nil, self._caster) then
		return
	end
	local ____tonumber_20 = tonumber
	local ____this_19
	____this_19 = self._caster
	local ____opt_18 = ____this_19.GetCustomValue
	local reduce = ____tonumber_20(____opt_18 and ____opt_18(____this_19, PA_003_MARK_MAX_STACK_REDUCE_KEY) or 0) or 0
	local maxStack = math.max(1, baseStack - reduce)
	local willTriggerOnNextHit = self:GetStackCount() >= maxStack - 1 and 1 or 0
	ParticleManager:SetParticleControl(self.overheadParticleId, 0, origin)
	ParticleManager:SetParticleControl(
		self.overheadParticleId,
		1,
		Vector(willTriggerOnNextHit, self:GetStackCount(), 0)
	)
end
modifier_pa_003_mark_debuff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_003_mark_debuff)
____exports.modifier_pa_003_mark_debuff = modifier_pa_003_mark_debuff
return ____exports