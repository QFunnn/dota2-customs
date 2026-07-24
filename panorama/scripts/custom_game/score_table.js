--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

const dataMapping = {
    legendary: "legendaryColumn",
    name: "nameColumn",
    color: "colorColumn",
    hero: "heroColumn",
    level: "levelColumn",
    kills: "killsColumn",
    team_color: "teamcolorColumn",
    death: "deathsColumn",
    epic: "epicsColumn",
    rare: "raresColumn",
    tipActive: "tipActiveColumn",
    lost: "lostColumn"
};

const neutralColor = "767676";
const colorMapping = {
    "2": "#60abf1",
    "6": "#60abf1",
    "7": "#60abf1",
    "3": "#ea5932",
    "8": "#ea5932",
    "9": "#ea5932"
};

const getNonNullValue = (value, fallback) => {
    const isNonNull = value !== null && value !== undefined && value !== void 0;

    return isNonNull
        ? value
        : fallback;
};

const getHeroImage = (id) => {
    let heroName = Players.GetPlayerSelectedHero(id);
    if (heroName === 'invalid index') {
        heroName = "npc_dota_hero_juggernaut";
    }
    
    return `file://{images}/heroes/${heroName}.png`;
};

class ScoreTable {
    constructor() {
        this.context = $.GetContextPanel();
        this.scoreboard = this.context.FindChildTraverse("Background");
        this.reportPanel = this.context.FindChildTraverse("ReportPanel");
        this.headerLabel = this.scoreboard.FindChildTraverse("Team_ScoreLabel");

        const firstHeroReport = this.reportPanel.FindChildTraverse("FistHeroReport");
        this.firstHeroImage = firstHeroReport.FindChildTraverse("ReportHeroImage");

        this.closed = true;
        this.hasReports = true;
        this.containers = [];
        this.players = {};

        this.firstReported = null;
        this.secondReported = null;

        // this.RewriteButton();
        GameEvents.Subscribe_custom("update_score_table", () => this.InitColumns());

        $.Schedule(1, () => {
            $.Msg("register");
            $.RegisterEventHandler("DOTACustomUI_SetFlyoutScoreboardVisible", $.GetContextPanel(), (bVisible) => {
                this.OpenScores(bVisible);
            });
        });

        this.InitColumns();
        //this.CreateKeybind();
    }
    
    InitColumns() {
        this.ClearColumns();
        this.CreateTables();
        this.SetColumns();     
    }

