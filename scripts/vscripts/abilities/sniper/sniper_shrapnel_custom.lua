--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sniper_shrapnel_custom", "abilities/sniper/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_custom_damage", "abilities/sniper/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_custom_damage_stack", "abilities/sniper/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_custom_thinker", "abilities/sniper/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_custom_mine", "abilities/sniper/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_custom_tracker", "abilities/sniper/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_custom_move_speed", "abilities/sniper/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_custom_silence", "abilities/sniper/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )



sniper_shrapnel_custom = class({})
sniper_shrapnel_custom_4 = class({})


function sniper_shrapnel_custom:CreateTalent()
local caster = self:GetCaster()
local ability = caster:FindAbilityByName("sniper_shrapnel_custom_4")

if not ability then return end
caster:SwapAbilities(self:GetName(), ability:GetName(), false, true)
ability:SetCurrentAbilityCharges(self:GetCurrentAbilityCharges())
end


function sniper_shrapnel_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_shrapnel.vpcf", context )
PrecacheResource( "particle","particles/sf_refresh_a.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/ember_slow.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_lifesteal.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_silenced.vpcf", context )
end


function sniper_shrapnel_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sniper_shrapnel_custom_tracker"
end


function sniper_shrapnel_custom:GetAbilityChargeRestoreTime(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sniper_shrapnel_1") then 
    bonus = self:GetCaster():GetTalentValue("modifier_sniper_shrapnel_1", "cd")
end 
return self:GetSpecialValueFor("AbilityChargeRestoreTime") + bonus
end


function sniper_shrapnel_custom_4:GetAbilityChargeRestoreTime(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sniper_shrapnel_1") then 
    bonus = self:GetCaster():GetTalentValue("modifier_sniper_shrapnel_1", "cd")
end 
return self:GetSpecialValueFor("AbilityChargeRestoreTime") + bonus
end


function sniper_shrapnel_custom:GetAOERadius()
local bonus = 0
if self:GetCaster():HasTalent("modifier_sniper_shrapnel_5") then 
    bonus = self:GetCaster():GetTalentValue("modifier_sniper_shrapnel_5", "radius")
end
return self:GetSpecialValueFor( "radius" ) + bonus
end


function sniper_shrapnel_custom_4:GetAOERadius()
local bonus = 0
if self:GetCaster():HasTalent("modifier_sniper_shrapnel_5") then 
    bonus = self:GetCaster():GetTalentValue("modifier_sniper_shrapnel_5", "radius")
end
return self:GetSpecialValueFor( "radius" ) + bonus
end


function sniper_shrapnel_custom:Launch(point)
local caster = self:GetCaster()
CreateModifierThinker( caster, self, "modifier_sniper_shrapnel_custom_thinker", {}, point, caster:GetTeamNumber(), false) 
if caster:GetName() == "npc_dota_hero_sniper" and RollPercentage(100) then
    caster:EmitSound("sniper_snip_ability_shrapnel_0"..math.random(1,3))
end

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
ParticleManager:SetParticleControlEnt(  effect_cast, 0,  caster,  PATTACH_POINT_FOLLOW,  "attach_attack1",  caster:GetOrigin(),  false )
ParticleManager:SetParticleControl( effect_cast, 1, point + Vector( 0, 0, 2000 ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
caster:EmitSound("Hero_Sniper.ShrapnelShoot")
end



function sniper_shrapnel_custom:OnSpellStart()
local point = self:GetCursorPosition()
self:Launch(point)
end


function sniper_shrapnel_custom_4:OnSpellStart()
local point = self:GetCursorPosition()
local ability = self:GetCaster():FindAbilityByName("sniper_shrapnel_custom")
ability:Launch(point)
end





modifier_sniper_shrapnel_custom_thinker = class({})
function modifier_sniper_shrapnel_custom_thinker:IsHidden() return true end
function modifier_sniper_shrapnel_custom_thinker:IsPurgable() return false end
function modifier_sniper_shrapnel_custom_thinker:IsAura() return self.start end
function modifier_sniper_shrapnel_custom_thinker:GetModifierAura()  return "modifier_sniper_shrapnel_custom_damage" end
function modifier_sniper_shrapnel_custom_thinker:GetAuraRadius() return self.radius end
function modifier_sniper_shrapnel_custom_thinker:GetAuraDuration() return 0.5 end
function modifier_sniper_shrapnel_custom_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_sniper_shrapnel_custom_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end


function modifier_sniper_shrapnel_custom_thinker:OnCreated( kv )
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.delay = self.ability:GetSpecialValueFor( "damage_delay" )*(1 + self.caster:GetTalentValue("modifier_sniper_shrapnel_6", "delay")/100)
self.radius = self.ability:GetSpecialValueFor( "radius" ) + self.caster:GetTalentValue("modifier_sniper_shrapnel_5", "radius")
self.damage = self.ability:GetSpecialValueFor( "shrapnel_damage" )
self.duration = self.ability:GetSpecialValueFor( "duration" ) 
self.damage = self.ability:GetSpecialValueFor( "shrapnel_damage" )

self.interval = 1

self.start = false

self.move_duration = self.caster:GetTalentValue("modifier_sniper_shrapnel_6", "duration", true)

if not IsServer() then return end

self.direction = (self.parent:GetOrigin()-self.caster:GetOrigin()):Normalized()
self.direction.z = 0

self:StartIntervalThink( self.delay )
end


function modifier_sniper_shrapnel_custom_thinker:OnIntervalThink()
if not self.start then
    self.start = true
    self:SetDuration( self.duration + FrameTime()*2, true )

    self.parent:EmitSound("Sniper.ShrapnelShatter")  

    if self.caster:HasTalent("modifier_sniper_shrapnel_6") then 
        self:StartIntervalThink(0.2)
    end

    AddFOWViewer( self.caster:GetTeamNumber(), self.parent:GetOrigin(), self.radius, self.duration, false )

    if self.caster:HasTalent("modifier_sniper_shrapnel_4") then 
        local mine = CreateUnitByName("npc_sniper_mine", self.parent:GetAbsOrigin(), true, nil, nil, self.caster:GetTeamNumber())
        mine.owner = self.caster
        mine:AddNewModifier(self.caster, self.ability, "modifier_sniper_shrapnel_custom_mine", {})
        mine:SetMaxHealth(self.caster:GetTalentValue("modifier_sniper_shrapnel_4", "attacks"))
        mine:SetHealth(self.caster:GetTalentValue("modifier_sniper_shrapnel_4", "attacks"))
    end

    self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_sniper/sniper_shrapnel.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:SetParticleControlForward( self.effect_cast, 2, self.direction )
    self:AddParticle(self.effect_cast, false, false, -1, false, true)
end

if (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.radius and self.caster:HasTalent("modifier_sniper_shrapnel_6") then 
    self.caster:AddNewModifier(self.caster, self.ability, "modifier_sniper_shrapnel_custom_move_speed", {duration = self.move_duration})
end

end

function modifier_sniper_shrapnel_custom_thinker:OnDestroy()
if not IsServer() then return end
self.parent:StopSound(self.sound_cast )
end





modifier_sniper_shrapnel_custom_tracker = class({})

function modifier_sniper_shrapnel_custom_tracker:IsHidden() return true end
function modifier_sniper_shrapnel_custom_tracker:IsPurgable() return false end

function modifier_sniper_shrapnel_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_chance = self.parent:GetTalentValue("modifier_sniper_shrapnel_7", "chance", true)
self.legendary_creeps = self.parent:GetTalentValue("modifier_sniper_shrapnel_7", "chance_creeps", true)

self.parent:AddAttackEvent_out(self)
end


function modifier_sniper_shrapnel_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
local target = params.target
if not params.target:IsUnit() then return end
if self.parent ~= params.attacker then return end

if target:HasModifier("modifier_sniper_shrapnel_custom_damage") then 
    if self.parent:HasTalent("modifier_sniper_shrapnel_3") then
        self.parent:GenericHeal(self.parent:GetMaxHealth()*self.parent:GetTalentValue("modifier_sniper_shrapnel_3", "heal")/100, self.ability, nil, nil, "modifier_sniper_shrapnel_3")
    end
end

if not self.parent:HasTalent("modifier_sniper_shrapnel_7") then return end
local chance = self.legendary_chance

if params.target:IsCreep() then 
    chance = chance*self.legendary_creeps
end

if not RollPseudoRandomPercentage(chance, 276, self.parent) then return end

local name = "sniper_shrapnel_custom"
if self.parent:HasTalent("modifier_sniper_shrapnel_6") then 
    name = "sniper_shrapnel_custom_4"
end
local ability = self.parent:FindAbilityByName(name)

if ability then
    ability:AddCharge(1, "particles/sf_refresh_a.vpcf", "Sniper.Shrapnel_legendary")
end

end




modifier_sniper_shrapnel_custom = class({})
function modifier_sniper_shrapnel_custom:IsHidden() return false end
function modifier_sniper_shrapnel_custom:IsPurgable() return false end
function modifier_sniper_shrapnel_custom:OnCreated(table)

self.ability = self:GetAbility()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.ms_slow = self.ability:GetSpecialValueFor( "slow_movement_speed" ) + self.caster:GetTalentValue("modifier_sniper_shrapnel_1", "slow")

self.silence_max = self.caster:GetTalentValue("modifier_sniper_shrapnel_5", "timer")
self.silence_slow = self.caster:GetTalentValue("modifier_sniper_shrapnel_5", "slow")

self.slow = self.caster:GetTalentValue("modifier_sniper_shrapnel_3", "slow")

self.legendary_damage = self.caster:GetTalentValue("modifier_sniper_shrapnel_7", "damage")
self.legendary_max = 3

self.particle_peffect = nil

if not IsServer() then return end

self.silence_timer = 0
self.interval_timer = 0
self.interval = 0.1

self:StartIntervalThink(self.interval)

if not self.caster:HasTalent("modifier_sniper_shrapnel_7") then return end
self:SetStackCount(1)
end


function modifier_sniper_shrapnel_custom:OnRefresh(table)
if not IsServer() then return end
if not self.caster:HasTalent("modifier_sniper_shrapnel_7") then return end

self:IncrementStackCount()

if self:GetStackCount() >= self.legendary_max then 
    self.parent:EmitSound("Sniper.Shrapnel_slow")
    if self.particle_peffect == nil then 
        self.particle_peffect = ParticleManager:CreateParticle("particles/general/generic_armor_reduction.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)   
        ParticleManager:SetParticleControl(self.particle_peffect, 0, self.parent:GetAbsOrigin())
        self:AddParticle(self.particle_peffect, false, false, -1, false, true)
    end
end 

end


function modifier_sniper_shrapnel_custom:OnStackCountChanged(iStackCount)
if not IsServer() then return end

if self:GetStackCount() < self.legendary_max then 
    if self.particle_peffect then 
        ParticleManager:DestroyParticle(self.particle_peffect, true)
        ParticleManager:ReleaseParticleIndex(self.particle_peffect)
        self.particle_peffect = nil
    end
end

end

function modifier_sniper_shrapnel_custom:GetModifierDamageOutgoing_Percentage()
if not self.caster:HasTalent("modifier_sniper_shrapnel_3") then return end
return self.slow
end

function modifier_sniper_shrapnel_custom:GetModifierAttackSpeedBonus_Constant()
if not self.caster:HasTalent("modifier_sniper_shrapnel_3") then return end
return self.slow
end

function modifier_sniper_shrapnel_custom:GetModifierMagicalResistanceBonus()
if not self.caster:HasTalent("modifier_sniper_shrapnel_7") then return end
return self.legendary_damage*self:GetStackCount()
end

function modifier_sniper_shrapnel_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
}
end

function modifier_sniper_shrapnel_custom:GetModifierMoveSpeedBonus_Percentage()
local k = 1
if self.parent:HasTalent("modifier_sniper_shrapnel_custom_silence") then 
    k = self.silence_slow
end
return self.ms_slow * k
end


function modifier_sniper_shrapnel_custom:OnIntervalThink()
if not IsServer() then return end

if self.parent:IsRealHero() and not self.caster:QuestCompleted() and self.caster:GetQuest() == "Sniper.Quest_5" then 
    self.caster:UpdateQuest(self.interval)
end

self.interval_timer = self.interval_timer + self.interval

if self.interval_timer >= 0.95 then 
    self.interval_timer = 0

    if self.caster:HasTalent("modifier_sniper_shrapnel_5") and not self.parent:HasModifier("modifier_sniper_shrapnel_custom_silence") then 
        self.silence_timer = self.silence_timer + 1
        if self.silence_timer >= self.silence_max then 
            self.silence_timer = 0
            self.parent:EmitSound("Sniper.Shrapnel_Silence")
            self.parent:AddNewModifier(self.caster, self.ability, "modifier_sniper_shrapnel_custom_silence", {duration = (1 - self.parent:GetStatusResistance())*self.caster:GetTalentValue("modifier_sniper_shrapnel_5", "silence")})
        end
    end
end

end



modifier_sniper_shrapnel_custom_damage = class({})

function modifier_sniper_shrapnel_custom_damage:IsHidden() return true end
function modifier_sniper_shrapnel_custom_damage:IsPurgable() return false end


function modifier_sniper_shrapnel_custom_damage:GetAttributes()
if not self:GetCaster():HasTalent("modifier_sniper_shrapnel_7") then return end
return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_sniper_shrapnel_custom_damage:OnCreated( kv )
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability:GetSpecialValueFor( "shrapnel_damage" )
self.damage_inc = self.caster:GetTalentValue("modifier_sniper_shrapnel_2", "damage")

self.speed_duration = self.caster:GetTalentValue("modifier_sniper_shrapnel_2", "duration", true)

local interval = 1
self.caster = self.ability:GetCaster()

if not IsServer() then return end

self.parent:AddNewModifier(self.caster, self.ability, "modifier_sniper_shrapnel_custom", {})

self.damageTable = { victim = self.parent, attacker = self.caster, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability,  }

self:StartIntervalThink( interval )
self:OnIntervalThink()
end


function modifier_sniper_shrapnel_custom_damage:OnDestroy()
if not IsServer() then return end
local mod = self.parent:FindModifierByName("modifier_sniper_shrapnel_custom")

if mod then 
    mod:DecrementStackCount()
    if mod:GetStackCount() == 0 then 
        mod:Destroy()
    end
end

end


function modifier_sniper_shrapnel_custom_damage:OnIntervalThink()
if not IsServer() then return end
local mod = self.caster:FindModifierByName("modifier_sniper_shrapnel_custom_damage_stack")

local damage = self.damage
if mod then 
    damage = damage + self.damage_inc*mod:GetStackCount()
end

self.damageTable.damage = damage
DoDamage(self.damageTable)

    
if self.caster:HasTalent("modifier_sniper_shrapnel_2") then
    self.caster:AddNewModifier(self.caster, self.ability, "modifier_sniper_shrapnel_custom_damage_stack", {duration = self.speed_duration})
end

end





modifier_sniper_shrapnel_custom_mine = class({})
function modifier_sniper_shrapnel_custom_mine:IsHidden() return true end
function modifier_sniper_shrapnel_custom_mine:IsPurgable() return false end
function modifier_sniper_shrapnel_custom_mine:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.health = self.caster:GetTalentValue("modifier_sniper_shrapnel_4", "attacks")
self.stun = self.caster:GetTalentValue("modifier_sniper_shrapnel_4", "stun")
self.damage = self.caster:GetTalentValue("modifier_sniper_shrapnel_4", "damage")/100
self.creeps = self.caster:GetTalentValue("modifier_sniper_shrapnel_4", "creeps")
self.radius = self.ability:GetSpecialValueFor( "radius" ) + self.caster:GetTalentValue("modifier_sniper_shrapnel_5", "radius")

self.damageTable = {attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

self.parent:EmitSound("Sniper.Shrapnel_mine_active")

self.parent:AddAttackEvent_inc(self)
self:StartIntervalThink(self.caster:GetTalentValue("modifier_sniper_shrapnel_4", "timer"))
end

function modifier_sniper_shrapnel_custom_mine:OnIntervalThink()
if not IsServer() then return end

local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf", PATTACH_CUSTOMORIGIN, nil )
ParticleManager:SetParticleControl( nFXIndex, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 1.0, 1.0, radius ) )
ParticleManager:SetParticleControl( nFXIndex, 2, Vector( 1.0, 1.0, radius ) )
ParticleManager:ReleaseParticleIndex( nFXIndex )

EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Sniper.Shrapnel_mine_explosion", self.caster)

local enemies = self.caster:FindTargets(self.radius, self.parent:GetAbsOrigin()) 

for _,enemy in pairs(enemies) do 
    enemy:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = (1 - enemy:GetStatusResistance())*self.stun})
    self.damageTable.victim = enemy
    self.damageTable.damage = enemy:GetMaxHealth()*self.damage

    if enemy:IsCreep() then
        self.damageTable.damage = self.creeps
    end
    local real_damage = DoDamage(self.damageTable, "modifier_sniper_shrapnel_4")
    enemy:SendNumber(4, real_damage)
end

self:Destroy()
end


function modifier_sniper_shrapnel_custom_mine:OnDestroy()
if not IsServer() then return end
self.parent:Kill(nil, nil)
end


function modifier_sniper_shrapnel_custom_mine:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
}
end

function modifier_sniper_shrapnel_custom_mine:AttackEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.target then return end

self.health = self.health - 1

if self.health < 1 then 
    self:Destroy()
else 
    self.parent:SetHealth(self.health)
end

end

function modifier_sniper_shrapnel_custom_mine:GetAbsoluteNoDamagePhysical()
return 1
end


function modifier_sniper_shrapnel_custom_mine:GetAbsoluteNoDamageMagical()
return 1
end

function modifier_sniper_shrapnel_custom_mine:GetAbsoluteNoDamagePure()
return 1
end

function modifier_sniper_shrapnel_custom_mine:CheckState()
return
{
    [MODIFIER_STATE_MAGIC_IMMUNE] = true,
    [MODIFIER_STATE_ROOTED] = true,
    [MODIFIER_STATE_DISARMED] = true,
    [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
}
end


modifier_sniper_shrapnel_custom_move_speed = class({})
function modifier_sniper_shrapnel_custom_move_speed:IsHidden() return false end
function modifier_sniper_shrapnel_custom_move_speed:IsPurgable() return false end
function modifier_sniper_shrapnel_custom_move_speed:GetTexture() return "buffs/aim_evasion" end

function modifier_sniper_shrapnel_custom_move_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sniper_shrapnel_custom_move_speed:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_sniper_shrapnel_custom_move_speed:OnCreated(table)
self.move = self:GetCaster():GetTalentValue("modifier_sniper_shrapnel_6", "move")
end

function modifier_sniper_shrapnel_custom_move_speed:CheckState()
return
{
    [MODIFIER_STATE_UNSLOWABLE] = true
}
end

function modifier_sniper_shrapnel_custom_move_speed:GetEffectName()
return "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf"
end

function modifier_sniper_shrapnel_custom_move_speed:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end





modifier_sniper_shrapnel_custom_damage_stack = class({})
function modifier_sniper_shrapnel_custom_damage_stack:IsHidden() return false end
function modifier_sniper_shrapnel_custom_damage_stack:GetTexture() return "buffs/acorn_range" end
function modifier_sniper_shrapnel_custom_damage_stack:IsPurgable() return false end
function modifier_sniper_shrapnel_custom_damage_stack:OnCreated(table)
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.caster:GetTalentValue("modifier_sniper_shrapnel_2", "max")
self.speed = self.caster:GetTalentValue("modifier_sniper_shrapnel_2", "speed")
self.damage = self.caster:GetTalentValue("modifier_sniper_shrapnel_2", "damage")

if not IsServer() then return end
self:AddStack()
end

function modifier_sniper_shrapnel_custom_damage_stack:OnRefresh(table)
if not IsServer() then return end
self:AddStack()
end


function modifier_sniper_shrapnel_custom_damage_stack:AddStack()
if not IsServer() then return end
if self.cd == true then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
self.cd = true
self:StartIntervalThink(0.95)
end


function modifier_sniper_shrapnel_custom_damage_stack:OnIntervalThink()
if not IsServer() then return end
self.cd = false
self:StartIntervalThink(-1)
end

function modifier_sniper_shrapnel_custom_damage_stack:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_sniper_shrapnel_custom_damage_stack:GetModifierAttackSpeedBonus_Constant()
return self.speed*self:GetStackCount()
end

function modifier_sniper_shrapnel_custom_damage_stack:OnTooltip()
return self.damage*self:GetStackCount()
end




modifier_sniper_shrapnel_custom_silence = class({})
function modifier_sniper_shrapnel_custom_silence:IsHidden() return true end
function modifier_sniper_shrapnel_custom_silence:IsPurgable() return true end
function modifier_sniper_shrapnel_custom_silence:CheckState() return {[MODIFIER_STATE_SILENCED] = true} end
function modifier_sniper_shrapnel_custom_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
function modifier_sniper_shrapnel_custom_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end


