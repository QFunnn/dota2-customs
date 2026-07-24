--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_abaddon_frostmourne_custom_debuff", "heroes/npc_dota_hero_abaddon_custom/abaddon_frostmourne_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abaddon_frostmourne_custom_buff", "heroes/npc_dota_hero_abaddon_custom/abaddon_frostmourne_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abaddon_frostmourne_custom_aggresive", "heroes/npc_dota_hero_abaddon_custom/abaddon_death_coil_custom", LUA_MODIFIER_MOTION_NONE)

abaddon_death_coil_custom = class({})

abaddon_death_coil_custom.modifier_abaddon_18 = {20,30,40}
abaddon_death_coil_custom.modifier_abaddon_2_cooldown = 7
abaddon_death_coil_custom.modifier_abaddon_2_duration = 1.5
abaddon_death_coil_custom.modifier_abaddon_2_speed = 550
abaddon_death_coil_custom.modifier_abaddon_15_dmg = 40
abaddon_death_coil_custom.modifier_abaddon_15_radius = 260
abaddon_death_coil_custom.modifier_abaddon_16 = {50,100}
abaddon_death_coil_custom.modifier_abaddon_17_cooldown = {-0.5,-1}
abaddon_death_coil_custom.modifier_abaddon_17_manacost = {50,100}

function abaddon_death_coil_custom:Precache( context )
    PrecacheResource( "particle", "particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance.vpcf", context )
end

function abaddon_death_coil_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_abaddon_16") then
        return "abaddon_16"
    end
    return "abaddon_death_coil"
end

function abaddon_death_coil_custom:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end
    if hTarget:IsOther() then
        return UF_FAIL_CUSTOM
    end
	return UF_SUCCESS
end

function abaddon_death_coil_custom:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end
    if hTarget:IsOther() then
		return "#dota_hud_error_cant_cast_on_other_units"
	end
end

