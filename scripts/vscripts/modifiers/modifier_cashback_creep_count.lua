--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_cashback_creep_count = class({})

function modifier_cashback_creep_count:IsHidden() return not self:GetParent():HasModifier("modifier_skill_cashback") end
function modifier_cashback_creep_count:IsPurgable() return false end
function modifier_cashback_creep_count:RemoveOnDeath() return false end
function modifier_cashback_creep_count:AllowIllusionDuplicate() return true end

function modifier_cashback_creep_count:OnCreated()
	if not IsServer() then return end
    self.damage = 0
    self.amp = 0
	self:SetStackCount(0)
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
end

function modifier_cashback_creep_count:Upgrade(cost)
    if not IsServer() then return end
    self.damage = self.damage + (cost / 1000 * 7)
    self.amp = self.amp + (cost / 1000 * 0.2)
    self:SendBuffRefreshToClients()
end

function modifier_cashback_creep_count:AddCustomTransmitterData()
    self.TransmitterTable = self.TransmitterTable or {}

    self.TransmitterTable.damage = self.damage
    self.TransmitterTable.amp = self.amp

    return self.TransmitterTable
end

function modifier_cashback_creep_count:HandleCustomTransmitterData( data )
    self.damage = data.damage
    self.amp = data.amp
end

function modifier_cashback_creep_count:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_cashback_creep_count:GetModifierPreAttack_BonusDamage(params)
    if not self:GetParent():HasModifier("modifier_skill_cashback") then return end
    if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
        _G.Players:QueueAttackBonus(params.attacker, params.target, self.damage, "cashback_creep_bonus", DAMAGE_TYPE_PHYSICAL)
    end
    return self.damage
end

function modifier_cashback_creep_count:GetModifierSpellAmplify_Percentage()
    if not self:GetParent():HasModifier("modifier_skill_cashback") then return end
    return self.amp
end