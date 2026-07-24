--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_up_venom_stack", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_bigdamage_heal", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_bigdamage_heal_cd", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_damagestack_stack", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_ignore_armor_stack", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_root_debuff", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_root_cd", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_res_cd", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_res_nodmg", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_res_ready", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_slow_debuff", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_up_teamfight_buff", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_shield_cd", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_attack_shield", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_magic_shield", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_general_stats_illusion", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_general_javelin_proc", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_general_stats", "abilities/general_talents/custom_general_talents", LUA_MODIFIER_MOTION_NONE)

custom_general_talents = class({})
custom_general_talents.talents = {}

custom_general_talents.damage_out_mods = 
{
  "modifier_up_lifesteal",
  "modifier_up_spellsteal",
  "modifier_up_venom",
  "modifier_up_ignore_armor"
}

custom_general_talents.damage_inc_mods = 
{
  "modifier_up_attackblock",
  "modifier_up_bigdamage",
  "modifier_up_magicblock",
  "modifier_up_res"
}

custom_general_talents.attack_out_mods = 
{
  "modifier_up_cleave",
  "modifier_up_root",
  "modifier_up_slow"
}

function custom_general_talents:UpdateTalents()
local caster = self:GetCaster()

if not self.init then
  self.init = true
  self.talents =
  {
    stats_bonus_int = caster:GetTalentValue("modifier_up_primaryupgrade", "int", true),
    stats_bonus_agi = caster:GetTalentValue("modifier_up_primaryupgrade", "agi", true),
    stats_bonus_str = caster:GetTalentValue("modifier_up_primaryupgrade", "str", true),
    stats_bonus_all = caster:GetTalentValue("modifier_up_allupgrade", "all", true)/100,

    javelin_damage = caster:GetTalentValue("modifier_up_javelin", "damage", true),
    gray_bonus = caster:GetTalentValue("modifier_up_graypoints", "bonus", true)/100,

    alchemist_bonus = caster:GetTalentValue("modifier_alchemist_rage_legendary", "bonus", true)/100,

    burn_radius = caster:GetTalentValue("modifier_up_aoe_damage", "radius", true),
    armor_duration = caster:GetTalentValue("modifier_up_ignore_armor", "duration", true),

    slow_chance = caster:GetTalentValue("modifier_up_slow", "chance", true),
    slow_duration = caster:GetTalentValue("modifier_up_slow", "duration", true),

    block_cd = caster:GetTalentValue("modifier_up_magicblock", "cd", true),

    root_cd = caster:GetTalentValue("modifier_up_root", "cd", true),

    bigdamage_duration = caster:GetTalentValue("modifier_up_bigdamage", "duration", true),
    bigdamage_cd = caster:GetTalentValue("modifier_up_bigdamage", "cd", true),
    bigdamage_health = caster:GetTalentValue("modifier_up_bigdamage", "health", true),

    venom_health = caster:GetTalentValue("modifier_up_venom", "health", true),
    venom_duration = caster:GetTalentValue("modifier_up_venom", "duration", true),

    teamfight_radius = caster:GetTalentValue("modifier_up_teamfight", "radius", true),

    res_radius = caster:GetTalentValue("modifier_up_res", "radius", true),
    res_heal = caster:GetTalentValue("modifier_up_res", "heal", true)/100,
    res_cd = caster:GetTalentValue("modifier_up_res", "cd", true)*60,
    res_stun = caster:GetTalentValue("modifier_up_res", "stun", true),
    res_invun = caster:GetTalentValue("modifier_up_res", "invun", true),

    damagestack_duration = caster:GetTalentValue("modifier_up_damagestack", "duration", true),
  }
end

self.talents.attack_speed_bonus = caster:GetTalentValue("modifier_up_speed", "general_bonus")
self.talents.armor_bonus = caster:GetTalentValue("modifier_up_armor", "general_bonus")
self.talents.damage_bonus = caster:GetTalentValue("modifier_up_damage", "general_bonus")
self.talents.health_bonus = caster:GetTalentValue("modifier_up_health", "general_bonus")
self.talents.magic_bonus = caster:GetTalentValue("modifier_up_magicresist", "general_bonus")
self.talents.mana_regen_bonus = caster:GetTalentValue("modifier_up_manaregen", "general_bonus")
self.talents.move_bonus = caster:GetTalentValue("modifier_up_movespeed", "general_bonus")
self.talents.primary_bonus = caster:GetTalentValue("modifier_up_primary", "general_bonus")
self.talents.secondary_bonus = caster:GetTalentValue("modifier_up_secondary", "general_bonus")
self.talents.all_bonus = caster:GetTalentValue("modifier_up_allstats", "general_bonus")
self.talents.spell_bonus = caster:GetTalentValue("modifier_up_spelldamage", "general_bonus")
self.talents.evasion_bonus = caster:GetTalentValue("modifier_up_evasion", "general_bonus")
self.talents.status_bonus = caster:GetTalentValue("modifier_up_statusresist", "general_bonus")
self.talents.creeps_bonus = caster:GetTalentValue("modifier_up_creeps", "general_bonus")
self.talents.javelin_bonus = caster:GetTalentValue("modifier_up_javelin", "general_bonus")
self.talents.aoe_damage_bonus = caster:GetTalentValue("modifier_up_aoe_damage", "general_bonus")
self.talents.cleave_bonus = caster:GetTalentValue("modifier_up_cleave", "general_bonus")
self.talents.lifesteal_bonus = caster:GetTalentValue("modifier_up_lifesteal", "general_bonus")
self.talents.spellsteal_bonus = caster:GetTalentValue("modifier_up_spellsteal", "general_bonus")

self.talents.stun_reduce = caster:GetTalentValue("modifier_up_stun", "damage_reduce")
self.talents.primary_gain_bonus = caster:GetTalentValue("modifier_up_gainprimary", "stats")
self.talents.all_gain_bonus = caster:GetTalentValue("modifier_up_gainall", "stats")
self.talents.secondary_gain_bonus = caster:GetTalentValue("modifier_up_gainsecondary", "stats")
self.talents.root_duration = caster:GetTalentValue("modifier_up_root", "duration")
self.talents.cdr_bonus = caster:GetTalentValue("modifier_up_cooldown", "cdr")
self.talents.cast_range_bonus = caster:GetTalentValue("modifier_up_range", "cast_range")
self.talents.attack_range_bonus = caster:GetTalentValue("modifier_up_range", "attack_range")

if not IsServer() then return end
if not caster:IsRealHero() or caster:IsTempestDouble() then return end

