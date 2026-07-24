--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_transform", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_transform_aura", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_fear_thinker", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_ring", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_fear_cd", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_slow", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_tracker", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_legendary_stack", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_terrorblade_demon_zeal_custom_buff", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_crit_attack", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_perma", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_portrait", "abilities/terrorblade/custom_terrorblade_metamorphosis", LUA_MODIFIER_MOTION_NONE)




custom_terrorblade_metamorphosis = class({})



function custom_terrorblade_metamorphosis:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "terrorblade_metamorphosis", self)
end


function custom_terrorblade_metamorphosis:CreateTalent()
local caster = self:GetCaster()
caster:RemoveModifierByName("modifier_custom_terrorblade_metamorphosis")
caster:RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_transform")
self:EndCd(0)
caster:AddNewModifier(caster, self, "modifier_custom_terrorblade_metamorphosis_legendary_stack", {})
local ability = caster:FindAbilityByName("terrorblade_demon_zeal_custom")
if ability then
    ability:SetHidden(false)
    ability:SetActivated(false)
end

end



function custom_terrorblade_metamorphosis:OnUpgrade()
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_custom_terrorblade_metamorphosis")
if mod then
    caster:AddNewModifier(caster, self, mod:GetName(), {duration = mod:GetRemainingTime()})
end

end

function custom_terrorblade_metamorphosis:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf", context )
PrecacheResource( "particle","particles/items_fx/phylactery_target.vpcf", context )
PrecacheResource( "particle","particles/items_fx/phylactery.vpcf", context )
PrecacheResource( "particle","particles/arc_warden/field_blink_start.vpcf", context )
PrecacheResource( "particle","particles/items_fx/blink_dagger_start.vpcf", context )
PrecacheResource( "particle","particles/items_fx/blink_dagger_end.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_scepter.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_vengeful/vengeful_swap_buff_overhead.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/eternal_shroud.vpcf", context )
PrecacheResource( "particle","particles/models/heroes/terrorblade/demon_zeal.vpcf", context )
PrecacheResource( "particle","particles/tb_aoe.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_manaburn.vpcf", context )

PrecacheResource( "model", "models/terrorblade_custom/demon.vmdl", context )

PrecacheResource( "particle","particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf", context )
PrecacheResource( "particle","particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_1.vpcf", context )

PrecacheResource( "particle","particles/terrorblade/meta_legendary_stack.vpcf", context )
PrecacheResource( "particle","particles/slark/essence_cleave.vpcf", context )
PrecacheResource( "particle","particles/enigma/summon_perma.vpcf", context )
PrecacheResource( "particle","particles/ogre_dd.vpcf", context )
end


function custom_terrorblade_metamorphosis:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_terrorblade_metamorphosis_tracker"
end

function custom_terrorblade_metamorphosis:GetManaCost(level)
if self:GetCaster():HasTalent("modifier_terror_meta_7") then 
	return 0
end
return self.BaseClass.GetManaCost(self,level)
end

function custom_terrorblade_metamorphosis:GetBehavior()
if self:GetCaster():HasTalent("modifier_terror_meta_7") then
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end
local bonus = 0
if self:GetCaster():HasTalent("modifier_terror_meta_5") then
    bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + bonus
end

function custom_terrorblade_metamorphosis:GetCooldown(iLevel)
local bonus = 0
if self:GetCaster():HasTalent("modifier_terror_meta_3") then
    bonus = self:GetCaster():GetTalentValue("modifier_terror_meta_3", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + bonus
end




function custom_terrorblade_metamorphosis:OnSpellStart()
local caster = self:GetCaster()
if caster:HasTalent("modifier_terror_meta_7") then return end

local delay = self:GetSpecialValueFor("transformation_time")
if caster:HasTalent("modifier_terror_meta_5") then
    caster:Purge(false, true, false, true, true)
    caster:AddNewModifier(caster, self, "modifier_generic_debuff_immune", {duration = caster:GetTalentValue("modifier_terror_meta_5", "duration") + delay, effect = 1})
    caster:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")
    caster:EmitSound("TB.Meta_stack")
end

caster:AddNewModifier(caster, self, "modifier_custom_terrorblade_metamorphosis_transform", {duration = delay})
end



modifier_custom_terrorblade_metamorphosis_transform = class({})
function modifier_custom_terrorblade_metamorphosis_transform:IsHidden()	return true end
function modifier_custom_terrorblade_metamorphosis_transform:IsPurgable() return false end

function modifier_custom_terrorblade_metamorphosis_transform:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.duration = self.ability:GetSpecialValueFor("duration") + self.parent:GetTalentValue("modifier_terror_meta_3", "duration")

local slark_mod = self.parent:FindModifierByName("modifier_slark_essence_shift_custom_legendary_steal")
if slark_mod then
    self.duration = slark_mod:GetRemainingTime()
end

if self.parent:IsIllusion() or self.parent:HasTalent("modifier_terror_meta_7") then
    self.duration = nil
end

self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_3)
self.parent:EmitSound("Hero_Terrorblade.Metamorphosis")

