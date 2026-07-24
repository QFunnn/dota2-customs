--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let MAIN_PANEL = $("#DuelPlayersContainer")
let BODY_PANEL = $("#DuelBody")
let LOCAL_PID = Game.GetLocalPlayerID()

const bSubscribedToBattlePass = IsPlayerBattlePassSubscribed(LOCAL_PID)

BODY_PANEL.SetHasClass("BattlePassSubscribed", bSubscribedToBattlePass)

let DUEL_INFO = {}
let Schedule = -1
let Schedule2 = -1

let LastTimeTimer = 0
let StartTimeTimer = 0
let NeedDelete = false

const TeamID = Players.GetTeam( LOCAL_PID )

let LOCAL_PLAYER_ROUND_INFO = {}

SubscribeAndFirePlayerTableByKey(`team_${TeamID}`, `round_info`, function(v){
    LOCAL_PLAYER_ROUND_INFO = v
})

SubscribeAndFirePlayerTableByKey("globals", `duel_info`, function(v){
    DUEL_INFO = v
    if(DUEL_INFO.fTeamID == undefined){return}

    $.Msg("DUEL INFO:")
    $.Msg(DUEL_INFO)
    $.Msg("LOCAL PLAYER INFO: ", LOCAL_PID, " ", TeamID)

    if(DUEL_INFO.state != "FINISHED" && Schedule == -1){
        Schedule2 = -1
        BODY_PANEL.AddClass("Show")
        BODY_PANEL.RemoveClass("ShowBetMap")

        NeedDelete = true

        for (let i = 1; i <= 2; i++) {
            let Container = $(`#Player${i}`)
            if(Container){
                const Entry = Container.FindChildTraverse("BetTextEntry")
                const GoldSlider = Container.FindChildTraverse("GoldSlider")
                Entry.text = ""
                GoldSlider.value = 0
                Entry.last_gold = undefined

                Container.RemoveClass("Winner")
                Container.RemoveClass("BettedToThis")
            }
        }

        Updater()
    }else if(DUEL_INFO.state == "FINISHED"){
        if(Schedule != -1){
            $.CancelScheduled(Schedule)
            Schedule = -1
        }
        BODY_PANEL.RemoveClass("Show")

        // $.DispatchEvent("DropInputFocus", BODY_PANEL)
    }
    UpdateDuelInfo()

    UpdateBetMap()
})

function Updater(){
    if(DUEL_INFO.state != "FINISHED"){
        Schedule = $.Schedule(0.1, Updater)
    }

    UpdateDuelInfo()
}

