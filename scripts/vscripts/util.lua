--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Util == nil then Util = class({}) end

LinkLuaModifier("modifier_hero_refreshing", "heroes/modifier_hero_refreshing", LUA_MODIFIER_MOTION_NONE)

--将英雄 移动到地图中间的方块
function Util:MoveHeroToCenter(nPlayerID, bPVPend)
	bPVPend = bPVPend or false
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	local nTeamNumber = hHero:GetTeamNumber()
	local vTargetLocation = GameMode.vTeamStartLocationMap[nTeamNumber]

	local hObservingTarget = Util:ChooseObservingTarget(nPlayerID)
	if PlayerResource:GetConnectionState(nPlayerID) ~= DOTA_CONNECTION_STATE_ABANDONED then
		if not hHero:IsAlive() then
			hHero:RespawnHero(false, false)
			hHero:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
		end
	end

	Util:MoveHeroToLocation(nPlayerID, vTargetLocation, hObservingTarget, "prepare", bPVPend)
end

function IsValid(h)
	return h ~= nil and h.IsNull ~= nil and not h:IsNull()
end

function Util:ChooseObservingTarget(nPlayerID)
	-- 如果5v5并且 单人PVP未结束
	if GetMapName() == "5v5" and GameMode.autoDuelMap[nPlayerID] and (not PvpModule.bEnd) then
		for _, nPvpPlayerID in ipairs(PvpModule.currentSinglePair) do
			--观战本队玩家
			if PlayerResource:GetTeam(nPvpPlayerID) == PlayerResource:GetTeam(nPlayerID) then
				local hTempTargetHero = PlayerResource:GetSelectedHeroEntity(nPvpPlayerID)
				if hTempTargetHero and (hTempTargetHero:IsAlive() or hTempTargetHero:IsReincarnating()) then
					return hTempTargetHero
				end
			end
		end
	end


	--观战PVP区域
	if PvpModule.nHomeTeamID and GameMode.autoDuelMap[nPlayerID] and (not PvpModule.bEnd) then
		for i = 1, PlayerResource:GetPlayerCountForTeam(PvpModule.nHomeTeamID) do
			local nTempPlayerID = PlayerResource:GetNthPlayerIDOnTeam(PvpModule.nHomeTeamID, i)
			local hTempTargetHero = PlayerResource:GetSelectedHeroEntity(nTempPlayerID)
			if hTempTargetHero and (hTempTargetHero:IsAlive() or hTempTargetHero:IsReincarnating()) then
				return hTempTargetHero
			end
		end
	end

	--观看PVE区域
	if GameMode.autoCreepMap[nPlayerID] and GameMode.currentRound and (not GameMode.currentRound.bEnd) then
		local nKillProgress = 100
		local nTargetTeamNumber

		--挑选一个进度最慢的队伍
		for nTeamNumber, bAlive in pairs(GameMode.vAliveTeam) do
			if bAlive and GameMode.currentRound.spanwers[nTeamNumber] and false == GameMode.currentRound.spanwers[nTeamNumber].bProgressFinished then
				if nKillProgress > GameMode.currentRound.spanwers[nTeamNumber].nKillProgress then
					nTargetTeamNumber = nTeamNumber
				end
			end
		end
		if nTargetTeamNumber then
			for i = 1, PlayerResource:GetPlayerCountForTeam(nTargetTeamNumber) do
				local nPlayerID = PlayerResource:GetNthPlayerIDOnTeam(nTargetTeamNumber, i)
				local hTempTargetHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				if hTempTargetHero and (hTempTargetHero:IsAlive() or hTempTargetHero:IsReincarnating()) then
					return hTempTargetHero
				end
			end
		end
	end

	-- 没得可看就看自己
	return PlayerResource:GetSelectedHeroEntity(nPlayerID)
end

