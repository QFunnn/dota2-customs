--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


var debug_vision = false;
var creep_pool_vision = false;
var selected_team = 4;

function Open() {
    debug_vision = !debug_vision;
    $("#DebugPanel").SetHasClass("Hidden", !debug_vision);
    
    if (!debug_vision) {
        creep_pool_vision = false;
        $("#CreepPool").AddClass("Hidden");
    }
}

function SelectTeam(teamId) {
    selected_team = teamId;
    $("#TeamGood").SetHasClass("Selected", teamId == 2);
    $("#TeamNeutral").SetHasClass("Selected", teamId == 4);
}

function ShowCreepPool() {
    creep_pool_vision = !creep_pool_vision;
    $("#CreepPool").SetHasClass("Hidden", !creep_pool_vision);

    if (creep_pool_vision) {
        var container = $("#CreepListScroll");
        container.RemoveAndDeleteChildren();

        var fullData = CustomNetTables.GetTableValue("debug_panel", "creeps_list");
        if (fullData) {
            var zones = Object.keys(fullData).sort((a, b) => {
				const aZoneMatch = a.match(/zone_(\d+)/)
				const bZoneMatch = b.match(/zone_(\d+)/)
				if (aZoneMatch && bZoneMatch) {
					return Number(aZoneMatch[1]) > Number(bZoneMatch[1]) ? 1 : -1
				}

				return a > b ? 1 : -1
			});
            zones.forEach(function(zoneName) {
                var monsters = fullData[zoneName];
                
                var zLabel = $.CreatePanel("Label", container, "");
                zLabel.AddClass("creep_zone_label");
                zLabel.text = zoneName.toUpperCase();

                var monsterNames = Object.keys(monsters).sort();

                monsterNames.forEach(function(mName) {
                    (function(name, zone) {
                        var mLabel = $.CreatePanel("Label", container, "");
                        mLabel.AddClass("creep_label");
                        mLabel.text = $.Localize("#" + name);
                        
                        mLabel.SetPanelEvent('onactivate', function() {
                            $("#CreateUnitName").text = $.Localize("#" + name);
                            $("#CreateUnitName").technicalName = name; 
                            $("#CreateUnitName").zone = zone;
                            $("#CreepPool").AddClass("Hidden");
                            creep_pool_vision = false;
                        });
                    })(mName, zoneName);
                });
            });
        }
    }
}

function CreateUnitButton() {
    var label = $("#CreateUnitName");
    var unitToSpawn = label.technicalName; 

    if (unitToSpawn) {
        GameEvents.SendCustomGameEventToServer("spawn_creep", {
            creep_name: unitToSpawn, 
            zone: label.zone,
            team: selected_team
        });
    }
}

// ---------------------------------------------------------------------

function UpHero() {
    GameEvents.SendCustomGameEventToServer("UpHero", {});
}

function lvlup1() {
    GameEvents.SendCustomGameEventToServer("lvlup1", {});
}

function QuickSpawnItems(mode) {
    GameEvents.SendCustomGameEventToServer("add_hero_item", {mode:mode});
}

// ---------------------------------------------------------------------

var debug_vision = false;
var creep_pool_vision = false;
var selected_team = 4;

var current_attributes_count = 0; 
var item_types = ['boots', 'armor', 'shield', 'legs', 'head', 'weapon'];
var attribute_list = ['desolator', 'magic_desolator', 'reflect', 'lifesteal', 'magic_lifesteal', 'mjolnir', 'mjolnir_armor', 'mkb', 'hp_regen', 'hp_regen_amp', 'damage_block', 'manacost', 'crit', 'multicast', 'magic_crit'];
var sets_list = ['set_1', 'set_2', 'set_3', 'set_4', 'set_5', 'set_6'];
var levels_list = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'];

