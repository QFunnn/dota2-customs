--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);


var is_active = false
var toggle = false;
var cooldown_update = false
var show_total = false
var current_sub_tab = "DamageAbilitiesIncome";

var local_hero_ent
var local_hero
var player_table

var damage_table_outgoing = {}
var damage_table_incoming = {}
var damage_table_healing = {}
var damage_table_temp = {}

function init()
{
	GameEvents.Subscribe_custom('init_damage_table', init_damage_table)
	GameEvents.Subscribe_custom('send_damage_stats', send_damage_stats)
	GameEvents.Subscribe_custom('send_damage_bar', send_damage_bar)
	GameEvents.Subscribe_custom('damage_stats_endscreen', damage_stats_endscreen)
    GameEvents.SendCustomGameEventToServer_custom("RequestItemBuild", {})
}

init()

function init_damage_table(kv)
{
	let main = $.GetContextPanel().FindChildTraverse("DamageBlockWithButton")
	if (kv.subscribed == 1 || kv.free_build == 1)
	{
		is_active = true
		main.RemoveClass("panel_hidden")
	}
}

function damage_stats_endscreen()
{
	let new_parent = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("EndScreen_Points")

	if (!new_parent)
		return

	let panel = $.GetContextPanel().FindChildTraverse("DamageBlockWithButton")

	panel.AddClass("DamageBlockWithButton_endscreen")
	$.GetContextPanel().SetParent(new_parent)
}



UpdateDamageBar()
function UpdateDamageBar()
{
    GameEvents.SendCustomGameEventToServer_custom("update_damage_bar", {})
    $.Schedule( 10, UpdateDamageBar)
}

function send_damage_bar(data)
{
	var maximum_damage = 0
	var maximum_damage_phys = 0
	var maximum_damage_magic = 0
	var maximum_damage_pure = 0

	for ( var hero in data )
	{
		if (hero == "n")
			continue

		maximum_damage = maximum_damage + data[hero].all_damage
		maximum_damage_phys = maximum_damage_phys + data[hero].phys
		maximum_damage_magic = maximum_damage_magic + data[hero].magic
		maximum_damage_pure = maximum_damage_pure + data[hero].pure
	}

	if (maximum_damage > 0)
		$("#DamageInfoBar").AddClass("DamageInfoBar_shadow")

	let phys_panel = $.GetContextPanel().FindChildTraverse("AllDamagePhys")
	let magic_panel = $.GetContextPanel().FindChildTraverse("AllDamageMagical")
	let pure_panel = $.GetContextPanel().FindChildTraverse("AllDamagePure")

	let phys_text = $.GetContextPanel().FindChildTraverse("AllDamagePhysPercent")
	let magic_text = $.GetContextPanel().FindChildTraverse("AllDamageMagicalPercent")
	let pure_text = $.GetContextPanel().FindChildTraverse("AllDamagePurePercent")

	var percent_phys = (maximum_damage_phys * 100) / (maximum_damage || 1)
	var percent_magic = (maximum_damage_magic * 100) / (maximum_damage || 1)
	var percent_pure = (maximum_damage_pure * 100) / (maximum_damage || 1)

	phys_panel.style.width = percent_phys.toFixed(0) +'%';
	magic_panel.style.width = percent_magic.toFixed(0) +'%';
	pure_panel.style.width = percent_pure.toFixed(0) +'%';

	phys_text.text = '';
	magic_text.text = '';
	pure_text.text = '';

	if (percent_phys > percent_magic && percent_phys > percent_pure)	
	{
		phys_text.text = percent_phys.toFixed(0)+'%';
	}else if (percent_magic > percent_phys && percent_magic > percent_pure)	
	{
		magic_text.text = percent_magic.toFixed(0)+'%';
	}else
		pure_text.text = percent_pure.toFixed(0)+'%';

}


