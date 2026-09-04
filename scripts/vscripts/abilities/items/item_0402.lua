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
local __TS__Delete = ____lualib.__TS__Delete
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0402 = __TS__Class()
local item_0402 = ____exports.item_0402
item_0402.name = "item_0402"
__TS__ClassExtends(item_0402, BaseItem_CS)
function item_0402.prototype.GetIntrinsicModifierName(self)
	return ____exports.item_0402_modifier.name
end
item_0402 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0402)
____exports.item_0402 = item_0402
--- 固有被动「毒棘」（类名被公共毒系统 HasModifier('item_0402_modifier') 检查，勿改名）。
____exports.item_0402_modifier = __TS__Class()
local item_0402_modifier = ____exports.item_0402_modifier
item_0402_modifier.name = "item_0402_modifier"
__TS__ClassExtends(item_0402_modifier, BaseModifier_CS)
function item_0402_modifier.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.pendingSettle = {}
end
function item_0402_modifier.GetLocalizationCN(self)
	return { name = "毒棘", description = "每次添加中毒后立刻结算一次中毒伤害。" }
end
function item_0402_modifier.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEBUFF_STATUS_APPLY_QUERY }
end
function item_0402_modifier.prototype.IsHidden(self)
	return true
end
function item_0402_modifier.prototype.IsPurgable(self)
	return false
end
function item_0402_modifier.prototype.GetMutexKey(self)
	return "poison_instant_settle"
end
function item_0402_modifier.prototype.GetMutexPriority(self)
	return 100
end
function item_0402_modifier.prototype.OnDebuffStatusApplyQuery_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.caster ~= parent then
		return
	end
	if event.status ~= DebuffStatusType.POISON then
		return
	end
	if event.cancelled then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target == parent or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if not target:FindModifierByNameAndCaster("modifier_generic_poison", parent) then
		return
	end
	local targetIndex = target:entindex()
	if self.pendingSettle[targetIndex] then
		return
	end
	self.pendingSettle[targetIndex] = true
	Timers:CreateTimer(0.01, function()
		__TS__Delete(self.pendingSettle, targetIndex)
		if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) then
			return
		end
		local poison = target:FindModifierByNameAndCaster("modifier_generic_poison", parent)
		if not poison then
			return
		end
		local ____opt_0 = poison.OnIntervalThink
		if ____opt_0 ~= nil then
			____opt_0(poison)
		end
	end)
end
item_0402_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, item_0402_modifier)
____exports.item_0402_modifier = item_0402_modifier
return ____exports