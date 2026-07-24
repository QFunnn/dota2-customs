--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_nyx_assassin_innate_custom", "abilities/nyx_assassin/nyx_assassin_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_innate_custom_perma", "abilities/nyx_assassin/nyx_assassin_innate_custom", LUA_MODIFIER_MOTION_NONE )

nyx_assassin_innate_custom = class({})
nyx_assassin_innate_custom.talents = {}

function nyx_assassin_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_nyx_assassin.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_nyx_assassin", context)
end

function nyx_assassin_innate_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_gold = 0,
    gold_inc = 0,
    move_inc = 0,

    has_h4 = 0,
    h4_radius = caster:GetTalentValue("modifier_nyx_hero_4", "radius", true),
    h4_cdr = caster:GetTalentValue("modifier_nyx_hero_4", "cdr", true),
    h4_max = caster:GetTalentValue("modifier_nyx_hero_4", "max", true),
    h4_damage = caster:GetTalentValue("modifier_nyx_hero_4", "damage", true),
  }
end

if caster:HasTalent("modifier_nyx_hero_3") then
    self.talents.has_gold = 1
    self.talents.move_inc = caster:GetTalentValue("modifier_nyx_hero_3", "move")
    self.talents.gold_inc = caster:GetTalentValue("modifier_nyx_hero_3", "gold")
end

if caster:HasTalent("modifier_nyx_hero_4") then
  self.talents.has_h4 = 1
end

end


function nyx_assassin_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_nyx_assassin_innate_custom"
end

modifier_nyx_assassin_innate_custom = class(mod_hidden)
function modifier_nyx_assassin_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.radius = self.ability:GetSpecialValueFor("radius")    
self.blue = self.ability:GetSpecialValueFor("blue")      
self.kill_radius = self.ability:GetSpecialValueFor("kill_radius")

self.shard_blue = self.ability:GetSpecialValueFor("shard_blue")

self.parent:AddDeathEvent(self, true)
end

function modifier_nyx_assassin_innate_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_nyx_assassin_innate_custom:GetModifierMoveSpeedBonus_Constant()
return self.ability.talents.move_inc
end


function modifier_nyx_assassin_innate_custom:IsAura() return true end
function modifier_nyx_assassin_innate_custom:GetAuraDuration() return 0.5 end
function modifier_nyx_assassin_innate_custom:GetAuraRadius() return self.radius end
function modifier_nyx_assassin_innate_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_nyx_assassin_innate_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_nyx_assassin_innate_custom:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end
function modifier_nyx_assassin_innate_custom:GetModifierAura() return "modifier_generic_vision" end
function modifier_nyx_assassin_innate_custom:GetAuraEntityReject(hEntity)
return not players[hEntity:GetId()] or players[hEntity:GetId()] ~= hEntity
end

function modifier_nyx_assassin_innate_custom:DeathEvent(params)
if not IsServer() then return end
if not params.unit:IsValidKill(self.parent) then return end

local attacker = params.attacker 

if attacker.owner then 
    attacker = attacker.owner
end 

if ((self.parent:GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() > self.kill_radius) and attacker ~= self.parent then return end

local blue = self.parent:HasShard() and (self.blue + self.shard_blue) or self.blue
dota1x6:AddBluePoints(self.parent, blue)

if self.ability.talents.has_gold == 1 then
    self.parent:GiveGold(self.ability.talents.gold_inc, true)
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_nyx_assassin_innate_custom_perma", {})
end



modifier_nyx_assassin_innate_custom_perma = class(mod_hidden)
function modifier_nyx_assassin_innate_custom_perma:IsHidden() return self.ability.talents.has_h4 == 0 or self:GetStackCount() >= self.ability.talents.h4_max end
function modifier_nyx_assassin_innate_custom_perma:RemoveOnDeath() return false end
function modifier_nyx_assassin_innate_custom_perma:GetTexture() return "buffs/nyx_assassin/hero_5" end
function modifier_nyx_assassin_innate_custom_perma:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.h4_max
self.cdr = self.ability.talents.h4_cdr/self.max
self.damage = self.ability.talents.h4_damage/self.max

if not IsServer() then return end 
self:StartIntervalThink(2)
self:SetStackCount(1)
end 

function modifier_nyx_assassin_innate_custom_perma:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()
end 

function modifier_nyx_assassin_innate_custom_perma:OnIntervalThink()
if not IsServer() then return end
if self.ability.talents.has_h4 == 0 then return end 
if self:GetStackCount() < self.max then return end 

self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 

function modifier_nyx_assassin_innate_custom_perma:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_nyx_assassin_innate_custom_perma:GetModifierPercentageCooldown()
if self.ability.talents.has_h4 == 0 then return end 
return self.cdr*self:GetStackCount()
end

function modifier_nyx_assassin_innate_custom_perma:GetModifierSpellAmplify_Percentage()
if self.ability.talents.has_h4 == 0 then return end 
return self.damage*self:GetStackCount()
end

function modifier_nyx_assassin_innate_custom_perma:GetModifierDamageOutgoing_Percentage()
if self.ability.talents.has_h4 == 0 then return end 
return self.damage*self:GetStackCount()
end