--将英雄 移动到指定地点
function Util:MoveHeroToLocation(nPlayerID, vLocation, hObservingTarget, sRoomName, bPVPend)
	bPVPend = bPVPend or false
	local units = {}
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	if hHero then
		--清理一下妨碍传送的Modifier
		--ListModifiers(hHero)
		Util:RemoveMovemenModifier(hHero)

		local iStartPtx
		if Econ.vPlayerData[nPlayerID] and Econ.vPlayerData[nPlayerID].sCurrentStartBlinkEffect then
			iStartPtx = ParticleManager:CreateParticle(Econ.vPlayerData[nPlayerID].sCurrentStartBlinkEffect, PATTACH_ABSORIGIN, hHero)
			ParticleManager:SetParticleControl(iStartPtx, 0, hHero:GetAbsOrigin())
			ParticleManager:SetParticleControl(iStartPtx, 1, hHero:GetAbsOrigin())
		else
			iStartPtx = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, hHero)
		end

		--		if Util.supposedLocations==nil then
		--		 Util.supposedLocations = {}
		--		end

		--  Util.supposedLocations[nPlayerID] = vLocation

		if Util.supposedRooms == nil then
			Util.supposedRooms = {}
		end

		Util.supposedRooms[nPlayerID] = sRoomName or "prepare"
		--预先记录周围的召唤物
		units = FindUnitsInRadius(PlayerResource:GetTeam(nPlayerID), hHero:GetAbsOrigin(), nil, 4000,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_DEAD,
			FIND_ANY_ORDER, false)
		FindClearSpaceForUnit(hHero, vLocation, true)

		local iEndPtx
		if Econ.vPlayerData[nPlayerID] and Econ.vPlayerData[nPlayerID].sCurrentEndBlinkEffect then
			iEndPtx = ParticleManager:CreateParticle(Econ.vPlayerData[nPlayerID].sCurrentEndBlinkEffect, PATTACH_ABSORIGIN_FOLLOW,
				hHero)
			ParticleManager:SetParticleControl(iEndPtx, 0, hHero:GetAbsOrigin())
			ParticleManager:SetParticleControl(iStartPtx, 1, hHero:GetAbsOrigin())
		else
			iEndPtx = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, hHero)
		end

		hHero:EmitSound("DOTA_Item.BlinkDagger.Activate")

		--如果没有穿指定的单位，镜头定位给英雄即可
		if hObservingTarget == nil then
			hObservingTarget = hHero
		end

		-- CenterCameraOnUnit(nPlayerID, hObservingTarget)
		PlayerResource:SetCameraTarget(nPlayerID, hObservingTarget)

		TimerManager:Timer(2, function()
			if iEndPtx then 
				ParticleManager:DestroyParticle(iEndPtx, true) 
				ParticleManager:ReleaseParticleIndex(iEndPtx)
			end
			if iStartPtx then 
				ParticleManager:DestroyParticle(iStartPtx, true) 
				ParticleManager:ReleaseParticleIndex(iStartPtx)
			end
		end)


		Timers:CreateTimer({
			endTime = 0.3,
			callback = function()
				PlayerResource:SetCameraTarget(nPlayerID, nil)
			end
		})
	end


	for _, unit in pairs(units) do
		if IsValid(unit) and unit:IsAlive() and unit ~= hHero and unit:GetPlayerOwnerID() == nPlayerID and unit:GetUnitName() ~= "npc_dummy_cosmetic_caster" then
			--宙斯雷云不要跟着移动
			if unit:HasMovementCapability() then
				--多重施法幻象在移动时销毁
				if unit:HasModifier("modifier_ogre_multicast_lua_bonus") then
					unit:ForceKill(false)
				else
					FindClearSpaceForUnit(unit, vLocation, true)
					if sRoomName == nil or sRoomName == "prepare" then
						unit:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
					else
						unit:RemoveModifierByName("modifier_hero_refreshing")
					end
					--刷新技能与物品
					if bPVPend then
						Util:RefreshAbilityAndItem(unit, {})
					end
				end
			end
		end
	end
end

--刷新技能与物品
function Util:RefreshAbilityAndItem(hHero, exceptions)
	if exceptions == nil then
		exceptions = {}
	end

	if not IsValid(hHero) then
		return
	end

	for i = 0, hHero:GetAbilityCount() - 1 do
		local hAbility = hHero:GetAbilityByIndex(i)
		if hAbility and hAbility:GetAbilityType() ~= DOTA_ABILITY_TYPE_ATTRIBUTES then
			if exceptions[hAbility:GetAbilityName()] == nil then
				hAbility:RefreshCharges()
				hAbility:EndCooldown()
			end
		end
	end

	for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_NEUTRAL_SLOT do
		local hItem = hHero:GetItemInSlot(i)
		if hItem then
			hItem:EndCooldown()
		end
	end

	local neutralItem = hHero:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)
	if neutralItem ~= nil then
		neutralItem:EndCooldown()
	end