local transform_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
if self:GetCaster().current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
    local color = self:GetCaster():GetTerrorbladeColor()
    ParticleManager:SetParticleControl(transform_particle, 15, color)
    ParticleManager:SetParticleControl(transform_particle, 16, Vector(1,0,0))
end
ParticleManager:ReleaseParticleIndex(transform_particle)

if self.parent:IsRealHero() then
end

end

function modifier_custom_terrorblade_metamorphosis_transform:OnDestroy()
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if self:GetRemainingTime() > 0.1 then return end

self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_terrorblade_metamorphosis", {duration = self.duration})
end

function modifier_custom_terrorblade_metamorphosis_transform:CheckState()
return 
{
    [MODIFIER_STATE_STUNNED] = true
}
end


modifier_custom_terrorblade_metamorphosis = class({})
function modifier_custom_terrorblade_metamorphosis:IsPurgable() return false end
function modifier_custom_terrorblade_metamorphosis:IsHidden() return false end

function modifier_custom_terrorblade_metamorphosis:OnCreated(table)

self.parent = self:GetParent()
self.caster = self:GetCaster()
if self.caster.owner then
    self.caster = self.caster.owner
end

self.parent:AddRecordDestroyEvent(self)
self.parent:AddAttackRecordEvent_out(self)
self.ability = self:GetAbility()

self.RemoveForDuel = true

self.bonus_range = self.ability:GetSpecialValueFor("bonus_range")
self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")

self.heal_creeps = self.parent:GetTalentValue("modifier_terror_meta_4", "creeps", true)

self.crit_damage = self.parent:GetTalentValue("modifier_terror_meta_1", "crit", true)

if not IsServer() then return end

self.parent:NoDraw(self, true)
self.records = {}

if self.parent:IsRealHero() then

    self.parent:AddDamageEvent_out(self)
    if not self.parent:HasTalent("modifier_terror_meta_7") then
        self.ability:EndCd()
    end
end

self.material_group = "default"

self.particle_ally_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle_ally_fx, 0, self.parent:GetAbsOrigin())
if self.caster.current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
    self.material_group = tostring(self.parent:GetTerrorbladeNumber())
    local color = self.caster:GetTerrorbladeColor()
    ParticleManager:SetParticleControl(self.particle_ally_fx, 15, color)
    ParticleManager:SetParticleControl(self.particle_ally_fx, 16, Vector(1,1,1))
end
self:AddParticle(self.particle_ally_fx, false, false, -1, false, false) 

self.model = "models/terrorblade_custom/demon.vmdl"
local new_model = wearables_system:GetUnitModelReplacement(self.caster, "terrorblade_form")
if new_model and string.find(new_model, ".vmdl") then
    self.model = new_model
end

Timers:CreateTimer(0.1, function()
    self.parent:SetMaterialGroup(self.material_group)
end)

self.previous_attack_cability = self.parent:GetAttackCapability()
if players[self.parent:GetId()] then
    self.previous_attack_cability = players[self.parent:GetId()].base_attack_type
end

self.parent:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)

if self:GetParent():IsRealHero() then
    CustomGameEventManager:Send_ServerToAllClients("dota1x6_update_terrorblade_form", {})
end

if self.ability:IsStolen() then
    self:StartIntervalThink(0.1)
end

end


function modifier_custom_terrorblade_metamorphosis:OnRefresh()
self.bonus_range = self.ability:GetSpecialValueFor("bonus_range")
self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
end

function modifier_custom_terrorblade_metamorphosis:OnIntervalThink()
if not IsServer() then return end
if self.ability:IsHidden() then
    self:Destroy()
end

end


function modifier_custom_terrorblade_metamorphosis:RecordDestroyEvent(params)
if not IsServer() then return end
if not self.records[params.record] then return end
self.records[params.record] = nil
end



