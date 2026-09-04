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
local ITEM_0270_PROJECTILE = "particles/units/heroes/hero_treant/treant_leech_seed.vpcf"
____exports.item_0270 = __TS__Class()
local item_0270 = ____exports.item_0270
item_0270.name = "item_0270"
__TS__ClassExtends(item_0270, BaseItem_CS)
function item_0270.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET }
end
function item_0270.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local ability_duration = self:GetSpecialValue("item_0270", "ability_value_duration")
	self:PlayEffects1(caster, target)
	target:AddNewModifier(
		caster,
		self,
		____exports.modifier_item_0270_dizzy_pollen.name,
		{ duration = ability_duration }
	)
	self:PlayEffects2(target)
end
function item_0270.prototype.PlayEffects1(self, caster, target)
	local particle_cast =
		MyGameHeroParticleManager:CreateParticle(ITEM_0270_PROJECTILE, PATTACH_ABSORIGIN_FOLLOW, caster, caster)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle_cast,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle_cast)
end
function item_0270.prototype.PlayEffects2(self, target)
	target:EmitSound("Item.Phylactery.Target")
end
function item_0270.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0270"
end
item_0270 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0270)
____exports.item_0270 = item_0270
____exports.modifier_item_0270_dizzy_pollen = __TS__Class()
local modifier_item_0270_dizzy_pollen = ____exports.modifier_item_0270_dizzy_pollen
modifier_item_0270_dizzy_pollen.name = "modifier_item_0270_dizzy_pollen"
__TS__ClassExtends(modifier_item_0270_dizzy_pollen, BaseModifier_CS)
function modifier_item_0270_dizzy_pollen.GetLocalizationCN(self)
	return { name = "迷醉花粉", description = "攻击有概率丢失。" }
end
function modifier_item_0270_dizzy_pollen.prototype.GetAttributeBonus(self)
	return { blind_chance_pct = self:GetSpecialValue("item_0270", "ability_miss_chance_pct") }
end
function modifier_item_0270_dizzy_pollen.prototype.IsHidden(self)
	return false
end
function modifier_item_0270_dizzy_pollen.prototype.IsDebuff(self)
	return true
end
function modifier_item_0270_dizzy_pollen.prototype.IsPurgable(self)
	return true
end
function modifier_item_0270_dizzy_pollen.prototype.GetEffectName(self)
	return "particles/items5_fx/jidi_pollen_bag_debuff.vpcf"
end
function modifier_item_0270_dizzy_pollen.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_0270_dizzy_pollen.prototype.GetTexture(self)
	return "item_jidi_pollen_bag"
end
modifier_item_0270_dizzy_pollen = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0270_dizzy_pollen)
____exports.modifier_item_0270_dizzy_pollen = modifier_item_0270_dizzy_pollen
local modifier_item_0270 = __TS__Class()
modifier_item_0270.name = "modifier_item_0270"
__TS__ClassExtends(modifier_item_0270, BaseModifier_CS)
function modifier_item_0270.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0270.prototype.IsHidden(self)
	return true
end
function modifier_item_0270.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local target = event.target
	if not RollPercentage(40) then
		return
	end
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	AddDeBuffStatus(
		nil,
		target,
		event.attacker,
		self:GetAbility(),
		DebuffStatusType.POISON,
		{ stack = 1, effect_name = "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf" }
	)
end
modifier_item_0270 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0270)
return ____exports