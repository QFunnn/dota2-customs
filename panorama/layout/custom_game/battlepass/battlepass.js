--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


var invopened        = false;
var every_day_button = $('#Gold_everyday_reward');
var main             = $('#BP_container');
var BuyBP            = $('#BuyBP');
var ShowReward       = $('#ShowReward');
var BuyControl       = $('#BuyControl');
var PassSelectModal  = $('#PassSelectModal');
var BuyLevelsModal   = $('#BuyLevelsModal');
var BuyLevelsBtn     = $('#BuyLevels');
var current_tier     = null; // null | 'standard' | 'premium'

BuyControl.visible      = false;
ShowReward.visible      = false;
PassSelectModal.visible = false;
BuyLevelsModal.visible  = false;

// В новой системе БП только за коины — скрываем старую кнопку покупки за RP в BuyControl
$('#rp_button').visible = false;

var c = 0;
var timerId;
var sound_tick;

const DotaHUD = GameUI.CustomUIConfig().DotaHUD;
DotaHUD.windowControllers["bp"] = {
    is_open: false,
    open:  function() { GameEvents.SendCustomGameEventToServer("bp_v2_get", {}); },
    close: function() { main.visible = false; }
};
DotaHUD.ListenToMouseEvent(
    DotaHUD.GetCloseWindowOnOutsideClick(main, "bp")
);

main.visible = false;

var steamID = Game.GetPlayerInfo(Game.GetLocalPlayerID()).player_steamid;

var bpTimerSchedule = null;

function pad2(n) { return n < 10 ? '0' + n : '' + n; }

function startBPTimer(expiresAt) {
    // expiresAt — ISO datetime string с сервера (например "2026-06-20T16:03:35+00:00")
    var endTime = new Date(expiresAt).getTime() / 1000;
    if (bpTimerSchedule) $.CancelScheduled(bpTimerSchedule);
    function tick() {
        var remaining = Math.floor(endTime - Date.now() / 1000);
        if (remaining <= 0) {
            $('#BP_timer_label').text = $.Localize('#bp_season_ended');
            return;
        }
        var d = Math.floor(remaining / 86400);
        var h = Math.floor((remaining % 86400) / 3600);
        var m = Math.floor((remaining % 3600) / 60);
        var s = remaining % 60;
        $('#BP_timer_label').text = d + $.Localize('#bp_timer_days') + ' ' + pad2(h) + $.Localize('#bp_timer_hours') + ' ' + pad2(m) + $.Localize('#bp_timer_mins') + ' ' + pad2(s) + $.Localize('#bp_timer_secs');
        bpTimerSchedule = $.Schedule(1, tick);
    }
    tick();
}

// ===== ТАБЫ =====

function switchTab(tabName) {
    // Старые табы убраны
}

function switchQuestTab(type) {
    var isDaily = type === 'daily';
    $('#BP_daily_quests_section').visible  = isDaily;
    $('#BP_weekly_quests_section').visible = !isDaily;
    if (isDaily) {
        $('#BP_quest_tab_daily').AddClass('BP_tab_active');
        $('#BP_quest_tab_weekly').RemoveClass('BP_tab_active');
    } else {
        $('#BP_quest_tab_daily').RemoveClass('BP_tab_active');
        $('#BP_quest_tab_weekly').AddClass('BP_tab_active');
    }
}

// ===== ОТКРЫТИЕ / ЗАКРЫТИЕ =====

function open() {
    if (DotaHUD.IsWindowOpen("bp")) {
        DotaHUD.WindowClose("bp");
    } else {
        DotaHUD.WindowOpen("bp");
    }
}

function close() {
    main.visible = false;
    invopened = false;
}

// ===== ИНИЦИАЛИЗАЦИЯ (bp_v2_init) =====

