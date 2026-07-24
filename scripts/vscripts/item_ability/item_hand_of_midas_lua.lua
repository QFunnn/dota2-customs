--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_hand_of_midas_lua = class({}) ---@class item_hand_of_midas_lua : CDOTA_Item_Lua

LinkLuaModifier("modifier_item_hand_of_midas_lua", "item_ability/item_hand_of_midas_lua", LUA_MODIFIER_MOTION_NONE)

function item_hand_of_midas_lua:IsRefreshable()
	return false
end

function item_hand_of_midas_lua:GetIntrinsicModifierName()
	return "modifier_item_hand_of_midas_lua"
end

function item_hand_of_midas_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if not IsValid(target) then ---@cast target CDOTA_BaseNPC
		return
	end

	if not self.isFromMulticast then -- isFromMulticast заполняется в multicast.lua
		local currentCharges = self:GetCurrentCharges()
		if currentCharges > 0 then
			self:SetCurrentCharges(currentCharges-1)
		end
	end

	local origin_xp = target:GetDeathXP()
	local origin_gold = target:GetGoldBounty()
	local xp_multiplier = self:GetSpecialValueFor("xp_multiplier")
	local bonus_gold = self:GetSpecialValueFor("bonus_gold")

	local particleID = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_bounty_hunter/bounty_hunter_jinada.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(particleID, 0, target, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0, 0, 0), true)
	ParticleManager:SetParticleControlEnt(particleID, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0),
		true)
	ParticleManager:ReleaseParticleIndex(particleID)

	target:SetDeathXP(0)
	target:SetMinimumGoldBounty(0)
	target:SetMaximumGoldBounty(0)

	if IsValid(target) and target:IsNeutralUnitType() and target:IsAlive() then
		local spawner = nil
		if SpawnerPlayerMap ~= nil then
			if SpawnerPlayerMap[caster:GetPlayerOwnerID()] ~= nil then
				spawner = SpawnerPlayerMap[caster:GetPlayerOwnerID()]
			end
		end
	end

	if UnitFilter(target, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, caster:GetTeamNumber()) == UF_SUCCESS then
		target:Kill(self, caster)
		if caster:IsHero() then ---@cast caster CDOTA_BaseNPC_Hero
			if target:IsNeutralUnitType() then
				caster:ModifyGoldFiltered(bonus_gold, false, DOTA_ModifyGold_Unspecified)
			else
				caster:ModifyGoldFiltered(bonus_gold, false, DOTA_ModifyGold_Unspecified)
			end
			caster:AddExperience(origin_xp * xp_multiplier, DOTA_ModifyXP_CreepKill, false, false)
		end
		EmitSoundOn("DOTA_Item.Hand_Of_Midas", caster)
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