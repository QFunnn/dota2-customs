--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_templar_assassin_meld_custom_buff", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_debuff", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_debuff_count", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_quest", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_tracker", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_toggle", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_heal", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_damage_reduce", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_agility", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_agility_cd", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_range", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_break", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_meld_custom_legendary", "abilities/templar_assasssin/templar_assassin_meld_custom", LUA_MODIFIER_MOTION_NONE )

templar_assassin_meld_custom = class({})

function templar_assassin_meld_custom:CreateTalent(name)
local caster = self:GetCaster()

if name == "modifier_templar_assassin_meld_4" then
    caster:RemoveModifierByName("modifier_templar_assassin_meld_custom_agility")
end

if name == "modifier_templar_assassin_meld_5" then
    self:ToggleAutoCast()
    caster:AddNewModifier(caster, self, "modifier_templar_assassin_meld_custom_toggle", {})
end

end


function templar_assassin_meld_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items3_fx/blink_arcane_start.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/blink_arcane_end.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_templar_assassin/templar_assassin_meld_attack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_templar_assassin/templar_assassin_meld.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_templar_assassin/templar_assassin_meld_armor.vpcf", context )
PrecacheResource( "particle","particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle","particles/general/generic_armor_reduction.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_juggernaut/jugg_agility_boost.vpcf", context )
PrecacheResource( "particle","particles/templar_assassin/meld_buff.vpcf", context )

end


function templar_assassin_meld_custom:GetCastRange(vLocation, hTarget)
local caster = self:GetCaster()
if caster:HasTalent("modifier_templar_assassin_meld_5") and caster:HasModifier("modifier_templar_assassin_meld_custom_toggle") then 
    if IsClient() then 
        return caster:GetTalentValue("modifier_templar_assassin_meld_5", "distance")
    else
        return 999999 
    end
end
return 0
end

function templar_assassin_meld_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_templar_assassin_meld_custom_tracker"
end

function templar_assassin_meld_custom:GetBehavior()
if self:GetCaster():HasTalent("modifier_templar_assassin_meld_5")  then 
    if not self:GetCaster():HasModifier("modifier_templar_assassin_meld_custom_toggle") then 
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + DOTA_ABILITY_BEHAVIOR_AUTOCAST + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    else 
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + DOTA_ABILITY_BEHAVIOR_AUTOCAST + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end


function templar_assassin_meld_custom:OnSpellStart()

local caster = self:GetCaster()
caster:RemoveModifierByName("modifier_templar_assassin_meld_custom_legendary")

