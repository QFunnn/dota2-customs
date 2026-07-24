--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_rain_of_chaos_custom", "heroes/npc_dota_hero_warlock_custom/warlock_rain_of_chaos_custom", LUA_MODIFIER_MOTION_NONE)

warlock_rain_of_chaos_custom = class({})
warlock_rain_of_chaos_custom.modifier_warlock_13 = {-100,-125,-150}
warlock_rain_of_chaos_custom.modifier_warlock_13_agility = 300
warlock_rain_of_chaos_custom.modifier_warlock_19 = 1
warlock_rain_of_chaos_custom.modifier_warlock_21 = 7
warlock_rain_of_chaos_custom.modifier_warlock_21_damage = 250
warlock_rain_of_chaos_custom.modifier_warlock_21_attackspeed = 25
warlock_rain_of_chaos_custom.modifier_warlock_14 = 500

function warlock_rain_of_chaos_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos_start.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf", context)
end

function warlock_rain_of_chaos_custom:GetAOERadius()
    return self:GetSpecialValueFor("aoe")
end

function warlock_rain_of_chaos_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_warlock_13") then
        return 0
    end
    return self.BaseClass.GetCastPoint(self)
end

function warlock_rain_of_chaos_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_warlock_13") then
        bonus = self.modifier_warlock_13[self:GetCaster():GetTalentLevel("modifier_warlock_13")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function warlock_rain_of_chaos_custom:OnAbilityPhaseStart()
	self:GetCaster():EmitSound("Hero_Warlock.RainOfChaos_buildup")
	return true
end

function warlock_rain_of_chaos_custom:OnAbilityPhaseInterrupted()
	self:GetCaster():StopSound("Hero_Warlock.RainOfChaos_buildup")
end

function warlock_rain_of_chaos_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local stun_delay = self:GetSpecialValueFor("stun_delay")
    local radius_stun = self:GetSpecialValueFor("aoe")
    local stun_duration = self:GetSpecialValueFor("stun_duration")
    if self:GetCaster():HasModifier("modifier_warlock_19") then
        stun_duration = stun_duration + self.modifier_warlock_19
    end
    
    EmitSoundOnLocationWithCaster(point, "Hero_Warlock.RainOfChaos", self:GetCaster())
    
    local particle_start = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_rain_of_chaos_start.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_start, 0, point)
	ParticleManager:ReleaseParticleIndex(particle_start)

    Timers:CreateTimer(stun_delay, function()
		GridNav:DestroyTreesAroundPoint(point, radius_stun, false)
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, point)
		ParticleManager:SetParticleControl(particle, 1, Vector(radius_stun, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle)
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius_stun, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
		for _,enemy in pairs(enemies) do
			enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = stun_duration * (1 - enemy:GetStatusResistance())})
            if self:GetCaster():HasModifier("modifier_warlock_21") then
                local start_damage = self:GetCaster():GetAgility() / 100 * self.modifier_warlock_21_damage
                ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = start_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
            end
		end
        self:CreateGolem(point)
        if self:GetCaster():HasModifier("modifier_warlock_13") then
            if self:GetCaster():GetAgility() >= self.modifier_warlock_13_agility then
                self:CreateGolem(point)
            end
        end
	end)
end