end

-- 清理数据
function Util:CleanPvpPair(nTeamNumber)
	local i, max = 1, #PvpModule.pvpPairs
	while i <= max do
		local pair = PvpModule.pvpPairs[i]
		if nTeamNumber == pair.nFirstTeamId or nTeamNumber == pair.nSecondeTeamId then
			table.remove(PvpModule.pvpPairs, i)
			i = i - 1
			max = max - 1
		end
		i = i + 1
	end
	return PvpModule.pvpPairs
end

-- 清理影响传送的Modifier
function Util:RemoveMovemenModifier(hHero)
	--爆破起飞
	hHero:Stop()
	hHero:RemoveModifierByName("modifier_magnataur_skewer_movement")
	hHero:RemoveModifierByName("modifier_phoenix_icarus_dive")
	hHero:RemoveModifierByName("modifier_mirana_leap")
	hHero:RemoveModifierByName("modifier_kunkka_x_marks_the_spot")
	hHero:RemoveModifierByName("modifier_kunkka_x_marks_the_spot_thinker")
	hHero:RemoveModifierByName("modifier_riki_tricks_of_the_trade_phase")
	hHero:RemoveModifierByName("modifier_monkey_king_bounce_perch")
	hHero:RemoveModifierByName("modifier_void_spirit_dissimilate_phase")
	hHero:RemoveModifierByName("modifier_monkey_king_bounce_leap")
	hHero:RemoveModifierByName("modifier_monkey_king_tree_dance_activity")
	hHero:RemoveModifierByName("modifier_sandking_burrowstrike")
	hHero:RemoveModifierByName("modifier_phantomlancer_dopplewalk_phase")
	hHero:RemoveModifierByName("modifier_life_stealer_infest")
	hHero:RemoveModifierByName("modifier_phoenix_sun_ray")
	hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_in_progress")
	hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_caster")
	hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_caster_invulnerability")

	--虚妄之诺 回泉水不回血的问题
	if hHero:HasModifier("modifier_oracle_false_promise") then
		--略微延迟一下再移除，防止飞尸
		Timers:CreateTimer(1,
			function()
				hHero:RemoveModifierByName("modifier_oracle_false_promise")
			end
		)
	end

	hHero:RemoveModifierByName("modifier_brewmaster_primal_split")
	hHero:RemoveModifierByName("modifier_invoker_tornado_lua")


	if hHero:HasAbility("puck_ethereal_jaunt") then
		hHero:FindAbilityByName("puck_ethereal_jaunt"):SetActivated(false)
		--三秒后放开
		Timers:CreateTimer({
			endTime = 3,
			callback = function()
				if hHero:HasAbility("puck_ethereal_jaunt") then
					hHero:FindAbilityByName("puck_ethereal_jaunt"):SetActivated(true)
				end
			end
		})
	end

	if hHero:HasModifier("modifier_ember_spirit_fire_remnant_remnant_tracker") then
		hHero:RemoveModifierByName("modifier_ember_spirit_fire_remnant_timer")
		hHero:RemoveModifierByName("modifier_ember_spirit_fire_remnant_remnant_tracker")
		hHero:AddNewModifier(hHero, hHero:FindAbilityByName("ember_spirit_fire_remnant"),
			"modifier_ember_spirit_fire_remnant_remnant_tracker", {})
	end

	if hHero:HasModifier("modifier_weaver_timelapse") then
		hHero:RemoveModifierByName("modifier_weaver_timelapse")
		hHero:AddNewModifier(hHero, hHero:FindAbilityByName("weaver_time_lapse"), "modifier_weaver_timelapse", {})
	end
end

function Util:RemoveAbilityClean(hHero, sAbilityName)
	if sAbilityName == "broodmother_spin_web" then
		Util:CleanWeb(hHero)
	end

	if sAbilityName == "witch_doctor_death_ward" then
		Util:CleanDeathWard(hHero)
	end

	if sAbilityName == "visage_summon_familiars" then
		Util:CleanFamiliar(hHero)
	end
end

--清理蜘蛛网
function Util:CleanWeb(hHero)
	-- 清理蜘蛛网
	local vWebs = Entities:FindAllByName("npc_dota_broodmother_web")
	for _, hWeb in pairs(vWebs) do
		if hWeb:GetOwner() == hHero then
			UTIL_Remove(hWeb)
		end
	end
