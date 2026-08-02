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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_global_thinker = __TS__Class()
local sl_modifier_global_thinker = ____exports.sl_modifier_global_thinker
sl_modifier_global_thinker.name = "sl_modifier_global_thinker"
__TS__ClassExtends(sl_modifier_global_thinker, SLModifierBase)
function sl_modifier_global_thinker.prototype.DeclareFunctions(self)
	return {
		MODIFIER_EVENT_ON_MODIFIER_ADDED,
		MODIFIER_EVENT_ON_MODIFIER_REFRESHED,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_ABILITY_START,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_EVENT_ON_HERO_KILLED,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_RESPAWN,
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ABILITY_END_CHANNEL,
		MODIFIER_EVENT_ON_DAMAGE_CALCULATED,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end
function sl_modifier_global_thinker.prototype.OnModifierRefreshed(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnModifierRefreshed(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnModifierAdded(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnModifierAdded(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnTakeDamage(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnTakeDamage(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnAbilityStart(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAbilityStart(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnAbilityExecuted(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAbilityExecuted(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnAbilityFullyCast(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAbilityFullyCast(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnAbilityEndChannel(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAbilityEndChannel(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnDeath(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnDeath(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnHeroKilled(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnHeroKilled(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnRespawn(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnRespawn(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnAttackStart(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAttackStart(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnAttackRecord(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAttackRecord(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnAttackRecordDestroy(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAttackRecordDestroy(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnAttack(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAttackLaunch(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnAttackLanded(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAttackLanded(event)
	end)
end
function sl_modifier_global_thinker.prototype.OnDamageCalculated(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnDamageCalculated(event)
	end)
end
sl_modifier_global_thinker = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_global_thinker") },
	sl_modifier_global_thinker
)
____exports.sl_modifier_global_thinker = sl_modifier_global_thinker
return ____exports