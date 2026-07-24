--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ursa_maul_custom", "heroes/npc_dota_hero_ursa_custom/ursa_maul_custom", LUA_MODIFIER_MOTION_NONE)

ursa_maul_custom = class({})
ursa_maul_custom.modifier_ursa_2 = {0.25,0.5}

function ursa_maul_custom:GetIntrinsicModifierName()
    return "modifier_ursa_maul_custom"
end

modifier_ursa_maul_custom = class({})
function modifier_ursa_maul_custom:IsHidden() return true end
function modifier_ursa_maul_custom:IsPurgable() return false end
function modifier_ursa_maul_custom:RemoveOnDeath() return false end

function modifier_ursa_maul_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_ursa_maul_custom:GetModifierPreAttack_BonusDamage()
    local percent_damage = self:GetAbility():GetSpecialValueFor("health_as_damage_pct")
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_ursa_2") then
        bonus = self:GetAbility().modifier_ursa_2[self:GetCaster():GetTalentLevel("modifier_ursa_2")]
    end
    if self:GetCaster():HasModifier("modifier_ursa_18") then
        return self:GetCaster():GetMana() / 100 * (percent_damage + bonus)
    end
    return self:GetCaster():GetHealth() / 100 * (percent_damage + bonus)
end