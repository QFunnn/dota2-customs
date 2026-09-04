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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
function ____exports.refreshM013ContractStack(self, modifier, stackCount)
	modifier:SetStackCount(math.max(1, math.floor(stackCount)))
	modifier:SetDuration(-1, false)
	modifier:RefreshAttributes()
end
function ____exports.getM013ContractPowerAllStatsPct(self, stackCount)
	if stackCount == 1 then
		return 30
	end
	if stackCount == 2 then
		return 80
	end
	return 0
end
____exports.M013_CONTRACT_POWER_DEBT_ALL_STATS_PCT_PER_STACK = -1
____exports.M013_CONTRACT_LIFE_MIN_HEALTH_PCT = 1
____exports.M013_CONTRACT_LIFE_RECOVERY_DURATION = 2
local M013_CONTRACT_LIFE_RECOVERY_INTERVAL = 0.05
local M013_CONTRACT_LIFE_POST_REVIVE_PROTECTION_DURATION = 2
local M013_CONTRACT_LIFE_POST_REVIVE_DAMAGE_REDUCTION_PCT = 80
local M013_POWER_DEBT_STACK_COOLDOWN = 0.5
local M013_POWER_DEBT_MAX_ADD_STACKS = 5
local M013_CONTRACT_LIFE_REVIVE_PARTICLE = "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf"
local M013_CONTRACT_LIFE_REVIVE_SOUND = "Hero_SkeletonKing.Reincarnate"
local function readStackCount(self, params, fallback)
	if fallback == nil then
		fallback = 1
	end
	return math.max(1, math.floor(tonumber(params and params.stack_count) or fallback or 1))
end
local function readReviveStackCount(self, params, fallback)
	if fallback == nil then
		fallback = 0
	end
	return math.max(0, math.floor(tonumber(params and params.stack_count) or fallback or 0))
end
local function refreshExactStack(self, modifier, params)
	____exports.refreshM013ContractStack(nil, modifier, readStackCount(nil, params, modifier:GetStackCount()))
end
function ____exports.getM013ContractGoldDropMaxBonusPct(self, stackCount)
	if stackCount == 1 then
		return 50
	end
	if stackCount == 2 then
		return 120
	end
	return 0
