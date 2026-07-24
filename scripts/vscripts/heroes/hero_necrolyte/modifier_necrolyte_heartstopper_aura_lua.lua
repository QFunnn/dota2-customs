--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_necrolyte_heartstopper_aura_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_necrolyte_heartstopper_aura_lua:IsHidden()
    return false
end

function modifier_necrolyte_heartstopper_aura_lua:IsDebuff()
    return false
end

function modifier_necrolyte_heartstopper_aura_lua:IsPurgable()
    return false
end

function modifier_necrolyte_heartstopper_aura_lua:IsPassive()
    return true
end

--------------------------------------------------------------------------------
-- Aura
function modifier_necrolyte_heartstopper_aura_lua:IsAura()
    if self:GetParent():PassivesDisabled() then
        return false
    end
    return true
end

function modifier_necrolyte_heartstopper_aura_lua:GetModifierAura()
    return "modifier_necrolyte_heartstopper_aura_lua_effect"
end

function modifier_necrolyte_heartstopper_aura_lua:GetAuraRadius()
    return self.aura_radius
end

function modifier_necrolyte_heartstopper_aura_lua:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_necrolyte_heartstopper_aura_lua:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_necrolyte_heartstopper_aura_lua:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS
end

function modifier_necrolyte_heartstopper_aura_lua:GetAuraDuration()
    return 0.5
end
--------------------------------------------------------------------------
-- Initializations
function modifier_necrolyte_heartstopper_aura_lua:OnCreated(kv)
    -- references
    self.aura_radius = self:GetAbility():GetSpecialValueFor("aura_radius")
    self.regen_duration = self:GetAbility():GetSpecialValueFor("regen_duration")
    self.hero_multiplier = self:GetAbility():GetSpecialValueFor("hero_multiplier")
    self.regen_expire_times = {}
    self.stack_count = 0
    if IsServer() then
        self.counter = self:GetParent():AddNewModifier(
        self:GetParent(), -- player source
        self:GetAbility(), -- ability source
        "modifier_necrolyte_heartstopper_aura_lua_counter", -- modifier name
        {}
        )
    end
end

function modifier_necrolyte_heartstopper_aura_lua:OnRefresh(kv)
    if IsServer() then
        self:OnCreated()
    end
end

function modifier_necrolyte_heartstopper_aura_lua:OnDestroy()
    if IsServer() then
        self:GetParent():RemoveModifierByName("modifier_necrolyte_heartstopper_aura_lua_counter")
    end
end

function modifier_necrolyte_heartstopper_aura_lua:OnDeathEvent(params)
    local attacker = params.attacker
    local unit_killed = params.unit

    if attacker ~= self:GetParent() then return end

    if attacker:GetTeamNumber() == unit_killed:GetTeamNumber() or unit_killed:IsIllusion() or unit_killed:IsTempestDouble() or unit_killed:HasModifier("modifier_arc_warden_tempest_double_lua")  then
        return
    end

    local regen_expire_times = GameRules:GetGameTime() + self.regen_duration

    local stack_to_add = 1
    if unit_killed:IsRealHero() then
        stack_to_add = self.hero_multiplier
    end
    for _ = 1, stack_to_add, 1 do
        table.insert(self.regen_expire_times, regen_expire_times)
    end
    self.stack_count = self.stack_count + stack_to_add

    if self.stack_count >= 1 then
        self.counter:SetStackCount(self.stack_count)
        self:StartIntervalThink(0.1)
    else
        self.counter:SetStackCount(self.stack_count)
    end

end

function modifier_necrolyte_heartstopper_aura_lua:OnIntervalThink()

    local flNow = GameRules:GetGameTime()

    for _, expire_time in pairs(self.regen_expire_times) do
        if (expire_time > flNow) then
            break
        end
        table.remove(self.regen_expire_times, 1)
        self.stack_count = self.stack_count - 1
    end

    self.counter:SetStackCount(self.stack_count)

    if self.stack_count <= 0 then
        self:StartIntervalThink(-1)
    end
end