end

--清理死亡守卫
function Util:CleanDeathWard(hHero)
	local vWards = Entities:FindAllByName("npc_dota_witch_doctor_death_ward")
	for _, vWard in pairs(vWards) do
		if vWard:GetOwner() == hHero then
			UTIL_Remove(vWard)
		end
	end
end

--清理佣兽
function Util:CleanFamiliar(hHero)
	local vFamiliars = Entities:FindAllByName("npc_dota_visage_familiar")
	for _, hFamiliar in pairs(vFamiliars) do
		if hFamiliar:GetOwner() == hHero then
			hFamiliar:ForceKill(false)
		end
	end
end

--判断是否触发重生
function Util:IsReincarnationWork(hHero)
	-- modifier_skeleton_king_reincarnation_scepter_active
	-- modifier_skeleton_king_reincarnation_scepter_respawn_time

	local bSkeletonKingReincarnationWork = false
	if hHero:HasAbility("skeleton_king_reincarnation") then
		local hAbility = hHero:FindAbilityByName("skeleton_king_reincarnation")
		if hAbility:GetLevel() > 0 then
			--刚刚触发
			if hAbility:GetCooldownTimeRemaining() == hAbility:GetEffectiveCooldown(hAbility:GetLevel() - 1) then
				bSkeletonKingReincarnationWork = true
			end
		end
	end

	local bUndyingReincarnationWork = false
	if hHero:HasModifier("modifier_special_bonus_reincarnation") then
		local hModifier = hHero:FindModifierByName("modifier_special_bonus_reincarnation")
		if hModifier:GetElapsedTime() < FrameTime() then
			bUndyingReincarnationWork = true
		end
	end

	return bSkeletonKingReincarnationWork or bUndyingReincarnationWork
end

--统计英雄数据

function Util:GenerateHeroInfo(nPlayerID)
	local heroInfo = {}
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)

	if hHero then
		local sAbilities = ""
		if hHero.abilitiesList then
			for _, sAbilityName in ipairs(hHero.abilitiesList) do
				sAbilities = sAbilities .. sAbilityName .. ","
			end
		end

		if string.sub(sAbilities, string.len(sAbilities)) == "," then --去掉最后一个逗号
			sAbilities = string.sub(sAbilities, 0, string.len(sAbilities) - 1)
		end

		--如果记录过消耗品
		local sItems = ""
		if hHero.sConsumedItems then
			sItems = hHero.sConsumedItems
		end

		for i = 0, 20 do --遍历物品
			local hItem = hHero:GetItemInSlot(i)
			if hItem then
				sItems = sItems .. hItem:GetName() .. ","
			end
		end

		if string.sub(sItems, string.len(sItems)) == "," then --去掉最后一个逗号
			sItems = string.sub(sItems, 0, string.len(sItems) - 1)
		end

		heroInfo.hero_name = hHero:GetUnitName()
		heroInfo.abilities = sAbilities
		heroInfo.items = sItems
	end


	return heroInfo
end

function CDOTA_BaseNPC:AddEndChannelListener(listener)
	local endChannelListeners = self.EndChannelListeners or {}
	self.EndChannelListeners = endChannelListeners
	local index = #endChannelListeners + 1
	endChannelListeners[index] = listener
end

--杀死全地图的猴子猴孙
function Util:CleanFurArmySoldier()
	Timers:CreateTimer({
		endTime = 0.5,
		callback = function()
			local units = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, Vector(0, 0, 0), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_ALL,
				DOTA_UNIT_TARGET_FLAG_DEAD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES +
				DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)
			for _, hUnit in ipairs(units) do
				if hUnit and not hUnit:IsNull() and (hUnit:HasModifier("modifier_monkey_king_fur_army_soldier") or hUnit:HasModifier("modifier_monkey_king_fur_army_soldier_hidden")) then
					--print("Killing"..hUnit:GetUnitName())
					hUnit:ForceKill(false)
					UTIL_Remove(hUnit)
				end
			end
		end
	})
end

function Util:RecordConsumableItem(nPlayerID, sItemName)
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	if hHero then
		--记录玩家使用的一次性道具
		if hHero.sConsumedItems == nil then
			hHero.sConsumedItems = ""
		end
		hHero.sConsumedItems = hHero.sConsumedItems .. sItemName .. ","
	end
