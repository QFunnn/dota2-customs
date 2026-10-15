--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
// 结束界面(end.xml / EndScreen)的数据填充。
// 注意：本文件运行在 EndScreen layout 自己的 JS 上下文里，和 gem_board.xml 的 gemtd.js 不是同一个上下文，
//       所以这里只读 custom net table（net table 全局可见），不依赖 gemtd.js 里的任何变量。
//   game_state / send_ranking    —— 服务器结算(send_ranking)时写入的战绩数据
//   game_state / send_ranking_cb —— 游戏内 catch_crab 请求排行榜后的返回(名次百分比等)

var end_local_id = Game.GetPlayerInfo(Players.GetLocalPlayer()).player_steamid;

function end_time_str(t) {
    if (t > 362439) t = 362439;
    var h = 0, m = 0, s = 0;
    if (!t) return "00:00:00";

    t = parseInt(t);
    h = Math.floor(t / 3600);
    m = Math.floor((t - h * 3600) / 60);
    s = t - h * 3600 - m * 60;

    h = h < 10 ? '0' + h : h;
    m = m < 10 ? '0' + m : m;
    s = s < 10 ? '0' + s : s;
    return h + ':' + m + ':' + s;
}

// 塔列表字符串: "unit:count,unit:count,...|level|time|gold|extra_kill|maze_length"
function end_parse_towers(raw) {
    var result = [];
    if (!raw) return result;
    var tower_part = String(raw).split("|")[0];
    var parts = tower_part.split(",");
    for (var i = 0; i < parts.length; i++) {
        if (!parts[i]) continue;
        var t = parts[i].split(":");
        var name = t[0];
        if (!name) continue;
        var count = parseInt(t[1]);
        if (isNaN(count) || count < 1) count = 1;
        var level = TOWER_LEVEL[name] || 0;
        var color = TOWER_LEVEL_COLOR[level] || "#888888";
        result.push({ name: name, count: count, level: level, color: color });
    }
    result.sort(function(a, b) {
        if (b.level !== a.level) return b.level - a.level;
        return b.count - a.count;
    });
    return result;
}

function end_update_towers(raw) {
    var list = $("#end_game_tower_list");
    if (!list) return;
    list.RemoveAndDeleteChildren();
    var towers = end_parse_towers(raw);
    var per_row = 10;
    var item_w = 88;
    var gap = 0;
    var row = null;
    var rows = [];
    for (var i = 0; i < towers.length; i++) {
        if (i % per_row == 0) {
            row = $.CreatePanel("Panel", list, "");
            row.style["width"] = "100%";
            row.style["height"] = "80px";
            row.style["flow-children"] = "right";
            row.style["horizontal-align"] = "center";
            rows.push(row);
        }

        var t = towers[i];
        var p = $.CreatePanel("Panel", row, "");
        p.style["width"] = item_w + "px";
        p.style["height"] = "78px";
        p.style["margin-right"] = gap + "px";
        p.style["flow-children"] = "down";
        p.style["border-top"] = "0px";
        p.style["border-right"] = "0px";
        p.style["border-left"] = "0px";
        p.style["border-bottom"] = "0px";

        var imgBox = $.CreatePanel("Panel", p, "");
        imgBox.style["width"] = "74px";
        imgBox.style["height"] = "46px";
        imgBox.style["overflow"] = "clip";
        imgBox.style["horizontal-align"] = "center";
        imgBox.style["margin-top"] = "2px";

        var img = $.CreatePanel("Image", imgBox, "");
        img.SetImage("file://{images}/custom_game/towers/" + t.name + ".png");
        img.style["width"] = "74px";
        img.style["height"] = "64px";
        img.style["vertical-align"] = "center";

        var label = $.CreatePanel("Label", p, "");
        label.text = "x" + t.count;
        label.style["width"] = "100%";
        label.style["height"] = "30px";
        label.style["font-size"] = "28px";
        label.style["color"] = t.color;
        label.style["text-align"] = "center";
        label.style["horizontal-align"] = "center";
        label.style["font-family"] = "defaultFont";
        label.style["font-weight"] = "bold";

        (function(panel, tower) {
            panel.SetPanelEvent("onmouseover", function () {
                var towerName = "<font color='" + tower.color + "'>" + $.Localize('#' + tower.name) + "</font>";
                $.DispatchEvent("DOTAShowTitleTextTooltip", panel, towerName, "");
            });
            panel.SetPanelEvent("onmouseout", function () {
                $.DispatchEvent("DOTAHideTitleTextTooltip");
                $.DispatchEvent("DOTAHideTextTooltip");
            });
        })(p, t);
    }
    for (var r = 0; r < rows.length; r++) {
        var count = Math.min(per_row, towers.length - r * per_row);
        rows[r].style["width"] = (count * (item_w + gap)) + "px";
    }
}

