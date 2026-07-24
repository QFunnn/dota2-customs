--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);

var points_count = 0
var max_points = 0

var places_points
var places_points_solo = [14,12,10,8,6,4]
var places_points_duo = [12, 10, 8, 6, 4]

var place_exp
var place_exp_solo = [40,30,25,20,15,10]
var place_exp_duo = [35,25,20,15,10]

var kills_inc = 1
var kills_max = 10
var towers_inc = 4
var bounty_inc = 0.5
var bounty_max = 10

var gained_exp = 0
var init_exp = 0
var max_exp = 0
var current_exp = 0
var level = 0
var max_level = 30
var player_hero = ''
var place_taken = 0

var level_thresh = [6,12,18,25,30]

var can_add_exp = false

var account_points = 0
var max_account_points = 500

var sub_random_inc = 1.15

var subscribed = 0

var valid_time = 0

var thresh = [50,60,70,80, 100,120,140,160,180,200, 230,260,290,320,350,380, 420,460,500,540,580,620,680, 800,900,1000,1100,1200, 1500 ]

var sound  
var sound_exp

var closed = true

var achivment_table = {}

var achivment_complete = false
var quest_complete = false
var quest_icon = ""
var quest_exp = 0
var quest_shards = 0
var quest_name = ""

var IsEndScreen = false


function ShowHeroQuest(quest_data)
{

	let main = $.GetContextPanel().FindChildTraverse("EndScreenBonuses")
	let quest = $.GetContextPanel().FindChildTraverse("EndScreenQuest")
	let achivment = $.GetContextPanel().FindChildTraverse("EndScreenAchivment")

	main.RemoveClass("EndScreenBonuses_hide")
	main.RemoveClass("EndScreenBonuses_hidden")

	if (IsEndScreen)
	{
		main.AddClass("EndScreenBonuses_show_from_top")
		main.AddClass("EndScreenBonuses_down")
	}else
	{
		main.AddClass("EndScreenBonuses_show")
		main.AddClass("EndScreenBonuses_right")
	}

	$.Schedule(0.5, function()
	{ 	
		if (!main.BHasClass("EndScreenBonuses_hide"))
		{
			main.RemoveClass("EndScreenBonuses_show_from_top")
			main.RemoveClass("EndScreenBonuses_show")
		}
	})

	if (quest_data)
	{
		let panel = $.GetContextPanel().FindChildTraverse("EndScreenQuest")
		if (panel)
		{
			let text = $.Localize("#" + quest_data.name)
			panel.SetPanelEvent('onmouseover', function() {
				$.DispatchEvent('DOTAShowTextTooltip', panel, text)
			});

			panel.SetPanelEvent('onmouseout', function() {
				$.DispatchEvent('DOTAHideTextTooltip', panel);
			});
		}
		quest.RemoveClass("EndScreenBonuses_hidden")

		let icon_panel = $.GetContextPanel().FindChildTraverse("EndScreenQuest_icon")
		icon_panel.style.backgroundImage = "url('file://{images}/custom_game/icons/skills/" + quest_data.icon + ".png')"
		icon_panel.style.backgroundSize = "contain"

		let exp_panel = $.GetContextPanel().FindChildTraverse("EndScreenQuest_text_exp")
		exp_panel.text = '+' + String(quest_data.exp)

		let shards_panel = $.GetContextPanel().FindChildTraverse("EndScreenQuest_text_shards")
		shards_panel.text = '+' + String(quest_data.shards)
	}else
	{
		quest.AddClass("EndScreenBonuses_hidden")
	}

	if (achivment_table)
	{
		for (let achivment_id in achivment_table)
		{
			let data = achivment_table[achivment_id]
			let main = $.CreatePanel("Panel", $("#EndScreenBonuses"), "")
			main.AddClass("EndScreenQuest")

			let text = $.Localize("#achivment_disc_" + data.id)
			main.SetPanelEvent('onmouseover', function() {
				$.DispatchEvent('DOTAShowTextTooltip', main, text)
			});

			main.SetPanelEvent('onmouseout', function() {
				$.DispatchEvent('DOTAHideTextTooltip', main);
			});

			let top = $.CreatePanel("Panel", main, "")
			top.AddClass("EndScreenAchivment_Top_Container")

			let icon_panel = $.CreatePanel("Panel", top, "")
			icon_panel.AddClass("EndScreenAchivment_icon")
			icon_panel.style.backgroundImage = "url('file://{images}/custom_game/icons/mini/achivments/achivment_icon_" + data.id + ".png')"
			icon_panel.style.backgroundSize = "contain"

			let top_text = $.CreatePanel("Label", top, "")
			top_text.AddClass("EndScreenAchivment_text")
			top_text.html = true
			top_text.text = $.Localize("#AchivmentCompleted")

			let bottom = $.CreatePanel("Panel", main, "")
			bottom.AddClass("EndScreenAchivment_Bot_Container")

			let bot_icon = $.CreatePanel("Panel", bottom, "")
			bot_icon.AddClass("EndScreenAchivment_icon_shards")

			let bot_text = $.CreatePanel("Label", bottom, "")
			bot_text.AddClass("EndScreenAchivment_icon_text")
			bot_text.html = true
			bot_text.text = '+' + String(data.amount)
		}
	}
}

