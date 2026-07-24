--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);

var local_unit = ""
var legendary_info = []
var current_legendary = ""

GameEvents.Subscribe( "dota_player_update_selected_unit", UpdateSelectionUnit );
GameEvents.Subscribe( "dota_player_update_query_unit", UpdateSelectionUnit );
GameEvents.Subscribe( "m_event_dota_inventory_changed_query_unit", UpdateSelectionUnit );

Hack()
SpectatorPanelUpdate()

function UpdateSelectionUnit(...args)
{
	Hack()
	SpectatorPanelUpdate()
}



function Hack()
{
	var parentHUDElements = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("QuickBuyRows");
	var stash = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("stash_bg");
	var Row = parentHUDElements.FindChildTraverse("Row1")
	var Info = $.GetContextPanel().FindChildTraverse("AllPointsAndInfo");

	var minimap = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("HUDElements").GetParent()

	var Dota1x6 = $.GetContextPanel().FindChildTraverse("Dota1x6")

	if ((Game.IsHUDFlipped()) && (Info.BHasClass("AllPointsAndInfo")))
	{	
		Info.RemoveClass("AllPointsAndInfo")
		Info.AddClass("AllPointsAndInfo_left")
	}

	if (( !Game.IsHUDFlipped() ) && (Info.BHasClass("AllPointsAndInfo_left")))
	{
		Info.RemoveClass("AllPointsAndInfo_left")
		Info.AddClass("AllPointsAndInfo")
	}

	if (minimap.BHasClass("MinimapExtraLarge"))
	{
		Dota1x6.RemoveClass("Dota1x6_small")
		Dota1x6.AddClass("Dota1x6_large")
	}else 
	{
		Dota1x6.RemoveClass("Dota1x6_large")
		Dota1x6.AddClass("Dota1x6_small")
	}


	if ((Game.IsHUDFlipped()) && (Dota1x6.BHasClass("Dota1x6")))
	{	
		Dota1x6.RemoveClass("Dota1x6")
		Dota1x6.AddClass("Dota1x6_right")
	}

	if (( !Game.IsHUDFlipped() ) && (Dota1x6.BHasClass("Dota1x6_right")))
	{
		Dota1x6.RemoveClass("Dota1x6_right")
		Dota1x6.AddClass("Dota1x6")
	}

	var bonus = 0
	var margin = 0


	if (Row.visible)
	{	
		margin = 62.3
		bonus = 3
	}
	else
	{
		margin = 65.5
		bonus = 0
	}

	if (stash.visible)
	{	
		margin = 49.3 - bonus
	}

	var text = String(margin) + '%'
	Info.style.marginTop = text

	let hero = Entities.GetUnitName(Players.GetLocalPlayerPortraitUnit())

	if (hero != local_unit)
	{
		local_unit = hero
		current_legendary = ""
		UpdateInnatePanel()
	}

	var dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()
	let innate = dotaHud.FindChildTraverse("DOTAHUDInnateStatusTooltip")

	if (innate)
	{
		let content = innate.FindChildTraverse("Contents")
		let legendary_panel = dotaHud.FindChildTraverse("legendary_details")

		if (legendary_panel && content)
		{

			legendary_panel.SetParent(content)
			let innate_details = innate.FindChildrenWithClassTraverse("InnateContainer")[0]

			if (innate_details)
			{
				content.MoveChildBefore(legendary_panel, innate_details)
			}

			if (legendary_table[1] && legendary_table[1] != 0)
			{
				legendary_panel.RemoveClass("legendary_aspect_hidden")
			}else 
			{
				legendary_panel.AddClass("legendary_aspect_hidden")
			}
		}
	}
}