function modifier_custom_terrorblade_metamorphosis:AttackRecordEvent_out(params)
local attacker = params.attacker
if attacker:GetTeamNumber() ~= self.parent:GetTeamNumber() then return end

self.parent:EmitSound("Hero_Terrorblade_Morphed.preAttack")

if not self.parent:HasTalent("modifier_terror_meta_1") then return end
if not params.target:IsUnit() then return end

self.parent:RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_crit_attack")
local chance = self.parent:GetTalentValue("modifier_terror_meta_1", "chance")

if RollPseudoRandomPercentage(chance, 1608, self.parent) then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_terrorblade_metamorphosis_crit_attack", {})
end

end


function modifier_custom_terrorblade_metamorphosis:CheckState()
if not self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis_crit_attack") then return end
return
{
    [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_custom_terrorblade_metamorphosis:OnDestroy()
if not IsServer() then return end

self.parent:EndNoDraw(self)

if self.parent:IsRealHero() and not self.parent:HasTalent("modifier_terror_meta_7") then
    self.ability:StartCd()
end

self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
self.parent:SetAttackCapability(self.previous_attack_cability)
if self:GetParent():IsRealHero() then
    CustomGameEventManager:Send_ServerToAllClients("dota1x6_update_terrorblade_form", {})
end
end


function modifier_custom_terrorblade_metamorphosis:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_terror_meta_4") then return end
if not self.parent:CheckLifesteal(params, 2) then return end

local heal = (1 - self.parent:GetHealthPercent()/100)*self.parent:GetTalentValue("modifier_terror_meta_4", "heal")/100
if params.unit:IsCreep() then
    heal = heal/self.heal_creeps
end

self.parent:GenericHeal(heal*params.damage, self.ability, true, "", "modifier_terror_meta_4")
end


function modifier_custom_terrorblade_metamorphosis:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_CHANGE,
	MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
	MODIFIER_PROPERTY_PROJECTILE_NAME,
	MODIFIER_PROPERTY_MODEL_SCALE,
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
    MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_custom_terrorblade_metamorphosis:GetModifierMoveSpeedBonus_Percentage()
if not self.parent:HasTalent("modifier_terror_meta_5") then return end
if not self.move_bonus then
    self.move_bonus = self.parent:GetTalentValue("modifier_terror_meta_5", "move")
end
return self.move_bonus
end

function modifier_custom_terrorblade_metamorphosis:GetCritDamage() 
if not self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis_crit_attack") then return end
return self.crit_damage
end

function modifier_custom_terrorblade_metamorphosis:GetModifierPreAttack_CriticalStrike(params)
if not self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis_crit_attack") then return end

self.records[params.record] = true
self.parent:RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_crit_attack")
return self.crit_damage
end


function modifier_custom_terrorblade_metamorphosis:GetModifierAttackRangeBonus()
return self.bonus_range
end

function modifier_custom_terrorblade_metamorphosis:GetModifierBaseAttack_BonusDamage()
local bonus = 0
if self.caster:HasTalent("modifier_terror_meta_4") and self.caster:HasModifier("modifier_custom_terrorblade_metamorphosis_perma") then
    bonus = self.caster:GetUpgradeStack("modifier_custom_terrorblade_metamorphosis_perma")*self.caster:GetTalentValue("modifier_terror_meta_4", "damage")
end

return self.bonus_damage + bonus
end

function modifier_custom_terrorblade_metamorphosis:GetModifierModelScale()
    if self.model == "models/terrorblade_custom/terrorblade_ultimate_depravity_ability.vmdl" then
        return -10
    end
end

function modifier_custom_terrorblade_metamorphosis:GetPriority()
return MODIFIER_PRIORITY_LOW
end

function modifier_custom_terrorblade_metamorphosis:GetModifierProjectileName()
local base_particle = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf", self)
if self.caster.current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
    local particle_name = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_"
    if base_particle == "particles/econ/items/terrorblade/terrorblade_ti9_immortal/terrorblade_ti9_immortal_metamorphosis_base_attack.vpcf" then
        particle_name = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_"
    end
    local id = self.caster:GetTerrorbladeNumber()
    if id then
        return particle_name..id..".vpcf"
    end
    if base_particle == "particles/econ/items/terrorblade/terrorblade_ti9_immortal/terrorblade_ti9_immortal_metamorphosis_base_attack.vpcf" then
        return "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf"
    end
    return "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_1.vpcf"
end
return wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf", self)
end

function modifier_custom_terrorblade_metamorphosis:GetModifierModelChange()
return self.model or "models/terrorblade_custom/demon.vmdl"
end

function modifier_custom_terrorblade_metamorphosis:GetAttackSound()
return "Hero_Terrorblade_Morphed.Attack"
end






modifier_custom_terrorblade_metamorphosis_tracker = class({})
function modifier_custom_terrorblade_metamorphosis_tracker:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_tracker:IsPurgable() return false end
function modifier_custom_terrorblade_metamorphosis_tracker:OnCreated()

end 

function modifier_custom_terrorblade_metamorphosis_tracker:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ABSORB_SPELL,
}
end

function modifier_custom_terrorblade_metamorphosis_tracker:GetAbsorbSpell(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_terror_meta_6") then return end
if not self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then return end
if self.parent:PassivesDisabled() then return end
if not params.ability then return end

local caster = params.ability:GetCaster()
if not caster then return end
if caster:HasModifier("modifier_custom_terrorblade_metamorphosis_fear_cd") then return end
if caster:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if (caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.fear_range then return end


local particle_2 = ParticleManager:CreateParticle("particles/items_fx/phylactery.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle_2, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(particle_2, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle_2)

caster:EmitSound("Generic.Fear")

caster:AddNewModifier(self.parent, self.ability, "modifier_nevermore_requiem_fear", {duration  = self.fear_duration * (1 - caster:GetStatusResistance())})
caster:AddNewModifier(self.parent, self.ability, "modifier_custom_terrorblade_metamorphosis_fear_cd", {duration = self.fear_cd})
return false
end



function modifier_custom_terrorblade_metamorphosis_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.fear_duration = self.parent:GetTalentValue("modifier_terror_meta_6", "fear", true)
self.fear_cd = self.parent:GetTalentValue("modifier_terror_meta_6", "cd", true)
self.fear_range = self.parent:GetTalentValue("modifier_terror_meta_6", "range", true)

self.cleave_radius = self.parent:GetTalentValue("modifier_terror_meta_2", "radius", true)
self.cleave_bonus = self.parent:GetTalentValue("modifier_terror_meta_2", "bonus", true)

self.delay = self.ability:GetSpecialValueFor("transformation_time")

self.crit_slow = self.parent:GetTalentValue("modifier_terror_meta_1", "duration", true)

self.metamorph_aura_tooltip = self:GetAbility():GetSpecialValueFor("metamorph_aura_tooltip")

self.visual_max = 5

self.parent:AddAttackStartEvent_out(self)
self.parent:AddAttackEvent_out(self)

if not IsServer() then return end
self.player = PlayerResource:GetPlayer(self.parent:GetPlayerID())
self:StartIntervalThink(1)
end

function modifier_custom_terrorblade_metamorphosis_tracker:OnIntervalThink()
if not IsServer() then return end

if self.parent:HasTalent("modifier_terror_meta_7") then
    if self.ability:IsFullyCastable() and self.parent:IsAlive() and not self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis_transform") 
        and not self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then 

        self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_terrorblade_metamorphosis_transform", {duration = self.delay})
    end

    self:UpdateUI()

    self:StartIntervalThink(0.2)
else
    if not self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") and not self.ability:IsActivated() then
        self.ability:StartCd()
    end
end

end


function modifier_custom_terrorblade_metamorphosis_tracker:UpdateUI()
if not IsServer() then return end
local stack_mod = self.parent:FindModifierByName("modifier_custom_terrorblade_metamorphosis_legendary_stack")

if not stack_mod then return end

local has_meta = self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis")
local mod = self.parent:FindModifierByName("modifier_terrorblade_demon_zeal_custom_buff")
local stack = stack_mod:GetStackCount()
local active = 0
local max = stack_mod:GetMax()
local zero = nil
local no_min = nil

if has_meta then
    no_min = 1
end

if mod then
    active = 1
    stack = mod:GetRemainingTime()
    zero = 1
end

if mod or not has_meta then
    if self.particle then
        ParticleManager:DestroyParticle(self.particle, true)
        ParticleManager:ReleaseParticleIndex(self.particle)
        self.particle = nil
    end
else
    if not self.particle then
        self.particle = ParticleManager:CreateParticleForPlayer("particles/terrorblade/meta_legendary_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent, self.player)
        self:AddParticle(self.particle, false, false, -1, false, false)
    end

    for i = 1,self.visual_max do 
        if i <= math.floor(stack/(max/self.visual_max)) then 
            ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0))   
        else 
            ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))   
        end  
    end
end

self.parent:UpdateUIlong({max = max, stack = stack, use_zero = zero, active = active, no_min = no_min, style = "TbMeta"})
end




function modifier_custom_terrorblade_metamorphosis_tracker:IsAura()
return self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis_transform") or self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis")
end

