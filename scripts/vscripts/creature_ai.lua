--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function Spawn(entityKeyValues)
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

	if thisEntity:GetTeam() ~= DOTA_TEAM_NEUTRALS then
		return
	end

	--为主动技能 随机设置CD
	for i = 0, thisEntity:GetAbilityCount() - 1 do
		local hAbility = thisEntity:GetAbilityByIndex(i)
		if hAbility and hAbility.IsPassive then
			if not hAbility:IsPassive() then
				hAbility:StartCooldown(0.5)
				if hAbility:GetAbilityName() == "harpy_storm_chain_lightning_lua" then
					Timers:CreateTimer({
						endTime = 0.45,
						callback = function()
							if GetMapName() == "5v5" then
								hAbility:SetLevel(1)
							end
							if GetMapName() == "2x6" then
								hAbility:SetLevel(2)
							end
							if string.find(GetMapName(), "1x8") then
								hAbility:SetLevel(3)
							end
						end
					})
				end

				if hAbility:GetAbilityName() == "golem_anti_blademail" then
					Timers:CreateTimer({
						endTime = 0.45,
						callback = function()
							if thisEntity:GetUnitName() == "npc_dota_mud_golem" then
								hAbility:SetLevel(1)
							end
							if thisEntity:GetUnitName() == "npc_dota_rock_golem" then
								hAbility:SetLevel(2)
							end
							if thisEntity:GetUnitName() == "npc_dota_granite_golem" then
								hAbility:SetLevel(3)
							end
						end
					})
				end

			end
		end
	end

	thisEntity:SetContextThink("CreepThink", CreepThink, 0.5)
end

function CreepThink()

	--debug top
	local bResult, flResult = xpcall(
	function()
		--debug top

		if not thisEntity:IsAlive() then
			return
		end
		if GameRules:IsGamePaused() then
			return 0.1
		end

		--如果被寄生
		if thisEntity:HasAbility("life_stealer_consume") then
			local hInfest = thisEntity:FindAbilityByName("life_stealer_consume")
			if hInfest and hInfest:IsFullyCastable() then
				ExecuteOrderFromTable({
					UnitIndex = thisEntity:entindex(),
					OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
					AbilityIndex = hInfest:entindex(),
				})
			end
		end

		--如果正在施法，先等一等
		if thisEntity:IsChanneling() then
			return 0.1
		end

		local hTarget

		--如果有目标
		if IsValid(thisEntity.hTarget) and thisEntity.hTarget:IsAlive() and (not thisEntity.hTarget:IsUnselectable()) then
			hTarget = thisEntity.hTarget
		else
			local vEnemies = {}
			--如果有目标队伍，直奔目标队伍
			if thisEntity.nSpawnerTeamNumber ~= nil then
				vEnemies = FindUnitsInRadius(thisEntity.nSpawnerTeamNumber, thisEntity:GetOrigin(), nil, 2600, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)
			else
				vEnemies = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, thisEntity:GetOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)
			end

			--遍历敌对英雄
			for _, hEnemy in pairs(vEnemies) do
				if hEnemy and not hEnemy:IsNull() and hEnemy:IsAlive() and (not hEnemy:IsUnselectable()) then
					hTarget = hEnemy
					thisEntity.hTarget = hEnemy
					break
				end
			end

			--寻找最近的英雄目标
			if nil == hTarget then
				--找不到目标，A地板
				thisEntity.hTarget = nil
				if not thisEntity:IsAttacking() then
					ExecuteOrderFromTable({
						UnitIndex = thisEntity:entindex(),
						OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
						Position = thisEntity:GetOrigin()
					})
				end
				return 0.5
			end
		end

		local flAbilityCastTime = TryCastAbility(hTarget)
		--先放技能 其他操作下个循环再说
		if flAbilityCastTime then
			return flAbilityCastTime
		else
			if not thisEntity:IsAttacking() then
				ExecuteOrderFromTable({
					UnitIndex = thisEntity:entindex(),
					OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
					Position = hTarget:GetOrigin()
				})
			end
		end

		return 0.5

		--debug down
	end,
	function(e)
		print("-------------Error-------------")
		print(e)
		if RandomInt(1, 100) < 5 then
			Service:UploadError(e)
		end
	end)
	--debug down

	--如果出错，1秒后再次计算
	if bResult then
		return flResult
	else
		return 1
	end

