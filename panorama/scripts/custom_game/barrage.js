--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const linesUsing = [];
const playerMessageTypes = {
    pvp_lose_aegis: "#lose_aegis",
    pvp_stack_curse: "#stack_curse",
    report_actor: "#marked_as_actor",
    bot_take_over: "#bot_take_over",
};
const relearnBookMessages = {
    1: "#compensate_torn_bookx2",
    2: "#compensate_relearn_and_torn_book",
    3: "#compensate_relearn_and_torn_bookx2",
};
function getFreeLineNumber() {
    for (let i = 0; i < linesUsing.length; i++) {
        if (!linesUsing[i]) {
            return i;
        }
    }
}
function getOrCreatePanel(lineNumber) {
    return $.CreatePanel("Panel", $("#BarrgeMainPanel"), `BulletPanel_${lineNumber}`);
}
function getPlayerData(playerId) {
    return {
        playerInfo: Game.GetPlayerInfo(playerId),
        heroName: Players.GetPlayerSelectedHero(playerId),
    };
}
function getImagePanel(panel, id) {
    return panel.FindChildTraverse(id);
}
function getLabelPanel(panel, id) {
    return panel.FindChildTraverse(id);
}
function setHeroIcon(panel, heroName) {
    getImagePanel(panel, "HeroIcon").SetImage(`file://{images}/heroes/icons/${heroName}.png`);
}
function initPlayerPanel(panel, playerId, snippet) {
    const { playerInfo, heroName } = getPlayerData(playerId);
    panel.BLoadLayoutSnippet(snippet);
    setHeroIcon(panel, heroName);
    return { playerInfo, heroName };
}
function setTeamVisuals(panel, teamId) {
    const customConfig = GameUI.CustomUIConfig();
    if (customConfig.team_colors) {
        const teamColor = customConfig.team_colors[teamId];
        if (teamColor) {
            getImagePanel(panel, "ShieldColor").style.washColor = teamColor;
        }
    }
    if (customConfig.team_icons) {
        const teamIcon = customConfig.team_icons[teamId];
        if (teamIcon) {
            getImagePanel(panel, "TeamIcon").SetImage(teamIcon);
        }
    }
}
function setPlayerName(panel, value) {
    getLabelPanel(panel, "PlayerName").text = value;
}
function finalizePanel(panel, lineNumber) {
    linesUsing[lineNumber] = true;
    panel.style.marginTop = `${lineNumber * 80}px`;
    $.Schedule(10, () => {
        linesUsing[lineNumber] = false;
    });
    $.Schedule(16.5, () => {
        panel.DeleteAsync(0);
    });
}
const barrageHandlers = {
    round_finish: (panel, keys) => {
        if (keys.playerId === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "FinishRound");
        setPlayerName(panel, `${playerInfo.player_name} `);
        getLabelPanel(panel, "GoldValue").text = String(keys.gold_value);
        return true;
    },
    bet_summary: (panel, keys) => {
        if (keys.teamId === undefined) {
            return false;
        }
        const teamName = $.Localize(Game.GetTeamDetails(keys.teamId).team_name);
        panel.BLoadLayoutSnippet("BetSummary");
        getLabelPanel(panel, "GoldValue").text = String(keys.gold_value);
        getLabelPanel(panel, "TeamName").text = ` ${teamName} `;
        setTeamVisuals(panel, keys.teamId);
        return true;
    },
    bet_summary_solo: (panel, keys) => {
        if (keys.playerId === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "BetSummarySolo");
        getLabelPanel(panel, "GoldValue").text = String(keys.gold_value);
        setPlayerName(panel, ` ${playerInfo.player_name}`);
        return true;
    },
    bet_win: (panel, keys) => {
        if (keys.playerId === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "BetWin");
        getLabelPanel(panel, "GoldValue").text = String(keys.gold_value);
        setPlayerName(panel, playerInfo.player_name);
        return true;
    },
    pvp_win: (panel, keys) => {
        if (keys.playerId === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "PvpWin");
        getLabelPanel(panel, "GoldValue").text = String(keys.gold_value);
        setPlayerName(panel, playerInfo.player_name);
        return true;
    },
    bet_jackpot: (panel, keys) => {
        if (keys.playerId === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "BetJackpot");
        getLabelPanel(panel, "GoldValue").text = String(keys.gold_value);
        setPlayerName(panel, playerInfo.player_name);
        return true;
    },
    team_lose: (panel, keys) => {
        if (keys.nTeamNumber === undefined) {
            return false;
        }
        const teamPlayers = Game.GetPlayerIDsOnTeam(keys.nTeamNumber);
        const teamName = $.Localize(Game.GetTeamDetails(keys.nTeamNumber).team_name);
        const playerNames = `(${teamPlayers
            .map((playerId) => `${Game.GetPlayerInfo(playerId).player_name} `)
            .join("")})`;
        panel.BLoadLayoutSnippet("TeamLose");
        setTeamVisuals(panel, keys.nTeamNumber);
        getLabelPanel(panel, "TeamName").text = teamName;
        setPlayerName(panel, playerNames);
        return true;
    },
    chat_wheel: (panel, keys) => {
        if (keys.playerId === undefined || keys.itemName === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "PlayerSay");
        setPlayerName(panel, `${playerInfo.player_name}: `);
        getLabelPanel(panel, "Content").text = $.Localize(`#chat_wheel_full_${keys.itemName}`);
        return true;
    },
    pvp_lose_aegis: createPlayerMessageHandler("pvp_lose_aegis"),
    pvp_stack_curse: createPlayerMessageHandler("pvp_stack_curse"),
    compensate_relearn_book: (panel, keys) => {
        if (keys.playerId === undefined || keys.round_number === undefined || keys.book_type === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "CompensateRelearnBook");
        const contentToken = relearnBookMessages[keys.book_type];
        if (!contentToken) {
            return false;
        }
        setPlayerName(panel, `${playerInfo.player_name} `);
        getLabelPanel(panel, "RoundNumber").text = String(keys.round_number);
        getLabelPanel(panel, "Content").text = $.Localize(contentToken);
        return true;
    },
    aegis_lose_compensate: (panel, keys) => {
        if (keys.playerId === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "CompensateAegisLoseRelearnBook");
        setPlayerName(panel, `${playerInfo.player_name} `);
        getLabelPanel(panel, "Content").text = $.Localize("#aegis_lose_compensate");
        return true;
    },
    add_extra_creature: (panel, keys) => {
        if (keys.playerId === undefined || keys.creatureName === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "PlayerSay");
        setPlayerName(panel, `${playerInfo.player_name} `);
        getLabelPanel(panel, "Content").text = $.Localize("#release") + $.Localize(`#${keys.creatureName}`);
        return true;
    },
    report_actor: createPlayerMessageHandler("report_actor"),
    bot_take_over: createPlayerMessageHandler("bot_take_over"),
    settle_pumpkin_king: (panel, keys) => {
        if (keys.playerId === undefined || keys.damage === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "SettlePumpkinKing");
        setPlayerName(panel, `${playerInfo.player_name} `);
        getLabelPanel(panel, "DamageValue").text = (keys.damage / 1000).toFixed(1);
        getLabelPanel(panel, "GoldValue").text = String(keys.gold_value);
        return true;
    },
};
function createPlayerMessageHandler(type) {
    return (panel, keys) => {
        if (keys.playerId === undefined) {
            return false;
        }
        const { playerInfo } = initPlayerPanel(panel, keys.playerId, "PlayerSay");
        setPlayerName(panel, type === "report_actor" || type === "bot_take_over" ? playerInfo.player_name : `${playerInfo.player_name} `);
        getLabelPanel(panel, "Content").text = $.Localize(playerMessageTypes[type]);
        return true;
    };
}
function FireBullet(keys) {
    const lineNumber = getFreeLineNumber();
    if (lineNumber === undefined) {
        return;
    }
    const handler = barrageHandlers[keys.type];
    if (!handler) {
        return;
    }
    const panel = getOrCreatePanel(lineNumber);
    const handled = handler(panel, keys);
    if (!handled) {
        panel.DeleteAsync(0);
        return;
    }
    panel.AddClass("Default");
    finalizePanel(panel, lineNumber);
}
for (let i = 0; i <= 9; i++) {
    linesUsing.push(false);
}
GameEvents.Subscribe("FireBullet", FireBullet);