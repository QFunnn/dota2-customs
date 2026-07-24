--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_starforge_seal_custom_burn", "abilities/items/item_starforge_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_starforge_seal_custom_stats", "abilities/items/item_starforge_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_starforge_seal_custom_aura", "abilities/items/item_starforge_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_starforge_seal_custom_stun", "abilities/items/item_starforge_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_starforge_seal_custom_thinker", "abilities/items/item_starforge_seal_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_starforge_seal_custom_leash", "abilities/items/item_starforge_seal_custom", LUA_MODIFIER_MOTION_NONE)


item_starforge_seal_custom = class({})

function item_starforge_seal_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items/devastator_aoe.vpcf", context )
PrecacheResource( "particle","particles/items/devastator/devastator_blast.vpcf", context )
PrecacheResource( "particle","particles/items/devastator/devastator_impact.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/meteor_hammer_spell_debuff.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_stunned.vpcf", context )
end

function item_starforge_seal_custom:GetIntrinsicModifierName()
return "modifier_item_starforge_seal_custom_stats"
end

function item_starforge_seal_custom:GetAOERadius()
return self:GetSpecialValueFor("impact_radius")
end


function item_starforge_seal_custom:GetCooldown(iLevel)
local cd = self:GetSpecialValueFor("AbilityCooldown")
if not IsSoloMode() then
    cd = self:GetSpecialValueFor("cd_duo")
end
return cd
end


function item_starforge_seal_custom:OnSpellStart()
if not IsServer() then return end

local position = self:GetCursorPosition()

CreateModifierThinker(self:GetCaster(), self, "modifier_item_starforge_seal_custom_thinker", {duration = self:GetSpecialValueFor("max_duration"), damage_k = self.multicast_k or 1}, position, self:GetCaster():GetTeamNumber(), false)

end



modifier_item_starforge_seal_custom_thinker = class({})
function modifier_item_starforge_seal_custom_thinker:IsHidden() return true end
function modifier_item_starforge_seal_custom_thinker:IsPurgable() return false end
function modifier_item_starforge_seal_custom_thinker:OnCreated(table)
if not IsServer() then return end 

self.impact_radius =   self:GetAbility():GetSpecialValueFor("impact_radius")
self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.damage_k = table.damage_k

self.damage = self:GetAbility():GetSpecialValueFor("impact_damage_units")
self.burn_duration = self:GetAbility():GetSpecialValueFor("burn_duration")

AddFOWViewer(self.caster:GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.impact_radius*1.2, self:GetRemainingTime()*2, false)

self:GetParent():EmitSound("Devastator.Channel")
self:GetParent():EmitSound("Devastator.Channel2")