function ChangeViewType()
{
	Game.EmitSound("UI.Click")
	let checkbox = $.GetContextPanel().FindChildTraverse("BottomPanelCheckbox")
	let header = $.GetContextPanel().FindChildTraverse("TempHeader")

	let DamageAbilitiesHealing_Total = $.GetContextPanel().FindChildTraverse("DamageAbilitiesHealing_Total")
	let DamageAbilitiesIncome_Total = $.GetContextPanel().FindChildTraverse("DamageAbilitiesIncome_Total")
	let DamageAbilities_Total = $.GetContextPanel().FindChildTraverse("DamageAbilities_Total")

	let DamageAbilitiesHealing_Recent = $.GetContextPanel().FindChildTraverse("DamageAbilitiesHealing_Recent")
	let DamageAbilitiesIncome_Recent = $.GetContextPanel().FindChildTraverse("DamageAbilitiesIncome_Recent")
	let DamageAbilities_Recent = $.GetContextPanel().FindChildTraverse("DamageAbilities_Recent")

	if (show_total)
	{
		DamageAbilitiesHealing_Recent.RemoveClass("panel_hidden")
		DamageAbilitiesIncome_Recent.RemoveClass("panel_hidden")
		DamageAbilities_Recent.RemoveClass("panel_hidden")

		DamageAbilitiesHealing_Total.AddClass("panel_hidden")
		DamageAbilitiesIncome_Total.AddClass("panel_hidden")
		DamageAbilities_Total.AddClass("panel_hidden")

		checkbox.RemoveClass("BottomPanelCheckbox_active")
		checkbox.AddClass("BottomPanelCheckbox_inactive")
		show_total = false
		header.text = $.Localize("#CurrentStatRecent")
	}else
	{
		DamageAbilitiesHealing_Recent.AddClass("panel_hidden")
		DamageAbilitiesIncome_Recent.AddClass("panel_hidden")
		DamageAbilities_Recent.AddClass("panel_hidden")

		DamageAbilitiesHealing_Total.RemoveClass("panel_hidden")
		DamageAbilitiesIncome_Total.RemoveClass("panel_hidden")
		DamageAbilities_Total.RemoveClass("panel_hidden")

		checkbox.AddClass("BottomPanelCheckbox_active")
		checkbox.RemoveClass("BottomPanelCheckbox_inactive")
		show_total = true
		header.text = $.Localize("#CurrentStatTotal")
	}
}



Game.DamageToggle = function(override)
{
	if (is_active == false)
		return

	let main = $.GetContextPanel().FindChildTraverse("DamageBlockWithButton")

	let should_open = false
	if (toggle == false)
	{
		should_open = true
	}
	if (override != 2)
		should_open = override

    if (should_open) 
    {
        toggle = true;

        main.RemoveClass("damage_close");
        main.AddClass("damage_open");
        main.AddClass("DamageBlockWithButton_opened")
        main.RemoveClass("DamageBlockWithButton_closed")

      // 	Game.EmitSound("UI.Talent_show")

		local_hero_ent = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())
		local_hero = Entities.GetUnitName(local_hero_ent)

		if (cooldown_update == false)
		{
			player_table = CustomNetTables.GetTableValue("upgrades_player", local_hero)
    		GameEvents.SendCustomGameEventToServer_custom("update_damage_stats", {})
			cooldown_update = true

	    	$.Schedule( 1, function()
	    	{
	    		cooldown_update = false
	    	})
    	}

    } else 
    {
        toggle = false;

        main.RemoveClass("damage_open");
        main.AddClass("damage_close");
        main.RemoveClass("DamageBlockWithButton_opened")
        main.AddClass("DamageBlockWithButton_closed")

       //	Game.EmitSound("UI.Talent_hide")
    }
}

DamageToggleButton("DamageAbilitiesIncome", "DamageAbilitiesIncomeButton")
function DamageToggleButton(tab, button) 
{
	$("#DamageAbilities").style.visibility = "collapse";
	$("#DamageAbilitiesIncome").style.visibility = "collapse";
	$("#DamageAbilitiesHealing").style.visibility = "collapse";
	$("#" + tab).style.visibility = "visible";

	$("#DamageAbilitiesIncomeButton").RemoveClass("DamageAbilitiesIncomeButton_select")
	$("#DamageAbilitiesButton").RemoveClass("DamageAbilitiesButton_select")
	$("#DamageAbilitiesHealingButton").RemoveClass("DamageAbilitiesHealingButton_select")

	Game.EmitSound("UI.Click")

	current_sub_tab = tab;

	$("#" + button).AddClass(button + "_select")
}

