--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
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
	local k = 0
	if c.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		k = k + GetOutgoingPhysicalDamagePercent(nil, b, c)
	elseif c.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		k = k + GetOutgoingMagicalDamagePercent(nil, b, c)
	elseif c.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE then
		k = k + GetOutgoingNoneDamagePercent(nil, b, c)
	end
	local l = 0
	local m = c.damage_category
	if m == DOTA_DAMAGE_CATEGORY_ATTACK then
		l = l + GetOutgoingAttackDamagePercent(nil, b, c)
	elseif m == DOTA_DAMAGE_CATEGORY_SPELL then
		l = l + GetOutgoingSpellDamagePercent(nil, b, c)
	end
	l = l + GetAbilityTagDamagePercent(nil, b, c)
	local n = 0
	local o = c.target
	if IsValid(o) and (o:GetShield() or 0) > 0 then
		n = n + CompoundIncrease(GetBarrierDamageAmplify(b, c), GetBarrierDamageBoost(b, c))
	end
	local p = c.damage_flags or EOM_DAMAGE_FLAGS.NONE
	if bit.band(p, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE) == EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE then
		n = n + CompoundIncrease(GetLightningDamageBoost(b, c), GetLightningDamageBoost2(b, c))
	end
	if bit.band(p, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE) == EOM_DAMAGE_FLAGS.FREEZE_DAMAGE then
		n = n + CompoundIncrease(GetFreezeDamageBoost(b, c), GetFreezeDamageBoost2(b, c))
	end
	if bit.band(p, EOM_DAMAGE_FLAGS.POISON_DAMAGE) == EOM_DAMAGE_FLAGS.POISON_DAMAGE then
		n = n + CompoundIncrease(GetPoisonDamageBoost(b, c), GetPoisonDamageBoost2(b, c))
	end
	if bit.band(p, EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE) == EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE then
		n = n + CompoundIncrease(GetBleedDamageBoost(b, c), GetBleedDamageBoost2(b, c))
	end
	if
		bit.band(p, EOM_DAMAGE_FLAGS.RETALIATED_DAMAGE) == EOM_DAMAGE_FLAGS.RETALIATED_DAMAGE
		or bit.band(p, EOM_DAMAGE_FLAGS.REFLECT_DAMAGE) == EOM_DAMAGE_FLAGS.REFLECT_DAMAGE
		or bit.band(p, EOM_DAMAGE_FLAGS.SHIELD_DAMAGE) == EOM_DAMAGE_FLAGS.SHIELD_DAMAGE
	then
		n = n + CompoundIncrease(GetHolyShieldDamageBoost(b, c), GetHolyShieldDamageBoost2(b, c))
	end
	if bit.band(p, EOM_DAMAGE_FLAGS.RING_DAMAGE) == EOM_DAMAGE_FLAGS.RING_DAMAGE then
		n = n + GetRingDamageBoost(b, c)
	end
	if bit.band(p, EOM_DAMAGE_FLAGS.SPLIT_DAMAGE) == EOM_DAMAGE_FLAGS.SPLIT_DAMAGE then
		n = n + GetSplashDamageBoost(b, c)
	end
	if
		bit.band(p, EOM_DAMAGE_FLAGS.BLADE) == EOM_DAMAGE_FLAGS.BLADE
		or bit.band(p, EOM_DAMAGE_FLAGS.SWORD) == EOM_DAMAGE_FLAGS.SWORD
	then
		n = n + CompoundIncrease(GetBladeDamageBoost(b, c), GetBladeSwordBoost2(b, c))
	end
	n = n + GetTargetDamageBoost(nil, b, c)
	n = n + GetRangeDamageBoost(nil, b, c)
	if c.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK or BitAndEquals(c.damage_flags, EOM_DAMAGE_FLAGS.Backstab) then
		if
			math.abs(AngleDiff(VectorToAngles(CalcDirection2D(o, b)).y, VectorToAngles(o:GetForwardVector()).y)) < 90
			or BitAndEquals(c.damage_flags, EOM_DAMAGE_FLAGS.Backstab)
		then
			n = n + (BASE_BACKSTAB_DAMAGE + GetBackstabDamageAmplify(b, c)) * (1 + GetBackstabDamageBoost(b, c) * 0.01)
			c.is_backstab = true
		end
	end
	local q = INTENSITY_FACTOR * GetDamageIntensity(b, c) * (1 + 0.01 * GetDamageIntensityBoost(b, c))
	local r = CompoundIncrease(
		q,
		k,
		l,
		n,
		GetHeroDamageBoost(b, c),
		GetDamageBoostMult(b, c),
		GetFinalDamage(b, c),
		GetFinalDamage101(b, c),
		GetFinalDamage102(b, c),
		GetFinalDamage103(b, c)
	)
	return r
end
function GetIncomingDamagePercent(self, b, c)
	local s = GetIncomingDamageAmplify(b, c) - GetDamageReduction(b, c)
	if
		c ~= nil
		and c.damage_flags ~= nil
		and bit.band(c.damage_flags, EOM_DAMAGE_FLAGS.TRAP) == EOM_DAMAGE_FLAGS.TRAP
	then
		s = s + GetTrapIncomingDamageAmplify(b, c)
	end
	return s
end
function GetAbilityChargeByType(self, g)
	if type(g.GetAbilityTag) ~= "function" then
		return 0
	end
	local e = g:GetAbilityTag()
	local t = g:GetCaster()
	repeat
		local u = e
		local v = u == AbilityTag.Attack
		if v then
			return GetAbilityChargeAttack(t)
		end
		v = v or u == AbilityTag.Skill
		if v then
			return GetAbilityChargeSkill(t)
		end
		v = v or u == AbilityTag.Dodge
		if v then
			return GetAbilityChargeDodge(t)
		end
		v = v or u == AbilityTag.Defense
		if v then
			return GetAbilityChargeDefense(t)
		end
		v = v or u == AbilityTag.Ultimate
		if v then
			return GetAbilityChargeUltimate(t)
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
	local t = g:GetCaster()
	if e == AbilityTag.Skill then
		return GetSkillCooldownReduction(t)
	elseif e == AbilityTag.Dodge then
		return GetEvadeCooldownReduction(t)
	elseif e == AbilityTag.Defense then
		return GetBlockCooldownReduction(t)
	elseif e == AbilityTag.Ultimate then
		return GetUltimateCooldownReduction(t)
	end
	return 0
end