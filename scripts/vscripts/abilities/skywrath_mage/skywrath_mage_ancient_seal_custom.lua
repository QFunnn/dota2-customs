--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skywrath_mage_ancient_seal_custom_silence", "abilities/skywrath_mage/skywrath_mage_ancient_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_ancient_seal_custom_legendary", "abilities/skywrath_mage/skywrath_mage_ancient_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_ancient_seal_custom_legendary_self", "abilities/skywrath_mage/skywrath_mage_ancient_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_ancient_seal_custom_legendary_self_effect", "abilities/skywrath_mage/skywrath_mage_ancient_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_ancient_seal_custom_tracker", "abilities/skywrath_mage/skywrath_mage_ancient_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_ancient_seal_custom_armor", "abilities/skywrath_mage/skywrath_mage_ancient_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_ancient_seal_custom_damage", "abilities/skywrath_mage/skywrath_mage_ancient_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_ancient_seal_custom_silence_cd", "abilities/skywrath_mage/skywrath_mage_ancient_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_ancient_seal_custom_pause", "abilities/skywrath_mage/skywrath_mage_ancient_seal_custom", LUA_MODIFIER_MOTION_NONE)


skywrath_mage_ancient_seal_custom = class({})

function skywrath_mage_ancient_seal_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "skywrath_mage_ancient_seal", self)
end

function skywrath_mage_ancient_seal_custom:CreateTalent(name)

if name == "modifier_sky_seal_7" then 
	if not self:IsHidden() then 
		self:GetCaster():SwapAbilities(self:GetName(), "skywrath_mage_ancient_seal_custom_legendary", false, true)
	end
end

end


function skywrath_mage_ancient_seal_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/enigma/midnight_pulse.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_slow.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_skywrath_mage/skywrath_mage_ancient_seal_debuff.vpcf", context )
PrecacheResource( "particle","particles/skywrath/seal_legendary.vpcf", context )
PrecacheResource( "particle","particles/skywrath/seal_legendary_self.vpcf", context )
PrecacheResource( "particle","particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_phylactery.vpcf", context )
PrecacheResource( "particle","particles/skywrath/seal_refresh.vpcf", context )
end


function skywrath_mage_ancient_seal_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_skywrath_mage_ancient_seal_custom_tracker"
end

function skywrath_mage_ancient_seal_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sky_seal_3") then 
	bonus = self:GetCaster():GetTalentValue("modifier_sky_seal_3", "cd")
end 
return self.BaseClass.GetCooldown( self, level ) + bonus
end

function skywrath_mage_ancient_seal_custom:OnSpellStart(new_target)

local caster = self:GetCaster()
local seal_duration = self:GetSpecialValueFor("seal_duration") + caster:GetTalentValue("modifier_sky_seal_3", "duration")
local target = self:GetCursorTarget()

if new_target then 
	target = new_target
end

if target:TriggerSpellAbsorb(self) then
  return nil
end

if caster:HasTalent("modifier_sky_flare_4") then 
	target:AddNewModifier(caster, self, "modifier_skywrath_mage_mystic_flare_custom_damage_inc", {duration = caster:GetTalentValue("modifier_sky_flare_4", "duration")})
end

target:EmitSound("Hero_SkywrathMage.AncientSeal.Target" )
target:AddNewModifier(caster, self, "modifier_skywrath_mage_ancient_seal_custom_silence", {duration = seal_duration*(1 - target:GetStatusResistance())}) 
end



skywrath_mage_ancient_seal_custom_legendary = class({})

function skywrath_mage_ancient_seal_custom_legendary:GetAOERadius()
return self:GetCaster():GetTalentValue("modifier_sky_seal_7", "radius")
end

function skywrath_mage_ancient_seal_custom_legendary:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "skywrath_mage_ancient_seal", self)
end

