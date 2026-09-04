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
____exports.item_0244 = __TS__Class()
local item_0244 = ____exports.item_0244
item_0244.name = "item_0244"
__TS__ClassExtends(item_0244, BaseItem_CS)
function item_0244.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0244"
end
item_0244 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0244)
____exports.item_0244 = item_0244
____exports.modifier_item_0244 = __TS__Class()
local modifier_item_0244 = ____exports.modifier_item_0244
modifier_item_0244.name = "modifier_item_0244"
__TS__ClassExtends(modifier_item_0244, BaseModifier_CS)
function modifier_item_0244.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_CRIT_QUERY }
end
function modifier_item_0244.prototype.OnDamageCritQuery_CS(self, event)
	local parent = self:GetParent()
	if event.ctx.spec.attacker ~= parent then
		return
	end
	local source = event.ctx.spec.source
	if not source or source.debuff_status ~= DebuffStatusType.BLEED then
		return
	end
	local physicalCritChancePct = math.max(0, MyGameAttribute:GetAttribute(parent, "physical_crit_chance_pct") or 0)
	local omniCritChancePct = math.max(0, MyGameAttribute:GetAttribute(parent, "omni_crit_chance_pct") or 0)
	local totalPhysicalCritChancePct = math.max(0, math.min(100, physicalCritChancePct + omniCritChancePct))
	if totalPhysicalCritChancePct <= 0 then
		return
	end
	local isCrit =
		RollPseudoRandomPercentage(totalPhysicalCritChancePct, DOTA_PSEUDO_RANDOM_PHANTOMASSASSIN_CRIT, parent)
	if isCrit then
		event.force_crit = true
	end
end
function modifier_item_0244.prototype.IsHidden(self)
	return true
end
modifier_item_0244 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0244)
____exports.modifier_item_0244 = modifier_item_0244
return ____exports