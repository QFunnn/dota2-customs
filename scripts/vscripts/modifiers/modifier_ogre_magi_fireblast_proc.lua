--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- [NP3-1] Проц Fireblast при автоатаке (талант 25 ур. special_bonus_unique_ogre_magi_3).
-- Интринсик-модификатор на огре (через ogre_magi_fireblast_custom:GetIntrinsicModifierName).
-- При каждой атаке катит шанс ability:GetSpecialValueFor("fireblast_proc") (0 без таланта,
-- 17 с талантом) и при успехе кастует Fireblast в цель.
modifier_ogre_magi_fireblast_proc = class({
    IsHidden        = function(self) return true end,
    IsPurgable      = function(self) return false end,
    IsPurgeException = function(self) return false end,
    IsDebuff        = function(self) return false end,
    RemoveOnDeath   = function(self) return false end,
})

function modifier_ogre_magi_fireblast_proc:DeclareFunctions()
    return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_ogre_magi_fireblast_proc:OnAttackLanded(params)
    if not IsServer() then return end

    local parent = self:GetParent()
    if params.attacker ~= parent then return end

    local target = params.target
    if not target or target:IsNull() then return end
    if target:GetTeamNumber() == parent:GetTeamNumber() then return end

    local ability = self:GetAbility()
    if not ability or ability:IsNull() then return end

    local chance = ability:GetSpecialValueFor("fireblast_proc")
    if chance <= 0 then return end

    if RandomInt(1, 100) <= chance then
        ability:ApplyToTarget(target)
    end
end