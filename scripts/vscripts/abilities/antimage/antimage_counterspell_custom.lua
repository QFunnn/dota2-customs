--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_antimage_counterspell_custom", "abilities/antimage/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_counterspell_custom_active", "abilities/antimage/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_counterspell_custom_legendary_damage", "abilities/antimage/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_counterspell_custom_burn_damage", "abilities/antimage/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_counterspell_custom_shield", "abilities/antimage/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_counterspell_custom_shard_shield", "abilities/antimage/antimage_counterspell_custom", LUA_MODIFIER_MOTION_NONE )

antimage_counterspell_custom = class({})
antimage_counterspell_custom.talents = {}

function antimage_counterspell_custom:CreateTalent()
self:ToggleAutoCast()
end

function antimage_counterspell_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/am_spell_damage.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_antimage/antimage_spellshield_reflect.vpcf", context )
PrecacheResource( "particle", "particles/am_lightning.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_antimage/antimage_counter.vpcf", context )
PrecacheResource( "particle", "particles/am_lightning.vpcf", context )
PrecacheResource( "particle", "particles/am_no_mana.vpcf", context )
PrecacheResource( "particle", "particles/void_astral_slow.vpcf", context )
PrecacheResource( "particle", "particles/zeus_resist_stack.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_faceless_void/faceless_void_dialatedebuf_2.vpcf", context )
PrecacheResource( "particle", "particles/am_spell_damage.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_antimage/antimage_manabreak_slow.vpcf", context )
PrecacheResource( "particle", "particles/void_astral_slow.vpcf", context )
PrecacheResource( "particle", "particles/antimage/counter_lowhp.vpcf", context )
PrecacheResource( "particle", "particles/enigma/summon_perma.vpcf", context )
PrecacheResource( "particle", "particles/bane/brain_shield.vpcf", context )

end

function antimage_counterspell_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_e1 = 0,
    e1_damage = 0,
    e1_damage_health = 0,
    e1_radius = caster:GetTalentValue("modifier_antimage_counter_1", "radius", true),
    e1_interval = caster:GetTalentValue("modifier_antimage_counter_1", "interval", true),
    e1_damage_type = caster:GetTalentValue("modifier_antimage_counter_1", "damage_type", true),
    
    has_e2 = 0,
    e2_health = 0,
    e2_mana = 0,
    e2_radius = caster:GetTalentValue("modifier_antimage_counter_2", "radius", true),
    
    has_e3 = 0,
    e3_heal = 0,
    e3_base = 0,
    e3_radius = caster:GetTalentValue("modifier_antimage_counter_3", "radius", true),
    e3_damage_type = caster:GetTalentValue("modifier_antimage_counter_3", "damage_type", true),
    e3_shield = caster:GetTalentValue("modifier_antimage_counter_3", "shield", true),
    
    has_e4 = 0,
    e4_status = caster:GetTalentValue("modifier_antimage_counter_4", "status", true),
    e4_duration = caster:GetTalentValue("modifier_antimage_counter_4", "duration", true),
    e4_range = caster:GetTalentValue("modifier_antimage_counter_4", "range", true),
    
    has_e7 = 0,
    e7_stun = caster:GetTalentValue("modifier_antimage_counter_7", "stun", true),
    e7_magic = caster:GetTalentValue("modifier_antimage_counter_7", "magic", true),
    e7_duration = caster:GetTalentValue("modifier_antimage_counter_7", "duration", true),
    e7_radius = caster:GetTalentValue("modifier_antimage_counter_7", "radius", true),
    e7_shield = caster:GetTalentValue("modifier_antimage_counter_7", "shield", true)/100,

    has_r3 = 0,
  }
end

if caster:HasTalent("modifier_antimage_counter_1") then
  self.talents.has_e1 = 1
  self.talents.e1_damage = caster:GetTalentValue("modifier_antimage_counter_1", "damage")
  self.talents.e1_damage_health = caster:GetTalentValue("modifier_antimage_counter_1", "damage_health")/100
end

if caster:HasTalent("modifier_antimage_counter_2") then
  self.talents.has_e2 = 1
  self.talents.e2_health = caster:GetTalentValue("modifier_antimage_counter_2", "health")
  self.talents.e2_mana = caster:GetTalentValue("modifier_antimage_counter_2", "mana")/100
  if IsServer() then
    caster:CalculateStatBonus(true)
  end
end

