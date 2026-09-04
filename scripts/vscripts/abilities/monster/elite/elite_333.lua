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
local modifier_elite_333_haste
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local HASTE_DURATION = 10
local HASTE_ATTACK_SPEED_PCT = 10
local HASTE_MOVESPEED_PCT = 80
local HASTE_PARTICLE = "particles/units/heroes/hero_abaddon/abaddon_mist_coil_buff.vpcf"
local HASTE_SOUND = "Hero_LifeStealer.Rage"
--- 精英技能333：开启后短时间提高攻击速度与移动速度
____exports.elite_333 = __TS__Class()
local elite_333 = ____exports.elite_333
elite_333.name = "elite_333"
__TS__ClassExtends(elite_333, MonsterAbility_CS)
function elite_333.prototype.Precache(self, context)
	PrecacheResource("particle", HASTE_PARTICLE, context)
end
function elite_333.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0,
		castDuration = 0,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			modifier_elite_333_haste:applys(caster, caster, self, { duration = HASTE_DURATION })
			EmitSoundOn(HASTE_SOUND, caster)
		end,
	}
end
elite_333 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_333)
____exports.elite_333 = elite_333
modifier_elite_333_haste = __TS__Class()
modifier_elite_333_haste.name = "modifier_elite_333_haste"
__TS__ClassExtends(modifier_elite_333_haste, MonsterModifier_CS)
function modifier_elite_333_haste.GetLocalizationCN(self)
	return { name = "迅捷激励", description = "攻击速度提高10%，移动速度提高50%。" }
end
function modifier_elite_333_haste.prototype.GetAttributeBonus(self)
	return { attack_speed_pct = HASTE_ATTACK_SPEED_PCT, bonus_movespeed_pct = HASTE_MOVESPEED_PCT }
end
function modifier_elite_333_haste.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():AddActivityModifier("surge")
	self:GetParent():AddActivityModifier("ds_2022")
end
function modifier_elite_333_haste.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:GetParent():ClearActivityModifiers()
end
function modifier_elite_333_haste.prototype.IsHidden(self)
	return false
end
function modifier_elite_333_haste.prototype.IsPurgable(self)
	return false
end
function modifier_elite_333_haste.prototype.GetTexture(self)
	return "night_stalker_void"
end
function modifier_elite_333_haste.prototype.GetEffectName(self)
	return HASTE_PARTICLE
end
function modifier_elite_333_haste.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_elite_333_haste =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_333_haste") }, modifier_elite_333_haste)
return ____exports