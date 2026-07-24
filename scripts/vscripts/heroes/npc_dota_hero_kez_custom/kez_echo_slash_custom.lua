--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kez_echo_slash_custom_debuff", "heroes/npc_dota_hero_kez_custom/kez_echo_slash_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_echo_slash_custom_damage", "heroes/npc_dota_hero_kez_custom/kez_echo_slash_custom", LUA_MODIFIER_MOTION_NONE)

kez_echo_slash_custom = class({})

kez_echo_slash_custom.modifier_kez_7 = 1
kez_echo_slash_custom.modifier_kez_3 = {7,14,21}
kez_echo_slash_custom.modifier_kez_2 = {-0.2,-0.4}
kez_echo_slash_custom.modifier_kez_2_manacost = {20, 40}
kez_echo_slash_custom.modifier_kez_4 = 70
kez_echo_slash_custom.modifier_kez_4_max = 7

function kez_echo_slash_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_katana_echo_strike.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_katana_echo_strike_cast.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_kez.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_kez.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_kez.vpcf", context)
end

function kez_echo_slash_custom:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT
end

function kez_echo_slash_custom:GetManaCost(iLevel)
    local manacost = self.BaseClass.GetManaCost(self, iLevel)
    if self:GetCaster():HasModifier("modifier_kez_2") then
        manacost = manacost * (1 - (self.modifier_kez_2_manacost[self:GetCaster():GetTalentLevel("modifier_kez_2")] / 100))
    end
    return manacost
end

function kez_echo_slash_custom:GetCooldown(iLevel)
    local cooldown = self.BaseClass.GetCooldown(self, iLevel)
    if self:GetCaster():HasModifier("modifier_kez_4") then
        local cooldown_reduced = self:GetCaster():GetStrength() / self.modifier_kez_4
        cooldown = math.max(self.modifier_kez_4_max, cooldown - cooldown_reduced)
    end
    return cooldown
end

function kez_echo_slash_custom:OnSpellStart()
    if not IsServer() then return end
    local katana_distance = self:GetSpecialValueFor("katana_distance")
    local travel_distance = self:GetSpecialValueFor("travel_distance")
    if self:GetCaster():HasModifier("modifier_kez_3") then
        travel_distance = katana_distance
    end
    local start_point = self:GetCaster():GetAbsOrigin()
    local end_point = start_point + self:GetCaster():GetForwardVector() * katana_distance
    local end_point_teleport = start_point + self:GetCaster():GetForwardVector() * travel_distance
    if self:GetCaster():HasModifier("modifier_kez_17") then
        end_point_teleport = start_point - self:GetCaster():GetForwardVector() * travel_distance
    end
    local katana_radius = self:GetSpecialValueFor("katana_radius")
    local strike_interval = self:GetSpecialValueFor("strike_interval") + 0.3
    if self:GetCaster():HasModifier("modifier_kez_2") then
        strike_interval = strike_interval + self.modifier_kez_2[self:GetCaster():GetTalentLevel("modifier_kez_2")]
    end
    local katana_strikes = self:GetSpecialValueFor("katana_strikes")
    if self:GetCaster():HasModifier("modifier_kez_7") then
        katana_strikes = katana_strikes + self.modifier_kez_7
    end
    FindClearSpaceForUnit(self:GetCaster(), end_point_teleport, true)
    self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
    self:PreCreateAttack(nil, katana_distance, travel_distance, start_point, end_point, end_point_teleport, katana_radius, strike_interval)
    print(katana_strikes)
    for i=1, katana_strikes-1 do
        self:PreCreateAttack(strike_interval*i, katana_distance, travel_distance, start_point, end_point, end_point_teleport, katana_radius, strike_interval)
    end
    ---------------------------------------------------------------------------------------------
    if self:GetCaster():HasModifier("modifier_kez_21") then return end
    local kez_falcon_rush_custom = self:GetCaster():FindAbilityByName("kez_falcon_rush_custom")
    if kez_falcon_rush_custom then
        kez_falcon_rush_custom:UseResources(false, false, false, true)
    end
end

