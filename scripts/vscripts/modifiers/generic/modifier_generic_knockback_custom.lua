--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_generic_knockback_custom", "modifiers/generic/modifier_generic_knockback_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

modifier_generic_knockback_custom = class({})

function modifier_generic_knockback_custom:IsHidden() return true end
function modifier_generic_knockback_custom:IsPurgable() return true end

function modifier_generic_knockback_custom:OnCreated(params)
if not IsServer() then return end
  
self.ability        = self:GetAbility()
self.caster         = self:GetCaster()
self.parent         = self:GetParent()

self:GetParent():StartGesture(ACT_DOTA_FLAIL)
  
self.position = GetGroundPosition(Vector(params.x, params.y, 0), nil)


self.knockback_duration   = self:GetRemainingTime()

self.knockback_distance   = params.max_distance
  
if params.from_center == 1 then 
 	--self.knockback_distance   = math.max((params.max_distance + params.min_distance)  - (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D(),  self:GetAbility().params.max_distance)
  
end


self.knockback_speed    = self.knockback_distance / self.knockback_duration
  
  
if self:ApplyHorizontalMotionController() == false then 
  self:Destroy()
  return
end

end

function modifier_generic_knockback_custom:UpdateHorizontalMotion( me, dt )
  if not IsServer() then return end

  local distance = (me:GetOrigin() - self.position):Normalized()
  
  me:SetOrigin( me:GetOrigin() + distance * self.knockback_speed * dt )

  GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.parent:GetHullRadius(), true )
end

function modifier_generic_knockback_custom:DeclareFunctions()
  local decFuncs = {
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }

    return decFuncs
end

function modifier_generic_knockback_custom:GetOverrideAnimation()
   return ACT_DOTA_FLAIL
end


function modifier_generic_knockback_custom:OnDestroy()
if not IsServer() then return end
self.parent:RemoveHorizontalMotionController( self )
self:GetParent():FadeGesture(ACT_DOTA_FLAIL)


end