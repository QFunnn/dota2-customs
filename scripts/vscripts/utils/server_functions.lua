--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CDOTA_BaseNPC:HasShard()
    return self:HasModifier("modifier_item_aghanims_shard")
end

function CDOTA_BaseNPC:DeleteModifiersList(modifiers_list)
    if not self then return end
    if self:IsNull() then return end
    for _, modifier_name in pairs(modifiers_list) do
        self:RemoveAllModifiersOfName(modifier_name)
    end
end

function CDOTA_BaseNPC:ResetCooldown()
    if self:IsNull() then return end
    for _, mod in pairs(self:FindAllModifiersByName("modifier_custom_cooldown_ability")) do
        if mod and not mod:IsNull() then
            mod:Destroy()
        end
    end
    for i = 0, self:GetAbilityCount()-1 do
		local ability = self:GetAbilityByIndex(i)
        if ability then
            ability:RefreshCharges()
            ability:EndCooldown()
            if ability:GetToggleState() and ability:GetAbilityName() == "pudge_rot" then 
                ability:ToggleAbility()
            end
        end
	end
	for i = 0,20 do
		local item = self:GetItemInSlot(i)
		if item then
			item:EndCooldown()
            item:RefreshCharges()
		end
	end
end

function CDOTA_BaseNPC:IsDisarmedCustom(ignore_mod_table)
    for _, mod in pairs(self:FindAllModifiers()) do
        if not ignore_mod_table[mod:GetName()] then
            local tables = {}
            mod:CheckStateToTable(tables)
            for state_name, mod_table in pairs(tables) do
                if tostring(state_name) == tostring(MODIFIER_STATE_DISARMED) then
                    return true
                end
            end
        end
    end
    return false
end

function IsValid(...)
    for i = 1, select("#", ...) do
        local entity = select(i, ...)
        if not entity or not entity.IsNull or entity:IsNull() then
            return false
        end
    end
    return true
end

function SendGameHudNotification(player_id, payload)
    local numeric_player_id = tonumber(player_id)
    if numeric_player_id == nil or numeric_player_id < 0 then return false end

    local player = PlayerResource and PlayerResource:GetPlayer(numeric_player_id) or nil
    if not IsValid(player) then return false end

    if type(payload) ~= "table" then
        payload = { text = tostring(payload or "") }
    end

    payload.duration = tonumber(payload.duration) or 5
    CustomGameEventManager:Send_ServerToPlayer(player, "game_event_hud_notification", payload)
    return true
end

function BuildLevelUpStatDeltaPayload(stats_table, value_kind)
    if type(stats_table) ~= "table" then return {} end

    local keys = {}
    for stat_name, value in pairs(stats_table) do
        if (tonumber(value) or 0) ~= 0 then
            table.insert(keys, stat_name)
        end
    end

    table.sort(keys, function(a, b)
        return tostring(a) < tostring(b)
    end)

    local result = {}
    for _, stat_name in ipairs(keys) do
        table.insert(result, {
            stat = stat_name,
            value = tonumber(stats_table[stat_name]) or 0,
            value_kind = value_kind or "fixed",
        })
    end

    return result
end

function DiffLevelUpStatChannels(old_stats, new_stats)
    local result = {}

    local function add_value(stat_name, value)
        local numeric_value = tonumber(value) or 0
        if numeric_value ~= 0 then
            result[stat_name] = (tonumber(result[stat_name]) or 0) + numeric_value
        end
    end

    local function flatten(stats, sign)
        if type(stats) ~= "table" then return end

        if type(stats.base) == "table" or type(stats.bonus) == "table" then
            for _, channel_name in ipairs({ "base", "bonus" }) do
                for stat_name, value in pairs(stats[channel_name] or {}) do
                    add_value(stat_name, sign * (tonumber(value) or 0))
                end
            end
            return
        end

        for stat_name, value in pairs(stats) do
            if stat_name ~= "base" and stat_name ~= "bonus" then
                add_value(stat_name, sign * (tonumber(value) or 0))
            end
        end
    end

    flatten(new_stats, 1)
    flatten(old_stats, -1)

    return result
end

function IsLevelUpGameplayInteractionIgnored(unit)
    return IsValid(unit) and unit.levelup_ignore_gameplay_interactions == true
end

