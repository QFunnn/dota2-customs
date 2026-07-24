--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);

function init()
{

	GameEvents.Subscribe_custom('timer_progress', OnTimer)

	//GameEvents.Subscribe_custom('PreGameEnd', ShowTimer)

	GameEvents.Subscribe_custom('duel_timer_progress', OnDuelTimer)
	GameEvents.Subscribe_custom('hide_all_timers', hide_all_timers)

	var HeaderText = $.GetContextPanel().FindChildTraverse("DuelHeaderText");
	HeaderText.text = "РАУНД 1"

	var DuelText = $.GetContextPanel().FindChildTraverse("DuelTimerText");
	DuelText.text = "1:00"



	var GoldIcon = $.GetContextPanel().FindChildTraverse("GoldIcon");
	var MkbIcon = $.GetContextPanel().FindChildTraverse("MkbIcon");
	var Necro = $.GetContextPanel().FindChildTraverse("NecroWave");


	 var text_mkb = $.Localize('#talent_disc_Mkb_info')

		MkbIcon.SetPanelEvent('onmouseover', function() {
	    $.DispatchEvent('DOTAShowTextTooltip', MkbIcon, text_mkb) });
	    
		MkbIcon.SetPanelEvent('onmouseout', function() {
	    $.DispatchEvent('DOTAHideTextTooltip', MkbIcon);
	});


	 var text_necro = $.Localize('#necro_wave_tip')

		Necro.SetPanelEvent('onmouseover', function() {
	    $.DispatchEvent('DOTAShowTextTooltip', Necro, text_necro) });
	    
		Necro.SetPanelEvent('onmouseout', function() {
	    $.DispatchEvent('DOTAHideTextTooltip', Necro);
	});

}

init();

function ShowTimer()
{
	let main = $.GetContextPanel().FindChildTraverse("AllTimer")

	if (main && main.BHasClass("Timer_hidden"))
	{
		main.RemoveClass("Timer_hidden")
		main.RemoveClass("Timer_hide")
		main.AddClass("Timer_show")


	}
}


function MouseOver( panel , skill)
{
	panel.SetPanelEvent('onmouseover', function() {
		$.DispatchEvent('DOTAShowAbilityTooltip', panel, skill) 
	});

	panel.SetPanelEvent('onmouseout', function() {
		$.DispatchEvent('DOTAHideAbilityTooltip', panel);
	});

}

function hide_all_timers()
{
	HideTimer()
	HideDuelTimer()
	Game.EmitSound("Game.End")
}



function HideTimer()
{

	let main = $.GetContextPanel().FindChildTraverse("AllTimer")

	if (main && main.BHasClass("Timer_show"))
	{
		main.RemoveClass("Timer_show")
		main.AddClass("Timer_hide")

		$.Schedule(0.7, function ()
		{ 
			main.AddClass("Timer_hidden")
		})
	}

}



function HideDuelTimer()
{

	let main = $.GetContextPanel().FindChildTraverse("AllDuelTimer")

	if (main && main.BHasClass("Timer_show"))
	{
		main.RemoveClass("Timer_show")
		main.AddClass("Timer_hide")


		$.Schedule(0.7, function ()
		{ 
			main.AddClass("Timer_hidden")
		})
	}

}


function ShowDuelTimer()
{

	let main = $.GetContextPanel().FindChildTraverse("AllDuelTimer")

	if (main && main.BHasClass("Timer_hidden"))
	{
		main.RemoveClass("Timer_hide")
		main.RemoveClass("Timer_hidden")
		main.AddClass("Timer_show")

	}

}

var ping_cd = false

