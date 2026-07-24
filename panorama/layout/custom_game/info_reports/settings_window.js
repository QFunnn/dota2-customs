--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom('SendSettingsChange', GetSettingsChange)

function init_settings_window() 
{
	let talent_label = $.GetContextPanel().FindChildTraverse("settings_label_talents")
	let level_label = $.GetContextPanel().FindChildTraverse("settings_label_level")

	var TalentView_text = $.Localize("#TalentView_info")
	var Level_text = $.Localize("#shop_show_level_info")

	ShowInfo(talent_label, TalentView_text)
	ShowInfo(level_label, Level_text)
}

function send_change_settings(type)
{
	Game.EmitSound("UI.Click")
	GameEvents.SendCustomGameEventToServer_custom("ChangeSettings", {type : type})

}

function ShowInfo(panel, text)
{
	panel.SetPanelEvent('onmouseover', function() {
    $.DispatchEvent('DOTAShowTextTooltip', panel, text) });
    
	panel.SetPanelEvent('onmouseout', function() {
    $.DispatchEvent('DOTAHideTextTooltip', panel); });
}


function GetSettingsChange(data)
{
	let button_talents = $.GetContextPanel().FindChildTraverse("settings_checkbox_talents")
	let button_level = $.GetContextPanel().FindChildTraverse("settings_checkbox_level")


	button_talents.SetHasClass("settings_checkbox_inactive", data.talent_view == 0)
	button_talents.SetHasClass("settings_checkbox_active", data.talent_view == 1)

	button_level.SetHasClass("settings_checkbox_inactive", data.level_view == 0)
	button_level.SetHasClass("settings_checkbox_active", data.level_view == 1)

}






var cd = false

function Settings_window_hide()
{
	if (cd == true)
		return
	
	$.Msg("hide")
	cd = true
	Game.EmitSound("UI.Info_Close")
	var info_button = $.GetContextPanel().FindChildTraverse("info_button")
	var settings_button = $.GetContextPanel().FindChildTraverse("settings_button")
	var info_window = $.GetContextPanel().FindChildTraverse("window_info")
	var settings_window = $.GetContextPanel().FindChildTraverse("settings_window")

	settings_button.RemoveClass("button_active")

	settings_window.RemoveClass("settings_window_show")
	settings_window.AddClass("settings_window_hidden")

	settings_button.SetPanelEvent("onactivate", function() 
	{	
		Settings_window_show()
	});
	$.Schedule(0.5, function ()
	{
		cd = false
	})	
}

function Settings_window_show()
{
	if (cd == true)
		return


	Game.EmitSound("UI.Info_Open")
	cd = true
	var info_button = $.GetContextPanel().FindChildTraverse("info_button")
	var settings_button = $.GetContextPanel().FindChildTraverse("settings_button")
	var shop_button = $.GetContextPanel().FindChildTraverse("shop_button")
	var info_window = $.GetContextPanel().FindChildTraverse("window_info")
	var settings_window = $.GetContextPanel().FindChildTraverse("settings_window")
	var shop_window = $.GetContextPanel().FindChildTraverse("window_shop")

	info_button.RemoveClass("button_active")
	settings_button.AddClass("button_active")

	if (info_window.BHasClass("info_window_show"))
	{
		info_window.RemoveClass("info_window_show")
		info_window.AddClass("info_window_hidden")

		info_button.SetPanelEvent("onactivate", function() 
		{	
			Info_window_show()
		});
	}
	if (shop_window.BHasClass("shop_window_show"))
	{
		shop_window.RemoveClass("shop_window_show")

		shop_window.AddClass("shop_window_hidden")
		shop_button.SetPanelEvent("onactivate", function() 
		{	
			GameUI.CustomUIConfig().OpenShop()
		});
	}

	settings_window.RemoveClass("settings_window_hidden")
	settings_window.AddClass("settings_window_show")

	settings_button.SetPanelEvent("onactivate", function() 
	{	
		Settings_window_hide()
	});

	init_settings_window()

	$.Schedule(0.5, function ()
	{
		cd = false
	})
	
}