for _,check_name in pairs(self.damage_out_mods) do
  if caster:HasTalent(check_name) then
    caster:AddDamageEvent_out(self.tracker, true)
  end
end

for _,check_name in pairs(self.damage_inc_mods) do
  if caster:HasTalent(check_name) then
    caster:AddDamageEvent_inc(self.tracker, true)
  end
end

for _,check_name in pairs(self.attack_out_mods) do
  if caster:HasTalent(check_name) then
    caster:AddAttackEvent_out(self.tracker, true)
  end
end

if caster:HasTalent("modifier_up_javelin") then
  caster:AddRecordDestroyEvent(self.tracker, true)
  caster:AddAttackStartEvent_out(self.tracker)
end

end

modifier_general_stats = class(mod_hidden)
function modifier_general_stats:RemoveOnDeath() return false end
function modifier_general_stats:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.pirat_bonus = 0.2

self.duo_status = 0
self.duo_health = 0
if not IsSoloMode() then
  self.duo_status = 10
  self.duo_health = 10
end

self.stack = self:UpdateStack()

if not IsServer() then return end

self.player_id = tostring(PlayerResource:GetSteamAccountID(self.parent:GetPlayerOwnerID()))
self.main_stat = self.parent:GetPrimaryAttribute()

self:SetHasCustomTransmitterData(true)
self:SendBuffRefreshToClients()

self.records = {}

self.interval = 1

self.gain_all = 0
self.gain_primary = 0
self.gain_secondary = 0

self:StartIntervalThink(self.interval)
end


function modifier_general_stats:UpdateStack()
local stack = 1
if self.parent:HasModifier("modifier_alchemist_chemical_rage_custom_legendary") and self.parent:HasTalent("modifier_alchemist_rage_legendary") then 
  stack = stack + self.ability.talents.alchemist_bonus
end
if self.parent:HasTalent("modifier_up_graypoints") then
  stack = stack + self.ability.talents.gray_bonus
end
if self.parent:HasModifier("modifier_item_pirate_hat_custom") then
  stack = stack + self.pirat_bonus
end
return stack
end

function modifier_general_stats:OnIntervalThink()
if not IsServer() then return end 

local need_refresh = false

local stack = self:UpdateStack()
if self.stack ~= stack then
  self.stack = stack
  need_refresh = true
end

if self.parent:GetPrimaryAttribute() ~= self.main_stat then 
  self.main_stat = self.parent:GetPrimaryAttribute()
  need_refresh = true
end 

if need_refresh then
  self:SendBuffRefreshToClients()
end

if self.gain_all ~= self.parent:TalentLevel("modifier_up_gainall") or self.gain_primary ~= self.parent:TalentLevel("modifier_up_gainprimary")
  or self.gain_secondary ~= self.parent:TalentLevel("modifier_up_gainsecondary") then 
  self:NewStats()
end 

if self.parent:HasTalent("modifier_up_res") and not self.parent:HasModifier("modifier_up_res_ready") then 
  self.parent:AddNewModifier(self.parent, nil, "modifier_up_res_ready", {})
end   

if not self.parent:HasModifier("modifier_shield_cd") then 
  if self.parent:HasTalent("modifier_up_attackblock") then 

    local mod = self.parent:FindModifierByName("modifier_attack_shield")
    if not mod or mod:GetStackCount() < mod.max_shield then 
      self.parent:AddNewModifier(self.parent, nil, "modifier_attack_shield", {})
    end
  end
  
  if self.parent:HasTalent("modifier_up_magicblock") then 
    local mod = self.parent:FindModifierByName("modifier_magic_shield")
    if not mod or mod:GetStackCount() < mod.max_shield then 
      self.parent:AddNewModifier(self.parent, nil, "modifier_magic_shield", {})
    end
  end
end 

if not self.parent:IsAlive() then return end

if self.parent:HasTalent("modifier_up_aoe_damage") then  

  if not self.damage_ability then 
    self.damage_ability = self.parent:AddAbility("generic_aoe_damage")
  end 

  local damage = self.ability.talents.aoe_damage_bonus*self.stack*self.interval
  for _,unit in pairs(self.parent:FindTargets(self.ability.talents.burn_radius)) do 
    DoDamage({victim = unit, damage = damage, attacker = self.parent, ability = self.damage_ability, damage_type = DAMAGE_TYPE_MAGICAL}, "modifier_up_aoe_damage")
  end 
end 

if not self.parent:HasTalent("modifier_up_teamfight") and not self.parent:HasTalent("modifier_up_damagestack") then return end

local units = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.ability.talents.teamfight_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS  + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES  + DOTA_UNIT_TARGET_FLAG_INVULNERABLE  + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD , FIND_CLOSEST, false)
 
local count = 0

for _,unit in pairs(units) do 
  if not unit:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") and not unit:IsTempestDouble() then 
    count = count  + 1
  end
end

if self.parent:HasTalent("modifier_up_damagestack") and count > 0 then
  self.parent:AddNewModifier(self.parent, nil, "modifier_up_damagestack_stack", {duration = self.ability.talents.damagestack_duration})
end


if not self.parent:HasTalent("modifier_up_teamfight") then return end

if count < 2 and self.parent:HasModifier("modifier_up_teamfight_buff") then 
  self.parent:RemoveModifierByName("modifier_up_teamfight_buff")
end

if count >= 2 and not self.parent:HasModifier("modifier_up_teamfight_buff") then 
  self.parent:AddNewModifier(self.parent, nil, "modifier_up_teamfight_buff", {})
end

end 




function modifier_general_stats:DamageEvent_inc(params)
if not IsServer() then return end
local unit = params.unit
local attacker = params.attacker
local damage = params.damage

if self.parent ~= unit then return end

if self.parent:HasTalent("modifier_up_attackblock") or self.parent:HasTalent("modifier_up_magicblock") then 
  self.parent:AddNewModifier(self.parent, nil, "modifier_shield_cd", {duration = self.ability.talents.block_cd})
end 

if self.parent:HasTalent("modifier_up_bigdamage") and self.parent:GetHealthPercent() <= self.ability.talents.bigdamage_health and not self.parent:HasModifier("modifier_death")
  and not self.parent:HasModifier("modifier_up_bigdamage_heal_cd") then 

  self.parent:AddNewModifier(self.parent, nil, "modifier_up_bigdamage_heal", {duration = self.ability.talents.bigdamage_duration})
  self.parent:AddNewModifier(self.parent, nil, "modifier_up_bigdamage_heal_cd", {duration = self.ability.talents.bigdamage_cd})
