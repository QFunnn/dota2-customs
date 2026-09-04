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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
____exports.modifier_ak_rune_purification = __TS__Class()
local modifier_ak_rune_purification = ____exports.modifier_ak_rune_purification
modifier_ak_rune_purification.name = "modifier_ak_rune_purification"
__TS__ClassExtends(modifier_ak_rune_purification, BaseModifier_CS)
function modifier_ak_rune_purification.GetLocalizationCN(self)
	return { name = "净化神符", description = "暂时免疫侵蚀效果" }
end
function modifier_ak_rune_purification.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:UpdateRemainingSeconds()
	self:StartIntervalThink(1)
end
function modifier_ak_rune_purification.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:UpdateRemainingSeconds()
	self:StartIntervalThink(1)
end
function modifier_ak_rune_purification.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ____opt_0 = parent.GetPlayerOwnerID
	local playerId = ____opt_0 and ____opt_0(parent)
	local ____temp_4 = playerId == nil or playerId < 0
	if not ____temp_4 then
		local ____opt_2 = MyGameRoomManager:GetPlayerRoom(playerId)
		____temp_4 = (____opt_2 and ____opt_2:GetRoomId()) ~= "M010"
	end
	if ____temp_4 then
		self:Destroy()
		return
	end
	self:UpdateRemainingSeconds()
end
function modifier_ak_rune_purification.prototype.RemoveOnDeath(self)
	return false
end
function modifier_ak_rune_purification.prototype.IsHidden(self)
	return false
end
function modifier_ak_rune_purification.prototype.IsDebuff(self)
	return false
end
function modifier_ak_rune_purification.prototype.IsPurgable(self)
	return false
end
function modifier_ak_rune_purification.prototype.GetTexture(self)
	return "rune_arcane"
end
function modifier_ak_rune_purification.prototype.UpdateRemainingSeconds(self)
	self:SetStackCount(math.max(0, math.ceil(self:GetRemainingTime())))
end
modifier_ak_rune_purification = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_ak_rune_purification)
____exports.modifier_ak_rune_purification = modifier_ak_rune_purification
return ____exports