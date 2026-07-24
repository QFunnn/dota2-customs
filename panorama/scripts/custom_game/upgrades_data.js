--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


Game.talents_values = {}
Game.new_talent_system = {}
Game.spells_by_number = {}
Game.achivment_table = {}
Game.pickrate_talents = {}
Game.local_chosen_build = -1
Game.CustomTooltipOpened = false
Game.Subscribed = false


CustomNetTables.SubscribeNetTableListener( "sub_data", update_hero_image );
CustomNetTables.SubscribeNetTableListener( "local_items", update_hero_image_local );
CustomNetTables.SubscribeNetTableListener( "custom_pick", update_custom_pick );
GameEvents.Subscribe("reconnect_hero_image", reconnect_hero_image)

var custom_pick_table

function update_custom_pick(table, key, data)
{
	if (table != "custom_pick") return
	if (key != "game_mode") return

	custom_pick_table = data
}

Game.talents_values = []

GameEvents.OnLoaded(() => {
	const hero_list = CustomNetTables.GetTableValue("custom_pick", "hero_list")
	custom_pick_table = CustomNetTables.GetTableValue("custom_pick", "game_mode")

	request_talent_values()
  GameEvents.Subscribe_custom('SendTalents', SendTalents)
  GameEvents.Subscribe_custom('SendNewTalentSystem', SendNewTalentSystem)
  GameEvents.Subscribe_custom('SendAchivments', SendAchivments)
  GameEvents.Subscribe_custom('SendPickRates', SendPickRates)
  GameEvents.Subscribe_custom('SendPickRates', SendPickRates)
  GameEvents.Subscribe_custom('SendSubscribed', SendSubscribed)
  GameEvents.Subscribe_custom('select_unit_custom', select_unit_custom)
  GameEvents.Subscribe_custom('send_arcana_icons', send_arcana_icons)


  GameEvents.SendCustomGameEventToServer_custom("RequestAchivments", {})
  GameEvents.SendCustomGameEventToServer_custom("RequestPickRates", {})
  GameEvents.SendCustomGameEventToServer_custom("RequestSubscribed", {})
  GameEvents.SendCustomGameEventToServer_custom("RequestArcanaIcons", {})
})

var talents_recieved = false
var pickrate_recieved = false

var images_keys =
{

}

function send_arcana_icons(data)
{
	for (let name in data)
	{
		if (name != "n")
		{
			images_keys[name] = data[name]
		}
	}
}

function request_talent_values()
{
	$.Msg('RequestTalents ',talents_recieved)

    GameEvents.SendCustomGameEventToServer_custom("RequestTalents", {})

    if (talents_recieved == true)
    	return

	$.Schedule(1, request_talent_values)
}

function SendAchivments(data)
{
	for (key in data)
	{
		if (key != "n")
			Game.achivment_table[key] = data[key]
	}
}


function SendSubscribed(data)
{
	Game.Subscribed = false

	if (data.sub && (data.sub == 1 || data.sub == true))
		Game.Subscribed = true
}



function SendPickRates(data)
{
	if (pickrate_recieved == true)
		return

	for (let name in data)
	{
		if (name != "n")
		{
			Game.pickrate_talents[name] = {}
			let data_table = data[name]["talents"]

			for (let legendary_name in data_table)
			{
				let legendary_data = data_table[legendary_name]
				Game.pickrate_talents[name][legendary_name] = {}
				let second_legendary = []
				let second_legendary_sum = 0

				for (let id in legendary_data)
				{
					let id_data = legendary_data[id]
					Game.pickrate_talents[name][legendary_name][id_data.name] = id_data.pickRate

					let talent_data = Game.talents_values[name][id_data.name]

					if (talent_data && talent_data["skill_icon"] != legendary_name && talent_data["rarity"] == "orange")
					{
						second_legendary.push(id_data.name)
						if (Game.pickrate_talents[name][legendary_name][id_data.name])
						{
							second_legendary_sum = second_legendary_sum + Game.pickrate_talents[name][legendary_name][id_data.name]
						}
					}
				}
				for (legendary_id in second_legendary)
				{
					let second_legendary_name = second_legendary[legendary_id]

					if (Game.pickrate_talents[name][legendary_name][second_legendary_name])
						Game.pickrate_talents[name][legendary_name][second_legendary_name] = Game.pickrate_talents[name][legendary_name][second_legendary_name]/second_legendary_sum
				}
			}
		}
	}
}




