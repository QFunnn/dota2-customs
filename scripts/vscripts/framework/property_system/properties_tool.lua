--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "framework/property_system/properties_tool"
function GetAttackDamage(self, b)
	return b:GetAttackDamage()
end
function GetMaxHealth(self, b)
	return b:GetMaxHealth()
end
function GetShield(self, b)
	return b:GetShield()
end
function GetAbilityTagDamagePercent(self, b, c)
	local d = c and c.ability
	local e = d and d:GetAbilityTag() or AbilityTag.None
	if e == AbilityTag.Skill then
		return CompoundIncrease(GetSkillDamageBoost(b, c), GetSkillDamageAmplify(b, c))
	elseif e == AbilityTag.Dodge then
		return CompoundIncrease(GetDodgeDamageBoost(b, c), GetDodgeDamageAmplify(b, c))
	elseif e == AbilityTag.Defense then
		return CompoundIncrease(GetDefenseDamageBoost(b, c), GetDefenseDamageAmplify(b, c))
	elseif e == AbilityTag.Ultimate then
		return CompoundIncrease(GetUltimateDamageBoost(b, c), GetUltimateDamageAmplify(b, c))
	end
	return 0
end
function GetTargetDamageBoost(self, b, c)
	local f = 0
	if c ~= nil and IsValid(c.target) then
		if c.target:IsBoss() then
			f = f + GetBossDamageBoost(b, c)
		elseif c.target:IsElite() then
			f = f + GetEliteDamageBoost(b, c)
		elseif c.target:IsCreep() then
			f = f + GetMinionDamageBoost(b, c)
		end
		if c.target:GetHealthPercent() <= 30 then
			f = f + CompoundIncrease(GetExecuteDamage(b, c), GetExecuteDamageAmplify(b, c))
		end
		if c.target:IsBleed() then
			f = f + GetDamageVsBleedingTargets(b, c)
		end
		if c.target:IsFrozen() then
			f = f + GetDamageVsFrozenTargets(b, c)
		end
		if c.target:IsShrine() then
			f = f + GetDamageVsShockedTargets(b, c)
		end
	end
	return f
end
function GetRangeDamageBoost(self, b, c)
	if c ~= nil and c.target ~= nil then
		local g = c.ability
		if IsValid(g) and g:GetAbilityName() == "vexis_1" then
			local h = g:GetSpecialValueFor("always_melee_damage") > 0
			local i = g:GetSpecialValueFor("always_ranged_damage") > 0
			if h or i then
				return (h and GetMeleeDamageBoost(b, c) or 0) + (i and GetRangedDamageBoost(b, c) or 0)
			end
		end
		local j = CalcDistance(b, c.target)
		if j <= 300 then
			return GetMeleeDamageBoost(b, c)
		end
		return GetRangedDamageBoost(b, c)
	end
	return 0
end
function GetOutgoingPhysicalDamagePercent(self, b, c)
	return CompoundIncrease(
		GetDamageBoost(b, c) + GetPhysicalDamageBoost(b, c),
		GetDamageAmplify(b, c) + GetPhysicalDamageAmplify(b, c)
	)
end
function GetOutgoingMagicalDamagePercent(self, b, c)
	return CompoundIncrease(
		GetDamageBoost(b, c) + GetMagicalDamageBoost(b, c),
		GetDamageAmplify(b, c) + GetMagicalDamageAmplify(b, c)
	)
end
function GetOutgoingAttackDamagePercent(self, b, c)
	return CompoundIncrease(GetAttackDamageBoost(b, c), GetAttackDamageAmplify(b, c))
end
function GetOutgoingSpellDamagePercent(self, b, c)
	return CompoundIncrease(GetSpellDamageBoost(b, c), GetSpellDamageAmplify(b, c))