function ConsumeLevelUpItemCharge(caster, item)
    if not IsValid(caster, item) then return false end

    local charges = 0
    if item.GetCurrentCharges then
        charges = tonumber(item:GetCurrentCharges()) or 0
    end

    if charges > 1 and item.SetCurrentCharges then
        item:SetCurrentCharges(charges - 1)
    else
        caster:TakeItem(item)
    end

    local player = caster.GetPlayerOwner and caster:GetPlayerOwner() or nil
    if IsValid(player) then
        CustomGameEventManager:Send_ServerToPlayer(player, "game_event_sync_item_slots", {})
    end

    return true
end

local LEVELUP_BLINK_ABILITY_NAMES = {
    "levelup_void_spirit_astral_step",
    "levelup_sand_king_burrowstrike",
    "levelup_mirana_leap",
    "levelup_earth_spirit_rolling_boulder",
}

function EnsureTwinGateWarpAbility(hero)
    if not IsValid(hero) or not hero:IsRealHero() then return nil end

    local ability = hero:FindAbilityByName("custom_twin_gate_portal_warp")
    if not IsValid(ability) then
        ability = hero:AddAbility("custom_twin_gate_portal_warp")
    end
    if not IsValid(ability) then return nil end

    ability:SetLevel(1)
    ability:SetHidden(false)
    ability:SetActivated(true)
    ability:EndCooldown()
    return ability
end

function ReplaceLevelUpBlinkAbility(hero, next_ability_name)
    if not IsValid(hero) then return false end

    next_ability_name = tostring(next_ability_name or "")
    if next_ability_name == "" then return false end

    local blink_ability = hero:FindAbilityByName("levelup_blink")
    if not IsValid(blink_ability) then
        blink_ability = hero:AddAbility("levelup_blink")
        if IsValid(blink_ability) then
            blink_ability:SetLevel(1)
        end
    end
    if not IsValid(blink_ability) then return false end

    local previous_replacement = tostring(hero._levelup_blink_replacement_ability or "")
    if previous_replacement ~= "" and previous_replacement ~= next_ability_name then
        local previous_ability = hero:FindAbilityByName(previous_replacement)
        if IsValid(previous_ability) and type(hero.SwapAbilities) == "function" then
            hero:SwapAbilities("levelup_blink", previous_replacement, true, false)
        end
    end

    for _, ability_name in ipairs(LEVELUP_BLINK_ABILITY_NAMES) do
        if ability_name ~= next_ability_name and IsValid(hero:FindAbilityByName(ability_name)) then
            hero:RemoveAbility(ability_name)
        end
    end

    local ability = hero:FindAbilityByName(next_ability_name)
    if not IsValid(ability) then
        ability = hero:AddAbility(next_ability_name)
    end
    if not IsValid(ability) then return false end

    ability:SetLevel(1)

    if type(hero.SwapAbilities) == "function" then
        hero:SwapAbilities("levelup_blink", next_ability_name, false, true)
    end

    hero._levelup_blink_replacement_ability = next_ability_name

    local player = hero:GetPlayerOwner()
    if IsValid(player) then
        CustomGameEventManager:Send_ServerToPlayer(player, "game_event_update_player_abilities", {})
    end

    return true
end

local LEVELUP_CAMERA_DISTANCE_DEFAULT = 1134
local LEVELUP_CAMERA_DISTANCE_MIN = 900
local LEVELUP_CAMERA_DISTANCE_MAX = 1800

local function NormalizeLevelUpCameraDistance(distance)
    local normalized = math.floor((tonumber(distance) or LEVELUP_CAMERA_DISTANCE_DEFAULT) + 0.5)
    return math.max(LEVELUP_CAMERA_DISTANCE_MIN, math.min(LEVELUP_CAMERA_DISTANCE_MAX, normalized))
end

function GetLevelUpPlayerSettings(player_id)
    local player_info = player_data and player_data.players_list and player_data.players_list[player_id] or nil
    local server_data = player_info and player_info.server_data or nil
    if not server_data then return nil end

    server_data.player_settings = server_data.player_settings or {}
    if server_data.player_settings.particles_enabled == nil then
        server_data.player_settings.particles_enabled = true
    end
    server_data.player_settings.camera_distance = NormalizeLevelUpCameraDistance(server_data.player_settings.camera_distance)
    if server_data.player_settings.damage_numbers_enabled == nil then
        server_data.player_settings.damage_numbers_enabled = true
    end

    return server_data.player_settings
end

function IsLevelUpPlayerParticlesEnabled(player_id)
    local settings = GetLevelUpPlayerSettings(player_id)
    if not settings then return true end
    return settings.particles_enabled ~= false and settings.particles_enabled ~= 0
end

