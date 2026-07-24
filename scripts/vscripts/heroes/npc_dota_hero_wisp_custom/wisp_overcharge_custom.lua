--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wisp_overcharge_custom", "heroes/npc_dota_hero_wisp_custom/wisp_overcharge_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_overcharge_custom_magic_immune", "heroes/npc_dota_hero_wisp_custom/wisp_overcharge_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_overcharge_custom_debuff", "heroes/npc_dota_hero_wisp_custom/wisp_overcharge_custom", LUA_MODIFIER_MOTION_NONE)

wisp_overcharge_custom = class({})
wisp_overcharge_custom.modifier_wisp_3 = {50,100}
wisp_overcharge_custom.modifier_wisp_5 = {0.5,1,1.5}
wisp_overcharge_custom.modifier_wisp_5_regen = {0.1,0.2,0.3}
wisp_overcharge_custom.modifier_wisp_13 = {0.8,1.6}
wisp_overcharge_custom.modifier_wisp_9_attack_speed = {15,30,45}
wisp_overcharge_custom.modifier_wisp_9_spell_amp = {2,4,6}

function wisp_overcharge_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_overcharge.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_wisp.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_wisp.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_wisp.vpcf", context)
end

function wisp_overcharge_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_wisp_5") then
        duration = duration + self.modifier_wisp_5[self:GetCaster():GetTalentLevel("modifier_wisp_5")]
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_wisp_overcharge_custom", {duration = duration})
    if self:GetCaster():HasModifier("modifier_wisp_13") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_wisp_overcharge_custom_magic_immune", {duration = self.modifier_wisp_13[self:GetCaster():GetTalentLevel("modifier_wisp_13")]})
        local modifier_wisp_tether_custom = self:GetCaster():FindModifierByName("modifier_wisp_tether_custom")
        if modifier_wisp_tether_custom and modifier_wisp_tether_custom.target and modifier_wisp_tether_custom.target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
            modifier_wisp_tether_custom.target:AddNewModifier(self:GetCaster(), self, "modifier_wisp_overcharge_custom_magic_immune", {duration = self.modifier_wisp_13[self:GetCaster():GetTalentLevel("modifier_wisp_13")]})
        end
    end
end

modifier_wisp_overcharge_custom = class({})

function modifier_wisp_overcharge_custom:OnCreated()
    self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
    self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.bonus_spell_amp = self:GetAbility():GetSpecialValueFor("bonus_spell_amp")
    self.overcharge_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_overcharge.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(self.overcharge_pfx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(self.overcharge_pfx, false, false, -1, false, false)
    if not IsServer() then return end
    if self:GetParent() == self:GetCaster() then
        EmitSoundOn("Hero_Wisp.Overcharge", self:GetParent())
    end
    self:StartIntervalThink(FrameTime())
end

function modifier_wisp_overcharge_custom:OnDestroy()
    if not IsServer() then return end
    if self:GetParent() == self:GetCaster() then
        StopSoundOn("Hero_Wisp.Overcharge", self:GetParent())
    end
end

function modifier_wisp_overcharge_custom:OnRefresh()
    self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
    self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.bonus_spell_amp = self:GetAbility():GetSpecialValueFor("bonus_spell_amp")
end

function modifier_wisp_overcharge_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent() == self:GetCaster() then
        local modifier_wisp_tether_custom = self:GetParent():FindModifierByName("modifier_wisp_tether_custom")
        if modifier_wisp_tether_custom then
            if modifier_wisp_tether_custom.target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
                modifier_wisp_tether_custom.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_overcharge_custom", {})
            else
                modifier_wisp_tether_custom.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_overcharge_custom_debuff", {})
            end
        end
    else
        if not self:GetCaster():HasModifier("modifier_wisp_overcharge_custom") then
            self:Destroy()
        end
    end
end

function modifier_wisp_overcharge_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_wisp_overcharge_custom:GetModifierHealthRegenPercentage()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_wisp_5") then
        bonus = self:GetAbility().modifier_wisp_5_regen[self:GetCaster():GetTalentLevel("modifier_wisp_5")]
    end
    return self.hp_regen + bonus
end

function modifier_wisp_overcharge_custom:GetModifierAttackSpeedBonus_Constant()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_wisp_9") then
        bonus = self:GetAbility().modifier_wisp_9_attack_speed[self:GetCaster():GetTalentLevel("modifier_wisp_9")]
    end
    return self.bonus_attack_speed + bonus
end

function modifier_wisp_overcharge_custom:GetModifierSpellAmplify_Percentage()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_wisp_9") then
        bonus = self:GetAbility().modifier_wisp_9_spell_amp[self:GetCaster():GetTalentLevel("modifier_wisp_9")]
    end
    return self.bonus_spell_amp + bonus
end

modifier_wisp_overcharge_custom_debuff = class({})

function modifier_wisp_overcharge_custom_debuff:OnCreated()
    self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
    self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.bonus_spell_amp = self:GetAbility():GetSpecialValueFor("bonus_spell_amp")
    self.overcharge_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_overcharge.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(self.overcharge_pfx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(self.overcharge_pfx, false, false, -1, false, false)
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function modifier_wisp_overcharge_custom_debuff:OnRefresh()
    self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
    self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.bonus_spell_amp = self:GetAbility():GetSpecialValueFor("bonus_spell_amp")
end

function modifier_wisp_overcharge_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_wisp_overcharge_custom") then
        self:Destroy()
    end
end

function modifier_wisp_overcharge_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_wisp_overcharge_custom_debuff:GetModifierHealthRegenPercentage()
    if not self:GetCaster():HasModifier("modifier_wisp_3") then return end
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_wisp_5") then
        bonus = self:GetAbility().modifier_wisp_5_regen[self:GetCaster():GetTalentLevel("modifier_wisp_5")]
    end
    return -(self.hp_regen+bonus) / 100 * self:GetAbility().modifier_wisp_3[self:GetCaster():GetTalentLevel("modifier_wisp_3")]
end

function modifier_wisp_overcharge_custom_debuff:GetModifierAttackSpeedBonus_Constant()
    if not self:GetCaster():HasModifier("modifier_wisp_3") then return end
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_wisp_9") then
        bonus = self:GetAbility().modifier_wisp_9_attack_speed[self:GetCaster():GetTalentLevel("modifier_wisp_9")]
    end
    return -(self.bonus_attack_speed + bonus) / 100 * self:GetAbility().modifier_wisp_3[self:GetCaster():GetTalentLevel("modifier_wisp_3")]
end

function modifier_wisp_overcharge_custom_debuff:GetModifierSpellAmplify_Percentage()
    if not self:GetCaster():HasModifier("modifier_wisp_3") then return end
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_wisp_9") then
        bonus = self:GetAbility().modifier_wisp_9_spell_amp[self:GetCaster():GetTalentLevel("modifier_wisp_9")]
    end
    return -(self.bonus_spell_amp+bonus) / 100 * self:GetAbility().modifier_wisp_3[self:GetCaster():GetTalentLevel("modifier_wisp_3")]
end


modifier_wisp_overcharge_custom_magic_immune = class({})

function modifier_wisp_overcharge_custom_magic_immune:GetTexture() return "wisp_13" end

function modifier_wisp_overcharge_custom_magic_immune:IsPurgable() return false end


function modifier_wisp_overcharge_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_wisp_overcharge_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_wisp_overcharge_custom_magic_immune:CheckState()
    return {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_wisp_overcharge_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_wisp_overcharge_custom_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_wisp_overcharge_custom_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_wisp_overcharge_custom_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_wisp_overcharge_custom_magic_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end