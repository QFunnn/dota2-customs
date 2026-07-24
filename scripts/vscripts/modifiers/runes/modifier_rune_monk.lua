--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_monk = class({})

local VALUES = {5,10,15}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_monk:IsHidden() return true end
function modifier_rune_monk:IsPurgable() return false end
function modifier_rune_monk:IsPurgeException() return false end
function modifier_rune_monk:RemoveOnDeath() return false end
function modifier_rune_monk:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_monk:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end

function modifier_rune_monk:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	}
end

function modifier_rune_monk:GetModifierTotal_ConstantBlock(kv)
    if IsServer() then
        local target = self:GetParent()
        if kv.damage > 0 and RollPercentage(GetValue(self)) then
            SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, kv.damage, nil)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            ParticleManager:ReleaseParticleIndex(particle)
            return kv.damage
        end
    end
end