--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_techies_bomb_cd", "abilities/npc_techies_bomb.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_bomb", "abilities/npc_techies_bomb.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_bomb_silence", "abilities/npc_techies_bomb.lua", LUA_MODIFIER_MOTION_NONE)

npc_techies_bomb = class({})



function npc_techies_bomb:Precache(context)
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf", context )

end


function npc_techies_bomb:OnSpellStart()

self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_techies_bomb_cd", {duration = self:GetCooldownTimeRemaining()})
self.radius = self:GetSpecialValueFor("radius")

self:GetCaster():EmitSound("Hero_Techies.RemoteMine.Plant")
new_bomb = CreateUnitByName("npc_techies_bomb", self:GetAbsOrigin()+RandomVector(RandomInt(-1, 1)+self.radius), true, nil, nil, DOTA_TEAM_CUSTOM_5)
new_bomb:AddNewModifier(self:GetCaster(), self, "modifier_techies_bomb", {})
end

modifier_techies_bomb = class({})

function modifier_techies_bomb:IsHidden() return true end
function modifier_techies_bomb:IsPurgable() return false end
function modifier_techies_bomb:IsDebuff() return true end

function modifier_techies_bomb:OnCreated(table)

self.parent = self:GetParent()
self.parent:AddAttackEvent_inc(self, true)

self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.duration = self:GetAbility():GetSpecialValueFor("duration")
self.range = self:GetAbility():GetSpecialValueFor("radius_exp")
self.hits = self:GetAbility():GetSpecialValueFor("hits")
self.timer = self:GetAbility():GetSpecialValueFor("timer")*2
self.t = 0
if not IsServer() then return end 
self:StartIntervalThink(0.5)
end


function modifier_techies_bomb:OnIntervalThink()
if not IsServer() then return end
self.t = self.t + 1
local caster = self:GetParent()


local number = (self.timer-self.t)/2 
local int = 0
int = number
if number % 1 ~= 0 then int = number - 0.5  caster:EmitSound("Hero_Techies.RemoteMine.Priming") end


local digits = math.floor(math.log10(number)) + 2

local decimal = number % 1

if decimal == 0.5 then
decimal = 8
else 
decimal = 1
end

local particleName = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf"
local particle = ParticleManager:CreateParticle(particleName, PATTACH_OVERHEAD_FOLLOW, caster)
ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))

ParticleManager:ReleaseParticleIndex(particle)

if self.t == self.timer then 

self:GetParent():EmitSound("Hero_Techies.RemoteMine.Activate")
self:GetParent():EmitSound("Hero_Techies.RemoteMine.Detonate")
local particle_explosion = "particles/units/heroes/hero_techies/techies_remote_mines_detonate.vpcf"

local particle_explosion_fx = ParticleManager:CreateParticle(particle_explosion, PATTACH_WORLDORIGIN, caster)
ParticleManager:SetParticleControl(particle_explosion_fx, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_explosion_fx, 1, Vector(600, 1, 1))
ParticleManager:SetParticleControl(particle_explosion_fx, 3, caster:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_explosion_fx)

local damage = 0
local enemy_for_ability = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0 , FIND_CLOSEST, false)
if #enemy_for_ability > 0 then 
     for _,i in pairs(enemy_for_ability) do 
        if i:GetTeam() ~= DOTA_TEAM_NEUTRALS and not i:IsBuilding() then 
            damage = i:GetMaxHealth()*self.damage/100
            i:AddNewModifier(self:GetAbility():GetCaster(), self:GetAbility(), "modifier_techies_bomb_silence", {duration = self.duration*(1 - i:GetStatusResistance())})
            DoDamage({ victim = i, attacker = self:GetAbility():GetCaster(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION})
        end
    end
 
end
self:GetParent():Kill(nil,nil)

end

end


function modifier_techies_bomb:DeclareFunctions() 
return
{
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
} 
end


function modifier_techies_bomb:GetAbsoluteNoDamageMagical() return 1 end

function modifier_techies_bomb:GetAbsoluteNoDamagePhysical() return 1 end

function modifier_techies_bomb:GetAbsoluteNoDamagePure() return 1 end

function modifier_techies_bomb:AttackEvent_inc( param )
 if not IsServer() then
        return
    end

    if self:GetParent() == param.target then

        self.hits = self.hits - 1
        if self.hits <= 0 then
            self:GetParent():Kill(nil, param.attacker)
        else 
            self:GetParent():SetHealth(self.hits)

        end
    end
end




modifier_techies_bomb_silence = class({})

function modifier_techies_bomb_silence:IsHidden() return false end
function modifier_techies_bomb_silence:IsPurgable() return true end 
function modifier_techies_bomb_silence:CheckState() return {[MODIFIER_STATE_SILENCED] = true} end
function modifier_techies_bomb_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
 
function modifier_techies_bomb_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end


modifier_techies_bomb_cd = class({})

function modifier_techies_bomb_cd:IsHidden() return false end
function modifier_techies_bomb_cd:IsPurgable() return false end