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
local item_0319 = __TS__Class()
item_0319.name = "item_0319"
__TS__ClassExtends(item_0319, BaseItem_CS)
function item_0319.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0319"
end
item_0319 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0319)
local modifier_item_0319 = __TS__Class()
modifier_item_0319.name = "modifier_item_0319"
__TS__ClassExtends(modifier_item_0319, BaseModifier_CS)
function modifier_item_0319.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0319.prototype.IsHidden(self)
	return true
end
function modifier_item_0319.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not ability:IsCooldownReady() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	AddDeBuffStatus(
		nil,
		target,
		event.attacker,
		ability,
		DebuffStatusType.POISON,
		{ stack = 1, effect_name = "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf" }
	)
	local lv = math.max(0, ability:GetLevel() - 1)
	local cd = ability:GetCooldown(lv)
	ability:StartCooldown(cd)
end
modifier_item_0319 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0319)
return ____exports