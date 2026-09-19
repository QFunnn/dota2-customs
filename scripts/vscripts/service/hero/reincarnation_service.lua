--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


ReincarnationService = ReincarnationService or {} ---@class ReincarnationService

-- Проверяет готовность перерождения от способности
---@param hUnit CDOTA_BaseNPC
---@return boolean
function ReincarnationService:CheckReincarnationAbilityReady(hUnit)
	if hUnit:HasAbility("skeleton_king_reincarnation") then
		local hAbility = hUnit:FindAbilityByName("skeleton_king_reincarnation")
		if hAbility and hAbility:GetLevel() > 0 then
			if hAbility:IsCooldownReady() then
				return true
			end
		end
	end

	if hUnit:HasAbility("undying_ceaseless_dirge") then
		local hAbility = hUnit:FindAbilityByName("undying_ceaseless_dirge")
		if hAbility and hAbility:IsCooldownReady() then
			return true
		end
	end

	return false
end

-- Определяет, следует ли иницировать перерождение
---@param hUnit CDOTA_BaseNPC
---@return boolean
function ReincarnationService:IsReincarnationWork(hUnit)
	local bSkeletonKingReincarnationWork = false
	if hUnit:HasAbility("skeleton_king_reincarnation") then
		local hAbility = hUnit:FindAbilityByName("skeleton_king_reincarnation")
		if hAbility and hAbility:GetLevel() > 0 then
			if hAbility:GetCooldownTimeRemaining() == hAbility:GetEffectiveCooldown(hAbility:GetLevel() - 1) then
				bSkeletonKingReincarnationWork = true
			end
		end
	end

	local bUndyingReincarnationWork = false
	if hUnit:HasAbility("undying_ceaseless_dirge") then
		local hAbility = hUnit:FindAbilityByName("undying_ceaseless_dirge")
		if
			hAbility
			and hAbility:GetCooldownTimeRemaining() == hAbility:GetEffectiveCooldown(hAbility:GetLevel() - 1)
		then
			bUndyingReincarnationWork = true
		end
	end

	return bSkeletonKingReincarnationWork or bUndyingReincarnationWork
end