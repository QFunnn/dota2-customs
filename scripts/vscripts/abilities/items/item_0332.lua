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
____exports.item_0332 = __TS__Class()
local item_0332 = ____exports.item_0332
item_0332.name = "item_0332"
__TS__ClassExtends(item_0332, BaseItem_CS)
function item_0332.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0332.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_value_duration")
	if ability_duration <= 0 then
		return
	end
	caster:AddNewModifier(caster, self, ____exports.modifier_item_0332_madness.name, { duration = ability_duration })
	self:PlayEffects1(caster)
end
function item_0332.prototype.PlayEffects1(self, caster)
	EmitSoundOn("DOTA_Item.MaskOfMadness.Activate", caster)
end
item_0332 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0332)
____exports.item_0332 = item_0332
____exports.modifier_item_0332_madness = __TS__Class()
local modifier_item_0332_madness = ____exports.modifier_item_0332_madness
modifier_item_0332_madness.name = "modifier_item_0332_madness"
__TS__ClassExtends(modifier_item_0332_madness, BaseModifier_CS)
function modifier_item_0332_madness.GetLocalizationCN(self)
	return { name = "疯狂", description = "攻击速度、移动速度和冷却缩减提高。" }
end
function modifier_item_0332_madness.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:PlayEffects1(self:GetParent())
end
function modifier_item_0332_madness.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:PlayEffects1(self:GetParent())
end
function modifier_item_0332_madness.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_value_bonus_attack_speed")
	else
		____ability_0 = 0
	end
	local ability_bonus_attack_speed = ____ability_0
	local ____ability_1
	if ability then
		____ability_1 = ability:GetSpecialValueFor("ability_value_bonus_move_speed")
	else
		____ability_1 = 0
	end
	local ability_bonus_move_speed = ____ability_1
	local ____ability_2
	if ability then
		____ability_2 = ability:GetSpecialValueFor("ability_cooldown_reduction_pct")
	else
		____ability_2 = 0
	end
	local ability_cooldown_reduction_pct = ____ability_2
	return {
		attack_speed = ability_bonus_attack_speed,
		base_movespeed = ability_bonus_move_speed,
		cooldown_reduction_pct = ability_cooldown_reduction_pct,
	}
end
function modifier_item_0332_madness.prototype.IsPurgable(self)
	return true
end
function modifier_item_0332_madness.prototype.IsHidden(self)
	return false
end
function modifier_item_0332_madness.prototype.IsDebuff(self)
	return false
end
function modifier_item_0332_madness.prototype.PlayEffects1(self, parent)
	local particle =
		ParticleManager:CreateParticle("particles/items2_fx/mask_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end
modifier_item_0332_madness = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0332_madness)
____exports.modifier_item_0332_madness = modifier_item_0332_madness
return ____exports