if caster:HasTalent("modifier_templar_assassin_meld_5") then

    caster:Purge(false, true, false, false, false)

    if caster:HasModifier("modifier_templar_assassin_meld_custom_toggle") and not caster:IsRooted() and not caster:IsLeashed() then 

        ProjectileManager:ProjectileDodge(caster)

        local point = self:GetCursorPosition()
        local start_point = caster:GetAbsOrigin()

        local vec = (point - start_point)

        EmitSoundOnLocationWithCaster( start_point, "Hero_Antimage.Blink_out", caster )

        if point == start_point then 
            point = start_point + caster:GetForwardVector()*5
        end

        local distance = caster:GetTalentValue("modifier_templar_assassin_meld_5", "distance")

        if vec:Length2D() > distance then 
            point = vec:Normalized()*distance + caster:GetAbsOrigin()
        end

        local effect = ParticleManager:CreateParticle("particles/items3_fx/blink_arcane_start.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(effect, 0, start_point)
        ParticleManager:ReleaseParticleIndex(effect)

        caster:GenericParticle("particles/items3_fx/blink_arcane_end.vpcf")

        caster:SetAbsOrigin(point)
        FindClearSpaceForUnit(caster, point, true)
    end
end

local duration = nil
if caster:HasTalent("modifier_templar_assassin_meld_7") then
    duration = caster:GetTalentValue("modifier_templar_assassin_meld_7", "duration")
else
    caster:Stop()
end

caster:AddNewModifier(caster, self, "modifier_templar_assassin_meld_custom_buff", {duration = duration})
caster:EmitSound("Hero_TemplarAssassin.Meld")
end




modifier_templar_assassin_meld_custom_buff = class({})
function modifier_templar_assassin_meld_custom_buff:IsPurgable() return false end

function modifier_templar_assassin_meld_custom_buff:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.legendary_move = self.parent:GetTalentValue("modifier_templar_assassin_meld_7", "move", true)
self.max_time = self.parent:GetTalentValue("modifier_templar_assassin_meld_7", "duration", true)
self.legendary_max = self.parent:GetTalentValue("modifier_templar_assassin_meld_7", "duration_max", true)
self.legendary_min = self.parent:GetTalentValue("modifier_templar_assassin_meld_7", "duration_min", true)

if not IsServer() then return end

self.ability:EndCd()

self.cancel_commands = 
{
    [DOTA_UNIT_ORDER_CAST_POSITION]    = true,
    [DOTA_UNIT_ORDER_CAST_TARGET]       = true,
    [DOTA_UNIT_ORDER_CAST_NO_TARGET]     = true,
    [DOTA_UNIT_ORDER_CAST_TOGGLE]     = true,
    [DOTA_UNIT_ORDER_MOVE_ITEM]       = true,
}

self.abs = self.parent:GetAbsOrigin()
self.record = nil
self.attacked = false

self.interval = FrameTime()
if self.parent:HasTalent("modifier_templar_assassin_meld_7") then
    self.interval = 0.1
end

self.parent:AddRecordDestroyEvent(self)
self.parent:AddOrderEvent(self)

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end


function modifier_templar_assassin_meld_custom_buff:OnRefresh()
self:OnCreated()
end


function modifier_templar_assassin_meld_custom_buff:OnDestroy()
if not IsServer() then return end

self.ability:StartCd()

if self.parent:GetQuest() == "Templar.Quest_6" then 
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_custom_quest", {duration = self.parent.quest.number})
end

if self.parent:HasTalent("modifier_templar_assassin_meld_5") then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_custom_range", {duration = self.parent:GetTalentValue("modifier_templar_assassin_meld_5", "duration")})
end


if self.parent:HasTalent("modifier_templar_assassin_meld_7") then
    local duration = self.legendary_min + (self.legendary_max - self.legendary_min)*(self:GetElapsedTime()/self.max_time)
    local mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_custom_legendary", {duration = duration})

    if not mod then
        self.parent:UpdateUIshort({hide = 1, style = "TemplarMeld"})
    end
end

if self.attacked == true then return end
self.parent:EmitSound("Hero_TemplarAssassin.Meld.Move")
end


function modifier_templar_assassin_meld_custom_buff:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end


function modifier_templar_assassin_meld_custom_buff:GetModifierMoveSpeedBonus_Percentage()
if not self.parent:HasTalent("modifier_templar_assassin_meld_7") then return end
return self.legendary_move
end

function modifier_templar_assassin_meld_custom_buff:GetActivityTranslationModifiers()
if self.attacked then return end
return "meld"
end


function modifier_templar_assassin_meld_custom_buff:ProcAttack(params)
if self.attacked then return end

self.attacked = true
self.record = params.record

if self.parent:HasTalent("modifier_templar_assassin_meld_2") then 
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_custom_heal", {duration = self.parent:GetTalentValue("modifier_templar_assassin_meld_2", "duration")})
end 

self:Destroy()
end


function modifier_templar_assassin_meld_custom_buff:OrderEvent(params)
if not IsServer() then return end
if params.ability and params.ability:GetAbilityName() == "templar_assassin_trap_teleport_custom" then return end
if not self.cancel_commands[params.order_type] then return end
 
self:Destroy()
end


function modifier_templar_assassin_meld_custom_buff:OnIntervalThink()
if not IsServer() then return end

if self.parent:HasTalent("modifier_templar_assassin_meld_7") then 
    self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetElapsedTime(), stack = self:GetElapsedTime(), priority = 1, use_zero = 1, style = "TemplarMeld"})
    return 
end
if self.parent:GetAbsOrigin() == self.abs then return end
if self.attacked then return end   

self:Destroy()
end


function modifier_templar_assassin_meld_custom_buff:RecordDestroyEvent(params)
if not IsServer() then return end
if not self.record then return end
if params.record ~= self.record then return end

self:Destroy()
end


function modifier_templar_assassin_meld_custom_buff:GetEffectName()
return "particles/units/heroes/hero_templar_assassin/templar_assassin_meld.vpcf"
end

function modifier_templar_assassin_meld_custom_buff:GetModifierInvisibilityLevel()
return 1
end

