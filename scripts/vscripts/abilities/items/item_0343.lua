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
____exports.item_0343 = __TS__Class()
local item_0343 = ____exports.item_0343
item_0343.name = "item_0343"
__TS__ClassExtends(item_0343, BaseItem_CS)
function item_0343.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0343_blessing.name
end
item_0343 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0343)
____exports.item_0343 = item_0343
____exports.modifier_item_0343_blessing = __TS__Class()
local modifier_item_0343_blessing = ____exports.modifier_item_0343_blessing
modifier_item_0343_blessing.name = "modifier_item_0343_blessing"
__TS__ClassExtends(modifier_item_0343_blessing, BaseModifier_CS)
function modifier_item_0343_blessing.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_FINAL_PRE_APPLY }
end
function modifier_item_0343_blessing.prototype.IsHidden(self)
	return true
end
function modifier_item_0343_blessing.prototype.IsPurgable(self)
	return false
end
function modifier_item_0343_blessing.prototype.GetMutexKey(self)
	return "bi_you_mutex"
end
function modifier_item_0343_blessing.prototype.GetMutexPriority(self)
	local ____opt_0 = self:GetAbility()
	return (____opt_0 and ____opt_0:GetAbilityName()) == "item_0443" and 200 or 100
end
function modifier_item_0343_blessing.prototype.OnDamageFinalPreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.victim ~= parent then
		return
	end
	local ability_threshold_health_pct = ability:GetSpecialValueFor("ability_threshold_health_pct")
	local ability_excess_reduce_pct = ability:GetSpecialValueFor("ability_excess_reduce_pct")
	if ability_threshold_health_pct <= 0 or ability_excess_reduce_pct <= 0 then
		return
	end
	local maxHealth = parent:GetMaxHealth()
	if maxHealth <= 0 then
		return
	end
	local thresholdDamage = maxHealth * ability_threshold_health_pct / 100
	local currentDamage = self:GetCurrentPipeDamage(event.final)
	if currentDamage <= thresholdDamage then
		return
	end
	local excessDamage = currentDamage - thresholdDamage
	local reducedDamage = excessDamage * ability_excess_reduce_pct / 100
	if reducedDamage <= 0 then
		return
	end
	local targetDamage = currentDamage - reducedDamage
	local ____event_final_2, ____mul_3 = event.final, "mul"
	if ____event_final_2[____mul_3] == nil then
		____event_final_2[____mul_3] = {}
	end
	local ____event_final_mul_4 = event.final.mul
	____event_final_mul_4[#____event_final_mul_4 + 1] =
		{ value = targetDamage / currentDamage, source = "item_0343:超额伤害减免" }
	self:PlayEffects1(parent, reducedDamage)
end
function modifier_item_0343_blessing.prototype.GetCurrentPipeDamage(self, final)
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
function modifier_item_0343_blessing.prototype.PlayEffects1(self, parent, reducedDamage)
	Popups:damageBlock(parent, math.max(1, math.floor(reducedDamage)))
end
modifier_item_0343_blessing = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0343_blessing)
____exports.modifier_item_0343_blessing = modifier_item_0343_blessing
return ____exports