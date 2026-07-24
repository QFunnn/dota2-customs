--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_roshan_slam_custom_debuff", "heroes/npc_dota_hero_arc_warden_custom/roshan_slam_custom", LUA_MODIFIER_MOTION_NONE)

roshan_slam_custom = class({})

roshan_slam_custom.modifier_arc_warden_15 = {80,120}
roshan_slam_custom.modifier_arc_warden_19 = {100,200,300}
roshan_slam_custom.modifier_arc_warden_17 = {-2.5,-5}

function roshan_slam_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_arc_warden_19") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function roshan_slam_custom:GetCastPoint()
	if self:GetCaster():HasModifier("modifier_arc_warden_19") then
		return 0
	end
	return self.BaseClass.GetCastPoint( self )
end

function roshan_slam_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("radius")
    end
end

function roshan_slam_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_arc_warden_17") and not self:GetCaster():HasModifier("modifier_arc_warden_17_debuff") then
        bonus = self.modifier_arc_warden_17[self:GetCaster():GetTalentLevel("modifier_arc_warden_17")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function roshan_slam_custom:OnSpellStart()
    if not IsServer() then return end
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")
    local duration = self:GetSpecialValueFor("duration")

    if self:GetCaster():HasModifier("modifier_arc_warden_15") then
        damage = damage + (self:GetCaster():GetIntellect(true) / 100 * self.modifier_arc_warden_15[self:GetCaster():GetTalentLevel("modifier_arc_warden_15")])
    end

    if self:GetCaster():HasModifier("modifier_arc_warden_19") then
        radius = radius + self.modifier_arc_warden_19[self:GetCaster():GetTalentLevel("modifier_arc_warden_19")]
    end

    local particle = ParticleManager:CreateParticle("particles/neutral_fx/roshan_slam.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
    ParticleManager:ReleaseParticleIndex(particle)

    self:GetCaster():EmitSound("Roshan.Slam")

    local modifier_item_hero_roshan_cheese = self:GetCaster():FindModifierByName("modifier_item_hero_roshan_cheese")
    if modifier_item_hero_roshan_cheese then
        local ability = modifier_item_hero_roshan_cheese:GetAbility()
        if not ability then
            modifier_item_hero_roshan_cheese:Destroy()
        else
            damage = damage * modifier_item_hero_roshan_cheese:GetAbility():GetSpecialValueFor("slam_mult")
            modifier_item_hero_roshan_cheese:Destroy()
        end
    end

    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, unit in pairs(units) do
        unit:AddNewModifier(self:GetCaster(), self, "modifier_roshan_slam_custom_debuff", {duration = duration * (1-unit:GetStatusResistance())})
        ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
    end
end

modifier_roshan_slam_custom_debuff = class({})

function modifier_roshan_slam_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_roshan_slam_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_roshan_slam_custom_debuff:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("attack_speed")
end