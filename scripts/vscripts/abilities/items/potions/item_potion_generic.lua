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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_potion_base = require("abilities.items.potions.item_potion_base")
local BasePotionModifier_CS = ____item_potion_base.BasePotionModifier_CS
local POTION_VALUE_PREFIX = "potion_"
local DEFAULT_POTION_DURATION = 120
--- 通用药剂：从当前赛季物品表的 `potion_*` Special Value 读取属性，喝下后转成限时药剂 Buff。
____exports.item_potion_generic = __TS__Class()
local item_potion_generic = ____exports.item_potion_generic
item_potion_generic.name = "item_potion_generic"
__TS__ClassExtends(item_potion_generic, BaseItem_CS)
function item_potion_generic.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			local potionDuration = self:GetPotionDuration()
			local potionValues = self:GetPotionModifierParams()
			self:ApplyPotionModifier(
				self:GetPotionModifierName(),
				potionDuration,
				__TS__ObjectAssign({}, potionValues, { potion_source_item = self:GetAbilityName() })
			)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_potion_generic.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_potion_generic.name
end
function item_potion_generic.prototype.GetPotionDuration(self)
	local duration = self:GetSpecialValueFor("ability_duration")
	local ____temp_0
	if duration > 0 then
		____temp_0 = duration
	else
		____temp_0 = DEFAULT_POTION_DURATION
	end
	return ____temp_0