function SendTalents(data)
{
	if (talents_recieved == true)
		return


	talents_recieved = true
	for (let name in data)
	{
		if (name != "n")
		{
			Game.talents_values[name] = data[name]
			for (let talent_name in data[name])
			{
				let talent_data = data[name][talent_name]
				let skill_number = talent_data["skill_number"]
				let skill_name = talent_data["skill_name"]
				let skill_icon = talent_data["skill_icon"]


				if (skill_number && skill_name)
				{
					if (Game.spells_by_number[name] == undefined)
						Game.spells_by_number[name] = {}

					if (Game.spells_by_number[name][skill_number] == undefined)
					{
						Game.spells_by_number[name][skill_number] = {}
						Game.spells_by_number[name][skill_number]["name"] = skill_name
						Game.spells_by_number[name][skill_number]["skill_icon"] = skill_icon
					}
				}
			}
		}
	}

	$.Schedule(1, function()
	{
	let new_table = Game.spells_by_number

	if (true) return

	let only_legendary = false
	let for_patchnote = "npc_dota_hero_ogre_magi"
	let rarity = ["blue", "purple", "orange"]
	let local = ["Редкие таланты:", "Эпические таланты:", "Легендарный талант:"]

	if (only_legendary)
	{
		rarity = ["orange"]
		local = ["Легендарный талант:"]
	}
	for (let name in new_table)
	{
		if (name != "n" && Game.new_talent_system[name] && (for_patchnote == false || name == for_patchnote))
		{
			$.Msg("-------")
			$.Msg($.Localize("#" + name) + ":")

			new_table[name]["0"] = {}
			new_table[name]["0"]["name"] = "hero_talents"

			for (let skill_number in new_table[name])
			{
				if (skill_number != 0 || only_legendary == false)
				{
					let skill_data = new_table[name][skill_number]
					let skill_name = skill_data["name"]

					if (!for_patchnote)
					{
						if (skill_number != 0)
						{
							$.Msg("Таланты для ", $.Localize("#DOTA_Tooltip_ability_" + skill_name))
						}else
						{
							$.Msg("Таланты из ветки Героя")
						}
					}
					let hero_data = Game.talents_values[name]

					for (rarity_nubmer in rarity)
					{
						let rarity_name = rarity[rarity_nubmer]

						if (skill_number != 0 || rarity_name != "orange")
						{
							if (!for_patchnote)
							{
								$.Msg()
								$.Msg(local[rarity_nubmer])
							}
							for (var i = 1; i <= 7; i++) 
							{
								for (let talent_name in hero_data)
								{
									let talent_data = hero_data[talent_name]
									let talent_number = talent_data["skill_number"]
									let talent_rarity = talent_data["rarity"]

									if (talent_number == skill_number && talent_rarity == rarity_name &&  (talent_name.at(-1) == String(i)))
									{
										if (!for_patchnote)
										{
											$.Msg(i + ") " + Game.ShowTalentValues("#upgrade_disc_" + talent_name, talent_name, 1, false, talent_data["rarity"] == "orange", false, true))
										}else
										{
											$.Msg()
											$.Msg("<" + talent_name + ">")

											let replace = ". "
											if (rarity_name == "orange")
											{
												$.Msg($.Localize("#talent_new_info"))
												$.Msg()
												replace = "\n\n"
											}
											let result = Game.ShowTalentValues("#upgrade_disc_" + talent_name, talent_name, 1, true, talent_data["rarity"] == "orange", false, true)
											result = result.replaceAll("<br><br>", replace);
											$.Msg(result)

											let result_info = $.Localize("#upgrade_disc_" + talent_name + "_info")
											let result_cd = talent_data["talent_cd"]

											if ((result_info != "#upgrade_disc_" + talent_name + "_info") || (result_cd))
											{
												$.Msg()
												let result = "<em>"
												if (result_info != "#upgrade_disc_" + talent_name + "_info")
												{	
													result_info = Game.ShowTalentValues(result_info, talent_name, 1, true, talent_data["rarity"] == "orange", false, true)
													result_info = result_info.replaceAll("<br><br>", "\n");
													result = result + result_info
													if (result_cd)
														result = result + "\n"
												}
												if (result_cd)
												{
													result = result + $.Localize("#talent_cd_info") + " " + result_cd
												}

												result = result + "</em>"
												$.Msg(result)
											}
										}
									}
								}
							}
						}

					}
				}
				$.Msg()
			}
		}
	}
		
	})
}