end

function Util:GetBotEarnedGold(nPlayerID)
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	if hHero then
		if GameRules.nGameStartTime then
			local nGold = math.ceil(PlayerResource:GetGoldPerMin(nPlayerID) *
			(GameRules:GetGameTime() - GameRules.nGameStartTime) / 60) + 600 - PvpModule.betValueSum[nPlayerID]
			return nGold
		end
	end
	return 600
end

--电子围栏，循环判断玩家位置是否正确 不正确进行传送
function Util:InitHeroFence()
	Util.flFenceRadius = 3000
	if GetMapName() == "5v5" then
		Util.flFenceRadius = 4100
	end

	--		Util.supposedLocations = {}

	--		Timers:CreateTimer({ endTime = 0.1,
	--				callback = function()
	--				 for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS do
	--						 local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
	--						 if hHero then
	--								 --Util.supposedLocations[nPlayerID] 英雄应该在的位置
	--								 if Util.supposedLocations[nPlayerID] then
	--										 local flDistance = (hHero:GetOrigin() - Util.supposedLocations[nPlayerID]):Length()
	--										 if flDistance>Util.flFenceRadius then
	--												 FindClearSpaceForUnit(hHero, Util.supposedLocations[nPlayerID], false)
	--										 end
	--										 --如果有风暴双雄
	--										 if hHero.tempest_double_hClone and hHero.tempest_double_hClone:HasModifier("modifier_tempest_double_illusion") then
	--												local flTempestDoubleDistance = (hHero.tempest_double_hClone:GetOrigin() - Util.supposedLocations[nPlayerID]):Length()
	--												if flTempestDoubleDistance>Util.flFenceRadius then
	--														FindClearSpaceForUnit(hHero.tempest_double_hClone, Util.supposedLocations[nPlayerID], false)
	--												end
	--										 end
	--								 end
	--						 end
	--				  end
	--				  return 0.25
	--				end
	--		})
end

--将当前时间转化为可读的时间戳
function Util:GetServerDateTimeStr()
	local strDate = GetSystemDate() .. " " .. GetSystemTime()
	local _, _, m, d, y, hour, min, sec = string.find(strDate, "(%d+)/(%d+)/(%d+)%s*(%d+):(%d+):(%d+)");
	--转化为时间戳
	return (y .. m .. d .. hour .. min .. sec)
end

--叉乘计算
function Util:GetCross(p1, p2)
	return p1.x * p2.y - p2.x * p1.y
end

--点乘计算
function Util:GetDotProduct(p1, p2)
	return p1.x * p2.x + p1.y * p2.y
end

--判断点p在矩形内，顺序传入左上， 左下， 右上， 右下
function Util:IsPointInsideRectangle(p, lu, ld, ru, rd)
	return (Util:GetCross(ru - lu, p - lu) * Util:GetCross(ld - rd, p - rd) >= 0) and
	(Util:GetCross(lu - ld, p - ld) * Util:GetCross(rd - ru, p - ru) >= 0)
end

function Util:GetSupposeRoom(hUnit)
	if hUnit == nil then
		return "prepare"
	end

	if Util.supposedRooms == nil then
		Util.supposedRooms = {}
		Util.supposedRooms[hUnit:GetPlayerOwnerID()] = "prepare"
	end
	return Util.supposedRooms[hUnit:GetPlayerOwnerID()] or "prepare"
end

function Util:GetRoomCenter(sRoomName)
	sRoomName = sRoomName or "prepare"
	local suppose_pos = nil
	if sRoomName == "prepare" then
		suppose_pos = (Entities:FindByName(nil, "prepare")):GetAbsOrigin()
	else
		suppose_pos = (Entities:FindByName(nil, sRoomName)):GetAbsOrigin()
	end


	return suppose_pos
end

