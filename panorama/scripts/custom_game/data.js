--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


var COLOR = {
    "0": "rgba(128,128,128,0.8)",
    "1": "rgba(128,128,128,0.8)",
    "2": "rgba(96,96,255,0.8)",
    "3": "rgba(255,64,192,0.8)",
    "4": "rgba(255,128,0,0.8)",
};
var COLOR_STR = {
    "0": "#bbbbbb",
    "1": "#bbbbbb",
    "2": "#6666ff",
    "3": "#ff00cc",
    "4": "#ff8800",
};
var GEM_HERO_LIST = {
    h101: "npc_dota_hero_enchantress",
    h102: "npc_dota_hero_puck",
    h103: "npc_dota_hero_omniknight",
    h104: "npc_dota_hero_wisp",
    h105: "npc_dota_hero_ogre_magi",
    h106: "npc_dota_hero_lion",
    h107: "npc_dota_hero_keeper_of_the_light",
    h108: "npc_dota_hero_rubick",
    h109: "npc_dota_hero_jakiro",
    h110: "npc_dota_hero_sand_king",
    h111: "npc_dota_hero_ancient_apparition", //new
    h112: "npc_dota_hero_earth_spirit", //new

    h201: "npc_dota_hero_crystal_maiden",
    h202: "npc_dota_hero_death_prophet",
    h203: "npc_dota_hero_templar_assassin",
    h204: "npc_dota_hero_lina",
    h205: "npc_dota_hero_tidehunter",
    h206: "npc_dota_hero_naga_siren",
    h207: "npc_dota_hero_phoenix",
    h208: "npc_dota_hero_dazzle",
    h209: "npc_dota_hero_warlock",
    h210: "npc_dota_hero_necrolyte",
    h211: "npc_dota_hero_lich",
    h212: "npc_dota_hero_furion",
    h213: "npc_dota_hero_venomancer",
    h214: "npc_dota_hero_kunkka",
    h215: "npc_dota_hero_axe",
    h216: "npc_dota_hero_slark",
    h217: "npc_dota_hero_viper",
    h218: "npc_dota_hero_tusk",
    h219: "npc_dota_hero_abaddon",
    h220: "npc_dota_hero_winter_wyvern", //new
    h221: "npc_dota_hero_ember_spirit", //new

    h301: "npc_dota_hero_windrunner",
    h302: "npc_dota_hero_phantom_assassin",
    h303: "npc_dota_hero_sniper",
    h304: "npc_dota_hero_sven",
    h305: "npc_dota_hero_luna",
    h306: "npc_dota_hero_mirana",
    h307: "npc_dota_hero_nevermore",
    h308: "npc_dota_hero_queenofpain",
    h309: "npc_dota_hero_juggernaut",
    h310: "npc_dota_hero_pudge",
    h311: "npc_dota_hero_shredder",
    h312: "npc_dota_hero_slardar",
    h313: "npc_dota_hero_antimage",
    h314: "npc_dota_hero_bristleback",
    h315: "npc_dota_hero_lycan",
    h316: "npc_dota_hero_lone_druid",
    h317: "npc_dota_hero_storm_spirit", //new
    h318: "npc_dota_hero_obsidian_destroyer", //new
    h319: "npc_dota_hero_grimstroke",

    h401: "npc_dota_hero_vengefulspirit",
    h402: "npc_dota_hero_invoker",
    h403: "npc_dota_hero_alchemist",
    h404: "npc_dota_hero_spectre",
    h405: "npc_dota_hero_morphling",
    h406: "npc_dota_hero_techies",
    h407: "npc_dota_hero_chaos_knight",
    h408: "npc_dota_hero_faceless_void",
    h409: "npc_dota_hero_legion_commander",
    h410: "npc_dota_hero_monkey_king",
    h411: "npc_dota_hero_razor",
    h412: "npc_dota_hero_tinker",
    h413: "npc_dota_hero_pangolier",
    h414: "npc_dota_hero_dark_willow",
    h415: "npc_dota_hero_terrorblade", //new
    h416: "npc_dota_hero_enigma", //new
}
var GEM_ABILITY_LIST = {
    a101: "gemtd_hero_huichun",
    a102: "gemtd_hero_shanbi",
    a103: "gemtd_hero_shouhu",
    a105: "gemtd_hero_beishuiyizhan",

    a201: "gemtd_hero_lanse",
    a202: "gemtd_hero_danbai",
    a203: "gemtd_hero_baise",
    a204: "gemtd_hero_hongse",
    a205: "gemtd_hero_lvse",
    a206: "gemtd_hero_fense",
    a207: "gemtd_hero_huangse",
    a208: "gemtd_hero_zise",
    a209: "gemtd_hero_jingying",
    a210: "gemtd_hero_putong",
    a211: "gemtd_hero_qingyi",
    a212: "gemtd_hero_shitou", //new

    a301: "gemtd_hero_kuaisusheji",
    a302: "gemtd_hero_baoji",
    a303: "gemtd_hero_miaozhun",
    a304: "gemtd_hero_fengbaozhichui",
    a305: "gemtd_hero_wuxia",
    a306: "gemtd_hero_huidaoguoqu",
    a307: "gemtd_hero_lianjie",
    a308: "gemtd_hero_xuanfeng", //new

    a401: "gemtd_hero_yixinghuanwei",
    a402: "gemtd_hero_wanmei",
    a403: "gemtd_hero_guangzhudaobiao",
}
var TOY_LIST = {
    t401: 'roshan',
    t402: 'greevil',
    t403: 'shell',
    t301: 'pumpkin',
    t302: 'snow',
    t303: 'beach',
    t304: 'mushroom',
}


