--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


-- return loadstring(decryptModule(""))()
require("talents_stats")

table_data = _G.talents_stats

function GetManaPercentClient(hero)
	return (hero:GetMana() / hero:GetMaxMana()) * 100
end

LinkLuaModifier("modifier_in_fight_lua", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_fear_lua", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invu_lua", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_hp_regen_boost_lua", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_talent_mag_resist_lua", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)

modifier_in_fight_lua = class({})

function modifier_in_fight_lua:IsHidden()
	return false
end
function modifier_in_fight_lua:IsPurgable()
	return false
end
function modifier_in_fight_lua:RemoveOnDeath()
	return false
end
function modifier_in_fight_lua:IsDebuff()
	return false
end
function modifier_in_fight_lua:GetTexture()
	return "in_fight"
end

modifier_fear_lua = class({})

function modifier_fear_lua:IsHidden()
	return false
end
function modifier_fear_lua:IsPurgable()
	return false
end
function modifier_fear_lua:RemoveOnDeath()
	return false
end
function modifier_fear_lua:IsDebuff()
	return true
end
function modifier_fear_lua:GetTexture()
	return "bonus_str_5"
end

modifier_invu_lua = class({})

function modifier_invu_lua:IsHidden()
	return false
end
function modifier_invu_lua:IsPurgable()
	return false
end
function modifier_invu_lua:RemoveOnDeath()
	return false
end
function modifier_invu_lua:IsDebuff()
	return true
end
function modifier_invu_lua:GetTexture()
	return "bonus_str_8"
end

modifier_hp_regen_boost_lua = class({})

function modifier_hp_regen_boost_lua:IsHidden()
	return false
end
function modifier_hp_regen_boost_lua:IsPurgable()
	return false
end
function modifier_hp_regen_boost_lua:RemoveOnDeath()
	return false
end
function modifier_hp_regen_boost_lua:IsDebuff()
	return true
end
function modifier_hp_regen_boost_lua:GetTexture()
	return "bonus_str_15"
end

modifier_talent_mag_resist_lua = class({})

function modifier_talent_mag_resist_lua:IsHidden()
	return false
end
function modifier_talent_mag_resist_lua:IsPurgable()
	return false
end
function modifier_talent_mag_resist_lua:RemoveOnDeath()
	return false
end
function modifier_talent_mag_resist_lua:IsDebuff()
	return true
end
function modifier_talent_mag_resist_lua:GetTexture()
	return "bonus_int_15"
end

local talent_keys = {
	"int",
	"spell_damage",
	"mana",
	"regen_mana",
	"cd",
	"exp",
	"str",
	"status",
	"mr",
	"armor",
	"hp",
	"hp_reg",
	"agi",
	"damage",
	"evasion",
	"attack_speed",
	"move_speed",
	"lifesteal",
}

local talent_keys_bonus = {
	"bonus_str",
	"bonus_int",
	"bonus_agi",
}

modifier_talents = class({})

function modifier_talents:IsHidden()
	return true
end
function modifier_talents:IsPurgable()
	return false
end
function modifier_talents:RemoveOnDeath()
	return false
end

function modifier_talents:OnCreated(kv)
	self:StartIntervalThink(0.3)
	if not IsServer() then
		return
	end
	if not self.values then
		self.values = {}
	end

	self:SetupRewards(kv)
	self:SetHasCustomTransmitterData(true)
end

function modifier_talents:SetupRewards(kv)
	if not IsServer() then
		return
	end

	for _, key in ipairs(talent_keys) do
		for i = 1, 3 do
			local talent_name = key .. "_" .. i
			self.values[talent_name] = kv[talent_name] or 0
		end
	end
	for _, key in ipairs(talent_keys_bonus) do
		for i = 1, 15 do
			local talent_name = key .. "_" .. i
			self.values[talent_name] = kv[talent_name] or 0
		end
	end
end

