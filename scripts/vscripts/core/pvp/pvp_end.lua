--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Завершить PvP-сражение для команд
---@param winnerTeamId integer
---@param loserTeamId integer
function PvpModule:EndPvp(winnerTeamId, loserTeamId)
    self:RefreshTeamHero(winnerTeamId)
    self:RefreshTeamHero(loserTeamId)

    if self.IsPvpEnd then return end
    logger:Log(string.format("END PVP. Winner = %d, Loser = %d", winnerTeamId, loserTeamId))

    self:KillSummonedCreatureAsyn(self.homeCenterVector)

    self:CompensateTeamExp(winnerTeamId)
    self:CompensateTeamExp(loserTeamId)

    self.IsPvpEnd = true

    self:PlayWinnerTeamEffect(winnerTeamId)

    Timers:CreateTimer({
        endTime = 3.6,
        callback = function()
            if GameMode:GetMatchType() == "PVP_SOLO" then
                if GameMode.place and GameMode.place <= 3 and (GameMode.validTeamNumber >= 5 or IsInToolsMode()) then
                    self:PunishLoser(loserTeamId)
                end
            end
            if GameMode:GetMatchType() == "PVP_DUO" then
                if GameMode.place and GameMode.place <= 2 and (GameMode.validTeamNumber >= 4 or IsInToolsMode()) then
                    self:PunishLoser(loserTeamId)
                end
            end
            return nil
        end
    })

    local pool = 0
    for _, teamId in ipairs({ winnerTeamId, loserTeamId }) do
        local list = self.betMap[teamId]
        if list then
            for _, data in ipairs(list) do
                if data and data.nValue then
                    pool = pool + data.nValue
                end
            end
        end
    end

    self:GrantBetBonus(winnerTeamId, loserTeamId, pool)

    for _, data in ipairs(self.betMap[loserTeamId] or {}) do
        if data and data.nPlayerId and data.flRatio and data.nValue then
            self:RecordBetHistory(data.nPlayerId, (-1 * data.nValue), winnerTeamId, loserTeamId, data.nValue, 0, pool)
        end
    end

    self:RecordWinner(winnerTeamId)
    self:RecordLoser(loserTeamId)

    for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        local records = self.PvpRecord[nPlayerID]
        if not (#records.bet_history == 0 and records.win == 0 and records.lose == 0 and records.total_bet_reward == 0) then
            CustomNetTables:SetTableValue("pvp_record", tostring(nPlayerID), records)
        end
    end

    CustomGameEventManager:Send_ServerToAllClients("TeamWin", {
        winnerTeamID = winnerTeamId,
        loserTeamID = loserTeamId
    });
end

---Выдать награды за сделанные ставки
---@param winnerTeamId integer
---@param loserTeamId integer
---@param pool integer сумма всех ставок в раунде (обе команды); прокидывается в RecordBetHistory
function PvpModule:GrantBetBonus(winnerTeamId, loserTeamId, pool)
    for _, data in ipairs(self.betMap[winnerTeamId] or {}) do
        if not data or not data.nPlayerId or not data.flRatio then
            goto continue
        end

        local playerId = data.nPlayerId
        local flRatio = data.flRatio

        local bonusGoldCount = math.floor(self.BaseBetBonus * flRatio)

        local barrageData = {
            playerId = playerId,
            type = "bet_win"
        }

        if data.sType and "pvp_free" == data.sType then
            if flRatio >= 0.99 then
                barrageData.type = "bet_jackpot"
            else
                barrageData.type = "pvp_win"
                bonusGoldCount = bonusGoldCount + math.floor(self.BaseBetBonus * 0.15)
            end
            self:RewardWinnerBonus(playerId, bonusGoldCount)
        else
            self:RewardBetBonus(playerId, bonusGoldCount)
        end

        local grossWinnings = math.ceil(bonusGoldCount * (100 + Util:GetPlayerBonusGoldPercentage(playerId)) * 0.01)
        barrageData.gold_value = grossWinnings

        Barrage:FireBullet(barrageData)

        self:SumBetReward(playerId, grossWinnings)

        local multiplier = data.nValue > 0 and (grossWinnings / data.nValue) or 0
        self:RecordBetHistory(
            playerId,
            grossWinnings - data.nValue,
            winnerTeamId,
            loserTeamId,
            data.nValue,
            multiplier,
            pool
        )

        ::continue::
    end
end

---Перезарядить героев команд, которые участвовали в PVP
---@param teamId integer
function PvpModule:RefreshTeamHero(teamId)
    for i = 1, PlayerResource:GetPlayerCountForTeam(teamId) do
        local playerId = PlayerResource:GetNthPlayerIDOnTeam(teamId, i)
        local hero = PlayerResource:GetSelectedHeroEntity(playerId)

        if not IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
            goto continue
        end

        if not hero:IsAlive() then
            Util:RefreshAbilityAndItem(hero)
            Timers:CreateTimer({
                endTime = 3,
                callback = function()
                    Util:MoveHeroToCenter(playerId, true)
                    if PlayerResource:GetConnectionState(playerId) ~= DOTA_CONNECTION_STATE_ABANDONED then
                        Util:RefreshAbilityAndItem(hero)
                        hero:RespawnHero(false, false)
                        if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
                            hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
                        end
                    end
                    hero.bJoiningPvp = false
                    return nil
                end
            })
        else
            Util:RefreshAbilityAndItem(hero)
            hero:SetHealth(hero:GetMaxHealth())
            hero:SetMana(hero:GetMaxMana())
            if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
                hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
            end
            hero:AddNewModifier(hero, nil, "modifier_pvp_ending", { duration = 3.1 })
            Timers:CreateTimer({
                endTime = 3,
                callback = function()
                    Util:MoveHeroToCenter(playerId, true)
                    Util:RefreshAbilityAndItem(hero)

                    hero.bJoiningPvp = false
                    return nil
                end
            })
        end

        ::continue::
    end
end

---Очищает целевую арену от саммонов
---@param targetLocation Vector
function PvpModule:KillSummonedCreatureAsyn(targetLocation)
    if not targetLocation then return end

    local cleanLocation = Vector(targetLocation.x, targetLocation.y, targetLocation.z)
    Timers:CreateTimer({
        endTime = 5,
        callback = function()
            local summonedCreature = FindUnitsInRadius(
                DOTA_TEAM_NEUTRALS,
                cleanLocation,
                nil,
                2500,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_ALL,
                DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE +
                DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
                FIND_CLOSEST,
                false
            )

            for _, unit in ipairs(summonedCreature) do
                if not unit or unit:IsNull() or not unit.GetUnitName or not unit:GetUnitName() or not unit:IsSummoned() or unit:IsIllusion() or unit:IsTempestDouble() or unit:HasModifier("modifier_arc_warden_tempest_double_lua") then
                    goto continue
                end

                if not unit:IsAlive() then
                    goto continue
                end

                if string.find(unit:GetUnitName(), "npc_dota_lone_druid_bear") == 1 then
                    local owner = unit:GetOwner()
                    if owner and owner.IsRealHero and owner:IsRealHero() and owner:HasAbility("lone_druid_spirit_bear") then
                        local ability = owner:FindAbilityByName("lone_druid_spirit_bear")
                        ability:EndCooldown()
                    end
                end

                if string.find(unit:GetUnitName(), "npc_dota_visage_familiar") == 1 then
                    local owner = unit:GetOwner()
                    if owner and owner.IsRealHero and owner:IsRealHero() and owner:HasAbility("visage_summon_familiars") then
                        local ability = owner:FindAbilityByName("visage_summon_familiars")
                        ability:EndCooldown()
                    end
                end

                if string.find(unit:GetUnitName(), "npc_dota_warlock_golem") == 1 then
                    local owner = unit:GetOwner()
                    if owner and owner.IsRealHero and owner:IsRealHero() and owner:HasAbility("warlock_rain_of_chaos") then
                        local ability = owner:FindAbilityByName("warlock_rain_of_chaos")
                        ability:EndCooldown()
                    end
                end

                if string.find(unit:GetUnitName(), "npc_dota_shadow_shaman_ward") == 1 then
                    local owner = unit:GetOwner()
                    if owner and owner.IsRealHero and owner:IsRealHero() and owner:HasAbility("shadow_shaman_mass_serpent_ward") then
                        local ability = owner:FindAbilityByName("shadow_shaman_mass_serpent_ward")
                        ability:EndCooldown()
                    end
                end

                if string.find(unit:GetUnitName(), "npc_dota_brewmaster") == 1 then
                    local owner = unit:GetOwner()
                    if owner and owner.IsRealHero and owner:IsRealHero() and owner:HasAbility("brewmaster_primal_split") then
                        local ability = owner:FindAbilityByName("brewmaster_primal_split")
                        ability:EndCooldown()
                    end
                end

                unit:ForceKill(false)

                ::continue::
            end
            return nil
        end
    })
end