end

if self.parent:HasTalent("modifier_up_res") and self.parent:GetHealth() <= 5 and self:CheckDeath() then 

  self.parent:GenericHeal(self.parent:GetMaxHealth()*self.ability.talents.res_heal, self.ability, nil, nil, "modifier_up_res")
  self.parent:Purge(false, true, false, true, true)

  self.parent:AddNewModifier(self.parent, nil, "modifier_up_res_cd", {duration = self.ability.talents.res_cd})
  self.parent:AddNewModifier(self.parent, nil, "modifier_up_res_nodmg", {duration = self.ability.talents.res_invun})

  self.parent:EmitSound( "UI.Talent_phoenix")

  local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl( pfx, 0, self.parent:GetAbsOrigin() )
  ParticleManager:SetParticleControl( pfx, 1, Vector(1.5,1.5,1.5) )
  ParticleManager:SetParticleControl( pfx, 3, self.parent:GetAbsOrigin() )
  ParticleManager:ReleaseParticleIndex(pfx)

  for _,target in pairs(self.parent:FindTargets(self.ability.talents.res_radius)) do
    target:AddNewModifier(self.parent, nil, "modifier_stunned", {duration = self.ability.talents.res_stun*(1 - target:GetStatusResistance())})
  end 
end 


end



function modifier_general_stats:DamageEvent_out(params)
if not IsServer() then return end
local unit = params.unit
local attacker = params.attacker
local damage = params.damage

if self.parent ~= attacker or unit:GetTeamNumber() == attacker:GetTeamNumber() or not unit:IsUnit() then return end

if self.parent:HasTalent("modifier_up_lifesteal") and self.parent:CheckLifesteal(params, 2) then 
  local heal = self.ability.talents.lifesteal_bonus*self.stack
  self.parent:GenericHeal(heal*damage/100, self.ability, true, nil, "modifier_up_lifesteal")
end

if self.parent:HasTalent("modifier_up_spellsteal") then
  local result = self.parent:CheckLifesteal(params, 1)
  if result then
    local heal = self.ability.talents.spellsteal_bonus*self.stack*result
    self.parent:GenericHeal(heal*damage/100, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_up_spellsteal")
  end
end

if self.parent:HasTalent("modifier_up_venom") and unit:GetHealthPercent() <= self.ability.talents.venom_health then 
  unit:AddNewModifier(self.parent, nil, "modifier_up_venom_stack", {duration = self.ability.talents.venom_duration})
end

if self.parent:HasTalent("modifier_up_ignore_armor") then 
  unit:AddNewModifier(self.parent, nil, "modifier_up_ignore_armor_stack", {stack = self.stack*100, duration = self.ability.talents.armor_duration})
end

end




function modifier_general_stats:AttackEvent_out(params)
if not IsServer() then return end 
local target = params.target
local attacker = params.attacker
local attack_damage = params.damage

if attacker == self.parent and target:IsUnit() then 

  if attacker:HasTalent("modifier_up_cleave") and not self.parent:HasModifier("modifier_no_cleave") and not self.parent:HasModifier("modifier_tidehunter_anchor_smash_caster")
    and not self.parent:IsRangedAttacker() and not params.no_cleave_flag then

    local damage = self.ability.talents.cleave_bonus*self.stack
    DoCleaveAttack(self.parent, target, self.ability, attack_damage*damage/100, 150, 360, 650, "particles/units/heroes/hero_magnataur/magnataur_empower_cleave_effect.vpcf")
  end

  if attacker:HasTalent("modifier_up_root") and not self.parent:HasModifier("modifier_up_root_cd") and not target:IsDebuffImmune() then 

    target:AddNewModifier(self.parent, nil, "modifier_up_root_debuff", {duration = self.ability.talents.root_duration*(1 - target:GetStatusResistance())})
    self.parent:AddNewModifier(self.parent, nil, "modifier_up_root_cd", {duration = self.ability.talents.root_cd})
  end 

  if attacker:HasTalent("modifier_up_slow") then 
    if RollPseudoRandomPercentage(self.ability.talents.slow_chance, 1600, self.parent) then
      target:AddNewModifier(attacker, nil, "modifier_up_slow_debuff", { duration = self.ability.talents.slow_duration*(1 - target:GetStatusResistance())})
    end
  end 

end 

end



function modifier_general_stats:CheckDeath()
if not self.parent:IsAlive() then return end
if self.parent:HasModifier("modifier_up_res_cd") then return end
if self.parent:LethalDisabled() then return end
if self.parent:IsInvulnerable() then return end
if self.parent:HasModifier("modifier_troll_warlord_battle_trance_custom") then return end
if self.parent:HasModifier("modifier_custom_juggernaut_healing_ward_reduction_aura")  then return end
local ability = self.parent:FindAbilityByName("skeleton_king_reincarnation_custom")
if ability and ability:IsFullyCastable() then return end

return true
end



function modifier_general_stats:NewStats()
if not IsServer() then return end

local str = 0
local agi = 0
local int = 0

if self.parent:HasTalent("modifier_up_gainall") then 
  self.gain_all = self.parent:TalentLevel("modifier_up_gainall")
  local stats = self.ability.talents.all_gain_bonus/100

  str = str + stats
  agi = agi + stats
  int = int + stats
end 

if self.parent:HasTalent("modifier_up_gainprimary") then 
  self.gain_primary = self.parent:TalentLevel("modifier_up_gainprimary")
  local stats = self.ability.talents.primary_gain_bonus/100

  if self.main_stat == 0 then
    str = str + stats
  end 

  if self.main_stat == 1 then
    agi = agi + stats
  end 

  if self.main_stat == 2 then
    int = int + stats
  end 
end 

if self.parent:HasTalent("modifier_up_gainsecondary") then 
  self.gain_secondary = self.parent:TalentLevel("modifier_up_gainsecondary")
  local stats = self.ability.talents.secondary_gain_bonus/100

  if self.main_stat == 0 then
    int = int + stats
    agi = agi + stats
  end 

  if self.main_stat == 1 then
    int = int + stats
    str = str + stats
  end 

  if self.main_stat == 2 then
    agi = agi + stats
    str = str + stats
  end 
end 

self.parent:AddPercentStat({agi = agi, str = str, int = int}, self)
end



function modifier_general_stats:GiveItem(name)

local item = CreateItem(name, self.parent, self.parent)

if name == "item_patrol_necro" then
  self.parent:AddNewModifier(self.parent, nil, "modifier_item_patrol_necro_timer", {duration = self.parent:GetTalentValue("modifier_patrol_reward_necro", "timer")*60, item = item:entindex()})
end

if self.parent:GetNumItemsInInventory() < 10 then
  self.parent:AddItem(item)
else
  CreateItemOnPositionSync(GetGroundPosition(self.parent:GetAbsOrigin(), self.parent), item)
end

end

function modifier_general_stats:GeneralTrigger(name)
if not IsServer() then return end

if name == "modifier_up_random_gray" then 
  for i = 1,self.parent:GetTalentValue("modifier_up_random_gray", "count") do
    upgrade:init_upgrade(self.parent,1,nil,false,nil,true)
  end 
  return
end 

if name == "modifier_up_bluepoints" then 
  for i = 1,self.parent:GetTalentValue("modifier_up_bluepoints", "count") do
    upgrade:init_upgrade(self.parent,2,nil,false,nil,true)
  end 
  return
end 


if name == "modifier_patrol_reward_shield" then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_reward_1_shield", {duration = self.parent:GetTalentValue("modifier_patrol_reward_shield", "duration")})
  return
end

if name == "modifier_patrol_reward_ward" then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_reward_1_ward", {duration = self.parent:GetTalentValue("modifier_patrol_reward_ward", "duration")})
  return
end

if name == "modifier_patrol_reward_contract" then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_reward_1_vision", {duration = self.parent:GetTalentValue("modifier_patrol_reward_contract", "duration")})
  return
end

if name == "modifier_patrol_reward_gold" then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_reward_1_gold", {duration = self.parent:GetTalentValue("modifier_patrol_reward_gold", "duration")})
  return
end

if name == "modifier_patrol_reward_orb" then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_reward_1_orb", {})
  return
end



if name == "modifier_patrol_reward_gem" then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_reward_2_gem", {duration = self.parent:GetTalentValue("modifier_patrol_reward_gem", "duration")})
  return
end

if name == "modifier_patrol_reward_buff" then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_reward_2_buff", {duration = self.parent:GetTalentValue("modifier_patrol_reward_buff", "duration")})
  return
end

if name == "modifier_patrol_reward_fortifier" then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_reward_2_fortifier", {})
  return
end

if name == "modifier_patrol_reward_necro" then 
  self:GiveItem("item_patrol_necro")
  return
end

if name == "modifier_patrol_reward_portal" then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_reward_2_portal", {duration = self.parent:GetTalentValue("modifier_patrol_reward_portal", "duration")})
  return
end


if name == "modifier_recipe_gold_satanic" then 
  self:GiveItem("item_recipe_alchemist_gold_satanic")
  return
end

if name == "modifier_recipe_gold_assault" then 
  self:GiveItem("item_recipe_alchemist_gold_cuirass")
  return
end

if name == "modifier_recipe_gold_khanda" then 
  self:GiveItem("item_recipe_alchemist_gold_khanda")
  return
end

if name == "modifier_recipe_gold_daedalus" then 
  self:GiveItem("item_recipe_alchemist_gold_daedalus")
  return
end

if name == "modifier_recipe_gold_heart" then 
  self:GiveItem("item_recipe_alchemist_gold_heart")
  return
end

if name == "modifier_recipe_gold_octarine" then 
  self:GiveItem("item_recipe_alchemist_gold_octarine")
  return
end

if name == "modifier_recipe_gold_shiva" then 
  self:GiveItem("item_recipe_alchemist_gold_shiva")
  return
end

if name == "modifier_recipe_gold_skadi" then 
  self:GiveItem("item_recipe_alchemist_gold_skadi")
  return
end


end



function modifier_general_stats:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
  MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
  MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_EVASION_CONSTANT,
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
  MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
  MODIFIER_PROPERTY_HEALTH_BONUS,
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
  MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,    
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  MODIFIER_PROPERTY_MIN_HEALTH,
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
  MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
}
end