function IsLevelUpPlayerDamageNumbersEnabled(player_id)
    local settings = GetLevelUpPlayerSettings(player_id)
    if not settings then return true end
    return settings.damage_numbers_enabled ~= false and settings.damage_numbers_enabled ~= 0
end

function SetLevelUpPlayerParticlesEnabled(player_id, enabled)
    local settings = GetLevelUpPlayerSettings(player_id)
    if not settings then return false end

    settings.particles_enabled = enabled == true or enabled == 1 or enabled == "1"

    if CustomTables then
        CustomTables:SetTableValue("player_settings", tostring(player_id), settings)
    end

    if LevelUpParticleManager then
        LevelUpParticleManager:SetPlayerEnabled(player_id, settings.particles_enabled)
    end
    if web_server and web_server.QueueSavePlayer then
        web_server:QueueSavePlayer(player_id, "player_settings")
    end

    return true
end

function SetLevelUpPlayerCameraDistance(player_id, distance)
    local settings = GetLevelUpPlayerSettings(player_id)
    if not settings then return false end

    settings.camera_distance = NormalizeLevelUpCameraDistance(distance)

    if CustomTables then
        CustomTables:SetTableValue("player_settings", tostring(player_id), settings)
    end

    if web_server and web_server.QueueSavePlayer then
        web_server:QueueSavePlayer(player_id, "player_settings")
    end

    return true
end

function SetLevelUpPlayerDamageNumbersEnabled(player_id, enabled)
    local settings = GetLevelUpPlayerSettings(player_id)
    if not settings then return false end

    settings.damage_numbers_enabled = enabled == true or enabled == 1 or enabled == "1"

    if CustomTables then
        CustomTables:SetTableValue("player_settings", tostring(player_id), settings)
    end

    if web_server and web_server.QueueSavePlayer then
        web_server:QueueSavePlayer(player_id, "player_settings")
    end

    return true
end

if not LevelUpParticleManager then
    _G.LevelUpParticleManager = {
        active_particles = {},
        next_handle_id = 0,
    }
end

function LevelUpParticleManager:GetMaxPlayerCount()
    return (DOTA_MAX_TEAM_PLAYERS or 24) - 1
end

function LevelUpParticleManager:CreateParticle(particle_name, attach_type, owner)
    local handle = {
        __levelup_particle_handle = true,
        particle_name = particle_name,
        attach_type = attach_type,
        owner = owner,
        particles_by_player = {},
    }

    self.next_handle_id = (self.next_handle_id or 0) + 1
    handle.handle_id = self.next_handle_id
    self.active_particles[handle.handle_id] = handle

    if not particle_name or particle_name == "" then
        return handle
    end

    for player_id = 0, self:GetMaxPlayerCount() do
        if PlayerResource:IsValidPlayerID(player_id) and IsLevelUpPlayerParticlesEnabled(player_id) then
            local player = PlayerResource:GetPlayer(player_id)
            if player then
                local particle = ParticleManager:CreateParticleForPlayer(particle_name, attach_type, owner, player)
                handle.particles_by_player[player_id] = particle
            end
        end
    end

    return handle
end

function LevelUpParticleManager:IsParticleHandle(handle)
    return type(handle) == "table" and handle.__levelup_particle_handle == true
end

function LevelUpParticleManager:ForEachParticle(handle, callback)
    if not self:IsParticleHandle(handle) then return end
    for player_id, particle in pairs(handle.particles_by_player or {}) do
        if particle then
            callback(particle, player_id)
        end
    end
end

function LevelUpParticleManager:SetParticleControl(handle, control_point, value)
    self:ForEachParticle(handle, function(particle)
        ParticleManager:SetParticleControl(particle, control_point, value)
    end)
end

function LevelUpParticleManager:SetParticleControlEnt(handle, control_point, entity, attach_type, attachment_name, fallback_position, include_wearables)
    self:ForEachParticle(handle, function(particle)
        ParticleManager:SetParticleControlEnt(particle, control_point, entity, attach_type, attachment_name, fallback_position, include_wearables)
    end)
end

function LevelUpParticleManager:SetParticleControlForward(handle, control_point, forward)
    self:ForEachParticle(handle, function(particle)
        ParticleManager:SetParticleControlForward(particle, control_point, forward)
    end)
end

function LevelUpParticleManager:SetParticleControlOrientation(handle, control_point, forward, right, up)
    self:ForEachParticle(handle, function(particle)
        ParticleManager:SetParticleControlOrientation(particle, control_point, forward, right, up)
    end)
end

