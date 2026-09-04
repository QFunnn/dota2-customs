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
____exports.item_0284 = __TS__Class()
local item_0284 = ____exports.item_0284
item_0284.name = "item_0284"
__TS__ClassExtends(item_0284, BaseItem_CS)
function item_0284.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET, cooldown = 90 }
end
function item_0284.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local ability_duration = self:GetSpecialValue("item_0284", "ability_duration")
	target:AddNewModifier(caster, self, ____exports.modifier_item_0284_fate_gaze.name, { duration = ability_duration })
	self:PlayEffects1(caster, target)
end
function item_0284.prototype.PlayEffects1(self, caster, target)
	caster:EmitSound("Hero_Oracle.PurifyingFlames.Damage")
	target:EmitSound("Hero_Oracle.FortunesEnd.Target")
end
item_0284 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0284)
____exports.item_0284 = item_0284
____exports.modifier_item_0284_fate_gaze = __TS__Class()
local modifier_item_0284_fate_gaze = ____exports.modifier_item_0284_fate_gaze
modifier_item_0284_fate_gaze.name = "modifier_item_0284_fate_gaze"
__TS__ClassExtends(modifier_item_0284_fate_gaze, BaseModifier_CS)
function modifier_item_0284_fate_gaze.GetLocalizationCN(self)
	return { name = "命运凝视", description = "魔法抗性与护甲降低。" }
end
function modifier_item_0284_fate_gaze.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_magic_resistance_reduce_pct =
		ability:GetSpecialValue("item_0284", "ability_magic_resistance_reduce_pct")
	local ability_armor_reduce = ability:GetSpecialValue("item_0284", "ability_armor_reduce")
	return {
		base_magic_resistance = -math.abs(ability_magic_resistance_reduce_pct),
		bonus_armor = -math.abs(ability_armor_reduce),
	}
end
function modifier_item_0284_fate_gaze.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:PlayEffects1()
end
function modifier_item_0284_fate_gaze.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:PlayEffects1()
end
function modifier_item_0284_fate_gaze.prototype.PlayEffects1(self)
	local effect = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_oracle/oracle_fortune_dmg.vpcf",
		PATTACH_POINT,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		effect,
		0,
		self._caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self._caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		effect,
		1,
		self._caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self._caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		effect,
		3,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:AddParticle(effect, false, false, -1, true, false)
end
function modifier_item_0284_fate_gaze.prototype.IsHidden(self)
	return false
end
function modifier_item_0284_fate_gaze.prototype.IsDebuff(self)
	return true
end
function modifier_item_0284_fate_gaze.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_oracle/oracle_fortune_purge.vpcf"
end
function modifier_item_0284_fate_gaze.prototype.IsPurgable(self)
	return true
end
function modifier_item_0284_fate_gaze.prototype.GetTexture(self)
	return "item_prophets_pendulum"
end
modifier_item_0284_fate_gaze = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0284_fate_gaze)
____exports.modifier_item_0284_fate_gaze = modifier_item_0284_fate_gaze
return ____exports