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
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local PA_010_HEAL_SOUND = "Hero_Oracle.FalsePromise.Healed"
local PA_010_HEAL_SOUND_COOLDOWN = 0.5
--- 幻影刺客技能 010 - 嗜血（被动，W）
-- 每次普攻命中敌方单位时，按总敏捷的一定比例回复生命（默认 100% 即等量于敏捷值）。
____exports.pa_010 = __TS__Class()
local pa_010 = ____exports.pa_010
pa_010.name = "pa_010"
__TS__ClassExtends(pa_010, BaseHeroAbility)
function pa_010.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function pa_010.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_pa_010_bloodlust.name
end
function pa_010.prototype.GetAgilityRestorePct(self)
	return math.max(0, self:GetSpecialValue("pa_010", "agility_restore_pct"))
end
pa_010 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_010)
____exports.pa_010 = pa_010
____exports.modifier_pa_010_bloodlust = __TS__Class()
local modifier_pa_010_bloodlust = ____exports.modifier_pa_010_bloodlust
modifier_pa_010_bloodlust.name = "modifier_pa_010_bloodlust"
__TS__ClassExtends(modifier_pa_010_bloodlust, BaseHeroModifier)
function modifier_pa_010_bloodlust.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_pa_010_bloodlust.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_pa_010_bloodlust.prototype.IsPermanent(self)
	return true
end
function modifier_pa_010_bloodlust.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local pct = ability:GetAgilityRestorePct()
	local amount = agility * pct / 100
	if amount <= 0 then
		return
	end
	parent:CustomHeal(amount, { ability = ability, source = "spell" })
end
modifier_pa_010_bloodlust = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_010_bloodlust)
____exports.modifier_pa_010_bloodlust = modifier_pa_010_bloodlust
return ____exports