function LevelUpParticleManager:SetParticleControlTransformForward(handle, control_point, origin, forward)
    self:ForEachParticle(handle, function(particle)
        ParticleManager:SetParticleControlTransformForward(particle, control_point, origin, forward)
    end)
end

function LevelUpParticleManager:DestroyParticle(handle, immediate)
    if not self:IsParticleHandle(handle) or handle.destroyed then return end
    handle.destroyed = true
    self:ForEachParticle(handle, function(particle)
        ParticleManager:DestroyParticle(particle, immediate)
    end)
end

function LevelUpParticleManager:ReleaseParticleIndex(handle)
    if not self:IsParticleHandle(handle) or handle.released then return end
    handle.released = true
    self:ForEachParticle(handle, function(particle)
        ParticleManager:ReleaseParticleIndex(particle)
    end)
    self.active_particles[handle.handle_id] = nil
end

function LevelUpParticleManager:SetPlayerEnabled(player_id, enabled)
    if enabled then return end
    for _, handle in pairs(self.active_particles or {}) do
        local particle = handle.particles_by_player and handle.particles_by_player[player_id] or nil
        if particle then
            if not handle.destroyed then
                ParticleManager:DestroyParticle(particle, false)
            end
            ParticleManager:ReleaseParticleIndex(particle)
            handle.particles_by_player[player_id] = nil
        end
    end
end

function GetProjectileFxSourceOrigin(source)
    if not IsValid(source) then
        return Vector(0, 0, 0)
    end

    if source.ScriptLookupAttachment and source.GetAttachmentOrigin then
        local attachment = source:ScriptLookupAttachment("attach_attack1")
        if attachment and attachment > 0 then
            return source:GetAttachmentOrigin(attachment)
        end
    end

    return source:GetAbsOrigin()
end

local function GetProjectileFxOrigin(source, data)
    data = data or {}
    if data.origin then
        return data.origin
    end

    return GetProjectileFxSourceOrigin(source)
end

function CreateProjectileFx(source, projectile, particle_name, target_data, point_data)
    if not particle_name or particle_name == "" then return nil end

    local fx = LevelUpParticleManager:CreateParticle(particle_name, PATTACH_WORLDORIGIN, nil)
    local cleanup_done = false
    local function cleanup()
        if cleanup_done then return end
        cleanup_done = true
        LevelUpParticleManager:DestroyParticle(fx, false)
        LevelUpParticleManager:ReleaseParticleIndex(fx)
    end

    if target_data then
        local origin = GetProjectileFxOrigin(source, target_data)
        LevelUpParticleManager:SetParticleControl(fx, 0, origin)
        LevelUpParticleManager:SetParticleControl(fx, 1, origin)
        LevelUpParticleManager:SetParticleControl(fx, 2, Vector(tonumber(target_data.speed) or 0, 0, 0))
    elseif point_data then
        local origin = GetProjectileFxOrigin(source, point_data)
        local direction = point_data.direction or Vector(0, 0, 0)
        local speed = tonumber(point_data.speed) or 0
        LevelUpParticleManager:SetParticleControl(fx, 0, origin)
        LevelUpParticleManager:SetParticleControl(fx, 1, direction * speed)
    end

    Timers:CreateTimer(FrameTime(), function()
        if not projectile or not ProjectileManager:IsValidProjectile(projectile) then
            cleanup()
            return nil
        end

        if target_data then
            local projectile_location = ProjectileManager:GetTrackingProjectileLocation(projectile)
            if projectile_location then
                LevelUpParticleManager:SetParticleControl(fx, 1, projectile_location)
            end
        end

        return FrameTime()
    end)

    return fx
end

function CDOTA_BaseNPC:AddNewModifierDelay(parent, ability, modifier_name, params)
    local parent = self
    Timers:CreateTimer(FrameTime(), function()
        if not parent:IsAlive() then return FrameTime() end
        self:AddNewModifier(parent, ability, modifier_name, params)
    end)
end

function FlagExist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function string.split( inputStr, delimiter )
    local d = delimiter or '%s' 
    local t={} 
    for field,s in string.gmatch(inputStr, "([^"..delimiter.."]*)("..delimiter.."?)") do 
        table.insert(t,field) 
        if s=="" then 
            return t 
        end 
    end
end

function CDOTA_BaseNPC:MoveToPositionAggressive(point)
    local order = 
    {
        UnitIndex = self:entindex(),
        OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
        Position = point,
        Queue = false
    }
    ExecuteOrderFromTable(order)
end

