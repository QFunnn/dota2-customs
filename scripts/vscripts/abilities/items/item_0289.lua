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
____exports.item_0289 = __TS__Class()
local item_0289 = ____exports.item_0289
item_0289.name = "item_0289"
__TS__ClassExtends(item_0289, BaseItem_CS)
function item_0289.prototype.Precache(self, context)
	PrecacheResource("particle", ____exports.item_0289.PARTICLE_BUFF_EFFECT, context)
end
function item_0289.prototype.OnSpellStart(self)
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
		____exports.modifier_item_0289_buff.name,
		{ duration = self:GetSpecialValueFor("ability_duration") }
	)
	self:PlayEffects1(caster)
end
function item_0289.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.DoE.Activate")
end
item_0289.PARTICLE_BUFF_EFFECT = "particles/items_fx/drum_of_endurance_buff.vpcf"
item_0289 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0289)
____exports.item_0289 = item_0289
____exports.modifier_item_0289_buff = __TS__Class()
local modifier_item_0289_buff = ____exports.modifier_item_0289_buff
modifier_item_0289_buff.name = "modifier_item_0289_buff"
__TS__ClassExtends(modifier_item_0289_buff, BaseModifier_CS)
function modifier_item_0289_buff.prototype.IsDebuff(self)
	return false
end
function modifier_item_0289_buff.prototype.IsPurgable(self)
	return true
end
function modifier_item_0289_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return { bonus_strength = ability:GetSpecialValueFor("ability_bonus_strength") }
end
function modifier_item_0289_buff.prototype.GetEffectName(self)
	return ____exports.item_0289.PARTICLE_BUFF_EFFECT
end
function modifier_item_0289_buff.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_0289_buff.prototype.GetTexture(self)
	return "item_minotaur_horn"
end
modifier_item_0289_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0289_buff)
____exports.modifier_item_0289_buff = modifier_item_0289_buff
return ____exports