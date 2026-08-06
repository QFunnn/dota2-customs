--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


/* 
    战利品宝箱
*/
GameEvents.Subscribe("show_loot_box", OnShowLootBox);
GameEvents.Subscribe("confirm_close_loot_box", confirm_close_panel_lootbox);
GameEvents.Subscribe("pet_choose_loot", OnPetChooseLoot);
GameEvents.Subscribe("request_choose_loot_cb", OnRequestChooseLootCB);


var is_lootbox_on_use = false;
var LOOT_CHOOSE_TABLE_REROLL = {};
var LOOT_CHOOSE_TABLE = {};
var LOOT_CHOOSE_COURIER_INDEX;
function OnShowLootBox(keys) {
    if (!CheckClientKey(keys.key) && !keys.reroll) return;
    if (is_lootbox_on_use == true && !keys.skip_open_box) {
        $.Schedule(0.5, function () {
            OnShowLootBox(keys);
        });
        return;
    }
    // 把备选选项暂时存放到 LOOT_CHOOSE_TABLE_REROLL
    var reroll_count = 0;
    LOOT_CHOOSE_TABLE_REROLL = {};
    for (var r in keys.loot_list_reroll){
        reroll_count ++;
        LOOT_CHOOSE_TABLE_REROLL[r] = keys.loot_list_reroll[r];
    }
    if (HasModifier('modifier_item_second_chance') && reroll_count > 0 && !keys.reroll) {
        // 持有第二次机会，并且能reroll，并且此次不是reroll
        $('#image_reroll').SetHasClass('invisible', false);
        $('#image_random').SetHasClass('invisible', true);
    }
    else{
        $('#image_reroll').SetHasClass('invisible', true);
        if (keys.reroll){
            $('#image_random').SetHasClass('invisible', true);
        }
        else{
            $('#image_random').SetHasClass('invisible', false);
        }
    }
    if (keys.box_type == 'item_relicbox'){
        $('#image_stolen_vault').SetHasClass('invisible', false);
        $('#image_close').SetHasClass('invisible', true);
    }
    else{
        $('#image_close').SetHasClass('invisible', false);
        $('#image_stolen_vault').SetHasClass('invisible', true);
    }
    var valid_table = keys.loot_list;
    if (keys.reroll){
        valid_table = keys.loot_list_reroll;
    }
    if (valid_table) {
        LOOT_CHOOSE_TABLE = {};
        var row_index = 1;
        var item_index = 1;

        var item_level_list = CustomNetTables.GetTableValue("chess_pool_table", 'item_level_list');
        var relic_list_obj = CustomNetTables.GetTableValue("chess_pool_table", 'relic_list');
        var relic_list = [];
        for (var i in relic_list_obj){
            relic_list.push(relic_list_obj[i]);
        }
        for (var i=1;i<=3;i++){
            var panel = $('#panel_loot_box_inner_row_' + i);
            if (panel){
                panel.RemoveAndDeleteChildren();
            }
        }
        for (var i in valid_table) {
            // target_item选项的内容为row
            var row = valid_table[i];
            var target_item = i;

            if (row_index < 1 || row_index > 3){
                // 容错，因为xml使写死了最多3个选项
                return;
            }

            // 获得物品等级
            var target_item_level = item_level_list[target_item];
            if (relic_list.indexOf(target_item)>=0){
                target_item_level = 6;
            }
            var level_color = LEVEL_2_COLOR[target_item_level];
            var panel = $('#panel_loot_box_inner_row_' + row_index);
            if (panel){
                panel.RemoveAndDeleteChildren();
            }

            var item_image = $.CreatePanel('DOTAItemImage', panel, 'panel_loot_box_inner_row_' +row_index+'_item', {
                class: 'panel_loot_one',
                itemname:  target_item,
                onactivate: 'OnChooseLoot('+ row_index +')',
            });
            $.CreatePanel('Panel', panel, 'panel_loot_box_inner_row_' +row_index+'_item_color', {
                class: 'panel_loot_one_level_color',
                style: 'width:100%;margin-left:5px;margin-right:5px;margin-bottom:5px;height:5px;background-color:'+level_color+';',
            });
            LOOT_CHOOSE_TABLE[''+row_index] = {
                loot_index: row_index,
                target_item_name: target_item,
            };
            // for (var j in row) {
            //     var row_details = row[j];

            //     LOOT_CHOOSE_TABLE[''+item_index] = {
            //         loot_index: item_index,
            //         target_item_name: target_item,
            //         target_item_level: target_item_level,
            //         chess_water_id: row_details.chess_water_id,
            //         chess_base_name: row_details.chess_base_name,
            //         hero_entindex: row_details.hero_entindex,
            //         hero_name: row_details.hero_name,
            //         item_name: row_details.item_name,
            //         target_item_panel_name: 'panel_loot_box_inner_row_' +row_index+'_item',
            //     };
            //     if (row_details.hero_entindex){
            //         LOOT_CHOOSE_COURIER_INDEX = row_details.hero_entindex;
            //     }
            //     var panel_inner = $.CreatePanel('Panel', panel, 'panel_loot_box_inner_row_choise_' + item_index, {
            //         class: 'panel_loot_box_inner',
            //         onactivate: 'OnChooseLoot('+ item_index +')',
            //     });

            //     if (row_details.chess_base_name){
            //         // 棋子：显示头像
            //         $.CreatePanel('DOTAHeroImage', panel_inner, '', {
            //             heroname: CHESS_2_HERO[row_details.chess_base_name],
            //             heroimagestyle: 'icon',
            //         });
            //     }
            //     else if (row_details.hero_name){
            //         // 信使：显示图片
            //         $.CreatePanel('Image', panel_inner, '', {
            //             src: 'file://{images}/custom_game/skaters/'+row_details.hero_name+'.png',
            //             style: 'horizontal-align: center;',
            //         });
            //     }
            //     if (row_details.item_name){
            //         var item_image = $.CreatePanel('DOTAItemImage', panel_inner, '', {
            //             itemname: row_details.item_name,
            //             onmouseover : '',
            //             onmouseout: '',
            //         });
            //     }

            //     SetLootboxPanelHoverEvent(item_index);

            //     item_index++;
            // }

            row_index ++;
        }
    }

    if (!keys.skip_open_box){
        $('#panel_loot_box').SetHasClass('invisible', false);
        $('#panel_loot_box').style['opacity'] = '1';
        $('#panel_loot_box').style['position'] = '0px 0px 0px';
        $('#panel_loot_box').style['transform'] = 'scale3d( 1, 1, 1);';
        Game.EmitSound("dac.loot.open");
        is_lootbox_on_use = true;
    }

}