--[[
    Создаёт стабильный source_key для любых source-бонусов (предмет, абилка, модификатор и т.д.).
    Примеры:
    GetSourceKey(ability, "item_levelup_tester") -> "item_levelup_tester_123"
    GetSourceKey(123, "wave_bonus")              -> "wave_bonus_123"
]]
function GetSourceKey(source_entity, source_prefix)
    if source_entity == nil then
        return nil
    end

    local prefix = tostring(source_prefix or "source")
    if prefix == "" then
        prefix = "source"
    end

    local source_id = nil
    local source_type = type(source_entity)

    if source_type == "number" then
        source_id = math.floor(source_entity)
    elseif source_type == "string" then
        source_id = source_entity
    else
        if source_entity.IsNull and source_entity:IsNull() then
            return nil
        end

        if source_entity.entindex then
            source_id = source_entity:entindex()
        elseif source_entity.GetEntityIndex then
            source_id = source_entity:GetEntityIndex()
        end
    end

    if source_id == nil then
        return nil
    end

    return prefix .. "_" .. tostring(source_id)
end

function dprint(...)
    if not (IsInToolsMode() or GameRules:IsCheatMode()) then return end
    print(...)
end

function GetRealHero(hAttacker)
    if not hAttacker then
        return hAttacker
    end
    
    if hAttacker.IsRealHero and hAttacker.IsIllusion and not hAttacker:IsRealHero() and not hAttacker:IsIllusion() then
        local owner = hAttacker:GetOwner()
        if owner and owner:IsBaseNPC() then
            return owner
        end
    end
    if hAttacker.IsRealHero and hAttacker.IsIllusion and hAttacker:IsRealHero() and not hAttacker:IsIllusion() and hAttacker.IS_CUSTOM_ILLUSION_RD then
        local playerID = hAttacker:GetPlayerID()
        local hero = PlayerResource:GetSelectedHeroEntity(playerID)
        if hero then
            return hero
        end
    end
    if hAttacker.IsHero and hAttacker.IsIllusion and hAttacker:IsHero() and hAttacker:IsIllusion() then
        local playerID = hAttacker:GetPlayerID()
        local hero = PlayerResource:GetSelectedHeroEntity(playerID)
        if hero then
            return hero
        end
    end
    return hAttacker
end

function GetLevelUpUnitOwnerPlayerID(unit)
    if not IsValid(unit) then return nil end

    local stored_player_id = tonumber(unit.levelup_summon_owner_player_id)
    if stored_player_id ~= nil and stored_player_id >= 0 then
        return stored_player_id
    end

    if unit.GetPlayerOwnerID then
        local player_id = unit:GetPlayerOwnerID()
        if player_id ~= nil and player_id >= 0 then
            return player_id
        end
    end

    if unit.GetMainControllingPlayer then
        local player_id = unit:GetMainControllingPlayer()
        if player_id ~= nil and player_id >= 0 then
            return player_id
        end
    end

    local owner = unit.GetOwner and unit:GetOwner() or nil
    if IsValid(owner) then
        if owner.GetPlayerOwnerID then
            local player_id = owner:GetPlayerOwnerID()
            if player_id ~= nil and player_id >= 0 then
                return player_id
            end
        end

        if GetRealHero then
            local owner_hero = GetRealHero(owner)
            if IsValid(owner_hero) and owner_hero.GetPlayerOwnerID then
                local player_id = owner_hero:GetPlayerOwnerID()
                if player_id ~= nil and player_id >= 0 then
                    return player_id
                end
            end
        end
    end

    return nil
end

function GetLevelUpUnitOwnerHero(unit)
    if not IsValid(unit) then return nil end

    if unit.IsRealHero and unit:IsRealHero() then return unit end

    local owner_hero_entindex = tonumber(unit.levelup_summon_owner_hero_entindex)
    if owner_hero_entindex ~= nil then
        local owner_hero = EntIndexToHScript(owner_hero_entindex)
        if IsValid(owner_hero) and owner_hero.IsRealHero and owner_hero:IsRealHero() then
            return owner_hero
        end
    end

    local owner = unit.GetOwner and unit:GetOwner() or nil
    if IsValid(owner) then
        if owner.IsRealHero and owner:IsRealHero() then
            return owner
        end

        if GetRealHero then
            local owner_hero = GetRealHero(owner)
            if IsValid(owner_hero) and owner_hero.IsRealHero and owner_hero:IsRealHero() then
                return owner_hero
            end
        end
    end

    local player_id = GetLevelUpUnitOwnerPlayerID(unit)
    if player_id ~= nil and player_id >= 0 then
        local selected_hero = PlayerResource:GetSelectedHeroEntity(player_id)
        if IsValid(selected_hero) and selected_hero.IsRealHero and selected_hero:IsRealHero() then
            return selected_hero
        end
    end

    return nil
