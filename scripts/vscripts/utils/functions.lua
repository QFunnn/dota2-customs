--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Совместимость с обновлением Dota 2 (06.2026): движок сменил сигнатуру
-- CDOTA_BaseNPC:GetBaseAttackTime() — теперь требует доп. аргумент, из-за чего
-- прямой вызов падает «expected 2 arguments». Хелпер сам подбирает рабочую
-- сигнатуру (и кэширует её), возвращая базовое время атаки юнита.
-- Используется вместо unit:GetBaseAttackTime() во всех модулях.
local _batForm = nil  -- кэш рабочего варианта: 0 = без доп.арг, 1 = (false)
function GetUnitBaseAttackTime(unit)
    if not unit or unit:IsNull() then return 1.7 end
    local m = unit.GetBaseAttackTime
    if m then
        if _batForm == 0 then local ok, v = pcall(m, unit);        if ok and type(v) == "number" and v > 0 then return v end end
        if _batForm == 1 then local ok, v = pcall(m, unit, false); if ok and type(v) == "number" and v > 0 then return v end end
        -- определяем рабочую сигнатуру
        local ok, v = pcall(m, unit)
        if ok and type(v) == "number" and v > 0 then _batForm = 0; return v end
        ok, v = pcall(m, unit, false)
        if ok and type(v) == "number" and v > 0 then _batForm = 1; return v end
        ok, v = pcall(m, unit, true)
        if ok and type(v) == "number" and v > 0 then return v end
    end
    -- фолбэк: на спавне (без модификаторов) время атаки ≈ базовое
    local ok2, v2 = pcall(unit.GetSecondsPerAttack, unit)
    if ok2 and type(v2) == "number" and v2 > 0 then return v2 end
    return 1.7
end

-- A6: надёжная проверка «юнит — вард». ВАЖНО: для кастомных крип-вардов (серпент-варды и т.п.)
-- движковый IsWard() возвращает FALSE (UnitRelationshipClass WARD на него НЕ влияет — проверено дебагом).
-- Поэтому идём по списку имён + IsWard() как fallback для настоящих вардов.
local WARD_UNIT_NAMES = {
    ["npc_dota_shadow_shaman_ward_1"] = true,
    ["npc_dota_shadow_shaman_ward_2"] = true,
    ["npc_dota_shadow_shaman_ward_3"] = true,
    ["npc_dota_venomancer_plague_ward_1"] = true,
    ["npc_dota_venomancer_plague_ward_2"] = true,
    ["npc_dota_venomancer_plague_ward_3"] = true,
    ["npc_dota_venomancer_plague_ward_4"] = true,
    ["npc_dota_pugna_nether_ward_1"] = true,
    ["npc_dota_pugna_nether_ward_2"] = true,
    ["npc_dota_pugna_nether_ward_3"] = true,
    ["npc_dota_pugna_nether_ward_4"] = true,
}
function IsWardUnit(unit)
    if not unit or unit:IsNull() then return false end
    if unit.IsWard and unit:IsWard() then return true end
    local n = unit.GetUnitName and unit:GetUnitName()
    return n ~= nil and WARD_UNIT_NAMES[n] == true
end

function GameMode:HeroIconClicked(params)
    -- [SEC] Отправитель читается из event.PlayerID (заглавная P) — движок это поле ИНЖЕКТИТ
    -- (доказано: playertables_base.js шлёт только {pid}, а playertables.lua:145 читает
    -- args.PlayerID, и подписки работают). ⚠️ НО «клиент подделать НЕ может» — НЕ ПРОВЕРЕНО:
    -- перезаписывает ли движок поле, присланное клиентом, никто не тестировал, а аудит
    -- 2026-06-23 (M2/M3) считает импersonation открытым риском. Диагностика — [SEC-EVT]
    -- в addon_init.lua + probe sec_probe.js. Клиентский params.playerId — отдельный, ему НЕ доверяем.
    -- ВАЖНО: первый аргумент колбэка (self) тут НЕ равен PlayerID (это userid/индекс — для игрока 0
    -- он приходил как 1), поэтому использовать его как PlayerID НЕЛЬЗЯ — была регрессия: камера
    -- наводилась на чужой PID, и кликер ничего не видел.
    local nPlayerID = params.PlayerID
    if nPlayerID == nil then nPlayerID = params.playerId end
    if nPlayerID == nil or nPlayerID == -1 or not PlayerResource:IsValidPlayerID(nPlayerID) then return end

    local nTargetPlayerID = params.targetPlayerId
    local nDoubleClick = params.doubleClick
    local nControldown = params.controldown
    local nAltDown = params.altdown

    -- [SEC-B] is_spectator определяем НА СЕРВЕРЕ по реальной команде отправителя
    -- (спектатор = команда 1, DOTA_SPECTATOR_TEAM; ср. Players:LoadSpectator, где
    -- спектатором считается GetTeam(PID) == 1), а не доверяем клиентскому params.is_spectator.
    local bIsSpectator = PlayerResource:GetTeam(nPlayerID) == 1

    -- Надёжный поиск героя цели: PlayerResource:GetSelectedHeroEntity иногда возвращает nil
    -- (бот / потерянный hero-binding) — тогда до камеры дело вообще не доходит. Фолбэк на
    -- хранимую модом ссылку Players.Players[pid].hero (как в Util:MoveHeroToLocation).
    local hTargetHero = PlayerResource:GetSelectedHeroEntity(nTargetPlayerID)
    if (not hTargetHero or hTargetHero:IsNull()) and Players and Players.Players and Players.Players[nTargetPlayerID] then
        local fb = Players.Players[nTargetPlayerID].hero
        if fb and not fb:IsNull() then hTargetHero = fb end
    end
    if hTargetHero then
        -- [A48] Камеру двигает КЛИЕНТ (GameUI.MoveCameraToEntity по двойному клику в JS).
        -- Серверный SetCameraTarget убран: он лочил камеру на слежение (самопроизвольный дрейф).
        --
        -- ⚠️ SetOverrideSelectionEntity вызываем ТОЛЬКО спектатору. Проверено в игре: снятие
        -- этого гейта (override для играющего) → КРАШ при клике по портрету. Значит для не-
        -- спектатора этот метод небезопасен — не переключаем им нижний HUD через override.
        if bIsSpectator then
            PlayerResource:SetOverrideSelectionEntity(nPlayerID, hTargetHero)
        end
    end
    if hTargetHero and nAltDown == 1 then
        if PlayerResource:GetPlayer(nPlayerID) then
            local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
            if hHero then
                if (nPlayerID ~= nTargetPlayerID) or IsInToolsMode() then
                    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(nPlayerID), "ShowActorPanel", {target_player_id = nTargetPlayerID} );
                end
            end
        end
    end
end

-- MF-18: ПКМ в таблице счёта → открыть панель игрока (ActorPanel: аватар/герой + мут + репорт)
-- у кликнувшего. Отправитель авторитетно из event.PlayerID (клиент подделать не может).
function GameMode:OnActorPanelOpen(params)
    local nPlayerID = params.PlayerID
    if nPlayerID == nil then nPlayerID = params.playerId end
    if nPlayerID == nil or not PlayerResource:IsValidPlayerID(nPlayerID) then return end
    local nTargetPlayerID = params.target_player_id
    if nTargetPlayerID == nil or not PlayerResource:IsValidPlayerID(nTargetPlayerID) then return end
    if nTargetPlayerID == nPlayerID and not IsInToolsMode() then return end -- не на себя
    if PlayerResource:GetPlayer(nPlayerID) then
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(nPlayerID), "ShowActorPanel", {target_player_id = nTargetPlayerID})
    end
end