function modifier_general_stats:CheckState()
if not IsValid(self.parent) then return end
if not self.parent:HasModifier("modifier_general_javelin_proc") then return end
return 
{
  [MODIFIER_STATE_CANNOT_MISS] = true
}
end


function modifier_general_stats:AttackStartEvent_out(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_up_javelin") then return end
if self.parent ~= params.attacker then return end 
if not params.target:IsUnit() then return end 

if self.parent:HasModifier("modifier_general_javelin_proc") then 
  self.records[params.record] = true
end

self.parent:RemoveModifierByName("modifier_general_javelin_proc")

self:RandomProcDamage()
end


function modifier_general_stats:GetModifierProcAttack_BonusDamage_Magical(params)
if not self.parent:HasTalent("modifier_up_javelin") then return end
if not params.target:IsUnit() then return end 
if self.parent ~= params.attacker then return end 
if not self.records[params.record] then return end

local damage = 0
if not self.parent:IsIllusion() then 
  damage = self.ability.talents.javelin_damage
  SendOverheadEventMessage(params.target, 4, params.target, damage, nil) 
end  
return damage
end


function modifier_general_stats:RecordDestroyEvent(params)
if not self.parent:HasTalent("modifier_up_javelin") then return end
if not self.records[params.record] then return end
self.records[params.record] = nil
end


function modifier_general_stats:RandomProcDamage()
if not self.parent:HasTalent("modifier_up_javelin") then return end

local chance = self.ability.talents.javelin_bonus*self.stack

if RollPseudoRandomPercentage(chance, 1960, self.parent) then 
  self.parent:AddNewModifier(self.parent, nil, "modifier_general_javelin_proc", {})
end

end


function modifier_general_stats:GetMinHealth()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_up_res") then return end 
if not self:CheckDeath() then return end

return 1
end 

function modifier_general_stats:GetModifierIncomingDamage_Percentage()
if not self.parent:HasTalent("modifier_up_stun") then return end

if self.parent:IsStunned() or self.parent:IsHexed() or self.parent:GetForceAttackTarget() ~= nil then 
  return self.ability.talents.stun_reduce
end

return 0
end

function modifier_general_stats:GetModifierExtraHealthPercentage()
return self.duo_health
end


function modifier_general_stats:GetModifierTotalDamageOutgoing_Percentage( params ) 
if params.attacker ~= self.parent then return end
if not params.target then return end

local bonus = 0
if params.target:IsCreep() then 
  bonus = bonus + self.ability.talents.creeps_bonus*self.stack
end
return bonus
end


function modifier_general_stats:GetModifierSpellAmplify_Percentage() 
local bonus = 0
if self.main_stat == 3 and self.parent:HasTalent("modifier_up_allupgrade") then
  bonus = bonus + self.ability.talents.stats_bonus_all*self.parent:GetIntellect(false)/self.ability.talents.stats_bonus_int 
elseif self.main_stat == 2 and self.parent:HasTalent("modifier_up_primaryupgrade") then 
  bonus = bonus + self.parent:GetIntellect(false)/self.ability.talents.stats_bonus_int
elseif (self.main_stat == 1 or self.main_stat == 0) and  self.parent:HasTalent("modifier_up_secondaryupgrade")then 
  bonus = bonus + self.parent:GetIntellect(false)/self.ability.talents.stats_bonus_int
end 
bonus = bonus + self.ability.talents.spell_bonus*self.stack
return bonus
end


function modifier_general_stats:GetModifierStatusResistanceStacking() 
local bonus = self.duo_status
if self.main_stat == 3 and  self.parent:HasTalent("modifier_up_allupgrade") then
  bonus = bonus + self.ability.talents.stats_bonus_all*self.parent:GetStrength()/self.ability.talents.stats_bonus_str
elseif self.main_stat == 0 and self.parent:HasTalent("modifier_up_primaryupgrade") then
  bonus = bonus + self.parent:GetStrength()/self.ability.talents.stats_bonus_str
elseif (self.main_stat == 1 or self.main_stat == 2) and self.parent:HasTalent("modifier_up_secondaryupgrade")then
  bonus = bonus + self.parent:GetStrength()/self.ability.talents.stats_bonus_str
end
bonus = bonus + self.ability.talents.status_bonus*self.stack
return bonus
end

function modifier_general_stats:GetModifierMoveSpeedBonus_Percentage() 
local bonus = 0
if self.main_stat == 3 and self.parent:HasTalent("modifier_up_allupgrade") then
  bonus =  bonus + self.ability.talents.stats_bonus_all*self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
elseif self.main_stat == 1 and self.parent:HasTalent("modifier_up_primaryupgrade") then
  bonus =  bonus + self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
elseif (self.main_stat == 0 or self.main_stat == 2) and self.parent:HasTalent("modifier_up_secondaryupgrade") then
  bonus =  bonus + self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
end
return bonus
end

function modifier_general_stats:GetModifierEvasion_Constant() 
local bonus = 0
if self.main_stat == 3 and self.parent:HasTalent("modifier_up_allupgrade") then
  bonus = bonus + self.ability.talents.stats_bonus_all*self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
elseif self.main_stat == 1 and self.parent:HasTalent("modifier_up_primaryupgrade")then
  bonus =  bonus + self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
elseif (self.main_stat == 0 or self.main_stat == 2) and self.parent:HasTalent("modifier_up_secondaryupgrade")then
  bonus =  bonus + self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
end
bonus = bonus + self.ability.talents.evasion_bonus*self.stack
return bonus
end



function modifier_general_stats:GetModifierBonusStats_Agility() 
local bonus = 0

if self.main_stat == 3 then 
  bonus = bonus + self.ability.talents.all_bonus*self.stack
end 
if self.main_stat == 1 then 
  bonus = bonus + self.ability.talents.primary_bonus*self.stack
end
if (self.main_stat == 2 or self.main_stat == 0) then 
  bonus = bonus + self.ability.talents.secondary_bonus*self.stack
end

return bonus
end


function modifier_general_stats:GetModifierBonusStats_Strength() 
local bonus = 0

if self.main_stat == 3 then 
  bonus = bonus + self.ability.talents.all_bonus*self.stack
end 
if self.main_stat == 0 then 
  bonus = bonus + self.ability.talents.primary_bonus*self.stack
end
if (self.main_stat == 1 or self.main_stat == 2) then 
  bonus = bonus + self.ability.talents.secondary_bonus*self.stack
end

return bonus
end


function modifier_general_stats:GetModifierBonusStats_Intellect() 
local bonus = 0

if self.main_stat == 3 then 
  bonus = bonus + self.ability.talents.all_bonus*self.stack
end 
if self.main_stat == 2 then 
  bonus = bonus + self.ability.talents.primary_bonus*self.stack
end
if (self.main_stat == 1 or self.main_stat == 0) then 
  bonus = bonus + self.ability.talents.secondary_bonus*self.stack
end

return bonus
end


function modifier_general_stats:GetModifierAttackRangeBonus()
if not self.parent:IsRangedAttacker() and self.parent:HasModifier("modifier_item_monkey_king_bar_custom") then return end
if self.parent:IsRangedAttacker() and (self.parent:HasModifier("modifier_item_dragon_lance") or self.parent:HasModifier("modifier_item_hurricane_pike_custom")) then return end
return self.ability.talents.attack_range_bonus
end

function modifier_general_stats:GetModifierCastRangeBonusStacking()
if self.parent:HasModifier("modifier_item_aether_lens") or self.parent:HasModifier("modifier_item_starforge_seal_custom_stats") then return end
return self.ability.talents.cast_range_bonus
end

function modifier_general_stats:GetModifierPercentageCooldown()
return self.ability.talents.cdr_bonus
end

function modifier_general_stats:GetModifierAttackSpeedBonus_Constant()
return self.ability.talents.attack_speed_bonus*self.stack
end

function modifier_general_stats:GetModifierPhysicalArmorBonus()
return self.ability.talents.armor_bonus*self.stack
end

function modifier_general_stats:GetModifierPreAttack_BonusDamage()
return self.ability.talents.damage_bonus*self.stack
end

function modifier_general_stats:GetModifierHealthBonus()
return self.ability.talents.health_bonus*self.stack
end

function modifier_general_stats:GetModifierMagicalResistanceBonus()
return self.ability.talents.magic_bonus*self.stack
end

function modifier_general_stats:GetModifierConstantManaRegen()
return self.ability.talents.mana_regen_bonus*self.stack
end

function modifier_general_stats:GetModifierMoveSpeedBonus_Constant()
return self.ability.talents.move_bonus*self.stack
end

function modifier_general_stats:AddCustomTransmitterData() 
return 
{
  stack = self.stack,
  main_stat = self.main_stat
} 
end

function modifier_general_stats:HandleCustomTransmitterData(data)
self.stack = data.stack
self.main_stat = data.main_stat
end






modifier_up_venom_stack = class({})
function modifier_up_venom_stack:IsHidden() return false end
function modifier_up_venom_stack:IsPurgable() return false end
function modifier_up_venom_stack:GetTexture() return "item_orb_of_venom" end
function modifier_up_venom_stack:DeclareFunctions()
return
{
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,

}
end

function modifier_up_venom_stack:OnCreated()

self.heal_reduction = self:GetCaster():GetTalentValue("modifier_up_venom", "heal_reduce")
end 


function modifier_up_venom_stack:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduction
end

function modifier_up_venom_stack:GetModifierHealChange()
return self.heal_reduction
end

function modifier_up_venom_stack:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduction
end










modifier_up_bigdamage_heal = class({})

function modifier_up_bigdamage_heal:GetTexture() return "tinker_defense_matrix" end
function modifier_up_bigdamage_heal:IsPurgable() return false end
function modifier_up_bigdamage_heal:IsHidden() return false end
function modifier_up_bigdamage_heal:OnCreated(table)

self.parent = self:GetParent()

self.damage =  self.parent:GetTalentValue("modifier_up_bigdamage", "damage_reduce")
self.heal = self.parent:GetTalentValue("modifier_up_bigdamage", "regen")/self:GetRemainingTime()

if not IsServer() then return end

self.parent:EmitSound("UI.Talent_matrix")

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_defense_matrix.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_up_bigdamage_heal:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end
 

function modifier_up_bigdamage_heal:GetModifierHealthRegenPercentage() 
return self.heal
end

function modifier_up_bigdamage_heal:GetModifierIncomingDamage_Percentage()
return self.damage
end


modifier_up_bigdamage_heal_cd = class({})
function modifier_up_bigdamage_heal_cd:IsHidden() return false end
function modifier_up_bigdamage_heal_cd:IsDebuff() return true end
function modifier_up_bigdamage_heal_cd:RemoveOnDeath() return false end
function modifier_up_bigdamage_heal_cd:GetTexture() return "tinker_defense_matrix" end
function modifier_up_bigdamage_heal_cd:IsPurgable() return false end
function modifier_up_bigdamage_heal_cd:OnCreated(table)
if not IsServer() then return end
self.RemoveForDuel = true
end





modifier_up_damagestack_stack = class({})
function modifier_up_damagestack_stack:IsHidden() return false end
function modifier_up_damagestack_stack:IsPurgable() return false end
function modifier_up_damagestack_stack:GetTexture() return "item_timeless_relic" end
function modifier_up_damagestack_stack:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_MODEL_SCALE,
}
end



