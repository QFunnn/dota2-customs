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
local DEFER_CUSTOM_TAG = "item_0569_defer"
local DRAIN_TICK_INTERVAL = 0.5
____exports.item_0569 = __TS__Class()
local item_0569 = ____exports.item_0569
item_0569.name = "item_0569"
__TS__ClassExtends(item_0569, BaseItem_CS)
function item_0569.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0569_recover.name
end
item_0569 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0569)
____exports.item_0569 = item_0569
--- 固有监听：受到伤害时打折 defer%，被打折部分记入【血契】欠款池。
-- 双通道：普通管线伤害走 ON_DAMAGE_PRE_APPLY 事前打折；来自自身的 HP_LOSS 类自损
-- （生命消耗/损失生命等，不进 PRE_APPLY 管线）走 ON_HP_LOSS 事后回填——已扣除的
-- defer% 治疗回来并记入血契池，净效果等价延迟扣除。
____exports.modifier_item_0569 = __TS__Class()
local modifier_item_0569 = ____exports.modifier_item_0569
modifier_item_0569.name = "modifier_item_0569"
__TS__ClassExtends(modifier_item_0569, BaseModifier_CS)
function modifier_item_0569.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY, BusinessEvents.ON_HP_LOSS }
end
function modifier_item_0569.prototype.IsHidden(self)
	return true
end
function modifier_item_0569.prototype.IsPurgable(self)
	return false
end
function modifier_item_0569.prototype.GetMutexKey(self)
	return "item_0569_mutex"
end
function modifier_item_0569.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0394" and 200 or 100
end
function modifier_item_0569.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.victim ~= parent then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____opt_0 = event.ctx.spec.source
	if (____opt_0 and ____opt_0.custom_tag) == DEFER_CUSTOM_TAG then
		return
	end
	local deferPct = self:GetDeferPct(ability)
	if deferPct <= 0 then
		return
	end
	local currentDamage = self:GetCurrentPipeDamage(event.final)
	if currentDamage <= 0 then
		return
	end
	local deferred = currentDamage * (deferPct / 100)
	local ____event_final_2, ____mul_3 = event.final, "mul"
	if ____event_final_2[____mul_3] == nil then
		____event_final_2[____mul_3] = {}
	end
	local ____event_final_mul_4 = event.final.mul
	____event_final_mul_4[#____event_final_mul_4 + 1] =
		{ value = 1 - deferPct / 100, source = "item_0569:时滞血契分期" }
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0569_pact.name, { debt = deferred })
end
function modifier_item_0569.prototype.OnHpLoss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.victim ~= parent then
		return
	end
	if event.attacker ~= parent then
		return
	end
	local ____opt_5 = event.source
	if (____opt_5 and ____opt_5.custom_tag) == DEFER_CUSTOM_TAG then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local deferPct = self:GetDeferPct(ability)
	if deferPct <= 0 then
		return
	end
	local lostDamage = math.max(0, event.final_damage or 0)
	if lostDamage <= 0 then
		return
	end
	local deferred = lostDamage * (deferPct / 100)
	parent:CustomHeal(deferred, { ability = ability, source = "item" })
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0569_pact.name, { debt = deferred })
end
function modifier_item_0569.prototype.GetDeferPct(self, ability)
	local rolledDefer = ability:GetSpecialValueFor("ability_value_defer_pct")
	local ____math_min_9 = math.min
	local ____math_max_8 = math.max
	local ____temp_7
	if rolledDefer > 0 then
		____temp_7 = rolledDefer
	else
		____temp_7 = ability:GetSpecialValueFor("ability_defer_pct")
	end
	return ____math_min_9(100, ____math_max_8(0, ____temp_7))
end
function modifier_item_0569.prototype.GetCurrentPipeDamage(self, final)
	local damage = final.base
	if final.add then
		for ____, value in ipairs(final.add) do
			damage = damage + value.value
		end
	end
	if final.mul then
		for ____, value in ipairs(final.mul) do
			damage = damage * value.value
		end
	end
	return math.max(0, damage)
end
modifier_item_0569 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0569)
____exports.modifier_item_0569 = modifier_item_0569
--- 【血契】（挂自己）：欠款池在剩余时间内匀速流失（真实扣血·可被治疗抵消），新伤害并入并重置窗口。
____exports.modifier_item_0569_pact = __TS__Class()
local modifier_item_0569_pact = ____exports.modifier_item_0569_pact
modifier_item_0569_pact.name = "modifier_item_0569_pact"
__TS__ClassExtends(modifier_item_0569_pact, BaseModifier_CS)
function modifier_item_0569_pact.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.pool = 0
end
function modifier_item_0569_pact.GetLocalizationCN(self)
	return { name = "血契", description = "受到伤害中被延迟的部分，正在缓慢流失。" }
end
function modifier_item_0569_pact.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.pool = math.max(0, params.debt or 0)
	self:RefreshWindow()
	self:StartIntervalThink(DRAIN_TICK_INTERVAL)
