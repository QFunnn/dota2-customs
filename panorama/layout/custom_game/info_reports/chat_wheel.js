--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function InitSounds() {
    // Инициализация кнопок
    $("#ButtonLabelDefault").text = `${$.Localize("#chat_wheel_general")}${GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL)}`;
    $("#ButtonLabelHero").text = `${$.Localize("#chat_wheel_hero")}${GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_CHAT_WHEEL)}`;
    
    // Обработчики всплывающих подсказок
    const settingsButton = $("#SoundWheelSettingsButton");
    settingsButton.SetPanelEvent('onmouseover', () => $.DispatchEvent('DOTAShowTextTooltip', settingsButton, "#chatwheel_settings_info"));
    settingsButton.SetPanelEvent('onmouseout', () => $.DispatchEvent('DOTAHideTextTooltip', settingsButton));

    // Получение панелей звуков
    const soundPanels = {
        rus: $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList1"),
        eng: $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList2"),
        other: $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList3")
    };

    // Получение и обработка звуков
    const soundsTable = CustomNetTables.GetTableValue("custom_sounds", "sounds") || {};
    
    // Функция для обработки звуков категории
    const processSounds = (category) => {
        if (!soundsTable[category]) return [];
        
        return Object.values(soundsTable[category])
            .filter(Boolean)
            .map(sound => [
                sound[1], // ID
                sound[2], // Название
                sound[3], // Порядок сортировки
                sound[4] || 0, // Доп. параметр 1
                sound[5] || 0  // Доп. параметр 2
            ])
            .sort((a, b) => Number(a[2]) - Number(b[2])); // Сохраняем вашу логику сортировки
    };

    const sounds = {
        rus: processSounds("general_ru"),
        eng: processSounds("general_eng"),
        other: processSounds("general_other")
    };

    // Функция для заполнения панели звуками
    const populateSoundPanel = (panel, soundsList) => {
        if (!panel) return;
        panel.RemoveAndDeleteChildren();
        soundsList.filter(sound => !HasItemInventory(sound[0]) && sound[3] !== 0).forEach(sound => CreateSoundInWheel(panel, sound, true));
        soundsList.filter(sound => HasItemInventory(sound[0])).forEach(sound => CreateSoundInWheel(panel, sound));
        soundsList.filter(sound => !HasItemInventory(sound[0]) && sound[3] !== 1).forEach(sound => CreateSoundInWheel(panel, sound));
    };

    // Заполняем все панели
    Object.keys(soundPanels).forEach(category => {
        populateSoundPanel(soundPanels[category], sounds[category]);
    });

    InitChatWheelData();
}

function CreateSoundInWheel(panel, sound)
{

	var SoundSelect = $.CreatePanel("Panel", panel, "");
	SoundSelect.AddClass("SoundSelect");
	SoundSelect.sound_name = sound[0]

	var SoundLocked = $.CreatePanel("Panel", SoundSelect, "");
	SoundLocked.AddClass("SoundLocked");
	SoundLocked.style.opacity = "0"

	var SoundIcon = $.CreatePanel("Panel", SoundSelect, "");
	SoundIcon.AddClass("SoundIcon");
	SoundIcon.SetPanelEvent("onactivate", function() 
	{
		Game.EmitSound(sound[1])
	});

	var SoundName = $.CreatePanel("Label", SoundSelect, "");
	SoundName.AddClass("SoundName");
    SoundName.html = true

    if (!HasItemInventory(sound[0]) && sound[3] != 0)
	{
        SoundName.text = "<b><font color='#ff0000'>New</font></b> " + $.Localize("#"+sound[1])
    } else
    {
        SoundName.text = $.Localize("#"+sound[1])
    }

	var player_data_local = player_table_shop
	// Здесь проверять на купленность, чтоб не добавлять стоимость если предмет уже есть
	if (!HasItemInventory(sound[0]))
	{
        SoundLocked.style.opacity = "1"
        if (sound[4] != 0)
        {
            SoundSelect.style.visibility = "collapse"
            return
        }
		SoundSelect.SetHasClass("buy_chat_wheel", true)
		var shardcostpanel = $.CreatePanel("Panel", SoundSelect, "");
		shardcostpanel.AddClass("shardcostpanel");
		var shardcost_icon = $.CreatePanel("Panel", SoundSelect, "");
		shardcost_icon.AddClass("shardcost_icon");
		var shard_cost_label = $.CreatePanel("Label", SoundSelect, "");
		shard_cost_label.AddClass("shard_cost_label");
		shard_cost_label.text = sound[2]
		let point = 150
		if (player_data_local && player_data_local["points"] >= sound[2])
		{
			SoundSelect.SetPanelEvent("onactivate", function() 
			{ 
				CreateBuyWindow(sound[0], sound[2], sound[1], 1)
			})
		} 
        else 
        {
			shard_cost_label.style.color = "red"
			SoundSelect.SetHasClass("buy_chat_wheel", false)
		}
	}
}