function skywrath_mage_ancient_seal_custom_legendary:GetAbilityChargeRestoreTime(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sky_seal_3") then 
	bonus = self:GetCaster():GetTalentValue("modifier_sky_seal_3", "cd")
end 
return self:GetSpecialValueFor("AbilityChargeRestoreTime") + self:GetCaster():GetTalentValue("modifier_sky_seal_7", "cd") + bonus
end


function skywrath_mage_ancient_seal_custom_legendary:OnSpellStart()

local caster = self:GetCaster()
local seal_duration = self:GetSpecialValueFor("seal_duration") + caster:GetTalentValue("modifier_sky_seal_7", "delay") + caster:GetTalentValue("modifier_sky_seal_3", "duration")
local point = self:GetCursorPosition()
local radius = caster:GetTalentValue("modifier_sky_seal_7", "radius")

caster:AddNewModifier(caster, self, "modifier_skywrath_mage_ancient_seal_custom_pause", {duration = 0.3})

if not caster:HasModifier("modifier_skywrath_mage_mystic_flare_custom_legendary_caster") then
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
end

if caster:HasTalent("modifier_sky_flare_4") then
	for _,target in pairs(caster:FindTargets(radius, point)) do 
		target:AddNewModifier(caster, self, "modifier_skywrath_mage_mystic_flare_custom_damage_inc", {duration = caster:GetTalentValue("modifier_sky_flare_4", "duration")})
	end
end

EmitSoundOnLocationWithCaster(point, "Sky.Seal_legendary", caster)
EmitSoundOnLocationWithCaster(point, "Sky.Seal_legendary_cast", caster)
EmitSoundOnLocationWithCaster(point, "Sky.Seal_legendary2", caster)

AddFOWViewer(caster:GetTeamNumber(), point, caster:GetTalentValue("modifier_sky_seal_7", "radius"), seal_duration, false)

CreateModifierThinker(caster, self, "modifier_skywrath_mage_ancient_seal_custom_legendary", {duration = seal_duration}, point, caster:GetTeamNumber(), false)
CreateModifierThinker(caster, self, "modifier_skywrath_mage_ancient_seal_custom_legendary_self", {duration = seal_duration}, point, caster:GetTeamNumber(), false)
end



modifier_skywrath_mage_ancient_seal_custom_silence = class({})

function modifier_skywrath_mage_ancient_seal_custom_silence:IsHidden() return false end
function modifier_skywrath_mage_ancient_seal_custom_silence:IsPurgable() return true end

function modifier_skywrath_mage_ancient_seal_custom_silence:OnCreated()

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.resist = self.ability:GetSpecialValueFor("resist_debuff") + self.caster:GetTalentValue("modifier_sky_seal_1", "magic")

self.attack_slow = self.caster:GetTalentValue("modifier_sky_seal_6", "attack")
self.move_slow = self.caster:GetTalentValue("modifier_sky_seal_6", "move")

self.heal_reduce = self.caster:GetTalentValue("modifier_sky_seal_1", "heal_reduce")
if not IsServer() then return end

if self.caster:HasTalent("modifier_sky_seal_6") then
	self.parent:GenericParticle("particles/skymage/bolt_slow.vpcf", self)
end

local silence_fx = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_skywrath_mage/skywrath_mage_ancient_seal_debuff.vpcf", self)

self.particle_seal_fx = ParticleManager:CreateParticle(silence_fx, PATTACH_OVERHEAD_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle_seal_fx, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_origin", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle_seal_fx, false, false, -1 , false, true)

self.damage = self.caster:GetTalentValue("modifier_sky_seal_7", "damage", true)/100
self.damageTable = {victim = self.parent, attacker = self.caster, ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL}

self.interval = 1
self.first_tick = false
self:OnIntervalThink()
self:StartIntervalThink(self.interval - FrameTime())
end


function modifier_skywrath_mage_ancient_seal_custom_silence:OnIntervalThink()
if not IsServer() then return end 

if self.caster:HasTalent("modifier_sky_seal_7") then 
	self.damageTable.damage = self.caster:GetMaxMana()*self.damage*self.interval
	DoDamage(self.damageTable, "modifier_sky_seal_7")
end

if self.parent:IsRealHero() and self.caster:GetQuest() == "Sky.Quest_7" and not self.caster:QuestCompleted() and self.first_tick == true then 
	self.caster:UpdateQuest(self.interval)
end

self.first_tick = true
end


function modifier_skywrath_mage_ancient_seal_custom_silence:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}    
end    

function modifier_skywrath_mage_ancient_seal_custom_silence:GetModifierLifestealRegenAmplify_Percentage() 
if not self.caster:HasTalent("modifier_sky_seal_1") then return end
return self.heal_reduce
end

function modifier_skywrath_mage_ancient_seal_custom_silence:GetModifierHealChange() 
if not self.caster:HasTalent("modifier_sky_seal_1") then return end
return self.heal_reduce
end

function modifier_skywrath_mage_ancient_seal_custom_silence:GetModifierHPRegenAmplify_Percentage() 
if not self.caster:HasTalent("modifier_sky_seal_1") then return end
return self.heal_reduce
end

function modifier_skywrath_mage_ancient_seal_custom_silence:GetModifierMagicalResistanceBonus()
return self.resist 
end

function modifier_skywrath_mage_ancient_seal_custom_silence:GetModifierAttackSpeedBonus_Constant()
if not self.caster:HasTalent("modifier_sky_seal_6") then return end
return self.attack_slow
end

function modifier_skywrath_mage_ancient_seal_custom_silence:GetModifierMoveSpeedBonus_Percentage()
if not self.caster:HasTalent("modifier_sky_seal_6") then return end
return self.move_slow
end

function modifier_skywrath_mage_ancient_seal_custom_silence:CheckState() 
if self.caster:HasTalent("modifier_sky_seal_6") then 
	return 
	{
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_PASSIVES_DISABLED] = true
	}
