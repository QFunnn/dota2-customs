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
local BLEED_DURATION = 5
local BLEED_TICK_INTERVAL = 0.5
local BLEED_TOTAL_DAMAGE_PCT = 70
local function GetTotalBleedStacks(self, unit)
	if not IsValid(nil, unit) or not unit.FindAllModifiers then
		return 0
	end
	local total = 0
	local allModifiers = unit:FindAllModifiers()
	for ____, modifier in ipairs(allModifiers) do
		do
			if modifier:GetName() ~= "modifier_generic_bleed" then
				goto __continue4
			end
			total = total + modifier:GetStackCount()
		end
		::__continue4::
	end
	return total
end
____exports.modifier_generic_bleed = __TS__Class()
local modifier_generic_bleed = ____exports.modifier_generic_bleed
modifier_generic_bleed.name = "modifier_generic_bleed"
__TS__ClassExtends(modifier_generic_bleed, BaseModifier_CS)
function modifier_generic_bleed.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.remainingDamagePool = 0
	self.ticksLeft = 0
	self.thinkStarted = false
	self.currentTickInterval = BLEED_TICK_INTERVAL
end
function modifier_generic_bleed.GetLocalizationCN(self)
	return {
		name = "流血",
		description = "周期性受到伤害。伤害基于触发流血的最终伤害，重复施加会提高后续流血总伤害。",
	}
end
function modifier_generic_bleed.prototype.DestroyOnExpire(self)
	return false
end
function modifier_generic_bleed.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.effectName = params.effect_name
	self.statusEffectName = params.status_effect_name
	local duration = params.duration or BLEED_DURATION
	if (params.pool_damage or 0) > 0 then
		self:AddBleedPoolDamage(params.pool_damage or 0, duration)
	else
		self:AddExternalBleed(params.source_final_damage or 0, duration)
	end
	if self.effectName and self.effectName ~= "" or self.statusEffectName and self.statusEffectName ~= "" then
		self:SetHasCustomTransmitterData(true)
		self:SendBuffRefreshToClients()
	end
end
function modifier_generic_bleed.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local victim = self:GetParent()
	local attacker = self:GetCaster()
	if
		not IsValidAlive(nil, victim)
		or not IsValidAlive(nil, attacker)
		or self.remainingDamagePool <= 0
		or self.ticksLeft <= 0
	then
		self:Destroy()
		return
	end
	local baseDamage = self.remainingDamagePool / self.ticksLeft
	if baseDamage <= 0 then
		self:Destroy()
		return
	end
	local damage = self:CalculateTickDamage(attacker, baseDamage)
	local intervalChanged = self:UpdateTickInterval(attacker)
	Damage:ApplyDamage({
		attacker = attacker,
		victim = victim,
		damage = damage,
		damage_type = 4,
		damage_flag = ApplyDamageFlag.HP_LOSS,
		ability = self:GetAbility(),
		extra_data = {
			damage_tags = DamageTag.DOT,
			debuff_status = DebuffStatusType.BLEED,
			source_name = self:GetName(),
		},
	})
	self.remainingDamagePool = math.max(self.remainingDamagePool - baseDamage, 0)
	self:RefreshStateCount()
	self.ticksLeft = self.ticksLeft - 1
	if self.ticksLeft <= 0 or self.remainingDamagePool <= 0 then
		self:Destroy()
		return
	end
	if intervalChanged then
		self:StartIntervalThink(self.currentTickInterval)
	end
end
function modifier_generic_bleed.prototype.AddExternalBleed(self, source_final_damage, duration)
	if not IsServer() then
		return
	end
	local addedDamage = math.max(source_final_damage, 0) * (BLEED_TOTAL_DAMAGE_PCT / 100)
	self:AddBleedPoolDamage(addedDamage, duration)
