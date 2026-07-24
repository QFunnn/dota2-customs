--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function InitHeroes()
{
	let table_heroes = CustomNetTables.GetTableValue("custom_pick", "hero_list")
	let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroList")
	const hero_names_sorted = [...Object.keys(table_heroes)].sort()
	let heroes_strength = []
	let heroes_agility = []
	let heroes_intellect = []
	let heroes_all = []
	for (const hero_name of hero_names_sorted)
	{
		if (table_heroes[hero_name] == 0)
		{
			heroes_strength.push(hero_name)
		} else if (table_heroes[hero_name] == 1) {
			heroes_agility.push(hero_name)
		} else if (table_heroes[hero_name] == 2) {
			heroes_intellect.push(hero_name)
		} else if (table_heroes[hero_name] == 3) {
			heroes_all.push(hero_name)
		}
	}
	if (heroes_panel)
	{
		heroes_panel.RemoveAndDeleteChildren()
		let attribute_info = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info.AddClass("attribute_info")
		let hero_icon_str = $.CreatePanel("Panel", attribute_info, "");
		hero_icon_str.AddClass("hero_icon_str")
		let hero_label_str = $.CreatePanel("Label", attribute_info, "");
		hero_label_str.AddClass("hero_label_str")
		hero_label_str.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_str")
		const str_row = $.CreatePanel("Panel", heroes_panel, "StrengthHeroes");
		let attribute_info_2 = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info_2.AddClass("attribute_info")
		let hero_icon_agi = $.CreatePanel("Panel", attribute_info_2, "");
		hero_icon_agi.AddClass("hero_icon_agi")
		let hero_label_agi = $.CreatePanel("Label", attribute_info_2, "");
		hero_label_agi.AddClass("hero_label_agi")
		hero_label_agi.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_agi")
		const agi_row = $.CreatePanel("Panel", heroes_panel, "AgilityHeroes");
		let attribute_info_3 = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info_3.AddClass("attribute_info")
		let hero_icon_int = $.CreatePanel("Panel", attribute_info_3, "");
		hero_icon_int.AddClass("hero_icon_int")
		let hero_label_int = $.CreatePanel("Label", attribute_info_3, "");
		hero_label_int.AddClass("hero_label_int")
		hero_label_int.text = $.Localize("#DOTA_Tooltip_Ability_item_power_treads_int")
		const int_row = $.CreatePanel("Panel", heroes_panel, "IntellectHeroes");
		let attribute_info_4 = $.CreatePanel("Panel", heroes_panel, "");
		attribute_info_4.AddClass("attribute_info")
		let hero_icon_all = $.CreatePanel("Panel", attribute_info_4, "");
		hero_icon_all.AddClass("hero_icon_all")
		let hero_label_all = $.CreatePanel("Label", attribute_info_4, "");
		hero_label_all.AddClass("hero_label_all")
		hero_label_all.text = $.Localize("#stats_all")
		const all_row = $.CreatePanel("Panel", heroes_panel, "AllHeroes");
		for (var i = 0; i < Object.keys(heroes_strength).length; i++) 
		{
			CreateHeroPanel(str_row, heroes_strength[i], 1)
		}
		for (var i = 0; i < Object.keys(heroes_agility).length; i++) 
		{
			CreateHeroPanel(agi_row, heroes_agility[i], 2)
		}
		for (var i = 0; i < Object.keys(heroes_intellect).length; i++) 
		{
			CreateHeroPanel(int_row, heroes_intellect[i], 3)
		}
		for (var i = 0; i < Object.keys(heroes_all).length; i++) 
		{
			CreateHeroPanel(all_row, heroes_all[i], 4)
		}
	}
}

