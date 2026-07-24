--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_legendary", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_armor", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_silence", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_damage", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_quest", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_focus", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_silence_cd", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_legendary_choosing", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_legendary_max", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_reduction", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_phantom_coup_de_grace_shield", "abilities/phantom_assassin/custom_phantom_assassin_coup_de_grace", LUA_MODIFIER_MOTION_NONE )


    
custom_phantom_assassin_coup_de_grace = class({})

custom_phantom_assassin_coup_de_grace.all_targets = {}
custom_phantom_assassin_coup_de_grace.current_targets = {}
custom_phantom_assassin_coup_de_grace.last_target = nil


function custom_phantom_assassin_coup_de_grace:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "phantom_assassin_coup_de_grace", self)
end

function custom_phantom_assassin_coup_de_grace:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end


PrecacheResource( "particle","particles/pa_cry.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_charge_mark.vpcf", context )
PrecacheResource( "particle","particles/pa_vendetta.vpcf", context )
PrecacheResource( "particle","particles/pa_arc.vpcf", context )
PrecacheResource( "particle","particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave_gods_strength.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf", context )
PrecacheResource( "particle","particles/general/generic_armor_reduction.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_hands.vpcf", context )
PrecacheResource( "particle","particles/brist_lowhp_.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_mark_overhead.vpcf", context )
PrecacheResource( "particle","particles/phantom_assassin/crit_shield.vpcf", context )

end



function custom_phantom_assassin_coup_de_grace:GetCooldown()
if self:GetCaster():HasTalent("modifier_phantom_assassin_crit_7") then
  return self:GetCaster():GetTalentValue("modifier_phantom_assassin_crit_7", "cd")
end

end

function custom_phantom_assassin_coup_de_grace:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_phantom_assassin_phantom_coup_de_grace"
end

function custom_phantom_assassin_coup_de_grace:GetBehavior()
if self:GetCaster():HasTalent("modifier_phantom_assassin_crit_7") then
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE 
end


function custom_phantom_assassin_coup_de_grace:SetTarget(index)
local caster = self:GetCaster()

local hero = EntIndexToHScript(index)
if not hero or hero:IsNull() or not players[hero:GetId()] then
  self:StartCd() 
  return
end

caster:AddNewModifier(caster, self, "modifier_phantom_assassin_phantom_coup_de_grace_legendary", {target = index, duration = caster:GetTalentValue("modifier_phantom_assassin_crit_7", "duration")})
end



function custom_phantom_assassin_coup_de_grace:OnSpellStart()

local caster = self:GetCaster()
local all_targets = {}
local targets_alive = 0

for _,target_table in pairs(self.all_targets) do 

  local target = EntIndexToHScript(target_table.target)

  if target and not target:IsNull() then 
    local count = #all_targets + 1
    all_targets[count] = {}
    all_targets[count].target = target_table.target

    if target_table.killed == true or not players[target_table.id] then 
      all_targets[count].killed = true
    else 

      all_targets[count].killed = false
      targets_alive = targets_alive + 1
    end
  end
end

self.current_targets = all_targets

if targets_alive > 0 then 
  caster:AddNewModifier(caster, self, "modifier_phantom_assassin_phantom_coup_de_grace_legendary_choosing", {})
  return
end

local heroes = {}

