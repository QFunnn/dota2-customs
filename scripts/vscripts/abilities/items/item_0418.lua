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
local ConsumeIceStacks = ____item_0409_shared.ConsumeIceStacks
local FindEnemies = ____item_0409_shared.FindEnemies
local GetAllStats = ____item_0409_shared.GetAllStats
local GetIceStacks = ____item_0409_shared.GetIceStacks
local IsNonDotDamage = ____item_0409_shared.IsNonDotDamage
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
____exports.item_0418 = __TS__Class()
local item_0418 = ____exports.item_0418
item_0418.name = "item_0418"
__TS__ClassExtends(item_0418, BaseItem_CS)
function item_0418.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0418_frozen_heart.name
end
item_0418 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0418)
____exports.item_0418 = item_0418
____exports.modifier_item_0418_frozen_heart = __TS__Class()
local modifier_item_0418_frozen_heart = ____exports.modifier_item_0418_frozen_heart
modifier_item_0418_frozen_heart.name = "modifier_item_0418_frozen_heart"
__TS__ClassExtends(modifier_item_0418_frozen_heart, BaseModifier_CS)
function modifier_item_0418_frozen_heart.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.nextTriggerTime = {}
end
function modifier_item_0418_frozen_heart.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0418_frozen_heart.prototype.IsHidden(self)
	return true
end
function modifier_item_0418_frozen_heart.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) or not IsNonDotDamage(nil, event, "item_0418_frozen_shatter") then
		return
	end
	local target = event.victim
	if not IsValidEnemyUnit(nil, parent, target) then
		return
	end
	local ability_required_ice_stacks =
		math.max(1, math.floor(ability:GetSpecialValueFor("ability_required_ice_stacks")))
	if GetIceStacks(nil, target) < ability_required_ice_stacks then
		return
	end
	local targetIndex = target:entindex()
	local now = GameRules:GetGameTime()
	if (self.nextTriggerTime[targetIndex] or 0) > now then
		return
	end
	local ____opt_0 = target.IsBoss
	if not (____opt_0 and ____opt_0(target)) then
		ConsumeIceStacks(nil, target, ability_required_ice_stacks)
	end
	self:TriggerFrozenShatter(parent, ability, target)
	local ability_trigger_cooldown = math.max(0.1, ability:GetSpecialValueFor("ability_trigger_cooldown"))
	self.nextTriggerTime[targetIndex] = now + ability_trigger_cooldown
end
function modifier_item_0418_frozen_heart.prototype.TriggerFrozenShatter(self, parent, ability, target)
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_all_stats_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_all_stats_damage_pct"))
	if ability_radius <= 0 or ability_all_stats_damage_pct <= 0 then
		return
	end
	local baseDamage = GetAllStats(nil, parent) * (ability_all_stats_damage_pct / 100)
	self:PlayEffects1(target, ability_radius)
	for ____, enemy in ipairs(FindEnemies(nil, parent, target:GetAbsOrigin(), ability_radius)) do
		do
			if not IsValidEnemyUnit(nil, parent, enemy) then
				goto __continue15
			end
			local ____enemy_IsBoss_result_4
			local ____opt_2 = enemy.IsBoss
			if ____opt_2 and ____opt_2(enemy) then
				____enemy_IsBoss_result_4 = ability:GetSpecialValueFor("ability_boss_damage_pct")
			else
				____enemy_IsBoss_result_4 = 100
			end
			local ability_boss_damage_pct = ____enemy_IsBoss_result_4
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = baseDamage * (ability_boss_damage_pct / 100),
				damage_type = 2,
				ability = ability,
				extra_data = {
					custom_tag = "item_0418_frozen_shatter",
					source_name = self:GetName(),
				},
			})
		end
		::__continue15::
	end
end
function modifier_item_0418_frozen_heart.prototype.PlayEffects1(self, target, ability_radius)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf",
		PATTACH_WORLDORIGIN,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(ability_radius, ability_radius, ability_radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Hero_Crystal.FreezingField.Explosion", target)
end
modifier_item_0418_frozen_heart = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0418_frozen_heart)
____exports.modifier_item_0418_frozen_heart = modifier_item_0418_frozen_heart
return ____exports