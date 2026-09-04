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
____exports.item_0362 = __TS__Class()
local item_0362 = ____exports.item_0362
item_0362.name = "item_0362"
__TS__ClassExtends(item_0362, BaseItem_CS)
function item_0362.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/item/econ/items/necrolyte/necro_sullen_harvest/item_249.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_necrolyte/necrolyte_scythe_orig.vpcf", context)
end
function item_0362.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0362_reaper_slash.name
end
item_0362 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0362)
____exports.item_0362 = item_0362
____exports.modifier_item_0362_reaper_slash = __TS__Class()
local modifier_item_0362_reaper_slash = ____exports.modifier_item_0362_reaper_slash
modifier_item_0362_reaper_slash.name = "modifier_item_0362_reaper_slash"
__TS__ClassExtends(modifier_item_0362_reaper_slash, BaseModifier_CS)
function modifier_item_0362_reaper_slash.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0362_reaper_slash.prototype.IsHidden(self)
	return true
end
function modifier_item_0362_reaper_slash.prototype.IsPurgable(self)
	return false
end
function modifier_item_0362_reaper_slash.prototype.OnAttackLanded_CS(self, event)
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
	local targetIndex = target:GetEntityIndex()
	local ability_effect_delay = 0.45
	self:PlayEffects1(parent, target)
	self:StartAbilityCooldown(ability)
	self:Timer(ability_effect_delay, function()
		if not IsValidAlive(nil, parent) then
			return
		end
		local slashTarget = EntIndexToHScript(targetIndex)
		if not slashTarget or not IsValidAlive(nil, slashTarget) or slashTarget:IsBuilding() then
			return
		end
		if slashTarget:GetTeamNumber() == parent:GetTeamNumber() then
			return
		end
		self:PlayEffects2(parent, slashTarget:GetAbsOrigin())
		self:ApplyReaperSlash(parent, slashTarget, ability)
	end)
end
function modifier_item_0362_reaper_slash.prototype.StartAbilityCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	ability:StartCooldown(ability:GetCooldown(level))
end
function modifier_item_0362_reaper_slash.prototype.ApplyReaperSlash(self, parent, target, ability)
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_damage_pct"))
	local ability_lifesteal_damage_bonus_pct =
		math.max(0, ability:GetSpecialValueFor("ability_lifesteal_damage_bonus_pct"))
	local ability_value_lifesteal_damage_bonus_max_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_lifesteal_damage_bonus_max_pct"))
	local ability_all_attributes = self:GetTotalAttributes(parent)
	local ability_any_lifesteal_pct = self:GetAnyLifestealPct(parent)
	local ability_lifesteal_bonus_pct = math.min(
		ability_value_lifesteal_damage_bonus_max_pct,
		ability_any_lifesteal_pct * ability_lifesteal_damage_bonus_pct
	)
	local ability_damage = ability_all_attributes * (ability_damage_pct / 100) * (1 + ability_lifesteal_bonus_pct / 100)
	local center = target:GetAbsOrigin()
	local team = parent:GetTeamNumber()
	local enemies = FindUnitsInRadius(
		team,
		center,
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue19
			end
			if enemy:GetTeamNumber() == team then
				goto __continue19
			end
			if ability_damage <= 0 then
				goto __continue19
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				ability = ability,
				damage = ability_damage,
				damage_type = 4,
				extra_data = { custom_tag = "item_0362_reaper_slash", source_name = "死神斩击" },
			})
		end
		::__continue19::
	end
end
function modifier_item_0362_reaper_slash.prototype.GetTotalAttributes(self, parent)
	local strength = MyGameAttribute:GetAttribute(parent, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	return math.max(0, strength + agility + intelligence)
end
function modifier_item_0362_reaper_slash.prototype.GetAnyLifestealPct(self, parent)
	local ability_attack_lifesteal_pct = math.max(0, MyGameAttribute:GetAttribute(parent, "attack_lifesteal_pct") or 0)
	local ability_spell_lifesteal_pct = math.max(0, MyGameAttribute:GetAttribute(parent, "spell_lifesteal_pct") or 0)
	local ability_physical_lifesteal_pct =
		math.max(0, MyGameAttribute:GetAttribute(parent, "physical_lifesteal_pct") or 0)
	local ability_magical_lifesteal_pct =
		math.max(0, MyGameAttribute:GetAttribute(parent, "magical_lifesteal_pct") or 0)
	local ability_omni_lifesteal_pct = math.max(0, MyGameAttribute:GetAttribute(parent, "omni_lifesteal_pct") or 0)
	return ability_attack_lifesteal_pct
		+ ability_spell_lifesteal_pct
		+ ability_physical_lifesteal_pct
		+ ability_magical_lifesteal_pct
		+ ability_omni_lifesteal_pct
end
function modifier_item_0362_reaper_slash.prototype.PlayEffects1(self, caster, target)
	local particle = ParticleManager:CreateParticle(
		"particles/item/econ/items/necrolyte/necro_sullen_harvest/item_249.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(particle, 0, caster:GetForwardVector())
	ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
	self:AddParticle(particle, false, false, 16, false, false)
end
function modifier_item_0362_reaper_slash.prototype.PlayEffects2(self, caster, position)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_necrolyte/necrolyte_scythe_orig.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil,
		caster
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		1,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		position,
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
modifier_item_0362_reaper_slash = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0362_reaper_slash)
____exports.modifier_item_0362_reaper_slash = modifier_item_0362_reaper_slash
return ____exports