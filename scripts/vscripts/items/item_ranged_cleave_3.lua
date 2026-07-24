--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ranged_cleave_3", "items/item_ranged_cleave_3", LUA_MODIFIER_MOTION_NONE)

item_ranged_cleave_3 = class({})

function item_ranged_cleave_3:GetIntrinsicModifierName()
	return "modifier_item_ranged_cleave_3"
end

modifier_item_ranged_cleave_3 = class({})

function modifier_item_ranged_cleave_3:IsDebuff() return false end
function modifier_item_ranged_cleave_3:IsHidden() return true end
function modifier_item_ranged_cleave_3:IsPurgable() return false end
function modifier_item_ranged_cleave_3:IsPurgeException() return false end
function modifier_item_ranged_cleave_3:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_ranged_cleave_3:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
	}
	return funcs
end

function modifier_item_ranged_cleave_3:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.cleave_radius = self.ability:GetSpecialValueFor("cleave_radius")
    self.bonus_str = self.ability:GetSpecialValueFor("bonus_str")
    self.bonus_agi = self.ability:GetSpecialValueFor("bonus_agi")
    self.bonus_dmg = self.ability:GetSpecialValueFor("bonus_dmg")
    self.bonus_range = self.ability:GetSpecialValueFor("bonus_range")
    self.cleave_dmg = self.ability:GetSpecialValueFor("cleave_dmg")
    self.attack_speed = self.ability:GetSpecialValueFor("attack_speed")
    self.bonus_damage_creeps_no_late = self.ability:GetSpecialValueFor("bonus_damage_creeps_no_late")
    self.bonus_damage_creeps_late = self.ability:GetSpecialValueFor("bonus_damage_creeps_late")
    if not IsServer() then return end
end

function modifier_item_ranged_cleave_3:GetModifierBonusStats_Strength()
	return self.bonus_str
end

function modifier_item_ranged_cleave_3:GetModifierBonusStats_Agility()
	return self.bonus_agi
end

function modifier_item_ranged_cleave_3:GetModifierPreAttack_BonusDamage(params)
	if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
		_G.Players:QueueAttackBonus(params.attacker, params.target, self.bonus_dmg, "item_ranged_cleave_3", DAMAGE_TYPE_PHYSICAL)
	end
	return self.bonus_dmg
end

function modifier_item_ranged_cleave_3:GetModifierAttackRangeBonusUnique()
	if self.parent:IsRangedAttacker() then
		return self.bonus_range
	end
end

function modifier_item_ranged_cleave_3:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end

function modifier_item_ranged_cleave_3:GetModifierProcAttack_BonusDamage_Physical( params )
	if not IsServer() then return end
	if params.attacker:IsIllusion() then return end
	if not params.attacker:IsRangedAttacker() then return end
	if params.attacker:GetTeam() == params.target:GetTeam() then return end
	if params.target:IsBuilding() then return end
	if self.parent.anchor_attack_talent then return end
	if self.parent.bCanTriggerLock then return end
	if params.no_attack_cooldown then return end
	if self.parent:HasModifier("modifier_muerta_pierce_the_veil_buff") then return end
	if self.parent:FindAllModifiersByName("modifier_item_ranged_cleave_3")[1] == self and not params.target:IsHero() then
		local bonus = 0
		if self.parent:HasModifier("modifier_skill_eternalist") then
			bonus = 90
		end
		local percentage_damage = params.original_damage / 100 * (self.bonus_damage_creeps_no_late + bonus)
		if GameMode.currentRound and GameMode.currentRound.nRoundNumber > 40 then
			percentage_damage = params.original_damage / 100 * (self.bonus_damage_creeps_late + bonus)
		end
		return percentage_damage
	end
end

function modifier_item_ranged_cleave_3:AttackLandedModifier(params)
	if not IsServer() then return end
	-- [NP-6] Клив не работает по «Other»-юнитам (варды, мины, облако Nimbus и т.п.) —
	-- как в ванили. Опираемся на нативную классификацию IsOther(), без списка имён.
	-- [NP-6] Клив не задевает «Other»-юнитов (варды/мины/Nimbus — нативно) и
	-- неподвижные саммоны (кастомные серпент-варды и т.п., в моде это крипы).
	if params.target then
		if params.target.IsOther and params.target:IsOther() then return end
		if params.target.IsSummoned and params.target:IsSummoned()
			and params.target.GetBaseMoveSpeed and params.target:GetBaseMoveSpeed() == 0 then return end
	end
	if not params.attacker:IsRealHero() or not params.attacker:IsRangedAttacker() then return end
	if params.attacker:GetTeam() == params.target:GetTeam() then return end
	if params.target:IsBuilding() then return end
	if self.parent.anchor_attack_talent then return end
	if self.parent.bCanTriggerLock then return end
	if params.no_attack_cooldown then return end
	if self.parent:HasModifier("modifier_muerta_pierce_the_veil_buff") then return end
	local frostivus2018_clinkz_searing_arrows = self.parent:FindAbilityByName("frostivus2018_clinkz_searing_arrows")
	if frostivus2018_clinkz_searing_arrows then
		if frostivus2018_clinkz_searing_arrows:GetAutoCastState() then
			if params.no_attack_cooldown then
				return
			end
		end
	end
	local target_loc = params.target:GetAbsOrigin()
	local fury_swipes_damage = 0
	if params.attacker:HasAbility("ursa_fury_swipes") and params.target:HasModifier("modifier_ursa_fury_swipes_damage_increase") then
		local ursa_swipes = params.attacker:FindAbilityByName("ursa_fury_swipes")
		if ursa_swipes and not ursa_swipes:IsNull() then
			local stacks = params.target:GetModifierStackCount("modifier_ursa_fury_swipes_damage_increase", params.attacker)
			fury_swipes_damage = stacks * ursa_swipes:GetSpecialValueFor("damage_per_stack")
		end
	end
	local bonus = 0
	if self.parent:HasModifier("modifier_skill_eternalist") then
		bonus = 90
	end
	local percentage_damage = params.original_damage / 100 * (self.bonus_damage_creeps_no_late + bonus)
	if GameMode.currentRound and GameMode.currentRound.nRoundNumber > 60 then
		percentage_damage = params.original_damage / 100 * (self.bonus_damage_creeps_late + bonus)
	end
	local splash_damage = params.original_damage + fury_swipes_damage
	local cleave_dmg = self.cleave_dmg
	if self.parent:HasModifier("modifier_skill_splash") then
		cleave_dmg = cleave_dmg + 30
	end
	splash_damage = splash_damage * cleave_dmg * 0.01
	local modifier_dragon_knight_elder_dragon_form_custom = self.parent:FindModifierByName("modifier_dragon_knight_elder_dragon_form_custom")
	if modifier_dragon_knight_elder_dragon_form_custom then
		splash_damage = splash_damage + (params.damage * modifier_dragon_knight_elder_dragon_form_custom.splash_pct)
	end
	local enemies = FindUnitsInRadius(params.attacker:GetTeamNumber(), target_loc, nil, self.cleave_radius, self.ability:GetAbilityTargetTeam(), self.ability:GetAbilityTargetType(), self.ability:GetAbilityTargetFlags(), FIND_ANY_ORDER, false)
	for _, enemy in pairs(enemies) do
		if enemy ~= params.target then
			ApplyDamage({ victim = enemy, attacker = params.attacker, damage = splash_damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, ability = self.ability})
			if modifier_dragon_knight_elder_dragon_form_custom then
				modifier_dragon_knight_elder_dragon_form_custom:Corrosive( enemy )
			end
		end
	end
end