--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if WereableSystem == nil then
    WereableSystem = class({}) ---@class WereableSystem
end

local SUPPORTED_SLOTS = {
    [ITEMS_DEFAULT_SLOTS.TITLE] = true,
    [ITEMS_DEFAULT_SLOTS.FX_HERO] = true,
}

local ATTACH_BY_SLOT = {
    [ITEMS_DEFAULT_SLOTS.TITLE] = PATTACH_OVERHEAD_FOLLOW,
    [ITEMS_DEFAULT_SLOTS.FX_HERO] = PATTACH_ABSORIGIN_FOLLOW,
}

function WereableSystem:Init()
    if self.Initialized then
        return
    end

    self.Initialized = true
    self.ActiveParticles = self.ActiveParticles or {}

    GameListener:SubscribeProtected("server_equip_item", function(event)
        self:OnEquipItem(event)
    end)
    GameListener:SubscribeProtected("server_unequip_item", function(event)
        self:OnUnequipItem(event)
    end)

    ListenToGameEvent("npc_spawned", function(event)
        self:OnNpcSpawned(event)
    end, nil)
end

---@param event table
function WereableSystem:OnEquipItem(event)
    local playerId = tonumber(event.PlayerID)
    if playerId == nil or playerId < 0 then
        return
    end

    local itemName = event.name
    if type(itemName) ~= "string" or itemName == "" then
        return
    end

    local itemInfo = ITEMS_LIST[itemName]
    if not itemInfo then
        return
    end

    local slotName = itemInfo.slot_name
    if not SUPPORTED_SLOTS[slotName] then
        return
    end

    self:ApplyParticleByItem(playerId, slotName, itemName)
end

---@param event table
function WereableSystem:OnUnequipItem(event)
    local playerId = tonumber(event.PlayerID)
    if playerId == nil or playerId < 0 then
        return
    end

    local slotName = event.slot_name
    if type(slotName) ~= "string" or slotName == "" then
        local itemName = event.name
        if type(itemName) == "string" and itemName ~= "" and ITEMS_LIST[itemName] then
            slotName = ITEMS_LIST[itemName].slot_name
        end
    end

    if not SUPPORTED_SLOTS[slotName] then
        return
    end

    self:RemoveParticleBySlot(playerId, slotName)
end

---@param event table
function WereableSystem:OnNpcSpawned(event)
    local unit = EntIndexToHScript(event.entindex or -1)
    if not unit or unit:IsNull() or not unit:IsRealHero() then
        return
    end

    local playerId = unit:GetPlayerOwnerID()
    if playerId == nil or playerId < 0 then
        return
    end

    for slotName, _ in pairs(SUPPORTED_SLOTS) do
        local equippedItem = Shop and Shop.GetEquippedItemInSlot and Shop:GetEquippedItemInSlot(playerId, slotName) or nil
        if equippedItem then
            self:ApplyParticleByItem(playerId, slotName, equippedItem)
        else
            self:RemoveParticleBySlot(playerId, slotName)
        end
    end
end

---@param playerId integer
---@param slotName string
function WereableSystem:RemoveParticleBySlot(playerId, slotName)
    if not self.ActiveParticles[playerId] then
        return
    end

    local oldParticle = self.ActiveParticles[playerId][slotName]
    if oldParticle then
        ParticleManager:DestroyParticle(oldParticle, true)
        ParticleManager:ReleaseParticleIndex(oldParticle)
        self.ActiveParticles[playerId][slotName] = nil
    end
end

---@param playerId integer
---@param slotName string
---@param itemName string
function WereableSystem:ApplyParticleByItem(playerId, slotName, itemName)
    local hero = PlayerResource:GetSelectedHeroEntity(playerId)
    if not hero or hero:IsNull() then
        return
    end

    local itemInfo = ITEMS_LIST[itemName]
    if not itemInfo then
        return
    end

    local particlePath = itemInfo.game_value
    if type(particlePath) ~= "string" or particlePath == "" then
        return
    end

    self.ActiveParticles[playerId] = self.ActiveParticles[playerId] or {}
    self:RemoveParticleBySlot(playerId, slotName)

    local attach = ATTACH_BY_SLOT[slotName] or PATTACH_ABSORIGIN_FOLLOW
    local particleId = ParticleManager:CreateParticle(particlePath, attach, hero)
    self.ActiveParticles[playerId][slotName] = particleId
end