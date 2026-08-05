--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


var SpellsMenuContent = $("#SpellsMenuContent");
var SpellsMenuContainer = $("#SpellsMenuContainer");
var SpellsMenuRerollContent = $("#SpellsMenuRerollContent");
var SpellsMenuReroll = $("#SpellsMenuReroll");
SpellsMenuReroll.visible = false
SpellsMenuContainer.visible = false

var SpellsMenuSpellsBlockSwap = FindDotaHudElement("SpellsMenuSpellsBlockSwap");
SpellsMenuSpellsBlockSwap.visible = false
var isOpenSwapMenu = false

function FindDotaHudElement(panel) {
	return $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse(panel);
}

var AbilityTooltipOver = (function(pan,skill){
    return function(){
        $.DispatchEvent( "DOTAShowAbilityTooltip", pan, skill)
    }
})

function OpenSpellsListingForPlayerHero() {
	if(isOpenSwapMenu == true){
		$.Msg("close swap")
		SpellsMenuSpellsBlockSwap.visible = false
		isOpenSwapMenu = false;
		return
	}else{
		$.Msg("open swap")
		isOpenSwapMenu = true;
		GameEvents.SendCustomGameEventToServer("GetSpeelsForSwapPanel", {})
	}
}


function GetPlayerSwapPanel( event_data ){
	SpellsMenuSpellsBlockSwap.RemoveAndDeleteChildren()
	SpellsMenuSpellsBlockSwap.visible = true;
    for(i in event_data['player_abilities']){
        let newChildPanel = $.CreatePanel( "DOTAAbilityImage", SpellsMenuSpellsBlockSwap, "" );
        newChildPanel.style.width = "100px";
        newChildPanel.SetDraggable(true);
        newChildPanel.abilityname = event_data['player_abilities'][i];
		newChildPanel.AddClass("swap_element")
    }
}

$.RegisterEventHandler( 'DragStart', $("#SpellsMenuSpellsBlockSwap"), OnDragStart );
$.RegisterEventHandler( 'DragEnd', $("#SpellsMenuSpellsBlockSwap"), OnDragEnd);
$.RegisterEventHandler( 'DragEnter', $("#SpellsMenuSpellsBlockSwap"), OnDragEnter );

var land_panel,dragPanel,beginPanel;
var cur_position1,cur_position2;

function OnDragStart( click_panel, dragCallbacks )
{
    beginPanel = click_panel;
    cur_position1 = GameUI.GetCursorPosition()
    dragPanel = $.CreatePanel( "DOTAAbilityImage", $.GetContextPanel(), "" );
    dragPanel.style.width= "100px";
    dragPanel.abilityname = click_panel.abilityname;
    dragCallbacks.displayPanel = dragPanel;
    dragCallbacks.offsetX = 0; 
    dragCallbacks.offsetY = 0;
    return true;
}

function OnDragEnter( panel, draggedPanel )
{
    land_panel=panel;
    return true;
}

function OnDragEnd( click_panel, draggedPanel )
{
    draggedPanel.DeleteAsync(0)
	if(land_panel.BHasClass("swap_element")){
		let tmp = land_panel.abilityname
		land_panel.abilityname = draggedPanel.abilityname
		beginPanel.abilityname = tmp
		GameEvents.SendCustomGameEventToServer("spells_menu_swap_player_spells", { first_ability_name: land_panel.abilityname, second_ability_name: beginPanel.abilityname});
		return true;
	}
}

function ShowSelectSkills(t){
	SpellsMenuContainer.visible = true
	SpellsMenuContent.RemoveAndDeleteChildren()
	for (var key in t) {
		if (t.hasOwnProperty(key)) {
			(function(key) {
                var value = t[key]
				var skill_panel = $.CreatePanel("Panel", SpellsMenuContent, "")
				skill_panel.BLoadLayoutSnippet("spell_select")
				var image = skill_panel.FindChildInLayoutFile("SpellImage")
				image.abilityname = value
				
        
				skill_panel.SetPanelEvent("onmouseover", AbilityTooltipOver(skill_panel, value));
				skill_panel.SetPanelEvent("onmouseout", function () {
					$.DispatchEvent("DOTAHideAbilityTooltip");
				});
				skill_panel.SetPanelEvent("onmouseactivate", function () {
					SelectSkill(value);
				});
            })(key);
        }
    }      
}


function ShowRerollSkills(t){
	SpellsMenuReroll.visible = true
	SpellsMenuRerollContent.RemoveAndDeleteChildren()
	for (var key in t) {
		if (t.hasOwnProperty(key)) {
			(function(key) {
                var value = t[key]
				var skill_panel = $.CreatePanel("Panel", SpellsMenuRerollContent, "")
				skill_panel.BLoadLayoutSnippet("spell_select")
				var image = skill_panel.FindChildInLayoutFile("SpellImage")
				image.abilityname = value
				
        
				skill_panel.SetPanelEvent("onmouseover", AbilityTooltipOver(skill_panel, value));
				skill_panel.SetPanelEvent("onmouseout", function () {
					$.DispatchEvent("DOTAHideAbilityTooltip");
				});
				skill_panel.SetPanelEvent("onmouseactivate", function () {
					RemoveSkill(value);
				});
            })(key);
        }
    }      
}

function RemoveSkill(name) {
	GameEvents.SendCustomGameEventToServer("RerollAbility", {AbilityName:name});
	SpellsMenuReroll.visible = false
}


function SelectSkill(name) {
	GameEvents.SendCustomGameEventToServer("AbilitySelected", {skill_name:name});
	SpellsMenuContainer.visible = false
}

(function () {
	GameEvents.Subscribe("ShowSelectSkillsEvent", ShowSelectSkills);	
	const centerBlock = FindDotaHudElement("center_block")
	 $.Schedule(0.1, function () {
			let cosmetics =FindDotaHudElement("BarOverItems");
			$("#SpellSwapButton").SetParent(cosmetics)
		});
	
    GameEvents.Subscribe("GetPlayerSwapPanel", GetPlayerSwapPanel);
    GameEvents.Subscribe("ShowRerollSkills", ShowRerollSkills);
})();