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
____exports.item_0385 = __TS__Class()
local item_0385 = ____exports.item_0385
item_0385.name = "item_0385"
__TS__ClassExtends(item_0385, BaseItem_CS)
function item_0385.prototype.____constructor(self, ...)
	BaseItem_CS.prototype.____constructor(self, ...)
	self.hiddenProtectionConsumed = false
end
function item_0385.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0385_lionheart_barrier.name
end
function item_0385.prototype.StartLionheartCooldown(self)
	local ability_level = math.max(0, self:GetLevel() - 1)
	self:StartCooldown(math.max(0.1, self:GetCooldown(ability_level)))
	self.hiddenProtectionConsumed = false
end
function item_0385.prototype.TryConsumeHiddenProtection(self)
	if self:IsCooldownReady() or self.hiddenProtectionConsumed then
		return false
	end
	self.hiddenProtectionConsumed = true
	return true
end
function item_0385.prototype.IsHiddenProtectionAvailable(self)
	return not self:IsCooldownReady() and not self.hiddenProtectionConsumed
end
item_0385 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0385)
____exports.item_0385 = item_0385
____exports.modifier_item_0385_lionheart_barrier = __TS__Class()
local modifier_item_0385_lionheart_barrier = ____exports.modifier_item_0385_lionheart_barrier
modifier_item_0385_lionheart_barrier.name = "modifier_item_0385_lionheart_barrier"
__TS__ClassExtends(modifier_item_0385_lionheart_barrier, BaseModifier_CS)
function modifier_item_0385_lionheart_barrier.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.lethalProtectionEnabled = false
end
function modifier_item_0385_lionheart_barrier.GetLocalizationCN(self)
	return {
		name = "狮心壁垒",
		description = "生命过低时恢复生命与所有护盾，并获得高额伤害减免。",
	}
end
function modifier_item_0385_lionheart_barrier.prototype.DeclareEvents(self)
	return {
		BusinessEvents.ON_DEAL_DAMAGE,
		BusinessEvents.ON_HP_LOSS,
		BusinessEvents.ON_MIN_HEALTH_TRIGGER,
		{ event = BusinessEvents.ON_UNIT_DEATH_INTERCEPT, priority = DeathRevivePriority.EQUIPMENT },
	}
end
function modifier_item_0385_lionheart_barrier.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MIN_HEALTH, MODIFIER_EVENT_ON_TAKEDAMAGE }
end
function modifier_item_0385_lionheart_barrier.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:UpdateLethalProtection()
	self:StartIntervalThink(0.1)
end
function modifier_item_0385_lionheart_barrier.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0385_lionheart_barrier.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:UpdateLethalProtection()
end
function modifier_item_0385_lionheart_barrier.prototype.OnDealDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.victim ~= parent then
		return
	end
	if (event.final_damage or 0) <= 0 and (event.shield_absorbed_value or 0) <= 0 then
		return
	end
	self:TryTriggerMainBarrier()
end
function modifier_item_0385_lionheart_barrier.prototype.OnHpLoss_CS(self, event)
	if not IsServer() or event.victim ~= self:GetParent() then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	self:TryTriggerMainBarrier()
end
function modifier_item_0385_lionheart_barrier.prototype.OnMinHealthTrigger_CS(self, event)
	if not IsServer() or event.victim ~= self:GetParent() then
		return
	end
	self:TryHandleLethalProtection()