var max_games = 0

Game.ShowEndWindow = (kv, is_end_screen) =>
{

	//let sum = 0

	//for (var i = 0; i < Object.keys(thresh).length; i++) 
	//{
		//sum = sum + thresh[i]
	//}

	IsEndScreen = is_end_screen
 
	if (is_end_screen)
	{
		$.GetContextPanel().AddClass("MainEndScreen_down")
	}else
	{
		$.GetContextPanel().AddClass("MainEndScreen_right")
	}

	
	places_points = places_points_solo
	place_exp = place_exp_solo
	if (Game.GetGameMode() == 2)
	{
		places_points = places_points_duo 
		place_exp = place_exp_duo
	}

	closed = false
	if ((kv.quest_table) && (kv.quest_table.completed))
	{
		quest_complete = kv.quest_table.completed
		quest_icon = kv.quest_table.icon
		quest_exp = kv.quest_table.exp
		quest_shards = kv.quest_table.shards
		quest_name = kv.quest_table.name
	}
	achivment_table = kv.achivment_table
	if (achivment_table)
	{
		achivment_complete = true
	}


	var sub_data = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer());

	can_add_exp = false

	subscribed = 0

	place_taken = kv.place
	var kills = kv.kills
	var towers = kv.towers
	var bounty = kv.runes

	Game.EmitSound("UI.Endscreen")

	var init_exp = 0
	level = 1
	account_points = 0
	player_hero = Entities.GetUnitName( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) )//kv.hero

	account_points = kv.points
	subscribed = kv.subscribed
	level = kv.level
	init_exp = kv.exp
	valid_time = kv.valid_time
    max_exp = thresh[level - 1]

	var info_text = $.Localize("#Sub_info")

	var SubButton_info = $.GetContextPanel().FindChildTraverse("SubButton")

	var NoSub = $.GetContextPanel().FindChildTraverse("BottomPanel_NoSub")
	var HasSub = $.GetContextPanel().FindChildTraverse("BottomPanel_HasSub")

	if (subscribed == 1)
	{
		gained_exp = place_exp[place_taken - 1]

		if (kv.randomed == 1)
		{
			gained_exp = Math.floor(gained_exp*sub_random_inc)
		}

		if (valid_time == 0)
		{
			gained_exp = 0
		}

		let time = kv.expire

		let days = Math.floor((time/3600)/24)
		let display = String(days) + $.Localize("#pass_active_sub_days")

		if (days < 1)
		{
			display = String(Math.max(0, Math.floor(((time/3600)/24 - days)*24))) + $.Localize("#pass_active_sub_hours")
		}

		HasSub.RemoveClass("BottomPanel_hidden")
	}else
	{

		NoSub.RemoveClass("BottomPanel_hidden")
		SubButton_info.SetPanelEvent('onmouseover', function() {
			$.DispatchEvent('DOTAShowTextTooltip', SubButton_info, info_text)
		});


		SubButton_info.SetPanelEvent('onmouseout', function() {
			$.DispatchEvent('DOTAHideTextTooltip', SubButton_info);
		});

		SubButton_info.SetPanelEvent("onactivate", function() 
		{	
			GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "sub"});	
		});	
	}


	gained_exp = gained_exp + quest_exp
	var RandomBonus = $.GetContextPanel().FindChildTraverse("RandomBonus")


	if (kv.randomed == 1)
	{
		RandomBonus.RemoveClass("RandomBonus_hidden")
		var info_text_bonus = $.Localize("#RandomBonus_info")

		RandomBonus.SetPanelEvent('onmouseover', function() {
			$.DispatchEvent('DOTAShowTextTooltip', RandomBonus, info_text_bonus)
		});

		RandomBonus.SetPanelEvent('onmouseout', function() {
			$.DispatchEvent('DOTAHideTextTooltip', RandomBonus);
		});
	}else 
	{
		RandomBonus.AddClass("RandomBonus_hidden")
	}


	var main = $.GetContextPanel().FindChild("EndScreenWindow_all")
	main.RemoveClass("EndScreenWindow_all_hide")
	main.AddClass("EndScreenWindow_show")


	$.Schedule(0.8, function()
	{ 	
		main.AddClass("EndScreenWindow_all_glow")
	})

	let timer = 0.8
	if (is_end_screen)
		timer = 0

	$.Schedule(timer, function()
	{ 
		if (closed == false && (quest_complete == true || achivment_complete == true ))
		{
			let quest_table = null
			if (quest_complete)
			{
				quest_table = {}
				quest_table.icon = quest_icon
				quest_table.exp = quest_exp
				quest_table.shards = quest_shards
				quest_table.name = quest_name
			}
			ShowHeroQuest(quest_table)
		}
	})

	InitHeroLevel(init_exp, gained_exp)
	ShowPoints(kills, towers, bounty, kv.randomed)

	var TopText = $.GetContextPanel().FindChildTraverse("EndScreenWindow_top_text")

	TopText.text = $.Localize("#end_place_" + String(kv.place))
	var MidText = $.GetContextPanel().FindChildTraverse("EndScreenWindow_bot_text")


	var rating_before = kv.rating_before
	var rating_change = kv.rating_change
	var sign = '+'
	if (rating_change <= 0)
	{	
		sign = ""
	}

	
	MidText.text = $.Localize("#rating_change") + ' ' + String(rating_before)

	var ChangeText = $.GetContextPanel().FindChildTraverse("EndScreenWindow_bot_text_change")

	ChangeText.text =  ' (' + sign + String(rating_change) + ')'

	if (rating_change >= 0)
	{
		ChangeText.AddClass('Change_Plus')
	}
	else
	{
		ChangeText.AddClass('Change_Minus')
	} 

	var Button_Watch = $.GetContextPanel().FindChildTraverse("EndScreenWindow_close")

	if (!is_end_screen)
	{
		GameEvents.SendCustomGameEventToServer_custom("GiveGlobalVision",{})
	}else
	{
		Button_Watch.AddClass("style_collapse")
	}
}







