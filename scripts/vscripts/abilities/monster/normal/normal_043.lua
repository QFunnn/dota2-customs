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
local modifier_normal_043_berserk
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local BERSERK_DURATION = 10
local BERSERK_MOVESPEED_PCT = 100
local BERSERK_ATTACK_SPEED_PCT = 100
local BERSERK_PARTICLE = "particles/units/heroes/hero_abaddon/abaddon_mist_coil_buff.vpcf"
local BERSERK_SOUND = "Hero_LifeStealer.Rage"
--- 普通怪物技能43：狂暴，主动开启后短时间提升移速与攻速
____exports.normal_043 = __TS__Class()
local normal_043 = ____exports.normal_043
normal_043.name = "normal_043"
__TS__ClassExtends(normal_043, MonsterAbility_CS)
function normal_043.prototype.Precache(self, context)
	PrecacheResource("particle", BERSERK_PARTICLE, context)
end
function normal_043.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0,
		castDuration = 0,
		OnStart = function()
			return self:OnStart()
		end,
	}
end
function normal_043.prototype.OnStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(BERSERK_SOUND, caster)
	modifier_normal_043_berserk:applys(caster, caster, self, { duration = BERSERK_DURATION })
end
normal_043 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_043)
____exports.normal_043 = normal_043
modifier_normal_043_berserk = __TS__Class()
modifier_normal_043_berserk.name = "modifier_normal_043_berserk"
__TS__ClassExtends(modifier_normal_043_berserk, MonsterModifier_CS)
function modifier_normal_043_berserk.GetLocalizationCN(self)
	return { name = "狂暴", description = "移动速度提升100%，攻击速度提升100。" }
end
function modifier_normal_043_berserk.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = BERSERK_MOVESPEED_PCT, attack_speed_pct = BERSERK_ATTACK_SPEED_PCT }
end
function modifier_normal_043_berserk.prototype.IsHidden(self)
	return false
end
function modifier_normal_043_berserk.prototype.IsPurgable(self)
	return false
end
function modifier_normal_043_berserk.prototype.GetTexture(self)
	return "night_stalker_void"
end
function modifier_normal_043_berserk.prototype.GetEffectName(self)
	return BERSERK_PARTICLE
end
function modifier_normal_043_berserk.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_normal_043_berserk =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_043_berserk") }, modifier_normal_043_berserk)
return ____exports