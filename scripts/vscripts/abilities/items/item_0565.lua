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
local ____modifier_generic_ignite = require("modifiers.debuff.modifier_generic_ignite")
local modifier_generic_ignite = ____modifier_generic_ignite.modifier_generic_ignite
local ____fenshi_set = require("shared.fenshi_set")
local CountFenshiItems = ____fenshi_set.CountFenshiItems
____exports.item_0565 = __TS__Class()
local item_0565 = ____exports.item_0565
item_0565.name = "item_0565"
__TS__ClassExtends(item_0565, BaseItem_CS)
function item_0565.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0565.name
end
item_0565 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0565)
____exports.item_0565 = item_0565
--- 固有监听：对处于点燃的敌人造成非 DOT 伤害时，按焚世套装件数概率为其额外叠加 1 层点燃。
____exports.modifier_item_0565 = __TS__Class()
local modifier_item_0565 = ____exports.modifier_item_0565
modifier_item_0565.name = "modifier_item_0565"
__TS__ClassExtends(modifier_item_0565, BaseModifier_CS)
function modifier_item_0565.GetLocalizationCN(self)
	return {
		name = "星火燎原",
		description = "对处于点燃的敌人造成伤害时，按焚世套装件数有概率使其额外叠加 1 层点燃。",
	}
end
function modifier_item_0565.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0565.prototype.IsHidden(self)
	return true
end
function modifier_item_0565.prototype.IsPurgable(self)
	return false
end
function modifier_item_0565.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
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
	local ignite = target:FindModifierByName(modifier_generic_ignite.name)
	if not (ignite and ignite.AddExternalStacks) then
		return
	end
	local chancePerItem = math.max(0, ability:GetSpecialValueFor("ability_chance_per_set_item"))
	local setCount = CountFenshiItems(nil, parent)
	local chancePct = math.min(100, setCount * chancePerItem)
	if chancePct <= 0 or not RollPercentage(chancePct) then
		return
	end
	ignite:AddExternalStacks({ stack = 1 })
end
modifier_item_0565 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0565)
____exports.modifier_item_0565 = modifier_item_0565
return ____exports