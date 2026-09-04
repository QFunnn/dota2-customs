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
____exports.item_0305 = __TS__Class()
local item_0305 = ____exports.item_0305
item_0305.name = "item_0305"
__TS__ClassExtends(item_0305, BaseItem_CS)
function item_0305.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0305.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	local ability_all_attack_damage_percent = self:GetSpecialValueFor("ability_value_all_attack_damage_percent")
	local ability_base_health_pct = self:GetSpecialValueFor("ability_value_base_health_pct")
	local ability_bonus_attack_damage = math.max(0, MyGameAttribute:GetAttribute(caster, "total_attack_damage") or 0)
		* (ability_all_attack_damage_percent / 100)
	local ability_bonus_health = math.max(0, caster:GetMaxHealth()) * (ability_base_health_pct / 100)
	caster:AddNewModifier(
		caster,
		self,
		____exports.modifier_item_0305_buff.name,
		{
			duration = ability_duration,
			ability_bonus_attack_damage = ability_bonus_attack_damage,
			ability_bonus_health = ability_bonus_health,
		}
	)
	self:PlayEffects1(caster)
end
function item_0305.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.MaskOfMadness.Activate")
end
item_0305 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0305)
____exports.item_0305 = item_0305
____exports.modifier_item_0305_buff = __TS__Class()
local modifier_item_0305_buff = ____exports.modifier_item_0305_buff
modifier_item_0305_buff.name = "modifier_item_0305_buff"
__TS__ClassExtends(modifier_item_0305_buff, BaseModifier_CS)
function modifier_item_0305_buff.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ability_bonus_attack_damage = 0
	self.ability_bonus_health = 0
end
function modifier_item_0305_buff.GetLocalizationCN(self)
	return { name = "笨拙", description = "移动速度降低，最大攻击力和最大生命值提高。" }
end
function modifier_item_0305_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_self_movespeed_pct = ability:GetSpecialValueFor("ability_self_movespeed_pct")
	return {
		bonus_movespeed_pct = -ability_self_movespeed_pct,
		bonus_attack_damage = self.ability_bonus_attack_damage,
		bonus_health = self.ability_bonus_health,
	}
end
function modifier_item_0305_buff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:ApplySnapshot(params)
	self:PlayEffects2()
end
function modifier_item_0305_buff.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:ApplySnapshot(params)
end
function modifier_item_0305_buff.prototype.IsHidden(self)
	return false
end
function modifier_item_0305_buff.prototype.IsPurgable(self)
	return true
end
function modifier_item_0305_buff.prototype.IsDebuff(self)
	return false
end
function modifier_item_0305_buff.prototype.ApplySnapshot(self, params)
	self.ability_bonus_attack_damage = math.max(0, tonumber(params.ability_bonus_attack_damage or 0))
	self.ability_bonus_health = math.max(0, tonumber(params.ability_bonus_health or 0))
	self:RefreshAttributes()
end
function modifier_item_0305_buff.prototype.PlayEffects2(self)
	local parent = self:GetParent()
	local particle =
		ParticleManager:CreateParticle("particles/items2_fx/mask_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end
modifier_item_0305_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0305_buff)
____exports.modifier_item_0305_buff = modifier_item_0305_buff
return ____exports