function AddPoints()
{
	var count = $.GetContextPanel().FindChildTraverse("ShardsCount_text")
	var bot_count = $.GetContextPanel().FindChildTraverse("ShardsBotCount_text")


	count.text = '+' + String(points_count)

	var max_text = ''
	if (subscribed == 0) 
	{
		max_text = '/' + String(max_account_points)
	}

	bot_count.text = String(account_points) + max_text


	if ((points_count < max_points) && ((account_points < max_account_points) || (subscribed == 1)  ))
	{


		points_count = points_count + 1
		account_points = account_points + 1

		$.Schedule(1.5 / max_points , function() 
			{AddPoints()}
		)
	}
	else 
	{
		if (sound != null)
		{
			Game.StopSound(sound)
		}
		Game.EmitSound("Sub.Points_end")
		if ((account_points >= max_account_points) && (subscribed == 0) )
		{
			bot_count.AddClass("Max_points")
			count.AddClass("Max_points")
		}


		can_add_exp = true


		var tier = 0
		var j = 0

		for (var i = 0; i <= level; i++) {
			if (i >= level_thresh[j])
			{
				j = j + 1
				tier = tier + 1
			} 
		}

		if (tier < 5)
		{
			if (subscribed == 1)
			{
				var level_text = $.GetContextPanel().FindChildTraverse("PlaceForLevel_exp")
				level_text.text = '+' + String(gained_exp)
			}
			//level_text.AddClass("Exp_for_place_" + String(tier))

			sound_exp = Game.EmitSound("Sub.Exp_count")
		}
	}
}



