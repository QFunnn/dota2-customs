--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local ____exports = {}
local isTruthyNumber, normalizeKvString, getItemKv, getRulesetPetItemRows, getPetItemSourceValue, BASE_PET_ITEM_ROWS
local AKGems = require("json.ak_gems")
local AKItems = require("json.ak_items")
local AKItemsEquip = require("json.ak_items_equip")
local AKItemsFormula = require("json.ak_items_formula")
local AKItemsPotion = require("json.ak_items_potion")
function isTruthyNumber(self, value)
	return (tonumber(value) or 0) > 0
end
function normalizeKvString(self, value)
	if value == nil or value == nil then
		return nil
	end
	local text = tostring(value)
	local ____temp_0
	if text == "" then
		____temp_0 = nil
	else
		____temp_0 = text
	end
	return ____temp_0
end
function getItemKv(self, itemName)
	if not itemName then
		return {}
	end
	return GetAbilityKeyValuesByName(itemName) or {}
end
function getRulesetPetItemRows(self)
	local ____temp_1
	if type(MyGameRulesetManager) ~= "nil" then
		____temp_1 = MyGameRulesetManager
	else
		____temp_1 = nil
	end
	local rulesetManager = ____temp_1
	return rulesetManager and rulesetManager:GetTable("ak_items_equip")
end
function getPetItemSourceValue(self, itemName, key)
	if not itemName then
		return nil
	end
	local ____opt_6 = getRulesetPetItemRows(nil)
	local ____opt_4 = ____opt_6 and ____opt_6[itemName]
	local rulesetValue = ____opt_4 and ____opt_4[key]
	if rulesetValue ~= nil then
		return rulesetValue
	end
	local kvValue = getItemKv(nil, itemName)[key]
	if kvValue ~= nil then
		return kvValue
	end
	local ____opt_8 = BASE_PET_ITEM_ROWS[itemName]
	return ____opt_8 and ____opt_8[key]
end
function ____exports.GetPetUnitNameByItemName(self, itemName)
	return normalizeKvString(nil, getPetItemSourceValue(nil, itemName, "PetUnitName"))
end
function ____exports.GetPetIdByItemName(self, itemName)
	return ____exports.GetPetUnitNameByItemName(nil, itemName)
end
function ____exports.IsPetItemName(self, itemName)
	return isTruthyNumber(nil, getPetItemSourceValue(nil, itemName, "IsPet"))
end
BASE_PET_ITEM_ROWS = AKItemsEquip or {}
local ILLUSTRATED_ITEM_ROWS =
	__TS__ObjectAssign({}, AKItems or {}, AKItemsPotion or {}, AKItemsEquip or {}, AKItemsFormula or {}, AKGems or {})
local function getPetItemRows(self)
	return getRulesetPetItemRows(nil) or BASE_PET_ITEM_ROWS
