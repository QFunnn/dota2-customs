--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function InitVote()
{
	$("#shop_window_6").RemoveAndDeleteChildren()
	var heroes_to_vote = CustomNetTables.GetTableValue("sub_data", "heroes_vote").vote_table;
	var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());
	var vote_cost = CustomNetTables.GetTableValue("shop_items",  "votes_cost").cost;
	var vote_data = CustomNetTables.GetTableValue("sub_data", "heroes_vote")
	var active_vote = vote_data.active_vote;
	var hero_won = vote_data.hero_won;
	var end_date = vote_data.end_date;
	var top_panel =  $.CreatePanel("Panel", $("#shop_window_6"), "");
	top_panel.AddClass("heroes_vote_list_top")
	if (active_vote == 0)
	{
		var top_panel_text =  $.CreatePanel("Label", top_panel, "");
		top_panel_text.AddClass("heroes_vote_list_top_text")
		top_panel_text.text = $.Localize('#vote_top_end')

		var mid_panel_text =  $.CreatePanel("Label",  $("#shop_window_6"), "");
		mid_panel_text.AddClass("mid_panel_text")
		mid_panel_text.text = $.Localize('#vote_hero_won')

		var mid_panel_icon =  $.CreatePanel("Panel",  $("#shop_window_6"), "");
		mid_panel_icon.AddClass("mid_panel_icon")
		mid_panel_icon.style.backgroundImage = "url('file://{images}/heroes/" + String(hero_won) + ".png')"
		mid_panel_icon.style.backgroundSize = "contain";
		mid_panel_icon.AddClass("HeroImageVote_" + String(vote_data.hero_stat))

		var bot_panel_text =  $.CreatePanel("Label",  $("#shop_window_6"), "");
		bot_panel_text.AddClass("bot_panel_text")
		bot_panel_text.html = true
		bot_panel_text.text = $.Localize('#vote_hero_won_date')
		return
	}

	var top_panel_text =  $.CreatePanel("Label", top_panel, "");
	top_panel_text.AddClass("heroes_vote_list_top_text")
	top_panel_text.text = $.Localize('#vote_top')

	var player_vote_count = 0
	if (sub_data)
	{
		player_vote_count = sub_data.votes_count
	}

	let full_vote = 1	
	let heroes_vote_list = $.CreatePanel("Panel", $("#shop_window_6"), "heroes_vote_list");
	heroes_vote_list.AddClass("heroes_vote_list")

	for (var i = 1; i <= Object.keys(heroes_to_vote).length; i++) 
	{
        if (Number(heroes_to_vote[i][2]) >= full_vote)
        {
            full_vote = Number(heroes_to_vote[i][2])
        }
	}

	for (var i = 1; i <= Object.keys(heroes_to_vote).length; i++) 
	{
		let percent = Math.round((heroes_to_vote[i][2] / full_vote) * 95)
		if (full_vote == 0)
		{
			percent = 0
		}
		let hero_info = $.CreatePanel("Panel", heroes_vote_list, "");
		hero_info.AddClass("hero_info_vote")
		if (i == 1)
		{
			hero_info.AddClass("hero_info_vote_first")
		}

		var HeroImage = $.CreatePanel(`DOTAHeroImage`, hero_info, "", {scaling: "stretch-to-cover-preserve-aspect", heroname : String(heroes_to_vote[i][1]), tabindex : "auto", class: "HeroImageVote"});

		let vote_line_default = $.CreatePanel("Panel", hero_info, "");
		vote_line_default.AddClass("vote_line_default")

		let vote_line_background = $.CreatePanel("Panel", vote_line_default, "");
		vote_line_background.AddClass("vote_line_background")
		vote_line_background.AddClass("vote_line_background_" + String(heroes_to_vote[i][4]))

		let vote_line_reach = $.CreatePanel("Panel", vote_line_default, "");
		vote_line_reach.AddClass("vote_line_reach")
		//vote_line_reach.AddClass("vote_line_reach_" + String(heroes_to_vote[i][4]))
		vote_line_reach.style.width = percent + "%"

		var anim = $.CreatePanel("DOTAScenePanel", vote_line_reach, 'HealthBurner', {map:'scenes/hud/healthbarburner', hittest:'false', camera:'camera_1'});

		let vote_line_label = $.CreatePanel("Label", vote_line_default, "");
		vote_line_label.AddClass("vote_line_label")
		vote_line_label.text = heroes_to_vote[i][2]

		let button_vote_hero = $.CreatePanel("Panel", hero_info, "");
		button_vote_hero.AddClass("button_vote_hero")

		if (sub_data.votes_count > 0)
		{
			button_vote_hero.AddClass("button_vote_hero_money")
		}
        else 
		{
			button_vote_hero.AddClass("button_vote_hero_nomoney")
		}

		SetOpenVoteHero(button_vote_hero, String(heroes_to_vote[i][1]), String(heroes_to_vote[i][4]))

		let button_vote_hero_label = $.CreatePanel("Label", button_vote_hero, "");
		button_vote_hero_label.AddClass("button_vote_hero_label")
		button_vote_hero_label.text = $.Localize("#vote_for_hero")
	}

	let votes_count_panel = $.CreatePanel("Panel", $("#shop_window_6"), "");
	votes_count_panel.AddClass("votes_count_panel")

	let votes_panel_top = $.CreatePanel("Panel", votes_count_panel, "");
	votes_panel_top.AddClass("votes_count_panel_top")

	let votes_panel_mid = $.CreatePanel("Panel", votes_count_panel, "");
	votes_panel_mid.AddClass("votes_count_panel_mid")

	let votes_panel_mid_left = $.CreatePanel("Panel", votes_panel_mid, "");
	votes_panel_mid_left.AddClass("votes_count_panel_mid_left")

	let votes_panel_mid_right = $.CreatePanel("Panel", votes_panel_mid, "");
	votes_panel_mid_right.AddClass("votes_count_panel_mid_right")

	let button_buy_votes_button_free = $.CreatePanel("Panel", votes_panel_mid_right, "button_buy_votes_button_free");
	button_buy_votes_button_free.AddClass("button_buy_votes_button_free")

	let votes_panel_mid_right_bot = $.CreatePanel("Label", votes_panel_mid_right, "button_buy_votes_button_free_label");
	votes_panel_mid_right_bot.AddClass("votes_panel_mid_right_bot")

	var active = 1

	if (sub_data.subscribed == 1)
	{
		if (sub_data.free_vote_cd !== 0)
		{
			active = 0
			let cd = Math.max(1, Math.floor(sub_data.free_vote_cd/3600))
			let s = "#vote_free_cd_hour"

			if (cd == 1)
			{
				s = "#vote_free_cd_hour_2"
			}


			votes_panel_mid_right_bot.text = $.Localize("#vote_free_cd") + String(cd) + $.Localize(s)
		}
	}
	else 
	{
		votes_panel_mid_right_bot.text = $.Localize("#vote_free_plus")
		active = 0
	}

	if (active == 1)
	{	
		button_buy_votes_button_free.SetPanelEvent("onactivate", function() 
		{	
			
			button_buy_votes_button_free.SetPanelEvent("onactivate", function() {})

			Game.EmitSound("UI.Shop_Buy")
			GameEvents.SendCustomGameEventToServer_custom( "heroes_vote_free", {});
			$.Schedule( 0.15, function()
			{
				InitVote()
			})

		});
		button_buy_votes_button_free.AddClass("button_buy_votes_button_free_money")
	}
    else 
	{
		button_buy_votes_button_free.AddClass("button_buy_votes_button_free_nomoney")
	}

	let button_buy_votes_button_free_label = $.CreatePanel("Label", button_buy_votes_button_free, "button_buy_votes_button_free_label");
	button_buy_votes_button_free_label.AddClass("button_buy_votes_button_free_label")
	button_buy_votes_button_free_label.text = $.Localize("#vote_free")

	let votes_count_player = $.CreatePanel("Label", votes_panel_top, "votes_count_player");
	votes_count_player.AddClass("votes_count_player")
	votes_count_player.text = $.Localize("#vote_count")  + player_vote_count

	if (sub_data.votes_count < 1)
	{
		votes_count_player.AddClass("votes_count_player_no_votes")
	}

	let button_buy_votes_button = $.CreatePanel("Panel", votes_panel_mid_left, "button_buy_votes_button");
	button_buy_votes_button.AddClass("button_buy_votes_button")

	let button_buy_votes_label = $.CreatePanel("Label", button_buy_votes_button, "button_buy_votes_label");
	button_buy_votes_label.AddClass("button_vote_hero_buy")
	button_buy_votes_label.text = $.Localize("#vote_buy") 

	let button_buy_votes_label_icon = $.CreatePanel("Panel", button_buy_votes_button, "button_vote_hero_icon");
	button_buy_votes_label_icon.AddClass("button_vote_hero_icon")

	let button_buy_votes_label_cost = $.CreatePanel("Label", button_buy_votes_button, "button_buy_votes_label_cost");
	button_buy_votes_label_cost.AddClass("button_vote_hero_cost")
	button_buy_votes_label_cost.text = $.Localize("#shop_buy") 

	SetBuyVoteCount(button_buy_votes_button)

	let button_buy_votes_entry = $.CreatePanel("Label", votes_panel_mid_left, "");
	button_buy_votes_entry.AddClass("button_buy_votes_entry")


	let count_max = Math.max(1, Math.floor(sub_data.points/vote_cost))


	let number_entry = $.CreatePanel(`NumberEntry`, button_buy_votes_entry, "NumberEntryBuyVotes", {value : 1, min : 1, max : count_max});

	UpdateButVotes(1)

	if (number_entry)
	{
		let text_entry = number_entry.FindChildTraverse("TextEntry")
		if (text_entry)
		{
			SetChangeBuyVoteCount(text_entry)
		}
	}

	let end_date_label = $.CreatePanel("Label", $("#shop_window_6"), "");
	end_date_label.AddClass("end_date_label")
	end_date_label.text = $.Localize('#vote_end_date') + end_date
}