function modifier_templar_assassin_meld_custom_buff:CheckState()
return 
{
    [MODIFIER_STATE_INVISIBLE] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end





modifier_templar_assassin_meld_custom_tracker = class({})
function modifier_templar_assassin_meld_custom_tracker:IsHidden() return true end
function modifier_templar_assassin_meld_custom_tracker:IsPurgable() return false end
function modifier_templar_assassin_meld_custom_tracker:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_templar_assassin_meld_custom_tracker:GetModifierBonusStats_Agility()
if not self.parent:HasTalent("modifier_templar_assassin_meld_1") then return end
return self.parent:GetTalentValue("modifier_templar_assassin_meld_1", "agility")
end

function modifier_templar_assassin_meld_custom_tracker:GetModifierHealthBonus()
if not self.parent:HasTalent("modifier_templar_assassin_meld_2") then return end
return self.parent:GetTalentValue("modifier_templar_assassin_meld_2", "health")*self.parent:GetAgility()
end

function modifier_templar_assassin_meld_custom_tracker:GetModifierAttackRangeBonus()
if not self.parent:HasTalent("modifier_templar_assassin_meld_5") then return end
if not self.parent:HasModifier("modifier_templar_assassin_meld_custom_range") and not self.parent:HasModifier("modifier_templar_assassin_meld_custom_buff") then return end
return self.range_bonus
end

function modifier_templar_assassin_meld_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.duration = self.ability:GetSpecialValueFor("duration")

self.damage_reduce_duration = self.parent:GetTalentValue("modifier_templar_assassin_meld_3", "duration", true)

self.agility_timer = self.parent:GetTalentValue("modifier_templar_assassin_meld_4", "timer", true)
self.agility_duration = self.parent:GetTalentValue("modifier_templar_assassin_meld_4", "duration", true)

self.range_bonus = self.parent:GetTalentValue("modifier_templar_assassin_meld_5", "range", true)

self.attack_cd = self.parent:GetTalentValue("modifier_templar_assassin_meld_6", "cd", true)
self.attack_stun = self.parent:GetTalentValue("modifier_templar_assassin_meld_6", "stun", true)
self.attack_health = self.parent:GetTalentValue("modifier_templar_assassin_meld_6", "health", true)
self.attack_break = self.parent:GetTalentValue("modifier_templar_assassin_meld_6", "break_duration", true)

self.legendary_chance = self.parent:GetTalentValue("modifier_templar_assassin_meld_7", "chance", true)
self.legendary_attacks = self.parent:GetTalentValue("modifier_templar_assassin_meld_7", "attacks", true)

self.parent:AddRecordDestroyEvent(self)
self.parent:AddAttackStartEvent_out(self)
self.parent:AddAttackEvent_out(self)
self.records = {}

if not IsServer() then return end
self:StartIntervalThink(1)
end


function modifier_templar_assassin_meld_custom_tracker:OnIntervalThink()
if not IsServer() then return end

if not self.ability:IsActivated() and not self.parent:HasModifier("modifier_templar_assassin_meld_custom_buff") then
    self.ability:StartCd()
end

if not self.parent:IsAlive() then return end
if not self.parent:HasTalent("modifier_templar_assassin_meld_4") then return end
if self.parent:HasModifier("modifier_templar_assassin_meld_custom_agility_cd") then return end
if self.parent:HasModifier("modifier_templar_assassin_meld_custom_agility") then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_custom_agility", {})
self:StartIntervalThink(0.2)
end


function modifier_templar_assassin_meld_custom_tracker:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

local mod = self.parent:FindModifierByName("modifier_templar_assassin_meld_custom_buff")
local proc = false
local type = 0

if mod and mod.attacked == false and not params.no_attack_cooldown then
    proc = true
    mod:ProcAttack(params)
end

local legendary_mod = self.parent:FindModifierByName("modifier_templar_assassin_meld_custom_legendary")

if legendary_mod and legendary_mod.count and not proc then
    legendary_mod.count = legendary_mod.count + 1
    if legendary_mod.count >= self.legendary_attacks then
        legendary_mod.count = 0
        type = 1
        proc = true
    end
end

if not proc then return end

local projectile =
{
    Target = params.target,
    Source = self.parent,
    Ability = self.ability,
    EffectName = "particles/units/heroes/hero_templar_assassin/templar_assassin_meld_attack.vpcf",
    iMoveSpeed = self.parent:GetProjectileSpeed()*1.1,
    vSourceLoc = self.parent:GetAbsOrigin(),
    bDodgeable = true,
    bProvidesVision = false,
}

self.records[params.record] = type
ProjectileManager:CreateTrackingProjectile( projectile )
end


function modifier_templar_assassin_meld_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

if self.parent:HasTalent("modifier_templar_assassin_meld_4") then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_custom_agility_cd", {duration = self.agility_timer})

    local mod = self.parent:FindModifierByName("modifier_templar_assassin_meld_custom_agility")
    if mod and mod.activated == false then
        mod.activated = true
        mod:SetDuration(self.agility_duration, true)
    end
end

if self.parent:HasTalent("modifier_templar_assassin_meld_6") then
    self.parent:CdAbility(self.ability, self.attack_cd)
end

if not self.records[params.record] then return end

local type = self.records[params.record]

self.records[params.record] = nil

local target = params.target
if not target:IsUnit() then return end

local damage = self.ability:GetSpecialValueFor("bonus_damage") + self.parent:GetTalentValue("modifier_templar_assassin_meld_4", "damage")*self.parent:GetAgility()/100

target:EmitSound("Hero_TemplarAssassin.Meld.Attack")

if self.parent:HasTalent("modifier_templar_assassin_meld_3") then
    target:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_custom_damage_reduce", {duration = self.damage_reduce_duration})
end

if self.parent:HasTalent("modifier_templar_assassin_meld_6") and type == 0 then
    target:EmitSound("TA.Meld_stun")
    target:AddNewModifier(self.parent, self.ability, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.attack_stun})

    if target:GetHealthPercent() <= self.attack_health then
        target:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_custom_break", {duration = (1 - target:GetStatusResistance())*self.attack_break})
    end
