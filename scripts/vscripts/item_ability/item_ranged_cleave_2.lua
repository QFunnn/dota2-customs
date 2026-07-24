--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



item_ranged_cleave_2 = class({})

LinkLuaModifier("modifier_item_ranged_cleave_2", "item_ability/item_ranged_cleave_2", LUA_MODIFIER_MOTION_NONE)


function item_ranged_cleave_2:GetIntrinsicModifierName()
	return "modifier_item_ranged_cleave_2"
end



modifier_item_ranged_cleave_2 = class({})

function modifier_item_ranged_cleave_2:IsDebuff() return false end
function modifier_item_ranged_cleave_2:IsHidden() return true end
function modifier_item_ranged_cleave_2:IsPurgable() return false end
function modifier_item_ranged_cleave_2:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_ranged_cleave_2:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
	}
	return funcs
end

function modifier_item_ranged_cleave_2:OnCreated()

	local ability = self:GetAbility()
	self.cleave_dmg = ability:GetSpecialValueFor("cleave_dmg")
	self.cleave_radius = ability:GetSpecialValueFor("cleave_radius")
	
end


function modifier_item_ranged_cleave_2:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_str")
end

function modifier_item_ranged_cleave_2:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_agi")
end

function modifier_item_ranged_cleave_2:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_dmg")
end

function modifier_item_ranged_cleave_2:GetModifierAttackRangeBonusUnique()
	if self:GetParent():IsRangedAttacker() then
		return self:GetAbility():GetSpecialValueFor("bonus_range")
	else
		return 0
	end
end

if not IsServer() then return end

function modifier_item_ranged_cleave_2:GetModifierProcAttack_Feedback(keys)
	if not keys.attacker:IsRealHero() or not keys.attacker:IsRangedAttacker() then return end
	if keys.attacker:GetTeam() == keys.target:GetTeam() then return end
	if keys.target:IsBuilding() then return end
	
	local ability = self:GetAbility()
	local target_loc = keys.target:GetAbsOrigin()
	local fury_swipes_damage = 0
	
	if keys.attacker:HasAbility("ursa_fury_swipes") and keys.target:HasModifier("modifier_ursa_fury_swipes_damage_increase") then
		local ursa_swipes = keys.attacker:FindAbilityByName("ursa_fury_swipes")
		if ursa_swipes and not ursa_swipes:IsNull() then
			local stacks = keys.target:GetModifierStackCount("modifier_ursa_fury_swipes_damage_increase", keys.attacker)
			fury_swipes_damage = stacks * ursa_swipes:GetSpecialValueFor("damage_per_stack")
		end
	end
	
	local damage = (keys.original_damage + fury_swipes_damage) * self.cleave_dmg * 0.01
	
	local blast_pfx = ParticleManager:CreateParticle("particles/custom/shrapnel.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(blast_pfx, 0, target_loc)
	ParticleManager:ReleaseParticleIndex(blast_pfx)

	local enemies = FindUnitsInRadius(keys.attacker:GetTeamNumber(), target_loc, nil, self.cleave_radius, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), FIND_ANY_ORDER, false)
	for _, enemy in pairs(enemies) do
		if IsValid(enemy) then
			if enemy ~= keys.target then
				ApplyDamage({
					victim 			= enemy,
					attacker 		= keys.attacker,
					damage 			= damage,
					damage_type 	= ability:GetAbilityDamageType(),
					damage_flags 	= DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
					ability 		= ability,
				})
			end
		end
	end
end