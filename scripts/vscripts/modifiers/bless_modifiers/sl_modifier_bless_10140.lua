--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10140") },
	sl_modifier_bless_10140_zombie
)
____exports.sl_modifier_bless_10140_zombie = sl_modifier_bless_10140_zombie
return ____exports