function modifier_up_damagestack_stack:OnCreated(table)
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_up_damagestack", "max")
self.damage = self.parent:GetTalentValue("modifier_up_damagestack", "damage")

self:SetStackCount(1)
end


function modifier_up_damagestack_stack:GetModifierModelScale()
if self:GetStackCount() < self.max then return end
return 25
end

function modifier_up_damagestack_stack:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
  self.parent:EmitSound("UI.Talent_buff")

  self.particle = ParticleManager:CreateParticle( "particles/jugg_damage.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
  ParticleManager:SetParticleControl( self.particle, 0, self.parent:GetAbsOrigin() )
  ParticleManager:SetParticleControl( self.particle, 1, self.parent:GetAbsOrigin() )
  ParticleManager:SetParticleControl( self.particle, 2, self.parent:GetAbsOrigin() ) 
  self:AddParticle(self.particle, false, false, -1, false, false) 
end

end


function modifier_up_damagestack_stack:GetModifierDamageOutgoing_Percentage()
return self:GetStackCount()*self.damage
end

function modifier_up_damagestack_stack:GetModifierSpellAmplify_Percentage()
return self:GetStackCount()*self.damage
end



modifier_up_ignore_armor_stack = class({})
function modifier_up_ignore_armor_stack:IsHidden() return true end
function modifier_up_ignore_armor_stack:IsPurgable() return false end

function modifier_up_ignore_armor_stack:OnCreated(table)
self.caster = self:GetCaster()
self.armor = self.caster:GetTalentValue("modifier_up_ignore_armor", "general_bonus")*-1
if not IsServer() then return end
self:SetStackCount(table.stack)
end 

function modifier_up_ignore_armor_stack:OnRefresh(table)
self:OnCreated(table)
end

function modifier_up_ignore_armor_stack:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end


function modifier_up_ignore_armor_stack:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()/100
end





modifier_up_root_debuff = class({})

function modifier_up_root_debuff:GetEffectName()
return "particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net.vpcf"
end

function modifier_up_root_debuff:CheckState()
return {[MODIFIER_STATE_ROOTED] = true}
end

function modifier_up_root_debuff:IsHidden() return true end
function modifier_up_root_debuff:IsPurgable() return true end

function modifier_up_root_debuff:OnCreated(table)
if not IsServer() then return end
self:GetParent():EmitSound("n_creep_TrollWarlord.Ensnare")

end


modifier_up_root_cd = class({})
function modifier_up_root_cd:IsHidden() return false end
function modifier_up_root_cd:GetTexture() return "meepo_earthbind" end
function modifier_up_root_cd:IsPurgable() return false end
function modifier_up_root_cd:RemoveOnDeath() return false end
function modifier_up_root_cd:IsDebuff() return true end
function modifier_up_root_cd:OnCreated(table)
if not IsServer() then return end

self.RemoveForDuel = true
end







modifier_up_res_cd = class({})
function modifier_up_res_cd:IsPurgable() return false end
function modifier_up_res_cd:IsHidden() return false end
function modifier_up_res_cd:IsDebuff() return true end
function modifier_up_res_cd:RemoveOnDeath() return false end
function modifier_up_res_cd:GetTexture() return "item_phoenix_ash" end


modifier_up_res_ready = class({})
function modifier_up_res_ready:IsPurgable() return false end
function modifier_up_res_ready:IsHidden() return self:GetParent():HasModifier("modifier_up_res_cd") end
function modifier_up_res_ready:RemoveOnDeath() return false end
function modifier_up_res_ready:GetTexture() return "item_phoenix_ash" end


modifier_up_res_nodmg = class({})
function modifier_up_res_nodmg:IsHidden() return true end 
function modifier_up_res_nodmg:IsPurgable() return false end
function modifier_up_res_nodmg:CheckState()
return
{
  [MODIFIER_STATE_INVULNERABLE] = true
}
end




modifier_up_slow_debuff = class({})

function modifier_up_slow_debuff:IsPurgable() return true end
function modifier_up_slow_debuff:IsHidden() return true end

function modifier_up_slow_debuff:OnCreated(table)

self.caster = self:GetCaster()
self.attack_slow = self.caster:GetTalentValue("modifier_up_slow", "attack_slow")
self.move_slow = self.caster:GetTalentValue("modifier_up_slow", "move_slow")

if not IsServer() then return end
self:GetParent():EmitSound("DOTA_Item.Maim")
end

function modifier_up_slow_debuff:GetEffectName()
return "particles/items2_fx/sange_maim.vpcf"
end

function modifier_up_slow_debuff:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end
 
function modifier_up_slow_debuff:GetModifierAttackSpeedBonus_Constant() 
return self.attack_slow
end

function modifier_up_slow_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.move_slow
end






modifier_up_teamfight_buff = class({})
function modifier_up_teamfight_buff:IsHidden() return false end
function modifier_up_teamfight_buff:IsPurgable() return false end
function modifier_up_teamfight_buff:GetTexture() return "buffs/Martyr" end
function modifier_up_teamfight_buff:OnCreated(table)

self.parent = self:GetParent()

self.damage = self.parent:GetTalentValue("modifier_up_teamfight", "damage_bonus")
self.incoming = self.parent:GetTalentValue("modifier_up_teamfight", "damage_reduce")
end

function modifier_up_teamfight_buff:GetEffectName()
return "particles/units/heroes/hero_pudge/pudge_fleshheap_block_shield_model.vpcf"
end

function modifier_up_teamfight_buff:GetModifierIncomingDamage_Percentage()
return self.incoming
end

function modifier_up_teamfight_buff:GetModifierDamageOutgoing_Percentage()
return self.damage
end

function modifier_up_teamfight_buff:GetModifierSpellAmplify_Percentage()
return self.damage
end

function modifier_up_teamfight_buff:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end







modifier_attack_shield = class({})
function modifier_attack_shield:IsHidden() return false end
function modifier_attack_shield:IsPurgable() return false end
function modifier_attack_shield:GetTexture() return "item_crimson_guard" end

function modifier_attack_shield:OnCreated(table)

self.parent = self:GetParent()
self.shield_talent = "modifier_up_attackblock"
self.max_shield = self.parent:GetTalentValue("modifier_up_attackblock", "block")

if not IsServer() then return end
self:SetStackCount(self.max_shield)
self.parent:EmitSound("Item.CrimsonGuard.Cast")
end

function modifier_attack_shield:OnRefresh(table)
self:OnCreated()
end


function modifier_attack_shield:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
  MODIFIER_PROPERTY_TOOLTIP,
}
end
function modifier_attack_shield:OnTooltip() return self:GetStackCount() end