// 因为BCreateChildren无了，改为调用这个CreateChildren
function CreateChildren(parent_panel, xmlstring) {
    var obj = readXML(xmlstring);
    CreateOneElement(obj, parent_panel);
}
function FindDotaHudElement(id) {
    var hudRoot;
    for (panel = $.GetContextPanel(); panel != null; panel = panel.GetParent()) {
        hudRoot = panel;
    }
    var comp = hudRoot.FindChildTraverse(id);
    return comp;
}
function CreateUIElement(parent_panel, panel_type, id, prop) {
    if (!parent_panel || !panel_type) {
        return;
    }
    var new_ui_element = $.CreatePanel(panel_type, parent_panel, id, prop || {});
    return new_ui_element;
}
function ClearUIElement(parent_panel) {
    parent_panel.RemoveAndDeleteChildren();
}
function CreateOneElement(obj, parent_panel) {
    if (!obj) {
        return;
    }
    if (!obj.type) {
        if (obj.children && obj.children.length > 0) {
            for (var i = 0; i < obj.children.length; i++) {
                CreateOneElement(obj.children[i], parent_panel);
            }
        }
        return;
    }
    var panel_type = obj.type;
    var props = obj.props;
    var panel_id = obj.props.id;
    var panel = CreateUIElement(parent_panel, panel_type, panel_id, props);

    if (obj.children && obj.children.length > 0) {
        for (var i = 0; i < obj.children.length; i++) {
            CreateOneElement(obj.children[i], panel);
        }
    }
}

function readXML(xmlstring) {
    xmlstring = xmlstring.replace(/\s+=\s+/g, '=');
    xmlstring = xmlstring.replace(/\s+=/g, '=');
    xmlstring = xmlstring.replace(/=\s+/g, '=');

    var element_queue = [];
    var p_i = 0;
    var element_temp = "";
    while (p_i < xmlstring.length) {
        element_temp = element_temp + xmlstring.charAt(p_i);
        if (xmlstring.charAt(p_i) == '>') {
            element_queue.unshift(element_temp);
            element_temp = "";
        }
        p_i++;
    }
    var element_stack = [];

    var element_string_object = { context: 'root', children: [], parent: null };
    var tree_pointer = element_string_object['children'];
    var parent_pointer = element_string_object;
    while (element_queue.length > 0) {
        var element = element_queue.pop();
        if (element.indexOf('/>') != -1) {
            tree_pointer.push({ context: element, children: [], parent: parent_pointer });
        }
        else if (element.indexOf('</') != -1) {
            parent_pointer = element_stack.pop()['parent'];
            tree_pointer = parent_pointer['children'];
        }
        else if (element.indexOf('<') != -1) {
            var obj = { context: element, children: [], parent: parent_pointer };
            tree_pointer.push(obj);
            element_stack.push(obj);
            parent_pointer = obj;
            tree_pointer = obj['children'];
        }
    }
    readchild(element_string_object);

    return element_string_object;
}
function readchild(obj) {
    if (obj['children'].length == 0) {
        return null;
    }
    else {
        for (var i = 0; i < obj['children'].length; i++) {
            var str = obj['children'][i]['context'];
            var p_type_start = str.indexOf('<');
            var p_type_end = str.indexOf(' ');
            var type = str.slice(p_type_start + 1, p_type_end);
            obj['children'][i]['type'] = type;
            var props = {};
            var p_i = p_type_end;
            while (p_i < str.length) {
                var p_prop_name_end = str.indexOf('=', p_i);
                if (p_prop_name_end == -1) {
                    break;
                }
                var prop_name = str.slice(p_i, p_prop_name_end).trim();

                var p_prop_value_start_1 = str.indexOf('"', p_i);
                var p_prop_value_start_2 = str.indexOf("'", p_i);
                var p_prop_value_end_1 = null;
                var p_prop_value_end_2 = null;
                if (p_prop_value_start_1) {
                    p_prop_value_end_1 = str.indexOf('"', p_prop_value_start_1 + 1) + 1;
                }
                if (p_prop_value_start_2) {
                    p_prop_value_end_2 = str.indexOf("'", p_prop_value_start_2 + 1) + 1;
                }
                var p_prop_value_end = (p_prop_value_end_1 || p_prop_value_end_2);
                if (p_prop_value_end == -1) {
                    break;
                }
                var prop_value = str.slice(p_prop_name_end + 1, p_prop_value_end).slice(1, -1);
                if (prop_name != "" && prop_value != "") {
                    props[prop_name] = prop_value;
                }
                p_i = p_prop_value_end + 1;
            }
            obj['children'][i]['props'] = props;
            delete obj['children'][i]['context'];
            delete obj['children'][i]['parent'];
            readchild(obj['children'][i]);
        }
    }
}