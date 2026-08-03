--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__StringReplace = ____lualib.__TS__StringReplace
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
			SLError(nil, (("符文特殊值不存在:" .. self:_GetRuneType()) .. " ") .. key)
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
		SLError(nil, "符文配置不存在: " .. rune_type)
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