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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local ConsumeIceStacks = ____item_0409_shared.ConsumeIceStacks
local IsRealNonItemAbility = ____item_0409_shared.IsRealNonItemAbility
local ReduceCooldown = ____item_0409_shared.ReduceCooldown
local TRIGGER_PARTICLE = "particles/boss/sky/skywrath_arcana_kill_targetc.vpcf"
local FULL_REFUND_HOOK_CHANCE_PCT = 100
local SELF_ICE_STACK = 1
local SELF_ICE_DURATION = 9999
local SELF_ICE_CHECK_INTERVAL = 1
--- 技能是否属于充能技能：自定义充能（本项目全部充能技能走这套）优先，引擎原生充能保留兼容。
function ____exports.IsChargeAbilityForRefund(self, ability)
	if MyGameAbilityChargeManager and MyGameAbilityChargeManager:IsCustomChargeAbility(ability) then
		return true
	end
	local level = math.max(0, ability:GetLevel() - 1)
	return math.max(0, math.floor(ability:GetMaxAbilityCharges(level) or 0)) > 0
end
--- 为充能技能返还 1 格（封顶上限），返回是否成功。
-- 自定义充能：临时把官方免消耗钩子置 100 → 调管理器公开入口 TryRefundChargeOnCast 必定 +1 → 立即还原钩子。
--  管理器内部补偿进度在 100% 时按「累计值-100」回写，钩子前后进度不变，无残留副作用。
-- 引擎原生充能：直接 SetCurrentAbilityCharges。
function ____exports.RestoreOneAbilityCharge(self, parent, ability)
	local manager = MyGameAbilityChargeManager
	if manager and manager:IsCustomChargeAbility(ability) then
		local hookKey = ability:GetAbilityName() .. "_charge_no_consume_chance_pct"
		local prevHookValue = tonumber(parent:GetCustomValue(hookKey) or 0) or 0
		parent:SetCustomValue(hookKey, FULL_REFUND_HOOK_CHANCE_PCT)
		local refunded = manager:TryRefundChargeOnCast(ability)
		parent:SetCustomValue(hookKey, prevHookValue)
		if refunded then
			ability:EndCooldown()
			ability:StartCooldown(manager:GetReleaseInterval())
		end
		return refunded
	end
	local level = math.max(0, ability:GetLevel() - 1)
	local maxCharges = math.max(0, math.floor(ability:GetMaxAbilityCharges(level) or 0))
	if maxCharges <= 0 then
		return false
	end
	local currentCharges = math.max(0, math.floor(ability:GetCurrentAbilityCharges() or 0))
	ability:SetCurrentAbilityCharges(math.min(maxCharges, currentCharges + 1))
	return true
end
____exports.item_0564 = __TS__Class()
local item_0564 = ____exports.item_0564
item_0564.name = "item_0564"
__TS__ClassExtends(item_0564, BaseItem_CS)
function item_0564.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0564.name
end
item_0564 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0564)
____exports.item_0564 = item_0564
____exports.modifier_item_0564 = __TS__Class()
local modifier_item_0564 = ____exports.modifier_item_0564
modifier_item_0564.name = "modifier_item_0564"
__TS__ClassExtends(modifier_item_0564, BaseModifier_CS)
function modifier_item_0564.GetLocalizationCN(self)
	return {
		name = "灵能永续",
		description = "使自己处于冰冻状态；攻击命中时有概率使自身所有主动技能减少冷却。",
	}
end
function modifier_item_0564.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0564.prototype.IsHidden(self)
	return true
end
function modifier_item_0564.prototype.IsPurgable(self)
	return false
end
function modifier_item_0564.prototype.GetMutexKey(self)
	return "ling_neng_mutex"
end
function modifier_item_0564.prototype.GetMutexPriority(self)
	local ____opt_4 = self:GetAbility()
	return (____opt_4 and ____opt_4:GetAbilityName()) == "item_0564" and 200 or 100
end
function modifier_item_0564.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:EnsureSelfIce()
	self:StartIntervalThink(SELF_ICE_CHECK_INTERVAL)
end
function modifier_item_0564.prototype.OnIntervalThink(self)
	self:EnsureSelfIce()
end
function modifier_item_0564.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) then
		return
	end
	ConsumeIceStacks(nil, parent, SELF_ICE_STACK)
end
function modifier_item_0564.prototype.EnsureSelfIce(self)
	local parent = self:GetParent()
	if not parent or not IsValidAlive(nil, parent) then
		return
	end
	if parent:HasModifier("modifier_generic_slow") then
		return
	end
	AddDeBuffStatus(
		nil,
		parent,
		parent,
		self:GetAbility(),
		DebuffStatusType.ICE_SLOW,
		{ stack = SELF_ICE_STACK, duration = SELF_ICE_DURATION }
	)
end
function modifier_item_0564.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local ability = self:GetAbility()
	if not ability or not ability:IsCooldownReady() then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local rolledChance = ability:GetSpecialValueFor("ability_value_trigger_chance_pct")
	local ____math_min_7 = math.min
	local ____temp_6
	if rolledChance > 0 then
		____temp_6 = rolledChance
	else
		____temp_6 = ability:GetSpecialValueFor("ability_trigger_chance_pct")
	end
	local chancePct = ____math_min_7(100, ____temp_6)
	if not RollPercentage(chancePct) then
		return
	end
	local rolledCdr = ability:GetSpecialValueFor("ability_value_cdr_per_hit_sec")
	local ____math_max_9 = math.max
	local ____temp_8
	if rolledCdr > 0 then
		____temp_8 = rolledCdr
	else
		____temp_8 = ability:GetSpecialValueFor("ability_cdr_per_hit_sec")
	end
	local cdrSec = ____math_max_9(0, ____temp_8)
	if cdrSec <= 0 then
		return
	end
	local cooling = {}
	local count = parent:GetAbilityCount()
	do
		local i = 0
		while i < count do
			do
				local ab = parent:GetAbilityByIndex(i)
				if not IsRealNonItemAbility(nil, ab) then
					goto __continue32
				end
				if ____exports.IsChargeAbilityForRefund(nil, ab) then
					goto __continue32
				end
				if ab:GetCooldownTimeRemaining() <= 0 then
					goto __continue32
				end
				cooling[#cooling + 1] = ab
			end
			::__continue32::
			i = i + 1
		end
	end
	if #cooling == 0 then
		return
	end
	for ____, ab in ipairs(cooling) do
		ReduceCooldown(nil, ab, cdrSec)
	end
	local triggerCd = math.max(0, ability:GetCooldown(ability:GetLevel()))
	if triggerCd > 0 then
		ability:StartCooldown(triggerCd)
	end
	local fx = MyGameHeroParticleManager:CreateParticle(TRIGGER_PARTICLE, PATTACH_OVERHEAD_FOLLOW, parent, parent)
	MyGameHeroParticleManager:SetParticleControl(fx, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(fx)
end
modifier_item_0564 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0564)
____exports.modifier_item_0564 = modifier_item_0564
return ____exports