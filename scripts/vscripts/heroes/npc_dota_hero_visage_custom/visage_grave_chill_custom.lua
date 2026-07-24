--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_grave_chill_custom_debuff", "heroes/npc_dota_hero_visage_custom/visage_grave_chill_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_grave_chill_custom_buff", "heroes/npc_dota_hero_visage_custom/visage_grave_chill_custom", LUA_MODIFIER_MOTION_NONE)

visage_grave_chill_custom = class({})

visage_grave_chill_custom.modifier_visage_8 = {1,2}
visage_grave_chill_custom.modifier_visage_12 = {10,20,30}

function visage_grave_chill_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_visage/visage_cloak_ambient_damage.vpcf", context)
    PrecacheResource("particle", "particles/visage_vacuum/visage_vacuum.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/fall_2021/blink_dagger_fall_2021_end.vpcf", context)
end

function visage_grave_chill_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("chill_duration")
    if self:GetCaster():HasModifier("modifier_visage_8") then
        duration = duration + self.modifier_visage_8[self:GetCaster():GetTalentLevel("modifier_visage_8")]
    end
    local radius = self:GetSpecialValueFor("radius")
    self:GetCaster():EmitSound("Hero_Visage.GraveChill.Cast")
    local target = self:GetCursorTarget()
    target:EmitSound("Hero_Visage.GraveChill.Target")
    target:AddNewModifier(self:GetCaster(), self, "modifier_visage_grave_chill_custom_debuff", {duration = duration * (1 - target:GetStatusResistance())})
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_visage_grave_chill_custom_buff", {duration = duration})
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_grave_chill_cast_beams.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)
    local visage_summon_familiars_custom = self:GetCaster():FindAbilityByName("visage_summon_familiars_custom")
    if visage_summon_familiars_custom and visage_summon_familiars_custom.familiar_table and #visage_summon_familiars_custom.familiar_table > 0 then
        for _, familiar in pairs(visage_summon_familiars_custom.familiar_table) do
            if familiar and not familiar:IsNull() and familiar:IsAlive() and familiar:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
                local distance = (familiar:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D()
                if distance <= radius then
                    familiar:AddNewModifier(self:GetCaster(), self, "modifier_visage_grave_chill_custom_buff", {duration = duration})
                end
            end
        end
    end
end

modifier_visage_grave_chill_custom_debuff = class({})

function modifier_visage_grave_chill_custom_debuff:IsPurgable()
    return not self:GetCaster():HasModifier("modifier_visage_12")
end

function modifier_visage_grave_chill_custom_debuff:OnCreated(params)
    self.movespeed_bonus = self:GetAbility():GetSpecialValueFor("movespeed_bonus")
    self.attackspeed_bonus = self:GetAbility():GetSpecialValueFor("attackspeed_bonus")
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_grave_chill_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(particle, 2, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_visage_grave_chill_custom_debuff:OnRefresh(params)
    self.movespeed_bonus = self:GetAbility():GetSpecialValueFor("movespeed_bonus")
    self.attackspeed_bonus = self:GetAbility():GetSpecialValueFor("attackspeed_bonus")
end

function modifier_visage_grave_chill_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
    }
end

function modifier_visage_grave_chill_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return -self.movespeed_bonus
end

function modifier_visage_grave_chill_custom_debuff:GetModifierAttackSpeedBonus_Constant()
    return -self.attackspeed_bonus
end

function modifier_visage_grave_chill_custom_debuff:GetModifierPropertyRestorationAmplification()
    if self:GetCaster():HasModifier("modifier_visage_12") then
        return -self:GetAbility().modifier_visage_12[self:GetCaster():GetTalentLevel("modifier_visage_12")]
    end
    return 0
end

function modifier_visage_grave_chill_custom_debuff:GetStatusEffectName()
	return "particles/units/heroes/hero_visage/status_effect_visage_chill_slow.vpcf"
end

modifier_visage_grave_chill_custom_buff = class({})

function modifier_visage_grave_chill_custom_buff:IsPurgable()
    return not self:GetCaster():HasModifier("modifier_visage_12")
end

function modifier_visage_grave_chill_custom_buff:OnCreated(params)
    self.movespeed_bonus = self:GetAbility():GetSpecialValueFor("movespeed_bonus")
    self.attackspeed_bonus = self:GetAbility():GetSpecialValueFor("attackspeed_bonus")
    if not IsServer() then return end
    local chill_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_grave_chill_caster.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(chill_particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
	if self:GetParent() == self:GetCaster() then
		ParticleManager:SetParticleControlEnt(chill_particle, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_tail_tip", self:GetParent():GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(chill_particle, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_wingtipL", self:GetParent():GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(chill_particle, 4, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_wingtipR", self:GetParent():GetAbsOrigin(), true)
	else
		ParticleManager:SetParticleControlEnt(chill_particle, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)ParticleManager:SetParticleControlEnt(chill_particle, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(chill_particle, 4, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)	
	end
    self:AddParticle(chill_particle, false, false, -1, false, false)
end

function modifier_visage_grave_chill_custom_buff:OnRefresh(params)
    self.movespeed_bonus = self:GetAbility():GetSpecialValueFor("movespeed_bonus")
    self.attackspeed_bonus = self:GetAbility():GetSpecialValueFor("attackspeed_bonus")
end

function modifier_visage_grave_chill_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
    }
end

function modifier_visage_grave_chill_custom_buff:GetModifierMoveSpeedBonus_Percentage()
    return self.movespeed_bonus
end

function modifier_visage_grave_chill_custom_buff:GetModifierAttackSpeedBonus_Constant()
    return self.attackspeed_bonus
end

function modifier_visage_grave_chill_custom_buff:GetModifierPropertyRestorationAmplification()
    if self:GetCaster():HasModifier("modifier_visage_12") then
        return self:GetAbility().modifier_visage_12[self:GetCaster():GetTalentLevel("modifier_visage_12")]
    end
    return 0
end

function modifier_visage_grave_chill_custom_buff:GetStatusEffectName()
	return "particles/units/heroes/hero_visage/status_effect_visage_chill_slow.vpcf"
end