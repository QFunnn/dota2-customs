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
____exports.item_0611 = __TS__Class()
local item_0611 = ____exports.item_0611
item_0611.name = "item_0611"
__TS__ClassExtends(item_0611, BaseItem_CS)
function item_0611.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0611.name
end
item_0611 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0611)
____exports.item_0611 = item_0611
--- 固有被动「百益」：层数 = 自身层数过门槛的增益个数，每个提高全域伤害。
____exports.modifier_item_0611 = __TS__Class()
local modifier_item_0611 = ____exports.modifier_item_0611
modifier_item_0611.name = "modifier_item_0611"
__TS__ClassExtends(modifier_item_0611, BaseModifier_CS)
function modifier_item_0611.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.buffCount = 0
end
function modifier_item_0611.GetLocalizationCN(self)
	return {
		name = "百益",
		description = "每有一个层数超过门槛的增益状态，就提高造成的伤害（层数=当前合格的增益个数）。",
	}
end
function modifier_item_0611.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0611.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0611.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability or not IsValid(nil, ability) then
		return
	end
	local ability_buff_stack_threshold = math.max(0, ability:GetSpecialValueFor("ability_buff_stack_threshold"))
	self.buffCount = self:CountQualifiedBuffs(parent, ability_buff_stack_threshold)
	self:SetStackCount(self.buffCount)
	self:RefreshAttributes()
end
function modifier_item_0611.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or self.buffCount <= 0 then
		return {}
	end
	return {
		outgoing_damage_pct = self.buffCount * math.max(0, ability:GetSpecialValueFor("ability_value_dmg_per_buff")),
	}
end
function modifier_item_0611.prototype.CountQualifiedBuffs(self, parent, threshold)
	local mods = parent:FindAllModifiers() or {}
	local count = 0
	for ____, m in ipairs(mods) do
		do
			local ____temp_2 = not m
			if not ____temp_2 then
				local ____opt_0 = m.IsNull
				____temp_2 = ____opt_0 and ____opt_0(m)
			end
			if ____temp_2 then
				goto __continue14
			end
			if m:GetName() == ____exports.modifier_item_0611.name then
				goto __continue14
			end
			local anyMod = m
			if anyMod.IsDebuff == nil or anyMod:IsDebuff() then
				goto __continue14
			end
			if anyMod.IsHidden == nil or anyMod:IsHidden() then
				goto __continue14
			end
			if m:GetStackCount() > threshold then
				count = count + 1
			end
		end
		::__continue14::
	end
	return count
end
function modifier_item_0611.prototype.IsHidden(self)
	return false
end
function modifier_item_0611.prototype.IsDebuff(self)
	return false
end
function modifier_item_0611.prototype.IsPurgable(self)
	return false
end
function modifier_item_0611.prototype.GetTexture(self)
	return "item_helm_of_the_overlord"
end
modifier_item_0611 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0611)
____exports.modifier_item_0611 = modifier_item_0611
return ____exports