function ShowSelectionPool(mode, targetPanel) {
    var pool = $("#SelectionPool");
    var container = $("#SelectionListScroll");
    var header = $("#SelectionHeader");
    
    if (!pool || !container) return;

    container.RemoveAndDeleteChildren();
    pool.RemoveClass("Hidden");

    var list = [];
    if (mode === 'item_type') { list = item_types; header.text = "ТИП"; }
    else if (mode === 'set_type') { list = sets_list; header.text = "СЕТ"; }
    else if (mode === 'attribute') { list = attribute_list; header.text = "АТРИБУТ"; }
    else if (mode === 'item_level') { list = levels_list; header.text = "УРОВЕНЬ"; }

    list.forEach(function(value) {
        var btn = $.CreatePanel("Button", container, "");
        btn.AddClass("creep_label");
        var lbl = $.CreatePanel("Label", btn, "");
        lbl.text = value.toUpperCase();

        btn.SetPanelEvent("onactivate", function() {
            if (mode === 'attribute' && GetCurrentSelectedAttributes()[value]) {
                Game.EmitSound("General.Cancel");
                return;
            }
            
            if (targetPanel) {
                targetPanel.text = value.toUpperCase();
                targetPanel.technicalName = value;
            }
            
            pool.AddClass("Hidden");
        });
    });
}

function AddAttributeRow() {
    if (current_attributes_count >= 5) return;

    var container = $("#AttributesContainer");
    if (!container) return;

    var row = $.CreatePanel("Panel", container, "");
    row.AddClass("AttributeRow");

    var btn = $.CreatePanel("Button", row, "");
    btn.AddClass("DropdownCustom");
    btn.style.width = "fill-parent-flow(1.0)";
    
    var lbl = $.CreatePanel("Label", btn, "");
    lbl.AddClass("AttributeValueLabel");
    lbl.text = "ВЫБРАТЬ АТРИБУТ...";
    
    btn.SetPanelEvent("onactivate", function() {
        ShowSelectionPool('attribute', lbl);
    });
 
    var closeBtn = $.CreatePanel("Button", row, "");
    closeBtn.style.width = "42px";
    closeBtn.style.height = "42px";
    closeBtn.style.marginLeft = "5px";
    closeBtn.style.backgroundColor = "gradient( linear, 0% 0%, 0% 100%, from( #882222 ), to( #441111 ) )";
    
    var closeLbl = $.CreatePanel("Label", closeBtn, "");
    closeLbl.text = "X";
    closeLbl.style.align = "center center";
    closeLbl.style.color = "white";
    closeLbl.style.fontWeight = "bold";

    closeBtn.SetPanelEvent("onactivate", function() {
        row.DeleteAsync(0);
        current_attributes_count--;
        $("#AddAttributeBtn").RemoveClass("Hidden");
    });

    current_attributes_count++;
    if (current_attributes_count === 5) $("#AddAttributeBtn").AddClass("Hidden");
}


function GetCurrentSelectedAttributes() {
    var selected = {};
    var labels = $("#AttributesContainer").FindChildrenWithClassTraverse("AttributeValueLabel");
    
    labels.forEach(function(lbl) {
        if (lbl.technicalName && lbl.technicalName !== "") {
            selected[lbl.technicalName] = 1;
        }
    });
    return selected;
}

function CreateCustomItem() {
    var itemType = $("#ItemTypeName").technicalName || "boots";
    var itemLevel = parseInt($("#ItemLevelValue").technicalName) || 1;
    var setTypeStr = $("#ItemSetName").technicalName || "set_1";
    var setNumber = parseInt(setTypeStr.replace(/\D/g, '')) || 1;
    
    var rawInput = $("#PlayerIDInput").text.trim(); 
    var targetPlayerID;
    var steamIdPattern = /^\d{17}$/;

    var errorLabel = $("#IDErrorLabel");

    if (rawInput === "") {
        targetPlayerID = null;
        errorLabel.AddClass("Hidden");
    } else if (steamIdPattern.test(rawInput)) {
        targetPlayerID = rawInput;
        errorLabel.AddClass("Hidden");
    } else {
        $("#PlayerIDInput").AddClass("ErrorState"); 
        errorLabel.RemoveClass("Hidden");
        return;
    }

    $("#PlayerIDInput").RemoveClass("ErrorState");

    var data = {
        item_type: itemType,
        level: itemLevel,
        set_type: setTypeStr,
        set_number: setNumber,
        bonus_attribute: GetCurrentSelectedAttributes(),
        base_attribute: {},
        target_id: targetPlayerID 
    };
    
    data.base_attribute[itemType] = 1;

    GameEvents.SendCustomGameEventToServer("AddItem", {data:data});
}