function modifier_custom_terrorblade_metamorphosis_tracker:GetAuraEntityReject(hTarget)
return not hTarget:IsIllusion() or not hTarget.owner or hTarget.owner ~= self.parent or hTarget:GetName() ~= self.parent:GetName()
end

function modifier_custom_terrorblade_metamorphosis_tracker:GetAuraDuration() return 0.5 end
function modifier_custom_terrorblade_metamorphosis_tracker:GetAuraRadius() return self.metamorph_aura_tooltip end
function modifier_custom_terrorblade_metamorphosis_tracker:GetAuraSearchFlags()return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end
function modifier_custom_terrorblade_metamorphosis_tracker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_custom_terrorblade_metamorphosis_tracker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_custom_terrorblade_metamorphosis_tracker:GetModifierAura() return "modifier_custom_terrorblade_metamorphosis_transform_aura" end



function modifier_custom_terrorblade_metamorphosis_tracker:AttackStartEvent_out(params)
local attacker = params.attacker
if attacker:GetTeamNumber() ~= self.parent:GetTeamNumber() then return end
if not attacker:HasModifier("modifier_custom_terrorblade_metamorphosis") then return end

if not self.parent:HasTalent("modifier_terror_meta_7") then return end
if attacker ~= self.parent then return end
if params.no_attack_cooldown then return end