function SetChangeBuyVoteCount(textEntry)
{
    textEntry.SetPanelEvent("ontextentrychange", function () 
    {
        UpdateButVotes(Number(textEntry.text))
	    Game.EmitSound("UI.Click")
  	})
}

function UpdateButVotes(count)
{
	var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());
	let votes_cost = CustomNetTables.GetTableValue("shop_items", "votes_cost").cost

	let button_buy_votes_label_cost = $.GetContextPanel().FindChildTraverse("button_buy_votes_label_cost")
    let button_buy_votes_button = $.GetContextPanel().FindChildTraverse("button_buy_votes_button")

    if (button_buy_votes_label_cost)
    {
       	button_buy_votes_label_cost.text = count * votes_cost
    }

    if (button_buy_votes_button)
    {
       	if (sub_data.points >= count * votes_cost)
       	{
       		button_buy_votes_button.AddClass("button_buy_votes_money")
       		button_buy_votes_button.RemoveClass("button_buy_votes_nomoney")
       		button_buy_votes_label_cost.RemoveClass("button_vote_hero_cost_nomoney")
       	}
        else
       	{
       		button_buy_votes_button.RemoveClass("button_buy_votes_money")
       		button_buy_votes_button.AddClass("button_buy_votes_nomoney")
       		button_buy_votes_label_cost.AddClass("button_vote_hero_cost_nomoney")
       	}
    }
}

