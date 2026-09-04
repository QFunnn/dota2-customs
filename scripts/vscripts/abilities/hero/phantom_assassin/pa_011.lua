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
local PA_011_EVASION_PCT = 15
local PA_011_MOVESPEED_PCT_PER_STACK = 5
local PA_011_MAX_STACK = 5
local PA_011_STACK_DECAY_INTERVAL = 5
____exports.pa_011 = __TS__Class()
local pa_011 = ____exports.pa_011
pa_011.name = "pa_011"
__TS__ClassExtends(pa_011, BaseHeroAbility)
function pa_011.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function pa_011.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_pa_011_dexterity_training.name
end
pa_011 = __TS__DecorateLegacy({ registerAbility(nil) }, pa_011)
____exports.pa_011 = pa_011
____exports.modifier_pa_011_dexterity_training = __TS__Class()
local modifier_pa_011_dexterity_training = ____exports.modifier_pa_011_dexterity_training
modifier_pa_011_dexterity_training.name = "modifier_pa_011_dexterity_training"
__TS__ClassExtends(modifier_pa_011_dexterity_training, BaseHeroModifier)
function modifier_pa_011_dexterity_training.GetLocalizationCN(self)
	return { name = "灵巧训练", description = "获得闪避，触发闪避时叠加移动速度。" }
end
function modifier_pa_011_dexterity_training.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_MISS }
end
function modifier_pa_011_dexterity_training.prototype.GetModifierConfig(self)
	return {
		isHidden = self:GetStackCount() <= 0,
		isDebuff = false,
		isPurgable = false,
		isPurgeException = false,
	}
end
function modifier_pa_011_dexterity_training.prototype.IsPermanent(self)
	return true
end
function modifier_pa_011_dexterity_training.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self:StartIntervalThink(-1)
end
function modifier_pa_011_dexterity_training.prototype.OnTakeAttackMiss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	if event.is_miss ~= true then
		return
	end
	local previousStack = self:GetStackCount()
	local nextStack = math.min(previousStack + 1, PA_011_MAX_STACK)
	self:SetStackCount(nextStack)
	self:RefreshAttributes()
	if previousStack <= 0 and nextStack > 0 then
		self:StartIntervalThink(PA_011_STACK_DECAY_INTERVAL)
	end
end
function modifier_pa_011_dexterity_training.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local nextStack = math.max(self:GetStackCount() - 1, 0)
	self:SetStackCount(nextStack)
	self:RefreshAttributes()
	if nextStack <= 0 then
		self:StartIntervalThink(-1)
	end
end
function modifier_pa_011_dexterity_training.prototype.GetAttributeBonus(self)
	return {
		evasion_pct = PA_011_EVASION_PCT,
		bonus_movespeed_pct = self:GetStackCount() * PA_011_MOVESPEED_PCT_PER_STACK,
	}
end
function modifier_pa_011_dexterity_training.prototype.GetTexture(self)
	return "phantom_assassin_blur"
end
modifier_pa_011_dexterity_training = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_pa_011_dexterity_training)
____exports.modifier_pa_011_dexterity_training = modifier_pa_011_dexterity_training
return ____exports