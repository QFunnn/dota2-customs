--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_hand_of_midas_lua = class({})
LinkLuaModifier("modifier_item_hand_of_midas_lua", "item_ability/item_hand_of_midas_lua", LUA_MODIFIER_MOTION_NONE)
-- function item_hand_of_midas_lua:IsRefreshable()
--	 return false
-- end
function item_hand_of_midas_lua:IsRefreshable()
	return false
end
function item_hand_of_midas_lua:GetIntrinsicModifierName()
	return "modifier_item_hand_of_midas_lua"
end
function item_hand_of_midas_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local drop_end = self:GetSpecialValueFor("drop_end")

	if not IsValid(hTarget) then
		return
	end

	local origin_xp = hTarget:GetDeathXP()
	local origin_gold = hTarget:GetGoldBounty()
	local xp_multiplier = self:GetSpecialValueFor("xp_multiplier")
	local bonus_gold = self:GetSpecialValueFor("bonus_gold")

	local particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_bounty_hunter/bounty_hunter_jinada.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hCaster)
	ParticleManager:SetParticleControlEnt(particleID, 0, hTarget, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0, 0, 0), true)
	-- ParticleManager:SetParticleControl(particleID, 1, hCaster:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(particleID, 1, hCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
	ParticleManager:ReleaseParticleIndex(particleID)

	hTarget:SetDeathXP(0)
	hTarget:SetMinimumGoldBounty(0)
	hTarget:SetMaximumGoldBounty(0)

	-- SendOverheadEventMessage(hCaster:GetPlayerOwner(), OVERHEAD_ALERT_GOLD, hTarget, bonus_gold, nil)

	if IsValid(hTarget) and hTarget:IsNeutralUnitType() and hTarget:IsAlive() then
		local spawner = nil
		if SpawnerPlayerMap ~= nil then
			if SpawnerPlayerMap[hCaster:GetPlayerOwnerID()] ~= nil then
				spawner = SpawnerPlayerMap[hCaster:GetPlayerOwnerID()]
			end
		end
		local round_num = GameMode.currentRound.nRoundNumber
		if spawner ~= nil and round_num and round_num < drop_end then
			-- ItemLoot:DropItem(hTarget, spawner:GetLootLevel(), hCaster:GetTeamNumber(), hCaster:GetPlayerOwnerID())
			-- ItemLoot:DropToken(hCaster:GetPlayerOwnerID(), spawner:GetLootLevel(), hTarget)
		end
	end

	if UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, hCaster:GetTeamNumber()) == UF_SUCCESS then
		hTarget:Kill(self, hCaster)
		if hTarget:IsNeutralUnitType() then
			if hCaster.ModifyGoldFiltered ~= nil and type(hCaster.ModifyGoldFiltered) == "function" then
				hCaster:ModifyGoldFiltered(bonus_gold, false, DOTA_ModifyGold_Unspecified)
			end

		else
			if hCaster.ModifyGoldFiltered ~= nil and type(hCaster.ModifyGoldFiltered) == "function" then
				hCaster:ModifyGoldFiltered(bonus_gold, false, DOTA_ModifyGold_Unspecified)
			end
		end
		if hCaster.AddExperience ~= nil and type(hCaster.AddExperience) == "function" then
			hCaster:AddExperience(origin_xp * xp_multiplier, DOTA_ModifyXP_CreepKill, false, false)
		end

		EmitSoundOn("DOTA_Item.Hand_Of_Midas", hCaster)
	end

end
--=================================modifier_item_hand_of_midas_lua-----------------
modifier_item_hand_of_midas_lua = class({})
function modifier_item_hand_of_midas_lua:IsDebuff()
	return false
end
function modifier_item_hand_of_midas_lua:IsHidden()
	return true
end
function modifier_item_hand_of_midas_lua:RemoveOnDeath()
	return false
end
function modifier_item_hand_of_midas_lua:OnCreated(data)
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end
function modifier_item_hand_of_midas_lua:OnRefresh(data)
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end
function modifier_item_hand_of_midas_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end
function modifier_item_hand_of_midas_lua:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end