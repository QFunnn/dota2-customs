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
local TRIGGER_INTERVAL = 5
local SURGE_DURATION = 1
local SURGE_MOVESPEED_PCT = 100
local SURGE_PARTICLE = "particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf"
local SURGE_SOUND = "Hero_Dark_Seer.Surge"
--- 普通技能23：虚空疾行，每隔5秒短暂提升自身移动速度
____exports.normal_023 = __TS__Class()
local normal_023 = ____exports.normal_023
normal_023.name = "normal_023"
__TS__ClassExtends(normal_023, MonsterAbility_CS)
function normal_023.prototype.Precache(self, context)
	PrecacheResource("particle", SURGE_PARTICLE, context)
end
function normal_023.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_023.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_023"
end
normal_023 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_023)
____exports.normal_023 = normal_023
local modifier_normal_023 = __TS__Class()
modifier_normal_023.name = "modifier_normal_023"
__TS__ClassExtends(modifier_normal_023, MonsterModifier_CS)
function modifier_normal_023.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(TRIGGER_INTERVAL)
end
function modifier_normal_023.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	EmitSoundOn(SURGE_SOUND, parent)
	parent:AddNewModifier(parent, ability, "modifier_normal_023_surge", { duration = SURGE_DURATION })
end
function modifier_normal_023.prototype.IsHidden(self)
	return true
end
function modifier_normal_023.prototype.IsPurgable(self)
	return false
end
modifier_normal_023 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_023") }, modifier_normal_023)
local modifier_normal_023_surge = __TS__Class()
modifier_normal_023_surge.name = "modifier_normal_023_surge"
__TS__ClassExtends(modifier_normal_023_surge, MonsterModifier_CS)
function modifier_normal_023_surge.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = SURGE_MOVESPEED_PCT }
end
function modifier_normal_023_surge.prototype.GetEffectName(self)
	return SURGE_PARTICLE
end
function modifier_normal_023_surge.prototype.IsPurgable(self)
	return false
end
modifier_normal_023_surge =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_023_surge") }, modifier_normal_023_surge)
return ____exports