function OnPetChooseLoot(keys){
    if (!CheckClientKey(keys.key)) return;
    // var item_level_list = CustomNetTables.GetTableValue("chess_pool_table", 'item_level_list');
    
    // var best_level=0;
    // var best_index;
    // for (var i in LOOT_CHOOSE_TABLE){
    //     var choise = LOOT_CHOOSE_TABLE[i];
    //     if (choise.target_item_name){
    //         var target_item_level = item_level_list[choise.target_item_name] || 0;
    //         if (target_item_level>best_level){
    //             best_index = i;
    //             best_level = target_item_level;
    //         }
    //     }
    // }
    OnChooseLoot(Math.ceil(Math.random()*3));
}
function OnChooseLoot(index) {
    var loot_details = LOOT_CHOOSE_TABLE[''+index];
    if (!loot_details){
        return;
    }
    GameEvents.SendCustomGameEventToServer("request_choose_loot", {
        loot_index: index,
        // chess_water_id: loot_details.chess_water_id,
        // hero_entindex: loot_details.hero_entindex,
        // item_name: loot_details.item_name,
        target_item_name: loot_details.target_item_name,
    });
}

function OnRequestChooseLootCB(keys){
    if (keys.result == true){
        Game.EmitSound("General.Buy");
        $('#panel_loot_box').style['opacity'] = '0.01';
        $('#panel_loot_box').style['position'] = '0px 100px 0px';
        $('#panel_loot_box').style['transform'] = 'scale3d( 0.01, 0.01, 0.01);';
        $.Schedule(0.5, function () {
            $('#panel_loot_box').SetHasClass('invisible', true);
            is_lootbox_on_use = false;
        });
    }
    else{
        OnMima({ text: keys.error, key: CLIENT_KEY });
        return;
    }
}


