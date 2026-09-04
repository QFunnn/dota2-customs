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
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
____exports.item_0470 = __TS__Class()
local item_0470 = ____exports.item_0470
item_0470.name = "item_0470"
__TS__ClassExtends(item_0470, BaseItem_CS)
function item_0470.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/units/heroes/hero_leshrac/leshrac_lightning_bolt.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context)
end
function item_0470.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0470_lightning_rod.name
end
item_0470 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0470)
____exports.item_0470 = item_0470
____exports.modifier_item_0470_lightning_rod = __TS__Class()
local modifier_item_0470_lightning_rod = ____exports.modifier_item_0470_lightning_rod
modifier_item_0470_lightning_rod.name = "modifier_item_0470_lightning_rod"
__TS__ClassExtends(modifier_item_0470_lightning_rod, BaseModifier_CS)
function modifier_item_0470_lightning_rod.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0470_lightning_rod.prototype.IsHidden(self)
	return true
end
function modifier_item_0470_lightning_rod.prototype.IsPurgable(self)
	return false
end
function modifier_item_0470_lightning_rod.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	local ____opt_0 = castAbility.IsItem
	if ____opt_0 and ____opt_0(castAbility) then
		return
	end
	local ____opt_2 = castAbility.IsToggle
	if ____opt_2 and ____opt_2(castAbility) then
		return
	end
	local ability_lightning_count = math.max(0, math.floor(ability:GetSpecialValueFor("ability_lightning_count")))
	local ability_int_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_int_damage_pct"))
	if ability_lightning_count <= 0 or ability_int_damage_pct <= 0 then
		return
	end
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	local damage = intelligence * (ability_int_damage_pct / 100)
	if damage <= 0 then
		return
	end
	self:StrikeLightning(parent, ability, ability_lightning_count, damage)
end
function modifier_item_0470_lightning_rod.prototype.StrikeLightning(
	self,
	caster,
	ability,
	ability_lightning_count,
	baseDamage
)
	local hitRecords = {}
	do
		local index = 0
		while index < ability_lightning_count do
			Timers:CreateTimer(index * 0.12, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local target = self:SelectTarget(caster, ability)
				if not target then
					return
				end
				local hitCount = self:GetHitCount(hitRecords, target:GetEntityIndex())
				local damage = baseDamage * self:GetDamageMultiplier(ability, hitCount)
				self:AddHitRecord(hitRecords, target:GetEntityIndex())
				self:PlayEffects1(caster, target)
				self:ApplyLightningDamage(caster, ability, target, damage)
				TriggerDarkDomainLightningFlash(nil, caster, target)
			end)
			index = index + 1
		end
	end
end
function modifier_item_0470_lightning_rod.prototype.SelectTarget(self, caster, ability)
	local ability_search_radius = math.max(0, ability:GetSpecialValueFor("ability_search_radius"))
	if ability_search_radius <= 0 then
		return nil
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		ability_search_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local targets = {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue23
			end
			targets[#targets + 1] = enemy
		end
		::__continue23::
	end
	if #targets <= 0 then
		return nil
	end
	return targets[RandomInt(0, #targets - 1) + 1]
end
function modifier_item_0470_lightning_rod.prototype.GetHitCount(self, hitRecords, targetIndex)
	for ____, record in ipairs(hitRecords) do
		if record.targetIndex == targetIndex then
			return record.count
		end
	end
	return 0
end
function modifier_item_0470_lightning_rod.prototype.AddHitRecord(self, hitRecords, targetIndex)
	for ____, record in ipairs(hitRecords) do
		do
			if record.targetIndex ~= targetIndex then
				goto __continue32
			end
			record.count = record.count + 1
			return
		end
		::__continue32::
	end
	hitRecords[#hitRecords + 1] = { targetIndex = targetIndex, count = 1 }
end
function modifier_item_0470_lightning_rod.prototype.GetDamageMultiplier(self, ability, hitCount)
	local ability_same_target_decay_pct =
		math.min(100, math.max(0, ability:GetSpecialValueFor("ability_value_c_same_target_decay_pct")))
	local decayMultiplier = 1 - ability_same_target_decay_pct / 100
	return math.pow(decayMultiplier, hitCount)
end
function modifier_item_0470_lightning_rod.prototype.ApplyLightningDamage(self, caster, ability, target, damage)
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = damage,
		damage_type = 2,
		ability = ability,
	})
end
function modifier_item_0470_lightning_rod.prototype.PlayEffects1(self, caster, target)
	local origin = target:GetAbsOrigin()
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_leshrac/leshrac_lightning_bolt.vpcf",
		PATTACH_WORLDORIGIN,
		nil,
		caster
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, origin:__add(Vector(0, 0, 1500)))
	MyGameHeroParticleManager:SetParticleControl(particle, 1, origin)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOnLocationWithCaster(origin, "Hero_Zuus.LightningBolt", caster)
end
modifier_item_0470_lightning_rod = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0470_lightning_rod)
____exports.modifier_item_0470_lightning_rod = modifier_item_0470_lightning_rod
return ____exports