local mod = self.parent:FindModifierByName("modifier_custom_terrorblade_metamorphosis_legendary_stack")
if mod then
    mod:AddStack(params.target)
    self:UpdateUI()
end

end



function modifier_custom_terrorblade_metamorphosis_tracker:AttackEvent_out(params)
if not IsServer() then return end
if params.attacker:GetTeamNumber() ~= self.parent:GetTeamNumber() then return end

local attacker = params.attacker
local attacker_owner = attacker
if attacker.owner then
    attacker_owner = attacker.owner
end

if attacker_owner ~= self.parent then return end

local target = params.target
local mod = attacker:FindModifierByName("modifier_custom_terrorblade_metamorphosis")

if mod then
    target:EmitSound("Hero_Terrorblade_Morphed.projectileImpact")
end

if not target:IsUnit() then return end

if mod and mod.records and mod.records[params.record] then
    EmitSoundOnLocationWithCaster(target:GetAbsOrigin(), "TB.Meta_crit", target)
    if attacker == self.parent then
        target:AddNewModifier(self.parent, self.ability, "modifier_custom_terrorblade_metamorphosis_slow", {duration = (1 - target:GetStatusResistance())*self.crit_slow})
    end
end

if attacker ~= self.parent then return end

if mod and target:IsRealHero() then
    attacker:AddNewModifier(self.parent, self.ability, "modifier_custom_terrorblade_metamorphosis_perma", {}) 
end

if not self.parent:HasTalent("modifier_terror_meta_2") then return end

local damage = params.damage*self.parent:GetTalentValue("modifier_terror_meta_2", "cleave")/100

if mod then
    damage = damage*self.cleave_bonus

    local effect_cast = ParticleManager:CreateParticle("particles/tb_aoe.vpcf" , PATTACH_ABSORIGIN_FOLLOW, target )
    ParticleManager:SetParticleControl( effect_cast, 0, target:GetAbsOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, target:GetAbsOrigin() )
    ParticleManager:DestroyParticle(effect_cast, false)
    ParticleManager:ReleaseParticleIndex(effect_cast)

    for _,aoe_target in pairs(self.parent:FindTargets(self.cleave_radius, target:GetAbsOrigin())) do
        if target ~= aoe_target then
            DoDamage({victim = aoe_target, attacker = self.parent, damage = damage, ability = self.ability, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK})
        end
    end
else
    DoCleaveAttack(self.parent, target, self.ability, damage, 150, 360, 650, "particles/slark/essence_cleave.vpcf" )
end 

end






modifier_custom_terrorblade_metamorphosis_transform_aura = class({})
function modifier_custom_terrorblade_metamorphosis_transform_aura:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_transform_aura:OnCreated()
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_terrorblade_metamorphosis_transform", {duration = self.ability:GetSpecialValueFor("transformation_time")})
end

function modifier_custom_terrorblade_metamorphosis_transform_aura:OnDestroy()
if not IsServer() then return end
if not self.parent or self.parent:IsNull() then return end