end
local function PlayM013ContractLifeReviveEffect(self, parent)
	local particle = ParticleManager:CreateParticle(M013_CONTRACT_LIFE_REVIVE_PARTICLE, PATTACH_CENTER_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(particle, 1, Vector(____exports.M013_CONTRACT_LIFE_RECOVERY_DURATION, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn(M013_CONTRACT_LIFE_REVIVE_SOUND, parent)
end
____exports.modifier_m013_contract_gold = __TS__Class()
local modifier_m013_contract_gold = ____exports.modifier_m013_contract_gold
modifier_m013_contract_gold.name = "modifier_m013_contract_gold"
__TS__ClassExtends(modifier_m013_contract_gold, BaseModifier_CS)
function modifier_m013_contract_gold.GetLocalizationCN(self)
	return {
		name = "渴求之器具",
		description = "<h1>收益</h1>掉落数量大幅提高。<br><br><h1>代价</h1>达到 1 层：破坏宝箱可能被守卫者追击。",
	}
end
function modifier_m013_contract_gold.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	refreshExactStack(nil, self, params)
end
function modifier_m013_contract_gold.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	refreshExactStack(nil, self, params)
end
function modifier_m013_contract_gold.prototype.RemoveOnDeath(self)
	return false
end
function modifier_m013_contract_gold.prototype.IsPurgable(self)
	return false
end
function modifier_m013_contract_gold.prototype.GetTexture(self)
	return "rune_bounty"
end
modifier_m013_contract_gold = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_gold)
____exports.modifier_m013_contract_gold = modifier_m013_contract_gold
____exports.modifier_m013_contract_gold_2 = __TS__Class()
local modifier_m013_contract_gold_2 = ____exports.modifier_m013_contract_gold_2
modifier_m013_contract_gold_2.name = "modifier_m013_contract_gold_2"
__TS__ClassExtends(modifier_m013_contract_gold_2, ____exports.modifier_m013_contract_gold)
function modifier_m013_contract_gold_2.GetLocalizationCN(self)
	return {
		name = "渴求之器具",
		description = "<h1>收益</h1>掉落数量巨幅提高。<br><br><h1>代价</h1>达到 1 层：破坏宝箱可能被守卫者追击。<br>达到 2 层：击杀精英怪物可能被守卫者追击。",
	}
end
modifier_m013_contract_gold_2 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_gold_2)
____exports.modifier_m013_contract_gold_2 = modifier_m013_contract_gold_2
____exports.modifier_m013_contract_life = __TS__Class()
local modifier_m013_contract_life = ____exports.modifier_m013_contract_life
modifier_m013_contract_life.name = "modifier_m013_contract_life"
__TS__ClassExtends(modifier_m013_contract_life, BaseModifier_CS)
function modifier_m013_contract_life.GetLocalizationCN(self)
	return {
		name = "生命之织缕",
		description = "<h1>收益</h1>每层契约增加 1 次抵挡致死伤害并恢复至满生命的机会。<br><br><h1>代价</h1>达到 1 层：精英怪获得 1 次复苏。",
	}
end
function modifier_m013_contract_life.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	refreshExactStack(nil, self, params)
end
function modifier_m013_contract_life.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	refreshExactStack(nil, self, params)
end
function modifier_m013_contract_life.prototype.RemoveOnDeath(self)
	return false
end
function modifier_m013_contract_life.prototype.IsPurgable(self)
	return false
end
function modifier_m013_contract_life.prototype.GetTexture(self)
	return "abaddon_borrowed_time"
end
modifier_m013_contract_life = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_life)
____exports.modifier_m013_contract_life = modifier_m013_contract_life
____exports.modifier_m013_contract_life_boss_phase = __TS__Class()
local modifier_m013_contract_life_boss_phase = ____exports.modifier_m013_contract_life_boss_phase
modifier_m013_contract_life_boss_phase.name = "modifier_m013_contract_life_boss_phase"
__TS__ClassExtends(modifier_m013_contract_life_boss_phase, ____exports.modifier_m013_contract_life)
function modifier_m013_contract_life_boss_phase.GetLocalizationCN(self)
	return { name = "生命之织缕", description = "死亡后进入第 2 阶段。" }
end
modifier_m013_contract_life_boss_phase =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_life_boss_phase)
____exports.modifier_m013_contract_life_boss_phase = modifier_m013_contract_life_boss_phase
____exports.modifier_m013_contract_life_2 = __TS__Class()
local modifier_m013_contract_life_2 = ____exports.modifier_m013_contract_life_2
modifier_m013_contract_life_2.name = "modifier_m013_contract_life_2"
__TS__ClassExtends(modifier_m013_contract_life_2, ____exports.modifier_m013_contract_life)
function modifier_m013_contract_life_2.GetLocalizationCN(self)
	return {
		name = "生命之织缕",
		description = "<h1>收益</h1>每层契约增加 1 次抵挡致死伤害并恢复至满生命的机会。<br><br><h1>代价</h1>达到 1 层：精英怪获得 1 次复苏。<br>达到 2 层：头目/Boss获得 1 次复苏。",
	}
end
modifier_m013_contract_life_2 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_life_2)
____exports.modifier_m013_contract_life_2 = modifier_m013_contract_life_2
____exports.modifier_m013_contract_life_revive = __TS__Class()
local modifier_m013_contract_life_revive = ____exports.modifier_m013_contract_life_revive
modifier_m013_contract_life_revive.name = "modifier_m013_contract_life_revive"
__TS__ClassExtends(modifier_m013_contract_life_revive, BaseModifier_CS)
function modifier_m013_contract_life_revive.GetLocalizationCN(self)
	return {
		name = "织缕复苏",
		description = "当前剩余 %dMODIFIER_PROPERTY_TOOLTIP% 次复苏机会；触发时播放死亡动作，并在 2 秒无敌状态内逐步恢复至满生命。",
	}
