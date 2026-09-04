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
local THINK_INTERVAL = 0.3
____exports.item_0610 = __TS__Class()
local item_0610 = ____exports.item_0610
item_0610.name = "item_0610"
__TS__ClassExtends(item_0610, BaseItem_CS)
function item_0610.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0610.name
end
item_0610 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0610)
____exports.item_0610 = item_0610
--- 固有被动：维护逾限记录（层数=暴伤加成）。
____exports.modifier_item_0610 = __TS__Class()
local modifier_item_0610 = ____exports.modifier_item_0610
modifier_item_0610.name = "modifier_item_0610"
__TS__ClassExtends(modifier_item_0610, BaseModifier_CS)
function modifier_item_0610.prototype.IsHidden(self)
	return true
end
function modifier_item_0610.prototype.IsPurgable(self)
	return false
end
function modifier_item_0610.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0610.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	local record = parent:FindModifierByName(____exports.modifier_item_0610_excess.name)
	if record and not record:IsNull() then
		record:Destroy()
	end
end
function modifier_item_0610.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local overflow = self:GetOverflow(parent, ability)
	local step = math.max(1, ability:GetSpecialValueFor("ability_overflow_per_step"))
	local ampPerStep = math.max(0, ability:GetSpecialValueFor("ability_value_crit_damage_per_step"))
	local amp = math.floor(overflow / step) * ampPerStep
	local record = parent:FindModifierByName(____exports.modifier_item_0610_excess.name)
	if amp > 0 then
		local m = record
		if not m or m:IsNull() then
			m = parent:AddNewModifier(parent, ability, ____exports.modifier_item_0610_excess.name, {})
		end
		if m and not m:IsNull() then
			m:SetStackCount(amp)
			m:RefreshAttributes()
		end
	elseif record and not record:IsNull() then
		record:Destroy()
	end
end
function modifier_item_0610.prototype.GetOverflow(self, parent, ability)
	local ability_value_c_crit_cap_pct = math.max(1, ability:GetSpecialValueFor("ability_value_c_crit_cap_pct"))
	local physicalCritChancePct = math.max(0, MyGameAttribute:GetAttribute(parent, "physical_crit_chance_pct") or 0)
	local omniCritChancePct = math.max(0, MyGameAttribute:GetAttribute(parent, "omni_crit_chance_pct") or 0)
	local total = physicalCritChancePct + omniCritChancePct
	return math.max(0, math.floor(total - ability_value_c_crit_cap_pct))
end
modifier_item_0610 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0610)
____exports.modifier_item_0610 = modifier_item_0610
--- 【逾限】：可见 buff——层数 = 当前暴击伤害加成（溢出换算·层数即加成）。
____exports.modifier_item_0610_excess = __TS__Class()
local modifier_item_0610_excess = ____exports.modifier_item_0610_excess
modifier_item_0610_excess.name = "modifier_item_0610_excess"
__TS__ClassExtends(modifier_item_0610_excess, BaseModifier_CS)
function modifier_item_0610_excess.GetLocalizationCN(self)
	return {
		name = "逾限",
		description = "超出暴击率上限的部分转化为暴击伤害（层数=当前加成百分比）。",
	}
end
function modifier_item_0610_excess.prototype.GetAttributeBonus(self)
	local amp = self:GetStackCount()
	if amp <= 0 then
		return {}
	end
	return { crit_damage_pct = amp }
end
function modifier_item_0610_excess.prototype.IsHidden(self)
	return false
end
function modifier_item_0610_excess.prototype.IsDebuff(self)
	return false
end
function modifier_item_0610_excess.prototype.IsPurgable(self)
	return false
end
function modifier_item_0610_excess.prototype.GetTexture(self)
	return "item_crystalys"
end
modifier_item_0610_excess = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0610_excess)
____exports.modifier_item_0610_excess = modifier_item_0610_excess
return ____exports