function end_update_avatars(raw) {
    var ids = [];
    if (raw) ids = String(raw).split(",");
    if (ids.length == 0 || (ids.length == 1 && !ids[0])) {
        ids = [];
        for (var p = 0; p <= 3; p++) {
            var info = Game.GetPlayerInfo(p);
            if (info && info.player_steamid) ids.push(info.player_steamid);
        }
    }
    for (var i = 1; i <= 4; i++) {
        var av = $("#end_game_avatar_" + i);
        if (!av) continue;
        av.steamid = ids[i - 1] || "";
        av.SetHasClass("invisible", false);
    }
    var list = $("#end_game_avatar_list");
    if (list) {
        list.style["width"] = "256px";
    }
}

// 引擎判定的胜者是不是天辉(DOTA_TEAM_GOODGUYS = 2，也就是玩家方)
// 结算数据缺失时(作弊标记、没上传成绩等)用它兜底，保证标题不会空着
function end_is_goodguys_win() {
    var winner = null;
    try {
        winner = Game.GetGameWinner();
    } catch (e) {
        winner = null;
    }
    return winner == 2;
}

// 标题：不再区分胜负，统一显示 GAME OVER（只保留胜负音效的差别）
function end_apply_title(is_win) {
    if (!$("#panel_end_game")) return;
    if (is_win) {
        Game.EmitSound("Loot_Drop_Stinger_Arcana");
    }
    else {
        Game.EmitSound("diretide_roshdeath_Stinger");
    }
    $("#label_end_game_title").text = "GAME OVER";
}

// game_state / send_ranking：标题 + 战绩 + 塔 + 迷宫长度 + 头像
function end_fill_ranking(data) {
    if (!data || !$("#panel_end_game")) return;

    // 与结算面板一致的胜负判定：等级 > 50 算通关；没有等级数据就看引擎判的胜者
    var is_win = data.level ? (parseInt(data.level) > 50) : end_is_goodguys_win();
    end_apply_title(is_win);

    $("#label_end_game_subtitle2").text = (parseInt(data.level) - 1);
    $("#label_end_game_subtitle6").text = (data.kills || 0);
    $("#label_end_game_subtitle4").text = end_time_str(data.time_cost);

    end_update_towers(data.towers);

    var maze_length = data.maze_length || 0;
    $("#end_game_maze_length").text = maze_length;

    end_update_avatars(data.player_ids);

    $("#panel_end_game").style["opacity"] = 0.95;
}

// game_state / send_ranking_cb：击败了 x% 的 nP 玩家 + 星级
function end_fill_ranking_cb(data) {
    if (!data || !data.crab || !$("#panel_end_game")) return;
    if (data.user && end_local_id && String(data.user) != String(end_local_id)) return;

    var object = null;
    try {
        object = JSON.parse(data.crab);
    } catch (e) {
        return;
    }
    if (!object || object.err == 1200) return;

    var beat_percent = Math.floor(((1.0 - (parseInt(object.rank) + 0.0) / (parseInt(object.total) || 1)) * 100));
    if (isNaN(beat_percent)) beat_percent = 0;
    if (beat_percent < 0) beat_percent = 0;
    if (beat_percent > 100) beat_percent = 100;

    var stars = "★";
    if (beat_percent >= 99) {
        stars = "★★★★★";
    }
    else if (beat_percent >= 90) {
        stars = "★★★★";
    }
    else if (beat_percent >= 75) {
        stars = "★★★";
    }
    else if (beat_percent >= 50) {
        stars = "★★";
    }

    $("#label_beat_percent").text = $.Localize('#' + "end_game_beat_1") + beat_percent + $.Localize('#' + "end_game_beat_2") + object.player_count + $.Localize('#' + "end_game_beat_3") + stars;

    // 通关奖励（原来在 gemtd.js 的 Hud 里弹，会被结束界面压住，现在在结束界面上弹）
    if (object.award > 0) {
        open_panel_award('gem', 'shell', '', object.award, 'pass');
    }
    if (object.award_extend) {
        open_panel_award('gem', 'item', 'extend', 1, 'pass');
    }
    if (object.award_item) {
        open_panel_award('gem', 'item', object.award_item, 1, 'pass');
    }
}