function Util:IsEscaping(hUnit, vPos)
	vPos = vPos or hUnit:GetAbsOrigin()

	if hUnit:IsRealHero() then
		return not Util:IsInRoom(hUnit, nil, vPos)
	else
		return not (Util:IsInRoom(hUnit, "prepare", vPos) or Util:IsInRoom(hUnit, "center_" .. hUnit:GetTeamNumber(), vPos) or Util:IsInRoom(hUnit, nil, vPos))
	end

	--9.17GridNav计算卡顿严重，改用判断点在矩形内实现
	-- if not GridNav:CanFindPath(suppose_pos, vPos) then
	--		 if LastPos ~= nil then
	--				 local try_dir = (vPos - LastPos):Normalized()
	--				 local new_pos = try_dir + vPos
	--				 for i = 1, 1000, 1 do
	--						 new_pos = try_dir + new_pos
	--						 if GridNav:CanFindPath(suppose_pos, new_pos) then
	--								 return false
	--						 elseif #GridNav:GetAllTreesAroundPoint(new_pos, 50, true) > 0 then
	--								 local tree = GridNav:GetAllTreesAroundPoint(new_pos, 50, true)[1]
	--								 local tree_dir = (tree:GetAbsOrigin() - hUnit:GetAbsOrigin()):Length2D()
	--								 for i = -200, 200, 1 do
	--										 local tree_try_pos = new_pos + tree_dir * i
	--										 if GridNav:CanFindPath(suppose_pos, tree_try_pos) then
	--												 return false
	--										 end
	--								 end
	--								 return true
	--						 end
	--				 end
	--				 return true
	--		 else
	--				 return true
	--		 end
	-- end
	-- return false
end

function Util:IsInRoom(hUnit, sRoomName, vPos)
	sRoomName = sRoomName or Util:GetSupposeRoom(hUnit)
	vPos = vPos or hUnit:GetAbsOrigin()
	local suppose_pos = Util:GetRoomCenter(sRoomName)
	local mapName = GetMapName()
	local RoomWidths = {
		["1x8"] = {
			center_2 = 1824,
			center_3 = 1824,
			center_4 = 1824,
			center_5 = 1824,
			center_6 = 1824,
			center_7 = 1824,
			center_8 = 1824,
			center_9 = 1824,
			prepare = 2750,
		},
		["2x6"] = {
			enter_2 = 2240,
			center_3 = 2240,
			-- center_4 = 1824,
			-- center_5 = 1824,
			center_6 = 2240,
			center_7 = 2240,
			center_8 = 2240,
			center_9 = 2240,
			prepare = 2600,
		},
		["5v5"] = {
			center_single_pvp = 1792,
			center_2 = 3500,
			center_3 = 3500,
			center_4 = 3640,
			prepare = 3600,
		},
	}

	local range = (RoomWidths[mapName][sRoomName] or 1824) * 0.5

	local point_lu = suppose_pos + Vector(-range, range, 0)
	local point_ld = suppose_pos + Vector(-range, -range, 0)
	local point_ru = suppose_pos + Vector(range, range, 0)
	local point_rd = suppose_pos + Vector(range, -range, 0)

	return Util:IsPointInsideRectangle(vPos, point_lu, point_ld, point_ru, point_rd)
end

--获取剩余玩家数量，剔除放弃的玩家
function Util:GetActivePlayerCount()
	local count = 0
	for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(i) and PlayerResource:GetConnectionState(i) ~= DOTA_CONNECTION_STATE_ABANDONED then
			count = count + 1
		end
	end
	return count
end

--获取玩家财产总和
function Util:GetTotalGoldForPlayer(nPlayerID)
	if PlayersGold == nil then
		_G.PlayersGold = {}
	end
	if PlayersGold[nPlayerID] == nil then
		PlayersGold[nPlayerID] = 600
	end
	return PlayersGold[nPlayerID] or 0
	-- return (math.ceil(PlayerResource:GetGoldPerMin(nPlayerID) * (GameRules:GetGameTime() - GameRules.nGameStartTime) / 60) + 600 - PvpModule.betValueSum[nPlayerID]) or 0
end

--获取弹射目标
function Util:GetBounceTarget(last_target, team_number, position, radius, team_filter, type_filter, flag_filter, order,
							  unit_table, can_bounce_bounced_unit)
	local first_targets = FindUnitsInRadius(team_number, position, nil, radius, team_filter, type_filter, flag_filter,
		order, false)

	for i = #first_targets, 1, -1 do
		local unit = first_targets[i]
		if unit == last_target then
			table.remove(first_targets, i)
		end
	end

	local second_targets = {}
	for k, v in pairs(first_targets) do
		second_targets[k] = v
	end

	if unit_table and type(unit_table) == "table" then
		for i = #first_targets, 1, -1 do
			if TableFindKey(unit_table, first_targets[i]) then
				table.remove(first_targets, i)
			end
		end
	end

	local first_target = first_targets[1]
	local second_target = second_targets[1]

	if can_bounce_bounced_unit ~= nil and type(can_bounce_bounced_unit) == "boolean" and can_bounce_bounced_unit == true then
		return first_target or second_target
	else
		return first_target
	end