end

target:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_custom_debuff", { duration = self.duration})
target:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_custom_debuff_count", { duration = self.duration})
SendOverheadEventMessage(nil, OVERHEAD_ALERT_CRITICAL, target, damage, nil)
DoDamage({victim = target, attacker = self.parent, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self.ability})
end


function modifier_templar_assassin_meld_custom_tracker:RecordDestroyEvent(params)
if not IsServer() then return end
if not self.records[params.record] then return end

self.records[params.record] = nil
end




modifier_templar_assassin_meld_custom_debuff = class({})
function modifier_templar_assassin_meld_custom_debuff:IsPurgable() return false end
function modifier_templar_assassin_meld_custom_debuff:OnCreated(table)

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.armor = self.ability:GetSpecialValueFor("bonus_armor") + self.caster:GetTalentValue("modifier_templar_assassin_meld_1", "armor")

if not IsServer() then return end

self:SetStackCount(1)

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_templar_assassin/templar_assassin_meld_armor.vpcf", PATTACH_POINT_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle, false, false, -1, false, false)
end


function modifier_templar_assassin_meld_custom_debuff:OnRefresh()
if not IsServer() then return end
self:IncrementStackCount()
end


function modifier_templar_assassin_meld_custom_debuff:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_templar_assassin_meld_custom_debuff:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()
end




modifier_templar_assassin_meld_custom_debuff_count = class({})
function modifier_templar_assassin_meld_custom_debuff_count:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_templar_assassin_meld_custom_debuff_count:IsPurgable() return false end
function modifier_templar_assassin_meld_custom_debuff_count:IsHidden() return true end
function modifier_templar_assassin_meld_custom_debuff_count:OnDestroy()
if not IsServer() then return end

local mod = self:GetParent():FindModifierByName("modifier_templar_assassin_meld_custom_debuff")

if mod then
    mod:DecrementStackCount()
    if mod:GetStackCount() <= 0 then
        mod:Destroy()
    end
end

end







modifier_templar_assassin_meld_custom_quest = class({})
function modifier_templar_assassin_meld_custom_quest:IsHidden() return true end
function modifier_templar_assassin_meld_custom_quest:IsPurgable() return false end


modifier_templar_assassin_meld_custom_toggle = class({})
function modifier_templar_assassin_meld_custom_toggle:IsHidden() return true end
function modifier_templar_assassin_meld_custom_toggle:IsPurgable() return false end
function modifier_templar_assassin_meld_custom_toggle:RemoveOnDeath() return false end


modifier_templar_assassin_meld_custom_heal = class({})

function modifier_templar_assassin_meld_custom_heal:IsPurgable() return false end
function modifier_templar_assassin_meld_custom_heal:GetTexture() return "buffs/Crit_blood" end
function modifier_templar_assassin_meld_custom_heal:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddDamageEvent_out(self)
self.heal = self.parent:GetTalentValue("modifier_templar_assassin_meld_2", "heal")
self.creeps = self.parent:GetTalentValue("modifier_templar_assassin_meld_2", "creeps")
end 

function modifier_templar_assassin_meld_custom_heal:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:CheckLifesteal(params) then return end

local heal = self.heal/100
if params.unit:IsCreep() then 
  heal = heal / self.creeps
end

