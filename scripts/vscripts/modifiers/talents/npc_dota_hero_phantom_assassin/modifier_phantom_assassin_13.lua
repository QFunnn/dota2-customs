--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phantom_assassin_13=class({})

function modifier_phantom_assassin_13:IsHidden() return true end
function modifier_phantom_assassin_13:IsPurgable() return false end
function modifier_phantom_assassin_13:IsPurgeException() return false end
function modifier_phantom_assassin_13:RemoveOnDeath() return false end

function modifier_phantom_assassin_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_phantom_assassin_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_phantom_assassin_13:OnCreated()
	if not IsServer() then return end
	self.bonus = 0
	self.b = {30,15,10}
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end

function modifier_phantom_assassin_13:OnRefresh()
	if not IsServer() then return end
	self.bonus = 0
	self.b = {30,15,10}
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_phantom_assassin_13:OnIntervalThink()
	if not IsServer() then return end
	local evasion = (self:GetCaster():GetEvasion() * 100)
	self.bonus = (evasion / self.b[self:GetStackCount()])
end

function modifier_phantom_assassin_13:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	}
end

function modifier_phantom_assassin_13:GetModifierTotal_ConstantBlock(kv)
    if IsServer() then
        local target = self:GetParent()
        if kv.damage > 0 and RollPercentage(self.bonus) then
            SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, kv.damage, nil)
            ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            return kv.damage
        end
    end
end