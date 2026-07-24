--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_void_spirit_innate_custom", "abilities/void_spirit/void_spirit_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_void_spirit_innate_custom_aura", "abilities/void_spirit/void_spirit_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_void_spirit_innate_custom_tracker", "abilities/void_spirit/void_spirit_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_void_spirit_innate_custom_scepter_step", "abilities/void_spirit/void_spirit_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_void_spirit_innate_custom_scepter_aura", "abilities/void_spirit/void_spirit_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_void_spirit_innate_custom_scepter_aura_damage", "abilities/void_spirit/void_spirit_innate_custom", LUA_MODIFIER_MOTION_NONE )

void_spirit_innate_custom = class({})


function void_spirit_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/brist_lowhp_.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_faceless_void/faceless_void_dialatedebuf_2.vpcf", context )
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_void_spirit.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_void_spirit", context)
end




function void_spirit_innate_custom:GetIntrinsicModifierName()
if self:GetCaster():IsRealHero() then
	return "modifier_void_spirit_innate_custom"
else
	return "modifier_void_spirit_innate_custom_tracker"
end

end

modifier_void_spirit_innate_custom_tracker = class({})
function modifier_void_spirit_innate_custom_tracker:IsHidden() return true end
function modifier_void_spirit_innate_custom_tracker:IsPurgable() return false end
function modifier_void_spirit_innate_custom_tracker:OnCreated()
if not IsServer() then return end
self.ability = self:GetAbility()
self.parent = self:GetParent()

self:StartIntervalThink(0.1)
end

function modifier_void_spirit_innate_custom_tracker:OnIntervalThink()
if not IsServer() then return end
if not self.parent.owner or self.parent.owner:IsNull() then return end

self.parent:AddNewModifier(self.parent.owner, self.ability, "modifier_void_spirit_innate_custom", {})

if self.parent:HasModifier("modifier_void_spirit_innate_custom") then
	self:StartIntervalThink(-1)
end

end



modifier_void_spirit_innate_custom = class({})
function modifier_void_spirit_innate_custom:IsHidden() return not self:GetParent():HasScepter() end
function modifier_void_spirit_innate_custom:IsPurgable() return false end
function modifier_void_spirit_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.move_bonus = self.parent:GetTalentValue("modifier_void_remnant_2", "bonus", true)
self.move_speed = 0
self.damage_bonus = 0
self.attack_speed = 0
self.evasion_bonus = 0

self.speed_bonus = self.parent:GetTalentValue("modifier_void_pulse_2", "bonus", true)
self.aura_radius = self.parent:GetTalentValue("modifier_void_pulse_2", "radius", true)

self.scepter_bva = self.ability:GetSpecialValueFor("scepter_agi_bva")
self.scepter_heal = self.ability:GetSpecialValueFor("scepter_agi_heal")/100
self.scepter_health = self.ability:GetSpecialValueFor("scepter_str_health")
self.scepter_damage = self.ability:GetSpecialValueFor("scepter_int_damage")
self.scepter_cd = self.ability:GetSpecialValueFor("scepter_cd")
self.scepter_timer = 0
self.interval = 1
self.scepter_agi = 0
self.scepter_str = 0
self.scepter_int = 0

self.current_max_stat = -1

self.bonus = self.ability:GetSpecialValueFor("bonus")/100
if not IsServer() then return end 

if self.parent:IsRealHero() then
	self.parent:AddDamageEvent_out(self)
end

if self.parent:IsIllusion() and self.parent:HasScepter() then
	local mod = self.caster:FindModifierByName("modifier_void_spirit_innate_custom")
	if mod then
		self:SetStackCount(mod:GetStackCount())
		self.scepter_agi = mod.scepter_agi
		self.scepter_str = mod.scepter_str
		self.scepter_int = mod.scepter_int
	end
end

self.armor_agi = GameRules:GetGameModeEntity():GetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_AGILITY_ARMOR)
self.int_mana = GameRules:GetGameModeEntity():GetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_MANA_REGEN)
self.int_resist = GameRules:GetGameModeEntity():GetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_MAGIC_RESIST)
self.str_health = GameRules:GetGameModeEntity():GetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_HP_REGEN)

self:StartIntervalThink(0.2)