    CreateKeybind() 
    {
       const name_bind = "OpenScoreBoard" + Math.floor(Math.random() * 9999999);
       var keybind = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_SCOREBOARD_TOGGLE);
       Game.CreateCustomKeyBind(keybind, "+" + name_bind);
       Game.AddCommand("+" + name_bind, () => this.OpenScores(true), "", 0);
       Game.AddCommand("-" + name_bind, () => this.OpenScores(false), "", 0);
    }

    CheckFlyoutUpdate(bvisible)
    {
        $.Msg(bvisible, " ", " TEST")
    }

    ClearColumns() {
        this.scoreboard.FindChildrenWithClassTraverse("TeamContainer").forEach(i => i.DeleteAsync(0));
    }

    RewriteButton() {
        var buttonBar = FindDotaHudElement("ButtonBar");
        if (!buttonBar) return;

        var originalButton = buttonBar.FindChildTraverse("ToggleScoreboardButton");
        if (!originalButton) return;

        originalButton.ClearPanelEvent("onactivate");
        originalButton.SetPanelEvent("onactivate", () => this.OpenScores());
    }

    CreateTables() {
        const localPlayer = Game.GetLocalPlayerID();

        const teams = Game.GetAllTeamIDs();
        teams.forEach((team, index) => {
            const players = Game.GetPlayerIDsOnTeam(team);
            if (players.length === 0) return;

            const container = $.CreatePanel("Panel", this.scoreboard, `Team${index}_Container`, {
                class: "TeamContainer TopBottomFlow"
            });

            container.SetHasClass("LocalTeam", players.includes(localPlayer));

            players.forEach(player => {
                const player_info = Game.GetPlayerInfo(player);
                if (this.IsSpectator(player) || !player_info) return;

                const playerPanel = $.CreatePanel("Panel", container, "", {
                    hittest: false
                });
                playerPanel.BLoadLayoutSnippet("TeamPlayerSnippet");

                const isLocalPlayer = player === localPlayer;

                playerPanel.SetHasClass("LocalPlayer", isLocalPlayer);
                
                const muteButton = playerPanel.FindChildTraverse("PlayerMuteButton");
                
                muteButton.SetPanelEvent(
                    "onmouseover",
                    () => $.DispatchEvent(
                        "DOTAShowTitleTextTooltip",
                        muteButton,
                        "#DOTA_Scoreboard_Mute_Title",
                        "#DOTA_Scoreboard_Mute_Desc"
                    )
                );
                muteButton.SetPanelEvent(
                    "onmouseout",
                    () => $.DispatchEvent("DOTAHideTitleTextTooltip", muteButton)
                );

                muteButton.SetPanelEvent("onactivate", () => this.MutePlayer(player, muteButton));
                muteButton.SetHasClass("Muted", Game.IsPlayerMuted(player));

                const reportButton = playerPanel.FindChildTraverse("PlayerReportButton");
                
                reportButton.SetPanelEvent(
                    "onmouseover",
                    () => $.DispatchEvent("DOTAShowTextTooltip", reportButton, "#DOTA_Overwatch_Report_Header")
                );
                reportButton.SetPanelEvent(
                    "onmouseout",
                    () => $.DispatchEvent("DOTAHideTextTooltip", reportButton)
                );
                
                reportButton.SetPanelEvent("onactivate", () => this.ReportPlayer(player))
                
                const heroImage = playerPanel.FindChildTraverse("HeroImage");
                const image = $.CreatePanel("Panel", heroImage, "RealHeroImage");
                image.AddClass("RealHeroImage");
    
                const heroName = playerPanel.FindChildTraverse("HeroNameLabel");
                heroName.text = $.Localize(`#${player_info.player_selected_hero}`);
    
                const profileName = playerPanel.FindChildTraverse("ProfileLink");
                profileName.steamid = player_info.player_steamid;

                this.players[player] = playerPanel;
            });

            this.containers.push(container);
        });

        const reportHeroList = this.reportPanel.FindChildTraverse("HeroList");
        reportHeroList.RemoveAndDeleteChildren();

        const players = Game.GetAllPlayerIDs();
        players.forEach(player_id => {
            const heroPanel = $.CreatePanel("Panel", reportHeroList, "", {
                class: "HeroReport HeroReportList",
                hittest: true
            });
            heroPanel.player_id = player_id;

            heroPanel.SetPanelEvent("onactivate", () => this.SelectSecondReportHero(heroPanel));

            const heroImage = $.CreatePanel("Image", heroPanel, "ReportHeroImage");

            const heroName = getHeroImage(player_id);
            heroImage.SetImage(heroName);
        });
    }

    OpenScores(bVisible) {
        this.closed = !bVisible;

        this.CheckReportAvailable();

        if (this.closed) {
            this.HideReports()

            this.firstReported = null;
            this.secondReported = null;
        } else {
            this.UpdateStats();
        }

        this.scoreboard.SetHasClass("ScoreboardClosed", this.closed);
    }

    CheckReportAvailable() {
        const reportData = CustomNetTables.GetTableValue("reports", Players.GetLocalPlayer());
        this.hasReports = reportData !== undefined && reportData.report > 0;

        const reportsAllowed = Game.GetGameMode() === 1
        this.scoreboard.SetHasClass("SoloMode", reportsAllowed);

        // ЗАКОММЕНТИРОВАТЬ ДЛЯ ВЫПУСКА ОБНОВЫ
       // this.scoreboard.SetHasClass("SoloMode", true);

        this.scoreboard.SetHasClass("NoReports", !this.hasReports);
    }

    SetColumns() {
        const GetColumn = (panel, id) => {
            var column = panel.FindChildTraverse(id);
            return column.FindChildTraverse("Label");
        };
        
        Object.values(this.players).forEach(playerPanel => {
            playerPanel.levelColumn = GetColumn(playerPanel, "PlayerLevelColumn");
            playerPanel.killsColumn = GetColumn(playerPanel, "PlayerKillsColumn");
            playerPanel.deathsColumn = GetColumn(playerPanel, "PlayerDeathsColumn");
            playerPanel.epicsColumn = GetColumn(playerPanel, "PlayerEpicSpheresColumn");
            playerPanel.raresColumn = GetColumn(playerPanel, "PlayerRareSpheresColumn");
            playerPanel.legendaryColumn = playerPanel.FindChildTraverse("LegendaryImage");
            playerPanel.heroColumn = playerPanel.FindChildTraverse("RealHeroImage");
            playerPanel.colorColumn = playerPanel.FindChildTraverse("PlayerColor");
            playerPanel.nameColumn = playerPanel.FindChildTraverse("PlayerNameLabel");
            playerPanel.tipActiveColumn = playerPanel.FindChildTraverse("PlayerTipButton");
        });
    }

    UpdateStats() {
        const allKills = Game.GetAllPlayerIDs().map(id => Players.GetKills(id)).reduce((a, b) => a + b);
        
        this.headerLabel.text = allKills.toString();

        this.CheckReportAvailable();
        
        Object.entries(this.players).forEach(([id, container]) => {
            var player_id = parseInt(id);

            var tipButton = container.FindChildTraverse("PlayerTipButton");
            tipButton.SetPanelEvent("onactivate", () => TipPlayer(player_id));

            var table = CustomNetTables.GetTableValue("networth_players", id.toString());
            var local_table = CustomNetTables.GetTableValue("networth_players", Game.GetLocalPlayerID().toString());

            if (!table) return;

            const colorData = "#" + getNonNullValue(table.team_color, neutralColor);
            
            var dataList = {
                level: Players.GetLevel(player_id).toString(),
                kills: Players.GetKills(player_id).toString(),
                death: Players.GetDeaths(player_id).toString(),
                epic: getNonNullValue(table.purple, -1).toString(),
                rare: getNonNullValue(table.rare, -1).toString(),
                legendary: getNonNullValue(table.legendary, -1),
                hero: getNonNullValue(table.hero_name, ""),
                color: colorData,
                team_color: colorData,
                name: getNonNullValue(table.steam_id, 0),
                tipActive: getNonNullValue(table.tips_available, 0),
                lost: getNonNullValue(table.lost, -1),
            };

            if (dataList.hero == "")
            {
                container.tipActiveColumn.AddClass("panel_hidden")
                return
            }

            for (var [key, value] of Object.entries(dataMapping)) {
                var data = dataList[key];

                switch (key) {
                    case "legendary":
                        var icon = data != 0
                            ? `url("file://{images}/custom_game/icons/mini/${table.hero_name}/${data}.png")`
                            : `url("file://{images}/custom_game/no_skill.png")`;
                        
                        container.legendaryColumn.style.backgroundImage = icon;
                        container.legendaryColumn.style.backgroundSize = "100%";
                        break;
                    case "hero":
                        const image = Game.GetHeroImage(id, data);

                        container.heroColumn.style.backgroundImage = `url("file://{images}/heroes/${image}.png")`;
                        container.heroColumn.style.backgroundSize = "100%";
                        
                        break;
                    case "team_color":
                        if (Game.GetGameMode() != 1) {
                            container.colorColumn.style.backgroundColor = data;
                        }

                        break;
                    case "color":
                        if (Game.GetGameMode() == 1) {
                            const color = colorMapping[data];
                            if (color) container.colorColumn.style.backgroundColor = color;
                        }

                        break;
                    case "name":
                        let info = Game.GetPlayerInfo(player_id);

                        if (info.player_steamid != "0") {
                            container.nameColumn.steamid = data;
                        } else {
                            container.nameColumn.GetChild(0).text = info.player_name;
                        }

                        break;
                    case "tipActive":
                        if (local_table)
                        {
                            let text = $.Localize("#tip_info_unsub");

                            if (local_table.subscribed == 1) {
                                text = $.Localize("#tip_info_sub");

                                if (local_table && local_table.tips_cooldown && local_table.tips_cooldown > 0) {
                                    text = $.Localize("#tip_cd") + local_table.tips_cooldown.toString();
                                }
                            }

                            container.tipActiveColumn.SetPanelEvent(
                                'onmouseover',
                                () => $.DispatchEvent('DOTAShowTextTooltip', container.tipActiveColumn, text)
                            );
                            container.tipActiveColumn.SetPanelEvent(
                                'onmouseout',
                                () => $.DispatchEvent('DOTAHideTextTooltip', container.tipActiveColumn)
                            );
                        }
                        break;
                    case "lost":
                        if (data == 1) {
                            container.heroColumn.AddClass('hero_lost')
                        } else if (container.heroColumn.BHasClass("hero_lost")) {
                            container.heroColumn.RemoveClass('hero_lost')
                        }

                        break;

                    default:
                        container[value].text = data;
                        break;
                }
            }
        });

        if (!this.closed)
            $.Schedule(0.5, () => this.UpdateStats());
    }

    MutePlayer(playerId, panel) {
        if (playerId === -1 || playerId === Game.GetLocalPlayerID()) return;
        
        const muted = !Game.IsPlayerMuted(playerId);
        
        Game.SetPlayerMuted(playerId, muted);
        
        const icon = panel.FindChildTraverse("MuteIcon");
        if (icon) icon.SetHasClass("Muted", muted);
    }


    ReportPlayer(playerId) {
        const localPlayer = Game.GetLocalPlayerID();

        if (playerId === -1 || playerId === localPlayer) return;
        if (!this.hasReports) return;

        this.firstReported = playerId;
        this.secondReported = null;

        this.reportPanel.SetHasClass("ReadyToReportHero", false);
        this.reportPanel.SetHasClass("Visible", true);

        Game.EmitSound("UI.Click")
        this.firstHeroImage.SetImage(getHeroImage(playerId));

        for (let player_id in this.players)
        {
            let panel = this.players[player_id]
            
            let reportButton = panel.FindChildTraverse("PlayerReportButton");
            reportButton.SetPanelEvent("onactivate", () => this.HideReports()) 
        }

        const reportHeroList = this.reportPanel.FindChildTraverse("HeroList");
        reportHeroList.Children().forEach(child => {
            child.RemoveClass("Selected");
            child.RemoveClass("Unselected");

            child.visible = true;
            if (child.player_id === localPlayer || child.player_id === playerId) {
                child.visible = false;
            }
        });
    }

    HideReports() 
    {

        if (!this.reportPanel.BHasClass("Visible"))
            return

        Game.EmitSound("UI.Click")

        this.reportPanel.SetHasClass("Visible", false);  
        this.reportPanel.SetHasClass("ReadyToReportHero", false);

        for (let player_id in this.players)
        {
            let panel = this.players[player_id]
            
            let reportButton = panel.FindChildTraverse("PlayerReportButton");
            reportButton.SetPanelEvent("onactivate", () => this.ReportPlayer(Number(player_id))) 
        }
    }


    SelectSecondReportHero(panel) {
        const reportHeroList = this.reportPanel.FindChildTraverse("HeroList");
        reportHeroList.Children().forEach(child => {
            child.RemoveClass("Selected");
            child.AddClass("Unselected");
        });

        panel.AddClass("Selected");
        panel.RemoveClass("Unselected");

        const playerId = panel.player_id;
        this.secondReported = playerId;

        this.reportPanel.SetHasClass("ReadyToReportHero", true);
    }

    SendReportToServer() {
        if (this.firstReported === null || this.secondReported === null) return;
        if (this.firstReported === this.secondReported) return;

        GameEvents.SendCustomGameEventToServer_custom("send_report", {
			Hero_1: this.firstReported,
			Hero_2: this.secondReported
		});

        this.HideReports()

        this.firstReported = null;
        this.secondReported = null;

        this.CheckReportAvailable();
    }

    IsSpectator(id) {
        if (Players.IsSpectator(id)) return true;

        const localTeam = Players.GetTeam(id);

        return localTeam !== 2
            && localTeam !== 3
            && localTeam !== 6
            && localTeam !== 7
            && localTeam !== 12
            && localTeam !== 9;
    }
}

const table = new ScoreTable();
Game.CreateScoreBind(table)