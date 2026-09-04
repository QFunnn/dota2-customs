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
____exports.item_0398 = __TS__Class()
local item_0398 = ____exports.item_0398
item_0398.name = "item_0398"
__TS__ClassExtends(item_0398, BaseItem_CS)
function item_0398.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0398.name
end
item_0398 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0398)
____exports.item_0398 = item_0398
____exports.modifier_item_0398 = __TS__Class()
local modifier_item_0398 = ____exports.modifier_item_0398
modifier_item_0398.name = "modifier_item_0398"
__TS__ClassExtends(modifier_item_0398, BaseModifier_CS)
function modifier_item_0398.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_value_bleed_damage_faster_pct = ability:GetSpecialValueFor("ability_value_bleed_damage_faster_pct")
	return { bleed_damage_faster_pct = ability_value_bleed_damage_faster_pct }
end
function modifier_item_0398.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0398.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not event.is_crit or event.damage_type ~= 1 then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.DOT) then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_value_trigger_chance_pct = ability:GetSpecialValueFor("ability_value_trigger_chance_pct")
	if not RollPercentage(ability_value_trigger_chance_pct) then
		return
	end
	AddDeBuffStatus(
		nil,
		target,
		parent,
		ability,
		DebuffStatusType.BLEED,
		{ source_final_damage = math.max(0, event.final_damage or 0) }
	)
end
function modifier_item_0398.prototype.IsHidden(self)
	return true
end
modifier_item_0398 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0398)
____exports.modifier_item_0398 = modifier_item_0398
return ____exports