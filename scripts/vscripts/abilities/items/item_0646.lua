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
local GetAllStats = ____item_0409_shared.GetAllStats
____exports.item_0646 = __TS__Class()
local item_0646 = ____exports.item_0646
item_0646.name = "item_0646"
__TS__ClassExtends(item_0646, BaseItem_CS)
function item_0646.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/units/heroes/hero_leshrac/leshrac_lightning_bolt.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context)
end
function item_0646.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE }
end
function item_0646.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	____exports.modifier_item_0646_heavenly_punishment:applys(caster, caster, self, { duration = ability_duration })
	self:PlayEffects1(caster)
end
function item_0646.prototype.PlayEffects1(self, caster)
	EmitSoundOn("Hero_Zuus.GodsWrath", caster)
end
item_0646 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0646)
____exports.item_0646 = item_0646
____exports.modifier_item_0646_heavenly_punishment = __TS__Class()
local modifier_item_0646_heavenly_punishment = ____exports.modifier_item_0646_heavenly_punishment
modifier_item_0646_heavenly_punishment.name = "modifier_item_0646_heavenly_punishment"
__TS__ClassExtends(modifier_item_0646_heavenly_punishment, BaseModifier_CS)
function modifier_item_0646_heavenly_punishment.GetLocalizationCN(self)
	return {
		name = "天罚",
		description = "每秒对周围随机敌人降下落雷，造成基于全属性的纯粹伤害。",
	}
end
function modifier_item_0646_heavenly_punishment.prototype.IsHidden(self)
	return false
end
function modifier_item_0646_heavenly_punishment.prototype.IsPurgable(self)
	return false
end
function modifier_item_0646_heavenly_punishment.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartPunishmentInterval()
end
function modifier_item_0646_heavenly_punishment.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:StartPunishmentInterval()
end
function modifier_item_0646_heavenly_punishment.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local target = self:SelectRandomTarget(caster, ability)
	if not target then
		return
	end
	local ability_all_stats_damage_pct = ability:GetSpecialValueFor("ability_all_stats_damage_pct")
	local ability_damage = GetAllStats(nil, caster) * (ability_all_stats_damage_pct / 100)
	if ability_damage <= 0 then
		return
	end
	self:PlayEffects2(caster, target)
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		ability = ability,
		damage = ability_damage,
		damage_type = 4,
		extra_data = {
			custom_tag = "item_0646_heavenly_punishment",
			source_name = ability:GetAbilityName(),
		},
	})
end
function modifier_item_0646_heavenly_punishment.prototype.StartPunishmentInterval(self)
	local ability = self:GetAbility()
	if not ability then
		self:Destroy()
		return
	end
	local ability_interval = ability:GetSpecialValueFor("ability_interval")
	self:StartIntervalThink(ability_interval)
end
function modifier_item_0646_heavenly_punishment.prototype.SelectRandomTarget(self, caster, ability)
	local ability_radius = ability:GetSpecialValueFor("ability_radius")
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
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
function modifier_item_0646_heavenly_punishment.prototype.PlayEffects2(self, caster, target)
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
modifier_item_0646_heavenly_punishment =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0646_heavenly_punishment)
____exports.modifier_item_0646_heavenly_punishment = modifier_item_0646_heavenly_punishment
return ____exports