function SetActiveChatBlock(id)
{
	let findblock = Number(id) - 1
	if ($("#ChatWheelButton"+findblock).BHasClass("chat_whell_block_selected"))
	{
		CloseActiveChatBlock()
		return
	}
	let sounds_panel_rus = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList1")
	let sounds_panel_eng = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList2")
	let sounds_panel_other = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList3")
	for (let i = 0; i <= 7; i++) 
    {
        $("#ChatWheelButton"+i).SetHasClass("chat_whell_block_selected", false)
    }
	$("#ChatWheelButton"+findblock).SetHasClass("chat_whell_block_selected", true)
	if (chat_select_active == false )
	{ 
        for (let child of sounds_panel_rus.Children())
        {
            SetEventChatWheel(child, child.sound_name, id, true)
        }
        for (let child of sounds_panel_eng.Children())
        {
            SetEventChatWheel(child, child.sound_name, id, true)
        }
        for (let child of sounds_panel_other.Children())
        {
            SetEventChatWheel(child, child.sound_name, id, true)
        }
		chat_select_active = true
	} 
    else 
    {
        for (let child of sounds_panel_rus.Children())
        {
            SetEventChatWheel(child, child.sound_name, 0, false)
        }
        for (let child of sounds_panel_eng.Children())
        {
            SetEventChatWheel(child, child.sound_name, id, true)
        }
        for (let child of sounds_panel_other.Children())
        {
            SetEventChatWheel(child, child.sound_name, id, true)
        }
		chat_select_active = false
	}
}

function CloseActiveChatBlock()
{
	let sounds_panel_rus = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList1")
	let sounds_panel_eng = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList2")
	let sounds_panel_other = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList3")

    for (let i = 0; i <= 7; i++) 
    {
        $("#ChatWheelButton"+i).SetHasClass("chat_whell_block_selected", false)
    }
    for (let child of sounds_panel_rus.Children())
    {
        SetEventChatWheel(child, child.sound_name, 0, false)
    }
    for (let child of sounds_panel_eng.Children())
    {
        SetEventChatWheel(child, child.sound_name, 0, false)
    }
    for (let child of sounds_panel_other.Children())
    {
        SetEventChatWheel(child, child.sound_name, 0, false)
    }
	chat_select_active = false
}

function SetEventChatWheel(panel, sound_name, id, active)
{
	let sounds_panel_rus = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList1")
	let sounds_panel_eng = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList2")
	let sounds_panel_other = $.GetContextPanel().FindChildTraverse("ChatWheelSoundsList3")
	if (active == false)
	{
		if (HasItemInventory(sound_name)) {
			panel.SetPanelEvent("onactivate", function() {})
			panel.SetHasClass("active_chat_wheel", false)
			sounds_panel_rus.SetHasClass("active_chat_wheel_all_block", false)
			sounds_panel_eng.SetHasClass("active_chat_wheel_all_block", false)
			sounds_panel_other.SetHasClass("active_chat_wheel_all_block", false)
		}
		return
	}
	if (!HasItemInventory(sound_name)) 
    {
		return
	}
	panel.SetHasClass("active_chat_wheel", true)
	sounds_panel_rus.SetHasClass("active_chat_wheel_all_block", true)
	sounds_panel_eng.SetHasClass("active_chat_wheel_all_block", true)
	sounds_panel_other.SetHasClass("active_chat_wheel_all_block", true)
	panel.SetPanelEvent("onactivate", function() 
    { 
		GameEvents.SendCustomGameEventToServer_custom( "select_chatwheel_player", {id : id, sound_name : sound_name } );
	})
}

function InitChatWheelData()
{
    const playerTable = PLAYER_CHATWHEEL_TABLE;
    const soundsTable = ALL_TABLE_CUSTOM_SOUNDS;
    if (!playerTable) return;
    for (let p = 1; p <= 8; p++) 
    {
        const soundId = String(playerTable[p]);
        let soundName = "null";
        const categories = ["general_ru", "general_eng", "general_other"];
        for (const category of categories) 
        {
            if (!soundsTable[category]) continue;
            const soundEntry = Object.values(soundsTable[category]).find(sound => String(sound[1]) === soundId);
            
            if (soundEntry) 
            {
                soundName = String(soundEntry[2]);
                break;
            }
        }
        $(`#chat_wheel_dota_${p}`).text = $.Localize(`#${soundName}`);
    }
}

function SwapCategorySounds(button, panel)
{
    let ButtonsSwapSounds = $.GetContextPanel().FindChildTraverse("ButtonsSwapSounds")
    for (let child of ButtonsSwapSounds.Children())
    {
        child.SetHasClass("selected", false)
    }
	Game.EmitSound("UI.Click")
	$("#sound_category_ru").style.visibility = "collapse"
	$("#sound_category_eng").style.visibility = "collapse"
	$("#sound_category_other").style.visibility = "collapse"
	$.GetContextPanel().FindChildTraverse(button).SetHasClass("selected", true)
	$.GetContextPanel().FindChildTraverse(panel).style.visibility = "visible"
}