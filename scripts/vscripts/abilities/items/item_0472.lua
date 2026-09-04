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
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local FindEnemies = ____item_0409_shared.FindEnemies
local GetTotalAttackDamage = ____item_0409_shared.GetTotalAttackDamage
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local StartAbilityCooldown = ____item_0409_shared.StartAbilityCooldown
local ____item_0468 = require("abilities.items.item_0468")
local modifier_item_0468_thunderstorm = ____item_0468.modifier_item_0468_thunderstorm
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
____exports.item_0472 = __TS__Class()
local item_0472 = ____exports.item_0472
item_0472.name = "item_0472"
__TS__ClassExtends(item_0472, BaseItem_CS)
function item_0472.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items_fx/chain_lightning.vpcf", context)
end
function item_0472.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0472_thunder_backlash_youth.name
end
item_0472 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0472)
____exports.item_0472 = item_0472
____exports.modifier_item_0472_thunder_backlash_youth = __TS__Class()
local modifier_item_0472_thunder_backlash_youth = ____exports.modifier_item_0472_thunder_backlash_youth
modifier_item_0472_thunder_backlash_youth.name = "modifier_item_0472_thunder_backlash_youth"
__TS__ClassExtends(modifier_item_0472_thunder_backlash_youth, BaseModifier_CS)
function modifier_item_0472_thunder_backlash_youth.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0472_thunder_backlash_youth.prototype.IsHidden(self)
	return true
end
function modifier_item_0472_thunder_backlash_youth.prototype.IsPurgable(self)
	return false
end
function modifier_item_0472_thunder_backlash_youth.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	if parent:HasModifier(modifier_item_0468_thunderstorm.name) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	if not IsValidAlive(nil, parent) or not IsValidEnemyUnit(nil, parent, event.target) then
		return
	end
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_attack_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_attack_damage_pct"))
	if ability_radius <= 0 or ability_attack_damage_pct <= 0 then
		return
	end
	local ability_trigger_chance_pct = math.max(0, ability:GetSpecialValueFor("ability_trigger_chance_pct"))
	if ability_trigger_chance_pct <= 0 or not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	local damage = GetTotalAttackDamage(nil, parent) * (ability_attack_damage_pct / 100)
	if damage <= 0 then
		return
	end
	self:SummonThunderStorm(parent, ability, event.target, ability_radius, damage)
	self:ApplyBacklash(parent, ability)
	StartAbilityCooldown(nil, ability, 1)
end
function modifier_item_0472_thunder_backlash_youth.prototype.SummonThunderStorm(
	self,
	parent,
	ability,
	center,
	ability_radius,
	damage
)
	local enemies = FindEnemies(nil, parent, center:GetAbsOrigin(), ability_radius)
	if #enemies <= 0 then
		return
	end
	self:PlayEffects1(parent, center)
	TriggerDarkDomainLightningFlash(nil, parent, center)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidEnemyUnit(nil, parent, enemy) then
				goto __continue18
			end
			Damage:ApplyDamage({
				victim = enemy,
				attacker = parent,
				damage = damage,
				damage_type = 2,
				ability = ability,
				extra_data = {
					custom_tag = "item_0472_thunder_backlash_youth",
					source_name = ability:GetAbilityName(),
				},
			})
		end
		::__continue18::
	end
end
function modifier_item_0472_thunder_backlash_youth.prototype.ApplyBacklash(self, parent, ability)
	local ability_backlash_current_health_pct =
		math.max(0, ability:GetSpecialValueFor("ability_backlash_current_health_pct"))
	if ability_backlash_current_health_pct <= 0 then
		return
	end
	local backlash = parent:GetHealth() * (ability_backlash_current_health_pct / 100)
	if backlash <= 0 then
		return
	end
	parent:CostHeal(backlash, {
		attacker = parent,
		ability = ability,
		source = {
			custom_tag = "item_0472_thunder_backlash_youth_backlash",
			source_name = ability:GetAbilityName(),
		},
		reserve_min_health = 1,
	})
end
function modifier_item_0472_thunder_backlash_youth.prototype.PlayEffects1(self, parent, center)
	local lightning = MyGameHeroParticleManager:CreateParticle(
		"particles/items_fx/chain_lightning.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		lightning,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		lightning,
		1,
		center,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		center:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(lightning)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning", center)
end
modifier_item_0472_thunder_backlash_youth =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0472_thunder_backlash_youth)
____exports.modifier_item_0472_thunder_backlash_youth = modifier_item_0472_thunder_backlash_youth
return ____exports