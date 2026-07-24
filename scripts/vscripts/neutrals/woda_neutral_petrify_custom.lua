--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_woda_neutral_petrify_custom", "neutrals/woda_neutral_petrify_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_woda_neutral_petrify_custom_debuff", "neutrals/woda_neutral_petrify_custom", LUA_MODIFIER_MOTION_NONE )

woda_neutral_petrify_custom = class({})

function woda_neutral_petrify_custom:GetIntrinsicModifierName()
    return "modifier_woda_neutral_petrify_custom"
end

modifier_woda_neutral_petrify_custom = class({})
function modifier_woda_neutral_petrify_custom:IsHidden() return true end
function modifier_woda_neutral_petrify_custom:IsPurgable() return false end
function modifier_woda_neutral_petrify_custom:IsPurgeException() return false end
function modifier_woda_neutral_petrify_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not self:GetAbility():IsFullyCastable() then return end
    params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_woda_neutral_petrify_custom_debuff", {duration = self:GetAbility():GetSpecialValueFor("duration") * (1-params.target:GetStatusResistance())})
    self:GetAbility():UseResources(false, false, false, true)
    params.target:EmitSound("n_creep_Spawnlord.Freeze")
end

modifier_woda_neutral_petrify_custom_debuff = class({})

function modifier_woda_neutral_petrify_custom_debuff:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/neutral_fx/prowler_shaman_shamanistic_ward.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetAbsOrigin() )
    self:AddParticle(particle, false, false, -1, false, false)
    self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("tick_interval")-FrameTime())
end

function modifier_woda_neutral_petrify_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetParent():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("damage")
    ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
end

function modifier_woda_neutral_petrify_custom_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_ROOTED] = true
    }
end