function warlock_rain_of_chaos_custom:CreateGolem(point)
    if not IsServer() then return end
    local golem_duration = self:GetSpecialValueFor("golem_duration")
    local health = self:GetSpecialValueFor("golem_hp")
    local damage = self:GetSpecialValueFor("golem_dmg")
    local armor = self:GetSpecialValueFor("golem_armor")
    local health_regen = self:GetSpecialValueFor("golem_health_regen")
    local golem_movement_speed = self:GetSpecialValueFor("golem_movement_speed")
    local golem_gold_bounty = self:GetSpecialValueFor("golem_gold_bounty")

    if self:GetCaster():HasModifier("modifier_warlock_21") then
        golem_duration = self.modifier_warlock_21
    end

    local golem = CreateUnitByName("npc_dota_warlock_golem", point, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
    golem:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = golem_duration})
    golem:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
    golem:SetOwner(self:GetCaster())

    if self:GetCaster().model_warlock == nil then
        self:GetCaster().model_warlock = golem:GetModelName()
    end

    golem:AddNewModifier(self:GetCaster(), self, "modifier_warlock_rain_of_chaos_custom", {})
    golem:SetMinimumGoldBounty(golem_gold_bounty)
    golem:SetMaximumGoldBounty(golem_gold_bounty)
    golem:SetBaseMoveSpeed(golem_movement_speed)
    golem:SetBaseMaxHealth(health)
    golem:SetMaxHealth(health)
    golem:SetHealth(golem:GetMaxHealth())
    golem:SetBaseDamageMin(damage)
    golem:SetBaseDamageMax(damage)
    golem:SetPhysicalArmorBaseValue(armor)
    golem:SetBaseHealthRegen(health_regen)

    for i=0, golem:GetAbilityCount()-1 do
        local ability = golem:GetAbilityByIndex(i)
        if ability then
            ability:SetLevel(self:GetLevel())
        end
    end

    ResolveNPCPositions(point, 128)
end

modifier_warlock_rain_of_chaos_custom = class({})
function modifier_warlock_rain_of_chaos_custom:IsHidden() return true end
function modifier_warlock_rain_of_chaos_custom:IsPurgable() return false end
function modifier_warlock_rain_of_chaos_custom:IsPurgeException() return false end
function modifier_warlock_rain_of_chaos_custom:OnCreated()
    self.invulnerable = false
    if self:GetCaster():HasModifier("modifier_warlock_21") then
        self.invulnerable = true
    end
    if not IsServer() then return end
    local attack_speed = self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_warlock_21_attackspeed
    self:SetStackCount(attack_speed)
end
function modifier_warlock_rain_of_chaos_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_DEATH,
    }
end
function modifier_warlock_rain_of_chaos_custom:OnDeath(params)
    if not IsServer() then return end
    if params.unit == self:GetParent() and self:GetCaster():HasModifier("modifier_warlock_14") then
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_imp_explode.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:DestroyParticle(particle, false)
        ParticleManager:ReleaseParticleIndex(particle)
        self:GetParent():EmitSound("Warlock_Imp.Explode")
    end
end

function modifier_warlock_rain_of_chaos_custom:CheckState()
    return
    {
        [MODIFIER_STATE_INVULNERABLE] = self.invulnerable,
        [MODIFIER_STATE_NO_HEALTH_BAR] = self.invulnerable,
    }
end
function modifier_warlock_rain_of_chaos_custom:GetModifierAttackSpeedBonus_Constant()
    if not self:GetCaster():HasModifier("modifier_warlock_21") then return end
    return self:GetStackCount()
end
function modifier_warlock_rain_of_chaos_custom:OnDestroy()
    if not IsServer() then return end
    local warlock_eldritch_summoning_custom = self:GetCaster():FindAbilityByName("warlock_eldritch_summoning_custom")
    if warlock_eldritch_summoning_custom and self:GetCaster():HasModifier("modifier_warlock_14") then
        local damage = warlock_eldritch_summoning_custom:GetSpecialValueFor("imp_explode")
        if self:GetCaster():HasModifier("modifier_warlock_14") then
            damage = damage + (self:GetCaster():GetManaRegen() / 100 * self:GetAbility().modifier_warlock_14)
        end
        local tooltip_imp_explode_radius = warlock_eldritch_summoning_custom:GetSpecialValueFor("tooltip_imp_explode_radius")
        local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, tooltip_imp_explode_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, 0, FIND_CLOSEST, false)
        for _,enemy in pairs(enemies) do
            ApplyDamage({ victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = self:GetParent(), ability = self:GetAbility()})
        end
    end
end