end
function modifier_m013_contract_life_revive.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function modifier_m013_contract_life_revive.prototype.OnTooltip(self)
	return self:GetStackCount()
end
function modifier_m013_contract_life_revive.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetStackCount(readReviveStackCount(nil, params))
	self:SetDuration(-1, false)
	self:RefreshAttributes()
end
function modifier_m013_contract_life_revive.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:SetStackCount(readReviveStackCount(nil, params, self:GetStackCount()))
	self:SetDuration(-1, false)
	self:RefreshAttributes()
end
function modifier_m013_contract_life_revive.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_MIN_HEALTH_TRIGGER }
end
function modifier_m013_contract_life_revive.prototype.GetAttributeBonus(self)
	if self:GetStackCount() <= 0 then
		return {}
	end
	local parent = self:GetParent()
	return {
		min_health = math.max(1, parent:GetMaxHealth() * ____exports.M013_CONTRACT_LIFE_MIN_HEALTH_PCT / 100),
	}
end
function modifier_m013_contract_life_revive.prototype.OnMinHealthTrigger_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.victim ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if self:GetStackCount() <= 0 then
		return
	end
	local nextStacks = self:GetStackCount() - 1
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
	____exports.modifier_m013_contract_life_recovering:applys(
		parent,
		parent,
		nil,
		{ duration = ____exports.M013_CONTRACT_LIFE_RECOVERY_DURATION }
	)
	PlayM013ContractLifeReviveEffect(nil, parent)
	if nextStacks <= 0 then
		self:Destroy()
	end
end
function modifier_m013_contract_life_revive.prototype.RemoveOnDeath(self)
	return false
end
function modifier_m013_contract_life_revive.prototype.IsPurgable(self)
	return false
end
function modifier_m013_contract_life_revive.prototype.GetTexture(self)
	return "abaddon_borrowed_time"
end
modifier_m013_contract_life_revive = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_life_revive)
____exports.modifier_m013_contract_life_revive = modifier_m013_contract_life_revive
____exports.modifier_m013_contract_life_recovering = __TS__Class()
local modifier_m013_contract_life_recovering = ____exports.modifier_m013_contract_life_recovering
modifier_m013_contract_life_recovering.name = "modifier_m013_contract_life_recovering"
__TS__ClassExtends(modifier_m013_contract_life_recovering, BaseModifier_CS)
function modifier_m013_contract_life_recovering.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.recoveryStartTime = 0
	self.recoveryStartHealth = 1
end
function modifier_m013_contract_life_recovering.GetLocalizationCN(self)
	return { name = "契约复苏", description = "死亡的脚步，被一只看不见的手按住。" }
end
function modifier_m013_contract_life_recovering.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self.recoveryStartTime = GameRules:GetGameTime()
	self.recoveryStartHealth = math.max(1, parent:GetHealth())
	parent:StartGestureWithPlaybackRate(ACT_DOTA_DIE, 1)
	self:StartIntervalThink(M013_CONTRACT_LIFE_RECOVERY_INTERVAL)
end
function modifier_m013_contract_life_recovering.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local elapsed = GameRules:GetGameTime() - self.recoveryStartTime
	local progress = math.min(1, math.max(0, elapsed / ____exports.M013_CONTRACT_LIFE_RECOVERY_DURATION))
	local maxHealth = parent:GetMaxHealth()
	local targetHealth = self.recoveryStartHealth + (maxHealth - self.recoveryStartHealth) * progress
	parent:SetHealth(math.max(1, math.min(maxHealth, targetHealth)))
