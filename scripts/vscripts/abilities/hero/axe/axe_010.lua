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
local AXE_010_PASSIVE_MODIFIER_NAME = "modifier_axe_010_glory_guard"
local AXE_010_ARMOR_POLL_INTERVAL = 0.2
____exports.axe_010 = __TS__Class()
local axe_010 = ____exports.axe_010
axe_010.name = "axe_010"
__TS__ClassExtends(axe_010, BaseHeroAbility)
function axe_010.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function axe_010.prototype.GetIntrinsicModifierName(self)
	return AXE_010_PASSIVE_MODIFIER_NAME
end
axe_010 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_010)
____exports.axe_010 = axe_010
____exports.modifier_axe_010_glory_guard = __TS__Class()
local modifier_axe_010_glory_guard = ____exports.modifier_axe_010_glory_guard
modifier_axe_010_glory_guard.name = "modifier_axe_010_glory_guard"
__TS__ClassExtends(modifier_axe_010_glory_guard, BaseHeroModifier)
function modifier_axe_010_glory_guard.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.lastTotalArmor = -99999
	self.bonusHealth = 0
end
function modifier_axe_010_glory_guard.GetLocalizationCN(self)
	return { name = "荣耀守护", description = "每点护甲值使自身增加10点生命上限。" }
end
function modifier_axe_010_glory_guard.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_010_glory_guard.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:UpdateBonusFromArmor(true)
	self:StartIntervalThink(AXE_010_ARMOR_POLL_INTERVAL)
end
function modifier_axe_010_glory_guard.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValid(nil, self:GetParent()) then
		return
	end
	self:UpdateBonusFromArmor(false)
end
function modifier_axe_010_glory_guard.prototype.GetAttributeBonus(self)
	return { base_energy_shield = self.bonusHealth }
end
function modifier_axe_010_glory_guard.prototype.UpdateBonusFromArmor(self, forceRefresh)
	local parent = self:GetParent()
	local totalArmor = MyGameAttribute:GetAttribute(parent, "total_armor") or 0
	if not forceRefresh and totalArmor == self.lastTotalArmor then
		return
	end
	self.lastTotalArmor = totalArmor
	local healthPerArmor = self:GetSpecialValue("axe_010", "health_per_armor")
	self.bonusHealth = math.floor(math.max(0, totalArmor) * healthPerArmor)
	self:SetStackCount(self.bonusHealth)
	self:RefreshAttributes()
end
modifier_axe_010_glory_guard = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_010_glory_guard)
____exports.modifier_axe_010_glory_guard = modifier_axe_010_glory_guard
return ____exports