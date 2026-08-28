--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


var position = {
    'd1': { x: 13, y: 13 },
    'd2': { x: 29, y: 6 },
    'd3': { x: 42, y: 8 },
    'd4': { x: 49, y: 18 },
    'd5': { x: 59, y: 19 },
    'd6': { x: 66, y: 10 },
    'd7': { x: 78, y: 17 },
    'd8': { x: 90, y: 26 },
    'd9': { x: 92, y: 42 },
    'd10': { x: 89, y: 58 },
    'd11': { x: 77, y: 49 },
    'd12': { x: 88, y: 73 },
    'd13': { x: 78, y: 82 },
    'd14': { x: 65, y: 84 },
    'd15': { x: 61, y: 56 },
    'd16': { x: 41, y: 43 },
    'd17': { x: 23, y: 26 },
    'd18': { x: 8, y: 49 },
    'd19': { x: 18, y: 56 },
    'd20': { x: 29, y: 65 },
};

var mainPanel = $.GetContextPanel().FindChildTraverse("Diff_container");

i = 0;

for (let key in position) {
    if (position.hasOwnProperty(key)) {
        i++;
        ((i) => {
            let panel = $.CreatePanel('Panel', mainPanel, key);
            panel.AddClass('all_d');

            let innerPanel = $.CreatePanel('Panel', panel, 'Diff_' + i);
            innerPanel.AddClass('dif_icon');
            innerPanel.AddClass('lock');

            // innerPanel.SetPanelEvent('onmouseover', function() {
                // TipsCustomOver(innerPanel, i);
            // });
            // innerPanel.SetPanelEvent('onmouseout', function() {
                // TipsOut();
            // });

            panel.style.marginLeft = position[key].x + '%';
            panel.style.marginTop = position[key].y + '%';
        })(i);
    }
}

function init_diff(data){
	$.Msg("init_diff raw data:", data);
	
	// Обрабатываем разные форматы данных
	var data_diff = null;
	if(Array.isArray(data) && data.length > 0){
		data_diff = data[0];
	} else if(typeof data === 'object' && data !== null){
		data_diff = data;
	}
	
	$.Msg("init_diff data_diff:", data_diff);
	
	// Извлекаем host_diff - может быть в разных форматах
	var host_diff = 0;
	if(data_diff){
		// Если есть прямое поле host_diff
		if(data_diff.host_diff !== undefined){
			host_diff = data_diff.host_diff;
		}
		// Если данные в формате {"1":20} или {"0":{...}}
		else if(data_diff["1"] !== undefined){
			// Если значение - это число, это host_diff
			if(typeof data_diff["1"] === 'number'){
				host_diff = data_diff["1"];
			}
			// Если значение - это объект, ищем host_diff внутри
			else if(data_diff["1"].host_diff !== undefined){
				host_diff = data_diff["1"].host_diff;
			}
		}
		// Если данные в формате {"0":{...}}
		else if(data_diff["0"] !== undefined && typeof data_diff["0"] === 'object'){
			if(data_diff["0"].host_diff !== undefined){
				host_diff = data_diff["0"].host_diff;
			}
		}
	}
	
	var display_players = {};
	if(data_diff){
		if(data_diff.display_players){
			display_players = data_diff.display_players;
		}
		else if(data_diff["1"] && typeof data_diff["1"] === 'object' && data_diff["1"].display_players){
			display_players = data_diff["1"].display_players;
		}
		else if(data_diff["0"] && typeof data_diff["0"] === 'object' && data_diff["0"].display_players){
			display_players = data_diff["0"].display_players;
		}
	}
	
	$.Msg("init_diff host_diff:", host_diff, "display_players:", display_players);
	
	var hittestBlocker = $.GetContextPanel().GetParent().FindChild("SidebarAndBattleCupLayoutContainer");
	if(hittestBlocker){
		hittestBlocker.visible = false;
	}

    var num = 0;

    for (let key in position) {
        if (position.hasOwnProperty(key)) {
            num++;
            ((num) => {

                let innerPanel = $('#Diff_'+num);
				
				// Разблокируем сложности до host_diff включительно
                if (num <= host_diff) {
                    innerPanel.SetHasClass("lock", false);
					innerPanel.style.backgroundImage = "url('file://{resources}/images/custom_game/loading_screen/num_unlock.png')";
					
					innerPanel.SetPanelEvent('onmouseactivate', (function(index, id) {
						return function() {
							select_diff(index, id);
						};
					})(num, innerPanel.id));
				
                }

                innerPanel.SetPanelEvent('onmouseover', function() {
                    innerPanel.SetHasClass("hovered", true);
                    TipsCustomOver(innerPanel, num);
                });

                innerPanel.SetPanelEvent('onmouseout', function() {
                    innerPanel.SetHasClass("hovered", false);
                    TipsOut();
                });

               
            })(num);
        }
    }
	
	// Создаем список игроков под кнопками сложности
	if(display_players && Object.keys(display_players).length > 0){
		create_players_list(display_players);
	}
}

