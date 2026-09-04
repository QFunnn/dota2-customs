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
local ITEM_0099_MANA_REGEN_PER_STACK = 0.2
local ITEM_0099_MAX_STACKS = 10
local ITEM_0099_DECAY_INTERVAL = 3
____exports.item_0099 = __TS__Class()
local item_0099 = ____exports.item_0099
item_0099.name = "item_0099"
__TS__ClassExtends(item_0099, BaseItem_CS)
function item_0099.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0099"
end
item_0099 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0099)
____exports.item_0099 = item_0099
____exports.modifier_item_0099 = __TS__Class()
local modifier_item_0099 = ____exports.modifier_item_0099
modifier_item_0099.name = "modifier_item_0099"
__TS__ClassExtends(modifier_item_0099, BaseModifier_CS)
function modifier_item_0099.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_item_0099.prototype.IsHidden(self)
	return true
end
function modifier_item_0099.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	local attacker = event.attacker
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not IsValidAlive(nil, attacker) or attacker:IsBuilding() then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	parent:AddNewModifier(parent, ability, "modifier_item_0099_erosa_ritual", {})
end
modifier_item_0099 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0099)
____exports.modifier_item_0099 = modifier_item_0099
____exports.modifier_item_0099_erosa_ritual = __TS__Class()
local modifier_item_0099_erosa_ritual = ____exports.modifier_item_0099_erosa_ritual
modifier_item_0099_erosa_ritual.name = "modifier_item_0099_erosa_ritual"
__TS__ClassExtends(modifier_item_0099_erosa_ritual, BaseModifier_CS)
function modifier_item_0099_erosa_ritual.GetLocalizationCN(self)
	return {
		name = "埃罗莎仪式",
		description = "受到攻击时获得叠层魔法恢复，每层提供0.2 点/秒魔法恢复，最多10层，并且每3秒衰减1层。",
	}
end
function modifier_item_0099_erosa_ritual.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
	self:StartIntervalThink(ITEM_0099_DECAY_INTERVAL)
end
function modifier_item_0099_erosa_ritual.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(math.min(self:GetStackCount() + 1, ITEM_0099_MAX_STACKS))
	self:RefreshAttributes()
end
function modifier_item_0099_erosa_ritual.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local nextStack = self:GetStackCount() - 1
	if nextStack <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(nextStack)
	self:RefreshAttributes()
end
function modifier_item_0099_erosa_ritual.prototype.GetAttributeBonus(self)
	return { mana_regen = self:GetStackCount() * ITEM_0099_MANA_REGEN_PER_STACK }
end
function modifier_item_0099_erosa_ritual.prototype.IsHidden(self)
	return false
end
function modifier_item_0099_erosa_ritual.prototype.IsDebuff(self)
	return false
end
function modifier_item_0099_erosa_ritual.prototype.IsPurgable(self)
	return false
end
function modifier_item_0099_erosa_ritual.prototype.GetTexture(self)
	return "item_occult_bracelet"
end
modifier_item_0099_erosa_ritual = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0099_erosa_ritual)
____exports.modifier_item_0099_erosa_ritual = modifier_item_0099_erosa_ritual
return ____exports