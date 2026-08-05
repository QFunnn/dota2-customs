--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


var spin = [0,0,0],
	slotsTypes = {},
	slots = [];

can_play = true
cas_openned = false	
	
slotMachine = $("#slotMachine")
slotMachine.visible = false	

var don = 0
var rp = 0

const DotaHUD = GameUI.CustomUIConfig().DotaHUD;
DotaHUD.windowControllers["cas"] = {
    is_open: false,
    open: function(){
        slotMachine.visible = true	
        GameEvents.SendCustomGameEventToServer("cas_init", {})
    },
    close: function(){
        slotMachine.visible = false	
    }
}
DotaHUD.ListenToMouseEvent(
    DotaHUD.GetCloseWindowOnOutsideClick($("#slotMachine"), "cas")
);

function openCasinoButton()
{
	if (can_play){
		if(DotaHUD.IsWindowOpen("cas")){
            DotaHUD.WindowClose("cas");
        }else{
            DotaHUD.WindowOpen("cas");
        }
	}
}

function cas_init(tab){
	don = tab.coins
	rp = tab.rp
	$('#DNMoneyLabel').text = don
	$('#MMMRPointsLabel').text = rp
}


for (i = 1; i < 4; i++) {
	var main = $('#wheel'+i)
	var wheelPanel = main.FindChildTraverse('RollItemsListMain');
	var item = $.CreatePanel("DOTAItemImage", wheelPanel, 'i');
	item.itemname = 'item_move_aura';
	item.AddClass("item_slot")
}	

spinSound = null
wheels_state = [true, true, true];

function press_button(type) {
	if (can_play){
		can_play = false
		GameEvents.SendCustomGameEventToServer("try_start_cas", {type:type})
	}
}

function shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
}



function start_spin(tab) {
    $('#DNMoneyLabel').text = tab.coins;
    $('#MMMRPointsLabel').text = tab.rp;
	
	spinSound = Game.EmitSound("ui.treasure.spin_music");
	 
    slotsTypes = tab.results;

    $.Msg("-----------------------")
    $.Msg(slotsTypes)


    slots_names = [
        'item_armor_aura', 'item_base_damage_aura', 'item_expiriance_aura',
        'item_move_aura', 'item_attack_speed_aura', 'item_hp_aura', 
        'item_cd_aura', 'item_lifesteal_aura', 'item_spell_aura', 
        'item_gold_aura', 'item_ticket2', 'item_krest', 'bless', 'soul'
    ];  

    for (let i = 0; i < 3; i++) {
        (function(wheelIndex) {
            var main = $('#wheel' + (wheelIndex + 1)); 
            var wheelPanel = main.FindChildTraverse('RollItemsListMain');

            wheelPanel.RemoveAndDeleteChildren();
            let firstItemName = slotsTypes[wheelIndex+ 1];
            createItem(firstItemName, wheelPanel);
            
			const shuffledSlotsNames = [...slots_names];
            shuffleArray(shuffledSlotsNames);

            for (let j = 0; j < shuffledSlotsNames.length; j++) {
                if (shuffledSlotsNames[j] === firstItemName) continue;
                createItem(shuffledSlotsNames[j], wheelPanel);
            }

            wheelPanel.style.position = "0px -1144px 0px";
            $.Schedule(0.3 * (wheelIndex + 1), function () {
                StartAnimate(-1144, 0, 1000, wheelPanel, wheelIndex, tab.matches, tab.reward);
            });
        })(i);
    }
}


function createItem(itemName, parentPanel) {
    let item;
    if (itemName === 'bless' || itemName === 'soul') {
        item = $.CreatePanel("Panel", parentPanel, itemName);
        item.style.backgroundImage = "url('file://{resources}/images/sets/" + itemName + ".png')";
    } else {
        item = $.CreatePanel("DOTAItemImage", parentPanel, itemName);
        item.itemname = itemName;
    }
    item.AddClass("item_slot");
}

function StartAnimate(current, drop_distance, speed, panel, index, matches, reward) {
    if (current >= drop_distance) {
        $.Schedule(0.1, function() {
            wheels_state[index] = false;
            if (wheels_state.every(val => val === false)) {
				endSpin(matches, reward)
            }
        });
        return;
    }

    current += speed * Game.GetGameFrameTime();
	
    if (current > 0) {
        current = 0;
    }

    if (current <= 0.37 * drop_distance) {
        speed += speed * Game.GetGameFrameTime();
    }

    speed = Math.max(100, speed);

    panel.style.position = "0px " + current + "px 0px";
    
    $.Schedule(Game.GetGameFrameTime(), function() {
        StartAnimate(current, drop_distance, speed, panel, index, matches, reward);
    });
}

function endSpin(matches, reward){
	$.Msg("end", matches)
	
	if (reward > 0){
		if (matches == 1){
			Game.EmitSound("coins_wager.x1")
		}else if (matches == 2){
			Game.EmitSound("coins_wager.x1")
		}else{
			Game.EmitSound("coins_wager.x3")
		}
	}
	Game.StopSound(spinSound)
	wheels_state = [true, true, true];
	can_play = true
}


function TipsOver(message, pos)
{
    if ($("#"+pos) != undefined)
    {
       $.DispatchEvent( "DOTAShowTextTooltip", $("#"+pos), $.Localize("#"+message));
    }
}

function TipsOut()
{
    $.DispatchEvent( "DOTAHideTitleTextTooltip");
    $.DispatchEvent( "DOTAHideTextTooltip");
}

(function(){
	GameEvents.Subscribe( "cas_init", cas_init)
	GameEvents.Subscribe( "start_spin", start_spin)
})();