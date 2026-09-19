--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


HeroBuilderService = HeroBuilderService or {} ---@class HeroBuilderService

require("service.hero_builder.hero_builder_ability_add")
require("service.hero_builder.hero_builder_ability_remove")
require("service.hero_builder.hero_builder_precache")
require("service.ability.ability_pool")
require("service.ability.ability_quota")
require("service.ability.ability_selection_service")
require("service.hero_builder.hero_builder_attack_capability")
require("service.hero_builder.hero_builder_events")
require("service.hero.hero_selection_service")
require("service.hero_builder.hero_builder_init_fields")
require("service.hero_builder.hero_builder_init_hero_abilities")
require("service.hero_builder.hero_builder_scepter")
require("service.hero_builder.hero_builder_ability_order")
require("service.hero_builder.hero_builder_team_action")

if not IsServer() then
	return
end

function HeroBuilderService:Init()
	AbilityPool:Init()
	AbilityQuota:Init()
	self:RegisterListeners()
	self:InitFields()
	HeroSelectionService:Init()
	AbilitySelectionService:Init()
end

-- Инициализировать героя игрока через панельку.
---@param hero CDOTA_BaseNPC_Hero?
function HeroBuilderService:InitPlayerHeroDebug(hero)
	if not IsValid(hero) then
		return
	end ---@cast hero CDOTA_BaseNPC_Hero

	if hero.abilitiesList == nil then
		hero.abilitiesList = {}
	end
	hero.isInited = true

	if HeroPlacementService:GetSupposeRoom(hero) == "prepare" then
		if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
			hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
		end
	end

	HeroBuilderService:InitHeroAbilities(hero)

	hero:AddNewModifier(hero, nil, "modifier_spell_amplify_controller", {})
end

---@param hero CDOTA_BaseNPC_Hero
---@param preName string
---@param newName string
function HeroBuilderService:ReplaceAbilityList(hero, preName, newName)
	if not hero.abilitiesList then
		return
	end
	for i, x in pairs(hero.abilitiesList) do
		if x == preName then
			table.remove(hero.abilitiesList, i)
			break
		end
	end
	table.insert(hero.abilitiesList, newName)
end