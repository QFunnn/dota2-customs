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
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_potion_base = require("abilities.items.potions.item_potion_base")
local BasePotionModifier_CS = ____item_potion_base.BasePotionModifier_CS
____exports.item_P026 = __TS__Class()
local item_P026 = ____exports.item_P026
item_P026.name = "item_P026"
__TS__ClassExtends(item_P026, BaseItem_CS)
function item_P026.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local ability_duration = self:GetSpecialValueFor("ability_duration")
			local ability_health_regen = self:GetSpecialValueFor("potion_health_regen")
			self:ApplyPotionModifier(
				____exports.modifier_item_P026_potion.name,
				ability_duration,
				{ ability_health_regen = ability_health_regen }
			)
			self:PlayEffects1(caster)
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_P026.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
end
item_P026 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P026)
____exports.item_P026 = item_P026
____exports.modifier_item_P026_potion = __TS__Class()
local modifier_item_P026_potion = ____exports.modifier_item_P026_potion
modifier_item_P026_potion.name = "modifier_item_P026_potion"
__TS__ClassExtends(modifier_item_P026_potion, BasePotionModifier_CS)
function modifier_item_P026_potion.prototype.____constructor(self, ...)
	BasePotionModifier_CS.prototype.____constructor(self, ...)
	self.ability_health_regen = 0
end
function modifier_item_P026_potion.GetLocalizationCN(self)
	return { name = "极效恢复药剂", description = "恢复Ⅲ。增加20点生命恢复" }
end
function modifier_item_P026_potion.prototype.OnCreated(self, params)
	BasePotionModifier_CS.prototype.OnCreated(self, params)
	self:RefreshValues(params)
end
function modifier_item_P026_potion.prototype.OnRefresh(self, params)
	self:SetPotionSequence(params and params.ak_potion_sequence)
	self:RefreshValues(params)
end
function modifier_item_P026_potion.prototype.GetAttributeBonus(self)
	return { health_regen = self.ability_health_regen }
end
function modifier_item_P026_potion.prototype.GetTexture(self)
	return "item_P026"
end
function modifier_item_P026_potion.prototype.RefreshValues(self, params)
	self.ability_health_regen = tonumber(params and params.ability_health_regen) or 0
	self:RefreshAttributes()
end
modifier_item_P026_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P026_potion)
____exports.modifier_item_P026_potion = modifier_item_P026_potion
return ____exports