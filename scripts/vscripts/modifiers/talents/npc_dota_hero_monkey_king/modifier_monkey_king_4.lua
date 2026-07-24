--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_monkey_king_4=class({})

function modifier_monkey_king_4:IsHidden() return true end
function modifier_monkey_king_4:IsPurgable() return false end
function modifier_monkey_king_4:IsPurgeException() return false end
function modifier_monkey_king_4:RemoveOnDeath() return false end

function modifier_monkey_king_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_monkey_king_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_monkey_king_4:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    }
end

function modifier_monkey_king_4:GetModifierAttackRangeBonus()
    return 75
end