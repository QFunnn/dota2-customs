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
____exports.item_0277 = __TS__Class()
local item_0277 = ____exports.item_0277
item_0277.name = "item_0277"
__TS__ClassExtends(item_0277, BaseItem_CS)
function item_0277.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0277_tracker.name
end
item_0277 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0277)
____exports.item_0277 = item_0277
____exports.modifier_item_0277_tracker = __TS__Class()
local modifier_item_0277_tracker = ____exports.modifier_item_0277_tracker
modifier_item_0277_tracker.name = "modifier_item_0277_tracker"
__TS__ClassExtends(modifier_item_0277_tracker, BaseModifier_CS)
function modifier_item_0277_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0277_tracker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.2)
end
function modifier_item_0277_tracker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	if parent:HasModifier(____exports.modifier_item_0277_charged.name) then
		return
	end
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0277_charged.name, {})
end
modifier_item_0277_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0277_tracker)
____exports.modifier_item_0277_tracker = modifier_item_0277_tracker
____exports.modifier_item_0277_charged = __TS__Class()
local modifier_item_0277_charged = ____exports.modifier_item_0277_charged
modifier_item_0277_charged.name = "modifier_item_0277_charged"
__TS__ClassExtends(modifier_item_0277_charged, BaseModifier_CS)
function modifier_item_0277_charged.GetLocalizationCN(self)
	return { name = "蓄力", description = "下一次攻击必定暴击，并提高暴击伤害。" }
end
function modifier_item_0277_charged.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_CRIT_QUERY }
end
function modifier_item_0277_charged.prototype.OnDamageCritQuery_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not event.ctx.spec.is_base_attack then
		return
	end
	if not ability then
		return
	end
	if event.ctx.spec.attacker ~= parent then
		return
	end
	local ability_bonus_crit_damage_pct = ability:GetSpecialValue("item_0277", "ability_bonus_crit_damage_pct")
	local addMultiplier = math.max(0, ability_bonus_crit_damage_pct / 100)
	event.force_crit = true
	local ____event_multiplier_0, ____add_1 = event.multiplier, "add"
	if ____event_multiplier_0[____add_1] == nil then
		____event_multiplier_0[____add_1] = {}
	end
	local ____event_multiplier_add_2 = event.multiplier.add
	____event_multiplier_add_2[#____event_multiplier_add_2 + 1] =
		{ value = addMultiplier, source = "item_0277:暴击伤害增量" }
	local ability_cooldown = ability:GetSpecialValue("item_0277", "ability_cooldown")
	if ability_cooldown > 0 then
		ability:StartCooldown(ability_cooldown)
	end
	self:PlayEffects1(parent)
	self:Destroy()
end
function modifier_item_0277_charged.prototype.PlayEffects1(self, target)
	target:EmitSound("Hero_Mars.Shield.Crit")
end
function modifier_item_0277_charged.prototype.IsHidden(self)
	return false
end
function modifier_item_0277_charged.prototype.IsDebuff(self)
	return false
end
function modifier_item_0277_charged.prototype.IsPurgable(self)
	return false
end
function modifier_item_0277_charged.prototype.GetTexture(self)
	return "item_giant_maul"
end
modifier_item_0277_charged = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0277_charged)
____exports.modifier_item_0277_charged = modifier_item_0277_charged
return ____exports