else
	return 
	{
		[MODIFIER_STATE_SILENCED] = true
	}
end

end


modifier_skywrath_mage_ancient_seal_custom_legendary = class({})
function modifier_skywrath_mage_ancient_seal_custom_legendary:IsHidden() return true end
function modifier_skywrath_mage_ancient_seal_custom_legendary:IsPurgable() return false end
function modifier_skywrath_mage_ancient_seal_custom_legendary:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.radius = self.caster:GetTalentValue("modifier_sky_seal_7", "radius")

if not IsServer() then return end 
self.particle = ParticleManager:CreateParticle("particles/skywrath/seal_legendary.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, self:GetRemainingTime(), 0))
self:AddParticle(self.particle, false, false, -1 , false, true)

self:StartIntervalThink(self.caster:GetTalentValue("modifier_sky_seal_7", "delay"))
end

function modifier_skywrath_mage_ancient_seal_custom_legendary:OnIntervalThink()
if not IsServer() then return end 
self:SetStackCount(1)
self:StartIntervalThink(-1)
end


function modifier_skywrath_mage_ancient_seal_custom_legendary:IsAura() return self:GetStackCount() == 1 end
function modifier_skywrath_mage_ancient_seal_custom_legendary:GetAuraDuration() return 0 end
function modifier_skywrath_mage_ancient_seal_custom_legendary:GetAuraRadius() return self.radius end
function modifier_skywrath_mage_ancient_seal_custom_legendary:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_skywrath_mage_ancient_seal_custom_legendary:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_skywrath_mage_ancient_seal_custom_legendary:GetModifierAura() return "modifier_skywrath_mage_ancient_seal_custom_silence" end





modifier_skywrath_mage_ancient_seal_custom_legendary_self = class({})
function modifier_skywrath_mage_ancient_seal_custom_legendary_self:IsHidden() return true end
function modifier_skywrath_mage_ancient_seal_custom_legendary_self:IsPurgable() return false end
function modifier_skywrath_mage_ancient_seal_custom_legendary_self:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.radius = self.caster:GetTalentValue("modifier_sky_seal_7", "radius")
if not IsServer() then return end 
self:StartIntervalThink(self.caster:GetTalentValue("modifier_sky_seal_7", "delay"))
end


function modifier_skywrath_mage_ancient_seal_custom_legendary_self:OnIntervalThink()
if not IsServer() then return end 
self:SetStackCount(1)
self:StartIntervalThink(-1)
end

function modifier_skywrath_mage_ancient_seal_custom_legendary_self:IsAura() return self:GetStackCount() == 1 end
function modifier_skywrath_mage_ancient_seal_custom_legendary_self:GetAuraDuration() return 0.1 end
function modifier_skywrath_mage_ancient_seal_custom_legendary_self:GetAuraRadius() return self.radius end
function modifier_skywrath_mage_ancient_seal_custom_legendary_self:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_skywrath_mage_ancient_seal_custom_legendary_self:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_skywrath_mage_ancient_seal_custom_legendary_self:GetAuraEntityReject(hEntity)
return hEntity ~= self.caster
end
function modifier_skywrath_mage_ancient_seal_custom_legendary_self:GetModifierAura() return "modifier_skywrath_mage_ancient_seal_custom_legendary_self_effect" end




modifier_skywrath_mage_ancient_seal_custom_legendary_self_effect = class({})
function modifier_skywrath_mage_ancient_seal_custom_legendary_self_effect:IsHidden() return false end
function modifier_skywrath_mage_ancient_seal_custom_legendary_self_effect:IsPurgable() return false end
function modifier_skywrath_mage_ancient_seal_custom_legendary_self_effect:OnCreated()
self.caster = self:GetCaster()
self.heal = self.caster:GetTalentValue("modifier_sky_seal_7", "damage")/100

if not IsServer() then return end 
self.caster:GenericParticle("particles/skywrath/seal_legendary_self.vpcf", self)
end

function modifier_skywrath_mage_ancient_seal_custom_legendary_self_effect:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
}
end