function CreateHeroPanel(panel, hero_name, stat) 
{
	var player_data_local = player_table_shop
 	var BlockHero = $.CreatePanel("Panel", panel, "");
	BlockHero.AddClass("BlockHero");
	var HeroImage = $.CreatePanel(`DOTAHeroImage`, BlockHero, "", {scaling: "stretch-to-cover-preserve-aspect", heroname : String(hero_name), tabindex : "auto", class: "HeroImage", heroimagestyle : "portrait"});
	var LevelPanel = $.CreatePanel("Panel", BlockHero, "");
	LevelPanel.AddClass("LevelPanel");
	var DotaPlusIcon = $.CreatePanel("Panel", LevelPanel, "");
	DotaPlusIcon.AddClass("DotaPlusIcon");
	DotaPlusIcon.style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + player_data_local["heroes_data"][hero_name]["tier"] + '_tiny_png.vtex")'
	var HeroLevelLabel = $.CreatePanel("Label", LevelPanel, "");
	HeroLevelLabel.AddClass("HeroLevelLabel");
	if (player_data_local["heroes_data"][hero_name]['has_level'] == 1)
	{
        let level = Number(player_data_local["heroes_data"][hero_name]["level"])
        let tier = Number(player_data_local["heroes_data"][hero_name]["tier"])
		HeroLevelLabel.text = level
        if (level < 10)
        {
            HeroLevelLabel.AddClass("HeroLevelLabel_1")
        }
		BlockHero.AddClass("BlockHero_" + String(tier))
        LevelPanel.AddClass("LevelPanel_" + String(tier))
        HeroImage.AddClass("HeroImage_" + String(tier))

	}else 
	{
        LevelPanel.style.opacity = 0
		HeroLevelLabel.text = 0
	}
	BlockHero.SetPanelEvent("onactivate", function() 
	{	
		OpenGeneralInformation(hero_name)
	});	
}

function OpenGeneralInformation(hero_name)
{
	Game.EmitSound("UI.Click")
	let heroes_panel = $.GetContextPanel().FindChildTraverse("HeroList")
	if (heroes_panel)
	{
		heroes_panel.style.visibility = "collapse"
	}
	let GeneralHeroInformation = $.GetContextPanel().FindChildTraverse("GeneralHeroInformation")
	if (GeneralHeroInformation)
	{
		GeneralHeroInformation.style.visibility = "visible"
	}
	InitHeroGeneralInformation(GeneralHeroInformation, hero_name)
}