function OnTimer( kv )
{
	let units = kv.units
	let units_max = kv.units_max
	let time = kv.time
	let max = kv.max
	let name = kv.name
	let skills = kv.skills 
	let reward = kv.reward
	let nwave = kv.number 
	let gold = kv.gold
	let show_gold = kv.show_gold
	let mkb = kv.mkb
	let necro = kv.necro
	let upgrade = kv.upgrade
	let patrol_table = kv.patrol_table
	let hide = kv.game_start 

	if (hide == 1)
	{
		HideDuelTimer()
		ShowTimer()
	}

	var DuelTimer = $.GetContextPanel().FindChildTraverse("DuelTimer")
	var CreepTimer = $.GetContextPanel().FindChildTraverse("CreepTimer")


	var Timer = $.GetContextPanel().FindChildTraverse("TimerTime");
	var TimerText = $.GetContextPanel().FindChildTraverse("TimerText");
	var EncounterSkill = $.GetContextPanel().FindChildTraverse("EncounterSkill");
	var SkillText = $.GetContextPanel().FindChildTraverse("EncounterSkillText");
	var WaveText = $.GetContextPanel().FindChildTraverse("WaveName_Text");
	var WaveNumber = $.GetContextPanel().FindChildTraverse("WaveNumber_Text");
	var WaveNumberBlock = $.GetContextPanel().FindChildTraverse("WaveNumber");
	var GoldIcon = $.GetContextPanel().FindChildTraverse("GoldIcon");
	var MkbIcon = $.GetContextPanel().FindChildTraverse("MkbIcon");
	var GoldText = $.GetContextPanel().FindChildTraverse("GoldText")
	var PatrolIcon = $.GetContextPanel().FindChildTraverse("PatrolInfo")
	var PatrolText = $.GetContextPanel().FindChildTraverse("PatrolInfoTimer")

	var Necro = $.GetContextPanel().FindChildTraverse("NecroWave")
	var Upgrade = $.GetContextPanel().FindChildTraverse("UpgradeWave")

	let allow_patrol = false
	if (patrol_table && patrol_table.patrol_creeps)
	{
		let patrol_player_data = patrol_table.patrol_creeps[Game.GetLocalPlayerID()]

		let timer = patrol_table.timer
		let type = 0
		let count = 0
		if (patrol_player_data)
		{
			type = patrol_player_data.type
			if (patrol_player_data.count)
				count = patrol_player_data.count
		}

		if (type != 0 && (count > 0 || timer >= 0))
		{
			allow_patrol = true
			let text = ""
			if (timer > 0)
			{
				text = timer
				if (text < 10)
					text = "0" + text
			}
			PatrolText.text = text
			PatrolIcon.RemoveClass("Timer_hidden")

			let info_text = "#timer_info_patrol"
			if (type == 1)
			{
				PatrolIcon.AddClass("PatrolCreep")
				PatrolIcon.RemoveClass("PatrolTormentor")
			}else
			{
				info_text = "#timer_info_tormentor"

				PatrolIcon.RemoveClass("PatrolCreep")
				PatrolIcon.AddClass("PatrolTormentor")
			}

			PatrolIcon.SetPanelEvent('onmouseover', function() {
				if (!ping_cd)
				{
					$.Schedule(2, function()
					{
						ping_cd = false
					})
					ping_cd = true
		    		GameEvents.SendCustomGameEventToServer_custom("get_patrol_position", {});
		    	}
		    	$.DispatchEvent('DOTAShowTextTooltip', PatrolIcon, info_text) 
		    });

			PatrolIcon.SetPanelEvent('onmouseout', function() {
		    	$.DispatchEvent('DOTAHideTextTooltip', PatrolIcon);
			});
		}
	}

	if (allow_patrol)
	{
		PatrolIcon.RemoveClass("Timer_hidden")
	}else
		PatrolIcon.AddClass("Timer_hidden")

	if (necro == true)
	{
		Necro.style.visibility = "visible"
	} else 
	{
		Necro.style.visibility = "collapse"
	}

	let duel_data = kv.duel_array
	let is_duel = false

	if (duel_data)
	{
		is_duel = true

		let DuelTimerHeader = $.GetContextPanel().FindChildTraverse("DuelTimerHeader")
		if (kv.stage == 1)
		{
			DuelTimerHeader.text = $.Localize('#duel_prepair')
		}
		else 
			DuelTimerHeader.text = $.Localize('#duel_active')

		if (DuelTimer.BHasClass("PanelHidden"))
		{
			$.Schedule(1, function ()
			{ 
				Game.EmitSound("Duel.Normal")
			})
			CreepTimer.RemoveClass("Timer_show")
			CreepTimer.RemoveClass("Timer_hide")
			CreepTimer.AddClass("Timer_hide")

			$.Schedule(0.3, function ()
			{
				DuelTimer.AddClass("Timer_show")
				DuelTimer.RemoveClass("PanelHidden")
			})
			$.Schedule(0.7, function ()
			{ 
				CreepTimer.AddClass("PanelHidden")
			})
		}

		if (duel_data.heroes1[2] || duel_data.heroes2[2])
		{
			DuelTimer.AddClass("DuelTimer_duo")
		}else
		{
			DuelTimer.RemoveClass("DuelTimer_duo")
		}

		Timer = $.GetContextPanel().FindChildTraverse("DuelTimer_Filler");
		TimerText = $.GetContextPanel().FindChildTraverse("DuelTimer_Text");

		for (var i = 1; i <= 2; i++) 
		{
			let icon = $.GetContextPanel().FindChildTraverse("NormalDuelHeroLeft_Icon" + String(i))
			if (duel_data.heroes1[i])
			{
				icon.RemoveClass("DuelHero_icon_hidden")
				icon.style.backgroundImage =  'url( "file://{images}/heroes/' +  Game.GetHeroImage(duel_data.heroes1[i].id , duel_data.heroes1[i].hero) + '.png")'
				icon.style.backgroundSize = '100%'
			}else
			{
				icon.AddClass("DuelHero_icon_hidden")
			}
		}

		for (var i = 1; i <= 2; i++) 
		{
			let icon = $.GetContextPanel().FindChildTraverse("NormalDuelHeroRight_Icon" + String(i))
			if (duel_data.heroes2[i])
			{
				icon.RemoveClass("DuelHero_icon_hidden")
				icon.style.backgroundImage =  'url( "file://{images}/heroes/' +  Game.GetHeroImage(duel_data.heroes2[i].id , duel_data.heroes2[i].hero) + '.png")'
				icon.style.backgroundSize = '100%'
			}else
			{
				icon.AddClass("DuelHero_icon_hidden")
			}
		}
	}else
	{
		if (CreepTimer.BHasClass("PanelHidden"))
		{
			DuelTimer.RemoveClass("Timer_show")
			DuelTimer.RemoveClass("Timer_hide")
			DuelTimer.AddClass("Timer_hide")

			$.Schedule(0.3, function ()
			{
				CreepTimer.AddClass("Timer_show")
				CreepTimer.RemoveClass("PanelHidden")
			})
			$.Schedule(0.7, function ()
			{ 
				DuelTimer.AddClass("PanelHidden")
			})
		}
	}


	if (upgrade > 0)
	{
		Upgrade.style.visibility = "visible"
		var UpgradeText  = $.GetContextPanel().FindChildTraverse("UpgradeWaveText")
		if (UpgradeText)
		{
			UpgradeText.text = upgrade
		}

		var text_up = $.Localize('#upgrade_creeps_text') + String(upgrade)*8 + '%'
		Upgrade.SetPanelEvent('onmouseout', function() {
	    $.DispatchEvent('DOTAHideTextTooltip', Upgrade) });
	}


	if ((gold >= 1) && show_gold == 1)
	{
		let number = gold - 100
		GoldIcon.style.visibility = "visible"

		if (number > 0)
		{
			GoldText.text = number + "%"
		} else
		{
			GoldText.text = ""
		}

	    var gold_text = $.Localize('#talent_disc_gold_info') + "<b><font color='#53ea48'>" + number + "%" + "</font></b>" + $.Localize('#talent_disc_gold_info_2')

		GoldIcon.SetPanelEvent('onmouseover', function() {
	    	$.DispatchEvent('DOTAShowTextTooltip', GoldIcon, gold_text) 
	    });
	    
		GoldIcon.SetPanelEvent('onmouseout', function() {
	    	$.DispatchEvent('DOTAHideTextTooltip', GoldIcon);
		});

	} else 
	{
		GoldIcon.style.visibility = "collapse"
	}

	if (mkb == 1)
	{
		MkbIcon.style.visibility = "visible"
	} else 
	{
		MkbIcon.style.visibility = "collapse"
	}

	var SkillIcons = $.GetContextPanel().FindChildTraverse("SkillIcons");
	var SkillText = $.GetContextPanel().FindChildTraverse("EncounterSkillText");
	//SkillText.text = $.Localize("#wave_skills")

	var RewardText = $.GetContextPanel().FindChildTraverse("RewardText");

	WaveNumberBlock.RemoveClass("WaveNumber_normal")
	WaveNumberBlock.RemoveClass("WaveNumber_purple")
	WaveNumberBlock.RemoveClass("WaveNumber_orange")
	WaveNumberBlock.AddClass("WaveNumber_normal")

	if (reward !== 0)
	{
		if (reward == 4)
		{
			WaveNumberBlock.RemoveClass("WaveNumber_normal")
			WaveNumberBlock.AddClass("WaveNumber_orange")
		}
		if (reward == 3)
		{
			WaveNumberBlock.RemoveClass("WaveNumber_normal")
			WaveNumberBlock.AddClass("WaveNumber_purple")
		}
	}

	var icon = []
	var b_icon = null 
	var b_text = ''

	for (var i = 1; i <= 4; i++) 
	{
		b_icon = $.GetContextPanel().FindChildTraverse("SkillIcon"+i)
		if (skills[i] != null ) 
		{
			b_icon.style.visibility = "visible"
			b_icon.abilityname = skills[i]
			MouseOver(b_icon, skills[i])
	    }else 
			b_icon.style.visibility = "collapse"
	}

	if (time > 0) 
	{
		let wave_text = $.Localize('#wave_name')
		WaveText.text =  $.Localize('#wave_name_' + name)
		WaveNumber.text =   String(nwave)

		var text = ''
		var min = String( Math.trunc((max - time)/60) )
		var sec_n =  (max - time) - 60*Math.trunc((max - time)/60)  
		var sec = String(sec_n)
		if (sec_n < 10) 
			sec = '0' + sec

		text = min  + ':' + sec

		TimerText.text = text
		var number = 0
		number = 100 - (time/(max)) * 100

		text = String(number)+'%'
		TimerText.style.align = 'right center'
		Timer.style.width =  text
	}
	else 
	{
		WaveText.text =  $.Localize('#wave_name_' + name)
		WaveNumber.text =   String(nwave)

		text = ''
		text = String(units) + '/' + String(units_max)
		
		TimerText.style.align = 'center center'	
		TimerText.text = text

		var number = 0
		number = (units/(units_max)) * 100
		text = String(number)+'%'
		Timer.style.width = text
	}
}	