function modifier_attack_shield:GetModifierIncomingPhysicalDamageConstant(params)

if IsClient() then 
  if params.report_max then 
    return self.max_shield 
  else 
    return self:GetStackCount()
  end 
end

if not IsServer() then return end
if self.parent == params.attacker then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end




modifier_magic_shield = class({})
function modifier_magic_shield:IsHidden() return false end
function modifier_magic_shield:IsPurgable() return false end

function modifier_magic_shield:GetTexture() return "item_hood_of_defiance" end



function modifier_magic_shield:OnCreated(table)
self.parent = self:GetParent()
self.shield_talent = "modifier_up_magicblock"
self.max_shield = self.parent:GetTalentValue("modifier_up_magicblock", "block")

if not IsServer() then return end

self:SetStackCount(self.max_shield)
self.parent:EmitSound("DOTA_Item.Pipe.Activate")
end

function modifier_magic_shield:OnRefresh(table)
self:OnCreated()
end



function modifier_magic_shield:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
  MODIFIER_PROPERTY_TOOLTIP,
}
end

function modifier_magic_shield:OnTooltip() return self:GetStackCount() end


function modifier_magic_shield:GetModifierIncomingSpellDamageConstant(params)

if IsClient() then 
  if params.report_max then 
    return self.max_shield 
  else 
    return self:GetStackCount()
  end 