function send_damage_stats(data)
{
	local_hero_ent = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())
	local_hero = Entities.GetUnitName(local_hero_ent)
		
	for (name in data)
	{
		if (name == "n")
			continue

		if (name == "outgoing")
			damage_table_outgoing = data[name]

		if (name == "incoming")
			damage_table_incoming = data[name]

		if (name == "healing")
			damage_table_healing = data[name]

		if (name == "temp")
			damage_table_temp = data[name]
	}

	UpdateAbilitiesHudHealing()
	UpdateAbilitiesHudDamage()
	UpdateAbilitiesHudDamageIncoming()
}


function CreateList(table, parent_panel, use_percent, is_healing, use_mini)
{
	let i = 0
	let sorted_table = Object.entries(table).map(([key, data]) => (data["name"] = key, data)).sort((a, b) => (b["damage"] - a["damage"] ))
	var maximum_damage = 0

	for (let data of sorted_table)
	{
		maximum_damage = maximum_damage + data["damage"]
	}

	for (let damage_data of sorted_table)
	{
		i++
		let ability_name = damage_data["name"]
		let damage = damage_data["damage"]
		let damage_types = damage_data["damage_types"]

		let ability_panel = parent_panel.FindChildTraverse("unit_damage_" + ability_name)
		if (ability_panel == null)
			ability_panel = CreateNewAbility(damage_data, parent_panel, is_healing, use_mini)

		if (parent_panel.GetChild(i-1))
			parent_panel.MoveChildAfter( ability_panel, parent_panel.GetChild(i-1) );

		var percent = Math.max(0.1, (damage * 100) / (maximum_damage || 1))

		if (ability_panel)
		{
			let damage_line = ability_panel.FindChildTraverse("DamageLine")
			damage_line.style['width'] = percent.toFixed(0) +'%';

			if (damage_types)
			{
				let sorted_damage_types = Object.entries(damage_types).sort((a, b) => (b[1] - a[1]))

				let type_count = 0
				for (let type_data of sorted_damage_types)
				{
					type_count++
					let type_name = type_data[0]
					let type_damage = type_data[1]
					var width_perc = type_damage/damage
					let type_panel = damage_line.FindChildTraverse("SubDamageLine_" + type_name)

					if (type_panel)
					{
						type_panel.style.width = width_perc*100 + "%"
					
						if (damage_line.GetChild(type_count-1))
							damage_line.MoveChildAfter( type_panel, damage_line.GetChild(type_count-1) );
					}
				}
			}
		}
		
		let text = String(CheckStringDamage(damage))
		if (use_percent)
			text =  text + " " + "( " + percent.toFixed(0) + "% )"
		ability_panel.FindChildTraverse("DamageUnitLabel").text = text
	}
}

function UpdateAbilitiesHudHealing()
{
	CreateList(damage_table_healing, $( "#DamageAbilitiesHealing_Total" ), true, true, false)

	let TempHealing = $.GetContextPanel().FindChildTraverse("TempHealing")
	if (TempHealing)
		TempHealing.DeleteAsync(0)

	TempHealing = $.CreatePanel("Panel", $("#DamageAbilitiesHealing_Recent"), "TempHealing")
	TempHealing.AddClass("TempContent")

	let found = false
	for (name in damage_table_temp)
	{
		if (name == "healing")
		{
			found = true
			CreateList(damage_table_temp[name].damages, TempHealing, false, true, false)
			break
		}
	}
	if (found == false)
	{
		let text = $.CreatePanel("Label", TempHealing, "")
		text.AddClass("TempTextNoData")
		text.text = $.Localize("#NoData_Healing")
	}
} 

function UpdateAbilitiesHudDamage() 
{
	CreateList(damage_table_outgoing, $( "#DamageAbilities_Total" ), true, false, false)

	let TempOutgoing = $.GetContextPanel().FindChildTraverse("TempOutgoing")
	if (TempOutgoing)
		TempOutgoing.DeleteAsync(0)

	TempOutgoing = $.CreatePanel("Panel", $("#DamageAbilities_Recent"), "TempOutgoing")
	TempOutgoing.AddClass("TempContent")

	let found = false
	for (name in damage_table_temp)
	{
		if (name == "outgoing")
		{
			found = true
			CreateList(damage_table_temp[name].damages, TempOutgoing, false, false, false)
			break
		}
	}
	if (found == false)
	{
		let text = $.CreatePanel("Label", TempOutgoing, "")
		text.AddClass("TempTextNoData")
		text.text = $.Localize("#NoData_Outgoing")
	}
}