end

function IsLevelUpSummon(unit)
    if not IsValid(unit) then return false end
    if unit.IsRealHero and unit:IsRealHero() then return false end

    local unit_name = unit.GetUnitName and unit:GetUnitName() or ""
    if unit_name == "npc_levelup_main_building" then return false end
    if unit_name == "npc_dota_thinker" or unit_name == "npc_dota_companion" then return false end

    local player_id = GetLevelUpUnitOwnerPlayerID(unit)
    if player_id == nil or player_id < 0 then return false end

    return true
end

function to_number(value, fallback)
    local num = tonumber(value)
    if num == nil then
        return fallback
    end
    return num
end

--[[
    Помощник (assistant) - allied ranged summon, который спавнится на линии игрока.
    Помечается полем unit.levelup_is_assistant = true при спавне (AssistantManager).
]]
function IsLevelUpAssistant(unit)
    return IsValid(unit) and unit.levelup_is_assistant == true
end

--[[
    Может ли юнит триггерить hero-only procs (extra attacks, bounce, ult-procs,
    карточные эффекты, рассчитанные только на атаки реального героя).
    Для помощников - false: помощник атакует и убивает, но не размножает
    hero-only механики. Сами герои - true.
]]
function CanUnitTriggerHeroOnlyProc(unit)
    if not IsValid(unit) then return false end
    if IsLevelUpAssistant(unit) then return false end
    return true
end

--[[
    Может ли юнит триггерить собственные special-эффекты помощника.
    True только для помощников (используется спец-бонусами из итерации 3).
]]
function CanAssistantTriggerAssistantSpecial(unit)
    return IsLevelUpAssistant(unit)
end

--[[
    Зажимает позицию pos так, чтобы она не выходила за radius от center.
    Если pos уже внутри радиуса - возвращается как есть.
]]
function ClampPositionToRadius(pos, center, radius)
    if not pos or not center then return pos end
    local max_radius = math.max(0, tonumber(radius) or 0)
    local offset = pos - center
    local distance = offset:Length2D()
    if distance <= max_radius or distance <= 0.001 then
        return pos
    end
    return center + offset * (max_radius / distance)
end

--[[
    Централизованный helper playerID -> laneID (1..4).
    Соответствие живёт в wave_manager (lane_states / GetAssignedLaneIndexForPlayer);
    оборачиваем его, чтобы помощники и прочие системы не плодили разрозненные
    костыли определения линии.
]]
function GetLevelUpPlayerLaneIndex(player_id)
    if player_id == nil or player_id < 0 then return nil end
    if wave_manager and wave_manager.GetAssignedLaneIndexForPlayer then
        return wave_manager:GetAssignedLaneIndexForPlayer(player_id)
    end
    return nil
end

local function copy_table_deep(data)
    if type(data) ~= "table" then
        return {}
    end

    local out = {}
    for key, value in pairs(data) do
        if type(value) == "table" then
            out[key] = copy_table_deep(value)
        else
            out[key] = value
        end
    end
    return out
end

--[[
    Приводит режим применения стат-бонуса к двум каналам: "base" или "bonus".
    Поддерживает boolean/string/table форматы (как в LevelUpSetCustomStatsBonus).
]]
function ResolveStatBonusMode(mode_or_options)
    if type(mode_or_options) == "boolean" then
        return mode_or_options and "bonus" or "base"
    end

    if type(mode_or_options) == "string" then
        local mode = string.lower(mode_or_options)
        if mode == "bonus" or mode == "green" then
            return "bonus"
        end
        return "base"
    end

    if type(mode_or_options) == "table" then
        if mode_or_options.bonus == true then
            return "bonus"
        end
        local mode = mode_or_options.mode or mode_or_options.kind
        if type(mode) == "string" then
            local normalized = string.lower(mode)
            if normalized == "bonus" or normalized == "green" then
                return "bonus"
            end
        end
    end

    return "base"
end