function UpdateDuelInfo(){
    if(DUEL_INFO.fTeamID == undefined){return}
    
    let bPlayerBetted = DUEL_INFO.bets && DUEL_INFO.bets[LOCAL_PID] != undefined
    let bPlayerInDuel = Players.GetTeam( LOCAL_PID ) == DUEL_INFO.fTeamID || Players.GetTeam( LOCAL_PID ) == DUEL_INFO.sTeamID
    let bIsSpectator = Players.IsSpectator( LOCAL_PID ) || (LOCAL_PLAYER_ROUND_INFO != undefined && LOCAL_PLAYER_ROUND_INFO.state == 5)

    // $.Msg("DUEL INFO: ", bPlayerBetted, " ", bPlayerInDuel, " ", bIsSpectator)

    // let bPlayerBetted = false
    BODY_PANEL.SetHasClass("ShowBet", DUEL_INFO.state == "PREPARING" && !bPlayerBetted && !bPlayerInDuel && !bIsSpectator)
    BODY_PANEL.SetHasClass("BetMapActive", ((DUEL_INFO.state == "PREPARING" && bPlayerBetted) || DUEL_INFO.state != "PREPARING") && !bPlayerInDuel && !bIsSpectator)

    BODY_PANEL.SetHasClass("Active", DUEL_INFO.state != "FINISHED" && (!bPlayerInDuel || (bPlayerInDuel && DUEL_INFO.state != "IN_GAME")))

    if(GameUI.CustomUIConfig().SetDuelActive != undefined){
        GameUI.CustomUIConfig().SetDuelActive(BODY_PANEL.BHasClass("Active") || BODY_PANEL.BHasClass("WinnerAnim"))
    }

    // $.Msg(DUEL_INFO.state != "FINISHED" && (!bPlayerInDuel || (bPlayerInDuel && DUEL_INFO.state != "IN_GAME")))

    let WinnerContainer = DUEL_INFO.winner == DUEL_INFO.fTeamID ? $("#Player1") : $("#Player2")
    WinnerContainer.SetHasClass("Winner", DUEL_INFO.state == "FINISHED" && DUEL_INFO.winner != undefined)
    if(DUEL_INFO.winner != undefined && Schedule2 == -1){
        BODY_PANEL.AddClass("WinnerAnim")
        Schedule2 = $.Schedule(1, function(){
            BODY_PANEL.RemoveClass("WinnerAnim")
        })
    }

    if(DUEL_INFO.state == "FINISHED" || !BODY_PANEL.BHasClass("Active") || BODY_PANEL.BHasClass("WinnerAnim")){return}

    if(NeedDelete){
        NeedDelete = false
        for (let i = 1; i <= 2; i++) {
            let Container = $(`#Player${i}`)
            if(Container){
                const DuelPlayerRightBetMapList = Container.FindChildTraverse("DuelPlayerRightBetMapList")
                if(DuelPlayerRightBetMapList){
                    DuelPlayerRightBetMapList.RemoveAndDeleteChildren()
                }
            }
        }
    }

    if(DUEL_INFO.BetJackpot != undefined){
        BODY_PANEL.SetDialogVariable("jackpot_gold", DUEL_INFO.BetJackpot.toFixed(0))
    }

    for (const _ in DUEL_INFO.PlayersList) {
        let PlayerDuelInfo = DUEL_INFO.PlayersList[_]
        let Container = DUEL_INFO.fTeamID == PlayerDuelInfo.TeamID ? $("#Player1") : $("#Player2")

        let bBettedToThis = bPlayerBetted && DUEL_INFO.bets[LOCAL_PID].team == PlayerDuelInfo.TeamID

        Container.SetHasClass("BettedToThis", bPlayerBetted && bBettedToThis)
        Container.RemoveClass("Winner")

        let PlayerInfo = Game.GetPlayerInfo( PlayerDuelInfo.PlayerID )

        let Rating = 0
        let RatingNumber = 0
        let AllGames = 0
        let SeasonGames = 0
        let PlayerServerInfo = CustomNetTables.GetTableValue("players_server_info", `player_${PlayerDuelInfo.PlayerID}`)
        if(PlayerServerInfo && PlayerServerInfo.profile){
            Rating = PlayerServerInfo.profile.rating
            RatingNumber = PlayerServerInfo.profile.rating_number_in_top
            AllGames = PlayerServerInfo.profile.total_games
            SeasonGames = PlayerServerInfo.profile.season_games
        }
        let RatingText = `${$.Localize("#Score")}: ${Rating}`

        let PlayerRankProfile = Container.FindChildTraverse("PlayerRankProfile")
        if(PlayerRankProfile){
            if (RatingNumber > 0 && RatingNumber <= 10 && Rating >= 5420) 
            {
                PlayerRankProfile.style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(10000) + '.png")';
            } else {
                PlayerRankProfile.style.backgroundImage = 'url("file://{images}/custom_game/ranks/' + GetImageRank(Rating) + '.png")';
            }
        }

        Container.SetDialogVariable("player_rating", RatingText)
        Container.SetDialogVariable("player_rating_place", RatingNumber + "")
        Container.SetDialogVariable("player_all_games", `${$.Localize("#DUEL_INFO_ALL_GAMES")} ${AllGames}`)
        Container.SetDialogVariable("player_season_games", `${$.Localize("#DUEL_INFO_SEASON_GAMES")} ${SeasonGames}`)

        let PlayerAvatar = Container.FindChildTraverse("PlayerAvatar")
        if(PlayerAvatar){
            PlayerAvatar.steamid = PlayerInfo.player_steamid
        }
        Container.SetDialogVariable("player_name", PlayerInfo.player_name)

        // MF-2: наказания за репорты — затемнение портрета + бейдж (курса/предупреждение) + дата снятия + тултип.
        let Punishment = CustomNetTables.GetTableValue("punishments", "player_" + PlayerDuelInfo.PlayerID)
        let hasCurse = !!(Punishment && Punishment.curse)
        let hasWarning = !!(Punishment && Punishment.warning)
        Container.SetHasClass("HasPunishmentCurse", hasCurse)
        Container.SetHasClass("HasPunishmentWarning", !hasCurse && hasWarning)
        // Дата снятия — только в тултипе (с портрета убрали). Курса приоритетнее предупреждения.
        let untilText = hasCurse ? (Punishment.curse_until || "") : (hasWarning ? (Punishment.warning_until || "") : "")
        // Тултип на иконке наказания: название модификатора + дата снятия + описание.
        let PunishIcon = Container.FindChildrenWithClassTraverse("PunishmentIcon")[0]
        if (PunishIcon) {
            let modName = hasCurse ? "modifier_report_curse" : (hasWarning ? "modifier_report_warning" : "")
            if (modName) {
                // Порядок: название → описание → дата снятия (внизу, под описанием).
                // %% в локализации — экранирование для нативного тултипа Dota; в своём тултипе
                // (DOTAShowTextTooltip) разэкранируем в одинарный %, иначе рисуется «20%%».
                let desc = $.Localize("#DOTA_Tooltip_" + modName + "_Description").replace(/%%/g, "%")
                let tip = $.Localize("#DOTA_Tooltip_" + modName)
                tip += "\n\n" + desc
                if (untilText) { tip += "\n\n" + $.Localize("#Punishment_Until") + " " + untilText }
                PunishIcon._punishTip = tip
            } else {
                PunishIcon._punishTip = ""
            }
            if (!PunishIcon._tipBound) {
                PunishIcon._tipBound = true
                PunishIcon.SetPanelEvent("onmouseover", function(){ if(PunishIcon._punishTip){ $.DispatchEvent("DOTAShowTextTooltip", PunishIcon, PunishIcon._punishTip) } })
                PunishIcon.SetPanelEvent("onmouseout", function(){ $.DispatchEvent("DOTAHideTextTooltip", PunishIcon) })
            }
        }

        let Gold = 0
        let GoldInfo = CustomNetTables.GetTableValue( "player_info", PlayerDuelInfo.PlayerID )
        if(GoldInfo){
            Gold = GoldInfo.gold
        }

        Container.SetDialogVariable("hero_name", $.Localize(`#${PlayerInfo.player_selected_hero}`))
        Container.SetDialogVariable("hero_level", `${PlayerInfo.player_level}${$.Localize(`#duel_level`)}`)
        Container.SetDialogVariable("player_gold", `${Gold}`)

        let DuelPlayerHeroScene = Container.FindChildTraverse("DuelPlayerHeroScene")
        if(DuelPlayerHeroScene){
            DuelPlayerHeroScene.heroname = PlayerInfo.player_selected_hero
        }

        let HeroIndex = PlayerInfo.player_selected_hero_entity_index
        if(HeroIndex != -1){

            if(DuelPlayerHeroScene){
                DuelPlayerHeroScene.SetPanelEvent("onactivate", function(){
                    GameUI.SelectUnit(HeroIndex, false)
                    // [A24] Помимо камеры/выделения — переключаем нижний HUD/портрет на кликнутого
                    // героя. Сервер делает это через PlayerResource:SetOverrideSelectionEntity в
                    // обработчике HeroIconClicked (ветка is_spectator), как в скорборде. Шлём то же
                    // событие с is_spectator, чтобы для спектатора сменился портрет в HUD.
                    GameEvents.SendCustomGameEventToServer('HeroIconClicked', {
                        playerId: LOCAL_PID,
                        targetPlayerId: PlayerDuelInfo.PlayerID,
                        doubleClick: 0, // одиночный клик = ВЫБОР героя (свитч нижнего HUD), БЕЗ камеры; камера — на ondblclick (двойной)
                        controldown: GameUI.IsControlDown(),
                        altdown: false,
                        is_spectator: Players.IsSpectator(Players.GetLocalPlayer())
                    })
                })
                DuelPlayerHeroScene.SetPanelEvent("ondblclick", function(){
                    // [A48] Камера по двойному клику — клиентски (без серверного лока → без дрейфа)
                    if(Entities.IsValidEntity(HeroIndex)){
                        GameUI.MoveCameraToEntity(HeroIndex)
                    }
                    GameEvents.SendCustomGameEventToServer('HeroIconClicked', {
                        playerId: LOCAL_PID,
                        targetPlayerId: PlayerDuelInfo.PlayerID,
                        doubleClick: true,
                        controldown: GameUI.IsControlDown()
                    })
                })
            }

            let Health = Entities.GetHealth( HeroIndex )
            let MaxHealth = Entities.GetMaxHealth( HeroIndex )
            let HealthRegen = Entities.GetHealthThinkRegen( HeroIndex )

            let PrefHP = HealthRegen > 0 ? "+" : ""

            let Mana = Entities.GetMana(HeroIndex)
            let MaxMana = Entities.GetMaxMana(HeroIndex)
            let ManaRegen = Entities.GetManaThinkRegen( HeroIndex )

            let PrefMP = ManaRegen > 0 ? "+" : ""
            

            Container.SetDialogVariable("hero_health", `${Health} / ${MaxHealth}`)
            Container.SetDialogVariable("hero_health_regen", `${PrefHP}${HealthRegen.toFixed(1)}`)
            Container.SetDialogVariable("hero_mana", `${Mana} / ${MaxMana}`)
            Container.SetDialogVariable("hero_mana_regen", `${PrefMP}${ManaRegen.toFixed(1)}`)

            let HealthProgressBar = Container.FindChildTraverse("HealthProgressBar")
            if(HealthProgressBar){
                HealthProgressBar.max = MaxHealth
                HealthProgressBar.value = Health
                // [NP-24] Alt+клик по полоске HP дуэлянта — пинг HP в чат.
                HealthProgressBar.hittest = true
                HealthProgressBar.SetPanelEvent("onactivate", function(){
                    if(!IsDotaAltPressed() || !GameUI.CustomUIConfig().SendPingTextToChat) return
                    let hn = $.Localize("#"+Entities.GetUnitName(HeroIndex))
                    let t = $.Localize("#PING_HP").replace("%s1", hn)
                        .replace("%s2", `${Math.round(Health)} / ${Math.round(MaxHealth)}`)
                        .replace("%s3", `${PrefHP}${HealthRegen.toFixed(1)}`)
                    GameUI.CustomUIConfig().SendPingTextToChat(t)
                })
            }

            let ManaProgressBar = Container.FindChildTraverse("ManaProgressBar")
            if(ManaProgressBar){
                ManaProgressBar.max = MaxMana
                ManaProgressBar.value = Mana
                // [NP-24] Alt+клик по полоске маны дуэлянта — пинг маны в чат.
                ManaProgressBar.hittest = true
                ManaProgressBar.SetPanelEvent("onactivate", function(){
                    if(!IsDotaAltPressed() || !GameUI.CustomUIConfig().SendPingTextToChat) return
                    let hn = $.Localize("#"+Entities.GetUnitName(HeroIndex))
                    let t = $.Localize("#PING_MANA").replace("%s1", hn)
                        .replace("%s2", `${Math.round(Mana)} / ${Math.round(MaxMana)}`)
                        .replace("%s3", `${PrefMP}${ManaRegen.toFixed(1)}`)
                    GameUI.CustomUIConfig().SendPingTextToChat(t)
                })
            }

            let PlayerTalents = Container.FindChildTraverse("PlayerTalents")
            if(PlayerTalents){
                SetShowTalents(PlayerTalents, PlayerInfo.player_selected_hero_id)
            }

            let bHasScepter = Entities.HasScepter( HeroIndex )
            let bHasShard = HasModifier(HeroIndex, "modifier_item_aghanims_shard")
            
            Container.SetHasClass("HasScepter", bHasScepter)
            Container.SetHasClass("HasShard", bHasShard)

            let PlayerAghanimContainer = Container.FindChildTraverse("PlayerAghanimContainer")
            if(PlayerAghanimContainer){
                SetShowAghan(PlayerAghanimContainer, PlayerInfo.player_selected_hero_id)
                // [NP-24] Alt+клик: скипетр и шард пингуются РАЗДЕЛЬНО (как в нативном HUD).
                let hnAgh = $.Localize("#"+Entities.GetUnitName(HeroIndex))
                let yesAgh = $.Localize("#PING_YES"), noAgh = $.Localize("#PING_NO")
                let aghScepter = PlayerAghanimContainer.GetChild(0)
                let aghShard = PlayerAghanimContainer.GetChild(1)
                if(aghScepter){
                    aghScepter.hittest = true
                    aghScepter.SetPanelEvent("onactivate", function(){
                        if(!IsDotaAltPressed() || !GameUI.CustomUIConfig().SendPingTextToChat) return
                        GameUI.CustomUIConfig().SendPingTextToChat($.Localize("#PING_SCEPTER_STATUS").replace("%s1", hnAgh).replace("%s2", bHasScepter ? yesAgh : noAgh))
                    })
                }
                if(aghShard){
                    aghShard.hittest = true
                    aghShard.SetPanelEvent("onactivate", function(){
                        if(!IsDotaAltPressed() || !GameUI.CustomUIConfig().SendPingTextToChat) return
                        GameUI.CustomUIConfig().SendPingTextToChat($.Localize("#PING_SHARD_STATUS").replace("%s1", hnAgh).replace("%s2", bHasShard ? yesAgh : noAgh))
                    })
                }
            }

            for ( let i = 0; i < 9; ++i )
            {
                let itemPanel = Container.FindChildTraverse( `item_slot_${i}` );
                let charges = 0
                let ItemEnt = Entities.GetItemInSlot(HeroIndex, i);
                if ( ItemEnt != undefined && ItemEnt != -1 )
                {
                    itemPanel.itemname = Abilities.GetAbilityName(ItemEnt)
                    itemPanel.contextEntityIndex = ItemEnt
                    charges = Items.GetCurrentCharges( ItemEnt )
                }
                else
                {
                    itemPanel.itemname = ""
                    itemPanel.contextEntityIndex = -1
                }

                UpdateAbilityCooldown(itemPanel, ItemEnt)

                // [NP-24] Alt+клик по предмету дуэлянта — пинг в чат союзникам.
                itemPanel.SetPanelEvent("onactivate", function(){
                    if(IsDotaAltPressed() && GameUI.CustomUIConfig().PingItemToChat){
                        GameUI.CustomUIConfig().PingItemToChat(ItemEnt, HeroIndex)
                    }
                })

                if(charges == 0){
                    charges = ""
                }
                itemPanel.SetDialogVariable("item_charges", charges)

                if(i >= 6){
                    GameUI.CustomUIConfig().UpdateNeutralTooltipImage(itemPanel, PlayerDuelInfo.PlayerID)
                }
            }

            let charges = 0
            let ItemEntNeutral = Entities.GetItemInSlot(HeroIndex, 16)
            let itemPanelNeutral = Container.FindChildTraverse( "PlayerNeutralItem" );
            if (ItemEntNeutral != undefined && ItemEntNeutral != -1) {
                itemPanelNeutral.GetChild(0).itemname = Abilities.GetAbilityName(ItemEntNeutral)
                itemPanelNeutral.GetChild(0).contextEntityIndex = ItemEntNeutral
                charges = Items.GetCurrentCharges( ItemEntNeutral )
            }
            else {
                itemPanelNeutral.GetChild(0).itemname = "";
                itemPanelNeutral.GetChild(0).contextEntityIndex = -1
            }

            if(charges == 0){
                charges = ""
            }
            itemPanelNeutral.SetDialogVariable("item_charges", charges)

            UpdateAbilityCooldown(itemPanelNeutral, ItemEntNeutral)

            // [NP-24] Alt+клик по нейтральному предмету дуэлянта — пинг в чат. Если нейтрала
            // нет — пингуем «нейтрала нет», чтобы союзники видели пустой слот.
            itemPanelNeutral.GetChild(0).SetPanelEvent("onactivate", function(){
                if(!IsDotaAltPressed()) return
                if(ItemEntNeutral != undefined && ItemEntNeutral != -1){
                    if(GameUI.CustomUIConfig().PingItemToChat) GameUI.CustomUIConfig().PingItemToChat(ItemEntNeutral, HeroIndex)
                } else if(GameUI.CustomUIConfig().SendPingTextToChat){
                    let hn = $.Localize("#"+Entities.GetUnitName(HeroIndex))
                    GameUI.CustomUIConfig().SendPingTextToChat($.Localize("#PING_NEUTRAL_NONE").replace("%s1", hn))
                }
            })

            GameUI.CustomUIConfig().UpdateNeutralTooltipImage(itemPanelNeutral.GetChild(0), PlayerDuelInfo.PlayerID)

            charges = 0
            let ItemEntSmokes = Entities.GetItemInSlot(HeroIndex, 15)
            let itemPanelSmokes = Container.FindChildTraverse( "PlayerSmokes" );
            if (ItemEntSmokes != undefined && ItemEntSmokes != -1) {
                itemPanelSmokes.GetChild(0).itemname = Abilities.GetAbilityName(ItemEntSmokes)
                charges = Items.GetCurrentCharges( ItemEntSmokes )
            }
            else {
                itemPanelSmokes.GetChild(0).itemname = "";
            }
            if(charges == 0){
                charges = ""
            }
            itemPanelSmokes.SetDialogVariable("item_charges", charges)

            UpdateAbilityCooldown(itemPanelSmokes, ItemEntSmokes)

            // [NP-24] Alt+клик по смоку дуэлянта — пинг в чат. Слот читаем СВЕЖИМ в момент
            // клика: захваченная ItemEntSmokes устаревает после траты всех смоков, а её
            // entity-index Dota переиспользует под другой предмет (часто смок пингующего) —
            // из-за этого раньше в чат уходило ЧУЖОЕ количество. Тот же подход, что уже
            // применён для нейтрал-слота (zxc_notifications.js: читать свежим + пустой случай).
            itemPanelSmokes.GetChild(0).SetPanelEvent("onactivate", function(){
                if(!IsDotaAltPressed()){ return }
                let cfg = GameUI.CustomUIConfig()
                let idx = Entities.GetItemInSlot(HeroIndex, 15)
                if(idx != undefined && idx != -1){
                    if(cfg.PingItemToChat){ cfg.PingItemToChat(idx, HeroIndex) }
                } else if(cfg.SendPingTextToChat && cfg.BuildSmokePingByCharges){
                    // Пусто = 0 смоков: тот же формат, что живой смок, но x0 (как верхняя строка пинга).
                    cfg.SendPingTextToChat(cfg.BuildSmokePingByCharges(HeroIndex, 0))
                }
            })

            let AbilityInnate = Container.FindChildTraverse("ability_innate")
            if(AbilityInnate){
                let IndexForInnate = -1
                for (let i = 0; i < Entities.GetAbilityCount(HeroIndex); i++) {
                    let ability = Entities.GetAbility(HeroIndex, i)
                    if(ability != -1 && IsInnateAbility(Abilities.GetAbilityName(ability))){
                        IndexForInnate = ability
                        break
                    }
                }

                let AbilityCharges = 0

                if(IndexForInnate != -1){
                    AbilityCharges = Abilities.GetCurrentAbilityCharges( IndexForInnate )
                    SetShowAbility(AbilityInnate, Abilities.GetAbilityName(IndexForInnate), HeroIndex)
                }else{
                    SetShowText(AbilityInnate, "#DUEL_INFO_NO_INNATE")
                }

                AbilityInnate.SetHasClass("HasCharges", Abilities.UsesAbilityCharges( IndexForInnate ))
                AbilityInnate.SetDialogVariable("item_charges", AbilityCharges)

                UpdateLevelInfo(AbilityInnate, IndexForInnate)

                UpdateAbilityCooldown(AbilityInnate, IndexForInnate)

                // [NP-24] Alt+клик по врождёнке дуэлянта — пинг в чат.
                AbilityInnate.SetPanelEvent("onactivate", function(){
                    if(IsDotaAltPressed() && GameUI.CustomUIConfig().PingAbilityToChat){
                        GameUI.CustomUIConfig().PingAbilityToChat(IndexForInnate, HeroIndex)
                    }
                })
            }

            let PlayerAbilitiesContainer = Container.FindChildTraverse("PlayerAbilitiesContainer")
            if(PlayerAbilitiesContainer){
                let Num = 0
                for (let i = 0; i < 30; i++) {
                    let ability = Entities.GetAbility(HeroIndex, i)
                    if (ability != -1 && !Abilities.IsHidden(ability) && !IsInnateAbility(Abilities.GetAbilityName(ability)) && !Abilities.GetAbilityName(ability).includes("special_bonus")) {
                        if(Num >= 16){break}

                        let AbilityCharges = 0

                        let ability_panel = Container.FindChildTraverse(`ability_slot_${Num}`)
                        if(ability_panel){
                            let Image = ability_panel.GetChild(0)
                            AbilityCharges = Abilities.GetCurrentAbilityCharges( ability )
                            Image.abilityname = Abilities.GetAbilityName(ability)
                            Image.contextEntityIndex = ability
                            ability_panel.RemoveClass("Hidden")
                            SetShowAbility(ability_panel, Abilities.GetAbilityName(ability), HeroIndex)

                            ability_panel.SetHasClass("HasCharges", Abilities.UsesAbilityCharges( ability ))
                            ability_panel.SetDialogVariable("item_charges", AbilityCharges)

                            UpdateLevelInfo(ability_panel, ability)

                            UpdateAbilityCooldown(ability_panel, ability)

                            // [NP-24] Alt+клик по способности дуэлянта — пинг в чат.
                            ability_panel.SetPanelEvent("onactivate", function(){
                                if(IsDotaAltPressed() && GameUI.CustomUIConfig().PingAbilityToChat){
                                    GameUI.CustomUIConfig().PingAbilityToChat(ability, HeroIndex)
                                }
                            })
                        }

                        Num++;
                    }
                }

                let Num2 = 0
                for (let i = 0; i < PlayerAbilitiesContainer.GetChildCount(); i++) {
                    let Child = PlayerAbilitiesContainer.FindChildTraverse(`ability_slot_${i}`)
                    if(Child){
                        if((Num-1) < Num2){
                            Child.AddClass("Hidden")

                            let Image = Child.GetChild(0)
                            Image.abilityname = ""
                            Image.contextEntityIndex = -1
                            Child.SetPanelEvent("onmouseover", ()=>{})
                            Child.SetPanelEvent("onmouseout", ()=>{})

                            Child.RemoveClass("HasCharges")
                            Child.RemoveClass("HasLevels")
                            Child.RemoveClass("Cooldown")
                        }
                        Num2++;
                    }
                }
            }
        }

        let SkillsIcon = Container.FindChildTraverse("SkillsIcon")
        if(SkillsIcon){
            SetShowSkills(SkillsIcon, PlayerDuelInfo.PlayerID)
        }

        let PlayerBuffs = Container.FindChildTraverse("PlayerBuffs")
        if(PlayerBuffs && HeroIndex != -1){
            UpdateDuelBuffs(PlayerBuffs, HeroIndex)
        }

        if(DUEL_INFO.state == "PREPARING" && BODY_PANEL.BHasClass("ShowBet")){
            const GoldSlider = Container.FindChildTraverse("GoldSlider")
            const BetTextEntry = Container.FindChildTraverse("BetTextEntry")

            let CurrentMaxGold = Math.floor(Players.GetGold(LOCAL_PID) / 2)
            let EntryValue = 0
            if(isNumeric(BetTextEntry.text) && parseInt(BetTextEntry.text) != undefined){
                EntryValue = parseInt(BetTextEntry.text)
            }
            if(EntryValue > CurrentMaxGold){
                EntryValue = CurrentMaxGold

                BetTextEntry.text = EntryValue.toFixed()
            }
            if(CurrentMaxGold != BetTextEntry.last_gold){
                GoldSlider.not_change = true
                GoldSlider.value = normalizeClamped(EntryValue, 0, CurrentMaxGold)
                GoldSlider.not_change = false
            }

            BetTextEntry.last_gold = CurrentMaxGold

            BetTextEntry.SetPanelEvent("ontextentrychange", function(){
                let MaxGold = Math.floor(Players.GetGold(LOCAL_PID) / 2)
                if(!isNumeric(BetTextEntry.text) && BetTextEntry.text != ""){
                    BetTextEntry.text = BetTextEntry.text.replace(/\D/g,'')
                }else if(parseInt(BetTextEntry.text) > MaxGold){
                    BetTextEntry.text = MaxGold.toString()
                }else if(parseInt(BetTextEntry.text) <= 0){
                    BetTextEntry.text = ""
                }

                let Value = 0
                if(isNumeric(BetTextEntry.text) && parseInt(BetTextEntry.text) != undefined){
                    Value = parseInt(BetTextEntry.text)
                }

                if(GoldSlider){
                    GoldSlider.not_change = true
                    GoldSlider.value = normalizeClamped(Value, 0, MaxGold)
                    GoldSlider.not_change = false
                }
            })

            if(GoldSlider){
                GoldSlider.SetPanelEvent("onvaluechanged", function(){
                    let MaxGold = Math.floor(Players.GetGold(LOCAL_PID) / 2)
                    let Value = Math.floor(GoldSlider.value * MaxGold)
                    if(BetTextEntry.text != Value.toString() && GoldSlider.not_change != true){
                        BetTextEntry.text = Value.toString()
                    }
                })
            }

            let BetMin = Container.FindChildTraverse("BetMin")
            if(BetMin){
                BetMin.SetPanelEvent("onactivate", function(){
                    BetTextEntry.text = ""

                    $.DispatchEvent("DropInputFocus", BetMin)
                })
            }

            let BetMax = Container.FindChildTraverse("BetMax")
            if(BetMax){
                BetMax.SetPanelEvent("onactivate", function(){
                    BetTextEntry.text = "99999"

                    $.DispatchEvent("DropInputFocus", BetMax)
                })
            }
            

            SetGold(Container.FindChildTraverse("Bet10"), BetTextEntry, 10)
            SetGold(Container.FindChildTraverse("Bet20"), BetTextEntry, 20)
            SetGold(Container.FindChildTraverse("Bet30"), BetTextEntry, 30)
            SetGold(Container.FindChildTraverse("Bet40"), BetTextEntry, 40)

            SetGoldArrow(Container.FindChildTraverse("BetUp"), BetTextEntry, 1)
            SetGoldArrow(Container.FindChildTraverse("BetDown"), BetTextEntry, -1)

            let BetProgress = Container.FindChildTraverse("BetProgress")
            if(BetProgress){
                let RoundTable = GetPlayerTablesValue("round_info", "round_info")
                if(RoundTable){
                    LastTimeTimer = RoundTable.begin_start_time
                    StartTimeTimer = RoundTable.start_time
                    
                    let total = Math.floor(LastTimeTimer) - Math.floor(StartTimeTimer)
                    let cur = Math.floor(Game.GetGameTime()) - Math.floor(StartTimeTimer)
                    let percent = ((total - cur) * 100) / total

                    BetProgress.style.width = (percent) + '%';

                    let Last = total - cur
                    BetProgress.SetHasClass("Warning_1", Last <= 15 && Last > 10)
                    BetProgress.SetHasClass("Warning_2", Last <= 10 && Last > 5)
                    BetProgress.SetHasClass("Warning_3", Last <= 5)

                    Container.SetDialogVariable("bet_time", `${$.Localize("#confirm")}: ${total - cur} ${$.Localize("#DUEL_INFO_SEC_VARIABLE")}`)
                }
            }

            let DuelMakeBetButton = Container.FindChildTraverse("DuelMakeBetButton")
            if(DuelMakeBetButton){
                DuelMakeBetButton.SetPanelEvent("onactivate", function(){
                    let Value = 0
                    if(isNumeric(BetTextEntry.text) && parseInt(BetTextEntry.text) != undefined){
                        Value = parseInt(BetTextEntry.text)
                    }
                    if(Value > 0){
                        

                        GameEvents.SendCustomGameEventToServer("ConfirmBet", {
                            value: Value,
                            wish_team_id: PlayerDuelInfo.TeamID,
                        });
                    }

                    $.DispatchEvent("DropInputFocus", DuelMakeBetButton)
                })
            }
        }
    }
}

function UpdateBetMap(){
    for (const _ in DUEL_INFO.PlayersList) {
        let PlayerDuelInfo = DUEL_INFO.PlayersList[_]
        let Container = DUEL_INFO.fTeamID == PlayerDuelInfo.TeamID ? $("#Player1") : $("#Player2")

        let DuelPlayerRightBetMapList = Container.FindChildTraverse("DuelPlayerRightBetMapList")
        if(DuelPlayerRightBetMapList){
            let BetsForThisPlayer = []
            let MaxBet = 0
            for (const BetPlayerID in DUEL_INFO.bets) {
                if(DUEL_INFO.bets[BetPlayerID].team == PlayerDuelInfo.TeamID){
                    if(MaxBet < DUEL_INFO.bets[BetPlayerID].value){
                        MaxBet = DUEL_INFO.bets[BetPlayerID].value
                    }

                    BetsForThisPlayer.push({
                        PlayerID: parseInt(BetPlayerID),
                        value: DUEL_INFO.bets[BetPlayerID].value
                    })
                }
            }

            for (const BetInfo of BetsForThisPlayer) {
                let BetPlayerID = BetInfo.PlayerID
                let Value = BetInfo.value

                let p = GetOrCreateBetMapPlayer(DuelPlayerRightBetMapList, BetPlayerID)

                let PlayerInfo = Game.GetPlayerInfo(BetPlayerID)

                if(PlayerInfo){
                    let BetPlayerAvatar = p.FindChildTraverse("BetPlayerAvatar")
                    if(BetPlayerAvatar){
                        BetPlayerAvatar.steamid = PlayerInfo.player_steamid
                    }

                    let BetHeroIcon = p.FindChildTraverse("BetHeroIcon")
                    if(BetHeroIcon){
                        BetHeroIcon.heroname = PlayerInfo.player_selected_hero
                    }

                    p.SetDialogVariable("bet_player_name", PlayerInfo.player_name)
                    p.SetDialogVariable("bet_hero_name", $.Localize(`#${PlayerInfo.player_selected_hero}`))
                    p.SetDialogVariable("bet_num", `${Value}`)

                    p.gold = Value

                    let pct = (Value * 100) / (MaxBet || 1)
                    pct = Math.min(100, pct)

                    let BetLine = p.FindChildTraverse("BetLine")
                    if(BetLine){
                        BetLine.style.width = pct.toFixed(0) + '%'
                    }
                }
            }

            ReorderPanels(DuelPlayerRightBetMapList, SortFuncValue)

            Container.SetHasClass("NoBets", BetsForThisPlayer.length <= 0)
        }
    }
}

function ReorderPanels(Container, SortFunc){
    var count = Container.GetChildCount()
	if (count > 0) {
		for (var i = 0; i < count; i++) {
            for (var j = i+1; j < count; j++) {
                let prev = Container.GetChild(i);
                let child = Container.GetChild(j);
                if(child != undefined){
                    SortFunc(Container, prev, child);
                }
            }
        }
	}
}

function SortFuncValue(Container, a, b){
    let aGold = a.gold
    let bGold = b.gold
    if(bGold > aGold){
        Container.MoveChildBefore(b, a);
    }
}

function ToggleBetMap(){
    BODY_PANEL.ToggleClass("ShowBetMap")
}

function GetOrCreateBetMapPlayer(Container, PlayerID){
    let f = Container.FindChildTraverse(`player_${PlayerID}`)
    if(f){
        return f
    }else{
        let p = $.CreatePanel("Panel", Container, `player_${PlayerID}`, {})
        p.BLoadLayoutSnippet("BetMapPlayer")

        return p
    }
}

function UpdateAbilityCooldown(panel, ability){
    if(!panel){return}

    if(ability == -1){
        panel.RemoveClass("Cooldown")
        return
    }

    let CooldownPanel = panel.FindChildTraverse("CooldownPanel")
    let CooldownLabel = panel.FindChildTraverse("CooldownLabel")

    if(CooldownPanel && CooldownLabel){
        let bCooldownReady = Abilities.IsCooldownReady( ability )
        panel.SetHasClass("Cooldown", !bCooldownReady);
        
        let CDRemaining = Abilities.GetCooldownTimeRemaining(ability)
        if(Abilities.UsesAbilityCharges(ability)){
            CDRemaining = Abilities.GetAbilityChargeRestoreTimeRemaining(ability)
        }
        let CD = Abilities.GetCooldown(ability)
        panel.SetHasClass("CooldownCharge", Abilities.UsesAbilityCharges(ability) && CDRemaining > 0)

        panel.SetDialogVariable("ability_cooldown", CDRemaining <= 5 ? CDRemaining.toFixed(1) : CDRemaining.toFixed(0));

        if (!bCooldownReady && CD != 0) {
            let pct = (-360 / CD * CDRemaining);
            CooldownPanel.style.clip = 'radial( 50% 50%, 0deg, ' + pct + 'deg )';
        }
        else {
            CooldownPanel.style.clip = 'radial( 50% 50%, 0deg, 0deg )';
        }
    }
}

function UpdateLevelInfo(panel, ability){
    if(!panel){return}

    if(ability == -1){return}

    let AbilityLevels = panel.FindChildTraverse("AbilityLevels")

    if(AbilityLevels){
        let AbilityLevel = Abilities.GetLevel(ability)
        let MaxLevel = Abilities.GetMaxLevel(ability)

        panel.SetHasClass("HasLevels", MaxLevel > 1)
        panel.SetHasClass("Levels3", MaxLevel == 3)
        panel.SetHasClass("Levels4", MaxLevel == 4)
        panel.SetHasClass("Levels5", MaxLevel == 5)
        panel.SetHasClass("Levels6", MaxLevel == 6)

        for (let i = 0; i < AbilityLevels.GetChildCount(); i++) {
            let LevelBar = AbilityLevels.GetChild(i)
            if(LevelBar){
                LevelBar.SetHasClass("ActiveLevel", i < AbilityLevel)
                LevelBar.SetHasClass("Hidden", i+1 > MaxLevel)
            }
        }
    }
}

function SetGold(panel, BetTextEntry, pct){
    if(!panel){return}

    panel.SetPanelEvent("onactivate", function(){
        let Value = Math.floor(Players.GetGold(LOCAL_PID) / 100 * pct)
        BetTextEntry.text = Value.toString()

        $.DispatchEvent("DropInputFocus", panel)
    })
}

function SetGoldArrow(panel, BetTextEntry, mult){
    if(!panel){return}

    panel.SetPanelEvent("onactivate", function(){

        let Value = Math.floor(Players.GetGold(LOCAL_PID) / 2 / 10 / 100)
        if(Value < 1){
            Value = 1
        }
        Value *= 100 * mult

        let EntryValue = 0
        if(isNumeric(BetTextEntry.text) && parseInt(BetTextEntry.text) != undefined){
            EntryValue = parseInt(BetTextEntry.text)
        }

        BetTextEntry.text = (EntryValue + Value).toString()

        $.DispatchEvent("DropInputFocus", panel)
    })
}

function normalizeClamped(value, min, max) {
    if (max === min) return 0.0;
    
    const clampedValue = Math.max(min, Math.min(max, value));

    return (clampedValue - min) / (max - min);
}

function SetShowAbility(panel, abilityname, hero){
    panel.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", panel, abilityname, hero);
    });

    panel.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideAbilityTooltip");
    });
}