if caster:HasTalent("modifier_antimage_counter_3") then
  self.talents.has_e3 = 1
  self.talents.e3_heal = caster:GetTalentValue("modifier_antimage_counter_3", "heal")/100
  self.talents.e3_base = caster:GetTalentValue("modifier_antimage_counter_3", "base")
end

if caster:HasTalent("modifier_antimage_counter_4") then
  self.talents.has_e4 = 1
end

if caster:HasTalent("modifier_antimage_counter_7") then
  self.talents.has_e7 = 1
end

if caster:HasTalent("modifier_antimage_void_3") then
  self.talents.has_r3 = 1
end

end

function antimage_counterspell_custom:Init()
self.caster = self:GetCaster()
end

function antimage_counterspell_custom:GetIntrinsicModifierName()
return "modifier_antimage_counterspell_custom"
end

function antimage_counterspell_custom:GetBehavior()
local bonus = self.talents.has_e4 == 1 and DOTA_ABILITY_BEHAVIOR_AUTOCAST or 0
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL + bonus
end

function antimage_counterspell_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel)
end

function antimage_counterspell_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self,level)
end

function antimage_counterspell_custom:ShardMana(mana)
if not IsServer() then return end
if not self:IsTrained() then return end
if not self.caster:HasShard() then return end

if self.caster.owner and self.caster.owner:HasAbility(self:GetName()) then
    self.caster.owner:FindAbilityByName(self:GetName()):ShardMana(mana)
    return
end

local shard_mana = mana*self.shard_mana
local over_mana = shard_mana - math.min(shard_mana, self.caster:GetMaxMana() - self.caster:GetMana())

self.caster:GiveMana(shard_mana)

if over_mana <= 0 then return end
self.caster:AddNewModifier(self.caster, self, "modifier_antimage_counterspell_custom_shard_shield", {shield = over_mana, duration = self.shard_duration})
end


function antimage_counterspell_custom:OnSpellStart()
local duration = self.duration

if test then
end

if test and false then
    local heroes = 
    {
        "npc_dota_hero_zuus",
        "npc_dota_hero_axe",
        "npc_dota_hero_alchemist",
        "npc_dota_hero_bane",
        "npc_dota_hero_bloodseeker",
        "npc_dota_hero_morphling",
        "npc_dota_hero_centaur",
        "npc_dota_hero_life_stealer",
        "npc_dota_hero_witch_doctor",   
        "npc_dota_hero_arc_warden",
        "npc_dota_hero_bristleback"
    }


    local teams = 
    {
        [1] = 1,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0,
    }

    local count = 1

    for _,hero in pairs(heroes) do
        local data = {}
        data.value = hero

        if teams[count] >= 2 then
            count = count + 1
        end
        data.spawn_for_team = count

        teams[count] = teams[count] + 1
        data.PlayerID = caster:GetId()

        DeepPrintTable(data)
        test_mode:AddHero(data, true)

    end
end

if self.caster.antimage_illusions then
    for illusion,_ in pairs(self.caster.antimage_illusions) do
        illusion:EmitSound("Hero_Antimage.Counterspell.Cast")
        illusion:AddNewModifier(self.caster, self, "modifier_antimage_counterspell_custom_active", {duration = duration})
    end
end

self.caster:EmitSound("Hero_Antimage.Counterspell.Cast")
self.caster:AddNewModifier(self.caster, self, "modifier_antimage_counterspell_custom_active", {duration = duration})

if self.talents.has_e3 == 1 or self.talents.has_e7 == 1 then
    self.caster:AddNewModifier(self.caster, self, "modifier_antimage_counterspell_custom_shield", {duration = duration})
end

end



modifier_antimage_counterspell_custom_active = class(mod_visible)
function modifier_antimage_counterspell_custom_active:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.damage_reduce = 0
if self.parent:IsIllusion() and self.caster.manavoid_ability_legendary then
    self.damage_reduce = self.caster.manavoid_ability_legendary.damage_reduce
end

if not IsServer() then return end

self.ignore_spells = 
{
    ["custom_pudge_dismember"] = true,
    ["morphling_replicate_custom"] = true,
}

local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_counter.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:SetParticleControl(particle, 1, Vector(100,0,0))
self:AddParticle(particle, false, false, -1, false, false)

if self.caster ~= self.parent then return end
self.ability:EndCd()
end


function modifier_antimage_counterspell_custom_active:OnDestroy()
if not IsServer() then return end

