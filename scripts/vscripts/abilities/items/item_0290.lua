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
local ITEM_0290_OVERRIDE_MOVESPEED = 450
local ITEM_0290_TRAP_IMMUNITY_KEY = "免疫陷阱"
____exports.item_0290 = __TS__Class()
local item_0290 = ____exports.item_0290
item_0290.name = "item_0290"
__TS__ClassExtends(item_0290, BaseItem_CS)
function item_0290.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0290.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	caster:Purge(false, true, false, true, true)
	caster:AddNewModifier(caster, self, ____exports.modifier_item_0290_web_walk.name, { duration = ability_duration })
	caster:EmitSound("DOTA_Item.SpiderLegs.Cast")
end
item_0290 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0290)
____exports.item_0290 = item_0290
____exports.modifier_item_0290_web_walk = __TS__Class()
local modifier_item_0290_web_walk = ____exports.modifier_item_0290_web_walk
modifier_item_0290_web_walk.name = "modifier_item_0290_web_walk"
__TS__ClassExtends(modifier_item_0290_web_walk, BaseModifier_CS)
function modifier_item_0290_web_walk.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.appliedTrapImmunity = false
end
function modifier_item_0290_web_walk.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:ApplyTrapImmunity(true)
	self:PlayEffects1()
end
function modifier_item_0290_web_walk.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:ApplyTrapImmunity(false)
end
function modifier_item_0290_web_walk.GetLocalizationCN(self)
	return {
		name = "蛛网穿行",
		description = "覆盖移动速度并解除移动限制，同时免疫陷阱效果。",
	}
end
function modifier_item_0290_web_walk.prototype.GetAttributeBonus(self)
	return { override_movespeed = ITEM_0290_OVERRIDE_MOVESPEED }
end
function modifier_item_0290_web_walk.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_item_0290_web_walk.prototype.IsHidden(self)
	return false
end
function modifier_item_0290_web_walk.prototype.IsPurgable(self)
	return true
end
function modifier_item_0290_web_walk.prototype.IsDebuff(self)
	return false
end
function modifier_item_0290_web_walk.prototype.PlayEffects1(self)
	local pfx = ParticleManager:CreateParticle(
		"particles/items5_fx/spider_legs_buff_2.vpcf",
		PATTACH_ROOTBONE_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		self:GetParent(),
		PATTACH_ROOTBONE_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		self:GetParent(),
		PATTACH_ROOTBONE_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_item_0290_web_walk.prototype.ApplyTrapImmunity(self, enable)
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) then
		return
	end
	if enable then
		if self.appliedTrapImmunity then
			return
		end
		local current = tonumber(parent:GetCustomValue(ITEM_0290_TRAP_IMMUNITY_KEY) or 0)
		parent:SetCustomValue(ITEM_0290_TRAP_IMMUNITY_KEY, current + 1)
		self.appliedTrapImmunity = true
		return
	end
	if not self.appliedTrapImmunity then
		return
	end
	local current = tonumber(parent:GetCustomValue(ITEM_0290_TRAP_IMMUNITY_KEY) or 0)
	parent:SetCustomValue(ITEM_0290_TRAP_IMMUNITY_KEY, math.max(0, current - 1))
	self.appliedTrapImmunity = false
end
modifier_item_0290_web_walk = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0290_web_walk)
____exports.modifier_item_0290_web_walk = modifier_item_0290_web_walk
return ____exports