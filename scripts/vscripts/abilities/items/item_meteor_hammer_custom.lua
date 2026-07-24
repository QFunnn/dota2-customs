--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_meteor_hammer_custom_burn", "abilities/items/item_meteor_hammer_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_meteor_hammer_custom_stats", "abilities/items/item_meteor_hammer_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_meteor_hammer_custom_cast", "abilities/items/item_meteor_hammer_custom", LUA_MODIFIER_MOTION_NONE)


item_meteor_hammer_custom                 = class({})
modifier_item_meteor_hammer_custom_burn   = class({})

function item_meteor_hammer_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items4_fx/meteor_hammer_aoe.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/meteor_hammer_cast.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/meteor_hammer_spell.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/meteor_hammer_spell_debuff.vpcf", context )
end

function item_meteor_hammer_custom:GetIntrinsicModifierName()
return "modifier_item_meteor_hammer_custom_stats"
end

function item_meteor_hammer_custom:GetAOERadius()
    return self:GetSpecialValueFor("impact_radius")
end

function item_meteor_hammer_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "item_meteor_hammer", self)
end

function item_meteor_hammer_custom:GetChannelTime() return self:GetSpecialValueFor("max_duration")
end
 

function item_meteor_hammer_custom:OnSpellStart()
self.caster     = self:GetCaster()


self.burn_duration              =   self:GetSpecialValueFor("burn_duration")
self.burn_interval              =   self:GetSpecialValueFor("burn_interval")
self.land_time                  =   self:GetSpecialValueFor("land_time")
self.impact_radius              =   self:GetSpecialValueFor("impact_radius")

if not IsServer() then return end

self.caster:AddNewModifier(self.caster, self, "modifier_item_meteor_hammer_custom_cast", {duration = self:GetSpecialValueFor("max_duration")})

local position  = self:GetCursorPosition()

-- Play the channel sound
self.caster:EmitSound("DOTA_Item.MeteorHammer.Channel")

AddFOWViewer(self.caster:GetTeam(), position, self.impact_radius, 3.8, false)

-- Impact location particles
self.particle   = ParticleManager:CreateParticle("particles/items4_fx/meteor_hammer_aoe.vpcf", PATTACH_WORLDORIGIN, self.caster)
ParticleManager:SetParticleControl(self.particle, 0, position)
ParticleManager:SetParticleControl(self.particle, 1, Vector(self.impact_radius, 1, 1))

self.particle2  = ParticleManager:CreateParticle("particles/items4_fx/meteor_hammer_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)

self.caster:StartGesture(ACT_DOTA_GENERIC_CHANNEL_1)
end

function item_meteor_hammer_custom:OnChannelFinish(bInterrupted)
if not IsServer() then return end

self.caster:RemoveModifierByName("modifier_item_meteor_hammer_custom_cast")

self.position = self:GetCursorPosition()

self.caster:FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)

if bInterrupted then
    self.caster:StopSound("DOTA_Item.MeteorHammer.Channel")

    ParticleManager:DestroyParticle(self.particle, true)
    ParticleManager:DestroyParticle(self.particle2, true)
else
    self.caster:EmitSound("DOTA_Item.MeteorHammer.Cast")

    self.particle3  = ParticleManager:CreateParticle("particles/items4_fx/meteor_hammer_spell.vpcf", PATTACH_WORLDORIGIN, self.caster)
    ParticleManager:SetParticleControl(self.particle3, 0, self.position + Vector(0, 0, 1000)) -- 1000 feels kinda arbitrary but it also feels correct
    ParticleManager:SetParticleControl(self.particle3, 1, self.position)
    ParticleManager:SetParticleControl(self.particle3, 2, Vector(self.land_time, 0, 0))
    ParticleManager:ReleaseParticleIndex(self.particle3)
    
    Timers:CreateTimer(self.land_time, function()
        if not self:IsNull() then
            GridNav:DestroyTreesAroundPoint(self.position, self.impact_radius, true)
        
            EmitSoundOnLocationWithCaster(self.position, "DOTA_Item.MeteorHammer.Impact", self.caster)
        
            local damage = self:GetSpecialValueFor("impact_damage_units")
            local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), self.position, nil, self.impact_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO , DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
            
            local damage_table = {
                damage          = damage,
                damage_type     = DAMAGE_TYPE_MAGICAL,
                attacker        = self.caster,
                ability         = self
            }

            for _, enemy in pairs(enemies) do
                enemy:EmitSound("DOTA_Item.MeteorHammer.Damage")
            
                enemy:AddNewModifier(self.caster, self, "modifier_item_meteor_hammer_custom_burn", {duration = self.burn_duration + FrameTime()})
                enemy:AddNewModifier(self.caster, self, "modifier_stunned", {duration = self:GetSpecialValueFor("stun_duration")*(1 - enemy:GetStatusResistance())})
                                
                damage_table.victim = enemy
                DoDamage(damage_table)
            end
        end
    end)
