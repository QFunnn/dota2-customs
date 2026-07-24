--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nyx_assassin_spiked_carapace_custom", "heroes/npc_dota_hero_nyx_assassin_custom/nyx_assassin_spiked_carapace_custom", LUA_MODIFIER_MOTION_NONE)

nyx_assassin_spiked_carapace_custom = class({})

nyx_assassin_spiked_carapace_custom.modifier_nyx_assassin_4 = {20,40,60}
nyx_assassin_spiked_carapace_custom.modifier_nyx_assassin_8 = {150,225,300}
nyx_assassin_spiked_carapace_custom.modifier_nyx_assassin_13 = {-1.5,-3}

function nyx_assassin_spiked_carapace_custom:OnSpellStart()
    if not IsServer() then return end
    local reflect_duration = self:GetSpecialValueFor("reflect_duration")
    self:GetCaster():EmitSound("Hero_NyxAssassin.SpikedCarapace")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_nyx_assassin_spiked_carapace_custom", {duration = reflect_duration})
    if self:GetCaster():HasModifier("modifier_nyx_assassin_14") then
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
        for _,unit in pairs(units) do
            if unit:IsIllusion() then
                local modifier_illusion = unit:FindModifierByName("modifier_illusion")
                if modifier_illusion and modifier_illusion:GetCaster() == self:GetCaster() then
                    unit:AddNewModifier(self:GetCaster(), self, "modifier_nyx_assassin_spiked_carapace_custom", {duration = reflect_duration})
                    unit:EmitSound("Hero_NyxAssassin.SpikedCarapace")
                end
            end
        end
    end
end

function nyx_assassin_spiked_carapace_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_nyx_assassin_13") then
        bonus = self.modifier_nyx_assassin_13[self:GetCaster():GetTalentLevel("modifier_nyx_assassin_13")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

modifier_nyx_assassin_spiked_carapace_custom = class({})

function modifier_nyx_assassin_spiked_carapace_custom:IsPurgable() return false end

function modifier_nyx_assassin_spiked_carapace_custom:OnCreated()
    if not IsServer() then return end
    self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
    self.damage_reflect_pct = self:GetAbility():GetSpecialValueFor("damage_reflect_pct")
    if self:GetCaster():HasModifier("modifier_nyx_assassin_4") then
        self.damage_reflect_pct = self.damage_reflect_pct + self:GetAbility().modifier_nyx_assassin_4[self:GetCaster():GetTalentLevel("modifier_nyx_assassin_4")]
    end
    self.carapaced_units = {}

    if self:GetCaster():HasModifier("modifier_nyx_assassin_burrow_custom") then
        local nyx_assassin_burrow_custom = self:GetCaster():FindAbilityByName("nyx_assassin_burrow_custom")
        if nyx_assassin_burrow_custom then
            local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, nyx_assassin_burrow_custom:GetSpecialValueFor("carrapase_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
            for _, unit in pairs(units) do
                self:ReflectDamage(unit, 0, nil)
            end
        end
    end
end

function modifier_nyx_assassin_spiked_carapace_custom:OnRefresh()
    self:OnCreated()
end

function modifier_nyx_assassin_spiked_carapace_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_nyx_assassin_spiked_carapace_custom:GetAbsoluteNoDamagePhysical(params)
    if params.original_damage <= 0 then return end
    if params.attacker == self:GetParent() then return end
    if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return end
    if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
    if self:GetParent():HasModifier("modifier_nyx_assassin_6") then return end
    if params.damage_type == DAMAGE_TYPE_PHYSICAL and self:ReflectDamage(params.attacker, params.damage, params) then
        return 1
    end
end

function modifier_nyx_assassin_spiked_carapace_custom:GetAbsoluteNoDamageMagical(params)
    if params.original_damage <= 0 then return end
    if params.attacker == self:GetParent() then return end
    if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return end
    if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
    if self:GetParent():HasModifier("modifier_nyx_assassin_6") then return end
    if params.damage_type == DAMAGE_TYPE_MAGICAL and self:ReflectDamage(params.attacker, params.damage, params) then
        return 1
    end
end

function modifier_nyx_assassin_spiked_carapace_custom:GetAbsoluteNoDamagePure(params)
    if params.original_damage <= 0 then return end
    if params.attacker == self:GetParent() then return end
    if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return end
    if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
    if self:GetParent():HasModifier("modifier_nyx_assassin_6") then return end
    if params.damage_type == DAMAGE_TYPE_PURE and self:ReflectDamage(params.attacker, params.damage, params) then
        return 1
    end
end

function modifier_nyx_assassin_spiked_carapace_custom:ReflectDamage(target, damage, params)
    if not IsServer() then return end
    if target:IsHero() and not self.carapaced_units[ target:entindex() ] then
        if not self:GetCaster():HasModifier("modifier_nyx_assassin_6") then
            target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = self.stun_duration * (1-target:GetStatusResistance())})
            target:EmitSound("Hero_NyxAssassin.SpikedCarapace.Stun")
            self.carapaced_units[ target:entindex() ] = target
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace_hit.vpcf", PATTACH_POINT_FOLLOW, target)
            ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
            ParticleManager:SetParticleControl(particle, 2, Vector(1,0,0))
            ParticleManager:ReleaseParticleIndex(particle)
        end
        if params ~= nil then
            ApplyDamage({victim = target, damage = params.original_damage / 100 * self.damage_reflect_pct, damage_type = params.damage_type, damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, attacker = self:GetParent(), ability = self:GetAbility()})
        end
        return true
    end
    return false
end

function modifier_nyx_assassin_spiked_carapace_custom:GetEffectName()
	return "particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace.vpcf"
end

function modifier_nyx_assassin_spiked_carapace_custom:GetModifierTotal_ConstantBlock(params)
    if not IsServer() then return end
    if params.original_damage <= 0 then return end
    if params.attacker == self:GetParent() then return end
    if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return end
    if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
    if not self:GetParent():HasModifier("modifier_nyx_assassin_6") then return end
    if self:ReflectDamage(params.attacker, params.damage, params) then
        return 0
    end
end

function modifier_nyx_assassin_spiked_carapace_custom:GetModifierAttackSpeedBonus_Constant()
    if not self:GetCaster():HasModifier("modifier_nyx_assassin_8") then return end
    return self:GetAbility().modifier_nyx_assassin_8[self:GetCaster():GetTalentLevel("modifier_nyx_assassin_8")]
end