self.init = false

self:SetHasCustomTransmitterData(true)
end

function modifier_void_spirit_innate_custom:GetMaxStat()
if self.parent:GetStrength() >= self.parent:GetAgility() then
	if self.parent:GetStrength() >= self.parent:GetIntellect(false) then
		return 0
	else
		return 2
	end
else
	if self.parent:GetAgility() >= self.parent:GetIntellect(false) then
		return 1
	else
		return 2
	end
end

end

function modifier_void_spirit_innate_custom:OnIntervalThink()
if not IsServer() then return end 

if self.init == false then
	self.init = true
	self:UpdateTalent()
end

if not self.base_magic then 
	self.base_magic = self.parent:GetBaseMagicalResistanceValue() - self.parent:GetIntellect(false)*self.int_resist
	self.base_armor = self.parent:GetPhysicalArmorBaseValue() - self.parent:GetAgility()*self.armor_agi
	self.base_mana = self.parent:GetBaseManaRegen() - self.parent:GetIntellect(false)*self.int_mana
	self.base_health = self.parent:GetBaseHealthRegen() - self.parent:GetStrength()*self.str_health
end

self.parent:SetBaseMagicalResistanceValue(self.base_magic + self.parent:GetIntellect(false)*self.int_resist*self.bonus)
self.parent:SetBaseManaRegen(self.base_mana + self.parent:GetIntellect(false)*self.int_mana*self.bonus)
self.parent:SetPhysicalArmorBaseValue(self.base_armor + self.parent:GetAgility()*self.armor_agi*self.bonus)
self.parent:SetBaseHealthRegen(self.base_health + self.parent:GetStrength()*self.str_health*self.bonus)


if self.parent:HasScepter() then
	local max_stat = self:GetMaxStat()
	if self.current_max_stat ~= max_stat then
		self.current_max_stat = max_stat
		self.parent:RemoveModifierByName("modifier_void_spirit_innate_custom_scepter_step")
		self.parent:RemoveModifierByName("modifier_void_spirit_innate_custom_scepter_aura")

		local effect_name
		if self.current_max_stat == 0 then
			effect_name = "particles/brist_lowhp_.vpcf"
		elseif self.current_max_stat == 1 then
			effect_name = "particles/general/patrol_refresh.vpcf"
		elseif self.current_max_stat == 2 then
			effect_name = "particles/rare_orb_patrol.vpcf"
		end

		if self.parent:IsRealHero() then
			self.parent:EmitSound("Void.Scepter_change")
			self.parent:GenericParticle(effect_name)
		end
		self:SendBuffRefreshToClients()
		self.parent:CalculateStatBonus(true)
	end

	if self.current_max_stat == 0 and not self.parent:HasModifier("modifier_void_spirit_innate_custom_scepter_aura") then
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_void_spirit_innate_custom_scepter_aura", {})
	end

	if self.current_max_stat == 2 and not self.parent:HasModifier("modifier_void_spirit_innate_custom_scepter_step") then
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_void_spirit_innate_custom_scepter_step", {})
	end

	if self.parent:IsRealHero() then
		self.scepter_timer = self.scepter_timer + self.interval
		if self.scepter_timer >= self.scepter_cd then
			self.scepter_timer = 0 
			self:IncrementStackCount()
			if self.current_max_stat == 0 then
				self.scepter_str = self.scepter_str + 1
			elseif self.current_max_stat == 1 then
				self.scepter_agi = self.scepter_agi + 1
			elseif self.current_max_stat == 2 then
				self.scepter_int = self.scepter_int + 1
			end
			self:SendBuffRefreshToClients()
			self.parent:CalculateStatBonus(true)
		end
	end
else
	self.current_max_stat = -1
	if self.parent:HasModifier("modifier_void_spirit_innate_custom_scepter_step") then
		self.parent:RemoveModifierByName("modifier_void_spirit_innate_custom_scepter_step")
	end
	if self.parent:HasModifier("modifier_void_spirit_innate_custom_scepter_aura") then
		self.parent:RemoveModifierByName("modifier_void_spirit_innate_custom_scepter_aura")
	end
end

self:StartIntervalThink(self.interval)
end



