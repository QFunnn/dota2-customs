--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_undying_hypnodancer_custom", "heroes/npc_dota_hero_undying_custom/undying_hypnodancer_custom", LUA_MODIFIER_MOTION_NONE)

undying_hypnodancer_custom = class({})

undying_hypnodancer_custom.modifier_undying_4 = {-5,-10,-15}
undying_hypnodancer_custom.modifier_undying_5 = {50,100}

function undying_hypnodancer_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_undying_4") then
        bonus = self.modifier_undying_4[self:GetCaster():GetTalentLevel("modifier_undying_4")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function undying_hypnodancer_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_hypnodancer_custom", {duration = duration + 0.1})
end

modifier_undying_hypnodancer_custom = class({})
function modifier_undying_hypnodancer_custom:IsPurgable() return false end
function modifier_undying_hypnodancer_custom:OnCreated()
    if not IsServer() then return end
    self:GetParent():EmitSound("undying_dance")
    self.cast_interval = self:GetAbility():GetSpecialValueFor("interval")
    self:OnIntervalThink()
    self:StartIntervalThink(FrameTime())
end

function modifier_undying_hypnodancer_custom:OnIntervalThink()
    if not IsServer() then return end
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local interval = self:GetAbility():GetSpecialValueFor("interval")
    self.cast_interval = self.cast_interval + FrameTime()
    if self.cast_interval >= interval then
        local undying_decay_custom = self:GetParent():FindAbilityByName("undying_decay_custom")
        if undying_decay_custom then
            undying_decay_custom:DecayCast(self:GetCaster():GetAbsOrigin(), self:GetParent(), radius)
        end
        self.cast_interval = 0
    end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), radius, FrameTime(), false)
end

function modifier_undying_hypnodancer_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():StopSound("undying_dance")
    self:GetParent():RemoveGesture(ACT_DOTA_FLAIL)
    local parent = self:GetParent()
    Timers:CreateTimer(0.1, function()
        parent:RemoveGesture(ACT_DOTA_FLAIL)
    end)
end

function modifier_undying_hypnodancer_custom:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_undying_hypnodancer_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_VISUAL_Z_DELTA,
        MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
	}
end

function modifier_undying_hypnodancer_custom:GetVisualZDelta()
    return 100
end

function modifier_undying_hypnodancer_custom:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_undying_hypnodancer_custom:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_undying_hypnodancer_custom:GetModifierPercentageManacostStacking(params)
    if self:GetCaster():HasModifier("modifier_undying_5") then
	    return self:GetAbility().modifier_undying_5[self:GetCaster():GetTalentLevel("modifier_undying_5")]
    end
end