// ---- 通关奖励弹窗（由 window.js 的 open_panel_award/close_panel_award 复制而来；
//      Hud 里那份继续给商店/幸运箱/赛季/CDK 等流程用，两边各自独立的 layout 作用域）----
var RARITY_COLOR_BG = {1:'rgba(128,128,128,0.7)',2:'rgba(96,96,255,0.7)',3:'rgba(200,0,200,0.8)',4:'rgba(255,128,0,0.9)'};
var is_panel_award_poping = false;

function close_panel_award(){
    if (!$('#panel_award')) return;
    $('#panel_award').style['position'] = '0px -1000px 0px';
    $('#panel_award').style['opacity'] = '0';
    Game.EmitSound("ui.books.pageturns");
    $.Schedule(0.5,function(){
        is_panel_award_poping = false;
    });
}

// game=gem/sm/dac  award=shell/item/hero/...  count=数量  from=pass/season/...
function open_panel_award(game,award,id,count,from){
    if (!$('#panel_award')) return;

    if (is_panel_award_poping){
        $.Schedule(0.5,function(){
            open_panel_award(game,award,id,count,from);
        });
    }
    else{
        $('#panel_award').style['position'] = '0px 0px 0px';
        $('#panel_award').style['opacity'] = '1';
        Game.EmitSound("ui.trophy_levelup");
        is_panel_award_poping = true;

        // 背景
        $('#panel_award_bgimg').SetImage('file://{images}/custom_game/panel_award_bgimg_'+game+'.jpg');
        if (game == 'dac'){
            $('#panel_award_bgimg_zhezhao').style['background-color'] = 'rgba(0,0,0,0.9)';
        }
        if (game == 'sm'){
            $('#panel_award_bgimg_zhezhao').style['background-color'] = 'rgba(0,0,0,0.5)';
        }
        if (game == 'gem'){
            $('#panel_award_bgimg_zhezhao').style['background-color'] = 'rgba(0,0,0,0.7)';
        }
        // 文字
        $('#panel_award_title_subtitle').text = $.Localize('#'+'award_subtitle_'+game);
        $('#panel_award_title_desc').text = $.Localize('#'+'award_from_'+from);
        $('#panel_award_title_text').text = $.Localize('#'+'award_name_'+award+'_'+id);
        $('#panel_award_title_count').text = '× '+count;
        var color = parseInt(id.substr(1,1)) || 1;
        $('#panel_award_title').style['background-color'] = RARITY_COLOR_BG[color];
        $('#panel_award_title_desc').style['color'] = '#fff';
        // 图片
        if (award=='shell' || award=='ice' || award=='candy'){
            $('#panel_award_img').SetHasClass('invisible',true);
            $('#panel_award_img_small').SetHasClass('invisible',false);
            $('#panel_award_img_hero').SetHasClass('invisible',true);
            $('#panel_award_img_small').SetImage('file://{images}/custom_game/award_'+award+'.png');
            $('#panel_award_title_desc').style['color'] = '#fff';
        }
        if (award=='card'){
            $('#panel_award_img').SetHasClass('invisible',false);
            $('#panel_award_img_small').SetHasClass('invisible',true);
            $('#panel_award_img_hero').SetHasClass('invisible',true);
            $('#panel_award_img').SetImage('file://{images}/custom_game/award_daccard_'+id+'.png');
            $('#panel_award_title_desc').style['color'] = '#fff';
        }
        if (award=='hero'){
            $('#panel_award_img').SetHasClass('invisible',true);
            $('#panel_award_img_small').SetHasClass('invisible',true);
            $('#panel_award_img_hero').SetHasClass('invisible',false);
            $('#panel_award_img_hero').heroname = GEM_HERO_LIST[id];
            $('#panel_award_title_desc').text = $.Localize('#'+'award_rarity_'+color)+' '+$.Localize('#'+'award_type_hero');
            $('#panel_award_title_text').text = $.Localize('#'+GEM_HERO_LIST[id]);
        }
        if (award=='skater'){
            $('#panel_award_img').SetHasClass('invisible',false);
            $('#panel_award_img_small').SetHasClass('invisible',true);
            $('#panel_award_img_hero').SetHasClass('invisible',true);
            $('#panel_award_img').SetImage('file://{images}/custom_game/lottery/'+id+'.png');
            $('#panel_award_title_desc').text = $.Localize('#'+'award_rarity_'+color)+' '+$.Localize('#'+'award_type_skater');
            $('#panel_award_title_text').text = $.Localize('#'+id);
        }
        if (award=='effect'){
            $('#panel_award_img').SetHasClass('invisible',false);
            $('#panel_award_img_small').SetHasClass('invisible',true);
            $('#panel_award_img_hero').SetHasClass('invisible',true);
            $('#panel_award_img').SetImage('file://{images}/custom_game/lottery/'+id+'.png');
            $('#panel_award_title_desc').text = $.Localize('#'+'award_rarity_'+color)+' '+$.Localize('#'+'award_type_effect');
            $('#panel_award_title_text').text = $.Localize('#'+id);
        }
        if (award=='smability'){
            $('#panel_award_img').SetHasClass('invisible',false);
            $('#panel_award_img_small').SetHasClass('invisible',true);
            $('#panel_award_img_hero').SetHasClass('invisible',true);
            $('#panel_award_img').SetImage('file://{images}/custom_game/lottery/'+id+'.png');
            $('#panel_award_title_desc').text = $.Localize('#'+'award_rarity_'+color)+' '+$.Localize('#'+'award_type_smability');
            $('#panel_award_title_text').text = $.Localize('#'+id);
        }
        if (award=='gemability'){
            $('#panel_award_img').SetHasClass('invisible',false);
            $('#panel_award_img_small').SetHasClass('invisible',true);
            $('#panel_award_img_hero').SetHasClass('invisible',true);
            $('#panel_award_img').SetImage('file://{images}/custom_game/lottery/gem_'+id+'.png');
            $('#panel_award_title_desc').text = $.Localize('#'+'award_rarity_'+color)+' '+$.Localize('#'+'award_type_gemability');
            $('#panel_award_title_text').text = $.Localize('#'+id);
        }
        if (award=='item'){
            if (id=='extend' || TOY_LIST[id]){
                $('#panel_award_img').SetHasClass('invisible',false);
                $('#panel_award_img_small').SetHasClass('invisible',true);
                $('#panel_award_img_hero').SetHasClass('invisible',true);
                $('#panel_award_img').SetImage('file://{images}/custom_game/award_item_'+(id||TOY_LIST[id])+'.png');
                $('#panel_award_title_desc').style['color'] = '#fff';
                $('#panel_award_title_text').text = $.Localize('#'+'award_name_item_'+(id||TOY_LIST[id]));
            }
            else{
                $('#panel_award_img').SetHasClass('invisible',true);
                $('#panel_award_img_small').SetHasClass('invisible',false);
                $('#panel_award_img_hero').SetHasClass('invisible',true);
                $('#panel_award_img_small').SetImage('file://{images}/custom_game/award_item_'+id+'.png');
                $('#panel_award_title_desc').style['color'] = '#fff';
            }
        }
    }
}

function OnEndGameStateChanged(table, key, data) {
    if (key == 'send_ranking') {
        end_fill_ranking(data);
    }
    if (key == 'send_ranking_cb') {
        end_fill_ranking_cb(data);
    }
}
CustomNetTables.SubscribeNetTableListener("game_state", OnEndGameStateChanged);

(function () {
    // 结算数据是服务器先写、游戏结束后才加载这个结束界面，所以进来先主动读一次现值
    if (!$("#panel_end_game")) return;

    var rank_data = CustomNetTables.GetTableValue("game_state", "send_ranking");
    if (rank_data) {
        end_fill_ranking(rank_data);
    }
    else {
        // 没有结算数据(作弊标记/未上传等)：至少按引擎判定的胜者把标题显示出来
        end_apply_title(end_is_goodguys_win());
    }

    var cb_data = CustomNetTables.GetTableValue("game_state", "send_ranking_cb");
    if (cb_data) end_fill_ranking_cb(cb_data);

    // 兜底：即使没有结算数据也把面板显示出来，避免结束界面全黑
    $("#panel_end_game").style["opacity"] = 0.95;
})();