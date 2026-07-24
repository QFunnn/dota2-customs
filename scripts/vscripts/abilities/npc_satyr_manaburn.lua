--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_manaburn_npc", "abilities/npc_satyr_manaburn.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_satyr_manaburn_cd", "abilities/npc_satyr_manaburn.lua", LUA_MODIFIER_MOTION_NONE)

npc_satyr_manaburn = class({})


function npc_satyr_manaburn:GetChannelTime() 
    return self:GetSpecialValueFor("duration") 
end

function npc_satyr_manaburn:OnSpellStart()
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_satyr_manaburn_cd", {duration = self:GetCooldownTimeRemaining()})
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_satyr_manaburn_npc", {})
end

 
function npc_satyr_manaburn:OnChannelFinish(bInterrupted)
self:GetCaster():RemoveModifierByName("modifier_satyr_manaburn_npc")
end 


modifier_satyr_manaburn_npc = class ({})

function modifier_satyr_manaburn_npc:IsHidden() return true end
function modifier_satyr_manaburn_npc:IsPurgable() return false end



function modifier_satyr_manaburn_npc:OnCreated(table)
self.mana = self:GetAbility():GetSpecialValueFor("mana")
self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.interval = self:GetAbility():GetSpecialValueFor("interval")
self.radius = self:GetAbility():GetSpecialValueFor("radius")
self.illusion = self:GetAbility():GetSpecialValueFor("damage_illusion")
self:StartIntervalThink(self.interval)
self:OnIntervalThink()
end

function modifier_satyr_manaburn_npc:OnIntervalThink()
if not IsServer() then return end
self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_1)
self:GetCaster():StartGestureWithPlaybackRate( ACT_DOTA_CAST_ABILITY_1, 1)
local enemy_for_ability = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE , FIND_ANY_ORDER, false)
if #enemy_for_ability > 0 then 
    for _,i in pairs(enemy_for_ability) do
        if not i:IsMagicImmune() then 


        self.nFXIndex = ParticleManager:CreateParticle("particles/neutral_fx/harpy_chain_lightning.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
        ParticleManager:SetParticleControlEnt(self.nFXIndex, 0, i, PATTACH_POINT_FOLLOW, "attach_hitloc", i:GetAbsOrigin(), true) 
        ParticleManager:SetParticleControlEnt(self.nFXIndex, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(self.nFXIndex)   

        local effect = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, i)
          i:EmitSound("n_creep_SatyrSoulstealer.ManaBurn")  
          local damage = self.damage
          if i:IsHero() and not i:IsRealHero() then damage = self.illusion end
          DoDamage({victim = i, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
          i:SpendMana(self.mana, self)   
        end
    end
end
end

modifier_satyr_manaburn_cd = class({})

function modifier_satyr_manaburn_cd:IsHidden() return false end
function modifier_satyr_manaburn_cd:IsPurgable() return false end