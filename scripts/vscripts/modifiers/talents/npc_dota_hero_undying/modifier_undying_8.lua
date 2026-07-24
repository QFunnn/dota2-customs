--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_undying_8=class({})

function modifier_undying_8:IsHidden() return true end
function modifier_undying_8:IsPurgable() return false end
function modifier_undying_8:IsPurgeException() return false end
function modifier_undying_8:RemoveOnDeath() return false end

function modifier_undying_8:OnCreated()
	self.bonus = {8,16}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_undying_8:OnRefresh()
	self.bonus = {8,16}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_undying_8:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if not params.target:IsBaseNPC() then return end
    if params.target:IsOther() then return end
    local bonus = self.bonus[self:GetStackCount()]
    local particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetParent():Heal(bonus, nil)
end