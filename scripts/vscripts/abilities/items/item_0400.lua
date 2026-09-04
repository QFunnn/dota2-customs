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
local IsRealNonItemAbility = ____item_0409_shared.IsRealNonItemAbility
local ____item_0564 = require("abilities.items.item_0564")
local IsChargeAbilityForRefund = ____item_0564.IsChargeAbilityForRefund
local RestoreOneAbilityCharge = ____item_0564.RestoreOneAbilityCharge
local CUSTOM_CHARGE_REFUND_DELAY = 0.05
____exports.item_0400 = __TS__Class()
local item_0400 = ____exports.item_0400
item_0400.name = "item_0400"
__TS__ClassExtends(item_0400, BaseItem_CS)
function item_0400.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0400_soul_bind.name
end
item_0400 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0400)
____exports.item_0400 = item_0400
____exports.modifier_item_0400_soul_bind = __TS__Class()
local modifier_item_0400_soul_bind = ____exports.modifier_item_0400_soul_bind
modifier_item_0400_soul_bind.name = "modifier_item_0400_soul_bind"
__TS__ClassExtends(modifier_item_0400_soul_bind, BaseModifier_CS)
function modifier_item_0400_soul_bind.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ability_cast_progress = 0
end
function modifier_item_0400_soul_bind.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0400_soul_bind.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0400_soul_bind.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local item_ability = self:GetAbility()
	if not item_ability or not IsValidAlive(nil, parent) or event.caster ~= parent:GetEntityIndex() then
		return
	end
	local cast_ability = EntIndexToHScript(event.ability_index)
	if not IsRealNonItemAbility(nil, cast_ability) or not self:IsChargeAbility(cast_ability) then
		return
	end
	local ability_required_casts =
		math.max(1, math.floor(item_ability:GetSpecialValueFor("ability_value_c_required_casts")))
	local ability_loop_stacks = self:GetStackCount()
	if ability_loop_stacks > 0 then
		if not self:TryRefundAbilityCharge(cast_ability) then
			return
		end
		self:SetStackCount(ability_loop_stacks - 1)
		self:PlayEffects2(parent)
		return
	end
	self.ability_cast_progress = self.ability_cast_progress + 1
	if self.ability_cast_progress < ability_required_casts then
		return
	end
	self.ability_cast_progress = 0
	self:SetStackCount(ability_loop_stacks + 1)
	self:PlayEffects1(parent)
end
function modifier_item_0400_soul_bind.prototype.IsChargeAbility(self, ability)
	return IsChargeAbilityForRefund(nil, ability)
end
function modifier_item_0400_soul_bind.prototype.TryRefundAbilityCharge(self, ability)
	local charge_ability = ability
	local ability_refund_time = GameRules:GetGameTime()
	if charge_ability.__item_charge_loop_refund_time__ == ability_refund_time then
		return false
	end
	charge_ability.__item_charge_loop_refund_time__ = ability_refund_time
	local parent = self:GetParent()
	if MyGameAbilityChargeManager and MyGameAbilityChargeManager:IsCustomChargeAbility(ability) then
		SysTimers:CreateTimer(CUSTOM_CHARGE_REFUND_DELAY, function()
			if not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
				return nil
			end
			RestoreOneAbilityCharge(nil, parent, ability)
			return nil
		end)
		return true
	end
	return RestoreOneAbilityCharge(nil, parent, ability)
end
function modifier_item_0400_soul_bind.prototype.PlayEffects1(self, parent)
	parent:EmitSound("DOTA_Item.ArcaneBoots.Activate")
end
function modifier_item_0400_soul_bind.prototype.PlayEffects2(self, parent)
	local particle_cast = MyGameHeroParticleManager:CreateParticle(
		"particles/boss/sky/skywrath_arcana_kill_targetc.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(particle_cast, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(particle_cast)
	parent:EmitSound("DOTA_Item.Refresher.Activate")
end
modifier_item_0400_soul_bind = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0400_soul_bind)
____exports.modifier_item_0400_soul_bind = modifier_item_0400_soul_bind
return ____exports