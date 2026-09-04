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
local START_SOUND = "Hero_Dark_Seer.Surge"
--- 普通怪技能1：短暂自我加速
____exports.normal_001 = __TS__Class()
local normal_001 = ____exports.normal_001
normal_001.name = "normal_001"
__TS__ClassExtends(normal_001, MonsterAbility_CS)
function normal_001.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_4,
		castPoint = 0.5,
		castDuration = 0,
		OnStart = function()
			local caster = self._caster
			EmitSoundOn(START_SOUND, caster)
			caster:AddNewModifier(caster, self, "modifier_normal_001", { duration = 0.5 })
		end,
	}
end
normal_001 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_001)
____exports.normal_001 = normal_001
____exports.modifier_normal_001 = __TS__Class()
local modifier_normal_001 = ____exports.modifier_normal_001
modifier_normal_001.name = "modifier_normal_001"
__TS__ClassExtends(modifier_normal_001, MonsterModifier_CS)
function modifier_normal_001.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = 300 }
end
function modifier_normal_001.prototype.GetEffectName(self)
	return "particles/items2_fx/phase_boots.vpcf"
end
modifier_normal_001 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_001)
____exports.modifier_normal_001 = modifier_normal_001
return ____exports