--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_doom_bringer_scorched_earth_custom", "abilities/doom_bringer_scorched_earth", LUA_MODIFIER_MOTION_NONE )

doom_bringer_scorched_earth_custom = class({})

function doom_bringer_scorched_earth_custom:Precache(context)
    PrecacheResource( "particle", 'particles/units/heroes/hero_doom_bringer/doom_scorched_earth.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_doom_bringer/doom_bringer_scorched_earth_debuff.vpcf', context )
end

function doom_bringer_scorched_earth_custom:OnToggle()
	if not IsServer() then return end
    local modifier_doom_bringer_scorched_earth_effect_aura = self:GetCaster():FindModifierByName("modifier_doom_bringer_scorched_earth_effect_aura")
    local modifier_doom_bringer_scorched_earth_custom = self:GetCaster():FindModifierByName("modifier_doom_bringer_scorched_earth_custom")
    if modifier_doom_bringer_scorched_earth_effect_aura then
        modifier_doom_bringer_scorched_earth_effect_aura:Destroy()
        if modifier_doom_bringer_scorched_earth_custom then
            modifier_doom_bringer_scorched_earth_custom:Destroy()
        end
    else
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_doom_bringer_scorched_earth_effect_aura", {})
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_doom_bringer_scorched_earth_custom", {})
    end
end

modifier_doom_bringer_scorched_earth_custom = class({})
function modifier_doom_bringer_scorched_earth_custom:IsHidden() return false end
function modifier_doom_bringer_scorched_earth_custom:IsPurgable() return false end
function modifier_doom_bringer_scorched_earth_custom:IsPurgeException() return false end
function modifier_doom_bringer_scorched_earth_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end
function modifier_doom_bringer_scorched_earth_custom:CheckState()
    if self.has_flying_talent then
        return {
            [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
            -- [A61] без NO_UNIT_COLLISION летающий блокирует наземного врага (коллизия на земле) → застакивание/ловушка в дуэли
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        }
    end
    return {}
end
function modifier_doom_bringer_scorched_earth_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.move_speed_bonus or 0
end
function modifier_doom_bringer_scorched_earth_custom:OnCreated()
    self.move_speed_bonus = self:GetAbility():GetSpecialValueFor("bonus_movement_speed_pct")
    local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_cha_doom_bringer")
    self.has_flying_talent = talent and talent:GetLevel() > 0
    if not IsServer() then return end
    self.mana_cost = self:GetAbility():GetSpecialValueFor("mana_cost")
    self:StartIntervalThink(1)
    self:OnIntervalThink()
end
function modifier_doom_bringer_scorched_earth_custom:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    if parent:HasModifier("modifier_huskar_blood_magic") then
        if parent:GetHealth() > self.mana_cost then
            parent:SetHealth(parent:GetHealth() - self.mana_cost)
        else
            self:GetAbility():ToggleAbility()
            self:Destroy()
        end
    else
        parent:SpendMana(self.mana_cost, self:GetAbility())
        if parent:GetMana() < self.mana_cost then
            self:GetAbility():ToggleAbility()
            self:Destroy()
        end
    end
end