end

ParticleManager:ReleaseParticleIndex(self.particle)
ParticleManager:ReleaseParticleIndex(self.particle2)
end







modifier_item_meteor_hammer_custom_burn   = class({})

function modifier_item_meteor_hammer_custom_burn:IsPurgable() return true end
function modifier_item_meteor_hammer_custom_burn:IsHidden() return false end

function modifier_item_meteor_hammer_custom_burn:GetEffectName()
    return "particles/items4_fx/meteor_hammer_spell_debuff.vpcf"
end

function modifier_item_meteor_hammer_custom_burn:IgnoreTenacity()
    return true
end


function modifier_item_meteor_hammer_custom_burn:OnCreated()
if not self:GetAbility() then return end

self.slow = self:GetAbility():GetSpecialValueFor("movespeed_slow")
if not IsServer() then return end 


self.ability    = self:GetAbility()
self.caster     = self:GetCaster()
self.parent     = self:GetParent()

self.inc_damage = self:GetAbility():GetSpecialValueFor("burn_dps_units")
self.burn_interval = self:GetAbility():GetSpecialValueFor("burn_interval")

self.damage_table = {
    victim          = self.parent,
    damage          = self.inc_damage*self.burn_interval,
    damage_type     = DAMAGE_TYPE_MAGICAL,
    attacker        = self.caster,
    ability         = self.ability
}
   
self:StartIntervalThink(self.burn_interval)
end


function modifier_item_meteor_hammer_custom_burn:OnIntervalThink()
if not IsServer() then return end
local damage = DoDamage(self.damage_table)
self.parent:SendNumber(4, damage)
end





function modifier_item_meteor_hammer_custom_burn:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_item_meteor_hammer_custom_burn:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end






modifier_item_meteor_hammer_custom_stats = class({})
function modifier_item_meteor_hammer_custom_stats:IsHidden() return true end
function modifier_item_meteor_hammer_custom_stats:IsPurgable() return false end
function modifier_item_meteor_hammer_custom_stats:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_HEALTH_BONUS,
}
end


function modifier_item_meteor_hammer_custom_stats:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.agi = self.ability:GetSpecialValueFor("stats_agi")
self.str = self.ability:GetSpecialValueFor("stats_str")
self.int = self.ability:GetSpecialValueFor("stats_int")
self.amp = self.ability:GetSpecialValueFor("spell_amp")
self.regen = self.ability:GetSpecialValueFor("mana_regen_multiplier")
self.health_bonus = self.ability:GetSpecialValueFor("health_bonus")/100
end 


function modifier_item_meteor_hammer_custom_stats:GetModifierBonusStats_Agility () return self.agi end
function modifier_item_meteor_hammer_custom_stats:GetModifierBonusStats_Strength() return self.str end
function modifier_item_meteor_hammer_custom_stats:GetModifierBonusStats_Intellect() return self.int end

function modifier_item_meteor_hammer_custom_stats:GetModifierSpellAmplify_Percentage() 
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_starforge_seal_custom_stats") then return end 
return self.amp 
end

function modifier_item_meteor_hammer_custom_stats:GetModifierMPRegenAmplify_Percentage()
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end  
if self.parent:HasModifier("modifier_item_starforge_seal_custom_stats") then return end 
return self.regen
end

function modifier_item_meteor_hammer_custom_stats:GetModifierHealthBonus()
if self.parent:HasModifier("modifier_item_starforge_seal_custom_stats") then return end 
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end 
return self.health_bonus*self.parent:GetMaxMana()
end


modifier_item_meteor_hammer_custom_cast = class({})
function modifier_item_meteor_hammer_custom_cast:IsHidden() return false end
function modifier_item_meteor_hammer_custom_cast:IsPurgable() return false end