function SendNewTalentSystem(data)
{

	for (let name in data)
	{
		if (name != "n")
			Game.new_talent_system[name] = data[name]
	}
}


function select_unit_custom(data)
{
	GameUI.SelectUnit( data.index, false)
}


Game.GetGameMode = () =>
{
	if (!custom_pick_table || !custom_pick_table.team_size) return
	return custom_pick_table.team_size
}

Game.GetWinPlace = () =>
{
	if (!custom_pick_table || !custom_pick_table.win_place) return
	return custom_pick_table.win_place
}


Game.GetMaxTeams = () =>
{
	if (!custom_pick_table || !custom_pick_table.max_teams) return
	return custom_pick_table.max_teams
}

Game.GetMaxLevel = (data) =>
{
	let rarity = data["rarity"]
	let max_level = 0

    if (rarity == "blue")
    {
        max_level = 3
    }else if (rarity == "purple" || rarity == "orange")
    {
        max_level = 1
    }

    if (data["main_epic"] == 1)
        max_level = 2

    return max_level
}

Game.GetLocalLegendary = () =>
{	
	let IDs = Game.GetAllPlayerIDs()
	let hero = Entities.GetUnitName(Players.GetLocalPlayerPortraitUnit())
	let result = []
	result[0] = 0
	result[1] = 0
	result[2] = 0

	for (var i = 0; i < Object.keys(IDs).length; i++) 
	{
		var table = CustomNetTables.GetTableValue("networth_players", IDs[i].toString());
		if (table && table.hero_name && table.hero_name == hero)
		{
			if (table.legendary)
			{
				result[0] = table.legendary
			}
			if (table.legendary_talent)
			{
				result[1] = table.legendary_talent
			}
			if (table.legendary_skill_name)
			{
				result[2] = table.legendary_skill_name
			}
			break
		}
	}
	return result
}



Game.HasTalent = (hero_name, talent_name) =>
{

	let talents = CustomNetTables.GetTableValue("upgrades_player", hero_name)

	if ((talents == undefined) || (talents == null))
	{
		return
	}

	let upgrades = talents.upgrades


	if ((upgrades == undefined) || (upgrades == null) || (upgrades[talent_name] == null) || (upgrades[talent_name] == undefined))
	{
		return
	}


	if ((upgrades[talent_name]) > 0)
	{
		return true
	}else 
	{
		return false
	}
	
}


var hero_images = {}
var hero_images_local = {}

function update_hero_image_local(table, key, data)
{
	if (data)
	{
        let set_new_image = null
		for (let item_id of Object.values(data.item_list)) 
		{
            if (images_keys[String(item_id)])
            {
                set_new_image = images_keys[String(item_id)]
            }
		}
        if (set_new_image)
        {
            hero_images_local[key] = set_new_image
        }
	}
}