function UpdateInnatePanel(new_table)
{

	let hero = Entities.GetUnitName(Players.GetLocalPlayerPortraitUnit()) 

    var players_heroes = CustomNetTables.GetTableValue("hero_portrait_levels", hero)
    var player_id = Game.GetLocalPlayerID()

    if (players_heroes)
        player_id = players_heroes["id"]

    player_id = Number(player_id)

    let hero_index = Players.GetPlayerHeroEntityIndex(player_id)   

	var dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()
	if (!dotaHud)
		return

	legendary_table = Game.GetLocalLegendary()

	if (new_table != undefined)
	{
		legendary_table[0] = new_table.legendary
		legendary_table[1] = new_table.legendary_talent
		legendary_table[2] = new_table.legendary_skill_name
	}

    let skill_name = null 
    let talent_data = null
    let skill_number = null

    if (legendary_table[1] && Game.talents_values && Game.talents_values[hero] && Game.talents_values[hero][legendary_table[1]])
    {
		talent_data = Game.talents_values[hero][legendary_table[1]]
		skill_number = talent_data["skill_number"]
	    if (Game.spells_by_number[hero] && Game.spells_by_number[hero][skill_number])
	    {
	        skill_name = Game.spells_by_number[hero][skill_number]["name"]
	    }
	}

	let legendary_panel = dotaHud.FindChildTraverse("legendary_details")

	if (legendary_panel)
	{

		let legendary_details_top_icon = legendary_panel.FindChildTraverse("legendary_details_top_icon")
		let legendary_name = legendary_panel.FindChildTraverse("legendary_details_top_text")
	  	let legendary_text = legendary_panel.FindChildTraverse("legendary_details_text")
	  
		if (legendary_details_top_icon && legendary_table[0] && legendary_table[0] != 0)
		{
	        if (skill_name)
	        {
                let ability = Entities.GetAbilityByName(hero_index, skill_name)
                if (ability)
                    legendary_details_top_icon.contextEntityIndex =  ability
                legendary_details_top_icon.abilityname = skill_name
	        }
		}

		if (legendary_name)
		{
			legendary_name.text = $.Localize("#DOTA_Tooltip_ability_" + legendary_table[2])
		}
	}

	
	let global_facet = dotaHud.FindChildTraverse("ContentsContainer").GetParent()
	if (!global_facet)
		return
	
	global_facet.style.marginBottom = "20px"

	let aspect = dotaHud.FindChildTraverse("legendary_aspect")
	let legendary_icon = legendary_table[0]


	if (aspect)
	{
		let content = global_facet.FindChildTraverse("ContentsContainer")
		if (content)
		{	
			content.SetPanelEvent('onmouseover', function() 
			{
	  			let legendary_text = legendary_panel.FindChildTraverse("legendary_details_text")
				let legendary_info = Game.GetLocalLegendary()
				if (legendary_text && legendary_table[1] && legendary_info[1] != 0 && current_legendary == "")
				{
					current_legendary = Game.ShowTalentValues("#upgrade_disc_" + legendary_info[1], legendary_info[1], 0, false, true, true)
					legendary_text.text = current_legendary
				}
    		});

			aspect.SetParent(content)

			let innate_icon = content.FindChildTraverse("InnateIcon")
			if (innate_icon)
			{
				innate_icon.style.width = "32px"
				innate_icon.style.height = "32px"
				innate_icon.style.marginTop = "2px"

				content.MoveChildBefore(aspect, innate_icon)
			}

			if (legendary_icon != 0 )
			{
		        if (skill_name)
		        {
	                let ability = Entities.GetAbilityByName(hero_index, skill_name)
	                if (ability)
	                    aspect.contextEntityIndex =  ability
	                aspect.abilityname = skill_name
		        }
				aspect.RemoveClass("legendary_aspect_hidden")
			}else 
			{
				aspect.AddClass("legendary_aspect_hidden")
			}
		}
	}
}



function init()
{
	GameEvents.Subscribe_custom('kill_progress', OnKill)

	GameEvents.Subscribe_custom('hero_quest_init', hero_quest_init)
	GameEvents.Subscribe_custom('hero_quest_complete', hero_quest_complete)
	GameEvents.Subscribe_custom('hero_quest_update', hero_quest_update)

	GameEvents.Subscribe_custom('goodwin_quest_alert', goodwin_quest_alert)
	GameEvents.Subscribe_custom('goodwin_quest_icon', goodwin_quest_icon)

	GameEvents.Subscribe_custom('UpdateInnatePanel', UpdateInnatePanel)

	GameEvents.Subscribe_custom('grenade_count_change', grenade_count_change)

	var Info = $.GetContextPanel().FindChildTraverse("ButtonInfo");
 	var text = $.Localize('#talent_disc_upgrade_info')

	Info.SetPanelEvent('onmouseover', function() {
    $.DispatchEvent('DOTAShowTextTooltip', Info, text) });
    
Info.SetPanelEvent('onmouseout', function() {
    $.DispatchEvent('DOTAHideTextTooltip', Info);
});

}

init();