function modifier_talents:AddCustomTransmitterData()
	local data = {}
	data.values = self.values

	for _, key in ipairs(talent_keys) do
		for i = 1, 3 do
			local talent_name = key .. "_" .. i
			data[talent_name] = self.values[talent_name] or 0
		end
	end

	for _, key in ipairs(talent_keys_bonus) do
		for i = 1, 15 do
			local talent_name = key .. "_" .. i
			data[talent_name] = self.values[talent_name] or 0
		end
	end
	return data
end

function modifier_talents:HandleCustomTransmitterData(data)
	self.values = data.values

	for _, key in ipairs(talent_keys) do
		for i = 1, 3 do
			local talent_name = key .. "_" .. i
			self.values[talent_name] = data[talent_name] or 0
		end
	end

	for _, key in ipairs(talent_keys_bonus) do
		for i = 1, 15 do
			local talent_name = key .. "_" .. i
			self.values[talent_name] = data[talent_name] or 0
		end
	end
end

function modifier_talents:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_EXP_RATE_BOOST,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_talents:OnAttack(event)
	if self:GetCaster() ~= event.attacker then
		return
	end
	if not event.attacker:IsIllusion() then
		if
			self.values["bonus_agi_15"]
			and self.values["bonus_agi_15"] > 0
			and RandomInt(1, 100) < 10
			and not self:GetParent():HasModifier("modifier_bonus_agi_15")
		then
			event.attacker:AddNewModifier(attacker, self:GetAbility(), "modifier_bonus_agi_15", { duration = 0.3 })
		end
	end
end

function modifier_talents:OnDeath(params)
	if self:GetParent() == params.attacker and self.values["bonus_int_13"] and self.values["bonus_int_13"] > 0 then
		self:GetParent():GiveMana(50)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, self:GetParent(), 50, nil)
	end

	if self:GetParent() == params.attacker and self.values["bonus_agi_1"] and self.values["bonus_agi_1"] > 0 then
		local amount = self:GetParent():GetMaxHealth() * 0.01
		self:GetParent():Heal(amount, self)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), amount, nil)
	end
end

function modifier_talents:OnAbilityFullyCast(params)
	if params.unit ~= self:GetParent() then
		return
	end
	if self.values["bonus_int_11"] and self.values["bonus_int_11"] > 0 then
		local mana = self:GetParent():GetMaxMana() * 0.05
		self:GetParent():GiveMana(mana)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, self:GetParent(), mana, nil)
	end
end

function modifier_talents:GetModifierPreAttack_CriticalStrike(params)
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then
			return
		end

		local chance = 0
		if self.values["bonus_agi_7"] and self.values["bonus_agi_7"] > 0 then
			chance = self.values["bonus_agi_7"] * 5
		end

		if RandomInt(1, 100) < chance then
			self.record = params.record
			return 200
		end
	end
end

function modifier_talents:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		if self.record and self.record == params.record then
			self.record = nil
			EmitSoundOn("Hero_Juggernaut.BladeDance", params.target)
		end
	end
end

function modifier_talents:GetModifierTotalDamageOutgoing_Percentage(keys)
	local bonus = 0

	if
		self.values["bonus_int_8"]
		and self.values["bonus_int_8"] > 0
		and keys.target:GetHealthPercent() < 20
		and keys.damage_category == 0
	then
		bonus = bonus + 10
	end

	if self.values["bonus_agi_8"] and self.values["bonus_agi_8"] > 0 and keys.target:GetHealthPercent() == 100 then
		bonus = bonus + 30
	end

	if self.values["bonus_agi_10"] and self.values["bonus_agi_10"] > 0 and keys.target:GetHealthPercent() < 15 then
		bonus = bonus + 10
	end

	return bonus
end

function modifier_talents:GetModifierBonusStats_Strength()
	return (table_data["str_1"] * (self.values["str_1"] or 0))
		+ (table_data["str_2"] * (self.values["str_2"] or 0))
		+ (table_data["str_3"] * (self.values["str_3"] or 0))
end

function modifier_talents:GetModifierBonusStats_Intellect()
	return (table_data["int_1"] * (self.values["int_1"] or 0))
		+ (table_data["int_2"] * (self.values["int_2"] or 0))
		+ (table_data["int_3"] * (self.values["int_3"] or 0))