function update_hero_image(table, key, data)
{
	if (table != "sub_data") return
	if (key == "heroes_vote" || key == -1 || key == "-1") return

	if (!hero_images[key])
		hero_images[key] = {}

	if (data && data.player_items_onequip)
	{
		for (const hero_name of Object.keys(data.player_items_onequip)) 
		{
			let hero_items = data.player_items_onequip[hero_name]
		    hero_images[key][hero_name] = ""
			if (hero_items)
			{
		        for (let item_id of Object.values(hero_items)) 
		        {
		        	if (images_keys[item_id])
		        	{
		        		hero_images[key][hero_name] = images_keys[item_id]
		        	}
		        }
		    }
		}
	}
}

function reconnect_hero_image()
{
    if (images_keys && Object.values(images_keys).length <= 0)
    {
        $.Schedule(1, reconnect_hero_image)
        return
    }
	if (Game.GetLocalPlayerID() == -1 || Game.GetLocalPlayerID() == "-1")
	{
		$.Schedule(1, reconnect_hero_image)
	}
    update_hero_image("sub_data", Game.GetLocalPlayerID(), CustomNetTables.GetTableValue("sub_data", Game.GetLocalPlayerID()))
    for (let i = 0; i < 10; i++)
    {
        if (Players.IsValidPlayerID(i))
        {
            update_hero_image("sub_data", i, CustomNetTables.GetTableValue("sub_data", i))
        }
    }
    let local_items = CustomNetTables.GetAllTableValues("local_items")
    for (let local_item_data of local_items)
    {
        let key = local_item_data["key"]
        let data = local_item_data["value"]
        update_hero_image_local("local_items", key, data)
    }
}

Game.GetHeroImage = (id, hero_name) => 
{
	let name = undefined
	let player_id = Number(id)

	if (hero_name == undefined || hero_name == " " || hero_name == "")
	{
		let info = Game.GetPlayerInfo(player_id)
		if (info && info.player_selected_hero !== "")
		{
			name = info.player_selected_hero
		}
	}
    else 
	{
		name = hero_name
	}

	if (hero_images[player_id] && hero_images[player_id][hero_name] && hero_images[player_id][hero_name] != "")
	{
		name = hero_images[player_id][hero_name]
	}

    if (hero_name && hero_images_local[hero_name] && hero_images_local[hero_name] != "")
    {
        name = hero_images_local[hero_name]
    }
    
	return name
}

Game.GetTalentValue = (name, value_name) => 
{
	for (const hero_name of Object.keys(Game.talents_values)) 
	{	
		if (Game.talents_values[hero_name] !== undefined)
		{
			for (const talent_data of Object.keys(Game.talents_values[hero_name]))
			{

				if ((talent_data == name) && (Game.talents_values[hero_name][talent_data][value_name] !== undefined))
				{

					return Game.talents_values[hero_name][talent_data][value_name]
				}
			} 
		}
	}
	return undefined
}




Game.GetValuesArray = (text) => {
    const keys = new Set();
    // Ищем ключи с любым количеством символов % и ^ после них
    const regex = /\*!?[+-]?(\w+)[%^]*\*/g;
    
    let match;
    while ((match = regex.exec(text)) !== null) {
        keys.add(match[1]); // match[1] содержит чистый ключ
    }
    
    return Array.from(keys);
};

Game.roundPlus = (x, n) =>
{ //x - число, n - количество знаков


	if (isNaN(x) || isNaN(n)) return false;

	var m = Math.pow(10, n);

	return Math.round(x * m) / m;

}