self.parent:RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_transform")
self.parent:RemoveModifierByName("modifier_custom_terrorblade_metamorphosis")
end




modifier_custom_terrorblade_metamorphosis_perma = class({})
function modifier_custom_terrorblade_metamorphosis_perma:IsHidden() return not self:GetCaster():HasTalent("modifier_terror_meta_4") end
function modifier_custom_terrorblade_metamorphosis_perma:IsPurgable() return false end
function modifier_custom_terrorblade_metamorphosis_perma:RemoveOnDeath() return false end
function modifier_custom_terrorblade_metamorphosis_perma:GetTexture() return "buffs/souls_tempo" end
function modifier_custom_terrorblade_metamorphosis_perma:OnCreated()
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_terror_meta_4", "max", true)

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_custom_terrorblade_metamorphosis_perma:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()
end

function modifier_custom_terrorblade_metamorphosis_perma:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self.parent:HasTalent("modifier_terror_meta_4") then return end

self.parent:GenericParticle("particles/enigma/summon_perma.vpcf")

self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 




modifier_custom_terrorblade_metamorphosis_fear_cd = class({})
function modifier_custom_terrorblade_metamorphosis_fear_cd:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_fear_cd:IsPurgable() return false end
function modifier_custom_terrorblade_metamorphosis_fear_cd:RemoveOnDeath() return false end



modifier_custom_terrorblade_metamorphosis_slow = class({})
function modifier_custom_terrorblade_metamorphosis_slow:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_slow:IsPurgable() return true end
function modifier_custom_terrorblade_metamorphosis_slow:GetEffectName() return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf" end
function modifier_custom_terrorblade_metamorphosis_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_terrorblade_metamorphosis_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_terror_meta_1", "slow")
end

function modifier_custom_terrorblade_metamorphosis_slow:GetModifierMoveSpeedBonus_Percentage() 
return self.slow
end








modifier_custom_terrorblade_metamorphosis_legendary_stack = class({})
function modifier_custom_terrorblade_metamorphosis_legendary_stack:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_legendary_stack:IsPurgable() return false end
function modifier_custom_terrorblade_metamorphosis_legendary_stack:RemoveOnDeath() return false end
function modifier_custom_terrorblade_metamorphosis_legendary_stack:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max = self.parent:GetTalentValue("modifier_terror_meta_7", "max")
self.delay = self.parent:GetTalentValue("modifier_terror_meta_7", "delay")

self.interval = 0.2

if not IsServer() then return end
self:SetStackCount(0)
end

function modifier_custom_terrorblade_metamorphosis_legendary_stack:GetMax()
return self.max + self.parent:GetTalentValue("modifier_terror_meta_3", "max")
end

function modifier_custom_terrorblade_metamorphosis_legendary_stack:AddStack(target)
if not IsServer() then return end
if self.parent:HasModifier("modifier_terrorblade_demon_zeal_custom_buff") then return end
if self:GetStackCount() >= self:GetMax() then return end

if target:IsHero() then
    self:IncrementStackCount()
end

if self:GetStackCount() >= self:GetMax() then
    self.ability:StartCd()
    self.parent:RemoveModifierByName("modifier_custom_terrorblade_metamorphosis")
    self.parent:RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_transform")
    self:SetStackCount(0)
end

self:StartIntervalThink(self.delay)
end


function modifier_custom_terrorblade_metamorphosis_legendary_stack:OnIntervalThink()
if not IsServer() then return end

if self:GetStackCount() > 0 then
    self:DecrementStackCount()
end

self:StartIntervalThink(self.interval)
end



function modifier_custom_terrorblade_metamorphosis_legendary_stack:OnStackCountChanged(iStackCount)
if not IsServer() then return end
local ability = self.parent:FindAbilityByName("terrorblade_demon_zeal_custom")
if not ability then return end
ability:SetActivated(self:GetStackCount() > 0)
end








terrorblade_demon_zeal_custom = class({})

function terrorblade_demon_zeal_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/models/heroes/terrorblade/demon_zeal.vpcf", context )
end


function terrorblade_demon_zeal_custom:GetCooldown()
local bonus = 0
if self:GetCaster():HasTalent("modifier_terror_meta_3") then
    bonus = self:GetCaster():GetTalentValue("modifier_terror_meta_3", "cd")
end
return self:GetCaster():GetTalentValue("modifier_terror_meta_7", "cd") + bonus
end



