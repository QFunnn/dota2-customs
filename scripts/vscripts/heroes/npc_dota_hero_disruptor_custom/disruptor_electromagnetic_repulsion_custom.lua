--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_disruptor_electromagnetic_repulsion_custom", "heroes/npc_dota_hero_disruptor_custom/disruptor_electromagnetic_repulsion_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

disruptor_electromagnetic_repulsion_custom = class({})

function disruptor_electromagnetic_repulsion_custom:GetIntrinsicModifierName()
    return "modifier_disruptor_electromagnetic_repulsion_custom"
end

modifier_disruptor_electromagnetic_repulsion_custom = class({})
function modifier_disruptor_electromagnetic_repulsion_custom:IsPurgable() return false end
function modifier_disruptor_electromagnetic_repulsion_custom:IsPurgeException() return false end
function modifier_disruptor_electromagnetic_repulsion_custom:IsPurgeException() return false end
function modifier_disruptor_electromagnetic_repulsion_custom:IsHidden() return true end
function modifier_disruptor_electromagnetic_repulsion_custom:RemoveOnDeath() return false end

function modifier_disruptor_electromagnetic_repulsion_custom:OnCreated()
    self.current_damage = 0
    self.damage_threshold = self:GetAbility():GetSpecialValueFor("damage_threshold")
    self.effect_radius = self:GetAbility():GetSpecialValueFor("effect_radius")
    self.knockback_duration = self:GetAbility():GetSpecialValueFor("knockback_duration")
    self.damage_reset_interval = self:GetAbility():GetSpecialValueFor("damage_reset_interval")
    self.distance_per_int = self:GetAbility():GetSpecialValueFor("distance_per_int")
    self.damage_per_int = self:GetAbility():GetSpecialValueFor("damage_per_int")
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_disruptor_electromagnetic_repulsion_custom:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_disruptor_electromagnetic_repulsion_custom:OnIntervalThink()
    self.current_damage = 0
end

function modifier_disruptor_electromagnetic_repulsion_custom:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end
    if self:GetParent():PassivesDisabled() then return end
    if not self:GetAbility():IsFullyCastable() then return end
    if self.is_triggering then return end
	self.current_damage = self.current_damage + params.damage
	if self.current_damage >= self.damage_threshold then
        self.is_triggering = true
        self.current_damage = 0
        self:GetAbility():UseResources(false, false, false, true)

        Timers:CreateTimer(FrameTime(), function()
            self.is_triggering = false
        end)

        local radius = self.effect_radius + (self.distance_per_int * self:GetParent():GetIntellect(false))
        local damage = self.damage_per_int * self:GetParent():GetIntellect(false)
        if self:GetCaster():HasModifier("modifier_disruptor_6") then
            damage = self.damage_per_int * self:GetParent():GetStrength()
        end
        self:GetParent():EmitSound("Hero_Disruptor.Innate.Knockback")
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_pulse_knockback_area.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(particle, 2, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 7, Vector(self.effect_radius, 1, 1))
        ParticleManager:ReleaseParticleIndex(particle)
        self:GetParent():EmitSound("Hero_Disruptor.Innate.Knockbac")
        local units = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.effect_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        for _, unit in pairs(units) do
            local distance = (unit:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
            local knockback_distance = radius - distance
            local dir = (unit:GetAbsOrigin() - self:GetParent():GetAbsOrigin())
            dir.z = 0
            dir = dir:Normalized()
            ApplyDamage({attacker = self:GetParent(), victim = unit, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
            unit:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_generic_knockback_lua", { duration = self.knockback_duration, distance = knockback_distance, height = 0, direction_x = dir.x, direction_y = dir.y})
        end
	end
    self:StartIntervalThink(self.damage_reset_interval)
end