end

function modifier_talents:GetModifierBonusStats_Agility()
	return (table_data["agi_1"] * (self.values["agi_1"] or 0))
		+ (table_data["agi_2"] * (self.values["agi_2"] or 0))
		+ (table_data["agi_3"] * (self.values["agi_3"] or 0))
end

function modifier_talents:GetModifierConstantHealthRegen()
	return (table_data["hp_reg_1"] * (self.values["hp_reg_1"] or 0))
		+ (table_data["hp_reg_2"] * (self.values["hp_reg_2"] or 0))
		+ (table_data["hp_reg_3"] * (self.values["hp_reg_3"] or 0))
end

function modifier_talents:GetModifierSpellAmplify_Percentage()
	local bonus = 0

	if self.values["bonus_int_4"] and self.values["bonus_int_4"] > 0 then
		bonus = self:GetCaster():GetLevel()
	end

	if self.values["bonus_int_6"] and self.values["bonus_int_6"] > 0 then
		bonus = bonus + 50
	end

	if self.values["bonus_int_9"] and self.values["bonus_int_9"] > 0 then
		local missing_mana_percent = (1 - (self:GetCaster():GetMana() / self:GetCaster():GetMaxMana())) * 100
		local bonus_spell_amp = math.floor(missing_mana_percent / 10) * 3
		bonus = bonus + bonus_spell_amp
	end

	return (table_data["spell_damage_1"] * (self.values["spell_damage_1"] or 0))
		+ (table_data["spell_damage_2"] * (self.values["spell_damage_2"] or 0))
		+ (table_data["spell_damage_3"] * (self.values["spell_damage_3"] or 0))
		+ bonus
end

function modifier_talents:GetModifierConstantManaRegen()
	local bonus = 0
	if self.values["bonus_int_1"] and self.values["bonus_int_1"] > 0 then
		bonus = self:GetCaster():GetMaxMana() / 100
	end

	return (table_data["regen_mana_1"] * (self.values["regen_mana_1"] or 0))
		+ (table_data["regen_mana_2"] * (self.values["regen_mana_2"] or 0))
		+ (table_data["regen_mana_3"] * (self.values["regen_mana_3"] or 0))
		+ bonus
end

function modifier_talents:GetModifierPercentageCooldown()
	return (table_data["cd_1"] * (self.values["cd_1"] or 0))
		+ (table_data["cd_2"] * (self.values["cd_2"] or 0))
		+ (table_data["cd_3"] * (self.values["cd_3"] or 0))
end

function modifier_talents:GetModifierPercentageExpRateBoost()
	return (table_data["exp_1"] * (self.values["exp_1"] or 0))
		+ (table_data["exp_2"] * (self.values["exp_2"] or 0))
		+ (table_data["exp_3"] * (self.values["exp_3"] or 0))
end

function modifier_talents:GetModifierMagicalResistanceBonus()
	local bonus = 0
	if self.values["bonus_str_9"] and self.values["bonus_str_9"] > 0 and self:GetCaster():GetHealthPercent() < 15 then
		bonus = 20
	end

	if
		self.values["bonus_int_2"]
		and self.values["bonus_int_2"] > 0
		and GetManaPercentClient(self:GetCaster()) < 30
	then
		bonus = bonus + 15
	end

	return (table_data["mr_1"] * (self.values["mr_1"] or 0))
		+ (table_data["mr_2"] * (self.values["mr_2"] or 0))
		+ (table_data["mr_3"] * (self.values["mr_3"] or 0))
		+ bonus
end

function modifier_talents:GetModifierPhysicalArmorBonus()
	local bonus = 0
	if self.values["bonus_str_4"] and self.values["bonus_str_4"] > 0 and self:GetCaster():GetHealthPercent() < 25 then
		bonus = 20
	end

	return (table_data["armor_1"] * (self.values["armor_1"] or 0))
		+ (table_data["armor_2"] * (self.values["armor_2"] or 0))
		+ (table_data["armor_3"] * (self.values["armor_3"] or 0))
		+ bonus
