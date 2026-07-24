--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_alchemist_gold_khanda_burn", "abilities/items/item_alchemist_gold_khanda", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_khanda_stats", "abilities/items/item_alchemist_gold_khanda", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_khanda_stun", "abilities/items/item_alchemist_gold_khanda", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_khanda_thinker", "abilities/items/item_alchemist_gold_khanda", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_khanda_leash", "abilities/items/item_alchemist_gold_khanda", LUA_MODIFIER_MOTION_NONE)

item_alchemist_gold_khanda                 = class({})

function item_alchemist_gold_khanda:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/alchemist/gold_khanda_aoe.vpcf", context )
PrecacheResource( "particle","particles/alchemist/gold_khanda_blast.vpcf", context )
PrecacheResource( "particle","particles/alchemist/gold_khanda_impact.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/meteor_hammer_spell_debuff.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_stunned.vpcf", context )
PrecacheResource( "particle","particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_phylactery_v2_target.vpcf", context )
end


function item_alchemist_gold_khanda:GetIntrinsicModifierName()
return "modifier_item_alchemist_gold_khanda_stats"
end

function item_alchemist_gold_khanda:GetAOERadius()
return self:GetSpecialValueFor("impact_radius")
end


function item_alchemist_gold_khanda:OnSpellStart()
local caster = self:GetCaster()
local position = self:GetCursorPosition()

CreateModifierThinker(caster, self, "modifier_item_alchemist_gold_khanda_thinker", {duration = self:GetSpecialValueFor("max_duration")}, position, caster:GetTeamNumber(), false)
end



modifier_item_alchemist_gold_khanda_thinker = class(mod_hidden)
function modifier_item_alchemist_gold_khanda_thinker:OnCreated()
if not IsServer() then return end 

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.impact_radius = self.ability:GetSpecialValueFor("impact_radius")
self.stun_duration = self.ability:GetSpecialValueFor("stun_duration")

self.damage = self.ability:GetSpecialValueFor("impact_damage_units")
self.burn_duration = self.ability:GetSpecialValueFor("break_duration")

AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), self.impact_radius*1.2, self:GetRemainingTime()*2, false)

self.parent:EmitSound("Devastator.Channel")
self.parent:EmitSound("Devastator.Channel2")

