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
local ____exports = {}
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 药剂 Buff 基类：记录施加顺序，用于超上限时移除最早生效的药剂。
____exports.BasePotionModifier_CS = __TS__Class()
local BasePotionModifier_CS = ____exports.BasePotionModifier_CS
BasePotionModifier_CS.name = "BasePotionModifier_CS"
__TS__ClassExtends(BasePotionModifier_CS, BaseModifier_CS)
function BasePotionModifier_CS.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.potionSequence = 0
end
function BasePotionModifier_CS.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetPotionSequence(params and params.ak_potion_sequence)
end
function BasePotionModifier_CS.prototype.IsPotionModifier(self)
	return true
end
function BasePotionModifier_CS.prototype.SetPotionSequence(self, sequence)
	self.potionSequence = math.max(0, math.floor(tonumber(sequence) or 0))
	self.__ak_potion_sequence = self.potionSequence
end
function BasePotionModifier_CS.prototype.GetPotionSequence(self)
	return self.potionSequence
end
return ____exports