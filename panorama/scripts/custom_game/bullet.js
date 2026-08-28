--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// 弹幕

$.GetContextPanel().RemoveAndDeleteChildren();
GameEvents.Subscribe("bullet", OnBullet);

function OnBullet(data) {
    var steam_id = Game.GetPlayerInfo(data.player_id).player_steamid;
    var player_name = wordFilter(Game.GetPlayerInfo(data.player_id).player_name);
    if (!CheckClientKey(data.key)) return;

    var text = wordFilter(data.text || '');
    var vip = data.vip;
    var win_streak = data.win_streak || 0;
    var item = data.item;
    var item_level = data.item_level;
    var pre_item = data.pre_item;
    var pre_ability = data.pre_ability;
    var ban = data.ban;
    var color = data.color || null;
    var target = data.target;
    // bullet_chat(steam_id, player_name, text, target, color, data.player_id, vip, win_streak, item, item_level, ban);
    ShowBullet({
        player_id: data.player_id,
        steam_id: steam_id,
        player_name: player_name,
        text: text,
        vip: vip,
        win_streak: win_streak,
        item: item,
        item_level: item_level,
        ban: ban,
        color: color,
        target: target,
        pre_item: pre_item,
        pre_ability: pre_ability,
    });
}
let IS_BULLET_BUSY = {};
function ShowBullet(info) {
    var player_id = info.player_id;
    if (IS_BULLET_BUSY[player_id] == true) {
        $.Schedule(0.1, function () {
            ShowBullet(info);
        });
        return;
    }

    IS_BULLET_BUSY[player_id] = true;
    $.Schedule(1.5, function () {
        IS_BULLET_BUSY[player_id] = false;
    });

    var panel = $.CreatePanel('Panel', $.GetContextPanel(), "");
    panel.BLoadLayoutSnippet('bullet');

    var panel = $.CreatePanel('DOTAScenePanel', $.GetContextPanel(), "", {
        class: 'bullet',
        hittest: false,
    });

    panel.visible = true;

    var hero = null;

    var ws_color = GetWSColor(info.win_streak);
    if (info.target) {
        // 把target转为英雄名字，存在hero
        var show_name = info.target;
        if (show_name.indexOf('11') > -1) {
            show_name = show_name.substr(0, show_name.length - 2);
        }
        if (show_name.indexOf('1') > -1) {
            show_name = show_name.substr(0, show_name.length - 1);
        }
        if (CHESS_2_LEVEL[show_name]) {
            info.color = LEVEL_2_COLOR[CHESS_2_LEVEL[show_name]];
        }
        if (CHESS_2_HERO[show_name]) { 
            hero = CHESS_2_HERO[show_name];
        }
        info.text = info.target;
    }
    if (info.item && info.item_level) {
        info.color = LEVEL_2_COLOR[info.item_level];
        info.text = info.item;
    }
    if (info.ban) {
        info.color = '#ff4444';
        info.text = 'DOTA_Tooltip_ability_' + info.ban;
    }


    if (info.vip) {
        $.CreatePanel('Image', panel, "", {
            class: 'bullet_img',
            src: "file://{images}/custom_game/vip/little_drodo_" + Math.floor(Math.random() * 5) + ".png",
        });

        panel.style['background-image'] = 'url("file://{images}/custom_game/vip/bg3.png")';
        panel.style['background-size'] = '100% 100%';
    }

    var banner = $.CreatePanel('Panel', panel, "", {
        class: 'bullet_banner',
    });

    var line1 = $.CreatePanel('Panel', banner, "", {
        class: 'bullet_line1',
    });
    if (info.player_name) {
        $.CreatePanel('Label', line1, "", {
            class: 'bullet_player_name',
            text: info.player_name,
            style: 'color:' + (ws_color || '#bbb') + ';',
        });
    }

    var line2 = $.CreatePanel('Panel', banner, "", {
        class: 'bullet_line2',
    });

    if (info.pre_item) {
        $.CreatePanel('DOTAItemImage', line2, "", {
            class: 'bullet_item_image',
            itemname: info.pre_item,
        });
    }

    if (info.pre_ability) {
        $.CreatePanel('DOTAAbilityImage', line2, "", {
            class: 'bullet_ability_image',
            abilityname: info.pre_ability,
        });
    }

    if (hero) {
        // 英雄头像
        $.CreatePanel('DOTAHeroImage', line2, "", {
            class: 'bullet_hero_image',
            heroname: hero,
            heroimagestyle: 'icon',
        });
    }

    // 装备图标
    if (info.item) {
        $.CreatePanel('DOTAItemImage', line2, "", {
            class: 'bullet_item_image',
            itemname: info.item,
        });
    }

    if (info.ban) {
        $.CreatePanel('Panel', line2, "", {
            class: 'bullet_ban_image',
        });
    }

    if (info.text) {
        $.CreatePanel('Label', line2, "", {
            class: 'bullet_text',
            text: $.Localize('#'+(info.text)),
            style: 'color:' + (info.color || '#fff') + ';',
        });
    }

    var user_info_table = CustomNetTables.GetTableValue("dac_table", 'user_panel_ranking');
    var rank = user_info_table.table[info.steam_id]['curr_rank'];

    // var i = GetPlayerPanelPosition(info.player_id) || 0;
    var margintop = ((rank - 1) * 92) + 140;
    var w = Game.GetScreenWidth();
    var h = Game.GetScreenHeight();
    var maxwidth = (w / h) * 1080 - 170;

    panel.style.position = maxwidth + 'px ' + margintop + 'px 0px';

    panel.style['transition-duration'] = '20s';
    panel.style['transition-timing-function'] = 'linear';

    panel.style.position = '-1000px ' + margintop + 'px 0px';

    $.Schedule(20, () => {
        panel.RemoveAndDeleteChildren();
    });
}