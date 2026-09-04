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
--- Boss 全局位置暴露：父单位在战争迷雾中向敌方队伍持续提供位置信息（类 Roshan 小地图/迷雾可见）。
-- 与 `modifier_breakable_container` 中 FOW 部分一致，无额外状态。
____exports.modifier_cs_boss_fow_reveal = __TS__Class()
local modifier_cs_boss_fow_reveal = ____exports.modifier_cs_boss_fow_reveal
modifier_cs_boss_fow_reveal.name = "modifier_cs_boss_fow_reveal"
__TS__ClassExtends(modifier_cs_boss_fow_reveal, BaseModifier_CS)
function modifier_cs_boss_fow_reveal.prototype.IsHidden(self)
	return true
end
function modifier_cs_boss_fow_reveal.prototype.IsDebuff(self)
	return false
end
function modifier_cs_boss_fow_reveal.prototype.IsPurgable(self)
	return false
end
function modifier_cs_boss_fow_reveal.prototype.IsPurgeException(self)
	return false
end
function modifier_cs_boss_fow_reveal.prototype.IsPermanent(self)
	return true
end
function modifier_cs_boss_fow_reveal.prototype.RemoveOnDeath(self)
	return true
end
function modifier_cs_boss_fow_reveal.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROVIDES_FOW_POSITION }
end
function modifier_cs_boss_fow_reveal.prototype.GetModifierProvidesFOWVision(self)
	return 1
end
modifier_cs_boss_fow_reveal =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_cs_boss_fow_reveal") }, modifier_cs_boss_fow_reveal)
____exports.modifier_cs_boss_fow_reveal = modifier_cs_boss_fow_reveal
return ____exports