function bp_init(t) {
    // Ник и аватар ставим всегда
    $('#BP_icon').steamid = steamID;
    $('#BP_name').steamid  = steamID;

    if (!t.has_bp) {
        current_tier = null;
        $('#BP_season_name').text = $.Localize('#bp_no_pass');
        $('#BP_timer_label').visible = false;
        BuyBP.visible = true;
        BuyBP.RemoveClass('bp_btn_disabled');
        BuyBP.SetPanelEvent('onmouseactivate', function() { buy_control(); });
        $('#BuyBP_text').text = $.Localize('#buy_bp');
        BuyLevelsBtn.style.opacity = '0';
        BuyLevelsBtn.SetPanelEvent('onmouseactivate', function() {});
        $('#BP_quest_tabs_row').visible        = true;
        $('#BP_daily_quests_section').visible  = true;
        $('#BP_weekly_quests_section').visible = false;
        switchQuestTab('daily');
        _render_quests(t.quests_daily,  '#BP_daily_quests_container');
        _render_quests(t.quests_weekly, '#BP_weekly_quests_container');
        var dailyPreview = t.daily_bonus || {};
        $('#Gold_everyday_reward_image').SetImage('file://{resources}/images/bp/lock.png');
        $('#Gold_everyday_reward_text').text = '+' + (dailyPreview.amount || 0) + ' RP';
        $('#Gold_everyday_reward').ClearPanelEvent('onmouseactivate');
        _render_level_rewards(t, null);
        main.visible = true;
        return;
    }
    $('#Gold_everyday_reward_image').SetImage('file://{resources}/images/custom_game/DS/protection.png');

    $('#BP_quest_tabs_row').visible = true;
    switchQuestTab('daily');

    current_tier = t.tier;

    // ===== КВЕСТЫ =====
    _render_quests(t.quests_daily,  '#BP_daily_quests_container');
    _render_quests(t.quests_weekly, '#BP_weekly_quests_container');

    invopened = !invopened;
    $('#BP_icon').steamid = steamID;
    $('#BP_name').steamid = steamID;

    // ===== ПРОГРЕСС-БАР =====
    var tab = GetHeroLevel(t.experience);
    var pan = $('#BP_exp_icon');

    $('#BP_icon_pr_bar').style.width = (940 / 100 * tab.percent) + "px";
    $('#BP_level_label').text        = $.Localize('#bp_level') + ' ' + t.level;
    $('#BP_exp_text').text           = tab.nexp + " / " + tab.need + " XP";

    pan.SetPanelEvent("onmouseover", function() {
        $.DispatchEvent("DOTAShowTextTooltip", pan, tab.nexp + ' ' + $.Localize('#bp_exp_of') + ' ' + tab.need);
    });
    pan.SetPanelEvent("onmouseout", TipsOut);

    // ===== ЕЖЕДНЕВНЫЙ БОНУС =====
    var daily = t.daily_bonus || {};
    $('#Gold_everyday_reward_text').text = daily.can_claim ? '+' + (daily.amount || 0) + ' RP' : '0 RP';
    every_day_button.ClearPanelEvent("onmouseactivate");
    if (daily.can_claim) {
        every_day_button.SetPanelEvent("onmouseactivate", function() {
            AddEveryDayReward();
        });
        every_day_button.RemoveClass('bp_daily_claimed');
    } else {
        every_day_button.AddClass('bp_daily_claimed');
    }

    // ===== UI ПОДПИСКИ =====
    updateSubscriberUI(t);

    // ===== ТАЙМЕР =====
    var timerLabel = $('#BP_timer_label');
    timerLabel.visible = true;
    startBPTimer(t.expires_at);

    // ===== НАЗВАНИЕ СЕЗОНА =====
    var nameMap = { 'standard': $.Localize('#bp_tier_standard'), 'premium': $.Localize('#bp_tier_premium') };
    $('#BP_season_name').text = nameMap[t.tier] || $.Localize('#bp_tier_default');

    main.visible = true;
    switchTab('rewards');

    _render_level_rewards(t, t.level);
}