end

function modifier_talents:GetModifierPreAttack_BonusDamage()
	local bonus = 0
	if self.values["bonus_agi_3"] and self.values["bonus_agi_3"] > 0 and self:GetCaster():GetHealthPercent() < 20 then
		bonus = 15 * self:GetStackCount() / 100
	end

	if self.values["bonus_agi_2"] and self.values["bonus_agi_2"] > 0 then
		bonus = bonus + 10 * self:GetStackCount() / 100
	end

	if self.values["bonus_int_6"] and self.values["bonus_int_6"] > 0 then
		bonus = bonus - 25 * self:GetStackCount() / 100
	end

	if self.values["bonus_agi_13"] and self.values["bonus_agi_13"] > 0 then
		bonus = bonus + math.max(0, self:GetCaster():GetIncreasedAttackSpeed(false) * 100)
		if self:GetParent():HasModifier("modifier_bonus_agi_15") then
			bonus = bonus - 1450
		end
	end

	return (table_data["damage_1"] * (self.values["damage_1"] or 0))
		+ (table_data["damage_2"] * (self.values["damage_2"] or 0))
		+ (table_data["damage_3"] * (self.values["damage_3"] or 0))
		+ bonus
end

function modifier_talents:GetModifierEvasion_Constant()
	return (table_data["evasion_1"] * (self.values["evasion_1"] or 0))
		+ (table_data["evasion_2"] * (self.values["evasion_2"] or 0))
		+ (table_data["evasion_3"] * (self.values["evasion_3"] or 0))
end

function modifier_talents:GetModifierAttackSpeedBonus_Constant()
	local bonus = 0
	if self.values["bonus_agi_4"] and self.values["bonus_agi_4"] > 0 then
		local max_health = self:GetParent():GetMaxHealth()
		local current_health = self:GetParent():GetHealth()
		local missing_health_percent = ((max_health - current_health) / max_health) * 100
		bonus = bonus + math.floor(missing_health_percent / 2)
	end

	return (table_data["attack_speed_1"] * (self.values["attack_speed_1"] or 0))
		+ (table_data["attack_speed_2"] * (self.values["attack_speed_2"] or 0))
		+ (table_data["attack_speed_3"] * (self.values["attack_speed_3"] or 0))
		+ bonus
end

function modifier_talents:GetModifierMoveSpeedBonus_Constant()
	return (table_data["move_speed_1"] * (self.values["move_speed_1"] or 0))
		+ (table_data["move_speed_2"] * (self.values["move_speed_2"] or 0))
		+ (table_data["move_speed_3"] * (self.values["move_speed_3"] or 0))
end

function modifier_talents:GetModifierManaBonus()
	return (table_data["mana_1"] * (self.values["mana_1"] or 0))
		+ (table_data["mana_2"] * (self.values["mana_2"] or 0))
		+ (table_data["mana_3"] * (self.values["mana_3"] or 0))
end

function modifier_talents:GetModifierStatusResistanceStacking()
	local bonus = 0
	if self.values["bonus_str_10"] and self.values["bonus_str_10"] > 0 and self:GetCaster():GetHealthPercent() < 30 then
		bonus = 30
	end

	return (table_data["status_1"] * (self.values["status_1"] or 0))
		+ (table_data["status_2"] * (self.values["status_2"] or 0))
		+ (table_data["status_3"] * (self.values["status_3"] or 0))
		+ bonus
end

function modifier_talents:GetModifierHealthBonus()
	local bonus = 0
	if self.values["bonus_str_14"] and self.values["bonus_str_14"] > 0 then
		bonus = 20 * self:GetCaster():GetPhysicalArmorValue(false)
	end

	return (table_data["hp_1"] * (self.values["hp_1"] or 0))
		+ (table_data["hp_2"] * (self.values["hp_2"] or 0))
		+ (table_data["hp_3"] * (self.values["hp_3"] or 0))
		+ bonus
