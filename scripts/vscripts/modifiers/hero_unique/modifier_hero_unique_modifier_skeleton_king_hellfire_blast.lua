--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_skeleton_king_hellfire_blast = class({})
function modifier_hero_unique_modifier_skeleton_king_hellfire_blast:IsHidden() 
    -- print(not self.ability, self.ability:IsNull(), self.ability:GetLevel() <= 0)
    return (not self.ability or self.ability:IsNull() or self.ability:GetLevel() <= 0)
end
function modifier_hero_unique_modifier_skeleton_king_hellfire_blast:IsPurgable() return false end
function modifier_hero_unique_modifier_skeleton_king_hellfire_blast:IsPurgeException() return false end
function modifier_hero_unique_modifier_skeleton_king_hellfire_blast:RemoveOnDeath() return false end
function modifier_hero_unique_modifier_skeleton_king_hellfire_blast:DestroyOnExpire() return false end

function modifier_hero_unique_modifier_skeleton_king_hellfire_blast:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
    }
end

function modifier_hero_unique_modifier_skeleton_king_hellfire_blast:OnCreated(params)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()

    if not IsServer() then return end
    self.nextTime = 0
    self.Record = {}
    self:StartIntervalThink(0.033)
end

function modifier_hero_unique_modifier_skeleton_king_hellfire_blast:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    else
        if self:GetRemainingTime() <= 0 then
            self:SetDuration(-1, true)
        end
    end
end

function modifier_hero_unique_modifier_skeleton_king_hellfire_blast:AttackLandedModifier(event)
    if self.parent and self.ability and self.Record[event.record] and self.nextTime <= GameRules:GetGameTime() then
        local Cooldown = self.ability:GetSpecialValueFor("mortal_strike_cooldown")
        self.nextTime = GameRules:GetGameTime() + Cooldown
        self.Record[event.record] = nil

        self:SetDuration(Cooldown, true)

        EmitSoundOn("Hero_SkeletonKing.CriticalStrike", self.parent)
    end
end

function modifier_hero_unique_modifier_skeleton_king_hellfire_blast:GetModifierPreAttack_CriticalStrike(params)
    if not IsServer() or not self.ability or params.attacker ~= self.parent or self.ability:GetLevel() <= 0 then return end

    if self.nextTime <= GameRules:GetGameTime() then
        self.Record[params.record] = true

        local CritValue = self.ability:GetSpecialValueFor("crit_mult")
        if self.parent:HasModifier("modifier_skeleton_king_reincarnation_scepter_active") then
            CritValue = CritValue + self.ability:GetSpecialValueFor("wraith_crit_bonus")
        end

        if _G.Players and _G.Players.QueueCritBonus and params.target then
            _G.Players:QueueCritBonus(params.attacker, params.target, CritValue, "skeleton_king_hellfire_blast_crit")
        end
        return CritValue
    end
end