end
function modifier_item_0569_pact.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.pool = self.pool + math.max(0, params.debt or 0)
	self:RefreshWindow()
end
function modifier_item_0569_pact.prototype.RefreshWindow(self)
	local ability = self:GetAbility()
	local ____ability_10
	if ability then
		____ability_10 = ability:GetSpecialValueFor("ability_value_defer_duration")
	else
		____ability_10 = 0
	end
	local rolledDur = ____ability_10
	local ____ability_13
	if ability then
		local ____math_max_12 = math.max
		local ____temp_11
		if rolledDur > 0 then
			____temp_11 = rolledDur
		else
			____temp_11 = ability:GetSpecialValueFor("ability_defer_duration")
		end
		____ability_13 = ____math_max_12(DRAIN_TICK_INTERVAL, ____temp_11)
	else
		____ability_13 = 5
	end
	local duration = ____ability_13
	self:SetDuration(duration, true)
	self:SetStackCount(math.max(1, math.ceil(self.pool)))
end
function modifier_item_0569_pact.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or self.pool <= 0 then
		self:Destroy()
		return
	end
	local remaining = math.max(DRAIN_TICK_INTERVAL, self:GetRemainingTime())
	local isLastTick = remaining <= DRAIN_TICK_INTERVAL
	local ____isLastTick_14
	if isLastTick then
		____isLastTick_14 = self.pool
	else
		____isLastTick_14 = self.pool * (DRAIN_TICK_INTERVAL / remaining)
	end
	local tickDamage = ____isLastTick_14
	self.pool = math.max(0, self.pool - tickDamage)
	self:SetStackCount(math.max(1, math.ceil(self.pool)))
	if tickDamage > 0 then
		Damage:ApplyDamage({
			attacker = parent,
			victim = parent,
			damage = tickDamage,
			damage_type = 4,
			damage_flag = ApplyDamageFlag.HP_LOSS,
			ability = self:GetAbility(),
			extra_data = {
				damage_tags = DamageTag.NO_PROC,
				custom_tag = DEFER_CUSTOM_TAG,
				source_name = self:GetName(),
			},
		})
	end
	if isLastTick or self.pool <= 0 then
		self:Destroy()
	end
end
function modifier_item_0569_pact.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0569_pact.prototype.IsHidden(self)
	return false
end
function modifier_item_0569_pact.prototype.IsDebuff(self)
	return true
end
function modifier_item_0569_pact.prototype.IsPurgable(self)
	return false
end
function modifier_item_0569_pact.prototype.GetTexture(self)
	return "item_eternal_shroud"
end
modifier_item_0569_pact = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0569_pact)
____exports.modifier_item_0569_pact = modifier_item_0569_pact
--- 固有监听：每次受到伤害，恢复自身最大生命的 recover%（传说随机键 / 史诗固定键·双读兼容）。item_0569 本体 + 史诗下级 item_0627 用。
____exports.modifier_item_0569_recover = __TS__Class()
local modifier_item_0569_recover = ____exports.modifier_item_0569_recover
modifier_item_0569_recover.name = "modifier_item_0569_recover"
__TS__ClassExtends(modifier_item_0569_recover, BaseModifier_CS)
function modifier_item_0569_recover.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0569_recover.prototype.IsHidden(self)
	return true
end
function modifier_item_0569_recover.prototype.IsPurgable(self)
	return false
end
function modifier_item_0569_recover.prototype.GetMutexKey(self)
	return "item_0569_recover_mutex"
end
function modifier_item_0569_recover.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0569" and 200 or 100
end
function modifier_item_0569_recover.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.victim ~= parent then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local rolled = ability:GetSpecialValueFor("ability_value_recover_max_health_pct")
	local ____math_max_16 = math.max
	local ____temp_15
	if rolled > 0 then
		____temp_15 = rolled
	else
		____temp_15 = ability:GetSpecialValueFor("ability_recover_max_health_pct")
	end
	local pct = ____math_max_16(0, ____temp_15)
	if pct <= 0 then
		return
	end
	local maxHealth = math.max(1, parent:GetMaxHealth())
	local missingPct = math.max(0, (1 - parent:GetHealth() / maxHealth) * 100)
	local amp = 1 + missingPct / 100
	local healAmount = maxHealth * (pct / 100) * amp
	if healAmount > 0 then
		parent:CustomHeal(healAmount, { ability = ability, source = "item" })
	end
	local ____math_max_19 = math.max
	local ____opt_17 = parent.GetTotalEnergyShield
	local maxShield = ____math_max_19(
		0,
		____opt_17 and ____opt_17(parent) or MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0
	)
	local shieldAmount = maxShield * (pct / 100) * amp
	if shieldAmount > 0 then
		parent:AddCurrentEnergyShield(shieldAmount)
	end
end
modifier_item_0569_recover = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0569_recover)
____exports.modifier_item_0569_recover = modifier_item_0569_recover
return ____exports