end

if not IsServer() then return end

if self.parent == params.attacker then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end







modifier_shield_cd = class({})
function modifier_shield_cd:IsHidden() return true end
function modifier_shield_cd:IsPurgable() return false end







modifier_general_stats_illusion = class(mod_hidden)
function modifier_general_stats_illusion:RemoveOnDeath() return false end
function modifier_general_stats_illusion:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.records = {}

self.duo_status = 0
self.duo_health = 0
if not IsSoloMode() then
  self.duo_status = 10
  self.duo_health = 10
end

self.stack = 1
if self.parent:HasTalent("modifier_up_graypoints") then
  self.stack = self.stack + self.ability.talents.gray_bonus/100
end

if not IsServer() then return end
self.main_stat = self.parent:GetPrimaryAttribute()

if self.parent:HasModifier("modifier_item_pirate_hat_custom") then
  local mod = self.parent:FindModifierByName("modifier_item_pirate_hat_custom")
  if mod and mod.bonus then
    self.stack = self.stack + mod.bonus/100
  end
end

if self.parent:HasTalent("modifier_up_javelin") and self.parent.owner then
  self.parent:AddRecordDestroyEvent(self, true)
  local owner = self.parent:IsTempestDouble() and self.parent or self.parent.owner
  owner:AddAttackStartEvent_out(self)
end

self:NewStats()
self:SetHasCustomTransmitterData(true)
self:SendBuffRefreshToClients()
end

function modifier_general_stats_illusion:OnRefresh()
self:OnCreated()
end

function modifier_general_stats_illusion:AddCustomTransmitterData() 
return 
{
  main_stat = self.main_stat,
  stack = self.stack
} 
end

function modifier_general_stats_illusion:HandleCustomTransmitterData(data)
self.main_stat = data.main_stat
self.stack = data.stack
end


function modifier_general_stats_illusion:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
  MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
  MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_EVASION_CONSTANT,
  MODIFIER_PROPERTY_HEALTH_BONUS,
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
  MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
}
end

function modifier_general_stats_illusion:GetModifierExtraHealthPercentage()
return self.duo_health
end

function modifier_general_stats_illusion:GetModifierAttackRangeBonus()
if not self.parent:IsRangedAttacker() and self.parent:HasModifier("modifier_item_monkey_king_bar_custom") then return end
if self.parent:IsRangedAttacker() and (self.parent:HasModifier("modifier_item_dragon_lance") or self.parent:HasModifier("modifier_item_hurricane_pike_custom")) then return end
return self.ability.talents.attack_range_bonus
end

function modifier_general_stats_illusion:GetModifierAttackSpeedBonus_Constant()
return self.ability.talents.attack_speed_bonus*self.stack
end