--[[
    Нормализует стат-бонусы к виду:
    { base = {...}, bonus = {...} }.
    Если вход плоский ({ damage = 10 }), попадёт в канал mode_or_options (по умолчанию base).
]]
function NormalizeStatBonuses(raw_stats, mode_or_options)
    if type(raw_stats) ~= "table" then
        return { base = {}, bonus = {} }
    end

    if type(raw_stats.base) == "table" or type(raw_stats.bonus) == "table" then
        return {
            base = copy_table_deep(raw_stats.base or {}),
            bonus = copy_table_deep(raw_stats.bonus or {}),
        }
    end

    local mode = ResolveStatBonusMode(mode_or_options)
    if mode == "bonus" then
        return {
            base = {},
            bonus = copy_table_deep(raw_stats),
        }
    end

    return {
        base = copy_table_deep(raw_stats),
        bonus = {},
    }
end

--[[
    Проверяет, есть ли в бонусах хотя бы одно ненулевое числовое значение.
]]
function HasAnyStatBonuses(raw_stats)
    local normalized = NormalizeStatBonuses(raw_stats, "base")

    for _, channel in pairs(normalized) do
        if type(channel) == "table" then
            for _, value in pairs(channel) do
                if to_number(value, 0) ~= 0 then
                    return true
                end
            end
        end
    end

    return false
end

--[[
    Нормализует proc trigger к нижнему регистру и подставляет default_trigger, если триггер пустой.
]]
function GetNormalizedProcTrigger(trigger, default_trigger)
    local fallback = tostring(default_trigger or "")
    local normalized = string.lower(tostring(trigger or fallback))
    if normalized == "" then
        return fallback
    end
    return normalized
end

--[[
    Проверяет готовность прока по info.proc_cooldown_end_time.
]]
function IsProcCooldownReady(info)
    if type(info) ~= "table" then return false end
    local cooldown_end = to_number(info.proc_cooldown_end_time, 0)
    return cooldown_end <= GameRules:GetGameTime()
end

--[[
    Устанавливает время окончания отката прока.
]]
function SetProcCooldownEnd(info, duration)
    if type(info) ~= "table" then return end
    local safe_duration = math.max(0, to_number(duration, 0))
    info.proc_cooldown_end_time = GameRules:GetGameTime() + safe_duration
end

local MELEE_HEROES =
{
    npc_dota_hero_kunkka = true,
    npc_dota_hero_magnataur = true,
    npc_dota_hero_legion_commander = true,
    npc_dota_hero_chaos_knight = true,
    npc_dota_hero_earth_spirit = true,
    npc_dota_hero_skeleton_king = true,
    npc_dota_hero_void_spirit = true,
    npc_dota_hero_sand_king = true,
    npc_dota_hero_faceless_void = true,
    npc_dota_hero_alchemist = true,
    npc_dota_hero_abaddon = true,
    npc_dota_hero_phantom_lancer = true,
    npc_dota_hero_mars = true,
    npc_dota_hero_pudge = true,
    npc_dota_hero_ursa = true,
    npc_dota_hero_kez = true,
}

function BuildPreAttackSound(attack_sound)
    return attack_sound:gsub("%.Attack$", ".PreAttack")
end

function BuildAttackImpactSound(hero_name, attack_sound)
    local sound_base = attack_sound:gsub("%.Attack$", "")

    if MELEE_HEROES[hero_name] then
        return sound_base .. ".Attack.Impact"
    end

    return sound_base .. ".ProjectileImpact"
end

function IsOrdinaryWaveCreep(target)
    local unit_name = tostring(target and target.GetUnitName and target:GetUnitName() or "")
    return
        unit_name == "npc_levelup_wave_melee" or
        unit_name == "npc_levelup_wave_melee_crystal" or
        unit_name == "npc_levelup_wave_melee_mega" or
        unit_name == "npc_levelup_wave_melee_mega_crystal" or
        unit_name == "npc_levelup_wave_melee_mega_insect" or
        unit_name == "npc_levelup_wave_melee_mega_bird" or
        unit_name == "npc_levelup_wave_melee_mega_clown" or
        unit_name == "npc_levelup_wave_melee_mega_crocodile"
end

function GetTrackedUnitData(unit)
    if not IsValid(unit) or not wave_manager or type(wave_manager.tracked_units) ~= "table" then
        return nil
    end

    return wave_manager.tracked_units[unit:entindex()]
end

function IsChallengerUnit(unit)
    local tracked_data = GetTrackedUnitData(unit)
    return type(tracked_data) == "table" and tracked_data.challenger_group_id ~= nil
end

local LEVELUP_BOSS_UNIT_NAMES = {
    npc_levelup_wave_boss = true,
    npc_levelup_boss_rush_automaton_legion_commander = true,
    npc_levelup_boss_rush_automaton_axe = true,
    npc_levelup_boss_rush_automaton_morphling = true,
    npc_levelup_boss_rush_automaton_bristleback = true,
    npc_levelup_boss_rush_automaton_oracle = true,
    npc_levelup_boss_rush_tinker = true,
    npc_levelup_boss_rush_ringmaster = true,
}

