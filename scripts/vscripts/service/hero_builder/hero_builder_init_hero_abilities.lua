--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local GAMEPLAY_KV = require("service.ability.ability_gameplay_kv")

local SPECIAL_INIT_ABILITIES = {
	"ringmaster_funhouse_mirror",
	"ringmaster_strongman_tonic",
	"ringmaster_whoopee_cushion",
	"ringmaster_summon_unicycle",
	"oracle_diviners_deck",
	"techies_focused_detonate",
}

---@param hero CDOTA_BaseNPC_Hero
local function FixInnateAbilities(hero)
	local heroName = hero:GetUnitName()
	logger:Log("[HeroBuilderService:FixInnateAbilities] HeroName = " .. heroName)

	if heroName == "npc_dota_hero_chen" then
		hero:AddNewModifier(hero, nil, "modifier_chen_base", {})
		return
	end
end

---@param hero CDOTA_BaseNPC_Hero
local function ApplyConfiguredInnateAbility(hero)
	local abilityInfo = GAMEPLAY_KV.InnateAbilities[hero:GetUnitName()]
	if not (abilityInfo and type(abilityInfo) == "table") then
		return
	end
	local abilityName = abilityInfo.AbilityName
	if not abilityName then
		return
	end
	local level = abilityInfo.AbilityLevel or 1
	local ability = hero:FindAbilityByName(abilityName)
	if not IsValid(ability) then
		ability = hero:AddAbility(abilityName)
	end
	if IsValid(ability) then
		ability:SetLevel(level)
	end ---@cast ability CDOTABaseAbility
end

---@param hero CDOTA_BaseNPC_Hero
function HeroBuilderService:InitHeroAbilities(hero)
	logger:Log("InitHeroAbilities started.")
	local innateAbility

	for i = 0, hero:GetAbilityCount() - 1 do
		local ability = hero:GetAbilityByIndex(i)
		if not ability then
			goto continue
		end

		local abilityName = ability:GetAbilityName()
		local isInnateAbility = ability:IsInnateAbility()
		if isInnateAbility then
			innateAbility = ability
		end

		if
			not string.find(abilityName, "special_bonus")
			and not isInnateAbility
			and not TableFindKey(SPECIAL_INIT_ABILITIES, abilityName)
		then
			hero:RemoveAbility(abilityName)
		end

		::continue::
	end

	for i = 0, 5 do
		local ability = hero:AddAbility("empty_" .. i)
		local indexAbility = hero:GetAbilityByIndex(i)
		if
			IsValid(indexAbility)
			and IsValid(innateAbility)
			and indexAbility ~= ability
			and indexAbility == innateAbility
		then ---@cast indexAbility CDOTABaseAbility
			if innateAbility:IsPassive() then
				hero:SwapAbilities(indexAbility, ability, false, false)
			end
		end
		ability.placeholderIndex = i + 1
	end

	ApplyConfiguredInnateAbility(hero)
	FixInnateAbilities(hero)
	self:RefreshAbilityOrder(hero:GetPlayerOwnerID())
end