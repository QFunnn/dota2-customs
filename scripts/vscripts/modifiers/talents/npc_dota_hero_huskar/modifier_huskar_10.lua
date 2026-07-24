--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_huskar_10=class({})

function modifier_huskar_10:IsHidden() return true end
function modifier_huskar_10:IsPurgable() return false end
function modifier_huskar_10:IsPurgeException() return false end
function modifier_huskar_10:RemoveOnDeath() return false end

function modifier_huskar_10:OnCreated()
    self.bonus = {25,50}
	if not IsServer() then return end
	self:SetStackCount(1)
    local huskar_burning_spear_custom = self:GetParent():FindAbilityByName("huskar_burning_spear_custom")
    if huskar_burning_spear_custom then
        huskar_burning_spear_custom:SetHidden(true)
        huskar_burning_spear_custom:SetActivated(false)
    end
end

function modifier_huskar_10:OnRefresh()
    self.bonus = {25,50}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_huskar_10:DeclareFunctions()
    return
    {
         
    }
end

function modifier_huskar_10:OnAttackLanded( params )
    if params.attacker ~= self:GetParent() then return end
    if RollPercentage(30) then
        local damage = self:GetCaster():GetDisplayAttackSpeed() / 100 * self.bonus[self:GetStackCount()]
        ApplyDamage({victim = params.target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL})
    end
end