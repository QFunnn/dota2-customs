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
local px2 = "particles/void_spirit_astral_step_impact_blue.vpcf"
local item_0158 = __TS__Class()
item_0158.name = "item_0158"
__TS__ClassExtends(item_0158, BaseItem_CS)
function item_0158.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0158"
end
item_0158 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0158)
local modifier_item_0158 = __TS__Class()
modifier_item_0158.name = "modifier_item_0158"
__TS__ClassExtends(modifier_item_0158, BaseModifier_CS)
function modifier_item_0158.prototype.IsHidden(self)
	return true
end
function modifier_item_0158.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0158.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == event.attacker:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_trigger_chance_pct = ability:GetSpecialValueFor("ability_trigger_chance_pct")
	if not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	local ability_damage = ability:GetSpecialValueFor("ability_damage")
	local damage = self:GetAllAttackDamage(event.attacker) * ability_damage * 0.01
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = event.attacker,
		damage = damage,
		damage_type = 1,
		ability = ability,
	})
	self:PlayEffects1(target)
end
function modifier_item_0158.prototype.PlayEffects1(self, target)
	local hitEffect = MyGameHeroParticleManager:CreateParticle(px2, PATTACH_CENTER_FOLLOW, target, self:GetParent())
	MyGameHeroParticleManager:SetParticleControlEnt(
		hitEffect,
		0,
		target,
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(hitEffect)
	EmitSoundOn("Hero_Lion.ImpaleHitTarget", target)
end
modifier_item_0158 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0158)
return ____exports