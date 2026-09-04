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
____exports.item_0533 = __TS__Class()
local item_0533 = ____exports.item_0533
item_0533.name = "item_0533"
__TS__ClassExtends(item_0533, BaseItem_CS)
function item_0533.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE }
end
function item_0533.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = math.max(0.1, self:GetSpecialValueFor("ability_value_duration"))
	local snapshot = self:GetLifestealSnapshot(caster)
	caster:AddNewModifier(
		caster,
		self,
		____exports.modifier_item_0533_unholy_frenzy.name,
		{
			duration = ability_duration,
			ability_physical_lifesteal_bonus_pct = snapshot.ability_physical_lifesteal_bonus_pct,
			ability_magical_lifesteal_bonus_pct = snapshot.ability_magical_lifesteal_bonus_pct,
		}
	)
	self:PlayEffects1(caster)
end
function item_0533.prototype.GetLifestealSnapshot(self, caster)
	local existing = caster:FindModifierByName(____exports.modifier_item_0533_unholy_frenzy.name)
	local existingPhysicalBonus = existing and existing:GetPhysicalLifestealBonus() or 0
	local existingMagicalBonus = existing and existing:GetMagicalLifestealBonus() or 0
	local ability_physical_lifesteal_pct =
		math.max(0, (MyGameAttribute:GetAttribute(caster, "physical_lifesteal_pct") or 0) - existingPhysicalBonus)
	local ability_magical_lifesteal_pct =
		math.max(0, (MyGameAttribute:GetAttribute(caster, "magical_lifesteal_pct") or 0) - existingMagicalBonus)
	local ability_omni_lifesteal_pct = math.max(0, MyGameAttribute:GetAttribute(caster, "omni_lifesteal_pct") or 0)
	return {
		ability_physical_lifesteal_bonus_pct = ability_physical_lifesteal_pct + ability_omni_lifesteal_pct,
		ability_magical_lifesteal_bonus_pct = ability_magical_lifesteal_pct + ability_omni_lifesteal_pct,
	}
end
function item_0533.prototype.PlayEffects1(self, caster)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/items3_fx/octarine_core_lifesteal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		caster:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	caster:EmitSound("DOTA_Item.Satanic.Activate")
end
item_0533 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0533)
____exports.item_0533 = item_0533
____exports.modifier_item_0533_unholy_frenzy = __TS__Class()
local modifier_item_0533_unholy_frenzy = ____exports.modifier_item_0533_unholy_frenzy
modifier_item_0533_unholy_frenzy.name = "modifier_item_0533_unholy_frenzy"
__TS__ClassExtends(modifier_item_0533_unholy_frenzy, BaseModifier_CS)
function modifier_item_0533_unholy_frenzy.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ability_physical_lifesteal_bonus_pct = 0
	self.ability_magical_lifesteal_bonus_pct = 0
end
function modifier_item_0533_unholy_frenzy.GetLocalizationCN(self)
	return { name = "不洁狂热", description = "物理吸血与魔法吸血翻倍。" }
end
function modifier_item_0533_unholy_frenzy.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetBonusFromParams(params)
	self:PlayEffects1()
end
function modifier_item_0533_unholy_frenzy.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:SetBonusFromParams(params)
end
function modifier_item_0533_unholy_frenzy.prototype.GetPhysicalLifestealBonus(self)
	return self.ability_physical_lifesteal_bonus_pct
end
function modifier_item_0533_unholy_frenzy.prototype.GetMagicalLifestealBonus(self)
	return self.ability_magical_lifesteal_bonus_pct
end
function modifier_item_0533_unholy_frenzy.prototype.GetAttributeBonus(self)
	return {
		physical_lifesteal_pct = self.ability_physical_lifesteal_bonus_pct,
		magical_lifesteal_pct = self.ability_magical_lifesteal_bonus_pct,
	}
end
function modifier_item_0533_unholy_frenzy.prototype.IsHidden(self)
	return false
end
function modifier_item_0533_unholy_frenzy.prototype.IsDebuff(self)
	return false
end
function modifier_item_0533_unholy_frenzy.prototype.IsPurgable(self)
	return true
end
function modifier_item_0533_unholy_frenzy.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_life_stealer_rage.vpcf"
end
function modifier_item_0533_unholy_frenzy.prototype.GetTexture(self)
	return "item_satanic"
end
function modifier_item_0533_unholy_frenzy.prototype.SetBonusFromParams(self, params)
	self.ability_physical_lifesteal_bonus_pct = math.max(
		0,
		tonumber(params and params.ability_physical_lifesteal_bonus_pct or self.ability_physical_lifesteal_bonus_pct)
			or 0
	)
	self.ability_magical_lifesteal_bonus_pct = math.max(
		0,
		tonumber(params and params.ability_magical_lifesteal_bonus_pct or self.ability_magical_lifesteal_bonus_pct) or 0
	)
end
function modifier_item_0533_unholy_frenzy.prototype.PlayEffects1(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_life_stealer/life_stealer_rage.vpcf",
		PATTACH_CENTER_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, true, false)
end
modifier_item_0533_unholy_frenzy = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0533_unholy_frenzy)
____exports.modifier_item_0533_unholy_frenzy = modifier_item_0533_unholy_frenzy
return ____exports