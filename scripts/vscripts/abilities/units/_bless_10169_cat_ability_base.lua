--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/units/_bless_10169_cat_ability_base.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__InstanceOf = ____lualib.__TS__InstanceOf
____debugRuntime.register(
	"abilities/units/_bless_10169_cat_ability_base.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:23",
		["14"] = "3:1",
		["15"] = "3:53",
		["17"] = "3:61",
		["18"] = "7:5",
		["19"] = "3:1",
		["20"] = "8:5",
		["21"] = "3:61",
		["22"] = "10:15",
		["23"] = "11:9",
		["24"] = "12:17",
		["25"] = "13:17",
		["26"] = "14:17",
		["29"] = "17:9",
		["30"] = "18:9",
		["31"] = "19:9",
		["32"] = "19:28",
		["33"] = "19:56",
		["34"] = "20:13",
		["35"] = "19:56",
		["36"] = "19:9",
		["37"] = "8:5",
		["38"] = "24:5",
		["39"] = "25:13",
		["40"] = "26:13",
		["41"] = "27:13",
		["43"] = "24:5",
	}
)
local ____exports = {}
local _____sl_ability_base = require("abilities._sl_ability_base")
local SLAbilityBase = _____sl_ability_base.SLAbilityBase
____exports._bless_10169_cat_ability_base = __TS__Class()
local _bless_10169_cat_ability_base = ____exports._bless_10169_cat_ability_base
_bless_10169_cat_ability_base.name = "_bless_10169_cat_ability_base"
__TS__ClassExtends(_bless_10169_cat_ability_base, SLAbilityBase)
function _bless_10169_cat_ability_base.prototype.____constructor(self, ...)
	SLAbilityBase.prototype.____constructor(self, ...)
	self._command_pid_duration = 3
end
function _bless_10169_cat_ability_base.prototype.OnSpellStart(self)
	SLAbilityBase.prototype.OnSpellStart(self)
	local caster = self:GetCaster()
	for ____, ability in ipairs(caster:FindAllAbilities()) do
		if __TS__InstanceOf(ability, ____exports._bless_10169_cat_ability_base) and ability ~= self then
			ability:StartCooldown(ability:GetCooldown(ability:GetLevel()))
			ability:_RemoveCommandParticle(true)
		end
	end
	self:_RemoveCommandParticle(true)
	self._command_pid = self:CreateParticle(self._command_particle, PATTACH_OVERHEAD_FOLLOW, caster)
	Timers:CreateTimer(self._command_pid_duration, function()
		self:_RemoveCommandParticle(false)
	end)
end
function _bless_10169_cat_ability_base.prototype._RemoveCommandParticle(self, immediatly)
	if self._command_pid then
		self:DestroyParticle(self._command_pid, immediatly)
		self._command_pid = nil
	end
end
return ____exports