end

------------------------------------------------------------------
--尝试释放技能
function TryCastAbility(hTarget)

	local flAbilityCastTime = CastAbility(hTarget)
	if flAbilityCastTime then
		return flAbilityCastTime
	end
	return nil

end

-------------------------------------------------------------------

--注意此处自定义技能GetBehavior返回 userdata
--原生技能 GetBehavior返回 number
function ContainsValue(sum, nValue)

	if type(sum) == "userdata" then
		sum = tonumber(tostring(sum))
	end

	if bit:_and(sum, nValue) == nValue then
		return true
	else
		return false
	end

end



-------------------------------------------------------------------

function CastAbility(hTarget)

	for i = 1, thisEntity:GetAbilityCount() - 1 do
		local hAbility = thisEntity:GetAbilityByIndex(i - 1)
		if hAbility and not hAbility:IsPassive() and hAbility:IsFullyCastable() and not hAbility:IsHidden() then
			--目标类技能 (法球不算)
			if ContainsValue(hAbility:GetBehavior(), DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) and not ContainsValue(hAbility:GetBehavior(), DOTA_ABILITY_BEHAVIOR_ATTACK) then
				--对敌人使用的目标技能
				if ContainsValue(hAbility:GetAbilityTargetTeam(), DOTA_UNIT_TARGET_TEAM_ENEMY) or ContainsValue(hAbility:GetAbilityTargetTeam(), DOTA_UNIT_TARGET_TEAM_CUSTOM) then
					ExecuteOrderFromTable({
						UnitIndex = thisEntity:entindex(),
						OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
						AbilityIndex = hAbility:entindex(),
						TargetIndex = hTarget:entindex()
					})
					return hAbility:GetCastPoint() + RandomFloat(0.1, 0.3)
				end
				-- 对自己释放的目标技能（此处忽略野怪之间互相buff）
				if ContainsValue(hAbility:GetAbilityTargetTeam(), DOTA_UNIT_TARGET_TEAM_FRIENDLY) then
					ExecuteOrderFromTable({
						UnitIndex = thisEntity:entindex(),
						OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
						AbilityIndex = hAbility:entindex(),
						TargetIndex = thisEntity:entindex()
					})
					return hAbility:GetCastPoint() + RandomFloat(0.1, 0.3)
				end
			end

			--点技能
			if HasBehavior(hAbility, DOTA_ABILITY_BEHAVIOR_POINT) then
				-- if ContainsValue(hAbility:GetBehavior(),DOTA_ABILITY_BEHAVIOR_POINT) then
				--伤害类技能 对敌人扔
				local vLeadingOffset = hTarget:GetForwardVector() * RandomInt(25, 75)
				local vTargetPos = hTarget:GetOrigin() + vLeadingOffset
				ExecuteOrderFromTable({
					UnitIndex = thisEntity:entindex(),
					OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
					Position = vTargetPos,
					AbilityIndex = hAbility:entindex(),
				})
				return hAbility:GetCastPoint() + RandomFloat(0.1, 0.3)
			end

			--无目标非切换技能 直接乱放
			if ContainsValue(hAbility:GetBehavior(), DOTA_ABILITY_BEHAVIOR_NO_TARGET) and not ContainsValue(hAbility:GetBehavior(), DOTA_ABILITY_BEHAVIOR_AUTOCAST) then

				ExecuteOrderFromTable({
					UnitIndex = thisEntity:entindex(),
					OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
					AbilityIndex = hAbility:entindex(),
				})
				return hAbility:GetCastPoint() + RandomFloat(0.1, 0.3)
			end

			--自动释放的技能，切换成自动释放
			if ContainsValue(hAbility:GetBehavior(), DOTA_ABILITY_BEHAVIOR_AUTOCAST) then
				if not hAbility:GetAutoCastState() then
					hAbility:ToggleAutoCast()
				end
			end
		end
	end

end

--------------------------------------------------------------------