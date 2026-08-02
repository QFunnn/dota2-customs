--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]



GameEvents.Subscribe("msg_box", (keys) => {
    show_msg(keys.text,keys.icon,keys.duration||3);
});

var RARITY_COLOR_BG = { 1: 'rgba(128,128,128,0.7)', 2: 'rgba(96,96,255,0.7)', 3: 'rgba(200,0,200,0.8)', 4: 'rgba(255,128,0,0.9)' };
var RARITY_COLOR_TEXT = { 1: 'rgba(255,255,255,1)', 2: 'rgba(128,128,255,1)', 3: 'rgba(255,0,255,1)', 4: 'rgba(255,128,0,1)' };

// 通用弹出窗
var is_panel_award_poping = false;
function close_panel_award() {
    // FindDotaHudElement('panel_award').style['position'] = '0px -1000px 0px';
    // FindDotaHudElement('panel_award').style['opacity'] = '0';
    FindDotaHudElement('panel_award').SetHasClass('show',false);
    Game.EmitSound("ui.books.pageturns");
    $.Schedule(0.5, function () {
        is_panel_award_poping = false;
    });
}

// game=gem/sm/dac
// award=shell/ice/candy/hero/skater/card/effect/item/smability/gemability/chessboard/emotion
// count=数量
// from=shellstore/icestore/candystore/cdkey/pass/season/hidden/lucky/beginner
function open_panel_award(game, award, id, count, from) {
    if (is_panel_award_poping) {
        $.Schedule(0.1, function () {
            open_panel_award(game, award, id, count, from);
        });
    }
    else {
        if (!FindDotaHudElement('panel_award')) return;
        // FindDotaHudElement('panel_award').style['position'] = '0px 0px 0px';
        // FindDotaHudElement('panel_award').style['opacity'] = '1';
        FindDotaHudElement('panel_award').SetHasClass('show',true);

        Game.EmitSound("ui.trophy_levelup");
        is_panel_award_poping = true;

        FindDotaHudElement('panel_award_title_count').text = "";

        // 背景
        FindDotaHudElement('panel_award_bgimg').SetImage('file://{images}/custom_game/panel_award_bgimg_' + game + '.jpg');
        if (game == 'dac') {
            FindDotaHudElement('panel_award_bgimg_zhezhao').style['background-color'] = 'rgba(0,0,0,0.9)';
        }
        if (game == 'sm') {
            FindDotaHudElement('panel_award_bgimg_zhezhao').style['background-color'] = 'rgba(0,0,0,0.5)';
        }
        if (game == 'gem') {
            FindDotaHudElement('panel_award_bgimg_zhezhao').style['background-color'] = 'rgba(0,0,0,0.7)';
        }
        // 文字
        FindDotaHudElement('panel_award_title_subtitle').text = $.Localize('#'+'award_subtitle_' + game);
        FindDotaHudElement('panel_award_title_desc').text = $.Localize('#'+'award_from_' + from);
        if (award == 'courier' || award == 'chessboard' || award == 'emotion') {
            FindDotaHudElement('panel_award_title_text').text = $.Localize('#'+id);
        }
        else {
            FindDotaHudElement('panel_award_title_text').text = $.Localize('#'+'award_name_' + award + '_' + id);
        }
        if (count){
            FindDotaHudElement('panel_award_title_count').text = '× ' + count; 
        } 
        
        var color = parseInt(id.substr(1, 1)) || 1;
        FindDotaHudElement('panel_award_title').style['background-color'] = RARITY_COLOR_BG[color];
        FindDotaHudElement('panel_award_title_desc').style['color'] = '#bbb';

        FindDotaHudElement('panel_award_img').SetHasClass('invisible', false);
        FindDotaHudElement('panel_award_img').SetHasClass('small', false);
        FindDotaHudElement('panel_award_img').SetHasClass('big', false);
        FindDotaHudElement('panel_award_emotion').RemoveAndDeleteChildren();
        FindDotaHudElement('panel_award_tag_container').RemoveAndDeleteChildren();

        // 图片
        if (award == 'shell' || award == 'ice' || award == 'candy') {
            FindDotaHudElement('panel_award_img').SetHasClass('small', true);
            FindDotaHudElement('panel_award_img').SetImage('file://{images}/custom_game/award_' + award + '.png');
        }
        if (award == 'courier') {
            FindDotaHudElement('panel_award_img').SetHasClass('small', true);
            FindDotaHudElement('panel_award_img').SetImage('file://{images}/custom_game/skaters/' + id + '.png');
            var rarity = id.slice(1, 2) || 1;
            show_tag(FindDotaHudElement('panel_award_tag_container'),[{text:'rarity_'+rarity,color:COLOR[''+rarity]},{text:'type_h',color:COLOR[1]}]);
        }
        if (award == 'chessboard') {
            FindDotaHudElement('panel_award_img').SetHasClass('big', true);
            FindDotaHudElement('panel_award_img').SetImage('file://{images}/custom_game/chessboard/' + id + '.png');
            var rarity = id.slice(1, 2) || 1;
            show_tag(FindDotaHudElement('panel_award_tag_container'),[{text:'rarity_'+rarity,color:COLOR[''+rarity]},{text:'type_b',color:COLOR[1]}]);
        }
        if (award == 'emotion') {
            var m_info = EMOTION_LIST[id]; 

            var text = "";
            var emotion_schema = "<Panel class='emotion_one' id = 'emotion_list_EMOTIONID' style='transform: scale3d( EMOTIONSIZE, EMOTIONSIZE, EMOTIONSIZE);width:200px;height:200px;'><Image src='file://{images}/custom_game/chat/EMOTIONID.png'/></Panel>";
            text += emotion_schema.replace(/EMOTIONID/g, m_info.emotion_index).replace(/EMOTIONSIZE/g, m_info.size);

            CreateChildren(FindDotaHudElement('panel_award_emotion'), text);
            
            FindDotaHudElement('panel_award_img').SetHasClass('invisible', true);
            var rarity = id.slice(1, 2) || 1;
            show_tag(FindDotaHudElement('panel_award_tag_container'),[{text:'rarity_'+rarity,color:COLOR[''+rarity]},{text:'type_m',color:COLOR[1]}]);
        }

        FindDotaHudElement('panel_award_ok').SetPanelEvent(
            "onactivate",
            function () {
                close_panel_award();
            }
        );
        
    }
}