end
function item_potion_generic.prototype.GetPotionModifierParams(self)
	local resolvedValues = MyGameRulesetManager and MyGameRulesetManager:ResolveItemAbilityValues(self:GetName())
	local ____resolvedValues_managed_5
	if resolvedValues and resolvedValues.managed then
		____resolvedValues_managed_5 = resolvedValues.values
	else
		____resolvedValues_managed_5 = self:GetItemKeyValues("AbilityValues")
	end
	local abilityValues = ____resolvedValues_managed_5
	local params = {}
	if not abilityValues then
		return params
	end
	for ____, ____value in ipairs(__TS__ObjectEntries(abilityValues)) do
		local key = ____value[1]
		local value = ____value[2]
		do
			if not __TS__StringStartsWith(key, POTION_VALUE_PREFIX) then
				goto __continue9
			end
			local attributeKey = __TS__StringSubstring(key, #POTION_VALUE_PREFIX)
			local numericValue = tonumber(value) or 0
			params[attributeKey] = numericValue
		end
		::__continue9::
	end
	return params
end
item_potion_generic = __TS__DecorateLegacy({ registerAbility(nil) }, item_potion_generic)
____exports.item_potion_generic = item_potion_generic
____exports.modifier_item_potion_generic = __TS__Class()
local modifier_item_potion_generic = ____exports.modifier_item_potion_generic
modifier_item_potion_generic.name = "modifier_item_potion_generic"
__TS__ClassExtends(modifier_item_potion_generic, BasePotionModifier_CS)
function modifier_item_potion_generic.prototype.____constructor(self, ...)
	BasePotionModifier_CS.prototype.____constructor(self, ...)
	self.attributeBonus = {}
	self.sourceItemName = ""
end
function modifier_item_potion_generic.GetLocalizationCN(self)
	return { name = "药剂效果", description = "药剂提供的临时增益效果。" }
end
function modifier_item_potion_generic.prototype.OnCreated(self, params)
	BasePotionModifier_CS.prototype.OnCreated(self, params)
	self:ApplyParams(params)
end
function modifier_item_potion_generic.prototype.OnRefresh(self, params)
	self:SetPotionSequence(params and params.ak_potion_sequence)
	self:ApplyParams(params)
end
function modifier_item_potion_generic.prototype.GetAttributeBonus(self)
	return self.attributeBonus
end
function modifier_item_potion_generic.prototype.GetTexture(self)
	local sourceItemName = self.sourceItemName
	if sourceItemName ~= "" then
		local rulesetItem = MyGameRulesetManager and MyGameRulesetManager:GetPotionConfig(sourceItemName)
		local ____rulesetItem_12
		if rulesetItem then
			____rulesetItem_12 = rulesetItem.AbilityTextureName
		else
			local ____opt_10 = GetAbilityKeyValuesByName(sourceItemName)
			____rulesetItem_12 = ____opt_10 and ____opt_10.AbilityTextureName
		end
		local textureName = ____rulesetItem_12
		if textureName then
			return tostring(textureName)
		end
		return sourceItemName
	end
	return "item_bottle"
end
function modifier_item_potion_generic.prototype.ApplyParams(self, params)
	self.sourceItemName = tostring(params and params.potion_source_item or "")
	local nextAttributeBonus = {}
	for ____, ____value in ipairs(__TS__ObjectEntries(params or {})) do
		local key = ____value[1]
		local value = ____value[2]
		do
			if key == "ak_potion_sequence" or key == "potion_source_item" then
				goto __continue20
			end
			local numericValue = tonumber(value) or 0
			if numericValue == 0 then
				goto __continue20
			end
			nextAttributeBonus[key] = numericValue
		end
		::__continue20::
	end
	self.attributeBonus = nextAttributeBonus
	self:RefreshAttributes()
end
modifier_item_potion_generic = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_potion_generic)
____exports.modifier_item_potion_generic = modifier_item_potion_generic
____exports.item_P006 = __TS__Class()
local item_P006 = ____exports.item_P006
item_P006.name = "item_P006"
__TS__ClassExtends(item_P006, ____exports.item_potion_generic)
function item_P006.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P006_potion.name
end
item_P006 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P006)
____exports.item_P006 = item_P006
____exports.modifier_item_P006_potion = __TS__Class()
local modifier_item_P006_potion = ____exports.modifier_item_P006_potion
modifier_item_P006_potion.name = "modifier_item_P006_potion"
__TS__ClassExtends(modifier_item_P006_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P006_potion.GetLocalizationCN(self)
	return { name = "防御药剂", description = "固甲。增加护甲值。" }
end
function modifier_item_P006_potion.prototype.GetTexture(self)
	return "item_icon_m5_14"
end
modifier_item_P006_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P006_potion)
____exports.modifier_item_P006_potion = modifier_item_P006_potion
____exports.item_P007 = __TS__Class()
local item_P007 = ____exports.item_P007
item_P007.name = "item_P007"
__TS__ClassExtends(item_P007, ____exports.item_potion_generic)
function item_P007.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P007_potion.name
end
item_P007 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P007)
____exports.item_P007 = item_P007
____exports.modifier_item_P007_potion = __TS__Class()
local modifier_item_P007_potion = ____exports.modifier_item_P007_potion
modifier_item_P007_potion.name = "modifier_item_P007_potion"
__TS__ClassExtends(modifier_item_P007_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P007_potion.GetLocalizationCN(self)
	return { name = "恢复药剂", description = "增加生命恢复。" }
end
function modifier_item_P007_potion.prototype.GetTexture(self)
	return "item_icon_m5_29"
end
modifier_item_P007_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P007_potion)
____exports.modifier_item_P007_potion = modifier_item_P007_potion
____exports.item_P008 = __TS__Class()
local item_P008 = ____exports.item_P008
item_P008.name = "item_P008"
__TS__ClassExtends(item_P008, ____exports.item_potion_generic)
function item_P008.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P008_potion.name
end
item_P008 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P008)
____exports.item_P008 = item_P008
____exports.modifier_item_P008_potion = __TS__Class()
local modifier_item_P008_potion = ____exports.modifier_item_P008_potion
modifier_item_P008_potion.name = "modifier_item_P008_potion"
__TS__ClassExtends(modifier_item_P008_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P008_potion.GetLocalizationCN(self)
	return { name = "迅捷药剂", description = "迅捷。使用后移速增加。" }
end
function modifier_item_P008_potion.prototype.GetTexture(self)
	return "item_icon_m5_27"
end
modifier_item_P008_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P008_potion)
____exports.modifier_item_P008_potion = modifier_item_P008_potion
____exports.item_P009 = __TS__Class()
local item_P009 = ____exports.item_P009
item_P009.name = "item_P009"
__TS__ClassExtends(item_P009, ____exports.item_potion_generic)
function item_P009.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P009_potion.name
end
item_P009 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P009)
____exports.item_P009 = item_P009
____exports.modifier_item_P009_potion = __TS__Class()
local modifier_item_P009_potion = ____exports.modifier_item_P009_potion
modifier_item_P009_potion.name = "modifier_item_P009_potion"
__TS__ClassExtends(modifier_item_P009_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P009_potion.GetLocalizationCN(self)
	return { name = "怒意药剂", description = "怒意。使用后攻击力增加,攻速增加。" }
end
function modifier_item_P009_potion.prototype.GetTexture(self)
	return "item_icon_m5_30"
end
modifier_item_P009_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P009_potion)
____exports.modifier_item_P009_potion = modifier_item_P009_potion
____exports.item_P011 = __TS__Class()
local item_P011 = ____exports.item_P011
item_P011.name = "item_P011"
__TS__ClassExtends(item_P011, ____exports.item_potion_generic)
function item_P011.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P011_potion.name
end
item_P011 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P011)
____exports.item_P011 = item_P011
____exports.modifier_item_P011_potion = __TS__Class()
local modifier_item_P011_potion = ____exports.modifier_item_P011_potion
modifier_item_P011_potion.name = "modifier_item_P011_potion"
__TS__ClassExtends(modifier_item_P011_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P011_potion.GetLocalizationCN(self)
	return { name = "坚毅药剂", description = "坚毅。使用后总生命上限增加。" }
end
function modifier_item_P011_potion.prototype.GetTexture(self)
	return "item_icon_m5_32"
end
modifier_item_P011_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P011_potion)
____exports.modifier_item_P011_potion = modifier_item_P011_potion
____exports.item_P012 = __TS__Class()
local item_P012 = ____exports.item_P012
item_P012.name = "item_P012"
__TS__ClassExtends(item_P012, ____exports.item_potion_generic)
function item_P012.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P012_potion.name
end
item_P012 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P012)
____exports.item_P012 = item_P012
____exports.modifier_item_P012_potion = __TS__Class()
local modifier_item_P012_potion = ____exports.modifier_item_P012_potion
modifier_item_P012_potion.name = "modifier_item_P012_potion"
__TS__ClassExtends(modifier_item_P012_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P012_potion.GetLocalizationCN(self)
	return { name = "奥义药剂", description = "冷静。增加10%冷却缩减,1点法力恢复。" }
end
function modifier_item_P012_potion.prototype.GetTexture(self)
	return "item_icon_m5_22"
end
modifier_item_P012_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P012_potion)
____exports.modifier_item_P012_potion = modifier_item_P012_potion
____exports.item_P014 = __TS__Class()
local item_P014 = ____exports.item_P014
item_P014.name = "item_P014"
__TS__ClassExtends(item_P014, ____exports.item_potion_generic)
function item_P014.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P014_potion.name
end
item_P014 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P014)
____exports.item_P014 = item_P014
____exports.modifier_item_P014_potion = __TS__Class()
local modifier_item_P014_potion = ____exports.modifier_item_P014_potion
modifier_item_P014_potion.name = "modifier_item_P014_potion"
__TS__ClassExtends(modifier_item_P014_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P014_potion.GetLocalizationCN(self)
	return { name = "秘法药剂", description = "秘法。增加20点法力上限,2点法力恢复。" }
end
function modifier_item_P014_potion.prototype.GetTexture(self)
	return "item_icon_m5_24"
end
modifier_item_P014_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P014_potion)
____exports.modifier_item_P014_potion = modifier_item_P014_potion
____exports.item_P015 = __TS__Class()
local item_P015 = ____exports.item_P015
item_P015.name = "item_P015"
__TS__ClassExtends(item_P015, ____exports.item_potion_generic)
function item_P015.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P015_potion.name
end
item_P015 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P015)
____exports.item_P015 = item_P015
____exports.modifier_item_P015_potion = __TS__Class()
local modifier_item_P015_potion = ____exports.modifier_item_P015_potion
modifier_item_P015_potion.name = "modifier_item_P015_potion"
__TS__ClassExtends(modifier_item_P015_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P015_potion.GetLocalizationCN(self)
	return { name = "狂暴药剂", description = "使用后增加攻击速度,暴击率和暴击伤害。" }
end
function modifier_item_P015_potion.prototype.GetTexture(self)
	return "item_icon_m5_21"
end
modifier_item_P015_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P015_potion)
____exports.modifier_item_P015_potion = modifier_item_P015_potion
____exports.item_P016 = __TS__Class()
local item_P016 = ____exports.item_P016
item_P016.name = "item_P016"
__TS__ClassExtends(item_P016, ____exports.item_potion_generic)
function item_P016.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P016_potion.name
end
item_P016 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P016)
____exports.item_P016 = item_P016
____exports.modifier_item_P016_potion = __TS__Class()
local modifier_item_P016_potion = ____exports.modifier_item_P016_potion
modifier_item_P016_potion.name = "modifier_item_P016_potion"
__TS__ClassExtends(modifier_item_P016_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P016_potion.GetLocalizationCN(self)
	return { name = "守护药剂", description = "守护。使用后增加20%伤害减免。" }
end
function modifier_item_P016_potion.prototype.GetTexture(self)
	return "item_icon_m5_17"
end
modifier_item_P016_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P016_potion)
____exports.modifier_item_P016_potion = modifier_item_P016_potion
____exports.item_P018 = __TS__Class()
local item_P018 = ____exports.item_P018
item_P018.name = "item_P018"
__TS__ClassExtends(item_P018, ____exports.item_potion_generic)
function item_P018.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P018_potion.name
end
item_P018 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P018)
____exports.item_P018 = item_P018
____exports.modifier_item_P018_potion = __TS__Class()
local modifier_item_P018_potion = ____exports.modifier_item_P018_potion
modifier_item_P018_potion.name = "modifier_item_P018_potion"
__TS__ClassExtends(modifier_item_P018_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P018_potion.GetLocalizationCN(self)
	return { name = "混沌药剂", description = "混沌。使用后受到伤害增加25%,造成伤害增加30%。" }
end
function modifier_item_P018_potion.prototype.GetTexture(self)
	return "item_icon_m5_20"
end
modifier_item_P018_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P018_potion)
____exports.modifier_item_P018_potion = modifier_item_P018_potion
____exports.item_P020 = __TS__Class()
local item_P020 = ____exports.item_P020
item_P020.name = "item_P020"
__TS__ClassExtends(item_P020, ____exports.item_potion_generic)
function item_P020.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P020_potion.name
end
item_P020 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P020)
____exports.item_P020 = item_P020
____exports.modifier_item_P020_potion = __TS__Class()
local modifier_item_P020_potion = ____exports.modifier_item_P020_potion
modifier_item_P020_potion.name = "modifier_item_P020_potion"
__TS__ClassExtends(modifier_item_P020_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P020_potion.GetLocalizationCN(self)
	return { name = "嗜血药剂", description = "吸血得到了提升。" }
end
function modifier_item_P020_potion.prototype.GetTexture(self)
	return "item_icon_m5_15"
end
modifier_item_P020_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P020_potion)
____exports.modifier_item_P020_potion = modifier_item_P020_potion
____exports.item_P021 = __TS__Class()
local item_P021 = ____exports.item_P021
item_P021.name = "item_P021"
__TS__ClassExtends(item_P021, ____exports.item_potion_generic)
function item_P021.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P021_potion.name
end
item_P021 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P021)
____exports.item_P021 = item_P021
____exports.modifier_item_P021_potion = __TS__Class()
local modifier_item_P021_potion = ____exports.modifier_item_P021_potion
modifier_item_P021_potion.name = "modifier_item_P021_potion"
__TS__ClassExtends(modifier_item_P021_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P021_potion.GetLocalizationCN(self)
	return { name = "魔抗药剂", description = "魔抗。使用后获得魔法抗性,持续一段时间。" }
end
function modifier_item_P021_potion.prototype.GetTexture(self)
	return "item_P021"
end
modifier_item_P021_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P021_potion)
____exports.modifier_item_P021_potion = modifier_item_P021_potion
____exports.item_P022 = __TS__Class()
local item_P022 = ____exports.item_P022
item_P022.name = "item_P022"
__TS__ClassExtends(item_P022, ____exports.item_potion_generic)
function item_P022.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P022_potion.name
end
item_P022 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P022)
____exports.item_P022 = item_P022
____exports.modifier_item_P022_potion = __TS__Class()
local modifier_item_P022_potion = ____exports.modifier_item_P022_potion
modifier_item_P022_potion.name = "modifier_item_P022_potion"
__TS__ClassExtends(modifier_item_P022_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P022_potion.GetLocalizationCN(self)
	return { name = "强效防御药剂", description = "防御Ⅱ。护甲增加10 持续时间120秒" }
end
function modifier_item_P022_potion.prototype.GetTexture(self)
	return "item_P022"
end
modifier_item_P022_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P022_potion)
____exports.modifier_item_P022_potion = modifier_item_P022_potion
____exports.item_P023 = __TS__Class()
local item_P023 = ____exports.item_P023
item_P023.name = "item_P023"
__TS__ClassExtends(item_P023, ____exports.item_potion_generic)
function item_P023.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P023_potion.name
end
item_P023 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P023)
____exports.item_P023 = item_P023
____exports.modifier_item_P023_potion = __TS__Class()
local modifier_item_P023_potion = ____exports.modifier_item_P023_potion
modifier_item_P023_potion.name = "modifier_item_P023_potion"
__TS__ClassExtends(modifier_item_P023_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P023_potion.GetLocalizationCN(self)
	return { name = "极效防御药剂", description = "防御Ⅲ。护甲增加15 持续时间240秒" }
end
function modifier_item_P023_potion.prototype.GetTexture(self)
	return "item_P023"
end
modifier_item_P023_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P023_potion)
____exports.modifier_item_P023_potion = modifier_item_P023_potion
____exports.item_P024 = __TS__Class()
local item_P024 = ____exports.item_P024
item_P024.name = "item_P024"
__TS__ClassExtends(item_P024, ____exports.item_potion_generic)
function item_P024.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P024_potion.name
end
item_P024 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P024)
____exports.item_P024 = item_P024
____exports.modifier_item_P024_potion = __TS__Class()
local modifier_item_P024_potion = ____exports.modifier_item_P024_potion
modifier_item_P024_potion.name = "modifier_item_P024_potion"
__TS__ClassExtends(modifier_item_P024_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P024_potion.GetLocalizationCN(self)
	return { name = "石盾合剂", description = "石盾。护甲增加20%,伤害减免增加15%持续时间600秒" }
end
function modifier_item_P024_potion.prototype.GetTexture(self)
	return "item_P024"
end
modifier_item_P024_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P024_potion)
____exports.modifier_item_P024_potion = modifier_item_P024_potion
____exports.item_P025 = __TS__Class()
local item_P025 = ____exports.item_P025
item_P025.name = "item_P025"
__TS__ClassExtends(item_P025, ____exports.item_potion_generic)
function item_P025.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P025_potion.name
end
item_P025 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P025)
____exports.item_P025 = item_P025
____exports.modifier_item_P025_potion = __TS__Class()
local modifier_item_P025_potion = ____exports.modifier_item_P025_potion
modifier_item_P025_potion.name = "modifier_item_P025_potion"
__TS__ClassExtends(modifier_item_P025_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P025_potion.GetLocalizationCN(self)
	return { name = "强效恢复药剂", description = "恢复Ⅱ。增加10点生命恢复" }
end
function modifier_item_P025_potion.prototype.GetTexture(self)
	return "item_P025"
end
modifier_item_P025_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P025_potion)
____exports.modifier_item_P025_potion = modifier_item_P025_potion
____exports.item_P027 = __TS__Class()
local item_P027 = ____exports.item_P027
item_P027.name = "item_P027"
__TS__ClassExtends(item_P027, ____exports.item_potion_generic)
function item_P027.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P027_potion.name
end
item_P027 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P027)
____exports.item_P027 = item_P027
____exports.modifier_item_P027_potion = __TS__Class()
local modifier_item_P027_potion = ____exports.modifier_item_P027_potion
modifier_item_P027_potion.name = "modifier_item_P027_potion"
__TS__ClassExtends(modifier_item_P027_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P027_potion.GetLocalizationCN(self)
	return { name = "滋养合剂", description = "滋养。每秒恢复2%的生命值,生命值增加500" }
end
function modifier_item_P027_potion.prototype.GetTexture(self)
	return "item_P027"
end
modifier_item_P027_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P027_potion)
____exports.modifier_item_P027_potion = modifier_item_P027_potion
____exports.item_P028 = __TS__Class()
local item_P028 = ____exports.item_P028
item_P028.name = "item_P028"
__TS__ClassExtends(item_P028, ____exports.item_potion_generic)
function item_P028.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P028_potion.name
end
item_P028 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P028)
____exports.item_P028 = item_P028
____exports.modifier_item_P028_potion = __TS__Class()
local modifier_item_P028_potion = ____exports.modifier_item_P028_potion
modifier_item_P028_potion.name = "modifier_item_P028_potion"
__TS__ClassExtends(modifier_item_P028_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P028_potion.GetLocalizationCN(self)
	return { name = "暴怒药剂", description = "暴怒。攻击力增加30点,攻击速度增加40%" }
end
function modifier_item_P028_potion.prototype.GetTexture(self)
	return "item_P028"
end
modifier_item_P028_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P028_potion)
____exports.modifier_item_P028_potion = modifier_item_P028_potion
____exports.item_P029 = __TS__Class()
local item_P029 = ____exports.item_P029
item_P029.name = "item_P029"
__TS__ClassExtends(item_P029, ____exports.item_potion_generic)
function item_P029.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P029_potion.name
end
item_P029 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P029)
____exports.item_P029 = item_P029
____exports.modifier_item_P029_potion = __TS__Class()
local modifier_item_P029_potion = ____exports.modifier_item_P029_potion
modifier_item_P029_potion.name = "modifier_item_P029_potion"
__TS__ClassExtends(modifier_item_P029_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P029_potion.GetLocalizationCN(self)
	return { name = "死斗合剂", description = "死斗。攻击力增加20%,攻击速度增加50%" }
end
function modifier_item_P029_potion.prototype.GetTexture(self)
	return "item_P029"
end
modifier_item_P029_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P029_potion)
____exports.modifier_item_P029_potion = modifier_item_P029_potion
____exports.item_P030 = __TS__Class()
local item_P030 = ____exports.item_P030
item_P030.name = "item_P030"
__TS__ClassExtends(item_P030, ____exports.item_potion_generic)
function item_P030.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P030_potion.name
end
item_P030 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P030)
____exports.item_P030 = item_P030
____exports.modifier_item_P030_potion = __TS__Class()
local modifier_item_P030_potion = ____exports.modifier_item_P030_potion
modifier_item_P030_potion.name = "modifier_item_P030_potion"
__TS__ClassExtends(modifier_item_P030_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P030_potion.GetLocalizationCN(self)
	return { name = "启迪药剂", description = "启迪。获得经验增加5%" }
end
function modifier_item_P030_potion.prototype.GetTexture(self)
	return "item_P030"
end
modifier_item_P030_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P030_potion)
____exports.modifier_item_P030_potion = modifier_item_P030_potion
____exports.item_P031 = __TS__Class()
local item_P031 = ____exports.item_P031
item_P031.name = "item_P031"
__TS__ClassExtends(item_P031, ____exports.item_potion_generic)
function item_P031.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P031_potion.name
end
item_P031 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P031)
____exports.item_P031 = item_P031
____exports.modifier_item_P031_potion = __TS__Class()
local modifier_item_P031_potion = ____exports.modifier_item_P031_potion
modifier_item_P031_potion.name = "modifier_item_P031_potion"
__TS__ClassExtends(modifier_item_P031_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P031_potion.GetLocalizationCN(self)
	return { name = "强效启迪药剂", description = "启迪Ⅱ。获得经验增加10%" }
end
function modifier_item_P031_potion.prototype.GetTexture(self)
	return "item_P031"
end
modifier_item_P031_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P031_potion)
____exports.modifier_item_P031_potion = modifier_item_P031_potion
____exports.item_P032 = __TS__Class()
local item_P032 = ____exports.item_P032
item_P032.name = "item_P032"
__TS__ClassExtends(item_P032, ____exports.item_potion_generic)
function item_P032.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P032_potion.name
end
item_P032 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P032)
____exports.item_P032 = item_P032
____exports.modifier_item_P032_potion = __TS__Class()
local modifier_item_P032_potion = ____exports.modifier_item_P032_potion
modifier_item_P032_potion.name = "modifier_item_P032_potion"
__TS__ClassExtends(modifier_item_P032_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P032_potion.GetLocalizationCN(self)
	return { name = "极效启迪药剂", description = "启迪Ⅲ。获得经验增加15%" }
end
function modifier_item_P032_potion.prototype.GetTexture(self)
	return "item_P032"
end
modifier_item_P032_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P032_potion)
____exports.modifier_item_P032_potion = modifier_item_P032_potion
____exports.item_P033 = __TS__Class()
local item_P033 = ____exports.item_P033
item_P033.name = "item_P033"
__TS__ClassExtends(item_P033, ____exports.item_potion_generic)
function item_P033.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P033_potion.name
end
item_P033 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P033)
____exports.item_P033 = item_P033
____exports.modifier_item_P033_potion = __TS__Class()
local modifier_item_P033_potion = ____exports.modifier_item_P033_potion
modifier_item_P033_potion.name = "modifier_item_P033_potion"
__TS__ClassExtends(modifier_item_P033_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P033_potion.GetLocalizationCN(self)
	return { name = "无尽学识合剂", description = "学识。获得经验增加25%,魔法上限+80" }
end
function modifier_item_P033_potion.prototype.GetTexture(self)
	return "item_P033"
end
modifier_item_P033_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P033_potion)
____exports.modifier_item_P033_potion = modifier_item_P033_potion
____exports.item_P034 = __TS__Class()
local item_P034 = ____exports.item_P034
item_P034.name = "item_P034"
__TS__ClassExtends(item_P034, ____exports.item_potion_generic)
function item_P034.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P034_potion.name
end
item_P034 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P034)
____exports.item_P034 = item_P034
____exports.modifier_item_P034_potion = __TS__Class()
local modifier_item_P034_potion = ____exports.modifier_item_P034_potion
modifier_item_P034_potion.name = "modifier_item_P034_potion"
__TS__ClassExtends(modifier_item_P034_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P034_potion.GetLocalizationCN(self)
	return { name = "法术掌控药剂", description = "法强。增加15%魔法伤害加成" }
end
function modifier_item_P034_potion.prototype.GetTexture(self)
	return "item_P034"
end
modifier_item_P034_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P034_potion)
____exports.modifier_item_P034_potion = modifier_item_P034_potion
____exports.item_P035 = __TS__Class()
local item_P035 = ____exports.item_P035
item_P035.name = "item_P035"
__TS__ClassExtends(item_P035, ____exports.item_potion_generic)
function item_P035.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P035_potion.name
end
item_P035 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P035)
____exports.item_P035 = item_P035
____exports.modifier_item_P035_potion = __TS__Class()
local modifier_item_P035_potion = ____exports.modifier_item_P035_potion
modifier_item_P035_potion.name = "modifier_item_P035_potion"
__TS__ClassExtends(modifier_item_P035_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P035_potion.GetLocalizationCN(self)
	return { name = "强效法术掌控药剂", description = "法强Ⅱ。增加20%魔法伤害加成" }
end
function modifier_item_P035_potion.prototype.GetTexture(self)
	return "item_P035"
end
modifier_item_P035_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P035_potion)
____exports.modifier_item_P035_potion = modifier_item_P035_potion
____exports.item_P036 = __TS__Class()
local item_P036 = ____exports.item_P036
item_P036.name = "item_P036"
__TS__ClassExtends(item_P036, ____exports.item_potion_generic)
function item_P036.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P036_potion.name
end
item_P036 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P036)
____exports.item_P036 = item_P036
____exports.modifier_item_P036_potion = __TS__Class()
local modifier_item_P036_potion = ____exports.modifier_item_P036_potion
modifier_item_P036_potion.name = "modifier_item_P036_potion"
__TS__ClassExtends(modifier_item_P036_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P036_potion.GetLocalizationCN(self)
	return { name = "极效法术掌控药剂", description = "法强Ⅲ。增加25%魔法伤害加成" }
end
function modifier_item_P036_potion.prototype.GetTexture(self)
	return "item_P036"
end
modifier_item_P036_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P036_potion)
____exports.modifier_item_P036_potion = modifier_item_P036_potion
____exports.item_P037 = __TS__Class()
local item_P037 = ____exports.item_P037
item_P037.name = "item_P037"
__TS__ClassExtends(item_P037, ____exports.item_potion_generic)
function item_P037.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P037_potion.name
end
item_P037 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P037)
____exports.item_P037 = item_P037
____exports.modifier_item_P037_potion = __TS__Class()
local modifier_item_P037_potion = ____exports.modifier_item_P037_potion
modifier_item_P037_potion.name = "modifier_item_P037_potion"
__TS__ClassExtends(modifier_item_P037_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P037_potion.GetLocalizationCN(self)
	return { name = "奥术风暴合剂", description = "奥术。增加30%魔法伤害加成,技能暴击增加15%" }
end
function modifier_item_P037_potion.prototype.GetTexture(self)
	return "item_P037"
end
modifier_item_P037_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P037_potion)
____exports.modifier_item_P037_potion = modifier_item_P037_potion
____exports.item_P040 = __TS__Class()
local item_P040 = ____exports.item_P040
item_P040.name = "item_P040"
__TS__ClassExtends(item_P040, ____exports.item_potion_generic)
function item_P040.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P040_potion.name
end
item_P040 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P040)
____exports.item_P040 = item_P040
____exports.modifier_item_P040_potion = __TS__Class()
local modifier_item_P040_potion = ____exports.modifier_item_P040_potion
modifier_item_P040_potion.name = "modifier_item_P040_potion"
__TS__ClassExtends(modifier_item_P040_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P040_potion.GetLocalizationCN(self)
	return { name = "强效迅捷药剂", description = "迅捷Ⅱ。使用后,增加30%移动速度" }
end
function modifier_item_P040_potion.prototype.GetTexture(self)
	return "item_P040"
end
modifier_item_P040_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P040_potion)
____exports.modifier_item_P040_potion = modifier_item_P040_potion
____exports.item_P041 = __TS__Class()
local item_P041 = ____exports.item_P041
item_P041.name = "item_P041"
__TS__ClassExtends(item_P041, ____exports.item_potion_generic)
function item_P041.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P041_potion.name
end
item_P041 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P041)
____exports.item_P041 = item_P041
____exports.modifier_item_P041_potion = __TS__Class()
local modifier_item_P041_potion = ____exports.modifier_item_P041_potion
modifier_item_P041_potion.name = "modifier_item_P041_potion"
__TS__ClassExtends(modifier_item_P041_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P041_potion.GetLocalizationCN(self)
	return { name = "极效迅捷药剂", description = "迅捷Ⅲ。使用后,增加35%移动速度" }
end
function modifier_item_P041_potion.prototype.GetTexture(self)
	return "item_P041"
end
modifier_item_P041_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P041_potion)
____exports.modifier_item_P041_potion = modifier_item_P041_potion
____exports.item_P042 = __TS__Class()
local item_P042 = ____exports.item_P042
item_P042.name = "item_P042"
__TS__ClassExtends(item_P042, ____exports.item_potion_generic)
function item_P042.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P042_potion.name
end
item_P042 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P042)
____exports.item_P042 = item_P042
____exports.modifier_item_P042_potion = __TS__Class()
local modifier_item_P042_potion = ____exports.modifier_item_P042_potion
modifier_item_P042_potion.name = "modifier_item_P042_potion"
__TS__ClassExtends(modifier_item_P042_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P042_potion.GetLocalizationCN(self)
	return {
		name = "风行合剂",
		description = "风行。使用后,增加50%移动速度,闪避增加20%持续600秒",
	}
end
function modifier_item_P042_potion.prototype.GetTexture(self)
	return "item_P042"
end
modifier_item_P042_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P042_potion)
____exports.modifier_item_P042_potion = modifier_item_P042_potion
____exports.item_P043 = __TS__Class()
local item_P043 = ____exports.item_P043
item_P043.name = "item_P043"
__TS__ClassExtends(item_P043, ____exports.item_potion_generic)
function item_P043.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P043_potion.name
end
item_P043 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P043)
____exports.item_P043 = item_P043
____exports.modifier_item_P043_potion = __TS__Class()
local modifier_item_P043_potion = ____exports.modifier_item_P043_potion
modifier_item_P043_potion.name = "modifier_item_P043_potion"
__TS__ClassExtends(modifier_item_P043_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P043_potion.GetLocalizationCN(self)
	return { name = "法力再生药剂", description = "法力再生。使用后增加每秒2点魔法恢复" }
end
function modifier_item_P043_potion.prototype.GetTexture(self)
	return "item_P043"
end
modifier_item_P043_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P043_potion)
____exports.modifier_item_P043_potion = modifier_item_P043_potion
____exports.item_P044 = __TS__Class()
local item_P044 = ____exports.item_P044
item_P044.name = "item_P044"
__TS__ClassExtends(item_P044, ____exports.item_potion_generic)
function item_P044.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P044_potion.name
end
item_P044 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P044)
____exports.item_P044 = item_P044
____exports.modifier_item_P044_potion = __TS__Class()
local modifier_item_P044_potion = ____exports.modifier_item_P044_potion
modifier_item_P044_potion.name = "modifier_item_P044_potion"
__TS__ClassExtends(modifier_item_P044_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P044_potion.GetLocalizationCN(self)
	return { name = "强效法力再生药剂", description = "法力再生Ⅱ。使用后增加每秒5点魔法恢复" }
end
function modifier_item_P044_potion.prototype.GetTexture(self)
	return "item_P044"
end
modifier_item_P044_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P044_potion)
____exports.modifier_item_P044_potion = modifier_item_P044_potion
____exports.item_P045 = __TS__Class()
local item_P045 = ____exports.item_P045
item_P045.name = "item_P045"
__TS__ClassExtends(item_P045, ____exports.item_potion_generic)
function item_P045.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P045_potion.name
end
item_P045 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P045)
____exports.item_P045 = item_P045
____exports.modifier_item_P045_potion = __TS__Class()
local modifier_item_P045_potion = ____exports.modifier_item_P045_potion
modifier_item_P045_potion.name = "modifier_item_P045_potion"
__TS__ClassExtends(modifier_item_P045_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P045_potion.GetLocalizationCN(self)
	return {
		name = "极效法力再生药剂",
		description = "法力再生Ⅲ。使用后增加每秒10点魔法恢复",
	}
end
function modifier_item_P045_potion.prototype.GetTexture(self)
	return "item_P045"
end
modifier_item_P045_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P045_potion)
____exports.modifier_item_P045_potion = modifier_item_P045_potion
____exports.item_P046 = __TS__Class()
local item_P046 = ____exports.item_P046
item_P046.name = "item_P046"
__TS__ClassExtends(item_P046, ____exports.item_potion_generic)
function item_P046.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P046_potion.name
end
item_P046 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P046)
____exports.item_P046 = item_P046
____exports.modifier_item_P046_potion = __TS__Class()
local modifier_item_P046_potion = ____exports.modifier_item_P046_potion
modifier_item_P046_potion.name = "modifier_item_P046_potion"
__TS__ClassExtends(modifier_item_P046_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P046_potion.GetLocalizationCN(self)
	return {
		name = "冥想合剂",
		description = "冥想。使用后增加每秒18点魔法恢复,技能消耗减免15%.持续600秒 {包括血蓝}",
	}
end
function modifier_item_P046_potion.prototype.GetTexture(self)
	return "item_P046"
end
modifier_item_P046_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P046_potion)
____exports.modifier_item_P046_potion = modifier_item_P046_potion
____exports.item_P047 = __TS__Class()
local item_P047 = ____exports.item_P047
item_P047.name = "item_P047"
__TS__ClassExtends(item_P047, ____exports.item_potion_generic)
function item_P047.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P047_potion.name
end
item_P047 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P047)
____exports.item_P047 = item_P047
____exports.modifier_item_P047_potion = __TS__Class()
local modifier_item_P047_potion = ____exports.modifier_item_P047_potion
modifier_item_P047_potion.name = "modifier_item_P047_potion"
__TS__ClassExtends(modifier_item_P047_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P047_potion.GetLocalizationCN(self)
	return { name = "幸运药剂", description = "好运。使用后增加35点幸运值,持续时间120秒" }
end
function modifier_item_P047_potion.prototype.GetTexture(self)
	return "item_P046"
end
modifier_item_P047_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P047_potion)
____exports.modifier_item_P047_potion = modifier_item_P047_potion
____exports.item_P050 = __TS__Class()
local item_P050 = ____exports.item_P050
item_P050.name = "item_P050"
__TS__ClassExtends(item_P050, ____exports.item_potion_generic)
function item_P050.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P050_potion.name
end
item_P050 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P050)
____exports.item_P050 = item_P050
____exports.modifier_item_P050_potion = __TS__Class()
local modifier_item_P050_potion = ____exports.modifier_item_P050_potion
modifier_item_P050_potion.name = "modifier_item_P050_potion"
__TS__ClassExtends(modifier_item_P050_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P050_potion.GetLocalizationCN(self)
	return { name = "攻击药剂", description = "攻击力提升了。" }
end
function modifier_item_P050_potion.prototype.GetTexture(self)
	return "item_icon_m6_10"
end
modifier_item_P050_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P050_potion)
____exports.modifier_item_P050_potion = modifier_item_P050_potion
____exports.item_P055 = __TS__Class()
local item_P055 = ____exports.item_P055
item_P055.name = "item_P055"
__TS__ClassExtends(item_P055, ____exports.item_potion_generic)
function item_P055.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P055_potion.name
end
item_P055 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P055)
____exports.item_P055 = item_P055
____exports.modifier_item_P055_potion = __TS__Class()
local modifier_item_P055_potion = ____exports.modifier_item_P055_potion
modifier_item_P055_potion.name = "modifier_item_P055_potion"
__TS__ClassExtends(modifier_item_P055_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P055_potion.GetLocalizationCN(self)
	return { name = "魔抗药剂", description = "魔抗提升。" }
end
function modifier_item_P055_potion.prototype.GetTexture(self)
	return "item_icon_p055"
end
modifier_item_P055_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P055_potion)
____exports.modifier_item_P055_potion = modifier_item_P055_potion
____exports.item_P056 = __TS__Class()
local item_P056 = ____exports.item_P056
item_P056.name = "item_P056"
__TS__ClassExtends(item_P056, ____exports.item_potion_generic)
function item_P056.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P056_potion.name
end
item_P056 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P056)
____exports.item_P056 = item_P056
____exports.modifier_item_P056_potion = __TS__Class()
local modifier_item_P056_potion = ____exports.modifier_item_P056_potion
modifier_item_P056_potion.name = "modifier_item_P056_potion"
__TS__ClassExtends(modifier_item_P056_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P056_potion.GetLocalizationCN(self)
	return { name = "攻击药剂Ⅱ", description = "攻击力提升。" }
end
function modifier_item_P056_potion.prototype.GetTexture(self)
	return "item_icon_m6_10"
end
modifier_item_P056_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P056_potion)
____exports.modifier_item_P056_potion = modifier_item_P056_potion
____exports.item_P057 = __TS__Class()
local item_P057 = ____exports.item_P057
item_P057.name = "item_P057"
__TS__ClassExtends(item_P057, ____exports.item_potion_generic)
function item_P057.prototype.GetPotionModifierName(self)
	return ____exports.modifier_item_P057_potion.name
end
item_P057 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P057)
____exports.item_P057 = item_P057
____exports.modifier_item_P057_potion = __TS__Class()
local modifier_item_P057_potion = ____exports.modifier_item_P057_potion
modifier_item_P057_potion.name = "modifier_item_P057_potion"
__TS__ClassExtends(modifier_item_P057_potion, ____exports.modifier_item_potion_generic)
function modifier_item_P057_potion.GetLocalizationCN(self)
	return { name = "防御药剂Ⅱ", description = "护甲提升。" }
end
function modifier_item_P057_potion.prototype.GetTexture(self)
	return "item_icon_m5_14"
end
modifier_item_P057_potion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P057_potion)
____exports.modifier_item_P057_potion = modifier_item_P057_potion
return ____exports