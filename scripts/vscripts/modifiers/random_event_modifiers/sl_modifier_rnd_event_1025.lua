--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/random_event_modifiers/sl_modifier_rnd_event_1025.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/random_event_modifiers/sl_modifier_rnd_event_1025.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:46",
		["19"] = "11:5",
		["20"] = "12:9",
		["21"] = "11:5",
		["22"] = "15:5",
		["23"] = "16:9",
		["24"] = "15:5",
		["25"] = "19:5",
		["26"] = "20:9",
		["27"] = "19:5",
		["28"] = "23:5",
		["29"] = "24:9",
		["30"] = "23:5",
		["31"] = "27:5",
		["32"] = "28:14",
		["35"] = "29:9",
		["36"] = "30:9",
		["37"] = "31:13",
		["38"] = "30:30",
		["39"] = "33:13",
		["40"] = "30:30",
		["41"] = "27:5",
		["42"] = "37:5",
		["43"] = "38:14",
		["46"] = "39:9",
		["47"] = "37:5",
		["48"] = "42:5",
		["49"] = "43:14",
		["52"] = "44:13",
		["55"] = "45:9",
		["56"] = "46:9",
		["57"] = "42:5",
		["58"] = "49:5",
		["59"] = "50:9",
		["60"] = "51:9",
		["61"] = "49:5",
		["62"] = "8:14",
		["63"] = "7:2",
		["64"] = "7:2",
		["65"] = "7:19",
		["66"] = "7:2",
		["68"] = "7:2",
		["69"] = "8:14",
		["71"] = "8:14",
		["73"] = "58:1",
		["74"] = "59:14",
		["75"] = "58:1",
		["76"] = "59:47",
		["77"] = "62:5",
		["78"] = "63:9",
		["79"] = "62:5",
		["80"] = "66:5",
		["81"] = "67:9",
		["82"] = "66:5",
		["83"] = "70:5",
		["84"] = "71:9",
		["85"] = "70:5",
		["86"] = "74:5",
		["87"] = "75:9",
		["88"] = "74:5",
		["89"] = "78:5",
		["90"] = "79:14",
		["93"] = "80:9",
		["94"] = "81:9",
		["95"] = "82:13",
		["96"] = "81:30",
		["97"] = "84:13",
		["98"] = "81:30",
		["99"] = "78:5",
		["100"] = "88:5",
		["101"] = "89:14",
		["104"] = "90:9",
		["105"] = "88:5",
		["106"] = "93:5",
		["107"] = "94:14",
		["110"] = "95:13",
		["113"] = "96:9",
		["114"] = "97:9",
		["115"] = "93:5",
		["116"] = "100:5",
		["117"] = "101:9",
		["118"] = "100:5",
		["119"] = "59:14",
		["120"] = "58:2",
		["121"] = "58:2",
		["122"] = "58:19",
		["123"] = "58:2",
		["125"] = "58:2",
		["126"] = "59:14",
		["128"] = "59:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 赵云：杀敌最高，输出↑ 承伤↑ + overhead
____exports.sl_modifier_rnd_event_1025_zhao = __TS__Class()
local sl_modifier_rnd_event_1025_zhao = ____exports.sl_modifier_rnd_event_1025_zhao
sl_modifier_rnd_event_1025_zhao.name = "sl_modifier_rnd_event_1025_zhao"
__TS__ClassExtends(sl_modifier_rnd_event_1025_zhao, SLModifierBase)
function sl_modifier_rnd_event_1025_zhao.prototype.IsHidden(self)
	return false
end
function sl_modifier_rnd_event_1025_zhao.prototype.GetTexture(self)
	return "buff/rnd_event_1025_zhaoyun"
end
function sl_modifier_rnd_event_1025_zhao.prototype.IsPermanent(self)
	return false
end
function sl_modifier_rnd_event_1025_zhao.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_rnd_event_1025_zhao.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
	self._overhead_pid = SParticleManager:CreateGenericParticle(
		GENERIC_PARTICLES.rnd_event_1025_zhaoyun_overhead,
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
end
function sl_modifier_rnd_event_1025_zhao.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_rnd_event_1025_zhao.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._overhead_pid == nil then
		return
	end
	SParticleManager:DestroyParticle(self._overhead_pid, false)
	self._overhead_pid = nil
end
function sl_modifier_rnd_event_1025_zhao.prototype._ApplyParam(self, params)
	self:_SetParentAttr("shI", params.shI)
	self:_SetParentAttr("csshI", params.csshI)
end
sl_modifier_rnd_event_1025_zhao = __TS__Decorate(
	{ registerModifier(nil, "modifiers/random_event_modifiers/sl_modifier_rnd_event_1025", nil, getfenv()) },
	sl_modifier_rnd_event_1025_zhao
)
____exports.sl_modifier_rnd_event_1025_zhao = sl_modifier_rnd_event_1025_zhao
--- 阿斗：死亡最高，承伤↓ + overhead
____exports.sl_modifier_rnd_event_1025_a_dou = __TS__Class()
local sl_modifier_rnd_event_1025_a_dou = ____exports.sl_modifier_rnd_event_1025_a_dou
sl_modifier_rnd_event_1025_a_dou.name = "sl_modifier_rnd_event_1025_a_dou"
__TS__ClassExtends(sl_modifier_rnd_event_1025_a_dou, SLModifierBase)
function sl_modifier_rnd_event_1025_a_dou.prototype.IsHidden(self)
	return false
end
function sl_modifier_rnd_event_1025_a_dou.prototype.GetTexture(self)
	return "buff/rnd_event_1025_adou"
end
function sl_modifier_rnd_event_1025_a_dou.prototype.IsPermanent(self)
	return false
end
function sl_modifier_rnd_event_1025_a_dou.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_rnd_event_1025_a_dou.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
	self._overhead_pid = SParticleManager:CreateGenericParticle(
		GENERIC_PARTICLES.rnd_event_1025_adou_overhead,
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
end
function sl_modifier_rnd_event_1025_a_dou.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_rnd_event_1025_a_dou.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._overhead_pid == nil then
		return
	end
	SParticleManager:DestroyParticle(self._overhead_pid, false)
	self._overhead_pid = nil
end
function sl_modifier_rnd_event_1025_a_dou.prototype._ApplyParam(self, params)
	self:_SetParentAttr("csshI", -params.csshI)
end
sl_modifier_rnd_event_1025_a_dou = __TS__Decorate(
	{ registerModifier(nil, "modifiers/random_event_modifiers/sl_modifier_rnd_event_1025", nil, getfenv()) },
	sl_modifier_rnd_event_1025_a_dou
)
____exports.sl_modifier_rnd_event_1025_a_dou = sl_modifier_rnd_event_1025_a_dou
return ____exports