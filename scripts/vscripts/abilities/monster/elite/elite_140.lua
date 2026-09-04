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
local modifier_elite_140_overpower
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local OVERPOWER_PARTICLE = "particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf"
local OVERPOWER_SOUND = "Hero_Ursa.Overpower"
local URSA_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_ursa.vsndevts"
--- 精英技能140 - 幽爪熊王：短时间进入怒意超载，获得高额攻速并随攻击命中叠加攻击力
____exports.elite_140 = __TS__Class()
local elite_140 = ____exports.elite_140
elite_140.name = "elite_140"
__TS__ClassExtends(elite_140, MonsterAbility_CS)
function elite_140.prototype.Precache(self, context)
	PrecacheResource("particle", OVERPOWER_PARTICLE, context)
	PrecacheResource("soundfile", URSA_SOUND_EVENTS, context)
end
function elite_140.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 0,
		castPoint = 0.3,
		castDuration = 0.5,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_3,
		animationPlaybackRate = 1,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(OVERPOWER_SOUND, caster)
			modifier_elite_140_overpower:applys(caster, caster, self, {
				duration = self:GetSpecialValueFor("buff_duration"),
				attack_speed = self:GetSpecialValueFor("bonus_attack_speed"),
				attack_damage_pct_per_attack = self:GetSpecialValueFor("attack_damage_pct_per_attack"),
			})
		end,
	}
end
elite_140 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_140)
____exports.elite_140 = elite_140
modifier_elite_140_overpower = __TS__Class()
modifier_elite_140_overpower.name = "modifier_elite_140_overpower"
__TS__ClassExtends(modifier_elite_140_overpower, MonsterModifier_CS)
function modifier_elite_140_overpower.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.attackSpeed = 0
	self.attackDamagePctPerAttack = 0
end
function modifier_elite_140_overpower.prototype.OnCreated(self, params)
	self.attackSpeed = params.attack_speed or 0
	self.attackDamagePctPerAttack = params.attack_damage_pct_per_attack or 0
	self:SetStackCount(0)
end
function modifier_elite_140_overpower.prototype.OnRefresh(self, params)
	self.attackSpeed = params.attack_speed or 0
	self.attackDamagePctPerAttack = params.attack_damage_pct_per_attack or 0
	self:SetStackCount(0)
	self:RefreshAttributes()
end
function modifier_elite_140_overpower.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_140_overpower.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local target = event.target
	if event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	if
		not IsValidAlive(nil, parent)
		or not IsValidAlive(nil, target)
		or target:GetTeamNumber() == parent:GetTeamNumber()
	then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
	self:RefreshAttributes()
end
function modifier_elite_140_overpower.prototype.GetAttributeBonus(self)
	return {
		attack_speed = self.attackSpeed,
		all_attack_damage_percent = self:GetStackCount() * self.attackDamagePctPerAttack,
	}
end
function modifier_elite_140_overpower.prototype.GetEffectName(self)
	return OVERPOWER_PARTICLE
end
function modifier_elite_140_overpower.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_elite_140_overpower.prototype.IsHidden(self)
	return false
end
function modifier_elite_140_overpower.prototype.IsDebuff(self)
	return false
end
function modifier_elite_140_overpower.prototype.IsPurgable(self)
	return false
end
function modifier_elite_140_overpower.prototype.GetTexture(self)
	return "ursa_overpower"
end
function modifier_elite_140_overpower.GetLocalizationCN(self)
	return { name = "怒意超载", description = "攻击速度大幅提升，攻击命中时叠加攻击力。" }
end
modifier_elite_140_overpower =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_140_overpower") }, modifier_elite_140_overpower)
return ____exports