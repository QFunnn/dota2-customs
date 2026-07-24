--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nevermore_frenzy_custom", "heroes/npc_dota_hero_nevermore_custom/nevermore_frenzy_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_frenzy_custom_pre_buff", "heroes/npc_dota_hero_nevermore_custom/nevermore_frenzy_custom", LUA_MODIFIER_MOTION_NONE)

nevermore_frenzy_custom = class({})

nevermore_frenzy_custom.modifier_nevermore_19_damage_reduce = -10
nevermore_frenzy_custom.modifier_nevermore_19 = 40

function nevermore_frenzy_custom:OnSpellStart()
    if not IsServer() then return end

    local caster = self:GetCaster()

    local old_frenzy = caster:FindModifierByName("modifier_nevermore_frenzy_custom")
    if old_frenzy then
        old_frenzy:Destroy()
    end

    local old_pre_buff = caster:FindModifierByName("modifier_nevermore_frenzy_custom_pre_buff")
    if old_pre_buff then
        old_pre_buff:Destroy()
    end

    caster:EmitSound("Hero_Nevermore.Frenzy")
    caster:AddNewModifier(caster, self, "modifier_nevermore_frenzy_custom", {duration = self:GetSpecialValueFor("duration")})
end

modifier_nevermore_frenzy_custom = class({})
function modifier_nevermore_frenzy_custom:IsPurgable() return false end
function modifier_nevermore_frenzy_custom:IsPurgeException() return false end

function modifier_nevermore_frenzy_custom:OnCreated()
    self.max_collection_count = self:GetAbility():GetSpecialValueFor("max_collection_count")
    self.soul_collection_per_interval = self:GetAbility():GetSpecialValueFor("soul_collection_per_interval")
    self.soul_collection_radius = self:GetAbility():GetSpecialValueFor("soul_collection_radius")
    self.soul_collection_interval = self:GetAbility():GetSpecialValueFor("soul_collection_interval")
    self.soul_collection_per_hero = self:GetAbility():GetSpecialValueFor("soul_collection_per_hero")
    self.soul_collection_per_creep = self:GetAbility():GetSpecialValueFor("soul_collection_per_creep")
    self.linger_duration = self:GetAbility():GetSpecialValueFor("linger_duration")
    if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/items2_fx/mask_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
    self.enemies = {}
    self.enemies_count = 0
    self.souls_steal = 0
    self:StartIntervalThink(self.soul_collection_interval)
end

function modifier_nevermore_frenzy_custom:OnIntervalThink()
    if not IsServer() then return end
    if self.enemies_count >= self.max_collection_count then
        return
    end
    local modifier_nevermore_necromastery_custom = self:GetCaster():FindModifierByName("modifier_nevermore_necromastery_custom")
    local heroes_tick = 0
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.soul_collection_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, enemy in pairs(enemies) do
        if not self.enemies[enemy] then
            heroes_tick = heroes_tick + 1
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
            ParticleManager:SetParticleControlEnt(particle, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(particle)
            local count = self.soul_collection_per_hero
            if not enemy:IsRealHero() then
                count = self.soul_collection_per_creep
            end
            self.enemies[enemy] = count
            self.enemies_count = self.enemies_count + 1
            self.souls_steal = self.souls_steal + count
            modifier_nevermore_necromastery_custom:AddNewSoul(count, true)
            if heroes_tick >= self.soul_collection_per_interval then
                break
            end
        end
    end
end

function modifier_nevermore_frenzy_custom:OnDestroy()
    if not IsServer() then return end
    local linger_duration = self:GetAbility():GetSpecialValueFor("linger_duration")
    local modifier_nevermore_necromastery_custom = self:GetCaster():FindModifierByName("modifier_nevermore_necromastery_custom")
    local not_is_alive_enemies = {}
    local not_alive_counter = 0
    for enemy, soul_count in pairs(self.enemies) do
        if (not enemy)
        or enemy:IsNull()
        or enemy:IsUnselectable()
        or not enemy:IsAlive()
        or not self:GetCaster():IsAlive()
        then
            not_is_alive_enemies[enemy] = soul_count
            not_alive_counter = not_alive_counter + 1
        else
            modifier_nevermore_necromastery_custom:AddNewSoul(-soul_count, true)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
            ParticleManager:SetParticleControlEnt(particle, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(particle)
        end
    end
    if not self:GetCaster():IsAlive() then
        for enemy, soul_count in pairs(not_is_alive_enemies) do
            modifier_nevermore_necromastery_custom:AddNewSoul(-soul_count, true)
        end
        return
    end

    if not_alive_counter > 0 then
        local modifier_nevermore_frenzy_custom_pre_buff = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_nevermore_frenzy_custom_pre_buff", {duration = linger_duration})
        if modifier_nevermore_frenzy_custom_pre_buff then
            modifier_nevermore_frenzy_custom_pre_buff.not_is_alive_enemies = not_is_alive_enemies
            local souls_cc = 0
            for enemy, soul_count in pairs(not_is_alive_enemies) do
                souls_cc = souls_cc + soul_count
            end
            modifier_nevermore_frenzy_custom_pre_buff.souls_counter = souls_cc
        end
    end
end

function modifier_nevermore_frenzy_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_nevermore_frenzy_custom:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("bonus_move_speed")
end

function modifier_nevermore_frenzy_custom:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_nevermore_frenzy_custom:GetModifierIncomingDamage_Percentage()
	if not self:GetCaster():HasModifier("modifier_nevermore_19") then return 0 end
	return self:GetAbility().modifier_nevermore_19_damage_reduce
end

function modifier_nevermore_frenzy_custom:GetModifierPercentageCasttime()
    if not self:GetCaster():HasModifier("modifier_nevermore_19") then return 0 end
    return self:GetAbility().modifier_nevermore_19
end

modifier_nevermore_frenzy_custom_pre_buff = class({})
function modifier_nevermore_frenzy_custom_pre_buff:IsPurgable() return false end
function modifier_nevermore_frenzy_custom_pre_buff:OnDestroy()
    if not IsServer() then return end
    local modifier_nevermore_necromastery_custom = self:GetCaster():FindModifierByName("modifier_nevermore_necromastery_custom")
    for enemy, soul_count in pairs(self.not_is_alive_enemies) do
        modifier_nevermore_necromastery_custom:AddNewSoul(-soul_count, true)
    end
end