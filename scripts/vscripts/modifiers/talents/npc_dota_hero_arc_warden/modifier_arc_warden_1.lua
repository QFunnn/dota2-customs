--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_arc_warden_1=class({})

function modifier_arc_warden_1:IsHidden() return true end
function modifier_arc_warden_1:IsPurgable() return false end
function modifier_arc_warden_1:IsPurgeException() return false end
function modifier_arc_warden_1:RemoveOnDeath() return false end

function modifier_arc_warden_1:OnCreated()
	self.bonus={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_arc_warden_1:OnRefresh()
	self.bonus={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_arc_warden_1:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if not params.target:IsBaseNPC() then return end
    if params.target:IsOther() then return end
    local bonus = self.bonus[self:GetStackCount()]
    local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetParent():Heal(bonus, nil)
end