function terrorblade_demon_zeal_custom:OnAbilityPhaseStart()
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_custom_terrorblade_metamorphosis_legendary_stack")
return self:GetCaster():HasModifier("modifier_custom_terrorblade_metamorphosis") and mod and mod:GetStackCount() > 0
end



function terrorblade_demon_zeal_custom:OnSpellStart()

local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_custom_terrorblade_metamorphosis_legendary_stack")

if not mod or mod:GetStackCount() <= 0 then return end

if caster:HasTalent("modifier_terror_meta_5") then
    caster:Purge(false, true, false, true, true)
    caster:AddNewModifier(caster, self, "modifier_generic_debuff_immune", {duration = caster:GetTalentValue("modifier_terror_meta_5", "duration"), effect = 1})
    caster:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")
end

local duration = mod:GetStackCount()*caster:GetTalentValue("modifier_terror_meta_7", "duration")
mod:SetStackCount(0)

caster:EmitSound("Hero_Terrorblade.DemonZeal.Cast")
caster:EmitSound("TB.Meta_stack")
caster:AddNewModifier(caster, self, "modifier_terrorblade_demon_zeal_custom_buff", {duration = duration})
end




modifier_terrorblade_demon_zeal_custom_buff = class({})
function modifier_terrorblade_demon_zeal_custom_buff:IsHidden() return true end
function modifier_terrorblade_demon_zeal_custom_buff:IsPurgable() return false end
function modifier_terrorblade_demon_zeal_custom_buff:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bva = self.parent:GetTalentValue("modifier_terror_meta_7", "bva")
if not IsServer() then return end
self.ability:EndCd()
self.RemoveForDuel = true

self.pfx = ParticleManager:CreateParticle("particles/models/heroes/terrorblade/demon_zeal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.pfx, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.pfx, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
if self.parent.current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
    local color = self.parent:GetTerrorbladeColor()
    ParticleManager:SetParticleControl(self.pfx, 15, color)
    ParticleManager:SetParticleControl(self.pfx, 16, Vector(1,0,0))
end
self:AddParticle(self.pfx, false, false, -1, false, false)

end



function modifier_terrorblade_demon_zeal_custom_buff:OnDestroy()
if not IsServer() then return end
self.ability:UseResources(false, false, false, true)
end

function modifier_terrorblade_demon_zeal_custom_buff:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
    MODIFIER_PROPERTY_MODEL_SCALE,
}
end


function modifier_terrorblade_demon_zeal_custom_buff:GetModifierBaseAttackTimeConstant()
return self.bva
end

function modifier_terrorblade_demon_zeal_custom_buff:GetModifierModelScale()
return 20
end

function modifier_terrorblade_demon_zeal_custom_buff:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end

function modifier_terrorblade_demon_zeal_custom_buff:GetStatusEffectName()
return "particles/status_fx/status_effect_dark_willow_shadow_realm.vpcf"
end





modifier_custom_terrorblade_metamorphosis_crit_attack = class({})
function modifier_custom_terrorblade_metamorphosis_crit_attack:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_crit_attack:IsPurgable() return false end






custom_terrorblade_terror_wave = class({})

function custom_terrorblade_terror_wave:GetCastRange(vLocation, hTarget)
if IsClient() then 
    return self:GetSpecialValueFor("range")
end 
return 99999
end


function custom_terrorblade_terror_wave:OnSpellStart(table)

local caster = self:GetCaster()
local point = self:GetCursorPosition()

if point == caster:GetAbsOrigin() then
    point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
end

local vec = (point - caster:GetAbsOrigin())
local max_range = self:GetSpecialValueFor("range") + caster:GetCastRangeBonus()
local delay = self:GetSpecialValueFor("scepter_spawn_delay")

if vec:Length2D() > max_range then 
    point = caster:GetAbsOrigin() + vec:Normalized()*max_range
end 

local units = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)

for _,unit in pairs(units) do 
    if unit == caster or (unit.owner and unit.owner == caster and unit:IsIllusion()) and not unit:HasModifier("modifier_custom_terrorblade_reflection_unit") then
        unit:AddNewModifier(caster, self, "modifier_custom_terrorblade_metamorphosis_fear_thinker", {x = point.x, y = point.y, duration = delay})
    end
end 

end


modifier_custom_terrorblade_metamorphosis_fear_thinker = class({})
function modifier_custom_terrorblade_metamorphosis_fear_thinker:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_fear_thinker:IsPurgable() return false end
function modifier_custom_terrorblade_metamorphosis_fear_thinker:CheckState()
return
{
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_OUT_OF_GAME] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
}
end

