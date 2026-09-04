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
local protectionParticle = "particles/items4_fx/combo_breaker_buff.vpcf"
local triggerParticle = "particles/items_fx/aegis_respawn.vpcf"
local protectionSound = "DOTA_Item.ComboBreaker"
____exports.item_0426 = __TS__Class()
local item_0426 = ____exports.item_0426
item_0426.name = "item_0426"
__TS__ClassExtends(item_0426, BaseItem_CS)
function item_0426.prototype.Precache(self, context)
	PrecacheResource("particle", protectionParticle, context)
	PrecacheResource("particle", triggerParticle, context)
end
function item_0426.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0426_stasis_tracker.name
end
function item_0426.prototype.PlayEffects1(self, parent)
	local particle = MyGameHeroParticleManager:CreateParticle(triggerParticle, PATTACH_ABSORIGIN_FOLLOW, parent, parent)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 1, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 2, parent:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	parent:EmitSound(protectionSound)
end
item_0426 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0426)
____exports.item_0426 = item_0426
____exports.modifier_item_0426_stasis_tracker = __TS__Class()
local modifier_item_0426_stasis_tracker = ____exports.modifier_item_0426_stasis_tracker
modifier_item_0426_stasis_tracker.name = "modifier_item_0426_stasis_tracker"
__TS__ClassExtends(modifier_item_0426_stasis_tracker, BaseModifier_CS)
function modifier_item_0426_stasis_tracker.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.protectionReady = false
end
function modifier_item_0426_stasis_tracker.prototype.DeclareEvents(self)
	return {
		BusinessEvents.ON_MIN_HEALTH_TRIGGER,
		{ event = BusinessEvents.ON_UNIT_DEATH_INTERCEPT, priority = DeathRevivePriority.EQUIPMENT },
	}
end
function modifier_item_0426_stasis_tracker.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MIN_HEALTH, MODIFIER_EVENT_ON_TAKEDAMAGE }
end
function modifier_item_0426_stasis_tracker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local ____temp_2 = ability and ability:IsCooldownReady()
	if ____temp_2 == nil then
		____temp_2 = false
	end
	self.protectionReady = ____temp_2
	self:StartIntervalThink(0.1)
end
function modifier_item_0426_stasis_tracker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:UpdateProtectionReady()
end
function modifier_item_0426_stasis_tracker.prototype.GetMinHealth(self)
	return self.protectionReady and 1 or 0
end
function modifier_item_0426_stasis_tracker.prototype.GetAttributeBonus(self)
	local ____table_protectionReady_3
	if self.protectionReady then
		____table_protectionReady_3 = { min_health = 1 }
	else
		____table_protectionReady_3 = {}
	end
	return ____table_protectionReady_3
end
function modifier_item_0426_stasis_tracker.prototype.OnTakeDamage(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.unit ~= parent or event.damage <= 0 or parent:GetHealth() > 1 then
		return
	end
	self:TriggerProtection()
end
function modifier_item_0426_stasis_tracker.prototype.OnMinHealthTrigger_CS(self, event)
	if not IsServer() or event.victim ~= self:GetParent() then
		return
	end
	self:TriggerProtection()
end
function modifier_item_0426_stasis_tracker.prototype.OnUnitDeathIntercept_CS(self, event)
	if not IsServer() or event.prevented then
		return
	end
	local parent = self:GetParent()
	if event.victim ~= parent or not self:TriggerProtection() then
		return
	end
	event.prevented = true
	event.handled_by = self:GetName()
	event.intercept_type = "death_prevent"
	event.set_health = 1
end
function modifier_item_0426_stasis_tracker.prototype.TriggerProtection(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsServer() or not ability or not IsValidAlive(nil, parent) or not ability:IsCooldownReady() then
		return false
	end
	local ability_duration = ability:GetSpecialValue("item_0426", "ability_value_duration")
	local ability_omni_lifesteal_pct = ability:GetSpecialValue("item_0426", "ability_value_omni_lifesteal_pct")
	local ability_damage_reduction_pct = ability:GetSpecialValue("item_0426", "ability_damage_reduction_pct")
	if ability_duration <= 0 then
		return false
	end
	local ability_level = math.max(0, ability:GetLevel() - 1)
	ability:StartCooldown(math.max(0.1, ability:GetCooldown(ability_level)))
	self.protectionReady = false
	self:RefreshAttributes()
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0426_stasis.name,
		{
			duration = ability_duration,
			ability_omni_lifesteal_pct = ability_omni_lifesteal_pct,
			ability_damage_reduction_pct = ability_damage_reduction_pct,
		}
	)
	ability:PlayEffects1(parent)
	return true
end
function modifier_item_0426_stasis_tracker.prototype.UpdateProtectionReady(self)
	local ability = self:GetAbility()
	local ____temp_6 = ability and ability:IsCooldownReady()
	if ____temp_6 == nil then
		____temp_6 = false
	end
	local protectionReady = ____temp_6
	if self.protectionReady == protectionReady then
		return
	end
	self.protectionReady = protectionReady
	self:RefreshAttributes()
end
function modifier_item_0426_stasis_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0426_stasis_tracker.prototype.IsPurgable(self)
	return false
end
modifier_item_0426_stasis_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0426_stasis_tracker)
____exports.modifier_item_0426_stasis_tracker = modifier_item_0426_stasis_tracker
____exports.modifier_item_0426_stasis = __TS__Class()
local modifier_item_0426_stasis = ____exports.modifier_item_0426_stasis
modifier_item_0426_stasis.name = "modifier_item_0426_stasis"
__TS__ClassExtends(modifier_item_0426_stasis, BaseModifier_CS)
function modifier_item_0426_stasis.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.abilityOmniLifestealPct = 0
	self.abilityDamageReductionPct = 0
end
function modifier_item_0426_stasis.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0426_stasis.GetLocalizationCN(self)
	return { name = "凝固", description = "受到的伤害降低并获得全域吸血。" }
end
function modifier_item_0426_stasis.prototype.OnCreated(self, params)
	self:UpdateValues(params)
end
function modifier_item_0426_stasis.prototype.OnRefresh(self, params)
	self:UpdateValues(params)
end
function modifier_item_0426_stasis.prototype.UpdateValues(self, params)
	self.abilityOmniLifestealPct = math.max(0, params.ability_omni_lifesteal_pct or 0)
	self.abilityDamageReductionPct = math.max(0, params.ability_damage_reduction_pct or 0)
	self:RefreshAttributes()
end
function modifier_item_0426_stasis.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() or self.abilityDamageReductionPct < 100 then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	event.prevent_apply = true
end
function modifier_item_0426_stasis.prototype.GetAttributeBonus(self)
	return { omni_lifesteal_pct = self.abilityOmniLifestealPct, damage_reduction_pct = self.abilityDamageReductionPct }
end
function modifier_item_0426_stasis.prototype.IsHidden(self)
	return false
end
function modifier_item_0426_stasis.prototype.IsPurgable(self)
	return false
end
function modifier_item_0426_stasis.prototype.GetTexture(self)
	return "item_bb06"
end
function modifier_item_0426_stasis.prototype.GetEffectName(self)
	return protectionParticle
end
function modifier_item_0426_stasis.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_item_0426_stasis = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0426_stasis)
____exports.modifier_item_0426_stasis = modifier_item_0426_stasis
return ____exports