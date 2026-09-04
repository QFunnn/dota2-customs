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
____exports.item_0280 = __TS__Class()
local item_0280 = ____exports.item_0280
item_0280.name = "item_0280"
__TS__ClassExtends(item_0280, BaseItem_CS)
function item_0280.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0280.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = self:GetSpecialValue("item_0280", "ability_duration")
	caster:AddNewModifier(caster, self, ____exports.modifier_item_0280_bloodlust.name, { duration = ability_duration })
	self:PlayEffects1(caster)
end
function item_0280.prototype.PlayEffects1(self, caster)
	caster:EmitSound("Hero_LifeStealer.Rage")
end
item_0280 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0280)
____exports.item_0280 = item_0280
____exports.modifier_item_0280_bloodlust = __TS__Class()
local modifier_item_0280_bloodlust = ____exports.modifier_item_0280_bloodlust
modifier_item_0280_bloodlust.name = "modifier_item_0280_bloodlust"
__TS__ClassExtends(modifier_item_0280_bloodlust, BaseModifier_CS)
function modifier_item_0280_bloodlust.GetLocalizationCN(self)
	return { name = "嗜血渴望", description = "攻击伤害与攻击吸血提升。" }
end
function modifier_item_0280_bloodlust.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_all_attack_damage_percent = ability:GetSpecialValue("item_0280", "ability_all_attack_damage_percent")
	local ability_attack_lifesteal_pct = ability:GetSpecialValue("item_0280", "ability_physical_lifesteal_pct")
	return {
		all_attack_damage_percent = ability_all_attack_damage_percent,
		attack_lifesteal_pct = ability_attack_lifesteal_pct,
	}
end
function modifier_item_0280_bloodlust.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local effect = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_life_stealer/life_stealer_rage.vpcf",
		PATTACH_CENTER_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(effect, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 1, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		effect,
		2,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:AddParticle(effect, false, false, -1, true, false)
end
function modifier_item_0280_bloodlust.prototype.IsHidden(self)
	return false
end
function modifier_item_0280_bloodlust.prototype.IsPurgable(self)
	return true
end
function modifier_item_0280_bloodlust.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_life_stealer_rage.vpcf"
end
function modifier_item_0280_bloodlust.prototype.GetTexture(self)
	return "item_flayers_bota"
end
modifier_item_0280_bloodlust = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0280_bloodlust)
____exports.modifier_item_0280_bloodlust = modifier_item_0280_bloodlust
return ____exports