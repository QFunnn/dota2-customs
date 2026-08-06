--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]




var data = CustomNetTables.GetTableValue("dac_table", 'end_board');
if (data) {
    $("#endgame_curtain").style['opacity'] = 1;
    $("#race_gameover").style['opacity'] = 1;
    $("#race_gameover").style['transform'] = 'scale3d( 1, 1, 1);';
    Game.EmitSound("dac.endboard");

    $('#race_gameover').SetHasClass("invisible", false);
    var local_id = Game.GetPlayerInfo(Players.GetLocalPlayer()).player_steamid;
    var arr = [];
    for (var d in data.data) {
        data.data[d].steamid = d;
        arr.push(data.data[d]);
    }
    arr.sort(function (a, b) {
        return a.rank - b.rank;
    });

    // 经济条：统计最大金钱
    var max_money = 0, max_width = 100;
    for (var i = 0; i < arr.length; i++) {
        var info = arr[i];
        var money = info.total_money;
        if (money > max_money) {
            max_money = money;
        }
    }
    if (max_money < 25) {
        max_money = 25;
    }
    max_width = max_money * 2;
    if (max_width < 50) {
        max_width = 50;
    }

    for (var i = 0; i < arr.length; i++) {
        var info = arr[i];
        var index = i + 1; //index是1~8，i是0~7
        if (arr[i].rank) {
            $("#end_rank_" + index).text = arr[i].rank;
        }
        $("#end_rank_" + index).SetHasClass("invisible", false);
        $("#end_board_player_" + index).SetHasClass("have_bg", true);

        var lineup_worth = 0;
        if (arr[i].chess_lineup) {
            var str = arr[i].chess_lineup;
            // 显示阵容
            var chess_lineup_arr = str.split(',');
            var chess_arr = [];
            // 去除空的和无效的
            for (var j = 0; j < chess_lineup_arr.length; j++) {
                if (chess_lineup_arr[j]) {
                    chess_arr.push(chess_lineup_arr[j]);
                }
            }
            //排序
            chess_arr.sort(function (a, b) {
                var score_b = 0;
                var score_a = 0;

                if (a.indexOf('11') > -1) {
                    score_a += 10000;
                }
                if (b.indexOf('11') > -1) {
                    score_b += 10000;
                }
                if (a.indexOf('1') > -1) {
                    score_a += 100;
                }
                if (b.indexOf('1') > -1) {
                    score_b += 100;
                }
                score_a += get_chess_cost(a);
                score_b += get_chess_cost(b);

                return score_b - score_a;
            });
            //显示i的阵容！
            var container = $('#panel_end_lineup_container_' + index);
            if (!container) {
                break;
            }
            container.RemoveAndDeleteChildren();

            for (var j = 0; j < chess_arr.length; j++) {
                var chess = chess_arr[j];
                var chess_ori = chess;
                var chess_star = 1;
                var chess_star_str = "■";
                var chess_level = 1;

                if (chess.indexOf('11') > -1) {
                    chess_star = 3;
                    chess_star_str = "■■■";
                    chess = chess.substr(0, chess.length - 2);
                    chess_level = 9;
                }
                if (chess.indexOf('1') > -1) {
                    chess_star_str = "■■";
                    chess_star = 2;
                    chess = chess.substr(0, chess.length - 1);
                    chess_level = 3;
                }
                var chess_name = CHESS_2_HERO[chess];
                var chess_index = j + 1;
                lineup_worth += chess_level * (CHESS_2_LEVEL[chess] || 1);

                // if (!$("#chess_lineup_" + (i + 1) + "_" + chess_index)) {
                //     break;
                // }

                // 显示棋子头像
                var outer = $.CreatePanel('Panel', container, 'panel_end_lineup_outer_' + index + '_' + chess_index, {
                    style: 'width:40px;height:60px;flow-children:down;',
                });
                $.CreatePanel('DOTAHeroImage', outer, 'panel_end_lineup_icon_' + index + '_' + chess_index, {
                    style: 'width:40px;height:40px;',
                    heroname: chess_name,
                    heroimagestyle: 'icon',
                });
                var stars = $.CreatePanel('Label', outer, 'panel_end_lineup_stars_' + index + '_' + chess_index, {
                    style: 'horizontal-align:center;vertical-align:top;font-size:10px;letter-spacing:3px;text-shadow:0px 0px 2px 2 #000000;',
                    text: chess_star_str,
                    heroimagestyle: 'icon',
                });
                if (LEVEL_2_COLOR[CHESS_2_LEVEL[chess]]) {
                    var color = LEVEL_2_COLOR[CHESS_2_LEVEL[chess]];
                    stars.style['color'] = color;
                }
                stars.style['width'] = (chess_star * 7 + (chess_star - 1) * 3) + 'px';

                SetPanelMouseOverText('panel_end_lineup_outer_' + index + '_' + chess_index, $.Localize('#' + chess));
            }

        }
        if (arr[i].is_vip) {
            $("#end_avatar_player_vip_" + (i + 1)).SetHasClass("invisible", false);
            $("#end_avatar_player_vip_badge_" + (i + 1)).SetHasClass("invisible", false);
        }
        else {
            $("#end_avatar_player_vip_" + (i + 1)).SetHasClass("invisible", true);
            $("#end_avatar_player_vip_badge_" + (i + 1)).SetHasClass("invisible", true);
        }
        if (arr[i].p2team) {
            $("#p2team_flag_" + (i + 1)).SetImage("file://{images}/custom_game/p2team_" + arr[i].p2team + ".png");
            $("#p2team_flag_" + (i + 1)).SetHasClass("invisible", false);
        }

        $("#end_avatar_" + (i + 1)).steamid = arr[i].steamid;
        $("#end_player_" + (i + 1)).steamid = arr[i].steamid;
        $("#end_player_" + (i + 1)).SetHasClass("invisible", false);

        $("#end_level_" + (i + 1)).style['background-image'] = 'url("file://{images}/custom_game/level_' + arr[i].mmr_level + '.png")';
        $("#end_level_" + (i + 1)).SetHasClass("invisible", false);

        if (arr[i].delta > 0) {
            if (arr[i].level_delta > 0) {
                $('#end_level_lbl_delta_' + (i + 1)).text = "▲♫";
            }
            else {
                $('#end_level_lbl_delta_' + (i + 1)).text = "▲";
            }
            $('#end_level_lbl_delta_' + (i + 1)).style['color'] = "#88ff88";
        }
        if (arr[i].delta < 0) {
            if (arr[i].level_delta < 0) {
                $('#end_level_lbl_delta_' + (i + 1)).text = "▼♭";
            }
            else {
                $('#end_level_lbl_delta_' + (i + 1)).text = "▼";
            }
            $('#end_level_lbl_delta_' + (i + 1)).style['color'] = "#ff0000";
        }

        // $('#end_level_lbl_delta_'+(i+1)).text = "▲♫";
        // $('#end_level_lbl_delta_'+(i+1)).style['color'] = "#88ff88";

        var queen_rank = arr[i].queen_rank;
        if (arr[i].mmr_level >= 38 && queen_rank) {
            $("#end_level_lbl_" + (i + 1)).text = $.Localize('#' + 'text_player_level_' + arr[i].mmr_level) + '#' + queen_rank;
        }
        else {
            $("#end_level_lbl_" + (i + 1)).text = $.Localize('#' + 'text_player_level_' + arr[i].mmr_level);
        }

        if (arr[i].mmr_level > 0) {
            $("#end_level_lbl_" + (i + 1)).style['color'] = '#fff';
        }
        else {
            $("#end_level_lbl_" + (i + 1)).style['color'] = '#888';
        }
        $('#end_hero_' + (i + 1)).style['background-image'] = "url('file://{images}/custom_game/skaters/" + arr[i].zhugong + ".png')";
        $("#end_hero_" + (i + 1)).SetHasClass("invisible", false);
        // $("#end_wave_"+(i+1)).text = arr[i].round;
        $("#end_win_" + (i + 1)).text = arr[i].win_round + '-' + arr[i].lose_round;

        $("#end_money_" + (i + 1)).text = '$' + (arr[i].total_money || 0);

        $("#end_damage_" + (i + 1)).text = (arr[i].hero_damage || 0) + '-' + (arr[i].hero_damaged || 0);

        $("#end_hero_level_" + (i + 1)).text = arr[i].hero_level || 0;
        $("#panel_end_hero_level_" + (i + 1)).SetHasClass('invisible', false);


        // 天赋树
        InitTalentTreeNew('panel_end_talent_tree_' + (i + 1));
        if (arr[i].talent_tree) {
            var talent_learned_list = [];
            for (var j = 1; j <= 4; j++) {
                if (arr[i].talent_tree[j]) {
                    talent_learned_list.push(arr[i].talent_tree[j].split('_')[1]);
                }
            }
            for (var j = 5; j <= 8; j++) {
                if (arr[i].talent_tree[j]) {
                    talent_learned_list.push(arr[i].talent_tree[j].split('_')[1]);
                }
            }
            //点亮已经学习了的天赋 
            var text = '';
            for (var j = 0; j < talent_learned_list.length; j++) {
                var t = talent_learned_list[j];
                SetTalentTreePipStatus('panel_end_talent_tree_' + (i + 1), t, true);
            }
        }

        if (arr[i].duration) {
            var m = Math.floor(arr[i].duration / 60);
            var s = Math.floor(arr[i].duration - 60 * m);
            $("#end_duration_" + (i + 1)).text = (m < 10 ? '0' + m : m) + ':' + (s < 10 ? '0' + s : s);
        }


        var text = '';
        if (arr[i].biscuit) {
            text += '<Panel id="panel_end_board_award_biscuit_' + (i + 1) + '" class="panel_end_board_award_line1"><Image id = "img_end_board_biscuit_1" src="file://{images}/custom_game/award_biscuit.png" class="img_end_board_award_candy"/><Label id = "text_end_board_award_biscuit_1" text = "+ ' + arr[i].biscuit + '" class="text_end_board_award_candy" style="font-family:titleFont;color:#88ff88;"/></Panel>';
        }
        if (arr[i].candy_award && arr[i].candy_award == -999) {
            text += '<Panel id="panel_end_board_award_candy_' + (i + 1) + '" class="panel_end_board_award_line2"><Image id = "img_end_board_candy_' + (i + 1) + '"  src="file://{images}/custom_game/award_skeleton.png" class="img_end_board_award_candy"/><Label id = "text_end_board_award_candy_' + (i + 1) + '"  text = "- ' + 0 + '" class="text_end_board_award_candy"  style="font-family:titleFont;color:#bbbbbb;"/></Panel>';
        }
        else if (arr[i].candy_award || arr[i].candy_award == 0) {
            if (arr[i].candy_award > 0) {
                text += '<Panel id="panel_end_board_award_candy_' + (i + 1) + '" class="panel_end_board_award_line2"><Image id = "img_end_board_candy_' + (i + 1) + '"  src="file://{images}/custom_game/award_candy.png" class="img_end_board_award_candy"/><Label id = "text_end_board_award_candy_' + (i + 1) + '" text = "+ ' + arr[i].candy_award + '" class="text_end_board_award_candy"  style="font-family:titleFont;color:#88ff88;"/></Panel>';
            }
            else if (arr[i].candy_award < 0) {
                text += '<Panel id="panel_end_board_award_candy_' + (i + 1) + '" class="panel_end_board_award_line2" ><Image id = "img_end_board_candy_' + (i + 1) + '"  src="file://{images}/custom_game/award_candy.png" class="img_end_board_award_candy"/><Label id = "text_end_board_award_candy_' + (i + 1) + '"  text = "- ' + (-arr[i].candy_award) + '" class="text_end_board_award_candy"  style="font-family:titleFont;color:#ff4444;"/></Panel >';
            }
            else if (Game.GetMapInfo().map_display_name == 'candy_5_1x8') {
                text += '<Panel id="panel_end_board_award_candy_' + (i + 1) + '" class="panel_end_board_award_line2"><Image id = "img_end_board_candy_' + (i + 1) + '"  src="file://{images}/custom_game/award_candy.png" class="img_end_board_award_candy"/><Label id = "text_end_board_award_candy_' + (i + 1) + '"  text = "+ ' + 0 + '" class="text_end_board_award_candy"  style="font-family:titleFont;color:#bbbbbb;"/></Panel>';
            }
        }
        $('#panel_end_board_award_' + (i + 1)).RemoveAndDeleteChildren();
        // $('#panel_end_board_award_'+(i+1)).BCreateChildren(text);
        CreateChildren($('#panel_end_board_award_' + (i + 1)), text);

        //更新经济条
        if ($('#end_panel_player_details_g_bar_' + (i + 1))) {

            var g_bar_width = (1.0 * info.total_money / max_money) * max_width;
            if (g_bar_width < 50) {
                g_bar_width = 50;
            }
            if (g_bar_width > 1000) {
                g_bar_width = 1000;
            }
            var lineup_worth_width = (1.0 * lineup_worth / max_money) * max_width;
            // if (lineup_worth_width < 50){
            //     lineup_worth_width = 50;
            // }
            if (lineup_worth_width > 1200) {
                lineup_worth_width = 1200;
            }
            $('#end_panel_player_details_g_bar_bar_total_' + (i + 1)).style['width'] = g_bar_width + 'px;';

            $('#end_panel_player_details_g_bar_bar_' + (i + 1)).style['width'] = lineup_worth_width + 'px;';
            $('#end_panel_player_details_g_bar_text_' + (i + 1)).text = '$' + lineup_worth;
            $('#end_panel_player_details_g_bar_text_' + (i + 1)).style['margin-left'] = (lineup_worth_width + 5) + 'px;';

            // if (lineup_worth_width > 30){

            // }
            // else{
            //     $('#panel_player_details_g_bar_text_'+player_id).text = '';
            // }
            // $('#panel_player_details_g_bar_total_text_'+player_id).text = '$'+lineup_worth;
        }

        if (local_id != arr[i].steamid) {
            $('#panel_end_report_' + (i + 1)).SetHasClass('invisible', false);
        }
        else {
            // 高亮自己
            $('#race_line_' + (i + 1)).style['background-color'] = 'gradient( linear, 0% 0%, 100% 0%, from( #7990b622 ), to( #7990b600 ) )';
        }

        if (arr[i].buff) {
            $('#end_buff_' + (i + 1)).RemoveAndDeleteChildren();
            // $('#end_buff_'+(i+1)).BCreateChildren(GetShowBuffXML(arr[i].buff));
            CreateChildren($('#end_buff_' + (i + 1)), GetShowBuffXML(arr[i].buff));
        }

        ShowRelicAndRelicHistory($('#end_relic_' + (i + 1)), arr[i].relic, arr[i].relic_history);
    }
}




