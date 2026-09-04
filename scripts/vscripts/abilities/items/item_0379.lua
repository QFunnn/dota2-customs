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
____exports.item_0379 = __TS__Class()
local item_0379 = ____exports.item_0379
item_0379.name = "item_0379"
__TS__ClassExtends(item_0379, BaseItem_CS)
function item_0379.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0379_curse_ribbon.name
end
item_0379 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0379)
____exports.item_0379 = item_0379
____exports.modifier_item_0379_curse_ribbon = __TS__Class()
local modifier_item_0379_curse_ribbon = ____exports.modifier_item_0379_curse_ribbon
modifier_item_0379_curse_ribbon.name = "modifier_item_0379_curse_ribbon"
__TS__ClassExtends(modifier_item_0379_curse_ribbon, BaseModifier_CS)
function modifier_item_0379_curse_ribbon.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0379_curse_ribbon.prototype.OnTakeDamage_CS(self, event)
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
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_duration = ability:GetSpecialValueFor("ability_duration")
	target:AddNewModifier(parent, ability, ____exports.modifier_item_0379_doom.name, { duration = ability_duration })
end
function modifier_item_0379_curse_ribbon.prototype.IsHidden(self)
	return true
end
function modifier_item_0379_curse_ribbon.prototype.IsPurgable(self)
	return false
end
modifier_item_0379_curse_ribbon = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0379_curse_ribbon)
____exports.modifier_item_0379_curse_ribbon = modifier_item_0379_curse_ribbon
____exports.modifier_item_0379_doom = __TS__Class()
local modifier_item_0379_doom = ____exports.modifier_item_0379_doom
modifier_item_0379_doom.name = "modifier_item_0379_doom"
__TS__ClassExtends(modifier_item_0379_doom, BaseModifier_CS)
function modifier_item_0379_doom.GetLocalizationCN(self)
	return { name = "厄运", description = "魔法抗性降低。" }
end
function modifier_item_0379_doom.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_magical_damage_add_pct = ability:GetSpecialValueFor("ability_magical_damage_add_pct")
	return { incoming_magical_damage_increase_pct = math.max(0, ability_magical_damage_add_pct) }
end
function modifier_item_0379_doom.prototype.IsDebuff(self)
	return true
end
function modifier_item_0379_doom.prototype.IsPurgable(self)
	return true
end
function modifier_item_0379_doom.prototype.GetTexture(self)
	return "item_item_0379"
end
modifier_item_0379_doom = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0379_doom)
____exports.modifier_item_0379_doom = modifier_item_0379_doom
return ____exports