function goodwin_quest_alert(kv)
{
	Game.EmitSound("Hunt.Start")
	var Main = $.GetContextPanel().FindChildTraverse("GoodwinQuest")

	let event = $.CreatePanel("Panel",Main,"event")
	event.AddClass("GoodwinQuest_event")


	let portrait = $.CreatePanel("Panel",event,"portrait")
	portrait.AddClass("GoodwinQuest_portrait")

	let event_text_main = $.CreatePanel("Panel",event,"event")
	event_text_main.AddClass("GoodwinQuest_main")

	let event_text = $.CreatePanel("Label", event_text_main, "")
	event_text.html = true
	event_text.AddClass("GoodwinQuest_text") 
	event_text.text = $.Localize("#goodwin_quest_" + String(kv.id))

	Game.EmitSound("GoodwinQuest")


	$.Schedule( 7.55, function(){ 
		event.RemoveClass("GoodwinQuest_event");
        event.AddClass("GoodwinQuest_event_close");
        goodwin_quest_icon(kv)
	 })
	event.DeleteAsync( 8 );
}

function goodwin_quest_icon(kv)
{
	var main = $.GetContextPanel().FindChildTraverse("GoodwinQuest_panel")

	main.RemoveClass("GoodwinQuest_panel_hidden")

	var text = $.Localize("#goodwin_quest_" + String(kv.id))

	main.SetPanelEvent('onmouseover', function() {
	$.DispatchEvent('DOTAShowTextTooltip', main, text) });

	main.SetPanelEvent('onmouseout', function() {
	$.DispatchEvent('DOTAHideTextTooltip', main); });
}


function OnKill( kv )
{

	 BPoints = kv.blue
	 PPoints = kv.purple
	 max = kv.max
	 max_p = kv.max_p

	var BluePoints = $.GetContextPanel().FindChildTraverse("BluePoints");

	var BlueProgress = $.GetContextPanel().FindChildTraverse("BlueProgress");

	var BlueNumber = $.GetContextPanel().FindChildTraverse("BlueNumber");


	var PurplePoints = $.GetContextPanel().FindChildTraverse("PurplePoints");

	var PurpleProgress = $.GetContextPanel().FindChildTraverse("PurpleProgress");

	var PurpleNumber = $.GetContextPanel().FindChildTraverse("PurpleNumber");



	var Info = $.GetContextPanel().FindChildTraverse("ButtonInfo");


	var text = ""
	var number = 0
	var prev = 0 

	text = String(BPoints) + "/" + String(max) 

	prev = Number(BlueNumber.text)

	BlueNumber.text = text






	if (prev > Number(BlueNumber.text)) 

	{
		 BlueProgress.RemoveClass("Progress")
		BlueProgress.AddClass("ProgressFull")
		BlueProgress.style.width = "0%"
        BlueProgress.RemoveClass("ProgressFull")
		BlueProgress.AddClass("Progress")


	}

	number = (BPoints/max) * 95
	text = String(number)+'%'

	BlueProgress.style.width = text


	text = String(PPoints) + "/" + String(max_p) 

	prev = Number(PurpleNumber.text)

	PurpleNumber.text = text






	if (prev > Number(PurpleNumber.text)) 

	{
		 PurpleProgress.RemoveClass("Progress")
		PurpleProgress.AddClass("ProgressFull")
		PurpleProgress.style.width = "0%"
        PurpleProgress.RemoveClass("ProgressFull")
		PurpleProgress.AddClass("Progress")


	}

	number = (PPoints/max_p) * 95
	text = String(number)+'%'

	PurpleProgress.style.width = text



		
}

function SpectatorPanelUpdate()
{
    let hero = Players.GetLocalPlayerPortraitUnit()
    if (hero && Entities.IsRealHero( hero ) && IsSpectatorCustom(Players.GetLocalPlayer()))
    {
        let spectator_points = CustomNetTables.GetTableValue("spectator_points", Entities.GetPlayerOwnerID( hero ))
        if (spectator_points)
        {
            OnKill( 
            {
                blue : spectator_points.blue,
                purple : spectator_points.purple,
                max : spectator_points.max,
                max_p : spectator_points.max_p,
            })
        }
    }
}

function IsSpectatorCustom(id)
{
    const localPlayer = Players.GetLocalPlayer()
    if (Players.IsSpectator(localPlayer))
    {
        return true
    }
    const localTeam = Players.GetTeam(localPlayer)
    return localTeam !== 2 && localTeam !== 3 && localTeam !== 6 && localTeam !== 7 && localTeam !== 8 && localTeam !== 9 && localTeam !== 10 && localTeam !== 11 && localTeam !== 12 && localTeam !== 13
}


