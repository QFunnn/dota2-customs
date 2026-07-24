--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


bristleback_hairball_custom = class({})
bristleback_hairball_custom.talents = {}

function bristleback_hairball_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_hairball.vpcf", context )
end

function bristleback_hairball_custom:GetAOERadius()
local bonus = 0
if self.caster.spray_ability and self.caster.spray_ability.talents.w2_radius then
  bonus = self.caster.spray_ability.talents.w2_radius
end 
return self:GetSpecialValueFor("radius") + bonus
end

function bristleback_hairball_custom:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()
local origin = caster:GetAbsOrigin()
local vec = point - origin
local speed = self:GetSpecialValueFor("projectile_speed")

if not IsValid(self.spray) then
  self.spray = caster:FindAbilityByName("bristleback_quill_spray_custom")
end

if not IsValid(self.goo) then
  self.goo = caster:FindAbilityByName("bristleback_viscous_nasal_goo_custom")
end

caster:EmitSound("Hero_Bristleback.Hairball.Cast")

local projectile =
{
  Ability              = self,
  EffectName           = "particles/units/heroes/hero_bristleback/bristleback_hairball.vpcf",
  vSpawnOrigin        = caster:GetAttachmentOrigin(caster:ScriptLookupAttachment("attach_hitloc")),
  fDistance            = vec:Length2D(),
  fStartRadius        = 0,
  fEndRadius            = 0,
  Source                = caster,
  bHasFrontalCone        = false,
  bReplaceExisting    = false,
  iUnitTargetTeam        = DOTA_UNIT_TARGET_TEAM_NONE,
  iUnitTargetFlags    = DOTA_UNIT_TARGET_FLAG_NONE,
  iUnitTargetType        = DOTA_UNIT_TARGET_NONE,
  fExpireTime         = GameRules:GetGameTime() + 5.0,
  bDeleteOnHit        = false,
  vVelocity            = vec:Normalized()*speed*(Vector(1,1,0)),
  bProvidesVision        = false,
}
ProjectileManager:CreateLinearProjectile(projectile)
end

function bristleback_hairball_custom:OnProjectileHit(hTarget, vLocation)
if not IsServer() then return end
local caster = self:GetCaster()
local quill_count = self:GetSpecialValueFor("quill_count")
local goo_count = self:GetSpecialValueFor("goo_count")
local radius = self:GetAOERadius()

AddFOWViewer(caster:GetTeamNumber(), vLocation, radius, 2, false)

local sound_name = wearables_system:GetSoundReplacement(caster, "Hero_Bristleback.ViscousGoo.Cast", self)
EmitSoundOnLocationWithCaster(vLocation, sound_name, caster)

local hit_type = 0
for _,target in pairs(self.caster:FindTargets(radius, vLocation)) do
  if target:IsHero() then
    hit_type = 2
  elseif hit_type == 0 then
    hit_type = 1
  end
  if self.caster.goo_ability then
    for i = 1, goo_count do
        self.caster.goo_ability:AddStack(target)
    end
  end
end

if hit_type ~= 0 and self.caster.warpath_ability and self.caster.warpath_ability.tracker then
  self.caster.warpath_ability.tracker:AddStack(hit_type == 2)
end

if self.caster.spray_ability then
  for i = 1, quill_count do
    Timers:CreateTimer(0.2*(i - 1), function()
      self.caster.spray_ability:MakeSpray(GetGroundPosition(vLocation, nil))
    end)
  end
end

end
