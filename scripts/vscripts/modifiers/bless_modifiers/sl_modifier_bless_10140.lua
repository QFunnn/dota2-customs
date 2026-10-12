--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10140.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10140.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "5:1",
		["15"] = "6:14",
		["16"] = "5:1",
		["17"] = "6:45",
		["18"] = "7:5",
		["19"] = "8:9",
		["20"] = "7:5",
		["21"] = "11:5",
		["22"] = "12:9",
		["23"] = "11:5",
		["24"] = "15:5",
		["25"] = "16:9",
		["26"] = "15:5",
		["27"] = "19:5",
		["28"] = "20:14",
		["31"] = "21:15",
		["32"] = "22:13",
		["33"] = "23:13",
		["35"] = "6:53",
		["36"] = "19:5",
		["37"] = "28:5",
		["38"] = "6:53",
		["39"] = "30:9",
		["40"] = "31:9",
		["41"] = "28:5",
		["42"] = "35:5",
		["43"] = "36:14",
		["46"] = "37:9",
		["47"] = "37:9",
		["49"] = "38:14",
		["50"] = "39:13",
		["53"] = "43:15",
		["54"] = "44:14",
		["55"] = "46:13",
		["57"] = "35:5",
		["58"] = "6:14",
		["59"] = "5:2",
		["60"] = "5:2",
		["61"] = "5:19",
		["62"] = "5:2",
		["64"] = "5:2",
		["65"] = "6:14",
		["67"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10140_zombie = __TS__Class()
local sl_modifier_bless_10140_zombie = ____exports.sl_modifier_bless_10140_zombie
sl_modifier_bless_10140_zombie.name = "sl_modifier_bless_10140_zombie"
__TS__ClassExtends(sl_modifier_bless_10140_zombie, sl_modifier_transmitter_data)
function sl_modifier_bless_10140_zombie.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_LIFETIME_FRACTION }
end
function sl_modifier_bless_10140_zombie.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return self._params.atk_spd
end
function sl_modifier_bless_10140_zombie.prototype.GetUnitLifetimeFraction(self)
	return self._params.life_time
end
function sl_modifier_bless_10140_zombie.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValidAlive(parent) then
		parent:ForceKill(false)
	end
	sl_modifier_transmitter_data.prototype.OnDestroy(self)
end
function sl_modifier_bless_10140_zombie.prototype.OnCreated(self, params)
	sl_modifier_transmitter_data.prototype.OnCreated(self, params)
	self:OnIntervalThink()
	self:StartIntervalThink(1)
end
function sl_modifier_bless_10140_zombie.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if self._target == nil then
		self._target = EntIndexToHScript(self._params.target)
	end
	if not IsValidAlive(self._target) then
		self:Destroy()
		return
	end
	local parent = self:GetParent()
	if not self._target:IsInvisible() then
		parent:MoveToTargetToAttack(self._target)
	end
end
sl_modifier_bless_10140_zombie = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10140", nil, getfenv()) },
	sl_modifier_bless_10140_zombie
)
____exports.sl_modifier_bless_10140_zombie = sl_modifier_bless_10140_zombie
return ____exports