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
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_potion_base = require("abilities.items.potions.item_potion_base")
local BasePotionModifier_CS = ____item_potion_base.BasePotionModifier_CS
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
____exports.item_P054 = __TS__Class()
local item_P054 = ____exports.item_P054
item_P054.name = "item_P054"
__TS__ClassExtends(item_P054, BaseItem_CS)
function item_P054.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/dd/small_lightning_strike_blue_cyan.vpcf", context)
end
function item_P054.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local ability_duration = self:GetSpecialValueFor("ability_duration")
			local ability_stun_duration = self:GetSpecialValueFor("ability_stun_duration")
			self:ApplyPotionModifier(
				____exports.modifier_item_P054_thunderclap_potion.name,
				ability_duration,
				{ ability_stun_duration = ability_stun_duration }
			)
			self:PlayEffects1(caster)
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_P054.prototype.PlayEffects1(self, caster)
	caster:EmitSound("Hero_Zuus.Pick")
end
item_P054 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P054)
____exports.item_P054 = item_P054
____exports.modifier_item_P054_thunderclap_potion = __TS__Class()
local modifier_item_P054_thunderclap_potion = ____exports.modifier_item_P054_thunderclap_potion
modifier_item_P054_thunderclap_potion.name = "modifier_item_P054_thunderclap_potion"
__TS__ClassExtends(modifier_item_P054_thunderclap_potion, BasePotionModifier_CS)
function modifier_item_P054_thunderclap_potion.prototype.____constructor(self, ...)
	BasePotionModifier_CS.prototype.____constructor(self, ...)
	self.abilityStunDuration = 0
end
function modifier_item_P054_thunderclap_potion.GetLocalizationCN(self)
	return {
		name = "震雷",
		description = "下次主攻击命中怪物时将其眩晕；怪物正在读条时强制触发破招。",
	}
end
function modifier_item_P054_thunderclap_potion.prototype.OnCreated(self, params)
	BasePotionModifier_CS.prototype.OnCreated(self, params)
	self:ReadParams(params)
end
function modifier_item_P054_thunderclap_potion.prototype.OnRefresh(self, params)
	self:SetPotionSequence(params and params.ak_potion_sequence)
	self:ReadParams(params)
end
function modifier_item_P054_thunderclap_potion.prototype.IsHidden(self)
	return false
end
function modifier_item_P054_thunderclap_potion.prototype.IsPurgable(self)
	return false
end
function modifier_item_P054_thunderclap_potion.prototype.GetTexture(self)
	return "item_mjollnir"
end
function modifier_item_P054_thunderclap_potion.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_P054_thunderclap_potion.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local attacker = self:GetParent()
	if not IsValidAlive(nil, attacker) or event.attacker ~= attacker or event.is_sub_attack == true then
		return
	end
	if not self:IsValidMonsterTarget(attacker, event.target) then
		return
	end
	local target = event.target
	if target:HasModifier("modifier_monster_cast_pre_progress") then
		MyGameMonsterCounterBreak:EnterWindow(target)
	end
	local ability = self:GetAbility()
	local ____AddDeBuffStatus_3 = AddDeBuffStatus
	local ____temp_2
	if ability and IsValid(nil, ability) then
		____temp_2 = ability
	else
		____temp_2 = nil
	end
	____AddDeBuffStatus_3(
		nil,
		target,
		attacker,
		____temp_2,
		DebuffStatusType.STUN,
		{ duration = self.abilityStunDuration }
	)
	self:PlayEffects2(target)
	TriggerDarkDomainLightningFlash(nil, attacker, target)
	self:Destroy()
end
function modifier_item_P054_thunderclap_potion.prototype.IsValidMonsterTarget(self, attacker, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	if target:GetTeamNumber() == attacker:GetTeamNumber() then
		return false
	end
	local ____this_5
	____this_5 = target
	local ____opt_4 = ____this_5.GetUnitType
	local unitType = ____opt_4 and ____opt_4(____this_5)
	return unitType == UnitType.MONSTER_NORMAL
		or unitType == UnitType.MONSTER_ELITE
		or unitType == UnitType.MONSTER_MINIBOSS
		or unitType == UnitType.MONSTER_BOSS
end
function modifier_item_P054_thunderclap_potion.prototype.PlayEffects2(self, target)
	local particle = ParticleManager:CreateParticle(
		"particles/dd/small_lightning_strike_blue_cyan.vpcf",
		PATTACH_CENTER_FOLLOW,
		target
	)
	ParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Hero_Zuus.LightningBolt", target)
end
function modifier_item_P054_thunderclap_potion.prototype.ReadParams(self, params)
	self.abilityStunDuration = math.max(0, tonumber(params and params.ability_stun_duration) or 0)
end
modifier_item_P054_thunderclap_potion =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P054_thunderclap_potion)
____exports.modifier_item_P054_thunderclap_potion = modifier_item_P054_thunderclap_potion
return ____exports