function kez_echo_slash_custom:PreCreateAttack(delay, katana_distance, travel_distance, start_point, end_point, end_point_teleport, katana_radius, strike_interval)
    if not delay then
        self:CreateAttack(katana_distance, travel_distance, start_point, end_point, end_point_teleport, katana_radius, strike_interval)
    else
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_katana_echo_strike_cast.vpcf", PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, start_point)
        ParticleManager:SetParticleControl(particle, 1, end_point)
        ParticleManager:SetParticleControlEnt(particle, 7, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
        Timers:CreateTimer(delay, function()
            self:CreateAttack(katana_distance, travel_distance, start_point, end_point, end_point_teleport, katana_radius, strike_interval)
        end)
    end
end

function kez_echo_slash_custom:CreateAttack(katana_distance, travel_distance, start_point, end_point, end_point_teleport, katana_radius, strike_interval)
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_katana_echo_strike.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, start_point)
    ParticleManager:SetParticleControl(particle, 1, end_point)
    ParticleManager:SetParticleControl(particle, 2, Vector(katana_distance, katana_radius, strike_interval))
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetCaster():EmitSound("Hero_Kez.EchoSlash.Katana.Start")
    self:GetCaster():EmitSound("Hero_Kez.EchoSlash.Katana.End")
    local tag_slow_duration = self:GetSpecialValueFor("tag_slow_duration")
    local units = FindUnitsInLine(self:GetCaster():GetTeamNumber(), start_point, end_point, nil, katana_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0)
    for _,target in pairs(units) do
        target:AddNewModifier(self:GetCaster(), self, "modifier_kez_echo_slash_custom_debuff", {duration = tag_slow_duration})
        local modifier_kez_echo_slash_custom_damage = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_echo_slash_custom_damage", {})
        if modifier_kez_echo_slash_custom_damage then
            if self:GetCaster():HasModifier("modifier_kez_17") then
                local damage_attack = self:GetCaster():GetAverageTrueAttackDamage(nil) + self:GetSpecialValueFor( "echo_hero_damage" )	
                ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage_attack, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
                self:GetCaster().spell_attack = true
                self:GetCaster():PerformAttack(target, true, true, true, false, false, true, self:GetCaster():GetChanceToEvasion(target))
                self:GetCaster().spell_attack = nil
                local modifier_kez_kazurai_katana_custom = self:GetCaster():FindModifierByName("modifier_kez_kazurai_katana_custom")
                if modifier_kez_kazurai_katana_custom then
                    modifier_kez_kazurai_katana_custom:ForceSetBuff(target, damage_attack)
                end
            else
                self:GetCaster().spell_attack = true
                self:GetCaster():PerformAttack(target, true, true, true, false, false, false, self:GetCaster():GetChanceToEvasion(target)) 
                self:GetCaster().spell_attack = nil
            end
            modifier_kez_echo_slash_custom_damage:Destroy()
        end
    end
end

modifier_kez_echo_slash_custom_debuff = class({})

function modifier_kez_echo_slash_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_kez_echo_slash_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("tag_slow")
end

modifier_kez_echo_slash_custom_damage = class({})
function modifier_kez_echo_slash_custom_damage:IsHidden() return true end
function modifier_kez_echo_slash_custom_damage:IsPurgable() return false end
function modifier_kez_echo_slash_custom_damage:OnCreated( kv )
	self.base_damage = self:GetAbility():GetSpecialValueFor( "echo_hero_damage" )	
	self.attack_factor = self:GetAbility():GetSpecialValueFor( "katana_echo_damage" )
    if self:GetCaster():HasModifier("modifier_kez_3") then
        self.attack_factor = self.attack_factor + self:GetAbility().modifier_kez_3[self:GetCaster():GetTalentLevel("modifier_kez_3")]
    end
end

function modifier_kez_echo_slash_custom_damage:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,

	}
end

function modifier_kez_echo_slash_custom_damage:GetModifierDamageOutgoing_Percentage( params )
	if IsServer() then
		return self.attack_factor - 100
	end
end

function modifier_kez_echo_slash_custom_damage:GetModifierPreAttack_BonusDamage( params )
	if IsServer() then
        if params.target and params.target:IsHero() then
		    return self.base_damage * (1 + (1 - (self.attack_factor / 100)))
        end
	end
end