--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


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
    var new_ui_element = $.CreatePanelWithProperties(panel_type, parent_panel, id, prop || {});
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