function SetBuyVoteCount(panel)
{
	panel.SetPanelEvent("onactivate", function() 
	{	
		BuyVoteLua()
	});
}

function BuyVoteLua()
{
	let NumberEntryBuyVotes = $.GetContextPanel().FindChildTraverse("NumberEntryBuyVotes")
	var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());
	let votes_cost = CustomNetTables.GetTableValue("shop_items", "votes_cost").cost

   	if (NumberEntryBuyVotes)
   	{
   		let text_entry = NumberEntryBuyVotes.FindChildTraverse("TextEntry")
   		if (text_entry)
   		{
	   		if (text_entry.text == "")
	   		{
	   			$.Msg("Пустое значение голосов")
	   		}
	   		else
	   		{
	   			let count_votes_buy = Number(text_entry.text)
	   			let cost_votes_buy = Number(text_entry.text) * votes_cost

	   			if (sub_data.points >= cost_votes_buy)
	   			{
					Game.EmitSound("UI.Click")
					CreateBuyWindow(-1, cost_votes_buy, String(count_votes_buy), 0)
				}
	   		}
	   	}
   	}
}

function SetOpenVoteHero(panel, hero_name, stat)
{
	panel.SetPanelEvent("onactivate", function() 
	{	
		var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());
		var player_vote_count = 0
		if (sub_data)
		{
			player_vote_count = sub_data.votes_count
		}
		if (player_vote_count > 0)
		{
			Game.EmitSound("UI.Click")
			OpenVoteHero(hero_name, stat)
		}
	});
}