function SetShowTalents(panel, hero){
    panel.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAHUDShowHeroStatBranchTooltip", panel, hero, 0);
    });

    panel.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHUDHideStatBranchTooltip");
    });
}

function SetShowAghan(panel, hero){
    panel.SetPanelEvent("onmouseover", function () {
        $.DispatchEvent("DOTAHUDShowAghsStatusTooltip", panel, hero, 0);
    });

    panel.SetPanelEvent("onmouseout", function () {
        $.DispatchEvent("DOTAHUDHideAghsStatusTooltip", panel);
    });
}

function SetShowText(panel, text){
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, text); 
    });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });
}

function SetShowSkills(panel, player_id)
{
    panel.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent(
            "UIShowCustomLayoutParametersTooltip",
            panel,
            "skill_tooltip",
            "file://{resources}/layout/custom_game/skill_block/skill_tooltip.xml",
            "player_id=" + player_id,
        );
    });

    panel.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("UIHideCustomLayoutTooltip", panel, "skill_tooltip");
    });
}

function ToggleDuelInfo(){
    BODY_PANEL.ToggleClass("Show")
}

function CloseDuelInfo(){
    BODY_PANEL.RemoveClass("Show")
}

GameUI.CustomUIConfig().CloseDuelInfo = CloseDuelInfo

