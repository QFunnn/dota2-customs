--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "framework/property_system/properties_tool"
function GetDamageBoostWithII(self, b, c, d, e)
	return CompoundIncrease(d, PropertySystem:GetPropertyValue(b:entindex(), c .. "_2", e))
end
function GetFinalGainMultiplier(self, b, c)
	return math.max(0, 1 - PropertySystem:GetPropertyValue(b:entindex(), c) * 0.01)
end
function GetAttackDamage(self, b)
	return b:GetAttackDamage()
end
function GetMaxHealth(self, b)
	return b:GetMaxHealth()
end
function GetShield(self, b)
	return b:GetShield()
end
function GetAbilityTagDamagePercent(self, b, e)
	local f = e and e.ability
	local g = f and f:GetAbilityTag() or AbilityTag.None
	if g == AbilityTag.Skill then
		return CompoundIncrease(
			GetDamageBoostWithII(nil, b, "skill_damage_boost", GetSkillDamageBoost(b, e), e),
			GetSkillDamageAmplify(b, e)
		)
	elseif g == AbilityTag.Dodge then
		return CompoundIncrease(
			GetDamageBoostWithII(nil, b, "dodge_damage_boost", GetDodgeDamageBoost(b, e), e),
			GetDodgeDamageAmplify(b, e)
		)
	elseif g == AbilityTag.Defense then
		return CompoundIncrease(
			GetDamageBoostWithII(nil, b, "defense_damage_boost", GetDefenseDamageBoost(b, e), e),
			GetDefenseDamageAmplify(b, e)
		)
	elseif g == AbilityTag.Ultimate then
		return CompoundIncrease(
			GetDamageBoostWithII(nil, b, "ultimate_damage_boost", GetUltimateDamageBoost(b, e), e),
			GetUltimateDamageAmplify(b, e)
		)
	end
	return 0
end
function GetTargetDamageBoost(self, b, e)
	local h = 0
	if e ~= nil and IsValid(e.target) then
		if e.target:IsBoss() then
			h = h + GetDamageBoostWithII(nil, b, "boss_damage_boost", GetBossDamageBoost(b, e), e)
		elseif e.target:IsElite() then
			h = h + GetDamageBoostWithII(nil, b, "elite_damage_boost", GetEliteDamageBoost(b, e), e)
		elseif e.target:IsCreep() then
			h = h + GetMinionDamageBoost(b, e)
		end
		if e.target:GetHealthPercent() <= 30 then
			h = h + CompoundIncrease(GetExecuteDamage(b, e), GetExecuteDamageAmplify(b, e))
		end
		if e.target:IsBleed() then
			h = h + GetDamageVsBleedingTargets(b, e)
		end
		if e.target:IsFrozen() then
			h = h + GetDamageVsFrozenTargets(b, e)
		end
		if e.target:IsShrine() then
			h = h + GetDamageVsShockedTargets(b, e)
		end
	end
	return h
end
function GetRangeDamageBoost(self, b, e)
	if e ~= nil and e.target ~= nil then
		local i = e.ability
		if IsValid(i) and i:GetAbilityName() == "vexis_1" then
			local j = i:GetSpecialValueFor("always_melee_damage") > 0
			local k = i:GetSpecialValueFor("always_ranged_damage") > 0
			if j or k then
				return (j and GetDamageBoostWithII(nil, b, "melee_damage_boost", GetMeleeDamageBoost(b, e), e) or 0)
					+ (k and GetDamageBoostWithII(nil, b, "ranged_damage_boost", GetRangedDamageBoost(b, e), e) or 0)
			end
		end
		local l = CalcDistance(b, e.target)
		if l <= 300 then
			return GetDamageBoostWithII(nil, b, "melee_damage_boost", GetMeleeDamageBoost(b, e), e)
		end
		return GetDamageBoostWithII(nil, b, "ranged_damage_boost", GetRangedDamageBoost(b, e), e)
	end
	return 0
end
function GetOutgoingPhysicalDamagePercent(self, b, e)
	return CompoundIncrease(
		GetDamageBoostWithII(nil, b, "damage_boost", GetDamageBoost(b, e), e)
			+ GetDamageBoostWithII(nil, b, "physical_damage_boost", GetPhysicalDamageBoost(b, e), e),
		GetDamageAmplify(b, e) + GetPhysicalDamageAmplify(b, e)
	)
end
function GetOutgoingMagicalDamagePercent(self, b, e)
	return CompoundIncrease(
		GetDamageBoostWithII(nil, b, "damage_boost", GetDamageBoost(b, e), e)
			+ GetDamageBoostWithII(nil, b, "magical_damage_boost", GetMagicalDamageBoost(b, e), e),
		GetDamageAmplify(b, e) + GetMagicalDamageAmplify(b, e)
	)