function modifier_void_spirit_innate_custom:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasScepter() then return end
if self.parent ~= params.attacker then return end
if not self.parent:CheckLifesteal(params, 2) then return end
if self.current_max_stat ~= 1 then return end

self.parent:GenericHeal(params.damage*self.scepter_heal, self.ability, true, nil, "scepter")
end


function modifier_void_spirit_innate_custom:UpdateTalent(name)
self.move_speed = self.parent:GetTalentValue("modifier_void_remnant_2", "move")
self.evasion_bonus = self.parent:GetTalentValue("modifier_void_remnant_2", "evasion")

self.damage_bonus = self.parent:GetTalentValue("modifier_void_remnant_1", "damage_bonus")

self.attack_speed = self.parent:GetTalentValue("modifier_void_pulse_2", "speed")

if name == "modifier_void_remnant_2" or self.parent:HasTalent("modifier_void_remnant_2") then
	local mod = self.parent:FindModifierByName("modifier_custom_void_remnant_tracker")
	if mod then
		mod:UpdateTalent("modifier_void_remnant_2")
	end
end

self:SendBuffRefreshToClients()
end


function modifier_void_spirit_innate_custom:AddCustomTransmitterData() 
return 
{
  attack_speed = self.attack_speed,
  move_speed = self.move_speed,
  damage_bonus = self.damage_bonus,
  evasion_bonus = self.evasion_bonus,
  current_max_stat = self.current_max_stat,
  scepter_agi = self.scepter_agi,
  scepter_str = self.scepter_str,
  scepter_int = self.scepter_int
} 
end

function modifier_void_spirit_innate_custom:HandleCustomTransmitterData(data)
self.attack_speed = data.attack_speed
self.move_speed = data.move_speed
self.damage_bonus = data.damage_bonus
self.evasion_bonus = data.evasion_bonus
self.current_max_stat = data.current_max_stat
self.scepter_agi = data.scepter_agi
self.scepter_int = data.scepter_int
self.scepter_str = data.scepter_str
end


function modifier_void_spirit_innate_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_EVASION_CONSTANT,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_void_spirit_innate_custom:GetModifierBonusStats_Agility()
if not self.parent:HasScepter() then return end
return self.scepter_agi
end

function modifier_void_spirit_innate_custom:GetModifierBonusStats_Strength()
if not self.parent:HasScepter() then return end
return self.scepter_str
end

function modifier_void_spirit_innate_custom:GetModifierBonusStats_Intellect()
if not self.parent:HasScepter() then return end
return self.scepter_int
end

function modifier_void_spirit_innate_custom:GetModifierSpellAmplify_Percentage()
if not self.parent:HasScepter() or self.current_max_stat ~= 2 then return end 
return self.scepter_damage
end

function modifier_void_spirit_innate_custom:GetModifierBaseAttackTimeConstant()
if not self.parent:HasScepter() or self.current_max_stat ~= 1 then return end 
return self.scepter_bva
end

function modifier_void_spirit_innate_custom:GetModifierHealthBonus()
if not self.parent:HasScepter() or self.current_max_stat ~= 0 then return end 
return self.scepter_health*self.parent:GetStrength()
end

function modifier_void_spirit_innate_custom:GetModifierDamageOutgoing_Percentage()
return self.damage_bonus
end


function modifier_void_spirit_innate_custom:GetModifierAttackSpeedBonus_Constant() 
local bonus = self.attack_speed
if self.caster:HasModifier("modifier_void_spirit_resonant_pulse") then 
	bonus = bonus*self.speed_bonus
end 
return bonus
end

function modifier_void_spirit_innate_custom:GetModifierMoveSpeedBonus_Constant()
local bonus = self.move_speed
if self.caster:HasModifier("modifier_custom_void_remnant_bonus") then 
	bonus = bonus*self.move_bonus
end 
return bonus
end

function modifier_void_spirit_innate_custom:GetModifierEvasion_Constant()
local bonus = self.evasion_bonus
if self.caster:HasModifier("modifier_custom_void_remnant_bonus") then 
	bonus = bonus*self.move_bonus
end 
return bonus
end