function create_players_list(display_players){
	$.Msg("create_players_list display_players:", display_players);
	
	// Удаляем все существующие списки игроков
	var mainPanel = $.GetContextPanel().FindChildTraverse("Diff_container");
	if(!mainPanel){
		$.Msg("Diff_container not found");
		return;
	}
	
	// Удаляем все старые контейнеры списков игроков
	for(var diff = 1; diff <= 20; diff++){
		var diffPanel = mainPanel.FindChildTraverse("d" + diff);
		if(diffPanel){
			var existingList = diffPanel.FindChildTraverse("PlayersListContainer_" + diff);
			if(existingList){
				existingList.DeleteAsync(0);
			}
		}
	}
	
	// display_players это объект с строковыми ключами ("0", "1", "2", ...)
	// Итерируемся по всем ключам объекта
	for(var diffKey in display_players){
		if(!display_players.hasOwnProperty(diffKey)){
			continue;
		}
		
		// Преобразуем строковый ключ в число
		var diff = parseInt(diffKey);
		if(isNaN(diff) || diff < 1 || diff > 20){
			continue;
		}
		
		// Получаем объект игроков для этой сложности
		var playersObj = display_players[diffKey];
		
		// Проверяем, есть ли игроки (объект не пустой)
		var hasPlayers = false;
		for(var key in playersObj){
			if(playersObj.hasOwnProperty(key)){
				hasPlayers = true;
				break;
			}
		}
		
		if(!hasPlayers){
			continue;
		}
		
		$.Msg("Creating players list for difficulty:", diff, "players:", playersObj);
		
		// Находим родительскую панель для этой сложности (d1, d2, и т.д.)
		var diffPanel = mainPanel.FindChildTraverse("d" + diff);
		
		if(!diffPanel){
			$.Msg("Panel not found for difficulty:", diff);
			continue;
		}
		
		// Создаем контейнер для списка игроков этой сложности
		var playersListContainer = $.CreatePanel("Panel", diffPanel, "PlayersListContainer_" + diff);
		playersListContainer.AddClass("players_list_container");
		
		// Позиционирование задается через CSS класс players_list_container
		// Контейнер будет центрирован горизонтально и выровнен по нижнему краю родителя (d17)
		
		// Создаем элементы для каждого игрока этой сложности
		// playersObj это объект, где ключи - индексы игроков, значения - объекты с sid
		var playerIndex = 0;
		for(var playerKey in playersObj){
			if(!playersObj.hasOwnProperty(playerKey)){
				continue;
			}
			
			var player = playersObj[playerKey];
			if(player && player.sid){
				var playerItem = $.CreatePanel("Panel", playersListContainer, "PlayerItem_" + diff + "_" + playerIndex);
				playerItem.AddClass("player_item");
				
				var avatarImage = $.CreatePanel("DOTAAvatarImage", playerItem, "PlayerAvatar_" + diff + "_" + playerIndex);
				avatarImage.AddClass("player_avatar");
				avatarImage.steamid = player.sid;
				
				// Применяем стили напрямую, так как DOTAAvatarImage может не применять CSS классы
				avatarImage.style.width = "30px";
				avatarImage.style.height = "30px";
				avatarImage.style.borderRadius = "50%";
				avatarImage.style.border = "1px solid #888888";
				
				$.Msg("Created player avatar for difficulty:", diff, "sid:", player.sid);
				playerIndex++;
			}
		}
	}
}

