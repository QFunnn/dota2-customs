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
--- 主动战盾，给自己减速并为周围友军提供护盾上限与当前护盾。
____exports.item_0255 = __TS__Class()
local item_0255 = ____exports.item_0255
item_0255.name = "item_0255"
__TS__ClassExtends(item_0255, BaseItem_CS)
function item_0255.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items3_fx/star_emblem_friend.vpcf", context)
end
function item_0255.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0255.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	local ability_aura_radius = self:GetSpecialValueFor("ability_aura_radius")
	caster:AddNewModifier(caster, self, ____exports.modifier_item_0255_self_slow.name, { duration = ability_duration })
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		ability_aura_radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, ally in ipairs(allies) do
		ally:AddNewModifier(caster, self, ____exports.modifier_item_0255_shield.name, { duration = ability_duration })
	end
	self:PlayEffects1(caster)
end
function item_0255.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.DoE.Activate")
end
item_0255 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0255)
____exports.item_0255 = item_0255
____exports.modifier_item_0255_self_slow = __TS__Class()
local modifier_item_0255_self_slow = ____exports.modifier_item_0255_self_slow
modifier_item_0255_self_slow.name = "modifier_item_0255_self_slow"
__TS__ClassExtends(modifier_item_0255_self_slow, BaseModifier_CS)
function modifier_item_0255_self_slow.GetLocalizationCN(self)
	return { name = "战盾", description = "移动速度降低。" }
end
function modifier_item_0255_self_slow.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_self_movespeed")
	else
		____ability_0 = 0
	end
	local ability_self_movespeed = ____ability_0
	return { base_movespeed = -math.abs(ability_self_movespeed) }
end
function modifier_item_0255_self_slow.prototype.IsDebuff(self)
	return false
end
function modifier_item_0255_self_slow.prototype.IsPurgable(self)
	return true
end
modifier_item_0255_self_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0255_self_slow)
____exports.modifier_item_0255_self_slow = modifier_item_0255_self_slow
____exports.modifier_item_0255_shield = __TS__Class()
local modifier_item_0255_shield = ____exports.modifier_item_0255_shield
modifier_item_0255_shield.name = "modifier_item_0255_shield"
__TS__ClassExtends(modifier_item_0255_shield, BaseModifier_CS)
function modifier_item_0255_shield.GetLocalizationCN(self)
	return { name = "战盾", description = "额外获得护盾值上限与当前护盾。" }
end
function modifier_item_0255_shield.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:PlayEffects1()
	self:ApplyShield()
end
function modifier_item_0255_shield.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:ApplyShield()
end
function modifier_item_0255_shield.prototype.GetAttributeBonus(self)
	return { base_energy_shield = self:CalculateShieldAmount() }
end
function modifier_item_0255_shield.prototype.IsDebuff(self)
	return false
end
function modifier_item_0255_shield.prototype.IsPurgable(self)
	return true
end
function modifier_item_0255_shield.prototype.ApplyShield(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local shieldAmount = self:CalculateShieldAmount()
	if shieldAmount <= 0 then
		return
	end
	parent:AddCurrentEnergyShield(shieldAmount, "next_frame_delta")
	self:RefreshAttributes()
end
function modifier_item_0255_shield.prototype.CalculateShieldAmount(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return 0
	end
	local ability_shield_amount = ability:GetSpecialValueFor("ability_value_shield_amount")
	return parent:GetMaxHealth() * (ability_shield_amount / 100)
end
function modifier_item_0255_shield.prototype.PlayEffects1(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local overheadParticle =
		ParticleManager:CreateParticle("particles/items3_fx/star_emblem_friend.vpcf", PATTACH_CENTER_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		overheadParticle,
		0,
		parent,
		PATTACH_OVERHEAD_FOLLOW,
		"follow_overhead",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		overheadParticle,
		1,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		overheadParticle,
		5,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(overheadParticle, false, false, -1, false, false)
end
modifier_item_0255_shield = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0255_shield)
____exports.modifier_item_0255_shield = modifier_item_0255_shield
return ____exports