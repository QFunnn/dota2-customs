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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
--- 先祖 0803 与本体共用本文件（ascended_item_aliases2）——双形态图标按物品名分流（先祖：xz_150 进攻 / xz_151 防御）。
local function isAscendedHarmonizer(self, ability)
	return not not ability and not ability:IsNull() and ability:GetAbilityName() == "item_0803"
end
____exports.item_0294 = __TS__Class()
local item_0294 = ____exports.item_0294
item_0294.name = "item_0294"
__TS__ClassExtends(item_0294, BaseItem_CS)
function item_0294.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0294_controller.name
end
function item_0294.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0294.prototype.GetAbilityTextureName(self)
	local ascended = isAscendedHarmonizer(nil, self)
	local caster = self:GetCaster()
	if
		caster
		and not caster:IsNull()
		and not self:IsNull()
		and caster:HasModifier(____exports.modifier_item_0294_defensive.name)
	then
		return ascended and "item_icon_xz_151" or "xiehe2"
	end
	return ascended and "item_icon_xz_150" or "item_harmonizer"
end
function item_0294.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local controller = caster:FindModifierByName(____exports.modifier_item_0294_controller.name)
	if controller then
		controller:Toggle()
	end
	self:PlayEffects1(caster)
	caster:EmitSound("largo_largo_ally_002")
end
function item_0294.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.Armlet.Activate")
end
item_0294 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0294)
____exports.item_0294 = item_0294
--- 隐藏控制器，管理进攻/防御两个可见 buff 的切换
____exports.modifier_item_0294_controller = __TS__Class()
local modifier_item_0294_controller = ____exports.modifier_item_0294_controller
modifier_item_0294_controller.name = "modifier_item_0294_controller"
__TS__ClassExtends(modifier_item_0294_controller, BaseModifier_CS)
function modifier_item_0294_controller.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._isAggressive = false
end
function modifier_item_0294_controller.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self._isAggressive = true
	caster:AddNewModifier(caster, ability, ____exports.modifier_item_0294_aggressive.name, {})
end
function modifier_item_0294_controller.prototype.Toggle(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self._isAggressive = not self._isAggressive
	if self._isAggressive then
		local defensive = caster:FindModifierByName(____exports.modifier_item_0294_defensive.name)
		if defensive then
			defensive:Destroy()
		end
		caster:AddNewModifier(caster, ability, ____exports.modifier_item_0294_aggressive.name, {})
	else
		local aggressive = caster:FindModifierByName(____exports.modifier_item_0294_aggressive.name)
		if aggressive then
			aggressive:Destroy()
		end
		caster:AddNewModifier(caster, ability, ____exports.modifier_item_0294_defensive.name, {})
	end
end
function modifier_item_0294_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not IsValidAlive(nil, caster) then
		return
	end
	local aggressive = caster:FindModifierByName(____exports.modifier_item_0294_aggressive.name)
	if aggressive then
		aggressive:Destroy()
	end
	local defensive = caster:FindModifierByName(____exports.modifier_item_0294_defensive.name)
	if defensive then
		defensive:Destroy()
	end
end
function modifier_item_0294_controller.prototype.IsHidden(self)
	return true
end
function modifier_item_0294_controller.prototype.IsPurgable(self)
	return false
end
modifier_item_0294_controller = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0294_controller)
____exports.modifier_item_0294_controller = modifier_item_0294_controller
____exports.modifier_item_0294_aggressive = __TS__Class()
local modifier_item_0294_aggressive = ____exports.modifier_item_0294_aggressive
modifier_item_0294_aggressive.name = "modifier_item_0294_aggressive"
__TS__ClassExtends(modifier_item_0294_aggressive, BaseModifier_CS)
function modifier_item_0294_aggressive.GetLocalizationCN(self)
	return { name = "谐振器（进攻）", description = "提高造成的伤害，但受到的伤害也会增加。" }
end
function modifier_item_0294_aggressive.prototype.OnCreated(self)
	self:RefreshAttributes()
end
function modifier_item_0294_aggressive.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return {
		outgoing_damage_pct = ability:GetSpecialValueFor("ability_value_aggressive_outgoing_damage_pct"),
		incoming_damage_increase_pct = ability:GetSpecialValueFor("ability_value_c_aggressive_incoming_damage_pct"),
	}
end
function modifier_item_0294_aggressive.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_largo/largo_croak_genius_creep_debuff.vpcf"
end
function modifier_item_0294_aggressive.prototype.IsHidden(self)
	return false
end
function modifier_item_0294_aggressive.prototype.IsPurgable(self)
	return false
end
function modifier_item_0294_aggressive.prototype.GetTexture(self)
	return isAscendedHarmonizer(nil, self:GetAbility()) and "item_icon_xz_150" or "item_harmonizer"
end
modifier_item_0294_aggressive = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0294_aggressive)
____exports.modifier_item_0294_aggressive = modifier_item_0294_aggressive
____exports.modifier_item_0294_defensive = __TS__Class()
local modifier_item_0294_defensive = ____exports.modifier_item_0294_defensive
modifier_item_0294_defensive.name = "modifier_item_0294_defensive"
__TS__ClassExtends(modifier_item_0294_defensive, BaseModifier_CS)
function modifier_item_0294_defensive.GetLocalizationCN(self)
	return {
		name = "谐振器（防御）",
		description = "提高护甲与魔法抗性，但造成的伤害会降低。",
	}
end
function modifier_item_0294_defensive.prototype.OnCreated(self)
	self:RefreshAttributes()
end
function modifier_item_0294_defensive.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return {
		base_armor_pct = ability:GetSpecialValueFor("ability_value_defensive_bonus_armor_pct"),
		base_magic_resistance = ability:GetSpecialValueFor("ability_value_defensive_bonus_magic_resistance_pct"),
		outgoing_damage_pct = -math.abs(
			ability:GetSpecialValueFor("ability_value_c_defensive_outgoing_damage_reduction_pct")
		),
	}
end
function modifier_item_0294_defensive.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_largo/largo_amphibian_rhapsody_heal.vpcf"
end
function modifier_item_0294_defensive.prototype.IsHidden(self)
	return false
end
function modifier_item_0294_defensive.prototype.IsPurgable(self)
	return false
end
function modifier_item_0294_defensive.prototype.GetTexture(self)
	return isAscendedHarmonizer(nil, self:GetAbility()) and "item_icon_xz_151" or "item_xiehe2"
end
modifier_item_0294_defensive = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0294_defensive)
____exports.modifier_item_0294_defensive = modifier_item_0294_defensive
return ____exports