// ===== РЕНДЕР КВЕСТОВ =====

function _to_array(raw) {
    if (!raw) return [];
    if (Array.isArray(raw)) return raw;
    var keys = Object.keys(raw).map(Number).sort(function(a, b) { return a - b; });
    return keys.map(function(k) { return raw[k]; });
}

function _render_quests(rawQuests, containerId) {
    var container = $(containerId);
    if (!container) return;
    container.RemoveAndDeleteChildren();

    var quests = _to_array(rawQuests);
    quests.sort(function(a, b) { return a.slot - b.slot; });

    for (var qi = 0; qi < quests.length; qi++) {
        var q = quests[qi];
        var PassPanel = $.CreatePanel("Panel", container, "Quest_" + containerId + "_" + q.slot);
        PassPanel.BLoadLayoutSnippet("quest_content");

        var questName = q.quest_name;
        var questImg  = 'npc_custom.png';
        var questDesc = '';
        if (questName.includes('damage_quest')) {
            questImg  = 'damage_quest.png';
            questDesc = $.Localize("#deal_damage_quest") + " " + q.target;
        } else if (questName.includes('spray_quest') || questName.includes('highfive_quest')) {
            questImg  = questName + '.png';
            questDesc = $.Localize("#" + questName) + " " + q.target;
        } else if (questName.indexOf('hero_play_') === 0) {
            var heroId = questName.slice('hero_play_'.length);
            questDesc = $.Localize("#hero_play_quest") + " " + $.Localize("#" + heroId) + ": " + q.target;
        } else if (questName.indexOf('hero_win_') === 0) {
            var heroId = questName.slice('hero_win_'.length);
            questDesc = $.Localize("#hero_win_quest") + " " + $.Localize("#" + heroId) + ": " + q.target;
        } else if (questName === 'games_played' || questName === 'win_quest' || questName === 'ward_quest') {
            questDesc = $.Localize("#" + questName) + " " + q.target;
        } else {
            questDesc = $.Localize("#kill_quest") + " " + q.target + " " + $.Localize("#" + questName);
        }
        PassPanel.FindChildInLayoutFile("Player_quest_image").style.backgroundImage = "url('file://{resources}/images/bp/quests/" + questImg + "')";
        PassPanel.FindChildInLayoutFile("Player_quest_image_desc").text = questDesc;
        PassPanel.FindChildInLayoutFile("Player_quest_image_progress").text = q.progress + "/" + q.target;
        PassPanel.FindChildInLayoutFile("MMMRPointsLabel").text = q.reward;
        var lockIcon = PassPanel.FindChildInLayoutFile("quest_lock_icon");
        if (!q.is_active) {
            PassPanel.AddClass('quest_locked');
            if (lockIcon) lockIcon.visible = true;
        } else {
            if (lockIcon) lockIcon.visible = false;
        }
        PassPanel.FindChildInLayoutFile("done").visible = q.completed;
    }
}

// ===== РЕНДЕР НАГРАД ЗА УРОВНИ =====
// bp_level = null если нет БП (ничего не кликабельно)

