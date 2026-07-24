--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_riki_blinkstrike_slow_custom", "heroes/npc_dota_hero_riki_custom/riki_blink_strike_custom", LUA_MODIFIER_MOTION_NONE)

riki_blink_strike_custom = class({})
riki_blink_strike_custom.modifier_riki_1 = 300
riki_blink_strike_custom.modifier_riki_2_str = 150
riki_blink_strike_custom.modifier_riki_2_agi = 75
riki_blink_strike_custom.modifier_riki_2_int = 75
riki_blink_strike_custom.modifier_riki_4 = {-2,-3,-4}
riki_blink_strike_custom.modifier_riki_5 = {30,60}
riki_blink_strike_custom.modifier_riki_6 = -200

function riki_blink_strike_custom:CastFilterResultTarget( hTarget )
	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)
	if hTarget == self:GetCaster() then
		return UF_FAIL_CUSTOM
	end
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end

function riki_blink_strike_custom:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end
end

function riki_blink_strike_custom:GetBehavior()
    local behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
    if self:GetCaster():HasModifier("modifier_riki_6") then
        behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
    end
    if self:GetCaster():HasModifier("modifier_riki_1") then
        behavior = behavior + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return behavior
end

function riki_blink_strike_custom:GetAOERadius()
    if self:GetCaster():HasModifier("modifier_riki_1") then
        return self.modifier_riki_1
    end
end

function riki_blink_strike_custom:GetAbilityChargeRestoreTime(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_riki_4") then
        bonus = self.modifier_riki_4[self:GetCaster():GetTalentLevel("modifier_riki_4")]
    end
    return self.BaseClass.GetAbilityChargeRestoreTime( self, level ) + bonus
end

function riki_blink_strike_custom:GetCastRange(location, target)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_riki_6") then
        bonus = self.modifier_riki_6
    end
    return self.BaseClass.GetCastRange(self, location, target) + bonus
end

function riki_blink_strike_custom:GetManaCost(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_riki_5") then
        bonus = self.BaseClass.GetManaCost(self, level) / 100 * self.modifier_riki_5[self:GetCaster():GetTalentLevel("modifier_riki_5")]
    end
    return self.BaseClass.GetManaCost(self, level) - bonus
end

function riki_blink_strike_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    local damage = self:GetSpecialValueFor("bonus_damage")
    if self:GetCaster():HasModifier("modifier_riki_2") and self:GetCaster():GetTalentLevel("modifier_riki_2") >= 1 then
        damage = damage + (self:GetCaster():GetStrength() / 100 * self.modifier_riki_2_str)
    end
    if self:GetCaster():HasModifier("modifier_riki_2") and self:GetCaster():GetTalentLevel("modifier_riki_2") >= 2 then
        damage = damage +  (self:GetCaster():GetAgility() / 100 * self.modifier_riki_2_agi)
    end
    if self:GetCaster():HasModifier("modifier_riki_2") and self:GetCaster():GetTalentLevel("modifier_riki_2") >= 3 then
        damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_riki_2_int)
    end
    local target = self:GetCursorTarget()
    local position = self:GetCursorPosition()
    if target then
        if target:TriggerSpellAbsorb(self) then return end
        local target_loc_forward_vector = target:GetForwardVector()
        local final_pos = target:GetAbsOrigin() - target_loc_forward_vector * 100
        local victim_angle = target:GetAnglesAsVector()
        local victim_forward_vector = target:GetForwardVector()
        local victim_angle_rad = victim_angle.y*math.pi/180
        local victim_position = target:GetAbsOrigin()
        local attacker_new = Vector(victim_position.x - 100 * math.cos(victim_angle_rad), victim_position.y - 100 * math.sin(victim_angle_rad), 0)
        if self:GetCaster():HasModifier("modifier_riki_4") then
            victim_forward_vector = -victim_forward_vector
            final_pos = target:GetAbsOrigin() + target:GetForwardVector() * 100
            attacker_new = final_pos
        end
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_blink_strike.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, final_pos)
        ParticleManager:ReleaseParticleIndex(particle)
        self:GetCaster():SetAbsOrigin(attacker_new)
        FindClearSpaceForUnit(self:GetCaster(), attacker_new, true)
        self:GetCaster():SetForwardVector(victim_forward_vector)
        if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
            self:GetCaster():MoveToTargetToAttack(target)
            self:GetCaster().riki_attack = true
            self:GetCaster():PerformAttack(target, true, true, false, false, false, false, false)
            self:GetCaster().riki_attack = nil
            ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
            target:AddNewModifier(self:GetCaster(), self, "modifier_riki_blinkstrike_slow_custom", {duration = self:GetSpecialValueFor("slow") * (1-target:GetStatusResistance())})
        end
        target:EmitSound("Hero_Riki.Blink_Strike")
        if self:GetCaster():HasModifier("modifier_riki_1") then
            local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self.modifier_riki_1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
            for _, unit in pairs(units) do
                if unit ~= target then
                    ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
                    self:GetCaster().riki_attack = true
                    self:GetCaster():PerformAttack(unit, true, true, true, false, false, false, false)
                    self:GetCaster().riki_attack = nil
                    unit:AddNewModifier(self:GetCaster(), self, "modifier_riki_blinkstrike_slow_custom", {duration = self:GetSpecialValueFor("slow") * (1-unit:GetStatusResistance())})
                end
            end
        end
    else
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_blink_strike.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, position)
        ParticleManager:ReleaseParticleIndex(particle)
        self:GetCaster():SetAbsOrigin(position)
        FindClearSpaceForUnit(self:GetCaster(), position, true)
        self:GetCaster():EmitSound("Hero_Riki.Blink_Strike")
        if self:GetCaster():HasModifier("modifier_riki_1") then
            local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), position, nil, self.modifier_riki_1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
            for _, unit in pairs(units) do
                ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
                self:GetCaster().riki_attack = true
                self:GetCaster():PerformAttack(unit, true, true, true, false, false, false, false)
                self:GetCaster().riki_attack = nil
                unit:AddNewModifier(self:GetCaster(), self, "modifier_riki_blinkstrike_slow_custom", {duration = self:GetSpecialValueFor("slow") * (1-unit:GetStatusResistance())})
            end
        end
    end
end

modifier_riki_blinkstrike_slow_custom = class({})

function modifier_riki_blinkstrike_slow_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_riki_blinkstrike_slow_custom:GetModifierMoveSpeedBonus_Percentage()
    return -100
end