--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_frostbitten_spam_buff", "abilities/npc_frostbitten_spam.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_frostbitten_thinker", "abilities/npc_frostbitten_spam.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_frostbitten_spam", "abilities/npc_frostbitten_spam.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_frostbitten_spam_cd", "abilities/npc_frostbitten_spam.lua", LUA_MODIFIER_MOTION_NONE)

npc_frostbitten_spam = class({})

function npc_frostbitten_spam:OnSpellStart()
self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_4)
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_frostbitten_spam_cd", {duration = self:GetCooldownTimeRemaining()})
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_frostbitten_spam", {target = self:GetCursorTarget():entindex()})
end

function npc_frostbitten_spam:GetChannelTime() 
    return self:GetSpecialValueFor("duration") 
end
 

function npc_frostbitten_spam:OnChannelFinish(bInterrupted)
self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_4)
self:GetCaster():RemoveModifierByName("modifier_frostbitten_spam")
end 


modifier_frostbitten_spam = class ({})

function modifier_frostbitten_spam:IsHidden() return true end

function modifier_frostbitten_spam:IsPurgable() return false end


function modifier_frostbitten_spam:OnCreated(table)
if not IsServer() then return end
    self.target = EntIndexToHScript(table.target)
    self.interval = self:GetAbility():GetSpecialValueFor("interval")
    self:StartIntervalThink(self.interval)
    self:OnIntervalThink()
end

function modifier_frostbitten_spam:OnIntervalThink()
if not IsServer() then return end
if not self.target:IsAlive() then return end
if (self:GetCaster():GetAbsOrigin() - self.target:GetAbsOrigin()):Length2D() > self:GetAbility():GetSpecialValueFor("range") then return end

CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_frostbitten_thinker", {duration = self:GetAbility():GetSpecialValueFor("delay")}, self.target:GetAbsOrigin() + RandomVector(RandomInt(-1, 1) + RandomInt(100, 350)), self:GetCaster():GetTeamNumber(), false)
   
end




modifier_frostbitten_thinker = class({})

function modifier_frostbitten_thinker:IsHidden() return true end

function modifier_frostbitten_thinker:IsPurgable() return false end

function modifier_frostbitten_thinker:OnCreated(table)
if not IsServer() then return end

self.caster = self:GetCaster()

self.radius = self:GetAbility():GetSpecialValueFor("radius")

self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius) )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self:GetRemainingTime(), 0, 0 ) )
end


function modifier_frostbitten_thinker:OnDestroy(table)
if not IsServer() then return end
    
if self.effect_cast then
    ParticleManager:DestroyParticle( self.effect_cast, true )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

 local zap_pfx = ParticleManager:CreateParticle("particles/frostbitten_strike.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:SetParticleControlEnt(zap_pfx, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_staff", self.caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(zap_pfx, 1, self:GetParent():GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(zap_pfx)

self:GetCaster():EmitSound("UI.Ability_frost")  

local seed_particle = ParticleManager:CreateParticle("particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(seed_particle, 0, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl(seed_particle, 1, self:GetParent():GetAbsOrigin())
 ParticleManager:SetParticleControl(seed_particle, 2, self:GetParent():GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(seed_particle)

local  enemy_for_ability = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE , FIND_CLOSEST, false)
 for _,i in pairs(enemy_for_ability) do
     if not i:IsMagicImmune() then 

         i:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_frostbitten_spam_buff", {duration = self:GetAbility():GetSpecialValueFor("duration_slow")*(1 - i:GetStatusResistance())})
         DoDamage({ victim = i, attacker = self:GetAbility():GetCaster(), ability = self:GetAbility(), damage = self:GetAbility():GetSpecialValueFor("damage"), damage_type = DAMAGE_TYPE_MAGICAL})

     end

 end
   
end





modifier_frostbitten_spam_buff = class ({})

function modifier_frostbitten_spam_buff:IsPurgable() return true end
function modifier_frostbitten_spam_buff:IsHidden() return false end

function modifier_frostbitten_spam_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end


function modifier_frostbitten_spam_buff:OnCreated(table)
    self.slow = self:GetAbility():GetSpecialValueFor("slow")
    self.speed = self:GetAbility():GetSpecialValueFor("speed")
end

function modifier_frostbitten_spam_buff:GetModifierMoveSpeedBonus_Percentage() return -1*self.slow end
function modifier_frostbitten_spam_buff:GetModifierAttackSpeedBonus_Constant() return -1*self.speed end

function modifier_frostbitten_spam_buff:GetEffectName() return "particles/generic_gameplay/generic_slowed_cold.vpcf" end




modifier_frostbitten_spam_cd = class({})

function modifier_frostbitten_spam_cd:IsHidden() return false end
function modifier_frostbitten_spam_cd:IsPurgable() return false end