heal = heal*params.damage
self.parent:GenericHeal(heal, self.ability, true, nil, "modifier_templar_assassin_meld_2")
end



modifier_templar_assassin_meld_custom_damage_reduce = class({})
function modifier_templar_assassin_meld_custom_damage_reduce:IsHidden() return true end
function modifier_templar_assassin_meld_custom_damage_reduce:IsPurgable() return false end
function modifier_templar_assassin_meld_custom_damage_reduce:OnCreated()

self.caster = self:GetCaster()

self.heal_reduce = self.caster:GetTalentValue("modifier_templar_assassin_meld_3", "heal_reduce")
self.damage_reduce = self.caster:GetTalentValue("modifier_templar_assassin_meld_3", "damage_reduce")
end 

function modifier_templar_assassin_meld_custom_damage_reduce:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_templar_assassin_meld_custom_damage_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_templar_assassin_meld_custom_damage_reduce:GetModifierHealChange() 
return self.heal_reduce
end

function modifier_templar_assassin_meld_custom_damage_reduce:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce
end

function modifier_templar_assassin_meld_custom_damage_reduce:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end

function modifier_templar_assassin_meld_custom_damage_reduce:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end


modifier_templar_assassin_meld_custom_agility = class({})
function modifier_templar_assassin_meld_custom_agility:IsHidden() return false end
function modifier_templar_assassin_meld_custom_agility:IsPurgable() return false end
function modifier_templar_assassin_meld_custom_agility:GetTexture() return "buffs/Blade_dance_speed" end
function modifier_templar_assassin_meld_custom_agility:OnCreated()
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_templar_assassin_meld_4", "max")
self.agility = self.parent:GetTalentValue("modifier_templar_assassin_meld_4", "agility")/100
self.activated = false

if not IsServer() then return end

self.parent:GenericParticle("particles/units/heroes/hero_juggernaut/jugg_agility_boost.vpcf", self)
self:SetStackCount(1)
self:StartIntervalThink(1)
end


function modifier_templar_assassin_meld_custom_agility:OnIntervalThink()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
if self.parent:HasModifier("modifier_templar_assassin_meld_custom_agility_cd") then return end
if self.activated == true then return end

self:IncrementStackCount()
end


function modifier_templar_assassin_meld_custom_agility:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.parent:AddPercentStat({agi = self:GetStackCount()*self.agility}, self)
end


function modifier_templar_assassin_meld_custom_agility:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_templar_assassin_meld_custom_agility:OnTooltip()
return self:GetStackCount()*self.agility*100
end


modifier_templar_assassin_meld_custom_agility_cd = class({})
function modifier_templar_assassin_meld_custom_agility_cd:IsHidden() return true end
function modifier_templar_assassin_meld_custom_agility_cd:IsPurgable() return false end


modifier_templar_assassin_meld_custom_range = class({})
function modifier_templar_assassin_meld_custom_range:IsHidden() return true end
function modifier_templar_assassin_meld_custom_range:IsPurgable() return false end





modifier_templar_assassin_meld_custom_break = class({})
function modifier_templar_assassin_meld_custom_break:IsHidden() return true end
function modifier_templar_assassin_meld_custom_break:IsPurgable() return false end
function modifier_templar_assassin_meld_custom_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_templar_assassin_meld_custom_break:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end


function modifier_templar_assassin_meld_custom_break:OnCreated(table)
self.parent = self:GetParent()
if not IsServer() then return end
self.parent:EmitSound("DOTA_Item.SilverEdge.Target")
self.parent:GenericParticle("particles/generic_gameplay/generic_break.vpcf", self, true)
end



modifier_templar_assassin_meld_custom_legendary = class({})
function modifier_templar_assassin_meld_custom_legendary:IsHidden() return true end
function modifier_templar_assassin_meld_custom_legendary:IsPurgable() return false end
function modifier_templar_assassin_meld_custom_legendary:GetEffectName() return "particles/templar_assassin/meld_buff.vpcf" end
function modifier_templar_assassin_meld_custom_legendary:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.count = 0
self.max_time = self.parent:GetTalentValue("modifier_templar_assassin_meld_7", "duration_max", true)

if not IsServer() then return end
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end


function modifier_templar_assassin_meld_custom_legendary:OnIntervalThink()
if not IsServer() then return end
self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self:GetRemainingTime(), active = 1, priority = 1, use_zero = 1, style = "TemplarMeld"})
end

function modifier_templar_assassin_meld_custom_legendary:OnDestroy()
if not IsServer() then return end

self.parent:UpdateUIshort({hide = 1, style = "TemplarMeld"})
end