function UpdateAbilitiesHudDamageIncoming() 
{
	var table_units = damage_table_incoming

	for ( var info of Object.keys(table_units) )
	{
		let hero_panel = $( "#DamageAbilitiesIncome_Total" ).FindChildTraverse("unit_name_" + info)
		
		if (hero_panel == null)
		{
			hero_panel = CreateNewHero(info, $( "#DamageAbilitiesIncome_Total" ))
		} else {
			hero_panel = hero_panel.FindChildTraverse("abilities")
		}

		var hero_max_damage = table_units[info].phys + table_units[info].magic + table_units[info].pure

		let phys_line = hero_panel.FindChildTraverse("DamageLinePhys")
		let magic_line = hero_panel.FindChildTraverse("DamageLineMagic")
		let pure_line = hero_panel.FindChildTraverse("DamageLinePure")

		var phys_percent = (table_units[info].phys * 100) / (hero_max_damage || 1)
		var magic_percent = (table_units[info].magic * 100) / (hero_max_damage || 1)
		var pure_percent = (table_units[info].pure * 100) / (hero_max_damage || 1)

		phys_line.style['width'] = phys_percent.toFixed(0) +'%';
		magic_line.style['width'] = magic_percent.toFixed(0) +'%';
		pure_line.style['width'] = pure_percent.toFixed(0) +'%';

		hero_panel.FindChildTraverse("DamageUnitLabelPhys").text = CheckStringDamage(table_units[info].phys)
		hero_panel.FindChildTraverse("DamageUnitLabelMagic").text = CheckStringDamage(table_units[info].magic)
		hero_panel.FindChildTraverse("DamageUnitLabelPure").text =CheckStringDamage(table_units[info].pure)
	}

	let TempIncoming = $.GetContextPanel().FindChildTraverse("TempIncoming")
	if (TempIncoming)
		TempIncoming.DeleteAsync(0)

	TempIncoming = $.CreatePanel("Panel", $("#DamageAbilitiesIncome_Recent"), "TempIncoming")
	TempIncoming.AddClass("TempContent")

	let found = false
	for (name in damage_table_temp)
	{
		if (name != "outgoing" && name != "healing")
		{
			found = true
			let enemy_container = $.CreatePanel("Panel", TempIncoming, "enemy_container_" + name)
			enemy_container.AddClass("temp_enemy_container")
	
			let enemy_hero = $.CreatePanel("Panel", enemy_container, "")
			enemy_hero.AddClass("temp_enemy_hero")

			let enemy_hero_icon = $.CreatePanel("Panel", enemy_hero, "")
			enemy_hero_icon.AddClass("temp_enemy_hero_icon")
		    enemy_hero_icon.style.backgroundImage = 'url("s2r://panorama/images/heroes/icons/' + name + '_png.vtex")';
		    enemy_hero_icon.style.backgroundSize = "100%";

			let parent_panel = $.CreatePanel("Panel", enemy_container, "")
			parent_panel.AddClass("temp_enemy_damages")

			CreateList(damage_table_temp[name].damages, parent_panel, false, false, true)
		}
	}
	if (found == false)
	{
		let text = $.CreatePanel("Label", TempIncoming, "")
		text.AddClass("TempTextNoData")
		text.text = $.Localize("#NoData_Incoming")
	}
} 

function compareFunc( a, b)
{
	if ( a < b )
	{
		return 1; // [ B, A ]
	}
	else if ( a > b )
	{
		return -1; // [ A, B ]
	}
	else
	{
		return 0;
	}
};

