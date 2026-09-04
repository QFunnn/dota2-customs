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
local ITEM_0265_DEBUFF_PARTICLE = "particles/items2_fx/medallion_of_courage.vpcf"
____exports.item_0265 = __TS__Class()
local item_0265 = ____exports.item_0265
item_0265.name = "item_0265"
__TS__ClassExtends(item_0265, BaseItem_CS)
function item_0265.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_0265_DEBUFF_PARTICLE, context)
end
function item_0265.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET }
end
function item_0265.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	local ability_incoming_damage_increase_pct = self:GetSpecialValueFor("ability_incoming_damage_increase_pct")
	target:AddNewModifier(
		caster,
		self,
		____exports.modifier_item_0265_exposed.name,
		{ duration = ability_duration, incoming_damage_increase_pct = ability_incoming_damage_increase_pct }
	)
	self:PlayEffects1(target)
end
function item_0265.prototype.PlayEffects1(self, target)
	target:EmitSound("DOTA_Item.MedallionOfCourage.Activate")
end
item_0265 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0265)
____exports.item_0265 = item_0265
____exports.modifier_item_0265_exposed = __TS__Class()
local modifier_item_0265_exposed = ____exports.modifier_item_0265_exposed
modifier_item_0265_exposed.name = "modifier_item_0265_exposed"
__TS__ClassExtends(modifier_item_0265_exposed, BaseModifier_CS)
function modifier_item_0265_exposed.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.incomingDamageIncreasePct = 0
end
function modifier_item_0265_exposed.GetLocalizationCN(self)
	return { name = "示众", description = "承受的所有伤害提高。" }
end
function modifier_item_0265_exposed.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	self.incomingDamageIncreasePct = params.incoming_damage_increase_pct
		or ability and ability:GetSpecialValueFor("ability_incoming_damage_increase_pct")
		or 0
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pfx = ParticleManager:CreateParticle(ITEM_0265_DEBUFF_PARTICLE, PATTACH_OVERHEAD_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_OVERHEAD_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(pfx, 1, parent, PATTACH_ABSORIGIN_FOLLOW, nil, parent:GetAbsOrigin(), true)
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_item_0265_exposed.prototype.GetAttributeBonus(self)
	return { incoming_damage_increase_pct = self.incomingDamageIncreasePct }
end
function modifier_item_0265_exposed.prototype.IsDebuff(self)
	return true
end
function modifier_item_0265_exposed.prototype.IsPurgable(self)
	return true
end
modifier_item_0265_exposed = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0265_exposed)
____exports.modifier_item_0265_exposed = modifier_item_0265_exposed
return ____exports