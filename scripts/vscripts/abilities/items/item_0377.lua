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
____exports.item_0377 = __TS__Class()
local item_0377 = ____exports.item_0377
item_0377.name = "item_0377"
__TS__ClassExtends(item_0377, BaseItem_CS)
function item_0377.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/neutral_fx/miniboss_dire_shield_hit.vpcf", context)
end
function item_0377.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0377_heavy_hammer.name
end
item_0377 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0377)
____exports.item_0377 = item_0377
____exports.modifier_item_0377_heavy_hammer = __TS__Class()
local modifier_item_0377_heavy_hammer = ____exports.modifier_item_0377_heavy_hammer
modifier_item_0377_heavy_hammer.name = "modifier_item_0377_heavy_hammer"
__TS__ClassExtends(modifier_item_0377_heavy_hammer, BaseModifier_CS)
function modifier_item_0377_heavy_hammer.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0377_heavy_hammer.prototype.IsHidden(self)
	return true
end
function modifier_item_0377_heavy_hammer.prototype.IsPurgable(self)
	return false
end
function modifier_item_0377_heavy_hammer.prototype.OnAttackLanded_CS(self, event)
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
	local ability_current_shield_damage_pct =
		math.max(0, ability:GetSpecialValueFor("ability_current_shield_damage_pct"))
	if ability_current_shield_damage_pct <= 0 then
		return
	end
	local ____math_max_2 = math.max
	local ____opt_0 = parent.GetTotalEnergyShield
	local totalShield = ____math_max_2(
		0,
		____opt_0 and ____opt_0(parent) or MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0
	)
	local damage = totalShield * (ability_current_shield_damage_pct / 100)
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = parent,
		damage = damage,
		damage_type = 1,
		ability = ability,
		extra_data = { custom_tag = "item_0377_heavy_hammer", source_name = "浩劫重锤" },
	})
	self:StartAbilityCooldown(ability)
	self:PlayEffects1(target)
end
function modifier_item_0377_heavy_hammer.prototype.StartAbilityCooldown(self, ability)
	local ability_level = math.max(0, ability:GetLevel() - 1)
	local ability_cooldown = ability:GetCooldown(ability_level)
	local ____ability_4 = ability
	local ____ability_StartCooldown_5 = ability.StartCooldown
	local ____temp_3
	if ability_cooldown > 0 then
		____temp_3 = ability_cooldown
	else
		____temp_3 = 0.01
	end
	____ability_StartCooldown_5(____ability_4, ____temp_3)
end
function modifier_item_0377_heavy_hammer.prototype.PlayEffects1(self, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/neutral_fx/miniboss_dire_shield_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Hero_Magnataur.Empower.Target", target)
end
modifier_item_0377_heavy_hammer = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0377_heavy_hammer)
____exports.modifier_item_0377_heavy_hammer = modifier_item_0377_heavy_hammer
return ____exports