// open_panel_award('dac','emotion','m303','1','cdkey'); 
// open_panel_award('dac','emotion','m303','1','cdkey'); 






// 弹提示框
function show_msg(text,icon,duration,sound) {
    FindDotaHudElement('msg_box_text').text = $.Localize(text);
    FindDotaHudElement('msg_box').SetHasClass('invisible', false);

    if (!icon){
        FindDotaHudElement('msg_box_image').visible = false;
    }
    else{
        FindDotaHudElement('msg_box_image').visible = true;
        FindDotaHudElement('msg_box_image').SetImage(icon);
    }

    Game.EmitSound(sound || "ui.trophy_levelup");

    $.Schedule(duration||3, function () {
        FindDotaHudElement('msg_box').SetHasClass('invisible', true);
    });
}

function show_confirm(text, fun, obj, toggle_obj) {
    FindDotaHudElement('confirmtextall').text = text;
    // FindDotaHudElement('confirmtextall').text = text;

    if (FindDotaHudElement('confirm_content')){
        FindDotaHudElement('confirm_content').RemoveAndDeleteChildren();
    }
    
    if (obj && obj.ban_synergy){

        var chess_list = obj.chess_list;
        var chess_list_all = {
            1: [],
            2: [],
            3: [],
            4: [],
            5: [],
        };
        for (var i in chess_list){
            var chess = chess_list[i];
            var cost = CHESS_2_LEVEL[chess];
            var hero_name = CHESS_2_HERO[chess];
            chess_list_all[cost].push({
                chess: chess,
                hero_name: hero_name,
            });
        }
        ShowSynergyTooltipsSmallIconsInner(chess_list_all, FindDotaHudElement('confirm_content'));
    }

    if (toggle_obj){
        var toggle_skip_animation_container = $.CreatePanel('Panel', FindDotaHudElement('confirm_content'), 'toggle_skip_animation_container', {
            style: 'horizontal-align:right;'
        });
        $.CreatePanel('ToggleButton', toggle_skip_animation_container, 'toggle_confirm', {
            style: 'horizontal-align:center;',
            selected: toggle_obj.selected || false,
            text: toggle_obj.toggle_text || '???',
        });
    }

    FindDotaHudElement('btnarea').RemoveAndDeleteChildren();

    // FindDotaHudElement('btnarea').BCreateChildren('<Label class="confirmres" text="" onactivate="'+fun+'"></Label><Label class="confirmrej" text="" onactivate="close_confirm()"></Label>');
    // CreateChildren(FindDotaHudElement('btnarea'), '<Label class="confirmres" text="" onactivate="' + fun + '"></Label><Label class="confirmrej" text="" onactivate="close_confirm()"></Label>');

    var btn_yes = $.CreatePanel('Panel', FindDotaHudElement('btnarea'), 'btn_yes', {
        class: 'confirmres',
    });
    var btn_no =  $.CreatePanel('Panel', FindDotaHudElement('btnarea'), 'btn_no', {
        class: 'confirmrej',
    });
    btn_yes.SetPanelEvent(
		"onactivate",
		function () {
			fun();
		}
	);
    btn_no.SetPanelEvent(
		"onactivate",
		function () {
			FindDotaHudElement('confirm_box').SetHasClass('invisible', true);
		}
	);

    FindDotaHudElement('confirm_box').SetHasClass('invisible', false);
}

// open_panel_award('gem','gemability','h402','1','candystore');