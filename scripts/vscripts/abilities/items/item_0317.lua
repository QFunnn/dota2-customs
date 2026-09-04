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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local item_0317 = __TS__Class()
item_0317.name = "item_0317"
__TS__ClassExtends(item_0317, BaseItem_CS)
function item_0317.prototype.GetDurationValue(self)
	return self:GetSpecialValueFor("ability_duration")
end
function item_0317.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0317.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:AddNewModifier(caster, self, "modifier_item_0317_madness", { duration = self:GetDurationValue() })
	caster:EmitSound("DOTA_Item.MaskOfMadness.Activate")
end
item_0317 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0317)
local modifier_item_0317_madness = __TS__Class()
modifier_item_0317_madness.name = "modifier_item_0317_madness"
__TS__ClassExtends(modifier_item_0317_madness, BaseModifier_CS)
function modifier_item_0317_madness.GetLocalizationCN(self)
	return { name = "疯狂", description = "攻击速度和移动速度提高，护甲降低。" }
end
function modifier_item_0317_madness.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local particle =
		ParticleManager:CreateParticle("particles/items2_fx/mask_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_item_0317_madness.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_bonus_attack_speed")
	else
		____ability_0 = 0
	end
	local bonusAttackSpeed = ____ability_0
	local ____ability_1
	if ability then
		____ability_1 = ability:GetSpecialValueFor("ability_bonus_move_speed")
	else
		____ability_1 = 0
	end
	local bonusMoveSpeed = ____ability_1
	local ____ability_2
	if ability then
		____ability_2 = ability:GetSpecialValueFor("ability_armor_reduction")
	else
		____ability_2 = 0
	end
	local armorReduction = ____ability_2
	return { attack_speed = bonusAttackSpeed, base_movespeed = bonusMoveSpeed, bonus_armor = -armorReduction }
end
function modifier_item_0317_madness.prototype.IsPurgable(self)
	return true
end
function modifier_item_0317_madness.prototype.IsHidden(self)
	return false
end
function modifier_item_0317_madness.prototype.IsDebuff(self)
	return false
end
modifier_item_0317_madness = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0317_madness)
return ____exports