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
____exports.item_0267 = __TS__Class()
local item_0267 = ____exports.item_0267
item_0267.name = "item_0267"
__TS__ClassExtends(item_0267, BaseItem_CS)
function item_0267.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0267.name
end
item_0267 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0267)
____exports.item_0267 = item_0267
____exports.modifier_item_0267 = __TS__Class()
local modifier_item_0267 = ____exports.modifier_item_0267
modifier_item_0267.name = "modifier_item_0267"
__TS__ClassExtends(modifier_item_0267, BaseModifier_CS)
function modifier_item_0267.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0267.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if event.damage_type ~= 2 then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	AddDeBuffStatus(
		nil,
		target,
		parent,
		ability,
		DebuffStatusType.BURN,
		{ duration = ability:GetSpecialValueFor("ability_burn_duration") }
	)
end
function modifier_item_0267.prototype.IsHidden(self)
	return true
end
modifier_item_0267 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0267)
____exports.modifier_item_0267 = modifier_item_0267
return ____exports