--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_strike", "abilities/npc_ogre_stun", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_strike_debuff", "abilities/npc_ogre_stun", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ogre_stun_cd", "abilities/npc_ogre_stun", LUA_MODIFIER_MOTION_NONE)


npc_ogre_stun = class({})

function npc_ogre_stun:OnSpellStart()

    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_ogre_stun_cd", {duration = self:GetCooldownTimeRemaining()})
    local point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * self:GetSpecialValueFor("range")
    CreateModifierThinker(self:GetCaster(), self, "modifier_strike", {duration = FrameTime()}, point, self:GetCaster():GetTeamNumber(), false)

end


modifier_strike = class({})

function modifier_strike:IsHidden() return false end

function modifier_strike:GetTexture() return "elder_titan_echo_stomp" end

function modifier_strike:IsPurgable() return false end

function modifier_strike:IsAura() return true end

function modifier_strike:GetAuraDuration() return 0.1 end

function modifier_strike:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end

function modifier_strike:OnDestroy(table)
    if not IsServer() then return end

            self:GetCaster():EmitSound("Hero_Centaur.HoofStomp")
    local nFXIndex = ParticleManager:CreateParticle( "particles/act_2/ogre_seal_suprise.vpcf", PATTACH_WORLDORIGIN,  self:GetCaster()  )
            ParticleManager:SetParticleControl( nFXIndex, 0, self:GetParent():GetOrigin() )
            ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 50, 50, 50 ) )
            ParticleManager:ReleaseParticleIndex( nFXIndex )


end    

function modifier_strike:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end

function modifier_strike:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end

function modifier_strike:GetModifierAura() return "modifier_strike_debuff" end

modifier_strike_debuff = class ({})

function modifier_strike_debuff:IsPurgable() return false end

function modifier_strike_debuff:GetTexture() return "elder_titan_echo_stomp" end

function modifier_strike_debuff:IsHidden() return true end

function modifier_strike_debuff:OnCreated(table)
        if not IsServer() then return end
        local damage = self:GetAbility():GetSpecialValueFor("damage")
        local duration = self:GetAbility():GetSpecialValueFor("duration")
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = duration*(1 - self:GetParent():GetStatusResistance())})
        DoDamage({ victim = self:GetParent(), attacker = self:GetAbility():GetCaster(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
end

modifier_ogre_stun_cd = class({})

function modifier_ogre_stun_cd:IsHidden() return false end
function modifier_ogre_stun_cd:IsPurgable() return false end