--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.mid_mode_tower_ancient_protection = __TS__Class()
local mid_mode_tower_ancient_protection = ____exports.mid_mode_tower_ancient_protection
mid_mode_tower_ancient_protection.name = "mid_mode_tower_ancient_protection"
__TS__ClassExtends(mid_mode_tower_ancient_protection, BaseAbility)
function mid_mode_tower_ancient_protection.prototype.GetIntrinsicModifierName(self)
	local level = self:GetLevel()
	if level >= 1 then
		return ____exports.modifier_mid_mode_tower_ancient_protection.name
	end
end
mid_mode_tower_ancient_protection = __TS__Decorate({ registerAbility(nil) }, mid_mode_tower_ancient_protection)
____exports.mid_mode_tower_ancient_protection = mid_mode_tower_ancient_protection
____exports.modifier_mid_mode_tower_ancient_protection = __TS__Class()
local modifier_mid_mode_tower_ancient_protection = ____exports.modifier_mid_mode_tower_ancient_protection
modifier_mid_mode_tower_ancient_protection.name = "modifier_mid_mode_tower_ancient_protection"
__TS__ClassExtends(modifier_mid_mode_tower_ancient_protection, SLModifierBase)
function modifier_mid_mode_tower_ancient_protection.prototype.AllowIllusionDuplicate(self)
	return false
end
function modifier_mid_mode_tower_ancient_protection.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_DEATH }
end
function modifier_mid_mode_tower_ancient_protection.prototype.OnDeath(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local unit = event.unit
	if IsValid(parent) and IsValid(unit) and parent == unit then
		local team = parent:GetTeam()
		for ____, hero in ipairs(HeroList:GetAllRealHeroes()) do
			if hero:GetTeam() ~= team and hero:HasShard() and not hero:IsMonkeyArmy() and not IsTempstDouble(hero) then
				self:GiveBonus(hero)
			end
			if not hero:HasShard() and not hero:IsMonkeyArmy() and not IsTempstDouble(hero) then
				self:GiveShard(hero)
			end
		end
	end
end
function modifier_mid_mode_tower_ancient_protection.prototype.GiveShard(self, hero)
	if hero:HasShard() then
		return
	end
	local hero_pos = hero:GetAbsOrigin()
	local pid = SParticleManager:CreateGenericParticle(
		GENERIC_PARTICLES.mid_tower_reward_shard,
		PATTACH_CUSTOMORIGIN_FOLLOW,
		hero
	)
	SParticleManager:SetParticleControlEnt(pid, 0, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero_pos, false)
	SParticleManager:SetParticleControlEnt(pid, 1, hero, PATTACH_ABSORIGIN_FOLLOW, nil, hero_pos, false)
	SParticleManager:ReleaseParticleIndex(pid)
	EmitAnnouncerSoundForPlayer("tower_shard", hero:GetPlayerOwnerID())
	hero:AddSLModifier("modifier_item_aghanims_shard", { caster = hero })
end
function modifier_mid_mode_tower_ancient_protection.prototype.GiveBonus(self, hero)
	if not hero:HasShard() then
		return
	end
	local pid = SParticleManager:CreateGenericParticle(
		GENERIC_PARTICLES.mid_tower_reward_resource,
		PATTACH_CUSTOMORIGIN_FOLLOW,
		hero
	)
	local hero_pos = hero:GetAbsOrigin()
	SParticleManager:SetParticleControlEnt(pid, 0, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero_pos, false)
	SParticleManager:SetParticleControlEnt(pid, 1, hero, PATTACH_ABSORIGIN_FOLLOW, nil, hero_pos, false)
	SParticleManager:ReleaseParticleIndex(pid)
	SLModules.ClientData:PushNumberData(hero, self:GetAbilitySpecialValueFor("gold_bounus"), 4)
	EmitAnnouncerSoundForPlayer("tower_xp", hero:GetPlayerOwnerID())
	EmitAnnouncerSoundForPlayer("tower_gold", hero:GetPlayerOwnerID())
	hero:AddExperience(self:GetAbilitySpecialValueFor("xp_bonus"), DOTA_ModifyXP_Unspecified, false, true, 0)
	hero:ModifyGoldFiltered(self:GetAbilitySpecialValueFor("gold_bounus"), false, DOTA_ModifyGold_Unspecified)
end
modifier_mid_mode_tower_ancient_protection = __TS__Decorate(
	{ registerModifier(nil, "abilities/tower/mid_mode_tower_ancient_protection") },
	modifier_mid_mode_tower_ancient_protection
)
____exports.modifier_mid_mode_tower_ancient_protection = modifier_mid_mode_tower_ancient_protection
return ____exports