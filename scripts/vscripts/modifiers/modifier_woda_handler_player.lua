--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_handler_player = class({})
function modifier_woda_handler_player:IsHidden() return true end
function modifier_woda_handler_player:IsPurgable() return false end
function modifier_woda_handler_player:IsPurgeException() return false end
function modifier_woda_handler_player:RemoveOnDeath() return false end

function modifier_woda_handler_player:OnCreated()
    self.parent = self:GetParent()
    if not IsServer() then return end
    self.hunt_counter = 0
    
    self.teams_damage = {}
    self.arena_max_damage =
    {
        [1] = {-50, 50},
        [2] = {-40, 40},
        [3] = {-30, 30},
        [4] = {-20, 20},
        [5] = {-10, 10},
        [6] = {0, 0},
    }
    self.timer_leader_debuff = 0
    self:SetHasCustomTransmitterData(true)
    self.max_mana_regen = nil
    self:StartIntervalThink(0.2)
end

function modifier_woda_handler_player:OnIntervalThink()
    if not IsServer() then return end
    if string.find(GetMapName(), "rating") then
        self.timer_leader_debuff = self.timer_leader_debuff + 0.2
        if self.timer_leader_debuff >= 1 then
            self.timer_leader_debuff = 0
            if not self:GetParent():IsIllusion() then
                local player = PlayerResource:GetPlayer(self:GetParent():GetPlayerOwnerID())
                if player then
                    if self:GetParent():HasModifier("modifier_wodaduel1") or self:GetParent():HasModifier("modifier_wodaduel2") or self:GetParent():HasModifier("modifier_wodaduel_duo") then
                        CustomGameEventManager:Send_ServerToPlayer( player, "comeback_system_update", {info = self.teams_damage, duel = 1})
                    else
                        CustomGameEventManager:Send_ServerToPlayer( player, "comeback_system_update", {info = self.teams_damage, duel = 0})
                    end
                end
            end
        end
    end
    self.max_mana_regen = nil
    local mana_regen = self.parent:GetManaRegen()
    local mana_decrease_percent = 0
    for _, mod in pairs(self.parent:FindAllModifiers()) do
        if mod and mod.GetModifierManaRegenPercentDecreaseCustom and mod:GetModifierManaRegenPercentDecreaseCustom() ~= nil then
            mana_decrease_percent = mana_decrease_percent + math.abs(mod:GetModifierManaRegenPercentDecreaseCustom())
        end
    end
    if mana_decrease_percent > 0 then
        self.max_mana_regen = mana_regen - (mana_regen / 100 * math.min(mana_decrease_percent, 100))
    end
    self:SendBuffRefreshToClients()
end

function modifier_woda_handler_player:DeclareFunctions()
	return
	{
		MODIFIER_EVENT_ON_MODIFIER_ADDED,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION,
        MODIFIER_PROPERTY_FIXED_MANA_REGEN,
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_woda_handler_player:OnModifierAdded(params)
	if not IsServer() then return end
	if params.unit == self.parent then return end
	if params.added_buff:GetCaster() ~= self.parent then return end
	if not params.added_buff:IsDebuff() then return end
	if params.added_buff:GetDuration() <= 0 then return end
    local mod_name = params.added_buff:GetName()
	if mod_name == "modifier_cyclone" then return end
	if mod_name == "modifier_eul_cyclone" then return end
	if mod_name == "modifier_eul_cyclone_thinker" then return end
	if mod_name == "modifier_eul_wind_waker_thinker" then return end
	if mod_name == "modifier_wind_waker" then return end
    if mod_name == "modifier_lina_slow_burn_custom_debuff" then return end
    if mod_name == "modifier_kill" then return end
    local percentage = 0
    for _, mod in pairs(self.parent:FindAllModifiers()) do
        if mod and mod.CustomIncreaseModifierDuration then
            percentage = percentage + (mod:CustomIncreaseModifierDuration() or 0)
        end
    end
	local new_duration = params.added_buff:GetDuration() + (params.added_buff:GetDuration() / 100 * percentage)
	params.added_buff:SetDuration(new_duration, true)
end

function modifier_woda_handler_player:GetModifierMagicalResistanceDirectModification()
    local parent = self.parent
    local int = parent:GetIntellect(false)
    local reduction = int * 0.1 * -1
    local bonus = math.min(50, int * 0.1)
    return reduction + bonus
end

function modifier_woda_handler_player:AddCustomTransmitterData() 
    return 
    {
        max_mana_regen = self.max_mana_regen,
    } 
end

function modifier_woda_handler_player:HandleCustomTransmitterData(data)
    self.max_mana_regen = data.max_mana_regen
end

function modifier_woda_handler_player:GetModifierFixedManaRegen()
	if self.max_mana_regen ~= nil then
        return self.max_mana_regen
    end
end

function modifier_woda_handler_player:OnDeath(params)
    if not IsServer() then return end
    self:HuntOnDeath(params)
    if string.find(GetMapName(), "rating") then
        self:LeaderOnDeath(params)
    end
end

function modifier_woda_handler_player:AddToHunt()
    if not IsServer() then return end
    self.hunt_counter = 0
    if self.parent:HasModifier("modifier_wodahunt") then return end
    local hunt_table_new = {}
    local hunt_table = arena_system.HUNT_PLAYERS_LIST
    if hunt_table ~= nil then
        for k,v in pairs(hunt_table) do
            table.insert(hunt_table_new,v)
        end
    end
    local new_player = {id = self.parent:GetPlayerOwnerID()}
    table.insert(hunt_table_new, new_player)
    arena_system.HUNT_PLAYERS_LIST = hunt_table_new
    CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "huntplayers", data = hunt_table_new})
    self.parent:AddNewModifier(self.parent, nil, "modifier_wodahunt", {})
    CustomGameEventManager:Send_ServerToAllClients("notification_player_hunt", {})