local LEVELUP_CONTROL_IMMUNE_UNIT_NAMES = {
    npc_levelup_lane_chest = true,
    npc_levelup_lane_war_banner = true,
}

function IsLevelUpBossOrMiniBossUnit(unit)
    if not IsValid(unit) then return false end

    local tracked_data = GetTrackedUnitData(unit)
    if type(tracked_data) == "table" then
        local unit_role = tracked_data.unit_role
        if unit_role == "stage_boss" or unit_role == "mini_boss" then
            return true
        end
    end

    local unit_name = tostring(unit:GetUnitName() or "")
    if LEVELUP_BOSS_UNIT_NAMES[unit_name] then return true end
    if BOSS_UNIT_ABILITIES and BOSS_UNIT_ABILITIES[unit_name] then return true end
    if unit:FindAbilityByName("levelup_boss_ability_handler") then return true end
    if unit:HasModifier("modifier_levelup_boss_ability_handler") then return true end

    return false
end

function IsLevelUpControlImmuneUnit(unit)
    if not IsValid(unit) then return false end
    if IsLevelUpBossOrMiniBossUnit(unit) then return true end

    local tracked_data = GetTrackedUnitData(unit)
    if type(tracked_data) == "table" and tracked_data.is_lane_chest == true then
        return true
    end

    return LEVELUP_CONTROL_IMMUNE_UNIT_NAMES[tostring(unit:GetUnitName() or "")] == true
end

local LEVELUP_LANE_STRUCTURE_UNIT_NAMES = 
{
    npc_levelup_lane_tower = true,
}

function IsLevelUpLaneStructureUnit(unit)
    return IsValid(unit) and LEVELUP_LANE_STRUCTURE_UNIT_NAMES[tostring(unit:GetUnitName() or "")] == true
end

function FilterOutLevelUpLaneStructures(units)
    if type(units) ~= "table" then return units end

    local filtered = {}
    for _, unit in ipairs(units) do
        if not IsLevelUpLaneStructureUnit(unit) then
            filtered[#filtered + 1] = unit
        end
    end

    if #filtered <= 0 then
        return units
    end

    return filtered
end

function GetChallengerTargetRole(unit)
    local tracked_data = GetTrackedUnitData(unit)
    return type(tracked_data) == "table" and tracked_data.challenger_target_role or nil
end

function CreateDamageParticle(unit, value, is_phys_crit, is_magic_crit)
    local point = unit:GetAbsOrigin()
    if player_data.players_list then
        for player_id, data in pairs(player_data.players_list) do
            local player = PlayerResource:GetPlayer(player_id)
            if player and IsLevelUpPlayerDamageNumbersEnabled(player_id) then
                CustomGameEventManager:Send_ServerToPlayer(player, "event_create_particle_damage_for_player", {x = point.x, y = point.y, value = value, is_phys_crit = is_phys_crit, is_magic_crit = is_magic_crit})
            end
        end
    end
end

function CreateMessageResources(unit, value, source_type, overhead)
    local particle_name = nil
    local source_value = 0
    if source_type == "exp" then
        particle_name = "particles/custom_message/exp.vpcf"
        source_value = 3
    end
    if source_type == "gold" then
        particle_name = "particles/custom_message/gold.vpcf"
        source_value = 6
    end
    if source_type == "souls" then
        particle_name = "particles/custom_message/souls.vpcf"
        source_value = 4
    end
    if source_type == "wood" then
        particle_name = "particles/custom_message/wood.vpcf"
        source_value = 5
    end
    if particle_name then
        local position = unit:GetAbsOrigin()
        local target_pfx = nil
        local attach = PATTACH_WORLDORIGIN
        if overhead then
            attach = PATTACH_OVERHEAD_FOLLOW
            target_pfx = unit
        else
            position.z = position.z + 250
        end
        local numb_count = string.len(tostring(math.floor(value))) + 1
        local particle = ParticleManager:CreateParticle(particle_name, attach, target_pfx)
        ParticleManager:SetParticleControl(particle, 0, position)
        ParticleManager:SetParticleControl(particle, 1, Vector(source_value, value, 0))
        ParticleManager:SetParticleControl(particle, 2, Vector(2, numb_count, 0))
        Timers:CreateTimer(2.5, function()
            ParticleManager:DestroyParticle(particle, true)
        end)
    end
end