function ShowPoints(kills_n, towers_n, bounty_n, randomed)
{
	var main = $.GetContextPanel().FindChildTraverse("EndScreenPoints")

	var kills = $.GetContextPanel().FindChildTraverse("ShardsCount_kills")
	var towers = $.GetContextPanel().FindChildTraverse("ShardsCount_towers")
	var bounty = $.GetContextPanel().FindChildTraverse("ShardsCount_bounty")
	var place = $.GetContextPanel().FindChildTraverse("ShardsCount_place")

	kills.AddClass("ShardInfo_label_hide")
	towers.AddClass("ShardInfo_label_hide")
	bounty.AddClass("ShardInfo_label_hide")
	place.AddClass("ShardInfo_label_hide")


	points_count = 0


	max_points = Math.min(kills_n*kills_inc, kills_max) + places_points[place_taken - 1] + towers_n*towers_inc + Math.floor(Math.min(bounty_n*bounty_inc, bounty_max))

	max_points = max_points

	if (randomed == 1)
	{
		max_points = Math.floor(max_points * sub_random_inc)
	}


	if (valid_time == 0)
	{
		max_points = 0
	}


	max_points = max_points + quest_shards



	sound = Game.EmitSound("Sub.Points_inc")
	AddPoints()

	$.Schedule(0.33, function()
	{ 	
		ShowShards_Place(kills_n, towers_n, bounty_n)
	})

}



function ShowShards_Place(kills, towers, bounty)
{
	var label = $.GetContextPanel().FindChildTraverse("ShardsCount_place")
	label.RemoveClass("ShardInfo_label_hide")
	label.AddClass("ShardInfo_label_show")

	var points = $.GetContextPanel().FindChildTraverse("ShardsInfo_place_text_points")

	let bonus = String(places_points[place_taken - 1])

	if (valid_time == 0)
	{
		bonus = 0
	}


	points.text = '(+' + bonus + ')';


	var text = $.GetContextPanel().FindChildTraverse("ShardsInfo_place_text")
	text.html = true;
	text.text =$.Localize("#shard_place") + String(place_taken)

	$.Schedule(0.33, function()
	{ 	
 		ShowShards_Kills( kills, towers, bounty)
	})

}



function ShowShards_Kills( kills, towers, bounty)
{
	var label = $.GetContextPanel().FindChildTraverse("ShardsCount_kills")
	label.RemoveClass("ShardInfo_label_hide")
	label.AddClass("ShardInfo_label_show")

	var text = $.GetContextPanel().FindChildTraverse("ShardsInfo_kills_text")
	var points = $.GetContextPanel().FindChildTraverse("ShardsInfo_kills_text_points")

	let bonus = String(Math.min(kills*kills_inc, kills_max) ) 

	if (valid_time == 0)
	{
		bonus = 0
	}

	points.text = '(+' + bonus + ')';

	text.html = true;
	var str = String(kills)
	if (kills > 10)
	{
		str = '10+'
	}

	text.text = $.Localize("#shard_kills") + str

	$.Schedule(0.33, function()
	{ 	
 		ShowShards_towers( towers, bounty)
	})

}


function ShowShards_towers( towers, bounty)
{
	var label = $.GetContextPanel().FindChildTraverse("ShardsCount_towers")
	label.RemoveClass("ShardInfo_label_hide")
	label.AddClass("ShardInfo_label_show")


	var points = $.GetContextPanel().FindChildTraverse("ShardsInfo_towers_text_points")

	let bonus = String(towers*towers_inc)

	if (valid_time == 0)
	{
		bonus = 0
	}

	points.text = '(+' + bonus + ')';



	var text = $.GetContextPanel().FindChildTraverse("ShardsInfo_towers_text")
	text.html = true;
	text.text = $.Localize("#shard_towers") + String(towers)

	$.Schedule(0.33, function()
	{ 	
 		ShowShards_bounty(bounty)
	})

}



function ShowShards_bounty(bounty)
{


	var label = $.GetContextPanel().FindChildTraverse("ShardsCount_bounty")
	label.RemoveClass("ShardInfo_label_hide")
	label.AddClass("ShardInfo_label_show")


	var points = $.GetContextPanel().FindChildTraverse("ShardsInfo_bounty_text_points")

	let bonus = Math.floor(String(Math.min(bounty*bounty_inc, bounty_max) ))

	if (valid_time == 0)
	{
		bonus = 0
	}

	points.text = '(+' + bonus + ')';
	


	var str = String(bounty)
	if (bounty > 20)
	{
		str = '20+'
	}

	var text = $.GetContextPanel().FindChildTraverse("ShardsInfo_bounty_text")
	text.html = true;
	text.text = $.Localize("#shard_bounty") + str



}



