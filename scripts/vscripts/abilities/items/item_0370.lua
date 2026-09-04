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
____exports.item_0370 = __TS__Class()
local item_0370 = ____exports.item_0370
item_0370.name = "item_0370"
__TS__ClassExtends(item_0370, BaseItem_CS)
function item_0370.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0370_shadow_blade.name
end
item_0370 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0370)
____exports.item_0370 = item_0370
____exports.modifier_item_0370_shadow_blade = __TS__Class()
local modifier_item_0370_shadow_blade = ____exports.modifier_item_0370_shadow_blade
modifier_item_0370_shadow_blade.name = "modifier_item_0370_shadow_blade"
__TS__ClassExtends(modifier_item_0370_shadow_blade, BaseModifier_CS)
function modifier_item_0370_shadow_blade.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0370_shadow_blade.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not event.is_crit or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_duration = ability:GetSpecialValueFor("ability_duration")
	if ability_duration <= 0 then
		return
	end
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0370_shadow_haste.name,
		{ duration = ability_duration }
	)
	self:PlayEffects1(parent)
end
function modifier_item_0370_shadow_blade.prototype.IsHidden(self)
	return true
end
function modifier_item_0370_shadow_blade.prototype.IsPurgable(self)
	return false
end
function modifier_item_0370_shadow_blade.prototype.PlayEffects1(self, parent)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/items2_fx/phase_boots.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		parent:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("DOTA_Item.PhaseBoots.Activate", parent)
end
modifier_item_0370_shadow_blade = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0370_shadow_blade)
____exports.modifier_item_0370_shadow_blade = modifier_item_0370_shadow_blade
____exports.modifier_item_0370_shadow_haste = __TS__Class()
local modifier_item_0370_shadow_haste = ____exports.modifier_item_0370_shadow_haste
modifier_item_0370_shadow_haste.name = "modifier_item_0370_shadow_haste"
__TS__ClassExtends(modifier_item_0370_shadow_haste, BaseModifier_CS)
function modifier_item_0370_shadow_haste.GetLocalizationCN(self)
	return { name = "野性", description = "移动速度提升。" }
end
function modifier_item_0370_shadow_haste.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_bonus_movespeed_pct = math.max(0, ability:GetSpecialValueFor("ability_bonus_movespeed_pct"))
	return { bonus_movespeed_pct = ability_bonus_movespeed_pct }
end
function modifier_item_0370_shadow_haste.prototype.IsHidden(self)
	return false
end
function modifier_item_0370_shadow_haste.prototype.IsDebuff(self)
	return false
end
function modifier_item_0370_shadow_haste.prototype.IsPurgable(self)
	return true
end
function modifier_item_0370_shadow_haste.prototype.GetTexture(self)
	return "item_icon_m52_08"
end
modifier_item_0370_shadow_haste = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0370_shadow_haste)
____exports.modifier_item_0370_shadow_haste = modifier_item_0370_shadow_haste
return ____exports