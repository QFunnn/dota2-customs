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
local ____dynamic_precache = require("shared.dynamic_precache")
local AK_DYNAMIC_PRECACHE_ITEM_NAME = ____dynamic_precache.AK_DYNAMIC_PRECACHE_ITEM_NAME
local ResolveDynamicPrecacheResourceType = ____dynamic_precache.ResolveDynamicPrecacheResourceType
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
--- 动态预载壳不具备游戏效果，只把管理器为当前批次准备好的资源交给引擎。
-- 全局资源数组只允许由 DynamicPrecacheManager 在发起单个批次前替换。
____exports.ak_dynamic_precache = __TS__Class()
local ak_dynamic_precache = ____exports.ak_dynamic_precache
ak_dynamic_precache.name = "ak_dynamic_precache"
__TS__ClassExtends(ak_dynamic_precache, BaseItem_CS)
function ak_dynamic_precache.prototype.Precache(self, context)
	local resources = MyGameDynamicPrecacheResources or {}
	for ____, resource in ipairs(resources) do
		do
			local resourceType = ResolveDynamicPrecacheResourceType(nil, resource)
			if not resourceType then
				goto __continue3
			end
			PrecacheResource(resourceType, resource, context)
		end
		::__continue3::
	end
end
ak_dynamic_precache = __TS__DecorateLegacy({ registerAbility(nil, AK_DYNAMIC_PRECACHE_ITEM_NAME) }, ak_dynamic_precache)
____exports.ak_dynamic_precache = ak_dynamic_precache
return ____exports