end

--判断技能是否是可选到的技能
function Util:IsValidAbility(sAbilityName, bOnlyRemovable)
	local replaceAbilityList = {
		"life_stealer_unfettered",
		"disruptor_kinetic_fence",
		"faceless_void_time_zone",
		"jakiro_liquid_ice",
	}
	local bFound = false
	for _, sName in ipairs(replaceAbilityList) do
		if sName == sAbilityName then
			return true
		end
	end
	for _, sName in pairs(HeroBuilder.allAbilityNames) do
		if sName == sAbilityName then
			return true
		end
	end
	if not bFound then
		return false
	end
	if bOnlyRemovable then
		--判断能否遗忘
		local bRemoveable = (unremovableAbilities[sAbilityName] == nil)

		return bRemoveable
	else
		return bFound
	end
end

--获取玩家拥有的可选到的技能数量
function Util:GetPlayerAbilityCount(nPlayerID)
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)

	if IsValid(hHero) then
		if hHero.abilitiesList ~= nil then
			return #hHero.abilitiesList
		else
			return 0
		end
	else
		return 6
	end
end

--获取玩家技能栏上的可选技能个数
function Util:GetPlayerAbilityCountOnBar(nPlayerID)
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)

	if IsValid(hHero) then
		local abilitylist = {}
		for i = 0, hHero:GetAbilityCount() - 1 do
			local ability = hHero:GetAbilityByIndex(i)
			if ability ~= nil and (not ability:IsHidden()) and Util:IsValidAbility(ability:GetAbilityName(), false) and string.find(ability:GetAbilityName(), "special_bonus_") == nil then
				table.insert(abilitylist, { ability_name = ability:GetAbilityName() })
			end
		end
		return #abilitylist
	else
		return 6
	end
end

--获取玩家技能栏上的可选技能个数
function Util:GetPlayerAllAbility(nPlayerID)
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)

	if IsValid(hHero) then
		local abilitylist = {}
		for i = 0, hHero:GetAbilityCount() - 1 do
			local ability = hHero:GetAbilityByIndex(i)
			if ability ~= nil and Util:IsValidAbility(ability:GetAbilityName(), false) and string.find(ability:GetAbilityName(), "special_bonus_") == nil then
				table.insert(abilitylist, ability:GetAbilityName())
			end
		end
		return abilitylist
	else
		return {}
	end
end

--获取玩家当前额外赏金层数
function Util:GetPlayerBonusGoldPercentage(iPlayerID)
	local pct = 0
	local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
	if IsValid(hHero) then
		if hHero:HasModifier("modifier_relief_fund") then
			local stack = hHero:FindModifierByName("modifier_relief_fund"):GetStackCount() or 0
			pct = pct + stack * 8
		end
	end
	return pct
end

--判断技能是否在技能池中
function Util:IsAbilityInPool(AbilityName)
	for _, Name in pairs(HeroBuilder.allAbilityNames) do
		if Name == AbilityName then
			return true
		end
	end
	return false
end

--判断技能是否有某个behavior
function HasBehavior(ability, behavior)
	local abilityBehavior = tonumber(tostring(ability:GetBehavior()))
	return (bit.band(abilityBehavior, behavior) == behavior)
end

function GetSteamID(nPlayerID)
	local sPlayerSteamId = tostring(PlayerResource:GetSteamAccountID(nPlayerID))
	-- 测试默认下，为玩家添加随机ID
	if sPlayerSteamId == "0" then
		sPlayerSteamId = tostring(80000000 + nPlayerID)
	end
	return sPlayerSteamId
end

function CDOTA_PlayerResource:GetRealPlayerCount()
	local count = 0
	for iPlayerID = 0, CHC_MAX_PLAYER_COUNT - 1 do
		if PlayerResource:IsValidPlayerID(iPlayerID) then
			if not PlayerResource:IsFakeClient(iPlayerID) then
				count = count + 1
			end
		end
	end
	return count
end