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
--- 闪避面板值轮询间隔（秒）：属性系统无跨键派生通知，靠比对驱动减伤词条刷新
local DROW_007_EVASION_POLL_INTERVAL = 0.5
--- 卓尔游侠技能 007 - 冰肌
-- 被动：每拥有 1% 面板闪避，受到的伤害降低 1%（damage_reduction_pct 加算桶）。
-- 闪避读数与刀阵旋风符印同口径：面板 evasion_pct，封顶 100。
____exports.drow_007 = __TS__Class()
local drow_007 = ____exports.drow_007
drow_007.name = "drow_007"
__TS__ClassExtends(drow_007, BaseHeroAbility)
function drow_007.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN }
end
function drow_007.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_drow_007_ice_skin.name
end
function drow_007.prototype.GetDamageReductionPerEvasion(self)
	return self:GetSpecialValue("drow_007", "damage_reduction_per_evasion")
end
drow_007 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_007)
____exports.drow_007 = drow_007
____exports.modifier_drow_007_ice_skin = __TS__Class()
local modifier_drow_007_ice_skin = ____exports.modifier_drow_007_ice_skin
modifier_drow_007_ice_skin.name = "modifier_drow_007_ice_skin"
__TS__ClassExtends(modifier_drow_007_ice_skin, BaseHeroModifier)
function modifier_drow_007_ice_skin.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.lastEvasion = 0
end
function modifier_drow_007_ice_skin.GetLocalizationCN(self)
	return { name = "冰肌", description = "每拥有1%%闪避，获得1%%伤害抵抗。" }
end
function modifier_drow_007_ice_skin.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_drow_007_ice_skin.prototype.IsPermanent(self)
	return true
end
function modifier_drow_007_ice_skin.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.lastEvasion = self:GetCurrentEvasion()
	self:RefreshAttributes()
	self:StartIntervalThink(DROW_007_EVASION_POLL_INTERVAL)
end
function modifier_drow_007_ice_skin.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local evasion = self:GetCurrentEvasion()
	if evasion == self.lastEvasion then
		return
	end
	self.lastEvasion = evasion
	self:RefreshAttributes()
end
function modifier_drow_007_ice_skin.prototype.GetCurrentEvasion(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return 0
	end
	local evasion = MyGameAttribute:GetAttribute(parent, "evasion_pct") or 0
	return math.min(math.max(evasion, 0), 100)
end
function modifier_drow_007_ice_skin.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return { damage_resistance_pct = self.lastEvasion * ability:GetDamageReductionPerEvasion() }
end
function modifier_drow_007_ice_skin.prototype.GetTexture(self)
	return "drow_07"
end
modifier_drow_007_ice_skin = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_007_ice_skin)
____exports.modifier_drow_007_ice_skin = modifier_drow_007_ice_skin
return ____exports