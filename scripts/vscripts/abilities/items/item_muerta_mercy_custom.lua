--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_muerta_quest_item_stats", "abilities/items/item_muerta_mercy_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_muerta_quest_item_slow", "abilities/items/item_muerta_mercy_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_muerta_quest_item_illusion", "abilities/items/item_muerta_mercy_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_muerta_quest_item_leash", "abilities/items/item_muerta_mercy_custom", LUA_MODIFIER_MOTION_NONE)

item_muerta_quest_item = class({})

function item_muerta_quest_item:GetIntrinsicModifierName()
return "modifier_item_muerta_quest_item_stats"
end

function item_muerta_quest_item:Spawn()
self.stats = self:GetSpecialValueFor("stats")
self.movespeed = self:GetSpecialValueFor("movespeed")
self.speed = self:GetSpecialValueFor("speed")
self.start_range = self:GetSpecialValueFor("start_range" )
self.duration = self:GetSpecialValueFor("duration")
self.impact_stun = self:GetSpecialValueFor("impact_stun")
self.max_range = self:GetSpecialValueFor("max_range")
self.extra_spell_damage_percent = self:GetSpecialValueFor("extra_spell_damage_percent")
self.slow = self:GetSpecialValueFor("slow")
self.leash_radius = self:GetSpecialValueFor("leash_radius")
self.creeps = self:GetSpecialValueFor("creeps")
self.has_leash = self:GetSpecialValueFor("has_leash")
self.cd_inc = self:GetSpecialValueFor("cd_inc")
self.innate_bonus = self:GetSpecialValueFor("innate_bonus")
end


function item_muerta_quest_item:OnAbilityPhaseStart()
self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 1.2)
return
end

function item_muerta_quest_item:OnAbilityPhaseInterrupted()
self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_5)
end

function item_muerta_quest_item:OnSpellStart()
local caster = self:GetCaster()
--caster:FadeGesture(ACT_DOTA_CAST_ABILITY_5)

local target = self:GetCursorTarget()

local info = 
{
    EffectName = "particles/units/heroes/hero_muerta/muerta_parting_shot_projectile.vpcf",
    Ability = self,
    iMoveSpeed = self.speed,
    Source = caster,
    Target = target,
    iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
    ExtraData = {x = caster:GetAbsOrigin().x, y = caster:GetAbsOrigin().y }
}

caster:EmitSound("Hero_Muerta.SpectralBlast.Cast")
ProjectileManager:CreateTrackingProjectile( info )
end


function item_muerta_quest_item:OnProjectileHit(target, vLocation)
if not IsServer() then return end
if not target then return end
if target:TriggerSpellAbsorb(self) then return end

local caster = self:GetCaster()
target:EmitSound("Hero_Muerta.SpectralBlast.Impact")
target:EmitSound("Hero_Muerta.PartingShot.Soul")
target:EmitSound("Hero_Muerta.SpectralBlast.Ethereal")

target:AddNewModifier(caster, self, "modifier_stunned", {duration = self.impact_stun})
target:AddNewModifier(caster, self, "modifier_item_muerta_quest_item_slow", {duration = self.duration})
target:AddNewModifier(caster, self, "modifier_ghost_state", {duration = self.duration*(1 - target:GetStatusResistance())})

if self.has_leash ~= 1 then return end
if target:IsCreep() then return end

local vec = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()
vec.z = 0

local point = target:GetAbsOrigin() + vec*50

local illusions = CreateIllusions(target, target, {duration = self.duration, outgoing_damage = -100 ,incoming_damage = 0}, 1, 1, false, true)
for _,illusion in pairs(illusions) do
	illusion:SetOwner(nil)
    illusion:Stop()
    illusion:StartGesture(ACT_DOTA_DISABLED)

    illusion:AddNewModifier(illusion, nil, "modifier_stunned", {duration = self.duration})
    illusion:AddNewModifier(illusion, nil, "modifier_chaos_knight_phantasm_illusion", {})
    illusion:AddNewModifier(illusion, self, "modifier_item_muerta_quest_item_illusion", {duration = self.duration})
    target:AddNewModifier(caster, self, "modifier_item_muerta_quest_item_leash", {duration = self.duration, soul = illusion:entindex()})

    illusion:SetAbsOrigin(point)
    FindClearSpaceForUnit(illusion, point, true)

    local new_point = target:GetAbsOrigin() + vec*self.max_range*0.25

    illusion:AddNewModifier(illusion, self,  "modifier_generic_arc",  
    {
      target_x = new_point.x,
      target_y = new_point.y,
      distance = self.max_range*0.25,
      duration = 0.3,
      height = 0,
      fix_end = false,
      isStun = false,
      activity = ACT_DOTA_FLAIL,
    })

    illusion:SetHealth(illusion:GetMaxHealth())
    illusion.owner = target
end

end