function _render_level_rewards(t, bp_level) {
    var panel = $('#BP_content_bottom');
    panel.RemoveAndDeleteChildren();

    var levelRewards = _to_array(t.level_rewards);

    for (var ri = 0; ri < levelRewards.length; ri++) {
        var r        = levelRewards[ri];
        var lvl      = r.level;
        var name     = r.reward;
        var isClaimed = r.claimed;
        var canClaim  = bp_level !== null && lvl <= bp_level && !isClaimed;

        var PassPanel = $.CreatePanel("Panel", panel, "Pass_Panel_" + lvl);
        PassPanel.BLoadLayoutSnippet("pass_container");
        PassPanel.FindChildInLayoutFile("pass_content_level_simple").text = lvl;
        PassPanel.FindChildInLayoutFile("pass_content_image_lock").visible = (bp_level === null || lvl > bp_level);

        var item      = PassPanel.FindChildInLayoutFile("pass_content_image_simple");
        var image     = PassPanel.FindChildInLayoutFile("pass_content_image_simple_image");
        var reward_bp = PassPanel.FindChildInLayoutFile("free_bp");

        if (name && name.indexOf('item_') === 0) {
            image.visible = false;
            item.visible  = true;
            item.itemname = name;
        } else {
            image.visible = true;
            item.visible  = false;
            image.SetImage('file://{resources}/images/bp/rew/' + name + '.png');
            (function(rb, n) {
                rb.SetPanelEvent("onmouseover", function() {
                    $.DispatchEvent("DOTAShowTextTooltip", rb, $.Localize('#' + n));
                });
                rb.SetPanelEvent("onmouseout", TipsOut);
            })(reward_bp, name);
        }

        if (canClaim) {
            reward_bp.AddClass('pass_content_back_simple');
            (function(p, rb, level) {
                p.SetPanelEvent("onmouseactivate", function() { TakeReward(rb, level); });
            })(PassPanel, reward_bp, lvl);
        } else {
            PassPanel.ClearPanelEvent("onmouseactivate");
            if (isClaimed) reward_bp.AddClass('pass_content_claimed');
        }
    }
}

// ===== ЛОГИКА ПОДПИСКИ =====

function updateSubscriberUI(t) {
    BuyLevelsBtn.style.opacity = '1';
    BuyLevelsBtn.SetPanelEvent('onmouseactivate', function() { buyLevels(); });

    BuyBP.visible = true;

    if (!t.has_bp) {
        BuyLevelsBtn.style.opacity = '0';
        BuyLevelsBtn.SetPanelEvent('onmouseactivate', function() {});
        $('#BuyBP_text').text = $.Localize('#buy_bp');
        BuyBP.SetPanelEvent('onmouseactivate', function() { buy_control(); });
        BuyBP.RemoveClass('bp_btn_disabled');
        BuyBP.ClearPanelEvent('onmouseover');
        BuyBP.ClearPanelEvent('onmouseout');
    } else if (t.tier === 'standard') {
        $('#BuyBP_text').text = $.Localize('#bp_upgrade_to_premium');
        BuyBP.SetPanelEvent('onmouseactivate', function() { buy_control(); });
        BuyBP.RemoveClass('bp_btn_disabled');
        BuyBP.ClearPanelEvent('onmouseover');
        BuyBP.ClearPanelEvent('onmouseout');
    } else {
        // Премиум — кнопка не кликабельна, показывает тултип
        $('#BuyBP_text').text = $.Localize('#bp_tier_premium');
        BuyBP.AddClass('bp_btn_disabled');
        BuyBP.ClearPanelEvent('onmouseactivate');
        BuyBP.SetPanelEvent('onmouseover', function() {
            $.DispatchEvent('DOTAShowTitleTextTooltip', BuyBP,
                $.Localize('#bp_tier_premium'),
                $.Localize('#bp_prem_feature_1') + '<br>' +
                $.Localize('#bp_prem_feature_2') + '<br>' +
                $.Localize('#bp_prem_feature_3') + '<br>' +
                $.Localize('#bp_prem_feature_4'));
        });
        BuyBP.SetPanelEvent('onmouseout', TipsOut);
    }
}

// ===== КУПИТЬ / АПГРЕЙД =====

function buy_control() {
    if (!current_tier) {
        PassSelectModal.visible = true;
    } else if (current_tier === 'standard') {
        // Показываем тот же модал но только с премиум-карточкой
        $('#PassSelect_title').text       = $.Localize('#bp_upgrade_to_premium');
        $('#PassSelect_subtitle').text    = $.Localize('#bp_upgrade_subtitle');
        $('#PassCard_std').style.opacity        = '0';
        $('#PassCard_prem_price_gems').text      = '50';
        $('#PassCard_prem_price_rp').text        = '5000';
        PassSelectModal.visible = true;
    }
}

