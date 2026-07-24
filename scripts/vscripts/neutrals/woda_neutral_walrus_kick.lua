--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_walrus_kick_debuff", "neutrals/woda_neutral_walrus_kick", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )

woda_neutral_walrus_kick = class({})

function woda_neutral_walrus_kick:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/dark_troll_ensnare_proj.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/dark_troll_ensnare.vpcf", context )
end

function woda_neutral_walrus_kick:OnSpellStart(new_caster, new_target)
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 1)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})
    Timers:CreateTimer(0.3, function()
        if not self:GetCaster():IsAlive() then return end
        local knockback = target:AddNewModifier(
            self:GetCaster(),
            self,
            "modifier_generic_knockback_lua",
            {
                direction_x = self:GetCaster():GetForwardVector().x,
                direction_y = self:GetCaster():GetForwardVector().y,
                distance = self:GetSpecialValueFor("range"),
                height = 250,
                duration = 1,
                IsStun = true,
            }
        )
        target:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_walrus_kick_debuff", {duration = (1 + self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance()))})
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tusk/tusk_walruskick_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
        ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 2, target:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        target:EmitSound("Hero_Tusk.WalrusKick.Target")
        self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
    end)
end

modifier_woda_neutral_walrus_kick_debuff = class({})
function modifier_woda_neutral_walrus_kick_debuff:IsPurgable() return true end
function modifier_woda_neutral_walrus_kick_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end
function modifier_woda_neutral_walrus_kick_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("slow")
end