function CreateNewAbility(table, general, is_healing, is_mini) 
{
	let name = table["name"]
	let type = table["type"]
	let new_icon = table["new_icon"]
	let color = table["color"]
	let damage_type = is_healing ? table["healing_type"] : table["damage_type"]
	let damage = table["damage"]
	let damage_types = table["damage_types"]
    let skill_change = table["skill_change"]

	let UnitPortraitClass = is_mini ? "UnitPortraitMini" : "UnitPortrait"

	var UnitDamagePanel = $.CreatePanel( "Panel", general, "unit_damage_"+ name );
	UnitDamagePanel.AddClass("UnitDamagePanel");
	is_mini ? UnitDamagePanel.AddClass("UnitDamagePanelMini") : UnitDamagePanel.AddClass("UnitDamagePanelBase")

	if (type == "item" )
	{
		var UnitPortrait = $.CreatePanel("DOTAItemImage", UnitDamagePanel, "UnitPortrait");
	    UnitPortrait.AddClass(UnitPortraitClass)
    	UnitPortrait.itemname = name;
    	UnitPortrait.style.height = "22px"
	} else if (type == "ability" ) 
	{
		var UnitPortrait = $.CreatePanel("DOTAAbilityImage", UnitDamagePanel, "UnitPortrait");
	    UnitPortrait.AddClass(UnitPortraitClass)

		if (name == "Scepter" || name == "shard" || name == "Shard" || name == "scepter") 
    	{
    		UnitPortrait.SetImage( "file://{images}/custom_game/icons/mini/general_changes/" + name + ".png" )
    	}else
    	{
    		UnitPortrait.abilityname = name;
    		UnitPortrait.SetPanelEvent('onmouseover', function() {
		    	$.DispatchEvent('DOTAShowAbilityTooltip', UnitPortrait, name); 
			});
		        
		    UnitPortrait.SetPanelEvent('onmouseout', function() {
		     $.DispatchEvent('DOTAHideAbilityTooltip', UnitPortrait);
    		}); 
    	}
    } else if (type == "talent" ) 
    {
        var UnitPortrait = $.CreatePanel("DOTAAbilityImage", UnitDamagePanel, "UnitPortrait");
	    UnitPortrait.AddClass(UnitPortraitClass)
    	UnitPortrait.abilityname = "";
    	UnitPortrait.SetImage( "file://{images}/custom_game/icons/mini/" + new_icon + ".png" )

    	let lvl = 0
    	if (player_table)
    		lvl = player_table.upgrades[name]

        let table_name = local_hero
        let talent_data = Game.talents_values[table_name][name]

        if (talent_data == undefined)
        {
            for (find_table_name in Game.talents_values)
            {
                if (Game.talents_values[find_table_name][name] != undefined)
                {
                    talent_data = Game.talents_values[find_table_name][name]
                    table_name = find_table_name
                    break
                }
            }
        }

        let max_level = Game.GetMaxLevel(talent_data)

       	if (color == "gray")
       	{
            let gray_bonus = talent_data["general_bonus"]
            var value = '+' + String(Math.trunc(lvl * gray_bonus)) + $.Localize('#talent_disc_' + name)

            UnitPortrait.SetPanelEvent('onmouseover', function() {
		        $.DispatchEvent('DOTAShowTextTooltip', UnitPortrait, value)
		    });

		    UnitPortrait.SetPanelEvent('onmouseout', function() {
		        $.DispatchEvent('DOTAHideTextTooltip', UnitPortrait);
		    });
       	}else
    		MouseOverTalent(UnitPortrait, "#upgrade_disc_" + name, name, lvl, true, color == "orange" ? "legendary" : color, max_level, Game.GetLocalPlayerID(), local_hero)
      	

    	if ((color) && (color != ""))
    	{
    		UnitPortrait.AddClass("DamageTalentColor_" + color)
    	}

    }
    else 
    {
		var UnitPortrait = $.CreatePanel("DOTAAbilityImage", UnitDamagePanel, "UnitPortrait");
	    UnitPortrait.AddClass(UnitPortraitClass)

    	UnitPortrait.abilityname = "action_attack";
    	UnitPortrait.SetImage( "s2r://panorama/images/spellicons/action_attack_png.vtex" )

    	let text = $.Localize("#attack_tooltip")
	    UnitPortrait.SetPanelEvent('onmouseover', function() {
	        $.DispatchEvent('DOTAShowTextTooltip', UnitPortrait, text)
	    });

	    UnitPortrait.SetPanelEvent('onmouseout', function() {
	        $.DispatchEvent('DOTAHideTextTooltip', UnitPortrait);
	    });
	}


	var UnitDamageInfoPanel = $.CreatePanel( "Panel", UnitDamagePanel, "" );
	UnitDamageInfoPanel.AddClass( "UnitDamageInfoPanel" );

	var DamageUnitLabel = $.CreatePanel( "Label", UnitDamageInfoPanel, "DamageUnitLabel" );
	DamageUnitLabel.text = '1'// CheckStringDamage(damage)

	var DamageLineBG = $.CreatePanel( "Panel", UnitDamageInfoPanel, "DamageLineBG" );
	var DamageLineBG2 = $.CreatePanel( "Panel", DamageLineBG, "DamageLineBG2" );

	var DamageLineStart = $.CreatePanel( "Panel", DamageLineBG2, "" );
	DamageLineStart.AddClass( "DamageLineStart" );

	var DamageLine = $.CreatePanel( "Panel", DamageLineBG2, "DamageLine" );
	DamageLine.AddClass("DamageLine")
	is_mini ? DamageLine.AddClass("DamageLineMini") : DamageLine.AddClass("DamageLineBase")
	DamageLine.AddClass("DamageLine_no")

	if (is_healing)
	{
		if (damage_type == "healing")
		{
			DamageLine.AddClass("DamageLine_healing")
		}else if (damage_type = "shield")
		{
			DamageLine.AddClass("DamageLine_shield")
		}
	}else
	{
		if (damage_types)
		{
			var SubDamageLineMagic = $.CreatePanel( "Panel", DamageLine, "SubDamageLine_2" );
			SubDamageLineMagic.AddClass("SubDamageLine")
			SubDamageLineMagic.AddClass("DamageLine_magical")

			var SubDamageLinePhys = $.CreatePanel( "Panel", DamageLine, "SubDamageLine_1" );
			SubDamageLinePhys.AddClass("SubDamageLine")
			SubDamageLinePhys.AddClass("DamageLine_phys")

			var SubDamageLinePure = $.CreatePanel( "Panel", DamageLine, "SubDamageLine_4" );
			SubDamageLinePure.AddClass("SubDamageLine")
			SubDamageLinePure.AddClass("DamageLine_pure")
		}else
		{
			if (damage_type == 1 )
			{
				DamageLine.AddClass("DamageLine_phys")
			} else if (damage_type == 2 ) {
				DamageLine.AddClass("DamageLine_magical")
			} else if (damage_type == 4 ) {
				DamageLine.AddClass("DamageLine_pure")
			}
		}
	}
	return UnitDamagePanel
}

