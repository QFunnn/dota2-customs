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
local ITEM_P019_BUFF_DURATION = 160
local ITEM_P019_BASE_STRENGTH_BONUS_PCT = 30
local ITEM_P019_RECALCULATE_INTERVAL = 0.5
____exports.item_P019 = __TS__Class()
local item_P019 = ____exports.item_P019
item_P019.name = "item_P019"
__TS__ClassExtends(item_P019, BaseItem_CS)
function item_P019.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			self:ApplyPotionModifier(____exports.item_P019_modifier.name, ITEM_P019_BUFF_DURATION)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
item_P019 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P019)
____exports.item_P019 = item_P019
____exports.item_P019_modifier = __TS__Class()
local item_P019_modifier = ____exports.item_P019_modifier
item_P019_modifier.name = "item_P019_modifier"
__TS__ClassExtends(item_P019_modifier, BasePotionModifier_CS)
function item_P019_modifier.prototype.____constructor(self, ...)
	BasePotionModifier_CS.prototype.____constructor(self, ...)
	self.bonusBaseStrength = 30
end
function item_P019_modifier.GetLocalizationCN(self)
	return { name = "力量药剂", description = "使用后额外获得30%基础力量，持续120秒。" }
end
function item_P019_modifier.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:UpdateBonusBaseStrength()
	self:StartIntervalThink(ITEM_P019_RECALCULATE_INTERVAL)
end
function item_P019_modifier.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:UpdateBonusBaseStrength()
end
function item_P019_modifier.prototype.GetAttributeBonus(self)
	return { base_strength = self.bonusBaseStrength }
end
function item_P019_modifier.prototype.GetEffectName(self)
	return "particles/generic_gameplay/rune_doubledamage_owner.vpcf"
end
function item_P019_modifier.prototype.GetTexture(self)
	return "item_icon_m5_18"
end
function item_P019_modifier.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function item_P019_modifier.prototype.UpdateBonusBaseStrength(self)
	local parent = self:GetParent()
	if not parent or not parent.IsHero or not parent:IsHero() then
		return
	end
	local baseStrength = parent:GetBaseStrength()
	local nextBonusBaseStrength = baseStrength * (ITEM_P019_BASE_STRENGTH_BONUS_PCT / 100)
	if self.bonusBaseStrength == nextBonusBaseStrength then
		return
	end
	self.bonusBaseStrength = nextBonusBaseStrength
	self:RefreshAttributes()
end
item_P019_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, item_P019_modifier)
____exports.item_P019_modifier = item_P019_modifier
return ____exports