function modifier_skywrath_mage_ancient_seal_custom_legendary_self_effect:GetModifierConstantHealthRegen()
return self.heal*self.caster:GetMaxMana()
end




modifier_skywrath_mage_ancient_seal_custom_tracker = class({})
function modifier_skywrath_mage_ancient_seal_custom_tracker:IsHidden() return true end
function modifier_skywrath_mage_ancient_seal_custom_tracker:IsPurgable() return false end
function modifier_skywrath_mage_ancient_seal_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_chance = self.parent:GetTalentValue("modifier_sky_seal_7", "chance", true)

self.armor_duration = self.parent:GetTalentValue("modifier_sky_seal_2", "duration", true)

self.auto_radius = self.parent:GetTalentValue("modifier_sky_seal_5", "radius", true)
self.auto_silence = self.parent:GetTalentValue("modifier_sky_seal_5", "duration", true)
self.auto_cd = self.parent:GetTalentValue("modifier_sky_seal_5", "cd", true)
self.auto_status = self.parent:GetTalentValue("modifier_sky_seal_5", "status", true)

self.parent:AddDamageEvent_out(self)
self.parent:AddSpellEvent(self)
end


function modifier_skywrath_mage_ancient_seal_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
}
end


function modifier_skywrath_mage_ancient_seal_custom_tracker:GetModifierStatusResistanceStacking()
if not self.parent:HasTalent("modifier_sky_seal_5") then return end 
return self.auto_status
end


function modifier_skywrath_mage_ancient_seal_custom_tracker:SpellEvent(params)
if not IsServer() then return end 
if params.ability:IsItem() then return end 
if not self.parent:IsAlive() then return end

local unit = params.unit

