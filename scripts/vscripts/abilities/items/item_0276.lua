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
____exports.item_0276 = __TS__Class()
local item_0276 = ____exports.item_0276
item_0276.name = "item_0276"
__TS__ClassExtends(item_0276, BaseItem_CS)
function item_0276.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0276_brand.name
end
item_0276 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0276)
____exports.item_0276 = item_0276
____exports.modifier_item_0276_brand = __TS__Class()
local modifier_item_0276_brand = ____exports.modifier_item_0276_brand
modifier_item_0276_brand.name = "modifier_item_0276_brand"
__TS__ClassExtends(modifier_item_0276_brand, BaseModifier_CS)
function modifier_item_0276_brand.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY_ATTACKER }
end
function modifier_item_0276_brand.prototype.IsHidden(self)
	return true
end
function modifier_item_0276_brand.prototype.OnDamagePreApplyAttacker_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if event.ctx.spec.attacker ~= parent then
		return
	end
	local victim = event.ctx.spec.victim
	if not IsValidAlive(nil, victim) or victim:IsBuilding() then
		return
	end
	if not victim:IsStunned() then
		return
	end
	local ability_damage_amp_pct = ability:GetSpecialValue("item_0276", "ability_damage_amp_pct")
	if ability_damage_amp_pct <= 0 then
		return
	end
	local factor = 1 + ability_damage_amp_pct / 100
	local ____event_final_0, ____mul_1 = event.final, "mul"
	if ____event_final_0[____mul_1] == nil then
		____event_final_0[____mul_1] = {}
	end
	local ____event_final_mul_2 = event.final.mul
	____event_final_mul_2[#____event_final_mul_2 + 1] = { value = factor, source = "item_0276:眩晕增伤" }
	victim:EmitSound("n_creep_OgreBruiser.Smash.Stun")
end
modifier_item_0276_brand = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0276_brand)
____exports.modifier_item_0276_brand = modifier_item_0276_brand
return ____exports