var is_reported = false;
function report(n) {
    if (is_reported) {
        return;
    }
    if (!$('#img_end_report_' + n).GetAttributeString('report', '')) {
        GameEvents.SendCustomGameEventToServer("dac_report", { "reporter": Game.GetPlayerInfo(Players.GetLocalPlayer()).player_steamid, "cheatuser": $('#end_player_' + n).steamid });
        $('#img_end_report_' + n).SetImage("file://{images}/custom_game/report_red.png");
        $('#img_end_report_' + n).SetAttributeString('report', 1);
        is_reported = true;
    }
}
function get_chess_cost(chess) {
    var chess_name = chess;
    if (chess_name.indexOf('11') > -1) {
        chess_name = chess_name.substr(0, chess_name.length - 2);
    }
    if (chess_name.indexOf('1') > -1) {
        chess_name = chess_name.substr(0, chess_name.length - 1);
    }
    return CHESS_2_LEVEL[chess_name] || 0;
}


function ShowRelicAndRelicHistory(panel, relic, history) {
    panel.RemoveAndDeleteChildren();
    var container = $.CreatePanel('Panel', panel, '', {
        style: 'width:130px;flow-children:right;horizontal-align:center;vertical-align:center;',
    });

    var container_inner = $.CreatePanel('Panel', container, '', {
        style: 'flow-children:right;horizontal-align:center;vertical-align:center;',
    });
    var first = $.CreatePanel('Panel', container_inner, '', {
        style: 'vertical-align:center;max-height:60px;',
    });
    var first1 = $.CreatePanel('Panel', first, '', {
        style: 'flow-children:down-wrap;horizontal-align:center;vertical-align:center;max-height:60px;',
    });
    if (history) {
        var history_arr = [];
        for (var i in history) {
            var r = history[i].relic;
            history_arr.push(r);
        }
        for (var i = 0; i < history_arr.length - 1; i++) {
            var rr = $.CreatePanel('Panel', first1, '', {
                style: 'width:20px;height:20px;margin-right:3px;margin-top:1px;margin-bottom:1px;overflow:clip clip;',
            });
            $.CreatePanel('DOTAItemImage', rr, '', {
                style: 'width:40px;height:25px;horizontal-align:center;vertical-align:center;',
                itemname: history_arr[i],
            });
        }
    }

    var last = $.CreatePanel('Panel', container_inner, '', {
        style: 'width:55px;height:45px;margin-left:5px;flow-children:right;vertical-align:center;overflow:clip clip;',
    });
    $.CreatePanel('DOTAItemImage', last, '', {
        style: 'width:61px;height:45px;horizontal-align:center;vertical-align:center;',
        itemname: relic || 'item_null',
    });
}

function SetPanelMouseOverTitleText(id, title, text) {
    if ($(id)) {
        $(id).SetPanelEvent("onmouseover",
            function () {
                $.DispatchEvent("DOTAShowTitleTextTooltip", $(id), title, text);
            }
        );
        $(id).SetPanelEvent("onmouseout",
            function () {
                $.DispatchEvent("DOTAHideTitleTextTooltip");
            }
        );
    }
}
function SetPanelMouseOverText(id, text) {
    if ($('#' + id)) {
        $('#' + id).SetPanelEvent("onmouseover",
            function () {
                $.DispatchEvent("DOTAShowTextTooltip", $('#' + id), text);
            }
        );
        $('#' + id).SetPanelEvent("onmouseout",
            function () {
                $.DispatchEvent("DOTAHideTextTooltip");
            }
        );
    }
}