var DUEL_BUFF_LIST = [
    { modifier: "modifier_item_essence_of_speed", tier: 1 },
    { modifier: "modifier_item_gem_shard", tier: 2 },
    { modifier: "modifier_item_gem_shard_2", tier: 3 },
    { modifier: "modifier_item_moon_shard_buff_custom", tier: 4 },
    { modifier: "modifier_item_dark_moon_shard", tier: 5 },
]

function UpdateDuelBuffs(container, heroIndex){
    for(let i = 0; i < DUEL_BUFF_LIST.length; i++){
        let buffInfo = DUEL_BUFF_LIST[i]
        let buffId = "duel_buff_" + i
        let panel = container.FindChildTraverse(buffId)
        let buffIndex = HasModifier(heroIndex, buffInfo.modifier)

        if(buffIndex){
            if(!panel){
                panel = $.CreatePanel("Panel", container, buffId)
                panel.AddClass("DuelBuff")
                panel.AddClass("DuelBuffTier" + buffInfo.tier)
                panel.style.backgroundImage = 'url("file://{images}/custom_game/buffs/' + buffInfo.modifier + '.png")'
                panel.style.backgroundSize = "contain"
                panel.style.backgroundPosition = "center"
                panel.style.backgroundRepeat = "no-repeat"
                panel.hittest = true
            }

            panel._heroIndex = heroIndex
            panel._modifier = buffInfo.modifier

            panel.SetPanelEvent("onmouseover", function(){
                let unit = panel._heroIndex
                let bIdx = HasModifier(unit, panel._modifier)
                if(bIdx){
                    try {
                        $.DispatchEvent("DOTAShowBuffTooltip", panel, unit, bIdx, Entities.IsEnemy(unit) ? true : false)
                    } catch(e) {
                        $.DispatchEvent("DOTAShowTextTooltip", panel, $.Localize("#DOTA_Tooltip_modifier_" + panel._modifier))
                    }
                }
            })
            panel.SetPanelEvent("onmouseout", function(){
                $.DispatchEvent("DOTAHideBuffTooltip", panel)
                $.DispatchEvent("DOTAHideTextTooltip")
            })

            panel.RemoveClass("Hidden")
        }else if(panel){
            panel.AddClass("Hidden")
        }
    }
}