if self.caster == self.parent then
    self.ability:StartCd()
end

self:ProcBlink()
end

function modifier_antimage_counterspell_custom_active:ProcBlink()
if not IsServer() then return end
if self.ability.talents.has_e4 == 0 then return end
if self.blink_proced then return end

self.blink_proced = true

self.parent:Purge(false, true, false, true, true)

if self.caster == self.parent and self.ability:GetAutoCastState() then
    local point = self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*self.ability.talents.e4_range
    local direction = self.parent:GetForwardVector()

    local particle_start = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_blink_start.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( particle_start, 0, self.parent:GetAbsOrigin() )
    ParticleManager:SetParticleControlForward( particle_start, 0, direction )
    ParticleManager:ReleaseParticleIndex( particle_start )

    FindClearSpaceForUnit( self.parent, point, true )
    EmitSoundOnLocationWithCaster( self.parent:GetAbsOrigin(), "Hero_Antimage.Blink_out", self.parent )
    self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.5)

    local particle_end = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_blink_end.vpcf", PATTACH_ABSORIGIN, self.parent )
    ParticleManager:SetParticleControl( particle_end, 0, self.parent:GetAbsOrigin() )
    ParticleManager:SetParticleControlForward( particle_end, 0, direction )
    ParticleManager:ReleaseParticleIndex( particle_end )
else
    self.parent:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")
end

end


function modifier_antimage_counterspell_custom_active:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_REFLECT_SPELL,
    MODIFIER_PROPERTY_ABSORB_SPELL,
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_antimage_counterspell_custom_active:GetModifierIncomingDamage_Percentage()
if not self.parent:IsIllusion() then return end
return self.damage_reduce
end

function modifier_antimage_counterspell_custom_active:GetAbsorbSpell( params )
if not IsServer() then return end
if not params.ability:GetCaster() then return end 
if params.ability:GetCaster():GetTeamNumber() == self.parent:GetTeamNumber() then return end 

local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_spellshield_reflect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex( particle )
self.parent:EmitSound("Hero_Antimage.SpellShield.Reflect")

return 1
end


function modifier_antimage_counterspell_custom_active:GetReflectSpell( params )
if not IsServer() then return end
if not params.ability:GetCaster() then return end 

local target = params.ability:GetCaster()
local reflected_spell_name = params.ability:GetAbilityName()

if target:GetTeamNumber() == self.parent:GetTeamNumber() then return end 

if target:IsCreep() or self.ability:IsStolen() or self.parent:IsIllusion() then 
    self.parent:EmitSound("Hero_Antimage.Counterspell.Target")
    return 
end

target:EmitSound("Hero_Antimage.Counterspell.Target")

if target:IsRealHero() then
    if self.parent:GetQuest() == "Anti.Quest_7" and not self.parent:QuestCompleted() then
        self.parent:UpdateQuest(1)
    end
end

if target:HasModifier("modifier_item_lotus_orb_active") or target:HasModifier("modifier_item_mirror_shield") or params.ability.spell_shield_reflect then return end
if self.ignore_spells[reflected_spell_name] then return end

local old_spell = false
for hSpell,name in pairs(self.parent.counterspell_history) do
    if hSpell ~= nil and name == reflected_spell_name then
        old_spell = true
        break
    end
end

if old_spell then
    ability = self.parent:FindAbilityByName(reflected_spell_name)
else
    ability = self.parent:AddAbility(reflected_spell_name)
    ability:SetStolen(true)
    ability:SetHidden(true)
    ability.spell_shield_reflect = true
    ability:SetRefCountsModifiers(true)
    self.parent.counterspell_history[ability] = ability:GetName()
end

ability:SetLevel(params.ability:GetLevel())

self.parent:SetCursorCastTarget(target)
ability:OnSpellStart()

if ability.OnChannelFinish then
    ability:OnChannelFinish(false)
end

local mod = self.parent:FindModifierByName("modifier_antimage_counterspell_custom")
if mod then
    mod:OnIntervalThink()
end

return false
end



modifier_antimage_counterspell_custom = class(mod_hidden)
function modifier_antimage_counterspell_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()
self.parent.counterspell_history = {}

self.parent.counterspell_ability = self.ability

