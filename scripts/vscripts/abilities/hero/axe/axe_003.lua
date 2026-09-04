--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local GetCustomNumber, IsCustomValueEnabled, ClampPercent, RestoreShieldOnHelix, SpendActiveHelixHealthCost, BuildCounterHelixDamage, PlayCounterHelixSelfEffects, DamageCounterHelixEnemies, TryScheduleCounterHelixMulticast, PerformCounterHelix, AXE_003_HELIX_DMG_BONUS_PCT_PER_ARMOR_KEY, AXE_003_ACTIVE_HELIX_HEALTH_COST_PCT_KEY, AXE_003_HELIX_MULTICAST_KEY, AXE_003_HELIX_MULTICAST_CHANCE_PCT_KEY, AXE_003_HELIX_RESTORE_SHIELD_PCT_KEY, AXE_003_HELIX_BURN_CHANCE_PCT_KEY, AXE_003_MULTICAST_FOLLOW_DELAY, AXE_003_HELIX_BURN_DURATION, AXE_003_ACTIVE_HEALTH_COST_PCT, AXE_003_COUNTER_HELIX_PARTICLE, AXE_003_HIT_PARTICLE
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____gem_multicast_feedback = require("modifiers.gem.gem_multicast_feedback")
local PlayGemMulticastFeedback = ____gem_multicast_feedback.PlayGemMulticastFeedback
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
function GetCustomNumber(self, unit, key, defaultValue, useDefaultWhenZero)
	if defaultValue == nil then
		defaultValue = 0
	end
	if useDefaultWhenZero == nil then
		useDefaultWhenZero = false
	end
	if not IsValidAlive(nil, unit) then
		return defaultValue
	end
	local ____this_1
	____this_1 = unit
	local ____opt_0 = ____this_1.GetCustomValue
	local raw = ____opt_0 and ____opt_0(____this_1, key) or defaultValue
	local value = tonumber(raw)
	if useDefaultWhenZero then
		return value or defaultValue
	end
	return value or defaultValue
end
function IsCustomValueEnabled(self, unit, key)
	return GetCustomNumber(nil, unit, key) > 0
end
function ClampPercent(self, value)
	return math.max(0, math.min(100, value))
end
function RestoreShieldOnHelix(self, parent, totalEnergyShield)
	if totalEnergyShield <= 0 then
		return
	end
	local restoreShieldPct = GetCustomNumber(nil, parent, AXE_003_HELIX_RESTORE_SHIELD_PCT_KEY)
	if restoreShieldPct <= 0 then
		return
	end
	local restoreShield = totalEnergyShield * (restoreShieldPct / 100)
	if restoreShield <= 0 then
		return
	end
	local ____this_3
	____this_3 = parent
	local ____opt_2 = ____this_3.AddCurrentEnergyShield
	if ____opt_2 ~= nil then
		____opt_2(____this_3, restoreShield)
	end
end
function SpendActiveHelixHealthCost(self, parent, ability)
	local maxHealthForCost = MyGameAttribute:GetAttribute(parent, "total_health") or parent:GetMaxHealth()
	local healthCostPct =
		GetCustomNumber(nil, parent, AXE_003_ACTIVE_HELIX_HEALTH_COST_PCT_KEY, AXE_003_ACTIVE_HEALTH_COST_PCT, true)
	local hpCost = math.floor(maxHealthForCost * math.max(0, healthCostPct) / 100)
	if hpCost <= 0 then
		return
	end
	parent:CostHeal(
		hpCost,
		{
			ability = ability,
			attacker = parent,
			reserve_min_health = 1,
			source = { custom_tag = "axe_003_active_helix_health_cost", source_name = "axe_003_active_helix" },
		}
	)
end
function BuildCounterHelixDamage(self, ctx, parent)
	local maxHealth = MyGameAttribute:GetAttribute(parent, "total_health") or parent:GetMaxHealth()
	local ____math_max_6 = math.max
	local ____this_5
	____this_5 = parent
	local ____opt_4 = ____this_5.GetTotalEnergyShield
	local totalEnergyShield = ____math_max_6(
		0,
		____opt_4 and ____opt_4(____this_5) or MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0
	)
	local maxHealthAndShield = maxHealth + totalEnergyShield
	local armor = MyGameAttribute:GetAttribute(parent, "total_armor") or 0
	local bonusPctPerArmor = GetCustomNumber(nil, parent, AXE_003_HELIX_DMG_BONUS_PCT_PER_ARMOR_KEY)
	local helixDamageMultiplier = math.max(0, 1 + armor * bonusPctPerArmor / 100)
	local finalDamage = maxHealthAndShield
		* (ctx:GetSpecialValue("axe_003", "max_health_damage_pct") / 100)
		* helixDamageMultiplier
	return { finalDamage = finalDamage, totalEnergyShield = totalEnergyShield }
