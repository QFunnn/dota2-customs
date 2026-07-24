--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rubick_fade_lightning_custom", "heroes/npc_dota_hero_rubick_custom/rubick_fade_lightning_custom", LUA_MODIFIER_MOTION_NONE)

rubick_fade_lightning_custom = class({})

rubick_fade_lightning_custom.modifier_rubick_6 = {-1,-2,-3}

function rubick_fade_lightning_custom:GetIntrinsicModifierName()
    return "modifier_rubick_fade_lightning_custom"
end

function rubick_fade_lightning_custom:GetCooldown(level)
    local cooldown = self.BaseClass.GetCooldown( self, level )
    if self:GetCaster():HasModifier("modifier_rubick_6") then
        cooldown = cooldown + self.modifier_rubick_6[self:GetCaster():GetTalentLevel("modifier_rubick_6")]
    end
    return cooldown
end

function rubick_fade_lightning_custom:GetCastRange(vLocation, hTarget)
    return self:GetSpecialValueFor("radius")
end

modifier_rubick_fade_lightning_custom = class({})
function modifier_rubick_fade_lightning_custom:IsHidden() return true end
function modifier_rubick_fade_lightning_custom:IsPurgable() return false end
function modifier_rubick_fade_lightning_custom:IsPurgeException() return false end
function modifier_rubick_fade_lightning_custom:RemoveOnDeath() return false end

function modifier_rubick_fade_lightning_custom:OnCreated()
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.interval = self:GetAbility():GetSpecialValueFor("interval")
    self:GetAbility():StartCooldown(self.interval)
    self:StartIntervalThink(self.interval)
end

function modifier_rubick_fade_lightning_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then
        self:StartIntervalThink(0.5)
        return 
    end
    if self:GetParent():HasModifier("modifier_wodarelax") then
        self:StartIntervalThink(0.5)
        return 
    end
    if self:GetParent():HasModifier("modifier_wodawisp") then
        self:StartIntervalThink(0.5)
        return 
    end
    local max_atacks = self:GetAbility():GetSpecialValueFor("max_atacks")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
    if #units <= 0 then
        self:StartIntervalThink(0.5)
        return
    end
    for _, unit in pairs(units) do
        if unit and unit:IsAlive() then
            local rubick_fade_bolt_custom = self:GetParent():FindAbilityByName("rubick_fade_bolt_custom")
            if rubick_fade_bolt_custom and rubick_fade_bolt_custom:GetLevel() > 0 then
                self:GetCaster():EmitSound("Hero_Rubick.FadeBolt.Cast")
                rubick_fade_bolt_custom:UseFadeBolt(self:GetCaster(), unit, nil, 0, nil, true, true)
                max_atacks = max_atacks - 1
            end
        end
        if max_atacks <= 0 then
            break
        end
    end
    local interval = self.interval
    if self:GetCaster():HasModifier("modifier_rubick_6") then
        interval = interval + self:GetAbility().modifier_rubick_6[self:GetCaster():GetTalentLevel("modifier_rubick_6")]
    end
    interval = interval * self:GetCaster():GetCooldownReduction()
    self:GetAbility():StartCooldown(interval)
    self:StartIntervalThink(interval)
end