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
local ____modifier_env_warmth = require("modifiers.env_buff.modifier_env_warmth")
local modifier_env_warmth = ____modifier_env_warmth.modifier_env_warmth
--- 温暖药剂:使用后获得温暖效果,免疫冻伤,并持续恢复少量生命值,持续200秒。
____exports.item_P010 = __TS__Class()
local item_P010 = ____exports.item_P010
item_P010.name = "item_P010"
__TS__ClassExtends(item_P010, BaseItem_CS)
function item_P010.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			self:ApplyPotionModifier(____exports.item_P010_modifier.name, 200)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
item_P010 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P010)
____exports.item_P010 = item_P010
____exports.item_P010_modifier = __TS__Class()
local item_P010_modifier = ____exports.item_P010_modifier
item_P010_modifier.name = "item_P010_modifier"
__TS__ClassExtends(item_P010_modifier, modifier_env_warmth)
function item_P010_modifier.prototype.____constructor(self, ...)
	modifier_env_warmth.prototype.____constructor(self, ...)
	self.potionSequence = 0
end
function item_P010_modifier.GetLocalizationCN(self)
	return { name = "温暖药剂", description = "免疫冻伤，并持续恢复少量生命值。" }
end
function item_P010_modifier.prototype.OnCreated(self, params)
	modifier_env_warmth.prototype.OnCreated(self, params or {})
	if not IsServer() then
		return
	end
	self:SetPotionSequence(params and params.ak_potion_sequence)
end
function item_P010_modifier.prototype.IsPotionModifier(self)
	return true
end
function item_P010_modifier.prototype.SetPotionSequence(self, sequence)
	self.potionSequence = math.max(0, math.floor(tonumber(sequence) or 0))
	self.__ak_potion_sequence = self.potionSequence
end
function item_P010_modifier.prototype.GetPotionSequence(self)
	return self.potionSequence
end
function item_P010_modifier.prototype.GetTexture(self)
	return "item_icon_m5_31"
end
item_P010_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, item_P010_modifier)
____exports.item_P010_modifier = item_P010_modifier
return ____exports