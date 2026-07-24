--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_bird_tornado_active_tornado", "abilities/neutral_creeps_active/neutral_bird_tornado_active", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bird_tornado_active_tornado_slow", "abilities/neutral_creeps_active/neutral_bird_tornado_active", LUA_MODIFIER_MOTION_NONE )


neutral_bird_tornado_active = class({})


function neutral_bird_tornado_active:OnSpellStart()
local caster = self:GetCaster()

local duration = self:GetSpecialValueFor("duration")
local point = self:GetCursorPosition()

local real_caster = caster.owner and caster.owner or caster

caster:EmitSound("n_creep_Wildkin.SummonTornado")

local tornado = CreateUnitByName("npc_dota_enraged_wildkin_tornado", point, true, nil, nil, real_caster:GetTeamNumber())
tornado:SetOwner(real_caster)
tornado:SetControllableByPlayer(real_caster:GetPlayerOwnerID(), true)
tornado.owner = real_caster

local mod = tornado:AddNewModifier(tornado, self, "modifier_kill", {duration = duration})

if mod then
  tornado:GenericParticle("particles/creatures/enraged_wildkin/enraged_wildkin_tornado.vpcf", mod)
  tornado:AddNewModifier(tornado, self, "modifier_bird_tornado_active_tornado", {})
end

end





modifier_bird_tornado_active_tornado = class(mod_hidden)
function modifier_bird_tornado_active_tornado:IsPurgable() return false end
function modifier_bird_tornado_active_tornado:IsHidden() return true end
function modifier_bird_tornado_active_tornado:CheckState()
return
{
  [MODIFIER_STATE_STUNNED] = true,
  [MODIFIER_STATE_NEUTRALS_DONT_ATTACK] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_bird_tornado_active_tornado:DeclareFunctions() 
return 
{
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
  MODIFIER_PROPERTY_HEALTHBAR_PIPS,
} 
end

function modifier_bird_tornado_active_tornado:GetModifierHealthBarPips() return self.health end
function modifier_bird_tornado_active_tornado:GetAbsoluteNoDamageMagical() return 1 end
function modifier_bird_tornado_active_tornado:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_bird_tornado_active_tornado:GetAbsoluteNoDamagePure() return 1 end

function modifier_bird_tornado_active_tornado:AttackEvent_inc( param )
if not IsServer() then return end
if self.parent ~= param.target then return end

self.health = self.health - 1

if self.health <= 0 then
  self.parent:Kill(nil, param.attacker)
else 
  self.parent:SetHealth(self.health)
end

end


function modifier_bird_tornado_active_tornado:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.health = self.ability:GetSpecialValueFor("health")
self.aoe = self.ability:GetSpecialValueFor("radius")

if not IsServer() then return end
self.parent:AddAttackEvent_inc(self)
end

function modifier_bird_tornado_active_tornado:IsAura() return true end
function modifier_bird_tornado_active_tornado:GetAuraDuration() return 0.1 end
function modifier_bird_tornado_active_tornado:GetAuraRadius() return self.aoe  end
function modifier_bird_tornado_active_tornado:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_bird_tornado_active_tornado:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_bird_tornado_active_tornado:GetModifierAura() return "modifier_bird_tornado_active_tornado_slow" end



modifier_bird_tornado_active_tornado_slow = class({})
function modifier_bird_tornado_active_tornado_slow:IsHidden() return false end
function modifier_bird_tornado_active_tornado_slow:IsPurgable() return true end
function modifier_bird_tornado_active_tornado_slow:GetTexture() return "enraged_wildkin_tornado" end
function modifier_bird_tornado_active_tornado_slow:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.slow = 0

if not self.ability or self.ability:IsNull() then return end

self.slow = self.ability:GetSpecialValueFor("slow")
self.damage = self.ability:GetSpecialValueFor("damage")
self.interval = 0.5

self.damageTable = {attacker = self:GetCaster(), ability = self.ability, damage = self.damage*self.interval, damage_type = DAMAGE_TYPE_MAGICAL, victim = self.parent}

self:OnIntervalThink()
self:StartIntervalThink(0.5)
end

function modifier_bird_tornado_active_tornado_slow:OnIntervalThink()
if not IsServer() then return end
DoDamage(self.damageTable)
end

function modifier_bird_tornado_active_tornado_slow:DeclareFunctions()
return 
{
   MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_bird_tornado_active_tornado_slow:GetModifierAttackSpeedBonus_Constant() 
return self.slow
end