end
function modifier_generic_bleed.prototype.AddBleedPoolDamage(self, poolDamage, duration)
	if not IsServer() then
		return
	end
	local addedDamage = math.max(poolDamage, 0)
	if addedDamage <= 0 then
		return
	end
	self.remainingDamagePool = self.remainingDamagePool + addedDamage
	self.ticksLeft = math.max(1, math.floor(duration / BLEED_TICK_INTERVAL))
	self:SetDuration(duration, true)
	self:RefreshStateCount()
	local attacker = self:GetCaster()
	local intervalChanged = self:UpdateTickInterval(attacker)
	if not self.thinkStarted then
		self.thinkStarted = true
		self:StartIntervalThink(self.currentTickInterval)
	elseif intervalChanged then
		self:StartIntervalThink(self.currentTickInterval)
	end
	local victim = self:GetParent()
	if not IsValid(nil, attacker) or not IsValid(nil, victim) then
		return
	end
	MyGameEvent:FireEvent(BusinessEvents.ON_BLEED_STACK_CHANGED, {
		attacker = attacker,
		victim = victim,
		ability = self:GetAbility(),
		added_stacks = math.max(1, math.ceil(addedDamage)),
		total_bleed_stacks = GetTotalBleedStacks(nil, victim),
	}, { scope = "entity", entity = attacker })
end
function modifier_generic_bleed.prototype.RefreshStateCount(self)
	local ____temp_0
	if self.remainingDamagePool > 0 then
		____temp_0 = math.max(1, math.ceil(self.remainingDamagePool))
	else
		____temp_0 = 0
	end
	local stateCount = ____temp_0
	self:SetStackCount(stateCount)
end
function modifier_generic_bleed.prototype.CalculateTickDamage(self, attacker, baseDamage)
	local bleedOutgoingPct = MyGameAttribute:GetAttribute(attacker, "bleed_outgoing_damage_pct") or 0
	local dotOutgoingPct = MyGameAttribute:GetAttribute(attacker, "dot_outgoing_damage_pct") or 0
	local bleedMultiplier = 1 + bleedOutgoingPct / 100
	local dotMultiplier = 1 + dotOutgoingPct / 100
	return math.max(0, baseDamage * bleedMultiplier * dotMultiplier)
end
function modifier_generic_bleed.prototype.UpdateTickInterval(self, attacker)
	local nextInterval = self:GetBleedTickInterval(attacker)
	local changed = math.abs(self.currentTickInterval - nextInterval) > 0.0001
	self.currentTickInterval = nextInterval
	return changed
end
function modifier_generic_bleed.prototype.GetBleedTickInterval(self, attacker)
	if not attacker or not IsValid(nil, attacker) or not MyGameAttribute:HasAttributes(attacker) then
		return BLEED_TICK_INTERVAL
	end
	local fasterPct = MyGameAttribute:GetAttribute(attacker, "bleed_damage_faster_pct") or 0
	local speedMultiplier = math.min(math.max(1 + fasterPct / 100, 0.05), 10)
	return math.max(BLEED_TICK_INTERVAL / speedMultiplier, 0.03)
end
function modifier_generic_bleed.prototype.AddCustomTransmitterData(self)
	return { effectName = self.effectName, statusEffectName = self.statusEffectName }
end
function modifier_generic_bleed.prototype.HandleCustomTransmitterData(self, data)
	self.effectName = data.effectName
	self.statusEffectName = data.statusEffectName
end
function modifier_generic_bleed.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_generic_bleed.prototype.IsHidden(self)
	return false
end
function modifier_generic_bleed.prototype.IsDebuff(self)
	return true
end
function modifier_generic_bleed.prototype.IsPurgable(self)
	return true
end
function modifier_generic_bleed.prototype.GetEffectName(self)
	return self.effectName or "particles/bb/grimstroke_ink_over_debuff_ground_splash_2.vpcf"
end
function modifier_generic_bleed.prototype.GetStatusEffectName(self)
	return self.statusEffectName or ""
end
function modifier_generic_bleed.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_generic_bleed.prototype.GetTexture(self)
	return "bloodseeker_rupture"
end
modifier_generic_bleed = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_bleed)
____exports.modifier_generic_bleed = modifier_generic_bleed
return ____exports