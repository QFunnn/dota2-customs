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
local ____modifier_generic_burning = require("modifiers.debuff.modifier_generic_burning")
local modifier_generic_burning = ____modifier_generic_burning.modifier_generic_burning
local PURGE_INTERVAL = 0.2
____exports.item_0613 = __TS__Class()
local item_0613 = ____exports.item_0613
item_0613.name = "item_0613"
__TS__ClassExtends(item_0613, BaseItem_CS)
function item_0613.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0613.name
end
item_0613 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0613)
____exports.item_0613 = item_0613
--- 固有被动「拒火」：周期净化自身的灼烧（快于灼烧首跳·等效完全免疫）。
____exports.modifier_item_0613 = __TS__Class()
local modifier_item_0613 = ____exports.modifier_item_0613
modifier_item_0613.name = "modifier_item_0613"
__TS__ClassExtends(modifier_item_0613, BaseModifier_CS)
function modifier_item_0613.GetLocalizationCN(self)
	return { name = "拒火", description = "免疫灼烧。" }
end
function modifier_item_0613.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:PurgeBurn()
	self:StartIntervalThink(PURGE_INTERVAL)
end
function modifier_item_0613.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0613.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:PurgeBurn()
end
function modifier_item_0613.prototype.PurgeBurn(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local mods = parent:FindAllModifiers() or {}
	for ____, m in ipairs(mods) do
		do
			local ____temp_2 = not m
			if not ____temp_2 then
				local ____opt_0 = m.IsNull
				____temp_2 = ____opt_0 and ____opt_0(m)
			end
			if ____temp_2 then
				goto __continue12
			end
			if m:GetName() == modifier_generic_burning.name then
				m:Destroy()
			end
		end
		::__continue12::
	end
end
function modifier_item_0613.prototype.IsHidden(self)
	return true
end
function modifier_item_0613.prototype.IsPurgable(self)
	return false
end
modifier_item_0613 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0613)
____exports.modifier_item_0613 = modifier_item_0613
return ____exports