function InitHeroGeneralInformation(panel, hero_name)
{
	let general_hero_panel = $.GetContextPanel().FindChildTraverse("GeneralHeroInformation")
	if (general_hero_panel)
	{
		general_hero_panel.RemoveAndDeleteChildren()
	}
	var player_data_local = player_table_shop
	var quest_data = CustomNetTables.GetTableValue("hero_quests", Players.GetLocalPlayer());
	var QuestsGeneralPanel = $.CreatePanel("Panel", panel, "");
	QuestsGeneralPanel.AddClass("QuestsGeneralPanel");
	var QuestsTopPanel = $.CreatePanel("Panel", QuestsGeneralPanel, "");
	QuestsTopPanel.AddClass("QuestsTopPanel");
	var QuestsGeneralPanelLabel = $.CreatePanel("Label", QuestsTopPanel, "");
	QuestsGeneralPanelLabel.AddClass("QuestsGeneralPanelLabel");
	QuestsGeneralPanelLabel.text = $.Localize("#quests_top")

	if (player_data_local.subscribed == 1)
	{
		let time = player_data_local.quests_cd
		let days = Math.floor((time/3600)/24)
		let display = String(days) + $.Localize("#pass_active_sub_days")
		if (days < 1)
		{
			display = String(Math.max(0, Math.floor(((time/3600)/24 - days)*24))) + $.Localize("#pass_active_sub_hours")
		}
		var QuestsGeneralPanelLabel_refresh = $.CreatePanel("Label", QuestsTopPanel, "");
		QuestsGeneralPanelLabel_refresh.AddClass("QuestsGeneralPanelLabel_refresh");
		QuestsGeneralPanelLabel_refresh.text = $.Localize("#QuestCd") + display
	}

	if (quest_data && quest_data[String(hero_name)])
	{
		if (Object.keys(quest_data[String(hero_name)]).length == 0)
		{
			var questpanel_main = $.CreatePanel("Panel", QuestsGeneralPanel, "");
			questpanel_main.AddClass("questpanel_main");
			var QuestPanel = $.CreatePanel("Panel", questpanel_main, "");
			QuestPanel.AddClass("QuestPanel");
			var QuestPanelName = $.CreatePanel("Label", QuestPanel, "");
			QuestPanelName.html = true;
			let text = $.Localize('#QuestsNoSub')
			if (player_data_local.subscribed == 1)
			{
				text = $.Localize('#NoQuests')
				QuestPanelName.AddClass("QuestPanelName");
			}
            else 
			{

				QuestPanelName.AddClass("QuestPanelName_nosub");
			}
			QuestPanelName.text = text
		}
        else
		{
			for (var i = 1; i <= Object.keys(quest_data[String(hero_name)]).length; i++)
			{

				CreateQuest(QuestsGeneralPanel, quest_data[String(hero_name)][i])
			}
		}
	}

	var HeroLevelProgress = $.CreatePanel("Panel", panel, "");
	HeroLevelProgress.AddClass("HeroLevelProgress");
	var HeroLevelProgressTop = $.CreatePanel("Panel", HeroLevelProgress, "");
	HeroLevelProgressTop.AddClass("HeroLevelProgressTop");
	var HeroLevelProgressTop_text = $.CreatePanel("Label", HeroLevelProgressTop, "");
	HeroLevelProgressTop_text.AddClass("HeroLevelProgressText");
	var HeroLevelProgressLine = $.CreatePanel("Panel", HeroLevelProgress, "");
	HeroLevelProgressLine.AddClass("HeroLevelProgressLine");
	var HeroLevelProgressLabel = $.CreatePanel("Label", HeroLevelProgressLine, "");
	HeroLevelProgressLabel.AddClass("HeroLevelProgressLabel");
	HeroLevelProgressLabel.text = ""
	let level_thresh = [6,12,18,25,30]
	let next_level = player_data_local["heroes_data"][hero_name]["level"] + 1
	let next_tier = 0
	for (var i = 0; i <= Object.keys(level_thresh).length; i++)
	{
		let thresh = level_thresh[i]
		if (next_level >= thresh)
		{
			next_tier = i+1
		}else 
		{
			break
		}
	}
	next_tier = Math.min(next_tier, 5)
	var HeroLevelProgressLineIcon1 = $.CreatePanel("Panel", HeroLevelProgressTop, "");
	HeroLevelProgressLineIcon1.AddClass("HeroLevelProgressLineIcon1");
	HeroLevelProgressLineIcon1.style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + player_data_local["heroes_data"][hero_name]["tier"] + '_png.vtex")'
	HeroLevelProgressLineIcon1.style.backgroundSize = "100%"
	var HeroLevelProgressFront = $.CreatePanel("Panel", HeroLevelProgressLine, "");
	HeroLevelProgressFront.AddClass("HeroLevelProgressFront");
	HeroLevelProgressFront.AddClass("HeroLevel_filler_" + String(player_data_local["heroes_data"][hero_name]["tier"]))
	HeroLevelProgressLine.AddClass("HeroLevel_bar_" + String(player_data_local["heroes_data"][hero_name]["tier"]))
	var HeroSoundPanel = $.CreatePanel("Panel", panel, "");
	HeroSoundPanel.AddClass("HeroSoundPanel");
	var HeroSoundPanelLabel = $.CreatePanel("Label", HeroSoundPanel, "");
	HeroSoundPanelLabel.AddClass("HeroSoundPanelLabel");
	HeroSoundPanelLabel.text = $.Localize("#shop_hero_sounds")
	var HeroSoundPanelSounds = $.CreatePanel("Panel", HeroSoundPanel, "");
	HeroSoundPanelSounds.AddClass("HeroSoundPanelSounds");
	if (player_data_local)
	{
		if (player_data_local["heroes_data"][hero_name])
		{
			let init_exp = player_data_local["heroes_data"][hero_name]["exp"]
			let max_exp =  thresh[player_data_local["heroes_data"][hero_name]["level"] - 1]
			if (max_exp)
			{
				let width = ( (init_exp)/max_exp) * 100
				HeroLevelProgressTop_text.text =  $.Localize('#hero_level_full') + String(player_data_local["heroes_data"][hero_name]["level"])
				HeroLevelProgressLabel.text =  String(init_exp) + ' / ' + String(max_exp)
				HeroLevelProgressFront.style.width = String(width)+'%'
			} 
            else 
            {
				HeroLevelProgressTop_text.text =  $.Localize('#hero_level_full') + String(player_data_local["heroes_data"][hero_name]["level"])
				HeroLevelProgressFront.style.width = "99%"
			}
		}
	}

	let sounds_table = ALL_TABLE_CUSTOM_SOUNDS
	for (var sound = 1; sound <= Object.keys(sounds_table[hero_name]).length; sound++)
	{
		CreateSoundInGeneralInformation(HeroSoundPanelSounds, sounds_table[hero_name][sound][1], sounds_table[hero_name][sound], hero_name)
	}
}