function abaddon_death_coil_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_abaddon_2") then
        bonus = self.modifier_abaddon_2_cooldown
    end
    if self:GetCaster():HasModifier("modifier_abaddon_17") then
        bonus = bonus + self.modifier_abaddon_17_cooldown[self:GetCaster():GetTalentLevel("modifier_abaddon_17")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function abaddon_death_coil_custom:GetManaCost(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_abaddon_17") then
        bonus = self.modifier_abaddon_17_manacost[self:GetCaster():GetTalentLevel("modifier_abaddon_17")]
    end
    return self.BaseClass.GetManaCost(self, iLevel) + bonus
end

function abaddon_death_coil_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_abaddon_16") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    if self:GetCaster():HasModifier("modifier_abaddon_15") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function abaddon_death_coil_custom:GetAOERadius()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_abaddon_15") then
        bonus = bonus + self:GetCaster():GetAoeBonus(self.modifier_abaddon_15_radius)
    end
    if self:GetCaster():HasModifier("modifier_abaddon_17") then
        bonus = bonus + self.modifier_abaddon_17_cooldown[self:GetCaster():GetTalentLevel("modifier_abaddon_17")]
    end
    return bonus
end

function abaddon_death_coil_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local self_damage = self:GetSpecialValueFor("self_damage")
    if self:GetCaster():HasModifier("modifier_abaddon_15") then
        self_damage = self_damage + (self_damage / 100 * self.modifier_abaddon_15_dmg)
    end

    if target ~= nil then
        self:CastTarget(target)
        if self:GetCaster():HasModifier("modifier_abaddon_15") then
            local radius = self:GetCaster():GetAoeBonus(self.modifier_abaddon_15_radius)
            if self:GetCaster():HasModifier("modifier_abaddon_16") then
                radius = radius + self.modifier_abaddon_16[self:GetCaster():GetTalentLevel("modifier_abaddon_16")]
            end
            local units = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
            for _, unit in pairs(units) do
                if unit ~= target then
                    self:CastTarget(unit)
                end
            end
        end
    else
        if self:GetCaster():HasModifier("modifier_abaddon_16") then
            local point = self:GetCursorPosition()
            local radius = self:GetCaster():GetAoeBonus(self.modifier_abaddon_15_radius)
            if self:GetCaster():HasModifier("modifier_abaddon_16") then
                radius = radius + self.modifier_abaddon_16[self:GetCaster():GetTalentLevel("modifier_abaddon_16")]
            end
            local units = FindUnitsInRadius(caster:GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
            for _, unit in pairs(units) do
                self:CastTarget(unit)
            end
        end
    end
	ApplyDamage({ victim = caster, attacker = caster, damage = self_damage, damage_type = DAMAGE_TYPE_PURE, ability = self, damage_flags = DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NON_LETHAL })
end

function abaddon_death_coil_custom:CastTarget(target)
	local projectile_speed = self:GetSpecialValueFor("missile_speed")
    local effect = "particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf"
    if self:GetCaster():HasModifier("modifier_abaddon_16") then
        effect = "particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance.vpcf"
    end
    local info = 
    {
		Target = target,
		Source = self:GetCaster(),
		Ability = self,	
		EffectName = effect,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
	}
    self:GetCaster():EmitSound("Hero_Abaddon.DeathCoil.Cast")
	ProjectileManager:CreateTrackingProjectile(info)
end

function abaddon_death_coil_custom:OnProjectileHit( target, location )
    if not IsServer() then return end
    if not target then return end
    local heal_amount = self:GetSpecialValueFor("heal_amount")
    local target_damage = self:GetSpecialValueFor("target_damage")
    if self:GetCaster():HasModifier("modifier_abaddon_18") then
        heal_amount = heal_amount + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_abaddon_18[self:GetCaster():GetTalentLevel("modifier_abaddon_18")])
        target_damage = target_damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_abaddon_18[self:GetCaster():GetTalentLevel("modifier_abaddon_18")])
    end

	if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		target:Heal( heal_amount, self:GetCaster() )
	else
		if target:IsInvulnerable() or target:TriggerSpellAbsorb( self ) then return end
		ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = target_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
        if self:GetCaster():HasModifier("modifier_abaddon_7") then
            local abaddon_frostmourne_custom = self:GetCaster():FindAbilityByName("abaddon_frostmourne_custom")
            if abaddon_frostmourne_custom and abaddon_frostmourne_custom:GetLevel() > 0 then
                local curse_duration = abaddon_frostmourne_custom:GetSpecialValueFor("curse_duration")
                target:AddNewModifier(self:GetCaster(), abaddon_frostmourne_custom, "modifier_abaddon_frostmourne_custom_debuff", {duration = curse_duration})
                self:GetCaster():AddNewModifier(self:GetCaster(), abaddon_frostmourne_custom, "modifier_abaddon_frostmourne_custom_buff", {duration = curse_duration})
                target:EmitSound("Hero_Abaddon.Curse.Proc")
                if self:GetCaster():HasModifier("modifier_abaddon_1") then
                    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, abaddon_frostmourne_custom.modifier_abaddon_1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
                    for _, unit in pairs(units) do
                        if unit ~= target then
                            unit:AddNewModifier(self:GetCaster(), abaddon_frostmourne_custom, "modifier_abaddon_frostmourne_custom_debuff", {duration = curse_duration})
                        end
                    end
                end
            end
        end
        if self:GetCaster():HasModifier("modifier_abaddon_2") then
            target:AddNewModifier(self:GetCaster(), self, "modifier_abaddon_frostmourne_custom_aggresive", {duration = self.modifier_abaddon_2_duration * (1-target:GetStatusResistance())})
        end
	end

	target:EmitSound("Hero_Abaddon.DeathCoil.Target")
end

modifier_abaddon_frostmourne_custom_aggresive = class({})
function modifier_abaddon_frostmourne_custom_aggresive:GetTexture() return "abaddon_2" end
function modifier_abaddon_frostmourne_custom_aggresive:IsPurgable() return false end

function modifier_abaddon_frostmourne_custom_aggresive:OnCreated( kv )
    if not IsServer() then return end
    self:GetParent():SetForceAttackTarget( self:GetCaster() )
    self:GetParent():MoveToTargetToAttack( self:GetCaster() )
    self:StartIntervalThink(FrameTime())
end

function modifier_abaddon_frostmourne_custom_aggresive:OnIntervalThink( kv )
    if not IsServer() then return end
    if not self:GetCaster():IsAlive() then
        self:Destroy()
    else
        self:GetParent():SetForceAttackTarget( self:GetCaster() )
        self:GetParent():MoveToTargetToAttack( self:GetCaster() )
    end
end

function modifier_abaddon_frostmourne_custom_aggresive:OnRemoved()
    if not IsServer() then return end
    self:GetParent():SetForceAttackTarget( nil )
end

function modifier_abaddon_frostmourne_custom_aggresive:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE
    }
end

function modifier_abaddon_frostmourne_custom_aggresive:GetModifierMoveSpeed_Absolute()
    return self:GetAbility().modifier_abaddon_2_speed
end

function modifier_abaddon_frostmourne_custom_aggresive:CheckState()
    return
    {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_TAUNTED] = true,
    }
end

function modifier_abaddon_frostmourne_custom_aggresive:GetStatusEffectName()
    return "particles/status_fx/status_effect_beserkers_call.vpcf"
end