self.ability.magic_resistance = self.ability:GetSpecialValueFor("magic_resistance")  
self.ability.duration = self.ability:GetSpecialValueFor("duration")  
self.ability.shard_mana = self.ability:GetSpecialValueFor("shard_mana")/100  
self.ability.shard_shield = self.ability:GetSpecialValueFor("shard_shield")/100
self.ability.shard_duration = self.ability:GetSpecialValueFor("shard_duration")  

if self.parent:IsRealHero() then 
    self.interval = 0.5
    self:StartIntervalThink(self.interval)
end

end

function modifier_antimage_counterspell_custom:OnRefresh(table)
self.ability.magic_resistance = self.ability:GetSpecialValueFor("magic_resistance")  
end

function modifier_antimage_counterspell_custom:GetModifierStatusResistanceStacking()
if self.ability.talents.has_e4 == 0 then return end
return self.ability.talents.e4_status
end

function modifier_antimage_counterspell_custom:GetModifierMagicalResistanceBonus( params )
if self.parent:PassivesDisabled() then return end
return self.ability.magic_resistance
end

function modifier_antimage_counterspell_custom:GetModifierExtraHealthPercentage()
return self.ability.talents.e2_health
end

function modifier_antimage_counterspell_custom:OnIntervalThink()
if not IsServer() then return end

for hSpell,name in pairs(self.parent.counterspell_history) do

    if hSpell and not hSpell:IsNull() then
        if hSpell:GetToggleState() then
            hSpell:ToggleAbility()
        end
        local intrinsic_mod = hSpell:GetIntrinsicModifierName()
        if intrinsic_mod then
            self.parent:RemoveModifierByName(intrinsic_mod)
        end

        if hSpell:NumModifiersUsingAbility() <= 0 and not hSpell:IsChanneling() then

            self.parent.counterspell_history[hSpell] = nil

            self.parent:RemoveAbilityByHandle(hSpell)
            UTIL_Remove(hSpell)
            hSpell = nil
        end
    else
        self.parent.counterspell_history[hSpell] = nil
    end
end
self:StartIntervalThink(self.interval)
end

function modifier_antimage_counterspell_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
    MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_antimage_counterspell_custom:IsAura() return self.ability.talents.has_e1 == 1 or self.ability.talents.has_e2 == 1 or self.ability.talents.has_r3 == 1 end
function modifier_antimage_counterspell_custom:GetAuraDuration() return 0.1 end
function modifier_antimage_counterspell_custom:GetAuraRadius() return self.ability.talents.e1_radius end
function modifier_antimage_counterspell_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_antimage_counterspell_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_antimage_counterspell_custom:GetModifierAura() return "modifier_antimage_counterspell_custom_burn_damage" end


modifier_antimage_counterspell_custom_burn_damage = class(mod_hidden)
function modifier_antimage_counterspell_custom_burn_damage:GetTexture() return "buffs/antimage/counterspell_1" end
function modifier_antimage_counterspell_custom_burn_damage:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if self.caster.owner then
    self.caster = self.caster.owner
    self.ability = self.caster.counterspell_ability
end

self.damage = self.ability.talents.e1_damage
self.burn_damage_health = self.ability.talents.e1_damage_health
self.interval = self.ability.talents.e1_interval

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = self.ability.talents.e1_damage_type}

if self.ability.talents.has_e1 == 1 or self.ability.talents.has_e2 == 1 then
    self.parent:GenericParticle("particles/units/heroes/hero_faceless_void/faceless_void_dialatedebuf_2.vpcf", self)
end

self:StartIntervalThink(self.interval )
end

function modifier_antimage_counterspell_custom_burn_damage:OnIntervalThink()
if not IsServer() then return end

if self.caster.manavoid_ability and self.caster.manavoid_ability.talents.has_r3 == 1 then
    self.parent:AddNewModifier(self.caster, self.caster.manavoid_ability, "modifier_antimage_mana_void_custom_int", {duration = self.caster.manavoid_ability.talents.r3_duration})
end

if self.ability.talents.has_e2 == 1 then
    local real_mana = self.parent:Script_ReduceMana(self.ability.talents.e2_mana*self.parent:GetMaxMana(), self.ability) 
    if self.caster:HasShard() then
        self.ability:ShardMana(real_mana)
    end 
end

if self.ability.talents.has_e1 == 0 then return end
self.damageTable.damage = self.interval*(self.damage + self.burn_damage_health*self.caster:GetMaxHealth())
DoDamage(self.damageTable, "modifier_antimage_counter_1")
end