end
function PlayCounterHelixSelfEffects(self, parent)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		AXE_003_COUNTER_HELIX_PARTICLE,
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn("Hero_Axe.CounterHelix", parent)
	parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1)
end
function DamageCounterHelixEnemies(self, ctx, parent, ability, radius, damage)
	local enemies = ctx:FindMonsterEnemies(parent:GetAbsOrigin(), radius)
	local burnChancePct = ClampPercent(nil, GetCustomNumber(nil, parent, AXE_003_HELIX_BURN_CHANCE_PCT_KEY))
	for ____, enemy in ipairs(enemies) do
		local pfx =
			MyGameHeroParticleManager:CreateParticle(AXE_003_HIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, enemy, parent)
		MyGameHeroParticleManager:SetParticleControl(pfx, 0, enemy:GetAbsOrigin())
		MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
		enemy:EmitSound("Hero_Axe.Attack")
		Damage:ApplyDamage({
			attacker = parent,
			victim = enemy,
			damage = damage,
			damage_type = 1,
			ability = ability,
		})
		if burnChancePct > 0 and RollPercentage(burnChancePct) then
			AddDeBuffStatus(
				nil,
				enemy,
				parent,
				ability,
				DebuffStatusType.BURN,
				{ duration = AXE_003_HELIX_BURN_DURATION }
			)
		end
	end
end
function TryScheduleCounterHelixMulticast(self, ctx, parent, ability, allowMulticastExtra, consumeHealthCost)
	if not allowMulticastExtra or not IsServer() then
		return
	end
	if not IsCustomValueEnabled(nil, parent, AXE_003_HELIX_MULTICAST_KEY) then
		return
	end
	local multicastChance = GetCustomNumber(nil, parent, AXE_003_HELIX_MULTICAST_CHANCE_PCT_KEY)
	if not __TS__NumberIsFinite(__TS__Number(multicastChance)) then
		return
	end
	local multicastChanceClamped = ClampPercent(nil, multicastChance)
	if multicastChanceClamped <= 0 then
		return
	end
	if not RollPercentage(multicastChanceClamped) then
		return
	end
	PlayGemMulticastFeedback(nil, parent, 2, 1)
	ctx:Timer(AXE_003_MULTICAST_FOLLOW_DELAY, function()
		if not IsValid(nil, ctx) or not IsValidAlive(nil, parent) then
			return
		end
		if not ability or not IsValid(nil, ability) or ability:IsNull() then
			return
		end
		PerformCounterHelix(nil, ctx, parent, ability, false, consumeHealthCost)
	end)
end
function PerformCounterHelix(self, ctx, parent, ability, allowMulticastExtra, consumeHealthCost)
	if consumeHealthCost then
		SpendActiveHelixHealthCost(nil, parent, ability)
	end
	local radius = ctx:GetSpecialValue("axe_003", "radius")
	local damageContext = BuildCounterHelixDamage(nil, ctx, parent)
	PlayCounterHelixSelfEffects(nil, parent)
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(parent, parent:GetAbsOrigin(), radius, ability)
	end
	DamageCounterHelixEnemies(nil, ctx, parent, ability, radius, damageContext.finalDamage)
	RestoreShieldOnHelix(nil, parent, damageContext.totalEnergyShield)
	TryScheduleCounterHelixMulticast(nil, ctx, parent, ability, allowMulticastExtra, consumeHealthCost)