end

function modifier_talents:GetModifierMoveSpeedBonus_Percentage()
	local bonus = 0
	if self.values["bonus_agi_2"] and self.values["bonus_agi_2"] > 0 then
		bonus = -15
	end

	if
		self.values["bonus_agi_9"]
		and self.values["bonus_agi_9"] > 0
		and GetManaPercentClient(self:GetCaster()) > 50
	then
		bonus = bonus + 10
	end

	if
		self.values["bonus_int_7"]
		and self.values["bonus_int_7"] > 0
		and GetManaPercentClient(self:GetCaster()) > 50
	then
		bonus = bonus + 10
	end

	return bonus
end

function modifier_talents:GetModifierPercentageManacost()
	local bonus = 0
	if self.values["bonus_int_3"] and self.values["bonus_int_3"] > 0 then
		bonus = 5
	end

	if
		self.values["bonus_int_12"]
		and self.values["bonus_int_12"] > 0
		and GetManaPercentClient(self:GetCaster()) < 10
	then
		bonus = bonus + 15
	end

	return bonus
end

function modifier_talents:GetModifierHealthRegenPercentage()
	local bonus = 0
	if self.values["bonus_str_6"] and self.values["bonus_str_6"] > 0 then
		bonus = 2
	end

	if
		self.values["bonus_str_3"]
		and self.values["bonus_str_3"] > 0
		and not self:GetParent():HasModifier("modifier_in_fight_lua")
	then
		bonus = bonus + 2
	end
	return bonus
end

function modifier_talents:GetModifierTotalPercentageManaRegen()
	local bonus = 0
	if
		self.values["bonus_int_5"]
		and self.values["bonus_int_5"] > 0
		and not self:GetParent():HasModifier("modifier_in_fight_lua")
	then
		bonus = 3
	end
	return bonus
end

function modifier_talents:GetModifierIncomingDamage_Percentage(keys)
	local damage = keys.damage

	local bonus = 0
	if self.values["bonus_str_11"] and self.values["bonus_str_11"] > 0 and keys.damage_type == 1 then
		bonus = bonus + -5
	end

	if self.values["bonus_str_12"] and self.values["bonus_str_12"] > 0 and keys.damage_type == 2 then
		bonus = bonus + -5
	end

	if
		self.values["bonus_int_10"]
		and self.values["bonus_int_10"] > 0
		and GetManaPercentClient(self:GetParent()) > 90
	then
		bonus = bonus + -10
	end

	if
		self.values["bonus_str_7"]
		and self.values["bonus_str_7"] > 0
		and keys.damage > self:GetParent():GetMaxHealth() * 0.25
	then
		bonus = bonus + -15
	end

	if self.values["bonus_agi_14"] and self.values["bonus_agi_14"] > 0 then
		if RandomInt(1, 100) <= 5 then
			local backtrack_fx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf",
				PATTACH_ABSORIGIN,
				self:GetParent()
			)
			ParticleManager:SetParticleControl(backtrack_fx, 0, self:GetParent():GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(backtrack_fx)
			return -9999
		end
	end

	if self.values["bonus_agi_5"] and self.values["bonus_agi_5"] > 0 and keys.damage_category == 0 then
		if RandomInt(1, 100) <= 10 then
			local backtrack_fx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf",
				PATTACH_ABSORIGIN,
				self:GetParent()
			)
			ParticleManager:SetParticleControl(backtrack_fx, 0, self:GetParent():GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(backtrack_fx)
			return -9999
		end
	end

	if
		damage >= self:GetParent():GetHealth()
		and self.values["bonus_str_8"]
		and self.values["bonus_str_8"] > 0
		and not self:GetParent():HasModifier("modifier_invu_lua")
	then
		self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_bonus_str_8", { duration = 1.5 })
		self:GetParent():EmitSound("DOTA_Item.ComboBreaker")
		local combo_breaker_particle = ParticleManager:CreateParticle(
			"particles/items4_fx/combo_breaker_buff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			combo_breaker_particle,
			1,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetAbsOrigin(),
			true
		)
		self:AddParticle(combo_breaker_particle, false, false, -1, true, false)

		self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_invu_lua", { duration = 300 })
		return -9999
	end

	if
		damage >= self:GetParent():GetHealth()
		and self.values["bonus_str_15"]
		and self.values["bonus_str_15"] > 0
		and not self:GetParent():HasModifier("modifier_hp_regen_boost_lua")
	then
		local amount = self:GetParent():GetMaxHealth() * 0.15
		self:GetParent():Heal(amount, self)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), amount, nil)
		self:GetCaster():EmitSound("DOTA_Item.Mekansm.Activate")
		self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_hp_regen_boost_lua", { duration = 300 })
		return -9999
	end

	return bonus