modifier_antimage_counterspell_custom_legendary_damage = class(mod_visible)
function modifier_antimage_counterspell_custom_legendary_damage:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_antimage_counterspell_custom_legendary_damage:GetModifierMagicalResistanceBonus(params)
if IsServer() and (not params.attacker or params.attacker:FindOwner() ~= self.caster) then return end
return self.ability.talents.e7_magic
end

function modifier_antimage_counterspell_custom_legendary_damage:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self.caster.counterspell_ability

if not IsServer() then return end
if self.parent:IsRealHero() and not IsValid(self.ability.legendary_mod) then
    self.ability.legendary_mod = self
    self:OnIntervalThink()
    self:StartIntervalThink(0.1)
end

self.parent:GenericParticle("particles/general/generic_magic_reduction.vpcf", self, true)
end

function modifier_antimage_counterspell_custom_legendary_damage:OnIntervalThink()
if not IsServer() then return end
self.caster:UpdateUIshort({max_time = self.ability.talents.e7_duration, time = self:GetRemainingTime(), stack = "+"..math.abs(self.ability.talents.e7_magic).."%", style = "AntimageCounter"})
end

function modifier_antimage_counterspell_custom_legendary_damage:OnDestroy()
if not IsServer() then return end
if not self.ability.legendary_mod or self.ability.legendary_mod ~= self then return end
self.ability.legendary_mod = nil

self.caster:UpdateUIshort({hide = 1, hide_full = 1, style = "AntimageCounter"})
end


modifier_antimage_counterspell_custom_shield = class(mod_hidden)
function modifier_antimage_counterspell_custom_shield:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.attacker = nil

self.heal = self.parent:GetMaxHealth()*self.ability.talents.e3_heal + self.ability.talents.e3_base
self.max_shield = self.ability.talents.e7_shield*self.parent:GetMaxHealth()
self.shield = self.max_shield

self.end_anim = ACT_DOTA_CAST_ABILITY_2

if not IsServer() then return end
self:SetHasCustomTransmitterData(true)

if self.ability.talents.has_e7 == 0 then return end

if self.parent.current_model == "models/heroes/antimage_female/antimage_female.vmdl" or self.parent.current_model == "models/items/antimage_female/mh_antimage_kirin/antimage_female_kirin.vmdl" or self.parent.current_model == "models/items/antimage_female/mh_antimage_kirin/antimage_female_kirin_rainbow.vmdl" then
    self.start_anim = ACT_DOTA_TELEPORT
else
    self.parent:AddActivityModifier("slasher_weapon")
    self.parent:AddActivityModifier("slasher_offhand")
    self.parent:AddActivityModifier("slasher_mask")
    self.parent:AddActivityModifier("slasher_chest")
    self.parent:AddActivityModifier("slasher_belt")
    self.parent:AddActivityModifier("slasher_arms")
    self.parent:AddActivityModifier("slasher_shoulder")

    self.start_anim = ACT_DOTA_LOADOUT
end

self.parent:StartGesture(self.start_anim)
end

function modifier_antimage_counterspell_custom_shield:AddCustomTransmitterData() 
return {shield = self.shield}
end

function modifier_antimage_counterspell_custom_shield:HandleCustomTransmitterData(data)
self.shield = data.shield
end

function modifier_antimage_counterspell_custom_shield:OnDestroy()
if not IsServer() then return end

if self.ability.talents.has_e7 == 1 then
    self.parent:ClearActivityModifiers()
    self.parent:FadeGesture(self.start_anim)
end

if self.shield > 0 then return end

local mod = self.parent:FindModifierByName("modifier_antimage_counterspell_custom_active")
if mod then
    mod:ProcBlink()
end

self.parent:StartGestureWithPlaybackRate(self.end_anim, 1.3)

local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_spellshield_reflect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex( particle )
 