end
function GetOutgoingAttackDamagePercent(self, b, e)
	return CompoundIncrease(
		GetDamageBoostWithII(nil, b, "attack_damage_boost", GetAttackDamageBoost(b, e), e),
		GetAttackDamageAmplify(b, e)
	)
end
function GetOutgoingSpellDamagePercent(self, b, e)
	return CompoundIncrease(
		GetDamageBoostWithII(nil, b, "spell_damage_boost", GetSpellDamageBoost(b, e), e),
		GetSpellDamageAmplify(b, e)
	)
end
function GetOutgoingDamagePercent(self, b, e)
	local m = 0
	local n = 0
	local o = 0
	if e.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		m = m + GetOutgoingPhysicalDamagePercent(nil, b, e)
		n = GetPhysicalDamageMultiplier(b, e)
		o = GetPhysicalDamageMultiplierMul(b, e)
	elseif e.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		m = m + GetOutgoingMagicalDamagePercent(nil, b, e)
		n = GetMagicalDamageMultiplier(b, e)
		o = GetMagicalDamageMultiplierMul(b, e)
	elseif e.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE then
		local p = GetOutgoingPhysicalDamagePercent(nil, b, e)
		local q = GetOutgoingMagicalDamagePercent(nil, b, e)
		local r = GetPhysicalDamageMultiplier(b, e)
		local s = GetMagicalDamageMultiplier(b, e)
		local t = GetPhysicalDamageMultiplierMul(b, e)
		local u = GetMagicalDamageMultiplierMul(b, e)
		if CompoundIncrease(p, r) >= CompoundIncrease(q, s) then
			m = p
			n = r
		else
			m = q
			n = s
		end
		if CompoundIncrease(p, t) >= CompoundIncrease(q, u) then
			m = p
			o = t
		else
			m = q
			o = u
		end
	end
	local v = 0
	local w = 0
	local x = e.damage_category
	if x == DOTA_DAMAGE_CATEGORY_ATTACK then
		v = v + GetOutgoingAttackDamagePercent(nil, b, e)
	elseif x == DOTA_DAMAGE_CATEGORY_SPELL then
		v = v + GetOutgoingSpellDamagePercent(nil, b, e)
		w = GetSpellDamageMultiplier(b, e)
	end
	v = v + GetAbilityTagDamagePercent(nil, b, e)
	local y = e.ability
	local z = (y and y:GetAbilityTag()) == AbilityTag.Skill and GetSkillDamageMultiplier(b, e) or 0
	local A = 0
	local B = e.target
	if IsValid(B) and (B:GetShield() or 0) > 0 then
		A = A
			+ CompoundIncrease(
				GetBarrierDamageAmplify(b, e),
				GetDamageBoostWithII(nil, b, "barrier_damage_boost", GetBarrierDamageBoost(b, e), e)
			)
	end
	local C = e.damage_flags or EOM_DAMAGE_FLAGS.NONE
	if bit.band(C, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE) == EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE then
		A = A
			+ CompoundIncrease(
				GetDamageBoostWithII(nil, b, "lightning_damage_boost", GetLightningDamageBoost(b, e), e),
				GetLightningDamageBoost2(b, e)
			)
	end
	if bit.band(C, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE) == EOM_DAMAGE_FLAGS.FREEZE_DAMAGE then
		A = A
			+ CompoundIncrease(
				GetDamageBoostWithII(nil, b, "freeze_damage_boost", GetFreezeDamageBoost(b, e), e),
				GetFreezeDamageBoost2(b, e)
			)
	end
	if bit.band(C, EOM_DAMAGE_FLAGS.POISON_DAMAGE) == EOM_DAMAGE_FLAGS.POISON_DAMAGE then
		A = A
			+ CompoundIncrease(
				GetDamageBoostWithII(nil, b, "poison_damage_boost", GetPoisonDamageBoost(b, e), e),
				GetPoisonDamageBoost2(b, e)
			)
	end
	if bit.band(C, EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE) == EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE then
		A = A
			+ CompoundIncrease(
				GetDamageBoostWithII(nil, b, "bleed_damage_boost", GetBleedDamageBoost(b, e), e),
				GetBleedDamageBoost2(b, e)
			)
	end
	if
		bit.band(C, EOM_DAMAGE_FLAGS.RETALIATED_DAMAGE) == EOM_DAMAGE_FLAGS.RETALIATED_DAMAGE
		or bit.band(C, EOM_DAMAGE_FLAGS.REFLECT_DAMAGE) == EOM_DAMAGE_FLAGS.REFLECT_DAMAGE
		or bit.band(C, EOM_DAMAGE_FLAGS.SHIELD_DAMAGE) == EOM_DAMAGE_FLAGS.SHIELD_DAMAGE
	then
		A = A
			+ CompoundIncrease(
				GetDamageBoostWithII(nil, b, "holy_shield_damage_boost", GetHolyShieldDamageBoost(b, e), e),
				GetHolyShieldDamageBoost2(b, e)
			)
	end
	if bit.band(C, EOM_DAMAGE_FLAGS.RING_DAMAGE) == EOM_DAMAGE_FLAGS.RING_DAMAGE then
		A = A + GetDamageBoostWithII(nil, b, "ring_damage_boost", GetRingDamageBoost(b, e), e)
	end
	if bit.band(C, EOM_DAMAGE_FLAGS.SPLIT_DAMAGE) == EOM_DAMAGE_FLAGS.SPLIT_DAMAGE then
		A = A + GetDamageBoostWithII(nil, b, "splash_damage_boost", GetSplashDamageBoost(b, e), e)
	end
	if
		bit.band(C, EOM_DAMAGE_FLAGS.BLADE) == EOM_DAMAGE_FLAGS.BLADE
		or bit.band(C, EOM_DAMAGE_FLAGS.SWORD) == EOM_DAMAGE_FLAGS.SWORD
	then
		A = A
			+ CompoundIncrease(
				GetDamageBoostWithII(nil, b, "blade_damage_boost", GetBladeDamageBoost(b, e), e),
				GetBladeSwordBoost2(b, e)
			)
	end
	A = A + GetTargetDamageBoost(nil, b, e)
	A = A + GetRangeDamageBoost(nil, b, e)
	if e.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK or BitAndEquals(e.damage_flags, EOM_DAMAGE_FLAGS.Backstab) then
		if
			math.abs(AngleDiff(VectorToAngles(CalcDirection2D(B, b)).y, VectorToAngles(B:GetForwardVector()).y)) < 90
			or BitAndEquals(e.damage_flags, EOM_DAMAGE_FLAGS.Backstab)
		then
			A = A
				+ (BASE_BACKSTAB_DAMAGE + GetBackstabDamageAmplify(b, e))
					* (1 + GetDamageBoostWithII(nil, b, "backstab_damage_boost", GetBackstabDamageBoost(b, e), e) * 0.01)
			e.is_backstab = true
		end
	end
	local D = INTENSITY_FACTOR * GetDamageIntensity(b, e) * (1 + 0.01 * GetDamageIntensityBoost(b, e))
	local E = CompoundIncrease(
		D,
		m,
		v,
		A,
		n,
		o,
		w,
		z,
		GetHeroDamageBoost(b, e),
		GetDamageBoostMult(b, e),
		GetFinalDamage(b, e),
		GetFinalDamage101(b, e),
		GetFinalDamage102(b, e),
		GetFinalDamage103(b, e)
	)
	return E