function OpenVoteHero(hero_name, stat)
{
	var sub_data = CustomNetTables.GetTableValue("sub_data",  Players.GetLocalPlayer());

	let main = $.GetContextPanel().FindChildTraverse("window_shop")

	Game.EmitSound("UI.Shop_Buy_start")

	let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
	blur_panel.RemoveClass("shop_window_blur_hidden")
	blur_panel.AddClass("shop_window_blur")
	
	var player_vote_count = 0

	if (sub_data)
	{
		player_vote_count = sub_data.votes_count
	}

	let vote_hero_end = $.CreatePanel("Panel", main, "vote_hero_end")
	vote_hero_end.AddClass("vote_hero_end")
	vote_hero_end.hittest = true
	vote_hero_end.SetPanelEvent("onactivate", function() {})

	let vote_information_end = $.CreatePanel("Panel", vote_hero_end, "vote_information_end")
	vote_information_end.AddClass("vote_information_end")

	var HeroImage = $.CreatePanel(`DOTAHeroImage`, vote_information_end, "", {scaling: "stretch-to-cover-preserve-aspect", heroname : String(hero_name), tabindex : "auto", class: "HeroImageVoteEnd"});

	HeroImage.AddClass("HeroImageVote_" + String(stat))

	let number_entry_end_panel = $.CreatePanel("Panel", vote_information_end, "number_entry_end_panel")
	number_entry_end_panel.AddClass("number_entry_end_panel")

	let number_entry_end = $.CreatePanel(`NumberEntry`, number_entry_end_panel, "number_entry_end", {value : player_vote_count, min : 0, max : player_vote_count});

	let buy_buttons = $.CreatePanel("Panel", vote_hero_end, "")
	buy_buttons.AddClass("buy_buttons")

	let button_buy_buy = $.CreatePanel("Panel", buy_buttons, "")
	button_buy_buy.AddClass("button_buy_buy")

	button_buy_buy.SetPanelEvent("onactivate", function() 
	{ 
		VoteHeroLua(hero_name)
	
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		vote_hero_end.RemoveClass("vote_hero_end")
		vote_hero_end.AddClass("vote_hero_end_hide")

		$.Schedule( 0.35, function()
		{
			vote_hero_end.DeleteAsync(0)
		})

		Game.EmitSound(hero_name + '_thx')

	  	Game.EmitSound("UI.Click")
		button_buy_close.SetPanelEvent("onactivate", function() {})

		$.Schedule( 0.25, function()
		{
			InitVote()
		})
	})

	let button_buy_close = $.CreatePanel("Panel", buy_buttons, "")
	button_buy_close.AddClass("button_buy_close")

	button_buy_close.SetPanelEvent("onactivate", function() 
	{ 
		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		vote_hero_end.RemoveClass("vote_hero_end")
		vote_hero_end.AddClass("vote_hero_end_hide")

		$.Schedule( 0.35, function()
		{
			vote_hero_end.DeleteAsync(0)
		})

		Game.EmitSound("UI.Shop_Category_Open")

		button_buy_close.SetPanelEvent("onactivate", function() {})
	})

	blur_panel.SetPanelEvent("onactivate", function() 
	{ 

		blur_panel.AddClass("shop_window_blur_hidden")
		blur_panel.RemoveClass("shop_window_blur")

		vote_hero_end.RemoveClass("vote_hero_end")
		vote_hero_end.AddClass("vote_hero_end_hide")

		$.Schedule( 0.35, function()
		{
			vote_hero_end.DeleteAsync(0)
		})

		Game.EmitSound("UI.Shop_Category_Open")

		blur_panel.SetPanelEvent("onactivate", function() {})
	})

	let label_button_1 = $.CreatePanel("Label", button_buy_buy, "")
	label_button_1.AddClass("label_button_buy_vote")
	label_button_1.text = $.Localize("#vote")

	let label_button_2 = $.CreatePanel("Label", button_buy_close, "")
	label_button_2.AddClass("label_button_buy")
	label_button_2.text = $.Localize("#close")
}

function VoteHeroLua(hero_name)
{
	let number_entry_end = $.GetContextPanel().FindChildTraverse("number_entry_end")
   	if (number_entry_end)
   	{
   		let text_entry = number_entry_end.FindChildTraverse("TextEntry")
   		if (text_entry)
   		{
	   		if (text_entry.text == "")
	   		{
	   			$.Msg("Пустое значение голосов")
	   		}
	   		else
	   		{
	   			let count_votes = Number(text_entry.text)
				GameEvents.SendCustomGameEventToServer_custom( "heroes_vote_change", {count : count_votes , name : hero_name});
	   		}
	   	}
   	}
}