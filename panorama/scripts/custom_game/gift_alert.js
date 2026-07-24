--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);




var cd = false
var current_id = -1



function init()
{
	GameEvents.Subscribe_custom('gift_alert', gift_alert)


	let content = $.GetContextPanel().FindChildTraverse("GiftAlert_button_content")
	content.RemoveClass("GiftAlert_button_content")
	content.AddClass("GiftAlert_button_content_hidden")

	let main = $.GetContextPanel().FindChildTraverse("GiftAlert_window")
	let button = $.GetContextPanel().FindChildTraverse("GiftAlert_button")

	main.RemoveClass("GiftAlert_window")
	main.RemoveClass("GiftAlert_window_active")
	main.AddClass("GiftAlert_window_hidden")

	button.RemoveClass("GiftAlert_button_active")


	let alert = $.GetContextPanel().FindChildTraverse("GiftAlert_text_alert")

	alert.RemoveClass("GiftAlert_text_alert")
	alert.AddClass("GiftAlert_text_alert_hidden")

}

function hide_alert()
{
	let button = $.GetContextPanel().FindChildTraverse("GiftAlert_button_content")

	if (!button) return
	if (button.BHasClass("GiftAlert_button_content_hidden")) return

	button.RemoveClass("GiftAlert_button_content")
	button.AddClass("GiftAlert_button_content_hidden")



}


function show_text_alert(data)
{
	let alert = $.GetContextPanel().FindChildTraverse("GiftAlert_text_alert")

	if (alert.BHasClass("GiftAlert_text_alert")) return

	alert.RemoveClass("GiftAlert_text_alert_hidden")
	alert.AddClass("GiftAlert_text_alert")

	Game.EmitSound("UI.Gift_alert")


	$.Schedule(4, function()
	{
		alert.RemoveClass("GiftAlert_text_alert")
		alert.AddClass("GiftAlert_text_alert_hidden")
	})

}


function show_alert(count)
{
	let button = $.GetContextPanel().FindChildTraverse("GiftAlert_button_content")

	if (!button) return

	let number = $.GetContextPanel().FindChildTraverse("GiftAlert_button_ping_text")

	if (number)
	{
		let old_number = Number(number.text)

		if (old_number != count)
		{
			number.text = String(count)

			if (old_number < count)
			{
				$.Schedule(0.6, function()
				{
					show_text_alert()
				})
			}
		}
	}

	if (button.BHasClass("GiftAlert_button_content")) return

	button.RemoveClass("GiftAlert_button_content_hidden")
	button.AddClass("GiftAlert_button_content")
	$.Schedule(0.6, function()
	{
		show_text_alert()
	})
}


function gift_alert(data)
{
	var gifts_data = CustomNetTables.GetTableValue("gifts_data", Players.GetLocalPlayer());


	if (gifts_data == null || gifts_data == undefined)
	{
		CloseWindow()
		hide_alert()
		return
	}

	let length = Object.keys(gifts_data).length

	if (length <= 0 )
	{
		CloseWindow()
		hide_alert()
		return
	}

	let main = $.GetContextPanel().FindChildTraverse("GiftAlert_window")

	if (main && main.BHasClass("GiftAlert_window"))
	{

		let giftId = gifts_data[1].giftId

		if (current_id != giftId)
		{
			CloseWindow()
			cd = true
			$.Schedule(0.45, function ()
			{
    		cd = false
				UpdateWindow()
				ShowWindow()
			})
		}

	}

	show_alert(length)
}







function OpenWindow()
{
	let main = $.GetContextPanel().FindChildTraverse("GiftAlert_window")
	let button = $.GetContextPanel().FindChildTraverse("GiftAlert_button")


	if (!main) return
	if (!button) return
	if (cd == true) return

	cd = true

  $.Schedule(0.6, function ()
  {
    cd = false
  })

	if (main.BHasClass("GiftAlert_window"))
	{
		Game.EmitSound("UI.Info_Close")
		CloseWindow()
	}else
	{

		Game.EmitSound("UI.Info_Open")
	  Game.EmitSound("UI.Gift_Open")

		UpdateWindow()
		ShowWindow()
 
	}
}


function CloseWindow()
{
	let main = $.GetContextPanel().FindChildTraverse("GiftAlert_window")
	let button = $.GetContextPanel().FindChildTraverse("GiftAlert_button")

	if (!main) return
	if (!button) return
	if (main.BHasClass("GiftAlert_window_hidden")) return

	main.RemoveClass("GiftAlert_window")
	main.RemoveClass("GiftAlert_window_active")
	main.AddClass("GiftAlert_window_hidden")

	button.RemoveClass("GiftAlert_button_active")
}



