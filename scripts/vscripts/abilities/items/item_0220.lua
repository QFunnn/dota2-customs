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
____exports.item_0220 = __TS__Class()
local item_0220 = ____exports.item_0220
item_0220.name = "item_0220"
__TS__ClassExtends(item_0220, BaseItem_CS)
function item_0220.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0220_wingbeat_listener.name
end
item_0220 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0220)
____exports.item_0220 = item_0220
____exports.modifier_item_0220_wingbeat_listener = __TS__Class()
local modifier_item_0220_wingbeat_listener = ____exports.modifier_item_0220_wingbeat_listener
modifier_item_0220_wingbeat_listener.name = "modifier_item_0220_wingbeat_listener"
__TS__ClassExtends(modifier_item_0220_wingbeat_listener, BaseModifier_CS)
function modifier_item_0220_wingbeat_listener.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_MISS }
end
function modifier_item_0220_wingbeat_listener.prototype.OnTakeAttackMiss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.target ~= parent or event.is_miss ~= true then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local buff = parent:FindModifierByName(____exports.modifier_item_0220_wingbeat_buff.name)
		or parent:AddNewModifier(parent, ability, ____exports.modifier_item_0220_wingbeat_buff.name, { duration = -1 })
	if not buff then
		return
	end
	buff:AddWingbeatStack()
	self:PlayEffects1(parent)
end
function modifier_item_0220_wingbeat_listener.prototype.IsHidden(self)
	return true
end
function modifier_item_0220_wingbeat_listener.prototype.IsPurgable(self)
	return false
end
function modifier_item_0220_wingbeat_listener.prototype.PlayEffects1(self, parent)
	parent:EmitSound("DOTA_Item.Butterfly")
end
modifier_item_0220_wingbeat_listener =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0220_wingbeat_listener)
____exports.modifier_item_0220_wingbeat_listener = modifier_item_0220_wingbeat_listener
____exports.modifier_item_0220_wingbeat_buff = __TS__Class()
local modifier_item_0220_wingbeat_buff = ____exports.modifier_item_0220_wingbeat_buff
modifier_item_0220_wingbeat_buff.name = "modifier_item_0220_wingbeat_buff"
__TS__ClassExtends(modifier_item_0220_wingbeat_buff, BaseModifier_CS)
function modifier_item_0220_wingbeat_buff.GetLocalizationCN(self)
	return { name = "振翅", description = "全域暴击率提高，层数会随时间流逝。" }
end
function modifier_item_0220_wingbeat_buff.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self:RefreshAttributes()
	self:StartDecay()
end
function modifier_item_0220_wingbeat_buff.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:StartDecay()
end
function modifier_item_0220_wingbeat_buff.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local nextStacks = self:GetStackCount() - 1
	if nextStacks <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
function modifier_item_0220_wingbeat_buff.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0220_wingbeat_buff.prototype.AddWingbeatStack(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local ability_value_max_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_max_stacks")))
	local nextStacks = math.min(self:GetStackCount() + 1, ability_value_max_stacks)
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
	self:StartDecay()
end
function modifier_item_0220_wingbeat_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local ability_value_omni_crit_chance_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_omni_crit_chance_pct"))
	return { omni_crit_chance_pct = self:GetStackCount() * ability_value_omni_crit_chance_pct }
end
function modifier_item_0220_wingbeat_buff.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0220_wingbeat_buff.prototype.IsDebuff(self)
	return false
end
function modifier_item_0220_wingbeat_buff.prototype.IsPurgable(self)
	return false
end
function modifier_item_0220_wingbeat_buff.prototype.GetTexture(self)
	return "item_butterfly"
end
function modifier_item_0220_wingbeat_buff.prototype.StartDecay(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local ability_decay_interval = math.max(0.1, ability:GetSpecialValueFor("ability_decay_interval"))
	self:StartIntervalThink(ability_decay_interval)
end
modifier_item_0220_wingbeat_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0220_wingbeat_buff)
____exports.modifier_item_0220_wingbeat_buff = modifier_item_0220_wingbeat_buff
return ____exports