Game.ShowTalentValues = (text, name, level, all_levels, legendary, no_color, no_tags) => 
{
	let talent_text = $.Localize(text)
	let hero = Entities.GetUnitName(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()))

	if (hero != undefined)
	{
		if (Game.GetTalentValue(name, "alt_talent") != undefined)
		{	
			let alt_talent = Game.GetTalentValue(name, "alt_talent")

			let alt_table = {1: alt_talent}
			if (typeof alt_talent == "object")
				alt_table = alt_talent


    		for (var i in alt_table)
    		{
				if (Game.HasTalent(hero, alt_table[i]))
				{	

					let key = text + "_alt"
					let new_text = $.Localize(key)
					if (key != new_text)
					{
						talent_text = new_text
						break
					}
				}
			}
		}
		if (Game.GetTalentValue(name, "alt_talent2") != undefined)
		{
			if (Game.HasTalent(hero, Game.GetTalentValue(name, "alt_talent2")))
			{
				let key = text + "_alt2"
				let new_text = $.Localize(key)
				if (key != new_text)
					talent_text = new_text
			}
		}
	}

    let values_array = Game.GetValuesArray(talent_text)
    let values_map = {}
   
    for (const value of values_array) 
    {	
    	values_map[value] = Game.GetTalentValue(name, value)
    }

    talent_text = replaceValues(talent_text, values_map, level, all_levels, legendary, no_color, no_tags);  

    //$.Msg(talent_text)
    //$.Msg()
    return talent_text
}


function replaceValues(str, valuesMap, level, showAll, legendary, no_color, no_tags) 
{
  let color = "#53ea48"; // Стандартный зелёный
  if (legendary) color = "#fb9531"; // Оранжевый для легендарных
  if (no_color) color = "#eee"; // Серый, если no_color
  const darkColor = "#297016"; // Цвет для неактивных уровней

  // Преобразуем level в число один раз в начале
  const currentLevel = Number(level);

  return str.replace(/\*(!?([+-])?)(\w+)(%?)(\^?)\*/g, (match, prefix, sign, key, percent, precisionMark) => {
    if (!valuesMap.hasOwnProperty(key)) return match;

    // Функция для форматирования значения с цветом
    const formatWithColor = (value, useMainColor) => {
      const decimalPlaces = precisionMark === '^' ? 3 : 1;
      const rawValue = String(value).replace(/^[+-]/, '');
      const roundedValue = Game.roundPlus(parseFloat(rawValue), decimalPlaces);
      const formatted = (sign || '') + roundedValue + percent;
      const usedColor = no_color ? color : (useMainColor ? color : darkColor);

      let result = no_tags ? formatted : `<b><font color='${usedColor}'>${formatted}</font></b>`
      return result;
    };

    // Обычные значения (не объект с уровнями)
    if (typeof valuesMap[key] !== 'object' || Array.isArray(valuesMap[key])) {
      if (no_color) {
        return formatWithColor(valuesMap[key], true);
      }
      return prefix.includes('!') 
        ? formatWithColor(valuesMap[key], true)
        : (sign || '') + Game.roundPlus(parseFloat(String(valuesMap[key]).replace(/^[+-]/, '')), precisionMark === '^' ? 3 : 1) + percent;
    }

    // Обработка значений с уровнями (объект)
    const levelValues = valuesMap[key];
    const levels = Object.keys(levelValues).map(Number).sort((a,b) => a-b);
    
    if (showAll) {
      // Показываем все уровни
      return levels.map(lvl => {
        const isCurrentLevel = (lvl === currentLevel); // Используем Number(level)
        return formatWithColor(levelValues[lvl], isCurrentLevel);
      }).join('/');
    } else {
      // Показываем только текущий уровень
      const displayLevel = currentLevel > 0 ? currentLevel : 1;
      return formatWithColor(levelValues[displayLevel], currentLevel > 0);
    }
  });
}


Game.CreateScoreBind = (score_table) => 
{
   const name_bind = "OpenDamageStats" + Math.floor(Math.random() * 99999999);
   var keybind = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_SCOREBOARD_TOGGLE);
   Game.CreateCustomKeyBind(keybind, "+" + name_bind);

   Game.AddCommand("+" + name_bind, () => {Game.DamageToggle(true); score_table.OpenScores(true)}, "", 0);
   Game.AddCommand("-" + name_bind, () => {Game.DamageToggle(false); score_table.OpenScores(false)}, "", 0);
}

Game.AllowShop = (id) =>
{
  let lang = $.Localize("#lang")
  let data = CustomNetTables.GetTableValue("server_data", String(id))

  if ((!data?.total_games || data.total_games < 5) && lang !== "rus") 
  {
    return false
  }
  return true
}