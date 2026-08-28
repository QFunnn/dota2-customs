--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pet_passive_logic", "pets/jackpot_pet_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pet_stats_sync", "pets/jackpot_pet_lua", LUA_MODIFIER_MOTION_NONE)

local _pet_exception_patterns = {
	"jackpot_pet_lua",
	"attribute_bonus",
	"ability_capture_lua",
	"terrorblade_",
	"alchemist_greevils_greed_lua",
	"legion_ult",
	"ogre_magi_bloodlust_lua",
	"lion_soul_collector",
	"silencer_infinite_int_lua",
	"techies_remote_mines_lua",
	"wraith_king_sceleton",
	"lua_abyssal_underlord_atrophy_aura",
	"anakim_wisp",
	"axe_blood_lua",
	"bloodseeker_thirst_lua",
	"broodmother_ult",
	"mars_atrophy_aura_lua",
	"shadow_fiend_necromastery_lua",
	"hero_destroyer_",
	"dado_",
	"hero_fiddlesticks_armor",
	"hero_rubick_ability",
	"special_bonus_",
	-- akatsuki
	"pain_",
	"itachi_",
	"kisame_",
	"hidan_",
	"tobi_",
	"zetsu_",
	"deidara_",
	"konan_",
	"kakuzu_",
	"sasori_",
}

local function is_pet_exception(ability_name)
	if not ability_name or ability_name == "" then
		return true
	end
	for _, pattern in ipairs(_pet_exception_patterns) do
		if string.find(ability_name, pattern, 1, true) then
			return true
		end
	end
	return false
end

jackpot_pet_lua = class({})

function jackpot_pet_lua:GetIntrinsicModifierName()
	return "modifier_pet_passive_logic"
end

--------------------------------------------------------------------------------

modifier_pet_passive_logic = class({})

function modifier_pet_passive_logic:IsHidden()
	return true
end

function modifier_pet_passive_logic:GetStatusEffectName()
	if self:GetParent():GetUnitName() == "jackpot_pet2" then
		return "particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_gold_lvl2.vpcf"
	end
end

function modifier_pet_passive_logic:StatusEffectPriority()
	if self:GetParent():GetUnitName() == "jackpot_pet2" then
		return 10
	end
end

function modifier_pet_passive_logic:OnCreated()
	if not IsServer() then
		return
	end
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_pet_stats_sync", {})
	self:GetParent():SetAcquisitionRange(0)
	self:StartIntervalThink(1)
end

function modifier_pet_passive_logic:OnIntervalThink()
	if not IsServer() then
		return
	end
	local pet = self:GetParent()
	local owner = pet:GetOwner()
	if not owner or not owner:IsRealHero() or not owner:IsAlive() then
		pet:Stop()
		pet:SetAggroTarget(nil)
		return
	end

	pet:SetMaxMana(owner:GetMaxMana())

	-- Собираем текущие скиллы хозяина
	local owner_abilities = {}
	local abilityCount = owner:GetAbilityCount()
	for i = 0, abilityCount - 1 do
		local ability = owner:GetAbilityByIndex(i)
		if ability and not ability:IsNull() then
			local ability_name = ability:GetAbilityName()
			if not is_pet_exception(ability_name) then
				owner_abilities[ability_name] = ability:GetLevel()
			end
		end
	end

	-- Удаляем с пета скиллы которых больше нет у хозяина
	for i = pet:GetAbilityCount() - 1, 0, -1 do
		local pet_ability = pet:GetAbilityByIndex(i)
		if pet_ability and not pet_ability:IsNull() then
			local name = pet_ability:GetAbilityName()
			if not is_pet_exception(name) and not owner_abilities[name] then
				pet:RemoveAbility(name)
			end
		end
	end

	-- Добавляем/обновляем скиллы хозяина на пете
	for ability_name, level in pairs(owner_abilities) do
		local pet_ability = pet:FindAbilityByName(ability_name)
		if not pet_ability then
			pet_ability = pet:AddAbility(ability_name)
		end
		if pet_ability and pet_ability:GetLevel() ~= level then
			pet_ability:SetLevel(level)
		end
	end

	local dist = (owner:GetOrigin() - pet:GetOrigin()):Length2D()
	if dist > 1200 then
		self:BlinkToOwner(pet, owner)
		return
	end

	local owner_target = owner:GetAggroTarget()
	if not owner_target or not owner_target:IsAlive() then
		pet:SetAcquisitionRange(0)
		if pet:GetAggroTarget() then
			pet:Stop()
			pet:SetAggroTarget(nil)
		end
		if dist > 400 then
			local target_pos = owner:GetAbsOrigin() - owner:GetForwardVector() * 150
			pet:MoveToPosition(target_pos)
		end
	else
		if pet:GetAggroTarget() ~= owner_target then
			pet:SetAcquisitionRange(500)
			pet:MoveToTargetToAttack(owner_target)
		end
	end
end

function modifier_pet_passive_logic:BlinkToOwner(pet, owner)
	local blink_pos = owner:GetOrigin() + RandomVector(RandomFloat(100, 150))
	pet:SetAbsOrigin(blink_pos)
	FindClearSpaceForUnit(pet, blink_pos, true)
	pet:Stop()
	local pfx = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, pet)
	ParticleManager:ReleaseParticleIndex(pfx)
end

function modifier_pet_passive_logic:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
	}
end

function modifier_pet_passive_logic:GetModifierPercentageManacostStacking()
	return 100
end

function modifier_pet_passive_logic:OnAbilityFullyCast(params)
	local owner = self:GetParent():GetOwner()
	if not owner or params.unit ~= owner or params.ability:IsItem() then
		return
	end

	local pet = self:GetParent()
	local hAbility = params.ability
	local ability_name = hAbility:GetAbilityName()

	if ability_name == self:GetAbility():GetAbilityName() then
		return
	end

	local pet_ability = pet:FindAbilityByName(ability_name)
	if pet_ability then
		pet_ability:EndCooldown()

		local behavior = hAbility:GetBehaviorInt()
		local target = params.target
		local point = owner:GetCursorPosition()

		if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 and target then
			pet:CastAbilityOnTarget(target, pet_ability, -1)
		elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
			pet:CastAbilityOnPosition(point, pet_ability, -1)
		elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
			pet:CastAbilityNoTarget(pet_ability, -1)
		end
	end
end

--------------------------------------------------------------------------------

modifier_pet_stats_sync = class({})

function modifier_pet_stats_sync:IsHidden()
	return false
end

function modifier_pet_stats_sync:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_pet_stats_sync:GetModifierSpellAmplify_Percentage()
	if not IsServer() then
		return
	end
	local owner = self:GetParent():GetOwner()

	if owner then
		local ampl = owner:GetSpellAmplification(false) * 100
		return ampl
	end
	return 0
end

function modifier_pet_stats_sync:GetModifierPreAttack_BonusDamage()
	if not IsServer() then
		return
	end
	local owner = self:GetParent():GetOwner()

	if owner then
		local damage = owner:GetAverageTrueAttackDamage(nil)
		return damage --* 0.5
	end
	return 0
end

function modifier_pet_stats_sync:GetModifierAttackSpeedBonus_Constant()
	if not IsServer() then
		return
	end
	local owner = self:GetParent():GetOwner()

	if owner then
		local current_as = owner:GetAttackSpeed(false) * 100
		return (current_as - 100) --* 0.5
	end
	return 0
end