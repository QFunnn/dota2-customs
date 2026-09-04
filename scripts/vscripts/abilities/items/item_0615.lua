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
local ____item_0614 = require("abilities.items.item_0614")
local AddDebt = ____item_0614.AddDebt
local GetDebt = ____item_0614.GetDebt
local DEBT_CAP = ____item_0614.DEBT_CAP
local THINK_INTERVAL = 0.5
____exports.item_0615 = __TS__Class()
local item_0615 = ____exports.item_0615
item_0615.name = "item_0615"
__TS__ClassExtends(item_0615, BaseItem_CS)
function item_0615.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0615.name
end
item_0615 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0615)
____exports.item_0615 = item_0615
--- 固有被动「高利」：施法记债；满仓停摆魔法增伤（层数=1 表示增伤在线，0=停摆）。
____exports.modifier_item_0615 = __TS__Class()
local modifier_item_0615 = ____exports.modifier_item_0615
modifier_item_0615.name = "modifier_item_0615"
__TS__ClassExtends(modifier_item_0615, BaseModifier_CS)
function modifier_item_0615.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.grantMagicAmp = 0
end
function modifier_item_0615.GetLocalizationCN(self)
	return {
		name = "高利",
		description = "魔法伤害提高；【债】满仓时本增伤停摆，直到偿出空位。",
	}
end
function modifier_item_0615.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0615.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0615.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0615.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or event.caster ~= parent:GetEntityIndex() then
		return
	end
	if event.is_trigger == true then
		return
	end
	local perCast = math.max(1, math.floor(ability:GetSpecialValueFor("ability_debt_per_cast")))
	AddDebt(nil, parent, ability, perCast)
end
function modifier_item_0615.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	local frozen = GetDebt(nil, parent) >= DEBT_CAP
	self.grantMagicAmp = frozen and 0 or math.max(0, ability:GetSpecialValueFor("ability_value_magic_amp_pct"))
	self:SetStackCount(frozen and 0 or 1)
	self:RefreshAttributes()
end
function modifier_item_0615.prototype.GetAttributeBonus(self)
	return { magical_damage_add_pct = self.grantMagicAmp }
end
function modifier_item_0615.prototype.IsHidden(self)
	return false
end
function modifier_item_0615.prototype.IsDebuff(self)
	return false
end
function modifier_item_0615.prototype.IsPurgable(self)
	return false
end
function modifier_item_0615.prototype.GetTexture(self)
	return "item_necronomicon"
end
modifier_item_0615 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0615)
____exports.modifier_item_0615 = modifier_item_0615
return ____exports