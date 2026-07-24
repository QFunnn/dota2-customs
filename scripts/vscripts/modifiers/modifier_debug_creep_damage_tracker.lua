--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_debug_creep_damage_tracker = class({})

function modifier_debug_creep_damage_tracker:IsHidden() return true end
function modifier_debug_creep_damage_tracker:IsPurgable() return false end
function modifier_debug_creep_damage_tracker:IsPurgeException() return false end
function modifier_debug_creep_damage_tracker:IsPermanent() return true end
function modifier_debug_creep_damage_tracker:RemoveOnDeath() return false end
function modifier_debug_creep_damage_tracker:GetAttributes()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_debug_creep_damage_tracker:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_EVENT_ON_DEATH,
    }
end

function modifier_debug_creep_damage_tracker:OnCreated()
    if not IsServer() then return end

    self.total_damage = 0
    self.last_hit_damage = 0
    self.dps_start_time = nil
    self.hide_timer = nil
    self.owner_player_id = self:GetParent()._debug_owner_player_id
    self.prev_health = self:GetParent():GetHealth()
    self.ability_damage = {}
end

function modifier_debug_creep_damage_tracker:RecordAbilityDamage(key, amount)
    if not IsServer() then return end
    if not amount or amount <= 0 then return end
    if not self.ability_damage then self.ability_damage = {} end
    self.ability_damage[key] = (self.ability_damage[key] or 0) + amount
    if self.dps_start_time == nil then
        self.dps_start_time = GameRules:GetGameTime()
    end
    local elapsed = GameRules:GetGameTime() - (self.dps_start_time or GameRules:GetGameTime())
    local dps = (elapsed > 0) and math.floor(self.total_damage / elapsed) or math.floor(self.last_hit_damage)
    self:SendDamageUpdate(math.floor(self.total_damage), dps, math.floor(self.last_hit_damage))
    self:ResetHideTimer()
end

function modifier_debug_creep_damage_tracker:OnTakeDamage(event)
    if not IsServer() then return end

    local parent = self:GetParent()
    if event.unit ~= parent then return end

    -- Calculate actual damage dealt by tracking HP change (accounts for armor/resist)
    local current_health = parent:GetHealth()
    local actual_damage = self.prev_health - current_health

    -- If unit died, the remaining HP was the damage
    if not parent:IsAlive() then
        actual_damage = self.prev_health
    end

    self.prev_health = current_health

    if actual_damage <= 0 then return end

    self.last_hit_damage = math.floor(actual_damage)
    self.total_damage = self.total_damage + actual_damage

    if self.dps_start_time == nil then
        self.dps_start_time = GameRules:GetGameTime()
    end

    local elapsed = GameRules:GetGameTime() - self.dps_start_time
    local dps = 0
    if elapsed > 0 then
        dps = math.floor(self.total_damage / elapsed)
    else
        dps = self.last_hit_damage
    end

    self:SendDamageUpdate(math.floor(self.total_damage), dps, self.last_hit_damage)
    self:ResetHideTimer()
end

function modifier_debug_creep_damage_tracker:OnDeath(event)
    if not IsServer() then return end

    local parent = self:GetParent()
    if event.unit ~= parent then return end

    local playerID = self.owner_player_id
    if playerID == nil then return end

    -- Remove from HeroDemo tracking list
    if HeroDemo._debug_creeps and HeroDemo._debug_creeps[playerID] then
        for i, creep in ipairs(HeroDemo._debug_creeps[playerID]) do
            if creep == parent then
                table.remove(HeroDemo._debug_creeps[playerID], i)
                break
            end
        end
    end

    -- Notify client to remove from UI
    local player = PlayerResource:GetPlayer(playerID)
    if player then
        CustomGameEventManager:Send_ServerToPlayer(player, "debugger_creep_died", {
            entindex = parent:entindex(),
        })
    end

    if self.hide_timer then
        Timers:RemoveTimer(self.hide_timer)
        self.hide_timer = nil
    end
end

function modifier_debug_creep_damage_tracker:SendDamageUpdate(total, dps, last_hit)
    local parent = self:GetParent()
    if not parent or parent:IsNull() then return end

    local playerID = self.owner_player_id
    if playerID == nil then return end

    local player = PlayerResource:GetPlayer(playerID)
    if not player then return end

    local ability_damage_serialized = {}
    if self.ability_damage then
        for k, v in pairs(self.ability_damage) do
            ability_damage_serialized[k] = math.floor(v)
        end
    end

    CustomGameEventManager:Send_ServerToPlayer(player, "debugger_creep_damage_update", {
        entindex = parent:entindex(),
        total_damage = total,
        dps = dps,
        last_hit = last_hit,
        ability_damage = ability_damage_serialized,
    })
end

function modifier_debug_creep_damage_tracker:ResetHideTimer()
    if self.hide_timer then
        Timers:RemoveTimer(self.hide_timer)
    end

    self.hide_timer = Timers:CreateTimer(10.0, function()
        self:SendDamageHide()
        return nil
    end)
end

function modifier_debug_creep_damage_tracker:SendDamageHide()
    local parent = self:GetParent()
    if not parent or parent:IsNull() then return end

    local playerID = self.owner_player_id
    if playerID == nil then return end

    local player = PlayerResource:GetPlayer(playerID)
    if not player then return end

    CustomGameEventManager:Send_ServerToPlayer(player, "debugger_creep_damage_hide", {
        entindex = parent:entindex(),
    })
end

function modifier_debug_creep_damage_tracker:ResetStats()
    self.total_damage = 0
    self.last_hit_damage = 0
    self.dps_start_time = nil
    self.ability_damage = {}

    if self.hide_timer then
        Timers:RemoveTimer(self.hide_timer)
        self.hide_timer = nil
    end

    self:SendDamageHide()
end