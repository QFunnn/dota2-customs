--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if HeroBuilder == nil then _G.HeroBuilder = class({}) end ---@class HeroBuilder

require("core.hero_builder.hero_builder_abilities_config")
require("core.hero_builder.hero_builder_ability_add")
require("core.hero_builder.hero_builder_ability_remove")
require("service.ability.ability_pool")
require("service.ability.ability_quota")
require("service.ability.ability_selection_service")
require("core.hero_builder.hero_builder_attack_capability")
require("core.hero_builder.hero_builder_config")
require("core.hero_builder.hero_builder_events")
require("core.hero_builder.hero_builder_globals")
require("service.hero.hero_selection_service")
require("core.hero_builder.hero_builder_init_fields")
require("core.hero_builder.hero_builder_init_hero_abilities")
require("core.hero_builder.hero_builder_link")
require("core.hero_builder.hero_builder_team_action")
require("core.hero_builder.hero_builder_utils")

if not IsServer() then return end


function HeroBuilder:Init()
    AbilityPool:Init()
    AbilityQuota:Init()
    self:RegisterListeners()
    self:InitFields()
    HeroSelectionService:Init()
    AbilitySelectionService:Init()
end

-- Инициализировать героя игрока через панельку.
---@param hHero CDOTA_BaseNPC_Hero?
function HeroBuilder:InitPlayerHeroDebug(hHero)
    if not IsValid(hHero) then return end ---@cast hHero CDOTA_BaseNPC_Hero

    if hHero.abilitiesList == nil then hHero.abilitiesList = {} end
    hHero.bInited = true

    if Util:GetSupposeRoom(hHero) == "prepare" then
        if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
            hHero:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
        end
    end

    HeroBuilder:InitHeroAbilities(hHero)

    hHero:AddNewModifier(hHero, nil, "modifier_spell_amplify_controller", {})

    -- Решить проблему с ченом
    if hHero:GetUnitName() == "npc_dota_hero_chen" then
        hHero:AddNewModifier(hHero, nil, "modifier_chen_base", {})
    end
end

---@param hHero CDOTA_BaseNPC_Hero
---@param sPreName string
---@param sNewName string
function HeroBuilder:ReplaceAbilityList(hHero, sPreName, sNewName)
    if not hHero.abilitiesList then return end
    for i, x in pairs(hHero.abilitiesList) do
        if x == sPreName then
            table.remove(hHero.abilitiesList, i)
            break
        end
    end
    table.insert(hHero.abilitiesList, sNewName)
end