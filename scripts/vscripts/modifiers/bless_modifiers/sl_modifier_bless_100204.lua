--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_100204.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_100204.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:26",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:39",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "10:5",
		["22"] = "11:9",
		["23"] = "10:5",
		["24"] = "14:5",
		["25"] = "15:9",
		["26"] = "14:5",
		["27"] = "20:5",
		["28"] = "21:9",
		["29"] = "20:5",
		["30"] = "24:5",
		["31"] = "25:14",
		["34"] = "26:13",
		["37"] = "27:13",
		["40"] = "30:9",
		["41"] = "24:5",
		["42"] = "37:5",
		["43"] = "38:14",
		["46"] = "39:13",
		["49"] = "41:15",
		["50"] = "42:15",
		["51"] = "45:9",
		["52"] = "37:5",
		["53"] = "48:5",
		["54"] = "49:9",
		["55"] = "48:5",
		["56"] = "52:5",
		["57"] = "53:9",
		["58"] = "52:5",
		["59"] = "58:5",
		["60"] = "59:14",
		["63"] = "60:9",
		["64"] = "58:5",
		["65"] = "63:5",
		["66"] = "64:16",
		["67"] = "64:16",
		["68"] = "64:16",
		["70"] = "64:16",
		["72"] = "64:16",
		["74"] = "64:9",
		["75"] = "63:5",
		["76"] = "67:5",
		["77"] = "68:16",
		["78"] = "68:16",
		["79"] = "68:16",
		["81"] = "68:16",
		["83"] = "68:16",
		["85"] = "68:9",
		["86"] = "67:5",
		["87"] = "5:14",
		["88"] = "4:2",
		["89"] = "4:2",
		["90"] = "4:19",
		["91"] = "4:2",
		["93"] = "4:2",
		["94"] = "5:14",
		["96"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
____exports.sl_modifier_bless_100204 = __TS__Class()
local sl_modifier_bless_100204 = ____exports.sl_modifier_bless_100204
sl_modifier_bless_100204.name = "sl_modifier_bless_100204"
__TS__ClassExtends(sl_modifier_bless_100204, SLModifierBase_Debuff)
function sl_modifier_bless_100204.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_100204.prototype.GetTexture(self)
	return "buff/bless/100204"
end
function sl_modifier_bless_100204.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true }
end
function sl_modifier_bless_100204.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end
function sl_modifier_bless_100204.prototype.OnAttackLanded(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetCaster() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	self:ExtendDuration(self:GetDelay())
end
function sl_modifier_bless_100204.prototype.ExtendDuration(self, extraDuration)
	if not IsServer() then
		return
	end
	if extraDuration <= 0 then
		return
	end
	local remainingTime = self:GetRemainingTime()
	local newDuration = remainingTime + extraDuration
	self:SetDuration(newDuration, true)
end
function sl_modifier_bless_100204.prototype.OnCreated(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_100204.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_100204.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	self._params = params
end
function sl_modifier_bless_100204.prototype.GetBaseDuration(self)
	local ____table__params_base_duration_0 = self._params
	if ____table__params_base_duration_0 ~= nil then
		____table__params_base_duration_0 = ____table__params_base_duration_0.base_duration
	end
	local ____table__params_base_duration_0_2 = ____table__params_base_duration_0
	if ____table__params_base_duration_0_2 == nil then
		____table__params_base_duration_0_2 = 0
	end
	return ____table__params_base_duration_0_2
end
function sl_modifier_bless_100204.prototype.GetDelay(self)
	local ____table__params_delay_3 = self._params
	if ____table__params_delay_3 ~= nil then
		____table__params_delay_3 = ____table__params_delay_3.delay
	end
	local ____table__params_delay_3_5 = ____table__params_delay_3
	if ____table__params_delay_3_5 == nil then
		____table__params_delay_3_5 = 0
	end
	return ____table__params_delay_3_5
end
sl_modifier_bless_100204 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100204", nil, getfenv()) },
	sl_modifier_bless_100204
)
____exports.sl_modifier_bless_100204 = sl_modifier_bless_100204
return ____exports