function OnDuelTimer( kv )
{
	let time = kv.time
	let max = kv.max
	let show = kv.show 
	let stage = kv.stage
	let round = kv.round
	let heroes1 = kv.heroes1
	let heroes2 = kv.heroes2 
	let wins1 = kv.wins1
	let wins2 = kv.wins2

	var text = ''

	let main = $.GetContextPanel().FindChildTraverse("AllTimer")

	HideTimer()
	ShowDuelTimer()

	var final = $.GetContextPanel().FindChildTraverse("FinalDuelBot");
	final.RemoveClass("PanelHidden")

	var DuelTextLeft = $.GetContextPanel().FindChildTraverse("DuelTimerTextLeft");
	DuelTextLeft.text = String(wins1)

	var DuelTextRight = $.GetContextPanel().FindChildTraverse("DuelTimerTextRight");
	DuelTextRight.text = String(wins2)

	for (var i = 1; i <= 2; i++) 
	{
		let icon = $.GetContextPanel().FindChildTraverse("FinalDuelHeroLeft_Icon" + String(i))
		if (heroes1[i])
		{
			icon.RemoveClass("DuelHero_icon_hidden")
			icon.style.backgroundImage =  'url( "file://{images}/heroes/' +  Game.GetHeroImage(heroes1[i].id , heroes1[i].hero) + '.png")'
			icon.style.backgroundSize = '100%'
		}else
		{
			icon.AddClass("DuelHero_icon_hidden")
		}
	}
	for (var i = 1; i <= 2; i++) 
	{
		let icon = $.GetContextPanel().FindChildTraverse("FinalDuelHeroRight_Icon" + String(i))
		if (heroes2[i])
		{
			icon.RemoveClass("DuelHero_icon_hidden")
			icon.style.backgroundImage =  'url( "file://{images}/heroes/' +  Game.GetHeroImage(heroes2[i].id , heroes2[i].hero) + '.png")'
			icon.style.backgroundSize = '100%'
		}else
		{
			icon.AddClass("DuelHero_icon_hidden")
		}
	}

	var HeaderText = $.GetContextPanel().FindChildTraverse("DuelHeaderText");
	if (stage == 1)
	{
		HeaderText.text = $.Localize('#duel_prepair')
	}
	else 
	{
		HeaderText.text = $.Localize('#duel_round') + String(round)
	}

	var Timer = $.GetContextPanel().FindChildTraverse("DuelTimerTime");
	var TimerText = $.GetContextPanel().FindChildTraverse("DuelTimerText");

	var DuelText = $.GetContextPanel().FindChildTraverse("DuelTimerText");

	var text = ''
	var min = String( Math.trunc((max - time)/60) )
	var sec_n =  (max - time) - 60*Math.trunc((max - time)/60)  
	var sec = String(sec_n)
	if (sec_n < 10) 
		sec = '0' + sec

	text = min  + ':' + sec
	DuelText.text = text
	var number = 0
	number = 100 - (time/(max)) * 100
	text = String(number)+'%'
	Timer.style.width = text
	Timer.style.backgroundSize = "100% 100%"
}	