end
function modifier_m013_contract_life_recovering.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetHealth(parent:GetMaxHealth())
	parent:FadeGesture(ACT_DOTA_DIE)
	parent:Stop()
	parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 1)
	____exports.modifier_m013_contract_life_post_revive_protection:applys(
		parent,
		parent,
		nil,
		{ duration = M013_CONTRACT_LIFE_POST_REVIVE_PROTECTION_DURATION }
	)
end
function modifier_m013_contract_life_recovering.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end
function modifier_m013_contract_life_recovering.prototype.RemoveOnDeath(self)
	return false
end
function modifier_m013_contract_life_recovering.prototype.IsPurgable(self)
	return false
end
function modifier_m013_contract_life_recovering.prototype.GetTexture(self)
	return "abaddon_borrowed_time"
end
modifier_m013_contract_life_recovering =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_life_recovering)
____exports.modifier_m013_contract_life_recovering = modifier_m013_contract_life_recovering
____exports.modifier_m013_contract_life_post_revive_protection = __TS__Class()
local modifier_m013_contract_life_post_revive_protection =
	____exports.modifier_m013_contract_life_post_revive_protection
modifier_m013_contract_life_post_revive_protection.name = "modifier_m013_contract_life_post_revive_protection"
__TS__ClassExtends(modifier_m013_contract_life_post_revive_protection, BaseModifier_CS)
function modifier_m013_contract_life_post_revive_protection.GetLocalizationCN(self)
	return { name = "复苏庇护", description = "受到的伤害降低 80%%。" }
end
function modifier_m013_contract_life_post_revive_protection.prototype.GetAttributeBonus(self)
	return { incoming_damage_decrease_pct = M013_CONTRACT_LIFE_POST_REVIVE_DAMAGE_REDUCTION_PCT }
end
function modifier_m013_contract_life_post_revive_protection.prototype.IsPurgable(self)
	return false
end
function modifier_m013_contract_life_post_revive_protection.prototype.GetTexture(self)
	return "abaddon_borrowed_time"
end
modifier_m013_contract_life_post_revive_protection =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_life_post_revive_protection)
____exports.modifier_m013_contract_life_post_revive_protection = modifier_m013_contract_life_post_revive_protection
____exports.modifier_m013_contract_power = __TS__Class()
local modifier_m013_contract_power = ____exports.modifier_m013_contract_power
modifier_m013_contract_power.name = "modifier_m013_contract_power"
__TS__ClassExtends(modifier_m013_contract_power, BaseModifier_CS)
function modifier_m013_contract_power.GetLocalizationCN(self)
	return {
		name = "世界之喰煞",
		description = "<h1>收益</h1>全属性提高 %dMODIFIER_PROPERTY_TOOLTIP%%%。<br><br><h1>代价</h1>达到 1 层：每 8 秒随机落下一颗小陨石，对范围内玩家与怪物造成伤害；被精英怪技能命中增加 5 层反噬。<br>每层反噬使全属性与基础生命上限降低 1%%。",
	}
end
function modifier_m013_contract_power.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function modifier_m013_contract_power.prototype.OnTooltip(self)
	return ____exports.getM013ContractPowerAllStatsPct(nil, self:GetStackCount())
end
function modifier_m013_contract_power.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	refreshExactStack(nil, self, params)
end
function modifier_m013_contract_power.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	refreshExactStack(nil, self, params)
end
function modifier_m013_contract_power.prototype.GetAttributeBonus(self)
	local bonus = ____exports.getM013ContractPowerAllStatsPct(nil, self:GetStackCount())
	return { base_all_stats_pct = bonus }
end
function modifier_m013_contract_power.prototype.RemoveOnDeath(self)
	return false
end
function modifier_m013_contract_power.prototype.IsPurgable(self)
	return false
end
function modifier_m013_contract_power.prototype.GetTexture(self)
	return "rune_doubledamage"