end
____exports.PET_BASIC_PICKUP_FILTER_UNLOCK_QUALITY = 4
____exports.PET_ADVANCED_UNLOCK_QUALITY = 6
____exports.PET_PICKUP_FULL_LIST_UNLOCK_QUALITY = 6
____exports.PET_PICKUP_BASIC_LIST_LIMIT = 3
____exports.PET_PICKUP_WHITELIST_LIMIT = 10
____exports.PET_PICKUP_BLACKLIST_LIMIT = 10
____exports.PET_PICKUP_LEVEL_LIST = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
}
____exports.PET_PICKUP_MAX_LEVEL = ____exports.PET_PICKUP_LEVEL_LIST[#____exports.PET_PICKUP_LEVEL_LIST]
____exports.PET_PICKUP_LEGACY_MAX_LEVEL = 7
____exports.PET_PICKUP_QUALITY_LIST = {
	1,
	2,
	3,
	4,
	5,
	6,
}
____exports.PET_PICKUP_MAX_QUALITY = ____exports.PET_PICKUP_QUALITY_LIST[#____exports.PET_PICKUP_QUALITY_LIST]
____exports.PET_PICKUP_TYPE_LIST = {
	"material",
	"equip",
	"gem",
	"blueprint",
	"potion",
	"other",
}
____exports.PET_PICKUP_PRESET_LIST = {
	"all",
	"growth",
	"valuable",
	"materials_blueprints",
	"custom",
}
____exports.PET_PICKUP_PRESET_CONFIG = {
	all = {
		types = { unpack(____exports.PET_PICKUP_TYPE_LIST) },
		levels = { unpack(____exports.PET_PICKUP_LEVEL_LIST) },
		qualities = { unpack(____exports.PET_PICKUP_QUALITY_LIST) },
	},
	growth = {
		types = { "material", "gem", "blueprint", "potion" },
		levels = { unpack(____exports.PET_PICKUP_LEVEL_LIST) },
		qualities = { unpack(____exports.PET_PICKUP_QUALITY_LIST) },
	},
	valuable = {
		types = { "equip", "gem", "blueprint", "material" },
		levels = { unpack(____exports.PET_PICKUP_LEVEL_LIST) },
		qualities = { 4, 5, 6 },
	},
	materials_blueprints = {
		types = { "material", "blueprint" },
		levels = { unpack(____exports.PET_PICKUP_LEVEL_LIST) },
		qualities = { unpack(____exports.PET_PICKUP_QUALITY_LIST) },
	},
}
____exports.PET_PICKUP_QUALITY_NAME_MAP = {
	[1] = "普通",
	[2] = "精良",
	[3] = "稀有",
	[4] = "史诗",
	[5] = "传说",
	[6] = "神话",
}
function ____exports.GetDefaultPetAutoPickupSettings(self)
	return {
		enabled = true,
		levels = { unpack(____exports.PET_PICKUP_LEVEL_LIST) },
		qualities = { unpack(____exports.PET_PICKUP_QUALITY_LIST) },
		types = { unpack(____exports.PET_PICKUP_TYPE_LIST) },
		preset = "all",
		whitelist = {},
		blacklist = {},
	}
end
function ____exports.GetAllPetIds(self)
	local petIds = {}
	for ____, itemName in ipairs(__TS__ObjectKeys(getPetItemRows(nil))) do
		do
			if not ____exports.IsPetItemName(nil, itemName) then
				goto __continue16
			end
			local petId = ____exports.GetPetIdByItemName(nil, itemName)
			if petId and not __TS__ArrayIncludes(petIds, petId) then
				petIds[#petIds + 1] = petId
			end
		end
		::__continue16::
	end
	return petIds
end
function ____exports.GetPetItemNameByPetId(self, petId)
	if not petId then
		return nil
	end
	if ____exports.IsPetItemName(nil, petId) then
		return petId
	end
	for ____, itemName in ipairs(__TS__ObjectKeys(getPetItemRows(nil))) do
		do
			if not ____exports.IsPetItemName(nil, itemName) then
				goto __continue24
			end
			if ____exports.GetPetUnitNameByItemName(nil, itemName) == petId then
				return itemName
			end
		end
		::__continue24::
	end
	return nil
end
function ____exports.IsPetPickupPreset(self, value)
	if not value then
		return false
	end
	return __TS__ArrayIncludes(____exports.PET_PICKUP_PRESET_LIST, value)
end
function ____exports.IsPetPickupListType(self, value)
	return value == "whitelist" or value == "blacklist"
end
function ____exports.IsPetPickupListAction(self, value)
	return value == "toggle" or value == "remove"
end
function ____exports.GetPetPickupPresetConfig(self, preset)
	if not preset or preset == "custom" then
		return nil
	end
	return ____exports.PET_PICKUP_PRESET_CONFIG[preset]
end
local function clampPickupFilterValue(self, value, maxValue)
	local ____temp_10
	if value > maxValue then
		____temp_10 = maxValue
	else
		____temp_10 = value
	end
	return ____temp_10
end
local function pickupFilterListIncludes(self, list, value)
	for ____, item in ipairs(list) do
		if item == value then
			return true
		end
	end
	return false
end
--- 等级 / 品质是否通过玩家勾选。
-- 仅当物品超出筛选项系统上限时才封顶到上限，避免 10 级或品质 7 永远捡不到；
-- 不会按玩家已选最大值往下压，否则没勾选的更高品质会被误捡。
function ____exports.MatchPetPickupBasicFilter(self, level, quality, settings)
	local matchedLevel = clampPickupFilterValue(nil, level, ____exports.PET_PICKUP_MAX_LEVEL)
	if not pickupFilterListIncludes(nil, settings.levels, matchedLevel) then
		return false
	end
	local matchedQuality = clampPickupFilterValue(nil, quality, ____exports.PET_PICKUP_MAX_QUALITY)
	if not pickupFilterListIncludes(nil, settings.qualities, matchedQuality) then
		return false
	end
	return true
end
--- 从存档解析允许拾取的等级。旧存档没有 8/9 时，跟随当时 7 级是否开启。
function ____exports.ResolvePetPickupSavedLevels(self, rawLevels)
	if not rawLevels then
		return { unpack(____exports.PET_PICKUP_LEVEL_LIST) }
	end
	local legacyMaxEnabled = (tonumber(rawLevels[tostring(____exports.PET_PICKUP_LEGACY_MAX_LEVEL)] or 0) or 0) > 0
	local allowed = {}
	for ____, level in ipairs(____exports.PET_PICKUP_LEVEL_LIST) do
		do
			local raw = rawLevels[tostring(level)]
			if raw ~= nil then
				if (tonumber(raw) or 0) > 0 then
					allowed[#allowed + 1] = level
				end
				goto __continue45
			end
			if level > ____exports.PET_PICKUP_LEGACY_MAX_LEVEL and legacyMaxEnabled then
				allowed[#allowed + 1] = level
			end
		end
		::__continue45::
	end
	return allowed
end
function ____exports.GetPetItemLevelByName(self, itemName)
	local ____tonumber_13 = tonumber
	local ____getPetItemSourceValue_result_11 = getPetItemSourceValue(nil, itemName, "Level")
	if ____getPetItemSourceValue_result_11 == nil then
		____getPetItemSourceValue_result_11 = getPetItemSourceValue(nil, itemName, "ItemLevel")
	end
	local ____getPetItemSourceValue_result_11_12 = ____getPetItemSourceValue_result_11
	if ____getPetItemSourceValue_result_11_12 == nil then
		____getPetItemSourceValue_result_11_12 = 0
	end
	local rawLevel = ____tonumber_13(____getPetItemSourceValue_result_11_12)
	local ____temp_14
	if __TS__NumberIsFinite(__TS__Number(rawLevel)) and rawLevel > 0 then
		____temp_14 = math.floor(rawLevel)
	else
		____temp_14 = 0
	end
	return ____temp_14
end
function ____exports.GetPetItemQualityByName(self, itemName)
	local ____tonumber_16 = tonumber
	local ____getPetItemSourceValue_result_15 = getPetItemSourceValue(nil, itemName, "ItemQuality")
	if ____getPetItemSourceValue_result_15 == nil then
		____getPetItemSourceValue_result_15 = 0
	end
	local rawQuality = ____tonumber_16(____getPetItemSourceValue_result_15)
	local ____temp_17
	if __TS__NumberIsFinite(__TS__Number(rawQuality)) and rawQuality > 0 then
		____temp_17 = math.floor(rawQuality)
	else
		____temp_17 = 0
	end
	return ____temp_17
end
function ____exports.IsPetItemAdvancedUnlocked(self, itemName)
	local itemQuality = ____exports.GetPetItemQualityByName(nil, itemName)
	return itemQuality >= ____exports.PET_ADVANCED_UNLOCK_QUALITY
end
function ____exports.IsPetBasicPickupFilterUnlocked(self, itemName)
	local itemQuality = ____exports.GetPetItemQualityByName(nil, itemName)
	return itemQuality >= ____exports.PET_BASIC_PICKUP_FILTER_UNLOCK_QUALITY
end
function ____exports.IsPetPickupListUnlocked(self, itemName)
	local itemQuality = ____exports.GetPetItemQualityByName(nil, itemName)
	return itemQuality > 0
end
--- 根据当前出战宠物品质返回图鉴拾取名单容量；神话以下宠物每个名单最多 3 项。
function ____exports.GetPetPickupListLimit(self, itemName)
	local itemQuality = ____exports.GetPetItemQualityByName(nil, itemName)
	return itemQuality >= ____exports.PET_PICKUP_FULL_LIST_UNLOCK_QUALITY and ____exports.PET_PICKUP_WHITELIST_LIMIT
		or ____exports.PET_PICKUP_BASIC_LIST_LIMIT
end
function ____exports.IsIllustratedPickupListItemName(self, itemName)
	if not itemName then
		return false
	end
	local row = ILLUSTRATED_ITEM_ROWS[itemName]
	if not row then
		return false
	end
	return (tonumber(row.hide) or 0) ~= 1
end
return ____exports