if self.ability.talents.has_e3 == 1 then
    self.parent:GenericHeal(self.heal, self.ability, nil, nil, "modifier_antimage_counter_3")

    self.parent:EmitSound("Antimage.Counterspell_damage")

    local effect_cast = ParticleManager:CreateParticle( "particles/am_spell_damage.vpcf", PATTACH_WORLDORIGIN,  nil)
    ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector(self.ability.talents.e7_radius , 0, 0 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

self.parent:EmitSound("Hero_Antimage.Counterspell.Target")

local attack_hit = false
for _,target in pairs(self.parent:FindTargets(self.ability.talents.e7_radius)) do

    if self.attacker and target == self.attacker then
        attack_hit = true
    end
    self:LegendaryHit(target)
end 

if not attack_hit and self.attacker and not self.attacker:IsNull() and self.attacker:IsAlive() then
    self:LegendaryHit(self.attacker, true)
end

end

function modifier_antimage_counterspell_custom_shield:LegendaryHit(target, range_hit)
if not IsServer() then return end
if not target:IsUnit() then return end

target:EmitSound("Antimage.Counterspell_damage_target")

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_antimage/antimage_manabreak_slow.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex(particle)

if self.ability.talents.has_e7 == 1 then
    target:EmitSound("Antimage.Break_stun")
    local immortal_particle = ParticleManager:CreateParticle("particles/am_no_mana.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
    ParticleManager:SetParticleControl(immortal_particle, 0, target:GetAbsOrigin())
    ParticleManager:SetParticleControl(immortal_particle, 1, target:GetAbsOrigin() )
    ParticleManager:Delete(immortal_particle, 1)

    local particle = ParticleManager:CreateParticle( "particles/am_lightning.vpcf", PATTACH_POINT_FOLLOW, target )
    ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
    ParticleManager:SetParticleControlEnt( particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
    ParticleManager:ReleaseParticleIndex( particle )

    target:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, true), "modifier_antimage_counterspell_custom_legendary_damage", {duration = self.ability.talents.e7_duration})
    target:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, true), "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.ability.talents.e7_stun})
end

if not range_hit and self.ability.talents.has_e3 == 1 then
    DoDamage({attacker = self.parent, damage = self.heal, damage_type = self.ability.talents.e3_damage_type, ability = self.ability, victim = target}, "modifier_antimage_counter_3")
end

end


function modifier_antimage_counterspell_custom_shield:CheckState()
if self.ability.talents.has_e7 == 0 then return end
return
{
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true
}
end

function modifier_antimage_counterspell_custom_shield:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_antimage_counterspell_custom_shield:GetModifierIncomingDamageConstant( params )

if IsClient() then 
    if params.report_max then 
        return self.max_shield
    else  
        return self.shield
    end 
end

if not IsServer() then return end
if params.attacker:GetTeamNumber() == self.parent:GetTeamNumber() then return end

local damage = math.min(params.damage, self.shield)
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self.parent:EmitSound("Antimage.Block_1")

local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_spellshield_reflect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex( particle )

self.shield = self.shield - damage
self:SendBuffRefreshToClients()
if self.shield <= 0 then
  self.attacker = params.attacker
  self:Destroy()
end

return -damage
end





modifier_antimage_counterspell_custom_shard_shield = class(mod_visible)
function modifier_antimage_counterspell_custom_shard_shield:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.shield_talent = "Shard"
self.shard_shield = self.ability.shard_shield
self.max_shield = self.shard_shield*self.parent:GetMaxHealth()

if not IsServer() then return end
self:SetHasCustomTransmitterData(true)
self.RemoveForDuel = true
self:AddShield(table.shield)
end

function modifier_antimage_counterspell_custom_shard_shield:OnRefresh(table)
self.max_shield = self.shard_shield*self.parent:GetMaxHealth()

if not IsServer() then return end
self:AddShield(table.shield)
end

function modifier_antimage_counterspell_custom_shard_shield:AddShield(shield)
if not IsServer() then return end
if not self.shield then
    self.shield = 0
end

self.shield = math.min(self.max_shield, self.shield + shield)
self:SendBuffRefreshToClients()
end

function modifier_antimage_counterspell_custom_shard_shield:AddCustomTransmitterData() 
return {shield = self.shield}
end

function modifier_antimage_counterspell_custom_shard_shield:HandleCustomTransmitterData(data)
self.shield = data.shield
end

function modifier_antimage_counterspell_custom_shard_shield:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
}
end

function modifier_antimage_counterspell_custom_shard_shield:GetModifierIncomingPhysicalDamageConstant( params )
if self.parent:HasModifier("modifier_antimage_counterspell_custom_shield") then return end

if IsClient() then 
    if params.report_max then 
        return self.max_shield
    else  
        return self.shield
    end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self.shield)
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self.shield = self.shield - damage
self:SendBuffRefreshToClients()
if self.shield <= 0 then
  self:Destroy()
end

return -damage
end

