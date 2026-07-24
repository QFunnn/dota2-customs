--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe_custom("event_woda_neutral_reward", NeutralRewardStart)

function NeutralRewardStart(data)
{
	$("#NeutralPanelReward").style.opacity = "1"
	let reward_1 = data.reward_1
	let reward_2 = data.reward_2
	let reward_3 = data.reward_3
	let reward_4 = data.reward_4
	let reward_5 = data.reward_5
	$("#neutral_item_1").itemname = reward_1.item_name
	$("#neutral_item_2").itemname = reward_2.item_name
	$("#neutral_item_3").itemname = reward_3.item_name
	$("#neutral_item_4").itemname = reward_4.item_name
    SetShowItemTooltip($("#neutral_item_1"), reward_1.item_name, reward_1.item_level)
    SetShowItemTooltip($("#neutral_item_2"), reward_2.item_name, reward_2.item_level)
    SetShowItemTooltip($("#neutral_item_3"), reward_3.item_name, reward_3.item_level)
    SetShowItemTooltip($("#neutral_item_4"), reward_4.item_name, reward_4.item_level)
	$("#GoldLabel").text = reward_5 + "<br>" + $.Localize("#goldrandomneutral")
	$("#RewardRefreshCount").text = data.reroll

	$("#NeutralItem1").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem2").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem3").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem4").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem5").SetPanelEvent("onactivate", function() {} );

	$("#NeutralItem1").SetPanelEvent("onactivate", function() {
		SelectNeutralItem(1)
	} );

	$("#NeutralItem2").SetPanelEvent("onactivate", function() {
		SelectNeutralItem(2)
	} );

	$("#NeutralItem3").SetPanelEvent("onactivate", function() {
		SelectNeutralItem(3)
	} );

	$("#NeutralItem4").SetPanelEvent("onactivate", function() {
		SelectNeutralItem(4)
	} );

	$("#NeutralItem5").SetPanelEvent("onactivate", function() {
		SelectNeutralItem(5)
	} );

	if (Number(data.reroll) > 0)
	{
		$("#RewardRefresh").SetPanelEvent("onactivate", function() {
			RefreshReward()
		});
	} else 
	{
		$("#RewardRefresh").RemoveClass("RewardRefresh")
		$("#RewardRefresh").AddClass("RewardRefreshNotActive")
	}

	MouseOver($("#RewardRefresh"), "#woda_reroll_neutrals_items")
}

function MouseOver(panel, text) 
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, text)
    });

    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });
}

function RefreshReward()
{
	Game.EmitSound("ui.pick_spin")

	$("#RewardRefresh").AddClass("RewardRotate")

	$.Schedule( 0.85, function()
    {
       	$("#RewardRefresh").RemoveClass("RewardRotate")
    });

    $("#RewardRefresh").SetPanelEvent("onactivate", function() {});
    GameEvents.SendCustomGameEventToServer_custom( 'woda_reroll_neutrals', {} );
}

function SelectNeutralItem(id)
{
	$("#RewardRefresh").SetPanelEvent("onactivate", function() {});
	$("#NeutralItem1").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem2").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem3").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem4").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem5").SetPanelEvent("onactivate", function() {} );
	$("#NeutralPanelReward").style.opacity = "0"
	GameEvents.SendCustomGameEventToServer_custom( "SelectNeutralReward", {choose : id} );
}


GameEvents.Subscribe_custom("event_woda_close_neutral_reward", CloseNeutralSelect)

function CloseNeutralSelect()
{
	$("#RewardRefresh").SetPanelEvent("onactivate", function() {});
	$("#NeutralItem1").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem2").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem3").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem4").SetPanelEvent("onactivate", function() {} );
	$("#NeutralItem5").SetPanelEvent("onactivate", function() {} );
	$("#NeutralPanelReward").style.opacity = "0"
}

GameEvents.Subscribe_custom("event_woda_timer_neutral_reward", event_woda_timer_neutral_reward)

function event_woda_timer_neutral_reward(data)
{
	let time = data.time
	let max = data.max

	$("#RewardTimeCount").text = time

	let radial_number = -360 * ( time / max )
    $("#RewardTime").style.clip = 'radial( 50.0% 50.0%, 0.0deg, ' + radial_number + 'deg);'
}



GameEvents.Subscribe_custom("event_open_overthrow_settings", event_open_overthrow_settings)

function event_open_overthrow_settings(data)
{
	$("#OverthrowGameModeSettings").style.opacity = "1"
	$("#OverthrowGameModeSettingsActive").SetPanelEvent("onactivate", function() {} );
	$("#OverthrowGameModeSettingsDeActive").SetPanelEvent("onactivate", function() {} );

	$("#OverthrowGameModeSettingsActive").SetPanelEvent("onactivate", function() 
	{
		SelectOverthrowSettings(true)
	});

	$("#OverthrowGameModeSettingsDeActive").SetPanelEvent("onactivate", function() 
	{
		SelectOverthrowSettings(false)
	});

	MouseOver($("#OverthrowGameModeSettingsActive"), "#woda_overthrow_settings_kill_plus")
	MouseOver($("#OverthrowGameModeSettingsDeActive"), "#woda_overthrow_settings_kill_close")
}

function SelectOverthrowSettings(plus)
{
	$("#OverthrowGameModeSettingsActive").SetPanelEvent("onactivate", function() {} );
	$("#OverthrowGameModeSettingsDeActive").SetPanelEvent("onactivate", function() {} );
	$("#OverthrowGameModeSettings").style.opacity = "0"
	if (plus)
	{
		GameEvents.SendCustomGameEventToServer_custom( "OverthrowSettingsPlus", {} );
	}
}

GameEvents.Subscribe_custom("event_close_overthrow_settings", event_close_overthrow_settings)

function event_close_overthrow_settings()
{
	$("#OverthrowGameModeSettingsActive").SetPanelEvent("onactivate", function() {} );
	$("#OverthrowGameModeSettingsDeActive").SetPanelEvent("onactivate", function() {} );
	$("#OverthrowGameModeSettings").style.opacity = "0"
}

function SetShowItemTooltip(panel, ability, level)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowAbilityTooltipForLevel', panel, ability, level); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideAbilityTooltip', panel);
    });       
}