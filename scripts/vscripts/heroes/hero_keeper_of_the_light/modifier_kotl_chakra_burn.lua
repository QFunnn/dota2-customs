--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_kotl_chakra_burn = class({})
function modifier_kotl_chakra_burn:IsDebuff()
    return true
end
function modifier_kotl_chakra_burn:IsPurgable()
    return false
end
function modifier_kotl_chakra_burn:IsPurgeException()
    return false
end
function modifier_kotl_chakra_burn:IsHidden()
    return false
end
function modifier_kotl_chakra_burn:OnCreated(params)
    if IsServer() then
        self.hCaster = self:GetCaster()
        self.hAbility = self:GetAbility()
        self.hParent = self:GetParent()
        self.bonus_magic_damage = self.hAbility:GetSpecialValueFor("bonus_magic_damage")
        self.debuff_duration = self.hAbility:GetSpecialValueFor("debuff_duration")
        self.interval_think = 1
        self:SetStackCount(params.stack or 1)
        self:StartIntervalThink(self.interval_think)
        self:OnIntervalThink()
    end
end
function modifier_kotl_chakra_burn:OnRefresh(params)
    if IsServer() then
        self.hCaster = self:GetCaster()
        self.hAbility = self:GetAbility()
        self.hParent = self:GetParent()
        self.bonus_magic_damage = self.hAbility:GetSpecialValueFor("bonus_magic_damage")
        self.debuff_duration = self.hAbility:GetSpecialValueFor("debuff_duration")
        self.interval_think = 1
        self:SetStackCount(params.stack or 1)
        self:StartIntervalThink(self.interval_think)
        self:OnIntervalThink()
    end
end
function modifier_kotl_chakra_burn:OnIntervalThink()
    if IsServer() then
        local flDamage = self.bonus_magic_damage
        local damage = {
            victim = self.hParent,
            attacker = self.hCaster,
            damage = flDamage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self.hAbility
        }
        ApplyDamage(damage)
        EmitSoundOn("Hero_KeeperOfTheLight.ChakraBurn.Target", self.hParent)

        local nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_chakra_burn.vpcf", PATTACH_CUSTOMORIGIN, self.hParent)
        ParticleManager:SetParticleControlEnt(nFXIndex, 1, self.hParent, PATTACH_ABSORIGIN_FOLLOW, nil, self.hParent:GetOrigin(), true)
        ParticleManager:ReleaseParticleIndex(nFXIndex)
    end
end
function modifier_kotl_chakra_burn:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end
function modifier_kotl_chakra_burn:GetModifierMagicalResistanceBonus()
    return -self:GetStackCount()
end