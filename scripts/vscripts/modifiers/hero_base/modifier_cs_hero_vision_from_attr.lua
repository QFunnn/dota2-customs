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
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
--- 将属性系统 view_distance 同步为引擎昼夜固定视野。
-- 数值经 SetStackCount 写入，昼夜回调只读堆叠，便于客户端与刷新路径一致。
____exports.modifier_cs_hero_vision_from_attr = __TS__Class()
local modifier_cs_hero_vision_from_attr = ____exports.modifier_cs_hero_vision_from_attr
modifier_cs_hero_vision_from_attr.name = "modifier_cs_hero_vision_from_attr"
__TS__ClassExtends(modifier_cs_hero_vision_from_attr, BaseModifier)
function modifier_cs_hero_vision_from_attr.prototype.IsHidden(self)
	return true
end
function modifier_cs_hero_vision_from_attr.prototype.IsPurgable(self)
	return false
end
function modifier_cs_hero_vision_from_attr.prototype.IsPermanent(self)
	return true
end
function modifier_cs_hero_vision_from_attr.prototype.RemoveOnDeath(self)
	return false
end
function modifier_cs_hero_vision_from_attr.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_FIXED_DAY_VISION, MODIFIER_PROPERTY_FIXED_NIGHT_VISION }
end
function modifier_cs_hero_vision_from_attr.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SyncStackFromAttribute()
	self._unregisterViewDistance = MyGameAttribute:RegisterAttributeChangeHandler("view_distance", function(____, unit)
		if unit == self:GetParent() then
			self:SyncStackFromAttribute()
			self:SendBuffRefreshToClients()
		end
	end)
end
function modifier_cs_hero_vision_from_attr.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local ____opt_0 = self._unregisterViewDistance
	if ____opt_0 ~= nil then
		____opt_0(self)
	end
	self._unregisterViewDistance = nil
end
function modifier_cs_hero_vision_from_attr.prototype.GetFixedDayVision(self)
	return self:GetStackCount()
end
function modifier_cs_hero_vision_from_attr.prototype.GetFixedNightVision(self)
	return self:GetStackCount()
end
function modifier_cs_hero_vision_from_attr.prototype.SyncStackFromAttribute(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local v = MyGameAttribute:GetAttribute(parent, "view_distance") or 0
	self:SetStackCount(math.floor(v))
end
modifier_cs_hero_vision_from_attr = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_cs_hero_vision_from_attr") },
	modifier_cs_hero_vision_from_attr
)
____exports.modifier_cs_hero_vision_from_attr = modifier_cs_hero_vision_from_attr
return ____exports