function modifier_void_spirit_innate_custom:IsAura() return self.parent:HasTalent("modifier_void_pulse_2") end
function modifier_void_spirit_innate_custom:GetAuraDuration() return 0.1 end
function modifier_void_spirit_innate_custom:GetAuraRadius() return self.aura_radius end
function modifier_void_spirit_innate_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_void_spirit_innate_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_void_spirit_innate_custom:GetModifierAura() return "modifier_void_spirit_innate_custom_aura" end


modifier_void_spirit_innate_custom_aura = class({})
function modifier_void_spirit_innate_custom_aura:IsHidden() return false end
function modifier_void_spirit_innate_custom_aura:IsPurgable() return false end
function modifier_void_spirit_innate_custom_aura:GetTexture() return "buffs/flux_speed" end
function modifier_void_spirit_innate_custom_aura:OnCreated()
self.caster = self:GetCaster()
self.slow = self.caster:GetTalentValue("modifier_void_pulse_2", "slow")
self.speed_bonus = self.caster:GetTalentValue("modifier_void_pulse_2", "bonus", true)
end

function modifier_void_spirit_innate_custom_aura:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_void_spirit_innate_custom_aura:GetModifierAttackSpeedBonus_Constant()
local bonus = self.slow
if self.caster:HasModifier("modifier_void_spirit_resonant_pulse") then 
	bonus = bonus*self.speed_bonus
end 
return bonus
end



modifier_void_spirit_innate_custom_scepter_step = class({})
function modifier_void_spirit_innate_custom_scepter_step:IsHidden() return true end
function modifier_void_spirit_innate_custom_scepter_step:IsPurgable() return false end
function modifier_void_spirit_innate_custom_scepter_step:RemoveOnDeath() return false end
function modifier_void_spirit_innate_custom_scepter_step:OnCreated()
if not IsServer() then return end
self:SetStackCount(self:GetAbility():GetSpecialValueFor("scepter_int_cd"))
end


modifier_void_spirit_innate_custom_scepter_aura = class({})
function modifier_void_spirit_innate_custom_scepter_aura:IsHidden() return true end
function modifier_void_spirit_innate_custom_scepter_aura:IsPurgable() return false end
function modifier_void_spirit_innate_custom_scepter_aura:RemoveOnDeath() return false end
function modifier_void_spirit_innate_custom_scepter_aura:OnCreated()
self.aura_radius = self:GetAbility():GetSpecialValueFor("scepter_str_radius")
end

function modifier_void_spirit_innate_custom_scepter_aura:IsAura() return true end
function modifier_void_spirit_innate_custom_scepter_aura:GetAuraDuration() return 0.1 end
function modifier_void_spirit_innate_custom_scepter_aura:GetAuraRadius() return self.aura_radius end
function modifier_void_spirit_innate_custom_scepter_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_void_spirit_innate_custom_scepter_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_void_spirit_innate_custom_scepter_aura:GetModifierAura() return "modifier_void_spirit_innate_custom_scepter_aura_damage" end



modifier_void_spirit_innate_custom_scepter_aura_damage = class({})
function modifier_void_spirit_innate_custom_scepter_aura_damage:IsHidden() return true end
function modifier_void_spirit_innate_custom_scepter_aura_damage:IsPurgable() return false end
function modifier_void_spirit_innate_custom_scepter_aura_damage:GetTexture() return "buffs/astral_burn" end
function modifier_void_spirit_innate_custom_scepter_aura_damage:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()

if self.caster.owner then 
	self.caster = self.caster.owner
end

self.ability = self.caster:FindAbilityByName(self:GetAbility():GetName())
if not self.ability then 
	return
end

self.interval = self.ability:GetSpecialValueFor("scepter_str_interval")
self.damage =  self.interval*self.ability:GetSpecialValueFor("scepter_str_damage")/100

self.parent:GenericParticle("particles/units/heroes/hero_faceless_void/faceless_void_dialatedebuf_2.vpcf", self)
self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}
self:StartIntervalThink(self.interval)
end


function modifier_void_spirit_innate_custom_scepter_aura_damage:OnIntervalThink()
if not IsServer() then return end
if not self.caster or self.caster:IsNull() then
	self:Destroy()
	return
end

local damage = self.caster:GetMaxHealth()*self.damage
self.damageTable.damage = damage

DoDamage(self.damageTable, "Scepter")
end

