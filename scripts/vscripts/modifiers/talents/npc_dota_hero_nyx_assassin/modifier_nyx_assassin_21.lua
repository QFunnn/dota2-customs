--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nyx_assassin_21=class({})

function modifier_nyx_assassin_21:IsHidden() return true end
function modifier_nyx_assassin_21:IsPurgable() return false end
function modifier_nyx_assassin_21:IsPurgeException() return false end
function modifier_nyx_assassin_21:RemoveOnDeath() return false end

function modifier_nyx_assassin_21:OnCreated()
    self.bonus={0}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_nyx_assassin_21:OnRefresh()
    self.bonus={0}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_nyx_assassin_21:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
         
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
    }
end

function modifier_nyx_assassin_21:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    local dagon_pfx = ParticleManager:CreateParticle("particles/items_fx/dagon.vpcf", PATTACH_RENDERORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(dagon_pfx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), false)
    ParticleManager:SetParticleControlEnt(dagon_pfx, 1, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), false)
    ParticleManager:SetParticleControl(dagon_pfx, 2, Vector(0, 0, 0))
    ParticleManager:SetParticleControl(dagon_pfx, 3, Vector(0.3, 0, 0))
    ParticleManager:ReleaseParticleIndex(dagon_pfx)
end

function modifier_nyx_assassin_21:GetModifierAttackRangeBonus()
    return 450
end

function modifier_nyx_assassin_21:GetModifierBonusStats_Intellect()
    return self.bonus[self:GetStackCount()]
end