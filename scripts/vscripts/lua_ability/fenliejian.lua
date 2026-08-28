--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


--多重箭函数
function DuoChongGongJi(keys)
	local caster = keys.caster
	local target = keys.target
	local attack_range = caster:Script_GetAttackRange()

	--只对远程有效
	if caster:IsRangedAttacker() then
		--获取攻击范围
		local radius = attack_range
		local teams = DOTA_UNIT_TARGET_TEAM_ENEMY
		local types = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING
		local flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NONE
		--获取周围的单位
		local group = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetOrigin(),
			nil,
			radius,
			teams,
			types,
			flags,
			FIND_CLOSEST,
			true
		)
		--获取箭的数量
		local attack_count = keys.attack_count or 0
		--获取箭的特效
		local attack_effect = caster:GetRangedProjectileName()
			or "particles/units/heroes/hero_lina/lina_base_attack.vpcf"
		local attack_unit = {}

		--筛选离英雄最近的敌人
		for i, unit in pairs(group) do
			if #attack_unit == attack_count then
				break
			end

			if unit ~= target then
				if unit:IsAlive() then
					if
						(GetMapName() ~= "gemtd_race" or caster:GetOwner():GetPlayerID() == unit.player)
						and caster:CanEntityBeSeenByMyTeam(unit)
					then
						table.insert(attack_unit, unit)
					end
				end
			end
		end

		for i, unit in pairs(attack_unit) do
			local info = {
				Target = unit,
				Source = caster,
				Ability = keys.ability,
				EffectName = attack_effect,
				bDodgeable = false,
				iMoveSpeed = caster:GetProjectileSpeed(),
				bProvidesVision = false,
				iVisionRadius = 0,
				iVisionTeamNumber = caster:GetTeamNumber(),
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
			}
			projectile = ProjectileManager:CreateTrackingProjectile(info)
		end
	end
end

function DuoChongGongJiDamage(keys)
	local caster = keys.caster
	local target = keys.target
	--获取攻击伤害
	local attack_damage = caster:GetAverageTrueAttackDamage(nil)
	local damageTable =
		{ victim = target, attacker = caster, damage_type = DAMAGE_TYPE_PHYSICAL, damage = attack_damage }
	ApplyDamage(damageTable)
end

--多重箭函数
function DuoChongGongJi_you(keys)
	local caster = keys.caster
	local target = keys.target
	local attack_range = caster:Script_GetAttackRange()

	--只对远程有效
	if caster:IsRangedAttacker() then
		--获取攻击范围
		local radius = attack_range --caster:GetAttackRange()
		local teams = DOTA_UNIT_TARGET_TEAM_ENEMY
		local types = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING
		local flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NONE
		--获取周围的单位
		local group = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetOrigin(),
			nil,
			radius,
			teams,
			types,
			flags,
			FIND_CLOSEST,
			true
		)
		--获取箭的数量
		local attack_count = keys.attack_count or 0
		--获取箭的特效
		local attack_effect = caster:GetRangedProjectileName()
			or "particles/units/heroes/hero_razor/razor_static_link_projectile_a.vpcf"
		local attack_unit = {}

		--筛选离英雄最近的敌人
		for i, unit in pairs(group) do
			if #attack_unit == attack_count then
				break
			end

			if unit ~= target then
				if unit:IsAlive() then
					if
						(GetMapName() ~= "gemtd_race" or caster:GetOwner():GetPlayerID() == unit.player)
						and caster:CanEntityBeSeenByMyTeam(unit)
					then
						table.insert(attack_unit, unit)
					end
				end
			end
		end

		for i, unit in pairs(attack_unit) do
			local info = {
				Target = unit,
				Source = caster,
				Ability = keys.ability,
				EffectName = attack_effect,
				bDodgeable = false,
				iMoveSpeed = caster:GetProjectileSpeed(),
				bProvidesVision = false,
				iVisionRadius = 0,
				iVisionTeamNumber = caster:GetTeamNumber(),
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
			}
			projectile = ProjectileManager:CreateTrackingProjectile(info)
		end
	end
end

function DuoChongGongJiDamage_you(keys)
	local caster = keys.caster
	local target = keys.target
	--获取攻击伤害
	local attack_damage = caster:GetAverageTrueAttackDamage(nil)
	local damageTable =
		{ victim = target, attacker = caster, damage_type = DAMAGE_TYPE_PHYSICAL, damage = attack_damage }
	ApplyDamage(damageTable)
end

function gemtd_hero_lianjie(keys)
	local damage = keys.damage
	local attacker = keys.attacker
	local caster = keys.caster

	local direUnits = FindUnitsInRadius(
		DOTA_TEAM_BADGUYS,
		keys.target:GetAbsOrigin(),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_FARTHEST,
		false
	)

	local unluckydog = nil
	for i, v in pairs(direUnits) do
		if v.player == nil or v.player == caster:GetPlayerID() then
			unluckydog = v
			break
		end
	end
	if unluckydog == nil then
		return
	end
	if unluckydog:GetEntityIndex() == keys.target:GetEntityIndex() then
		return
	end

	-- local info =
	-- {
	--     Target = unluckydog,
	--     Source = keys.target,
	--     Ability = nil,
	--     EffectName = "particles/units/heroes/hero_warlock/warlock_fatal_bonds_base.vpcf",
	--     bDodgeable = false,
	--     iMoveSpeed = 3000,
	--     bProvidesVision = false,
	--     iVisionRadius = 0,
	--     iVisionTeamNumber = keys.target:GetTeamNumber(),
	--     iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
	-- }
	-- projectile = ProjectileManager:CreateTrackingProjectile(info)

	local p = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_warlock/warlock_fatal_bonds_base.vpcf",
		PATTACH_CUSTOMORIGIN,
		keys.target
	)
	ParticleManager:SetParticleControlEnt(p, 0, keys.target, 5, "attach_hitloc", keys.target:GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(p, 1, unluckydog, 5, "attach_hitloc", unluckydog:GetOrigin(), true)
	Timers:CreateTimer(0.5, function()
		ParticleManager:DestroyParticle(p, true)
	end)

	local ability_level = caster:FindAbilityByName("gemtd_hero_lianjie"):GetLevel()

	damage = damage * (ability_level * 0.1 + 0.6)

	local distance = (attacker:GetAbsOrigin() - unluckydog:GetAbsOrigin()):Length2D()
	local beishu = math.floor(distance / 400) * 0.1 + 1

	damage = damage * beishu

	--获取攻击伤害
	local damageTable = {
		victim = unluckydog,
		attacker = attacker,
		damage_type = DAMAGE_TYPE_PURE,
		damage = damage,
	}
	ApplyDamage(damageTable)
end

function Blink(keys)
	local caster = keys.caster
	local p = keys.target_points[1] or caster.target_position

	caster:SetAbsOrigin(p)
end