end
--- 斧王技能 003 - 反击螺旋（被动）
-- 官方机制简化版：被攻击时有几率旋转，对周围敌人造成伤害，并有短内置冷却。
local AXE_003_COUNTER_HELIX_MODIFIER_NAME = "modifier_axe_003_counter_helix"
local AXE_003_ACTIVE_HELIX_MODIFIER_NAME = "modifier_axe_003_active_helix"
AXE_003_HELIX_DMG_BONUS_PCT_PER_ARMOR_KEY = "axe_003_helix_dmg_bonus_pct_per_armor"
local AXE_003_HELIX_CHANCE_BONUS_PCT_KEY = "axe_003_helix_chance_bonus_pct"
--- 符印：反击螺旋改为主动持续旋转（`ak_gems.csv` hero_data）
local AXE_003_ACTIVE_HELIX_KEY = "axe_003_active_helix"
AXE_003_ACTIVE_HELIX_HEALTH_COST_PCT_KEY = "axe_003_active_helix_health_cost_pct"
--- 符印：主动螺旋期间自身减速百分比
local AXE_003_ACTIVE_HELIX_SELF_SLOW_PCT_KEY = "axe_003_active_helix_self_slow_pct"
--- 符印：普攻命中时可与受击相同规则触发反击螺旋（`ak_gems.csv` hero_data）
local AXE_003_HELIX_ON_ATTACK_KEY = "axe_003_helix_on_attack"
--- 符印：普攻触发反击螺旋后，每层提供的攻速百分比
local AXE_003_HELIX_ATTACK_SPEED_PCT_PER_STACK_KEY = "axe_003_helix_attack_speed_pct_per_stack"
--- 符印：普攻触发反击螺旋后的攻速增益持续时间
local AXE_003_HELIX_ATTACK_SPEED_BUFF_DURATION_KEY = "axe_003_helix_attack_speed_buff_duration"
--- 符印：普攻触发反击螺旋后的攻速增益最大层数
local AXE_003_HELIX_ATTACK_SPEED_MAX_STACKS_KEY = "axe_003_helix_attack_speed_max_stacks"
AXE_003_HELIX_MULTICAST_KEY = "axe_003_helix_multicast"
AXE_003_HELIX_MULTICAST_CHANCE_PCT_KEY = "axe_003_helix_multicast_chance_pct"
AXE_003_HELIX_RESTORE_SHIELD_PCT_KEY = "axe_003_helix_restore_shield_pct"
AXE_003_HELIX_BURN_CHANCE_PCT_KEY = "axe_003_helix_burn_chance_pct"
AXE_003_MULTICAST_FOLLOW_DELAY = 0.3
AXE_003_HELIX_BURN_DURATION = 3
--- 被动内置冷却：对应 ak_abilities.csv 中 axe_003 的原始冷却时间。
local AXE_003_PASSIVE_INTERNAL_COOLDOWN = 0.25
local AXE_003_ACTIVE_DURATION = 5
local AXE_003_ACTIVE_INTERVAL = 0.3
local AXE_003_ACTIVE_COOLDOWN = 10
AXE_003_ACTIVE_HEALTH_COST_PCT = 5
local AXE_003_ACTIVE_SELF_SLOW_PCT = 50
AXE_003_COUNTER_HELIX_PARTICLE = "particles/axe/axe_counterhelix_2.vpcf"
AXE_003_HIT_PARTICLE = "particles/econ/items/juggernaut/pw_blossom_sword/juggernaut_omni_slash_tgt.vpcf"
local AXE_003_ACTIVE_HELIX_AURA_PARTICLE = "particles/bb/axe_abilityjg_juggernaut_blade_fury_abyssal.vpcf"
local AXE_003_ACTIVE_HELIX_SPIN_PARTICLE =
	"particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser.vpcf"
local function IsActiveHelixEnabled(self, caster)
	return IsCustomValueEnabled(nil, caster, AXE_003_ACTIVE_HELIX_KEY)
end
local function AddAttackSpeedStackOnAttackHelix(self, parent, ability)
	local attackSpeedPctPerStack = GetCustomNumber(nil, parent, AXE_003_HELIX_ATTACK_SPEED_PCT_PER_STACK_KEY)
	local duration = GetCustomNumber(nil, parent, AXE_003_HELIX_ATTACK_SPEED_BUFF_DURATION_KEY)
	local maxStacks = math.floor(GetCustomNumber(nil, parent, AXE_003_HELIX_ATTACK_SPEED_MAX_STACKS_KEY))
	if attackSpeedPctPerStack <= 0 or duration <= 0 or maxStacks <= 0 then
		return
	end
	____exports.modifier_axe_003_helix_attack_speed:applys(
		parent,
		parent,
		ability,
		{ duration = duration, attack_speed_pct_per_stack = attackSpeedPctPerStack, max_stacks = maxStacks }
	)
end
____exports.axe_003 = __TS__Class()
local axe_003 = ____exports.axe_003
axe_003.name = "axe_003"
__TS__ClassExtends(axe_003, BaseHeroAbility)
function axe_003.prototype.GetAbilityConfig(self)
	local caster = self:GetCaster()
	if caster and not caster:IsNull() and IsActiveHelixEnabled(nil, caster) then
		return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
	end
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function axe_003.prototype.GetIntrinsicModifierName(self)
	return AXE_003_COUNTER_HELIX_MODIFIER_NAME
