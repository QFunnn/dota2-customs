--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_leshrac_nihilism_custom", "abilities/leshrac/leshrac_nihilism_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_nihilism_custom_aura", "abilities/leshrac/leshrac_nihilism_custom", LUA_MODIFIER_MOTION_NONE )

leshrac_nihilism_custom = class({})

function leshrac_nihilism_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/leshrac/nihilism_caster.vpcf", context )
end

function leshrac_nihilism_custom:Init()
self.caster = self:GetCaster()
self.duration = self:GetLevelSpecialValueFor("duration", 1)
self.damage_inc = self:GetLevelSpecialValueFor("damage_inc", 1)
self.movespeed = self:GetLevelSpecialValueFor("movespeed", 1)
self.slow = self:GetLevelSpecialValueFor("slow", 1)
self.radius = self:GetLevelSpecialValueFor("radius", 1)
end

function leshrac_nihilism_custom:Spawn()
end

function leshrac_nihilism_custom:GetRadius()
return (self.radius and self.radius or 0) + (self.caster.leshrac_innate and self.caster.leshrac_innate:GetRange() or 0)
end

function leshrac_nihilism_custom:GetCastRange(vLocation, hTarget)
return self:GetRadius() - self.caster:GetCastRangeBonus()
end

function leshrac_nihilism_custom:OnSpellStart()

self.caster:AddNewModifier(self.caster, self, "modifier_leshrac_nihilism_custom", {duration = self.duration})
end

modifier_leshrac_nihilism_custom = class(mod_hidden)
function modifier_leshrac_nihilism_custom:IsPurgable() return true end
function modifier_leshrac_nihilism_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetRadius()
self.movespeed = self.ability.movespeed

if not IsServer() then return end
self.ability:EndCd()
self.parent:EmitSound("Hero_Leshrac.Nihilism.Cast")
self.parent:EmitSound("Hero_Leshrac.Nihilism.Target")

self.parent:AddNewModifier(self.parent, self.ability, "modifier_ghost_state", {duration = self:GetRemainingTime()})

local effect_cast = ParticleManager:CreateParticle("particles/leshrac/nihilism_caster.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))
self:AddParticle(effect_cast, false, false, 1, false, false)
end

function modifier_leshrac_nihilism_custom:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
end

function modifier_leshrac_nihilism_custom:CheckState()
return
{
  [MODIFIER_STATE_DISARMED] = false
}
end

function modifier_leshrac_nihilism_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ALWAYS_ETHEREAL_ATTACK,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_leshrac_nihilism_custom:GetAllowEtherealAttack()
return 1
end

function modifier_leshrac_nihilism_custom:GetModifierMoveSpeedBonus_Percentage()
return self.movespeed
end

function modifier_leshrac_nihilism_custom:IsAura() return true end
function modifier_leshrac_nihilism_custom:GetAuraDuration() return 0.1 end
function modifier_leshrac_nihilism_custom:GetAuraRadius() return self.radius end
function modifier_leshrac_nihilism_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_leshrac_nihilism_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_leshrac_nihilism_custom:GetModifierAura() return "modifier_leshrac_nihilism_custom_aura" end


modifier_leshrac_nihilism_custom_aura = class(mod_hidden)
function modifier_leshrac_nihilism_custom_aura:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow = self.ability.slow
self.damage_inc = self.ability.damage_inc
if not IsServer() then return end
self.parent:GenericParticle("particles/items3_fx/witch_blade_debuff.vpcf", self)
end

function modifier_leshrac_nihilism_custom_aura:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_leshrac_nihilism_custom_aura:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_leshrac_nihilism_custom_aura:GetModifierIncomingDamage_Percentage()
return self.damage_inc
end