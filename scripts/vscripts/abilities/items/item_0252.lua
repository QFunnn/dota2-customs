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
local ITEM_0252_BUFF_PARTICLE = "particles/econ/courier/courier_golden_roshan/golden_roshan_ambient.vpcf"
--- 主动幸运，短时间提升掉落幸运百分比。
____exports.item_0252 = __TS__Class()
local item_0252 = ____exports.item_0252
item_0252.name = "item_0252"
__TS__ClassExtends(item_0252, BaseItem_CS)
function item_0252.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_0252_BUFF_PARTICLE, context)
end
function item_0252.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0252.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:AddNewModifier(
		caster,
		self,
		____exports.modifier_item_0252_buff.name,
		{ duration = self:GetSpecialValueFor("ability_duration") }
	)
	caster:EmitSound("ui.treasure_01")
end
item_0252 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0252)
____exports.item_0252 = item_0252
____exports.modifier_item_0252_buff = __TS__Class()
local modifier_item_0252_buff = ____exports.modifier_item_0252_buff
modifier_item_0252_buff.name = "modifier_item_0252_buff"
__TS__ClassExtends(modifier_item_0252_buff, BaseModifier_CS)
function modifier_item_0252_buff.GetLocalizationCN(self)
	return { name = "休眠协议", description = "提高物品掉落幸运。" }
end
function modifier_item_0252_buff.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pfx = ParticleManager:CreateParticle(ITEM_0252_BUFF_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_item_0252_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_item_drop_luck_pct")
	else
		____ability_0 = 0
	end
	local bonusLuckPct = ____ability_0
	return { item_drop_luck_pct = bonusLuckPct }
end
function modifier_item_0252_buff.prototype.IsDebuff(self)
	return false
end
function modifier_item_0252_buff.prototype.IsPurgable(self)
	return true
end
modifier_item_0252_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0252_buff)
____exports.modifier_item_0252_buff = modifier_item_0252_buff
return ____exports