function buy_control_close() {
    BuyControl.visible = false;
}

function passSelectClose() {
    PassSelectModal.visible = false;
    // Восстановить дефолтный вид для следующего открытия без БП
    $('#PassSelect_title').text    = $.Localize('#bp_select_pass');
    $('#PassSelect_subtitle').text = $.Localize('#bp_select_subtitle');
    $('#PassCard_std').style.opacity   = '1';
    $('#PassCard_prem_price_gems').text = '150';
    $('#PassCard_prem_price_rp').text   = '15000';
}

// tier: 'standard' | 'premium' (что покупаем); currency: 'gems' | 'rp' (чем платим)
function buy(tier, currency) {
    var action;
    if      (current_tier === 'standard')  action = 'upgrade';        // апгрейд до премиума
    else if (tier === 'standard')          action = 'buy_standard';
    else                                   action = 'buy_premium';
    currency = currency || 'gems';
    BuyControl.visible      = false;
    PassSelectModal.visible = false;
    Game.EmitSound("cas.item_has_been_sold");
    GameEvents.SendCustomGameEventToServer("bp_v2_buy", { action: action, currency: currency });
}

function buyLevels() {
    if (!current_tier) return;
    BuyLevelsModal.visible = true;
}

function buyLevelsClose() {
    BuyLevelsModal.visible = false;
}

function buyLevelPack(amount) {
    BuyLevelsModal.visible = false;
    Game.EmitSound("cas.item_has_been_sold");
    GameEvents.SendCustomGameEventToServer("buy_bp_levels", { amount: amount });
}

// ===== ЕЖЕДНЕВНАЯ НАГРАДА =====

function AddEveryDayReward() {
    every_day_button.ClearPanelEvent("onmouseactivate");
    every_day_button.AddClass('bp_daily_claimed');
    GameEvents.SendCustomGameEventToServer("bp_v2_claim_daily_bonus", {});
}

function updateDailyValue(count) {
    count -= 1;
    if (count < 0) {
        $.Schedule(0.01, function() {
            Game.StopSound(sound_tick);
            Game.EmitSound("Plus.shards_tally");
            $('#Gold_everyday_reward_text').text = '0 RP';
        });
    } else {
        $('#Gold_everyday_reward_text').text = count + ' RP';
        $.Schedule(0.01, function() {
            updateDailyValue(count);
        });
    }
}

function bp_daily_bonus_received(t) {
    sound_tick = Game.EmitSound("Shards.Count");
    updateDailyValue(t.rp_earned);
}

// ===== КЛЕЙМ НАГРАДЫ ЗА УРОВЕНЬ =====

function TakeReward(button, level) {
    button.ClearPanelEvent("onmouseactivate");
    button.RemoveClass('pass_content_back_simple');
    GameEvents.SendCustomGameEventToServer("bp_v2_claim_level_reward", { level: level });
}

function bp_level_reward_received(t) {
    if (!t.rewards || t.rewards.length === 0) return;
    Game.EmitSound("Plus.shards_tally");
    // Обновляем UI
    GameEvents.SendCustomGameEventToServer("bp_v2_get", {});
}

// ===== АВТО-ЗАВЕРШЕНИЕ КВЕСТА =====

function bp_quest_completed(t) {
    Game.EmitSound("Plus.shards_tally");
    // Показываем уведомление о выполненном квесте и полученных RP
    Show_reward({ rp_back: t.rp });
}

// ===== ОШИБКИ =====

function bp_error(t) {
    $.Msg("[BP_V2] Ошибка: " + (t.error || 'unknown'));
}

// ===== РАСЧЁТ УРОВНЯ =====