function MouseOverTalent(panel, talent_text, name, lvl, all_levels, rarity, max_level, player_id, hero, is_scepter, skill_change) 
{
    panel.SetPanelEvent("onmouseover", () => 
    {
        Game.CustomTooltipOpened = true

        $.DispatchEvent(
            "UIShowCustomLayoutParametersTooltip",
            panel,
            "skill_tooltip",
            "file://{resources}/layout/custom_game/custom_tooltip.xml",
            "talent_text=" + talent_text + "&name=" + name + "&lvl=" + lvl + "&all_levels=" + all_levels + "&rarity=" + rarity + "&max_level=" + max_level + "&player_id=" + player_id + "&hero_name=" + hero + "&is_scepter=" + is_scepter + "&skill_change=" + skill_change,
        );
    });
    panel.SetPanelEvent("onmouseout", () => 
    {
        Game.CustomTooltipOpened = false
        $.DispatchEvent("UIHideCustomLayoutTooltip", panel, "skill_tooltip");
    });
}


function CreateNewHero(hero_name, general) 
{
	var UnitHeroInfo = $.CreatePanel( "Panel", general, "unit_name_"+hero_name );
	UnitHeroInfo.AddClass( "UnitHeroInfo" );

    var UnitPortrait_hero = $.CreatePanel("Panel", UnitHeroInfo, "UnitPortrait_hero");
    UnitPortrait_hero.style.backgroundImage = 'url("s2r://panorama/images/heroes/icons/' + hero_name + '_png.vtex")';
    UnitPortrait_hero.style.backgroundSize = "100%";
    UnitPortrait_hero.style.height = "30px"
    UnitPortrait_hero.style.width = "30px"

    var UnitHeroInfoAbilities = $.CreatePanel( "Panel", UnitHeroInfo, "abilities" );
	UnitHeroInfoAbilities.AddClass( "UnitHeroInfoAbilities" );

	var UnitDamageInfoPanelPhys = $.CreatePanel( "Panel", UnitHeroInfoAbilities, "" );
	UnitDamageInfoPanelPhys.AddClass( "UnitDamageInfoPanelIncome" );
	
	var DamageUnitLabelPhys = $.CreatePanel( "Label", UnitDamageInfoPanelPhys, "DamageUnitLabelPhys" );
	var DamageLineBGPhys = $.CreatePanel( "Panel", UnitDamageInfoPanelPhys, "DamageLineBGPhys" );
	var DamageLineBG2Phys = $.CreatePanel( "Panel", DamageLineBGPhys, "DamageLineBG2Phys" );

	//var DamageLineStart = $.CreatePanel( "Panel", DamageLineBG2Phys, "" );
	//DamageLineStart.AddClass( "DamageLineStart" );
	//DamageLineStart.style.backgroundColor = "#ae2f28"

	var DamageLinePhys = $.CreatePanel( "Panel", DamageLineBG2Phys, "DamageLinePhys" );
	DamageLinePhys.AddClass("DamageLine_phys")
	DamageLinePhys.AddClass("DamageLineInc")

	var UnitDamageInfoPanelMagic = $.CreatePanel( "Panel", UnitHeroInfoAbilities, "" );
	UnitDamageInfoPanelMagic.AddClass( "UnitDamageInfoPanelIncome" );
	
	var DamageUnitLabelMagic = $.CreatePanel( "Label", UnitDamageInfoPanelMagic, "DamageUnitLabelMagic" );
	var DamageLineBGMagic = $.CreatePanel( "Panel", UnitDamageInfoPanelMagic, "DamageLineBGMagic" );
	var DamageLineBG2Magic = $.CreatePanel( "Panel", DamageLineBGMagic, "DamageLineBG2Magic" );

	//var DamageLineStart = $.CreatePanel( "Panel", DamageLineBG2Magic, "" );
	//DamageLineStart.AddClass( "DamageLineStart" );
	//DamageLineStart.style.backgroundColor = "#5b93d1"

	var DamageLineMagic = $.CreatePanel( "Panel", DamageLineBG2Magic, "DamageLineMagic" );
	DamageLineMagic.AddClass("DamageLine_magical")
	DamageLineMagic.AddClass("DamageLineInc")

	var UnitDamageInfoPanelPure = $.CreatePanel( "Panel", UnitHeroInfoAbilities, "" );
	UnitDamageInfoPanelPure.AddClass( "UnitDamageInfoPanelIncome" );
	
	var DamageUnitLabelPure = $.CreatePanel( "Label", UnitDamageInfoPanelPure, "DamageUnitLabelPure" );
	var DamageLineBGPure = $.CreatePanel( "Panel", UnitDamageInfoPanelPure, "DamageLineBGPure" );
	var DamageLineBG2Pure = $.CreatePanel( "Panel", DamageLineBGPure, "DamageLineBG2Pure" );

	//var DamageLineStart = $.CreatePanel( "Panel", DamageLineBG2Pure, "" );
	//DamageLineStart.AddClass( "DamageLineStart" );
	//DamageLineStart.style.backgroundColor = "#d8ae53"

	var DamageLinePure = $.CreatePanel( "Panel", DamageLineBG2Pure, "DamageLinePure" );
	DamageLinePure.AddClass("DamageLineInc")
	DamageLinePure.AddClass("DamageLine_pure")

    return UnitHeroInfoAbilities
}

function CheckStringDamage(damage) {
	if (damage > 999999) 
	{
		return String((damage/1000000).toFixed(1)) + "M"
	} else if (damage > 999) {
		return String((damage/1000).toFixed(1)) + "K"
	} else {
		return damage.toFixed(0)
	}
}
