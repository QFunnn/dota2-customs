--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_chaos_knight_chaos_king_bar", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_chaos_king_bar", LUA_MODIFIER_MOTION_NONE)

chaos_knight_chaos_king_bar = class({})

function chaos_knight_chaos_king_bar:Precache(context)
    PrecacheResource("particle", "particles/econ/items/lifestealer/lifestealer_immortal_backbone/chaos_immortal_backbone_rage.vpcf", context)
end

function chaos_knight_chaos_king_bar:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():Purge(false, true, false, false, false)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_chaos_knight_chaos_king_bar", {duration = duration})
    self:GetCaster():EmitSound("DOTA_Item.MinotaurHorn.Cast")
end

modifier_chaos_knight_chaos_king_bar = class({})
function modifier_chaos_knight_chaos_king_bar:IsPurgable() return false end
function modifier_chaos_knight_chaos_king_bar:IsPurgeException() return false end
function modifier_chaos_knight_chaos_king_bar:OnCreated()
    self.health_regen = self:GetAbility():GetSpecialValueFor("health_regen")
    self.magical_resistance = self:GetAbility():GetSpecialValueFor("magical_resistance")
end

function modifier_chaos_knight_chaos_king_bar:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end

function modifier_chaos_knight_chaos_king_bar:CheckState()
    return
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
    }
end

function modifier_chaos_knight_chaos_king_bar:GetModifierConstantHealthRegen()
    return self.health_regen / 100 * self:GetParent():GetManaRegen()
end

function modifier_chaos_knight_chaos_king_bar:GetModifierMagicalResistanceBonus()
    return self.magical_resistance
end

function modifier_chaos_knight_chaos_king_bar:GetEffectName()
    return "particles/econ/items/lifestealer/lifestealer_immortal_backbone/chaos_immortal_backbone_rage.vpcf"
end

function modifier_chaos_knight_chaos_king_bar:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end