end
modifier_m013_contract_power = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_power)
____exports.modifier_m013_contract_power = modifier_m013_contract_power
____exports.modifier_m013_contract_power_2 = __TS__Class()
local modifier_m013_contract_power_2 = ____exports.modifier_m013_contract_power_2
modifier_m013_contract_power_2.name = "modifier_m013_contract_power_2"
__TS__ClassExtends(modifier_m013_contract_power_2, ____exports.modifier_m013_contract_power)
function modifier_m013_contract_power_2.GetLocalizationCN(self)
	return {
		name = "世界之喰煞",
		description = "<h1>收益</h1>全属性提高 %dMODIFIER_PROPERTY_TOOLTIP%%%。<br><br><h1>代价</h1>达到 1 层：每 8 秒随机落下一颗小陨石，对范围内玩家与怪物造成伤害；被精英怪技能命中增加 5 层反噬。<br>达到 2 层：大陨石替换小陨石，伤害范围更大，并留下无法移动和攻击、死亡时自爆的陨石怪；头目与小头目技能也会增加 5 层反噬。<br>每层反噬使全属性与基础生命上限降低 1%%。",
	}
end
modifier_m013_contract_power_2 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_power_2)
____exports.modifier_m013_contract_power_2 = modifier_m013_contract_power_2
____exports.modifier_m013_contract_power_debt = __TS__Class()
local modifier_m013_contract_power_debt = ____exports.modifier_m013_contract_power_debt
modifier_m013_contract_power_debt.name = "modifier_m013_contract_power_debt"
__TS__ClassExtends(modifier_m013_contract_power_debt, BaseModifier_CS)
function modifier_m013_contract_power_debt.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.nextStackApplyTime = 0
end
function modifier_m013_contract_power_debt.GetLocalizationCN(self)
	return {
		name = "契约反噬",
		description = "全属性与基础生命上限降低 %dMODIFIER_PROPERTY_TOOLTIP%%%。",
	}
end
function modifier_m013_contract_power_debt.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function modifier_m013_contract_power_debt.prototype.OnTooltip(self)
	return math.abs(____exports.M013_CONTRACT_POWER_DEBT_ALL_STATS_PCT_PER_STACK * self:GetStackCount())
end
function modifier_m013_contract_power_debt.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.nextStackApplyTime = GameRules:GetGameTime() + M013_POWER_DEBT_STACK_COOLDOWN
	self:SetStackCount(readStackCount(nil, params))
	self:RefreshAttributes()
end
function modifier_m013_contract_power_debt.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local now = GameRules:GetGameTime()
	if self.nextStackApplyTime > now then
		return
	end
	self.nextStackApplyTime = now + M013_POWER_DEBT_STACK_COOLDOWN
	local exactStackCount = math.floor(tonumber(params and params.exact_stack_count) or 0)
	if exactStackCount > 0 then
		self:SetStackCount(exactStackCount)
	else
		local addStacks = math.min(readStackCount(nil, params), M013_POWER_DEBT_MAX_ADD_STACKS)
		self:SetStackCount(self:GetStackCount() + addStacks)
	end
	self:RefreshAttributes()
end
function modifier_m013_contract_power_debt.prototype.GetAttributeBonus(self)
	local penalty = ____exports.M013_CONTRACT_POWER_DEBT_ALL_STATS_PCT_PER_STACK * self:GetStackCount()
	return {
		all_strength_pct = penalty,
		all_agility_pct = penalty,
		all_intelligence_pct = penalty,
		base_health_pct = penalty,
	}
end
function modifier_m013_contract_power_debt.prototype.IsDebuff(self)
	return true
end
function modifier_m013_contract_power_debt.prototype.IsPurgable(self)
	return false
end
function modifier_m013_contract_power_debt.prototype.GetTexture(self)
	return "doom_bringer_doom"
end
modifier_m013_contract_power_debt = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_m013_contract_power_debt)
____exports.modifier_m013_contract_power_debt = modifier_m013_contract_power_debt
return ____exports