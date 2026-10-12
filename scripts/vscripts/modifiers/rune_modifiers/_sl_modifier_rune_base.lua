--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/_sl_modifier_rune_base.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__StringReplace = ____lualib.__TS__StringReplace
____debugRuntime.register(
	"modifiers/rune_modifiers/_sl_modifier_rune_base.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:23",
		["14"] = "3:1",
		["15"] = "3:45",
		["17"] = "3:53",
		["18"] = "17:5",
		["19"] = "18:9",
		["20"] = "19:9",
		["21"] = "20:9",
		["22"] = "17:96",
		["23"] = "23:5",
		["24"] = "3:1",
		["25"] = "4:5",
		["26"] = "5:9",
		["27"] = "4:5",
		["28"] = "8:5",
		["29"] = "9:15",
		["30"] = "10:9",
		["31"] = "8:5",
		["32"] = "13:5",
		["33"] = "14:9",
		["34"] = "14:16",
		["35"] = "14:39",
		["36"] = "14:55",
		["37"] = "14:16",
		["38"] = "13:5",
		["39"] = "35:5",
		["40"] = "46:9",
		["41"] = "46:9",
		["42"] = "46:9",
		["44"] = "60:15",
		["45"] = "61:15",
		["46"] = "62:15",
		["47"] = "63:15",
		["48"] = "63:30",
		["49"] = "63:40",
		["50"] = "63:30",
		["51"] = "64:13",
		["52"] = "65:13",
		["53"] = "66:13",
		["55"] = "68:9",
		["56"] = "35:5",
		["57"] = "74:5",
		["58"] = "75:14",
		["59"] = "75:36",
		["61"] = "76:14",
		["62"] = "77:17",
		["63"] = "78:17",
		["64"] = "78:25",
		["65"] = "78:17",
		["67"] = "78:17",
		["69"] = "80:13",
		["71"] = "82:9",
		["72"] = "74:5",
		["73"] = "85:5",
		["74"] = "86:9",
		["75"] = "87:9",
		["76"] = "85:5",
		["77"] = "90:5",
		["78"] = "91:9",
		["79"] = "90:5",
		["80"] = "94:5",
		["81"] = "95:14",
		["84"] = "96:15",
		["85"] = "97:15",
		["86"] = "98:30",
		["87"] = "98:30",
		["88"] = "98:30",
		["90"] = "98:15",
		["91"] = "99:14",
		["92"] = "100:13",
		["95"] = "103:9",
		["96"] = "104:9",
		["97"] = "94:5",
		["98"] = "107:5",
		["99"] = "108:9",
		["100"] = "107:5",
		["101"] = "111:5",
		["102"] = "112:9",
		["103"] = "111:5",
	}
)
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_rune_base = __TS__Class()
local sl_modifier_rune_base = ____exports.sl_modifier_rune_base
sl_modifier_rune_base.name = "sl_modifier_rune_base"
__TS__ClassExtends(sl_modifier_rune_base, SLModifierBase)
function sl_modifier_rune_base.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._attr_get_func = {
		[DOTA_ATTRIBUTE_STRENGTH] = function(____, hero)
			return hero:GetStrength()
		end,
		[DOTA_ATTRIBUTE_AGILITY] = function(____, hero)
			return hero:GetAgility()
		end,
		[DOTA_ATTRIBUTE_INTELLECT] = function(____, hero)
			return hero:GetIntellect(false)
		end,
	}
	self._attr_cached_record = {}
end
function sl_modifier_rune_base.prototype.IsHidden(self)
	return false
end
function sl_modifier_rune_base.prototype.GetTexture(self)
	local rune_type = self:_GetRuneType()
	return "buff/" .. rune_type
end
function sl_modifier_rune_base.prototype._GetRuneType(self)
	return __TS__StringReplace(self:GetName(), "sl_modifier_", "")
end
function sl_modifier_rune_base.prototype._CheckAndGetCachedAttrReleatedValue(
	self,
	____type,
	releated_data_key,
	recalculate_data_value
)
	local ____self__attr_cached_record_0, ____releated_data_key_1 = self._attr_cached_record, releated_data_key
	if ____self__attr_cached_record_0[____releated_data_key_1] == nil then
		____self__attr_cached_record_0[____releated_data_key_1] = {
			[DOTA_ATTRIBUTE_STRENGTH] = { attr = 0, cached_value = 0 },
			[DOTA_ATTRIBUTE_AGILITY] = { attr = 0, cached_value = 0 },
			[DOTA_ATTRIBUTE_INTELLECT] = { attr = 0, cached_value = 0 },
		}
	end
	local releated_data = self._attr_cached_record[releated_data_key]
	local attr_func = self._attr_get_func[____type]
	local data = releated_data[____type]
	local current_attr = attr_func(nil, self:GetParent())
	if data.attr ~= current_attr then
		data.attr = current_attr
		data.cached_value = recalculate_data_value(nil, current_attr)
	end
	return data.cached_value
end
function sl_modifier_rune_base.prototype._GetRuneSpecialValue(self, key)
	if not self._special_values then
		return 0
	end
	if not self._special_values[key] then
		if IsServer() then
			SLError(
				(("符文特殊值不存在:" .. self:_GetRuneType()) .. " ") .. key,
				nil,
				"modifiers/rune_modifiers/_sl_modifier_rune_base.ts:78:17"
			)
		end
		return 0
	end
	return self._special_values[key]
end
function sl_modifier_rune_base.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_SyncSettingData()
end
function sl_modifier_rune_base.prototype.OnRefresh(self, params)
	self:_SyncSettingData()
end
function sl_modifier_rune_base.prototype._SyncSettingData(self)
	if not IsServer() then
		return
	end
	local setting = HTTP.setting:GetServerSet("customRune")
	local rune_type = self:_GetRuneType()
	local ____setting_rune_type_2 = setting
	if ____setting_rune_type_2 ~= nil then
		____setting_rune_type_2 = ____setting_rune_type_2[rune_type]
	end
	local rune_setting = ____setting_rune_type_2
	if not rune_setting then
		SLError(
			"符文配置不存在: " .. rune_type,
			nil,
			"modifiers/rune_modifiers/_sl_modifier_rune_base.ts:100:13"
		)
		return
	end
	self._special_values = rune_setting.special_values
	self:SendBuffRefreshToClients()
end
function sl_modifier_rune_base.prototype.AddCustomTransmitterData(self)
	return self._special_values
end
function sl_modifier_rune_base.prototype.HandleCustomTransmitterData(self, data)
	self._special_values = data
end
return ____exports