modifier_item_muerta_quest_item_leash = class(mod_hidden)
function modifier_item_muerta_quest_item_leash:OnCreated(table)
if not IsServer() then return end
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.soul = EntIndexToHScript(table.soul)
self.max_range = self.ability.max_range

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_parting_shot_tether.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt( self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( self.particle, 1, self.soul, PATTACH_POINT_FOLLOW, "attach_hitloc", self.soul:GetOrigin(), true )
self:AddParticle(self.particle, false, false, -1, false, false)

self.interval = 0.1
self:StartIntervalThink(0.1)
end

function modifier_item_muerta_quest_item_leash:OnIntervalThink()
if not IsServer() then return end

if not IsValid(self.soul, self.ability) or not self.soul:IsAlive() then 
    self:Destroy()
end

AddFOWViewer(self.caster:GetTeamNumber(), self.soul:GetAbsOrigin(), 50, self.interval*2, false)

if (self.soul:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.max_range then return end 
self:Destroy()
end

function modifier_item_muerta_quest_item_leash:OnDestroy()
if not IsServer() then return end
if self:GetRemainingTime() <= 0.1 then return end

self.parent:GenericParticle("particles/muerta/dead_legendary_stun.vpcf")
self.parent:EmitSound("Hero_Muerta.PartingShot.Stun")

self.parent:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = self.ability.impact_stun})

if self.parent:IsRealHero() and self.caster.muerta_innate and self.caster.muerta_innate.tracker then
	self.caster.muerta_innate.tracker:MuertaQuestProgress()
end

if self.ability.cd_inc ~= 0 then
	self.parent:CdAbility(self.ability, nil, self.ability.cd_inc/100)

	local particle = ParticleManager:CreateParticle("particles/muerta/dead_refresh.vpcf", PATTACH_CUSTOMORIGIN, self.caster)
	ParticleManager:SetParticleControlEnt( particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex(particle)
	self.caster:EmitSound("Muerta.Scepter_Refresh")
end

if not IsValid(self.soul) then RespawnUnit() end
self.soul:GenericParticle("particles/muerta/dead_legendary_stun.vpcf")
self.soul:Kill(nil, nil)
end

function modifier_item_muerta_quest_item_leash:CheckState()
return
{
    [MODIFIER_STATE_TETHERED] = true
}
end



modifier_item_muerta_quest_item_stats = class(mod_hidden)
function modifier_item_muerta_quest_item_stats:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self:SendStack()
end

function modifier_item_muerta_quest_item_stats:SendStack(reset)
if not IsServer() then return end
self:SetStackCount(reset and 0 or self.ability.innate_bonus)

if IsValid(self.parent.muerta_innate) and self.parent.muerta_innate.tracker then
	self.parent.muerta_innate.tracker:ChangeStack()
end

end

function modifier_item_muerta_quest_item_stats:OnDestroy()
if not IsServer() then return end
self:SendStack(true)
end

function modifier_item_muerta_quest_item_stats:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
 	MODIFIER_PROPERTY_IS_SCEPTER,
}
end

function modifier_item_muerta_quest_item_stats:GetModifierTotalDamageOutgoing_Percentage(params)
if not params.target or not params.target:HasModifier("modifier_muerta_innate_custom_creep") then return end
return self.ability.creeps
end

function modifier_item_muerta_quest_item_stats:GetModifierMoveSpeedBonus_Constant()
return self.ability.movespeed
end

function modifier_item_muerta_quest_item_stats:GetModifierBonusStats_Strength()
return self.ability.stats
end

function modifier_item_muerta_quest_item_stats:GetModifierBonusStats_Agility()
return self.ability.stats
end

function modifier_item_muerta_quest_item_stats:GetModifierBonusStats_Intellect()
return self.ability.stats
end

function modifier_item_muerta_quest_item_stats:GetModifierScepter()
return 1
end



modifier_item_muerta_quest_item_slow = class(mod_hidden)
function modifier_item_muerta_quest_item_slow:IsPurgable() return true end
function modifier_item_muerta_quest_item_slow:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.slow = self.ability.slow
end

function modifier_item_muerta_quest_item_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_muerta_quest_item_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_item_muerta_quest_item_illusion = class(mod_hidden)
function modifier_item_muerta_quest_item_illusion:GetStatusEffectName() return "particles/status_fx/status_effect_muerta_parting_shot.vpcf" end
function modifier_item_muerta_quest_item_illusion:StatusEffectPriority() return MODIFIER_PRIORITY_ILLUSION end
function modifier_item_muerta_quest_item_illusion:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_muerta/muerta_parting_shot_soul.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt( self.particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( self.particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
self:AddParticle(self.particle, false, false, -1, false, false)

self.parent:StartGesture(ACT_DOTA_DISABLED)
end

function modifier_item_muerta_quest_item_illusion:CheckState()
return
{
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
}
end

function modifier_item_muerta_quest_item_illusion:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_item_muerta_quest_item_illusion:GetActivityTranslationModifiers()
return ACT_DOTA_DISABLED
end

function modifier_item_muerta_quest_item_illusion:GetAbsoluteNoDamagePhysical()
return 1
end

function modifier_item_muerta_quest_item_illusion:GetAbsoluteNoDamagePure()
return 1
end

function modifier_item_muerta_quest_item_illusion:GetAbsoluteNoDamageMagical()
return 1
end



item_muerta_mercy_custom = class(item_muerta_quest_item)
item_muerta_mercy_and_grace_custom = class(item_muerta_quest_item)
item_muerta_mercy_and_grace_full_custom = class(item_muerta_quest_item)