end

function modifier_talents:OnTakeDamage(keys)
	if not IsServer() then
		return
	end
	if keys.unit ~= self:GetParent() then
		return
	end
	if bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
		return
	end

	local parent = self:GetParent()
	local attacker = keys.attacker
	local target = keys.unit

	parent:AddNewModifier(parent, self, "modifier_in_fight_lua", { duration = 10 })

	if self.values["bonus_str_13"] and self.values["bonus_str_13"] > 0 then
		local particle_return_fx = ParticleManager:CreateParticle(particle_return, PATTACH_ABSORIGIN, target)
		ParticleManager:SetParticleControlEnt(
			particle_return_fx,
			0,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			target:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			particle_return_fx,
			1,
			attacker,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			attacker:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle_return_fx)

		local return_damage = target:GetBaseDamageMin() * 0.05
		if attacker:IsCreep() and keys.damage_type ~= 4 then
			ApplyDamage({
				victim = attacker,
				attacker = target,
				damage = return_damage,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL
					+ DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
					+ DOTA_DAMAGE_FLAG_REFLECTION
					+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			})
		end
	end

	if keys.damage_type == 2 and self.values["bonus_int_14"] and self.values["bonus_int_14"] > 0 then
		parent:AddNewModifier(parent, self, "modifier_bonus_int_14", { duration = 3 })
	end

	if
		parent:GetHealthPercent() < 20
		and self.values["bonus_str_5"]
		and self.values["bonus_str_5"] > 0
		and not parent:HasModifier("modifier_fear_lua")
	then
		parent:AddNewModifier(parent, self, "modifier_fear_lua", { duration = 120 })

		local wave_particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_scepter.vpcf",
			PATTACH_WORLDORIGIN,
			parent
		)
		ParticleManager:SetParticleControl(wave_particle, 0, parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(wave_particle, 1, Vector(500, 500, 500))
		ParticleManager:SetParticleControl(wave_particle, 2, Vector(500, 500, 500))
		ParticleManager:ReleaseParticleIndex(wave_particle)
		parent:EmitSound("Hero_Terrorblade.Metamorphosis.Fear")

		for _, enemy in
			pairs(
				FindUnitsInRadius(
					self:GetCaster():GetTeamNumber(),
					parent:GetAbsOrigin(),
					parent,
					math.min(500 * (self:GetElapsedTime() - 0.6), 500),
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
			)
		do
			if enemy:IsCreep() then
				enemy:AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_fear", { duration = 0.6 })
			end
		end
	end
end

function modifier_talents:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if parent ~= params.attacker and parent ~= params.target then
		return
	end

	if parent == params.attacker then
		local current_lifesteal = (table_data["lifesteal_1"] * (self.values["lifesteal_1"] or 0))
			+ (table_data["lifesteal_2"] * (self.values["lifesteal_2"] or 0))
			+ (table_data["lifesteal_3"] * (self.values["lifesteal_3"] or 0))
		local heal = params.damage * current_lifesteal / 100
		if heal > 1 then
			self:GetParent():Heal(heal, self)
			self:PlayEffects(self:GetParent())
		end
		if self.values["bonus_agi_12"] and self.values["bonus_agi_12"] > 0 then
			ApplyDamage({
				victim = params.target,
				attacker = params.attacker,
				damage = self:GetParent():GetAttackDamage() * 0.05,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
					+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			})
			EmitSoundOn("Hero_Spectre.Desolate", self:GetParent())
		end
	end

	if self.values["bonus_agi_11"] and self.values["bonus_agi_11"] > 0 then
		if params.target == parent and params.attacker:GetTeamNumber() ~= params.target:GetTeamNumber() then
			if RandomInt(1, 100) <= 10 then
				if
					(params.target:GetAbsOrigin() - params.attacker:GetAbsOrigin()):Length2D()
					< params.target:Script_GetAttackRange()
				then
					StartAnimation(self:GetParent(), { duration = 0.1, activity = ACT_DOTA_ATTACK_EVENT })
					params.target:PerformAttack(params.attacker, false, true, true, false, true, false, false)
					EmitSoundOn("Hero_LegionCommander.Courage", self:GetParent())
				end
			end
		end
	end
end

function modifier_talents:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_talents:OnIntervalThink()
	if IsServer() then
		if self:GetCaster():IsAlive() then
			local needAllies = (self.values["bonus_str_1"] or 0) > 0 or (self.values["bonus_str_2"] or 0) > 0
			local needEnemies = (self.values["bonus_agi_6"] or 0) > 0
			local changed = false

			-- поиск союзников нужен только под таланты bonus_str_1 / bonus_str_2
			if needAllies then
				local allies = FindUnitsInRadius(
					self:GetCaster():GetTeamNumber(),
					self:GetCaster():GetAbsOrigin(),
					self:GetCaster(),
					500,
					DOTA_UNIT_TARGET_TEAM_FRIENDLY,
					DOTA_UNIT_TARGET_HERO,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_CLOSEST,
					false
				)
				local n = #allies
				if n ~= self._dms_lastAllies then
					self._dms_lastAllies = n
					changed = true
					if (self.values["bonus_str_1"] or 0) > 0 then
						if not self._dms_mod_str_1 or self._dms_mod_str_1:IsNull() then
							self._dms_mod_str_1 = self:GetCaster()
								:AddNewModifier(self:GetCaster(), nil, "modifier_bonus_str_1", {})
						end
						self._dms_mod_str_1:SetStackCount(n)
					end
					if (self.values["bonus_str_2"] or 0) > 0 then
						if not self._dms_mod_str_2 or self._dms_mod_str_2:IsNull() then
							self._dms_mod_str_2 = self:GetCaster()
								:AddNewModifier(self:GetCaster(), nil, "modifier_bonus_str_2", {})
						end
						self._dms_mod_str_2:SetStackCount(n)
					end
				end
			end

			-- поиск врагов нужен только под талант bonus_agi_6
			if needEnemies then
				local enemies = FindUnitsInRadius(
					self:GetCaster():GetTeamNumber(),
					self:GetCaster():GetAbsOrigin(),
					self:GetCaster(),
					400,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_CLOSEST,
					false
				)
				local n = #enemies
				if n ~= self._dms_lastEnemies then
					self._dms_lastEnemies = n
					changed = true
					if not self._dms_mod_agi_6 or self._dms_mod_agi_6:IsNull() then
						self._dms_mod_agi_6 = self:GetCaster()
							:AddNewModifier(self:GetCaster(), nil, "modifier_bonus_agi_6", {})
					end
					self._dms_mod_agi_6:SetStackCount(n)
				end
			end

			-- self stack = базовый минимальный урон; обновляем только при изменении
			local dmg = self:GetParent():GetBaseDamageMin()
			if dmg ~= self._dms_lastBaseDmg then
				self._dms_lastBaseDmg = dmg
				self:SetStackCount(dmg)
				changed = true
			end

			-- тяжёлый полный пересчёт стат — только если что-то реально поменялось
			if changed then
				self:GetParent():CalculateStatBonus(true)
			end
		end
	end

	if
		self.values["bonus_int_15"]
		and self.values["bonus_int_15"] > 0
		and GetManaPercentClient(self:GetParent()) < 10
		and not self:GetParent():HasModifier("modifier_talent_mag_resist_lua")
	then
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_bonus_int_15", { duration = 3 })
		EmitSoundOn("DOTA_Item.BlackKingBar.Activate", self:GetParent())
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_talent_mag_resist_lua", { duration = 120 })
	end
end

LinkLuaModifier("modifier_bonus_int_15", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)

modifier_bonus_int_15 = class({})

function modifier_bonus_int_15:IsHidden()
	return true
end

function modifier_bonus_int_15:IsDebuff()
	return false
end

function modifier_bonus_int_15:IsPurgable()
	return false
end

function modifier_bonus_int_15:GetEffectName()
	return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_bonus_int_15:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_bonus_int_15:CheckState()
	local state = { [MODIFIER_STATE_MAGIC_IMMUNE] = true }
	return state
end

LinkLuaModifier("modifier_bonus_agi_6", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)

modifier_bonus_agi_6 = class({})

function modifier_bonus_agi_6:IsHidden()
	return true
end

function modifier_bonus_agi_6:IsDebuff()
	return false
end

function modifier_bonus_agi_6:IsPurgable()
	return false
end

function modifier_bonus_agi_6:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}
	return decFuncs
end

function modifier_bonus_agi_6:GetModifierMoveSpeedBonus_Constant()
	return 3 * self:GetStackCount()
end

LinkLuaModifier("modifier_bonus_int_14", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)

modifier_bonus_int_14 = class({})

function modifier_bonus_int_14:IsHidden()
	return true
end

function modifier_bonus_int_14:IsDebuff()
	return false
end

function modifier_bonus_int_14:IsPurgable()
	return false
end

function modifier_bonus_int_14:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return decFuncs
end

function modifier_bonus_int_14:GetModifierMoveSpeedBonus_Percentage()
	return 10
end

LinkLuaModifier("modifier_bonus_str_8", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)

modifier_bonus_str_8 = class({})

function modifier_bonus_str_8:IsHidden()
	return true
end

function modifier_bonus_str_8:IsDebuff()
	return false
end

function modifier_bonus_str_8:IsPurgable()
	return false
end

function modifier_bonus_str_8:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
	return decFuncs
end

function modifier_bonus_str_8:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_bonus_str_8:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_bonus_str_8:GetAbsoluteNoDamagePure()
	return 1
end

LinkLuaModifier("modifier_bonus_str_1", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)

modifier_bonus_str_1 = class({})

function modifier_bonus_str_1:IsHidden()
	return true
end

function modifier_bonus_str_1:IsDebuff()
	return false
end

function modifier_bonus_str_1:IsPurgable()
	return false
end

function modifier_bonus_str_1:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_bonus_str_1:GetModifierPhysicalArmorBonus()
	return 3 * self:GetStackCount()
end

LinkLuaModifier("modifier_bonus_str_2", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)

modifier_bonus_str_2 = class({})

function modifier_bonus_str_2:IsHidden()
	return true
end

function modifier_bonus_str_2:IsDebuff()
	return false
end

function modifier_bonus_str_2:IsPurgable()
	return false
end

function modifier_bonus_str_2:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_bonus_str_2:GetModifierMagicalResistanceBonus()
	return 2 * self:GetStackCount()
end

LinkLuaModifier("modifier_bonus_agi_15", "modifiers/modifier_talents", LUA_MODIFIER_MOTION_NONE)

modifier_bonus_agi_15 = class({})

function modifier_bonus_agi_15:IsHidden()
	return true
end

function modifier_bonus_agi_15:IsPurgable()
	return false
end

function modifier_bonus_agi_15:OnCreated()
	self.proc = false
end

function modifier_bonus_agi_15:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_bonus_agi_15:OnAttack(keys)
	if keys.attacker ~= self:GetParent() then
		return
	end
	self.proc = true
end

function modifier_bonus_agi_15:GetModifierAttackSpeedBonus_Constant()
	if self.proc == false then
		return 1450
	end
	return 0
end