end
function GetOutgoingDamagePercent(self, b, c)
	local k = 0
	local l = 0
	if c.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		k = k + GetOutgoingPhysicalDamagePercent(nil, b, c)
		l = GetPhysicalDamageMultiplier(b, c)
	elseif c.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		k = k + GetOutgoingMagicalDamagePercent(nil, b, c)
		l = GetMagicalDamageMultiplier(b, c)
	elseif c.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE then
		local m = GetOutgoingPhysicalDamagePercent(nil, b, c)
		local n = GetOutgoingMagicalDamagePercent(nil, b, c)
		local o = GetPhysicalDamageMultiplier(b, c)
		local p = GetMagicalDamageMultiplier(b, c)
		if CompoundIncrease(m, o) >= CompoundIncrease(n, p) then
			k = m
			l = o
		else
			k = n
			l = p
		end
	end
	local q = 0
	local r = 0
	local s = c.damage_category
	if s == DOTA_DAMAGE_CATEGORY_ATTACK then
		q = q + GetOutgoingAttackDamagePercent(nil, b, c)
	elseif s == DOTA_DAMAGE_CATEGORY_SPELL then
		q = q + GetOutgoingSpellDamagePercent(nil, b, c)
		r = GetSpellDamageMultiplier(b, c)
	end
	q = q + GetAbilityTagDamagePercent(nil, b, c)
	local t = c.ability
	local u = (t and t:GetAbilityTag()) == AbilityTag.Skill and GetSkillDamageMultiplier(b, c) or 0
	local v = 0
	local w = c.target
	if IsValid(w) and (w:GetShield() or 0) > 0 then
		v = v + CompoundIncrease(GetBarrierDamageAmplify(b, c), GetBarrierDamageBoost(b, c))
	end
	local x = c.damage_flags or EOM_DAMAGE_FLAGS.NONE
	if bit.band(x, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE) == EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE then
		v = v + CompoundIncrease(GetLightningDamageBoost(b, c), GetLightningDamageBoost2(b, c))
	end
	if bit.band(x, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE) == EOM_DAMAGE_FLAGS.FREEZE_DAMAGE then
		v = v + CompoundIncrease(GetFreezeDamageBoost(b, c), GetFreezeDamageBoost2(b, c))
	end
	if bit.band(x, EOM_DAMAGE_FLAGS.POISON_DAMAGE) == EOM_DAMAGE_FLAGS.POISON_DAMAGE then
		v = v + CompoundIncrease(GetPoisonDamageBoost(b, c), GetPoisonDamageBoost2(b, c))
	end
	if bit.band(x, EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE) == EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE then
		v = v + CompoundIncrease(GetBleedDamageBoost(b, c), GetBleedDamageBoost2(b, c))
	end
	if
		bit.band(x, EOM_DAMAGE_FLAGS.RETALIATED_DAMAGE) == EOM_DAMAGE_FLAGS.RETALIATED_DAMAGE
		or bit.band(x, EOM_DAMAGE_FLAGS.REFLECT_DAMAGE) == EOM_DAMAGE_FLAGS.REFLECT_DAMAGE
		or bit.band(x, EOM_DAMAGE_FLAGS.SHIELD_DAMAGE) == EOM_DAMAGE_FLAGS.SHIELD_DAMAGE
	then
		v = v + CompoundIncrease(GetHolyShieldDamageBoost(b, c), GetHolyShieldDamageBoost2(b, c))
	end
	if bit.band(x, EOM_DAMAGE_FLAGS.RING_DAMAGE) == EOM_DAMAGE_FLAGS.RING_DAMAGE then
		v = v + GetRingDamageBoost(b, c)
	end
	if bit.band(x, EOM_DAMAGE_FLAGS.SPLIT_DAMAGE) == EOM_DAMAGE_FLAGS.SPLIT_DAMAGE then
		v = v + GetSplashDamageBoost(b, c)
	end
	if
		bit.band(x, EOM_DAMAGE_FLAGS.BLADE) == EOM_DAMAGE_FLAGS.BLADE
		or bit.band(x, EOM_DAMAGE_FLAGS.SWORD) == EOM_DAMAGE_FLAGS.SWORD
	then
		v = v + CompoundIncrease(GetBladeDamageBoost(b, c), GetBladeSwordBoost2(b, c))
	end
	v = v + GetTargetDamageBoost(nil, b, c)
	v = v + GetRangeDamageBoost(nil, b, c)
	if c.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK or BitAndEquals(c.damage_flags, EOM_DAMAGE_FLAGS.Backstab) then
		if
			math.abs(AngleDiff(VectorToAngles(CalcDirection2D(w, b)).y, VectorToAngles(w:GetForwardVector()).y)) < 90
			or BitAndEquals(c.damage_flags, EOM_DAMAGE_FLAGS.Backstab)
		then
			v = v + (BASE_BACKSTAB_DAMAGE + GetBackstabDamageAmplify(b, c)) * (1 + GetBackstabDamageBoost(b, c) * 0.01)
			c.is_backstab = true
		end
	end
	local y = INTENSITY_FACTOR * GetDamageIntensity(b, c) * (1 + 0.01 * GetDamageIntensityBoost(b, c))
	local z = CompoundIncrease(
		y,
		k,
		q,
		v,
		l,
		r,
		u,
		GetHeroDamageBoost(b, c),
		GetDamageBoostMult(b, c),
		GetFinalDamage(b, c),
		GetFinalDamage101(b, c),
		GetFinalDamage102(b, c),
		GetFinalDamage103(b, c)
	)
	return z
end
function GetIncomingDamagePercent(self, b, c)
	local A = GetIncomingDamageAmplify(b, c) - GetDamageReduction(b, c)
	if
		c ~= nil
		and c.damage_flags ~= nil
		and bit.band(c.damage_flags, EOM_DAMAGE_FLAGS.TRAP) == EOM_DAMAGE_FLAGS.TRAP
	then
		A = A + GetTrapIncomingDamageAmplify(b, c)
	end
	return A
end
function GetAbilityChargeByType(self, g)
	if type(g.GetAbilityTag) ~= "function" then
		return 0
	end
	local e = g:GetAbilityTag()
	local B = g:GetCaster()
	repeat
		local C = e
		local D = C == AbilityTag.Attack
		if D then
			return GetAbilityChargeAttack(B)
		end
		D = D or C == AbilityTag.Skill
		if D then
			return GetAbilityChargeSkill(B)
		end
		D = D or C == AbilityTag.Dodge
		if D then
			return GetAbilityChargeDodge(B)
		end
		D = D or C == AbilityTag.Defense
		if D then
			return GetAbilityChargeDefense(B)
		end
		D = D or C == AbilityTag.Ultimate
		if D then
			return GetAbilityChargeUltimate(B)
		end
		do
			return 0
		end
	until true
end
function GetCooldownReductionByTag(self, g)
	if not IsValid(g) then
		return 0
	end
	if type(g.GetAbilityTag) ~= "function" then
		return 0
	end
	local e = g:GetAbilityTag()
	local B = g:GetCaster()
	if e == AbilityTag.Skill then
		return GetSkillCooldownReduction(B)
	elseif e == AbilityTag.Dodge then
		return GetEvadeCooldownReduction(B)
	elseif e == AbilityTag.Defense then
		return GetBlockCooldownReduction(B)
	elseif e == AbilityTag.Ultimate then
		return GetUltimateCooldownReduction(B)
	end
	return 0
end