function TipsCustomOver(pos, num)
{
	if (typeof(pos) == 'object'){
		pos = pos.id;
	}
	
	// var stats = (50 + 30 * (num - 1)) + '%';
	// var armor = (50 + 20 * (num - 1)) + '%';
	// var resist = (50 + 10 * (num - 1)) + '%';
	// var cd = 100 - ((1.25 - num / 20) * 100)
	// var as = (num - 1) * 5
	
	var stats = (40 + 40 * (num - 1)) + '%';
	var armor = (40 + 30 * (num - 1)) + '%';
	var resist = (40 + 15 * (num - 1)) + '%';
	var cd = 100 - ((1.25 - num / 20) * 100)
	var as = (num - 1) * 5

	var additional = '';
	if(num >= 16){	
		additional = $.Localize('#diff_add') + '<br>';
	}
	
	$.DispatchEvent( "DOTAShowTextTooltip", $("#" + pos), 
		$.Localize('#diff') + ' ' + num + '<br>' +
		$.Localize('#diff_hp') + ' ' + stats + '<br>' +
		$.Localize('#diff_dmg') + ' ' + stats + '<br>' +
		$.Localize('#diff_armor') + ' ' + armor + '<br>' +
		$.Localize('#diff_resist') + ' ' + resist + '<br>' +
		$.Localize('#diff_cd') + ' ' + -1*cd.toFixed(0) + "%" + '<br>' +
		$.Localize('#diff_as') + ' ' + as + '<br>' + additional + '<br>'+
		$.Localize('#diff_stats'))
}

function TipsOver(pos, message)
{
	if (typeof(pos) == 'object'){
		pos = pos.id
	}
	$.DispatchEvent( "DOTAShowTextTooltip", $("#"+pos), $.Localize('#'+pos));
}

function TipsOut()
{
    $.DispatchEvent( "DOTAHideTitleTextTooltip");
    $.DispatchEvent( "DOTAHideTextTooltip");
}

function select_diff(index, id){
	if ( Players.GetLocalPlayer() == 0) {
		var parentPanel = $.GetContextPanel().FindChildTraverse("Diff_container");
		var difIcons = parentPanel.FindChildrenWithClassTraverse("dif_icon");
		for (var i = 0; i < difIcons.length; i++) {
			var difIcon = difIcons[i];
			// difIcon.ClearPanelEvent("onmouseactivate")
		}
		GameEvents.SendCustomGameEventToServer("choise_diff", {index, id})	
	}
}

function update_diff(t){
	panel = $("#"+t.id)

    var parentPanel = $.GetContextPanel().FindChildTraverse("Diff_container");
    var difIcons = parentPanel.FindChildrenWithClassTraverse("dif_icon");
    for (var i = 0; i < difIcons.length; i++) {
        difIcons[i].style.boxShadow = '0px 0px 0px transparent';
        const Target = difIcons[i].GetParent().FindChildTraverse("Target");
        if(Target){
            Target.DeleteAsync(0)
        }
    }
	panel.style.boxShadow = '0px 0px 20px green';
	var TabPanel = $.CreatePanel("Panel", panel.GetParent(), "Target");
}	


function back(t){
	c = $("#"+t).Children("images-back")
	c[1].visible = true;
	TipsOver($("#"+t), "sad")
}

function unback(t){
	c = $("#"+t).Children("images-back")
	c[1].visible = false;
	TipsOut()
}


(function(){
	GameEvents.Subscribe( "init_diff", init_diff)
	GameEvents.Subscribe( "update_diff", update_diff)
})();