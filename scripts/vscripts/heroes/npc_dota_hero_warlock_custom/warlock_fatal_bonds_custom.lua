--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_fatal_bonds_custom", "heroes/npc_dota_hero_warlock_custom/warlock_fatal_bonds_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_fatal_bonds_custom_handler", "heroes/npc_dota_hero_warlock_custom/warlock_fatal_bonds_custom", LUA_MODIFIER_MOTION_NONE)

warlock_fatal_bonds_custom = class({})
warlock_fatal_bonds_custom.modifier_warlock_1 = 50
warlock_fatal_bonds_custom.modifier_warlock_2_duration = {-3,-6,-9}
warlock_fatal_bonds_custom.modifier_warlock_2_cooldown = {-3,-6,-9}
warlock_fatal_bonds_custom.modifier_warlock_2_manacost = {30,60,90}
warlock_fatal_bonds_custom.modifier_warlock_6 = 50 -- какой урон будет с талантом (50% от значения)
warlock_fatal_bonds_custom.modifier_warlock_7 = 150

function warlock_fatal_bonds_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit_parent.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_fatal_bonds_icon.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_warlock.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_warlock.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_warlock.vpcf", context)
end

function warlock_fatal_bonds_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_warlock_2") then
        bonus = self.modifier_warlock_2_cooldown[self:GetCaster():GetTalentLevel("modifier_warlock_2")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function warlock_fatal_bonds_custom:GetManaCost(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_warlock_2") then
        bonus = self.modifier_warlock_2_manacost[self:GetCaster():GetTalentLevel("modifier_warlock_2")]
    end
    return self.BaseClass.GetManaCost(self, iLevel) * (1 - (bonus / 100))
end

function warlock_fatal_bonds_custom:GetIntrinsicModifierName()
    return "modifier_warlock_fatal_bonds_custom_handler"
end

function warlock_fatal_bonds_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local max_targets = self:GetSpecialValueFor("count")
	local search_aoe = self:GetSpecialValueFor("search_aoe")
    self:GetCaster():EmitSound("Hero_Warlock.FatalBonds")
    if self.units_table == nil then
        self.units_table = {}
    end
    local last_target = target
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, search_aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
    if self:GetCaster():HasModifier("modifier_warlock_6") then
        table.insert(enemies, self:GetCaster())
        local friendly = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, search_aoe, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)
        for _,friend in pairs(friendly) do
            if friend ~= self:GetCaster() then
                table.insert(enemies, friend)
            end
        end
    end
    for _,enemy in pairs(enemies) do
        local duration = self:GetSpecialValueFor("duration")
        if self:GetCaster():HasModifier("modifier_warlock_2") then
            duration = duration + self.modifier_warlock_2_duration[self:GetCaster():GetTalentLevel("modifier_warlock_2")]
        end
        if enemy:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
            duration = duration * (1-enemy:GetStatusResistance())
        end
        max_targets = max_targets - 1
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_warlock_fatal_bonds_custom", {duration = duration})
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit_parent.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetCaster())
        if enemy == target then
            ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        else
            ParticleManager:SetParticleControlEnt(particle, 0, last_target, PATTACH_POINT_FOLLOW, "attach_hitloc", last_target:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(particle, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
        end
        ParticleManager:ReleaseParticleIndex(particle)
        last_target = enemy
        if max_targets <= 0 then break end
    end
    if self:GetCaster():HasModifier("modifier_warlock_6") then
        if not self:GetCaster():HasModifier("modifier_warlock_fatal_bonds_custom") then
            local duration_other = self:GetSpecialValueFor("duration")
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_warlock_fatal_bonds_custom", {duration = duration_other})
        end
    end
end

modifier_warlock_fatal_bonds_custom = class({})
function modifier_warlock_fatal_bonds_custom:IsHidden() return false end
function modifier_warlock_fatal_bonds_custom:IsPurgable() return self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() end
function modifier_warlock_fatal_bonds_custom:IsDebuff() return true end
function modifier_warlock_fatal_bonds_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_warlock_fatal_bonds_custom:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
    self.damage_share_percentage = self.ability:GetSpecialValueFor("damage_share_percentage") / 100
    if not IsServer() then return end
	local particle_head = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_fatal_bonds_icon.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
    self:AddParticle(particle_head, false, false, -1, false, true)
    table.insert(self:GetAbility().units_table, self:GetParent())
    self.damage_counter = {}
    self.interval_talent = 0
    self:StartIntervalThink(1)
end

function modifier_warlock_fatal_bonds_custom:OnIntervalThink()
    if not IsServer() then return end
    self:SetDamage()
    if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then return end
    self.interval_talent = self.interval_talent + 1
    if self.interval_talent >= 1 then
        if self:GetCaster():HasModifier("modifier_warlock_1") then
            local damage = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_warlock_1
            ApplyDamage({victim = self.parent, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK})
        end
        self.interval_talent = 0
    end
end

function modifier_warlock_fatal_bonds_custom:OnDestroy()
    if not IsServer() then return end
    for i=#self:GetAbility().units_table, 1, -1 do
        if self:GetAbility().units_table[i] then
            if self:GetAbility().units_table[i] == self.parent then
                table.remove(self:GetAbility().units_table, i)
                break
            end
        end
    end
end

function modifier_warlock_fatal_bonds_custom:DeclareFunctions()
	return { }
end

function modifier_warlock_fatal_bonds_custom:OnTakeDamage(params)
    if not IsServer() then return end
	if bit.band( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) == DOTA_DAMAGE_FLAG_REFLECTION then return end
    if params.unit ~= self.parent then return end
    if params.inflictor == self.ability then return end
    if self:GetParent() == self:GetCaster() then
        self.damage_counter[params.damage_type] = (self.damage_counter[params.damage_type] or 0) + params.original_damage
    else
        self.damage_counter[params.damage_type] = (self.damage_counter[params.damage_type] or 0) + params.damage
    end
end

function modifier_warlock_fatal_bonds_custom:SetDamage()
    if not IsServer() then return end
    for _, unit in pairs(self:GetAbility().units_table) do
        if unit and not unit:IsNull() and unit:IsAlive() and unit ~= self.parent and unit:GetTeamNumber() ~= self.caster:GetTeamNumber() then
            local effect = false
            for damage_type, damage_inc in pairs(self.damage_counter) do
                local damage = damage_inc * self.damage_share_percentage
                if self:GetCaster():HasModifier("modifier_warlock_6") then
                    damage = damage / 100 * self:GetAbility().modifier_warlock_6
                end
                ApplyDamage({ victim = unit, damage = damage, damage_type = damage_type, attacker = self.caster, ability = self.ability, damage_flags = DOTA_DAMAGE_FLAG_REFLECTION})
                effect = true
            end
            if effect then
                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
                ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
                ParticleManager:SetParticleControlEnt(particle, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
                ParticleManager:ReleaseParticleIndex(particle)
            end
        end
    end
    self.damage_counter = {}
end

modifier_warlock_fatal_bonds_custom_handler = class({})
function modifier_warlock_fatal_bonds_custom_handler:IsHidden() return self:GetStackCount() == 0 end
function modifier_warlock_fatal_bonds_custom_handler:IsPurgable() return false end
function modifier_warlock_fatal_bonds_custom_handler:IsPurgeException() return false end
function modifier_warlock_fatal_bonds_custom_handler:RemoveOnDeath() return false end
function modifier_warlock_fatal_bonds_custom_handler:GetTexture() return "warlock_7" end
function modifier_warlock_fatal_bonds_custom_handler:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(0)
    self:StartIntervalThink(0.1)
end
function modifier_warlock_fatal_bonds_custom_handler:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_warlock_7") then return end
    if self:GetAbility().units_table == nil then
        self:GetAbility().units_table = {}
    end
    self:SetStackCount(#self:GetAbility().units_table)
end
function modifier_warlock_fatal_bonds_custom_handler:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end
function modifier_warlock_fatal_bonds_custom_handler:GetModifierPreAttack_BonusDamage()
    if not self:GetCaster():HasModifier("modifier_warlock_7") then return end
    return self:GetStackCount() * self:GetAbility().modifier_warlock_7
end