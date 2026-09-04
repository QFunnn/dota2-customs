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
____exports.item_0260 = __TS__Class()
local item_0260 = ____exports.item_0260
item_0260.name = "item_0260"
__TS__ClassExtends(item_0260, BaseItem_CS)
function item_0260.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET }
end
function item_0260.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	if target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() ~= caster:GetTeamNumber() then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	local ability_mana_restore_total = self:GetSpecialValueFor("ability_mana_restore_total")
	target:AddNewModifier(
		caster,
		self,
		____exports.modifier_item_0260_mana_regen.name,
		{
			duration = ability_duration,
			ability_mana_restore_total = ability_mana_restore_total,
			ability_duration = ability_duration,
		}
	)
	self:PlayEffects1(caster)
end
function item_0260.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.ClarityPotion.Activate")
end
item_0260 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0260)
____exports.item_0260 = item_0260
____exports.modifier_item_0260_mana_regen = __TS__Class()
local modifier_item_0260_mana_regen = ____exports.modifier_item_0260_mana_regen
modifier_item_0260_mana_regen.name = "modifier_item_0260_mana_regen"
__TS__ClassExtends(modifier_item_0260_mana_regen, BaseModifier_CS)
function modifier_item_0260_mana_regen.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ability_mana_regen_constant = 0
end
function modifier_item_0260_mana_regen.prototype.IsHidden(self)
	return false
end
function modifier_item_0260_mana_regen.prototype.IsDebuff(self)
	return false
end
function modifier_item_0260_mana_regen.prototype.IsPurgable(self)
	return true
end
function modifier_item_0260_mana_regen.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local total = math.max(0, tonumber(params.ability_mana_restore_total or 0))
	local duration = math.max(0.01, tonumber(params.ability_duration or self:GetDuration() or 0))
	self.ability_mana_regen_constant = total / duration
	self:PlayEffects2(self:GetParent())
end
function modifier_item_0260_mana_regen.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT }
end
function modifier_item_0260_mana_regen.prototype.GetModifierConstantManaRegen(self)
	return self.ability_mana_regen_constant
end
function modifier_item_0260_mana_regen.prototype.PlayEffects2(self, target)
	local pfx =
		ParticleManager:CreateParticle("particles/items_fx/healing_clarity.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(pfx, 0, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetAbsOrigin(), true)
	self:AddParticle(pfx, false, false, -1, false, false)
end
modifier_item_0260_mana_regen = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0260_mana_regen)
____exports.modifier_item_0260_mana_regen = modifier_item_0260_mana_regen
return ____exports