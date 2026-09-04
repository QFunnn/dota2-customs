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
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____monkey_soldiers = require("abilities.monster.boss_monkey.monkey_soldiers")
local CleanupMonkeySoldiers = ____monkey_soldiers.CleanupMonkeySoldiers
local EnsureMonkeySoldiers = ____monkey_soldiers.EnsureMonkeySoldiers
local MONKEY_SOLDIER_STATUS_EFFECT = ____monkey_soldiers.MONKEY_SOLDIER_STATUS_EFFECT
local MONKEY_AB5_CAST_PARTICLE = "particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_cast_arcana_fire.vpcf"
local MONKEY_AB5_INITIAL_DELAY = 1
____exports.monkey_ab5 = __TS__Class()
local monkey_ab5 = ____exports.monkey_ab5
monkey_ab5.name = "monkey_ab5"
__TS__ClassExtends(monkey_ab5, MonsterAbility_CS)
function monkey_ab5.prototype.Precache(self, context)
	PrecacheResource("particle", MONKEY_AB5_CAST_PARTICLE, context)
	PrecacheResource("particle", MONKEY_SOLDIER_STATUS_EFFECT, context)
end
function monkey_ab5.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN, castPoint = 0, castDuration = 0 }
end
function monkey_ab5.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_monkey_ab5_soldier_pool.name
end
monkey_ab5 = __TS__DecorateLegacy({ registerAbility(nil) }, monkey_ab5)
____exports.monkey_ab5 = monkey_ab5
____exports.modifier_monkey_ab5_soldier_pool = __TS__Class()
local modifier_monkey_ab5_soldier_pool = ____exports.modifier_monkey_ab5_soldier_pool
modifier_monkey_ab5_soldier_pool.name = "modifier_monkey_ab5_soldier_pool"
__TS__ClassExtends(modifier_monkey_ab5_soldier_pool, MonsterModifier_CS)
function modifier_monkey_ab5_soldier_pool.prototype.IsHidden(self)
	return true
end
function modifier_monkey_ab5_soldier_pool.prototype.IsPurgable(self)
	return false
end
function modifier_monkey_ab5_soldier_pool.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(MONKEY_AB5_INITIAL_DELAY)
end
function modifier_monkey_ab5_soldier_pool.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:RefreshSoldierPool()
end
function modifier_monkey_ab5_soldier_pool.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	CleanupMonkeySoldiers(nil, parent)
end
function modifier_monkey_ab5_soldier_pool.prototype.RefreshSoldierPool(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	EnsureMonkeySoldiers(nil, parent, self:GetAbility())
end
modifier_monkey_ab5_soldier_pool = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_monkey_ab5_soldier_pool)
____exports.modifier_monkey_ab5_soldier_pool = modifier_monkey_ab5_soldier_pool
return ____exports