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
local modifier_boss_brewmaster_1_drinking, modifier_boss_brewmaster_1_speed_buff, modifier_boss_brewmaster_1
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local BOSS_BREWMASTER_1_CAST_POINT = 0.57
local BOSS_BREWMASTER_1_CAST_DURATION = 0.33
local BOSS_BREWMASTER_1_DRINKING_DURATION = BOSS_BREWMASTER_1_CAST_POINT + BOSS_BREWMASTER_1_CAST_DURATION + 1
local BOSS_BREWMASTER_1_HEAL_MAX_HEALTH_PCT = 30
local BOSS_BREWMASTER_1_SPEED_BUFF_DURATION = 4
local BOSS_BREWMASTER_1_ATTACK_SPEED_PCT = 50
local BOSS_BREWMASTER_1_MOVESPEED_PCT = 50
local BOSS_BREWMASTER_1_HEAL_EFFECT = "particles/item/item_heal.vpcf"
local BOSS_BREWMASTER_1_DRINK_SOUND = "Hero_Brewmaster.Brawler.Cast"
local BOSS_BREWMASTER_1_COMPLETE_SOUND = "Hero_BrewMaster.CinderBrew.SelfAttack"
--- 酒仙 BOSS 技能 1。
____exports.boss_brewmaster_1 = __TS__Class()
local boss_brewmaster_1 = ____exports.boss_brewmaster_1
boss_brewmaster_1.name = "boss_brewmaster_1"
__TS__ClassExtends(boss_brewmaster_1, MonsterAbility_CS)
function boss_brewmaster_1.prototype.Precache(self, context)
	PrecacheResource("particle", BOSS_BREWMASTER_1_HEAL_EFFECT, context)
end
function boss_brewmaster_1.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = BOSS_BREWMASTER_1_CAST_POINT,
		castDuration = BOSS_BREWMASTER_1_CAST_DURATION,
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_4,
		isNotMove = true,
		counterBreakWindowDuration = 0,
		OnPhaseStart = function()
			return self:StartDrinking()
		end,
		OnStart = function()
			return self:CompleteDrinking()
		end,
		OnInterrupt = function()
			return self:StopDrinking()
		end,
	}
end
function boss_brewmaster_1.prototype.StartDrinking(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(BOSS_BREWMASTER_1_DRINK_SOUND, caster)
	modifier_boss_brewmaster_1_drinking:applys(caster, caster, self, { duration = BOSS_BREWMASTER_1_DRINKING_DURATION })
end
function boss_brewmaster_1.prototype.CompleteDrinking(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(BOSS_BREWMASTER_1_COMPLETE_SOUND, caster)
	caster:CustomHeal(
		caster:GetMaxHealth() * (BOSS_BREWMASTER_1_HEAL_MAX_HEALTH_PCT / 100),
		{ ability = self, source = "spell", show_popup = true }
	)
	modifier_boss_brewmaster_1_speed_buff:applys(
		caster,
		caster,
		self,
		{ duration = BOSS_BREWMASTER_1_SPEED_BUFF_DURATION }
	)
	modifier_boss_brewmaster_1:applys(caster, caster, self, {})
end
function boss_brewmaster_1.prototype.StopDrinking(self)
	local caster = self:GetCaster()
	if not IsValid(nil, caster) then
		return
	end
	caster:RemoveModifierByName("modifier_boss_brewmaster_1_drinking")
end
boss_brewmaster_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_brewmaster_1)
____exports.boss_brewmaster_1 = boss_brewmaster_1
modifier_boss_brewmaster_1_drinking = __TS__Class()
modifier_boss_brewmaster_1_drinking.name = "modifier_boss_brewmaster_1_drinking"
__TS__ClassExtends(modifier_boss_brewmaster_1_drinking, BaseModifier_CS)
function modifier_boss_brewmaster_1_drinking.prototype.GetEffectName(self)
	return BOSS_BREWMASTER_1_HEAL_EFFECT
end
function modifier_boss_brewmaster_1_drinking.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_boss_brewmaster_1_drinking.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_boss_brewmaster_1_drinking.prototype.GetActivityTranslationModifiers(self)
	return "self"
end
function modifier_boss_brewmaster_1_drinking.prototype.IsPurgable(self)
	return false
end
function modifier_boss_brewmaster_1_drinking.prototype.IsHidden(self)
	return true
end
modifier_boss_brewmaster_1_drinking =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_brewmaster_1_drinking)
modifier_boss_brewmaster_1_speed_buff = __TS__Class()
modifier_boss_brewmaster_1_speed_buff.name = "modifier_boss_brewmaster_1_speed_buff"
__TS__ClassExtends(modifier_boss_brewmaster_1_speed_buff, MonsterModifier_CS)
function modifier_boss_brewmaster_1_speed_buff.GetLocalizationCN(self)
	return { name = "酒意正浓", description = "移动速度提升50%，攻击速度提升50%。" }
end
function modifier_boss_brewmaster_1_speed_buff.prototype.GetAttributeBonus(self)
	return {
		attack_speed_pct = BOSS_BREWMASTER_1_ATTACK_SPEED_PCT,
		bonus_movespeed_pct = BOSS_BREWMASTER_1_MOVESPEED_PCT,
	}
end
function modifier_boss_brewmaster_1_speed_buff.prototype.IsPurgable(self)
	return false
end
modifier_boss_brewmaster_1_speed_buff =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_brewmaster_1_speed_buff)
modifier_boss_brewmaster_1 = __TS__Class()
modifier_boss_brewmaster_1.name = "modifier_boss_brewmaster_1"
__TS__ClassExtends(modifier_boss_brewmaster_1, MonsterModifier_CS)
function modifier_boss_brewmaster_1.prototype.GetAttributeBonus(self)
	local stacks = self:GetStackCount()
	return { base_health_pct = stacks * 30, bonus_attack_damage = stacks * 450 }
end
function modifier_boss_brewmaster_1.prototype.OnCreated(self)
	self:SetStackCount(1)
end
function modifier_boss_brewmaster_1.prototype.OnRefresh(self)
	self:IncrementStackCount()
end
modifier_boss_brewmaster_1 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_brewmaster_1)
return ____exports