function grenade_count_change(kv)
{
  let main = $.GetContextPanel().FindChildTraverse("Grenade_count")
  if (main.BHasClass("Grenade_count_hidden"))
  {
    main.RemoveClass("Grenade_count_hidden")
   
    main.AddClass("Grenade_count")
  }

  if (kv.inc == 1)
  {
  	Game.EmitSound("UI.Grenade_Gain")
  }


  let filler = $.GetContextPanel().FindChildTraverse("Grenade_count_Filler")

  let width = (kv.count/kv.max) * 96
  let text = String(width)+'%'

  filler.style.width = text

  let number = $.GetContextPanel().FindChildTraverse("Grenade_count_Number")
  number.text = String(kv.count)

  var text1 = $.Localize("#Grenade_count_text")

	main.SetPanelEvent('onmouseover', function() {
   $.DispatchEvent('DOTAShowTextTooltip', main, text1) });
    
	main.SetPanelEvent('onmouseout', function() {
   $.DispatchEvent('DOTAHideTextTooltip', main); });
}


function roundPlus(x, n) { //x - число, n - количество знаков

	if (isNaN(x) || isNaN(n)) return false;

	var m = Math.pow(10, n);

	return Math.round(x * m) / m;

}


function hero_quest_init(kv)
{
	let main = $.GetContextPanel().FindChildTraverse("HeroQuest")

	let goal = kv.goal
	let progress = 0
	let icon = kv.icon
	let exp = kv.exp
	let shards = kv.shards
	let name = kv.name

	if (main.BHasClass("HeroQuest_hidden"))
	{
		main.RemoveClass("HeroQuest_hidden")
	}

	let icon_panel = $.GetContextPanel().FindChildTraverse("HeroQuest_icon")

	let text_panel = $.GetContextPanel().FindChildTraverse("HeroQuest_text")

	icon_panel.style.backgroundImage = "url('file://{images}/custom_game/icons/skills/" + icon + ".png')"
	icon_panel.style.backgroundSize = "contain"

	let goal_text = String(goal)
	let progress_text = String(progress)

	if (goal >= 10000)
	{
		goal_text = String(Math.floor(goal/1000)) + 'k'

		if (progress > 0)
		{
			progress_text = String((progress/1000).toFixed(1)) + 'k'
		}
	}

	text_panel.text = progress_text + '/' + goal_text


	let place = ""
	if (!kv.legendary)
	{
		place = '<br><br>' + $.Localize("#QuestDiscWin") + Game.GetWinPlace() + $.Localize("#QuestDiscWin2")
	}

	let text_info = $.Localize('#' + name) + '<br><br>' + $.Localize('#QuestReward') + "<b><font color='#53ea48'>" + String(shards) + "</font></b>" + $.Localize('#QuestReward2') + "<b><font color='#53ea48'>" + String(exp) + "</font></b>" + $.Localize('#QuestReward3') + place


	main.SetPanelEvent('onmouseover', function() {
    $.DispatchEvent('DOTAShowTextTooltip', main, text_info) });
    
	main.SetPanelEvent('onmouseout', function() {
    $.DispatchEvent('DOTAHideTextTooltip', main)});
}



function hero_quest_complete(kv)
{
	let main = $.GetContextPanel().FindChildTraverse("HeroQuest")

	if (main.BHasClass("HeroQuest_hidden"))
	{
		main.RemoveClass("HeroQuest_hidden")
	}


	Game.EmitSound("UI.Quest_Complete")

	let icon_panel = $.GetContextPanel().FindChildTraverse("HeroQuest_icon")
	icon_panel.AddClass("HeroQuest_complete")

	let text_panel = $.GetContextPanel().FindChildTraverse("HeroQuest_text_panel")
	text_panel.style.visibility = "collapse"

	main.style.width = "22.5%";


}


function hero_quest_update(kv)
{
	let main = $.GetContextPanel().FindChildTraverse("HeroQuest")

	if (main.BHasClass("HeroQuest_hidden"))
	{
		main.RemoveClass("HeroQuest_hidden")
	}

	if (kv.inc == 0)
	{

	let icon_panel = $.GetContextPanel().FindChildTraverse("HeroQuest_icon")

		icon_panel.style.backgroundImage = "url('file://{images}/custom_game/icons/skills/" + kv.icon + ".png')"
		icon_panel.style.backgroundSize = "contain"
	}

	let goal = kv.goal
	let progress = kv.progress


	if (progress% 1 != 0)
	{
		progress = progress.toFixed(1)
	}



	let text_panel = $.GetContextPanel().FindChildTraverse("HeroQuest_text")

	let goal_text = String(goal)
	let progress_text = String(progress)


	if (goal >= 10000)
	{
		goal_text = String(Math.floor(goal/1000)) + 'k'

		if (progress > 0)
		{
			progress_text = String((progress/1000).toFixed(1)) + 'k'
		}
	}

	text_panel.text = progress_text + '/' + goal_text
}