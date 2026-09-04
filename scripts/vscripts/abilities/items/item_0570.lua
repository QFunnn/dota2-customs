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
local THINK_INTERVAL = 0.2
____exports.item_0570 = __TS__Class()
local item_0570 = ____exports.item_0570
item_0570.name = "item_0570"
__TS__ClassExtends(item_0570, BaseItem_CS)
function item_0570.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0570.name
end
item_0570 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0570)
____exports.item_0570 = item_0570
____exports.modifier_item_0570 = __TS__Class()
local modifier_item_0570 = ____exports.modifier_item_0570
modifier_item_0570.name = "modifier_item_0570"
__TS__ClassExtends(modifier_item_0570, BaseModifier_CS)
function modifier_item_0570.GetLocalizationCN(self)
	return { name = "万诅共鸣", description = "负面状态达到阈值时，获得全域暴击率。" }
end
function modifier_item_0570.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0570.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0570.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0570.prototype.IsHidden(self)
	return true
end
function modifier_item_0570.prototype.IsDebuff(self)
	return false
end
function modifier_item_0570.prototype.IsPurgable(self)
	return false
end
function modifier_item_0570.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return {}
	end
	local threshold = math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_c_debuff_threshold")))
	local omniCritPct = math.max(0, ability:GetSpecialValueFor("ability_value_omni_crit_pct"))
	if omniCritPct <= 0 then
		return {}
	end
	if self:CountDebuffs(parent) < threshold then
		return {}
	end
	return { omni_crit_chance_pct = omniCritPct }
end
function modifier_item_0570.prototype.CountDebuffs(self, parent)
	local mods = parent:FindAllModifiers() or {}
	local n = 0
	for ____, m in ipairs(mods) do
		if m.IsDebuff and m:IsDebuff() then
			n = n + 1
		end
	end
	return n
end
modifier_item_0570 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0570)
____exports.modifier_item_0570 = modifier_item_0570
return ____exports