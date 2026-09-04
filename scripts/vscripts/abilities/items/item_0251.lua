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
local ITEM_0251_BUFF_PARTICLE = "particles/items4_fx/item_polliwog_charmlvl3.vpcf"
--- 主动恢复，开启后持续回复固定生命值。
____exports.item_0251 = __TS__Class()
local item_0251 = ____exports.item_0251
item_0251.name = "item_0251"
__TS__ClassExtends(item_0251, BaseItem_CS)
function item_0251.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_0251_BUFF_PARTICLE, context)
end
function item_0251.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0251.prototype.OnSpellStart(self)
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
		____exports.modifier_item_0251_buff.name,
		{ duration = self:GetSpecialValueFor("ability_duration") }
	)
	caster:EmitSound("item_polliwog_charm.activate")
end
item_0251 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0251)
____exports.item_0251 = item_0251
____exports.modifier_item_0251_buff = __TS__Class()
local modifier_item_0251_buff = ____exports.modifier_item_0251_buff
modifier_item_0251_buff.name = "modifier_item_0251_buff"
__TS__ClassExtends(modifier_item_0251_buff, BaseModifier_CS)
function modifier_item_0251_buff.GetLocalizationCN(self)
	return { name = "呱呱", description = "持续回复生命值。" }
end
function modifier_item_0251_buff.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pfx = ParticleManager:CreateParticle(ITEM_0251_BUFF_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	local attach = PATTACH_POINT_FOLLOW
	local bone = "attach_hitloc"
	local origin = parent:GetAbsOrigin()
	for ____, cp in ipairs({
		0,
		1,
		2,
		3,
		5,
	}) do
		ParticleManager:SetParticleControlEnt(pfx, cp, parent, attach, bone, origin, true)
	end
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_item_0251_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_health_regen")
	else
		____ability_0 = 0
	end
	local healthRegen = ____ability_0
	return { health_regen = healthRegen }
end
function modifier_item_0251_buff.prototype.IsDebuff(self)
	return false
end
function modifier_item_0251_buff.prototype.IsPurgable(self)
	return true
end
modifier_item_0251_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0251_buff)
____exports.modifier_item_0251_buff = modifier_item_0251_buff
return ____exports