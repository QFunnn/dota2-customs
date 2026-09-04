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
local ITEM_P049_DURATION = 360
--- 光亮药剂：使用后获得发光效果，持续360秒。
____exports.item_P049 = __TS__Class()
local item_P049 = ____exports.item_P049
item_P049.name = "item_P049"
__TS__ClassExtends(item_P049, BaseItem_CS)
function item_P049.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			self:ApplyPotionModifier(____exports.item_P049_modifier.name, ITEM_P049_DURATION)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
item_P049 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P049)
____exports.item_P049 = item_P049
____exports.item_P049_modifier = __TS__Class()
local item_P049_modifier = ____exports.item_P049_modifier
item_P049_modifier.name = "item_P049_modifier"
__TS__ClassExtends(item_P049_modifier, BasePotionModifier_CS)
function item_P049_modifier.GetLocalizationCN(self)
	return { name = "光亮药剂", description = "使用后身体会发光,持续360秒。" }
end
function item_P049_modifier.prototype.GetAttributeBonus(self)
	return { health_regen = 3 }
end
function item_P049_modifier.prototype.GetTexture(self)
	return "item_icon_m5_28"
end
item_P049_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, item_P049_modifier)
____exports.item_P049_modifier = item_P049_modifier
return ____exports