function CreateQuest(panel, data, player_data)
{
	var questpanel_main = $.CreatePanel("Panel", panel, "");
	questpanel_main.AddClass("questpanel_main");
	var QuestPanel = $.CreatePanel("Panel", questpanel_main, "");
	QuestPanel.AddClass("QuestPanel");
	var QuestPanelIcon = $.CreatePanel("Panel", QuestPanel, "");
	QuestPanelIcon.AddClass("QuestPanelIcon");
	QuestPanelIcon.style.backgroundImage = 'url("file://{images}/custom_game/icons/skills/' + data.icon + '.png")'
	QuestPanelIcon.style.backgroundSize = "100%"
	var QuestPanelText = $.CreatePanel("Panel", QuestPanel, "");
	QuestPanelText.AddClass("QuestPanelText");
	var QuestPanelReward = $.CreatePanel("Panel", QuestPanel, "");
	QuestPanelReward.AddClass("QuestPanelReward");
	var QuestPanelReward_shards = $.CreatePanel("Panel", QuestPanelReward , "");
	QuestPanelReward_shards.AddClass("QuestPanelReward_shards");
	var QuestPanelReward_exp = $.CreatePanel("Panel", QuestPanelReward , "");
	QuestPanelReward_exp.AddClass("QuestPanelReward_exp");
	var QuestPanelReward_shards_icon = $.CreatePanel("Panel", QuestPanelReward_shards , "");
	QuestPanelReward_shards_icon.AddClass("QuestPanelReward_shards_icon");
	var QuestPanelReward_exp_icon = $.CreatePanel("Panel", QuestPanelReward_exp , "");
	QuestPanelReward_exp_icon.AddClass("QuestPanelReward_exp_icon");
	var QuestPanelRewardLabel_shards = $.CreatePanel("Label",  QuestPanelReward_shards, "");
	QuestPanelRewardLabel_shards.AddClass("QuestPanelReward_text");
	QuestPanelRewardLabel_shards.text ="+" + data.shards
	var QuestPanelRewardLabel_exp = $.CreatePanel("Label",  QuestPanelReward_exp, "");
	QuestPanelRewardLabel_exp.AddClass("QuestPanelReward_text");
	QuestPanelRewardLabel_exp.text = "+" + data.exp
	var QuestPanelName = $.CreatePanel("Label", QuestPanelText, "");
	QuestPanelName.AddClass("QuestPanelName");
	QuestPanelName.html = true;
	QuestPanelName.text = $.Localize("#"+data.name)  + $.Localize("#QuestGoal") + "<b><font color='#53ea48'>" + String(data.goal) + "</font></b>"
	if (!QUEST_BLUR)
	{
		QuestPanel.style.blur = "gaussian( 50 )"
		var QuestComingSoon = $.CreatePanel("Label", questpanel_main, "");
		QuestComingSoon.AddClass("QuestComingSoon");
		QuestComingSoon.text = $.Localize("#soon_ingame")
	}
}

function CreateSoundInGeneralInformation(panel, level, sound, hero_name)
{
	var SoundSelect = $.CreatePanel("Panel", panel, "");
	SoundSelect.AddClass("SoundSelect");
	var SoundLocked = $.CreatePanel("Panel", SoundSelect, "");
	SoundLocked.AddClass("SoundLocked");
	SoundLocked.style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + (level) + '_png.vtex")'
	SoundLocked.style.backgroundSize = "100%"
	SoundLocked.style.width = "25px"
	SoundLocked.style.height = "25px"
	var SoundIcon = $.CreatePanel("Panel", SoundSelect, "");
	SoundIcon.AddClass("SoundIcon");
	SoundIcon.SetPanelEvent("onactivate", function() 
	{	
		Game.EmitSound(sound[2])
	});
	var SoundHeroIcon = $.CreatePanel("Panel", SoundSelect, "");
	SoundHeroIcon.AddClass("SoundHeroIcon");
	SoundHeroIcon.style.backgroundImage = "url('file://{images}/heroes/icons/" + String(hero_name) + ".png')"
	SoundHeroIcon.style.backgroundSize = "100%"
	var SoundName = $.CreatePanel("Label", SoundSelect, "");
	SoundName.AddClass("SoundName");
	SoundName.text = $.Localize("#"+sound[2])
}