function confirm_random_panel_lootbox() {
    show_confirm($.Localize('#'+'text_confirm_random_panel_lootbox'), function(){
        random_panel_lootbox();
    });
}
function confirm_reroll_panel_lootbox(){
    show_confirm($.Localize('#'+'text_confirm_reroll_panel_lootbox'), function(){
        reroll_panel_lootbox();
    });
}
function reroll_panel_lootbox() {
    close_confirm();
    Game.EmitSound("item.multicast");
    $('#panel_loot_box').SetHasClass('invisible', true);
    is_lootbox_on_use = false;
    OnShowLootBox({
        reroll:1,
        loot_list_reroll:LOOT_CHOOSE_TABLE_REROLL,
    })
}
function confirm_close_panel_lootbox() {
    show_confirm($.Localize('#'+'text_confirm_close_panel_lootbox'), function(){
        close_panel_lootbox(); 
    });
}
function close_panel_lootbox() {
    GameEvents.SendCustomGameEventToServer("request_choose_loot", {
        hero_entindex: LOOT_CHOOSE_COURIER_INDEX,
        loot_index: -1,
    });
    Game.EmitSound("dac.popup");
    $('#panel_loot_box').style['opacity'] = '0.01';
    $('#panel_loot_box').style['position'] = '0px 100px 0px';
    $('#panel_loot_box').style['transform'] = 'scale3d( 0.01, 0.01, 0.01);';
    $.Schedule(0.5, function () {
        $('#panel_loot_box').SetHasClass('invisible', true);
        is_lootbox_on_use = false;
    });
    close_confirm();
}
function confirm_choose_stolen_vault(){
    show_confirm($.Localize('#'+'text_confirm_choose_stolen_vault'), function(){
        choose_stolen_vault();
    });
}
function choose_stolen_vault() {
    GameEvents.SendCustomGameEventToServer("request_choose_loot", {
        hero_entindex: LOOT_CHOOSE_COURIER_INDEX,
        loot_index: -3,
    });
    // Game.EmitSound("dac.popup");
    // $('#panel_loot_box').style['opacity'] = '0.01';
    // $('#panel_loot_box').style['position'] = '0px 100px 0px';
    // $('#panel_loot_box').style['transform'] = 'scale3d( 0.01, 0.01, 0.01);';
    // $.Schedule(0.5, function () {
    //     $('#panel_loot_box').SetHasClass('invisible', true);
    //     is_lootbox_on_use = false;
    // });
    close_confirm();
}
function random_panel_lootbox() {
    GameEvents.SendCustomGameEventToServer("request_choose_loot", {
        hero_entindex: LOOT_CHOOSE_COURIER_INDEX,
        loot_index: -2,
    });
    Game.EmitSound("boing");
    close_confirm();
}


function SetLootboxPanelHoverEvent(item_index){
    var panel_hover = FindDotaHudElement('panel_loot_box_inner_row_choise_' + item_index);
    var loot_details = LOOT_CHOOSE_TABLE[''+item_index];
    if (!loot_details || !panel_hover){
        return;
    }
    var target_item_name = loot_details.target_item_name;
    var item_name = loot_details.item_name;
    // $.Msg(item_index+':'+(item_name||'')+'-->'+target_item_name);
    var text = $.Localize('#txt_lootbox_hover_choose');
    if (item_name){
        text = $.Localize('#txt_lootbox_hover_update');
        text = text.replace('<item>',$.Localize('#DOTA_Tooltip_ability_'+item_name));
    }
    text = text.replace('<target_item>',$.Localize('#DOTA_Tooltip_ability_'+target_item_name));

    panel_hover.SetPanelEvent("onmouseover", function () {
        // $.Msg(loot_details);
        $.DispatchEvent("DOTAShowTextTooltip", panel_hover, text);
    });
    panel_hover.SetPanelEvent("onmouseout", function () {
        $.DispatchEvent("DOTAHideTextTooltip");
    });
}