function ShowWindow()
{
	let main = $.GetContextPanel().FindChildTraverse("GiftAlert_window")
	let button = $.GetContextPanel().FindChildTraverse("GiftAlert_button")

	if (!main) return
	if (!button) return

	main.AddClass("GiftAlert_window")
	main.RemoveClass("GiftAlert_window_hidden")

	button.AddClass("GiftAlert_button_active")

	$.Schedule(0.55, function ()
	{
		main.AddClass("GiftAlert_window_active")
	})
}



function UpdateWindow()
{

	var gifts_data = CustomNetTables.GetTableValue("gifts_data", Players.GetLocalPlayer());

	if (gifts_data == null || gifts_data == undefined)
	{
		return
	}

	let main = $.GetContextPanel().FindChildTraverse("GiftAlert_window")
	if (!main) return

	let data = gifts_data[1]

	if (!data || data == undefined) return

	let giftId = data.giftId

	if (current_id == giftId) return

  current_id = giftId

	let text = ""
	let msg_text = $.Localize("#gift_no_msg")
	let count = data.amount
	let fromPlayerId = data.fromPlayerId
	let type = data.productName

	let icon = $.GetContextPanel().FindChildTraverse("GiftAlert_window_icon")
	let name = $.GetContextPanel().FindChildTraverse("GiftAlert_window_gift_name")
	let gift_msg = $.GetContextPanel().FindChildTraverse("GiftAlert_window_gift_msg")
	let gift_button = $.GetContextPanel().FindChildTraverse("GiftAlert_window_button")

	let gifter_panel = $.GetContextPanel().FindChildTraverse("GiftAlert_window_gifter_block")
	if (gifter_panel)
	{
		gifter_panel.DeleteAsync(0)
	}

	let top_panel = $.GetContextPanel().FindChildTraverse("GiftAlert_window_top")

	gifter_panel = $.CreatePanel("Panel", top_panel, "GiftAlert_window_gifter_block")
	gifter_panel.AddClass("GiftAlert_window_gifter_block")

	let start_text = $.CreatePanel("Label", gifter_panel, "")
	start_text.AddClass("GiftAlert_window_gifter_text")
	start_text.text = $.Localize("#gift_gifter_text")

  let gifter_icon = $.CreatePanel("DOTAAvatarImage",gifter_panel,"gifter_icon")
	gifter_icon.style.width = "30px"
	gifter_icon.style.height = "30px"
	gifter_icon.accountid = fromPlayerId

	let gifter_name = $.CreatePanel("DOTAUserName",gifter_panel,"gifter_name")
	gifter_name.AddClass("GiftAlert_window_gifter_name")
	gifter_name.style.width = "400px"
	gifter_name.accountid = fromPlayerId




	if (data.message)
	{
		msg_text = data.message
	}

	icon.RemoveClass("GiftAlert_window_icon_sub")
	icon.RemoveClass("GiftAlert_window_icon_shards")

	if (type == "dota_plus")
	{
		icon.style.backgroundImage = 'url("s2r://panorama/images/custom_game/shop/battle_pass_png.vtex")';
		icon.AddClass("GiftAlert_window_icon_sub")
		text = $.Localize("#gift_name_sub")
		count = count*30
	}else 
	{
		let icon_name = 'url("file://{images}/econ/tools/battle_points_ti11_levels_5.png")';
		let amount = Number(count)

		if(amount >= 100000)
		{
			icon_name = 'url("file://{images}/econ/tools/bp_2022_treasure_crimson.png")';
		}else if(amount >= 35000)
		{
			icon_name = 'url("file://{images}/econ/tools/battle_points_ti11_levels_24.png")';
		}else if(amount >= 10000)
		{
			icon_name = 'url("file://{images}/econ/tools/battle_points_ti11_levels_11.png")';
		}

		icon.style.backgroundImage = icon_name
		
		icon.AddClass("GiftAlert_window_icon_shards")
		text = $.Localize("#gift_name_shards")
	}


	icon.style.backgroundSize = "contain";
	name.text = '+' + String(count) + text



	gift_msg.text = msg_text


	gift_button.SetPanelEvent("onactivate", function() {
		Game.EmitSound("UI.Gift_accept")
		Game.EmitSound("UI.Click")
		GameEvents.SendCustomGameEventToServer_custom( "accept_gift", {giftId : giftId});	

		gift_button.SetPanelEvent("onactivate", function() {})

	})

}


init()