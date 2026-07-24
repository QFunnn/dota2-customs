--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lina_slow_burn_custom", "heroes/npc_dota_hero_lina_custom/lina_slow_burn_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lina_slow_burn_custom_debuff", "heroes/npc_dota_hero_lina_custom/lina_slow_burn_custom", LUA_MODIFIER_MOTION_NONE)

lina_slow_burn_custom = class({})
lina_slow_burn_custom.modifier_lina_15 = {3,6}
lina_slow_burn_custom.modifier_lina_16 = {3,6}
lina_slow_burn_custom.modifier_lina_18 = {3,6}
lina_slow_burn_custom.modifier_lina_21 = 38
lina_slow_burn_custom.modifier_lina_21_duration = -2

function lina_slow_burn_custom:GetIntrinsicModifierName()
    return "modifier_lina_slow_burn_custom"
end

modifier_lina_slow_burn_custom = class({})
function modifier_lina_slow_burn_custom:IsHidden() return true end
function modifier_lina_slow_burn_custom:IsPurgable() return false end
function modifier_lina_slow_burn_custom:IsPurgeException() return false end
function modifier_lina_slow_burn_custom:RemoveOnDeath() return false end

function modifier_lina_slow_burn_custom:OnCreated()
    if not IsServer() then return end
    self.burn_duration = self:GetAbility():GetSpecialValueFor("burn_duration")
end

function modifier_lina_slow_burn_custom:OnRefresh()
    self:OnCreated()
end

function modifier_lina_slow_burn_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.inflictor == nil then return end
    if params.inflictor:IsItem() then return end
    if params.inflictor == self:GetAbility() then return end
    if params.inflictor:GetAbilityName() == "lina_fiery_soul_custom" then return end
    local burn_pct = self:GetAbility():GetSpecialValueFor("burn_damage_pct")
    if self:GetCaster():HasModifier("modifier_lina_15") then
        burn_pct = burn_pct + self:GetAbility().modifier_lina_15[self:GetCaster():GetTalentLevel("modifier_lina_15")]
    end
    if self:GetCaster():HasModifier("modifier_lina_16") then
        burn_pct = burn_pct + self:GetAbility().modifier_lina_16[self:GetCaster():GetTalentLevel("modifier_lina_16")]
    end
    if self:GetCaster():HasModifier("modifier_lina_18") then
        burn_pct = burn_pct + self:GetAbility().modifier_lina_18[self:GetCaster():GetTalentLevel("modifier_lina_18")]
    end
    if self:GetCaster():HasModifier("modifier_lina_21") then
        burn_pct = burn_pct + self:GetAbility().modifier_lina_21
    end
    local burn_duration = self:GetAbility():GetSpecialValueFor("burn_duration")
    if self:GetCaster():HasModifier("modifier_lina_21") then
        burn_duration = burn_duration + self:GetAbility().modifier_lina_21_duration
    end
    params.unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lina_slow_burn_custom_debuff", {duration = burn_duration, damage = burn_pct / 100 * params.damage})
end

modifier_lina_slow_burn_custom_debuff = class({})

function modifier_lina_slow_burn_custom_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_lina_slow_burn_custom_debuff:OnCreated(params)
    if not IsServer() then return end
    self.tick_damage = params.damage / self:GetDuration()
    if self:GetCaster():HasModifier("modifier_lina_21") then
        self.tick_damage = self.tick_damage * 0.5
        self:StartIntervalThink(0.5)
    else
        self:StartIntervalThink(1)
    end
end

function modifier_lina_slow_burn_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), damage = self.tick_damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self:GetAbility()})
end

function modifier_lina_slow_burn_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_lina_slow_burn_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end