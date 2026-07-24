--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_keeper_of_the_light_spirit_form_custom", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_spirit_form_custom", LUA_MODIFIER_MOTION_NONE)

keeper_of_the_light_spirit_form_custom = class({})
keeper_of_the_light_spirit_form_custom.modifier_keeper_of_the_light_14 = 250
keeper_of_the_light_spirit_form_custom.modifier_keeper_of_the_light_14_duration = -25

function keeper_of_the_light_spirit_form_custom:OnUpgrade( level )
	if not IsServer() then return end
	local keeper_of_the_light_radiant_bind = self:GetCaster():FindAbilityByName( "keeper_of_the_light_radiant_bind" )
	if keeper_of_the_light_radiant_bind then
		keeper_of_the_light_radiant_bind:SetLevel(keeper_of_the_light_radiant_bind:GetLevel() + 1)
	end
end

function keeper_of_the_light_spirit_form_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_20") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function keeper_of_the_light_spirit_form_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_20") then
        return 0
    end
    return self.BaseClass.GetCooldown(self, iLevel)
end

function keeper_of_the_light_spirit_form_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_20") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function keeper_of_the_light_spirit_form_custom:GetIntrinsicModifierName()
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_20") then
        return "modifier_keeper_of_the_light_spirit_form_custom"
    end
end

function keeper_of_the_light_spirit_form_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_14") then
        duration = duration + self.modifier_keeper_of_the_light_14_duration
    end
    self:GetCaster():EmitSound("Hero_KeeperOfTheLight.SpiritForm")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_keeper_of_the_light_spirit_form_custom", {duration = duration})
end

modifier_keeper_of_the_light_spirit_form_custom = class({})
function modifier_keeper_of_the_light_spirit_form_custom:IsPurgable() return false end
function modifier_keeper_of_the_light_spirit_form_custom:IsPurgeException() return false end
function modifier_keeper_of_the_light_spirit_form_custom:OnCreated()
    self.movement_speed = self:GetAbility():GetSpecialValueFor("movement_speed")
    self.cast_range = self:GetAbility():GetSpecialValueFor("cast_range")
    if not IsServer() then return end
    local keeper_of_the_light_radiant_bind = self:GetCaster():FindAbilityByName("keeper_of_the_light_radiant_bind")
    if keeper_of_the_light_radiant_bind then
        keeper_of_the_light_radiant_bind:SetHidden(false)
        keeper_of_the_light_radiant_bind:SetActivated(true)
    end
end

function modifier_keeper_of_the_light_spirit_form_custom:OnDestroy()
    if not IsServer() then return end
    local keeper_of_the_light_illuminate_end_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_illuminate_end_custom")
    if keeper_of_the_light_illuminate_end_custom then
        keeper_of_the_light_illuminate_end_custom:OnSpellStart()
    end
    if not self:GetParent():HasModifier("modifier_keeper_of_the_light_16") then
        local keeper_of_the_light_radiant_bind = self:GetCaster():FindAbilityByName("keeper_of_the_light_radiant_bind")
        if keeper_of_the_light_radiant_bind then
            keeper_of_the_light_radiant_bind:SetHidden(true)
            keeper_of_the_light_radiant_bind:SetActivated(false)
        end
    end
end

function modifier_keeper_of_the_light_spirit_form_custom:OnRefresh()
    self:OnCreated()
end

function modifier_keeper_of_the_light_spirit_form_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
        MODIFIER_PROPERTY_BONUS_NIGHT_VISION
    }
end

function modifier_keeper_of_the_light_spirit_form_custom:GetBonusNightVision()
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_14") then
        return 1000
    end
end

function modifier_keeper_of_the_light_spirit_form_custom:GetModifierProjectileSpeedBonus()
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_14") then
        return self:GetAbility().modifier_keeper_of_the_light_14
    end
end

function modifier_keeper_of_the_light_spirit_form_custom:GetModifierAttackRangeBonus()
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_14") then
        return self:GetAbility().modifier_keeper_of_the_light_14
    end
end

function modifier_keeper_of_the_light_spirit_form_custom:CheckState()
    return
    {
        [MODIFIER_STATE_FORCED_FLYING_VISION] = self:GetCaster():HasModifier("modifier_keeper_of_the_light_14")
    }
end

function modifier_keeper_of_the_light_spirit_form_custom:GetModifierMoveSpeedBonus_Constant()
    local keeper_of_the_light_bright_speed = self:GetCaster():FindAbilityByName("keeper_of_the_light_bright_speed")
    return self.movement_speed / 100 * keeper_of_the_light_bright_speed:GetSpecialValueFor("current_speed")
end

function modifier_keeper_of_the_light_spirit_form_custom:GetModifierCastRangeBonus()
    return self.cast_range
end

function modifier_keeper_of_the_light_spirit_form_custom:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_spirit_form_ambient.vpcf"
end

function modifier_keeper_of_the_light_spirit_form_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_keeper_spirit_form.vpcf"
end

function modifier_keeper_of_the_light_spirit_form_custom:StatusEffectPriority()
    return 10
end