self.particle   = ParticleManager:CreateParticle("particles/items/devastator_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(self.impact_radius, 1, 1))
ParticleManager:SetParticleControl(self.particle, 2, Vector(self:GetRemainingTime() + 0.1, 1, 1))
self:AddParticle(self.particle, false, false, -1, false, false)

self:StartIntervalThink(self:GetRemainingTime() - self:GetAbility():GetSpecialValueFor("land_time"))
end


function modifier_item_starforge_seal_custom_thinker:OnIntervalThink()
if not IsServer() then return end 
self:GetParent():EmitSound("Devastator.Cast")
self:StartIntervalThink(-1)
end



function modifier_item_starforge_seal_custom_thinker:OnDestroy()
if not IsServer() then return end


self.position = self:GetParent():GetAbsOrigin()

self:GetParent():StopSound("Devastator.Channel")
self:GetParent():StopSound("Devastator.Channel2")

self.particle3  = ParticleManager:CreateParticle("particles/items/devastator/devastator_blast.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle3, 0, self.position)
ParticleManager:SetParticleControl(self.particle3, 1, Vector(self.impact_radius, 1, 1))
ParticleManager:ReleaseParticleIndex(self.particle3)

self.particle4  = ParticleManager:CreateParticle("particles/items/devastator/devastator_impact.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle4, 0, self.position)
ParticleManager:SetParticleControl(self.particle4, 3, self.position)
ParticleManager:SetParticleControl(self.particle4, 1, Vector(self.impact_radius, 1, 1))
ParticleManager:ReleaseParticleIndex(self.particle4)

GridNav:DestroyTreesAroundPoint(self.position, self.impact_radius, true)

EmitSoundOnLocationWithCaster(self.position, "Devastator.Impact", self.caster)
EmitSoundOnLocationWithCaster(self.position, "Devastator.Impact2", self.caster)

local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), self.position, nil, self.impact_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO , DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)


local damage_table = {
    damage          = self.damage*self.damage_k,
    damage_type     = DAMAGE_TYPE_MAGICAL,
    attacker        = self.caster,
    ability         = self.ability
}
       

for _, enemy in pairs(enemies) do
    damage_table.victim = enemy
    DoDamage(damage_table)
    enemy:RemoveModifierByName("modifier_item_starforge_seal_custom_burn")
    enemy:AddNewModifier(self.caster, self.ability, "modifier_item_starforge_seal_custom_burn", {duration = self.burn_duration + 2*FrameTime()})
    enemy:AddNewModifier(self.caster, self.ability, "modifier_item_starforge_seal_custom_stun", {radius = self.impact_radius, x = self.position.x, y = self.position.y, duration = self.stun_duration*(1 - enemy:GetStatusResistance())})                         
  
end

end 



modifier_item_starforge_seal_custom_burn   = class({})
function modifier_item_starforge_seal_custom_burn:IsPurgable() return true end
function modifier_item_starforge_seal_custom_burn:IsHidden() return false end
function modifier_item_starforge_seal_custom_burn:GetEffectName() return "particles/items4_fx/meteor_hammer_spell_debuff.vpcf" end
function modifier_item_starforge_seal_custom_burn:IgnoreTenacity() return true end
function modifier_item_starforge_seal_custom_burn:OnCreated()
if not self:GetAbility() then return end
self.ability    = self:GetAbility()
self.caster     = self:GetCaster()
self.parent     = self:GetParent()

self.slow = self.ability:GetSpecialValueFor("movespeed_slow")
if not IsServer() then return end 

self.inc_damage = self:GetAbility():GetSpecialValueFor("burn_dps_units")
self.burn_interval = self:GetAbility():GetSpecialValueFor("burn_interval")

self.damage_table = {victim = self.parent, damage = self.inc_damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = self.caster, ability = self.ability }

self:StartIntervalThink(self.burn_interval)
end

function modifier_item_starforge_seal_custom_burn:OnIntervalThink()
if not IsServer() then return end
local damage = DoDamage(self.damage_table)
self.parent:SendNumber(4, damage)
end

function modifier_item_starforge_seal_custom_burn:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_item_starforge_seal_custom_burn:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end





modifier_item_starforge_seal_custom_stun = class({})
function modifier_item_starforge_seal_custom_stun:IsHidden() return true end
function modifier_item_starforge_seal_custom_stun:IsPurgable() return false end
function modifier_item_starforge_seal_custom_stun:IsPurgeException() return true end
function modifier_item_starforge_seal_custom_stun:IsStunDebuff() return true end
function modifier_item_starforge_seal_custom_stun:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.leash_duration = self.ability:GetSpecialValueFor("leash_duration")

self.center = GetGroundPosition(Vector(table.x, table.y, 0), nil)

self.radius = table.radius

local vec = (self.parent:GetAbsOrigin() - self.center)
--local point = self.center + vec:Normalized()*(self.radius + 10) 

self.anim_time = 0.3

if not self.parent:IsCurrentlyVerticalMotionControlled() and not self.parent:IsCurrentlyHorizontalMotionControlled() then 

    self.mod = self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(),
    "modifier_knockback",
    {   
        center_x = self.center.x,
        center_y = self.center.y,
        center_z = self.center.z,
        knockback_distance = 0,--(point - self.parent:GetAbsOrigin()):Length2D(),
        knockback_height = 130, 
        duration = self.anim_time,
        knockback_duration = self.anim_time,
        should_stun = true,
    })

    self:GetParent():StartGesture(ACT_DOTA_FLAIL)

    self:StartIntervalThink(self.anim_time)
