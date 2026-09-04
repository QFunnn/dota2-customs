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
--- 洞窟英雄复活保护：独立于位移等通用减伤，避免同名 Buff 刷新缩短保护时间。
____exports.modifier_greed_cave_hero_revive_protection = __TS__Class()
local modifier_greed_cave_hero_revive_protection = ____exports.modifier_greed_cave_hero_revive_protection
modifier_greed_cave_hero_revive_protection.name = "modifier_greed_cave_hero_revive_protection"
__TS__ClassExtends(modifier_greed_cave_hero_revive_protection, BaseModifier_CS)
function modifier_greed_cave_hero_revive_protection.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.damageReductionPct = 0
end
function modifier_greed_cave_hero_revive_protection.prototype.OnCreated(self, params)
	self:RefreshDamageReductionPct(params)
end
function modifier_greed_cave_hero_revive_protection.prototype.OnRefresh(self, params)
	self:RefreshDamageReductionPct(params)
end
function modifier_greed_cave_hero_revive_protection.prototype.GetAttributeBonus(self)
	return { damage_reduction_pct = self.damageReductionPct }
end
function modifier_greed_cave_hero_revive_protection.prototype.IsHidden(self)
	return true
end
function modifier_greed_cave_hero_revive_protection.prototype.IsPurgable(self)
	return false
end
function modifier_greed_cave_hero_revive_protection.prototype.RefreshDamageReductionPct(self, params)
	self.damageReductionPct = math.max(0, tonumber(params and params.damage_reduction_pct) or 0)
	self:RefreshAttributes()
end
modifier_greed_cave_hero_revive_protection =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_greed_cave_hero_revive_protection)
____exports.modifier_greed_cave_hero_revive_protection = modifier_greed_cave_hero_revive_protection
return ____exports