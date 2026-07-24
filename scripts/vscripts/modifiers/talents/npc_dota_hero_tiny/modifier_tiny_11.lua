--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tiny_11=class({})

function modifier_tiny_11:IsHidden() return true end
function modifier_tiny_11:IsPurgable() return false end
function modifier_tiny_11:IsPurgeException() return false end
function modifier_tiny_11:RemoveOnDeath() return false end

function modifier_tiny_11:OnCreated()
	self.bonus={6,12}
    self.bonus2={3,6}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_tiny_11:OnRefresh()
	self.bonus={6,12}
    self.bonus2={3,6}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tiny_11:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EVASION_CONSTANT,
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	}
end

function modifier_tiny_11:GetModifierEvasion_Constant()
	return self.bonus[self:GetStackCount()]
end

function modifier_tiny_11:GetModifierTotal_ConstantBlock(kv)
    if IsServer() then
        local target = self:GetParent()
        if kv.damage > 0 and RollPercentage(self.bonus2[self:GetStackCount()]) then
            SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, kv.damage, nil)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            ParticleManager:ReleaseParticleIndex(particle)
            return kv.damage
        end
    end
end