else 

    self:GetParent():StartGesture(ACT_DOTA_DISABLED)
end 

end


function modifier_item_starforge_seal_custom_stun:OnIntervalThink()
if not IsServer() then return end

self:GetParent():RemoveGesture(ACT_DOTA_FLAIL)
self:GetParent():StartGesture(ACT_DOTA_DISABLED)

self:StartIntervalThink(-1)
end

function modifier_item_starforge_seal_custom_stun:CheckState()
return
{
    [MODIFIER_STATE_STUNNED] = true
}
end


function modifier_item_starforge_seal_custom_stun:OnDestroy()
if not IsServer() then return end 

if self.mod and not self.mod:IsNull() then 
    self.mod:Destroy()
end 

self.parent:AddNewModifier(self.caster, self.ability, "modifier_item_starforge_seal_custom_leash", {duration = self.leash_duration*(1 - self.parent:GetStatusResistance())})

self:GetParent():FadeGesture(ACT_DOTA_DISABLED)
self:GetParent():RemoveGesture(ACT_DOTA_FLAIL)
end



function modifier_item_starforge_seal_custom_stun:GetEffectName()
return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_item_starforge_seal_custom_stun:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end



modifier_item_starforge_seal_custom_stats = class({})
function modifier_item_starforge_seal_custom_stats:IsHidden() return true end
function modifier_item_starforge_seal_custom_stats:IsPurgable() return false end
function modifier_item_starforge_seal_custom_stats:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_MANA_BONUS,
    MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
    MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_HEALTH_BONUS,
}
end


function modifier_item_starforge_seal_custom_stats:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.agi = self.ability:GetSpecialValueFor("stats_agi")
self.str = self.ability:GetSpecialValueFor("stats_str")
self.int = self.ability:GetSpecialValueFor("stats_int")
self.amp = self.ability:GetSpecialValueFor("spell_amp")
self.regen = self.ability:GetSpecialValueFor("mana_regen_multiplier")
self.mana_bonus = self.ability:GetSpecialValueFor("mana_bonus")
self.range_bonus = self.ability:GetSpecialValueFor("range_bonus")
self.health_bonus = self.ability:GetSpecialValueFor("health_bonus")/100
end 


function modifier_item_starforge_seal_custom_stats:GetModifierBonusStats_Agility () return self.agi end
function modifier_item_starforge_seal_custom_stats:GetModifierBonusStats_Strength() return self.str end
function modifier_item_starforge_seal_custom_stats:GetModifierBonusStats_Intellect() return self.int end
function modifier_item_starforge_seal_custom_stats:GetModifierManaBonus()
return self.mana_bonus
end

function modifier_item_starforge_seal_custom_stats:GetModifierHealthBonus()
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end 
return self.health_bonus*self.parent:GetMaxMana()
end

function modifier_item_starforge_seal_custom_stats:GetModifierCastRangeBonusStacking()
if self.parent:HasModifier("modifier_item_aether_lens") then return end
return self.range_bonus
end

function modifier_item_starforge_seal_custom_stats:GetModifierSpellAmplify_Percentage() 
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end 
return self.amp
end

function modifier_item_starforge_seal_custom_stats:GetModifierMPRegenAmplify_Percentage()
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end  
return self.regen
end


modifier_item_starforge_seal_custom_leash = class(mod_hidden)
function modifier_item_starforge_seal_custom_leash:IsPurgable() return true end
function modifier_item_starforge_seal_custom_leash:CheckState()
return
{
    [MODIFIER_STATE_TETHERED] = true
}
end