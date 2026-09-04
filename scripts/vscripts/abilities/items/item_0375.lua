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
____exports.item_0375 = __TS__Class()
local item_0375 = ____exports.item_0375
item_0375.name = "item_0375"
__TS__ClassExtends(item_0375, BaseItem_CS)
function item_0375.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0375_slow_ring.name
end
item_0375 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0375)
____exports.item_0375 = item_0375
____exports.modifier_item_0375_slow_ring = __TS__Class()
local modifier_item_0375_slow_ring = ____exports.modifier_item_0375_slow_ring
modifier_item_0375_slow_ring.name = "modifier_item_0375_slow_ring"
__TS__ClassExtends(modifier_item_0375_slow_ring, BaseModifier_CS)
function modifier_item_0375_slow_ring.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0375_slow_ring.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_trigger_chance_pct = math.max(0, ability:GetSpecialValueFor("ability_trigger_chance_pct"))
	if not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	local ability_duration = ability:GetSpecialValueFor("ability_duration")
	if ability_duration <= 0 then
		return
	end
	if NotifyCustomDebuffApplyQuery(nil, target, parent, ability, ____exports.modifier_item_0375_slow.name) then
		target:AddNewModifier(
			parent,
			ability,
			____exports.modifier_item_0375_slow.name,
			{ duration = ability_duration }
		)
	end
	self:StartAbilityCooldown(ability)
	self:PlayEffects1(target)
end
function modifier_item_0375_slow_ring.prototype.IsHidden(self)
	return true
end
function modifier_item_0375_slow_ring.prototype.IsPurgable(self)
	return false
end
function modifier_item_0375_slow_ring.prototype.StartAbilityCooldown(self, ability)
	local ability_cooldown = ability:GetSpecialValueFor("ability_cooldown")
	if ability_cooldown > 0 then
		ability:StartCooldown(ability_cooldown)
	end
end
function modifier_item_0375_slow_ring.prototype.PlayEffects1(self, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/items_fx/diffusal_slow.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("DOTA_Item.DiffusalBlade.Target", target)
end
modifier_item_0375_slow_ring = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0375_slow_ring)
____exports.modifier_item_0375_slow_ring = modifier_item_0375_slow_ring
____exports.modifier_item_0375_slow = __TS__Class()
local modifier_item_0375_slow = ____exports.modifier_item_0375_slow
modifier_item_0375_slow.name = "modifier_item_0375_slow"
__TS__ClassExtends(modifier_item_0375_slow, BaseModifier_CS)
function modifier_item_0375_slow.GetLocalizationCN(self)
	return { name = "迟缓", description = "移动速度降低。" }
end
function modifier_item_0375_slow.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_slow_pct = math.max(0, ability:GetSpecialValueFor("ability_slow_pct"))
	return { bonus_movespeed_pct = -ability_slow_pct }
end
function modifier_item_0375_slow.prototype.IsHidden(self)
	return false
end
function modifier_item_0375_slow.prototype.IsDebuff(self)
	return true
end
function modifier_item_0375_slow.prototype.IsPurgable(self)
	return true
end
function modifier_item_0375_slow.prototype.GetTexture(self)
	return "item_icon_eq02_15"
end
modifier_item_0375_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0375_slow)
____exports.modifier_item_0375_slow = modifier_item_0375_slow
return ____exports