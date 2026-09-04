--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
function ____exports.IsValidEnemyUnit(self, parent, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	return target:GetTeamNumber() ~= parent:GetTeamNumber()
end
function ____exports.IsValidFriendUnit(self, parent, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	return target:GetTeamNumber() == parent:GetTeamNumber()
end
function ____exports.IsNonDotDamage(self, event, ignoredCustomTag)
	if (event.final_damage or 0) <= 0 then
		return false
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return false
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.DOT) then
		return false
	end
	local ____ignoredCustomTag_5 = ignoredCustomTag
	if ____ignoredCustomTag_5 then
		local ____opt_3 = event.source
		____ignoredCustomTag_5 = (____opt_3 and ____opt_3.custom_tag) == ignoredCustomTag
	end
	if ____ignoredCustomTag_5 then
		return false
	end
	return true
end
function ____exports.StartAbilityCooldown(self, ability, fallback)
	local level = math.max(0, ability:GetLevel() - 1)
	local ability_cooldown = ability:GetCooldown(level)
	local ____ability_7 = ability
	local ____ability_StartCooldown_8 = ability.StartCooldown
	local ____temp_6
	if ability_cooldown > 0 then
		____temp_6 = ability_cooldown
	else
		____temp_6 = fallback
	end
	____ability_StartCooldown_8(____ability_7, ____temp_6)
end
function ____exports.GetStrength(self, parent)
	return math.max(0, MyGameAttribute:GetAttribute(parent, "total_strength") or 0)
end
function ____exports.GetAgility(self, parent)
	return math.max(0, MyGameAttribute:GetAttribute(parent, "total_agility") or 0)
end
function ____exports.GetIntelligence(self, parent)
	return math.max(0, MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0)
end
function ____exports.GetAllStats(self, parent)
	return ____exports.GetStrength(nil, parent)
		+ ____exports.GetAgility(nil, parent)
		+ ____exports.GetIntelligence(nil, parent)
end
function ____exports.GetTotalAttackDamage(self, parent)
	return math.max(0, MyGameAttribute:GetAttribute(parent, "total_attack_damage") or 0)
end
function ____exports.HasBleed(self, target)
	return not not target and IsValid(nil, target) and target:HasModifier("modifier_generic_bleed")
end
function ____exports.GetBleedStacks(self, target)
	return ____exports.HasBleed(nil, target) and 1 or 0
end
function ____exports.ConsumeBleedStacks(self, _target, _count)
	return 0
end
function ____exports.GetIceStacks(self, target)
	local modifier = target:FindModifierByName("modifier_generic_slow")
	return math.max(0, modifier and modifier:GetStackCount() or 0)
end
function ____exports.ConsumeIceStacks(self, target, count)
	if not IsServer() then
		return 0
	end
	local modifier = target:FindModifierByName("modifier_generic_slow")
	if not modifier then
		return 0
	end
	local currentStacks = math.max(0, modifier:GetStackCount())
	local consumeStacks = math.min(currentStacks, math.max(0, math.floor(count)))
	if consumeStacks <= 0 then
		return 0
	end
	local remainingStacks = currentStacks - consumeStacks
	if remainingStacks <= 0 then
		modifier:Destroy()
	else
		modifier:SetStackCount(remainingStacks)
	end
	return consumeStacks
end
function ____exports.FindEnemies(self, parent, origin, radius)
	return FindUnitsInRadius(
		parent:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
end
function ____exports.FindFriends(self, parent, origin, radius)
	return FindUnitsInRadius(
		parent:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
end
function ____exports.IsRealNonItemAbility(self, castAbility)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return false
	end
	local ____this_12
	____this_12 = castAbility
	local ____opt_11 = ____this_12.IsItem
	if ____opt_11 and ____opt_11(____this_12) then
		return false
	end
	local ____this_14
	____this_14 = castAbility
	local ____opt_13 = ____this_14.IsToggle
	if ____opt_13 and ____opt_13(____this_14) then
		return false
	end
	local ____this_16
	____this_16 = castAbility
	local ____opt_15 = ____this_16.GetBehaviorInt
	local behavior = ____opt_15 and ____opt_15(____this_16) or 0
	return bit.band(behavior, DOTA_ABILITY_BEHAVIOR_PASSIVE) == 0
end
function ____exports.ReduceCooldown(self, ability, ability_reduce_cooldown_sec)
	local remaining = ability:GetCooldownTimeRemaining()
	if remaining <= 0 then
		return
	end
	ability:EndCooldown()
	local nextCooldown = math.max(0, remaining - ability_reduce_cooldown_sec)
	if nextCooldown > 0 then
		ability:StartCooldown(nextCooldown)
	end
end
function ____exports.ReduceNonItemCooldowns(self, parent, ability_reduce_cooldown_sec, exceptAbility)
	if ability_reduce_cooldown_sec <= 0 then
		return
	end
	local abilityCount = parent:GetAbilityCount()
	do
		local i = 0
		while i < abilityCount do
			do
				local ability = parent:GetAbilityByIndex(i)
				if not ____exports.IsRealNonItemAbility(nil, ability) then
					goto __continue38
				end
				if exceptAbility and ability == exceptAbility then
					goto __continue38
				end
				____exports.ReduceCooldown(nil, ability, ability_reduce_cooldown_sec)
			end
			::__continue38::
			i = i + 1
		end
	end
end
function ____exports.IsOwnedByParentPlayer(self, attacker, parent)
	if not attacker or not IsValid(nil, attacker) or attacker:IsNull() then
		return false
	end
	local parentPlayerId = parent:GetPlayerOwnerID()
	if parentPlayerId >= 0 and attacker:GetPlayerOwnerID() == parentPlayerId then
		return true
	end
	if attacker == parent then
		return true
	end
	local owner = attacker:GetOwner()
	return not not owner and IsValid(nil, owner) and not owner:IsNull() and owner == parent
end
function ____exports.GetProjectileLaunchOrigin(self, caster)
	local attach = caster:ScriptLookupAttachment("attach_hitloc")
	if attach > 0 then
		return caster:GetAttachmentOrigin(attach)
	end
	return caster:GetAbsOrigin()
end
function ____exports.LaunchTrackingDamageProjectile(self, caster, ability, target, damage, effectName, burnDuration)
	local distance = math.max(1, caster:GetDistance(target))
	local projectileSpeed = distance / 0.35
	CreateProjectile(nil, {
		caster = caster,
		ability = ability,
		effect_name = effectName,
		target = target,
		start_point = ____exports.GetProjectileLaunchOrigin(nil, caster),
		projectile_type = "tracking",
		projectile_speed = projectileSpeed,
		on_hit = function(____, hitTarget)
			if not IsValidAlive(nil, caster) or not ____exports.IsValidEnemyUnit(nil, caster, hitTarget) then
				return true
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = hitTarget,
				damage = damage,
				damage_type = 2,
				ability = ability,
				extra_data = {
					custom_tag = "item_0419_solar_forge",
					source_name = ability:GetAbilityName(),
				},
			})
			if burnDuration and burnDuration > 0 then
				AddDeBuffStatus(nil, hitTarget, caster, ability, DebuffStatusType.BURN, { duration = burnDuration })
			end
			EmitSoundOn("Hero_Lina.ProjectileImpact", hitTarget)
			return true
		end,
	})
end
return ____exports