for _,player in pairs(players) do 
  if player:GetTeamNumber() ~= caster:GetTeamNumber() then
    heroes[#heroes + 1] = player
  end
end 

if #heroes == 0 then return end

local target = heroes[RandomInt(1, #heroes)]

if #heroes > 1 and self.last_target ~= nil then 
	repeat target = heroes[RandomInt(1, #heroes)]
	until self.last_target ~= target
end

caster:AddNewModifier(caster, self, "modifier_phantom_assassin_phantom_coup_de_grace_legendary", {target = target:entindex(), duration = caster:GetTalentValue("modifier_phantom_assassin_crit_7", "duration")})
end




modifier_phantom_assassin_phantom_coup_de_grace_legendary = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_legendary:IsPurgable() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_legendary:IsHidden() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_legendary:GetTexture() return "buffs/odds_fow" end
function modifier_phantom_assassin_phantom_coup_de_grace_legendary:RemoveOnDeath() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_legendary:OnCreated(table) 
if not IsServer() then  return end
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)

self.ability = self:GetAbility()
self.target = EntIndexToHScript(table.target)
self.ability.last_target = self.target
self.ability:EndCd()

self.target_id = self.target:GetId()

self.range = self.parent:GetTalentValue("modifier_phantom_assassin_crit_7", "range")
self.timer = self.parent:GetTalentValue("modifier_phantom_assassin_crit_7", "delay")

if test then 
  self.timer = 0
end

self.RemoveForDuel = true

self.particle_trail = ParticleManager:CreateParticleForTeam("particles/lc_odd_charge_mark.vpcf", PATTACH_OVERHEAD_FOLLOW, self.target, self.parent:GetTeamNumber())
self:AddParticle(self.particle_trail, false, false, -1, false, false)

self.particle_trail_fx = ParticleManager:CreateParticleForTeam("particles/pa_vendetta.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.target, self.parent:GetTeamNumber())
self:AddParticle(self.particle_trail_fx, false, false, -1, false, false)

self.parent:EmitSound("Phantom_Assassin.SuperCrit")
self.parent:GenericParticle("particles/pa_cry.vpcf")

self.interval = 0.1
self.count = 0
self:SetStackCount(self.timer)
self:StartIntervalThink(self.interval)
end


function modifier_phantom_assassin_phantom_coup_de_grace_legendary:OnIntervalThink()
if not IsServer() then return end

if self:GetStackCount() > 0 then
  self.count = self.count + self.interval
  if self.count >= 1 then
    self.count = 0
    self:DecrementStackCount()
  end
end


if not self.target or self.target:IsNull() or not players[self.target_id] then 
  self:Destroy()
  return
end

if self.target:IsAlive() then 
  AddFOWViewer(self.parent:GetTeamNumber(), self.target:GetAbsOrigin(), 10, self.interval*2, true)
end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID()), "pa_hunt_think",  {hero = self.target:GetUnitName(), timer = math.floor(self:GetRemainingTime()), gold = 0})
end




function modifier_phantom_assassin_phantom_coup_de_grace_legendary:DeathEvent(params)
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if self.target ~= params.unit then return end 
if self.target:IsReincarnating() then return end
if self:GetStackCount() > 0 then return end

local attacker = params.attacker

if attacker and attacker.owner then 
  attacker = attacker.owner
end

if self.parent ~= attacker and (self.target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.range then return end

self.kill_done = true
self:Destroy()
end




function modifier_phantom_assassin_phantom_coup_de_grace_legendary:OnDestroy()
if not IsServer() then return end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID()), "pa_hunt_end",  {})

self.ability:StartCd()

if self.kill_done then 

  local mod = self.parent:FindModifierByName("modifier_phantom_assassin_phantom_coup_de_grace")
  if mod then 
    mod:AddStack()
  end

  for _,data in pairs(self.ability.all_targets) do 
    if data.target == self.target:entindex() then 
      data.killed = true
    end
  end

end

end





modifier_phantom_assassin_phantom_coup_de_grace = class({})
function modifier_phantom_assassin_phantom_coup_de_grace:IsHidden() return not self.parent:HasTalent("modifier_phantom_assassin_crit_7") end
function modifier_phantom_assassin_phantom_coup_de_grace:IsPurgable() return false end
function modifier_phantom_assassin_phantom_coup_de_grace:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if self.parent:IsRealHero() then 
  self.parent:AddDamageEvent_out(self)
  self.parent:AddAttackEvent_out(self)
end 
self.focus_duration = self.ability:GetSpecialValueFor("duration")

self.legendary_max = self.parent:GetTalentValue("modifier_phantom_assassin_crit_7", "max", true)
self.legendary_damage = self.parent:GetTalentValue("modifier_phantom_assassin_crit_7", "damage", true)
self.legendary_bva = self.parent:GetTalentValue("modifier_phantom_assassin_crit_7", "bva", true)

self.heal_creeps = self.parent:GetTalentValue("modifier_phantom_assassin_crit_2", "creeps", true)
self.heal_bonus = self.parent:GetTalentValue("modifier_phantom_assassin_crit_2", "bonus", true)

self.silence_duration = self.parent:GetTalentValue("modifier_phantom_assassin_crit_5", "silence", true)
self.silence_cd = self.parent:GetTalentValue("modifier_phantom_assassin_crit_5", "cd", true)

self.armor_duration = self.parent:GetTalentValue("modifier_phantom_assassin_crit_4", "duration", true)
self.armor_stack = self.parent:GetTalentValue("modifier_phantom_assassin_crit_4", "crit_stack", true)

self.damage_duration = self.parent:GetTalentValue("modifier_phantom_assassin_crit_3", "duration", true)

self.shield_duration = self.parent:GetTalentValue("modifier_phantom_assassin_crit_6", "duration", true)

if not IsServer() then return end
if self.ability:IsStolen() then return end

local all_ids = {}
for id,player in pairs(players) do
  if player:GetTeamNumber() ~= self.parent:GetTeamNumber() then 
    table.insert(all_ids, id)
  end
end

local max = 5
local final_ids = {}

if #all_ids == 0 then return end

if #all_ids > max then
  local used = {}
  local random = 0
  for i = 1,max do
    repeat random = RandomInt(1, #all_ids)
    until not dota1x6:check_used(used,random)
    used[#used + 1] = random
    final_ids[#final_ids + 1] = all_ids[random]
  end
else
  final_ids = all_ids
end

for _,id in pairs(final_ids) do 
  local player = players[id]
  if player then 
    print(id, player:GetUnitName())
    local count = #self.ability.all_targets + 1
    self.ability.all_targets[count] = {}
    self.ability.all_targets[count].target = player:entindex()
    self.ability.all_targets[count].killed = false
    self.ability.all_targets[count].id = id
  end
end

self.proced = false
self:StartIntervalThink(1)
end



function modifier_phantom_assassin_phantom_coup_de_grace:OnIntervalThink()
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_phantom_assassin_crit_7") then return end
if self.parent:HasModifier("modifier_phantom_assassin_phantom_coup_de_grace_legendary_max") then return end

local alive = false
for _,data in pairs(self.ability.all_targets) do
  local target = EntIndexToHScript(data.target)
  if target and not target:IsNull() and data.killed == false and players[data.id] then 
    alive = true
    break
  end
end

if alive == true then return end 

self.parent:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_legendary_max", {})
end


function modifier_phantom_assassin_phantom_coup_de_grace:AddStack()
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_phantom_assassin_crit_7") then return end
if self:GetStackCount() >= self.legendary_max then return end

self:IncrementStackCount()

if self:GetStackCount() >= self.legendary_max then 
  local particle_peffect = ParticleManager:CreateParticle("particles/brist_lowhp_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
  ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
  ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
  ParticleManager:ReleaseParticleIndex(particle_peffect)
  self.parent:EmitSound("BS.Thirst_legendary_active")
else 

  self.particle = ParticleManager:CreateParticle( "particles/pa_arc.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent ) 
     
  self.parent:EmitSound("Phantom_Assassin.SuperCrit")
  Timers:CreateTimer(1,function()
     ParticleManager:DestroyParticle( self.particle , false)
     ParticleManager:ReleaseParticleIndex( self.particle )
  end)
end

end



function modifier_phantom_assassin_phantom_coup_de_grace:DeclareFunctions()
return  
{
  MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
  MODIFIER_PROPERTY_TOOLTIP,
  MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
}
end

function modifier_phantom_assassin_phantom_coup_de_grace:OnTooltip()
if not self.parent:HasTalent("modifier_phantom_assassin_crit_7") then return end
return self.legendary_damage*self:GetStackCount()
end 


function modifier_phantom_assassin_phantom_coup_de_grace:GetModifierBaseAttackTimeConstant()
if not self.parent:HasTalent("modifier_phantom_assassin_crit_7") then return end
if not self.parent:HasModifier("modifier_phantom_assassin_phantom_coup_de_grace_legendary_max") then return end
return self.legendary_bva
end 



function modifier_phantom_assassin_phantom_coup_de_grace:AttackEvent_out(params)
if not IsServer() then return end
if not params.target:IsUnit() then return end 
local attacker = params.attacker
local real_attacker = attacker

if real_attacker.owner and real_attacker:IsIllusion() then 
  real_attacker = attacker.owner
end

if self.parent ~= real_attacker then return end
if attacker:PassivesDisabled() then return end

if attacker:HasTalent("modifier_phantom_assassin_crit_4") then 
  params.target:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_armor", {duration = self.armor_duration})
  attacker:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_armor", {duration = self.armor_duration})
end 

local mod = attacker:FindModifierByName("modifier_phantom_assassin_phantom_coup_de_grace_focus")

if mod and mod.record and mod.record == params.record then 

  if self.parent:GetQuest() == "Phantom.Quest_8" and params.target:IsRealHero() and self.parent == attacker then 
    params.target:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_quest", {duration = 3})
  end

  if attacker:HasTalent("modifier_phantom_assassin_crit_5") and not params.target:HasModifier("modifier_phantom_assassin_phantom_coup_de_grace_silence_cd") then
    params.target:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_silence_cd", {duration = self.silence_cd}) 
    params.target:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_silence", {duration = (1 - params.target:GetStatusResistance())*self.silence_duration})
  end

  if attacker:HasTalent("modifier_phantom_assassin_crit_6") then 
    attacker:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_shield", {duration = self.shield_duration})
  end

  if attacker:HasTalent("modifier_phantom_assassin_crit_3") then 
    params.target:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_reduction", {duration = self.damage_duration})
  end

  if attacker:HasTalent("modifier_phantom_assassin_crit_4") then 
    local armor = params.target:FindModifierByName("modifier_phantom_assassin_phantom_coup_de_grace_armor")
    for i = 1, (self.armor_stack - 1) do 
      params.target:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_armor", {duration = self.armor_duration})
      attacker:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_armor", {duration = self.armor_duration})
    end 
  end 
        
  self:PlayEffects(attacker, params.target )
  return
end

local chance = self.ability:GetSpecialValueFor( "crit_chance" ) 
local dagger = attacker:FindModifierByName("modifier_custom_phantom_assassin_stifling_dagger_attack")

if dagger then 
  chance = self.ability:GetSpecialValueFor("dagger_crit_chance")
end 

if attacker:HasTalent("modifier_phantom_assassin_crit_1") then 
  chance = chance + attacker:GetTalentValue("modifier_phantom_assassin_crit_1", "chance")
end

local random = RollPseudoRandomPercentage(chance,1223, attacker)

if not random then return end
attacker:AddNewModifier(attacker, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_focus", {duration = self.focus_duration})
end 






function modifier_phantom_assassin_phantom_coup_de_grace:DamageEvent_out(params)
if not IsServer() then return end
if not params.unit:IsUnit() then return end

local attacker = params.attacker
local real_attacker = attacker

if real_attacker.owner and real_attacker:IsIllusion() then 
  real_attacker = attacker.owner
end

if self.parent ~= real_attacker then return end

local mod = attacker:FindModifierByName("modifier_phantom_assassin_phantom_coup_de_grace_focus")
local crit = false

if not params.inflictor and mod and mod.record and params.record and mod.record == params.record then 
  crit = true
  mod:Destroy()
end

if attacker:HasTalent("modifier_phantom_assassin_crit_2") then
  local heal = params.damage*attacker:GetTalentValue("modifier_phantom_assassin_crit_2", "heal")/100

  if crit == true then 
    heal = heal * self.heal_bonus
  end
  if params.unit:IsCreep() and params.inflictor then 
    heal = heal/self.heal_creeps
  end

  attacker:GenericHeal(heal, self.ability, not crit, nil, "modifier_phantom_assassin_crit_2")
end

end




function modifier_phantom_assassin_phantom_coup_de_grace:PlayEffects( attacker, target )


local crit_effect = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf", self)

local vec = (target:GetAbsOrigin() - attacker:GetAbsOrigin()):Normalized()

local coup_pfx = ParticleManager:CreateParticle(crit_effect, PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt( coup_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
ParticleManager:SetParticleControl( coup_pfx, 1, target:GetOrigin() )
ParticleManager:SetParticleControlForward( coup_pfx, 1, -vec )
ParticleManager:ReleaseParticleIndex( coup_pfx )

target:EmitSound(wearables_system:GetSoundReplacement(self:GetCaster(), "Hero_PhantomAssassin.CoupDeGrace", self))

end























modifier_phantom_assassin_phantom_coup_de_grace_armor = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_armor:IsHidden() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_armor:IsPurgable() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_armor:GetTexture() return "buffs/back_shield" end
function modifier_phantom_assassin_phantom_coup_de_grace_armor:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, 
}
end

function modifier_phantom_assassin_phantom_coup_de_grace_armor:OnCreated(table)

self.caster = self:GetCaster()
self.parent = self:GetParent()

self.armor = self.caster:GetTalentValue("modifier_phantom_assassin_crit_4", "armor")
self.max = self.caster:GetTalentValue("modifier_phantom_assassin_crit_4", "max")

if self.caster:GetTeamNumber() == self.parent:GetTeamNumber() then 
  self.armor = self.armor * -1
end

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_phantom_assassin_phantom_coup_de_grace_armor:GetModifierPhysicalArmorBonus() 
return self.armor*self:GetStackCount()
end

function modifier_phantom_assassin_phantom_coup_de_grace_armor:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()

if self:GetStackCount() >= self.max and self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber() then 
  self.parent:EmitSound("Hoodwink.Acorn_armor")
  self.parent:GenericParticle("particles/general/generic_armor_reduction.vpcf", self, true)
end

end 








modifier_phantom_assassin_phantom_coup_de_grace_silence = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_silence:IsHidden() return true end
function modifier_phantom_assassin_phantom_coup_de_grace_silence:IsPurgable() return true end
function modifier_phantom_assassin_phantom_coup_de_grace_silence:GetTexture() return "buffs/strike_stack" end
function modifier_phantom_assassin_phantom_coup_de_grace_silence:CheckState() return {[MODIFIER_STATE_SILENCED] = true} end
function modifier_phantom_assassin_phantom_coup_de_grace_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
function modifier_phantom_assassin_phantom_coup_de_grace_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end


function modifier_phantom_assassin_phantom_coup_de_grace_silence:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_phantom_assassin_crit_5", "slow")
if not IsServer() then return end
self:GetParent():EmitSound("Sf.Raze_Silence")
end

function modifier_phantom_assassin_phantom_coup_de_grace_silence:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_phantom_assassin_phantom_coup_de_grace_silence:GetModifierAttackSpeedBonus_Constant()
return self.slow
end




modifier_phantom_assassin_phantom_coup_de_grace_damage = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_damage:IsHidden() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_damage:IsPurgable() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_damage:GetTexture() return "buffs/Blade_dance_stack" end
function modifier_phantom_assassin_phantom_coup_de_grace_damage:OnCreated(table)
self.damage = self:GetCaster():GetTalentValue("modifier_phantom_assassin_crit_1", "damage")
end

function modifier_phantom_assassin_phantom_coup_de_grace_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end

function modifier_phantom_assassin_phantom_coup_de_grace_damage:GetModifierPreAttack_BonusDamage()
return self.damage
end







modifier_phantom_assassin_phantom_coup_de_grace_quest = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_quest:IsHidden() return true end
function modifier_phantom_assassin_phantom_coup_de_grace_quest:IsPurgable() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_quest:OnCreated(table)
if not IsServer() then return end

self:SetStackCount(1)
end

function modifier_phantom_assassin_phantom_coup_de_grace_quest:OnRefresh(table)
if not IsServer() then return end
if not self:GetCaster():GetQuest() then return end

self:IncrementStackCount()


if self:GetStackCount() >= self:GetCaster().quest.number then 
  self:GetCaster():UpdateQuest(1)
  self:Destroy()
end

end


modifier_phantom_assassin_phantom_coup_de_grace_focus = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_focus:IsHidden() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_focus:IsPurgable() return false end


function modifier_phantom_assassin_phantom_coup_de_grace_focus:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end

self.damage = self.ability:GetSpecialValueFor("crit_bonus")

local mod = self.parent:FindModifierByName("modifier_phantom_assassin_phantom_coup_de_grace")

if mod and self.parent:HasTalent("modifier_phantom_assassin_crit_7") then 
  self.damage = self.damage + mod:GetStackCount()*self.parent:GetTalentValue("modifier_phantom_assassin_crit_7", "damage")
end

if self.parent:HasTalent("modifier_phantom_assassin_crit_1") then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_phantom_assassin_phantom_coup_de_grace_damage", {duration = self.parent:GetTalentValue("modifier_phantom_assassin_crit_1", "duration")})
end

self.record = nil
self:StartIntervalThink(0.2)
end

function modifier_phantom_assassin_phantom_coup_de_grace_focus:GetEffectName()
return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_mark_overhead.vpcf"
end

function modifier_phantom_assassin_phantom_coup_de_grace_focus:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end


function modifier_phantom_assassin_phantom_coup_de_grace_focus:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsRealHero() then return end

if not self.ability or not self.ability:GetIntrinsicModifierName() or not self.parent:HasModifier(self.ability:GetIntrinsicModifierName()) then
  self:Destroy()
end

end

function modifier_phantom_assassin_phantom_coup_de_grace_focus:DeclareFunctions()
return  
{
  MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
}
end

function modifier_phantom_assassin_phantom_coup_de_grace_focus:GetModifierPreAttack_CriticalStrike( params )
if not IsServer() then return end
if not params.target:IsUnit() then return end

self.record = params.record
return self.damage
end

function modifier_phantom_assassin_phantom_coup_de_grace_focus:GetCritDamage() 
return self.damage 
end





modifier_phantom_assassin_phantom_coup_de_grace_silence_cd = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_silence_cd:IsHidden() return true end
function modifier_phantom_assassin_phantom_coup_de_grace_silence_cd:IsPurgable() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_silence_cd:RemoveOnDeath() return false end





modifier_phantom_assassin_phantom_coup_de_grace_legendary_choosing = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_legendary_choosing:IsHidden() return true end
function modifier_phantom_assassin_phantom_coup_de_grace_legendary_choosing:IsPurgable() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_legendary_choosing:RemoveOnDeath() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_legendary_choosing:OnCreated(table)
if not IsServer() then return end 

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.targets = {}
local alive = 0

for _,data in pairs(self.ability.current_targets) do 
  local count = #self.targets + 1
  local target = EntIndexToHScript(data.target)
  if target and not target:IsNull() then 
    self.targets[count] = {}
    self.targets[count].target = target:GetUnitName()
    self.targets[count].killed = data.killed
    self.targets[count].index = data.target
  end

  if data.killed == false then 
    alive = alive + 1
  end
end

if #self.targets == 0 or alive == 0 then 
  self:Destroy()
  return
end

self.picked = false
self.ability:EndCd()
self:OnIntervalThink()
self:StartIntervalThink(0.5)
end 

function modifier_phantom_assassin_phantom_coup_de_grace_legendary_choosing:OnIntervalThink()
if not IsServer() then return end
CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID()), "pa_hunt_init", self.targets)
end 

function modifier_phantom_assassin_phantom_coup_de_grace_legendary_choosing:EndPick(pick)
if not IsServer() then return end
if not self.parent:IsAlive() then return end

if self.targets[pick] and self.targets[pick].index then 
  self.ability:SetTarget(self.targets[pick].index)
  self.picked = true
end
self:Destroy()
end 

function modifier_phantom_assassin_phantom_coup_de_grace_legendary_choosing:OnDestroy()
if not IsServer() then return end
if self.picked == false then 
  self.ability:StartCd()
end
EmitAnnouncerSoundForPlayer("Lc.Duel_target_end", self.parent:GetPlayerOwnerID())
CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID()), "pa_hunt_init_end",  {})
end 







modifier_phantom_assassin_phantom_coup_de_grace_legendary_max = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_legendary_max:IsHidden() return true end
function modifier_phantom_assassin_phantom_coup_de_grace_legendary_max:IsPurgable() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_legendary_max:RemoveOnDeath() return false end

function modifier_phantom_assassin_phantom_coup_de_grace_legendary_max:OnCreated()
self.parent = self:GetParent()

if not IsServer() then return end
local particle_peffect = ParticleManager:CreateParticle("particles/brist_lowhp_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)
self.parent:EmitSound("BS.Thirst_legendary_active")
end








modifier_phantom_assassin_phantom_coup_de_grace_reduction = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_reduction:IsHidden() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_reduction:IsPurgable() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_reduction:GetTexture() return "buffs/Bloodrage_blood" end
function modifier_phantom_assassin_phantom_coup_de_grace_reduction:OnCreated()
self.caster = self:GetCaster()
self.heal_reduce = self.caster:GetTalentValue("modifier_phantom_assassin_crit_3", "heal_reduce")
self.damage_reduce = self.caster:GetTalentValue("modifier_phantom_assassin_crit_3", "damage_reduce")
end 

function modifier_phantom_assassin_phantom_coup_de_grace_reduction:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_phantom_assassin_phantom_coup_de_grace_reduction:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_phantom_assassin_phantom_coup_de_grace_reduction:GetModifierHealChange() 
return self.heal_reduce
end

function modifier_phantom_assassin_phantom_coup_de_grace_reduction:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce
end

function modifier_phantom_assassin_phantom_coup_de_grace_reduction:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end

function modifier_phantom_assassin_phantom_coup_de_grace_reduction:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end













modifier_phantom_assassin_phantom_coup_de_grace_shield = class({})
function modifier_phantom_assassin_phantom_coup_de_grace_shield:IsHidden() return false end
function modifier_phantom_assassin_phantom_coup_de_grace_shield:GetTexture() return "buffs/Blade_dance_move" end
function modifier_phantom_assassin_phantom_coup_de_grace_shield:IsPurgable() return false end

function modifier_phantom_assassin_phantom_coup_de_grace_shield:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.shield_talent = "modifier_phantom_assassin_crit_6"
self.shield = self.parent:GetTalentValue("modifier_phantom_assassin_crit_6", "shield")/100
self.max = self.parent:GetTalentValue("modifier_phantom_assassin_crit_6", "max")
self.status = self.parent:GetTalentValue("modifier_phantom_assassin_crit_6", "status")

self.add_shield =  self.shield*self.parent:GetMaxHealth()
self.max_shield = self.add_shield*self.max

if not IsServer() then return end
self.parent:GenericParticle("particles/phantom_assassin/crit_shield.vpcf", self)

self.parent:EmitSound("PA.Crit_shield")
self.RemoveForDuel = true
self:AddShield()
end

function modifier_phantom_assassin_phantom_coup_de_grace_shield:OnRefresh()
self:AddShield()
end 

function modifier_phantom_assassin_phantom_coup_de_grace_shield:AddShield()
if not IsServer() then return end
self:SetStackCount(math.min(self.max_shield, self:GetStackCount() + self.add_shield))
end 

function modifier_phantom_assassin_phantom_coup_de_grace_shield:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}

end


function modifier_phantom_assassin_phantom_coup_de_grace_shield:GetModifierStatusResistanceStacking()
return self.status
end


function modifier_phantom_assassin_phantom_coup_de_grace_shield:GetStatusEffectName()
return "particles/status_fx/status_effect_bloodrage.vpcf"
end


function modifier_phantom_assassin_phantom_coup_de_grace_shield:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end

function modifier_phantom_assassin_phantom_coup_de_grace_shield:GetModifierIncomingDamageConstant( params )

if IsClient() then 
  if params.report_max then 
    return self.max_shield
  else 
      return self:GetStackCount()
    end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end