end
function axe_003.prototype.GetActiveHelixCooldown(self)
	return self:ResolveTagNumber(AXE_003_ACTIVE_COOLDOWN, 7)
end
function axe_003.prototype.GetPassiveInternalCooldown(self)
	return self:ResolveTagNumber(AXE_003_PASSIVE_INTERNAL_COOLDOWN, 7)
end
function axe_003.prototype.GetCooldown(self, level)
	local caster = self:GetCaster()
	if caster and not caster:IsNull() and IsActiveHelixEnabled(nil, caster) then
		if IsServer() then
			return 0
		end
		return self:GetActiveHelixCooldown()
	end
	return BaseHeroAbility.prototype.GetCooldown(self, level)
end
function axe_003.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster or not IsValidAlive(nil, caster) then
		return
	end
	if not IsActiveHelixEnabled(nil, caster) then
		return
	end
	local activeModifier = caster:FindModifierByName(AXE_003_ACTIVE_HELIX_MODIFIER_NAME)
	if (not activeModifier or not IsValid(nil, activeModifier)) and not self:IsCooldownReady() then
		return
	end
	if activeModifier and IsValid(nil, activeModifier) then
		activeModifier:Destroy()
		if self:IsCooldownReady() then
			self:StartCooldown(self:GetActiveHelixCooldown())
		end
		return
	end
	____exports.modifier_axe_003_active_helix:applys(caster, caster, self, { duration = AXE_003_ACTIVE_DURATION })
end
axe_003 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_003)
____exports.axe_003 = axe_003
____exports.modifier_axe_003_counter_helix = __TS__Class()
local modifier_axe_003_counter_helix = ____exports.modifier_axe_003_counter_helix
modifier_axe_003_counter_helix.name = "modifier_axe_003_counter_helix"
__TS__ClassExtends(modifier_axe_003_counter_helix, BaseHeroModifier)
function modifier_axe_003_counter_helix.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.passiveCooldownReadyTime = 0
end
function modifier_axe_003_counter_helix.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_003_counter_helix.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_axe_003_counter_helix.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if event.target ~= parent then
		return
	end
	self:TryTriggerCounterHelix(parent, ability, false, event.attacker)
end
function modifier_axe_003_counter_helix.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if event.attacker ~= parent then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	self:TryTriggerCounterHelix(parent, ability, true)
end
function modifier_axe_003_counter_helix.prototype.TryTriggerCounterHelix(self, parent, ability, fromAttack, attacker)
	if fromAttack and not IsCustomValueEnabled(nil, parent, AXE_003_HELIX_ON_ATTACK_KEY) then
		return
	end
	if not self:IsPassiveCooldownReady() then
		return
	end
	local bonusChancePct = GetCustomNumber(nil, parent, AXE_003_HELIX_CHANCE_BONUS_PCT_KEY)
	local baseChancePct = self:GetSpecialValue("axe_003", "trigger_chance_pct")
	local chancePct = baseChancePct + bonusChancePct
	if not fromAttack and attacker and IsValid(nil, attacker) and not attacker:IsNull() then
		local ____this_10
		____this_10 = attacker
		local ____opt_9 = ____this_10.IsBoss
		local ____temp_13 = (____opt_9 and ____opt_9(____this_10)) == true
		if not ____temp_13 then
			local ____this_12
			____this_12 = attacker
			local ____opt_11 = ____this_12.IsMiniboss
			____temp_13 = (____opt_11 and ____opt_11(____this_12)) == true
		end
		if ____temp_13 then
			chancePct = chancePct * 2
		end
	end
	chancePct = ClampPercent(nil, chancePct)
	if not RollPseudoRandomPercentage(chancePct, DOTA_PSEUDO_RANDOM_AXE_HELIX, self._parent) then
		return
	end
	self:StartPassiveInternalCooldown(ability)
	if fromAttack then
		AddAttackSpeedStackOnAttackHelix(nil, parent, ability)
	end
	self:PerformCounterHelix(parent, ability, true)
end
function modifier_axe_003_counter_helix.prototype.PerformCounterHelix(self, parent, ability, allowMulticastExtra)
	PerformCounterHelix(nil, self, parent, ability, allowMulticastExtra, false)
