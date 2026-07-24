--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sniper_take_aim_custom_active", "heroes/npc_dota_hero_sniper_custom/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_take_aim_custom", "heroes/npc_dota_hero_sniper_custom/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )

sniper_take_aim_custom = class({})
sniper_take_aim_custom.modifier_sniper_8 = {25,50,75}
sniper_take_aim_custom.modifier_sniper_9 = {0.75,1.5}

function sniper_take_aim_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_take_aim_overhead.vpcf", context )
end

function sniper_take_aim_custom:GetIntrinsicModifierName()
    return "modifier_sniper_take_aim_custom"
end

function sniper_take_aim_custom:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_sniper_9") then
        duration = duration + self.modifier_sniper_9[self:GetCaster():GetTalentLevel("modifier_sniper_9")]
    end
    caster:EmitSound("Hero_Sniper.TakeAim.Cast")
    caster:AddNewModifier(caster, self, "modifier_sniper_take_aim_custom_active", {duration = duration})
    if not caster:HasModifier("modifier_sniper_14") then
        caster:AddNewModifier(caster, self, "modifier_sniper_take_aim_bonus", {duration = duration})
    end
end

modifier_sniper_take_aim_custom = class({})
function modifier_sniper_take_aim_custom:IsHidden() return true end
function modifier_sniper_take_aim_custom:IsPurgable() return false end
function modifier_sniper_take_aim_custom:IsPurgeException() return false end
function modifier_sniper_take_aim_custom:RemoveOnDeath() return false end
function modifier_sniper_take_aim_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    }
end
function modifier_sniper_take_aim_custom:GetModifierAttackRangeBonus()
    return self:GetAbility():GetSpecialValueFor("passive_attack_range_bonus")
end

modifier_sniper_take_aim_custom_active = class({})
function modifier_sniper_take_aim_custom_active:IsHidden() return not self:GetCaster():HasModifier("modifier_sniper_14") end
function modifier_sniper_take_aim_custom_active:IsPurgable() return true end
function modifier_sniper_take_aim_custom_active:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_sniper_take_aim_custom_active:GetModifierMoveSpeedBonus_Percentage()
    if not self:GetCaster():HasModifier("modifier_sniper_14") then return end
    return -self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_sniper_take_aim_custom_active:GetModifierAttackRangeBonus()
    if not self:GetCaster():HasModifier("modifier_sniper_14") then return end
    return self:GetAbility():GetSpecialValueFor("active_attack_range_bonus")
end

function modifier_sniper_take_aim_custom_active:GetModifierAttackSpeedBonus_Constant()
    if self:GetCaster():HasModifier("modifier_sniper_8") then
        return self:GetAbility().modifier_sniper_8[self:GetCaster():GetTalentLevel("modifier_sniper_8")]
    end
end

function modifier_sniper_take_aim_custom_active:CheckState()
    if not self:GetCaster():HasModifier("modifier_sniper_14") then return end
    return
    {
        [MODIFIER_STATE_FORCED_FLYING_VISION] = true,
    }
end