function GetHeroLevel(experience) {
    var expNeeded = 250;
    var expAtStart = 0;
    var level = 0;
    while (experience >= expNeeded && level < 100) {
        experience  -= expNeeded;
        expAtStart   = expNeeded;
        level       += 1;
        expNeeded   += 50;
    }
    return {
        level:   level,
        percent: expNeeded > 0 ? (experience / expNeeded * 100) : 100,
        need:    expNeeded,
        nexp:    experience
    };
}

// ===== ПОКАЗ НАГРАДЫ =====

function Show_reward(tab) {
    ShowReward.visible = true;
    var image      = ShowReward.FindChildInLayoutFile("reward_image");
    var item_image = ShowReward.FindChildInLayoutFile("reward_item_image");
    var label      = ShowReward.FindChildInLayoutFile("reward_item_label");

    ShowReward.RemoveClass("animate-show");
    ShowReward.style.transform = 'scale3d(0, 0, 0)';
    ShowReward.AddClass("animate-show");

    function updateReward(imagePath, labelText, hideItemImage) {
        image.visible      = true;
        image.SetImage(imagePath);
        item_image.visible = !hideItemImage;
        label.text         = labelText;
    }

    if (tab.guild_exp > 0) updateReward('file://{resources}/images/bp/rew/guild_exp_50.png',    "+" + tab.guild_exp, true);
    if (tab.rp > 0)        updateReward('file://{resources}/images/bp/rew/rp_25.png',           "+" + tab.rp,        true);
    if (tab.rp_back > 0)   updateReward('file://{resources}/images/bp/rew/rp_25.png',           "+" + tab.rp_back,   true);
    if (tab.acc_exp > 0)   updateReward('file://{resources}/images/bp/rew/account_exp_150.png', "+" + tab.acc_exp,   true);
    if (tab.bless > 0)     updateReward('file://{resources}/images/bp/rew/bless.png',           "+" + tab.bless,     true);
    if (tab.soul > 0)      updateReward('file://{resources}/images/bp/rew/soul.png',            "+" + tab.soul,      true);

    if (tab.items) {
        for (var key in tab.items) {
            if (tab.items.hasOwnProperty(key)) {
                var value = tab.items[key];
                if (value > 0) {
                    updateReward('file://{resources}/images/bp/rew/rp_25.png', "+" + value, false);
                } else {
                    image.visible       = false;
                    item_image.visible  = true;
                    item_image.itemname = key;
                    label.text          = $.Localize("#DOTA_Tooltip_ability_") + key;
                }
            }
        }
    }

    if (!timerId) timerId = $.Schedule(1, timer);
}

function timer() {
    $.Schedule(1, function() {
        if (c > 2) {
            ShowReward.visible = false;
            timerId = null;
            c = 0;
        } else {
            c++;
            timer();
        }
    });
}

// ===== ПОДСКАЗКИ =====

function TipsOver(message, pos) {
    var panel = $("#" + pos);
    if (panel) $.DispatchEvent("DOTAShowTextTooltip", panel, $.Localize("#" + message));
}
function TipsOut() {
    $.DispatchEvent("DOTAHideTitleTextTooltip");
    $.DispatchEvent("DOTAHideTextTooltip");
}

// ===== ПОДПИСКИ =====

(function() {
    GameEvents.Subscribe("bp_v2_init",                  bp_init);
    GameEvents.Subscribe("bp_v2_quest_completed",       bp_quest_completed);
    GameEvents.Subscribe("bp_v2_level_reward_received", bp_level_reward_received);
    GameEvents.Subscribe("bp_v2_daily_bonus_received",  bp_daily_bonus_received);
    GameEvents.Subscribe("bp_v2_error",                 bp_error);
    GameEvents.Subscribe("Show_reward",                 Show_reward);
    GameUI.LoopTime.Schedule(0.0, () => {
        DotaHUD.CreateTopBarButton("file://{images}/bp/bpopen.png", "bp", open, "bp");
    });
})();