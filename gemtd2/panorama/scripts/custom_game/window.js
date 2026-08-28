--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


var RARITY_COLOR_BG = {1:'rgba(128,128,128,0.7)',2:'rgba(96,96,255,0.7)',3:'rgba(200,0,200,0.8)',4:'rgba(255,128,0,0.9)'};
var RARITY_COLOR_TEXT = {1:'rgba(255,255,255,1)',2:'rgba(128,128,255,1)',3:'rgba(255,0,255,1)',4:'rgba(255,128,0,1)'};

// 通用弹出窗
var is_panel_award_poping = false;
function close_panel_award(){
    $('#panel_award').style['position'] = '0px -1000px 0px';
    $('#panel_award').style['opacity'] = '0';
    Game.EmitSound("ui.books.pageturns");
    $.Schedule(0.5,function(){
        is_panel_award_poping = false;
    });
}
// game=gem/sm/dac
// award=shell/ice/candy/hero/skater/card/effect/item/smability/gemability
// count=数量
// from=shellstore/icestore/candystore/cdkey/pass/season/hidden/luckybox
function open_panel_award(game,award,id,count,from){

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
            // $('#panel_award_title_desc').style['color'] = RARITY_COLOR_TEXT[color];
            $('#panel_award_title_desc').text = $.Localize('#'+'award_rarity_'+color)+' '+$.Localize('#'+'award_type_hero');
            $('#panel_award_title_text').text = $.Localize('#'+GEM_HERO_LIST[id]);
        }
        if (award=='skater'){
            $('#panel_award_img').SetHasClass('invisible',false);
            $('#panel_award_img_small').SetHasClass('invisible',true);
            $('#panel_award_img_hero').SetHasClass('invisible',true);
            $('#panel_award_img').SetImage('file://{images}/custom_game/lottery/'+id+'.png');
            // $('#panel_award_title_desc').style['color'] = RARITY_COLOR_TEXT[color];
            $('#panel_award_title_desc').text = $.Localize('#'+'award_rarity_'+color)+' '+$.Localize('#'+'award_type_skater');
            $('#panel_award_title_text').text = $.Localize('#'+id);
        }
        if (award=='effect'){
            $('#panel_award_img').SetHasClass('invisible',false);
            $('#panel_award_img_small').SetHasClass('invisible',true);
            $('#panel_award_img_hero').SetHasClass('invisible',true);
            $('#panel_award_img').SetImage('file://{images}/custom_game/lottery/'+id+'.png');
            // $('#panel_award_title_desc').style['color'] = RARITY_COLOR_TEXT[color];
            $('#panel_award_title_desc').text = $.Localize('#'+'award_rarity_'+color)+' '+$.Localize('#'+'award_type_effect');
            $('#panel_award_title_text').text = $.Localize('#'+id);
        }
        if (award=='smability'){
            $('#panel_award_img').SetHasClass('invisible',false);
            $('#panel_award_img_small').SetHasClass('invisible',true);
            $('#panel_award_img_hero').SetHasClass('invisible',true);
            $('#panel_award_img').SetImage('file://{images}/custom_game/lottery/'+id+'.png');
            // $('#panel_award_title_desc').style['color'] = RARITY_COLOR_TEXT[color];
            $('#panel_award_title_desc').text = $.Localize('#'+'award_rarity_'+color)+' '+$.Localize('#'+'award_type_smability');
            $('#panel_award_title_text').text = $.Localize('#'+id);
        }
        if (award=='gemability'){
            $('#panel_award_img').SetHasClass('invisible',false);
            $('#panel_award_img_small').SetHasClass('invisible',true);
            $('#panel_award_img_hero').SetHasClass('invisible',true);
            $('#panel_award_img').SetImage('file://{images}/custom_game/lottery/gem_'+id+'.png');
            // $('#panel_award_title_desc').style['color'] = RARITY_COLOR_TEXT[color];
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

// 弹提示框，待美化
function show_msg(text){
    $('#msg_box_text').text = $.Localize('#'+text);
    $('#msg_box').SetHasClass('invisible',false);
    Game.EmitSound("ui.crafting_gem_drop");

    $.Schedule(2,function(){
        $('#msg_box').SetHasClass('invisible',true);
    });
}