function modifier_custom_terrorblade_metamorphosis_fear_thinker:OnCreated(params)
if not IsServer() then return end 

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("scepter_radius")
self.speed = self.ability:GetSpecialValueFor("scepter_speed")
self.blink_radius = self.ability:GetSpecialValueFor("blink_radius")

local start_point = self.parent:GetAbsOrigin()

ProjectileManager:ProjectileDodge(self.parent)

EmitSoundOnLocationWithCaster( start_point, "Hero_Antimage.Blink_out", self.parent )

local effect = ParticleManager:CreateParticle("particles/arc_warden/field_blink_start.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect, 0, start_point)
ParticleManager:ReleaseParticleIndex(effect)

local effect2 = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect2, 0, start_point)
ParticleManager:ReleaseParticleIndex(effect2)

self.parent:NoDraw(self)

self.parent:AddNoDraw()
self.point = GetGroundPosition(Vector(params.x, params.y, 0), nil)
local vec = (self.point - self.parent:GetAbsOrigin()):Normalized()
vec.z = 0
self.parent:SetForwardVector(vec)
self.parent:FaceTowards(self.point)

end


function modifier_custom_terrorblade_metamorphosis_fear_thinker:OnDestroy()
if not IsServer() then return end

self.parent:RemoveNoDraw()
self.parent:Stop()

local final_point = self.point + RandomVector(self.blink_radius)

local effect = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect, 0, final_point + Vector(0, 0, 100))
ParticleManager:ReleaseParticleIndex(effect)

self.parent:SetAbsOrigin(final_point)
FindClearSpaceForUnit(self.parent, final_point, true)

if self.caster ~= self.parent then return end

self.caster:EmitSound("Hero_Terrorblade.Metamorphosis.Scepter")
self.caster:AddNewModifier(self.parent, self.ability, "modifier_custom_terrorblade_metamorphosis_ring", {duration = self.radius/self.speed} )
end



modifier_custom_terrorblade_metamorphosis_ring = class({})
function modifier_custom_terrorblade_metamorphosis_ring:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_ring:IsPurgable() return false end
function modifier_custom_terrorblade_metamorphosis_ring:RemoveOnDeath() return false end
function modifier_custom_terrorblade_metamorphosis_ring:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end


function modifier_custom_terrorblade_metamorphosis_ring:OnCreated( kv )
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.fear_duration  = self.ability:GetSpecialValueFor("fear_duration")
self.radius         = self.ability:GetSpecialValueFor("scepter_radius")
self.speed          = self.ability:GetSpecialValueFor("scepter_speed")
self.damage         = self.ability:GetSpecialValueFor("damage")

self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_terrorblade/terrorblade_scepter.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(  self.speed, self.speed, self.speed ) )

if self.parent.current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
    local color = self.parent:GetTerrorbladeColor()
    ParticleManager:SetParticleControl(self.effect_cast, 15, color)
    ParticleManager:SetParticleControl(self.effect_cast, 16, Vector(1,0,0))
end

self:AddParticle(self.effect_cast, false, false, -1, false, false)

self.origin = self:GetParent():GetAbsOrigin()

self.start_radius = 0
self.end_radius = self.radius
self.width = 100

self.targets = {}

self:StartIntervalThink( 0.03 )
self:OnIntervalThink()
end


function modifier_custom_terrorblade_metamorphosis_ring:OnIntervalThink()

local radius = self.start_radius + self.speed * self:GetElapsedTime()
if radius>self.end_radius then
    self:Destroy()
    return
end

local targets = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self.origin, nil, radius,  DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

for _,target in pairs(targets) do
    if not self.targets[target] and (target:GetOrigin()-self.origin):Length2D()>(radius-self.width) then
        self.targets[target] = true
        target:EmitSound("Sf.Aura_Fear")
        target:AddNewModifier(self.parent, self.ability, "modifier_terrorblade_fear", {duration = self.fear_duration*(1 - target:GetStatusResistance())})
        DoDamage({victim = target, attacker = self.parent, ability = self.ability, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL})
    end
end

end



modifier_custom_terrorblade_metamorphosis_portrait = class({})
function modifier_custom_terrorblade_metamorphosis_portrait:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_portrait:IsPurgable() return false end
function modifier_custom_terrorblade_metamorphosis_portrait:GetEffectName() return "particles/ogre_dd.vpcf" end