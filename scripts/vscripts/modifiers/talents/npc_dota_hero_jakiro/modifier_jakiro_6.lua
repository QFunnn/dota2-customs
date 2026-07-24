--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_jakiro_6=class({})

function modifier_jakiro_6:IsHidden() return true end
function modifier_jakiro_6:IsPurgable() return false end
function modifier_jakiro_6:IsPurgeException() return false end
function modifier_jakiro_6:RemoveOnDeath() return false end

function modifier_jakiro_6:OnCreated()
    self.vision = {400,800}
    self.speed = {7,14}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_jakiro_6:OnRefresh()
    self.vision = {400,800}
    self.speed = {7,14}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_jakiro_6:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_VISUAL_Z_DELTA
    }
end

function modifier_jakiro_6:GetVisualZDelta()
    return 50
end

function modifier_jakiro_6:GetModifierMoveSpeedBonus_Percentage()
    return self.speed[self:GetStackCount()]
end

function modifier_jakiro_6:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then return end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.vision[self:GetStackCount()], FrameTime(), false)
end

function modifier_jakiro_6:CheckState()
    return
    {
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_OBSTRUCTIONS] = true,
    }
end