self.particle   = ParticleManager:CreateParticle("particles/alchemist/gold_khanda_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(self.impact_radius, 1, 1))
ParticleManager:SetParticleControl(self.particle, 2, Vector(self:GetRemainingTime() + 0.1, 1, 1))
self:AddParticle(self.particle, false, false, -1, false, false)

self:StartIntervalThink(self:GetRemainingTime() - self.ability:GetSpecialValueFor("land_time"))
end


function modifier_item_alchemist_gold_khanda_thinker:OnIntervalThink()
if not IsServer() then return end 
self.parent:EmitSound("Devastator.Cast")
self:StartIntervalThink(-1)
end


function modifier_item_alchemist_gold_khanda_thinker:OnDestroy()
if not IsServer() then return end

self.position = self.parent:GetAbsOrigin()

self.parent:StopSound("Devastator.Channel")
self.parent:StopSound("Devastator.Channel2")

self.particle3  = ParticleManager:CreateParticle("particles/alchemist/gold_khanda_blast.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle3, 0, self.position)
ParticleManager:SetParticleControl(self.particle3, 1, Vector(self.impact_radius, 1, 1))
ParticleManager:ReleaseParticleIndex(self.particle3)

self.particle4  = ParticleManager:CreateParticle("particles/alchemist/gold_khanda_impact.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.particle4, 0, self.position)
ParticleManager:SetParticleControl(self.particle4, 3, self.position)
ParticleManager:SetParticleControl(self.particle4, 1, Vector(self.impact_radius, 1, 1))
ParticleManager:ReleaseParticleIndex(self.particle4)

GridNav:DestroyTreesAroundPoint(self.position, self.impact_radius, true)

EmitSoundOnLocationWithCaster(self.position, "Devastator.Impact", self.caster)
EmitSoundOnLocationWithCaster(self.position, "Devastator.Impact2", self.caster)

local damage_table = { damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = self.caster, ability  = self.ability}
       
for _, enemy in pairs(self.caster:FindTargets(self.impact_radius, self.position) ) do
    damage_table.victim = enemy
    DoDamage(damage_table)
    enemy:AddNewModifier(self.caster, self.ability, "modifier_item_alchemist_gold_khanda_burn", {duration = self.burn_duration*(1 - enemy:GetStatusResistance())})
    enemy:AddNewModifier(self.caster, self.ability, "modifier_item_alchemist_gold_khanda_stun", {radius = self.impact_radius, x = self.position.x, y = self.position.y, duration = self.stun_duration*(1 - enemy:GetStatusResistance())})                         
  
end

end 



modifier_item_alchemist_gold_khanda_burn   = class(mod_visible)
function modifier_item_alchemist_gold_khanda_burn:GetEffectName() return "particles/items4_fx/meteor_hammer_spell_debuff.vpcf" end
function modifier_item_alchemist_gold_khanda_burn:IgnoreTenacity() return true end
function modifier_item_alchemist_gold_khanda_burn:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_item_alchemist_gold_khanda_burn:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end
function modifier_item_alchemist_gold_khanda_burn:OnCreated()
if not self:GetAbility() then return end

self.ability = self:GetAbility()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.slow = self.ability:GetSpecialValueFor("movespeed_slow")

if not IsServer() then return end 

if self.parent:IsHero() then
    self.parent:EmitSound("DOTA_Item.SilverEdge.Target")
end

self.parent:GenericParticle("particles/generic_gameplay/generic_break.vpcf", self, true)

self.count = self.ability:GetSpecialValueFor("damage_count")
self.inc_damage = self.ability:GetSpecialValueFor("burn_dps_units")
self.burn_interval = self:GetRemainingTime()/self.count

self.damage_table = {victim = self.parent, damage = self.inc_damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker  = self.caster, ability  = self.ability }
self:StartIntervalThink(self.burn_interval - FrameTime())
end

function modifier_item_alchemist_gold_khanda_burn:OnIntervalThink()
if not IsServer() then return end
DoDamage(self.damage_table)
end

function modifier_item_alchemist_gold_khanda_burn:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_item_alchemist_gold_khanda_burn:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end




modifier_item_alchemist_gold_khanda_stun = class({})
function modifier_item_alchemist_gold_khanda_stun:IsHidden() return true end
function modifier_item_alchemist_gold_khanda_stun:IsPurgable() return false end
function modifier_item_alchemist_gold_khanda_stun:IsPurgeException() return true end
function modifier_item_alchemist_gold_khanda_stun:IsStunDebuff() return true end

function modifier_item_alchemist_gold_khanda_stun:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.leash_duration = self.ability:GetSpecialValueFor("leash_duration")

self.center = GetGroundPosition(Vector(table.x, table.y, 0), nil)

self.radius = table.radius

local vec = (self.parent:GetAbsOrigin() - self.center)

self.anim_time = 0.3

if not self.parent:IsCurrentlyVerticalMotionControlled() and not self.parent:IsCurrentlyHorizontalMotionControlled() then 

    self.mod = self.parent:AddNewModifier( self:GetCaster(), self:GetAbility(),
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

    self.parent:StartGesture(ACT_DOTA_FLAIL)

    self:StartIntervalThink(self.anim_time)
else 

    self.parent:StartGesture(ACT_DOTA_DISABLED)
end 

end


function modifier_item_alchemist_gold_khanda_stun:OnIntervalThink()
if not IsServer() then return end

self.parent:RemoveGesture(ACT_DOTA_FLAIL)
self.parent:StartGesture(ACT_DOTA_DISABLED)

self:StartIntervalThink(-1)
end

function modifier_item_alchemist_gold_khanda_stun:CheckState()
return
{
    [MODIFIER_STATE_STUNNED] = true
}
end


function modifier_item_alchemist_gold_khanda_stun:OnDestroy()
if not IsServer() then return end 

if self.mod and not self.mod:IsNull() then 
    self.mod:Destroy()
end 

self.parent:AddNewModifier(self.caster, self.ability, "modifier_item_alchemist_gold_khanda_leash", {duration = (1 - self.parent:GetStatusResistance())*self.leash_duration})

self.parent:FadeGesture(ACT_DOTA_DISABLED)
self.parent:RemoveGesture(ACT_DOTA_FLAIL)
end



function modifier_item_alchemist_gold_khanda_stun:GetEffectName()
return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_item_alchemist_gold_khanda_stun:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end



modifier_item_alchemist_gold_khanda_stats = class(mod_hidden)
function modifier_item_alchemist_gold_khanda_stats:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_MANA_BONUS,
    MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE 
}
end

function modifier_item_alchemist_gold_khanda_stats:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if self.parent:IsRealHero() then 
    self.parent:AddDamageEvent_out(self, true)
end 

self.mana = self.ability:GetSpecialValueFor("bonus_mana")
self.agi = self.ability:GetSpecialValueFor("stats_agi")
self.str = self.ability:GetSpecialValueFor("stats_str")
self.int = self.ability:GetSpecialValueFor("stats_int")
self.amp = self.ability:GetSpecialValueFor("spell_amp")
self.regen = self.ability:GetSpecialValueFor("mana_regen_multiplier")
self.range_bonus = self.ability:GetSpecialValueFor("range_bonus")
self.health_bonus = self.ability:GetSpecialValueFor("health_bonus")/100

self.min_damage = self.ability:GetSpecialValueFor("min_damage_to_activate")
self.crit_damage = self.ability:GetSpecialValueFor("crit_damage")/100
self.crit_chance = self.ability:GetSpecialValueFor("crit_chance")
self.crit_bonus = self.ability:GetSpecialValueFor("crit_bonus")
self.damageTable = {attacker = self.parent, ability = self.ability, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, custom_flag = CUSTOM_FLAG_GOLD_KHANDA}
end 

function modifier_item_alchemist_gold_khanda_stats:GetModifierManaBonus() return self.mana end
function modifier_item_alchemist_gold_khanda_stats:GetModifierBonusStats_Agility () return self.agi end
function modifier_item_alchemist_gold_khanda_stats:GetModifierBonusStats_Strength() return self.str end
function modifier_item_alchemist_gold_khanda_stats:GetModifierBonusStats_Intellect() return self.int end

function modifier_item_alchemist_gold_khanda_stats:GetModifierSpellAmplify_Percentage() 
if self.parent:HasModifier("modifier_item_starforge_seal_custom_stats") then return end 
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end
if self.parent:HasModifier("modifier_item_meteor_hammer_custom_stats") then return end  
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
return self.amp
end

function modifier_item_alchemist_gold_khanda_stats:GetModifierMPRegenAmplify_Percentage()
if self.parent:HasModifier("modifier_item_starforge_seal_custom_stats") then return end 
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end  
if self.parent:HasModifier("modifier_item_meteor_hammer_custom_stats") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
return self.regen
end

function modifier_item_alchemist_gold_khanda_stats:GetModifierHealthBonus()
if self.parent:HasModifier("modifier_item_starforge_seal_custom_stats") then return end 
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end  
if self.parent:HasModifier("modifier_item_meteor_hammer_custom_stats") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
return self.health_bonus*self.parent:GetMaxMana()
end

function modifier_item_alchemist_gold_khanda_stats:GetModifierCastRangeBonusStacking()
if self.parent:HasModifier("modifier_item_aether_lens") then return end
if self.parent:HasModifier("modifier_item_starforge_seal_custom_stats") then return end 
return self.range_bonus
end

function modifier_item_alchemist_gold_khanda_stats:DamageEvent_out(params)
if not IsServer() then return end
if self.parent:HasModifier("modifier_item_angels_demise_custom") then return end
if self.parent:HasModifier("modifier_item_phylactery_custom") then return end
if params.attacker ~= self.parent then return end
local unit = params.unit

if unit:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if not self.parent:IsRealHero() then return end
if not params.inflictor then return end
if params.custom_flag and params.custom_flag == CUSTOM_FLAG_GOLD_KHANDA then return end
if not self.parent:IsAlive() then return end
if params.original_damage < self.min_damage then return end

local chance = self.crit_chance + (unit:FindModifierByNameAndCaster("modifier_item_alchemist_gold_khanda_burn", self.parent) and self.crit_bonus or 0)
local index = params.original_damage > 150 and 5128 or 5129

if not RollPseudoRandomPercentage(chance, index, self.parent) then return end

local particle = ParticleManager:CreateParticle("particles/items/khanda_proc.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
ParticleManager:SetParticleControlEnt(particle, 0, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

if unit:IsHero() then
    unit:EmitSound("Item.Khanda_proc")
end

local damage = params.original_damage*self.crit_damage
self.damageTable.victim = unit
self.damageTable.damage = damage
self.damageTable.damage_type = params.damage_type
DoDamage(self.damageTable)

unit:SendNumber(24, damage)
end


modifier_item_alchemist_gold_khanda_leash = class(mod_hidden)
function modifier_item_alchemist_gold_khanda_leash:IsPurgable() return true end
function modifier_item_alchemist_gold_khanda_leash:CheckState()
return
{
    [MODIFIER_STATE_TETHERED] = true
}
end