end
function GetIncomingDamagePercent(self, b, e)
	local F = GetIncomingDamageAmplify(b, e) - GetDamageReduction(b, e)
	if
		e ~= nil
		and e.damage_flags ~= nil
		and bit.band(e.damage_flags, EOM_DAMAGE_FLAGS.TRAP) == EOM_DAMAGE_FLAGS.TRAP
	then
		F = F + GetTrapIncomingDamageAmplify(b, e)
	end
	return F
end
function GetAbilityChargeByType(self, i)
	if type(i.GetAbilityTag) ~= "function" then
		return 0
	end
	local g = i:GetAbilityTag()
	local G = i:GetCaster()
	repeat
		local H = g
		local I = H == AbilityTag.Attack
		if I then
			return GetAbilityChargeAttack(G)
		end
		I = I or H == AbilityTag.Skill
		if I then
			return GetAbilityChargeSkill(G)
		end
		I = I or H == AbilityTag.Dodge
		if I then
			return GetAbilityChargeDodge(G)
		end
		I = I or H == AbilityTag.Defense
		if I then
			return GetAbilityChargeDefense(G)
		end
		I = I or H == AbilityTag.Ultimate
		if I then
			return GetAbilityChargeUltimate(G)
		end
		do
			return 0
		end
	until true
end
function GetCooldownReductionByTag(self, i)
	if not IsValid(i) then
		return 0
	end
	if type(i.GetAbilityTag) ~= "function" then
		return 0
	end
	local g = i:GetAbilityTag()
	local G = i:GetCaster()
	if g == AbilityTag.Skill then
		return GetSkillCooldownReduction(G)
	elseif g == AbilityTag.Dodge then
		return GetEvadeCooldownReduction(G)
	elseif g == AbilityTag.Defense then
		return GetBlockCooldownReduction(G)
	elseif g == AbilityTag.Ultimate then
		return GetUltimateCooldownReduction(G)
	end
	return 0
end