end
function modifier_item_0385_lionheart_barrier.prototype.OnTakeDamage(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.unit ~= parent or event.damage <= 0 then
		return
	end
	if parent:GetHealth() <= 1 and self:TryHandleLethalProtection() then
		return
	end
	self:TryTriggerMainBarrier()
end
function modifier_item_0385_lionheart_barrier.prototype.OnUnitDeathIntercept_CS(self, event)
	if not IsServer() or event.prevented then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local isMainBarrierReady = (ability and ability:IsCooldownReady()) == true
	if event.victim ~= parent or not self:TryHandleLethalProtection() then
		return
	end
	event.prevented = true
	event.handled_by = self:GetName()
	event.intercept_type = "death_prevent"
	if isMainBarrierReady and ability then
		local ability_restore_max_health_pct = ability:GetSpecialValueFor("ability_value_restore_max_health_pct")
		event.set_health = math.max(1, parent:GetMaxHealth() * (ability_restore_max_health_pct / 100))
	else
		event.set_health = 1
	end
end
function modifier_item_0385_lionheart_barrier.prototype.GetMinHealth(self)
	return self.lethalProtectionEnabled and 1 or 0
end
function modifier_item_0385_lionheart_barrier.prototype.GetAttributeBonus(self)
	local ____table_lethalProtectionEnabled_2
	if self.lethalProtectionEnabled then
		____table_lethalProtectionEnabled_2 = { min_health = 1 }
	else
		____table_lethalProtectionEnabled_2 = {}
	end
	return ____table_lethalProtectionEnabled_2
end
function modifier_item_0385_lionheart_barrier.prototype.IsHidden(self)
	return true
end
function modifier_item_0385_lionheart_barrier.prototype.IsDebuff(self)
	return false
end
function modifier_item_0385_lionheart_barrier.prototype.IsPurgable(self)
	return false
end
function modifier_item_0385_lionheart_barrier.prototype.GetTexture(self)
	return "item_bb01"
end
function modifier_item_0385_lionheart_barrier.prototype.TryTriggerMainBarrier(self, ignoreHealthThreshold)
	if ignoreHealthThreshold == nil then
		ignoreHealthThreshold = false
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or not ability:IsCooldownReady() then
		return false
	end
	if not ignoreHealthThreshold then
		local ability_health_threshold_pct = ability:GetSpecialValueFor("ability_health_threshold_pct")
		local ability_health_pct = parent:GetHealth() / math.max(1, parent:GetMaxHealth()) * 100
		if ability_health_pct >= ability_health_threshold_pct then
			return false
		end
	end
	local ability_duration = ability:GetSpecialValueFor("ability_value_duration")
	local ability_damage_reduction_pct = ability:GetSpecialValueFor("ability_damage_reduction_pct")
	self:RestoreAllShield(parent)
	self:RestoreHealth(parent, ability)
	____exports.modifier_item_0385_lionheart_reduction:applys(
		parent,
		parent,
		ability,
		{ duration = ability_duration, ability_damage_reduction_pct = ability_damage_reduction_pct }
	)
	ability:StartLionheartCooldown()
	self:UpdateLethalProtection()
	self:PlayEffects1(parent)
	return true
end
function modifier_item_0385_lionheart_barrier.prototype.RestoreHealth(self, parent, ability)
	local ability_restore_max_health_pct = ability:GetSpecialValueFor("ability_value_restore_max_health_pct")
	local ability_restore_health = parent:GetMaxHealth() * (ability_restore_max_health_pct / 100)
	if ability_restore_health > 0 then
		parent:CustomHeal(ability_restore_health, { ability = ability, source = "item" })
	end
end
function modifier_item_0385_lionheart_barrier.prototype.TryHandleLethalProtection(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return false
	end
	if ability:IsCooldownReady() then
		return self:TryTriggerMainBarrier(true)
	end
	if not ability:TryConsumeHiddenProtection() then
		return false
	end
	self:RestoreAllShield(parent)
	self:UpdateLethalProtection()
	self:PlayEffects1(parent)
	return true
end
function modifier_item_0385_lionheart_barrier.prototype.UpdateLethalProtection(self)
	local ability = self:GetAbility()
	local lethalProtectionEnabled = (ability and ability:IsCooldownReady()) == true
		or (ability and ability:IsHiddenProtectionAvailable()) == true
	if self.lethalProtectionEnabled == lethalProtectionEnabled then
		return
	end
	self.lethalProtectionEnabled = lethalProtectionEnabled
	self:RefreshAttributes()
end
function modifier_item_0385_lionheart_barrier.prototype.RestoreAllShield(self, parent)
	if not parent.GetCurrentEnergyShield or not parent.GetTotalEnergyShield or not parent.AddCurrentEnergyShield then
		return
	end
	local totalShield = math.max(0, parent:GetTotalEnergyShield())
	local currentShield = math.max(0, parent:GetCurrentEnergyShield())
	local missingShield = math.max(0, totalShield - currentShield)
	if missingShield > 0 then
		parent:AddCurrentEnergyShield(missingShield)
	end
end
function modifier_item_0385_lionheart_barrier.prototype.PlayEffects1(self, parent)
	parent:EmitSound("Item.Lotus.Heal")
end
modifier_item_0385_lionheart_barrier =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0385_lionheart_barrier)
____exports.modifier_item_0385_lionheart_barrier = modifier_item_0385_lionheart_barrier
____exports.modifier_item_0385_lionheart_reduction = __TS__Class()
local modifier_item_0385_lionheart_reduction = ____exports.modifier_item_0385_lionheart_reduction
modifier_item_0385_lionheart_reduction.name = "modifier_item_0385_lionheart_reduction"
__TS__ClassExtends(modifier_item_0385_lionheart_reduction, BaseModifier_CS)
function modifier_item_0385_lionheart_reduction.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.abilityDamageReductionPct = 0
end
function modifier_item_0385_lionheart_reduction.GetLocalizationCN(self)
	return { name = "狮心壁垒", description = "受到的伤害大幅降低。" }
end
function modifier_item_0385_lionheart_reduction.prototype.OnCreated(self, params)
	self:UpdateValues(params)
end
function modifier_item_0385_lionheart_reduction.prototype.OnRefresh(self, params)
	self:UpdateValues(params)
end
function modifier_item_0385_lionheart_reduction.prototype.GetAttributeBonus(self)
	return { damage_reduction_pct = self.abilityDamageReductionPct }
end
function modifier_item_0385_lionheart_reduction.prototype.IsHidden(self)
	return false
end
function modifier_item_0385_lionheart_reduction.prototype.IsDebuff(self)
	return false
end
function modifier_item_0385_lionheart_reduction.prototype.IsPurgable(self)
	return false
end
function modifier_item_0385_lionheart_reduction.prototype.GetTexture(self)
	return "item_bb01"
end
function modifier_item_0385_lionheart_reduction.prototype.UpdateValues(self, params)
	self.abilityDamageReductionPct = math.max(0, params.ability_damage_reduction_pct or 0)
	self:RefreshAttributes()
end
modifier_item_0385_lionheart_reduction =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0385_lionheart_reduction)
____exports.modifier_item_0385_lionheart_reduction = modifier_item_0385_lionheart_reduction
return ____exports