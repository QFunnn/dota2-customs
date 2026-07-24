--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ranged_cleave", "items/item_ranged_cleave", LUA_MODIFIER_MOTION_NONE)

item_ranged_cleave = class({})

function item_ranged_cleave:GetIntrinsicModifierName()
	return "modifier_item_ranged_cleave"
end

modifier_item_ranged_cleave = class({})

function modifier_item_ranged_cleave:IsDebuff() return false end
function modifier_item_ranged_cleave:IsHidden() return true end
function modifier_item_ranged_cleave:IsPurgable() return false end
function modifier_item_ranged_cleave:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_ranged_cleave:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.cleave_radius = self.ability:GetSpecialValueFor("cleave_radius")
    self.bonus_str = self.ability:GetSpecialValueFor("bonus_str")
    self.bonus_agi = self.ability:GetSpecialValueFor("bonus_agi")
    self.bonus_dmg = self.ability:GetSpecialValueFor("bonus_dmg")
    self.bonus_range = self.ability:GetSpecialValueFor("bonus_range")
    self.cleave_dmg = self.ability:GetSpecialValueFor("cleave_dmg")
    if not IsServer() then return end
end

function modifier_item_ranged_cleave:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_item_ranged_cleave:GetModifierBonusStats_Strength()
	return self.bonus_str
end

function modifier_item_ranged_cleave:GetModifierBonusStats_Agility()
	return self.bonus_agi
end

function modifier_item_ranged_cleave:GetModifierPreAttack_BonusDamage(params)
	if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
		_G.Players:QueueAttackBonus(params.attacker, params.target, self.bonus_dmg, "item_ranged_cleave", DAMAGE_TYPE_PHYSICAL)
	end
	return self.bonus_dmg
end

function modifier_item_ranged_cleave:GetModifierAttackRangeBonusUnique()
	if self.parent:IsRangedAttacker() then
		return self.bonus_range
	else
		return 0
	end
end

function modifier_item_ranged_cleave:AttackLandedModifier(keys)
	if not IsServer() then return end
	-- [NP-6] Клив не работает по «Other»-юнитам (варды, мины, облако Nimbus и т.п.) —
	-- как в ванили. Опираемся на нативную классификацию IsOther(), без списка имён.
	-- [NP-6] Клив не задевает «Other»-юнитов (варды/мины/Nimbus — нативно) и
	-- неподвижные саммоны (кастомные серпент-варды и т.п., в моде это крипы).
	if keys.target then
		if keys.target.IsOther and keys.target:IsOther() then return end
		if keys.target.IsSummoned and keys.target:IsSummoned()
			and keys.target.GetBaseMoveSpeed and keys.target:GetBaseMoveSpeed() == 0 then return end
	end
	if not keys.attacker:IsRealHero() or not keys.attacker:IsRangedAttacker() then return end
	if keys.attacker:GetTeam() == keys.target:GetTeam() then return end
	if keys.target:IsBuilding() then return end
	if self.parent.anchor_attack_talent then return end
	if self.parent.bCanTriggerLock then return end
	if keys.no_attack_cooldown then return end
	if self.parent:HasModifier("modifier_muerta_pierce_the_veil_buff") then return end
	local frostivus2018_clinkz_searing_arrows = self.parent:FindAbilityByName("frostivus2018_clinkz_searing_arrows")
	if frostivus2018_clinkz_searing_arrows then
		if frostivus2018_clinkz_searing_arrows:GetAutoCastState() then
			if keys.no_attack_cooldown then
				return
			end
		end
	end
	local target_loc = keys.target:GetAbsOrigin()
	local fury_swipes_damage = 0
	if keys.attacker:HasAbility("ursa_fury_swipes") and keys.target:HasModifier("modifier_ursa_fury_swipes_damage_increase") then
		local ursa_swipes = keys.attacker:FindAbilityByName("ursa_fury_swipes")
		if ursa_swipes and not ursa_swipes:IsNull() then
			local stacks = keys.target:GetModifierStackCount("modifier_ursa_fury_swipes_damage_increase", keys.attacker)
			fury_swipes_damage = stacks * ursa_swipes:GetSpecialValueFor("damage_per_stack")
		end
	end
	local cleave_dmg = self.cleave_dmg
	if self.parent:HasModifier("modifier_skill_splash") then
		cleave_dmg = cleave_dmg + 30
	end
	local damage = (keys.original_damage + fury_swipes_damage) * cleave_dmg * 0.01
	local modifier_dragon_knight_elder_dragon_form_custom = self.parent:FindModifierByName("modifier_dragon_knight_elder_dragon_form_custom")
	if modifier_dragon_knight_elder_dragon_form_custom then
		damage = damage + (keys.damage * modifier_dragon_knight_elder_dragon_form_custom.splash_pct)
	end
	local enemies = FindUnitsInRadius(keys.attacker:GetTeamNumber(), target_loc, nil, self.cleave_radius, self.ability:GetAbilityTargetTeam(), self.ability:GetAbilityTargetType(), self.ability:GetAbilityTargetFlags(), FIND_ANY_ORDER, false)
	for _, enemy in pairs(enemies) do
		if enemy ~= keys.target then
			ApplyDamage({ victim = enemy, attacker = keys.attacker, damage = damage, damage_type = self.ability:GetAbilityDamageType(), damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, ability = self.ability })
		end
	end
end