end

function modifier_woda_handler_player:FastUpdatePanel()
    if not IsServer() then return end
    if math.min(arena_system:GetCurrentArena(), 6) <= 6 then
        for id, damage in pairs(self.teams_damage) do
            if damage > 0 then
                local max_value = self.arena_max_damage[math.min(arena_system:GetCurrentArena(), 6)][2]
                if damage > max_value then
                    self.teams_damage[id] = max_value
                end
            elseif damage < 0 then
                local max_value = self.arena_max_damage[math.min(arena_system:GetCurrentArena(), 6)][1]
                if damage < max_value then
                    self.teams_damage[id] = max_value
                end
            end
        end
    end
end

function modifier_woda_handler_player:GetModifierTotalDamageOutgoing_Percentage(params)
    if self:GetParent():HasModifier("modifier_wodaduel1") then return end
    if self:GetParent():HasModifier("modifier_wodaduel2") then return end
    if self:GetParent():HasModifier("modifier_wodaduel_duo") then return end
	if params.target and params.target:IsHero() then
        if self.teams_damage[params.target:GetPlayerOwnerID()] ~= nil then
            return self.teams_damage[params.target:GetPlayerOwnerID()]
        end
    end
end

function modifier_woda_handler_player:HuntOnDeath(params)
    if params.attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() and params.unit:GetTeamNumber() ~= self:GetParent():GetTeamNumber() and params.unit:IsRealHero() then
        if self:GetParent():HasModifier("modifier_wodaduel1") then return end
        if self:GetParent():HasModifier("modifier_wodaduel_duo") then return end
        if params.reincarnate then return end
        if self.teams_damage[params.unit:GetPlayerOwnerID()] ~= nil and self.teams_damage[params.unit:GetPlayerOwnerID()] > 0 then
            self.teams_damage[params.unit:GetPlayerOwnerID()] = 0
        else
            if self.teams_damage[params.unit:GetPlayerOwnerID()] == nil then
                self.teams_damage[params.unit:GetPlayerOwnerID()] = 0
            end
            local max_value = self.arena_max_damage[math.min(arena_system:GetCurrentArena(), 6)][1]
            self.teams_damage[params.unit:GetPlayerOwnerID()] = math.max(max_value, self.teams_damage[params.unit:GetPlayerOwnerID()] - 10)
        end
	end
	if params.unit:GetTeamNumber() == self:GetParent():GetTeamNumber() and params.attacker ~= nil and not params.attacker:IsNull() and not params.attacker:IsNeutralUnitType() and params.attacker:GetTeamNumber() ~= self:GetParent():GetTeamNumber() and params.unit:IsRealHero() then
        if self:GetParent():HasModifier("modifier_wodaduel1") then return end
        if self:GetParent():HasModifier("modifier_wodaduel2") then return end
        if self:GetParent():HasModifier("modifier_wodaduel_duo") then return end
        if params.reincarnate then return end
        if self.teams_damage[params.attacker:GetPlayerOwnerID()] ~= nil and self.teams_damage[params.attacker:GetPlayerOwnerID()] < 0 then
            self.teams_damage[params.attacker:GetPlayerOwnerID()] = 0
        else
            if self.teams_damage[params.attacker:GetPlayerOwnerID()] == nil then
                self.teams_damage[params.attacker:GetPlayerOwnerID()] = 0
            end
            local max_value = self.arena_max_damage[math.min(arena_system:GetCurrentArena(), 6)][2]
            self.teams_damage[params.attacker:GetPlayerOwnerID()] = math.min(max_value, self.teams_damage[params.attacker:GetPlayerOwnerID()] + 10)
        end
	end
end

function modifier_woda_handler_player:LeaderOnDeath(params)
    if not IsServer() then return end
    if params.attacker:GetTeamNumber() == self.parent:GetTeamNumber() and params.unit:IsRealHero() then
        if self.parent:HasModifier("modifier_wodahunt") then return end
        if self.parent:HasModifier("modifier_wodaduel1") then return end
        if self.parent:HasModifier("modifier_wodaduel_duo") then return end
        if self.parent:HasModifier("modifier_wodaduel2") then return end
        if params.reincarnate then return end
        if params.attacker:GetPlayerOwnerID() ~= self.parent:GetPlayerOwnerID() then return end
        self.hunt_counter = self.hunt_counter + 1
        if self.hunt_counter >= 5 then
            self:AddToHunt()
        end
    end
    if params.unit == self.parent then
        if params.reincarnate then return end
        self.hunt_counter = 0
    end
end