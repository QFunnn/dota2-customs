--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local ABILITY_DRAFT_LIST = require("service.ability.ability_draft_list")

if AbilityPool == nil then AbilityPool = class({}) end ---@class AbilityPool

function AbilityPool:Init()
    if self.inited then return end
    self.inited = true

    self.allAbilityNames = {}       ---@type string[]
    self.heroAbilityPool = {}       ---@type table<string, string[]>
    self.abilityHeroMap = {}        ---@type table<string, string>
    self.linkedAbilities = {}       ---@type table<string, string[]>
    self.linkedAbilitiesLevel = {}  ---@type table<string, integer>
    self.referencedAbilities = {}   ---@type table<string, boolean>

    for szHeroName, entries in pairs(ABILITY_DRAFT_LIST) do
        local full = "npc_dota_hero_" .. szHeroName
        self.heroAbilityPool[full] = {}
        for _, entry in ipairs(entries) do
            local abilityName, links
            if type(entry) == "table" then
                abilityName = entry[1]
                links = entry.links
            else
                abilityName = entry
            end

            table.insert(self.allAbilityNames, abilityName)
            table.insert(self.heroAbilityPool[full], abilityName)
            self.abilityHeroMap[abilityName] = szHeroName
            self.referencedAbilities[abilityName] = true

            if links then
                self.linkedAbilities[abilityName] = {}
                for linkedName, level in pairs(links) do
                    table.insert(self.linkedAbilities[abilityName], linkedName)
                    self.linkedAbilitiesLevel[linkedName] = level
                    self.referencedAbilities[linkedName] = true
                end
            end
        end
    end
end

---@return table<string, boolean>
function AbilityPool:GetAllReferencedAbilities()
    return self.referencedAbilities
end

---@return string[]
function AbilityPool:CopyAllAbilities()
    return table.deepcopy(self.allAbilityNames)
end

---@param heroName string полное имя `npc_dota_hero_*`
---@return string[]|nil
function AbilityPool:CopyHeroAbilityPool(heroName)
    local pool = self.heroAbilityPool[heroName]
    if not pool then return nil end
    return table.deepcopy(pool)
end

---@param abilityName string
---@return string|nil
function AbilityPool:GetAbilityHero(abilityName)
    return self.abilityHeroMap[abilityName]
end

---@param abilityName string
---@return string[]|nil
function AbilityPool:GetLinkedAbilities(abilityName)
    return self.linkedAbilities[abilityName]
end

---@param abilityName string
---@return integer|nil
function AbilityPool:GetLinkedAbilityLevel(abilityName)
    return self.linkedAbilitiesLevel[abilityName]
end

---@param abilityName string
---@return boolean
function AbilityPool:Contains(abilityName)
    return table.contains(self.allAbilityNames, abilityName)
end

---@param abilityName string
function AbilityPool:RemoveAbility(abilityName)
    if table.contains(self.allAbilityNames, abilityName) then
        table.remove_item(self.allAbilityNames, abilityName)
    end

    local heroName = self.abilityHeroMap[abilityName]
    if heroName and self.heroAbilityPool[heroName]
        and table.contains(self.heroAbilityPool[heroName], abilityName) then
        table.remove_item(self.heroAbilityPool[heroName], abilityName)
    end
end