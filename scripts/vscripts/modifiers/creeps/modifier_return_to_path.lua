--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]





modifier_return_to_path = class({})

function modifier_return_to_path:IsHidden() return false end
function modifier_return_to_path:IsPurgable() return false end
function modifier_return_to_path:CheckState()
return
{
  [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
  [MODIFIER_STATE_INVULNERABLE] = true,
  [MODIFIER_STATE_DISARMED] = true,
  [MODIFIER_STATE_SILENCED] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_return_to_path:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_return_to_path:GetModifierMoveSpeedBonus_Percentage() 
return 50 
end

function modifier_return_to_path:OnCreated(table)
self.parent = self:GetParent()

if not IsServer() then return end
self.point = self.parent:GetPathPoint()
self:OnIntervalThink()
self:StartIntervalThink(0.3)
end


function modifier_return_to_path:OnIntervalThink()
if not IsServer() then return end

if (self.parent:GetAbsOrigin() - self.point):Length2D() <= 300 then
	self:Destroy()
	return
end

self.parent:MoveToPosition(self.point)
end