function InitHeroLevel(exp, gained)
{
	var hero_icon = $.GetContextPanel().FindChildTraverse("HeroLevel_icon")
	var hero_level = $.GetContextPanel().FindChildTraverse("HeroLevel_level")
    var total_text = $.GetContextPanel().FindChildTraverse("HeroLevel_bar_text")
    var level_text = $.GetContextPanel().FindChildTraverse("PlaceForLevel_level")

	let bar = $.GetContextPanel().FindChildTraverse("HeroLevel_bar")
	let filler = $.GetContextPanel().FindChildTraverse("HeroLevel_bar_filler")

    hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + player_hero + '.png" );'
    hero_icon.style.backgroundSize = 'contain';

	var tier = 0
	var j = 0

	for (var i = 0; i <= level; i++) {
		if (i >= level_thresh[j])
		{
			j = j + 1
			tier = tier + 1
		} 
	}
    

    if (tier < 5)
    {
    	gained_exp = gained
    	init_exp = exp
    	current_exp = 0
    	AddLevel()
    }
    else
    {
    	total_text.text = $.Localize('#hero_level') + String(level)
    	level_text.style.visibility = "collapse";
		filler.style.width = '97%';
    } 



    hero_level.AddClass("HeroLevel_icon_" + String(tier))
    bar.AddClass("HeroLevel_bar_" + String(tier))
    filler.AddClass("HeroLevel_filler_" + String(tier))


}



function IncLevel()
{
	init_exp = 0
	level = level + 1
    max_exp = thresh[level - 1]

    Game.EmitSound("Sub.Hero_levelup")

	var hero_level = $.GetContextPanel().FindChildTraverse("HeroLevel_level")

	let bar = $.GetContextPanel().FindChildTraverse("HeroLevel_bar")
	let filler = $.GetContextPanel().FindChildTraverse("HeroLevel_bar_filler")

    var tier = 0
	var j = 0

	for (var i = 0; i <= level; i++) {
		if (i >= level_thresh[j])
		{
			j = j + 1
			tier = tier + 1
		} 
	}
    

    hero_level.AddClass("HeroLevel_icon_" + String(tier))
    bar.AddClass("HeroLevel_bar_" + String(tier))
    filler.AddClass("HeroLevel_filler_" + String(tier))

}





function AddLevel()
{


	let filler = $.GetContextPanel().FindChildTraverse("HeroLevel_bar_filler")
    var level_text = $.GetContextPanel().FindChildTraverse("PlaceForLevel_level")
    var exp_text = $.GetContextPanel().FindChildTraverse("PlaceForLevel_exp")
    var total_text = $.GetContextPanel().FindChildTraverse("HeroLevel_bar_text")


	if (level == max_level)
	{
		let text = '97%'
		filler.style.width = text
    	total_text.text = $.Localize('#hero_level') + String(level)
    	level_text.style.visibility = "collapse";
    	exp_text.style.visibility = "collapse";
		Game.StopSound(sound_exp)
		return
	}


	let width = ( (init_exp)/max_exp) * 98

	if (subscribed == 1)
	{

   		level_text.text = $.Localize('#hero_level') + String(level) 
    	total_text.text =  String(init_exp) + '/' + String(max_exp)
    }
    else
    {
    	total_text.text = $.Localize("#level_no_sub")
    }


	let text = String(width)+'%'

	if (filler)
	{
		filler.style.width = text
	}

	if (can_add_exp == false)
	{

		$.Schedule(0.1, function()
		{
			AddLevel()
		})
		return
	}

	if (current_exp < gained_exp)
	{
		current_exp = current_exp + 1
		init_exp = init_exp + 1

		if (init_exp >= max_exp)
		{
			IncLevel()
		}

		$.Schedule(1.5 / gained_exp, function()
		{
			AddLevel()
		})
	}
	else 
	{

		Game.StopSound(sound_exp)
	}
}


function CloseWindow()
{
	closed = true

	var main = $.GetContextPanel().FindChild("EndScreenWindow_all")

	var Quests = $.GetContextPanel().FindChildTraverse("EndScreenBonuses")

	if (quest_complete == 1 || achivment_complete == 1)
	{
		Quests.RemoveClass("EndScreenBonuses_show")
		Quests.AddClass("EndScreenBonuses_hide")
	}
	main.RemoveClass("EndScreenWindow_all_glow")
	main.RemoveClass("EndScreenWindow_show")
	main.AddClass("EndScreenWindow_all_hide")

	Game.EmitSound("UI.Info_Close")

}