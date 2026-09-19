--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


HeroRefreshService = HeroRefreshService or {} ---@class HeroRefreshService

---Сбрасывает перезарядку умений и предметов у определенного героя.
---@param hUnit CDOTA_BaseNPC?
---@param exceptions table | nil
function HeroRefreshService:RefreshAbilityAndItem(hUnit, exceptions)
	if exceptions == nil then
		exceptions = {}
	end

	if not IsValid(hUnit) then
		return
	end ---@cast hUnit CDOTA_BaseNPC

	for i = 0, hUnit:GetAbilityCount() - 1 do
		local hAbility = hUnit:GetAbilityByIndex(i)
		if hAbility and hAbility:GetAbilityType() ~= DOTA_ABILITY_TYPE_ATTRIBUTES then
			if exceptions[hAbility:GetAbilityName()] == nil then
				hAbility:RefreshCharges()
				hAbility:EndCooldown()
			end
		end
	end

	for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_NEUTRAL_SLOT do
		if not (i == DOTA_ITEM_TP_SCROLL) then
			local hItem = hUnit:GetItemInSlot(i)
			if hItem then
				hItem:EndCooldown()
				if hItem:GetName() == "item_hand_of_midas_lua" then
					hItem:SetCurrentCharges(2) --todo поправить костыль
				end
			end
		end
	end

	local neutralItem = hUnit:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)
	if neutralItem ~= nil then
		neutralItem:EndCooldown()
	end

	-- Также сбрасываем КД у предметов в кастомном extender_stash (хранятся
	-- в инвентаре скрытого npc_chc_stash_holder, поэтому слотовый цикл выше
	-- их не видит). Делаем только для реальных героев с валидным владельцем.
	if hUnit.IsRealHero and hUnit:IsRealHero() and hUnit.GetPlayerOwnerID then
		local playerId = hUnit:GetPlayerOwnerID()
		if playerId ~= nil and playerId ~= -1 and ExtenderStash and ExtenderStash.RefreshItemsCooldown then
			ExtenderStash:RefreshItemsCooldown(playerId, exceptions)
		end
	end
end

---Удаляет паутину бруды у определенного героя
---@param hUnit CDOTA_BaseNPC
function HeroRefreshService:CleanWeb(hUnit)
	local vWebs = Entities:FindAllByName("npc_dota_broodmother_web")
	for _, hWeb in pairs(vWebs) do
		if hWeb:GetOwner() == hUnit then
			UTIL_Remove(hWeb)
		end
	end
end

---Удаляет варды вич доктора у определенного героя
---@param hUnit CDOTA_BaseNPC
function HeroRefreshService:CleanDeathWard(hUnit)
	local vWards = Entities:FindAllByName("npc_dota_witch_doctor_death_ward")
	for _, vWard in pairs(vWards) do ---@cast vWard CDOTA_BaseNPC
		if vWard:GetOwner() == hUnit then
			UTIL_Remove(vWard)
		end
	end
end

---Удаляет гаргулей у определенного героя
---@param hHero CDOTA_BaseNPC
function HeroRefreshService:CleanFamiliar(hHero)
	local vFamiliars = Entities:FindAllByName("npc_dota_visage_familiar")
	for _, hFamiliar in pairs(vFamiliars) do ---@cast hFamiliar CDOTA_BaseNPC
		if hFamiliar:GetOwner() == hHero then
			hFamiliar:ForceKill(false)
		end
	end
end

local abilityCleanerByAbilityName = {
	["broodmother_spin_web"] = HeroRefreshService.CleanWeb,
	["witch_doctor_death_ward"] = HeroRefreshService.CleanDeathWard,
	["visage_summon_familiars"] = HeroRefreshService.CleanFamiliar,
}

---Зачищает мусор с карты и модификаторы определенных способостей у выбранного героя
---@param hHero CDOTA_BaseNPC
---@param abilityName string
function HeroRefreshService:RemoveAbilityClean(hHero, abilityName)
	logger:Log("removing ability clean")
	local cleanerFunc = abilityCleanerByAbilityName[abilityName]
	if cleanerFunc then
		cleanerFunc(self, hHero)
	end
end

--- Удаляет обезьян от Wukongs Command
function HeroRefreshService:CleanFurArmySoldier()
	Timers:CreateTimer({
		endTime = 0.5,
		callback = function()
			local units = FindUnitsInRadius(
				DOTA_TEAM_NEUTRALS,
				Vector(0, 0, 0),
				nil,
				-1,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_ALL,
				DOTA_UNIT_TARGET_FLAG_DEAD
					+ DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
					+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE
					+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
				FIND_CLOSEST,
				false
			)
			for _, hUnit in ipairs(units) do
				if
					hUnit
					and not hUnit:IsNull()
					and (
						hUnit:HasModifier("modifier_monkey_king_fur_army_soldier")
						or hUnit:HasModifier("modifier_monkey_king_fur_army_soldier_hidden")
					)
				then
					hUnit:ForceKill(false)
					UTIL_Remove(hUnit)
				end
			end
			return nil
		end,
	})
end