function modifier_general_stats_illusion:GetModifierHealthBonus()
return self.ability.talents.health_bonus*self.stack
end

function modifier_general_stats_illusion:GetModifierMoveSpeedBonus_Constant()
return self.ability.talents.move_bonus*self.stack
end

function modifier_general_stats_illusion:GetModifierPreAttack_BonusDamage()
return self.ability.talents.damage_bonus*self.stack
end


function modifier_general_stats_illusion:GetModifierStatusResistanceStacking() 
local bonus = self.duo_status
if self.main_stat == 3 and  self.parent:HasTalent("modifier_up_allupgrade") then
  bonus = bonus + self.ability.talents.stats_bonus_all*self.parent:GetStrength()/self.ability.talents.stats_bonus_str
elseif self.main_stat == 0 and self.parent:HasTalent("modifier_up_primaryupgrade") then
  bonus = bonus + self.parent:GetStrength()/self.ability.talents.stats_bonus_str
elseif(self.main_stat == 1 or self.main_stat == 2) and self.parent:HasTalent("modifier_up_secondaryupgrade")then
  bonus = bonus + self.parent:GetStrength()/self.ability.talents.stats_bonus_str
end
bonus = bonus + self.ability.talents.status_bonus*self.stack
return bonus
end

function modifier_general_stats_illusion:GetModifierMoveSpeedBonus_Percentage() 
local bonus = 0
if self.main_stat == 3 and self.parent:HasTalent("modifier_up_allupgrade") then
  bonus =  bonus + self.ability.talents.stats_bonus_all*self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
elseif self.main_stat == 1 and self.parent:HasTalent("modifier_up_primaryupgrade") then
  bonus =  bonus + self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
elseif (self.main_stat == 0 or self.main_stat == 2) and self.parent:HasTalent("modifier_up_secondaryupgrade") then
  bonus =  bonus + self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
end
return bonus
end

function modifier_general_stats_illusion:GetModifierEvasion_Constant() 
local bonus = 0
if self.main_stat == 3 and self.parent:HasTalent("modifier_up_allupgrade") then
  bonus = bonus + self.ability.talents.stats_bonus_all*self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
elseif self.main_stat == 1 and self.parent:HasTalent("modifier_up_primaryupgrade")then
  bonus =  bonus + self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
elseif (self.main_stat == 0 or self.main_stat == 2) and self.parent:HasTalent("modifier_up_secondaryupgrade")then
  bonus =  bonus + self.parent:GetAgility()/self.ability.talents.stats_bonus_agi
end
bonus = bonus + self.ability.talents.evasion_bonus*self.stack
return bonus
end



function modifier_general_stats_illusion:GetModifierBonusStats_Agility() 
local bonus = 0

if self.main_stat == 3 then 
  bonus = bonus + self.ability.talents.all_bonus*self.stack
end 
if self.main_stat == 1 then 
  bonus = bonus + self.ability.talents.primary_bonus*self.stack
end
if (self.main_stat == 2 or self.main_stat == 0) then 
  bonus = bonus + self.ability.talents.secondary_bonus*self.stack
end

return bonus
end


function modifier_general_stats_illusion:GetModifierBonusStats_Strength() 
local bonus = 0

if self.main_stat == 3 then 
  bonus = bonus + self.ability.talents.all_bonus*self.stack
end 
if self.main_stat == 0 then 
  bonus = bonus + self.ability.talents.primary_bonus*self.stack
end
if (self.main_stat == 1 or self.main_stat == 2) then 
  bonus = bonus + self.ability.talents.secondary_bonus*self.stack
end

return bonus
end


function modifier_general_stats_illusion:GetModifierBonusStats_Intellect() 
local bonus = 0

if self.main_stat == 3 then 
  bonus = bonus + self.ability.talents.all_bonus*self.stack
end 
if self.main_stat == 2 then 
  bonus = bonus + self.ability.talents.primary_bonus*self.stack
end
if (self.main_stat == 1 or self.main_stat == 0) then 
  bonus = bonus + self.ability.talents.secondary_bonus*self.stack
end

return bonus
end




function modifier_general_stats_illusion:NewStats()
if not IsServer() then return end

local str = 0
local agi = 0
local int = 0

if self.parent:HasTalent("modifier_up_gainall") then 
  local stats = self.ability.talents.all_gain_bonus/100

  str = str + stats
  agi = agi + stats
  int = int + stats
end 

if self.parent:HasTalent("modifier_up_gainprimary") then 
  local stats = self.ability.talents.primary_gain_bonus/100

  if self.main_stat == 0 then
    str = str + stats
  end 

  if self.main_stat == 1 then
    agi = agi + stats
  end 

  if self.main_stat == 2 then
    int = int + stats
  end 
end 

if self.parent:HasTalent("modifier_up_gainsecondary") then 
  local stats = self.ability.talents.secondary_gain_bonus/100

  if self.main_stat == 0 then
    int = int + stats
    agi = agi + stats
  end 

  if self.main_stat == 1 then
    int = int + stats
    str = str + stats
  end 

  if self.main_stat == 2 then
    agi = agi + stats
    str = str + stats
  end 
end 

self.parent:AddPercentStat({agi = agi, str = str, int = int}, self)
end 


function modifier_general_stats_illusion:CheckState()
if not IsValid(self.parent) then return end
if not self.parent:HasModifier("modifier_general_javelin_proc") then return end
return 
{
  [MODIFIER_STATE_CANNOT_MISS] = true
}
end


function modifier_general_stats_illusion:AttackStartEvent_out(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_up_javelin") then return end
if self.parent ~= params.attacker then return end 
if not params.target:IsUnit() then return end 

if self.parent:HasModifier("modifier_general_javelin_proc") then 
  self.records[params.record] = true
end

self.parent:RemoveModifierByName("modifier_general_javelin_proc")

self:RandomProcDamage()
end

function modifier_general_stats_illusion:RecordDestroyEvent(params)
if not self.parent:HasTalent("modifier_up_javelin") then return end
if not self.records[params.record] then return end
self.records[params.record] = nil
end


function modifier_general_stats_illusion:RandomProcDamage()
if not self.parent:HasTalent("modifier_up_javelin") then return end

local chance = self.ability.talents.javelin_bonus*self.stack

if RollPseudoRandomPercentage(chance, 1960, self.parent) then 
  self.parent:AddNewModifier(self.parent, nil, "modifier_general_javelin_proc", {})
end

end




modifier_general_javelin_proc = class(mod_hidden)