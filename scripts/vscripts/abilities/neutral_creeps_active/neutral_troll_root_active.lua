--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_troll_root_active_effect", "abilities/neutral_creeps_active/neutral_troll_root_active", LUA_MODIFIER_MOTION_NONE )

neutral_troll_root_active = class({})


function neutral_troll_root_active:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

caster:EmitSound("n_creep_TrollWarlord.Ensnare")
local speed = self:GetSpecialValueFor("speed")
local info = 
{
  Target = target,
  Source = caster,
  Ability = self, 
  EffectName = "particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net_projectile.vpcf",
  iMoveSpeed = speed,
  bReplaceExisting = false,                         
  bProvidesVision = true,                           
  iVisionRadius = 450,        
  iVisionTeamNumber = caster:GetTeamNumber()        
}
ProjectileManager:CreateTrackingProjectile(info)
end



function neutral_troll_root_active:OnProjectileHit(hTarget, vLocation)
if not IsServer() then return end
if hTarget==nil then return end
if hTarget:TriggerSpellAbsorb( self ) then return end
local caster = self:GetCaster()

hTarget:EmitSound("Hero_Meepo.Earthbind.Target")
hTarget:AddNewModifier(caster, self, "modifier_troll_root_active_effect", {duration = (1 - hTarget:GetStatusResistance())*self:GetSpecialValueFor("duration")})
end


modifier_troll_root_active_effect = class(mod_hidden)
function modifier_troll_root_active_effect:IsPurgable() return true end
function modifier_troll_root_active_effect:OnCreated(table)
self:GetParent():GenericParticle("particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net.vpcf", self)
end

function modifier_troll_root_active_effect:CheckState()
return
{
  [MODIFIER_STATE_ROOTED] = true
}
end