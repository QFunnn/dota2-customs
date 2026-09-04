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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 治疗：无目标仅对自身，一次性恢复当前缺失生命值一定比例。
-- 等级上限 1，不可学习。
____exports.ak_hero_heal = __TS__Class()
local ak_hero_heal = ____exports.ak_hero_heal
ak_hero_heal.name = "ak_hero_heal"
__TS__ClassExtends(ak_hero_heal, BaseHeroAbility)
function ak_hero_heal.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/hero/ti8_hero_effect_detail.vpcf", context)
end
function ak_hero_heal.prototype.GetBehavior(self)
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end
function ak_hero_heal.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0.05,
		castAnimation = ACT_DOTA_ATTACK,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		animationPlaybackRate = 1,
	}
end
function ak_hero_heal.prototype.GetMaxLevel(self)
	return 1
end
function ak_hero_heal.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local maxHp = caster:GetMaxHealth()
	local curHp = caster:GetHealth()
	local missing = math.max(0, maxHp - curHp)
	self:EmitSound("CNY_Beast.HandOfGodHealHero")
	local pct = self:GetSpecialValue("ak_hero_heal", "heal_missing_pct") or 30
	local amount = missing * (pct / 100)
	if amount > 0 then
		caster:CustomHeal(amount, { ability = self, source = "spell" })
	end
	caster:AddNewModifier(caster, self, "modifier_cs_damage_reduction", { duration = 0.2, damage_reduction_pct = 80 })
	____exports.natural_shlter_modifire:applys(caster, caster, self, { duration = 5 })
end
ak_hero_heal = __TS__DecorateLegacy({ registerAbility(nil) }, ak_hero_heal)
____exports.ak_hero_heal = ak_hero_heal
____exports.natural_shlter_modifire = __TS__Class()
local natural_shlter_modifire = ____exports.natural_shlter_modifire
natural_shlter_modifire.name = "natural_shlter_modifire"
__TS__ClassExtends(natural_shlter_modifire, BaseModifier_CS)
function natural_shlter_modifire.prototype.GetAttributeBonus(self)
	return { health_regen = 10 }
end
function natural_shlter_modifire.prototype.GetEffectName(self)
	return "particles/hero/ti8_hero_effect_detail.vpcf"
end
function natural_shlter_modifire.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE }
end
function natural_shlter_modifire.prototype.GetModifierHealthRegenPercentage(self)
	return 5
end
natural_shlter_modifire = __TS__DecorateLegacy({ registerModifier(nil) }, natural_shlter_modifire)
____exports.natural_shlter_modifire = natural_shlter_modifire
return ____exports