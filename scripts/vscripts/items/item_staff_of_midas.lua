--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_staff_of_midas", "items/item_staff_of_midas", LUA_MODIFIER_MOTION_NONE)

item_staff_of_midas = class({})

function item_staff_of_midas:CastFilterResultTarget( target )
	if target:HasModifier("modifier_wodacreepchampion") then
		return UF_FAIL_ANCIENT
	end
	if target:HasModifier("modifier_wodacreepchampionred") then
		return UF_FAIL_ANCIENT
	end
    if target:GetUnitName() == "npc_woda_pig" then
		return UF_FAIL_ANCIENT
	end
    if target:GetUnitName() == "npc_woda_frog" then
		return UF_FAIL_ANCIENT
	end
    if target:GetUnitName() == "npc_woda_pig_pve" then
		return UF_FAIL_ANCIENT
	end
    if target:GetUnitName() == "npc_woda_frog_pve" then
		return UF_FAIL_ANCIENT
	end
	local nResult = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end

function item_staff_of_midas:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local ability = self
	local sound_cast = "DOTA_Item.Hand_Of_Midas"
	local bonus_gold = ability:GetSpecialValueFor("bonus_gold")
	local xp_multiplier = ability:GetSpecialValueFor("xp_multiplier")
	local bonus_xp = target:GetDeathXP()
	target:EmitSound(sound_cast)
	SendOverheadEventMessage(PlayerResource:GetPlayer(caster:GetPlayerOwnerID()), OVERHEAD_ALERT_GOLD, target, bonus_gold, nil)
	local midas_particle = ParticleManager:CreateParticle("particles/items2_fx/hand_of_midas.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(midas_particle, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), false)
	target:SetDeathXP(0)
	target:SetMinimumGoldBounty(0)
	target:SetMaximumGoldBounty(0)
	target:Kill(ability, caster)
    if not caster:IsHero() then
		caster = caster:GetPlayerOwner():GetAssignedHero()
	end
	caster:AddExperience(bonus_xp, false, false)
	caster:ModifyGold(bonus_gold, true, 0)
end

function item_staff_of_midas:GetIntrinsicModifierName()
	return "modifier_item_staff_of_midas"
end


modifier_item_staff_of_midas = class({})

function modifier_item_staff_of_midas:IsHidden() return true end
function modifier_item_staff_of_midas:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_staff_of_midas:IsPurgable() return false end
function modifier_item_staff_of_midas:IsPurgeException() return false end
function modifier_item_staff_of_midas:RemoveOnDeath() return false end

function modifier_item_staff_of_midas:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_item_staff_of_midas:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_staff_of_midas:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_str")
end

function modifier_item_staff_of_midas:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end