end
function modifier_axe_003_counter_helix.prototype.IsPassiveCooldownReady(self)
	return GameRules:GetGameTime() >= self.passiveCooldownReadyTime
end
function modifier_axe_003_counter_helix.prototype.StartPassiveInternalCooldown(self, ability)
	self.passiveCooldownReadyTime = GameRules:GetGameTime() + math.max(0, ability:GetPassiveInternalCooldown())
end
modifier_axe_003_counter_helix = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_003_counter_helix)
____exports.modifier_axe_003_counter_helix = modifier_axe_003_counter_helix
____exports.modifier_axe_003_helix_attack_speed = __TS__Class()
local modifier_axe_003_helix_attack_speed = ____exports.modifier_axe_003_helix_attack_speed
modifier_axe_003_helix_attack_speed.name = "modifier_axe_003_helix_attack_speed"
__TS__ClassExtends(modifier_axe_003_helix_attack_speed, BaseHeroModifier)
function modifier_axe_003_helix_attack_speed.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.attackSpeedPctPerStack = 0
	self.maxStacks = 1
end
function modifier_axe_003_helix_attack_speed.GetLocalizationCN(self)
	return { name = "旋舞", description = "反击螺旋由攻击触发后获得攻速提升，可叠加。" }
end
function modifier_axe_003_helix_attack_speed.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_003_helix_attack_speed.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:RefreshConfig(params)
	self:SetStackCount(1)
	self:RefreshAttributes()
end
function modifier_axe_003_helix_attack_speed.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:RefreshConfig(params)
	self:SetStackCount(math.min(self.maxStacks, self:GetStackCount() + 1))
	self:SetDuration(params.duration, true)
	self:RefreshAttributes()
end
function modifier_axe_003_helix_attack_speed.prototype.GetAttributeBonus(self)
	return { attack_speed_pct = self.attackSpeedPctPerStack * self:GetStackCount() }
end
function modifier_axe_003_helix_attack_speed.prototype.RefreshConfig(self, params)
	self.attackSpeedPctPerStack = math.max(0, params.attack_speed_pct_per_stack)
	self.maxStacks = math.max(1, math.floor(params.max_stacks))
end
modifier_axe_003_helix_attack_speed =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_003_helix_attack_speed)
____exports.modifier_axe_003_helix_attack_speed = modifier_axe_003_helix_attack_speed
____exports.modifier_axe_003_active_helix = __TS__Class()
local modifier_axe_003_active_helix = ____exports.modifier_axe_003_active_helix
modifier_axe_003_active_helix.name = "modifier_axe_003_active_helix"
__TS__ClassExtends(modifier_axe_003_active_helix, BaseHeroModifier)
function modifier_axe_003_active_helix.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_003_active_helix.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValidAlive(nil, parent) then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	local pfx = ParticleManager:CreateParticle(AXE_003_ACTIVE_HELIX_AURA_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 5, Vector(ability:GetSpecialValue("axe_003", "radius"), 1, 1))
	self:AddParticle(pfx, false, false, -1, false, false)
	self:TickOnce(parent, ability)
	self:StartIntervalThink(AXE_003_ACTIVE_INTERVAL)
end
function modifier_axe_003_active_helix.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	if ability:IsCooldownReady() then
		ability:StartCooldown(ability:GetActiveHelixCooldown())
	end
end
function modifier_axe_003_active_helix.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValidAlive(nil, parent) then
		return
	end
	if not IsActiveHelixEnabled(nil, parent) then
		self:Destroy()
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	self:TickOnce(parent, ability)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		AXE_003_ACTIVE_HELIX_SPIN_PARTICLE,
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControlTransform(
		pfx,
		0,
		parent:GetAbsOrigin(),
		QAngle(0, math.random(0, 360), 0)
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_axe_003_active_helix.prototype.TickOnce(self, parent, ability)
	PerformCounterHelix(nil, self, parent, ability, true, true)
end
function modifier_axe_003_active_helix.prototype.GetAttributeBonus(self)
	local slowPct = GetCustomNumber(
		nil,
		self:GetParent(),
		AXE_003_ACTIVE_HELIX_SELF_SLOW_PCT_KEY,
		AXE_003_ACTIVE_SELF_SLOW_PCT,
		true
	)
	return { bonus_movespeed_pct = -math.max(0, slowPct) }
end
function modifier_axe_003_active_helix.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
modifier_axe_003_active_helix = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_003_active_helix)
____exports.modifier_axe_003_active_helix = modifier_axe_003_active_helix
return ____exports