if self.parent:HasTalent("modifier_sky_seal_5") and unit:GetTeamNumber() ~= self.parent:GetTeamNumber() and not unit:IsInvulnerable() and unit:IsUnit() and 
	(self.parent:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D() <= self.auto_radius and not unit:HasModifier("modifier_skywrath_mage_ancient_seal_custom_silence_cd") then 

	local particle = ParticleManager:CreateParticle("particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_phylactery.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)

	unit:EmitSound("Hero_SkywrathMage.AncientSeal.Target")
	unit:AddNewModifier(self.parent, self.ability, "modifier_skywrath_mage_ancient_seal_custom_silence", {duration = (1 - unit:GetStatusResistance())*self.auto_silence})
	unit:AddNewModifier(self.parent, self.ability, "modifier_skywrath_mage_ancient_seal_custom_silence_cd", {duration = self.auto_cd})
end


if self.parent ~= unit then return end
if not self.parent:HasTalent("modifier_sky_seal_2") then return end
self.parent:AddNewModifier(self.parent, self.ability, "modifier_skywrath_mage_ancient_seal_custom_armor", {duration = self.armor_duration})
end

function modifier_skywrath_mage_ancient_seal_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end 
if not self.parent:HasModifier("modifier_skywrath_mage_ancient_seal_custom_legendary_self_effect") then return end 
if not params.unit:IsRealHero() then return end
if self.parent ~= params.attacker then return end
if params.damage < 2 then return end

local ability = self.parent:FindAbilityByName("skywrath_mage_ancient_seal_custom_legendary")
if not ability or not ability:IsTrained() then return end 

local charges = ability:GetCurrentAbilityCharges()
local max_charges = ability:GetMaxAbilityCharges(ability:GetLevel())
if charges >= max_charges then return end
if not RollPseudoRandomPercentage(self.legendary_chance,6251,self.parent) then return end

local particle = ParticleManager:CreateParticle("particles/skywrath/seal_refresh.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex(particle)

self.parent:EmitSound("Sky.Seal_refresh")

if charges < max_charges - 1 then 
	ability:SetCurrentAbilityCharges(ability:GetCurrentAbilityCharges() + 1)
else 
	ability:RefreshCharges()
end

end



modifier_skywrath_mage_ancient_seal_custom_armor = class({})
function modifier_skywrath_mage_ancient_seal_custom_armor:IsHidden() return false end
function modifier_skywrath_mage_ancient_seal_custom_armor:IsPurgable() return false end
function modifier_skywrath_mage_ancient_seal_custom_armor:GetTexture() return "buffs/seal_armor" end
function modifier_skywrath_mage_ancient_seal_custom_armor:OnCreated()
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_sky_seal_2", "max")
self.str = self.parent:GetTalentValue("modifier_sky_seal_2", "str")
self.armor = self.parent:GetTalentValue("modifier_sky_seal_2", "armor")
self:SetStackCount(1)
end

function modifier_skywrath_mage_ancient_seal_custom_armor:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()
end

function modifier_skywrath_mage_ancient_seal_custom_armor:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_skywrath_mage_ancient_seal_custom_armor:OnDestroy()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_skywrath_mage_ancient_seal_custom_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_skywrath_mage_ancient_seal_custom_armor:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()
end

function modifier_skywrath_mage_ancient_seal_custom_armor:GetModifierBonusStats_Strength()
return self.str*self:GetStackCount()
end



modifier_skywrath_mage_ancient_seal_custom_damage = class({})
function modifier_skywrath_mage_ancient_seal_custom_damage:IsHidden() return false end
function modifier_skywrath_mage_ancient_seal_custom_damage:IsPurgable() return false end
function modifier_skywrath_mage_ancient_seal_custom_damage:GetTexture() return "buffs/seal_damage" end
function modifier_skywrath_mage_ancient_seal_custom_damage:OnCreated()
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_sky_seal_4", "max")
self.damage = self.parent:GetTalentValue("modifier_sky_seal_4", "damage")
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_skywrath_mage_ancient_seal_custom_damage:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()
end


function modifier_skywrath_mage_ancient_seal_custom_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end


function modifier_skywrath_mage_ancient_seal_custom_damage:GetModifierSpellAmplify_Percentage()
return self:GetStackCount()*self.damage
end



modifier_skywrath_mage_ancient_seal_custom_silence_cd = class({})
function modifier_skywrath_mage_ancient_seal_custom_silence_cd:IsHidden() return true end
function modifier_skywrath_mage_ancient_seal_custom_silence_cd:IsPurgable() return false end
function modifier_skywrath_mage_ancient_seal_custom_silence_cd:OnCreated()
self.RemoveForDuel = true
end

function modifier_skywrath_mage_ancient_seal_custom_silence_cd:RemoveOnDeath() return false end


modifier_skywrath_mage_ancient_seal_custom_pause = class({})
function modifier_skywrath_mage_ancient_seal_custom_pause:IsHidden() return true end
function modifier_skywrath_mage_ancient_seal_custom_pause:IsPurgable() return false end
function modifier_skywrath_mage_ancient_seal_custom_pause:OnCreated()
self.ability = self:GetAbility()
if not IsServer() then return end
self.ability:SetActivated(false)
end

function modifier_skywrath_mage_ancient_seal_custom_pause:OnDestroy()
if not IsServer() then return end
self.ability:SetActivated(true)
end