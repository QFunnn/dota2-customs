--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


necrolyte_death_pulse_custom = class({})

necrolyte_death_pulse_custom.modifier_necrolyte_8 = {-0.5,-1}
necrolyte_death_pulse_custom.modifier_necrolyte_9_damage = {30,60,90}
necrolyte_death_pulse_custom.modifier_necrolyte_9_manacost = {30,60,90}
necrolyte_death_pulse_custom.modifier_necrolyte_15_radius = {100,200}
necrolyte_death_pulse_custom.modifier_necrolyte_15_heal = {20,40}
necrolyte_death_pulse_custom.modifier_necrolyte_20_damage = 150

function necrolyte_death_pulse_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_necrolyte_20") then
        return "necrolyte_20"
    end
    return "necrolyte_death_pulse"
end

function necrolyte_death_pulse_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_necrolyte_8") then
        bonus = self.modifier_necrolyte_8[self:GetCaster():GetTalentLevel("modifier_necrolyte_8")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function necrolyte_death_pulse_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_necrolyte_2") then
        return 0
    end
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_necrolyte_9") then
        bonus = self.BaseClass.GetManaCost(self, iLevel) / 100 * self.modifier_necrolyte_9_manacost[self:GetCaster():GetTalentLevel("modifier_necrolyte_9")]
    end
    return self.BaseClass.GetManaCost(self, iLevel) - bonus
end

function necrolyte_death_pulse_custom:GetHealthCost(iLevel)
    if self:GetCaster():HasModifier("modifier_necrolyte_2") then
        local bonus = 0
        if self:GetCaster():HasModifier("modifier_necrolyte_9") then
            bonus = self.BaseClass.GetManaCost(self, iLevel) / 100 * self.modifier_necrolyte_9_manacost[self:GetCaster():GetTalentLevel("modifier_necrolyte_9")]
        end
        return self.BaseClass.GetManaCost(self, iLevel) - bonus
    end
    return 0
end

function necrolyte_death_pulse_custom:OnSpellStart()
    if not IsServer() then return end
    local area_of_effect = self:GetSpecialValueFor("area_of_effect")
    local projectile_speed = self:GetSpecialValueFor("projectile_speed")
    local origin = self:GetCaster():GetAbsOrigin()
    self:GetCaster():EmitSound("Hero_Necrolyte.DeathPulse")

    if self:GetCaster():HasModifier("modifier_necrolyte_15") then
        area_of_effect = area_of_effect + self.modifier_necrolyte_15_radius[self:GetCaster():GetTalentLevel("modifier_necrolyte_15")]
    end

    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), origin, nil, area_of_effect, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
    for _,enemy in pairs(enemies) do
        local projectile =
        {
            Target = enemy,
            Source = self:GetCaster(),
            Ability = self,
            EffectName = "particles/units/heroes/hero_necrolyte/necrolyte_pulse_enemy.vpcf",
            bDodgeable = false,
            bProvidesVision = false,
            iMoveSpeed = projectile_speed,
            flExpireTime = GameRules:GetGameTime() + 60,
            iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
            ExtraData = {}
        }
        ProjectileManager:CreateTrackingProjectile(projectile)
    end

	local allies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), origin, nil, area_of_effect, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
	for _,ally in pairs(allies) do
        local projectile =
        {
            Target = ally,
            Source = self:GetCaster(),
            Ability = self,
            EffectName = "particles/units/heroes/hero_necrolyte/necrolyte_pulse_friend.vpcf",
            bDodgeable = false,
            bProvidesVision = false,
            iMoveSpeed = projectile_speed,
            flExpireTime = GameRules:GetGameTime() + 60,
            iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
            ExtraData = {}
        }
        ProjectileManager:CreateTrackingProjectile(projectile)
	end
end

function necrolyte_death_pulse_custom:OnProjectileHit(target, vLocation)
	if not IsServer() then return end
    local heal = self:GetSpecialValueFor("heal")
    if self:GetCaster():HasModifier("modifier_necrolyte_15") then
        heal = heal + self.modifier_necrolyte_15_heal[self:GetCaster():GetTalentLevel("modifier_necrolyte_15")]
    end
    local damage = self:GetSpecialValueFor("damage")
    local damage_type = self:GetAbilityDamageType()
    if self:GetCaster():HasModifier("modifier_necrolyte_8") then
        damage_type = DAMAGE_TYPE_PHYSICAL
    end
    if self:GetCaster():HasModifier("modifier_necrolyte_9") then
        damage = damage + (self:GetCaster():GetAgility() / 100 * self.modifier_necrolyte_9_damage[self:GetCaster():GetTalentLevel("modifier_necrolyte_9")])
    end
    if self:GetCaster():HasModifier("modifier_necrolyte_20") then
        damage = damage + (self:GetCaster():GetManaRegen() / 100 * self.modifier_necrolyte_20_damage)
    end
    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
	    target:Heal(heal, self:GetCaster())
	    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, heal, nil)
    else
        ApplyDamage({attacker = self:GetCaster(), victim = target, ability = self, damage = damage, damage_type = damage_type})
    end
end