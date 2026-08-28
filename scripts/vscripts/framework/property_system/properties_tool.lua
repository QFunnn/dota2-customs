--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/property_system/properties_tool"
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
		local g = CalcDistance(b, c.target)
		if g <= 300 then
			return GetMeleeDamageBoost(b, c)
		end
		return GetRangedDamageBoost(b, c)
	end
	return 0
end
function GetOutgoingNoneDamagePercent(self, b, c)
	return math.max(GetOutgoingPhysicalDamagePercent(nil, b, c), GetOutgoingMagicalDamagePercent(nil, b, c))
end
function GetOutgoingAttackDamagePercent(self, b, c)
	return CompoundIncrease(GetAttackDamageBoost(b, c), GetAttackDamageAmplify(b, c))
end
function GetOutgoingSpellDamagePercent(self, b, c)
	return CompoundIncrease(GetSpellDamageBoost(b, c), GetSpellDamageAmplify(b, c))
end
function GetOutgoingDamagePercent(self, b, c)
	local h = 0
	if c.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		h = h + GetOutgoingPhysicalDamagePercent(nil, b, c)
	elseif c.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		h = h + GetOutgoingMagicalDamagePercent(nil, b, c)
	elseif c.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE then
		h = h + GetOutgoingNoneDamagePercent(nil, b, c)
	end
	local i = 0
	local j = c.damage_category
	if j == DOTA_DAMAGE_CATEGORY_ATTACK then
		i = i + GetOutgoingAttackDamagePercent(nil, b, c)
	elseif j == DOTA_DAMAGE_CATEGORY_SPELL then
		i = i + GetOutgoingSpellDamagePercent(nil, b, c)
	end
	i = i + GetAbilityTagDamagePercent(nil, b, c)
	local k = 0
	local l = c.target
	if IsValid(l) and (l:GetShield() or 0) > 0 then
		k = k + CompoundIncrease(GetBarrierDamageAmplify(b, c), GetBarrierDamageBoost(b, c))
	end
	local m = c.damage_flags or EOM_DAMAGE_FLAGS.NONE
	if bit.band(m, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE) == EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE then
		k = k + CompoundIncrease(GetLightningDamageBoost(b, c), GetLightningDamageBoost2(b, c))
	end
	if bit.band(m, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE) == EOM_DAMAGE_FLAGS.FREEZE_DAMAGE then
		k = k + CompoundIncrease(GetFreezeDamageBoost(b, c), GetFreezeDamageBoost2(b, c))
	end
	if bit.band(m, EOM_DAMAGE_FLAGS.POISON_DAMAGE) == EOM_DAMAGE_FLAGS.POISON_DAMAGE then
		k = k + CompoundIncrease(GetPoisonDamageBoost(b, c), GetPoisonDamageBoost2(b, c))
	end
	if bit.band(m, EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE) == EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE then
		k = k + CompoundIncrease(GetBleedDamageBoost(b, c), GetBleedDamageBoost2(b, c))
	end
	if
		bit.band(m, EOM_DAMAGE_FLAGS.RETALIATED_DAMAGE) == EOM_DAMAGE_FLAGS.RETALIATED_DAMAGE
		or bit.band(m, EOM_DAMAGE_FLAGS.REFLECT_DAMAGE) == EOM_DAMAGE_FLAGS.REFLECT_DAMAGE
		or bit.band(m, EOM_DAMAGE_FLAGS.SHIELD_DAMAGE) == EOM_DAMAGE_FLAGS.SHIELD_DAMAGE
	then
		k = k + CompoundIncrease(GetHolyShieldDamageBoost(b, c), GetHolyShieldDamageBoost2(b, c))
	end
	if bit.band(m, EOM_DAMAGE_FLAGS.RING_DAMAGE) == EOM_DAMAGE_FLAGS.RING_DAMAGE then
		k = k + GetRingDamageBoost(b, c)
	end
	if bit.band(m, EOM_DAMAGE_FLAGS.SPLIT_DAMAGE) == EOM_DAMAGE_FLAGS.SPLIT_DAMAGE then
		k = k + GetSplashDamageBoost(b, c)
	end
	if
		bit.band(m, EOM_DAMAGE_FLAGS.BLADE) == EOM_DAMAGE_FLAGS.BLADE
		or bit.band(m, EOM_DAMAGE_FLAGS.SWORD) == EOM_DAMAGE_FLAGS.SWORD
	then
		k = k + CompoundIncrease(GetBladeDamageBoost(b, c), GetBladeSwordBoost2(b, c))
	end
	k = k + GetTargetDamageBoost(nil, b, c)
	k = k + GetRangeDamageBoost(nil, b, c)
	if c.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK or BitAndEquals(c.damage_flags, EOM_DAMAGE_FLAGS.Backstab) then
		if
			math.abs(AngleDiff(VectorToAngles(CalcDirection2D(l, b)).y, VectorToAngles(l:GetForwardVector()).y)) < 90
			or BitAndEquals(c.damage_flags, EOM_DAMAGE_FLAGS.Backstab)
		then
			k = k + (BASE_BACKSTAB_DAMAGE + GetBackstabDamageAmplify(b, c)) * (1 + GetBackstabDamageBoost(b, c) * 0.01)
			c.is_backstab = true
		end
	end
	local n = INTENSITY_FACTOR * GetDamageIntensity(b, c) * (1 + 0.01 * GetDamageIntensityBoost(b, c))
	local o = CompoundIncrease(
		n,
		h,
		i,
		k,
		GetHeroDamageBoost(b, c),
		GetDamageBoostMult(b, c),
		GetFinalDamage(b, c),
		GetFinalDamage101(b, c),
		GetFinalDamage102(b, c),
		GetFinalDamage103(b, c)
	)
	return o
end
function GetIncomingDamagePercent(self, b, c)
	local p = GetIncomingDamageAmplify(b, c) - GetDamageReduction(b, c)
	if
		c ~= nil
		and c.damage_flags ~= nil
		and bit.band(c.damage_flags, EOM_DAMAGE_FLAGS.TRAP) == EOM_DAMAGE_FLAGS.TRAP
	then
		p = p + GetTrapIncomingDamageAmplify(b, c)
	end
	return p
end
function GetAbilityChargeByType(self, q)
	if type(q.GetAbilityTag) ~= "function" then
		return 0
	end
	local e = q:GetAbilityTag()
	local r = q:GetCaster()
	repeat
		local s = e
		local t = s == AbilityTag.Attack
		if t then
			return GetAbilityChargeAttack(r)
		end
		t = t or s == AbilityTag.Skill
		if t then
			return GetAbilityChargeSkill(r)
		end
		t = t or s == AbilityTag.Dodge
		if t then
			return GetAbilityChargeDodge(r)
		end
		t = t or s == AbilityTag.Defense
		if t then
			return GetAbilityChargeDefense(r)
		end
		t = t or s == AbilityTag.Ultimate
		if t then
			return GetAbilityChargeUltimate(r)
		end
		do
			return 0
		end
	until true
end
function GetCooldownReductionByTag(self, q)
	if not IsValid(q) then
		return 0
	end
	if type(q.GetAbilityTag) ~= "function" then
		return 0
	end
	local e = q:GetAbilityTag()
	local r = q:GetCaster()
	if e == AbilityTag.Skill then
		return GetSkillCooldownReduction(r)
	elseif e == AbilityTag.Dodge then
		return GetEvadeCooldownReduction(r)
	elseif e == AbilityTag.Defense then
		return GetBlockCooldownReduction(r)
	elseif e == AbilityTag.Ultimate then
		return GetUltimateCooldownReduction(r)
	end
	return 0
end