--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
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
local ITEM_0296_DEBUFF_EFFECT = "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf"
local ITEM_0296_COLD_ROOM_IDS = __TS__New(Set, { "M003", "M011" })
local ITEM_0296_ICE_SOUL_DAMAGE_TAG = "item_0296_ice_soul_damage"
____exports.item_0296 = __TS__Class()
local item_0296 = ____exports.item_0296
item_0296.name = "item_0296"
__TS__ClassExtends(item_0296, BaseItem_CS)
function item_0296.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_0296_DEBUFF_EFFECT, context)
end
function item_0296.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0296"
end
item_0296 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0296)
____exports.item_0296 = item_0296
____exports.modifier_item_0296 = __TS__Class()
local modifier_item_0296 = ____exports.modifier_item_0296
modifier_item_0296.name = "modifier_item_0296"
__TS__ClassExtends(modifier_item_0296, BaseModifier_CS)
function modifier_item_0296.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.hasColdEnvironment = false
end
function modifier_item_0296.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.hasColdEnvironment = self:IsInColdEnvironment()
	self:StartIntervalThink(0.2)
	self:RefreshAttributes()
end
function modifier_item_0296.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local hasColdEnvironment = self:IsInColdEnvironment()
	if self.hasColdEnvironment == hasColdEnvironment then
		return
	end
	self.hasColdEnvironment = hasColdEnvironment
	self:RefreshAttributes()
end
function modifier_item_0296.prototype.IsInColdEnvironment(self)
	local parent = self:GetParent()
	local playerId = parent:GetPlayerOwnerID()
	if playerId == nil or playerId < 0 then
		return false
	end
	local room = MyGameRoomManager:GetPlayerRoom(playerId)
	if not room then
		return false
	end
	return ITEM_0296_COLD_ROOM_IDS:has(room:GetRoomId())
end
function modifier_item_0296.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0296.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local attacker = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= attacker or event.is_base_attack then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____opt_0 = event.source
	if (____opt_0 and ____opt_0.custom_tag) == ITEM_0296_ICE_SOUL_DAMAGE_TAG then
		return
	end
	local damageAbility = event.ability
	local ____temp_4 = not damageAbility or not IsValid(nil, damageAbility) or damageAbility:IsNull()
	if not ____temp_4 then
		local ____opt_2 = damageAbility.IsItem
		____temp_4 = ____opt_2 and ____opt_2(damageAbility)
	end
	if ____temp_4 then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, attacker) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == attacker:GetTeamNumber() then
		return
	end
	self:DealBonusDamage(attacker, target, ability)
	self:ApplyColdStacks(attacker, target, ability)
	self:StartAbilityCooldown(ability)
end
function modifier_item_0296.prototype.DealBonusDamage(self, attacker, target, ability)
	local ability_value_all_stats_damage_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_all_stats_damage_pct"))
	local damage = self:GetAllStats(attacker) * (ability_value_all_stats_damage_pct / 100)
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = attacker,
		damage = damage,
		damage_type = 2,
		ability = ability,
		extra_data = { custom_tag = ITEM_0296_ICE_SOUL_DAMAGE_TAG, source_name = "冰魄" },
	})
end
function modifier_item_0296.prototype.ApplyColdStacks(self, attacker, target, ability)
	local ability_cold_duration = ability:GetSpecialValueFor("ability_cold_duration")
	local ability_cold_stack_per_hit = ability:GetSpecialValueFor("ability_cold_stack_per_hit")
	do
		local i = 0
		while i < ability_cold_stack_per_hit do
			AddDeBuffStatus(
				nil,
				target,
				attacker,
				ability,
				DebuffStatusType.ICE_SLOW,
				{ stack = 1, duration = ability_cold_duration, status_effect_name = ITEM_0296_DEBUFF_EFFECT }
			)
			i = i + 1
		end
	end
end
function modifier_item_0296.prototype.StartAbilityCooldown(self, ability)
	local ability_level = math.max(0, ability:GetLevel() - 1)
	local ability_cooldown = ability:GetCooldown(ability_level)
	if ability_cooldown > 0 then
		ability:StartCooldown(ability_cooldown)
	end
end
function modifier_item_0296.prototype.GetAllStats(self, attacker)
	local strength = MyGameAttribute:GetAttribute(attacker, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(attacker, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(attacker, "total_intelligence") or 0
	return math.max(0, strength + agility + intelligence)
end
function modifier_item_0296.prototype.GetAttributeBonus(self)
	if not self.hasColdEnvironment then
		return {}
	end
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_value_cold_lord_speed_pct = ability:GetSpecialValueFor("ability_value_cold_lord_speed_pct")
	return {
		outgoing_damage_pct_2 = ability_value_cold_lord_speed_pct,
		damage_resistance_pct = ability_value_cold_lord_speed_pct,
	}
end
function modifier_item_0296.prototype.IsHidden(self)
	return true
end
modifier_item_0296 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0296)
____exports.modifier_item_0296 = modifier_item_0296
return ____exports